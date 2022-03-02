Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F154A4C9ECF
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:00:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240001AbiCBIB1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:01:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239984AbiCBIBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:01:19 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1857B6D08
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:00:35 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id m42-20020a05600c3b2a00b00382ab337e14so1501920wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:00:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=6EnkP3G89LOuEbKkRGHr/q7Nv6a/aOjFoR0uEwGT1xw=;
        b=V8fPKFqwDJ8Dy92I3pVJC3xxFxCIKmvAa/jsclT9eI84ZRpMU+6blTDMSq3wpPRcTk
         zZhPp9VzQZHIhlsQF6ITQ7EZj4Kbxpir5WDl2o5UMXcNjYUdqZ9KbD8ZIEee79oTvyEH
         oFlXI2XCf3pWVQ9NP5O6S1L/9c/KLCZuJtb5axFJS1BLq7GTyCKR/3I4KL9caLjhcsZS
         5fLJqEZpm4O0d2IGoj9TPHQcH2VNKrBphqyMQZ+egHZL2+pvx9614lcv0FyeCrulPFGf
         9LnKjV8+z0qAPTASDepCdXWTH1391WGpUi4an8+Iy5XY1UgVcq26sE93Gxsjo/NNfRs6
         QLjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=6EnkP3G89LOuEbKkRGHr/q7Nv6a/aOjFoR0uEwGT1xw=;
        b=BvXiiiQQ4BEayvvJw9IltWdEviE1nhqnPSPqAjnjPCpReGsE9FpQrHmSbhoksQ77RO
         AqvYuzeySwshF8/N8/z+Z1tKHM3jGOD4N68xwKFlgWYTMlG2bwd42ofaWg8BChg6P31f
         yqovjPFKEp/LyynaUgYJLLWZ80tOJQEoFcC8BSbR7dMmoc9adi4el1AW7vzamPq/IzVQ
         xe5YMI07rsGXixLxsfVkDDAUn6cjgL6yJPYryNcrOLdZHKnnwSFPIq9RUAeS/SiQl53x
         rPjsw0m0M2eZSgRx1UfjKkFEtC3ahODB/WJOTyUVd1dKz6sodRWMT4KPsqh1FOeVEk3B
         89Zw==
X-Gm-Message-State: AOAM532Ok8PSN/yfqpzIl6VcI52JMXEz1rAm+W+JURJ9jyhvBPfFYnGb
        csxOlhJeD1THRzK3NqWXtefrRHf8fDjtCRVo
X-Google-Smtp-Source: ABdhPJwvSxBoudapBNvzLrn0ekB10uvEM8VCg20AuY76WEEr8NkSk85eSx/VJI98pWsRrWnk48wFgA==
X-Received: by 2002:a05:600c:4e10:b0:381:a004:5855 with SMTP id b16-20020a05600c4e1000b00381a0045855mr4807543wmq.70.1646208034474;
        Wed, 02 Mar 2022 00:00:34 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id w22-20020a7bc756000000b0038171f6bb63sm4827495wmk.35.2022.03.02.00.00.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:00:34 -0800 (PST)
Date:   Wed, 2 Mar 2022 08:00:31 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh8kH5sWMkFBYQyN@google.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com>
 <Yh3pZXQPP9kmcSSx@google.com>
 <Yh325S5PyPiJf4F5@kroah.com>
 <Yh37gTCPaESkgNzV@google.com>
 <Yh6N4mWCfHtlBM07@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh6N4mWCfHtlBM07@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 01 Mar 2022, Greg KH wrote:

> On Tue, Mar 01, 2022 at 10:54:57AM +0000, Lee Jones wrote:
> > On Tue, 01 Mar 2022, Greg KH wrote:
> > 
> > > On Tue, Mar 01, 2022 at 09:37:41AM +0000, Lee Jones wrote:
> > > > On Mon, 28 Feb 2022, Greg KH wrote:
> > > > 
> > > > > On Mon, Feb 28, 2022 at 12:46:44PM +0000, Lee Jones wrote:
> > > > > > On Mon, 28 Feb 2022, Greg KH wrote:
> > > > > > 
> > > > > > > On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> > > > > > > > On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> > > > > > > > 
> > > > > > > > > Hi all,
> > > > > > > > > 
> > > > > > > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > > > > > > 
> > > > > > > > I did ask for this *not* to be merged when it was in -testing.
> > > > > > > 
> > > > > > > Sorry, I missed that, I saw your ack on the patch so that's why I took
> > > > > > > it.
> > > > > > > 
> > > > > > > > I'll follow-up with Greg.
> > > > > > > 
> > > > > > > Should I revert this from my tree?
> > > > > > 
> > > > > > I did try to catch it before a revert would have been required.
> > > > > 
> > > > > My fault.
> > > > > 
> > > > > > But yes, please revert it.
> > > > > 
> > > > > Will go do so now.
> > > > 
> > > > Thank you.
> > > > 
> > > > > > The Ack is not standard and should not be merged.
> > > > > 
> > > > > I do not understand this, what went wrong here?
> > > > 
> > > > The "Ack" you saw was just a placeholder.
> > > > 
> > > > When I provided it, I would have done so like this:
> > > > 
> > > >     "For my own reference (apply this as-is to your sign-off block):
> > > > 
> > > >      Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>"
> > > > 
> > > > REF: https://lore.kernel.org/all/YQ0fYe531yCyP4pf@google.com/
> > > > 
> > > > The majority of maintainers I regularly work with know this to mean
> > > > that the set is due to be routed via MFD (with a subsequent
> > > > pull-request to an immutable branch to follow), since MFD is often
> > > > the centre piece (parent) of the patch-sets I deal with.
> > > > 
> > > > I appreciate that this could cause confusion, but I'm not sure of a
> > > > better way to convey this information such that it survives through
> > > > various submission iterations.
> > > 
> > > But what else is another maintainer supposed to think if they see that
> > > ack on the patch?  Ignore it?  I took that to mean "this is good from a
> > > mfd-point-of-view" which meant it can go through whatever tree it is
> > > supposed to.
> > > 
> > > Are you wanting this individual patch to go through your tree now only?
> > > If so, you should say that by NOT acking it :)
> > 
> > It's not quite as easy as that.
> > 
> > It wouldn't be fair to the contributor to start reviews once all the
> > other patches in the set are ready to be merged.  So how would I
> > indicate that the MFD part is ready, fully expecting some of the other
> > patches in the set to be reworked and subsequent revisions are to be
> > submitted?
> 
> But from an "outside" observer, this patch series seemed to have acks
> from all maintainers, yet no one was taking it.  Which is why I picked
> it up (someone asked me to.)  Having the subsystem maintainer ack it
> implied to me that there was no problem.  Odd that you later on had one :)

I understand the problem and I'm not blaming you for your assumptions.

Can you recommend a better solution though?

To be fair this very seldom causes issues.

And now you know, you know. :)

> > > How do you want to see this merged?
> > 
> > The plan is for the whole set to be merged together via MFD.
> > 
> > All of the other maintainers have now Acked, so it's ready to go:
> > 
> >   https://lore.kernel.org/all/20220131133049.77780-1-robert.marko@sartura.hr/
> > 
> > Looking at the diff, I'm not entirely sure why you took it in the
> > first place?
> 
> As I mentioned above, someone else asked me to as it was sitting around
> for quite a while with no movement.

Probably better for them to reply to the 0th patch in the first instance.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
