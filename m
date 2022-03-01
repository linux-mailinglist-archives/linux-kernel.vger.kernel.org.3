Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 072E54C882C
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 10:38:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233176AbiCAJib (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 04:38:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiCAJi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 04:38:28 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31DEC25CF
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 01:37:46 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id d3so19510237wrf.1
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 01:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=WL7296Voa7XM5nC6jBcwSH3JZ4O9Js6FwTvwTJrqRDU=;
        b=K+DLjYVILSKe0zHrgZ7UItTH1K07qNEo5kVY9CPPCIf5Pp91pAZvoCOzFwxKhEGcv5
         P1JdfHXZvpsMM9l82uHo0jaysLG/XwyLu9O54TjlHWa4Fveiei9nfCEC8K11rSymvtca
         kF2Cw+W2vEM/6xxb7qBbdxi92f/5Ryev0zA6+Mj9MWJTNMSc+HAf/mNIUj2ZLZFdODlV
         A6a09QhH0Z1VINB6S3iMvrZ2GX0rJH4uYIIjakQ5nBsBBvpWaOBptNTWSc4/GgwwxAst
         7fOXALPnQx/BLJcfPHHTHl8r16pf/iZryENtYisXZCdgjasiKAXC22PnjJCisP0vfObA
         aPjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=WL7296Voa7XM5nC6jBcwSH3JZ4O9Js6FwTvwTJrqRDU=;
        b=Qg5UyShnkK/82lnV2Lsvuucx5mmGzJDMRFYWZH3dlnS/luJ0g+CQOq520i1VsTsKZC
         VP24n1KBMkXrBQjcwZ1Tfw62HbQFygUU+ESASY2cf6GyGyAmyAsu4c7m6CaW+f2Rkoqf
         tqI6vDyKBW3or0cTCNNSkfk6qNorPq8tCXPO8Ddtt8QAh9J+BOLwOWxjD9e95m+kONEr
         nuWVQ3UmqyWAHWGfnBi1GQDDpgU2+Izf1k2BAFr7Fo1RTNJfNFi3iZRiubP00ByMRC7W
         +EDIBBYrgivurVFcgKleWHVV14AaEJnubRRngTvJYIZWlGKJhc1YPccv7Bxzv3hCT0Pi
         oSkg==
X-Gm-Message-State: AOAM533+mIxsPavz7RULMymnWpYDvJGYEIoPgmvMPI3Q/Qj4JpVqyfgA
        i4amCXmDl93x7qQcGLKiV6TYTg==
X-Google-Smtp-Source: ABdhPJxr08d/H3s/W2AJoyjvXMbxtHk6ci/qpVFryLyBkL90xwmqbuQRDW8s/A8J3vOMLJeLCCZx8g==
X-Received: by 2002:adf:f611:0:b0:1ed:e11a:67a4 with SMTP id t17-20020adff611000000b001ede11a67a4mr18853699wrp.215.1646127464708;
        Tue, 01 Mar 2022 01:37:44 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id l16-20020a05600c4f1000b0033383cdeea1sm2157253wmq.10.2022.03.01.01.37.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Mar 2022 01:37:43 -0800 (PST)
Date:   Tue, 1 Mar 2022 09:37:41 +0000
From:   Lee Jones <lee.jones@linaro.org>
To:     Greg KH <greg@kroah.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Arnd Bergmann <arnd@arndb.de>,
        Alistair Francis <alistair@alistair23.me>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: linux-next: manual merge of the char-misc tree with the mfd tree
Message-ID: <Yh3pZXQPP9kmcSSx@google.com>
References: <20220228193928.3ec6ee98@canb.auug.org.au>
 <YhyPfcjJtIKNQtF8@google.com>
 <Yhyn72NO/roH1gA8@kroah.com>
 <YhzENKPtY+WOp566@google.com>
 <Yh09/r/nT2LeE82n@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yh09/r/nT2LeE82n@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 28 Feb 2022, Greg KH wrote:

> On Mon, Feb 28, 2022 at 12:46:44PM +0000, Lee Jones wrote:
> > On Mon, 28 Feb 2022, Greg KH wrote:
> > 
> > > On Mon, Feb 28, 2022 at 09:01:49AM +0000, Lee Jones wrote:
> > > > On Mon, 28 Feb 2022, Stephen Rothwell wrote:
> > > > 
> > > > > Hi all,
> > > > > 
> > > > > Today's linux-next merge of the char-misc tree got a conflict in:
> > > > 
> > > > I did ask for this *not* to be merged when it was in -testing.
> > > 
> > > Sorry, I missed that, I saw your ack on the patch so that's why I took
> > > it.
> > > 
> > > > I'll follow-up with Greg.
> > > 
> > > Should I revert this from my tree?
> > 
> > I did try to catch it before a revert would have been required.
> 
> My fault.
> 
> > But yes, please revert it.
> 
> Will go do so now.

Thank you.

> > The Ack is not standard and should not be merged.
> 
> I do not understand this, what went wrong here?

The "Ack" you saw was just a placeholder.

When I provided it, I would have done so like this:

    "For my own reference (apply this as-is to your sign-off block):

     Acked-for-MFD-by: Lee Jones <lee.jones@linaro.org>"

REF: https://lore.kernel.org/all/YQ0fYe531yCyP4pf@google.com/

The majority of maintainers I regularly work with know this to mean
that the set is due to be routed via MFD (with a subsequent
pull-request to an immutable branch to follow), since MFD is often
the centre piece (parent) of the patch-sets I deal with.

I appreciate that this could cause confusion, but I'm not sure of a
better way to convey this information such that it survives through
various submission iterations.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
