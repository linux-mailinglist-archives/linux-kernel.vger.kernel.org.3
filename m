Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 74B2C48E162
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 01:10:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238370AbiANAKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 19:10:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238356AbiANAKU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 19:10:20 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBCDC061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:10:20 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso20383364pjm.4
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 16:10:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/C3PGCEVWLO0uOy1T7KZibXtT4SeasJLjPrh8DOrydo=;
        b=JkpAw1UUdMMzJ4z3PNAuGBw81ik+w1CEEoMF6j7nJHsFC6fVF9vlPa7etaQOSoQ60d
         ZdkAFrLSO+Bn9NU2TYkgdzmGVQX8TK8UUA4mFrwfciZ3QOhI2EQuXPUNsFm7yOZ4x/Ld
         JGsT8tO9Z/zIMQwsSIuPhaeQuN4y+2xHoL81AkFgWM19DS+dGhDb3RwOXySNZSP1kekS
         hMwch/IqRkFisq6wOZkwpKXSnmEidIl7K69ciwydxL7Yu9m0pR/nzLzW8HBLxypSe0CJ
         MOdjdl80HYvtvT1SUXE/VS1JKBQMhzeUsUwKiJtSA/ubFUemN1TQ4nVQu5eT3zVJ5n/z
         MtHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/C3PGCEVWLO0uOy1T7KZibXtT4SeasJLjPrh8DOrydo=;
        b=vrtlqHPIyDwWgXtu7/QC2rk8heN5wKCxdhUS/+gwzGgebrE+/28vCne+EnpBX2KWfI
         2nXysCiDnPjDtwxK3CfmylBw43XNCBKPcubADq0p4ye7wjk0YHAWnVwX7UhNdiY15s61
         9lCNFqkIcor3J3TasWa4NcZU4BFG2qAwJ9s3MVTzS1/6IAJCZDWBHJJGlskEa2XfKmiu
         o4RTDJmCpORiSaNiRhpVW+gbmk0TPMsyNYDBHclQjdI8spdn/p/HPFhncnEsV5Sj7Ie4
         W7Ob0fg8x9p2mvST26Wwph2rTQ+u4UJJhkeVulhBArWmg3EoxttSr+9uhj5n/9zylrvK
         w9AA==
X-Gm-Message-State: AOAM5331VJMh2HQvM4Ir+2/U6e67b6MSs3QFgo53zWmeV1a2gdImbC7I
        Yx9XytIm6FQAk7rKOGx05Aj3K5jyFdQ=
X-Google-Smtp-Source: ABdhPJxz/wGersgCX30ctvHrS8hpHU1EFU/C6OeGiFIDYL+XT65T/b/HcqAWCClNFBWvhK5Qd4MoDQ==
X-Received: by 2002:a17:902:a988:b0:149:f2ae:649a with SMTP id bh8-20020a170902a98800b00149f2ae649amr7163234plb.172.1642119019563;
        Thu, 13 Jan 2022 16:10:19 -0800 (PST)
Received: from localhost.localdomain (192.243.120.57.16clouds.com. [192.243.120.57])
        by smtp.gmail.com with ESMTPSA id t7sm3734083pfj.168.2022.01.13.16.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 16:10:19 -0800 (PST)
From:   davidcomponentone@gmail.com
To:     davidcomponentone@gmail.com
Cc:     linux-kernel@vger.kernel.org, Yang Guang <yang.guang5@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
Subject: [PATCH] tools lib traceevent: fix boolreturn.cocci warning
Date:   Fri, 14 Jan 2022 08:10:08 +0800
Message-Id: <13fadc627ba2eaa442b9cd7d2e22fae328465e7a.1642065110.git.davidcomponentone@gmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yang Guang <yang.guang5@zte.com.cn>

The coccinelle report
./tools/lib/traceevent/event-parse-api.c:289:8-9:
WARNING: return of 0/1 in function 'tep_is_local_bigendian'
with return type bool.

Return statements in functions returning bool should use true/false
instead of 1/0.

Reported-by: Zeal Robot <zealci@zte.com.cn>
Signed-off-by: Yang Guang <yang.guang5@zte.com.cn>
Signed-off-by: David Yang <davidcomponentone@gmail.com>
---
 tools/lib/traceevent/event-parse-api.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/traceevent/event-parse-api.c b/tools/lib/traceevent/event-parse-api.c
index f8361e45d446..f153476f39c1 100644
--- a/tools/lib/traceevent/event-parse-api.c
+++ b/tools/lib/traceevent/event-parse-api.c
@@ -286,7 +286,7 @@ bool tep_is_local_bigendian(struct tep_handle *tep)
 {
 	if (tep)
 		return (tep->host_bigendian == TEP_BIG_ENDIAN);
-	return 0;
+	return false;
 }
 
 /**
-- 
2.30.2

