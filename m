Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1D855C751
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:53:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241476AbiF0XHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238302AbiF0XHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:07:05 -0400
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 415E72250C
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:07:04 -0700 (PDT)
Received: by mail-ej1-x636.google.com with SMTP id mf9so22282363ejb.0
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:07:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NfqgJbSosLMARFR+8HOsCtjTWKHL8eM8i6GA2q20KXs=;
        b=Wd5XrJH4RNPdVycldHky1miBc0yZX2F5ouQ/+Uzou+henCRa8mhiUAtrVVTrKeWqtz
         cB0f2EgrQ03vfX6c6at1aja+ZGRJMx9aVOFaR18RKJoCDTISSAaM97aeRuVkmtIZ04Dc
         QV8jXjEV7g4/pfWrsW5XjA/I5vnlmbKWr+X2o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NfqgJbSosLMARFR+8HOsCtjTWKHL8eM8i6GA2q20KXs=;
        b=nx0aXR41/fQmFDS6OgmCkzQTkhSwQuAmwiivD6tE2CgWzoen4RP557DLQ1poeEBMzO
         BW0yFChqJ83DyHtX24cnTf1diDw9vtPkTJ+G+JxkhLHoDtYYmGYhQFWjDIRzdI4pMV/X
         cfF7DWx6KtWWn6Os0LRV0uZel0tCFerVD7zM9blkcNC96BpKPzOeXNE+0HJ1XqfMoR7H
         iusZwNMZYc+M1yRQfr0FPkJ9ZgTK3uhNszDWDv8fmqMCZ5wL0xqpIvVWdoFqsnuG2evc
         g14di/EdBUrPRnnMgg74b0Exr1Uc/aC9T+h6vVPBgD4+hT7YPLJ1Yi6XD0Fkkjye/dKV
         rErA==
X-Gm-Message-State: AJIora+7Lzjj3/OJKoQSW7kTHSF74IJtE/UkBqTn45U49dE3GoDbkLs4
        5/NPwZgEtaIbDbZJXKi1EeVVxSQZHMX+2SlD
X-Google-Smtp-Source: AGRyM1t3niTVYp3xvOc+rX47Vw6KBIFXGAGFMV3UcaCSm60iXsng0jcT/vgVqOOPIWkLQtebtQAgoQ==
X-Received: by 2002:a17:907:6d9e:b0:726:8f7a:7a7a with SMTP id sb30-20020a1709076d9e00b007268f7a7a7amr12154282ejc.425.1656371222474;
        Mon, 27 Jun 2022 16:07:02 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id h10-20020a50ed8a000000b00435728cd12fsm8414541edr.18.2022.06.27.16.07.01
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 16:07:01 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id q9so15080257wrd.8
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:07:01 -0700 (PDT)
X-Received: by 2002:adf:d1e9:0:b0:21b:c8f8:3c16 with SMTP id
 g9-20020adfd1e9000000b0021bc8f83c16mr8998757wrd.659.1656371221092; Mon, 27
 Jun 2022 16:07:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 16:06:49 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VQ_O2eH2+bnEegOQuBmqMhD7ixiRV3=ukuU9SnPaBSDA@mail.gmail.com>
Message-ID: <CAD=FV=VQ_O2eH2+bnEegOQuBmqMhD7ixiRV3=ukuU9SnPaBSDA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] soc: qcom: cmd-db: replace strncpy() with strscpy_pad()
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, May 19, 2022 at 12:33 AM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> The use of strncpy() is considered deprecated for NUL-terminated
> strings[1].  Replace strncpy() with strscpy_pad(), to keep existing
> pad-behavior of strncpy.  This fixes W=3D1 warning:
>
>   drivers/soc/qcom/cmd-db.c: In function =E2=80=98cmd_db_get_header.part.=
0=E2=80=99:
>   drivers/soc/qcom/cmd-db.c:151:9: warning: =E2=80=98strncpy=E2=80=99 spe=
cified bound 8 equals destination size [-Wstringop-truncation]
>     151 |         strncpy(query, id, sizeof(query));
>
> [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strncp=
y-on-nul-terminated-strings
>
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Stephen Boyd <sboyd@kernel.org>
>
> ---
>
> Changes since v1:
> 1. Split series per subsystem.
> 2. Add tag.
> ---
>  drivers/soc/qcom/cmd-db.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> index dd872017f345..c5137c25d819 100644
> --- a/drivers/soc/qcom/cmd-db.c
> +++ b/drivers/soc/qcom/cmd-db.c
> @@ -148,7 +148,7 @@ static int cmd_db_get_header(const char *id, const st=
ruct entry_header **eh,
>                 return ret;
>
>         /* Pad out query string to same length as in DB */
> -       strncpy(query, id, sizeof(query));
> +       strscpy_pad(query, id, sizeof(query));

Sorry to report that this breaks booting on
sc7280-herobrine-herobrine-r1. I believe that the function was
actually _relying_ on the "unsafe" behavior of strncpy(). Specifically
I think:
* The source string (id) was a '\0' terminated string.
* The destination (query) was a fixed 8-byte string and doesn't need
to be '\0' terminated.

So before your change we could actually support 8-byte strings. Now we
can't because you'll only copy 7 bytes to the destination to leave
room for the '\0' termination...

Looking at printouts, I see, for instance at least one ID that looks
like "lnbclka2".

Given the requirements of this function(), the old strncpy() is
actually _exactly_ what we want. Is there any way to disable the
warning? If not, I guess we could make "query" be 9 bytes bit, or
"sizeof(ent->id) + 1" bytes big... Happy to post a patch, but it's
basically a bikeshed for how you want it fixed (there are dozens of
ways) and I'd rather you just tell me instead of me guessing.

-Doug
