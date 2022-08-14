Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6047E591F8D
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 12:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbiHNK1E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 06:27:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiHNK1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 06:27:03 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 051E52314B;
        Sun, 14 Aug 2022 03:27:02 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id r4so6346845edi.8;
        Sun, 14 Aug 2022 03:27:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=F0QRLiWNSzIQtXswU6jXQI0utW/YNhjytPAn4syeAYo=;
        b=ZJSfm9kFCx/eZhg89Rs0t3m6Fy6adkXoTliit5PQQBdOtlMcNIvsEyy8+F8a0jpwPV
         o/dWuLgA8XDB66FvEGPw8jwbfxawdxjs+PMY0VwWWT2n9OVTGgFA7C36sytkEtHURtQm
         GDsVciUaHteupndYBIofcffxzFAgoTKS9u/78I6SYN4NYUHD5z64TJvD7nLnTSvRPQgO
         +y6PhiP7eSdk7TihwV9QG72AQP6H/UeOZ26QXxVUN9iGaspbV+50bNBxdjW65Gh6AeA0
         QK5hzBSvcQ+tA6CCRDuJ9rRVNwVL9TK9aF97e1/DJci/A0DnA0TOKHmrgLLbzdhyX1+2
         8P5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=F0QRLiWNSzIQtXswU6jXQI0utW/YNhjytPAn4syeAYo=;
        b=MwMUo0SNiT3m2HqbEIj+O8RCqH1NnLgJSsGjXkmeyJ5FqbjwmLsuLf3caCnrOyyBCe
         Wt4u+vePAOVXU5SKeGQ2bgJp+mQiTeZGsOnJO3p/KBZVjxUyKQujqR9JzSvxtBeutr/N
         KFKUd2X/bg2F2yIC0ntt7hYd3MQU5y3FwQZFQ5HI9LXv0JDIJpj5fgKNBqPJzYSCID3n
         DbSq1qxcR0wo5k4glr9qvHuOwqtY4ubWLkQs+AydootlJk+olmWQaMylEuk9Qfn0gm96
         krGoe5E0Ataxd/wdgG92j0jkn+bQbjx48QccxH6InQGkv7zlS32eXIFSXkF778HdHMtT
         0Olw==
X-Gm-Message-State: ACgBeo3vY6q3c9AVQiP8IcARmWpHSc9MYExn0iRrTV3rSO8fvjsGxFfx
        Eko0d64WBJhnUMshiKSt3ys=
X-Google-Smtp-Source: AA6agR4i+V31/LTEjlSFFV72AWe8uaurlX4Rluvgz+I9IqK+DcOgFvetksqi/8H1PWhsoFDmBT5uDA==
X-Received: by 2002:aa7:de18:0:b0:43d:30e2:d22b with SMTP id h24-20020aa7de18000000b0043d30e2d22bmr10478796edv.224.1660472820604;
        Sun, 14 Aug 2022 03:27:00 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id v17-20020a17090690d100b0072aac7446easm2810028ejw.47.2022.08.14.03.26.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 03:27:00 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hans de Goede <hdegoede@redhat.com>,
        Icenowy Zheng <icenowy@aosc.io>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Ripard <mripard@kernel.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 3/9] soc: sunxi: sram: Prevent the driver from being unbound
Date:   Sun, 14 Aug 2022 12:26:59 +0200
Message-ID: <22747013.6Emhk5qWAg@jernej-laptop>
In-Reply-To: <20220801030509.21966-4-samuel@sholland.org>
References: <20220801030509.21966-1-samuel@sholland.org> <20220801030509.21966-4-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dne ponedeljek, 01. avgust 2022 ob 05:05:03 CEST je Samuel Holland napisal(a):
> This driver exports a regmap tied to the platform device (as opposed to
> a syscon, which exports a regmap tied to the OF node). Because of this,
> the driver can never be unbound, as that would destroy the regmap. Use
> builtin_platform_driver_probe() to enforce this limitation.
> 
> Fixes: 5828729bebbb ("soc: sunxi: export a regmap for EMAC clock reg on
> A64") Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej



