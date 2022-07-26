Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931E7580EAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbiGZIJl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:09:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238650AbiGZIJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:09:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59AC62F666;
        Tue, 26 Jul 2022 01:09:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 17E4AB80EBA;
        Tue, 26 Jul 2022 08:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 617B6C341C0;
        Tue, 26 Jul 2022 08:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658822960;
        bh=pG72duAPiTGl4achXEhxrKZ8ePu73MmI2EBcMCasz0Y=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=MP7YZkJNqzVBTuMJ789kv7my8rdAKEdZoFSR92Y+jTdj8W/yANme/XWGa2h1d4sUC
         X0A197Rl2ijLZdlBJer8X2ikG1nMLIrjBenK7aFNz2Y6dgjt+qY5eBKd40H9VSbe03
         Dlj7Z7lwSQ0Nqlqe3eNWFpP6RtlEk4EvTkmw85cCKFJA0y+dJ8atHlEnmf1V1iHBUU
         +J1hbe4Pmh6Jp1AvyMQ00gm5DnhgxqYIjSz+nReeGOI3rk9RunnwoJxKFTwKyl8Fq7
         /HprzjgZPSS3mqfeGpj8X+kNXF31rx22jd9qL3KLNANMX3X0sO3Cc1hibPpZsLY2qs
         eareb8vgUAd+g==
Date:   Tue, 26 Jul 2022 13:39:13 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v4 1/1] bus: mhi: host: Move IRQ allocation to controller
 registration phase
Message-ID: <20220726080913.GF5522@workstation>
References: <1655952183-66792-1-git-send-email-quic_qianyu@quicinc.com>
 <20220624072740.GA12171@thinkpad>
 <87k08an038.fsf@kernel.org>
 <20220720093909.GA5747@thinkpad>
 <063fe6bf-11b1-1724-058f-0fed7247906e@quicinc.com>
 <20220721101914.GC36189@thinkpad>
 <87wnc1qdhz.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87wnc1qdhz.fsf@kernel.org>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 09:00:08PM +0300, Kalle Valo wrote:
> Manivannan Sadhasivam <mani@kernel.org> writes:
> 
> > On Wed, Jul 20, 2022 at 05:47:37PM +0800, Qiang Yu wrote:
> >
> >> 
> >> On 7/20/2022 5:39 PM, Manivannan Sadhasivam wrote:
> >> > On Mon, Jul 18, 2022 at 02:15:23PM +0300, Kalle Valo wrote:
> >> > > + ath11k list
> >> > > 
> >> > > Manivannan Sadhasivam <mani@kernel.org> writes:
> >> > > 
> >> > > > On Thu, Jun 23, 2022 at 10:43:03AM +0800, Qiang Yu wrote:
> >> > > > > During runtime, the MHI endpoint may be powered up/down several times.
> >> > > > > So instead of allocating and destroying the IRQs all the time, let's just
> >> > > > > enable/disable IRQs during power up/down.
> >> > > > > 
> >> > > > > The IRQs will be allocated during mhi_register_controller() and freed
> >> > > > > during mhi_unregister_controller(). This works well for things like PCI
> >> > > > > hotplug also as once the PCI device gets removed, the controller will
> >> > > > > get unregistered. And once it comes back, it will get registered back
> >> > > > > and even if the IRQ configuration changes (MSI), that will get accounted.
> >> > > > > 
> >> > > > > Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> >> > > > Applied to mhi-next!
> >> > > I did a bisect and this patch breaks ath11k during rmmod. I'm on
> >> > > vacation right now so I can't investigate in detail but more info below.
> >> > > 
> >> > I just tested linux-next/master next-20220718 on my NUC with QCA6390, but I'm
> >> > not able to reproduce the issue during rmmod! Instead I couldn't connect to AP.
> >> 
> >> I suspect that in __free_irq(), if CONFIG_DEBUG_SHIRQ is enabled, irq
> >> handler for a shared IRQ will be invoked and null pointer access happen.
> >> 
> >> #ifdef CONFIG_DEBUG_SHIRQ
> >>     /*
> >>      * It's a shared IRQ -- the driver ought to be prepared for an IRQ
> >>      * event to happen even now it's being freed, so let's make sure that
> >>      * is so by doing an extra call to the handler ....
> >>      *
> >>      * ( We do this after actually deregistering it, to make sure that a
> >>      *   'real' IRQ doesn't run in parallel with our fake. )
> >>      */
> >>     if (action->flags & IRQF_SHARED) {
> >>         local_irq_save(flags);
> >>         action->handler(irq, dev_id);
> >>         local_irq_restore(flags);
> >>     }
> >> #endif
> >> 
> >
> > Ah yes, after enabling CONFIG_DEBUG_SHIRQ I could reproduce the issue.
> 
> So how to fix this regression? (If there's already a fix I might have
> missed it as I came back only today)
> 

Copied you on the fix patch. Please test and let us know!

Thanks,
Mani

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
