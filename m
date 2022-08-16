Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 609E7596078
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 18:41:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236576AbiHPQlZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 12:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230494AbiHPQlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 12:41:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B4EF80B51;
        Tue, 16 Aug 2022 09:41:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 077646123A;
        Tue, 16 Aug 2022 16:41:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3A08EC433D6;
        Tue, 16 Aug 2022 16:41:21 +0000 (UTC)
Date:   Tue, 16 Aug 2022 12:41:28 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     ira.weiny@intel.com
Cc:     Dan Williams <dan.j.williams@intel.com>,
        Alison Schofield <alison.schofield@intel.com>,
        Vishal Verma <vishal.l.verma@intel.com>,
        Ben Widawsky <bwidawsk@kernel.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        linux-kernel@vger.kernel.org, linux-cxl@vger.kernel.org
Subject: Re: [RFC PATCH 1/9] cxl/mem: Implement Get Event Records command
Message-ID: <20220816124128.618948e9@gandalf.local.home>
In-Reply-To: <20220816123958.2b49674a@gandalf.local.home>
References: <20220813053243.757363-1-ira.weiny@intel.com>
        <20220813053243.757363-2-ira.weiny@intel.com>
        <20220816123958.2b49674a@gandalf.local.home>
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

On Tue, 16 Aug 2022 12:39:58 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> > +		record_count = le16_to_cpu(payload.record_count);
> > +		if (record_count > 0)
> > +			trace_cxl_event(dev_name(cxlds->dev), type,
> > +					&payload.record);
> > +
> > +		if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> > +			trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> > +						 &payload);  
> 
> If you want to avoid the compare operations when the tracepoints are not
> enabled, you can add:
> 
> 		if (trace_cxl_event_enabled()) {
> 			if (record_count > 0)
> 				trace_cxl_event(dev_name(cxlds->dev), type,
> 						&payload.record);
> 		}
> 
> 		if (trace_cxl_event_overflow_enabled()) {
> 			if (payload.flags & CXL_GET_EVENT_FLAG_OVERFLOW)
> 				trace_cxl_event_overflow(dev_name(cxlds->dev), type,
> 							 &payload);
> 		}
> 
> Those "<tracepoint>_enabled()" functions are static branches. Which means
> when not enabled it's a nop that skips this code, and when either is
> enabled, it turns into a jump to the contents of the if block.

Ignore this suggestion. I see in the second patch you add more logic to the
if condition. Only use this suggestion if the logic is only for when the
tracepoint is enabled.

-- Steve
