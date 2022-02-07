Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E821E4AB55F
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbiBGG57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:57:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244239AbiBGGjS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:39:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859F4C043184;
        Sun,  6 Feb 2022 22:39:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6330A608CC;
        Mon,  7 Feb 2022 06:39:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02037C004E1;
        Mon,  7 Feb 2022 06:39:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644215955;
        bh=x0+qU7jW+I6pS9yDRMI6eYb/c2RxQC1bhyeo7aFHyY0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hQ0Q1uPSjrKlkH+8zu3b1QjeLuuhFlRFXuI+pbSDJ3NfbIaJR9kKLKcWsg/kjF+lX
         M5dNenFMXdjFaGtmzYbHHOL0BMwfAl8xdRZoGXDa4AMPzasTH6er+lFw1vwP24VbRM
         8ingmHtZySUbzYn9UNfqamBqSO70IEZg7tVW2r4iEq6GCt0LrZRpe+2DU332ZsZE4c
         DEt7pG6yPpEVk1o9P5MDYPOLmjxuYpgRw4m/vxAzKQ0nA/IvxPN+2f33beEeZD/rcP
         O96G7vOJuzFQwxcayzcP/1YEFLmHx84iRX52XLJKH5vIhRWsYR1gWXoO4S11kKig5x
         Vx+28MxMz4zzA==
Date:   Mon, 7 Feb 2022 12:09:08 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Jia-Ju Bai <baijiaju1990@gmail.com>
Cc:     hemantk@codeaurora.org, bbhatt@codeaurora.org,
        loic.poulain@linaro.org, jhugo@codeaurora.org,
        linux-arm-msm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] bus: mhi: possible deadlock in mhi_pm_disable_transition()
 and mhi_async_power_up()
Message-ID: <20220207063908.GB1905@thinkpad>
References: <d3a94b53-0d77-dafe-ce45-f9ab23278616@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d3a94b53-0d77-dafe-ce45-f9ab23278616@gmail.com>
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

Thanks for the report!

On Sat, Jan 29, 2022 at 10:56:30AM +0800, Jia-Ju Bai wrote:
> Hello,
> 
> My static analysis tool reports a possible deadlock in the mhi driver in
> Linux 5.10:
> 
> mhi_async_power_up()
>   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 933 (Lock A)
>   wait_event_timeout(mhi_cntrl->state_event, ...) --> Line 985 (Wait X)
>   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 1040 (Unlock A)
> 
> mhi_pm_disable_transition()
>   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 463 (Lock A)
>   wake_up_all(&mhi_cntrl->state_event); --> Line 474 (Wake X)
>   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 524 (Unlock A)
>   wake_up_all(&mhi_cntrl->state_event); --> Line 526 (Wake X)
> 
> When mhi_async_power_up() is executed, "Wait X" is performed by holding
> "Lock A". If mhi_pm_disable_transition() is concurrently executed at this
> time, "Wake X" cannot be performed to wake up "Wait X" in
> mhi_async_power_up(), because "Lock A" is already hold by
> mhi_async_power_up(), causing a possible deadlock.
> I find that "Wait X" is performed with a timeout, to relieve the possible
> deadlock; but I think this timeout can cause inefficient execution.
> 

As per the MHI design, we can be sure that mhi_pm_disable_transition() won't be
called until wait_event_timeout() completes in mhi_async_power_up(). So this
deadlock is not possible in practical.

Thanks,
Mani

> I am not quite sure whether this possible problem is real and how to fix it
> if it is real.
> Any feedback would be appreciated, thanks :)
> 
> 
> Best wishes,
> Jia-Ju Bai
> 
> 
> 
