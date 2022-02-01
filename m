Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4C5E4A65AE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Feb 2022 21:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236972AbiBAUbL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 15:31:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234508AbiBAUbJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 15:31:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74515C061714;
        Tue,  1 Feb 2022 12:31:09 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id ah7so57646663ejc.4;
        Tue, 01 Feb 2022 12:31:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=871htcl5Y6GDsL/12E1mDAY6z1Cjye967VwgYm9q+Gg=;
        b=hvlVn+CVcEnV+tlmPHp78A14rGo2OGfM2X0oCX7frzFrhbwbvUT4M7Dyq3fYezi/aZ
         hQrJXfo/LL7uwEIF/G2UWjjeOSmQk9g/CX+qc/oq7KOqiZY+Q725ENqrUq8YDOD+Udia
         4XgQgOqyVWv3w/QlWp/S9Afui0CuUPZu3en+9BrEXn1+ikqrWOSFiudaFmNLcOWi9TwN
         Ka6ymt53BBUJl0zhiemfQQED/2Wy5aq+fweFEruWk0YkzJ3rQbE3CfOCfauJjhSa08QX
         smgFEHiXMSrtlRiziaW6bNwHOEOvB+lq4ak4OFt4MYzx1bkT7jqvKwNodj1jZwQADeb8
         3JIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=871htcl5Y6GDsL/12E1mDAY6z1Cjye967VwgYm9q+Gg=;
        b=d3tV/EO4W1ZS9weoIo1cTe5SkQ5A2awVu9azIoouqD4mBY+QkE4IAUoYtd2NhAvkcr
         vDnUYJ7So8VRyL2QR6nDvyxw6QmHsPT8dNNc5mEOJyP0rq9/fmGW228RMJccX8xegJpx
         3558vvP1Xh1d3iTT1BxnJt07ccz6Z4oUXPClrILTFIRt+rlInKNSwDdu9rUFZ97De8WT
         VhpPqQSzvdgeEl/qTb28/8PMCacKu6sAhhobo8NBV/7qGqJwem+mNGYthxVlYMJ6gOq6
         klHuPtLIQcdNuSGLgw822voaGuYeW+O/UIgBEvlKpZVnhgLAaOkCUH4S1+YBzbhV939+
         fN7g==
X-Gm-Message-State: AOAM530HHRFv8KQ0Lys5pEJ12ddfTBOGMAJeegg0WESvUpz5PeidC2eT
        KxBgzy9czsiIEA/R1bBIsE5/gndPJlvcQlCUpyA=
X-Google-Smtp-Source: ABdhPJxkt038fDi0CxsQYm22/dTA7Yyk8WXF4gwZgsFk7C6/L85VmkSfCoJ3PfkU6B3/uMwgE0DALb5sA11SzLIxvto=
X-Received: by 2002:a17:907:a40a:: with SMTP id sg10mr23120532ejc.44.1643747467808;
 Tue, 01 Feb 2022 12:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20220130232122.GA119248@adroid>
In-Reply-To: <20220130232122.GA119248@adroid>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 1 Feb 2022 22:29:32 +0200
Message-ID: <CAHp75VdAo9BzQ+PnH5v1P2GZTjbYPqiEhp+j6H5+fbX+2o=76g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: samsung: improve wake irq info on console
To:     =?UTF-8?Q?Martin_J=C3=BCcker?= <martin.juecker@gmail.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        Linux Samsung SOC <linux-samsung-soc@vger.kernel.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 1, 2022 at 5:11 PM Martin J=C3=BCcker <martin.juecker@gmail.com=
> wrote:
>
> Improve the wake irq message by also printing the bank name and hwirq
> number that matches this irq number.

Perhaps wait a bit and replace the first argument with str_enabled_disabled=
()?

--=20
With Best Regards,
Andy Shevchenko
