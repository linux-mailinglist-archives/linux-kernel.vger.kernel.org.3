Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52A0F50B327
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 10:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1445548AbiDVIrd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 04:47:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1445591AbiDVIra (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 04:47:30 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8B0532E0
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:44:37 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id bv16so9983517wrb.9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 01:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QGLQHAkzK7JjSt9QZown/UN57Ky55LtxpxP5Kh3Vpq0=;
        b=8QhOHjlGtjJTa3UwEv/qYeHhjLS2ZbNEKUIgtt+cYyoRq698fFcXkKf5K3OJLZYH0Q
         +UqEQjqVRGA4L+YHjrSTiPanpyUXQwlcpWYYUMktO+CrbxTIHVq0zKbOKX8r5BpGTf0a
         oE719ymaB3W/4FY7lFsJXxW7bDov/v9tbV3r3nWgYtUaVurcyi7DoCB1fk0z1zA85rWi
         Wop3+HT5l6JEtry/11rJE7u8JNk81OW9GZGJ74Gn62FfKCeps3Y3+Mx8ojpj0NAYaqz2
         2IVIQX/Zd2sJPNTR5zWkOG2lVxUhzcKphENIS2i9Near5AEWwG+WvweX1sWcASu2pu1G
         nElg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QGLQHAkzK7JjSt9QZown/UN57Ky55LtxpxP5Kh3Vpq0=;
        b=ARQQQBS2MyAsjeOw7v86MJ2WG14Qd5VGrNWv7HH0RfjdlCMYMyKRnpWmfyLULVsdxs
         yduSKEHZqJzDtoJHPKdlTgt6SGDySfswNdLzJFp4FWEQl1ZeapEB+XY3EIZd0h+xolpR
         yyHCk6Vz0EoYcy6pPVeTIJpyk7If0QzGgopi52bduebyNEcR1X4fAlVDE9IqGTTQE46L
         G+qum5LqzBKF5rlGgYEJYhuJzGKBis3+FFALBuX42LnR8TY5+bZaaW6B7NgZH0gZQFld
         ocGY5ZkbNXCPMaBDqPHbZ6XuPYkw3SRzwek+GsFQdVQEgBvrn7XAS+glCyAt3YfWv1FV
         ecMQ==
X-Gm-Message-State: AOAM532EUx27+/jOP+SY8d1uojTwzDHyFHdJum4XJ3BMxT+cCvYKThIH
        4Kb2cps7MXQ90+X0AIzYlKealg==
X-Google-Smtp-Source: ABdhPJywtATRsTspDnN95ZBg4mCkpTryvtiMy/4QW/bWGxrVBIii+hWzYZZALv4a0By/OmNxBc9bLg==
X-Received: by 2002:a05:6000:1c8:b0:207:af9e:a4ec with SMTP id t8-20020a05600001c800b00207af9ea4ecmr2762065wrx.9.1650617076027;
        Fri, 22 Apr 2022 01:44:36 -0700 (PDT)
Received: from localhost.localdomain ([2001:861:44c0:66c0:3ce1:1ed1:5e14:cd49])
        by smtp.gmail.com with ESMTPSA id q14-20020a1cf30e000000b0038986a18ec8sm1144921wmq.46.2022.04.22.01.44.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Apr 2022 01:44:35 -0700 (PDT)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     kernel test robot <lkp@intel.com>, Sandor Yu <Sandor.yu@nxp.com>
Cc:     Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Shengjiu Wang <shengjiu.wang@nxp.com>,
        dri-devel@lists.freedesktop.org, David Airlie <airlied@linux.ie>,
        Jonas Karlman <jonas@kwiboo.se>, kbuild-all@lists.01.org
Subject: Re: [PATCH] drm: bridge: dw_hdmi: Audio: fix returnvar.cocci warnings
Date:   Fri, 22 Apr 2022 10:44:33 +0200
Message-Id: <165061705553.2647880.6752040608547766409.b4-ty@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YmFzutFV/iDyEQF2@dd18de969aa6>
References: <202204212311.TnfpcTGm-lkp@intel.com> <YmFzutFV/iDyEQF2@dd18de969aa6>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, 21 Apr 2022 23:09:46 +0800, kernel test robot wrote:
> From: kernel test robot <lkp@intel.com>
> 
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c:80:5-8: Unneeded variable: "ret". Return "0" on line 94
> drivers/gpu/drm/bridge/synopsys/dw-hdmi-gp-audio.c:105:5-8: Unneeded variable: "ret". Return "0" on line 112
> 
> 
>  Remove unneeded variable used to store return value.
> 
> [...]

Thanks, Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)

[1/1] drm: bridge: dw_hdmi: Audio: fix returnvar.cocci warnings
      https://cgit.freedesktop.org/drm/drm-misc/commit/?id=0e48711f602064705bf81eebe6f627ee1bc11d3b

-- 
Neil
