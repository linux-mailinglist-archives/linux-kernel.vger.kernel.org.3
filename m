Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59D415A0FB3
	for <lists+linux-kernel@lfdr.de>; Thu, 25 Aug 2022 13:58:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240850AbiHYL6W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 Aug 2022 07:58:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236708AbiHYL6U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Aug 2022 07:58:20 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DAE0A50FA
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:58:19 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id u9so10068272ejy.5
        for <linux-kernel@vger.kernel.org>; Thu, 25 Aug 2022 04:58:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=iQYbswVj7iM4wqguS/ZmMUjlm9pK2PIPrAloX1Q6g7Q=;
        b=zwgg9tn6AWHOp9f3t61Mo5JEjMdDoAGp9tIBsRSHkFooCeKLD5656cagW8eyiiQPRr
         PdyfN8+30JG4SLbAWL5u3K2GuIEHT0aUx//rBU8preTL+AZaSx6dbSZZVJCmPI3iFa3M
         oKOWexPaZhk4M1IHN1cMY0COiSvfHXry04/7HM7JkKhM57BumaRpOVd+vTN5pRDcKSm6
         kj4UPVv7FRNrB14lgrVp7BP4x9IcRnWlDuaebwBokFYg4DpeMDiTI8SRU05POexROvJ6
         OSFsZZit/I2ogapEr2l7OyFOVBlXEbn5Td+CyT7u6H+4FXR7yUHhSqvAeAO5I7oQSYmm
         9kZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=iQYbswVj7iM4wqguS/ZmMUjlm9pK2PIPrAloX1Q6g7Q=;
        b=8DUQqZcECybHi/kUioxKgNuupvSjGovUUmeBygk+HfAzg7z36tBYrobsix02Kiz14G
         LQLNbhU2CYyO8ttTyKBzPQajnXX7z6DIAqy7b4jHOCHfi8Pz5MFz5OxQdcPmUOpGVS7Z
         5iIVl34FcQS6fQTH6jSTkDIAxZ0htuG/cUN/WGOi0KdFMGup5Aup3P4sOvJTA1zNkdde
         3PxJ2t41LKSasltOODvpt1WBEMoUk/hL/GBoGFjLhIIcQE++/UQLSC1mHqn2iTcFG8ET
         RKpBDOuI4DUSoAuwvLoDZLOXGRALF018p+SOvXkFJqOsyv4e7QeQmPME6EK4bl2Tuelo
         yJXw==
X-Gm-Message-State: ACgBeo0vAv/G32wDk5OhuK2GiUSPj/cTTbfHo2YNQF9q+CueckdhLrKF
        ezWL6ooLmL7u7STiQWaLn+Awp+Ou/W9xoumdkFBxRw==
X-Google-Smtp-Source: AA6agR4izDWOE+9XTU+4xXNJ0Srz/r8RJsdsvkC3QjAfuqj7oC+ch8T2Fe57i2NzQFuB5qtP5JsoeVMI2Zs9uKSjS0I=
X-Received: by 2002:a17:906:58c8:b0:6fe:91d5:18d2 with SMTP id
 e8-20020a17090658c800b006fe91d518d2mr2336619ejs.190.1661428697709; Thu, 25
 Aug 2022 04:58:17 -0700 (PDT)
MIME-Version: 1.0
References: <20220620165053.74170-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220620165053.74170-1-andriy.shevchenko@linux.intel.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 25 Aug 2022 13:58:06 +0200
Message-ID: <CACRpkdaZrQ-YY8ZSzB4XNJWqjA7Ej=y-YK-Xc1v+q0ZzAbtZ6A@mail.gmail.com>
Subject: Re: [PATCH v1 1/1] pinctrl: bcm: Convert drivers to use struct
 pingroup and PINCTRL_PINGROUP()
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 6:50 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:

> The pin control header provides struct pingroup and PINCTRL_PINGROUP() macro.
> Utilize them instead of open coded variants in the driver.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Patch applied due to non-responsive maintainers!

Thanks for fixing this up Andy.

Yours,
Linus Walleij
