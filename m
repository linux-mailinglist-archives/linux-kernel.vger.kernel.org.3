Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C87458517A
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 16:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236978AbiG2OWe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 10:22:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236293AbiG2OWc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 10:22:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED97656B8B;
        Fri, 29 Jul 2022 07:22:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9E0BEB82808;
        Fri, 29 Jul 2022 14:22:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 624B8C433C1;
        Fri, 29 Jul 2022 14:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659104549;
        bh=FYp7dxRuDa2TzbtLpfE1k1l6o7hR4ycZLxQgQwCsplA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=gI52e6Jn7VE10U5yCiJqdCtJ8vq4VD1COs74rMHOXEDNUAB313zvt0660JPDJ89vL
         uRPByAcorrzRsXtzw4UHnEJYFgnZ0epF0+cuXPtDnI7WiYrbh8tDpLbH5ehEusMPBg
         eNhTd/WKCWFGW0aqvwRSSQZedj1nbkhf51FcitmIv3mV+5IihAseMfE30NzpLOZ+yz
         Vbrkd030U5POnTAx7Z0DMhjniNQpxIMtQyv4s34uHp67VcwJhg0wPbvzzST6nu9tlq
         e55lT7qkLZFj0rAWah49KRFUemdcWzLi8jfIAxIEaMFW92wBqgfG7GfQR8uG/sz0BC
         dVxKcR7Sz1vGw==
Date:   Fri, 29 Jul 2022 19:52:21 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v3 1/1] bus: mhi: host: Fix up null pointer access in
 mhi_irq_handler
Message-ID: <20220729142221.GA9937@thinkpad>
References: <1658459838-30802-1-git-send-email-quic_qianyu@quicinc.com>
 <20220726080636.GE5522@workstation>
 <87czdrrc95.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87czdrrc95.fsf@kernel.org>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 26, 2022 at 08:53:58PM +0300, Kalle Valo wrote:
> Manivannan Sadhasivam <mani@kernel.org> writes:
> 
> > +ath11k, Kalle
> >
> > On Fri, Jul 22, 2022 at 11:17:18AM +0800, Qiang Yu wrote:
> >> The irq handler for a shared IRQ ought to be prepared for running
> >> even now it's being freed. So let's check the pointer used by
> >> mhi_irq_handler to avoid null pointer access since it is probably
> >> released before freeing IRQ.
> >> 
> >> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> >
> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> This fixes the crash and my regression tests pass now, thanks. But
> please see my question below.
> 
> Tested-by: Kalle Valo <kvalo@kernel.org>
> 

Thanks Kalle!

> >> +	/*
> >> +	 * If CONFIG_DEBUG_SHIRQ is set, the IRQ handler will get invoked during __free_irq()
> >> +	 * and by that time mhi_ctxt() would've freed. So check for the existence of mhi_ctxt
> >> +	 * before handling the IRQs.
> >> +	 */
> >> +	if (!mhi_cntrl->mhi_ctxt) {
> >> +		dev_dbg(&mhi_cntrl->mhi_dev->dev,
> >> +			"mhi_ctxt has been freed\n");
> >> +		return IRQ_HANDLED;
> >> +	}
> 
> I don't see any protection accessing mhi_cntrl->mhi_ctxt, is this really
> free of race conditions?
> 

As Qiang said, it is safe to access mhi_ctxt here.

Thanks,
Mani

> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

-- 
மணிவண்ணன் சதாசிவம்
