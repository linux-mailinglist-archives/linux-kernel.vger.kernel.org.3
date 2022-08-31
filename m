Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A2A5A735F
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 03:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230510AbiHaBeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 21:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiHaBeH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 21:34:07 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAE0E9E886
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:06 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id i5-20020a17090a2a0500b001fd8708ffdfso10477181pjd.2
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 18:34:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc;
        bh=IZI6y2vpGGRc3o8pF0wlrPeZMh7+YaVLfgMLYc70b3U=;
        b=b421CmE4QFudEqjDuwm1n1tYJC3aFMO+SOoooowmFErKgi1c09IfhM73eNone9SW1b
         kWL6Y3gFz9xcabYIQAnoGmHFogCJxAKKWzySCaLSLktF9eTEwkFdeuYhJnikgkIqok9g
         3bvjJ/rNDtcWDKPvtMQ2NV5s47K3elHZ5qdr8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=IZI6y2vpGGRc3o8pF0wlrPeZMh7+YaVLfgMLYc70b3U=;
        b=e9diVV8hO8aIcXZgA+zqPJm5uLn2Wl22hGW2Mcz9Iww+i9UeeO21l+uZCs822usmed
         92Zk5C8dSPY6c6xHNhNzcOfYPynAEvtjJcOzTMVDn5Mbl6f9Run9HSY/lX+0QPF4B0+P
         M44gtLBIoAtY/wE1iTnfKZYDjlsottFMKfIuvgEsU4EJVbfg+Vz+TVR4lh1s3Q3mAW8y
         ILA8xSzpsWQvjXtvRhGlRX4zH2N3ePzHMRl+h3dy5voo69FBurmxCTLMLfD/y3R+2uqs
         66NCc4AVfreRWPZ6aV9LGKbfRcepgI9aajaPSD4kKKa7iQ7ZXSgH0FheDkStEhwtFa92
         3yXg==
X-Gm-Message-State: ACgBeo1g+jl54+nIWLY5GW5GmqlonobVdSsZB73hAK1b2IrfhQirsT7Q
        YwLqFCmrkmo9nzmP+3ENmXgkv77JCcBhEw==
X-Google-Smtp-Source: AA6agR7mpdg1vbBqN796ynpGeGt9okldi2pzxGODXLnNGQmqID0Ch1/jXEBAdj0guf36Q1gUg2rsVQ==
X-Received: by 2002:a17:902:bb95:b0:16e:e3f4:8195 with SMTP id m21-20020a170902bb9500b0016ee3f48195mr23384954pls.130.1661909646268;
        Tue, 30 Aug 2022 18:34:06 -0700 (PDT)
Received: from jwerner-p920.mtv.corp.google.com ([2620:15c:202:201:2e75:b9a4:fb1:b1b8])
        by smtp.gmail.com with ESMTPSA id t10-20020a170902e84a00b00174f4316c24sm4261382plg.245.2022.08.30.18.34.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 18:34:05 -0700 (PDT)
From:   Julius Werner <jwerner@chromium.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Julius Werner <jwerner@chromium.org>
Subject: [PATCH 0/4] dt-bindings: memory: Describing LPDDR topology
Date:   Tue, 30 Aug 2022 18:33:55 -0700
Message-Id: <20220831013359.1807905-1-jwerner@chromium.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series implements a proposal previously discussed on the
mailing list under the topic `[RFC] Correct memory layout reporting for
"jedec,lpddr2" and related bindings`. It adds a new jedec,lpddr-channel
binding which should be used to group nodes of the existing jedec,lpddr
bindings to describe their relative topology on the system and the
amount of chips wired in parallel on each channel, as well as their
different ranks. This also adds bindings for LPDDR4 and LPDDR5 memory
types and deduplicates some common schema elements between different
LPDDR types.

Julius Werner (4):
  dt-bindings: memory: Factor out common properties of LPDDR bindings
  dt-bindings: memory: Add numeric LPDDR compatible string variant
  dt-bindings: memory: Add jedec,lpddr4 and jedec,lpddr5 bindings
  dt-bindings: memory: Add jedec,lpddrX-channel binding

 .../ddr/jedec,lpddr-channel.yaml              | 116 ++++++++++++++++++
 .../ddr/jedec,lpddr-props.yaml                |  82 +++++++++++++
 .../memory-controllers/ddr/jedec,lpddr2.yaml  |  48 ++------
 .../memory-controllers/ddr/jedec,lpddr3.yaml  |  51 ++------
 .../memory-controllers/ddr/jedec,lpddr4.yaml  |  36 ++++++
 .../memory-controllers/ddr/jedec,lpddr5.yaml  |  48 ++++++++
 6 files changed, 303 insertions(+), 78 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-channel.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr-props.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr4.yaml
 create mode 100644 Documentation/devicetree/bindings/memory-controllers/ddr/jedec,lpddr5.yaml

-- 
2.31.0

