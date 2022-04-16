Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 549035045B4
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 00:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiDPWmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Apr 2022 18:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230377AbiDPWmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Apr 2022 18:42:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4D86637A29
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650148770;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BpOVvGdiVmOkFc6Vxt31zxMLOJ/JVW56iU3zr83wB70=;
        b=XXk60STq4xjlj1hVLCb4QLtjcveCQzcuPj4r+aWCyn168yrli2GSPAnl79MkbEtkvnFVEo
        nSsi4LNt2ucNgEvxVV+2fSrHw2qvhHKMUShG4Z3ujD455enY69Ce8QNSN0n6GTyu1V7Frv
        nXSj0PgWGnmiZGEEjYIs6Y904RSX2wk=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-494-4m2TPBcTMEmijyAAiCpr3w-1; Sat, 16 Apr 2022 18:39:28 -0400
X-MC-Unique: 4m2TPBcTMEmijyAAiCpr3w-1
Received: by mail-qk1-f198.google.com with SMTP id l20-20020a05620a28d400b0069c63137970so6872198qkp.10
        for <linux-kernel@vger.kernel.org>; Sat, 16 Apr 2022 15:39:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BpOVvGdiVmOkFc6Vxt31zxMLOJ/JVW56iU3zr83wB70=;
        b=ajlbOsb24Aklqo68lv2OyVn6AbFt7VBI5US6vrS8xto4RnIqp0kxAEVlYErXZIfVoW
         J5h0UkMhcNQwxYSFedMvCEo5e/EOIHyPB2Tvz89wgF2X/0CMAYZ0MA3yEtAWVOIjhfcJ
         thfPPAagRP3Jr7bWmR6eDiArO9o6EM+owgfzmSou5AFI8QK03SVQtu9QW0U7FxAVlnDy
         k8sHGTrrHbUSez9qZLUhlCCElB1N1cfqV3nzzB4FBiHzXWc5+08bZFZ0AOB5Cf1twEhQ
         Rs7ksBrJi0wgZAnBy7Tnwum+02UpBTOvxJLbGWfdGxX7xRi/9y6o5UaOAfTuROH4CfTE
         NRQw==
X-Gm-Message-State: AOAM533IIRHKF7/BBg9aoGgRb8uUkUsak9z1NxI1otkxoQtXGMuS7T76
        h8pr+m3gE3j7sGMOSo3x0y0MsGM1AmEkrMbogT423ChVK7hVDy35O0nODS0rdbmExVcDpRkI6Zg
        M5PnVXlwwABvNw1WetR+z9qV8
X-Received: by 2002:ae9:eb87:0:b0:69e:75b3:6527 with SMTP id b129-20020ae9eb87000000b0069e75b36527mr2243515qkg.386.1650148768198;
        Sat, 16 Apr 2022 15:39:28 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzDR9RLRp+qTWzVkbCtfQ9U7EuTs1Feo7WIWOwOFw1MB385IjzG7j183dip8VZh/DlKz9M7Wg==
X-Received: by 2002:ae9:eb87:0:b0:69e:75b3:6527 with SMTP id b129-20020ae9eb87000000b0069e75b36527mr2243503qkg.386.1650148767997;
        Sat, 16 Apr 2022 15:39:27 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id 8-20020ac85948000000b002e1cd3fa142sm5346012qtz.92.2022.04.16.15.39.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Apr 2022 15:39:27 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, waynec@nvidia.com,
        rikard.falkeborn@gmail.com, zhangqilong3@huawei.com,
        jakobkoschel@gmail.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] usb: gadget: tegra-xudc: clean up comments
Date:   Sat, 16 Apr 2022 18:39:21 -0400
Message-Id: <20220416223921.2881719-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling replacements
cancelled to canceled
endpiont to endpoint
Compliance to Compliance

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/usb/gadget/udc/tegra-xudc.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index d9c406bdb680..0aaf01e1551f 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
@@ -1330,7 +1330,7 @@ static void squeeze_transfer_ring(struct tegra_xudc_ep *ep,
 	bool pcs;
 
 	/*
-	 * Clear out all the TRBs part of or after the cancelled request,
+	 * Clear out all the TRBs part of or after the canceled request,
 	 * and must correct trb cycle bit to the last un-enqueued state.
 	 */
 	while (trb != &ep->transfer_ring[ep->enq_ptr]) {
@@ -1343,11 +1343,11 @@ static void squeeze_transfer_ring(struct tegra_xudc_ep *ep,
 			trb = ep->transfer_ring;
 	}
 
-	/* Requests will be re-queued at the start of the cancelled request. */
+	/* Requests will be re-queued at the start of the canceled request. */
 	ep->enq_ptr = req->first_trb - ep->transfer_ring;
 	/*
 	 * Retrieve the correct cycle bit state from the first trb of
-	 * the cancelled request.
+	 * the canceled request.
 	 */
 	ep->pcs = pcs_enq;
 	ep->ring_full = false;
@@ -1434,7 +1434,7 @@ __tegra_xudc_ep_dequeue(struct tegra_xudc_ep *ep,
 		return 0;
 	}
 
-	/* Halt DMA for this endpiont. */
+	/* Halt DMA for this endpoint. */
 	if (ep_ctx_read_state(ep->context) == EP_STATE_RUNNING) {
 		ep_pause(xudc, ep->index);
 		ep_wait_for_inactive(xudc, ep->index);
@@ -3423,7 +3423,7 @@ static void tegra_xudc_device_params_init(struct tegra_xudc *xudc)
 	}
 
 	/*
-	 * Compliacne suite appears to be violating polling LFPS tBurst max
+	 * Compliance suite appears to be violating polling LFPS tBurst max
 	 * of 1.4us.  Send 1.45us instead.
 	 */
 	val = xudc_readl(xudc, SSPX_CORE_CNT32);
-- 
2.27.0

