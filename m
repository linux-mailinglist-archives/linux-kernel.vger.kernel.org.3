Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9695835ED
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 02:11:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234775AbiG1ALj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 20:11:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiG1ALg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 20:11:36 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 748D3186EB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:11:34 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i14so923653yba.1
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 17:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oj1JQ0byf3ZK+xjlkmwlMJIjyJZ04S1n8W9/zGUpWWA=;
        b=tXWP4NtnND1J/gM2E8aRkWedxAYPMOCtgHly7gtP193/3vz5Gas/sYP4+VZXDzZ1Qb
         fc6PUF0DWZD12L+go7CsQ2nImqz3v7KsaVua6wjoOYZmDiqoW2EHdoodQSqNO4ni8u4W
         2gyhbJYcFITXPBv4LSchtEk2D6MzaBMEZ82A1g8++Mh5r0zZBW8+8B0pi6zkpouLc0eH
         1LEMp73pQmOGTwZnp7OBE+5oW0JBurLMQzVjOFpsFZ9N/FJgMEk+GYZx6uZICN/9Lo7y
         8lqFOwDZtA3zxjNOkdPbRhXTpTSWuBiRTWgl0/aW3WfmWNr1pMwbRT6aQDLW6IjscgdV
         Xxqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oj1JQ0byf3ZK+xjlkmwlMJIjyJZ04S1n8W9/zGUpWWA=;
        b=OUZyc4BHSUMXhLOt7Wsvx6Vc5U4TBsLxiZhk0W2rGH7ZZHuv5h6uF3FUFJjof+yZCA
         kA7ci387GAAUUVaGyLRix96x7LfgACcO9QVkm+WOT8mPbs+IkkUFJGE2858siYVbmNqz
         zDcTHbyOdaTZBTKgsrRSIdda26FoJW45DgdI94LYhKuJ/Vt2c3Gyl8iXUOmvog9jN82u
         QZFHi7urMg2hT40OXMTOPRXvBmc5MAtypLTiYia/i6XcmE9EbT/k6nEC8LGohG7IAsaj
         +MVjnr67gE1AWRRUcUa6Xtt1rJ197xjGRpIdeqk3NnMA72anMgArl1iExyImKa8Lt6WZ
         oixg==
X-Gm-Message-State: AJIora/nQI+rPohDZUR5vNS26st6kNqt96xniW9Syjl5S9P1qr9cXX7x
        XUaUrKICRETSpFjp4TdOXMldiVZd4T4kiFUNh0YNXQ==
X-Google-Smtp-Source: AGRyM1u6tjSAdR2WE2mzeblmgX5kmaBQQu+3ohcxhdflDpv1Hzk8UxGeO/SvuCzWkkLGH+JMHzxhJKBxzC/dQZlcDbo=
X-Received: by 2002:a25:8384:0:b0:66f:ad5a:a7b9 with SMTP id
 t4-20020a258384000000b0066fad5aa7b9mr19568642ybk.352.1658967093393; Wed, 27
 Jul 2022 17:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220727181936.3250466-1-saravanak@google.com> <YuG5KCksLWzThSmF@shell.armlinux.org.uk>
In-Reply-To: <YuG5KCksLWzThSmF@shell.armlinux.org.uk>
From:   Saravana Kannan <saravanak@google.com>
Date:   Wed, 27 Jul 2022 17:10:57 -0700
Message-ID: <CAGETcx9HFQa=58XUQ07FVQ_Qqem2La4YcR8_qDbg4uqCT8w3CQ@mail.gmail.com>
Subject: Re: [PATCH v6] amba: Remove deferred device addition
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Philipp Zabel <p.zabel@pengutronix.de>,
        Rob Herring <robh@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        patches@armlinux.org.uk, kernel-team@android.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 3:16 PM Russell King (Oracle)
<linux@armlinux.org.uk> wrote:
>
> On Wed, Jul 27, 2022 at 11:19:35AM -0700, Saravana Kannan wrote:
> > The uevents generated for an amba device need PID and CID information
> > that's available only when the amba device is powered on, clocked and
> > out of reset. So, if those resources aren't available, the information
> > can't be read to generate the uevents. To workaround this requirement,
> > if the resources weren't available, the device addition was deferred and
> > retried periodically.
> >
> > However, this deferred addition retry isn't based on resources becoming
> > available. Instead, it's retried every 5 seconds and causes arbitrary
> > probe delays for amba devices and their consumers.
> >
> > Also, maintaining a separate deferred-probe like mechanism is
> > maintenance headache.
> >
> > With this commit, instead of deferring the device addition, we simply
> > defer the generation of uevents for the device and probing of the device
> > (because drivers needs PID and CID to match) until the PID and CID
> > information can be read. This allows us to delete all the amba specific
> > deferring code and also avoid the arbitrary probing delays.
>
> Oh, this is absolutely horrible. I can apply it cleanly to my "misc"
> branch, but it then conflicts when I re-merge my tree for the for-next
> thing (which is only supposed to be for sfr - the hint is in the name!)
> for-next is basically my "fixes" plus "misc" branch and anything else I
> want sfr to pick up for the -next tree.

Btw, this is the repo I was using because I couldn't find any amba repo.
git://git.armlinux.org.uk/~rmk/linux-arm.git

Is the misc branch visible somewhere because I don't see it in that
repo? Or is that just a local branch? Also, what does sfr stand for
(s* for next)?

In case this helps, all the conflicts are due to this commit:
8030aa3ce12e ARM: 9207/1: amba: fix refcount underflow if
amba_device_add() fails

It's fixing bugs in code I'm deleting. So if you revert that, I can
give you a patch that'll apply across 5.18 and 5.19.

Let me know if you want me to do that.

> Applying this has to be on top of that merge commit, otherwise the
> conflicts are horrid, but that then means I need to send Linus the
> for-next merge commit (which I don't normally do.)
>
> Gah, we have too many changes to drivers/bus/amba.c in this cycle,
> some of them which have been submitted for 5.19 as fixes (and thus
> are not in 5.18-rc1 which the misc branch is based upon for other
> patch dependency reasons) and others in the misc branch for the next
> cycle - and now your patch wants both, which I can't do without
> rebasing the misc branch.
>
> Sadly, getting these changes into GregKH's tree will just create a
> conflict between Greg's tree and my tree.
>
> Can we postpone this please?

I guess? It's not like I can force either of you :) Or maybe you can
ask Greg to pick it up after he picks up your for-next?

Anyway, whatever option can get this pulled in reasonably soon is fine
by me -- I can send out v7 on whatever tree you want. I've been
nursing this patch for a year and I want to get it in before I hit
more conflicts/issues and give up on it :)

-Saravana
