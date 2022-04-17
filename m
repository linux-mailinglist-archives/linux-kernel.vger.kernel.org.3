Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 309E35047DA
	for <lists+linux-kernel@lfdr.de>; Sun, 17 Apr 2022 15:07:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234142AbiDQNKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 17 Apr 2022 09:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234135AbiDQNKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 17 Apr 2022 09:10:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0B93F3A5ED
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650200848;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=2NwAEZe2oe/eBcVmeVKeLZ3JZbCLX6HoW7jxxZnMSXo=;
        b=f6Ka8u5fXcAlffxS/qNrLKhlOsLPpvscM0YxAsW9WnC2z9JVRCIQoiueD+eeXH32scJeVH
        t2nlc/AyGP1JOPaQAPxqCDtL7wMg+pXKVbjYArFklb7BhdHe/KhUQiCv0xWGk6KawEQABS
        SrUxEL8zbmb2wEJh5ozVZswzLpFnUIw=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-435-Tz-TyE-LOMWHwJplyqKMBw-1; Sun, 17 Apr 2022 09:07:17 -0400
X-MC-Unique: Tz-TyE-LOMWHwJplyqKMBw-1
Received: by mail-qv1-f71.google.com with SMTP id a3-20020a056214062300b00443cd6175c8so10381574qvx.4
        for <linux-kernel@vger.kernel.org>; Sun, 17 Apr 2022 06:07:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=2NwAEZe2oe/eBcVmeVKeLZ3JZbCLX6HoW7jxxZnMSXo=;
        b=HU9HbeGZq9L+htPbUuM635JPWYTIBPWlvtIQ/ucLqnKdF42e+LO5MLQfk0nBMjMT3a
         T8BodweH/FZKhGXHUJ42iUd/5Kj5/6wEqmRRiwGHxl6IJ8fhJFmJTpKyphBP7nfVMWNV
         6QF2OFVOnAwEWSfzUeo/JLobTOwN470rN5pfWsQ8lquSXFVvcf+NxN9xrUShKyYE2JRD
         itnVL3sSQtyTcbUVxmGmYpt/lbeDWglaVzfxqtqAQrcx/Sdn9YMWPOY2kyQn294N9FKc
         eCKb94lgrLB5Wh1DRtIPutH3lEy0flxSs8uJeoAUQH8gYMGqI6tmiHLTrt/KWqul3IeH
         P6+A==
X-Gm-Message-State: AOAM532VsKNDrcjt5sl18amMyy7xmmXAlNAO2uRwom4AdD664ziwfMJK
        03Wp7+5NsUy8VidUTJq7mxQ2fyTtBVJ/lTIHHNNxbm3TOGXJYAIkSLflkXpq6GkjSo/McSZinis
        X7uAqWuJU/dV9xib/2mnHYy2H
X-Received: by 2002:ac8:764e:0:b0:2eb:d973:50bf with SMTP id i14-20020ac8764e000000b002ebd97350bfmr4337879qtr.70.1650200837191;
        Sun, 17 Apr 2022 06:07:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzrP2i7t47KIvWqNguloCZux/VuEEyEN1n3q2TYFEbHP5vZgWRTRM5xPvnuLycqPfDYW6jDDQ==
X-Received: by 2002:ac8:764e:0:b0:2eb:d973:50bf with SMTP id i14-20020ac8764e000000b002ebd97350bfmr4337853qtr.70.1650200836938;
        Sun, 17 Apr 2022 06:07:16 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i136-20020a379f8e000000b0069c7f8b69b8sm4583861qke.82.2022.04.17.06.07.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Apr 2022 06:07:16 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     balbi@kernel.org, gregkh@linuxfoundation.org,
        thierry.reding@gmail.com, jonathanh@nvidia.com, waynec@nvidia.com,
        jakobkoschel@gmail.com, zhangqilong3@huawei.com,
        rikard.falkeborn@gmail.com, chunfeng.yun@mediatek.com
Cc:     linux-usb@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH v2] usb: gadget: tegra-xudc: clean up comments
Date:   Sun, 17 Apr 2022 09:07:12 -0400
Message-Id: <20220417130712.3932247-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Spelling replacements
endpiont to endpoint
Compliacne to Compliance

Signed-off-by: Tom Rix <trix@redhat.com>
---
v2: restore cancelled, fix commit log

 drivers/usb/gadget/udc/tegra-xudc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/tegra-xudc.c b/drivers/usb/gadget/udc/tegra-xudc.c
index d9c406bdb680..6d31ccf6aee5 100644
--- a/drivers/usb/gadget/udc/tegra-xudc.c
+++ b/drivers/usb/gadget/udc/tegra-xudc.c
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

