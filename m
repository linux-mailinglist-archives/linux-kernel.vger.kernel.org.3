Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA6A753EF6E
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 22:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233322AbiFFUTL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 16:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233891AbiFFUS6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 16:18:58 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B65BD5F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 13:18:46 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id h1so12989598plf.11
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 13:18:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAlsC0h5lJCHopuggZD7f+zz1bUnWsXyG9PWIkU6Y+0=;
        b=ke+dA0R0UcPduUVRV2FXD2PjVf/XTJl1ISNU7QZSaoQ5timKMdBpps4QhF7AmOrLCl
         AOOxm+gw+9qf/9Xinr9iE0yrg9SRY2mOA1WoSu1utrkhipzXioFCFGylTuYSTuuZr2Jm
         13zjEnDUxP1KxrqNVTLAvehtDotVwQJ0rDbhY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YAlsC0h5lJCHopuggZD7f+zz1bUnWsXyG9PWIkU6Y+0=;
        b=qXcA5VshZN5MEGTN8ctFhPAKshEAX9wHHa6gvFLeZ4IQ57WqqbWil7XBXdkL72rJVc
         JmUfjdBsLKCzurX2Wy56mdb23fXsr5XHcHpxDknZ5TABtbVRGrZs0LHnZ5V7KURiLQDl
         Vnn5eM9bPDOtvns7j2jNal1Otd2P5TUHon3hqgzEBkLFsnIxqRPj3w8rYUdXUfT8km4E
         wKF4c/xLvURtbL3GyZx+TEryUTgvbWvrtTVAiHYHgXeMmIMyM+k6NApEArpl7X0jVCS9
         0f9/Wsij3ScFa0XSwT+wFEVHdahCZ0CxGuhcFvM318jYiLnB1eBBKsqmGN0aH3nZH5l5
         0jtA==
X-Gm-Message-State: AOAM532GdXWx1uJuViOh9TUPjwz5RFRFnM/5aMsSfhBJ4mSm7S+/cDTl
        fsAu9IZDWoFzTIjkZLhA2xwbrOUd5FQxlIJf
X-Google-Smtp-Source: ABdhPJxfTNfRlDzcEtbKKPeM95NhovvrUH81ZWKOfqkm4zJBNTQwYGnjfGyo0SpIDvpZh2V9lfWHlg==
X-Received: by 2002:a17:90b:5091:b0:1e8:990c:f735 with SMTP id rt17-20020a17090b509100b001e8990cf735mr2428046pjb.153.1654546725832;
        Mon, 06 Jun 2022 13:18:45 -0700 (PDT)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id l5-20020a170902d34500b0015ef27092aasm10883034plk.190.2022.06.06.13.18.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 13:18:45 -0700 (PDT)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     bleung@chromium.org, Prashant Malani <pmalani@chromium.org>,
        Brian Norris <briannorris@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROME HARDWARE PLATFORM
        SUPPORT), Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>
Subject: [PATCH 0/3] platform/chrome: cros_ec_command() improvements
Date:   Mon,  6 Jun 2022 20:17:59 +0000
Message-Id: <20220606201825.763788-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a short series related to cros_ec_command(). The first patch
updates a couple of Cros EC regulator callsites to use the common
cros_ec_command(). The next couple of patches do a rename and argument
type update.

Prashant Malani (3):
  regulator: cros-ec: Use common cros_ec_command()
  platform/chrome: cros_ec_proto: Rename cros_ec_command function
  platform/chrome: cros_ec_proto: Update size arg types

 drivers/mfd/cros_ec_dev.c                   |  4 +--
 drivers/platform/chrome/cros_ec_proto.c     | 22 ++++++------
 drivers/platform/chrome/cros_ec_typec.c     | 39 ++++++++++-----------
 drivers/platform/chrome/cros_usbpd_notify.c |  4 +--
 drivers/regulator/cros-ec-regulator.c       | 36 ++-----------------
 include/linux/platform_data/cros_ec_proto.h |  4 +--
 6 files changed, 39 insertions(+), 70 deletions(-)

-- 
2.36.1.255.ge46751e96f-goog

