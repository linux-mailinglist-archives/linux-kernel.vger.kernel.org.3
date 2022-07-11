Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36A90570B2D
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 22:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230088AbiGKULU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 16:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbiGKULS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 16:11:18 -0400
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F05132A72E;
        Mon, 11 Jul 2022 13:11:17 -0700 (PDT)
Received: by mail-qv1-xf33.google.com with SMTP id l11so1168182qvu.13;
        Mon, 11 Jul 2022 13:11:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=y7SHA/z8BOa8wh+UPK+wnNg27Xa7/eY8+Vpvp2gYlkk=;
        b=XjhGErLQpeUic9yY27h96GD0jf40eQ8ShJnFm1QdMvY+d69KFUrkoNCJic0i/T3uO8
         lfRPX6akik2lQGF+nhy2QSS+SD+NQ+W3x3qnUXgoOqP/zDNTVVqNJam2K7mHqXwexMet
         LCBvR6zrambhoEuABXGe6XFxlnfC5tL1PpckYPim499odDVcwrbz8FxLkf5n9SdUeqBB
         Ohg5dt7v1RQ5PQVi6vK0hvd0wYyP4EsL/t7l6OFqI1vr90UUyvMS1BkdWPgEO/RXTm9Y
         KxFrg49JUEhEWUdnsgXCFsEGEv+7AwRrfdjYBiCrjWZhM4fvFVRn8WLZoHQXTZ+DrBey
         q1fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=y7SHA/z8BOa8wh+UPK+wnNg27Xa7/eY8+Vpvp2gYlkk=;
        b=YRh1eWc+ngS8i5uoCVojCOSo1lGOE8t3BGcFTJoJAbHFQ+gyY/KmsXMY+1nlpr6nzM
         cf3oSqTijvTs0XBQMsj8psgy1ctxtn73X2m6oLdb1DfI+LZWPgeGD4KNxx62Q2zwbhCf
         OQqXOaK7KSx16bEGEORb/lZuCM24O3+woD2so1orNYhG1fawYYNkwIjTkDHvdGm2EtCh
         PqJ/fXlf8sxgsU7DT08ZLgTPhuUdNcQ8yRYKDW7Jy8EmAKIsDGY4NgPpu3mrbn5iJ1ZR
         DmAEAEh7s+cJm5+zJCf0M1+K9duz9lrdvhlROj58ORd45TOLlOXAboE5UWVOzzQZzU8b
         Pm4g==
X-Gm-Message-State: AJIora9z277aVLZyu8Fc7rCKFMPQwi53LS64c18wH1wcGymE0mIgg8ff
        IOKeP0jve0OeTVtqXhLKawptKBV7wgqK7Fsldomm0gF4FGs=
X-Google-Smtp-Source: AGRyM1uZtS85BzP3kwXmdYKyYAZ/KlQV8Yf28ztSF22Fz9gHtnceKubKIOXnsT90Qr4ubtZ6GmitYC2XvgNtmds0AGE=
X-Received: by 2002:a0c:8c89:0:b0:470:9ab6:bb27 with SMTP id
 p9-20020a0c8c89000000b004709ab6bb27mr15074994qvb.118.1657570277109; Mon, 11
 Jul 2022 13:11:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220704212402.1715182-1-robimarko@gmail.com> <20220704212402.1715182-9-robimarko@gmail.com>
 <CACRpkdaAb14TGF0atvbB8NHygsRGNCKJCf_S2gOzvvTxxDEeRA@mail.gmail.com>
In-Reply-To: <CACRpkdaAb14TGF0atvbB8NHygsRGNCKJCf_S2gOzvvTxxDEeRA@mail.gmail.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Mon, 11 Jul 2022 22:11:06 +0200
Message-ID: <CAOX2RU6xNRipZT7mFa1oCdJkMY_=R73p__zhHFzVuf7APSLEtg@mail.gmail.com>
Subject: Re: [PATCH v6 09/12] pinctrl: qcom-pmic-gpio: add support for PMP8074
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        lee.jones@linaro.org, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, jic23@kernel.org,
        lars@metafoo.de, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org
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

On Mon, 11 Jul 2022 at 13:56, Linus Walleij <linus.walleij@linaro.org> wrote:
>
> On Mon, Jul 4, 2022 at 11:24 PM Robert Marko <robimarko@gmail.com> wrote:
>
> > PMP8074 has 12 GPIO-s with holes on GPIO1 and GPIO12.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
>
> Since there are no compile-time dependencies I expect to pick
> the pinctrl-related patches separately to the pinctrl tree on next
> v7 iteration.

Great, I will send that out tonight as Mark picked the regulator
changes.

Regards,
Robert
>
> Yours,
> Linus Walleij
