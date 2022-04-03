Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 465034F0A16
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 16:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358365AbiDCOEW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 10:04:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350651AbiDCOET (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 10:04:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5EC5E38D8C
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 07:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648994543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=IgMX2nj2cNExGiU4IHmGwPOWMy+mYsJ+4MxIjrhMhLQ=;
        b=WxU1ua3Hvdk8btLLcLi/UpyHxMqLJ2WSkkzDwRc6T3a+UD57expJVWlDad8FMIJSQN/3F6
        1/1F1J3XSCRH9okpSOHEvdCdz7vZoktJMDU5l9QArivD/ak2uXTTd0AORFrpxe4/o0I6fY
        xUdRtkwTzcf531VnABp8Q1SCUdn6Hk4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-662-OvQrXa5INPicSH1Xl--8ZA-1; Sun, 03 Apr 2022 10:02:15 -0400
X-MC-Unique: OvQrXa5INPicSH1Xl--8ZA-1
Received: by mail-wm1-f72.google.com with SMTP id l7-20020a05600c1d0700b0038c9c48f1e7so5592081wms.2
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 07:02:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=IgMX2nj2cNExGiU4IHmGwPOWMy+mYsJ+4MxIjrhMhLQ=;
        b=I5ccs4xZWnyTzeY89u+KrQp83NLhGGzKGYzy13jGoWQQKhJ/E1C3ocYZr586kDwudG
         0lfxBLT/45o9+JwD1I7Dn1caP64dJgfemfTy91WWtl9P/m2lq1Hi5i91Ajg+kqG4qFE4
         fUbdnFpELdH8x+Ucwu06C4yYumQ+YEWV0TWLLm5bWzXkz8fByrfdvCjGL8snI1Dek1XO
         +z6O6Q+ZOF6052baILECum9Lg2T43CojsDQ9WSzB0ePLVbLL9UxpAEuqBKNmNrDcBUVN
         d9Fgzqj8OsNf65P7X4uD82LJ/oShaukPIPITNfao61rYJmdsMHrS3dOhw7GH+Tw5/6na
         1MFg==
X-Gm-Message-State: AOAM531UOymAMAYEDoFsy8xs9LNqOSWPxWci1mrdxYu3s6o9p/iaxdTX
        Mf5djRAHr2dHUJFl+coajZh5zWD31+yHepb4mJyKDKHhbsFg4GMZWW0Skgb3PqEF4Y2rtKOsrdO
        o+aaY7I2iVwLT6lBQiL2ZoSua
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id b8-20020a5d40c8000000b002052a3b0c2cmr14072342wrq.13.1648994534315;
        Sun, 03 Apr 2022 07:02:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwz8TWqYImcP6rcwIhAkGMXujAFPtHd1mtW4Epczq6oGwMPXw022V6Oc/3xXzJvj9XSl1FGwA==
X-Received: by 2002:a5d:40c8:0:b0:205:2a3b:c2c with SMTP id b8-20020a5d40c8000000b002052a3b0c2cmr14072332wrq.13.1648994534137;
        Sun, 03 Apr 2022 07:02:14 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id k9-20020adfb349000000b00206101fc58fsm914374wrd.110.2022.04.03.07.02.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 07:02:13 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     peppe.cavallaro@st.com, alexandre.torgue@foss.st.com,
        joabreu@synopsys.com, davem@davemloft.net, kuba@kernel.org,
        pabeni@redhat.com, mcoquelin.stm32@gmail.com
Cc:     netdev@vger.kernel.org, linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] stmmac: dwmac-loongson: change loongson_dwmac_driver from global to static
Date:   Sun,  3 Apr 2022 10:02:02 -0400
Message-Id: <20220403140202.2191516-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
dwmac-loongson.c:208:19: warning: symbol
  'loongson_dwmac_driver' was not declared.
  Should it be static?

loongson_dwmac_driver is only used in dwmac-loongson.c.
File scope variables used only in one file should
be static. Change loongson_dwmac_driver's
storage-class-specifier from global to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
index ecf759ee1c9f..017dbbda0c1c 100644
--- a/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
+++ b/drivers/net/ethernet/stmicro/stmmac/dwmac-loongson.c
@@ -205,7 +205,7 @@ static const struct pci_device_id loongson_dwmac_id_table[] = {
 };
 MODULE_DEVICE_TABLE(pci, loongson_dwmac_id_table);
 
-struct pci_driver loongson_dwmac_driver = {
+static struct pci_driver loongson_dwmac_driver = {
 	.name = "dwmac-loongson-pci",
 	.id_table = loongson_dwmac_id_table,
 	.probe = loongson_dwmac_probe,
-- 
2.27.0

