Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80734D2D15
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 11:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiCIKZs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 05:25:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbiCIKZq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 05:25:46 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98CC156C66
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 02:24:47 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id t5so1850967pfg.4
        for <linux-kernel@vger.kernel.org>; Wed, 09 Mar 2022 02:24:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id;
        bh=Ce2OWqbOvhVGvkh9CKalayGwAHAmYG9YoQa70H7zwHk=;
        b=nhsB643oL1z7gSz9OhPKaYTp92GH9sg+/1DuFdJZk1fKbP62NAfuUgyhqycQ1FqFo+
         5rmoZlZtyivfZVAfYIzmCykCkAF7VU1tcpTtbcye+FzMNUMSpsDn1HqQQBeUEfkEWQYp
         phjIaBxXla2Fnmq5PQsLvQJ35lNRalRiFJpTO3Ize16CEx26rLuoCAWTk4XyO7syLutA
         J3tc9yg10WtAbYAUMBfgpJ+sR6FFaDtRA436mFodx2KdMVDsvM4z+cFoBv+/3JIWLk8M
         LpVMxj0oNuGCkXxkgBd9K3GEPtyHQUZeXY/NhLKujU7sDdSUUiB/QiXt1QbA8U9hCvIC
         UjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Ce2OWqbOvhVGvkh9CKalayGwAHAmYG9YoQa70H7zwHk=;
        b=tQRlnfYVc9h28Iw3G0zJ1KmgtaSKJbb/YwHNLTq8u/X20YIsxyfzTVaKbLoQhjdATJ
         YoK6zBJfKRZv30PAg5bgRggAWnsTeB3ecFD35j5kOVAxX3yEIDd8x+TizjbvQJg/kqUF
         O+DQM5DzWmLC4W91ugE1qEPC0Si23/4r9PKI6vSeREdWSo0vRyxFZB483s288z60WbNw
         DDrJVDLxunqN3pTNji2DveUWBSLroiCdNwnMk5BlQ9P3mWWQuvZs4i6v0A86wvdo9gEn
         o0pNLHK30P59MadIykT0u4p6LiEB52b+kEI7VmLkqPCBx3mmlGxak1BlmJvaMlr3ed8p
         C3gQ==
X-Gm-Message-State: AOAM532BdLSsRvp5kKb/ATvGmCcjErKga0whYa2ZjKvPplzx8c7rtkPa
        BO3a/yIfPHSX5vLusLZ7Dwo=
X-Google-Smtp-Source: ABdhPJwWk0jNGLAAdDoKZXq4XIQ1YkfcmM4HG7VGwMH/fxjxX2ftGdpC0zjfa6zFKyVMKy6b1+9O+g==
X-Received: by 2002:a63:3d48:0:b0:374:4b15:76e4 with SMTP id k69-20020a633d48000000b003744b1576e4mr17404308pga.593.1646821487378;
        Wed, 09 Mar 2022 02:24:47 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.googlemail.com with ESMTPSA id a38-20020a056a001d2600b004f70d5e92basm2369076pfx.34.2022.03.09.02.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 02:24:47 -0800 (PST)
From:   Miaoqian Lin <linmq006@gmail.com>
To:     Stefano Stabellini <sstabellini@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Shannon Zhao <shannon.zhao@linaro.org>,
        Julien Grall <julien.grall@arm.com>,
        xen-devel@lists.xenproject.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     linmq006@gmail.com
Subject: [PATCH] arm/xen: Fix refcount leak in xen_dt_guest_init
Date:   Wed,  9 Mar 2022 10:24:41 +0000
Message-Id: <20220309102442.14726-1-linmq006@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The of_find_compatible_node() function returns a node pointer with
refcount incremented, We should use of_node_put() on it when done
Add the missing of_node_put() to release the refcount.

Fixes: 9b08aaa3199a ("ARM: XEN: Move xen_early_init() before efi_init()")
Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
---
 arch/arm/xen/enlighten.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index ec5b082f3de6..262f45f686b6 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -424,6 +424,7 @@ static void __init xen_dt_guest_init(void)
 
 	if (of_address_to_resource(xen_node, GRANT_TABLE_INDEX, &res)) {
 		pr_err("Xen grant table region is not found\n");
+		of_node_put(xen_node);
 		return;
 	}
 	xen_grant_frames = res.start;
-- 
2.17.1

