Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2195856D7C6
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 10:23:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229876AbiGKIXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 04:23:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiGKIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 04:23:51 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE767DF93
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:23:50 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-31bf3656517so41120367b3.12
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 01:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kZsdMYacO8VAAHqbhjDjJSdsG7RVa3r8H1DBDt7rYZs=;
        b=eGZl7X2mQ0ei44bmsyFYCU0JVoYUM4uheb25sff9U6PlYShef312lStMtZgLoHhNnT
         H5LSalU7C4nrpb/jfemcFzK9KiVE1HBbWXXkBvcAuRGiWWXNP68IOMm7/oUM2+vZaRtr
         DGhRbcfqNGWb8qvKcKiTwUuTfS9mfZknWygtPKMAdUsuO6kaMl0cMX6PKujiv9mlms5M
         PUTuTjW8hZm6tdg/9XTeepIfrMQo7vt7NIr7GDGqwv9K90quwBQ808MGSaOlawtS759V
         UNqXGh3cJtzmnLNYB3Yj0OMd+2CXl/sZeu+QC1Qgj4n6VRjqJwAW3PN7Y0UpKo/TycT9
         lLhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kZsdMYacO8VAAHqbhjDjJSdsG7RVa3r8H1DBDt7rYZs=;
        b=JLk5hqY06G+Dw9fCt5mgSH5UIm9S1UMZNTz+wghHqq3qT5bXT7WI8GEYnqo0CzbfXV
         DxBrfcfK7LLe6wA0alScgWB5HuXVAncpmxVY/RNR+AH6h5nYoehLYqCKBpv+/SGLX0j9
         6ELrlrzjxBNK7yTAyb3oY0OzqAh5V/ab6BBFFU6bSzDXraKtVDtkxOD5r+rN1sey6qoB
         vnKQFrKOFAX5yhdhrqcSEIphj4YHSVX/9MxKVsRDhByuFe4Bh8iNrlu+49g3VaD9SljK
         ootU75WGm6OvIwXflBRd5nBscv+QshUiBNnPbxKjROpYtFvEpXUVkEAXJY6CbNj8wozI
         U+Tw==
X-Gm-Message-State: AJIora8FyGthzrncDzGD0UUMFFL7cQr80AnxPXcV7wL72D0pB88OrLQw
        lDK6Vf81jpNDWKMnQV7EFQVpTzgYNzmfthzYkexJZA==
X-Google-Smtp-Source: AGRyM1vnX925vJjegMdjucj2Quqg5yjKgiMJdV7Hx6WnNM6TVCXb+Mz53jlaeDVDBT5Vc/FQ/70QPkmIRjrM6WjGHrE=
X-Received: by 2002:a81:5b88:0:b0:31c:a228:ece1 with SMTP id
 p130-20020a815b88000000b0031ca228ece1mr18981028ywb.140.1657527830232; Mon, 11
 Jul 2022 01:23:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220627085333.1774396-1-emil.renner.berthing@canonical.com>
In-Reply-To: <20220627085333.1774396-1-emil.renner.berthing@canonical.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 11 Jul 2022 10:23:39 +0200
Message-ID: <CACRpkdYY+sjCntR-s0BZAk_WfZ67cHwnE7titmNnRTZGDn127g@mail.gmail.com>
Subject: Re: [PATCH] pinctrl: starfive: Serialize adding groups and functions
To:     Emil Renner Berthing <emil.renner.berthing@canonical.com>
Cc:     linux-gpio@vger.kernel.org,
        Jianlong Huang <jianlong.huang@starfivetech.com>,
        Michael Zhu <michael.zhu@starfivetech.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 10:53 AM Emil Renner Berthing
<emil.renner.berthing@canonical.com> wrote:

> From: Jianlong Huang <jianlong.huang@starfivetech.com>
>
> The pinctrl dt_node_to_map method may be called in parallel which leads
> us to call pinconf_generic_add_group and pinconf_generic_add_function
> in parallel. This is not supported though and leads to errors, so add a
> mutex to serialize these calls.
>
> Signed-off-by: Jianlong Huang <jianlong.huang@starfivetech.com>
> Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>

Patch applied! Sorry for taking so long, I think I was waiting for
maintainer feedback that never arrived.

Yours,
Linus Walleij
