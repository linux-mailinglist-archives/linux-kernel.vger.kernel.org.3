Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE59A482FEA
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jan 2022 11:30:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232662AbiACKat (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jan 2022 05:30:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiACKas (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jan 2022 05:30:48 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6CFCC061784
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jan 2022 02:30:47 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id y9so1299309pgr.11
        for <linux-kernel@vger.kernel.org>; Mon, 03 Jan 2022 02:30:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=K5BEbt9OjKO+nuqxpvzbIOlXKc6txbVTj2xfbbvgeXff1lHQfcdfbFdinIBNEq0EyO
         Y1aCWLAj4I6N5aIbVrp02f36dabPmFWQ8BiKUWjxqHdsE1oXmAmDB33rNVwT2RaiAGS2
         nDMYYHPmDL4PfdBErgwWs8EHct2Z3Z+uDPY9KZ/+H+TJncxI2Pexcrtxgj/DbqOXEIVt
         PCegKTkSznNwgTdolMRZLUIKw/hxyb2wMSN8XWJT8egb0H8fLooQPDX5yVhfIahzMBJa
         23cSUeyaczkJ+xdjSYMP8Rzg70cKqDcxOZKBvM2STQF2+CH+UcTBs3UsOswcrji9OpBm
         hKHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bqezZ2/HwBTxC4hfR4A8RkBTbm8B6r0iUtltdIvH/WQ=;
        b=ZSrLnf6W5P5/2mZ0q4R6pVy6IBfvVENC5zzvGvzWBh3Xruuwx6wCjX7QRKKHRVMwtF
         /FUpoYIn+vLoaXC5X+vl5r8XO+YYER0Nhb5Yk5/OAYxwmGaZsB8WRgvWojUP2UeEU2jp
         wiuMPstWkEMIFE5QsBu2ZIw9hWpiWUrjBgl902/HPNOGzDCYO/6YwApaG5UUrpa0h/ai
         okhcZhI2xrL1yMpcV3pS8sj7blfePPKW3ygX/W0ih+beR5zwafZX/AeR2qZdB5is1OaV
         bKKD4k/1tz73JI7SVjyffy+DKSgonDuSjpA9tgZ9UQUK1PE3FgcLZ2HR7NWDyktLBFlR
         klzA==
X-Gm-Message-State: AOAM532grGnXmIIFUinsnChPy/D2EmsYO7jRbd/+VN827N6AOVL8sJy7
        AoViW+Gu64NWlT8/QimH/zrBjByux6B3A0uESL31Aw==
X-Google-Smtp-Source: ABdhPJzjmfkMpGxFmUpkFi1mKbOuAv2LnaShqmU2K2ivWzs/UE9RKuPtNoD834Rh8/Elsaluwf7Y0D03nF5Me2CLMTg=
X-Received: by 2002:a63:6d3:: with SMTP id 202mr38562627pgg.324.1641205846920;
 Mon, 03 Jan 2022 02:30:46 -0800 (PST)
MIME-Version: 1.0
References: <4bc21aed4b60d3d5ac4b28d8b07a6fdd8da6a536.1640768126.git.christophe.jaillet@wanadoo.fr>
 <YcyIidlnW4Sh6CGm@pendragon.ideasonboard.com>
In-Reply-To: <YcyIidlnW4Sh6CGm@pendragon.ideasonboard.com>
From:   Robert Foss <robert.foss@linaro.org>
Date:   Mon, 3 Jan 2022 11:30:35 +0100
Message-ID: <CAG3jFys8i+D32BSmsLnSG2ArP+wwf-q7DtxoateX8Ln-5V5RtA@mail.gmail.com>
Subject: Re: [PATCH v2] drm/bridge: sn65dsi83: Fix an error handling path in sn65dsi83_probe()
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        andrzej.hajda@intel.com, narmstrong@baylibre.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, airlied@linux.ie, daniel@ffwll.ch,
        marex@denx.de, frieder.schrempf@kontron.de,
        linus.walleij@linaro.org, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next
