Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 45DA750E3C5
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 16:54:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242683AbiDYO57 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 10:57:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242605AbiDYO54 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 10:57:56 -0400
Received: from bee.birch.relay.mailchannels.net (bee.birch.relay.mailchannels.net [23.83.209.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A7FB36319
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 07:54:51 -0700 (PDT)
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id E5B484C131F;
        Mon, 25 Apr 2022 14:54:50 +0000 (UTC)
Received: from pdx1-sub0-mail-a217.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 3A4F04C14EF;
        Mon, 25 Apr 2022 14:54:50 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1650898490; a=rsa-sha256;
        cv=none;
        b=Qv5pdPBXIhhxPP0diy3cv44dDzGzcdi1DtgvFfn9fDpc+hBu0+5kjUsAZ2DZSsYGofm8K9
        gSwX54wG7e84VxuQV3omoyt/Ccw4Eca5Fv0+ynrOeBInDPoeJhxZVuf/9axO20DEtMPC51
        pUjfrlVznpXK1I7WsrFFrGvh3FVLr+TfziiNyOdt1kvW/tffyydM4oFvmHAtQdJSEcsHA5
        GCwKN4S3ldoOOmmCNBnO3fneIGrEfL/dEF2AVlFMal0KHnvLhOSn9cpzDj+iuxrbdo5CIn
        vmfLYI4iPZvGtYvsIYWslWdYF3pll7wVKqklu5KBp6FDzWr0Y3ztxA65qZd9lw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1650898490;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:dkim-signature;
        bh=E7RdCTV7+3DP95M5GJ/3bHKwcDL1cFUtBMaATWIA/jQ=;
        b=NNWXZ+aeIDDnfaN+xPtaep3ed8788+AR0D3Ywcw7vraURpVau6quoiljynN0vCClFtAdIR
        i30CXEnLR0AiHiTHeb6at0J3xkY4LrZiDx8Z4yaZ70+Kgkpd1nShENzuJ0iMHUimv03AzU
        mroTXfgsAysWFYKLbrRDRwlMc2ztTbBV/g7JF5GGMKM5VvdKYIlL4ZmQkgd56gLjE0Nsh4
        7aNqE1swOSPyiiIE/wolfi7abyFxSPV+rdY/YbdbueTYUbp9YBgSbMBxqlZTvgjuIerA9V
        BgmjWEdtCu8H69/ozcliqV+i+KC5qYCJCBfoVqGiCyfCLi9pcDCk+ago0m60QQ==
ARC-Authentication-Results: i=1;
        rspamd-67b64f579b-xzh56;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=ian@linux.cowan.aero
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|ian@linux.cowan.aero
X-MailChannels-Auth-Id: dreamhost
X-Spicy-Little: 6516efa239c93994_1650898490701_992106049
X-MC-Loop-Signature: 1650898490700:3349046989
X-MC-Ingress-Time: 1650898490700
Received: from pdx1-sub0-mail-a217.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.96.96.30 (trex/6.7.1);
        Mon, 25 Apr 2022 14:54:50 +0000
Received: from localhost.localdomain (unknown [69.12.38.97])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: ian@linux.cowan.aero)
        by pdx1-sub0-mail-a217.dreamhost.com (Postfix) with ESMTPSA id 4Kn7Ms1GtWznb;
        Mon, 25 Apr 2022 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.cowan.aero;
        s=dreamhost; t=1650898489;
        bh=E7RdCTV7+3DP95M5GJ/3bHKwcDL1cFUtBMaATWIA/jQ=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=b4KQS662s+1BjaJB2DzHSw7988VHh4EMJnvXH3HNOxUpkZo5ft9qVRx7cUHB3EoPt
         0DX6pItMkxYOP3COUU/xZFYlqsjTc6/aZvkiVdGhDu+1SqMh2moZXqGuxKmOiy9wZb
         CgIQr/rr4WHv6GZDlo8Hci63Hkg/Wzd1M8Zcsb2NSYHYrnZJQ/Mh1TwVtJbH1zoEdS
         Yyc7j8oAnwdJIeg66EtdFPjncU4oI0DTvMHIs28Rbwx0lRqnuUhnQtBbzL884PKuhP
         4IWbLf2PxG9bU6YnKK3MDta9ovBM2gVmtKfjzVMKidA2V89ZNWSgLkp/wlyfglDsPQ
         vBZgyLnxpTQqw==
From:   Ian Cowan <ian@linux.cowan.aero>
To:     Sven Van Asbroeck <TheSven73@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Ian Cowan <ian@linux.cowan.aero>
Subject: [PATCH] staging: fieldbus: remove unnecessary double negation
Date:   Mon, 25 Apr 2022 10:54:40 -0400
Message-Id: <20220425145440.146891-1-ian@linux.cowan.aero>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the double negation (!!) from the code since this does nothing
and may create confusion on whether or not those values are negated.

Signed-off-by: Ian Cowan <ian@linux.cowan.aero>
---
 drivers/staging/fieldbus/dev_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/fieldbus/dev_core.c b/drivers/staging/fieldbus/dev_core.c
index 5aab734606ea..6766b2b13482 100644
--- a/drivers/staging/fieldbus/dev_core.c
+++ b/drivers/staging/fieldbus/dev_core.c
@@ -28,7 +28,7 @@ static ssize_t online_show(struct device *dev, struct device_attribute *attr,
 {
 	struct fieldbus_dev *fb = dev_get_drvdata(dev);
 
-	return sprintf(buf, "%d\n", !!fb->online);
+	return sprintf(buf, "%d\n", fb->online);
 }
 static DEVICE_ATTR_RO(online);
 
@@ -39,7 +39,7 @@ static ssize_t enabled_show(struct device *dev, struct device_attribute *attr,
 
 	if (!fb->enable_get)
 		return -EINVAL;
-	return sprintf(buf, "%d\n", !!fb->enable_get(fb));
+	return sprintf(buf, "%d\n", fb->enable_get(fb));
 }
 
 static ssize_t enabled_store(struct device *dev, struct device_attribute *attr,
-- 
2.35.1

