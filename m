Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 779304C5CD1
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Feb 2022 17:18:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231600AbiB0QSd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Feb 2022 11:18:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231321AbiB0QSb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Feb 2022 11:18:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 72C58DF4E
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:17:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645978673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UEEZb2DOh5vylG1x1VMy8AuvAs8IP8CoCmlX2Vt9jDU=;
        b=g5xliKYZgBCrcXrtD8G25AzNbFTclOnvgVmMEVEdEqBtk8+nal5dMqGJeHRZJ7qnSzQu1Y
        z1gyrXia5l1rJS4RCtmzuqqO4s3bl6RJtrG4yzApraiX2AyGsgQJveRmBRTCPvIuc+fkC0
        FC6TWORvFARv/x2TojeCojM6q0Obcio=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-609-ZV4Y63jEPK6xAoVai3JyjA-1; Sun, 27 Feb 2022 11:17:52 -0500
X-MC-Unique: ZV4Y63jEPK6xAoVai3JyjA-1
Received: by mail-qv1-f71.google.com with SMTP id v16-20020a0ce1d0000000b00432bb204b3dso7311024qvl.13
        for <linux-kernel@vger.kernel.org>; Sun, 27 Feb 2022 08:17:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=UEEZb2DOh5vylG1x1VMy8AuvAs8IP8CoCmlX2Vt9jDU=;
        b=Z78vNmA+8dBAthblKpah6CJnNlFjDfdmdX2tuzbqaqwD3JYhwBoeFmHwbRad1ELIcJ
         YjkUwma6mBOslrrawhNEXV7y1aeMaxknFAAFNuGSH2QhDC5+e4+FBqDjGdzKwrI56L6C
         SYD0O74trlAZfqLYYNWhIouqXVb0ci6oNJ+KjP62630cFMc4OkbZsMt+9fN9ZDvcS9Y/
         Z4lFvu+4zDwSvKF9kpQ4gSlCKz0WmYLaEwF46ioSPfOvHWXirw5e4vo2d0zzKbF3CHyT
         h9OCJ+YqKdsa5dxXTtf3hnyWRW5SO283I1jyPkxdM4vTqJP9DyM/uNQ3DSzBwxgCkgew
         3s3w==
X-Gm-Message-State: AOAM533ZVIQnD37elpmHDbzBqacgfTqMkHZod7bFixifkVsoLoQUv0hW
        BWt0Ti3iWd89g/8vWzgoVHhYroQNVfFWvGu8ShKL7y6ovAH6ExbbPP+MRPF+4EisngTfVCTTf8F
        wc++DVi7Subuqs5k19Fpg41jr
X-Received: by 2002:a05:620a:576:b0:649:243f:752d with SMTP id p22-20020a05620a057600b00649243f752dmr9320426qkp.699.1645978671552;
        Sun, 27 Feb 2022 08:17:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzsYFLTwjcspUwtB5uDZ6VD5JILqh8bnjJ0uyOIdm4mEt5/kyzeqiapVtIaaLGd4DnYIn9tgw==
X-Received: by 2002:a05:620a:576:b0:649:243f:752d with SMTP id p22-20020a05620a057600b00649243f752dmr9320418qkp.699.1645978671320;
        Sun, 27 Feb 2022 08:17:51 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id v26-20020a05620a0a9a00b00605c6dbe40asm3823172qkg.87.2022.02.27.08.17.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Feb 2022 08:17:50 -0800 (PST)
From:   trix@redhat.com
To:     vilhelm.gray@gmail.com, nathan@kernel.org, ndesaulniers@google.com,
        Jonathan.Cameron@huawei.com
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] counter: add defaults to switch-statements
Date:   Sun, 27 Feb 2022 08:17:46 -0800
Message-Id: <20220227161746.82776-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this representative problem
counter-chrdev.c:482:3: warning: Undefined or garbage value
  returned to caller
  return ret;
  ^~~~~~~~~~

counter_get_data() has a multilevel switches, some without
defaults, so ret is sometimes not set.
Add returning -EINVAL similar to other defaults.

Fixes: b6c50affda59 ("counter: Add character device interface")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/counter/counter-chrdev.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/counter/counter-chrdev.c b/drivers/counter/counter-chrdev.c
index b7c62f957a6a8..69d340be9c93f 100644
--- a/drivers/counter/counter-chrdev.c
+++ b/drivers/counter/counter-chrdev.c
@@ -477,6 +477,8 @@ static int counter_get_data(struct counter_device *const counter,
 		case COUNTER_SCOPE_COUNT:
 			ret = comp->count_u8_read(counter, parent, &value_u8);
 			break;
+		default:
+			return -EINVAL;
 		}
 		*value = value_u8;
 		return ret;
@@ -496,6 +498,8 @@ static int counter_get_data(struct counter_device *const counter,
 		case COUNTER_SCOPE_COUNT:
 			ret = comp->count_u32_read(counter, parent, &value_u32);
 			break;
+		default:
+			return -EINVAL;
 		}
 		*value = value_u32;
 		return ret;
-- 
2.26.3

