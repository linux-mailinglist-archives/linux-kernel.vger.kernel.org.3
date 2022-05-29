Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FBD4536F7A
	for <lists+linux-kernel@lfdr.de>; Sun, 29 May 2022 06:41:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiE2E3o (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 29 May 2022 00:29:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiE2E3i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 29 May 2022 00:29:38 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E7EEB2240
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 21:29:37 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id g13-20020a9d6b0d000000b0060b13026e0dso5636967otp.8
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 21:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4k7HEF/6PocZEKm7M5webn0NCvbC90OBpWbzVdzTlEE=;
        b=D0CorQHwJZhfvMm0vJw6F018HAia8jKh4HAyazlslOhnDc6Zl7Y6505gqxX+pf7oLQ
         R1E/BySSL4FCe2LneTpJ/ObOR2i5WasBCBrt0o3s3Q+7VFrYvBdMnlXlpasW73v9QCUT
         k8qM/A6Tj0XoZekZx/kHZACgodywwz3eGPInQITDcdEozOD6tlESNXYdemxh7VEg8KpM
         6tF15csMUDQMJq5a3G6xW4LJiPA0DClbnJZM0l9+2lnxmTnt2lBKnFV30a5lvLllThqC
         CytY7tHb/LQRFJrfJgIVMrf1w/6i3Q0D82Yae3Ww1IL374icPEicHfMamTx9Bjw6fagn
         X5YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4k7HEF/6PocZEKm7M5webn0NCvbC90OBpWbzVdzTlEE=;
        b=sg7ffwzoWJNEHgoyzJG+3ZZAlqlQqR5YqIy3XOuQu8xWTGAvJXqSFYiuTdjqU6m2I1
         xlr4CQGbIdx5Qx1tuLUqslPoQ8UhZH9e8fAtg2JZuvRd2ssl0yQqsycLY8OD5urGnQ6q
         9nYZH4Jm6k3WCCcLQ/qaDpie7pr60ZNdrzdqoUsNLRNJO4iqFHZJf+mZJzUo2x5rwBX3
         N2CZQ9hi2DE7URbFaRj9NiTsvWolaauUSX6f3BmPRpvEuW+FsHn+NXZsYjY/EB/LgCCj
         RokLvYVIetTymfvNPf0XzutLBdxzXMIarXgsMkf7VyOMT8mXjw5TECqYH9XbGHMXf2Lo
         KSlA==
X-Gm-Message-State: AOAM530Xdctcdkz3C5WAeu59KBACEwemjjkiyhf1bdsFFl85yKXwngA3
        KYA0O5LekXMrSkv+vBvxKpJ4ozAycXY=
X-Google-Smtp-Source: ABdhPJyBDA3kjaypEpAcf+4WD4YCOChfMXCQE7sCnjZoIWGam+P//G/BDj2p2ho+XSMtQttVgRMVEw==
X-Received: by 2002:a05:6830:1af0:b0:60b:2242:f266 with SMTP id c16-20020a0568301af000b0060b2242f266mr9946502otd.108.1653798576630;
        Sat, 28 May 2022 21:29:36 -0700 (PDT)
Received: from geday ([2804:7f2:8006:5ec0:8108:8ab5:1f16:73fe])
        by smtp.gmail.com with ESMTPSA id t9-20020a056830082900b006060322124csm3621140ots.28.2022.05.28.21.29.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 28 May 2022 21:29:36 -0700 (PDT)
Date:   Sun, 29 May 2022 01:29:32 -0300
From:   Geraldo Nascimento <geraldogabriel@gmail.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] workqueue: missing NOT while checking if Workqueue is
 offline
Message-ID: <YpL2rHUXd0vf8IML@geday>
References: <YpKA5Bdk1Cm6KgKU@geday>
 <YpLLnx8/xpZIPMbi@geday>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YpLLnx8/xpZIPMbi@geday>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 28, 2022 at 10:25:55PM -0300, Geraldo Nascimento wrote:
> On Sat, May 28, 2022 at 05:07:08PM -0300, Geraldo Nascimento wrote:
> > Greetings,
> > 
> 
> Hi, again,
> 

And again, Hi!

Doing my due dilligence, it seems.

> > This is a one-character patch but very important as the kernel workqueue
> > __cancel_work_timer will cancel active work

It won't cancel important work, seems it's just a WARN_ON but it's very
annoying. My understanding was the NOT was needed to call __flush_work()
before kthreads are spawned. During early boot, as the comment says, before
workqueue_init() fires.

There's a bug report at https://gitlab.freedesktop.org/drm/amd/-/issues/1898
and Felix Kuehling is right that this bug is only triggered when you try
to use amdkfd ( and the Kconfigs that implies) without HSA_AMD_SVM
configured.

It makes sense to me that NOT operator is missing however, since in the warning
I was coming from _cancel_work_timer() to __flush_work(), something that
should not be done?

I would like very much to hear the opinion of the maintainers!

Thanks,
Geraldo Nascimento

>> without the NOT operator
> > added.
> > 
> > During early boot wq_online is false so with the NOT added it will evaluate
> > to true. Conversely, after boot is done, workqueue
> 
> I meant wq_online. After boot, wq_online will evaluate to true, current
> code might as well have an if (true) there. I hurried up the patch
> because if I'm right this is a major show stopper to drivers that make
> use of cancel_work_timer(). I hit it through amdgpu in conjuction with amdkfd.
> 
> > is now true and we want
> > it to evaluate to false because otherwise it will cancel important work.
> > 
> > Signed-off-by: Geraldo Nascimento <geraldogabriel@gmail.com>
> > 
> > --- workqueue.c	2022-05-28 16:54:12.024176123 -0300
> > +++ workqueue.c	2022-05-28 16:54:37.698176135 -0300
> > @@ -3158,7 +3158,7 @@ static bool __cancel_work_timer(struct w
> >  	 * This allows canceling during early boot.  We know that @work
> >  	 * isn't executing.
> >  	 */
> > -	if (wq_online)
> > +	if (!wq_online)
> >  		__flush_work(work, true);
> >  
> >  	clear_work_data(work);
