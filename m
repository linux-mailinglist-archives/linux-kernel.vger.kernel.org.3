Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0F7F4C9F5E
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 09:37:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237148AbiCBIie (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 03:38:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbiCBIic (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 03:38:32 -0500
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C5D74A3DD
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 00:37:49 -0800 (PST)
Received: by mail-wr1-x42d.google.com with SMTP id d17so1472102wrc.9
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 00:37:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FyMU8fq6y4HoMZwEsMGQy/b/5UhgOTpxKWSbxduUW2U=;
        b=NihcgkqUkT0B/zsTlsx+XzrBEQd2pUUX7WqAIAOcocJ+Qlud6uUY/rO3t+BCjbJ+ls
         7eR4xVYaPIn2OINEeLD70a7tAeP1FWs348PUwDNpuZrZBlDYpIiApAXjwhSLuyCPYx6R
         Fi00/T/ffEHpzHq92kDi590SWMuAqvO0BLjJFXgVAYH8sLtKKf4m3slBOyyO3bsVF7Kz
         SlPc2CwAAjb6nxzxEfSAwSGNxUPWxRFWS+usC6gNFhptle0s4ntxkJju5e1uy5iaeREq
         9k6MaTULshnBoWP4Y6VWlfPtFykzt3eXLyA8gRiBwrtoK/LX+bMWHDhckSfqL1TRQVGO
         +KMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FyMU8fq6y4HoMZwEsMGQy/b/5UhgOTpxKWSbxduUW2U=;
        b=UgJUwT1UtRkpYf37aVL3sLjgjlqnrNN8j0hTi8rnwhTo/XsQC5/IV8Oa0UQbXE74m0
         4TxbR8Zfs4ADZWzpfHDuRm6QnSEsZ2gWP1JXjDYG/ZFh1hgtEjGItEdcXm+dwIBLkNTG
         ivz8hiHGFO4hrg4xz2PnQYLJNJjaoz3KtG1jjRie2io1AHd+9JnNCjDG6emZ/H2x3Q+t
         nnlATZEexH91gn9X/3a9iTQc7DRnAoSjsyp7WKxpXVlLtBYUGEbAhguaKV5PmBOXCb5N
         iSXfOpCxlfEpAIXfgxg0rCnDiQIs1Th50tHubFfdU6Iqd7MTc82kK/ETbc7do76oHd2J
         p85A==
X-Gm-Message-State: AOAM53380bNXjZpZ0pwL9oZsh7vF8i9reGvlbSL8N7wn4Mg5r9vGOiGn
        l4NyhowucFS5gbYctw1/ZtW7NA==
X-Google-Smtp-Source: ABdhPJwl9qFFI1veZYMItGxkmO2YTm89AX3gV+MTpqHzqEy3cLhV8nvy5+eNURy/aVI3T4huRj5M0A==
X-Received: by 2002:a5d:408c:0:b0:1ee:6c0f:1830 with SMTP id o12-20020a5d408c000000b001ee6c0f1830mr20725366wrp.687.1646210267541;
        Wed, 02 Mar 2022 00:37:47 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id k13-20020a7bc40d000000b00381890032dfsm4284201wmi.1.2022.03.02.00.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 00:37:47 -0800 (PST)
Date:   Wed, 2 Mar 2022 08:37:45 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Robert Marko <robert.marko@sartura.hr>
Cc:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh8s2WeF6NEGiArh@google.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com>
 <Yh3pZXQPP9kmcSSx@google.com>
 <Yh325S5PyPiJf4F5@kroah.com>
 <Yh37gTCPaESkgNzV@google.com>
 <CA+HBbNF1Am7k9M7Mf_9+TRmQ6CtFkF5MSQ4LU79svvSxPUBPiw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+HBbNF1Am7k9M7Mf_9+TRmQ6CtFkF5MSQ4LU79svvSxPUBPiw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Mar 2022, Robert Marko wrote:

> On Tue, Mar 1, 2022 at 11:54 AM Lee Jones <lee.jones@linaro.org> wrote:
> >
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
> >
> > This method actually works really well the majority of the time, and
> > has done for a number of years.  However, I am always willing to
> > improve on my processes given the opportunity.
> >
> > > How do you want to see this merged?
> >
> > The plan is for the whole set to be merged together via MFD.
> >
> > All of the other maintainers have now Acked, so it's ready to go:
> >
> >   https://lore.kernel.org/all/20220131133049.77780-1-robert.marko@sartura.hr/
> 
> Hi Lee, as far as I understand you will now take this series up via
> your MFD tree?

Yes, that's correct.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
