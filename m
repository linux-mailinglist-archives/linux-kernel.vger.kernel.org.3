Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE8E4E5AC5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 22:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344967AbiCWVn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 17:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbiCWVn6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 17:43:58 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1540E85952
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:42:28 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id i23-20020a9d6117000000b005cb58c354e6so1996459otj.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 14:42:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gauJU+/Ukt87qElnbOCar/GeP644jnPenO1H+olAZxI=;
        b=cswYNs/WyXAL6DSvgYLR3dF6cUIcVKCxSQGRNXV786efwrusYDE0bclQvwL/1eYS9t
         vThDuK/9GhGm5Ws+5z71Qd6WANakCW1IxYdEHRVO7aP16V8R06I2LqJrdw4RATCO1HP0
         UUGnJhwwcsp+xk/fmmMo/rX+1/XfoPXgN3W38qwm7MH+c8m3HzAOcpFmrbcAhGuFJHfX
         Vw5+f9RS596X3GChcf3jnVR4yHuJTrMPuhPEsnm8gzpHE3KwO/joTbHm5QXM0P67HP7h
         kV7tMbBorXJ887ivq0y7jr9VBFPDYpcw9XRIV3B7VBq9qM221sxbmH/8tVfi1WkmyQp0
         i0dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gauJU+/Ukt87qElnbOCar/GeP644jnPenO1H+olAZxI=;
        b=50h7k0kKQ+JdkpR0dWkCgvHNv7G93l0ocIBsJ3UHD/vvRbtFxF8C+OMJuC6B1+wiPF
         RYgKbC3/eTlJ7cZASAUOBnYg8U4Ptp+qyqfJWm6sZYXMasTDm5gnhdbr/HivfRKQutaF
         ZELvcgTp9HviwGf5v5MQxob29vC8QbUKXKaex58mXXKs3BLC3OEZA/HSlKqhrsEORnar
         //yKNIcY11lXS+mXpSOqO8/rlRQwAYptvvfGcIXq5BZ4QeDTCBWTCDB/3zq9wdPjZa/6
         1a2E4rXm2CJPqCLf+hRN99yZUe69PP45XO85zkTk7Ph39VPzkOPYy4z/e4+ZVLf+Z0hp
         tKKQ==
X-Gm-Message-State: AOAM533TZvhRuKov+8YV+9It3xDR00H4YIBPh30KMwFvM5KYoLIO1vAn
        PT1bTtnlglFsdZgx1C6oyqZTmrkTYAWu2kR9Z8o=
X-Google-Smtp-Source: ABdhPJxUgqnvMju0kQuK4cFRp3woy6+I3sh81LdOzyl9ntgr/e/GmMKsqkaDy48Yz3SiqBg8bmw7SQ3TapKKosYD62I=
X-Received: by 2002:a05:6830:10c3:b0:5cd:481a:148a with SMTP id
 z3-20020a05683010c300b005cd481a148amr913080oto.200.1648071747457; Wed, 23 Mar
 2022 14:42:27 -0700 (PDT)
MIME-Version: 1.0
References: <1647943132-31250-1-git-send-email-baihaowen@meizu.com>
In-Reply-To: <1647943132-31250-1-git-send-email-baihaowen@meizu.com>
From:   Alex Deucher <alexdeucher@gmail.com>
Date:   Wed, 23 Mar 2022 17:42:16 -0400
Message-ID: <CADnq5_PB-SOvbJJiRGvGpeLwfYpuYHPT8_0HRW1R6WUJ8vwKiw@mail.gmail.com>
Subject: Re: [PATCH] drm/amd/display: use NULL instead of using plain integer
 as pointer
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     "Wentland, Harry" <harry.wentland@amd.com>,
        "Leo (Sunpeng) Li" <sunpeng.li@amd.com>,
        "Siqueira, Rodrigo" <Rodrigo.Siqueira@amd.com>,
        "Deucher, Alexander" <alexander.deucher@amd.com>,
        Christian Koenig <christian.koenig@amd.com>,
        xinhui pan <Xinhui.Pan@amd.com>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
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

Thanks for the patches.  I've already applied fixes from others for
these issues.

Alex

On Tue, Mar 22, 2022 at 9:05 AM Haowen Bai <baihaowen@meizu.com> wrote:
>
> This fixes the following sparse warnings:
> drivers/gpu/drm/amd/amdgpu/../display/dc/dml/dsc/rc_calc_fpu.c:71:40: warning: Using
> plain integer as NULL pointer
>
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> index ec636d0..ef75eb7 100644
> --- a/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> +++ b/drivers/gpu/drm/amd/display/dc/dml/dsc/rc_calc_fpu.c
> @@ -68,7 +68,7 @@ static void get_qp_set(qp_set qps, enum colour_mode cm, enum bits_per_comp bpc,
>         int sel = table_hash(mode, bpc, max_min);
>         int table_size = 0;
>         int index;
> -       const struct qp_entry *table = 0L;
> +       const struct qp_entry *table = NULL;
>
>         // alias enum
>         enum { min = DAL_MM_MIN, max = DAL_MM_MAX };
> --
> 2.7.4
>
