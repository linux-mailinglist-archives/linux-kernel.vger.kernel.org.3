Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A573C56D2E1
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 04:11:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiGKCLX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 22:11:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229547AbiGKCLW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 22:11:22 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F38AE18356;
        Sun, 10 Jul 2022 19:11:21 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q5so3264147plr.11;
        Sun, 10 Jul 2022 19:11:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dz9Fmr8N6qhVe2M4Rtzgf5gDh4JycsFpsHAn+cejyws=;
        b=VuAEnbnfb1MGz+ES+Ya5ba4dCuL7/sfR5YmjcUwr2xMuz5vztJwVRl26rJ4vMlmtD3
         xEn2pq70DFAFZzmOZ9DvbzjfNHAWG0GcuTL9NhA7DOWPGBWYaNL2bweA6dxravkbtVlk
         ddAR+GsztLxtNO6zUpHO6Qy0TeBrBfpPq66SGMc8w4gt+Tfdl72wjgFLQ7XTPUpSlRIg
         K6osbKTTP11shv2xfZovbR9QDxGxwAml5oJvoGFugTO5Z9kma5zhiPXYtX0ZYO1ZMIe/
         cjUajsIUh8jD3wVWqHdK+2nknD9k694MBLqPvhg9MDOIqVDN5lLuvH5JFQKeNPlXpNBv
         XPoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dz9Fmr8N6qhVe2M4Rtzgf5gDh4JycsFpsHAn+cejyws=;
        b=gjfIzUWSWHMLkzVva9nhmOsnI9oCAbgm/6d/o03fjpyO8TTqgU/90PJttnM8FpYkBq
         UvL1Tor5kqL1s+LEPiYmLH56CFlZalLbmxW53pfIy3LoA/FZF4xtukUeV5U6aWW7Oi4y
         ckk5AZihhKCTwPrPn8+d4K44UzExTZEBpdZKqnv7Ig8h/zxTFqhQMgAdyZ+DD+SyOehy
         hwDfi/78tP7zV+8M9+8iyz5BuHzvIsirHbokQ5yqHCqKPVODkHju7/5r/bQTS7Ej91OK
         f8n6yvSkCTQME7xxgHN8ZPapaFX3h63WdkdFvOkvRSF8ZoxjItYyleFPgjnpVnImoUI8
         mqGQ==
X-Gm-Message-State: AJIora8Fa9c7DhImr9V/PSwGQQoFYmw7W8HQA67dfXXejzWYXD/S5Xky
        3ugYEhdsmQKaK/GMD3jpY54=
X-Google-Smtp-Source: AGRyM1uVKkRSt9XsN1ZR2mGKYBgotdTS5tGfVIQqOLbTCvO996UnOIKfaLLEPgQKEGwxzbfDdhpEHA==
X-Received: by 2002:a17:90b:3b90:b0:1ef:eb4a:fbd with SMTP id pc16-20020a17090b3b9000b001efeb4a0fbdmr15118385pjb.2.1657505481472;
        Sun, 10 Jul 2022 19:11:21 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id p23-20020a170902a41700b0016a71196150sm3372559plq.135.2022.07.10.19.11.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Jul 2022 19:11:20 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     bcm-kernel-feedback-list@broadcom.com,
        William Zhang <william.zhang@broadcom.com>,
        Linux ARM List <linux-arm-kernel@lists.infradead.org>
Cc:     anand.gore@broadcom.com, dan.beygelman@broadcom.com,
        kursad.oney@broadcom.com, joel.peshkin@broadcom.com,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RESEND PATCH 4/8] clk: bcm: bcmbca: Replace ARCH_BCM_63XX with ARCH_BCMBCA
Date:   Sun, 10 Jul 2022 19:11:18 -0700
Message-Id: <20220711021118.3289767-1-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220707065800.261269-4-william.zhang@broadcom.com>
References: <20220707065800.261269-1-william.zhang@broadcom.com> <20220707065800.261269-4-william.zhang@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  6 Jul 2022 23:57:55 -0700, William Zhang <william.zhang@broadcom.com> wrote:
> Prepare for the BCM63138 ARCH_BCM_63XX migration to ARCH_BCMBCA. Make
> CLK_BCM_63XX depending and setting default on ARCH_BCMBCA.
> 
> Signed-off-by: William Zhang <william.zhang@broadcom.com>
> ---

Applied to https://github.com/Broadcom/stblinux/commits/drivers/next, thanks!
--
Florian
