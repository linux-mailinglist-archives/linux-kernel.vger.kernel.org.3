Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DD5D5B2658
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 20:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232479AbiIHS5M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 14:57:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232369AbiIHS5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 14:57:09 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91457F411C
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 11:57:08 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id y136so13914822pfb.3
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 11:57:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Pm28BmGQbrW5Gi0MeI52+kjIwgWThKQThYJFme0LBgA=;
        b=fBSZPfGc/DVDWJvkB24mLjrwq2DPhyoU3WiqW9rmLQu8Cm9UMsp5TxezenEhz1eClA
         0Xe2hCH07b9SOO89K4rSo/x91qCANkwordHm3BWHzPjnNKDVEn6fCSPsHQXLKKc/v+J+
         1peBSLTKnwgAM4Z8Ucy0A8+mmcTo8dTvvXrI3rgkZG8kvkPnXeOdASCRR7Css1igEuq7
         t3RVbfRwH83XwGpHxj7Ylt4qT/ZOiBOJbc4nTPgg+s/JAiESHaHnry42KPXoRVKme8wR
         msgZJnqTDRbBVQklV+Ch2CgbVPDX8zi8fAc8/f2PWPPE5me2juDMWUPP2prjfefMiqBS
         C4Cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Pm28BmGQbrW5Gi0MeI52+kjIwgWThKQThYJFme0LBgA=;
        b=AKRlUicrIKKjMKCH2uogJOTLfoR5VspL3FvZbmI9kXynnayz3kZxhaK/WmQh+jS5yM
         CG2zr4hVHMHIZe7EkYsVhEcaVP2aMlhq6kdMaRa6oW93N7zJqy93vZMbS2YxtW8BGSyd
         SVyicFxtoDGCY7g3qD5BrAIgByOsJJwrA9KeVo9up2L14rtEnRf+Lmp1HNpg9ebau7uM
         5TyhFDWNnY+V47C9JADnq1Kdu/vDlI05upFVyLtj2zsCormjHAIChg1ORDkeNQYbb9OV
         CnfjsYH9RPdL9N742l5+sR00SNqx56626RGk8FtC0yi9VL91Zxiyc4jFuuvpB9Z6UvY6
         8YNw==
X-Gm-Message-State: ACgBeo1KrKR7E3EnWRS1Fw3xLrtBodPpXJQKiRl+Qkc7Hxu6UnEQZTeD
        7LM8f5ZtIC4hzUNaWxiw7uftnau81GGToJcd/p4=
X-Google-Smtp-Source: AA6agR4pgBZYnKG3vwyCLaggnelUQXBntY88YO+ElYymgdXYZ4p55XxyCTzF0I0V4JOhd50PbXV7j0iDDcsQC+A0g1c=
X-Received: by 2002:a63:5d4e:0:b0:41d:2966:74e7 with SMTP id
 o14-20020a635d4e000000b0041d296674e7mr8860484pgm.526.1662663427960; Thu, 08
 Sep 2022 11:57:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220908170133.1159747-1-abrestic@rivosinc.com> <20220908185006.1212126-1-abrestic@rivosinc.com>
In-Reply-To: <20220908185006.1212126-1-abrestic@rivosinc.com>
From:   SS JieJi <c141028@gmail.com>
Date:   Fri, 9 Sep 2022 02:56:57 +0800
Message-ID: <CANaf2sf=W=X0aEpj5haN3ns3XVqZt2si+Q=xFdhaK6GwNR7Tnw@mail.gmail.com>
Subject: Re: [PATCH v2] riscv: Make mmap() with PROT_WRITE imply PROT_READ
To:     Andrew Bresticker <abrestic@rivosinc.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Atish Patra <atishp@atishpatra.org>,
        Celeste Liu <coelacanthus@outlook.com>,
        dram <dramforever@live.com>, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The v2 patch looks great,
> -       if (unlikely((prot & PROT_WRITE) && !(prot & PROT_READ)))
> -               return -EINVAL;
> -
This also removes the check for --x pages, which used to be present in
previous versions (before the submission of the to-be-reverted patch).
Is this intended? Thanks!
