Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8CC30577F01
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234289AbiGRJvf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:51:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiGRJva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:51:30 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC791AD8D
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:51:28 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31cf1adbf92so101133207b3.4
        for <linux-kernel@vger.kernel.org>; Mon, 18 Jul 2022 02:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=M2I1pV2sf/JUqVpweWJo62P/1i0gSiIp5oWBjWp8nSA=;
        b=VAdwyum2hOxxRktnZsEA5+p2O+7iNmpqU/GL3hqBFgrGxVwE7yJKFyoaukFIJrzqFR
         RxnoXCt+IYceVU8pDGd6l3Ko6tY3zqRADfWG+9NCj7Jfz0KEvzx6Ifd0hXlK8H0JLAcZ
         xa3Jh5o70hLUS8bsNuQbGCQLgGRIQ5ejB/GxaL+w+EAO5bnKNBgmtjb5V4NMewye+cot
         9wva9denq4VDljP4pAhxa+i5PFShKRMN7DYFA6fNvcTzjZ1PwKoWy/AlDSe+f0zcBj9U
         xkBfiFeqo0dLiFtKDgs7Nqb0/K1vyOsE/blH5fHxqfuQFISe9QnabKPTzzF8oOtbkkop
         EFow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=M2I1pV2sf/JUqVpweWJo62P/1i0gSiIp5oWBjWp8nSA=;
        b=Df87ofQZa7+Sw859QtWs7U5cgtVDCqV7ZXKTXiA9PP+OqSONTVfCAqeGaV7i6a1pki
         zc1T+f4/3L5q9qcMh5BFNnrg5XpsFweTP+bRcwyWH9Sge2cuYAs+q0ZdCEdMo4Afb525
         p6IF88XVVrJDo9Ml7zvT1j9QMAL0rBXaAbuJeUf8lAbz7a3S4YxnNXfHFNaX3p88l4nL
         CeTjVHHhtl90yFhwPmW6GJtQkJg8VFAUVjFbs6srcX5OxTHLJRPAb39+/FCyIl5Kxg5T
         ZvQBG5m4xzx0k1cvQpAH7w3cJzbKaBrRck66IVSt6vOWPCv8hzgHHdg381vWSU8tEeYG
         /tqw==
X-Gm-Message-State: AJIora8r0gNraZDbGEmjMRDjMADNeUszUBQWKV51Cj7AXKNkz8c8PtGp
        PGv1tvxv7GdK2wRoyLBpZMTm0F64tqp07tncmI5ytQ==
X-Google-Smtp-Source: AGRyM1tfVn+JAC2MQr4dXxWt6ef/fkIZilU3quKxyr9s6kkXm8v6LDRT99L/0WLdmE0wv1KUEY1Un+YTA2/Gmcd1nQA=
X-Received: by 2002:a0d:d997:0:b0:31d:669c:5bd7 with SMTP id
 b145-20020a0dd997000000b0031d669c5bd7mr29367588ywe.340.1658137888026; Mon, 18
 Jul 2022 02:51:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220711203408.2949888-1-robimarko@gmail.com> <20220711203408.2949888-3-robimarko@gmail.com>
 <CACRpkdbLKXrVu9q3m1BRfRMT5q4gtrtuSNw0PmTsZBraeytVFw@mail.gmail.com> <CAOX2RU6uRbkU3VCZRuNQewndEGiJweRbr0PehARyHGjhq6-5FA@mail.gmail.com>
In-Reply-To: <CAOX2RU6uRbkU3VCZRuNQewndEGiJweRbr0PehARyHGjhq6-5FA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 18 Jul 2022 11:51:16 +0200
Message-ID: <CACRpkdYTdVeFGF5_eKuHK8J1433o8cEEHSzqYevd9kGohraanw@mail.gmail.com>
Subject: Re: [PATCH v7 3/7] dt-bindings: pinctrl: qcom,pmic-gpio: add PMP8074
To:     Robert Marko <robimarko@gmail.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        lee.jones@linaro.org, Rob Herring <robh+dt@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org, jic23@kernel.org,
        lars@metafoo.de, linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-gpio@vger.kernel.org, linux-iio@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 10:25 AM Robert Marko <robimarko@gmail.com> wrote:
> On Tue, 12 Jul 2022 at 10:39, Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Mon, Jul 11, 2022 at 10:34 PM Robert Marko <robimarko@gmail.com> wrote:
> >
> > > Document the compatible for PMP8074 which has 12 GPIO-s with holes at
> > > GPIO1 and GPIO12.
> > >
> > > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >
> > Patch applied to the pinctrl tree.
>
> Hi Linus,
> Dont want to bother you, but I am not seeing this and the GPIO patch
> in the pinctrl tree.

It was stuck in test loops.

I will push it out soon.

Yours,
Linus Walleij
