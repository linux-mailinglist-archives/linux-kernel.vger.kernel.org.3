Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3611B4AF86F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238257AbiBIR2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:28:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238259AbiBIR2S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:28:18 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0826C05CB89
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:28:18 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id j14so9391898ejy.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:28:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Oj1txH1U8co5rSGx4kpxKWpJZ2ixf2fNLNbwVSTc3q0=;
        b=TZ17UPMEdxa+llRScmyrtRpadlOV+mO6ficAHR/AbUbCAFhwoN3PIaUB+Dm6Yy1A0f
         Lap9E7pm1bPPbls/LT0WD1ZXVJve521S0VzMZKWcqIJZ8FoXJ6v29AZzGfVb0kiDwyy8
         kRRniTdMe2OwrtKbY29vq4LerKI5xG3sWstuS9/M6CmUoaIKOj1qGfgLiPQJ5G5BEnff
         jtOov4q7ZJLAsiQADR5B3Uh9rDuH+PyvxTFR0k4aQGBPtkd8YqVS5ZHgqYhk6cIc2+Bm
         mfdeYS4yAC3P5UVO8zIRO83+oZIIsv6fTa3ouk2e6vWOcRX+dM1inW5vwGLepDNTrXMc
         tHsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Oj1txH1U8co5rSGx4kpxKWpJZ2ixf2fNLNbwVSTc3q0=;
        b=4VoeBR7c5OoneyMj9Oe2JlzQykwtDLrtx9gCixl8m06Hx4h3lkaorBhItzshEjRBLZ
         7pXd+ArUIuya63sTz8hHtPyr+yO3othc6q+sndNb17ZS1B58veit4IBcd9YmWEERQ5PP
         mWXXFf3Eu4NZm4AZPzS+NVYzfWbKoPqrWCLQHbR41ZFxDiF1TMzX9MGduV3uqZ8Miziv
         ugE6ReGtPsTixoqmUDnyPmj9oUMjJFtRqoftnFbcUT1r/QWSZZLBQDgoB7riMXXGM81j
         WdjCRbO4IKzVt3POXwERcqePPogaB7lXMXXBCdHIN8FFgLTpe09ua7lbPbjzkNmSuTR/
         ApnQ==
X-Gm-Message-State: AOAM532GrR9YKM8zByD0NtT1pEriTzcS04VANN8hHVFL6BpWj259z6cL
        tBADiC01zEe1wsvZrHuo7Fs=
X-Google-Smtp-Source: ABdhPJwE8armPOf2NcDudp4zU/H+APwY24uygKTAnE1PUaB/Qllz6QBMp5oDqRIgi8n1WHvAqkrNPA==
X-Received: by 2002:a17:906:2bd9:: with SMTP id n25mr2924545ejg.359.1644427697091;
        Wed, 09 Feb 2022 09:28:17 -0800 (PST)
Received: from kista.localnet (cpe-86-58-32-107.static.triera.net. [86.58.32.107])
        by smtp.gmail.com with ESMTPSA id q7sm2330396edv.93.2022.02.09.09.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Feb 2022 09:28:16 -0800 (PST)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Pin-Yen Lin <treapking@chromium.org>
Cc:     Pin-Yen Lin <treapking@chromium.org>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Pi-Hsun Shih <pihsun@chromium.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        Tzung-Bi Shih <tzungbi@google.com>,
        Xin Ji <xji@analogixsemi.com>, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm/bridge: anx7625: Fix overflow issue on reading EDID
Date:   Wed, 09 Feb 2022 18:28:14 +0100
Message-ID: <3151389.aeNJFYEL58@kista>
In-Reply-To: <20220209055327.2472561-1-treapking@chromium.org>
References: <20220209055327.2472561-1-treapking@chromium.org>
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

Hi!

Dne sreda, 09. februar 2022 ob 06:53:27 CET je Pin-Yen Lin napisal(a):
> The length of EDID block can be longer than 256 bytes, so we should use
> `int` instead of `u8` for the `edid_pos` variable.
> 
> Signed-off-by: Pin-Yen Lin <treapking@chromium.org>

Please add "Fixes" tag. With that:
Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


