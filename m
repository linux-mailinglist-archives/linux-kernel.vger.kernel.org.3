Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB99154B4FC
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 17:46:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237867AbiFNPqB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 11:46:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234683AbiFNPp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 11:45:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A4DC40E4C
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:45:58 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so17950174ejj.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 08:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YSB5MTfStk1UspqZc+McpHC5WrZMD/bRWtNH57v7Pi8=;
        b=GMGDlORopVsfXCvr45KKTAZgyKiLinGmJP2++AkxuZWakX4DhNgvG1i9J6wUmCLEPZ
         pYjhhb9/n4/K3dV/LoJnfWi9Ev4QLvBEo7GBmQXWaFn43GMCGHMs6mKdDc0WvOB57thE
         b139b7GZPQW7DIQOit2W89RVb31QoAfooMGSzC2/2tk7cSUIDZEcslP5o0l3UOST1PsR
         BeBVPXDeRp2qRvNa6zAP/fGVSeEUtNg4fdJq+EOqkumXhoz5mnZBtpmE6+ZWbQC4uJRl
         TeKxjnN/Pi919oQPJn3jG6iIWR+9dEp75pCEWqlKNZYTznlUO+SPXT0a4OinMDQaE5NI
         Ex1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YSB5MTfStk1UspqZc+McpHC5WrZMD/bRWtNH57v7Pi8=;
        b=YSxhjFr8m6361z0aUmljo2qGhLNbn2+3YYY5TVwM/La8vhKrxwCKhjOLewxywwNUt4
         0hIbFdvcp3AvfAUTdqVkx3yYezcYqDJRDrsIlkNrclrr6dFEl1yaXmehu9ajFt2RrMx0
         LG99JGH3Jq3Bb5e2rE1bfEkwhAhCJAobXbX8/VBAiw0HKc1Azqv0vl+R04hbJvxBjUSt
         e2PFBS5jkyeeohkSiuucyqf6xG8orzs/dWraVm4Vank18KV8C4GKNoUE1BCBGrYr5BKg
         GQvk6y4wwIZL6CapW4xdb7u/7w6IA5qNn1uhvWP96oTyXLiVl5ADc4KqExqa7BAKoSuk
         4nnw==
X-Gm-Message-State: AJIora/mVTcQjT3Msi/cYEVDxbe3EKyxN8Tb7VZjeCadVTawf+BYd8M3
        AU7YrTr4pYgeS8CMd8BehZFCcQbMsuOjpA==
X-Google-Smtp-Source: AGRyM1t6j6k1HmO4uYue7LESoFEcMf8JICSTSvZZkVWPlcUQUTc9Bxqf6cAzusx7gQvkL9WUcNPxOw==
X-Received: by 2002:a17:907:9496:b0:711:f459:664 with SMTP id dm22-20020a170907949600b00711f4590664mr4815819ejc.704.1655221557066;
        Tue, 14 Jun 2022 08:45:57 -0700 (PDT)
Received: from kista.localnet (213-161-3-76.dynamic.telemach.net. [213.161.3.76])
        by smtp.gmail.com with ESMTPSA id da26-20020a056402177a00b004315050d7dfsm7271922edb.81.2022.06.14.08.45.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 08:45:56 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Maxime Ripard <mripard@kernel.org>, Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        "H. Nikolaus Schaller" <hns@goldelico.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Paul Cercueil <paul@crapouillou.net>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH] drm/sun4i: dw-hdmi: Fix ddc-en GPIO consumer conflict
Date:   Tue, 14 Jun 2022 17:45:55 +0200
Message-ID: <8075386.T7Z3S40VBb@kista>
In-Reply-To: <20220614073100.11550-1-samuel@sholland.org>
References: <20220614073100.11550-1-samuel@sholland.org>
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

Dne torek, 14. junij 2022 ob 09:31:00 CEST je Samuel Holland napisal(a):
> commit 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio
> support") added a consumer for this GPIO in the HDMI connector device.
> This new consumer conflicts with the pre-existing GPIO consumer in the
> sun8i HDMI controller driver, which prevents the driver from probing:
> 
>   [    4.983358] display-connector connector: GPIO lookup for consumer ddc-
en
>   [    4.983364] display-connector connector: using device tree for GPIO 
lookup
>   [    4.983392] gpio-226 (ddc-en): gpiod_request: status -16
>   [    4.983399] sun8i-dw-hdmi 6000000.hdmi: Couldn't get ddc-en gpio
>   [    4.983618] sun4i-drm display-engine: failed to bind 6000000.hdmi (ops 
sun8i_dw_hdmi_ops [sun8i_drm_hdmi]): -16
>   [    4.984082] sun4i-drm display-engine: Couldn't bind all pipelines 
components
>   [    4.984171] sun4i-drm display-engine: adev bind failed: -16
>   [    4.984179] sun8i-dw-hdmi: probe of 6000000.hdmi failed with error -16
> 
> Both drivers have the same behavior: they leave the GPIO active for the
> life of the device. Let's take advantage of the new implementation, and
> drop the now-obsolete code from the HDMI controller driver.
> 
> Fixes: 6de79dd3a920 ("drm/bridge: display-connector: add ddc-en gpio 
support")
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


