Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFB814D75FC
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:02:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234703AbiCMPDf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:03:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230198AbiCMPDd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D1372580C4
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:02:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647183745;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=OZkkggqsQIoWieW/oVrOCwUkJK6lKvyxEtn8wx8/DH4=;
        b=UcrIcXXj8VAMNjOp9WXjy3kMeGHIFNmkxDvRLntaHKW5tXosG5QBbEdtQvRVLzwZsGq3w2
        zsPTPToU5N2D96ikgmkvhMinV+new34KWzfGsP0Vims8lL4ykoeThS3pnvwQXnGxCI2DyC
        950EuuNYMsuu2b7nan3E3Bwyd4TCGTQ=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-196-fNHsYCwCNuuopRr7NlIcKA-1; Sun, 13 Mar 2022 11:02:23 -0400
X-MC-Unique: fNHsYCwCNuuopRr7NlIcKA-1
Received: by mail-ot1-f69.google.com with SMTP id p23-20020a9d7457000000b005b223576603so10045840otk.6
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 08:02:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=OZkkggqsQIoWieW/oVrOCwUkJK6lKvyxEtn8wx8/DH4=;
        b=M0PD8J75N6vcYoakmnVhTx4LuiauZeIQEHpFEzXXPBwomjFuxNX+4rgg0ZxWUCF//i
         PTMfg/2zqkNXDh13ArJpZTL5LVc8k9UYa3d+FnhnFp9C/fZ3YUW1nNFBumt1Efk9yLQ5
         RKnTI+uKYBMh4mGZb+WYWanwNbMuJah9COGvN0uAxdWEuKUL133BSAuWm8d4KXgZm4c/
         WlMl/hhE0j+rWXGO9+aN/DUhHBakqA2y6QqKaZnLZ6o4p/ZNEKefHlND++0kut31aByu
         UJh3B+okHhKVIGjmildQf5bvIBg352QCFGGG5DFLeY2y+JRGFUhq63ewr/+F4E2RvRaJ
         TRgA==
X-Gm-Message-State: AOAM533U5nvYL+aL5t7+w5dP5UdymrfZTXKEXW0JeSrs8IObvU1k8ehy
        wyl5cOSpVr36pqsLdECA7Kr/WjrMkTGlD8No7FxP8g8F9xNcr/JekKZsU9Ktp2fQdDylaVL+Iag
        +OSETSC0WKGqnuoebYb2IC2G+
X-Received: by 2002:a9d:4e99:0:b0:5b2:54f4:75e7 with SMTP id v25-20020a9d4e99000000b005b254f475e7mr9119060otk.94.1647183741498;
        Sun, 13 Mar 2022 08:02:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzjb1ejVgoHBYltkBU7cyugOD8fhaxKGdkCT++7rWLl8GnDe8scorY7NgLJqvOmNm3oOxRWWQ==
X-Received: by 2002:a9d:4e99:0:b0:5b2:54f4:75e7 with SMTP id v25-20020a9d4e99000000b005b254f475e7mr9119012otk.94.1647183739823;
        Sun, 13 Mar 2022 08:02:19 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id o17-20020a9d5c11000000b005b2611a13edsm6324116otk.61.2022.03.13.08.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Mar 2022 08:02:19 -0700 (PDT)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] igb: zero hwtstamp by default
Date:   Sun, 13 Mar 2022 08:02:10 -0700
Message-Id: <20220313150210.1508203-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative issue
igb_ptp.c:997:3: warning: The left operand of '+' is a
  garbage value
  ktime_add_ns(shhwtstamps.hwtstamp, adjust);
  ^            ~~~~~~~~~~~~~~~~~~~~

shhwtstamps.hwtstamp is set by a call to
igb_ptp_systim_to_hwtstamp().  In the switch-statement
for the hw type, the hwtstamp is zeroed for matches
but not the default case.  Move the memset out of
switch-statement.  This degarbages the default case
and reduces the size.

Some whitespace cleanup of empty lines

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/igb/igb_ptp.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_ptp.c b/drivers/net/ethernet/intel/igb/igb_ptp.c
index 6580fcddb4be5..02fec948ce642 100644
--- a/drivers/net/ethernet/intel/igb/igb_ptp.c
+++ b/drivers/net/ethernet/intel/igb/igb_ptp.c
@@ -165,23 +165,21 @@ static void igb_ptp_systim_to_hwtstamp(struct igb_adapter *adapter,
 	unsigned long flags;
 	u64 ns;
 
+	memset(hwtstamps, 0, sizeof(*hwtstamps));
+
 	switch (adapter->hw.mac.type) {
 	case e1000_82576:
 	case e1000_82580:
 	case e1000_i354:
 	case e1000_i350:
 		spin_lock_irqsave(&adapter->tmreg_lock, flags);
-
 		ns = timecounter_cyc2time(&adapter->tc, systim);
-
 		spin_unlock_irqrestore(&adapter->tmreg_lock, flags);
 
-		memset(hwtstamps, 0, sizeof(*hwtstamps));
 		hwtstamps->hwtstamp = ns_to_ktime(ns);
 		break;
 	case e1000_i210:
 	case e1000_i211:
-		memset(hwtstamps, 0, sizeof(*hwtstamps));
 		/* Upper 32 bits contain s, lower 32 bits contain ns. */
 		hwtstamps->hwtstamp = ktime_set(systim >> 32,
 						systim & 0xFFFFFFFF);
-- 
2.26.3

