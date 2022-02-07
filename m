Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6058D4AB563
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 08:00:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241006AbiBGG6S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 01:58:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240072AbiBGGpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 01:45:20 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80572C043185;
        Sun,  6 Feb 2022 22:45:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EB62EB80D83;
        Mon,  7 Feb 2022 06:45:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9391FC004E1;
        Mon,  7 Feb 2022 06:45:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644216315;
        bh=iZXpNhr0N3akH/Sjy44hlofDVMLAqUl7QsOwcgUX2zs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UDEBiKMGPEXlEdwQnsw7Z7trJhc6ITA+Rz8zvxvviECIo+3EeSJWZDi8pNHQ1x7Jp
         baaeb95V7jMHPKiUTL8Jcq7oFCYSYZ4OWLCEG8bJfUWXgptuT+aT5vtst/HsfkoKLh
         PdQkuvX1EADhbd38ndP/Z6REcliGKLrsLOAtrsG70q4ACjSUi82INxQ/JY6SpxrDiq
         YoWOlxL5+EjzzUQa0IfZpLaS1EeIREt8qyrxmhVllf35mmgGPxttra1Tje3CpSn25O
         h8mQc+31Z+nNKq8wKmJskBmHdOa9k/iGUf1rv0VnNzYeiw6ozqL+EseJw8wBRo7xAe
         5oNBaUINBpUNw==
Date:   Mon, 7 Feb 2022 12:15:04 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Jia-Ju Bai <baijiaju1990@gmail.com>, hemantk@codeaurora.org,
        bbhatt@codeaurora.org, loic.poulain@linaro.org,
        jhugo@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BUG] bus: mhi: possible deadlock in mhi_pm_disable_transition()
 and mhi_async_power_up()
Message-ID: <20220207064504.GC1905@thinkpad>
References: <d3a94b53-0d77-dafe-ce45-f9ab23278616@gmail.com>
 <20220201171540.2udq3x6r2swctzau@maple.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220201171540.2udq3x6r2swctzau@maple.lan>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 01, 2022 at 05:15:40PM +0000, Daniel Thompson wrote:
> On Sat, Jan 29, 2022 at 10:56:30AM +0800, Jia-Ju Bai wrote:
> > Hello,
> > 
> > My static analysis tool reports a possible deadlock in the mhi driver in
> > Linux 5.10:
> > 
> > mhi_async_power_up()
> >   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 933 (Lock A)
> >   wait_event_timeout(mhi_cntrl->state_event, ...) --> Line 985 (Wait X)
> >   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 1040 (Unlock A)
> > 
> > mhi_pm_disable_transition()
> >   mutex_lock(&mhi_cntrl->pm_mutex); --> Line 463 (Lock A)
> >   wake_up_all(&mhi_cntrl->state_event); --> Line 474 (Wake X)
> >   mutex_unlock(&mhi_cntrl->pm_mutex); --> Line 524 (Unlock A)
> >   wake_up_all(&mhi_cntrl->state_event); --> Line 526 (Wake X)
> > 
> > When mhi_async_power_up() is executed, "Wait X" is performed by holding
> > "Lock A". If mhi_pm_disable_transition() is concurrently executed at this
> > time, "Wake X" cannot be performed to wake up "Wait X" in
> > mhi_async_power_up(), because "Lock A" is already hold by
> > mhi_async_power_up(), causing a possible deadlock.
> > I find that "Wait X" is performed with a timeout, to relieve the possible
> > deadlock; but I think this timeout can cause inefficient execution.
> > 
> > I am not quite sure whether this possible problem is real and how to fix it
> > if it is real.
> > Any feedback would be appreciated, thanks :)
> 
> Interesting find but I think it would be better to run your tool
> against more recent kernels to confirm any problem reports. In this
> case the code you mention looks like it was removed in v5.17-rc1
> (and should eventually make its way to the stable kernels too).
> 

Hmm, looks like the commit didn't apply cleanly to 5.10:
https://www.spinics.net/lists/stable/msg526754.html

Let send the fix up version.

Thanks,
Mani

> 
> Daniel.
