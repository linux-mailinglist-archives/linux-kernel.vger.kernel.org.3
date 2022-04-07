Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF8464F7D23
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 12:38:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244512AbiDGKkN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 06:40:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244571AbiDGKjv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 06:39:51 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6E1919613F;
        Thu,  7 Apr 2022 03:37:51 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id i27so9898294ejd.9;
        Thu, 07 Apr 2022 03:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=S629+q8OmpzUfpI5xcIxyUuaxIHs7guC/HibFDTI34s=;
        b=XghNR0vByvtRKbEcnuM8MxYvAH3+32pXisaRKi84IjTpKV9BKN8u9mJmKtFzYwXMM5
         DYF2pfN7txHOl6VWLlVGkjddHKq2hWdFsRUIV8/jzSRm7rFbqn+VfNXVtHFwElMC9pdD
         +v7MIENHhf9fnfeeEM0Cvjzcw5mNl7/lcAej0dWXF6HLXNqcXt9PBbIfA7S4F/vOHkRu
         VpV23MyXMMB+7nVTMoD34siQXuS4HQT4PWeI3nvWCA2hsbWot+YW8h1dDtxnQp0dCmSw
         1ufBr3KWT3qYhA+OjzeKE3onJSQoUHWaGLcNp/AL+lxaFcuCUpesJbB/YED9vQ/8TvTm
         bvQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=S629+q8OmpzUfpI5xcIxyUuaxIHs7guC/HibFDTI34s=;
        b=buoqm2DGremyqLhyLWv56HJ5I8ujfl32sdjlbTOQZyYVT/HfwgM4/GxQPbC54LmMLn
         8sWyldHbQZzTFGzzYnjkh5wf/lW5uhTAHEk1XklBfG+/jE9TCwwK8P9VrWolMil23OBD
         aDcvHGYF4TrylbUCXmDbGxaY4d+Yy6rI+4AliDED3ptrBKp6KZT/wWvcCQwn+Zpg7gWF
         bY0sXNb/oKlmYNzau8QMRN9JbrJZkpF2NJ8Hq7hfLFUHcWvaBZKk96/nrdlL2tjS6jI6
         6kdKOE3hpAnxKMhmnMhDeToYGBDhqJgBktz7pFjs9P08UqY4jIIG4iooY5FFUnXdDzwz
         Phag==
X-Gm-Message-State: AOAM5305DZBSA4IaxGwfYHf9WJR1ZyN1uF2BntMF4/+1rIlLll0GJg0D
        qtqlX9pNct96s/ddsq5RlcY=
X-Google-Smtp-Source: ABdhPJy6OMMnQdMyR0O6MxEv3ovYJ6UqRsX9MIkIrFAMGakLTfIm38eCbhyJwCXJT5PYsUUYM299HA==
X-Received: by 2002:a17:906:d555:b0:6db:148e:5cc with SMTP id cr21-20020a170906d55500b006db148e05ccmr12271053ejc.63.1649327870366;
        Thu, 07 Apr 2022 03:37:50 -0700 (PDT)
Received: from giga-mm.localdomain ([195.245.23.54])
        by smtp.gmail.com with ESMTPSA id n6-20020aa7c786000000b00410d2403ccfsm9026814eds.21.2022.04.07.03.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 03:37:49 -0700 (PDT)
Message-ID: <731673954bbf9e0970f0567350f81f184e076265.camel@gmail.com>
Subject: Re: [PATCH 00/12] ARM: ARMv5 multiplatform conversions
From:   Alexander Sverdlin <alexander.sverdlin@gmail.com>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Hubert Feurstein <hubert.feurstein@contec.at>,
        Lukasz Majewski <lukma@denx.de>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Imre Kaloz <kaloz@openwrt.org>,
        Krzysztof Halasa <khalasa@piap.pl>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Simtec Linux Team <linux@simtec.co.uk>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "moderated list:ARM/SAMSUNG EXYNOS ARM ARCHITECTURES" 
        <linux-samsung-soc@vger.kernel.org>, patches@opensource.cirrus.com
Date:   Thu, 07 Apr 2022 12:37:47 +0200
In-Reply-To: <CAK8P3a22dR276SRVh5WRZWDEGQaf9KUUz61tQaCySHZrrgnh9g@mail.gmail.com>
References: <20220405091750.3076973-1-arnd@kernel.org>
         <39e8b64cefd8e2b4e4d91a5e6cfc98db88be7449.camel@gmail.com>
         <CAK8P3a22dR276SRVh5WRZWDEGQaf9KUUz61tQaCySHZrrgnh9g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Arnd!

On Thu, 2022-04-07 at 12:08 +0200, Arnd Bergmann wrote:
> Sure, both look like obvious bugfixes. Shall I apply them to the
> fixes branch for 5.18, or as part of the multiplatform series?

I'm fine with either option if they land not in the recycled bin ;)

> Either way, if you have any obvious bugfixes for code you maintain,
> and you'd like
> to get merged through the soc tree, please send them to soc@kernel.org, which
> puts them into the patchwork tracker.

Sounds great, thanks, I'll note this!

-- 
Alexander Sverdlin.

