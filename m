Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AA8E4B5509
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 16:41:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355936AbiBNPlC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 10:41:02 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231735AbiBNPlA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 10:41:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D16E360A9F
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:40:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644853252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=NsyCA1by/ak8R1lwSMjCXJyyH1qXb4V0zf8axMvxNR8=;
        b=HKZln+PhdJkpOIJZ3+q+SKv6AKeZegZ97SglSkvovc3HX9p5Oegv14tSWwTQZ+v7GvLRCI
        yzGup0ZGzY/wpwGzFWGIYajcfh3RgwbHCcCQ0XtKLK+++bBlLr1pxfhawOL1YFwkfMUq/J
        9fapGoIomFwzX+QPkOmxxOWAhYNxolM=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-201-mXRaGe_rN7Sld9LysQL8aw-1; Mon, 14 Feb 2022 10:40:48 -0500
X-MC-Unique: mXRaGe_rN7Sld9LysQL8aw-1
Received: by mail-oi1-f200.google.com with SMTP id bd39-20020a056808222700b002cd93cfaad4so3692407oib.12
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 07:40:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=NsyCA1by/ak8R1lwSMjCXJyyH1qXb4V0zf8axMvxNR8=;
        b=hNxT81mOtqvpShtFCB63NPMEMhcHXvHVFhO7TE2MFwpXUMrq2Fw741j6j1h7EVyMAX
         ugWo1Wm6paiyg7t4hQVXObYnSA9ZKjqRYNCbokAjYqUl9pSqLTxo+GW2lffWfJXtB7dI
         6hLh1rW/wtVYHgDUz85sEACVvASw3dWcU15Rw1ZBSWxspCNrFd291W3k/oMatKkQQGCQ
         3IbPCiVcLRH8872vRD+/alkxFijPsTM9QOeAnrdz/X5g+HVEJWFPmTmrT/vdIM1M5yDD
         /MlNoOJdy918qFMsuauNo1O1RSO0mOKP5YDQAhmDPMC8Y5n+cfa2L3+O4LxUsQy9yMnz
         lqOg==
X-Gm-Message-State: AOAM530JjZmORV5f3L+o0rpPn4xM5wxdhOKSAEspYwZAskzyfQzkLvwF
        mVlstZaSwjtHoNwhHbpIWWagmXcUTSEXd3DMg3vAYhtkgxmQ0eVtOkK9+bjOftfsoeyOB1NiaW4
        pwrXVpyhCJveWthna4PrzAkuZ
X-Received: by 2002:a05:6808:30a0:: with SMTP id bl32mr34576oib.262.1644853248083;
        Mon, 14 Feb 2022 07:40:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyuAZBJGNoWdrA+012X1djizbpdOBot5gLyfgpONhsQ6+8gC+0JtSILPzlYULjoQUEuunFbBw==
X-Received: by 2002:a05:6808:30a0:: with SMTP id bl32mr34562oib.262.1644853247928;
        Mon, 14 Feb 2022 07:40:47 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id n11sm4432445oal.1.2022.02.14.07.40.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 07:40:47 -0800 (PST)
From:   trix@redhat.com
To:     jesse.brandeburg@intel.com, anthony.l.nguyen@intel.com,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com, paul.greenwalt@intel.com,
        evan.swanson@intel.com
Cc:     intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] ice: initialize local variable 'tlv'
Date:   Mon, 14 Feb 2022 07:40:43 -0800
Message-Id: <20220214154043.2891024-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this issues
ice_common.c:5008:21: warning: The left expression of the compound
  assignment is an uninitialized value. The computed value will
  also be garbage
  ldo->phy_type_low |= ((u64)buf << (i * 16));
  ~~~~~~~~~~~~~~~~~ ^

When called from ice_cfg_phy_fec() ldo is the unintialized local
variable tlv.  So initialize.

Fixes: ea78ce4dab05 ("ice: add link lenient and default override support")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/intel/ice/ice_common.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_common.c b/drivers/net/ethernet/intel/ice/ice_common.c
index c57e5fc41cf8..0e4434e3c290 100644
--- a/drivers/net/ethernet/intel/ice/ice_common.c
+++ b/drivers/net/ethernet/intel/ice/ice_common.c
@@ -3379,7 +3379,7 @@ ice_cfg_phy_fec(struct ice_port_info *pi, struct ice_aqc_set_phy_cfg_data *cfg,
 
 	if (fec == ICE_FEC_AUTO && ice_fw_supports_link_override(hw) &&
 	    !ice_fw_supports_report_dflt_cfg(hw)) {
-		struct ice_link_default_override_tlv tlv;
+		struct ice_link_default_override_tlv tlv = { 0 };
 
 		status = ice_get_link_default_override(&tlv, pi);
 		if (status)
-- 
2.26.3

