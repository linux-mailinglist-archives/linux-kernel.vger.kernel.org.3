Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9E824EFDC9
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 03:35:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237189AbiDBBgp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 21:36:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229819AbiDBBgn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 21:36:43 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79FDFC62
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 18:34:53 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id b17so3318254qvf.12
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 18:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP9DZjk6ZczTz6Snvbre433wZ+Z/QMRd5nCRz0IXdXs=;
        b=Fa13p9GdwFU7opfjdPo5hVT2m/Oi0qEPLOLVA8J2h8VJD0ZYyOTrzv9oV4wWWUJvZi
         J7SVkUanyaefso8uRwdkUSi3rhSn5iXHhBK8YzeGv1ChVCCdHGuPDNbKBey6w4j6VR/z
         jG8YzY8YgCdJ4vE0HqNvrJB4o1kR/jJGsBztyyVjnNSFplV6FdbIbzlFkpglB920KhbZ
         2ey6o//f/Aj6q5bdYqa35n0IGWgCWJ61PgUijFclfMLez1yZkbHSgiiG2kpNYu28VSSH
         iBIEerppBSbHq0BZ7dtgTv/gBR4j+T/jCgX3eOQlbvCRlqVKmlNjgSi+ItC4kh/z4uTT
         /EXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VP9DZjk6ZczTz6Snvbre433wZ+Z/QMRd5nCRz0IXdXs=;
        b=Kw4mVJgeuV1PYCE4/EzB6BRqHvsFfyr3HBLeRjRwGk56au8q9lhn/PJwQcsNEy/Txe
         nOrbXFcTC+gIB93YUbh0adgs3lvem4gDqGW+Y7XJh/dqE5fQHGjX0tQTJzBVFhoTa1Bl
         0GBj+/NZ+iIGigvGx1XnIPWby6QNBYTWtEucFsYzlnmcFjx05p7v9W1eETocuHZmsJIz
         WhE2CXQE8nv80pclhO3zE63fYWrdQ2Ik2jUGcTyf7miDzZZnf2Bkco+qc05MHxC6UagM
         TczgXNhSor1lRnA7+DtU6Ef242o6MWYtEqXYieQVVmhrNcbZ4RrmgKiEgANBILq4g/gs
         dq6Q==
X-Gm-Message-State: AOAM531MaGaK29rr+RNSyxQQzA1C9jiD2JWCkegkBTs3LWFu24xgdT9P
        pY0lUJHC574ryuuO/YXa+1M=
X-Google-Smtp-Source: ABdhPJyqslw2b/47GfaBsU/fgUlm0J5pzcv80e22GxP6cCUtZ6UqVEPfqFaOwA07H4FlJQtQ2RJ9nQ==
X-Received: by 2002:a05:6214:cad:b0:441:4269:37ff with SMTP id s13-20020a0562140cad00b00441426937ffmr42562979qvs.128.1648863292699;
        Fri, 01 Apr 2022 18:34:52 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id v12-20020a05622a130c00b002e1b3ccd9adsm2922207qtk.79.2022.04.01.18.34.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Apr 2022 18:34:52 -0700 (PDT)
From:   cgel.zte@gmail.com
X-Google-Original-From: lv.ruyi@zte.com.cn
To:     mpe@ellerman.id.au
Cc:     benh@kernel.crashing.org, paulus@samba.org, maz@kernel.org,
        nick.child@ibm.com, lv.ruyi@zte.com.cn,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] powerpc/sysdev: fix refcount leak in icp_opal_init()
Date:   Sat,  2 Apr 2022 01:34:19 +0000
Message-Id: <20220402013419.2410298-1-lv.ruyi@zte.com.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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

The of_find_compatible_node() function returns a node pointer with
refcount incremented, use of_node_put() on it when done.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Lv Ruyi <lv.ruyi@zte.com.cn>
---
 arch/powerpc/sysdev/xics/icp-opal.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/sysdev/xics/icp-opal.c b/arch/powerpc/sysdev/xics/icp-opal.c
index bda4c32582d9..4dae624b9f2f 100644
--- a/arch/powerpc/sysdev/xics/icp-opal.c
+++ b/arch/powerpc/sysdev/xics/icp-opal.c
@@ -196,6 +196,7 @@ int __init icp_opal_init(void)
 
 	printk("XICS: Using OPAL ICP fallbacks\n");
 
+	of_node_put(np);
 	return 0;
 }
 
-- 
2.25.1

