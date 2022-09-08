Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 539C95B1AFD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 13:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiIHLLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 07:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiIHLLR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 07:11:17 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17E0DE42C2
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 04:11:14 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 29so18698092edv.2
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 04:11:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=r4Y41vD7puNvlBr3i+ZthSauPxLbBF/SBVHLhtBk8es=;
        b=O3teFLEVTRxUkz3Uqk15z3RuX29Ow05PzlJ0X0o6YZjiRUzJ6euRq4QMRsAJct0ylr
         +hBbNkynYoe9Ng6hdzLIhJ8cYQTlVRHCzdlqjyPx6DWch3I6IqH5a5myeJbNsU/OEl1x
         N231Kp80INeo1M1CJilpL50vdbjIOV5X4wg7g2zbON9yzkyoGl+ZAtZnv05Cqc6BR1K9
         iyv3xA62Z9D2v0KrnUTSMm9gc8wmLY7b1mgdcref1u8a7if7QGkv6Wn8TbRpMGZMurvN
         EkpNUHxypu2eAODpXJxngGd1mlwEznRD0AyxA6aMAjJZBc2GinLv2D0GlIaRAm2u2cGp
         ndwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=r4Y41vD7puNvlBr3i+ZthSauPxLbBF/SBVHLhtBk8es=;
        b=0coc2PABMopeiEo9W0kq7t/nRPhdeF0XUBUPFomnoys+WlRSVNOoz60WZ2ozGybfqQ
         YJGMPiH8xR2G6ZVpCB90rViK7BAGNJakBlop2u7MY/JalECPZ2EpWGY2xlEuEaffHSZI
         Z1hU7CbXhIjoRuDkXkdTqJEdVFrWWr2k7nKjRQm1E0blENYhywLWh4/vo1oNd6idxz9d
         p+eoP5E2PtCG1kkScw4rUGuAYWDnNmuhhOc4g5n0DWVk+uopo8xnMtLdeAPXlwL1HswP
         a0u4H6QCPaAe0021ffxzw+xklD7unKVtVec1SGXL2JL6NG5xtoP49GxJz1x3uzKQO4rF
         1GCA==
X-Gm-Message-State: ACgBeo21g6L6OvsFiJgTmMKRxGtu9joroOXmAqXLnDhBSYA6xY83P0BZ
        fW+ebaFWJnWPq2WB3ESiL4ER8i3k5Jkr7V/bk6GF0fmH5NY=
X-Google-Smtp-Source: AA6agR4xkyjcTwbCW7SBccyIEeG9xwZTAgMp/RIM5wyyDOvh5Zoit4OM/BjfhNTr5hQAQI4BQk9b64UVG2vYRBfDs/4=
X-Received: by 2002:a05:6402:547:b0:44e:8d81:cd9c with SMTP id
 i7-20020a056402054700b0044e8d81cd9cmr6621525edx.196.1662635472393; Thu, 08
 Sep 2022 04:11:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220902091535.3572333-1-raychi@google.com> <YxIX+jqWFfwAWYot@rowland.harvard.edu>
 <CAPBYUsApTYex027qBe-=EyUxDHb8MMQscX+2jqZ98zXxN-0tHA@mail.gmail.com>
 <YxI4ZViLkZOjN/Bh@rowland.harvard.edu> <CAPBYUsCEjMSJ8P8ZM1_W+S1DOWFTOM0wJwi2fTukfxSGucYhnQ@mail.gmail.com>
 <YxYTRSSeNqooy7lz@rowland.harvard.edu>
In-Reply-To: <YxYTRSSeNqooy7lz@rowland.harvard.edu>
From:   Ray Chi <raychi@google.com>
Date:   Thu, 8 Sep 2022 19:11:01 +0800
Message-ID: <CAPBYUsD5peoF0WNQnjS3xc6R_tCXH3685AKdf3MbUhk8Tkxf_g@mail.gmail.com>
Subject: Re: [Patch v2] usb: core: stop USB enumeration if too many retries
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        mathias.nyman@linux.intel.com,
        Albert Wang <albertccwang@google.com>,
        Badhri Jagan Sridharan <badhri@google.com>,
        Puma Hsu <pumahsu@google.com>, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 5, 2022 at 11:18 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Mon, Sep 05, 2022 at 04:36:16PM +0800, Ray Chi wrote:
> > On Sat, Sep 3, 2022 at 1:07 AM Alan Stern <stern@rowland.harvard.edu> wrote:
> > > I don't understand.  If you don't know whether the accessory is broken,
> > > how do you know whether to set the quirk?
> > >
> > > On the other hand, if you always set the quirk even before you know
> > > whether the accessory is broken, why make it a quirk at all?  Why not
> > > make it the normal behavior of the driver?
> > >
> >
> > Since our device has a watchdog mechanism, when the device connects to
> > a broken accessory, the kernel panic will happen. This problem didn't happen
> > in all USB Hosts, so I want to use the quirk to fix this problem for those hosts
> > with a watchdog mechanism.
>
> Okay.  So this shouldn't be a quirk; it should apply all the time to any
> hub where the host controller has this watchdog mechanism.
>
> > > Why not set CONFIG_USB_FEW_INIT_RETRIES instead?
> > >
> >
> > https://source.android.com/docs/core/architecture/kernel/android-common
> > According to Android Common Kernel, I can't only add this config to one project.
> > In addition, it can't stop enumeration so that the timeout problem
> > still happens.
>
> This is the first time you have mentioned either the watchdog mechanism
> or the fact that this is intended for Android.  It would have been a lot
> better if both of these facts were included in the initial patch
> description.  You can't expect people to evaluate a new patch properly
> if they don't have a clear picture of what it was meant for.
>
> > > might describe in detail a situation where the quirk is needed,
> > > explaining what sort of behavior of the system would lead you to set the
> > > quirk, and why.
> > >
> >
> > There is a kernel panic when the device connects to the broken accessory.
> > I tried to modify the initial_descriptor_timeout. When the accessory is not
> > working, the total time is 6.5s (get descriptor retry) + 5*2 seconds
> > (set address of xhci timeout).
> > The time is so long to cause kernel panic for the device. This is why I want to
> > stop enumeration instead reducing the retries or timeout.
>
> It sounds like what you need is a "quick initialization" option that
> will limit the timeout lengths and the numbers of retries, and will
> cause the system to ignore connections on a port once an initialization
> has failed.  There should also be a way to make the system stop ignoring
> a port, perhaps by writing to a sysfs file.
>

I will remove the quirk and use the sysfs file to do.

> In addition, there should be an automatic algorithm to determine which
> hub ports this option will apply to.  I don't think you want it to be
> based on a quirk, because you shouldn't need to wait for a kernel panic
> before realizing that the quirk is needed -- that's why the algorithm
> has to be automatic.
>
> Can you write a new patch that works more like this?
>

I had two ideas to determine whether the port should apply the option or not.
One is a timeout and the other one is using a retry count. If using
the retry count,
I think it is close to current retry definitions. Maybe we can modify
the design.
If I use the timeout, I need more time to think of a better way to do it for the
synchronization problem. Currently, they are rough ideas. I will
upload the commit
if I have a better solution to determine the behavior automatically.

I will upload a v3 patch using sysfs file to fix the current problem.

> Alan Stern

Thanks,
Ray
