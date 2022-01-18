Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 556F6492898
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 15:40:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245601AbiAROkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 09:40:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231658AbiAROkM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 09:40:12 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC9A2C061574;
        Tue, 18 Jan 2022 06:40:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 50BB2B816B0;
        Tue, 18 Jan 2022 14:40:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA0EC340E5;
        Tue, 18 Jan 2022 14:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642516809;
        bh=YwXVko3UDBGinWHl2wzLD2CoOggJH2y/i7m5Z9CE92E=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JjpmrWKS1VrR22nGwO1EF19v/EThe4LTRetS2KJwNKyhnFtb6trWNqrIVb5aiwiiN
         I70VIWmORaumvX56P1j8KOy0vVtdBwIZpgxLMGYso8eL6Awt5ffVp8FnIFUk8sXMqq
         3SjFcDblhOTkElY0nT5a7M6o3It4xh3XjRjodvuKjvsaS8ambVE7DLRlFr/Puz7QCx
         8eD4vnR5AcSPRf36GKoEyU90x80Nkt9mqzK2Uc+Dy1AeWZIvE6XXhbBfribTxiqHlN
         TfLoDiSVGAtaWXYziMNs5io4OplFkaPoUdrZlv2J0rSsv6UOGSOD2YZjuZYu/SAB0A
         oCZvlV3KHr2ag==
Received: by mail-ed1-f48.google.com with SMTP id j7so32020669edr.4;
        Tue, 18 Jan 2022 06:40:09 -0800 (PST)
X-Gm-Message-State: AOAM532qlmrAtPEBXFtDKX2e0/lZRGCTHiQKt4CqqOMTtmCSHqIHrGEQ
        sxlSOtQBUolWjr2PKH385JcwWYHvLCfRGjTIBw==
X-Google-Smtp-Source: ABdhPJxZXEv/F70l/2F763cGopBlndK4NcrE6a3K6sVwU3w5bmG4m+b1gOrc5zCuCPM6dB2m4JpTGoOi5Bf6LB/f2gk=
X-Received: by 2002:a05:6402:4315:: with SMTP id m21mr26177288edc.67.1642516807391;
 Tue, 18 Jan 2022 06:40:07 -0800 (PST)
MIME-Version: 1.0
References: <20220114105620.GK18506@ediswmail.ad.cirrus.com>
 <20220114111800.GL18506@ediswmail.ad.cirrus.com> <CAL_JsqKWMLi69kXp0fcdqLD039eSPwi=NPkPpOWKy=va1+YXow@mail.gmail.com>
 <20220117092656.GM18506@ediswmail.ad.cirrus.com> <20220117095559.GN18506@ediswmail.ad.cirrus.com>
In-Reply-To: <20220117095559.GN18506@ediswmail.ad.cirrus.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 18 Jan 2022 08:39:55 -0600
X-Gmail-Original-Message-ID: <CAL_Jsq+x-q_xOctCCVmzNSwGbWa_uipJ84xa1NCZnjhWSn1vVg@mail.gmail.com>
Message-ID: <CAL_Jsq+x-q_xOctCCVmzNSwGbWa_uipJ84xa1NCZnjhWSn1vVg@mail.gmail.com>
Subject: Re: ChipIdea USB regression
To:     Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     Peter Chen <peter.chen@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Arnd Bergmann <arnd@arndb.de>, Tony Lindgren <tony@atomide.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 17, 2022 at 3:56 AM Charles Keepax
<ckeepax@opensource.cirrus.com> wrote:
>
> On Mon, Jan 17, 2022 at 09:26:56AM +0000, Charles Keepax wrote:
> > On Sat, Jan 15, 2022 at 09:55:23AM -0600, Rob Herring wrote:
> > > On Fri, Jan 14, 2022 at 5:18 AM Charles Keepax
> > > <ckeepax@opensource.cirrus.com> wrote:
> > > > On Fri, Jan 14, 2022 at 10:56:20AM +0000, Charles Keepax wrote:
> > > > So when that patch copies the DT node to the new platform device
> > > > in ci_hdrc_add_device it copies the compatible stuff as well as
> > > > the IRQ stuff it was targeting, this presumably causes the kernel
> > > > to bind a new copy of the driver to that new device, which probes
> > > > and calls ci_hdrc_add_device again repeating the process until
> > > > it dies.
> > > >
> > > > Kinda looks to me like the best solution might just be to revert
> > > > the patch, I am not sure I see how that copy of the DT is supposed
> > > > to work?
> > >
> > > It's not copying the DT, but yes AFAICT it does match and bind the
> > > child device on the parent driver using the compatible match instead
> > > of matching on driver name. I think we can use the of_reuse_node flag
> > > to avoid this in the match, but that needs some more investigation.
> >
> > Assuming you mean the of_node_reused flag, looks like it already
> > being set, your code does this:
> >
> > @@ -864,6 +864,7 @@ struct platform_device *ci_hdrc_add_device(struct device *dev,
> >       pdev->dev.parent = dev;
> >       + device_set_of_node_from_dev(&pdev->dev, dev);
> >
> > And that function does this:
> >
> > void device_set_of_node_from_dev(struct device *dev, const struct device *dev2)
> > {
> >       of_node_put(dev->of_node);
> >       dev->of_node = of_node_get(dev2->of_node);
> >       dev->of_node_reused = true;
> > }
> > EXPORT_SYMBOL_GPL(device_set_of_node_from_dev);
> >
> > I guess maybe that flag doesn't do what it is supposed to for
> > some reason?
> >
>
> Ah ok it seems that flag is only currently used by the pinctrl
> subsystem, didn't realise that was quite so new and not used
> anywhere. I guess we probably need to add something to the
> platform device code to use that flag too, if that is the way we
> want to run with this.

I pushed a patch[1] for kernel-ci to test if you want to give it a try, too.

Rob

[1] https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/log/?h=for-kernelci
