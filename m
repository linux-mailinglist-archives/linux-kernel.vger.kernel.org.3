Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F0C8A481A1A
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Dec 2021 08:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236796AbhL3HD7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Dec 2021 02:03:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229871AbhL3HD6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Dec 2021 02:03:58 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63B7FC061574;
        Wed, 29 Dec 2021 23:03:58 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id m15so20731229pgu.11;
        Wed, 29 Dec 2021 23:03:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5g9iyzLubVmDFpcluL9dWJKSqVkGpdkFyIy0fcw3xMA=;
        b=ZvzVpQ0HcqEakmAZMzS6RfFpZy0ncGMLJo4oR4+Zw8ab+MiE4zQR6TR30bzBbYvn+f
         40XPIEc7Uv5lJo+xJ0c6TWlRbd7TTfdTOtOFCIGiW29vtPFNoChnDK3+f1rme7yirCUT
         aXfh3ewOzfq3V4WaVWJt5zdVgUqkm8knDlmtVsEy9r2JmKx7H4hNPI1zi6Vh5UkP2aTD
         04EPc5fL1IR1NcZ3Mnsq6RA9KyQQ6IlzhyeHwh4rrzWheZzmTxtxuTdKWMrkGz34C9ro
         bmuoaeNGL+5hNaRyNIBRbFAOLhQU68bMxvfCA003fqIZwB6qPt5iB2+7Rrlx8lJ0hgFz
         B/Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=5g9iyzLubVmDFpcluL9dWJKSqVkGpdkFyIy0fcw3xMA=;
        b=bmonAx/UL/FKj9zklcHMiQdVBgxWM1YKjB6eLBcCG1CIB21CwoVQooWkxBICth6nJC
         uZf+FCy0j+icin86/bICT5f9a116Bq7yzv8pvDL0cRxTcFOqjX9Y9YTJo7HJJDAIb7KP
         awsBKzYeMH0jQMYiJbAaYpiHOnGJO5HQnWBfdGaJ9VTyiRybM3WttbX/GKaihbGUNXTQ
         94m0fbUf9jxy/k9Lx1O40klCxUSR2vVclalYKu6Yx6QDzqukY+vjzJWbBqAR79IhKEOh
         g/+Ie/zbjh9qRfcJDVstClcOePMcLlTocKtQXNe3Oqc4M7Fe9Q0sKm5O8YF1kKBFwJhX
         wNgg==
X-Gm-Message-State: AOAM531wCaJHKbZbuqfj8YrXtSGWh3nOpIlxFL4kDPlvBpfPy2pNvrcM
        eXSc0H0zMDhE1cs7EZhWnl6ZH0tosVUF4ZWnxZM=
X-Google-Smtp-Source: ABdhPJwI+WGNhDsEMaAoDgjZKxm7j7yXVfw88HtEIxpAB0Yky/3q4LmnEG4k69cDjFMzOEmSfGu9xg==
X-Received: by 2002:a05:6a00:1744:b0:4bb:9cf4:2c27 with SMTP id j4-20020a056a00174400b004bb9cf42c27mr26857867pfc.65.1640847838026;
        Wed, 29 Dec 2021 23:03:58 -0800 (PST)
Received: from localhost.localdomain ([159.226.95.43])
        by smtp.gmail.com with ESMTPSA id q9sm21682073pgc.65.2021.12.29.23.03.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Dec 2021 23:03:57 -0800 (PST)
From:   Zizhuang Deng <sunsetdzz@gmail.com>
To:     tianjia.zhang@linux.alibaba.com, herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        Zizhuang Deng <sunsetdzz@gmail.com>
Subject: [PATCH] lib/mpi: Add the return value check of kcalloc()
Date:   Thu, 30 Dec 2021 15:03:31 +0800
Message-Id: <20211230070331.1046343-1-sunsetdzz@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the return value check of kcalloc() to avoid potential
NULL ptr dereference.

Signed-off-by: Zizhuang Deng <sunsetdzz@gmail.com>
---
 lib/mpi/mpi-mod.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/lib/mpi/mpi-mod.c b/lib/mpi/mpi-mod.c
index 47bc59edd4ff..54fcc01564d9 100644
--- a/lib/mpi/mpi-mod.c
+++ b/lib/mpi/mpi-mod.c
@@ -40,6 +40,8 @@ mpi_barrett_t mpi_barrett_init(MPI m, int copy)
 
 	mpi_normalize(m);
 	ctx = kcalloc(1, sizeof(*ctx), GFP_KERNEL);
+	if (!ctx)
+		return NULL;
 
 	if (copy) {
 		ctx->m = mpi_copy(m);
-- 
2.25.1

