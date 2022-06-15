Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA19D54C80E
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Jun 2022 14:01:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347006AbiFOMBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 08:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236920AbiFOMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 08:01:07 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C034254024;
        Wed, 15 Jun 2022 05:01:04 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id y19so22754980ejq.6;
        Wed, 15 Jun 2022 05:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=orSrBMvLMEVHIfNWoTAjMFds8ahPweoQsG2LKSoHLLY=;
        b=E5R+HqK+9Xlfi8cMW3zua8ZyTL0noIfVPDXqZm4I1cU/nCvi+LZcwKri6Lf4JKEkWY
         V79QRdlfC7QCmKps+dZH4m1cHOfIhvm8mm4MB8jjJASPe936+HbYYmc/3bVn1yWYOLBV
         o4FyGrWOVUv7Q3vDPwoouQQNDmLuiccZ/ZK/FZIzkWek5QuW+ZQDjBKQZacMZzFmhLfX
         TGEfEQCjqRffsp1WbSF97v40c49Hw1pmky1hEcWWjS7QL9JPTrnBBPtr2T9aRGsuMMrY
         GG1Tu28qxet3VcV72uWck74W7Ay1H8FzxLHsSaGUfP/g1fvvgk4c3Pc9AYNG4L47CiqC
         6ROg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=orSrBMvLMEVHIfNWoTAjMFds8ahPweoQsG2LKSoHLLY=;
        b=C9b3j9s7SdLoMR789jYcsSBrOV8XMaAOueN3DNaYnPGKH7oEyvySH2rH+P8M+viFlg
         vLeENx3Lp3be0XmAxSJVLOHMnBFK9EdL8792ffgSQLXr12p67zsB2BeV95HWYfq09OAc
         b+rIcYfPuKI6HR/IeKsSg0YKi3pnqt7QnqBZ58XkE7WSml7v5hzLUKuuV1F08cApnQXp
         uLO0AQ5DHvT9qU4197Jr6Qwe81AsiaSmL2RrbU1iR3DfkcgZrk3EsPX7mYx225fvWk3b
         n9MxeeNaEB0WsZ+eR8Bswqr2pG7yCSEh3V5y1pT/dFXXHvpYFvj7slXiV7PYiGHWd+qS
         dz3g==
X-Gm-Message-State: AOAM531EKGAGB4NIP4xY8GYe00zutst4mjpMPi0OjOzm+IL1jlHf00yz
        If8og4A9v2zDtDdsDnWgh52aFP6D/dJ5D0SPj0c=
X-Google-Smtp-Source: ABdhPJy11U8MVD+ufS7tVp2iztcNq4wBlfWbsvEgm795FjdWC80VtopJpjPnE14ai6YO1MTEFQ/Vv5TyltGnD8DC2ls=
X-Received: by 2002:a17:906:c7c1:b0:711:d2e9:99d0 with SMTP id
 dc1-20020a170906c7c100b00711d2e999d0mr8560950ejb.639.1655294463351; Wed, 15
 Jun 2022 05:01:03 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1654118389.git.william.gray@linaro.org> <a2dca9435f7f1f727c696a1faa0ab9e27927f9f3.1654118389.git.william.gray@linaro.org>
 <CAHp75VepZ8P_cqnN8qJ_Wb=xM0LW3y-a22tv1otDReFSqRDFYA@mail.gmail.com> <YqnIygHDSUbV5yws@fedora>
In-Reply-To: <YqnIygHDSUbV5yws@fedora>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 15 Jun 2022 14:00:26 +0200
Message-ID: <CAHp75Vcojz1d8uGcR5CMeSFcBDCxqzDbncU2Mp-LT4iDqw_+Pw@mail.gmail.com>
Subject: Re: [PATCH 1/2] iio: adc: stx104: Implement and utilize register structures
To:     William Breathitt Gray <william.gray@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Wed, Jun 15, 2022 at 1:55 PM William Breathitt Gray
<william.gray@linaro.org> wrote:
> On Wed, Jun 15, 2022 at 11:44:54AM +0200, Andy Shevchenko wrote:
> > On Mon, Jun 6, 2022 at 4:27 PM William Breathitt Gray
> > <william.gray@linaro.org> wrote:
> > >
> > > Reduce magic numbers and improve code readability by implementing and
> > > utilizing named register data structures.
> >
> > Can we consider using regmap APIs instead?

> The regmap API may be more appropriate here. I'll investigate and see if
> I can convert this over to it.

I just realized that this driver is for the old PC104 (like?) hardware
that most likely uses IO ports, I don't remember if we have support
for IO ports in regmap (MMIO -- yes for sure).

-- 
With Best Regards,
Andy Shevchenko
