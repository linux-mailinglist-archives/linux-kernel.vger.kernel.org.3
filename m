Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 945D055D5E6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiF0XTW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 19:19:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243130AbiF0XSw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 19:18:52 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA19D23BFE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:18:51 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id sb34so22144226ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zgmUx8GYExZbeR6syxj1F4c0dy5754EbgcGWedOPJuE=;
        b=cQcZltqRrWwVQ4uvTKyAMU59i2lxrdkf1M9fdaGd8SM3DfB4BmCfJWKtHISrbEnkfR
         DEKbzBrTDR6OEekw9l1BCSm47ExDQG/8oMxwk/jWzy3Ur6sBqG9Csr/eUX3ed/Drb7kf
         6MeqjFtfuMOK0xEZqvIoWVFIsQuEwmh+2nYbg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zgmUx8GYExZbeR6syxj1F4c0dy5754EbgcGWedOPJuE=;
        b=guC5vrUaw4W0CSJlr+lNCFMvzv/1zVNk0dufHC4XgEpswnosApl8ghCe5WNt9K1h5Y
         kGJvJU2BrK4+6I1FcGmzDRDwQ3oQ61NVwbvNAjzcac3yJYkRZNy9mNf9aXqhnrr74XCt
         XZnMbnv0H/dSDOTmSZLb++BzckAChQIbibLNt3u61UYONzEonFpFvgHbSkUjEAOGOQi7
         UYDbO/V9khkPEI+Nv2knD9gKXWA+4u3oqb6BTGGeEU4yOEMtvXq4RCVNjprTPn4u4cWz
         ykfBZ3xtQSLk/hg7PgBxvz9M/uNBq7L9l3Yz01iB9SedOrMbLMJxxuz40q2k6fS70fjZ
         zfFw==
X-Gm-Message-State: AJIora+ZhGev2z3MqtQF4cgZi5vVtVNuWK6nyPz7jNH3aVhVZdSSOm7M
        VMUK8drvYYBHSdGjaKsrS9uZ4brCU+FmbLbm
X-Google-Smtp-Source: AGRyM1uCdvBHL8OvlpDkaP8EZasmytNcfG5oE1YmItlvBOgn/oJjciaS/I+A2lBP73dL7PgHsD/NtA==
X-Received: by 2002:a17:907:3f0a:b0:726:324c:5bc2 with SMTP id hq10-20020a1709073f0a00b00726324c5bc2mr15997650ejc.32.1656371929944;
        Mon, 27 Jun 2022 16:18:49 -0700 (PDT)
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com. [209.85.221.53])
        by smtp.gmail.com with ESMTPSA id ox6-20020a170907100600b0072629ee85ecsm5536795ejb.108.2022.06.27.16.18.48
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 16:18:49 -0700 (PDT)
Received: by mail-wr1-f53.google.com with SMTP id w17so15108030wrg.7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 16:18:48 -0700 (PDT)
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id
 c18-20020adffb12000000b0020c79b2a200mr14879025wrr.617.1656371928525; Mon, 27
 Jun 2022 16:18:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220519073301.7072-1-krzysztof.kozlowski@linaro.org> <CAD=FV=VQ_O2eH2+bnEegOQuBmqMhD7ixiRV3=ukuU9SnPaBSDA@mail.gmail.com>
In-Reply-To: <CAD=FV=VQ_O2eH2+bnEegOQuBmqMhD7ixiRV3=ukuU9SnPaBSDA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 27 Jun 2022 16:18:36 -0700
X-Gmail-Original-Message-ID: <CAD=FV=Wx_Tr6r4Yo1EZ9nKM_yCc0KgAaZcqPXmw1Jr8+TN23wg@mail.gmail.com>
Message-ID: <CAD=FV=Wx_Tr6r4Yo1EZ9nKM_yCc0KgAaZcqPXmw1Jr8+TN23wg@mail.gmail.com>
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

On Mon, Jun 27, 2022 at 4:06 PM Doug Anderson <dianders@chromium.org> wrote=
:
>
> Hi,
>
> On Thu, May 19, 2022 at 12:33 AM Krzysztof Kozlowski
> <krzysztof.kozlowski@linaro.org> wrote:
> >
> > The use of strncpy() is considered deprecated for NUL-terminated
> > strings[1].  Replace strncpy() with strscpy_pad(), to keep existing
> > pad-behavior of strncpy.  This fixes W=3D1 warning:
> >
> >   drivers/soc/qcom/cmd-db.c: In function =E2=80=98cmd_db_get_header.par=
t.0=E2=80=99:
> >   drivers/soc/qcom/cmd-db.c:151:9: warning: =E2=80=98strncpy=E2=80=99 s=
pecified bound 8 equals destination size [-Wstringop-truncation]
> >     151 |         strncpy(query, id, sizeof(query));
> >
> > [1] https://www.kernel.org/doc/html/latest/process/deprecated.html#strn=
cpy-on-nul-terminated-strings
> >
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Stephen Boyd <sboyd@kernel.org>
> >
> > ---
> >
> > Changes since v1:
> > 1. Split series per subsystem.
> > 2. Add tag.
> > ---
> >  drivers/soc/qcom/cmd-db.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/drivers/soc/qcom/cmd-db.c b/drivers/soc/qcom/cmd-db.c
> > index dd872017f345..c5137c25d819 100644
> > --- a/drivers/soc/qcom/cmd-db.c
> > +++ b/drivers/soc/qcom/cmd-db.c
> > @@ -148,7 +148,7 @@ static int cmd_db_get_header(const char *id, const =
struct entry_header **eh,
> >                 return ret;
> >
> >         /* Pad out query string to same length as in DB */
> > -       strncpy(query, id, sizeof(query));
> > +       strscpy_pad(query, id, sizeof(query));
>
> Sorry to report that this breaks booting on
> sc7280-herobrine-herobrine-r1. I believe that the function was
> actually _relying_ on the "unsafe" behavior of strncpy(). Specifically
> I think:
> * The source string (id) was a '\0' terminated string.
> * The destination (query) was a fixed 8-byte string and doesn't need
> to be '\0' terminated.
>
> So before your change we could actually support 8-byte strings. Now we
> can't because you'll only copy 7 bytes to the destination to leave
> room for the '\0' termination...
>
> Looking at printouts, I see, for instance at least one ID that looks
> like "lnbclka2".
>
> Given the requirements of this function(), the old strncpy() is
> actually _exactly_ what we want. Is there any way to disable the
> warning? If not, I guess we could make "query" be 9 bytes bit, or
> "sizeof(ent->id) + 1" bytes big... Happy to post a patch, but it's
> basically a bikeshed for how you want it fixed (there are dozens of
> ways) and I'd rather you just tell me instead of me guessing.

Actually, I followed the link on the error message and found that the
right solution is probably '__nonstring' so I've posted that. If
someone wants the bikeshed a different color I can do it a different
way.

https://lore.kernel.org/r/20220627161642.1.Ie7b480cd99e2c13319220cbc108caf2=
bcd41286b@changeid
