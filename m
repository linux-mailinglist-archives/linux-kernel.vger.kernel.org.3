Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D65C567A58
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 00:50:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232949AbiGEWsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 18:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232877AbiGEWsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 18:48:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0316619C0C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 15:47:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 87185B81A1C
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 22:47:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36AB4C341C7;
        Tue,  5 Jul 2022 22:47:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1o8rKf-001yGR-0l;
        Tue, 05 Jul 2022 18:47:49 -0400
Message-ID: <20220705224453.120955146@goodmis.org>
User-Agent: quilt/0.66
Date:   Tue, 05 Jul 2022 18:44:53 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 00/13] tracing/events: Add __vstring and __assign_vstr helpers
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There's several places that open code the following logic:

  TP_STRUCT__entry(__dynamic_array(char, msg, MSG_MAX)),
  TP_fast_assign(vsnprintf(__get_str(msg), MSG_MAX, vaf->fmt, *vaf->va);)

To load a string created by variable array va_list.

The main issue with this approach is that "MSG_MAX" usage in the
__dynamic_array() portion. That actually just reserves the MSG_MAX in the
event, and even wastes space because there's dynamic meta data also saved
in the event to denote the offset and size of the dynamic array. It would
have been better to just use a static __array() field.

Instead, create __vstring() and __assign_vstr() that work like __string
and __assign_str() but instead of taking a destination string to copy,
take a format string and a va_list pointer and fill in the values.

It uses the helper:

 #define __trace_event_vstr_len(fmt, va)	\
 ({						\
	va_list __ap;				\
	int __ret;				\
						\
	va_copy(__ap, *(va));			\
	__ret = vsnprintf(NULL, 0, fmt, __ap);	\
	va_end(__ap);				\
						\
	min(__ret, TRACE_EVENT_STR_MAX);	\
 })

To figure out the length to store the string. It may be slightly slower as
it needs to run the vsnprintf() twice, but it now saves space on the ring
buffer, and more importantly, simplifies the code!


Steven Rostedt (Google) (13):
      tracing/events: Add __vstring() and __assign_vstr() helper macros
      tracing/IB/hfi1: Use the new __vstring() helper
      tracing/ath: Use the new __vstring() helper
      tracing/brcm: Use the new __vstring() helper
      tracing/iwlwifi: Use the new __vstring() helper
      usb: chipidea: tracing: Use the new __vstring() helper
      xhci: tracing: Use the new __vstring() helper
      USB: mtu3: tracing: Use the new __vstring() helper
      usb: musb: tracing: Use the new __vstring() helper
      scsi: iscsi: tracing: Use the new __vstring() helper
      scsi: qla2xxx: tracing: Use the new __vstring() helper
      batman-adv: tracing: Use the new __vstring() helper
      mac80211: tracing: Use the new __vstring() helper

----
 drivers/infiniband/hw/hfi1/trace_dbg.h                 |  8 ++------
 drivers/net/wireless/ath/ath10k/trace.h                | 14 ++++----------
 drivers/net/wireless/ath/ath11k/trace.h                |  7 ++-----
 drivers/net/wireless/ath/ath6kl/trace.h                | 14 ++++----------
 drivers/net/wireless/ath/trace.h                       |  7 ++-----
 drivers/net/wireless/ath/wil6210/trace.h               |  7 ++-----
 .../wireless/broadcom/brcm80211/brcmfmac/tracepoint.h  | 12 ++++--------
 .../brcm80211/brcmsmac/brcms_trace_brcmsmac_msg.h      | 12 ++++--------
 drivers/net/wireless/intel/iwlwifi/iwl-devtrace-msg.h  | 12 ++++--------
 drivers/usb/chipidea/trace.h                           |  4 ++--
 drivers/usb/host/xhci-trace.h                          |  4 ++--
 drivers/usb/mtu3/mtu3_trace.h                          |  4 ++--
 drivers/usb/musb/musb_trace.h                          |  4 ++--
 include/linux/trace_events.h                           | 18 ++++++++++++++++++
 include/trace/events/iscsi.h                           |  4 ++--
 include/trace/events/qla.h                             |  4 ++--
 include/trace/stages/stage1_struct_define.h            |  3 +++
 include/trace/stages/stage2_data_offsets.h             |  3 +++
 include/trace/stages/stage4_event_fields.h             |  3 +++
 include/trace/stages/stage5_get_offsets.h              |  4 ++++
 include/trace/stages/stage6_event_callback.h           |  7 +++++++
 net/batman-adv/trace.h                                 |  7 ++-----
 net/mac80211/trace_msg.h                               |  6 ++----
 23 files changed, 82 insertions(+), 86 deletions(-)
