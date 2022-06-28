Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5A155DB53
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345910AbiF1MjP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:39:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345290AbiF1MjN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:39:13 -0400
Received: from mail-yb1-xb2c.google.com (mail-yb1-xb2c.google.com [IPv6:2607:f8b0:4864:20::b2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A27762ED49
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:39:12 -0700 (PDT)
Received: by mail-yb1-xb2c.google.com with SMTP id v185so12453285ybe.8
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 05:39:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=MTpYKqpj1Ke2nAmzrM6LJJrYdhJ2JyjS8LNVvYtovMY=;
        b=LZ4njZtM/bVQo60epTjPQUxLOP5aP70PbLAod6eYk4b+5m4+pvXIbgAw+6FM9oQXWp
         fYbFM9x4zHrfsatqy64G8NP4VYffdEpd0F3fFz4czouhH2J4zKCdHcXHuv+9REqitFIl
         ca7OMcQZj49s03y1/vdx6QPl2Q7IFvSfIvXKuqgY6g0//qEb0odvsb+fcq2xGEBRdPHa
         K8pIeoNQV0Yspl5/H3nb9n4QBna/oTSysJY3EQIP2f0cqOpRcM8nckemGnWPb8PAqcie
         BfwS1L2wRN7/1rUbgtJVwCY8tzQGGaJmaGr5Yz+M4KlMjmskNpt5BkcQEBZDeSWSgeNU
         eO/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=MTpYKqpj1Ke2nAmzrM6LJJrYdhJ2JyjS8LNVvYtovMY=;
        b=30wn1M/ozhWYU+jFB+X66k4PZ48bkknGnqawMPD8OqqXA8P3vmG6lGHWl175rJeGQs
         whnitNGbKn28tY+dRxPWC5ac+kOeXj845yPinoZA/Xgi6lWQ0FmTSf4J5CmKdQ5oZ4JP
         ZP83pWrpE0xgoDDsewnwAkJJ7ONqZjnsm1mrXnWsh2DHSyf5uH59Azz46VD6nP3N8fW6
         609IZDH7e9dLr7eYQuH14+lXUv7JWH7kqd6Kt03bnOJjz6BYXW4c7eS2QIk6Fp7fYA2F
         pUeuvvbCuowy9XW6/gS29VHzGCmCeZUGYvSagBFaJR9JyuO3OEZoF5DsBRRzcnWSbk9L
         b0RA==
X-Gm-Message-State: AJIora8sn+89HVGWJivvX8SC0HFRvYKB56vNWkfJL4sFnyqKpJlXARSz
        QWz+12PoBf5BcpCLkEZtIPjGA3BD85V5KrBoHUBVYw==
X-Google-Smtp-Source: AGRyM1vap6g56eXS4/X+EknzSt9CwmskqIiDkdBJiGLfUDZZWgN3Fs7uzox9wQbgYLZTCOLAW51Xy7ZFUvOkyb3jtBg=
X-Received: by 2002:a05:6902:152:b0:66c:e116:6a7 with SMTP id
 p18-20020a056902015200b0066ce11606a7mr9347506ybh.533.1656419951745; Tue, 28
 Jun 2022 05:39:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220620165053.74170-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220620165053.74170-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 28 Jun 2022 14:39:00 +0200
Message-ID: <CACRpkdZrCd9vAMg+MOTduAhmZ+uRq9q89Ts6o6RagdTkrrpogA@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: bcm: Convert drivers to use struct
 pingroup and PINCTRL_PINGROUP()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        =?UTF-8?B?w4FsdmFybyBGZXJuw6FuZGV6IFJvamFz?= <noltari@gmail.com>,
        Jonas Gorski <jonas.gorski@gmail.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 6:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The pin control header provides struct pingroup and PINCTRL_PINGROUP() ma=
cro.
> Utilize them instead of open coded variants in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

This looks very tasty. Can we get a test or ACK from one of the BCM
people? (=C3=81lvaro/Jonas)

Yours,
Linus Walleij
