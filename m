Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36F2E500463
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 04:41:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239430AbiDNCnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 22:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235844AbiDNCnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 22:43:31 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D43531AF3E
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:41:03 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id y32so6749743lfa.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Apr 2022 19:41:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mCEuHD36brVtOxyd++nob/+Gm+DiKQiXoh2FckYZDmo=;
        b=qd4NjLduoTAivuhSPCDziNZX9mUcFXnmlw0uTDhfvoEc3UafX5fs5Re0iD5b+7/sVb
         AuBdeBCPpzky8ysbFOez7GVVHVyGoUYg8jXiZ8+TMpoaxEu1zbClTRkD1CF1JWKtXY3T
         m/RpH8GcI/cwf2hrMURfH8Kaf4wc6DfrsF4Z0pOB2uWuMnsv08kT1pFZX8x184An2FbJ
         Z4jP1pywbNvYV9F/jBKYOv6eC4LRaQELvQaJkSfASd2BXKcbC8X4+zLYDvR8++t/Jo8j
         NSLXuSrD/vgzZfXgs95l/lyN4dMgLLGeVEx0ZGBpIspJHN7BwklFYrjUOCf9YDeH5OG6
         Cl5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mCEuHD36brVtOxyd++nob/+Gm+DiKQiXoh2FckYZDmo=;
        b=adwCXj9mLRLI0Sbss51YiayHnzq3/O+cszUcDPEZOivBSEYtSVX3rzGFzriK2h7wCQ
         yim+ZVRLv/Fzd7+W5Aoc5qVpPg5bJuF/T2ol/LTzOBMKAvAoTgQNlZVsDmrVLci0oT/q
         dZAl9EyUV5H4RDkcS94fa78LgVE+DP57o5VLXp1P+Ca6YsV6YrWEITcJBRv1DKnbzdkx
         Sz8DSlVgqwbeXJxn89C2yhAZGF/qdWg4uLyf9qdvhR1pqS4+wvAfH+DNeqSKkRA/v1+E
         g7mbC2g4Hcc0oIuZ7bSirY0Z3ki/Ehc07xHLiBKGZ30TOvpxGe6TOa1tQHDFztAtXv/2
         F81w==
X-Gm-Message-State: AOAM530fUoRR+azrRz9bpo2TZ4m/nUnFcrmM+VRIPbuf+mVWfJTvp5Lh
        WZvzR6+vO2JBX2z3//H9Sx6mT7vUTYdWQ22lI1skSfVO8zJ6Cg==
X-Google-Smtp-Source: ABdhPJy/TxGaYjTzpc+8A8MTSoJRPdE5fFBg22cQwIv0h2c92kph7QuwX3ILyCMgrSuPwtGXMdSS1pMVcrZUnUSseEA=
X-Received: by 2002:a05:6512:10c8:b0:44a:9305:77bd with SMTP id
 k8-20020a05651210c800b0044a930577bdmr482301lfg.404.1649904061833; Wed, 13 Apr
 2022 19:41:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220413122925.33856-1-patrick.wang.shcn@gmail.com> <20220413122826.792a859d90b6c2822b1c796a@linux-foundation.org>
In-Reply-To: <20220413122826.792a859d90b6c2822b1c796a@linux-foundation.org>
From:   patrick wang <patrick.wang.shcn@gmail.com>
Date:   Thu, 14 Apr 2022 10:40:50 +0800
Message-ID: <CAGcnep_rWWYBr+NFYzh7wNhoenFpwbxy=15a6w5vpJAH8P1dDg@mail.gmail.com>
Subject: Re: [PATCH] mm: kmemleak: take a full lowmem check in kmemleak_*_phys()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     catalin.marinas@arm.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 3:28 AM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 13 Apr 2022 20:29:25 +0800 Patrick Wang <patrick.wang.shcn@gmail.com> wrote:
>
> > The kmemleak_*_phys() apis do not check the address for lowmem's min
> > boundary, while the caller may pass an address below lowmem, which
> > will trigger an oops:
>
> Do you believe this fix should be backported into -stable kernels?

Yes, I think so. The callers may not quite know the actual address they
pass(e.g. from devicetree). So the kmemleak_*_phys() apis should guarantee
the address they finally use is in lowmem range.
