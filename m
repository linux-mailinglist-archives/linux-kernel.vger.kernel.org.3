Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE2E5A2316
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 10:34:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343654AbiHZIe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 04:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236513AbiHZIe0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 04:34:26 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92506D570A
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:34:24 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id u9so1825562ejy.5
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 01:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9QhGhU7lLaKiaQPCd/qzmAwGekbNhgokI2CAGqEql24=;
        b=j6x0VinB+t/bMuC0562EM3Mg4KSP4y6TTwznnfjuwx5LGjdcf3MT2dzII1Jic0wCUJ
         tiN0bEvcykhJJaHHJc3y+6qz44aex00kTkVN90GXx9+y0933m2tF7hlLgdw2sLOu1u7C
         uBjD3936HOyq6PmM/TTkLoBv4GnnW0as2Gig2IAM/T97jXdBnIzmvkHicumyV/IsM99P
         63AThoflxqIgsFuFvohTjvze3/PIH5rp8m7Hw7jOvy6W3QVbtXFOcNxzML5QYCrZt6K7
         Lg8lyfX4emBZlmKw8xeQhAzgzvUCU26bwPzRgd5z54gSFctoggePLHrKxGG5/2wqPj1L
         /oMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9QhGhU7lLaKiaQPCd/qzmAwGekbNhgokI2CAGqEql24=;
        b=zixi8GS6HEVfeGUkfNlyIRBAqhUsrp+FC8P+NzuRONkuowilUgkIF8v4DdCaS2850N
         X0vTPt26g0FkqkG8fn3aJlaMzk9adNMToqUMcGXSwAKgytGKijFK0YxVV5o+Hlmggb/7
         yzH65sD1r8MONYHeyej+C5Wr5+TbXMiPrQmN5CNRybndxKZZfWGZVe951W/iCnUb2ZHL
         s1xzVq3F/u7tUdhIA5YTnod2/ubMpdYZCtxAdos6VAcflqn1vJ26eMApb1WH6o20iaLe
         bMhYcYvNiBDvKcP2CH/f6DBZ1Q/0t/zBWBdToYkU+qXGAjBa+po6ncz9qihFhbS5W0nW
         dJKw==
X-Gm-Message-State: ACgBeo228AN8qcw3+Tfs+wmPwVM/+LAPFy9eE58MgTo0UJamq57u3hhE
        ejadMZv3iQCqVwFr0oalZdvBeFD70zDnZ02a8UirfBvh9Cw=
X-Google-Smtp-Source: AA6agR5J9DdrNpaN6NzDZ+VcVLr0lD3L32evHEFw7CSaww09ZXKZcU7WpfG1k+TrpICQX0pH/5pOqL73uDUF8mk1+Uk=
X-Received: by 2002:a17:906:974f:b0:73d:716a:7d98 with SMTP id
 o15-20020a170906974f00b0073d716a7d98mr4859681ejy.208.1661502862503; Fri, 26
 Aug 2022 01:34:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220822232046.1230-1-afd@ti.com> <20220822232046.1230-2-afd@ti.com>
In-Reply-To: <20220822232046.1230-2-afd@ti.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 26 Aug 2022 10:34:11 +0200
Message-ID: <CACRpkdaJvxYx4CT0fARDg7NWYf=eDwzkafqB+UUbMzYk+nOjNg@mail.gmail.com>
Subject: Re: [PATCH 1/2] ARM: nspire: Use syscon-reboot to handle restart
To:     Andrew Davis <afd@ti.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
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

On Tue, Aug 23, 2022 at 1:20 AM Andrew Davis <afd@ti.com> wrote:

> Writing this bit can be handled by the syscon-reboot driver. Add the
> info to DT and remove the machine_desc version.
>
> Signed-off-by: Andrew Davis <afd@ti.com>

Excellent reuse
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours
Linus Walleij
