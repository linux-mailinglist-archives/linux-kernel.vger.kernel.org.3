Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CDF8519972
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 10:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346135AbiEDITn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 04:19:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346106AbiEDITa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 04:19:30 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB7F21817
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 01:15:54 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p189so387149wmp.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 01:15:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BMywFm11EqXrNibAu4d/EqrOPzgyY5HVKqDpJGYDDAw=;
        b=JJpNffMdp6cZOgwoTGlGNfpKXrWcn5bJmphCVqZUDcQo0lT77JrqBF63FlnfdsNZ9O
         Kh+kDmaOSXGYRkV5NuMqK+ErTbIoiGsah0O6CO+PiVUOWxbSKxUM6q9SrPXGuqFScuqu
         JRUxcLCbDylDoYs2OuGB7ZPIppkR3sxXgvgHdhecI2tTN5wnsUiOllm/l86oTl/jjmd6
         8s82e2zvkDciA5ee01pNZ9uvZ+k1Ns363+CwnZt24nMHmYGpEiYmDqUreE5BwSnZbLXP
         tgr9PVxUXHCjQJjkVpY/XBjeRZDlWmlC1FdZZhFv14HPK59kItx7pYqeqQX4AA0+tlNF
         hIrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BMywFm11EqXrNibAu4d/EqrOPzgyY5HVKqDpJGYDDAw=;
        b=24c018iflpOUfRU5mLmcF95gXlsHNiACl1F8MLC9sba7xHNu+SQrZ5funjQavw2QRi
         VcBYxNuzemFASY2/ylLSTBBKjHSQt12xlQ/CW+Zx83WfOTk5rkVOMrMtOt6ZauFoxQTg
         kgZNmdeTszZvU292Q5powuEFaW0E7HmPK0ncJxgNK+D5cVKORDO6Dev+iZ5bemMw05l0
         LoDoB1aKRCipd1b+89IBx/cU9fArCcLrpyMqwoSZZ9fDL1ex/BUQvr0OnpAk1jW3uhTT
         Q/O7LSNLsQ8Yl5UmLHMYX0SSIT0WR5OflR7zcmSJW46ggn27nMDyc621mfyOjIgD5I2m
         79nQ==
X-Gm-Message-State: AOAM531GjhhKwTauAdge/QPBn/IQgwBBLYBsRMtYb4Z+Lu6EWtiNsJh8
        Q9A1ICSjDcnHkLmiVglV/idCLQ==
X-Google-Smtp-Source: ABdhPJxyhGdJO+eCQccjPUIqEqeae3i1YpwaQD3fzOb/wa/UMN9kNcDyP0A74Hztgg1arLFiXMo0Vw==
X-Received: by 2002:a05:600c:3792:b0:394:5fa4:f2a4 with SMTP id o18-20020a05600c379200b003945fa4f2a4mr494108wmr.33.1651652153094;
        Wed, 04 May 2022 01:15:53 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:4b7d:bde6:bf9b:6cf2])
        by smtp.gmail.com with ESMTPSA id e8-20020adfa748000000b0020c5253d914sm11161866wrd.96.2022.05.04.01.15.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 May 2022 01:15:52 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     Robert Foss <robert.foss@linaro.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Fabien Parent <fparent@baylibre.com>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/bridge: ite-it6505: add missing Kconfig option select
Date:   Wed,  4 May 2022 10:15:50 +0200
Message-Id: <165165213702.1111026.16077727887449605674.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220426141536.274727-1-fparent@baylibre.com>
References: <20220426141536.274727-1-fparent@baylibre.com>
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

On Tue, 26 Apr 2022 16:15:36 +0200, Fabien Parent wrote:
> The IT6505 is using functions provided by the DRM_DP_HELPER driver.
> In order to avoid having the bridge enabled but the helper disabled,
> let's add a select in order to be sure that the DP helper functions are
> always available.
> 
> 

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-fixes)

[1/1] drm/bridge: ite-it6505: add missing Kconfig option select
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=841e512ffb64898db6322c0619f6bbc41266d86f

-- 
Neil
