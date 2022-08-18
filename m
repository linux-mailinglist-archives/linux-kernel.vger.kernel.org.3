Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64F6A598401
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 15:24:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245020AbiHRNXp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 09:23:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242702AbiHRNXj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 09:23:39 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D56B611152
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 06:23:36 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6523F106F;
        Thu, 18 Aug 2022 06:23:37 -0700 (PDT)
Received: from pluto.. (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCEB23F70D;
        Thu, 18 Aug 2022 06:23:34 -0700 (PDT)
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     sudeep.holla@arm.com, james.quinlan@broadcom.com,
        f.fainelli@gmail.com, vincent.guittot@linaro.org,
        lukasz.luba@arm.com, Cristian Marussi <cristian.marussi@arm.com>
Subject: [PATCH 0/1] Harmonize SCMI traces formats
Date:   Thu, 18 Aug 2022 14:23:08 +0100
Message-Id: <20220818132309.584042-1-cristian.marussi@arm.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

after having recently added new scmi_msg_dump traces I realized the
general format of the various other SCMI traces is not consistent.

As an example the full traces of a simple PERF_LEVEL_SET is now:

     cpufreq-set-276     [000] .....   139.905639: scmi_xfer_begin: transfer_id=145 msg_id=7 protocol_id=19 seq=145 poll=0
     cpufreq-set-276     [000] .....   139.905724: scmi_msg_dump: pt=13 t=CMND msg_id=07 seq=0091 s=0 pyld=000000008066ab13
     cpufreq-set-276     [000] .....   139.905725: scmi_xfer_response_wait: transfer_id=145 msg_id=7 protocol_id=19 seq=145 tmo_ms=5000 poll=0
          <idle>-0       [000] d.h2.   139.906493: scmi_msg_dump: pt=13 t=RESP msg_id=07 seq=0091 s=0 pyld=
          <idle>-0       [000] d.h2.   139.906521: scmi_rx_done: transfer_id=145 msg_id=7 protocol_id=19 seq=145 msg_type=0
     cpufreq-set-276     [000] .....   139.906651: scmi_xfer_end: transfer_id=145 msg_id=7 protocol_id=19 seq=145 status=0

... where same information is reported using different names (protocol_id= vs pt=)
and even worst different bases, which is hard to read and to parse.

So this tiny patch aims to unify this, using the same naming and ordering
of the fields (wherever possible) and moving all the protocol related
fields to base-16 while keeping in base-10 timeouts, res_id and values, so
that the new traces would be like:

     cpufreq-set-274     [001] .....   100.242894: scmi_xfer_begin: pt=13 msg_id=07 seq=0092 transfer_id=92 poll=0
     cpufreq-set-274     [001] .....   100.242906: scmi_msg_dump: pt=13 t=CMND msg_id=07 seq=0092 s=0 pyld=000000008066ab13
     cpufreq-set-274     [001] .....   100.242907: scmi_xfer_response_wait: pt=13 msg_id=07 seq=0092 transfer_id=92 tmo_ms=5000 poll=0
             cat-256     [000] d.h1.   100.243084: scmi_msg_dump: pt=13 t=RESP msg_id=07 seq=0092 s=0 pyld=
             cat-256     [000] d.h1.   100.243094: scmi_rx_done: pt=13 msg_id=07 seq=0092 transfer_id=92 msg_type=0
     cpufreq-set-274     [002] .....   100.243120: scmi_xfer_end: pt=13 msg_id=07 seq=0092 transfer_id=92 s=0

Being just a proposal I'm open to any variation of this that could help
improving realiability and parsing, any feedback welcome !

Thanks,
Cristian

Cristian Marussi (1):
  include: trace: Harmonize SCMI tracing message format

 include/trace/events/scmi.h | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

-- 
2.37.2

