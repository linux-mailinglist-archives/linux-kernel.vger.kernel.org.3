Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4835AA2C2
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 00:19:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235182AbiIAWTV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 18:19:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234773AbiIAWST (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 18:18:19 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D1F55A14D
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 15:18:08 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id w28so224184qtc.7
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 15:18:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=Uetgjnmco7XMjJ0pPvFMMYQeK2oqyNBCbg9zI/9WK6U=;
        b=Qlh767M6LCeX0fcTUExKI0vDqoTRBfz2hg5EurE23Vs4l8vVL/qjU47CREwknrDU0m
         rLGyL/hdoXaQ3k8Vo5xqmJuRolH5BcV8urpgipRpHre9ncZoZRuwvvGiH/z84Xkf9PKx
         w32OhzRkeqYAp5tKbH/fi2wbMWp9nPLv/U/O4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=Uetgjnmco7XMjJ0pPvFMMYQeK2oqyNBCbg9zI/9WK6U=;
        b=nq3aUTRsqln4odhSFxpqdPRDu+HuWBYF42wnXC79LbJuEtstcIh4THFhXAAoJ/VDE1
         1I+BnXMhiAjy3HU0gALHS1/gnlZYiWSo3ZHZDpfQuvGzYwhD8Ie96lkrSJRdneNPeJzP
         kIWh8yRjDS0o+TZUesWJ0JeUNYhS0U/GERnutG3S7o5UJiaFO396pS/rGfPm4G18fSC3
         Od/xC+2Nwhs7M2ftmex++6BbFxAJiJFg4e7FCfV3oDZzbJy6Fc6MGbUUHgzdHMPsLK0+
         nhNE6bNWOXIVpIohayroCibqDTUzNa0faW8SSmYDyymYfKg56SdZplXULf05FXY5VxVG
         xZ8g==
X-Gm-Message-State: ACgBeo3txMgK7Fj5Zyhjp78AIb5sPvGKkBMYS5OJuRmQmiFtzRgzlvZB
        GAFw6xIqN56gi1q8+GLioTnMdw==
X-Google-Smtp-Source: AA6agR7NX0LPVmvfR8AYnY7HzxGSlvcrW6s4HEA32zP4sXGb6qTrqmmBag2GXgdyln10oQkqNMt8zw==
X-Received: by 2002:ac8:5a96:0:b0:344:b3be:6931 with SMTP id c22-20020ac85a96000000b00344b3be6931mr25930091qtc.509.1662070687197;
        Thu, 01 Sep 2022 15:18:07 -0700 (PDT)
Received: from joelboxx.c.googlers.com.com (228.221.150.34.bc.googleusercontent.com. [34.150.221.228])
        by smtp.gmail.com with ESMTPSA id s16-20020ac85290000000b0034305a91aaesm11060794qtn.83.2022.09.01.15.18.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Sep 2022 15:18:06 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, rushikesh.s.kadam@intel.com,
        urezki@gmail.com, neeraj.iitr10@gmail.com, frederic@kernel.org,
        paulmck@kernel.org, rostedt@goodmis.org, vineeth@bitbyteword.org,
        boqun.feng@gmail.com,
        "Joel Fernandes (Google)" <joel@joelfernandes.org>
Subject: [PATCH v5 14/18] net/core: Move call_rcu() to call_rcu_lazy()
Date:   Thu,  1 Sep 2022 22:17:16 +0000
Message-Id: <20220901221720.1105021-15-joel@joelfernandes.org>
X-Mailer: git-send-email 2.37.2.789.g6183377224-goog
In-Reply-To: <20220901221720.1105021-1-joel@joelfernandes.org>
References: <20220901221720.1105021-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is required to prevent callbacks triggering RCU machinery too
quickly and too often, which adds more power to the system.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 net/core/dst.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/core/dst.c b/net/core/dst.c
index bc9c9be4e080..babf49e413e1 100644
--- a/net/core/dst.c
+++ b/net/core/dst.c
@@ -174,7 +174,7 @@ void dst_release(struct dst_entry *dst)
 			net_warn_ratelimited("%s: dst:%p refcnt:%d\n",
 					     __func__, dst, newrefcnt);
 		if (!newrefcnt)
-			call_rcu(&dst->rcu_head, dst_destroy_rcu);
+			call_rcu_lazy(&dst->rcu_head, dst_destroy_rcu);
 	}
 }
 EXPORT_SYMBOL(dst_release);
-- 
2.37.2.789.g6183377224-goog

