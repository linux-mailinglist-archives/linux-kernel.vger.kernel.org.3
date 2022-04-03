Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FB864F0A00
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Apr 2022 15:39:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358890AbiDCNlH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Apr 2022 09:41:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232011AbiDCNlG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Apr 2022 09:41:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F28E5326D8
        for <linux-kernel@vger.kernel.org>; Sun,  3 Apr 2022 06:39:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648993151;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=J/vKqF4Fb5vvVfUXn1DmQOnTx8l3MynEh/qGnDOubjg=;
        b=W2+WOE4XvI+lr//WY2EK/ea/EBtYh9DOq6hGyNXHTlzIewBW7K7uW5FCE1Rh7U5I4mYBU6
        euY6ukpYpkQeQTW0NjcGQWByWxzziovm7cfLVH2pUBIC+v+bdC7Nd1WB5GrSQjcTo0nYaU
        XAVZSG0cP3kGaVYHGUdc9Cc1eZ6iog4=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-395-y7rB5BVRNkal1NIG_QmeOg-1; Sun, 03 Apr 2022 09:39:10 -0400
X-MC-Unique: y7rB5BVRNkal1NIG_QmeOg-1
Received: by mail-qt1-f199.google.com with SMTP id h11-20020a05622a170b00b002e0769b9018so4825392qtk.14
        for <linux-kernel@vger.kernel.org>; Sun, 03 Apr 2022 06:39:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=J/vKqF4Fb5vvVfUXn1DmQOnTx8l3MynEh/qGnDOubjg=;
        b=MRwLNe2pkIAzGQpDPsu/2mjq+foDr4BWDp6rm3HOAKl4Dj2I2RaUWGuFHNk2R1WJzo
         aSeC3ES9NKqlmKt8aUhGqoj0yniaZhFfdJFqIAxTM/+SqW2xXIxvEyVjT91EO8ymJ4p2
         41AeyvpX+Y4BeSh7wr9cK4DOkaQ4pWFvaEpizPIPSN/YeUxXuAMvL1huC1qSAFmGEiK6
         MnBt0/uh5O/mba2IYCL8TAcTcPGGTd5WJVUFweIuNDoc014CRQhmhd4fFDNbxWoOP1zt
         Z5ufNcKdM1Q5gn6T+IYKD0gQR1ZaKz/iMPLYqOqntDUVtPjBFkzHAkYRKmGQsOvVVzQu
         IYUQ==
X-Gm-Message-State: AOAM532vaj9gv55EWUKHlkg1pvNnzIry5NJ/RD8bqrJSMfm7r1p3Za7T
        fyBovNSBDDWV2vqMeqmfQ8m9Zh0qHt7HQRASrNi/t5ORBpSa+dyTWIdgrw1qULvXOJL9Y7uKWub
        Y6R9R0cyPSHPpeu15ZD9btMLs
X-Received: by 2002:a05:622a:302:b0:2e0:7aed:d653 with SMTP id q2-20020a05622a030200b002e07aedd653mr14547286qtw.492.1648993149412;
        Sun, 03 Apr 2022 06:39:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJznBY6lM5pUk5KLpWwhsYcpw73/6PHuL9br7Xdu2mnLktf9MGSSS8Zh0+xwBiFGKXjQlPUh/g==
X-Received: by 2002:a05:622a:302:b0:2e0:7aed:d653 with SMTP id q2-20020a05622a030200b002e07aedd653mr14547278qtw.492.1648993149184;
        Sun, 03 Apr 2022 06:39:09 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id o21-20020ac85a55000000b002e16389b501sm6096875qta.96.2022.04.03.06.39.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 06:39:08 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     vincent.sunplus@gmail.com, srinivas.kandagatla@linaro.org
Cc:     linux-kernel@vger.kernel.org, Tom Rix <trix@redhat.com>
Subject: [PATCH] nvmem: change sp_otp_v0 from global to static
Date:   Sun,  3 Apr 2022 09:39:06 -0400
Message-Id: <20220403133906.1379832-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch reports this issue
sunplus-ocotp.c:74:29: warning: symbol 'sp_otp_v0'
  was not declared. Should it be static?

sp_otp_v0 is only used in sunplus-ocotp.c.  File
scope variables used only in one file should
be static. Change sp_otp_v0's storage-class-specifier
from global to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/nvmem/sunplus-ocotp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvmem/sunplus-ocotp.c b/drivers/nvmem/sunplus-ocotp.c
index 2dc59c22eb55..e0b11e13f5f8 100644
--- a/drivers/nvmem/sunplus-ocotp.c
+++ b/drivers/nvmem/sunplus-ocotp.c
@@ -71,7 +71,7 @@ struct sp_ocotp_data {
 	int size;
 };
 
-const struct sp_ocotp_data  sp_otp_v0 = {
+static const struct sp_ocotp_data  sp_otp_v0 = {
 	.size = QAC628_OTP_SIZE,
 };
 
-- 
2.27.0

