Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2DE25606B8
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 18:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiF2QxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 12:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231844AbiF2Qwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 12:52:36 -0400
Received: from crane.ash.relay.mailchannels.net (crane.ash.relay.mailchannels.net [23.83.222.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4244013F81;
        Wed, 29 Jun 2022 09:52:33 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id A8CD6121B70;
        Wed, 29 Jun 2022 16:52:29 +0000 (UTC)
Received: from pdx1-sub0-mail-a288.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id E3364121691;
        Wed, 29 Jun 2022 16:52:28 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1656521549; a=rsa-sha256;
        cv=none;
        b=463jQEBgMFV74iEN+TnjsqGLipT5PWEq525tmOOCXli2QbepPoKWvKoguaEQfzeijCtpMs
        W0Y97rPbnNRm5r68xkw/uDqYRtflxSW4NoRTk6daRuCoMasw/okGBZzKsPuY2U446Pmfuk
        Tw+3Ir/hZn0iLQjoetTKNhnkSG0/izN1BgwDhJVVxSqZsXG0qzKYONLsPTlNHhozGO9XH5
        P40XbXUC0RgHfVa70kpC6k+O+dYjNKtw/5K4C7G5jRWfZPyPfD73wUggz8cOy9YswZxBf1
        oNpEcjot3rpRasydqHE6CJZssYNhy+Q3oXSH+myVm++K71/uWbeT8ae6u5Vr9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1656521549;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=iOLcV9f/LV1oZPOPbY/80a03Bs1TUR8dCN1QpbUZqE4=;
        b=dwekxzYpGBHTWMNG8EsSYmZe8KeQDDal4JrGNI/IFmUff19uLy00pgxROV5In2U1C/GEKG
        vW/lDEU/6eBJy2J7FgVHjmliwPdedvin/wuWEmWcnVmmAS+TXARWXRWd1FScS2aQwWnqP5
        bvM1oLVtJeJJBOAQA4TVTKAW94yEbWaUl2TI5Yd+z21iX2FzquRO8t5VCL9tLAooAeL/Il
        iMztYVsJsVYVRlLPrVNog+PKnoSYORgu0BhF+Y/sTh3r8ZQz/cI4t42ToqLtNatIvi4w7M
        RAVhEMYYzT1xaYDnMJebVqas9hj6AYLXPFmMpoIDUzVlzGUqU0NaVhIob0LZpA==
ARC-Authentication-Results: i=1;
        rspamd-674ffb986c-2d48t;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Callous-Imminent: 6e03671f47e34c0e_1656521549255_4186424639
X-MC-Loop-Signature: 1656521549255:876281039
X-MC-Ingress-Time: 1656521549255
Received: from pdx1-sub0-mail-a288.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.105.211.156 (trex/6.7.1);
        Wed, 29 Jun 2022 16:52:29 +0000
Received: from offworld.. (unknown [104.36.31.105])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a288.dreamhost.com (Postfix) with ESMTPSA id 4LY6vb1v0Mz7x;
        Wed, 29 Jun 2022 09:52:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1656521547;
        bh=iOLcV9f/LV1oZPOPbY/80a03Bs1TUR8dCN1QpbUZqE4=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Qs9PUCo0Ba8JnusPwvxhulDhgUiFOQeIQlDDOqOC0cHYanyxV8pF3NLeAJ6HkOmcM
         NidJ1XacUTDGLg1uu5zHFr+1cA6/bmm3C50yjkhEabttoRpZw/NDyCrIbovX/kNEBz
         1cD2irnktQAi+tqIfLWLd9Kat1Dc5pplWNPfsqG2IB5nvApM9+/4yafe4iK1ENWM9b
         SesoAI85karEbRoWBM2R/WUxWA6L4GM0iefSj94ufexpxdimVcFcMfboYNG5XCO/Qb
         lZ9MgJABkn1jtadlQwlLWOY+Uw8QeT8e8UwSRvFrSvG+ljbS3WymUMJWOn0dlCgjd7
         +zOIrHsoJnqgA==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com
Cc:     aldas60@gmail.com, gregkh@linuxfoundation.org,
        keescook@chromium.org, linux-kernel@vger.kernel.org,
        linux-staging@lists.linux.dev, linux-usb@vger.kernel.org,
        nathan@kernel.org, syzkaller-bugs@googlegroups.com,
        Davidlohr Bueso <dave@stgolabs.net>
Subject: [PATCH] staging/wlan-ng: get the correct struct hfa384x in work callback
Date:   Wed, 29 Jun 2022 09:52:25 -0700
Message-Id: <20220629165225.3436822-1-dave@stgolabs.net>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <000000000000e3fc8905e2608d4f@google.com>
References: <000000000000e3fc8905e2608d4f@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hfa384x_usbctlx_completion_task() is bogusly using the reaper BH when
in fact this is the completion_bh. This was reflected when trying
to acquire the hw->ctlxq.lock and getting a failed lockdep class
initialized to it.

Reported-by: syzbot+ce3408364c4a234dd90c@syzkaller.appspotmail.com
Fixes: 9442e81d7e7 (staging/wlan-ng, prism2usb: replace completion_bh tasklet with work)
Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/wlan-ng/hfa384x_usb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/wlan-ng/hfa384x_usb.c b/drivers/staging/wlan-ng/hfa384x_usb.c
index 33844526c797..02fdef7a16c8 100644
--- a/drivers/staging/wlan-ng/hfa384x_usb.c
+++ b/drivers/staging/wlan-ng/hfa384x_usb.c
@@ -2632,7 +2632,7 @@ static void hfa384x_usbctlx_reaper_task(struct work_struct *work)
  */
 static void hfa384x_usbctlx_completion_task(struct work_struct *work)
 {
-	struct hfa384x *hw = container_of(work, struct hfa384x, reaper_bh);
+	struct hfa384x *hw = container_of(work, struct hfa384x, completion_bh);
 	struct hfa384x_usbctlx *ctlx, *temp;
 	unsigned long flags;
 
-- 
2.36.1

