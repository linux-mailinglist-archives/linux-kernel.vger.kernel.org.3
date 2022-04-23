Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACB650C9EA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 14:31:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235424AbiDWMeA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 08:34:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231231AbiDWMd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 08:33:58 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2D7321696EE
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650717060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=BeOJYjv9Uq2XAYhQoQ5l1QOio0YQGcQSqiAKchKFN5I=;
        b=E9/ioy77zwY21eX+UcpvtdiQp7kIrGOwyLaIlUDUqof3GRr+g1vSHYf9fBDJPYeFm13/Lh
        5DmhvvO23lmQ5ScMglaT++D0RUrZ/7edi2+FCFwXFVbtucpeGMbdCJ79kW9UAFY2PZCmL4
        x6mVT9yNHg9nqeT7uKIGtJEuTVcSZJ8=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-286-YZgoz7wRPfaJGnnhAoYjew-1; Sat, 23 Apr 2022 08:30:58 -0400
X-MC-Unique: YZgoz7wRPfaJGnnhAoYjew-1
Received: by mail-qv1-f69.google.com with SMTP id u7-20020a0cb407000000b00446687f0b1bso8767117qve.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 05:30:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=BeOJYjv9Uq2XAYhQoQ5l1QOio0YQGcQSqiAKchKFN5I=;
        b=A5zZIkOmVVKuO5vTzu1qrpOOMj3zp/8Cg3+T7ur3rw8iSPWy2pZFhr0un40Vxgb4Yk
         w0ARybTBnOO9D/fdMj3n45YKisn23LsqT5U5kIy3XvlNegPZ47M20YkVO731Dkwu4IZY
         7OZc/j88GZ/ce68lvHI2rA+vars0SY2a5gtJRJdmtw9k2IjbBQhxLRaKfnXJdb6lm3KP
         JONBjdeqXesbhPZ66XQIDgfXqweG+faK7KMfKyL8/Wj6pMeI5bR0PUMX7XwE6Ot/bWPs
         uLaGCcl8DscwDqiRlTbAEwYDrxc/gzeXXQ9WDWZLtFSnWakl4eo/nCfh2JaXhe9t+Znb
         ACsQ==
X-Gm-Message-State: AOAM530HoYSEB5zDUJ0F/GLZL5LHPHbFbKwxqbeOC+t7E57ODVAnhZmj
        OjC9PUjulRnWjjCuvfFdtNBsrvUvuX1FXfwEenPHKluiZ7b1EK0jzD2nQVLsEii1hZ9Xu6l50f7
        JxVV+Q4hMjt+5XHBl3+saZXKb
X-Received: by 2002:ad4:5be1:0:b0:440:a2ec:ea99 with SMTP id k1-20020ad45be1000000b00440a2ecea99mr6617958qvc.20.1650717058476;
        Sat, 23 Apr 2022 05:30:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhVcaF6hVaQMxy2Bx+WEj0Dv5VCNN+pTO04EbmEvOcA4BOxWj6bxa7W6hRQnXKI8Wa64U7Yg==
X-Received: by 2002:ad4:5be1:0:b0:440:a2ec:ea99 with SMTP id k1-20020ad45be1000000b00440a2ecea99mr6617945qvc.20.1650717058312;
        Sat, 23 Apr 2022 05:30:58 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id y15-20020a05620a09cf00b0069c80404de6sm2105323qky.31.2022.04.23.05.30.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 05:30:57 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     irenic.rajneesh@gmail.com, david.e.box@intel.com,
        hdegoede@redhat.com, markgross@kernel.org
Cc:     platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] platform/x86/intel: pmc/core: change pmc_lpm_modes to static
Date:   Sat, 23 Apr 2022 08:30:48 -0400
Message-Id: <20220423123048.591405-1-trix@redhat.com>
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

Sparse reports this issue
core.c: note: in included file:
core.h:239:12: warning: symbol 'pmc_lpm_modes' was not declared. Should it be static?

Global variables should not be defined in headers.  This only works
because core.h is only included by core.c. Single file use
variables should be static, so change its storage-class specifier
to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/platform/x86/intel/pmc/core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/pmc/core.h b/drivers/platform/x86/intel/pmc/core.h
index a46d3b53bf61..7a059e02c265 100644
--- a/drivers/platform/x86/intel/pmc/core.h
+++ b/drivers/platform/x86/intel/pmc/core.h
@@ -236,7 +236,7 @@ enum ppfear_regs {
 #define ADL_LPM_STATUS_LATCH_EN_OFFSET		0x1704
 #define ADL_LPM_LIVE_STATUS_OFFSET		0x1764
 
-const char *pmc_lpm_modes[] = {
+static const char *pmc_lpm_modes[] = {
 	"S0i2.0",
 	"S0i2.1",
 	"S0i2.2",
-- 
2.27.0

