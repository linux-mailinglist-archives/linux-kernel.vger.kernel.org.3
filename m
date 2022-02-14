Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2DF54B550D
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:41:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355957AbiBNPl5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:41:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:38852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243798AbiBNPly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:41:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 79C0D2194
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:41:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644853305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=o2n4igdt+OdiIrBK6xR+fpoYm2D50EglcumtCm9hZt8=;
        b=FVsVq3jtAAILewqxQnNTKyyHCaxuA5PSptypwlg0DiBmOHAQEzs5o/LQV6BewUrRRSI8Ck
        NGlfoKVo4MVQGA/khwbKobm8q3vJZKdcOjOibhS6iH3N4uaqqtM60cMcBtlztPaM4apJEN
        ZpS99hKLlo/l/FHZUViAAcT08EeJUIQ=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-592-mkVz8rZoNsKjOFUKyGsPLQ-1; Mon, 14 Feb 2022 10:41:44 -0500
X-MC-Unique: mkVz8rZoNsKjOFUKyGsPLQ-1
Received: by mail-oo1-f70.google.com with SMTP id t14-20020a4a96ce000000b00318605258dbso7962826ooi.21
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:41:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=o2n4igdt+OdiIrBK6xR+fpoYm2D50EglcumtCm9hZt8=;
        b=H9QDLZua3v+1IsCXiRSfvOfrJySUWVhasDwntqmZE0COs8aCWo0ihHqlKHFXO8HfUP
         vDW9fZfs3ZyOo6/rIjf+kkbVeO+TIfQRzQnGmw1SomlDWcE1FGC8Y37A7xeWVDraDpRn
         xTv5/nmD13y/IPr3iCpTOr3UYew3ApUsAf7jvvGyJyMdW03ydNimczl3v2u6aZHooWnv
         93W62QnQ4hAn/VrI2daCr9uq5J7lKXigsxjQlfrsOZcLLN8cs/wQmVkRPa8J9jeqnWSY
         vLIipYT8CCg3JvnWi/+8p2Jfk2fG/D9n5L1Wao5PVjHjjGxyTXcrZTlaGFjkkDF6Epp8
         49Mg==
X-Gm-Message-State: AOAM531oDRFhlWxo8gNv4fhQBN8J1FP3Vr+2A1imN6NXlsCSQ5RV8oe+
        Rc8SCNH/mvwYUuVTnrkS/n1hTUW4SYjoBifTdt1rvpau6gTNyZHep7l+r0Y3TkNr0Kq4kFNTB/k
        5RiBetqXVhPTzjIMDsthb25l5
X-Received: by 2002:a05:6870:c20e:: with SMTP id z14mr29924oae.226.1644853303788;
        Mon, 14 Feb 2022 07:41:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykwDMfLBLRPN5iUh2wRhsPvJO6ozI0RxsCmCpzqo4Z8Tbxt3PVn2hkDq2VMttNpeqfULuCBA==
X-Received: by 2002:a05:6870:c20e:: with SMTP id z14mr29920oae.226.1644853303609;
        Mon, 14 Feb 2022 07:41:43 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id g17sm12497046ots.73.2022.02.14.07.41.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:41:43 -0800 (PST)
From:   trix@redhat.com
To:     ioana.ciornei@nxp.com, davem@davemloft.net, kuba@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] dpaa2-switch: fix default return of dpaa2_switch_flower_parse_mirror_key
Date:   Mon, 14 Feb 2022 07:41:39 -0800
Message-Id: <20220214154139.2891275-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative problem
dpaa2-switch-flower.c:616:24: warning: The right operand of '=='
  is a garbage value
  tmp->cfg.vlan_id == vlan) {
                   ^  ~~~~
vlan is set in dpaa2_switch_flower_parse_mirror_key(). However
this function can return success without setting vlan.  So
change the default return to -EOPNOTSUPP.

Fixes: 0f3faece5808 ("dpaa2-switch: add VLAN based mirroring")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
index d6eefbbf163f..cacd454ac696 100644
--- a/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
+++ b/drivers/net/ethernet/freescale/dpaa2/dpaa2-switch-flower.c
@@ -532,6 +532,7 @@ static int dpaa2_switch_flower_parse_mirror_key(struct flow_cls_offload *cls,
 	struct flow_rule *rule = flow_cls_offload_flow_rule(cls);
 	struct flow_dissector *dissector = rule->match.dissector;
 	struct netlink_ext_ack *extack = cls->common.extack;
+	int ret = -EOPNOTSUPP;
 
 	if (dissector->used_keys &
 	    ~(BIT(FLOW_DISSECTOR_KEY_BASIC) |
@@ -561,9 +562,10 @@ static int dpaa2_switch_flower_parse_mirror_key(struct flow_cls_offload *cls,
 		}
 
 		*vlan = (u16)match.key->vlan_id;
+		ret = 0;
 	}
 
-	return 0;
+	return ret;
 }
 
 static int
-- 
2.26.3

