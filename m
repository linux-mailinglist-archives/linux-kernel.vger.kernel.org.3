Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D169B4FC02A
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347750AbiDKPTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347725AbiDKPSt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:18:49 -0400
Received: from beige.elm.relay.mailchannels.net (beige.elm.relay.mailchannels.net [23.83.212.16])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A5C131DFB
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 08:16:34 -0700 (PDT)
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from relay.mailchannels.net (localhost [127.0.0.1])
        by relay.mailchannels.net (Postfix) with ESMTP id 1D69B22855;
        Mon, 11 Apr 2022 15:16:33 +0000 (UTC)
Received: from pdx1-sub0-mail-a264.dreamhost.com (unknown [127.0.0.6])
        (Authenticated sender: dreamhost)
        by relay.mailchannels.net (Postfix) with ESMTPA id 9801D22BD5;
        Mon, 11 Apr 2022 15:16:32 +0000 (UTC)
ARC-Seal: i=1; s=arc-2022; d=mailchannels.net; t=1649690192; a=rsa-sha256;
        cv=none;
        b=gP2gmTLVxwUmcZEO3ApG6Hxx/i7oKSOIfLD+xJFcp+Y5DfieadtsysmUd2i+OfPPSB+BUx
        mhpulJrY/eh9qNRp+tzRyaJfVJA18/LHiMLZKnsWXolhD1MJ4aCn85RGxSHBuxefyXJfgK
        0R5Yob0HYSQf/GMKGEvNR7P4pAG7yhRxaq09HX+qVk1EYCka+8N4h7f9DnIEr+OG7U5TO2
        5ndoYvSg1VK9ytOeYZHMriQdKfb/b7td3dZXdTievSy7t777XJt90+966Z0bo/FLRfzaJb
        j4r99I5PAux65JiHT2S5wBPLR5jeaDSUKmAs1ZWukepKdbnovW6T1C/A3uREcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mailchannels.net;
        s=arc-2022; t=1649690192;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references:dkim-signature;
        bh=lR/YiGVQcmetX+2lRuVb/KT4hVGeawzTusjLHsX35/g=;
        b=XvowLJgUVFwCNo0eOPgV+zTKXBd0O1QbXkbo0OEc4Qv9ZUaNrhZi2wxO2ti8sRX7c7NaSA
        Cjr+TlJLiOZHtPVhSNs4aSwvnnMHJmnfegGStrkD2UGTEl2hsnqKNgC0giijntCmNj/kgS
        xnucXgj0fDZHiKVj7J/KsEK4ij4kyq+jxv/eXN6Q38auBJRsWT7Y0gh8iZhdQ2J6aFH7eZ
        g5Fxqlq489zZhmdSDHDyqZsrkdZA2pnUmi6zhWo4BAiwZfLjohk0A61hpeXXSNynB2WZDa
        eKRrQJSfE9ysHjn82e4g38udzgaLcYqudRYPmXiqLGc8l6IUyv987xD3Mq5WtA==
ARC-Authentication-Results: i=1;
        rspamd-68f9d8f9d5-4gr6r;
        auth=pass smtp.auth=dreamhost smtp.mailfrom=dave@stgolabs.net
X-Sender-Id: dreamhost|x-authsender|dave@stgolabs.net
Received: from pdx1-sub0-mail-a264.dreamhost.com (pop.dreamhost.com
 [64.90.62.162])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384)
        by 100.112.55.239 (trex/6.7.1);
        Mon, 11 Apr 2022 15:16:33 +0000
X-MC-Relay: Neutral
X-MailChannels-SenderId: dreamhost|x-authsender|dave@stgolabs.net
X-MailChannels-Auth-Id: dreamhost
X-Juvenile-Snatch: 6c997adc33f46124_1649690192901_2500046846
X-MC-Loop-Signature: 1649690192900:3222495231
X-MC-Ingress-Time: 1649690192900
Received: from localhost.localdomain (unknown [104.36.29.104])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: dave@stgolabs.net)
        by pdx1-sub0-mail-a264.dreamhost.com (Postfix) with ESMTPSA id 4KcXWM5dB4z1fB;
        Mon, 11 Apr 2022 08:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=stgolabs.net;
        s=dreamhost; t=1649690192;
        bh=lR/YiGVQcmetX+2lRuVb/KT4hVGeawzTusjLHsX35/g=;
        h=From:To:Cc:Subject:Date:Content-Transfer-Encoding;
        b=Daf2KCzyZf8qtZfLVmsu7yPMCs968bFHs8RvhuHlK+gN6w+mrWJBIwGFUfCQmTlJU
         fviTfD+SFjFU4X9NbN2Qa0yl1z79kN2PzPposOacpIJfHCRQznPMDkpwzinuuxuJtJ
         1y6KsMUdssaz0v4I0FLGUBSSMh7VOtfHLQBq5tw7PwUaGBT+MJY2ZpGZ7IwmEt06Rw
         fTFkpqDm/VWUHZU0hU+kHran149H9kJjFOYO0+3Tn8uhzbd75aEwNRmgZcgLyL763E
         7q/vlFd53AO9VX/T7gP+hCUN3ZKT/yLODPvwjB66HJEyxHrS8hZMBqDuynL/8swtEc
         6VrzyntmoNNsg==
From:   Davidlohr Bueso <dave@stgolabs.net>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        dave@stgolabs.net
Subject: [PATCH 5/6] staging/rtl8712: remove event_tasklet
Date:   Mon, 11 Apr 2022 08:16:19 -0700
Message-Id: <20220411151620.129178-6-dave@stgolabs.net>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20220411151620.129178-1-dave@stgolabs.net>
References: <20220411151620.129178-1-dave@stgolabs.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is unused.

Signed-off-by: Davidlohr Bueso <dave@stgolabs.net>
---
 drivers/staging/rtl8712/rtl871x_cmd.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/staging/rtl8712/rtl871x_cmd.h b/drivers/staging/rtl8712/rtl871x_cmd.h
index 95e9ea5b2d98..a7d98e9fd762 100644
--- a/drivers/staging/rtl8712/rtl871x_cmd.h
+++ b/drivers/staging/rtl8712/rtl871x_cmd.h
@@ -66,7 +66,6 @@ struct	evt_priv {
 	u8	*evt_buf;	/*shall be non-paged, and 4 bytes aligned*/
 	u8	*evt_allocated_buf;
 	u32	evt_done_cnt;
-	struct tasklet_struct event_tasklet;
 };
 
 #define init_h2fwcmd_w_parm_no_rsp(pcmd, pparm, code) \
-- 
2.26.2

