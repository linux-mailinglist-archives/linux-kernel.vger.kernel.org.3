Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 532ED4C4455
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 13:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240529AbiBYMJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 07:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240493AbiBYMJh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 07:09:37 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DCDB1D8AB9
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:05 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id gb39so10486904ejc.1
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 04:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=GENNLaQhNZpnjjnz6C1PcYTzISYUuvw5z52vl9WFlyg=;
        b=l+HEuc36ChZ+EJy3l9Z5lwsRxjWcJGD23wiQXMPhnlRZ6EZ6LjB2SrV6v6hPNrcj5E
         9UKOz93KGaBgkKyfg2buFRE5UuvIp3iBRzdky3Og4Hpv/np7dil/FppyB/Iw5eqaupN2
         mB3Hso+pC1ivFr+zdKrMxEYE0WM3Q2SpV/MvhilHorEqQcCrJmKpjRouSjqeyZfVKmkQ
         kYZDeXi073ryB5NvFOsvKQgphbo5mt652Ka5BPUHldBT+bpUs7AvylI4seu2VXfUCXMF
         glcI8gnrEkwwkBLLlHH1Lx+6UvF+epjfuM12Qp2thJPbR/8VoUpp1iHnO6V6StChbeCX
         GkVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=GENNLaQhNZpnjjnz6C1PcYTzISYUuvw5z52vl9WFlyg=;
        b=Au70LUM1a8JXKVYtrUNk7DjjmP7oUbwPrPn56TMnZaUwVvv2SMLMFGtqQIKRGyhRrf
         5fBJMh5lqFcVmrwqdnTtp+k3O7Q2VAFpjkqULxM6jlIskPA/Tnk1RwQo9XKTF4J8neUB
         tAw2N/8KMZ3d9+U1GercqhUO5Y5Xr4AhFqJnuU/fJkZfuthTsoWAJnY0dGFBfQXpwjd7
         +gbUtzjWVnCOdCfNFpZUZq5oOMEmrovLUBn5U6AgQUJLzqGWP8fZviI8gMZbvfaypDEi
         Itw5Ed/1rhA0vvqW4LzcZBrZmbsDwKH25c39MDCTp64DkhgoyrXVJgJbBY+ok0hkbwrl
         /rBQ==
X-Gm-Message-State: AOAM532Kl7f/Wh/B4t5HpXalJkrUjLQYYSpVQUG1zS8k39ke19pchSpn
        wqoYkmoR26zOzEVRqd6Zy/Y=
X-Google-Smtp-Source: ABdhPJzkd3ES32Z7qBR4343VTRkejdGJHQr2pHRW66977S7YfesYu6A6Y58JDxjeg+P5wGO5D6m1og==
X-Received: by 2002:a17:906:8681:b0:6ce:d45f:1689 with SMTP id g1-20020a170906868100b006ced45f1689mr5768356ejx.183.1645790943867;
        Fri, 25 Feb 2022 04:09:03 -0800 (PST)
Received: from localhost.localdomain (ip5f5abb8d.dynamic.kabel-deutschland.de. [95.90.187.141])
        by smtp.gmail.com with ESMTPSA id y14-20020a50eb8e000000b00410a2e7798dsm1229418edr.38.2022.02.25.04.09.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Feb 2022 04:09:03 -0800 (PST)
From:   Michael Straube <straube.linux@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Michael Straube <straube.linux@gmail.com>
Subject: [PATCH 3/4] staging: r8188eu: remove update_bcn_p2p_ie()
Date:   Fri, 25 Feb 2022 13:08:42 +0100
Message-Id: <20220225120843.10674-4-straube.linux@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220225120843.10674-1-straube.linux@gmail.com>
References: <20220225120843.10674-1-straube.linux@gmail.com>
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

The function update_bcn_p2p_ie() is empty. Remove it.

Signed-off-by: Michael Straube <straube.linux@gmail.com>
---
 drivers/staging/r8188eu/core/rtw_ap.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/staging/r8188eu/core/rtw_ap.c b/drivers/staging/r8188eu/core/rtw_ap.c
index ed66331de319..2ff78ed1faab 100644
--- a/drivers/staging/r8188eu/core/rtw_ap.c
+++ b/drivers/staging/r8188eu/core/rtw_ap.c
@@ -613,16 +613,10 @@ static void update_bcn_wps_ie(struct adapter *padapter)
 	kfree(pbackup_remainder_ie);
 }
 
-static void update_bcn_p2p_ie(struct adapter *padapter)
-{
-}
-
 static void update_bcn_vendor_spec_ie(struct adapter *padapter, u8 *oui)
 {
 	if (!memcmp(WPS_OUI, oui, 4))
 		update_bcn_wps_ie(padapter);
-	else if (!memcmp(P2P_OUI, oui, 4))
-		update_bcn_p2p_ie(padapter);
 }
 
 void update_beacon(struct adapter *padapter, u8 ie_id, u8 *oui, u8 tx)
-- 
2.35.1

