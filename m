Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE8C533CFB
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243885AbiEYMuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:50:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243810AbiEYMuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:50:09 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 625088D683
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:50:09 -0700 (PDT)
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com [209.85.208.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id D55633F19E
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:50:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653483007;
        bh=rAm0vlTlFHnGFybKw7GdGun3AiUfPwceSrfYbk/I7Zg=;
        h=From:To:Cc:Subject:Date:Message-Id:MIME-Version;
        b=aidq1KrTTAqytspV1bm3osC8H1MAGrCyshzsT7AjHPpNXNRDPfQR/ypifxF94Z1aC
         o7qjc4wmlskCy0lVYXy6gBW79mOQ4iuoKDCoNw2FaWwe91GlYxl1rycHIQcAElHhqX
         imYJ+OLgA3a9fQiKAQK1yNLoovHUbg9oCwe0mCRE/KXARtmzIFoMTLX1dqXkU17Stb
         fH0q8EIuRBmg9KNBb2a6+lZinUyuB1Zlep7QL99LANjTF430gBrs+QA8sXoxB3Gnd7
         yu9puleDskIkfkER1q5PmvvbVgc9J1s2Ng+7E+3DHp7EfUW4pt/rJs4VVxj48axvPw
         fmOozX6s6WP2Q==
Received: by mail-ed1-f71.google.com with SMTP id r14-20020aa7cfce000000b0042bcefd6109so550418edy.13
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:50:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rAm0vlTlFHnGFybKw7GdGun3AiUfPwceSrfYbk/I7Zg=;
        b=wpw5zkrzwF1grgveYr1/76lsy/jIy1hZzC72mAzY1oqPx2TL7ySWL0G9B8RMFzuxQ3
         pQqQLpigH/ypXnSKz/cByQcmvefEYjVj5Owm/VFJo9ZnI1HJCFsao8ffwvbWapEAU+eS
         ROfaItPUawfrH1OWKgCEGD16bSmKV6Cc+kcml30O1nsBykEmdghrNFnLm6iOCSAWZDkO
         a+42/YiRQ/wQ8EaeVKQztlBnaeRBXkxg6QFn+nNJR6BNTFpGhPkZeIL4MmrG8YSF+YJD
         aiuN122Fi+bylo8raHQ1CtgTmkouEBQPdIELDGf7z57v7nWNAbD21ILpl6L8iCSmMBeR
         XiXg==
X-Gm-Message-State: AOAM530292fDsPOiTepIalGnxwoojSxjOv2k+a+SM8BPf+WXdtoqBTc/
        BFiaJbepC9ODJ3vg/r8USzqZ/TKpfnALIXZiq0jEkdt3OqTOTzI10ItBah0ZvLgFe4pkochJ42h
        vCvOiNt4QsVz9RYzboLKrSkQbGoWhDW/yv8eCu/iQBw==
X-Received: by 2002:a17:907:2cc5:b0:6f9:1fc:ebef with SMTP id hg5-20020a1709072cc500b006f901fcebefmr28181476ejc.121.1653483007617;
        Wed, 25 May 2022 05:50:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzvTvCfr2URj1gvVBPwdVrL7eDlhYrXsRoUskI+1RzXgsbrq4SC9HIUuinuM5xzuAqeiXyC7w==
X-Received: by 2002:a17:907:2cc5:b0:6f9:1fc:ebef with SMTP id hg5-20020a1709072cc500b006f901fcebefmr28181460ejc.121.1653483007466;
        Wed, 25 May 2022 05:50:07 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l8-20020a1709060e0800b006f3ef214e62sm2860566eji.200.2022.05.25.05.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:50:07 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 0/2] um: Kconfig: Style cleanups
Date:   Wed, 25 May 2022 14:49:59 +0200
Message-Id: <20220525125001.47009-1-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The convention for indentation seems to be a single tab. Help text is
further indented by an additional two whitespaces. Fix the lines that
violate these rules.

Juerg Haefliger (2):
  um: Kconfig: Fix indentation
  um/drivers: Kconfig: Fix indentation

 arch/um/Kconfig         |  2 +-
 arch/um/drivers/Kconfig | 54 ++++++++++++++++++++---------------------
 2 files changed, 28 insertions(+), 28 deletions(-)

-- 
2.32.0

