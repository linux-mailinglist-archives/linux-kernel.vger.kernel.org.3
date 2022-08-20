Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D36F959AAEA
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 05:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244549AbiHTDZx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 23:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiHTDZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 23:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88CF0EEC7C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660965929;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=rCdaW8VW9KVhf4KlGQHWkOq32wI36GjplhXzdCZm9VA=;
        b=A3lbZSS5pdMC8sltsATtA8GRgDXCHT3U/OETH/j3rE8mNQAo9NqqFAkaVtCu+5QKWMyHFA
        6JUh/HUJIwQIKOB6Nry1FOl2U+W1JBTYHel9syUffTeUkNzum3XAYoty6jmrGLPW7AEdu/
        NaERx2OSGcp9EauTmfxvHO4oyPaxDI8=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-633-igCt3x4AP6eeYy22Z5WJHQ-1; Fri, 19 Aug 2022 23:25:26 -0400
X-MC-Unique: igCt3x4AP6eeYy22Z5WJHQ-1
Received: by mail-pg1-f198.google.com with SMTP id e187-20020a6369c4000000b0041c8dfb8447so2761244pgc.23
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 20:25:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc;
        bh=rCdaW8VW9KVhf4KlGQHWkOq32wI36GjplhXzdCZm9VA=;
        b=sPc56/CVoo360GkxIH7iCHTX1x4feDmR7ta1VLedtZ/HSqMuu5aRSkuBy3geFVlff+
         +0PnHczprtmO49fmH5uTkrlrvJYQHw0xAP2UiWmCk1NSDtya6UwpdNkXG79enKQ0LjwV
         HZmO5DuKWTiSI3CJJ+tX/7QC8/EfW0gKRxY6hI5+O72HWvhqynY7VJLCXETt4bFu+Tac
         wKFEU4QU1K7jbiete/8H4kepgotiWFilP9Ex0a80vF8ws30Lo5PCADTlUOCYZZH83RYB
         EPGRmthX/VoTraDwriPVe7zicLBSGFErI1dLXtol34/kHQ2sRkPk9vrJpJhfpTP6KWLm
         6A9w==
X-Gm-Message-State: ACgBeo3ne4HuL89wtXZefzMghwj/OJaFep1nJHOlfWiWYK1b+G/TLGPS
        hjMZDPEIM2HGcwv6LBU1HzxGbi08xmGTlbQI1O4gK/FmrFWwK4iGfv3/xc6a9aVXuIiS0HDiTrT
        4S5Ttb69KYT0AQj2hbLCncmgc
X-Received: by 2002:a17:90b:4a0d:b0:1fa:c277:126e with SMTP id kk13-20020a17090b4a0d00b001fac277126emr13986424pjb.246.1660965925019;
        Fri, 19 Aug 2022 20:25:25 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7G9enq5xkrmpDkzKybaz2ssbk1855D5ew/T350m3OaXXLhX8q18+DZC61QPqCJPA5d+4HTmA==
X-Received: by 2002:a17:90b:4a0d:b0:1fa:c277:126e with SMTP id kk13-20020a17090b4a0d00b001fac277126emr13986406pjb.246.1660965924720;
        Fri, 19 Aug 2022 20:25:24 -0700 (PDT)
Received: from xps13.. ([240d:1a:c0d:9f00:4f2f:926a:23dd:8588])
        by smtp.gmail.com with ESMTPSA id l7-20020a170903120700b0016d692ff95esm3906400plh.133.2022.08.19.20.25.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 20:25:24 -0700 (PDT)
From:   Shigeru Yoshida <syoshida@redhat.com>
To:     mareklindner@neomailbox.ch, sw@simonwunderlich.de, a@unstable.cc,
        sven@narfation.org
Cc:     b.a.t.m.a.n@lists.open-mesh.org, linux-kernel@vger.kernel.org,
        Shigeru Yoshida <syoshida@redhat.com>
Subject: [PATCH] batman-adv: Fix hang up with small MTU hard-interface
Date:   Sat, 20 Aug 2022 12:25:16 +0900
Message-Id: <20220820032516.200446-1-syoshida@redhat.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The system hangs up when batman-adv soft-interface is created on
hard-interface with small MTU.  For example, the following commands
create batman-adv soft-interface on dummy interface with zero MTU:

  # ip link add name dummy0 type dummy
  # ip link set mtu 0 dev dummy0
  # ip link set up dev dummy0
  # ip link add name bat0 type batadv
  # ip link set dev dummy0 master bat0

These commands cause the system hang up with the following messages:

  [   90.578925][ T6689] batman_adv: bat0: Adding interface: dummy0
  [   90.580884][ T6689] batman_adv: bat0: The MTU of interface dummy0 is too small (0) to handle the transport of batman-adv packets. Packets going over this interface will be fragmented on layer2 which could impact the performance. Setting the MTU to 1560 would solve the problem.
  [   90.586264][ T6689] batman_adv: bat0: Interface activated: dummy0
  [   90.590061][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
  [   90.595517][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)
  [   90.598499][ T6689] batman_adv: bat0: Forced to purge local tt entries to fit new maximum fragment MTU (-320)

This patch fixes this issue by returning error when enabling
hard-interface with small MTU size.

Signed-off-by: Shigeru Yoshida <syoshida@redhat.com>
---
 net/batman-adv/hard-interface.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/batman-adv/hard-interface.c b/net/batman-adv/hard-interface.c
index b8f8da7ee3de..dce5557800e9 100644
--- a/net/batman-adv/hard-interface.c
+++ b/net/batman-adv/hard-interface.c
@@ -700,6 +700,9 @@ int batadv_hardif_enable_interface(struct batadv_hard_iface *hard_iface,
 	int max_header_len = batadv_max_header_len();
 	int ret;
 
+	if (hard_iface->net_dev->mtu < ETH_MIN_MTU + max_header_len)
+		return -EINVAL;
+
 	if (hard_iface->if_status != BATADV_IF_NOT_IN_USE)
 		goto out;
 
-- 
2.37.2

