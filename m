Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311844ACB70
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 22:41:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241044AbiBGVko (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 16:40:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240208AbiBGVkl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 16:40:41 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3C4C061355
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 13:40:40 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id i186so15354490pfe.0
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 13:40:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUCNvjYGBjDLOWx0oqjTNqXH/Yx+Zia2/rtd6r5omRs=;
        b=O7m2P73zV+5NeLlFCzV7cYTbgTSOFUB6jKeJh5bYZY4eykQxfb6J0TLyiaKsWAsdlk
         51kBcDc1bKUHh4BVAuzZ6upxW7bHVwRpqqnKJvzIa9+dNjz1bYnWjYTlq34sKe9ArSVk
         tQKETIKuouocyHBnM+j7QR3RZ1IK/EC+LX6YI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=TUCNvjYGBjDLOWx0oqjTNqXH/Yx+Zia2/rtd6r5omRs=;
        b=niuLByBafaeAx28wiejleO3sOUz2WgkbrMtGt61d5UfOkn2YqygbdY0J9x7Y5YZB6r
         GpKT7FzpxCn4JbF1N6sXFLKlnsPCjw7VTl4yAaloK5oxhX4oromfJuN+7aX2Or2BS7Qx
         OexdcGXQZqtD5qKO1BRYkhwhfnxnX6rcZo4SlBtF9ev1px8aKg1/5GCwBQADKeLyHIO0
         R8DMUO+miHKkiCZ/hE+5ESW1V4Swt6ftKtknO88dhDIVwvcdEtv+XH6SimvV9jT4X/oq
         o7gHz140Y+Gs2tm6ifGmoTE8aYBukbLKifu/qquVX5VQlb3s+2ya1nug5PzNV20yY32n
         BSGA==
X-Gm-Message-State: AOAM531ebWDGaQY0DzUdcGP7eIYU6pvrqNrzUOEOPIA92L8NgZIqBU4O
        QFO4inj1bNwJgeIlD+opyh5dPm3AMflEZQ==
X-Google-Smtp-Source: ABdhPJy2uusfp5RUHaUg38A19JuXK7AQln9SqEclfLmCzpUTINXPSo4Jt2gaG4sSxhwgVB7W2mNt/w==
X-Received: by 2002:a05:6a00:1514:: with SMTP id q20mr1467788pfu.74.1644270039871;
        Mon, 07 Feb 2022 13:40:39 -0800 (PST)
Received: from pmalani.c.googlers.com.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id s9sm9268010pgm.76.2022.02.07.13.40.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Feb 2022 13:40:39 -0800 (PST)
From:   Prashant Malani <pmalani@chromium.org>
To:     linux-kernel@vger.kernel.org
Cc:     Prashant Malani <pmalani@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        chrome-platform@lists.linux.dev (open list:CHROMEOS EC USB TYPE-C
        DRIVER), Guenter Roeck <groeck@chromium.org>
Subject: [PATCH 0/4] platform/chrome: cros_ec_typec: Reorganize mux configuration
Date:   Mon,  7 Feb 2022 21:40:22 +0000
Message-Id: <20220207214026.1526151-1-pmalani@chromium.org>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
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

This is a short series that reorganizes when mux configuration occurs
during Type C port updates. The first 2 patches are minor refactors
which move some of the mux update logic to within
cros_typec_configure_mux(). The third patch moves
cros_typec_configure_mux() itself to be earlier in
cros_typec_port_update().

The final patch updates the stashed mux flag when a partner removal has
occured.

Prashant Malani (4):
  platform/chrome: cros_ec_typec: Move mux flag checks
  platform/chrome: cros_ec_typec: Get mux state inside configure_mux
  platform/chrome: cros_ec_typec: Configure muxes at start of port
    update
  platform/chrome: cros_ec_typec: Update mux flags during partner
    removal

 drivers/platform/chrome/cros_ec_typec.c | 76 +++++++++++--------------
 1 file changed, 34 insertions(+), 42 deletions(-)

-- 
2.35.0.263.gb82422642f-goog

