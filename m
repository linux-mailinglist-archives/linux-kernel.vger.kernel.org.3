Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D267548490B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 21:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232034AbiADUAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 15:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbiADUA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 15:00:29 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA8F3C061761;
        Tue,  4 Jan 2022 12:00:28 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id u13so83961110lff.12;
        Tue, 04 Jan 2022 12:00:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=acwKczvWyIUy4HDb+EQ5WSebsiTaZduWta3iesC5T2o=;
        b=of2xzanTwLPRofEdYDfJGZ7/CoMWgSS8Md5kjX7oWnUmZK+aA5FdLew+X78eRnN9U2
         CHrusCivKs1kdX4TT1kxva+bNWUSJnYQb5WmU5Iosgzgmmn2lULhUFvMD86IizF3YzH9
         RxtOH6L3gfL7hE4onLysV8trj0WeMf4665okuSeXSYsqo9E3uKq2v2HDamivsE1uQxij
         qCJBMg+RNK0xUCybM4lHnN8+NvCKmfTLB4Y+QnWv7AZwI1DW7hdhZ/qxC8lYNdwirem8
         CsAImeyoGl9XHAfnDjzTYPLN9KPpExoD53FOjIT+ZlnP1p+jKuErIlSFy4BuaqfLwVJA
         4grg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=acwKczvWyIUy4HDb+EQ5WSebsiTaZduWta3iesC5T2o=;
        b=O0QQbWoUhXR7PwcK46xB6jM5Zo8LcThBuaWR//4IhO6YEuPpCaiB7uuZnu51pbAKVJ
         j4Z5lZFC8qA53LT5s4akre4q+226Gm2xcLdUbP3B2aHz8M3mwGzGgVB/mvFCYVet2y1f
         1pLjuZNTSnP6Zo0yxMaZ8Hos0SgI2dpck6vQ6Chwd/mbmJD7T561EJkh0W/xj9FXn1bI
         myxYuVhcncngRJx0iPzcs79lAcQ4VdFn7MG2DEPs3SUd2eWpfwbaT3ssUmoOagIssbiO
         ZPAFHBxW1SWh21Y4CShNPtzPNwriAysg8tj94sQ3xQ+OPhhLcMvDiAZULxIM49B4SDxp
         +DYw==
X-Gm-Message-State: AOAM530Qk2d+jbSbf7BNOl+2Xy2TicMktRYP2Wm72FRctb7uqmtQ4RZf
        XHnkX4el3Q/anvF2u3g53in6S1VoRDU=
X-Google-Smtp-Source: ABdhPJwN9a4/n7mSeTAgjpESf7lwUlBb/mEqYITglVbNni2b2Q6VyvJuIm4OWafPWe+oNLiIkWi/Sw==
X-Received: by 2002:a05:6512:1110:: with SMTP id l16mr44192566lfg.193.1641326426901;
        Tue, 04 Jan 2022 12:00:26 -0800 (PST)
Received: from [192.168.1.103] ([178.176.72.219])
        by smtp.gmail.com with ESMTPSA id u26sm4017510lfi.62.2022.01.04.12.00.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jan 2022 12:00:26 -0800 (PST)
Subject: Re: [PATCH] gpio: rcar: Propagate errors from devm_request_irq()
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        linux-renesas-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220104153615.13393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <255da762-5402-fab3-d1a6-944dcf028743@gmail.com>
Date:   Tue, 4 Jan 2022 23:00:24 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <20220104153615.13393-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 1/4/22 6:36 PM, Lad Prabhakar wrote:

> The driver overrides the error code returned by devm_request_irq() to
> -ENOENT. Switch to propagating the error code upstream.
> 
> Suggested-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
[...]

Reviewed-by: Sergey Shtylyov <s.shtylyov@omp.ru>

MBR, Sergey
