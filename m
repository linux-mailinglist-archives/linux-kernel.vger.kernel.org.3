Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C2C55A838
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbiFYJFE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:05:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbiFYJFD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:05:03 -0400
Received: from sender4-op-o11.zoho.com (sender4-op-o11.zoho.com [136.143.188.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0D233E06
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:05:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1656146995; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=eQ8vlQ/mEa0BTElFAADKoVMx03yLeGW9BpCjUAPi5WA/5sTo10Eh3ch2cp/Fh1nj8LRYwAItf/BUK6f2c9WUiwKpIpKN3jgSWzG5QPQY32/NoyZLZmZP+VQ4+id0UIyayLzKbbyDgB6yzcS92DvcaTZBYvpKQxB1ikQRJ1Tttdo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1656146995; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=73B7q5ose/xpDy9xdiy7dsAKG7gzYSYBRfHb0ImXIXY=; 
        b=hWOIinsJoGtVAHhY6hFjC60zeMiQtgzoM1vrqxjOYoUFWVTDfSpd98X2EfthJhk1RQBtY0b374u61Rw4eUI8wq+zWcJfdQ58SkEdpBNeSAvzQV6HDj4+IPEVLOBoe4HQwjdys//XGmBrw23Sia9xGp43QkVKvHp7syYyC8+JUGQ=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=gvisoc.com;
        spf=pass  smtp.mailfrom=gabriel@gvisoc.com;
        dmarc=pass header.from=<gabriel@gvisoc.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1656146995;
        s=zoho; d=gvisoc.com; i=gabriel@gvisoc.com;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=73B7q5ose/xpDy9xdiy7dsAKG7gzYSYBRfHb0ImXIXY=;
        b=AGLir0qMfZ+8+9RBF74CrrNnsDKka432+iidZEZtUxp0FnmjE5gjOpAsqOLg/Qdv
        7Ec8zqQzuidgW2c6D5ouxI3A8ubOnmB5b/60tRzPF52CVajdBaoSGc61vPAggQ1teox
        lwTH7KyqKtP7bKiC542a/b40mtH1Ghtrj81sYNLE=
Received: from localhost (124-171-144-237.tpgi.com.au [124.171.144.237]) by mx.zohomail.com
        with SMTPS id 1656146993489390.95142231892817; Sat, 25 Jun 2022 01:49:53 -0700 (PDT)
From:   Gabriel Viso Carrera <gabriel@gvisoc.com>
To:     andreas.noever@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Gabriel Viso Carrera <gabriel@gvisoc.com>
Subject: [PATCH 1/3] staging: Thunderbolt: ctl.c: Fixed 2 literal style coding issues
Date:   Sat, 25 Jun 2022 18:49:11 +1000
Message-Id: <20220625084913.603556-2-gabriel@gvisoc.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220625084913.603556-1-gabriel@gvisoc.com>
References: <20220625084913.603556-1-gabriel@gvisoc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In lines 1028 and 1054, there were WARN calls with hardcoded literal
function name. Replaced with the recommended %s and __func__.

Signed-off-by: Gabriel Viso Carrera <gabriel@gvisoc.com>
---
 drivers/thunderbolt/ctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/thunderbolt/ctl.c b/drivers/thunderbolt/ctl.c
index e92c658dba1c..4b841fbb3628 100644
--- a/drivers/thunderbolt/ctl.c
+++ b/drivers/thunderbolt/ctl.c
@@ -1025,7 +1025,7 @@ int tb_cfg_read(struct tb_ctl *ctl, void *buffer, u64 route, u32 port,
 		break;
 
 	default:
-		WARN(1, "tb_cfg_read: %d\n", res.err);
+		WARN(1, "%s: %d\n", __func__, res.err);
 		break;
 	}
 	return res.err;
@@ -1051,7 +1051,7 @@ int tb_cfg_write(struct tb_ctl *ctl, const void *buffer, u64 route, u32 port,
 		break;
 
 	default:
-		WARN(1, "tb_cfg_write: %d\n", res.err);
+		WARN(1, "%s: %d\n", __func__, res.err);
 		break;
 	}
 	return res.err;
-- 
2.36.1

