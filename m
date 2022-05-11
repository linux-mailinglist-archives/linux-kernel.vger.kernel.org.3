Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B27522EFF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 11:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233584AbiEKJJt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 05:09:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229805AbiEKJJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 05:09:43 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEC3656749
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:09:42 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id l9-20020a4abe09000000b0035eb3d4a2aeso1481216oop.0
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 02:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LFJbGCO+KEpkTahVLKoJS07JSk1FU7jnYtVBpRVs9qA=;
        b=nqvWipIic4TOarPih9e4ymbhEt8VLbgMLDGzik5DKPt8XstB3kHfLw345zcFyas6MT
         gQSczD9ebL7Yf7bu3M3k8n+3DDzKaXIX1l1aF9+3XLlzU626Eo2I6p3VTuxR33RIom6Y
         9U2dJRZd4/hkh01dN9oqHUJH5iPUschuDwok3Fphrc7b8FQ7MufY1C2supWd2qEzYWcM
         6k8KuZoA7wUvSTuPp3aWEDw7EanHKUEFx4tWB31OxcTjQVpGkON6CppT3dg306+igWGr
         pOO0Bfjf1jIaqyp+1hGcQ0+r8aumhVgAtKtnyDqzjdERPSY4yA1VnURzQSZbG+ofiBDe
         8vLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LFJbGCO+KEpkTahVLKoJS07JSk1FU7jnYtVBpRVs9qA=;
        b=UgW+Q4hb54nQTEh6SQp8OXpGbb5RWeFgzWfe7JGuwPn3YEGx1rooEJuek2Vdne9hOF
         Bq6DzJO+vRR1lr8pxnsQYG3fLzySS9sQxJ1rKLDIpVWu+OUbGNqXXtDvcAEWaBVqAflQ
         Y2KqHseypWwyFyopeV+jJVFmDvHrLzVHuLuaz7Nh0iAKVRzEMP0QAaslcUwTXJ5UmZVa
         Feof34A4g/6QP2g5IYPUat+aDJDx7wFUmFXPkIhKju634AzKTPu/PhPV0AURCGvxMtjF
         Vdi9f3vOCehTribPu9M4/fONImt8gAvFKHp3H8+pjL3f7evza839UVdnCr1TZHZImrAL
         tNXQ==
X-Gm-Message-State: AOAM5335wWlduCM8qKmV8u3Tg3ngj+SeAz6TSPhGVjJeUbVkmXUJaS8T
        ma96VGPP/c/9wI2r075sCYb2uBq3UbSFnaJBQNF5kdZSSyE=
X-Google-Smtp-Source: ABdhPJz5KG/JZw3SPJe9r+dzzejESWWET6oyIgfk4ClgLnCEwFmmT6ehztogA7zfGYfhraqt7Vp1XigcnX1IL/CcEs4=
X-Received: by 2002:a9d:7ac1:0:b0:605:e9ce:ddfd with SMTP id
 m1-20020a9d7ac1000000b00605e9ceddfdmr9279992otn.384.1652260182247; Wed, 11
 May 2022 02:09:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220508022910.98481-1-wangborong@cdjrlc.com>
In-Reply-To: <20220508022910.98481-1-wangborong@cdjrlc.com>
From:   Max Filippov <jcmvbkbc@gmail.com>
Date:   Wed, 11 May 2022 02:09:31 -0700
Message-ID: <CAMo8BfK9HcYWYFmvxLASO_4CTjY+fT0+LiPi6EZX+zz0-e3HnA@mail.gmail.com>
Subject: Re: [PATCH] xtensa: no need to initialise statics to 0
To:     Jason Wang <wangborong@cdjrlc.com>
Cc:     Chris Zankel <chris@zankel.net>,
        "open list:TENSILICA XTENSA PORT (xtensa)" 
        <linux-xtensa@linux-xtensa.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 7, 2022 at 7:30 PM Jason Wang <wangborong@cdjrlc.com> wrote:
>
> Static variables do not need to be initialised to 0, because compiler
> will initialise all uninitialised statics to 0. Thus, remove the
> unneeded initializations.
>
> Signed-off-by: Jason Wang <wangborong@cdjrlc.com>
> ---
>  arch/xtensa/platforms/xt2000/setup.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Thanks, applied to my xtensa tree.

-- Max
