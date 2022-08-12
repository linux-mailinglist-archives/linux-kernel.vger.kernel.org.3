Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1145590F83
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 12:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238494AbiHLKbx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 06:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237891AbiHLKbt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 06:31:49 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 276E385AB3;
        Fri, 12 Aug 2022 03:31:48 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id v5so401970wmj.0;
        Fri, 12 Aug 2022 03:31:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=lwAQMI1sAL0OklMDCRhkpjmWO5xQXlKD2t+9GjkTLnw=;
        b=NekzvIBGqbnM8R1wrIL/GvFCe4yE5MZrFY1tfBiajfkvjeIiwnLU+JvvBSlmTahAYo
         ciQPTPLL8rxdPdhA4sa5pvlLVw7bbFVmJuUGsLc8BdnszxYvgIJWAikgZHm2R4aInGoc
         hIYMrJ9nFYCl0N8jZ+lPSEccwC3cdm1t6ecijzzo4aw/WMHJi+RuKuDj+Yu31YMzGI4D
         uhoOfeod0J04/UuTRiSMoZaG0vSu0f6/f26ylaYYs7RVel0qfJDK2hkjv+MYk439Kizq
         vcIzPmRrNoRZW91ABJU/zzNenxPol8A3+q7im+o+9SUjzYidUyejrTiiocQHLOHLs3c4
         k+VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=lwAQMI1sAL0OklMDCRhkpjmWO5xQXlKD2t+9GjkTLnw=;
        b=7rbC6zE6+C9+XQETOVx0WIEL6M78qwZMhinF6Hb3izig1baoTT1NLwuvyxnJ4IBYBI
         gnFJ0x3xinl+88medP0gZRLD8yghkf334IozBmbO1eJ+Co+wlg4KSwvjZLK9wmqvs6Lb
         oDKAzESIldK9zWeoetnOwO/3a5C4J74vs6unc+YIqXtwoGcEFIiCgbXLmb5WtoPhOo7Y
         qMJG3IKMkExn7hYpgHd3Gcp250hlio/UOZ/skkqaj1Kv3nGjf2ulHaRojh5fglj4gx6r
         OnCWXIStbPhdR+wkEcZ9Ah6SvcRq6AkAD59LXJhCKbaNGrPP5070Zf8CNL4RsvV71Yw8
         wAWw==
X-Gm-Message-State: ACgBeo1eTGSdfLws5RfasDU1CVqWUb+flBdxMToKp39bIKTEx+Dj0oKO
        inMUjZQ8DRvDKQCHUuQHtjg=
X-Google-Smtp-Source: AA6agR6a/ubv/jrXzDWkpZHXoNmgI1hZ8w4fpubsarLbUPx/vETOkmuwHbsitJ5CuC2mydSeudM7WQ==
X-Received: by 2002:a1c:4c0d:0:b0:3a5:a401:a1ed with SMTP id z13-20020a1c4c0d000000b003a5a401a1edmr2079898wmf.15.1660300306640;
        Fri, 12 Aug 2022 03:31:46 -0700 (PDT)
Received: from felia.fritz.box (200116b826b2c500c09e217863a02585.dip.versatel-1u1.de. [2001:16b8:26b2:c500:c09e:2178:63a0:2585])
        by smtp.gmail.com with ESMTPSA id p35-20020a05600c1da300b003a35ec4bf4fsm2487837wms.20.2022.08.12.03.31.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 03:31:46 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH v2] wifi: mac80211: clean up a needless assignment in ieee80211_sta_activate_link()
Date:   Fri, 12 Aug 2022 12:31:26 +0200
Message-Id: <20220812103126.25308-1-lukas.bulwahn@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 177577dbd223 ("wifi: mac80211: sta_info: fix link_sta insertion")
makes ieee80211_sta_activate_link() return 0 in the 'hash' label case.
Hence, setting ret in the !test_sta_flag(...) branch to zero is not needed
anymore and can be dropped.

Remove a needless assignment.

No functional change. No change in object code.

Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
---
v1 -> v2: remove the needless braces.

 net/mac80211/sta_info.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cb23da9aff1e..8402a5a65370 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2777,10 +2777,8 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 
 	sta->sta.valid_links = new_links;
 
-	if (!test_sta_flag(sta, WLAN_STA_INSERTED)) {
-		ret = 0;
+	if (!test_sta_flag(sta, WLAN_STA_INSERTED))
 		goto hash;
-	}
 
 	ret = drv_change_sta_links(sdata->local, sdata, &sta->sta,
 				   old_links, new_links);
-- 
2.17.1

