Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0365E5A531B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 19:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbiH2R1M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 13:27:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiH2R1K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 13:27:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B78B8E0FA;
        Mon, 29 Aug 2022 10:27:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DF263B8119C;
        Mon, 29 Aug 2022 17:27:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F1C3FC433C1;
        Mon, 29 Aug 2022 17:27:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661794026;
        bh=LngYf8P+LI6UrANiDYF1odyCTinChzauYVwqE9jZYEk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JnRPX5hGG/m2kiEPTmqWQY6QvgVVXyPU+eqjZ5agyPQQsKK/io9g7B/AvQtz+lCWz
         WVq2GV+8lgaASRcL9+bJx3+eLbPu577683lRTJblVXNFKm5HMT3ClCSrLxO8bSsMg/
         qZ4enOxWahqgcMobW+Wg1Q6JelWe1Fc+bsUMKPC8ikwv4y7RMdAW0cS7gBxVQivfLd
         TkBudKMcPDibwIOgu0m2d6ccR8x3vxTuTvTWhJjpCqpiI+qDh+/6VfzGzdtUJEjXDq
         yz4Et2enr5+rLrzo8WH75UqHVmRGgebfu9NXqI+JYY0zBMnYLXtYkVgzbB1PowQSbe
         yKAdGB86SAeCQ==
Date:   Mon, 29 Aug 2022 22:56:54 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Kalle Valo <kvalo@kernel.org>
Cc:     Qiang Yu <quic_qianyu@quicinc.com>, quic_hemantk@quicinc.com,
        loic.poulain@linaro.org, quic_jhugo@quicinc.com,
        mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, quic_cang@quicinc.com,
        ath11k@lists.infradead.org
Subject: Re: [PATCH v3 1/1] bus: mhi: host: Fix up null pointer access in
 mhi_irq_handler
Message-ID: <20220829172654.GA84762@thinkpad>
References: <1658459838-30802-1-git-send-email-quic_qianyu@quicinc.com>
 <20220726080636.GE5522@workstation>
 <87czdrrc95.fsf@kernel.org>
 <20220729142221.GA9937@thinkpad>
 <87h71vc98l.fsf@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87h71vc98l.fsf@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 29, 2022 at 07:20:10PM +0300, Kalle Valo wrote:
> Manivannan Sadhasivam <mani@kernel.org> writes:
> 
> > On Tue, Jul 26, 2022 at 08:53:58PM +0300, Kalle Valo wrote:
> >> Manivannan Sadhasivam <mani@kernel.org> writes:
> >> 
> >> > +ath11k, Kalle
> >> >
> >> > On Fri, Jul 22, 2022 at 11:17:18AM +0800, Qiang Yu wrote:
> >> >> The irq handler for a shared IRQ ought to be prepared for running
> >> >> even now it's being freed. So let's check the pointer used by
> >> >> mhi_irq_handler to avoid null pointer access since it is probably
> >> >> released before freeing IRQ.
> >> >> 
> >> >> Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
> >> >
> >> > Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> >> 
> >> This fixes the crash and my regression tests pass now, thanks. But
> >> please see my question below.
> >> 
> >> Tested-by: Kalle Valo <kvalo@kernel.org>
> >> 
> >
> > Thanks Kalle!
> 
> I just tested v6.0-rc3 and it's still crashing. What's the plan to get
> this fix to Linus?

Sorry for the delay. Just sent the PR to Greg for including it as a fix for
v6.0.

Thanks,
Mani

> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

-- 
மணிவண்ணன் சதாசிவம்
