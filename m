Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A46F54AB01A
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Feb 2022 16:03:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiBFPDL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Feb 2022 10:03:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbiBFPDH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Feb 2022 10:03:07 -0500
X-Greylist: delayed 303 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 06 Feb 2022 07:03:04 PST
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8BD22C06173B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Feb 2022 07:03:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644159783;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rKATFCi7H9n+MAZn8bO3eBo0n7dtdQd0f24aSeVzaI0=;
        b=ABXLnVMrajyEER8fv6zZnyk41IwF3vbz5n0sbwzi1pp9qhy0TXV4heeJ8O+KM2oL5bV7uw
        2Gi0kOSj9RnMIXsPhuK3zlLBPigIABbgf0bpzQ1ZBSEtcUQQt9jtMk/nEV7D5ZtdX/qTLM
        4LOcAx60sIunIYXsj8H24yuqsMiHcy4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-396-RL4WRtduPAiZb7T89b4W-g-1; Sun, 06 Feb 2022 09:56:07 -0500
X-MC-Unique: RL4WRtduPAiZb7T89b4W-g-1
Received: by mail-qk1-f197.google.com with SMTP id bl5-20020a05620a1a8500b005088d061be4so1030854qkb.21
        for <linux-kernel@vger.kernel.org>; Sun, 06 Feb 2022 06:56:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=rKATFCi7H9n+MAZn8bO3eBo0n7dtdQd0f24aSeVzaI0=;
        b=TCr/9e3wHsT+Y9fS9J33fl0+RpwF7Yh1/EuKbAhqmS3SVxiZ/RQrKy12PTT+cbv9Q7
         LimejisrXW7Nxi/g6yKBc2GFToSNTfwm0Ao0IiqEU9dHeh6tx7VrFiG4jOsJnzg6BMMQ
         y9Pqz+p+hS43EdqafJXljY+fa7KpAnCV4Y7Or+6qa6XwKSCGyVkkhNCH4uFc4DkumLWt
         fEYuu/N6l0WH2AU7ENEvOGUHt264UIQ8gd7MQUxB/Vcd9igSIb5eR5HaYDf9F8eLRwH1
         ZYH7Sl+TUHEaPUE9j76VhgzjkQQgRWs+ST/mmxdbp1DG8nj/AB12xqHxZxkV78euCl6I
         uEYg==
X-Gm-Message-State: AOAM533I0F8fz2kuEaOGX6U7n+sdmI84Dg4El7hvBwA/V6if7PT2+mKT
        HHE+7RGsQkalOgYbqst/0TtW9QhVKB4Zb1KU4LjoPDEaBx6fGp19XNXpGAgvLy2YFfOHYKvEN3K
        4V45AjaDXooJcnMuKpabgwYhT
X-Received: by 2002:ad4:5dcf:: with SMTP id m15mr7972312qvh.26.1644159367086;
        Sun, 06 Feb 2022 06:56:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTp2kb9P2giYVhQ0IgQPqQwQCfebA5KvNvWTckY4PCBS0uRH4aJxr/ywtTHS2RVG5PxxdQsw==
X-Received: by 2002:ad4:5dcf:: with SMTP id m15mr7972305qvh.26.1644159366953;
        Sun, 06 Feb 2022 06:56:06 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id q12sm4597635qtx.51.2022.02.06.06.56.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Feb 2022 06:56:06 -0800 (PST)
From:   trix@redhat.com
To:     davem@davemloft.net, kuba@kernel.org, paskripkin@gmail.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] caif: cleanup double word in comment
Date:   Sun,  6 Feb 2022 06:55:21 -0800
Message-Id: <20220206145521.2011008-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Replace the second 'so' with 'free'.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/caif/caif_dev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/caif/caif_dev.c b/net/caif/caif_dev.c
index 440139706130a..52dd0b6835bc8 100644
--- a/net/caif/caif_dev.c
+++ b/net/caif/caif_dev.c
@@ -268,7 +268,7 @@ static int receive(struct sk_buff *skb, struct net_device *dev,
 
 	err = caifd->layer.up->receive(caifd->layer.up, pkt);
 
-	/* For -EILSEQ the packet is not freed so so it now */
+	/* For -EILSEQ the packet is not freed so free it now */
 	if (err == -EILSEQ)
 		cfpkt_destroy(pkt);
 
-- 
2.26.3

