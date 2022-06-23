Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E053B5588E0
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 21:30:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231468AbiFWTaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 15:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231455AbiFWT3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 15:29:32 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EAE592149;
        Thu, 23 Jun 2022 12:00:21 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u12so99863eja.8;
        Thu, 23 Jun 2022 12:00:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DlD0qxEHT2yzgN07/r9hAt1+bX51O7i0+YMrDs9OqBI=;
        b=f11c4tn3nl7urOAnkHO27alkVuIcDL2eMLUTUz1bg8OraDNhiUYgNDbNM/S+SX+NXD
         oOD1clTA6J3Wdh2VpyEptUNa/6DbNdXu55pKdoPvkGPdu29vYCHb0BL5jQLkwUAZktFM
         Kk+uS9ZZsxlh2v6nZRne1NcBT9Q+DB7Ny0wUd2juLeelh697JPhi3uf6X8bzN5fSLn0t
         JcrsNNb5uh1QcU31D1WnJr/LPaLBDbvu+eAEaVGsUWXL8oWBbj+erypHxZ0BIWP+wBzD
         mq4F00+VauyqgV9b64PyqTwkl06v4YIP6rG3kPRNqmY7TcK5lpUQwXx4j4ysh2sNohP+
         l5YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DlD0qxEHT2yzgN07/r9hAt1+bX51O7i0+YMrDs9OqBI=;
        b=2OT5pMDBRgfgmYvd7BtaeAx6tWXCIodcXoM+PicjHoHUfYmD5nT44Iuny/oT8bXc9E
         9aafEpBJVCEjOZgnpn9mzdzrgwvtmkV66oea/YqD5ZmGJazucTLHS8Iw0WtXfhYPX6Tj
         HdhVThYFRYR9tFrKjJnMLvo9kkzIP0cZeoTHu+IoetyyX8a0phg86Q0IPkGXPys0ME8l
         Kttg2PerRAnEHH1FFhkFl7+UY5Az2BS1dgxDASPT6WxHAExkA3aCYsMszd6Ki6VuaR8q
         98UJGfA55Ijz9N5h7bgkjjSDNGPncyoMj3hkBGs+DjkYuxTDAPtoJUfZ5Hb9Q/1Avgz0
         UURg==
X-Gm-Message-State: AJIora/ZvvL10j8dEwITxS4+S06O5UU1Z3qzD+js9yxPRwRQcZnqnyVy
        lSiv5fdEFdf2qoCiOkj5p0gFsM3+yxkhaLlSJco=
X-Google-Smtp-Source: AGRyM1tjvJdRj1PCspbJAq1ILaoQ+ef9Zgu837d8hxEsWLP71mAQ+rAb5XvUL3ESbXicGB497dv2xjD8VYMwG4XkNMo=
X-Received: by 2002:a17:907:2d09:b0:722:f0bf:ac26 with SMTP id
 gs9-20020a1709072d0900b00722f0bfac26mr9722254ejc.77.1656010819823; Thu, 23
 Jun 2022 12:00:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
In-Reply-To: <20220623170844.2189814-1-marcus.folkesson@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 23 Jun 2022 20:59:43 +0200
Message-ID: <CAHp75VfKeGPL=T3cNCr2MWRBdOoNA3WuxhH_wSMkxsaBFjsELg@mail.gmail.com>
Subject: Re: [PATCH 01/10] iio: adc: mcp3911: correct "microchip,device-addr" property
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
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

On Thu, Jun 23, 2022 at 7:40 PM Marcus Folkesson
<marcus.folkesson@gmail.com> wrote:
>
> Go for the right property name that is documented in the bindings.

If the driver is already for a while in the kernel, I'm afraid we may
not do this, since it's part of ABI (firmware <--> OS). You can add a
new property and try it first.

-- 
With Best Regards,
Andy Shevchenko
