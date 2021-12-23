Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DA4747E65E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Dec 2021 17:29:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349173AbhLWQ3C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Dec 2021 11:29:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:58733 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244177AbhLWQ3A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Dec 2021 11:29:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640276940;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=uJOgwGjirTFzn7tlsminzBCCoKOlNNhzzWyCm3307/w=;
        b=W7B8WUN5853U2fYYRj6Np7g0yLSEktdwrs78j+Wajb0rVDOhiaffEiJD0nWxCOoKzwQwxW
        AH7/yenTQ7b3qnVTh1bbrncrKgEuRpMoKBk665l4sWhJ+7grtCmaFqogtYW2MbRhrKTndT
        EkNWgFqXi5C++BUpUUR0KIDh48exRIk=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-dbVh3u5lNPCuNghH0veA3w-1; Thu, 23 Dec 2021 11:28:58 -0500
X-MC-Unique: dbVh3u5lNPCuNghH0veA3w-1
Received: by mail-qv1-f69.google.com with SMTP id gv14-20020a056214262e00b0041192fab00dso1672005qvb.23
        for <linux-kernel@vger.kernel.org>; Thu, 23 Dec 2021 08:28:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uJOgwGjirTFzn7tlsminzBCCoKOlNNhzzWyCm3307/w=;
        b=zHlU0kY15VL/LFVrbKGU8nZL2/jYJ+wSEUNT/IWuZjIhLm/S0t+dSKBXH6rENx9cA/
         Nsoq6gIiKAjqzXzrSEADCMrTLnNnnVwsi2cF8SWoGpwqX5GCAvJ2oEWDgP/qp/eIXKdo
         OeiahBg6yPTbJJ+QTZVXXuQsPAdYx7QlzPDl7hDCfnS8JBa2qpNppohwth43DSPVurZE
         ajFieqI43hjcr+7+DAPqC4jbUw29YYfphgzu/lKO0J/c6x1qMZqD/hGXOhxV3g35ra31
         rdDLS5rrQlL7KVby+4Ojs2xnn4VRbvI6O31scY5h/kYzq/iTiPwgluCO3PvGtzW0s1Ej
         kaDQ==
X-Gm-Message-State: AOAM533asQoJyBn10tZqsiN0wb9Sbyucpxgd0xYF7YYqzIZJg0igPSZd
        g5p03+IkFWPqUJ9yKVhdxUfPeOvuqtbm5q4Hs8rUDQef6XU94C2qcpupD0V+cnRsvaU81odDmYQ
        kOfb1UJYGneaDWUu8Ekbx/hs+
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr1907012qke.480.1640276938439;
        Thu, 23 Dec 2021 08:28:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwzpz9zm2A3nxoNm6dr+ZZ7zHfR2tVjNN8kjrl0r7RnwHfLx6ohxoG8UtvwJHnYzNd5uok2bw==
X-Received: by 2002:a37:a8cc:: with SMTP id r195mr1906996qke.480.1640276938135;
        Thu, 23 Dec 2021 08:28:58 -0800 (PST)
Received: from localhost.localdomain.com (075-142-250-213.res.spectrum.com. [75.142.250.213])
        by smtp.gmail.com with ESMTPSA id u11sm4743795qtw.29.2021.12.23.08.28.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Dec 2021 08:28:57 -0800 (PST)
From:   trix@redhat.com
To:     johannes@sipsolutions.net, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com, linville@tuxdriver.com
Cc:     linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mac80211: initialize variable have_higher_than_11mbit
Date:   Thu, 23 Dec 2021 08:28:48 -0800
Message-Id: <20211223162848.3243702-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this warnings

mlme.c:5332:7: warning: Branch condition evaluates to a
  garbage value
    have_higher_than_11mbit)
    ^~~~~~~~~~~~~~~~~~~~~~~

have_higher_than_11mbit is only set to true some of the time in
ieee80211_get_rates() but is checked all of the time.  So
have_higher_than_11mbit needs to be initialized to false.

Fixes: 5d6a1b069b7f ("mac80211: set basic rates earlier")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/mac80211/mlme.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/mac80211/mlme.c b/net/mac80211/mlme.c
index 51f55c4ee3c6e..766cbbc9c3a72 100644
--- a/net/mac80211/mlme.c
+++ b/net/mac80211/mlme.c
@@ -5279,7 +5279,7 @@ static int ieee80211_prep_connection(struct ieee80211_sub_if_data *sdata,
 	 */
 	if (new_sta) {
 		u32 rates = 0, basic_rates = 0;
-		bool have_higher_than_11mbit;
+		bool have_higher_than_11mbit = false;
 		int min_rate = INT_MAX, min_rate_index = -1;
 		const struct cfg80211_bss_ies *ies;
 		int shift = ieee80211_vif_get_shift(&sdata->vif);
-- 
2.26.3

