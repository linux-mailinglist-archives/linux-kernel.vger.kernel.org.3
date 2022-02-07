Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2ECC34AB6D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 09:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244771AbiBGIo2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:44:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235503AbiBGIfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:35:07 -0500
X-Greylist: delayed 6950 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 07 Feb 2022 00:35:06 PST
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE35DC043181;
        Mon,  7 Feb 2022 00:35:06 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E8CE6111F;
        Mon,  7 Feb 2022 08:35:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 891F1C004E1;
        Mon,  7 Feb 2022 08:35:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644222905;
        bh=h4Bvczeyy+ofT4a7RZOUPBSV5mPLLMNEcheXBjrAyB8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DiCIj391D50M8UCaz0XpFwitV6FNrGv6bKMcV2warCsu4b0WvYxWlrOLf/j14s+O+
         ML/Om+tfNdvuLzQnZ8JIDTwRXCzwyjuDvF4PzQNNshnnzKbQ6I2x1X1aP2ceW/qG9B
         AywAVKDqVTYgQammmXWFG+OVlbNT+I9aBbUyH8mYTfvqQ56reBk57rWcVYxvSgGDQp
         9Yrb1Gc82FlOs7+iS89A/StrwuMC9ziZ5/3tmT59XDorz5Qp1JnVLqHIsPOpWU23GL
         8PkDWVMLnc2HtV1PR1Evm+wkuOCyrpF2yBFNUSTRNDMrkR4+kwqBHZqngev7QKMY5j
         42XqmbrUX3IwA==
Date:   Mon, 7 Feb 2022 14:04:58 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] bus: mhi: possible deadlock in mhi_pm_disable_transition()
 and mhi_async_power_up()
Message-ID: <20220207083458.GD1905@thinkpad>
References: <d3a94b53-0d77-dafe-ce45-f9ab23278616@gmail.com>
 <20220201171540.2udq3x6r2swctzau@maple.lan>
 <a2c91d4c-c1f3-4723-e1a4-02ac1742f96c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a2c91d4c-c1f3-4723-e1a4-02ac1742f96c@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sun, Feb 06, 2022 at 11:34:02PM +0800, Jia-Ju Bai wrote:
> 
> 
> On 2022/2/2 1:15, Daniel Thompson wrote:
> > On Sat, Jan 29, 2022 at 10:56:30AM +0800, Jia-Ju Bai wrote:
> > > Hello,
> > > 
> > > My static analysis tool reports a possible deadlock in the mhi driver in
> > > Linux 5.10:
> > > 
> > > mhi_async_power_up()
> > >    mutex_lock(&mhi_cntrl->pm_mutex); --> Line 933 (Lock A)
> > >    wait_event_timeout(mhi_cntrl->state_event, ...) --> Line 985 (Wait X)
> > >    mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 1040 (Unlock A)
> > > 
> > > mhi_pm_disable_transition()
> > >    mutex_lock(&mhi_cntrl->pm_mutex); --> Line 463 (Lock A)
> > >    wake_up_all(&mhi_cntrl->state_event); --> Line 474 (Wake X)
> > >    mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 524 (Unlock A)
> > >    wake_up_all(&mhi_cntrl->state_event); --> Line 526 (Wake X)
> > > 
> > > When mhi_async_power_up() is executed, "Wait X" is performed by holding
> > > "Lock A". If mhi_pm_disable_transition() is concurrently executed at this
> > > time, "Wake X" cannot be performed to wake up "Wait X" in
> > > mhi_async_power_up(), because "Lock A" is already hold by
> > > mhi_async_power_up(), causing a possible deadlock.
> > > I find that "Wait X" is performed with a timeout, to relieve the possible
> > > deadlock; but I think this timeout can cause inefficient execution.
> > > 
> > > I am not quite sure whether this possible problem is real and how to fix it
> > > if it is real.
> > > Any feedback would be appreciated, thanks :)
> > Interesting find but I think it would be better to run your tool
> > against more recent kernels to confirm any problem reports. In this
> > case the code you mention looks like it was removed in v5.17-rc1
> > (and should eventually make its way to the stable kernels too).
> 
> Hi Daniel,
> 
> Thanks for your reply :)
> I check Linux v5.17-rc1 code, and find that this possible deadlock does not
> exist, due to the changes in commit d651ce8e917f.
> 
> However, my tool also reports several other possible deadlocks, which are
> caused by waiting with holding mhi_cntrl->pm_mutex.
> There are two examples in Linux v5.17-rc1:
> 
> #BUG 1
> mhi_pm_sys_error_transition()
>   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 572 (Lock A)
>   wait_event_timeout(mhi_cntrl->state_event, ...); --> Line 600 (Wait X)
>   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 630 (Unlock A)
> 
> mhi_pm_disable_transition()
>   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 464 (Lock A)
>   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 496 (Unlock A)
>   wake_up_all(&mhi_cntrl->state_event); --> Line 498 (Wake X)
> 

The wait_event_timeout() in mhi_pm_sys_error_transition() waits for the state
change event from the endpoint device after triggering MHI reset. And the device
will send the state change event through the BHI IRQ vector, that'll wake up
mhi_pm_sys_error_transition().

Refer drivers/bus/mhi/host/main.c:

irqreturn_t mhi_intvec_handler(int irq_number, void *dev)
{
        struct mhi_controller *mhi_cntrl = dev;

        /* Wake up events waiting for state change */
        wake_up_all(&mhi_cntrl->state_event);

        return IRQ_WAKE_THREAD;
}

By this way there would be no deadlock. This applies to your 2nd case as well.

Thanks for reporting!

Regards,
Mani

> #BUG 2
> mhi_pm_sys_error_transition()
>   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 572 (Lock A)
>   wait_event_timeout(mhi_cntrl->state_event, ...); --> Line 600 (Wait X)
>   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 630 (Unlock A)
> 
> mhi_power_down()
>   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 1139 (Lock A)
>   wake_up_all(&mhi_cntrl->state_event); --> Line 1165 (Wait X)
>   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 1168 (Unlock A)
> 
> I am not quite sure whether these possible problems are real.
> Any feedback would be appreciated, thanks :)
> 
> 
> Best wishes,
> Jia-Ju Bai
> 
