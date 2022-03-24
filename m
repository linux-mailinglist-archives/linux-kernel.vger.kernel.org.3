Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 171624E6080
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 09:40:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348954AbiCXImB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 04:42:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237092AbiCXImA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 04:42:00 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F33459BAD1
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:40:28 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id qx21so7607164ejb.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 01:40:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=RqPTfWDpy51bGnp33iHbv7py0JgSciRl7uPSFGe9Mog=;
        b=ePYxLKQzE/pjMYLMswJlbtRwuRNsq2TfcoeAdd5BqSYfRb1r30aBX3oBZji2ScUhg4
         TFKl1XgQjup79UoIkmJo74USF/FUR9u0DbVpQteQxWONO7dMtd9cuwCVIJUK42X6tRb+
         cI6NQWZ6OJTCn5SuzLeB/bgTcsAGP5UTRf4qXsW1ZSWEGTwW5Xg5DpyF5F47Omm/qzX9
         DyEJ4CjVEGLEkUSdmr1w3Fx31mThq8CVvqkA59jaqUl0rYZgzSsdqXCOI7XSXc8pZ5sE
         AblCdMRgNAhZ85TP+LwSHhjTwqzDZ2JkoamI1q3T6EtahzWv58PbXVB6Rm16Jab23FyF
         sS0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=RqPTfWDpy51bGnp33iHbv7py0JgSciRl7uPSFGe9Mog=;
        b=umGe+lBsVtGPDA4w4SoG2uMWrJT7qdn0VoT1pib90wZsohnWS5vC20imUw9Li70Ksn
         uwCNuSEH3gtNG0n389/L+g+xpeapqGeSQ5Jn7LO/ZktdOSKxsT2Oocs3fYRmfa+mzj7U
         RES51C9R0+IG7cAkodauQYW2E/yM9xLOZuGp2HZRP9ZAjAYR13uVfPDRR7HhASprxHqS
         VycNJalulgn0LXm9VDl568ExoJsQ4lZ9oK+R/PZC7rAn2Cm6jrXHQbt1M6+oeZ3KOjzz
         E+128FGnWTBVLxLdY/dMHJJcRWK+YEVcSO2Itr4SiW4bQZ2GM+XMy7rtq3duoYwOB35N
         /T2g==
X-Gm-Message-State: AOAM530oTeW5QMCowUVP9T/dP4l9VyDlSbzspj3zIJuun5Nh4q6veNZR
        Kf0tmeaqu8/+dlOLvIWETDc=
X-Google-Smtp-Source: ABdhPJwX95ClsycRmoRe/F0VmrZ/tynUjQSJhbxu0XlbMSicc/FxB1ig0lYZPEyVK6SuXBhu/s8dTw==
X-Received: by 2002:a17:907:3e18:b0:6da:7ac5:4ad4 with SMTP id hp24-20020a1709073e1800b006da7ac54ad4mr4598124ejc.212.1648111227462;
        Thu, 24 Mar 2022 01:40:27 -0700 (PDT)
Received: from gmail.com (0526F2AE.dsl.pool.telekom.hu. [5.38.242.174])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090600d600b006dfbc46efabsm853495eji.126.2022.03.24.01.40.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 01:40:26 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Thu, 24 Mar 2022 09:40:24 +0100
From:   Ingo Molnar <mingo@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [GIT PULL] locking changes for v5.18
Message-ID: <YjwueBQoung7rFD+@gmail.com>
References: <YjhdcJB4FaLfsoyO@gmail.com>
 <CAHk-=wjS6ptr5=JqmmyEb_qTjDz_68+S=h1o1bL1fEyArVOymA@mail.gmail.com>
 <CAHk-=whNBs07foho7=QxVbs_hnpDfPP3s2fwyXK-reNw67mU=g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whNBs07foho7=QxVbs_hnpDfPP3s2fwyXK-reNw67mU=g@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Linus Torvalds <torvalds@linux-foundation.org> wrote:

> On Tue, Mar 22, 2022 at 3:05 PM Linus Torvalds
> <torvalds@linux-foundation.org> wrote:
> >
> > I see that the -mm tree has a fix for this,[..]
> 
> Ok, usually I strive to let the patch-bomb from Andrew sit in a branch
> of its own for a while (in case somebody replies to one of Andrew's
> emails I can then fix things up).
> 
> But I decided to just apply and merge the series immediately instead,
> partly to just have this issue sorted out.
> 
> Let's hope there's nothing dodgy in there..

Thanks!

> > I thought -tip had started checking with clang, but apparently not.

Only intermittently on my side - it only recently started working reliably 
& it doubles the not inconsiderable test time :-/

> > I see that the -mm tree has a fix for this, but I'm rather unhappy that 
> > the -tip tree build checking has deteriorated so much, and clang builds 
> > will now have a pointless build error that will cause issues for 
> > bisect.

Will try to add better clang testing, seems to have better warnings in a 
couple of areas.

Thanks,

	Ingo
