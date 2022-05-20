Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D71D52F301
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:35:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352764AbiETSfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352729AbiETSer (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:34:47 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87063195788;
        Fri, 20 May 2022 11:34:46 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id h5so11478293wrb.11;
        Fri, 20 May 2022 11:34:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CpYIZhKHdlhrBX2j3mBVDwD72KOGHk6Bi7vdThLJVUw=;
        b=E8P68JHjPhoZQKmLJXfzsg5h+CE1f2t5u81tRwz8baH/AqVaqv6QptKRwWJ7PW5J1g
         46GQm5UZJbTpS7269lvGTgqKgm2uEWPYorDGOe60tgZN+crQwIsxSK0mhzECjcAwmxLm
         z9sIo+SPu7kmAuKPXUJCs9IlnzAwDRJG4nw6JEUf1yqPde+iqwI3UokrcqVsC+oBNAjc
         70TB/eL9mbVGPbEARceHLUk2sDfC9lNXzCd1zrRXDcc3z5u85yMmYyKP9BJkErl5wIbu
         ShbWp6+tZzQAAAcziUPN5WfKn1DdPP3c+zYSAYJqmQGQ1EELxY3y9915UnUA4sd2zbwn
         w09Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CpYIZhKHdlhrBX2j3mBVDwD72KOGHk6Bi7vdThLJVUw=;
        b=30/sQTZOdFWnS89w9OJnsxPw8GwcjTTvTnVH2Nb2E09BQsrVIXwOb2OzJtucUyyXaS
         Tx+RgGVPrbCnqqjyovW4QQSjFPQEW+84d/Yki6/6Cb66J921EUVOV0rWv0vrCFMgNVhI
         cS394dyc/18wJUG7rGvWRlhAhMj1M/eAn+CASoDjcr0T0s9F0oEQtEmd5hI3tbVcfWgI
         uKmZBEWpwYcVlTxn/y0Yq282oTb/X8k20bHTrD8k7PMUR0jBBCeCFcdiwDwAS09ePGrO
         OtSge18QCV3nWSHhuKkwuFwxuctf7Pr6DG0xPaQYUEHiXMuxnASBHTaAPsUFbrVXSqT8
         lQAA==
X-Gm-Message-State: AOAM532GNEEkdYNX3CnclHULz2G6v36owuyake1dyX/ad80hu7K0nB73
        e8xwNJqTviQdesnhxQARYe0=
X-Google-Smtp-Source: ABdhPJwU0UVwYWxaEUN8lrV18/0WHkPw90A6EWXi40d/Rk9+bUJf1ONBWalV3nKumC17+VBx+2HcHA==
X-Received: by 2002:a05:6000:170a:b0:20e:712b:2d79 with SMTP id n10-20020a056000170a00b0020e712b2d79mr6832317wrc.388.1653071685121;
        Fri, 20 May 2022 11:34:45 -0700 (PDT)
Received: from xws.localdomain (pd9e5a9fe.dip0.t-ipconnect.de. [217.229.169.254])
        by smtp.gmail.com with ESMTPSA id r9-20020adfa149000000b0020e62feca05sm3252081wrr.32.2022.05.20.11.34.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:34:44 -0700 (PDT)
From:   Maximilian Luz <luzmaximilian@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Maximilian Luz <luzmaximilian@gmail.com>,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 04/10] power/supply: surface_charger: Use client device wrappers for notifier registration
Date:   Fri, 20 May 2022 20:34:16 +0200
Message-Id: <20220520183422.7185-5-luzmaximilian@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220520183422.7185-1-luzmaximilian@gmail.com>
References: <20220520183422.7185-1-luzmaximilian@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use newly introduced client device wrapper functions for notifier
registration and unregistration.

Signed-off-by: Maximilian Luz <luzmaximilian@gmail.com>
---
 drivers/power/supply/surface_charger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/power/supply/surface_charger.c b/drivers/power/supply/surface_charger.c
index a060c36c7766..59182d55742d 100644
--- a/drivers/power/supply/surface_charger.c
+++ b/drivers/power/supply/surface_charger.c
@@ -216,7 +216,7 @@ static int spwr_ac_register(struct spwr_ac_device *ac)
 	if (IS_ERR(ac->psy))
 		return PTR_ERR(ac->psy);
 
-	return ssam_notifier_register(ac->sdev->ctrl, &ac->notif);
+	return ssam_device_notifier_register(ac->sdev, &ac->notif);
 }
 
 
@@ -251,7 +251,7 @@ static void surface_ac_remove(struct ssam_device *sdev)
 {
 	struct spwr_ac_device *ac = ssam_device_get_drvdata(sdev);
 
-	ssam_notifier_unregister(sdev->ctrl, &ac->notif);
+	ssam_device_notifier_unregister(sdev, &ac->notif);
 }
 
 static const struct spwr_psy_properties spwr_psy_props_adp1 = {
-- 
2.36.1

