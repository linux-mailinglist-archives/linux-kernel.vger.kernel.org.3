Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B731F533CF9
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:51:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243612AbiEYMub (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:50:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243813AbiEYMuL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:50:11 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A8497B9FF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:50:10 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id BF1F13F5F0
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 12:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1653483008;
        bh=9zHgR3b+SGsLsYl7DYzLJLfkkfd5/6w+v2TQTn+n5EE=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version;
        b=M5mHq5mYsiTjjyvXcmX2uphLw/sEo0mkV02WapuTeQIrQbqIes/Z0GQgOxxLItduz
         dQGrkubv7BI2//+8upmbxhjU0ly1lsUV6rtEzVjvGhns1EEKVZA0iP5mKgYb5pMTZ5
         dwa3WFp81gV7AfTJn/a9+rHnO4s0Xyq0O+49uNh3tnlTkZxtSzghZWOq0+ea2kTjCj
         Wax5G8BcrF0EZQmAnRU+x1qnlk1CWLjIG0jsdlGuIpH8XZsjJLn1fGc7q/gLvlvXxY
         oqwI8Aqz71K3SZ5pFZMQ5hJwIIymAsx7IAdftRMfAgqzE+/43fHNXCqgSL/Y52m9Yy
         W6/rt1/2Ejm5A==
Received: by mail-ed1-f69.google.com with SMTP id j7-20020a056402238700b0042b9c2e9c64so2434594eda.19
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:50:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9zHgR3b+SGsLsYl7DYzLJLfkkfd5/6w+v2TQTn+n5EE=;
        b=PLnSiCzePf1CODuHbJcxgX4YJ28VUa/VIp36/V6qzcX0UTndaCKuH/6jubinpKpGoH
         6z2HCApfkZ9y+otSex/oMGUnsr9cyNkvfganuUxvMvIBJWpl1CoTwX681CZuwK2Zy3tr
         PvZikBDPOpZIqBBplgRH+WnsiOuAfgGmMaT9sgvNT+kcr3ybVciyjiHm0lSYeEAdmHu1
         CH1ajMKnlRfYxJzri+ruNUr4UbnwOdA0izk8eI8dILtuzxt1YmQSwpfyCzDozUITA/nY
         R5LKBcdu5ojVB/dtPi7GJPGt9KF5G4lTT4KI6amEzJlKD92AwIu4+tfmld+YWG5PRSsQ
         p4Mw==
X-Gm-Message-State: AOAM5323vsg0WRoQIveLVVnKkMce0wF6VkkLUdhKBqSCTcG3p86n0aTb
        z9EdkY+KriaK7SFGLzYWteJDD2u5xM0RMRGbe32KA/FWgKyRrWzi0tnceWmbGMSc+3V0D6Wb43k
        geJ/VqMa4KNoecateRv3mIoN/tN4oXBs6GeaZf//yCw==
X-Received: by 2002:a17:907:3e8f:b0:6fe:d023:e147 with SMTP id hs15-20020a1709073e8f00b006fed023e147mr14990351ejc.270.1653483008492;
        Wed, 25 May 2022 05:50:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyX4EIg1hekBM8pH38rwZllKq3CO7LQGZ92PSFO37AeFZWIji2YucWxSEIeinyNYNn2xiO+oA==
X-Received: by 2002:a17:907:3e8f:b0:6fe:d023:e147 with SMTP id hs15-20020a1709073e8f00b006fed023e147mr14990336ejc.270.1653483008315;
        Wed, 25 May 2022 05:50:08 -0700 (PDT)
Received: from gollum.fritz.box ([194.191.244.86])
        by smtp.gmail.com with ESMTPSA id l8-20020a1709060e0800b006f3ef214e62sm2860566eji.200.2022.05.25.05.50.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 05:50:07 -0700 (PDT)
From:   Juerg Haefliger <juerg.haefliger@canonical.com>
To:     richard@nod.at, anton.ivanov@cambridgegreys.com,
        johannes@sipsolutions.net, linux-um@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org,
        Juerg Haefliger <juerg.haefliger@canonical.com>
Subject: [PATCH 1/2] um: Kconfig: Fix indentation
Date:   Wed, 25 May 2022 14:50:00 +0200
Message-Id: <20220525125001.47009-2-juerg.haefliger@canonical.com>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220525125001.47009-1-juerg.haefliger@canonical.com>
References: <20220525125001.47009-1-juerg.haefliger@canonical.com>
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

Signed-off-by: Juerg Haefliger <juerg.haefliger@canonical.com>
---
 arch/um/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/um/Kconfig b/arch/um/Kconfig
index 4d398b80aea8..12fe6a08dc35 100644
--- a/arch/um/Kconfig
+++ b/arch/um/Kconfig
@@ -81,7 +81,7 @@ config ARCH_HAS_CACHE_LINE_SIZE
 source "arch/$(HEADER_ARCH)/um/Kconfig"
 
 config MAY_HAVE_RUNTIME_DEPS
-        bool
+	bool
 
 config STATIC_LINK
 	bool "Force a static link"
-- 
2.32.0

