Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A20BC4B3385
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 08:04:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232296AbiBLHE2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 02:04:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbiBLHEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 02:04:24 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA0AE2716D;
        Fri, 11 Feb 2022 23:04:21 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9178B816F9;
        Sat, 12 Feb 2022 07:04:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E6ABC340E7;
        Sat, 12 Feb 2022 07:04:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644649459;
        bh=5JR5bOcysOJSDhFqg8hYnCFWbBwyk5yff/mZFGN/g14=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rfy74ZkfFcQ+kcqFIyQLj/N5y9ufjm8AT5DYj4lCEUJOyzf7tTiYvBvOu6TPWVRbz
         /zy7BHaB9LQtbocZDeokNetYzUVKmZ1QIWSAojXQSG3zaWWbCB3vQrTJig+qhXhh8c
         QbPntvOB+fNg8ctNwIM4ahKsim82DJ0htqVSL+6U=
Date:   Sat, 12 Feb 2022 08:04:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Abhinav Kumar <quic_abhinavk@quicinc.com>
Cc:     johannes@sipsolutions.net, linux-kernel@vger.kernel.org,
        rafael@kernel.org, robdclark@gmail.com,
        dri-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, seanpaul@chromium.org,
        swboyd@chromium.org, nganji@codeaurora.org,
        aravindh@codeaurora.org, khsieh@codeaurora.org, daniel@ffwll.ch,
        dmitry.baryshkov@linaro.org
Subject: Re: [PATCH] devcoredump: increase the device delete timeout to 10
 mins
Message-ID: <Ygdb63FrorUsX/Hg@kroah.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
 <YgZD8vPqB7ISpRpZ@kroah.com>
 <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <654d620b-9e14-c47f-b48c-762dc0bd32a1@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 11, 2022 at 10:59:39AM -0800, Abhinav Kumar wrote:
> Hi Greg
> 
> Thanks for the response.
> 
> On 2/11/2022 3:09 AM, Greg KH wrote:
> > On Tue, Feb 08, 2022 at 11:44:32AM -0800, Abhinav Kumar wrote:
> > > There are cases where depending on the size of the devcoredump and the speed
> > > at which the usermode reads the dump, it can take longer than the current 5 mins
> > > timeout.
> > > 
> > > This can lead to incomplete dumps as the device is deleted once the timeout expires.
> > > 
> > > One example is below where it took 6 mins for the devcoredump to be completely read.
> > > 
> > > 04:22:24.668 23916 23994 I HWDeviceDRM::DumpDebugData: Opening /sys/class/devcoredump/devcd6/data
> > > 04:28:35.377 23916 23994 W HWDeviceDRM::DumpDebugData: Freeing devcoredump node
> > 
> > What makes this so slow?  Reading from the kernel shouldn't be the
> > limit, is it where the data is being sent to?
> 
> We are still checking this. We are seeing better read times when we bump up
> the thread priority of the thread which was reading this.

Where is the thread sending the data to?

> We are also trying to check if bumping up CPU speed is helping.
> But, results have not been consistently good enough. So we thought we should
> also increase the timeout to be safe.

Why would 10 minutes be better than 30?  What should the limit be?  :)

thanks,

greg k-h
