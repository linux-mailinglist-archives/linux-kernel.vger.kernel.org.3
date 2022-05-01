Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFFC85168A6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 00:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376452AbiEAWVX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 18:21:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233440AbiEAWVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 18:21:20 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB1F132EEE
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 15:17:53 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-2ef5380669cso131947407b3.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 15:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OHcKmkE+rIAXkTOBZuHPiqnK2tVvFIoTFEKDFyD7/SU=;
        b=kD90+egFQ41q4Grt9jpl9Yb96LmgMblclHBm5QtyjHtRizdXUMQGZRicq8wIF5s6Ni
         g60VjNbA7XU1BBBEt7z8LA6wyuwnBmO2TOgZXHmInILQnzqIRI5VenTJnAju1eA3ch//
         aont5JFKke5phrmlE7yVQ4UdpHZvfiSby19U2qImtKk7VwGQu7+nZ0iBAuuKdFglZ2TM
         krsR0XK8bSvzzEcrjpITieMD/iBYOltZYrwa+zqs0izt4Y9h4COruBdLcfsfgFHK01Lm
         7clrfcYLo0rF1saBj4eA9pgZWKLqdzOhayJGP53XTiMZjnWwOBGOMPFWxvtX26XI4amQ
         QI6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OHcKmkE+rIAXkTOBZuHPiqnK2tVvFIoTFEKDFyD7/SU=;
        b=ApM7JYdW50rZc9LYgbjHlvze+Rq/EUBYPvqATt2B72lbrJ3gBu0v1i/wFTeRK2Ag+Y
         pfuLIKbwnVB8jfDeCQ/vfuuZi0NPnmvK7lKAK9u/EhznNoWCrugFfdLKriTBut42g1aT
         t1XEsK+m/3QUW5xQz34oxLIcSlcWA4MJEkyuECQZZ7QYF2+Of9XAFp9Q4v2yD0F9Lbbg
         uI5OWLATguPg4OivI5JOQ0AyYnGAKI90RDCSmHVyzpXgjYv/t2MO9nsUPTQeJQzmX0Ws
         5digRC6kkKaeZWWGdVcq+sTcKAHkRqcxui3+Ak5H8Vpqxcmi37xXlrJDzOg5Q1j42kPu
         Viag==
X-Gm-Message-State: AOAM530J6yk5aGpbcB/HfpFtdicuWVnTlR7S6PzV+TFtxcPdk1ehrkmp
        EOyx8dkAJqPHxESQY95m+gS6mfTt8Bh8rfWno/37ig==
X-Google-Smtp-Source: ABdhPJx9yHFXOUj3OgG6zsxo57KNcUwrld4ZVpMPiyqztVBS//vWoDNxleb6BAIjQuCLW3dFcnsPF3VBG41OR2joa6c=
X-Received: by 2002:a0d:ddc6:0:b0:2f8:a506:a5c0 with SMTP id
 g189-20020a0dddc6000000b002f8a506a5c0mr9644644ywe.140.1651443472960; Sun, 01
 May 2022 15:17:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220427144620.9105-1-pmalgujar@marvell.com> <20220427144620.9105-6-pmalgujar@marvell.com>
In-Reply-To: <20220427144620.9105-6-pmalgujar@marvell.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 2 May 2022 00:17:41 +0200
Message-ID: <CACRpkdb367uMwRTgE2rMyfRYzKuJjzOyrPFHT7CSqiYCSVSCaA@mail.gmail.com>
Subject: Re: [PATCH 5/5] gpio: thunderx: change handler for level interrupt
To:     Piyush Malgujar <pmalgujar@marvell.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rric@kernel.org,
        cchavva@marvell.com, wsadowski@marvell.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 4:47 PM Piyush Malgujar <pmalgujar@marvell.com> wrote:

> The current level interrupt handler is masking the GPIO interrupt
> and not unmasking it, to resolve that, handle_level_irq is used.
>
> Signed-off-by: Witold Sadowski <wsadowski@marvell.com>
> Signed-off-by: Piyush Malgujar <pmalgujar@marvell.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
