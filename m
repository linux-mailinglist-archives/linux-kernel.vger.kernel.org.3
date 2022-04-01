Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9185C4EE96B
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 09:56:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344079AbiDAH6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 03:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245108AbiDAH6g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 03:58:36 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59283267583;
        Fri,  1 Apr 2022 00:56:47 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 85so1482474qkm.9;
        Fri, 01 Apr 2022 00:56:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9g3A+Aj99vNxItNSwcSuRfYALYB+zaA6rfn+8eFdWC4=;
        b=dkAtwaPew0tAja8U6bbKfKMn3g99pI9I/Yi/CxDe+marRIj6vCyE10eWZ3TwT4l11V
         B20Qn8+RLkPMe3jMQ/71G2a+Ie9IL6gj6i4EtRpuGqYbLDimdzyokcuNmfzumtrt0MPz
         /CklPz4pQOI5dlNxicPVwrcBRWXYqT5SIQlwTF4L8HykQmuG7F7sJRkNyXUAastRC+Ek
         H4vwbOoc/ugf9OMXJve3PytG9OYREXknfcCsSl78T7IoIuAcHGLDF6m+xR4BlDXWfn/P
         XWtZJfMeT4wWshP95US/9uPhfT8kiz3SwDOAdcAjGsF9Xi4qqHSHKRmOMnw+YR1ogOmq
         sc4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=9g3A+Aj99vNxItNSwcSuRfYALYB+zaA6rfn+8eFdWC4=;
        b=Me33ggmHnIWqzu/7eYTRSEGwhiQgxXWox54VN2N2mFGT/Eqax0tP0xfJw40ioVyolm
         wJkJhxqwaHuH1fVtmNsBCzVx3rNpCBnDCBOc3t3DqIAOLi+J/iraHqfuPWkTltsz+TnK
         5u+IHF0jgVdcy/0DJZ2n6ggycB0nwNk6G40woeqMAlu0+Y9UfZI4vQYa+2YdkyU7csQs
         oFGK+bfg4+bzLGbBVFj2Su40TTaZdSVTAOlUsz4alT94Q2TIU6p7/wpnA8Bv6rDvTNLL
         WW2Y5N+tMRod8atO6G/i9c/z/l+sjd4oWS+Eb3ixYiDvq+knwCnEkNHQA5qN6xaIegUF
         rJ1A==
X-Gm-Message-State: AOAM530L3EjIOsAYvjSeUVCgThWMQYI7RctCRMNj1FjOqih2aGeMmWhy
        +K+ebFDiYMuVHbw2U4IENNZmLT4otlM=
X-Google-Smtp-Source: ABdhPJzTa0VnR6KTAReY57UMiVvyoluIsuDu/7SqwVaVfpsq8RGe9WhaU8NnKE4zm8sd8/1UTyDNXg==
X-Received: by 2002:a05:620a:792:b0:67d:7fcc:2809 with SMTP id 18-20020a05620a079200b0067d7fcc2809mr5736689qka.126.1648799806503;
        Fri, 01 Apr 2022 00:56:46 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id k73-20020a37a14c000000b0067b316a4161sm919864qke.120.2022.04.01.00.56.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 00:56:46 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     hca@linux.ibm.com, gor@linux.ibm.com
Cc:     agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
        svens@linux.ibm.com, lv.ruyi@zte.com.cn, egorenar@linux.ibm.com,
        oberpar@linux.ibm.com, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] s390: replace zero-length array with flexible-array member
Date:   Fri,  1 Apr 2022 07:56:39 +0000
Message-Id: <20220401075639.2407457-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Lv Ruyi <lv.ruyi@zte.com.cn>

There is a regular need in the kernel to provide a way to declare
having a dynamically sized set of trailing elements in a structure.
Kernel code should always use “flexible array members”[1] for these
cases. The older style of one-element or zero-length arrays should
no longer be used[2].

[1] https://en.wikipedia.org/wiki/Flexible_array_member
[2] https://www.kernel.org/doc/html/v5.16/process/deprecated.html#zero-length-and-one-element-arrays

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 drivers/s390/char/sclp_cmd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/s390/char/sclp_cmd.c b/drivers/s390/char/sclp_cmd.c
index 15971997cfe2..3c87057436d5 100644
--- a/drivers/s390/char/sclp_cmd.c
+++ b/drivers/s390/char/sclp_cmd.c
@@ -241,7 +241,7 @@ struct attach_storage_sccb {
 	u16 :16;
 	u16 assigned;
 	u32 :32;
-	u32 entries[0];
+	u32 entries[];
 } __packed;
 
 static int sclp_attach_storage(u8 id)
-- 
2.25.1

