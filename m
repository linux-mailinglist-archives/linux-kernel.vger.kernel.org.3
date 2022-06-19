Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76676550D8D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 01:19:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235235AbiFSXSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 19:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232358AbiFSXSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 19:18:48 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C6C26348
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:18:47 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id k5-20020a17090a404500b001e8875e6242so8653642pjg.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jun 2022 16:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wItWg2bzk6jHDJ8lmG0zhg8Sf6lxfJMRxsbUkoZn5qE=;
        b=mikZDPyObP3mlHXHOduH4nx5OuuQS1n71ug8b8w6+8XW61rWmouv0wvExMNRR63wVf
         jS+DbR4R4jZULGYzSZjqtz86riT3o5O0kGZCmsmh7gtbOT6ue84ZeZHMol8kjFIkUiWy
         QJUx8r+Kjguqel0yTBulWa5lpP5HFnXKW6qtW5Yi/Ro/KYm2lj4Tn2JZJlw+LNygSIed
         7yTvmceCNrRSnIDlJXGB6yfjH2qV7kwc0/caYJY5rvZbcAzNy9eu+sTZKM0Nt0vSGlGM
         yEHuaGosmwpp8YpiVBkjjT5K/WWiZ7JhXSN8VMbE2JccWg8mLd0vpRiGExgx6DVAx1rN
         ldug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=wItWg2bzk6jHDJ8lmG0zhg8Sf6lxfJMRxsbUkoZn5qE=;
        b=3947buXkK2aZR2p7Ud6rmhIUT3TvFbk0F0pOLQmbkrrtLa9rQ64xp4ueVMWhM2+Awq
         53uVLGxv4zzN7slChTuw7ibvQfWdtvtkQNbgGW5b7Ofe7Wvu63kf3soB0NlV4+JzLTy3
         LNQ6FLBsGdTUVPw32FGdXHsMvK0iRsuwQZPp2i+uRVZhoVxN84XM+6Cp8DrlGYoccn50
         mLL2qNfwAoh9jDqx5Y8qSkp9jbuIuAcriJfpfCzMArmnVAJmgnuwmY0VgXOuaE+eSOl7
         WUSX/mrP2O/ZTxbZ8/xYgwtkQ1aHN/JOM//Un5T4thy0GyYUBdDNGa28vU93v2Dw+pD7
         ZdJg==
X-Gm-Message-State: AJIora/ggGUVw6hNREnBRWwkKfseNtRDL2tR4af5Z6qHWv8AwDMBz6sR
        y8WoEBOtBA5cqMr809PCs4ahoqTeXamOVw==
X-Google-Smtp-Source: AGRyM1u/Ftzw1cAlUvQGU04s4/eJwqQZLn993tHLEcoG2BJLz/bMQwQyUHNqUpcMvPG1mtNdNMw9jA==
X-Received: by 2002:a17:902:c2ca:b0:168:db72:16a with SMTP id c10-20020a170902c2ca00b00168db72016amr21525769pla.171.1655680727058;
        Sun, 19 Jun 2022 16:18:47 -0700 (PDT)
Received: from octofox.hsd1.ca.comcast.net ([2601:641:401:1d20:c443:f10c:f501:dd9f])
        by smtp.gmail.com with ESMTPSA id b9-20020a17090aa58900b001e2f6c7b6f6sm6807016pjq.10.2022.06.19.16.18.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jun 2022 16:18:46 -0700 (PDT)
From:   Max Filippov <jcmvbkbc@gmail.com>
To:     linux-xtensa@linux-xtensa.org
Cc:     Chris Zankel <chris@zankel.net>, linux-kernel@vger.kernel.org,
        Frederic Weisbecker <frederic@kernel.org>,
        Max Filippov <jcmvbkbc@gmail.com>
Subject: [PATCH 0/2] xtensa: context tracking updates
Date:   Sun, 19 Jun 2022 16:18:35 -0700
Message-Id: <20220619231837.1150499-1-jcmvbkbc@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        FROM_LOCAL_NOVOWEL,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Frederic,

your recent conversion of CONTEXT_TRACKING to CONTEXT_TRACKING_USER
missed the xtensa architexture. These two patches hopefully fix it.
Please take them to the tree that holds the rest of the conversion.
(Even better if they could be folded into the corresponding conversion
 patches).

Max Filippov (2):
  xtensa: rename context_tracking_user_{enter,exit}
  xtensa: rename CONTEXT_TRACKING to CONTEXT_TRACKING_USER

 arch/xtensa/Kconfig        | 2 +-
 arch/xtensa/kernel/entry.S | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

-- 
Thanks.
-- Max
