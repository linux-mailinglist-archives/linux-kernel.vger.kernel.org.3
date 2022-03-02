Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C794C9E00
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 07:48:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239751AbiCBGtg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 01:49:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239758AbiCBGtd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 01:49:33 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26385B2D7F;
        Tue,  1 Mar 2022 22:48:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AC42C618B4;
        Wed,  2 Mar 2022 06:48:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CEBE8C340F2;
        Wed,  2 Mar 2022 06:48:47 +0000 (UTC)
Date:   Wed, 2 Mar 2022 12:18:44 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mhi tree
Message-ID: <20220302064844.GF12451@workstation>
References: <20220302173714.78c9f43c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220302173714.78c9f43c@canb.auug.org.au>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed, Mar 02, 2022 at 05:37:14PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the mhi tree, today's linux-next build (x86_64 allmodconfig)
> failed like this:
> 
> drivers/bus/mhi/ep/main.c: In function 'mhi_ep_register_controller':
> drivers/bus/mhi/ep/main.c:1426:9: error: implicit declaration of function 'irq_set_status_flags' [-Werror=implicit-function-declaration]
>  1426 |         irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
>       |         ^~~~~~~~~~~~~~~~~~~~
> drivers/bus/mhi/ep/main.c:1426:46: error: 'IRQ_NOAUTOEN' undeclared (first use in this function); did you mean 'IRQF_NO_AUTOEN'?
>  1426 |         irq_set_status_flags(mhi_cntrl->irq, IRQ_NOAUTOEN);
>       |                                              ^~~~~~~~~~~~
>       |                                              IRQF_NO_AUTOEN
> drivers/bus/mhi/ep/main.c:1426:46: note: each undeclared identifier is reported only once for each function it appears in
> 
> Caused by commit
> 
>   6cb3bc57b0c5 ("bus: mhi: ep: Add support for processing MHI endpoint interrupts")
> 
> Presumably a missing include.
> 

Yes, it seems I was missing "#include <linux/irq.h>" for irq APIs. Fixed
now!

But somehow this header got included in ARM cross compilation and I
failed to catch it.

Thanks,
Mani

> I have used the mhi tree from next-20220301 for today.
> 
> -- 
> Cheers,
> Stephen Rothwell


