Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB19563823
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231612AbiGAQji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGAQjh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:39:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B65DB28E0A
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:39:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E41462135
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 16:39:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D311C3411E;
        Fri,  1 Jul 2022 16:39:35 +0000 (UTC)
Date:   Fri, 1 Jul 2022 12:39:33 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Pawel Laszczak <pawell@cadence.com>,
        Felipe Balbi <felipe.balbi@linux.intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] str not used in cdns3 trace events
Message-ID: <20220701123933.031dc06b@gandalf.local.home>
In-Reply-To: <20220701121353.17a0b1ae@gandalf.local.home>
References: <20220701121353.17a0b1ae@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 1 Jul 2022 12:13:53 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hi,
> 
> I'm doing updates to add __vstring (dynamically created strings in trace
> events) and came across the trace events in:
> 
>   drivers/usb/cdns3/trace.h
> 
> Where there is several cases of this:
> 
> +DECLARE_EVENT_CLASS(cdns3_log_usb_irq,
> +       TP_PROTO(struct cdns3_device *priv_dev, u32 usb_ists),
> +       TP_ARGS(priv_dev, usb_ists),
> +       TP_STRUCT__entry(
> +               __field(enum usb_device_speed, speed)
> +               __field(u32, usb_ists)
> +               __dynamic_array(char, str, CDNS3_MSG_MAX)
> +       ),
> +       TP_fast_assign(
> +               __entry->speed = cdns3_get_speed(priv_dev);
> +               __entry->usb_ists = usb_ists;
> +       ),
> +       TP_printk("%s", cdns3_decode_usb_irq(__get_str(str), __entry->speed,
> +                                            __entry->usb_ists))

I see what you are doing now.

You are reserving space in the buffer to use as something to process.

There's a better way to do this. There's a trace_seq handle called "p" that
is reserved for TP_printk()

You can look at the event scsi_dispatch_cmd_start in
include/trace/events/scsi.h that uses it.

  const char *scsi_trace_parse_cdb(struct trace_seq*, unsigned char*, int);
  #define __parse_cdb(cdb, len) scsi_trace_parse_cdb(p, cdb, len)

  __parse_cdb(__get_dynamic_array(cmnd), __entry->cmd_len),

It's better than wasting space on the ring buffer just to use as a buffer
for the event.

-- Steve


> +);
> 
> I see you create a dynamic array for "str" and even reference it in the
> print with __get_str(str). But it is never assigned in TP_fast_assign().
> 
> This looks to be a bug to me. Can you explain this please?
> 
> -- Steve

