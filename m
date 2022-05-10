Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BCB521C6D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 16:33:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345086AbiEJOhD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 10:37:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344228AbiEJOVY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 10:21:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15DFD254711
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 06:48:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C610619B0
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 13:48:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96D37C385A6;
        Tue, 10 May 2022 13:48:15 +0000 (UTC)
Date:   Tue, 10 May 2022 09:48:14 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: include/trace/stages/init.h:2:23: warning:
 'str__irq_vectors__trace_system_name' defined but not used
Message-ID: <20220510094814.7d917f10@gandalf.local.home>
In-Reply-To: <20220510094459.5a462ad8@gandalf.local.home>
References: <202205100202.Ag0S76wP-lkp@intel.com>
        <20220510094459.5a462ad8@gandalf.local.home>
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

On Tue, 10 May 2022 09:44:59 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> Hmm, when I do:
> 
> 	$ make arch/x86/kernel/irq.i
> 	$ astyle arch/x86/kernel/irq.i
> 	$ grep str__irq_irq_vectors__trace_system_name
> 
>   static const char str__irq_vectors__trace_system_name[] = "irq_vectors";
>   static struct trace_event_class __attribute__((__used__)) __attribute__((__section__(".ref.data"))) event_class_x86_irq_vector = { .system = str__irq_vectors__trace_system_name, .fields_array = trace_event_fields_x86_irq_vector, .fields = { &(event_class_x86_irq_vector.fields),  &(event_class_x86_irq_vector.fields) }, .raw_init = trace_event_raw_init, .probe = trace_event_raw_event_x86_irq_vector, .reg = trace_event_reg, .perf_probe = perf_trace_x86_irq_vector, };

Or is it because it is used only in initdata?

I guess I can check if it is referenced afterward anywhere, and set it to
initdata as well, if that's the case.

-- Steve
