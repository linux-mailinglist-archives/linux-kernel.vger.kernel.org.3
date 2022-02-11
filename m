Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725A74B23FB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 12:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349331AbiBKLJn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 06:09:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349218AbiBKLJm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 06:09:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E232E38;
        Fri, 11 Feb 2022 03:09:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E11BA61451;
        Fri, 11 Feb 2022 11:09:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A1D5C340E9;
        Fri, 11 Feb 2022 11:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1644577781;
        bh=fnV1JTSj7tqGi4Eic+pZ2ccHQtO2wG65Y0Fp6p/nPm0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wLgUCTd9qga4DEj1Uyx+cjGgDG2HkGvRysMby6Jyn8DHEIJQrsFW7gShEMemqd+IE
         jzwPBAbT/CS2LEwLfdN6ZDZ8pZwDOSps+yW/8jaiZq3UUcNyHgHsWAW28C0iD/1UHb
         Z8tr1+ULXhHqsdwEhUBtHG56v/NpTDPwDRIFXvJ0=
Date:   Fri, 11 Feb 2022 12:09:38 +0100
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
Message-ID: <YgZD8vPqB7ISpRpZ@kroah.com>
References: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644349472-31077-1-git-send-email-quic_abhinavk@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 11:44:32AM -0800, Abhinav Kumar wrote:
> There are cases where depending on the size of the devcoredump and the speed
> at which the usermode reads the dump, it can take longer than the current 5 mins
> timeout.
> 
> This can lead to incomplete dumps as the device is deleted once the timeout expires.
> 
> One example is below where it took 6 mins for the devcoredump to be completely read.
> 
> 04:22:24.668 23916 23994 I HWDeviceDRM::DumpDebugData: Opening /sys/class/devcoredump/devcd6/data
> 04:28:35.377 23916 23994 W HWDeviceDRM::DumpDebugData: Freeing devcoredump node

What makes this so slow?  Reading from the kernel shouldn't be the
limit, is it where the data is being sent to?

> Increase the timeout to 10 mins to accommodate system delays and large coredump
> sizes.

Nit, please wrap your changelog texts at 72 columns.

And what is "large"?

thanks,

greg k-h
