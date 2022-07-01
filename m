Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05FC2562E3E
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236438AbiGAIaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236291AbiGAIaF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:30:05 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107EA71240
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:29:54 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id i1so2068634wrb.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 01:29:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z6ULNT3zXtL+jR9dX9ryJVFmHZaHUROnfIZg7MaGIM8=;
        b=PDhtLDK+oMJB8ag8YZaDeZQbJ2+wR7L8YCEzyPRB7urkxatJH8NpS+oAsNQwTI8gxk
         jSgJsvqP79Gnjx0jND3FTapmImW93sAHTW/YS4kkuA8qtu3ri9/pZtsR1fBhjl0L8DZn
         pfBeDE8do0HfAnrjPy33S0yPzOwfUdzeTPG7sJTr3UG4tcCSB9pT5Vyaf9YAGHgTodXx
         FNlpDi3LTZuf5ZO/8vo1JPeMcWrVlPw0Xg87CdVwaUxLr1lv1+3g/CB8Klyar0h7W/li
         5/CjgRFr90jxVfU9vWJnancu13GeRNeDO8OhCOiOxDRCZ8dAtGyY1Y/SoAd/KyCVq/oD
         MTLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z6ULNT3zXtL+jR9dX9ryJVFmHZaHUROnfIZg7MaGIM8=;
        b=xVZlV3S+bosa0xW9vBnYVhPw1Sojvnikm5X6zaBiehbidJ/toN/tbILbGamrxd0YhQ
         WdQEtTNMybOxjijW0qk47ISmdFmiFT1BEZ+sYhS+UNjZDShOGNaNWZ5UjrdABouvIFrE
         ANGE9dU7UBXEMoryeyjf1VatZvavK5ddulWfpnt4frAKmObeqfoeuG3qhtJgkPiLaQE6
         aSUWTmAylVipX7vY+wXMar94eIcrt1kKNn0sUm03YFwUB0o4ERi7zzrrXnXqaCVa5LbO
         l0B6xZZEV32xtS9b2rckqjgm0Oy1hifR0aTlA97yuKgvooevEGKD0a3b3eiu3c1rm5to
         rALg==
X-Gm-Message-State: AJIora/oToI5MOzf4JFPF9GxYa9P5RAGlXE9VosaI0hg0UILnh/M3T25
        StCdZyzy5izW8A87ZHoeO6dHUg==
X-Google-Smtp-Source: AGRyM1stZC7VPm2CCUa3SRAgIUiALXV0JZLbbYbJ4yuR2mPcSmHvwSMM689NlSoteFJe+4RktBHoNg==
X-Received: by 2002:a5d:5050:0:b0:21b:a348:7c0 with SMTP id h16-20020a5d5050000000b0021ba34807c0mr12052542wrt.184.1656664193308;
        Fri, 01 Jul 2022 01:29:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:5d81:390:1737:2a33])
        by smtp.gmail.com with ESMTPSA id f18-20020adfb612000000b002185631adf0sm22494784wre.23.2022.07.01.01.29.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Jul 2022 01:29:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     NXP Linux Team <linux-imx@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Fabio Estevam <festevam@gmail.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>, Marek Vasut <marex@denx.de>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Liu Ying <victor.liu@nxp.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] drm/bridge: imx: i.MX8 bridge drivers should depend on ARCH_MXC
Date:   Fri,  1 Jul 2022 10:29:50 +0200
Message-Id: <165666417227.2909452.2369233598376215828.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <42c542b53a1c8027b23a045045fbb7b34479913d.1656072500.git.geert+renesas@glider.be>
References: <42c542b53a1c8027b23a045045fbb7b34479913d.1656072500.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Fri, 24 Jun 2022 14:10:51 +0200, Geert Uytterhoeven wrote:
> The various Freescale i.MX8 display bridges are only present on
> Freescale i.MX8 SoCs.  Hence add a dependency on ARCH_MXC, to prevent
> asking the user about these drivers when configuring a kernel without
> i.MX SoC support.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm/bridge: imx: i.MX8 bridge drivers should depend on ARCH_MXC
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=5cd561688b3e8a248fdbb37a1b10801b06736865

-- 
Neil
