Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D38591EF7
	for <lists+linux-kernel@lfdr.de>; Sun, 14 Aug 2022 09:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240227AbiHNHrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 03:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240102AbiHNHrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 03:47:12 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBE51EAEA;
        Sun, 14 Aug 2022 00:47:11 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id f22so6111497edc.7;
        Sun, 14 Aug 2022 00:47:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=hPc+aF2VAi/VbtY/nNmAuTS5AG9h1lW1aTIOSa9Z7t8=;
        b=TcrPgJ4ohViDciruhNDRuGYu8uFAQ7ywdU0cgSCp6gfiZ9WMtHxZGnHTWpXtzyJFww
         Pg90Kl2fWc/reoStkjEFcj8YZHJUHgvqsoaCwnOWScJMxfY9Lpu5lcOtwXD0/b3rsy+q
         XLbNEtxtZ9L4JYQxWpHo+hBBlOlDzOlRUGP+1iPQNp5vAHXhC/q0M2LXWfXT/SepsYCJ
         MJu0Ga3dQGkUi09svuD8eTus6cQJ282lmm82NP0KnCyfcNJso0p/fhuQShnqOlFxYyOd
         7u7Y2pTLQE+++IL5972uDenQ5Q2XG7Bp10K46srntrOJ9ChWAHpCkS3z+kvs3pC3+Avg
         QvsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=hPc+aF2VAi/VbtY/nNmAuTS5AG9h1lW1aTIOSa9Z7t8=;
        b=MsiqtOPoMXyTNojLouatSV2oAsBzPuZBJcOzhfBh7HM2B/6c+5T/mekkAvT6ySdtev
         qXCDaQlbiDsuaYZNoKHtcsMEGcJd5r1Ud7IjfnXkZjgYtAb3RqPIYwaFCp4Mm8n9EKAH
         jM8aS+sggAxVixVVWxh3Hk6k247J1dV/kvjumz3UQF0gtEOmWBN9TDBtmbTM0b/bUm4g
         1GUVFlmWBlORouRBCKrzfclXppS4NlTYrbVJrVYIUhqZA9V92uTGRoSXO8vHGEYs/IPE
         BZMKQCPn1Ig5RlSefY55CcN+QlfLCI26+gZXgOxLtCXlD1f4faWs1sPUuEUvu4AL65OC
         R62g==
X-Gm-Message-State: ACgBeo2rJyGa23XVUsY5IIr7cyZTAN7xHFblDiNeB/SAdnitnCYlVef/
        H2dbfRJ3rGAU63qf2n6cKTM=
X-Google-Smtp-Source: AA6agR4xesSbq0h+Z50jLzI3hDE4cPZAkKUdasYL/U5BfidpRRo0/xGAgREkUb2XLYIBaHbs5IHMRA==
X-Received: by 2002:a05:6402:5190:b0:43d:da02:566a with SMTP id q16-20020a056402519000b0043dda02566amr10055382edd.187.1660463230217;
        Sun, 14 Aug 2022 00:47:10 -0700 (PDT)
Received: from jernej-laptop.localnet (89-212-118-115.static.t-2.net. [89.212.118.115])
        by smtp.gmail.com with ESMTPSA id 23-20020a170906309700b0072b342ad997sm2651373ejv.199.2022.08.14.00.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Aug 2022 00:47:09 -0700 (PDT)
From:   Jernej =?utf-8?B?xaBrcmFiZWM=?= <jernej.skrabec@gmail.com>
To:     Chen-Yu Tsai <wens@csie.org>, Maxime Ripard <mripard@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: Re: [PATCH 4/4] drm/sun4i: dsi: Add the A100 variant
Date:   Sun, 14 Aug 2022 09:47:08 +0200
Message-ID: <2110674.irdbgypaU6@jernej-laptop>
In-Reply-To: <20220812074257.58254-5-samuel@sholland.org>
References: <20220812074257.58254-1-samuel@sholland.org> <20220812074257.58254-5-samuel@sholland.org>
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

Dne petek, 12. avgust 2022 ob 09:42:56 CEST je Samuel Holland napisal(a):
> The A100 variant of the MIPI DSI controller now gets its module clock
> from the TCON via the TCON TOP, so the clock rate cannot be set to a
> fixed value. Otherwise, it appears to be the same as the A31 variant.
> 
> Signed-off-by: Samuel Holland <samuel@sholland.org>

Reviewed-by: Jernej Skrabec <jernej.skrabec@gmail.com>

Best regards,
Jernej


