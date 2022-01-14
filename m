Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F28C248E896
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 11:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240590AbiANKvM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 05:51:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbiANKvK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 05:51:10 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E384C061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:51:10 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id k18so14865127wrg.11
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:51:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MNu7t1Ljlb2prCp8AD9cBENC17XN93Gmt4yUeCJHVzE=;
        b=Qbfn7uypSV1LyQz2w1EFtaCpmN2h4zjJddCuPiwhAyDaSSF2i3jPujf29um0kCabTq
         U45Puo1QbpVM3z/rl4IOx9lqIBmZ+2X9XqFdG7jFxqsYIlsJ6QrSbPkjWQ6EUx6d8Jzq
         fXtOXMZhEcR7EC+IlwcOVX9UKTx9QTWJJe6zdWc9rv59dm1S6F9SYiO2fykAbJamo2Eo
         VIuM+egIFmCRpjjvYviXIGJ81mvM0nXi2xUOF4HT7f8tUhB+2i1JJvOrGYbJHPCaIFgC
         qh4+jfJ8KDiDnpmVi0AVHTGPP6FJmB1QdcMt8Ttu66Z5t/FpWvi/riMC1aSBBdD9VkS9
         e6OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MNu7t1Ljlb2prCp8AD9cBENC17XN93Gmt4yUeCJHVzE=;
        b=tsCKhhskT7DSuZ7/RtsD1g//3BUPLpkE1FJLMdOn3Yghb5gYMGFubn6w8czzfW+6Hw
         bMxSUQ9ThAoAzfuQQ7D+qc8dQOKMlqKk2IIBeLPyNmJKIk9oMOeA3tViZspetBssHyUL
         vlfI1Uh6WkpnL+ZbpeonYe6qNpmhkebTcfJCRyL40a1+KW0hvvHPmffx2j0y+XEkivW/
         cv+PnvoZ1ftDSCU9SZHK1KlFW7N4LWSAXqOCFRfH5DEIybZ69Oai9d/E12ewugq4YoQ5
         XS4iRY2GYKn4NfIjJufPSkLCr5I2Ehgc/Ivc4VrLaTt+zZKb/5TuuLNRNhC+pxI0mrWv
         Hcfg==
X-Gm-Message-State: AOAM531I2TP4k48rXRn+n7mPyJFyGj9tXdLKYuBU7RevtI1oT4WBXQXT
        7oTl7ixqI7e/+hGQ7IsSSyx0BA==
X-Google-Smtp-Source: ABdhPJyXciixk6P7RQpoKiS2hUdjfnUFK4nzYmJVI6x87htxXI15K67RzfBYwm7rm5rsVFdeNbvWMg==
X-Received: by 2002:adf:ce87:: with SMTP id r7mr7669525wrn.259.1642157468117;
        Fri, 14 Jan 2022 02:51:08 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:a3fc:c40b:5afc:88ee])
        by smtp.gmail.com with ESMTPSA id i15sm268207wry.99.2022.01.14.02.51.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 02:51:07 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Drew Davenport <ddavenport@chromium.org>, ple@baylibre.com
Cc:     Neil Armstrong <narmstrong@baylibre.com>, airlied@linux.ie,
        jernej.skrabec@gmail.com, robert.foss@linaro.org, daniel@ffwll.ch,
        a.hajda@samsung.com, jonas@kwiboo.se,
        Laurent.pinchart@ideasonboard.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: bridge: it66121: Remove redundant check
Date:   Fri, 14 Jan 2022 11:51:05 +0100
Message-Id: <164215742752.1114906.11976523106834193507.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220114064012.1670612-1-ddavenport@chromium.org>
References: <20220114064012.1670612-1-ddavenport@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 13 Jan 2022 23:40:12 -0700, Drew Davenport wrote:
> ctx->next_bridge is checked for NULL twice in a row. The second
> conditional is redundant, so remove it.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: bridge: it66121: Remove redundant check
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1500296576464dd4f8f7ba409069591648f4e98c

-- 
Neil
