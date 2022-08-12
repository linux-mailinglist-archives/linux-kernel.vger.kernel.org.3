Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B30C590E53
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238016AbiHLJpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232812AbiHLJpK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:45:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779B3AA4C4;
        Fri, 12 Aug 2022 02:45:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id j8so1095345ejx.9;
        Fri, 12 Aug 2022 02:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc;
        bh=Bvhapg50EtdPV5mahEm3KX87tXIOFG45bjV4IviwH/o=;
        b=ScZcWwo95wuKnXA3/3Be64uPZLPrMdenrkxN+h3I6SgsjySkJh7vGwNDwWvzbQyZqo
         Oo0TjuXNPqRAeuBZFWcuPzSrD+t423PjbeRxSZnwnzdubKBLoYY/XFAsoEinPVhKZv4M
         wnHHSrD0QCN6kcwpFYHUIPLXyjue3xrgmgTz9iNWN1Ka46F+CyyJQsyy3bANIcTqrJw2
         cpmfkVrqhjjAGTrwpxa/rbOMURo3bhIuKiKyW60bEkA0e603um/v9Tv1dd6EpiXLiwY5
         10VHcKo4iEdufDKSy7PrSvAeZ4+rA/vDOqf5itccsP+31RK8GaOR98C229OY2AgamByG
         lLqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Bvhapg50EtdPV5mahEm3KX87tXIOFG45bjV4IviwH/o=;
        b=lH304hu6/6Px3zBoqBsL8XZLc/wBTIjQakgOTrey62YFO4fgtLbCZ/CNDVzFSbHiwI
         AvfWSk9tEOI1zSCgOxJpgvS3H+UKgTispVWyIiyS3uabW2Emcz8OnlEkBPd0EAY5uoK2
         rHx/wP7ncX2+YOn5Z5EwFFqpkzR4P0G9ndnYAIgYZACRv5r4qpeHAjLWxWxHHaGwi3tE
         sCRPnVbfxdK9k9n2JsomNySRUnER7+TlxFC57JEFqy6kJ5pVkcOVDhbmzGeMiXwYm5aX
         Vp/dz+s3c7oXDp5IIaWAKq+Fr0vwc2d2tQ4gEsg0cvTaGf3pamz1cjn9hs8s3OqcweG8
         2FUg==
X-Gm-Message-State: ACgBeo3qAk286SPVo2aleK6IB70L2GvgyINi+yuzYvRLc0bKTz/nlDdy
        BtvZYZ3fKV/zwJwwid3ppbcAAMYK6Kk=
X-Google-Smtp-Source: AA6agR6OfSGqMLiQydJi4DUwK/PDWIFhoCKvPesRfKrUuEr+fZrn/yQr7OCvc9fsg6iulMv0pi+UTA==
X-Received: by 2002:a17:907:86ac:b0:731:5180:8aa0 with SMTP id qa44-20020a17090786ac00b0073151808aa0mr2181559ejc.366.1660297507917;
        Fri, 12 Aug 2022 02:45:07 -0700 (PDT)
Received: from felia.fritz.box (200116b826b2c500c09e217863a02585.dip.versatel-1u1.de. [2001:16b8:26b2:c500:c09e:2178:63a0:2585])
        by smtp.gmail.com with ESMTPSA id u15-20020a056402064f00b0043a7c24a669sm1047456edx.91.2022.08.12.02.45.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 12 Aug 2022 02:45:07 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
To:     Johannes Berg <johannes@sipsolutions.net>,
        linux-wireless@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: [PATCH] wifi: mac80211: clean up a needless assignment in ieee80211_sta_activate_link()
Date:   Fri, 12 Aug 2022 11:44:38 +0200
Message-Id: <20220812094438.18291-1-lukas.bulwahn@gmail.com>
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
 net/mac80211/sta_info.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/net/mac80211/sta_info.c b/net/mac80211/sta_info.c
index cb23da9aff1e..492c7a29d797 100644
--- a/net/mac80211/sta_info.c
+++ b/net/mac80211/sta_info.c
@@ -2778,7 +2778,6 @@ int ieee80211_sta_activate_link(struct sta_info *sta, unsigned int link_id)
 	sta->sta.valid_links = new_links;
 
 	if (!test_sta_flag(sta, WLAN_STA_INSERTED)) {
-		ret = 0;
 		goto hash;
 	}
 
-- 
2.17.1

