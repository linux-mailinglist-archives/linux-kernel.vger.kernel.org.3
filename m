Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D0925328FA
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:29:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236632AbiEXL3W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:29:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbiEXL3V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:29:21 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6146287A33
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:29:20 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id r71so16125897pgr.0
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:29:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IldGxKJY6LO3UJ6O+XkKSV+I8U/lySrgG1o7l9jJtsQ=;
        b=K3AP1mzKBkpP2s1wvEPgKcIXDy+J8uuf3OY/9pZ0vetpdQO3QCTQ9d2xR3ESFGL5Qk
         8NbxT4ovJqlKJO3B8XqM0FJpYywxafJPGDDKR11ruaJRCaihuty47AZ9UJfIXHN7W8Z2
         bj3v+r8WAwDgaTpEvzxOIOmF/Du+xMo/K2OAwpo4R8pydlYQPicRILJORFTi7sP8Ma4N
         2XpY2kP3VX3vorDulh8I+r9kE1nsY7Ce4uThY0R6NgOyR+QgPhnSsSojzQiCOClqFYE8
         Ug0uAt3iReyy+5/WtabDKt/HSQXKuZW480T56peAMB69YQLTBLYCAtv6m74kUcVSR+83
         l9bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IldGxKJY6LO3UJ6O+XkKSV+I8U/lySrgG1o7l9jJtsQ=;
        b=oCRMvZAwqN+9KdHksBHD6TQXiutjBZ/lzVzWhQwlMW/wnwactZR+AwM7Ytz6R4YxcW
         KNbPXcd0xrkzL1cX7z9QT4F3rc+W0UhHLLftBPVRA9UgmcHc9pUAlodVKwDWPW7I/D3f
         dlUtGH1+oQoExN4l+xyW4SxKtFk47n4rxHLEH3OR6VrDMv+oaxQd91aswgAWjUP/cHQN
         5O02SPfpmMrDk7fgjykq4eIwUXUC3w0VyVirvQ4rSUA9DqHV9d2vpLTCvTbkD55eWAVI
         4siS4+LHjm9tk5Xlquw5Z6XodAZW35+HsCUA+iVfmSxEWK9mTbojHqq+sBuVEOpMnWdM
         p3jg==
X-Gm-Message-State: AOAM531bbvkz1ucLeVspmqZX4K0Esl8DEVuxW/dJVBtsgtkxW5q8Egz2
        QW2q4tEjsZFcDRbEfCnjOxaV/g==
X-Google-Smtp-Source: ABdhPJyeS3sWXHou4lfADPXNoFZTAcSSX9pCVQTrStY0/TIhBtQVG89ziKHFF7D93bNi9LgC0lAaSw==
X-Received: by 2002:aa7:960d:0:b0:518:7139:f85c with SMTP id q13-20020aa7960d000000b005187139f85cmr20365589pfg.40.1653391759901;
        Tue, 24 May 2022 04:29:19 -0700 (PDT)
Received: from localhost ([122.162.234.2])
        by smtp.gmail.com with ESMTPSA id iz19-20020a170902ef9300b0016214b6318bsm5399367plb.128.2022.05.24.04.29.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 04:29:19 -0700 (PDT)
Date:   Tue, 24 May 2022 16:59:17 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     Schspa Shi <schspa@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
Subject: Re: [PATCH v3] cpufreq: fix race on cpufreq online
Message-ID: <20220524112917.apcvvvblksg7jdu4@vireshk-i7>
References: <20220511043515.fn2gz6q3kcpdai5p@vireshk-i7>
 <CAMA88TpefB=rnqea2u1zEvNUJNE_kdj4mYito7SGCuMj-o071Q@mail.gmail.com>
 <20220511122114.wccgyur6g3qs6fps@vireshk-i7>
 <CAJZ5v0gN_yDFpvCXRXv8rN-i3TugCi-HKpBKK2z4eWU0Zm1GUg@mail.gmail.com>
 <CAJZ5v0id+7vkqMQEyVRe29oF_dRtzZ0EhoYUn8=yzeENDeABJw@mail.gmail.com>
 <20220512065623.q4aa6y52pst3zpxu@vireshk-i7>
 <CAJZ5v0jeYiZ6esdxnJbOyDztNqOAbjcjxmpca3JTFWRh+cwdBw@mail.gmail.com>
 <20220513042705.nbnd6vccuiu6lb7a@vireshk-i7>
 <20220524111456.hw4qugsvt4bm7reh@vireshk-i7>
 <CAJZ5v0i_qpcaUwdZY=KR_e=HC6MZUw2aDGL=hxgo866dF1zwOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJZ5v0i_qpcaUwdZY=KR_e=HC6MZUw2aDGL=hxgo866dF1zwOA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24-05-22, 13:22, Rafael J. Wysocki wrote:
> On Tue, May 24, 2022 at 1:15 PM Viresh Kumar <viresh.kumar@linaro.org> wrote:
> >
> > On 13-05-22, 09:57, Viresh Kumar wrote:
> > > On 12-05-22, 12:49, Rafael J. Wysocki wrote:
> > > > > > Moreover, I'm not sure why the locking dance in store() is necessary.
> > > > >
> > > > > commit fdd320da84c6 ("cpufreq: Lock CPU online/offline in cpufreq_register_driver()")
> > > >
> > > > I get that, but I'm wondering if locking CPU hotplug from store() is
> > > > needed at all.  I mean, if we are in store(), we are holding an active
> > > > reference to the policy kobject, so the policy cannot go away until we
> > > > are done anyway.  Thus it should be sufficient to use the policy rwsem
> > > > for synchronization.
> > >
> > > I think after the current patchset is applied and we have the inactive
> > > policy check in store(), we won't required the dance after all.
> >
> > I was writing a patch for this and then thought maybe look at mails
> > around this time, when you sent the patch, and found the reason why we
> > need the locking dance :)
> >
> > https://lore.kernel.org/lkml/20150729091136.GN7557@n2100.arm.linux.org.uk/

Actually no, this is for the lock in cpufreq_driver_register().

> Well, again, if we are in store(), we are holding a reference to the
> policy kobject, so this is not initialization time.

This is the commit which made the change.

commit 4f750c930822 ("cpufreq: Synchronize the cpufreq store_*() routines with CPU hotplug")

-- 
viresh
