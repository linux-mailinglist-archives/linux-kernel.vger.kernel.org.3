Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 703815B0F4F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 23:41:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230201AbiIGVlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 17:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229822AbiIGVls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 17:41:48 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2E82BBA40
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 14:41:47 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id dv25so4134495ejb.12
        for <linux-kernel@vger.kernel.org>; Wed, 07 Sep 2022 14:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=PCLOGd3/tpRK84IBMUdkn77sH30x2dlPwugZQ57tiSY=;
        b=sLORtrxy5XIxUUi59IvQUc7pmF5sVg6FnSt6DpvKPFPTClP34glCL/pc1lxIh2Vnv6
         2j6rvgnos1YAJ38LdWN14Braq0s+wMKQzorFkoyy+k518xHfdVQWlyD3GpRj6206sVdD
         ASXveAHtr4a4Ysn6IejQjs7DfqDXL2u1frbhe6BWmbagd+xKae5/H6dTS7DNRtFhL1uN
         RiXsS1MDAzx8AsioWZeN8MV6nzWXN+vRoRz3oX2qMdCCJqWxtpaiE8eTjz+xLHF5OOmZ
         Qh0h+M+/WhrE5MIHbXUL8ZRAgOoi8ayFFK8y532XD9Alfwu9ZQeTekcy7uoe/xHEmD3Y
         UXnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=PCLOGd3/tpRK84IBMUdkn77sH30x2dlPwugZQ57tiSY=;
        b=Oft+W0JPyP1Pt/8oHQasLGoSE5dnpg2zDg+lix/5WNFqxcsTIKERXnfKRyguIwA0Od
         t3i099RKjAwW3emdJKGNR5iTlK4rz2siGjjeUE4as47wTfqRw6M8eYXn6FfQxWjR6bWY
         84+VuutW8v9W2kdryLUYWJ60IynPmkbRf+Rp63K5yMkKAyJ9KDqe0ahKszZToUGjaORo
         m3Y+fpy0NRQCv+NA1e7eO3ieOpMu3UdtBKXb9UmvBILEPPw4h7u6slKiaNOGe2RvMJ2Z
         KWosMVj4dXXizEJ3Pxuy7vbtS6ozCoHv8s7+vge1UoKEy3P1aF4MWZ0KWxAH3+oqEMug
         efGg==
X-Gm-Message-State: ACgBeo3SFtUX1MKGRRo5AX2f6s2t5NiolBt1daGwnx17tvBx2tbwlICL
        uucK6uaFJAuShxKfMY+24dkLltC2gmEMh8t2T3t4vQ==
X-Google-Smtp-Source: AA6agR7OI6rEye2Uta66x4p0Obv9tGg1dCVb19GwKRTzzdYBl21/u+IZFbc7eQ5M+Otlvp6nSVQcq88FOigOatxGRTs=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr3786036ejs.190.1662586906505; Wed, 07
 Sep 2022 14:41:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220906204603.3762756-1-dmitry.torokhov@gmail.com> <20220906204603.3762756-2-dmitry.torokhov@gmail.com>
In-Reply-To: <20220906204603.3762756-2-dmitry.torokhov@gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 7 Sep 2022 23:41:35 +0200
Message-ID: <CACRpkdYpHZZ=Nq-uygwr0GDa1S0u7r1RQRRZiFArNw1t-brvkQ@mail.gmail.com>
Subject: Re: [PATCH 2/3] media: i2c: s5c73m3: remove support for platform data
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Sep 6, 2022 at 10:46 PM Dmitry Torokhov
<dmitry.torokhov@gmail.com> wrote:

> There are no existing users of s5c73m3_platform_data in the tree, and
> new users shoudl either be using device tree, ACPI, or static device
> properties, so let's remove it from the driver.
>
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
