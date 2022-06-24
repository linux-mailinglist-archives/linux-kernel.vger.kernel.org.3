Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98F2D559B69
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 16:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbiFXOVs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 10:21:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232401AbiFXOVq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 10:21:46 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA52E562DF
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:21:44 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id 65so2669444pfw.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 07:21:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gm1rQOK+mtphDI8kcI6bqB/QE5aGOSJgtL/42BhKW1s=;
        b=jUJmsfuxsGmBkBlz8uoOMKBsh5zii0b6kyo4UGtUZtRcVP/eQ62xEqx1yp+p9r2RBb
         u2iemCnlN5ab8kxb5/SqFbREuliur6+AHpIegfg+WDqRPMdn047nR2F7NvlJhsvd1PMD
         Y5WC0N1Lbcblf5BCO/LdQbFvxSpDg+1smsR2CBnsJqNZdMAgEj4e838L8oT8mGOPmTrp
         abBOMbDW5GPx6tR5LeTLMpQw5SPhBt4gz6b1Xf2A1hZj5JKu5TKfU85dfIvDQ2af6wua
         LLQMBgNXpWRRKmKC+cs1pvDP3w5oNoUw37bUO/t020HI4hc/1v4OYMkFXJ5eULRlVHI5
         IYFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Gm1rQOK+mtphDI8kcI6bqB/QE5aGOSJgtL/42BhKW1s=;
        b=tzdkRXLDdJR1TsgNM5TVK8xNkf1WH987E5zTpQ5rUsNGyV89c3DZDVnElJog+BfSoB
         MHEkPNQgdiZc+h11W352/EgeJ59DMG9pV92XtEo7JMnGMq6Q8fUJZMpOkJykn9Phu+Su
         8I/UrwQF07xSaTdDcrOqPUy9MZpRViRbYZMPCOsr7UvyYtVB2iQmyubsEfNpE3JreEMH
         zDzB6Z3PUQNL3TgIa1XI07V40CvFYJoQaqO1np/2QBN7+2yTqTPDMi5XJdwJYap1X/HX
         8l8+bZzfa3OcT1n2ohgOnS/hsMwHCXDoziX2QylB3J6BXB1ApW+6zBB/4Y83AOUl1oP2
         4w8A==
X-Gm-Message-State: AJIora9+SGCNdAJDIMxVgzvUuqDhRZC6Q3gXFNeqjvT+4eA+p64fau+W
        HDxJlxS0wr4Q56xd5W2hOI/0uCf7wpVWhiC1
X-Google-Smtp-Source: AGRyM1vPxxwcqwbRahhD3wqTdZ41SZk38shzdGTT2AP7tkKnWCBBlZm8B6XghK3eFpJ0wOG6xCzgsg==
X-Received: by 2002:a65:6c10:0:b0:380:437a:c154 with SMTP id y16-20020a656c10000000b00380437ac154mr11854740pgu.549.1656080504253;
        Fri, 24 Jun 2022 07:21:44 -0700 (PDT)
Received: from localhost.localdomain ([199.101.192.196])
        by smtp.gmail.com with ESMTPSA id jd12-20020a170903260c00b0016a15842cf5sm1868877plb.121.2022.06.24.07.21.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Jun 2022 07:21:44 -0700 (PDT)
From:   Zhangfei Gao <zhangfei.gao@linaro.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jean-philippe <jean-philippe@linaro.org>,
        Wangzhou <wangzhou1@hisilicon.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     acc@openeuler.org, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, iommu@lists.linux.dev,
        Zhangfei Gao <zhangfei.gao@linaro.org>
Subject: [PATCH v2 0/2] fix uacce concurrency issue of uacce_remove
Date:   Fri, 24 Jun 2022 22:21:20 +0800
Message-Id: <20220624142122.30528-1-zhangfei.gao@linaro.org>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When uacce is working, uacce parent module can be rmmod, parent
device can also be removed anytime, which may cause concurrency issues.
Here solve the concurrency issue.

Jean-Philippe Brucker (1):
  uacce: Handle parent device removal

Zhangfei Gao (1):
  uacce: Handle parent driver module removal

 drivers/misc/uacce/uacce.c | 135 ++++++++++++++++++++++++-------------
 include/linux/uacce.h      |   6 +-
 2 files changed, 92 insertions(+), 49 deletions(-)

-- 
2.36.1

