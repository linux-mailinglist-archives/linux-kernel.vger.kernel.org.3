Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18636573F95
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:23:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237060AbiGMWXt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:23:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237380AbiGMWXm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:23:42 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485AA2738
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:23:37 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id d16so2056wrv.10
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:23:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ruCmAmoxX6pis6Bl4Fz9X/byBGXsAOtsRaO6C1QUaI=;
        b=jKiE6RimWUieOZRpuQr4rFLDInDXDC6e/n+FdEUgXxsHRWKmS3n9le7gnJUZWoIBpX
         MLhb0TEzuDqnsMAsYGO+i5DnsQ+b9RSBSy6adVTtOn4108T724cAASm5fOb2QUZNlyAr
         FCFxpM4T82tY0phZktlrXsNB6FwISpQnxsmOJTdHrkvJ+p+srhn/axmRWw3G1NiBjGz6
         qqDjplmEP+a7rW6IoPEvoiwCfuX8NEPjqjC6xjevhAzRe3aQeng8zsUHKbPAO6ZZojk/
         pKmOZbyhlkZ0FzQzCR6UJnpVZDMa6DZHliyUnl0chM2Hmr5GRWctAUvwS5qGNPkQNuJG
         3qtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/ruCmAmoxX6pis6Bl4Fz9X/byBGXsAOtsRaO6C1QUaI=;
        b=faozwVYZGOx8Xeo+6HheRHuQ8KnyH7hSaE4+kb2q3wG6jviPv1woLaM8Mf/Vgeoio3
         hXSzuW+tQQf9HUmed/d54D93QgMTi+B6aN0Lhujvsa156PNoQLL5pDSuPF2Ymaog+Zzi
         6YrvuZ9/CWHPO9RR8hyyx0f+x8p9g9ZoxgbuPed0gV4zKMt3E97TOiKb3KOfOuXxz4KE
         Ul53JgB4s7f5+Pq8fE7bKn7mj/DZ3uQcWt7M1v7dPOnsDyJdaL55LCnu4B/2DIPigBig
         +19MS2xd6WwCFfn1amY1BJYRvhWCjLZzuLm++4UPebigNRw/Hb74BtczOHklxOUrTzXp
         Fg5w==
X-Gm-Message-State: AJIora+3XrATCdHM0enHtNe0aZSLUYUAiN4VufrH40L8FL8BA2DuGHtX
        ONeMzgYbnC/uKSMXNkLyPv6VEjnDV/qBxQ==
X-Google-Smtp-Source: AGRyM1vVOGQrZQ4J8MhCvuS1y2lZYLOJ55AnOMgrUASZS91m2DvtOBoZEbCMx6ij7SQRQM/QTFWe5w==
X-Received: by 2002:a5d:474f:0:b0:21d:9a9b:a1fb with SMTP id o15-20020a5d474f000000b0021d9a9ba1fbmr5476906wrs.115.1657751015566;
        Wed, 13 Jul 2022 15:23:35 -0700 (PDT)
Received: from localhost.localdomain (cpc152649-stkp13-2-0-cust121.10-2.cable.virginm.net. [86.15.83.122])
        by smtp.gmail.com with ESMTPSA id 3-20020a05600c024300b003a1a02c6d7bsm3515500wmj.35.2022.07.13.15.23.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:23:35 -0700 (PDT)
From:   Ben Dooks <ben.dooks@sifive.com>
To:     linux-kernel@vger.kernel.org
Cc:     Sudip Mukherjee <sudip.mukherjee@sifive.com>,
        Jude Onyenegecha <jude.onyenegecha@sifive.com>,
        Ben Dooks <ben.dooks@sifive.com>
Subject: [PATCH] lib: include <linux/io.h> for devmem_is_allowed definition
Date:   Wed, 13 Jul 2022 23:23:25 +0100
Message-Id: <20220713222325.157357-1-ben.dooks@sifive.com>
X-Mailer: git-send-email 2.35.1
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

The devmem_is_allowed() is defined in <asm/io.h> but this or <linux/io.h>
is not included in lib/devmem_is_allowed.c does not include it. Fix the
following sparse warning by including <linux/io.h>

lib/devmem_is_allowed.c:20:5: warning: symbol 'devmem_is_allowed' was not declared. Should it be static?

Signed-off-by: Ben Dooks <ben.dooks@sifive.com>
---
 lib/devmem_is_allowed.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/lib/devmem_is_allowed.c b/lib/devmem_is_allowed.c
index 60be9e24bd57..9c060c69f134 100644
--- a/lib/devmem_is_allowed.c
+++ b/lib/devmem_is_allowed.c
@@ -10,6 +10,7 @@
 
 #include <linux/mm.h>
 #include <linux/ioport.h>
+#include <linux/io.h>
 
 /*
  * devmem_is_allowed() checks to see if /dev/mem access to a certain address
-- 
2.35.1

