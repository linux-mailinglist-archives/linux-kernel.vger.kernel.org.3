Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44AA64C8A0B
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 11:55:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232285AbiCAKzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 05:55:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiCAKzn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 05:55:43 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 104E42D1CD
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 02:55:01 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id r10so19865729wrp.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 02:55:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RC9oQAYhwzqDcFJdvw95JaPm8X/ixpz4G02IlVUuRQA=;
        b=fYMVAihAYq9J0SIqjc+WIOtnDT9inS98fW1fEi2Sn7ghMnAI3y501AUdeK0R7blrUp
         0/CzDMOfXmbb80tqsD1JDwEQEQP1Qh2s7zs0K7f0tNTVS6JrKl3ecELo5nx5seZBwdK9
         vimGyhAwh/LYebJwbHA4Arcm5BmPeEsFLJemnowLmgAGOAWL7CLRKIOXAOmFWoMYREKi
         4D5KcCD9faaxJIMc6EXKsN/8k3vN7ip7tcOFf8mCfX35R4RqMZGH8fUsTBlUuZtZAyZv
         CgB9l4S31auUQUUfGqDIj/536k5mlGOJJf5Q1qNYme3xdjdar0ZUR698ZnnbUX1H+b1/
         4v6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RC9oQAYhwzqDcFJdvw95JaPm8X/ixpz4G02IlVUuRQA=;
        b=YH9Wv5BXtmTRWLB1F/T7ff3NyyRZa8epNdBW/YvL+0USAwSAaFayYThFNUJnDb4DhC
         HImwpfSzdvAsHHP9hUoXxBjWXavuVusTDJhHXfLWquRxbiTJti20+P46GtQ/EyfC+lVd
         XM9z0W4h1OHpKt5Xit/JySxTajKRrigrXlkC20w8TXg4h2vYv6/wjg2l23uV+/DsvRM1
         VDhA1tLH4iBZELpBjJO81KjbAnsR5BiRVX05EAiec7dcKhXq9M0gb/d+BeDuTQYxI6o9
         eqRe4Y9dOfQM2ncGFxeid4MMmEeUZsfbUDycjZ/A4xW8W9pZoi0rhufnTiAdtw5W13Az
         mYwQ==
X-Gm-Message-State: AOAM533HjYqkL4Nm4WVNN5eegjiOKd8Pt++MyjtwDLVq3baVd+M2Rq35
        29P7667KaftM/R243CE0HqJ8Mg==
X-Google-Smtp-Source: ABdhPJzdYMhou6o5WrZ52n2EdXq1yT7EjObFb+PF0Vlfb5l46Xdgw8+pUJp/NLWi38XzB8Ln5nF/ug==
X-Received: by 2002:adf:a512:0:b0:1ea:9656:958b with SMTP id i18-20020adfa512000000b001ea9656958bmr18797120wrb.241.1646132099524;
        Tue, 01 Mar 2022 02:54:59 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id bg20-20020a05600c3c9400b0037fa5c422c8sm2438734wmb.48.2022.03.01.02.54.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 02:54:59 -0800 (PST)
Date:   Tue, 1 Mar 2022 10:54:57 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh37gTCPaESkgNzV@google.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com>
 <Yh3pZXQPP9kmcSSx@google.com>
 <Yh325S5PyPiJf4F5@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh325S5PyPiJf4F5@kroah.com>
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

> On Tue, Mar 01, 2022 at 09:37:41AM +0000, Lee Jones wrote:
> > On Mon, 28 Feb 2022, Greg KH wrote:
> > 
> > > On Mon, Feb 28, 2022 at 12:46:44PM +0000, Lee Jones wrote:
> > > > On Mon, 28 Feb 2022, Greg KH wrote:
> > > > 
> > > > > On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> > > > > > On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> > > > > > 
> > > > > > > Hi all,
> > > > > > > 
> > > > > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > > > > 
> > > > > > I did ask for this *not* to be merged when it was in -testing.
> > > > > 
> > > > > Sorry, I missed that, I saw your ack on the patch so that's why I took
> > > > > it.
> > > > > 
> > > > > > I'll follow-up with Greg.
> > > > > 
> > > > > Should I revert this from my tree?
> > > > 
> > > > I did try to catch it before a revert would have been required.
> > > 
> > > My fault.
> > > 
> > > > But yes, please revert it.
> > > 
> > > Will go do so now.
> > 
> > Thank you.
> > 
> > > > The Ack is not standard and should not be merged.
> > > 
> > > I do not understand this, what went wrong here?
> > 
> > The "Ack" you saw was just a placeholder.
> > 
> > When I provided it, I would have done so like this:
> > 
> >     "For my own reference (apply this as-is to your sign-off block):
> > 
> >      Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>"
> > 
> > REF: https://lore.kernel.org/all/YQ0fYe531yCyP4pf@google.com/
> > 
> > The majority of maintainers I regularly work with know this to mean
> > that the set is due to be routed via MFD (with a subsequent
> > pull-request to an immutable branch to follow), since MFD is often
> > the centre piece (parent) of the patch-sets I deal with.
> > 
> > I appreciate that this could cause confusion, but I'm not sure of a
> > better way to convey this information such that it survives through
> > various submission iterations.
> 
> But what else is another maintainer supposed to think if they see that
> ack on the patch?  Ignore it?  I took that to mean "this is good from a
> mfd-point-of-view" which meant it can go through whatever tree it is
> supposed to.
> 
> Are you wanting this individual patch to go through your tree now only?
> If so, you should say that by NOT acking it :)

It's not quite as easy as that.

It wouldn't be fair to the contributor to start reviews once all the
other patches in the set are ready to be merged.  So how would I
indicate that the MFD part is ready, fully expecting some of the other
patches in the set to be reworked and subsequent revisions are to be
submitted?

This method actually works really well the majority of the time, and
has done for a number of years.  However, I am always willing to
improve on my processes given the opportunity.

> How do you want to see this merged?

The plan is for the whole set to be merged together via MFD.

All of the other maintainers have now Acked, so it's ready to go:

  https://lore.kernel.org/all/20220131133049.77780-1-robert.marko@sartura.hr/

Looking at the diff, I'm not entirely sure why you took it in the
first place?

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
