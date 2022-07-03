Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8145C564956
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:39:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiGCSjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229794AbiGCSjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:39:42 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4ED9A2DE4;
        Sun,  3 Jul 2022 11:39:41 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id c143so4662956ybf.3;
        Sun, 03 Jul 2022 11:39:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5DVzDDMeIoa4xyzY/DW7k8LXANM8ZaNyYc69eLGHeFg=;
        b=l+DDU0LZH8WGQTO6pD9bNCgr4uLF+eY5UdKiq8eX2SBZNJHWMgdQlNzAqhTuSA6wkV
         q9+LyRaZyRLI0FP2MdSh+kJ+6duv3jKG8hDHA/Q3yGw/BWNFpwYas+Ac7OX6hknCzhav
         0avsAcxjDB3GWeOiXvURteEb13j0fJUIbKG4CLZmYL1ZFHOa+86FXhtHVFNc3dUDccjg
         dCf3SwJhuoTLB8VX6c8fJktmD6odf80W+iyXpXuWpEraLmS19eTRFBNGYtZWCsU70e7P
         ijinwoXmdAEwwAiOyIRUSZPYNa01VPtrO1udnxFHZFFsPZXFWuxSctrkC/Do5AvpiPXk
         55Sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5DVzDDMeIoa4xyzY/DW7k8LXANM8ZaNyYc69eLGHeFg=;
        b=AfKSiHj3CgbtM/v0fdXCXKaNHqaKovPca2FLF+XcyoGB03NEhrk1AAnp35wlbv5ewk
         yw4C53yh+ajhVM4/+1RgagfgCUrAbEZASzvxOW/QezFtwLVAvsqzQYLzMTlj0sDW7wBS
         bzZCntCJSRQrOw//CeQ6PzbEmDqMCLZg6PFfiPj/4v3ir93U4UDAuFKUpei1iRjhZ9c7
         8qjH7U0bY3fAXZH1/XXmg3lOy6NFYJfVgoQewmuza4jrdIC3ejI2VvCSpoOXUOqtwFju
         TUDE1qbYdaxtoTWXERNihfb9eq6DT84pC1GJeZVvp6GbEWyliqHu7eGVkth409sHbgOo
         C62A==
X-Gm-Message-State: AJIora9Y6TovLQnOaKJmyjntXfQKVOYrWrTZUae/6FM+KaKVnFNNN0Bw
        NkddesjqQ5lsBVdQzJCRm8U07wemMiZpieQUHIk=
X-Google-Smtp-Source: AGRyM1tf2ujv1P42O/7wA8ZPhLFRPqwPYmN+ZPq8B2MFR9A64a7c9ulfkNc1A9KhBA0V+YAI74eIXpqN/uWFTaEsDXQ=
X-Received: by 2002:a05:6902:10c9:b0:668:e27c:8f7 with SMTP id
 w9-20020a05690210c900b00668e27c08f7mr26878837ybu.128.1656873580503; Sun, 03
 Jul 2022 11:39:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-8-LinoSanfilippo@gmx.de>
In-Reply-To: <20220703170039.2058202-8-LinoSanfilippo@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 20:39:04 +0200
Message-ID: <CAHp75VfTYv51ZcBJHR3Ms9HQWjPccigrjUxHUq4NixKXdvm5Ew@mail.gmail.com>
Subject: Re: [PATCH v2 7/9] serial: ar933x: Fix check for RS485 support
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
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

On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
>
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> Without an RTS GPIO RS485 is not possible so disable the support
> regardless of whether RS485 is enabled at boottime or not. Also remove the

boot time

> now superfluous check for the RTS GPIO in ar933x_config_rs485().
>
> Fixes: e849145e1fdd ("serial: ar933x: Fill in rs485_supported")

Is it an independent fix? If so, it should be the first patch in the
series, otherwise if it's dependent on something from previous patches
you need to mark all of them as a fix.

-- 
With Best Regards,
Andy Shevchenko
