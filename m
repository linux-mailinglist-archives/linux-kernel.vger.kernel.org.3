Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D285228EF
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 03:26:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240337AbiEKB0p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 21:26:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238569AbiEKB0j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 21:26:39 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAA686FD00;
        Tue, 10 May 2022 18:26:37 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id i27so1074958ejd.9;
        Tue, 10 May 2022 18:26:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bRbUgRTaSaGKFWOQVW0vsPy+my+VkFAnyFE5K6q7L9M=;
        b=qhyR8P53avM7dqw0RfzKOnZGncdneWha7XFdoMznIeUAqy1T8E3ckkbnYsVgq5Sd+8
         NKSqqzlLMedZ/ub9Dv+oUWfz+X9M6TikmUvhqrFYZdoY6WuMacjhdqGw0H5tCyuyJtmI
         WbiRGrmCZqFjSg+0swBR0xzI+xbbNVf2PPKn68hxD9yalmWVBam9AfTFcoKTj3DAnDb4
         HJkFdrAZAS0edWDdl5FyteiJ9GEzpfwR8bmURf43vXsoQ5wepFu/h98uRb1Qgv7j/M7S
         j7wwbbZNGoHEuB/7EfR/6TXFOUyrzCCNsg1cTf5IGSruAF757k3gjr2U9932Tdd6slri
         MruQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bRbUgRTaSaGKFWOQVW0vsPy+my+VkFAnyFE5K6q7L9M=;
        b=zVNP90XOTHigLJ0W2wNT0hmnLxxO/5F6XgqKHZlQ4X0KnA5lgaQGZ4Tyxa2ZARS3GQ
         n23FYuN1GfnSz/KxB/VndCs+KFRtZHyHrWxTbwpeka0I+2W3HFJ1qsiyTbCYq+VdboM/
         TC5BYB9EPkoGpMiYQRGKuEY5U5N1wHicVd0MZIOP0clvbZlCTW0UQYU/7v2Hia3jyUXR
         bpVpM00D2W5eKmU+3ZeFpWvk3o5f/wEqQld8yZOyIZSINSbbICKIOqAQepIhAM58jvIm
         AJk4s6Yz79x33LyHmxSLqlCwj+wU4C6IzlfqUH8+/p2qdQI/wKOnF/LXCJU46Kgz6dUN
         ObIA==
X-Gm-Message-State: AOAM532ODFoiLzjLoKuBzJOOwlVfXE//8cLzIHn24OC6a1txDUFgNh3A
        KEDYvx686BkGsZiG37am4PD4t02vnYtwvypc10M1r++hLas=
X-Google-Smtp-Source: ABdhPJzGF0MlZtd+4qPm8c00mpqbAg80KAzF9urrIpJUUz5MriRD5cxJF5uvWXYBkvG8VM2ceU378E1aIuzhDzE/YP0=
X-Received: by 2002:a17:906:c14b:b0:6f8:e6bb:f8d5 with SMTP id
 dp11-20020a170906c14b00b006f8e6bbf8d5mr15304336ejc.4.1652232396394; Tue, 10
 May 2022 18:26:36 -0700 (PDT)
MIME-Version: 1.0
References: <20220509111126.7032-1-max.oss.09@gmail.com> <20220509111126.7032-3-max.oss.09@gmail.com>
In-Reply-To: <20220509111126.7032-3-max.oss.09@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 10 May 2022 22:26:24 -0300
Message-ID: <CAOMZO5AGLnf8-c3Birfs8nONMCOX9ZX2dwzfpnH+EseWyVVSpg@mail.gmail.com>
Subject: Re: [PATCH v1 2/3] ARM: dts: imx6qdl-colibri: Mux mclk for sgtl5000
 with the codec node
To:     Max Krummenacher <max.oss.09@gmail.com>
Cc:     Max Krummenacher <max.krummenacher@toradex.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

On Mon, May 9, 2022 at 8:12 AM Max Krummenacher <max.oss.09@gmail.com> wrote:
>
> From: Max Krummenacher <max.krummenacher@toradex.com>
>
> Move the pin muxing for MCLK used by the codec to the codec node
> instead of placing it inside the audmux pinctrl group.
>
> While no negative effects have been observed this should make sure that
> MCLK is provided when the codec driver is probed.
>
> Follows commit fa51e1dc4b91 ("ARM: dts: imx6qdl-apalis: Fix sgtl5000
> detection issue")
>
> Signed-off-by: Max Krummenacher <max.krummenacher@toradex.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
