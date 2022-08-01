Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF95863ED
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 08:14:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiHAGOB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 02:14:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239506AbiHAGNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 02:13:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FB0913F84;
        Sun, 31 Jul 2022 23:13:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 783FFB80E93;
        Mon,  1 Aug 2022 06:13:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8ACECC433C1;
        Mon,  1 Aug 2022 06:13:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1659334429;
        bh=ufvReJmyzn8HuZ2QSi6foXERUMWcAAloMDHnl/jBc58=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=oZyyNIyqB7zzReEOOi0QGLgXcGLeaw3DGT7XpxPFR6xPdyDl1OYTRJEhjqQtt3drS
         /OpJ3v5kpWFqDmLnU18F8cW2l6D+fzzrBpOZBZr6UU+OoogdC7LDA6/29XjQB3u895
         E1AOzh0/mkdtJXZMWKRHsWDtN3zOthYMtQe51lGo=
Date:   Mon, 1 Aug 2022 08:13:44 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "yekai (A)" <yekai13@huawei.com>
Cc:     herbert@gondor.apana.org.au, linux-crypto@vger.kernel.org,
        linux-kernel@vger.kernel.org, wangzhou1@hisilicon.com,
        liulongfang@huawei.com
Subject: Re: [PATCH v6 2/3] Documentation: add a isolation strategy sysfs
 node for uacce
Message-ID: <YudvGPbcegOZQlbE@kroah.com>
References: <20220730083246.55646-1-yekai13@huawei.com>
 <20220730083246.55646-3-yekai13@huawei.com>
 <YuUQuNPIV6Xrfmwt@kroah.com>
 <901896fa-2acc-127c-a8ea-8143cda47b1b@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <901896fa-2acc-127c-a8ea-8143cda47b1b@huawei.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 01, 2022 at 10:20:27AM +0800, yekai (A) wrote:
> 
> 
> On 2022/7/30 19:06, Greg KH wrote:
> > On Sat, Jul 30, 2022 at 04:32:45PM +0800, Kai Ye wrote:
> >> Update documentation describing sysfs node that could help to
> >> configure isolation strategy for users in the user space. And
> >> describing sysfs node that could read the device isolated state.
> >>
> >> Signed-off-by: Kai Ye <yekai13@huawei.com>
> >> ---
> >>  Documentation/ABI/testing/sysfs-driver-uacce | 17 +++++++++++++++++
> >>  1 file changed, 17 insertions(+)
> >>
> >> diff --git a/Documentation/ABI/testing/sysfs-driver-uacce b/Documentation/ABI/testing/sysfs-driver-uacce
> >> index 08f2591138af..1601f9dac29c 100644
> >> --- a/Documentation/ABI/testing/sysfs-driver-uacce
> >> +++ b/Documentation/ABI/testing/sysfs-driver-uacce
> >> @@ -19,6 +19,23 @@ Contact:        linux-accelerators@lists.ozlabs.org
> >>  Description:    Available instances left of the device
> >>                  Return -ENODEV if uacce_ops get_available_instances is not provided
> >>  
> >> +What:           /sys/class/uacce/<dev_name>/isolate_strategy
> >> +Date:           Jul 2022
> >> +KernelVersion:  5.20
> >> +Contact:        linux-accelerators@lists.ozlabs.org
> >> +Description:    (RW) Configure the frequency size for the hardware error
> >> +                isolation strategy. This size is a configured integer value.
> >> +                The default is 0. The maximum value is 65535. This value is a
> >> +                threshold based on your driver handling strategy.
> > what is a "driver handling strategy"?  What exactly is this units in?
> > Any documentation for how to use this?
> >
> > thanks,
> >
> > greg k-h
> > .
> The unit is the number of times, also means frequency size.
> e.g.
> In the  hisilicon acc engine, First we will time-stamp every slot AER error. Then check the AER error log when the device
> AER error occurred. if the device slot AER error count  exceeds the preset the number of times in one hour, the isolated state
> will be set to true. So the device will be isolated.  And the AER error log that exceed one hour  will be cleared.  Of course,
> different strategy can be defined in different drivers.

Ok, can you please explain this better here when you redo the patch
series?

thanks,

greg k-h
