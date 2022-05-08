Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52EB951EF6F
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 21:12:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238882AbiEHTGG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 May 2022 15:06:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378051AbiEHSkd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 May 2022 14:40:33 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD658DF40
        for <linux-kernel@vger.kernel.org>; Sun,  8 May 2022 11:36:41 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i19so23004777eja.11
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:36:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xBmn7X1sKMD561MY32VMh/zOVxyDoB4sLlJH4mBK1Yg=;
        b=dr3n8iEg3Okpi2+98RAFGyaZsIkZq224vHkxOm2jpXBTr4bMWowz9Nq+aeGy5w2pE1
         ZJ6350+ep2T6lHqgbhVu2oD65CQstrAqa+O3z6jHA46o2ZwHqJCfHDRMc+xQCXNRYAjR
         Y3/d9df793izCkwXzJqiiChoAuyFekvCT/hKg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xBmn7X1sKMD561MY32VMh/zOVxyDoB4sLlJH4mBK1Yg=;
        b=A39Q55R6TZkb9GuWI7L6u0SuqWeGp89Ck6aZib+dx/1jn56OtCTzEMPbsMrtEV5jBt
         mYnZnQmdrSFZdu9wWGQCNC+rAMM6y5IDzRz8kartp2Zz9GSR2OeeIWJdZ9ckZy3hDuap
         53tFmb0xCOIS03kfpuQ+brnA6cFJUtlqPHhcDCTE3vRPfL7owNGYAaWSFqmbomyXSfAn
         aLQLiMgG9EfOeJBimInOHBbh0FP5IJCJBiwsreHwFAIG5Jw/S444E9d1kX3ixMCsZHpk
         UOs9hdDhqWep2XFnEd0XphwZpO1G1hLLSXjaSzMpICbJ3s6tpX3+l2ySOxfLkfAarCxB
         oEVQ==
X-Gm-Message-State: AOAM533tBLKIqb4wWuk674xOV0LhIEZegbEXPA6mxp+wJQsrYYMZ9GKd
        xxgWnG7YWmd4zpc3+gU8R+D3j1s+DHedCt3y
X-Google-Smtp-Source: ABdhPJxtH2wIKz2peAtt3wLzL4JzTxH/PAm+vbzZziEufVv8RawVhdbA19MsLxlzKxbWHrMV9IHv2A==
X-Received: by 2002:a17:907:1c20:b0:6f4:639e:9400 with SMTP id nc32-20020a1709071c2000b006f4639e9400mr11323490ejc.485.1652035000138;
        Sun, 08 May 2022 11:36:40 -0700 (PDT)
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com. [209.85.221.46])
        by smtp.gmail.com with ESMTPSA id cn18-20020a0564020cb200b0042617ba639esm5099113edb.40.2022.05.08.11.36.39
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 May 2022 11:36:39 -0700 (PDT)
Received: by mail-wr1-f46.google.com with SMTP id x18so16693665wrc.0
        for <linux-kernel@vger.kernel.org>; Sun, 08 May 2022 11:36:39 -0700 (PDT)
X-Received: by 2002:adf:dfc8:0:b0:20a:d256:5b5c with SMTP id
 q8-20020adfdfc8000000b0020ad2565b5cmr10818059wrn.97.1652034999135; Sun, 08
 May 2022 11:36:39 -0700 (PDT)
MIME-Version: 1.0
References: <165201148069.536527.1960632033331546251.tglx@xen13>
 <CAHk-=wjMmSZzMJ3Xnskdg4+GGz=5p5p+GSYyFBTh0f-DgvdBWg@mail.gmail.com> <CAHk-=whj6m0B9ys4XyE4AAPPoXE7XpBtxL7mD3Rk6EYX1=Ugng@mail.gmail.com>
In-Reply-To: <CAHk-=whj6m0B9ys4XyE4AAPPoXE7XpBtxL7mD3Rk6EYX1=Ugng@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 8 May 2022 11:36:23 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiEC-Jdx4iTP5NQ0a8stsU+SL0DjbTwhQ+mvPGNBXyMag@mail.gmail.com>
Message-ID: <CAHk-=wiEC-Jdx4iTP5NQ0a8stsU+SL0DjbTwhQ+mvPGNBXyMag@mail.gmail.com>
Subject: Re: [GIT pull] core/urgent for v5.18-rc6
To:     Thomas Gleixner <tglx@linutronix.de>,
        Zhangfei Gao <zhangfei.gao@foxmail.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Dave Hansen <dave.hansen@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 8, 2022 at 11:09 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Looks like it is
>
>  ->(*sva_bind)()
>     -> intel_svm_bind_mm()
>       -> mmu_notifier_register(&svm->notifier, mm)
>
> and yes, the mmu notifiers annoyingly end up doing an mmgrab [..]

Side note: quite independently of this mmgrab issue, I think the code
in question is *very* suspect and horrendously fragile.

In particular, the code ends up being called through things like this:

     handle = iommu_sva_bind_device(uacce->parent, current->mm, NULL);

and then that Intel svm.c code does this:

                svm->pasid = mm->pasid;
                svm->mm = mm;
                svm->flags = flags;

and saves off that mm pointer in the 'svm' structure.

AND IT NEVER TAKES ANY REFERENCE TO IT AT ALL!

It then does

        mm = svm->mm;

later at some unspecified time, and the 'mm' might long since have died.

In other words, the code works almost by accident - the only user of
the 'mm' pointer seems to be that mmu_notifier_register() thing, so it
basically treats the 'struct mm_struct' as something as a random
cookie.

And yes, the mmu notifiers do then take that mmgrab reference to the
mm, so it all works.

But it sure looks horrendously ugly. Saving off a 'struct mm_struct'
pointer with having basically an accidental reference to it is WRONG.

In fact, it will save off that pointer whether it then actually does
the mmu_notifier thing on it, because the code actually does

                [...]
                svm->mm = mm;
                svm->flags = flags;
                INIT_LIST_HEAD_RCU(&svm->devs);

                if (!(flags & SVM_FLAG_SUPERVISOR_MODE)) {
                        svm->notifier.ops = &intel_mmuops;
                        ret = mmu_notifier_register(&svm->notifier, mm);
                [...]

so that mmu_notifier_register() call is conditional. On the freeing
path, it then uses that "svm->notifier.ops" pointer as a "did we
register this thing or not" flag, so again - it all technically
*works*, but this is all horrendously ugly and wrong on so many
levels, keeping pointers around with very dubious reference counting
indeed.

               Linus
