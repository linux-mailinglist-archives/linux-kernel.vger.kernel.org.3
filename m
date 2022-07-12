Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6377F5713ED
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 10:07:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232223AbiGLIHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 04:07:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230352AbiGLIG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 04:06:58 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD174DF1C;
        Tue, 12 Jul 2022 01:06:56 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id u12so12910794eja.8;
        Tue, 12 Jul 2022 01:06:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HkZSgCnQI1eO9qu6qqxTjO6amioZ3t5sm12IidirK00=;
        b=TRON5GwVaAz/wlDRFRuYTy1ceA1h+VnEpmI8OKRF939thQ4wo0wIoakbTof4BSipKu
         nO0qd+Xz6eVAafR04UlfNOGeWQjmbrsSagAhoZPDkuJlPWmOJRjHqRzfAei0VTxoxWBJ
         /ZquWtskxDRGmjjjeaptmMddauNsWOkGo8y0R/eX6kdYzoFv8Oc5Hkzd/Skhugw2efZV
         xSeel2jNMJJHuU+x4Zw2zDIcYfhPmTGh/od22K7vyVXN6DS8txsGM/Au4ytU/4grU6Wh
         jZO1Z0jv2FWrP6YtZAZ+wVQ7bzBvK6lR4YTye87Lb8Niky+gOnRG0O81oUr5lIjEvmTg
         5CkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HkZSgCnQI1eO9qu6qqxTjO6amioZ3t5sm12IidirK00=;
        b=z4R+Bx3Gi1YSc69DKBq7SX2azR4bztWCXVfWKbj3G3wJ5/R9BG0UWCv8tnYLen/7Vt
         nlmW/j8NE9315UchZcLVPB3W8iNo+ushAqZ5OINHFPZoBhtUuM0eSVrub0E+h++8cmum
         sVal/7iWgltDucMbu+8gHgt0eg/bJhjUBc94BZo2W6jdYuB8eD5mzaMpiAuF78uYWF7M
         VOhTA+hpna8VJeBscQ8fvMRa28H1bC4Xx4n3eQ5bBfDtGg8E/X3KRUnsyPqeifwCJu4t
         mX7DmI0JLxuflVqHKg76QeQF4+phXY3izhaAoykAEW3yj4EuKxMia4w1kkrf5wMmu1lb
         bcnw==
X-Gm-Message-State: AJIora+ygF7Zdw3NTZezPlbnsjojkpaT1/d4f2fOr2wL30F4jX6IW32H
        sEmldiK+46WnrA+FRWimWvAfJ8v7/xH7Nj/p/K8=
X-Google-Smtp-Source: AGRyM1uiD3cOchmZZSvROPPgfWYOHudZV6UrSIbCZkc2o5s6xeJDbEiTm4ZR8uuFgHvcmYqHezivFUlevc4qeEbxBlo=
X-Received: by 2002:a17:906:58cf:b0:722:e4e1:c174 with SMTP id
 e15-20020a17090658cf00b00722e4e1c174mr22511764ejs.85.1657613215351; Tue, 12
 Jul 2022 01:06:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220710154822.2610801-1-williamsukatube@163.com> <CACRpkdY-USEfscMOb6bPONW6xcSqhe3HU-93vJC800xJYCTkGA@mail.gmail.com>
In-Reply-To: <CACRpkdY-USEfscMOb6bPONW6xcSqhe3HU-93vJC800xJYCTkGA@mail.gmail.com>
From:   William Dean <williamsukatube@gmail.com>
Date:   Tue, 12 Jul 2022 16:06:43 +0800
Message-ID: <CAK6EE7=YZQtboueyb1zbXnAtAtCNRZRJ-69eyYp_sa9hoktCEQ@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: Add check for kcalloc
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     williamsukatube@163.com, dvorkin@tibbo.com, wellslutw@gmail.com,
        linux-arm-kernel@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hacash Robot <hacashRobot@santino.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

thx :)

Linus Walleij <linus.walleij@linaro.org> =E4=BA=8E2022=E5=B9=B47=E6=9C=8811=
=E6=97=A5=E5=91=A8=E4=B8=80 21:04=E5=86=99=E9=81=93=EF=BC=9A

>
> On Sun, Jul 10, 2022 at 5:48 PM <williamsukatube@163.com> wrote:
>
> > From: William Dean <williamsukatube@gmail.com>
> >
> > As the potential failure of the kcalloc(),
> > it should be better to check it in order to
> > avoid the dereference of the NULL pointer.
> >
> > Fixes: aa74c44be19c8 ("pinctrl: Add driver for Sunplus SP7021")
> > Reported-by: Hacash Robot <hacashRobot@santino.com>
> > Signed-off-by: William Dean <williamsukatube@gmail.com>
>
> Patch applied, tweaked the subject a bit,
>
> Yours,
> Linus Walleij
