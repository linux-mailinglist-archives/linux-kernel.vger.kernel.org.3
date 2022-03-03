Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82FAC4CBC42
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 12:16:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232680AbiCCLRC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 06:17:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232679AbiCCLQ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 06:16:58 -0500
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5114316E7FC
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 03:16:13 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 8so3817707qvf.2
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 03:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y9DlD3oCdFvs1u/R5SJKhZ/VIJ18Ddk/lN0S1Fli8aw=;
        b=l2GX1pEkiLp3APYwLaIixZZOxYJXvSsBgETozQrWrh+aIVn80upugXc9s0JothnyAU
         OslmBvRX/yuGseFw+hIxK69Mdj1Qao/eNmhHYiv9T+ruAgizL0arsPdUHk34h/0iwBP/
         ARBaKFAzBI37Crmz0EGauZ6da5movIlm967E/bzDQC0GXBLdOj0ATLQzmhJnB8bYSWIn
         I0x16pQ1uezsigGsyJY4cINKTFXYV0NJ68IrwK9byqqQIVtdPp5/6qhQOPGllsrFrZ2p
         9QgVte58ZeMaoEgSO1ckO8hsF24txWhMVoAfzbPtmIAiJmQ/DV1PMMHT8eNr/AiwgJnQ
         M+iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y9DlD3oCdFvs1u/R5SJKhZ/VIJ18Ddk/lN0S1Fli8aw=;
        b=7n56JXo3LZTL8heUyk8qMuLf1j8vhyH0FFlp3npFD3q1lDsFmTCbAIPG72dojObCqX
         synjGJ1hCdl0dZUH1EGy+FmSqqn8MAMlc4JOf6Vw3giYKkyXr425jHCJwXz3YsfvJnya
         Fubv6SZG0CcjDgl67h5B8uL32aOI77CF3frpi8pTMBLd9gJpGLuruCVM2kDFJiOUkCH1
         vJhMFKHNgEyid2N5ooM6z3YJUF84vgGgIYl/tuKS93ZjqKU5Z/A2IS8EAOVm8ErmhGiX
         C+WTg9w1gCNBIhofn7FFnjB8RMdbkxauJqGKATiCyDOHQFHeoNhN2flo+PWq+74RzU4r
         KmKw==
X-Gm-Message-State: AOAM533jC3Ev/8UVY8cPreUqzzCA+Mpv20MDUtvCwyGWAVIwJetkymL/
        FrUBgRyUPhAarfxd+8PktwC4FC5/eyRsBsLaliM=
X-Google-Smtp-Source: ABdhPJy2PhWLWch8BJkzIgQi78ExoTPK/IMtiwfcnaZ2bYp2/EEV9L8nUiJ2A9XjIWOPZ9qJgA9wrwB9mzRfqmt13Co=
X-Received: by 2002:a05:6214:cc3:b0:432:56c0:688b with SMTP id
 3-20020a0562140cc300b0043256c0688bmr23746146qvx.21.1646306172547; Thu, 03 Mar
 2022 03:16:12 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7E4716854F78B812C4FF16C83573486E1806@qq.com> <CAM0jSHO=yudjZeWbVCwdVnaJ1kJ7k34unQVvyCBxTji=u3WnWQ@mail.gmail.com>
In-Reply-To: <CAM0jSHO=yudjZeWbVCwdVnaJ1kJ7k34unQVvyCBxTji=u3WnWQ@mail.gmail.com>
From:   Matthew Auld <matthew.william.auld@gmail.com>
Date:   Thu, 3 Mar 2022 11:15:45 +0000
Message-ID: <CAM0jSHMkSNuyjEKGtDBdmpLcQS8-r_ZevR0d2iVTGEVvUmKV3g@mail.gmail.com>
Subject: Re: [Intel-gfx] [PATCH] drm/i915/selftests: check the return value of kstrdup()
To:     xkernel.wang@foxmail.com
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Intel Graphics Development <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        ML dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>
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

On Thu, 3 Mar 2022 at 10:53, Matthew Auld
<matthew.william.auld@gmail.com> wrote:
>
> On Tue, 22 Feb 2022 at 13:32, <xkernel.wang@foxmail.com> wrote:
> >
> > From: Xiaoke Wang <xkernel.wang@foxmail.com>
> >
> > kstrdup() is a memory allocation function which can return NULL when
> > some internaly memory errors happen. It is better to check the return
> > value of it to prevent further wrong memory access.
> >
> > Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
> Reviewed-by: Matthew Auld <matthew.auld@intel.com>

Scratch that. it looks like the for() already accounts for this, as
pointed out by Chris.
