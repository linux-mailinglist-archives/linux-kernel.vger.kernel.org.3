Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38C74CFC59
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 12:10:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiCGLKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 06:10:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241735AbiCGLKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 06:10:20 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B87B831361
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 02:32:27 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id q14so6894757wrc.4
        for <linux-kernel@vger.kernel.org>; Mon, 07 Mar 2022 02:32:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8Gy2GGJRNoE8yXst/AS7H0JV0qPwD/Ie1gxojbs4D5c=;
        b=Fo26egBRntaoWEL3/DfwEyAAq742j6+C9p7nDoRR3xfgwKcH+E0TDoMeGdqSawnRY0
         zK2N5vNx5GMF6qcKk9V2KQnbaO6UyAUZCaFdE/FXr9jbVZfTgPCvGzsNhJ97oyKdTfTT
         9E7Vnhv8Rurn78Ms2XDJxajn01Dbp0imBBo9Q3pRVgfySlysnVpEFWUvCcmDxiOegZIl
         WWg1dZA3DQ/fsbnGYraHhMuoUVT/avjAHhbckx1TMJO0ndoAh5wSR7jCu7rJm18ex+HD
         6/yN5sjeCaH7th5JEU44U3ejPjC2rJ/XGT+w0F7t3lGOEwoOp7GFPRO/arGAf2ZkvV7U
         7hpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8Gy2GGJRNoE8yXst/AS7H0JV0qPwD/Ie1gxojbs4D5c=;
        b=40IKiDekLfLD+Df6fC8eS6lI2uFhVk+oEDl3CgF2kAtc0sPP26uowgLeD2dxxWVOwK
         14kUwNjlw10Xji1i+AYvOJ3TlS7z0vBL/iV76mTytPoSpOa86pF0mxOZSeOj7bpbXTKc
         nQAjMm/iFUnGPm4YFuC8ECdBSOP2OV5Y6A+vjo11F96t+zAy5In1wNGpJTDYTXEm3Gvo
         T0DFtxeBsVCmWx47HAm89R7IMx0u3wAztW8bpbgrsAjekWpzk92I3ioKv681INYq7uO9
         nXgQXnPodpCtZkMw3SWaXyh3S3+9sCuuEr4nwHe1sWZ8B14G/Q4JabgY8FDE93q47rx+
         FWDw==
X-Gm-Message-State: AOAM5316SK4xRQGOsvojAZrmJpncqHxXxtOwahETBBat+7lrz0+L27z9
        +9WhFo/gtf24rMMow+jvllGAxg==
X-Google-Smtp-Source: ABdhPJwHiGercBUiYw+DtjYkKgYMr9GAQJXwN7tAmH0OoSry2XwjfzU/p74ni4PpTyE4NNe4RLvE1w==
X-Received: by 2002:adf:e98c:0:b0:1f0:2f5c:2e9 with SMTP id h12-20020adfe98c000000b001f02f5c02e9mr7534324wrm.356.1646649146147;
        Mon, 07 Mar 2022 02:32:26 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:1451:71b4:fefe:6096])
        by smtp.gmail.com with ESMTPSA id v10-20020a05600c214a00b00389bcc75559sm385091wml.27.2022.03.07.02.32.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Mar 2022 02:32:25 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        David Airlie <airlied@linux.ie>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Daniel Vetter <daniel@ffwll.ch>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Kevin Hilman <khilman@baylibre.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm: Drop commas after SoC match table sentinels
Date:   Mon,  7 Mar 2022 11:32:23 +0100
Message-Id: <164664911819.1311314.8887306245856110435.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <298f0644275d7d0b4aa3ee7143756a2431a4900c.1646311443.git.geert+renesas@glider.be>
References: <298f0644275d7d0b4aa3ee7143756a2431a4900c.1646311443.git.geert+renesas@glider.be>
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

On Thu, 3 Mar 2022 13:44:56 +0100, Geert Uytterhoeven wrote:
> It does not make sense to have a comma after a sentinel, as any new
> elements must be added before the sentinel.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: Drop commas after SoC match table sentinels
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=f6e68388443ff50088e224b3a75090bdc0403be6

-- 
Neil
