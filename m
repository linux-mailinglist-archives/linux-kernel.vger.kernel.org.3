Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4B95810AE
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 12:03:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232901AbiGZKD3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 06:03:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231492AbiGZKDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 06:03:23 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 442153121F;
        Tue, 26 Jul 2022 03:03:22 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id f15so8659120edc.4;
        Tue, 26 Jul 2022 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=LKwGqmUj96Eif8vyV8hd+gwU8OsUdDwQ9Yl4J8uKbgU=;
        b=GGeBqLGdauVLqo0xDLvelQVIgDx/FWxKblVC5Dp81n+qksny1mgA7wi3JQcuD4aZUw
         +6947jo4tn2swwREiz1qUk6W8U91/zqi4TY6BKs/21ZwT1yp5fx1cdqcuHV2i/rANKk9
         Tf6mKFfxA/Yt459rDb3aXLMCf/ho7al4PKxXb4npTq8twNZWm9RlvhyGNMcD2VXE9c4a
         c/NQSWhzW4rwxfscm92Hah6O+J3fcrLPDKY3C87gubm5o9cnBM78Lfa1csifMj5UFwBa
         RcosCuJkOANlWK8YZmkFphcBxPXFqJvYJOTAXAIi0YzWUss2iTYZMo0OVcmrwx4gQKVo
         DVrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=LKwGqmUj96Eif8vyV8hd+gwU8OsUdDwQ9Yl4J8uKbgU=;
        b=y1crJJwc4msKuVWegI1WmH0EY86Xp8eIAG4qJlaJGbiHcNHvHtIZGPKK3KiTxr9Wix
         Xa3WshqUxca8cbZZ9sddKNaE8AKmg5eAthR/1QKFG1p1BGeEPQJ5avDMC9YTmTyk/xKY
         PFsrHhhb6Pvh9KaOq61/LQOeNNXy116Wb03qVsTHrqhJxlevbXS85lf6Fa+eed1/Y67K
         VrAkwkjONNee71dtf27Q+6GmAWYIll9ryNh1b4XBw3sDRWqeAe3pFy8LJbkdbQlGulh6
         K0Pm+jMFBbbHfxEXyfu10T0Xd+yQSEPjTCvWPPoN+Pb49Tb3nRjafiUARkgNkBJIVV/t
         1d/w==
X-Gm-Message-State: AJIora/xHwmwRdsorK1LZIoM8TDeDkbRCpbGZoyM+n0jXs2l+mHhbvLF
        dPND5l3vKHwt6hC4kZCpZS9vZdrDHT/hBbuFPYo=
X-Google-Smtp-Source: AGRyM1uPysQNOXR4mPuYD+VMBkxc1fR87sWcUT6/GvstLWYn2XNZYtr3aZvs10BDVK13Ig+fb+aHlzs6vxLFmNmqOa4=
X-Received: by 2002:a05:6402:d05:b0:425:b7ab:776e with SMTP id
 eb5-20020a0564020d0500b00425b7ab776emr18093826edb.142.1658829800622; Tue, 26
 Jul 2022 03:03:20 -0700 (PDT)
MIME-Version: 1.0
References: <1657780937-20891-1-git-send-email-u0084500@gmail.com>
 <CADiBU39x98iyO_OB2sYdAUGUOW9pV4dt+mEdfquhuJVm1HDRHA@mail.gmail.com> <ada44af6-2a5e-0b1c-8c46-3dbaae9b1a94@linaro.org>
In-Reply-To: <ada44af6-2a5e-0b1c-8c46-3dbaae9b1a94@linaro.org>
From:   ChiYuan Huang <u0084500@gmail.com>
Date:   Tue, 26 Jul 2022 18:03:09 +0800
Message-ID: <CADiBU3-juJZoeGccjPGCsJJ=B7Sez=MhtiiFADCuCCGc7fLrxQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/3] Add Richtek RT5120 PMIC support
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        cy_huang <cy_huang@richtek.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        linux-input@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> =E6=96=BC 2022=E5=B9=
=B47=E6=9C=8826=E6=97=A5 =E9=80=B1=E4=BA=8C =E4=B8=8B=E5=8D=885:59=E5=AF=AB=
=E9=81=93=EF=BC=9A
>
> On 26/07/2022 05:45, ChiYuan Huang wrote:
> > cy_huang <u0084500@gmail.com> =E6=96=BC 2022=E5=B9=B47=E6=9C=8814=E6=97=
=A5 =E9=80=B1=E5=9B=9B =E4=B8=8B=E5=8D=882:42=E5=AF=AB=E9=81=93=EF=BC=9A
> >>
> >> From: ChiYuan Huang <cy_huang@richtek.com>
> >>
> >> This patch series is to add Richtek RT5120 PMIC support.
> >> In RT5120, it integrates four channels of buck converter, one channel =
of LDO,
> >> and one external enable channel to control the external power source.
> > ping ......
>
> Whom are you pinging? Everyone in To list?
>
Sorry, forget to specify the part.
I'm pining the 'mfd' patch and 'power key' patch.

> Best regards,
> Krzysztof
