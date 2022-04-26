Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2C6850FC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 14:06:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349759AbiDZMJO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 08:09:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349792AbiDZMJH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 08:09:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BED52FA40E
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650974759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dRKiCK7YkDXuEi8UT1lBCyoBeoI9sdfI9zFpeIfYSjc=;
        b=eNxmfRoLHA24WaGXMldertx1rCM2YWOzC4CoZg2qgMNA114snyMSS9tMXEiqAb+rSZSkbt
        i7z8hgfOIPKbcXAnd/w8yo+OXMVeB7ihr3H2ATfoBZZVVG8zuhdMoFoC+RP+0AXXX9jfar
        tnmLK7twhw/WlhHvBYFipK4YyaQlykY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-150-QiIOYpHcPcKt9x4ZhVVYmQ-1; Tue, 26 Apr 2022 08:05:58 -0400
X-MC-Unique: QiIOYpHcPcKt9x4ZhVVYmQ-1
Received: by mail-qt1-f200.google.com with SMTP id j9-20020ac85c49000000b002f37e06e8ffso546562qtj.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 05:05:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=dRKiCK7YkDXuEi8UT1lBCyoBeoI9sdfI9zFpeIfYSjc=;
        b=bxZ3pGLL77FGAylKEf+sWiGOGspkRfkHtBkqc/AHyEQtsFsbNFDTHRBwRWN3CvqfC5
         EkUbQtXcQBWXTqMCT6rqGaDalTnAuhKe5BpZffU/2/pNu38Qbqk8788SbPAGJgkLq/PM
         9ZXTdpGIbpqoJ4HNJODiCm7ynX+SdXzWu0xi0YbVOdkG3l/89XpxEgJsjDMZMJQps4Ix
         AgGh9Z6eOsl3xofMqUjY1jb6BnAqUr05tcAd9EyJgbWVR08KXc/WmTHkZH3q+EN0FLuw
         lmw+xs3+4yuKWf69X80kQs9KbOiR4XGgV+QTR5Rji5A7RMdZBMEocYekgXIo0n4uVlGv
         V2pw==
X-Gm-Message-State: AOAM533HLcf2noXAnzrsG8ZHquMYZuGNvIKNStl0QfHLZqP+RFffqte8
        ibGni/1XGMgbK1qx3T48ZNy7Ut0boUcieTRsMiJg3CEJwVSMCXTCdeNyg+GA+R/Awpk5OAMEric
        kRWn1tjxXBRIojRcNO65tSRr2
X-Received: by 2002:ac8:4e86:0:b0:2f3:6a2f:ef75 with SMTP id 6-20020ac84e86000000b002f36a2fef75mr5637989qtp.588.1650974757569;
        Tue, 26 Apr 2022 05:05:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzQG6Om7R3FEtSeKU6XTcpFbpghZNVbhF6P6lTL6zIz8c560p8Bgs4whB0ZkzC0XtJogWcGpw==
X-Received: by 2002:ac8:4e86:0:b0:2f3:6a2f:ef75 with SMTP id 6-20020ac84e86000000b002f36a2fef75mr5637972qtp.588.1650974757361;
        Tue, 26 Apr 2022 05:05:57 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id i19-20020a05620a249300b0069f805534d3sm454101qkn.89.2022.04.26.05.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 05:05:56 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     gregkh@linuxfoundation.org, jirislaby@kernel.org,
        nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] tty: n_gsm: return -EINVAL when adaption is not supported
Date:   Tue, 26 Apr 2022 08:05:54 -0400
Message-Id: <20220426120554.1120585-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The clang build fails with
n_gsm.c:940:13: error: variable 'size' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
        } else if (dlci->adaption == 2) {
                   ^~~~~~~~~~~~~~~~~~~

The else should return an error, so return -EINVAL.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/tty/n_gsm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index b0762d2fa8d6..3b8c65f66d64 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -944,6 +944,7 @@ static int gsm_dlci_modem_output(struct gsm_mux *gsm, struct gsm_dlci *dlci,
 	} else {
 		pr_err("%s: unsupported adaption %d\n", __func__,
 		       dlci->adaption);
+		return -EINVAL;
 	}
 
 	msg = gsm_data_alloc(gsm, dlci->addr, size, gsm->ftype);
-- 
2.27.0

