Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D64BB4F0A70
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:54:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359087AbiDCOzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238092AbiDCOzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:55:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4FE37396B6
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:53:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648997589;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=LFfRhd7Sfzdrdd1INj/Q/SqPdx7gABrZJOzXKbno2vQ=;
        b=BFGeEvCGIfx0XlsEk54yb3cFEWpqz4If677kf1IOcS3PKECTjAaVpN8dB7fG2HZD42aYgP
        VTDhO0NGBcNkEXsI/FgxBPx3/ERdjJpbLkdZRxUTVyAM2B5KttgzrcPfrZ00fGoP1GCpim
        IyYMUaL+yuYWOx4oPJE4FVtS+iyjDKg=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-346-ZTPF3PBiO1CbVXYZ-w9ndQ-1; Sun, 03 Apr 2022 10:53:08 -0400
X-MC-Unique: ZTPF3PBiO1CbVXYZ-w9ndQ-1
Received: by mail-qv1-f72.google.com with SMTP id g1-20020a0562140ac100b00443ca5e8059so2611856qvi.17
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 07:53:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=LFfRhd7Sfzdrdd1INj/Q/SqPdx7gABrZJOzXKbno2vQ=;
        b=ySmHYKawb3N2+UxEfft3MBjD0J8/WTCYG1hd7B4tL5orp5JpeH8lyk87nFFCehy4IO
         m3gY0obKUZZ5Pb3morj4qUOfT8elzqTWYZTGJJaEw9o6PUg9B8BM7hPjinfh6fKokTZW
         c1EUbl5D5dfPzFuSMgJHTCQBDncsCdEk+E8MSzg9UEzRP+dtNh6MLVc3vAevLSoayYqD
         YhLi3n4ZdZyFwLuRXdBzIydbAEZkMsosFV7UMITZhyz9z2VlBntSzW/I+iSoo2o1qeMh
         1sewa9xY2glG1TX2jmqY4wF6B5Esb5kC/NTaibsq6o8Raod1ZeFto81fX2FmqDlwqfn2
         o+IQ==
X-Gm-Message-State: AOAM533XkJNDT8b+MtZvjTPG0uYrDX8OqZMZVHlH5ROBYB/iRVQdrkr6
        ccv32yFJIhS+gnl6ckZ42tAidwvaeoMLFvI8LXJf94+962rUtTwSDISWSye2V0UVXcXGAj+jBV/
        rc1vnWzPrYS9EIHlUy8emyOK3
X-Received: by 2002:a05:6214:e69:b0:441:75c6:92d with SMTP id jz9-20020a0562140e6900b0044175c6092dmr14307328qvb.99.1648997587960;
        Sun, 03 Apr 2022 07:53:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/HIvXI8os8Ml55FFBb0QLFbZHcrRmId+ROUfy4QTy8ixdqR3vv+seVxFOAOcakl/b5zqGAw==
X-Received: by 2002:a05:6214:e69:b0:441:75c6:92d with SMTP id jz9-20020a0562140e6900b0044175c6092dmr14307317qvb.99.1648997587813;
        Sun, 03 Apr 2022 07:53:07 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id x6-20020a376306000000b0067b32a8568esm4716651qkb.101.2022.04.03.07.53.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:53:07 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     jassisinghbrar@gmail.com, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] mailbox: imx: remove redundant initializer
Date:   Sun,  3 Apr 2022 10:53:04 -0400
Message-Id: <20220403145304.685443-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
imx-mailbox.c:887:10: warning: Initializer entry defined twice
imx-mailbox.c:889:10:   also defined here

  .rxdb	= imx_mu_generic_rxdb,

Is listed twice, so remove one.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/mailbox/imx-mailbox.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/mailbox/imx-mailbox.c b/drivers/mailbox/imx-mailbox.c
index e88f544a1548..df8a785be324 100644
--- a/drivers/mailbox/imx-mailbox.c
+++ b/drivers/mailbox/imx-mailbox.c
@@ -886,7 +886,6 @@ static const struct imx_mu_dcfg imx_mu_cfg_imx8ulp = {
 	.rx	= imx_mu_generic_rx,
 	.rxdb	= imx_mu_generic_rxdb,
 	.init	= imx_mu_init_generic,
-	.rxdb	= imx_mu_generic_rxdb,
 	.type	= IMX_MU_V2,
 	.xTR	= 0x200,
 	.xRR	= 0x280,
-- 
2.27.0

