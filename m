Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBF6056588F
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:24:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234233AbiGDOYk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:24:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233232AbiGDOYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:24:37 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BC4B33
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:24:36 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id z12so4126322wrq.7
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:24:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bp1wg82gdWxinNfZCuCgL7x1XYi28SYXqHd8Ha4MekE=;
        b=RxfIDxavIAmAgvyiLqADwT4xQOj9LQkO8txG1jgIaWP1ixgOtm4BB392KYBH6xvnKM
         Ye3kqyLyuXZIBFRibXyctZN51wel3re6qMEgd2KHGQmoQxNgZLfKVjyuXCjdGpndnVCT
         IG9I7CIy9WI41EeD1OIezbFdShc0RS4nz4ckTSZcQ8YIcqfqvtHz5vspU96EQWf5ct/R
         rM9xyJad5LMKuws5cRbMICdr+CKHH+W78NFQGibKeZb9WKm3yQz/952QxKc88LTW8WOT
         53Ox7wGU2fN3NxxWRr+eKwQg7GtyNlJl0sV5zn+Zjq+z529Urs6hLtA6ThSOQv6VY1t4
         HvTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bp1wg82gdWxinNfZCuCgL7x1XYi28SYXqHd8Ha4MekE=;
        b=LW0g0RcB/Wnd1iz0irU+EFxKJXByHCc4FzYgfgmwSM1hdqRiBTohG7Vd8gjJFYZuc9
         007JCgncQ9YEhzxNRrE/N+4Q2/0Oef6j/r0h58esYJYJLWcsiDROBaLcyqUKeIvhXnXm
         wmOA8bn+pjc2OB//oalCTc4j3uweg2SqRx6bi3sDYaDWa9oQSARKknnuV3zndqPRNhVH
         luN10a5mjHf+rFqnaxv0r6bRr9yUc50pplAggWV+JWOkV/u0TSycV/Y+67xewp8Lb9tv
         VbxalG98teiQ1qkgi8YVnuzNsFykX0141ZE3V5+Dz0Io307aS/sqLlOQH+Wk24CFjddC
         wsGQ==
X-Gm-Message-State: AJIora+MUlvfO8p4DcXEm4hWO2zdq0Tt0/9QG6gsSfpRT7LxpamBx4su
        I/j00BWOeeHnM+qB0aLbojs8VPykjTMdF1EL
X-Google-Smtp-Source: AGRyM1uTsz1TDgg8/38iwpaQktF3rRo5ZcTWH5lFqvW5z5aQj9xHF1C28BNOXA4uhVj8myD5t4oC4g==
X-Received: by 2002:adf:e68d:0:b0:21d:6d20:5175 with SMTP id r13-20020adfe68d000000b0021d6d205175mr3193032wrm.494.1656944674408;
        Mon, 04 Jul 2022 07:24:34 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:df6d:5783:b4dd:8e2])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b003a1925aa19asm10100650wmq.21.2022.07.04.07.24.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:24:33 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     linux-kernel@vger.kernel.org, Liu Ying <victor.liu@nxp.com>,
        dri-devel@lists.freedesktop.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Laurent.pinchart@ideasonboard.com, sam@ravnborg.org,
        airlied@linux.ie, marex@denx.de, andrzej.hajda@intel.com,
        robert.foss@linaro.org, linux-imx@nxp.com,
        jernej.skrabec@gmail.com, daniel@ffwll.ch, jonas@kwiboo.se
Subject: Re: [PATCH 0/3] drm/bridge: fsl-ldb: A few fixes
Date:   Mon,  4 Jul 2022 16:24:32 +0200
Message-Id: <165694465386.3087613.3999900906526053435.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220701065634.4027537-1-victor.liu@nxp.com>
References: <20220701065634.4027537-1-victor.liu@nxp.com>
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

On Fri, 1 Jul 2022 14:56:31 +0800, Liu Ying wrote:
> This series contains three fixes for the fsl-ldb bridge driver.
> 
> Patch 1/3 fixes mode clock rate validation.
> Patch 2/3 fixes LVDS dual link mode.
> Patch 3/3 fixes input data enable signal polarity.
> 
> Liu Ying (3):
>   drm/bridge: fsl-ldb: Fix mode clock rate validation
>   drm/bridge: fsl-ldb: Enable split mode for LVDS dual link
>   drm/bridge: fsl-ldb: Drop DE signal polarity inversion
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/3] drm/bridge: fsl-ldb: Fix mode clock rate validation
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=591129d3db266648823bb953ebbc28c92e059bf3
[2/3] drm/bridge: fsl-ldb: Enable split mode for LVDS dual link
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=57ef278ef125e9188474a164f35dcffc69836d01
[3/3] drm/bridge: fsl-ldb: Drop DE signal polarity inversion
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=1dbc790b4d416dacb124a6acd05f88a0bcf3be39

-- 
Neil
