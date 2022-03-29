Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A461F4EB4A3
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:22:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbiC2UYI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:24:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbiC2UXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:23:38 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D0123B3DB
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:55 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h4so14234660edr.3
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:21:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fIs5jI9omv80B5uNj3oOSCaJBQX+29ujQ7UOt2Cbf58=;
        b=Jf9Ra5iHS5hioNaVO9GhdL/uG/444ph1zmk8dUfMXgNVj83UXcBTgmZOtWGdvqUIbx
         3u9vsnL3GcceGLKWE7h9bbTV9SWJESQPgF4kcb8psti+o0GS/btGAzv1tqbHwY+oQjOt
         JkBqL9Hyqppb0cEwNz7H17AyztFK0zcX3LBQftBbsEycfOFdliWjQhQOd0411Fqy2FSm
         myQNedrtJ0r0q0xxD530yD5pjCG7DqM42vYJm0N3Y+MxcaAQEBu51uM8pvhtob2JqivO
         8jocciF7IEnWwzhxFLNhtJsyCrlK4zXiC+A1eT4AwfPgA5PvOhWPPtSve0+pCI8gCZuD
         iq4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fIs5jI9omv80B5uNj3oOSCaJBQX+29ujQ7UOt2Cbf58=;
        b=IIyjmuqVeZYyX5hgfE6fbttL0w3XwcaN0bkTHKO44zAdOfWDxGvrLl6AoqYt0bI8Zj
         23rxBlh68sYJw1frzN6gOhOsPvtMphteqq6SuqvhG8NqqbpVZGjrWOvGr/SIo3iEQEdW
         2B1B5BT9djx2zJQlGHnmMOfrI7pIi/QVz+mvahb6tdYsX+kF7yun8PFbKjUyr5DLHga1
         xRRFP4vDF40p7d8TX/jVzNd3r2WB38rRg0GWSsnaNeIEEGHI+QoDOM10omeMwnY4yYwU
         p8Ql5A5kMltnWVtJaN/X3VRa/KU66h424GoiFQfNOKCCGXJwleyEDe8Lp85Nd00Slogw
         /Byw==
X-Gm-Message-State: AOAM531L/Y4yV3lX7jCI4Rijmg1OvhGETP0NopbKRRPWm4Cdcfj23T2e
        +nvd6lG2MyIZc2qFkRMMkVE=
X-Google-Smtp-Source: ABdhPJyJa+lNo2HUwnOhZSfYZOfzn0GkZx6F2p+5jGP+ETbLaJm7lunbaJHlO7RRzTMHAtEHDXhtlQ==
X-Received: by 2002:aa7:c056:0:b0:418:e8d7:52a3 with SMTP id k22-20020aa7c056000000b00418e8d752a3mr6703601edo.301.1648585313737;
        Tue, 29 Mar 2022 13:21:53 -0700 (PDT)
Received: from localhost.localdomain (ip5f5abb55.dynamic.kabel-deutschland.de. [95.90.187.85])
        by smtp.gmail.com with ESMTPSA id ss12-20020a170907038c00b006e0ec9e806dsm3938111ejb.136.2022.03.29.13.21.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Mar 2022 13:21:53 -0700 (PDT)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH v2 6/8] staging: r8188eu: simplify if-else statement
Date:   Tue, 29 Mar 2022 22:21:39 +0200
Message-Id: <20220329202141.7028-7-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220329202141.7028-1-straube.linux@gmail.com>
References: <20220329202141.7028-1-straube.linux@gmail.com>
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

Simplify a nested if-else statement to a single if-else statement in
rtw_set_threshold(). This improves readability and allows us to
remove the local variable threshold.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
v2: Better readable simplification.

 drivers/staging/r8188eu/core/rtw_mlme.c | 14 ++++----------
 1 file changed, 4 insertions(+), 10 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_mlme.c b/drivers/staging/r8188eu/core/rtw_mlme.c
index 086d64542082..1d52cfac1999 100644
--- a/drivers/staging/r8188eu/core/rtw_mlme.c
+++ b/drivers/staging/r8188eu/core/rtw_mlme.c
@@ -1789,20 +1789,14 @@ void rtw_update_registrypriv_dev_network(struct adapter *adapter)
 
 static void rtw_set_threshold(struct adapter *adapter)
 {
-	u8 threshold;
 	struct mlme_priv *mlmepriv = &adapter->mlmepriv;
 	struct ht_priv *htpriv = &mlmepriv->htpriv;
 
-	/*  TH = 1 => means that invalidate usb rx aggregation */
-	/*  TH = 0 => means that validate usb rx aggregation, use init value. */
-	if (htpriv->ht_option) {
-		if (adapter->registrypriv.wifi_spec == 1)
-			threshold = 1;
-		else
-			threshold = USB_RXAGG_PAGE_COUNT;
-
-		rtw_write8(adapter, REG_RXDMA_AGG_PG_TH, threshold);
+	if (htpriv->ht_option && adapter->registrypriv.wifi_spec != 1) {
+		/* validate usb rx aggregation, use init value. */
+		rtw_write8(adapter, REG_RXDMA_AGG_PG_TH, USB_RXAGG_PAGE_COUNT);
 	} else {
+		/* invalidate usb rx aggregation */
 		rtw_write8(adapter, REG_RXDMA_AGG_PG_TH, 1);
 	}
 }
-- 
2.35.1

