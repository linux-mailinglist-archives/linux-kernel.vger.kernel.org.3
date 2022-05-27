Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52E39536378
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 15:47:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352727AbiE0Nri (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 09:47:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352708AbiE0Nr1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 09:47:27 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2AF018358
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:47:25 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id p10so5934627wrg.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 06:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YJw/68oJ2Ve+rhEVma5/z7ZSptuL9RBQlec5IpwcYH4=;
        b=4sw+2aoM5gel0Ufzhq13u1+8+tUCQyJBZ/8NvGRz+K92kScpR5fsTYDM9edSlYinjF
         Wh6D9MGi8S/WUmENkNK45EmIIKIZpZ0d3CohEJb9NFV46/1TNM8G1bqzevuK05rVpPoF
         x2krQ+Lvs+9W0AYMk5iHdS7wQro28Ad2u+6ctXm2dTyNgxWNPJc1o/j29GVX2kwH2cKb
         8APPtEOua7S/CUmEz4w4cj9nsnbdrsGea6LocI7e1V3UnU9A5JFbdYjIpgb0aSqoKoHt
         TDRFruR0hfSy6P/RmD1qRHe5xX2BFu0i6f9+04bOxyY2WCaMOiaf2aJU1cjXkN677AmW
         6w4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YJw/68oJ2Ve+rhEVma5/z7ZSptuL9RBQlec5IpwcYH4=;
        b=aQ+kn9IbHm3O38JfXeSQe6zaUHYMZl+gWdDMai3etgv1BKPFc7PLjsnG8yFY6XxVxI
         +cHLxXOvPMpyTIrZuEBqT+iYQqGyj3dnzkRP9Vz1lL8NUXsen8fojoF4aQnfRTB0McSo
         C593HEbDzyCyDz3/unBnGVXQ4plbjF7x9iMrmlXcmiVFDMn2jLCMxPw2cgLKV++p5iKH
         S2/lvJKzdgK5LsV5oVUgIH1LyNGqruVT/+/Prx2EQNFI/tnRh3rt7bqqTp2pxfMeanBI
         wa2dGAN34mQqkLVhi1Cub7Yq9B9wBFghpTX+YAweoN9tSrQ7IHLiDZDBhF38dmU8o7Rl
         hmWA==
X-Gm-Message-State: AOAM530oFzP58rnQGjQX9xlqLVgz6yC1wZh4hPv9mKBjnid/gaEqKSGU
        Xr7oz1jv0rVa/VWIDf/RTvXeErWjKJVXOg==
X-Google-Smtp-Source: ABdhPJxJHwgae8gBZtNLXNeueHSHgMXtd10QHJ2hXwx5BHRITk4XBtLwwmeLjCZkLdEm49xzSETXgQ==
X-Received: by 2002:a5d:5888:0:b0:20c:9868:9d94 with SMTP id n8-20020a5d5888000000b0020c98689d94mr34917757wrf.433.1653659244342;
        Fri, 27 May 2022 06:47:24 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:f081:5ded:fc86:365d])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d6d81000000b0020d02262664sm1763477wrs.25.2022.05.27.06.47.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 06:47:23 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     khilman@baylibre.com, Zelong Dong <zelong.dong@amlogic.com>,
        robh+dt@kernel.org, p.zabel@pengutronix.de,
        martin.blumenstingl@googlemail.com, devicetree@vger.kernel.org
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, jbrunet@baylibre.com
Subject: Re: [PATCH] arm64: dts: meson: add reset controller for Meson-S4 SoC
Date:   Fri, 27 May 2022 15:47:22 +0200
Message-Id: <165365923903.118001.12421287063580195435.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220526130158.36651-1-zelong.dong@amlogic.com>
References: <20220526130158.36651-1-zelong.dong@amlogic.com>
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

On Thu, 26 May 2022 21:01:58 +0800, Zelong Dong wrote:
> Add the reset controller device of Meson-S4 SoC family
> 
> 

Thanks, Applied to https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git (v5.20/arm64)

[1/1] arm64: dts: meson: add reset controller for Meson-S4 SoC
      https://git.kernel.org/amlogic/c/ead23b52f539a4d93a541afe208d70b1a9089e1a

These changes has been applied on the intermediate git tree [1].

The v5.20/arm64 branch will then be sent via a formal Pull Request to the Linux SoC maintainers
for inclusion in their intermediate git branches in order to be sent to Linus during
the next merge window, or sooner if it's a set of fixes.

In the cases of fixes, those will be merged in the current release candidate
kernel and as soon they appear on the Linux master branch they will be
backported to the previous Stable and Long-Stable kernels [2].

The intermediate git branches are merged daily in the linux-next tree [3],
people are encouraged testing these pre-release kernels and report issues on the
relevant mailing-lists.

If problems are discovered on those changes, please submit a signed-off-by revert
patch followed by a corrective changeset.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/amlogic/linux.git
[2] https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git
[3] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git

-- 
Neil
