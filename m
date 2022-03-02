Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53AF64CA555
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 13:57:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241972AbiCBM54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 07:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242014AbiCBM5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 07:57:53 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1A27BC24A9
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 04:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646225829;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4tvH7/UPfOujZY4vvMaOBTun4bBist9qqxPve17cRH0=;
        b=PXsoNd1FyhdPPq9GiLEoXkGdBasgBcJDYaSfjSdTBq/8Eo1IYSQuVMcBZP96cMNE6WcLt0
        H3WwBmpwXKMNxwlmaOLCBPLyANNXtL36KACmpNxG8geJ02tndGwqaYjspUBSWtA6322wME
        d8y46ZT6fMwhy9h3REah6YnwLbev7Qo=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-455-YaY96u8HMDO5njmse178dA-1; Wed, 02 Mar 2022 07:57:08 -0500
X-MC-Unique: YaY96u8HMDO5njmse178dA-1
Received: by mail-ot1-f72.google.com with SMTP id q2-20020a9d5782000000b005ad0c39a8b5so1243783oth.2
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 04:57:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4tvH7/UPfOujZY4vvMaOBTun4bBist9qqxPve17cRH0=;
        b=tLbmQle8wKS5QSe6m75OSJscoUN/l78ICttjiOIlG50kbUEBNhSyAPrLDV869JFxB/
         dbczpmjqs4UbjI0g8lwWUhLAwzAKeaUwNeDiNnHN58voOxq6eVaxYmOMrIQU2GeOUz60
         0v0iT7a/RJ1L6RJb2+0C922NO1KvNkknl5SjQ8iW4fY8aTpNCEVWhJLICXNr8SxXuDZh
         MUFfo3VMyraPOElGr0+dqddE4PgO4kB5wOxCGWSMFmv1M54lnryo0abd6GWNgs4yoIQz
         gGLKSoV16BoAhvFp2C+3AQRG7Loy+k1/01WFelZHZYgDcyxmyIpRVudVKZpPNOLF+lXl
         HhOQ==
X-Gm-Message-State: AOAM532FGLD1PwD8nKqKNDApn1AdpYObuQtsMlIsoyI3FVei18YWcuh2
        HdJXfm8Jx+9CPtoAoOtIdTjNSpJpxAWiN6s1ZTIE2HtDUSZzDGbM/hN1OS64x5/DkqjY4TDZY14
        ea9BBDEnTFwoh7Rkub/Hqqoh8
X-Received: by 2002:a05:6870:238c:b0:d6:f796:c98e with SMTP id e12-20020a056870238c00b000d6f796c98emr7520498oap.82.1646225827388;
        Wed, 02 Mar 2022 04:57:07 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx+HJAWOIaiYoffWdK1JHVICQZFHgy9ZPQ2SGyYS6IGnckQm6gVc5ccom6k+N2+elbCInqJoA==
X-Received: by 2002:a05:6870:238c:b0:d6:f796:c98e with SMTP id e12-20020a056870238c00b000d6f796c98emr7520491oap.82.1646225827239;
        Wed, 02 Mar 2022 04:57:07 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id e199-20020a4a55d0000000b0031ca56292bbsm2816774oob.46.2022.03.02.04.57.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 04:57:06 -0800 (PST)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] i40e: little endian only valid checksums
Date:   Wed,  2 Mar 2022 04:57:02 -0800
Message-Id: <20220302125702.358999-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

The calculation of the checksum can fail.
So move converting the checksum to little endian
to inside the return status check.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/i40e/i40e_nvm.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/i40e/i40e_nvm.c b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
index fe6dca846028f..3a38bf8bcde7e 100644
--- a/drivers/net/ethernet/intel/i40e/i40e_nvm.c
+++ b/drivers/net/ethernet/intel/i40e/i40e_nvm.c
@@ -682,10 +682,11 @@ i40e_status i40e_update_nvm_checksum(struct i40e_hw *hw)
 	__le16 le_sum;
 
 	ret_code = i40e_calc_nvm_checksum(hw, &checksum);
-	le_sum = cpu_to_le16(checksum);
-	if (!ret_code)
+	if (!ret_code) {
+		le_sum = cpu_to_le16(checksum);
 		ret_code = i40e_write_nvm_aq(hw, 0x00, I40E_SR_SW_CHECKSUM_WORD,
 					     1, &le_sum, true);
+	}
 
 	return ret_code;
 }
-- 
2.26.3

