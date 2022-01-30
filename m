Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACA1A4A3ACC
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 23:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347767AbiA3Wxc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 17:53:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbiA3Wx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 17:53:29 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F3AC061714;
        Sun, 30 Jan 2022 14:53:28 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id v13so21851749wrv.10;
        Sun, 30 Jan 2022 14:53:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aLABlGloUKCDwPwzOQyc5Kb5Zd5UVP0O5ptdkGtV0Y=;
        b=fLJhJBlrf80wFZRS/lZpT0NjeDn9aIQf6BOzNeAOf4t87swGk6aBTZLrQFp+ku+3dF
         y3+lZnge20tDGOXVS+SCkKSpUnvSgGgSUDGkN9eJaNa22QcoEYGXwIY7M20xzSAv3XDV
         jcLuUgzQrpBWjaFlN7lH2Q4aNp7dho9s17pwYycbrrXRKOwEaFGG40KVtZDTxaGtyjwQ
         T/16G2E46/ImoMjCEi16HGrbzVZq0kbpMJKSXejvbcv1CYhJ4bTX9bcs7WlLvkN68gUA
         QgaqOXy46QplO386eImI4BN0tshNWpEahGJGtOtmxQW/+CCSiZ34wUJuy72zkjOB7Dgj
         v4ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=8aLABlGloUKCDwPwzOQyc5Kb5Zd5UVP0O5ptdkGtV0Y=;
        b=JiNFpHNkI9OgnO1A9dK6XeclI34MKQd+zBgXx0+WlphrJem/eaMNshRmcZ6XzU6Wsg
         TEX1tQ1w0nweD+UfaW1g9zZhsd6Xw2bnFAyHQdTtkznyP+OB3gg1DLjT72dklEuMIcDx
         mu3+3zRN8uIHUFe8Z31AF+Hd4GStNEOQgM8T972W2t6/VOmOG22TX38DIs8dxVFtF0tN
         xGI4ZYtt6R3Z1TaW4u0iUhfOm7DxtX1oIna3sODicoxVi7pN1V4HZUwW+QGjsuBM2LPF
         +0v9q154xBdZJiuIA9H3LLFnT+37h/zcVfLsj75CqEEHyge1EDhGdZvfvXvrBoZn1BBH
         hW2Q==
X-Gm-Message-State: AOAM532ldVsCeGhkq8QrlstwvNkh3O5sVpFe2zzzxP09BsMDck0BuCa0
        GdpDUZAPxBxAIPZVd0aDR4A=
X-Google-Smtp-Source: ABdhPJyEE686mcajaIAdlANBP8O5MwuccLcQUECwyMHovcRKagxwN1SFR7awbrL9sD0Q66NQe/7NIQ==
X-Received: by 2002:a5d:6da2:: with SMTP id u2mr14622853wrs.704.1643583207002;
        Sun, 30 Jan 2022 14:53:27 -0800 (PST)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id k32sm8820214wms.14.2022.01.30.14.53.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Jan 2022 14:53:26 -0800 (PST)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Boris Brezillon <bbrezillon@kernel.org>,
        Arnaud Ebalard <arno@natisbad.org>,
        Srujana Challa <schalla@marvell.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S . Miller" <davem@davemloft.net>,
        linux-crypto@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] crypto: marvell/octeontx: remove redundant initialization of variable c_size
Date:   Sun, 30 Jan 2022 22:53:25 +0000
Message-Id: <20220130225325.7819-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Variable c_size is being initialized with a value that is never read, it
is being re-assigned with a different value later on. The initialization
is redundant and can be removed.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/crypto/marvell/octeontx/otx_cptvf_main.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
index b681bd2dc6ad..36d72e35ebeb 100644
--- a/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
+++ b/drivers/crypto/marvell/octeontx/otx_cptvf_main.c
@@ -204,7 +204,6 @@ static int alloc_command_queues(struct otx_cptvf *cptvf,
 
 	/* per queue initialization */
 	for (i = 0; i < cptvf->num_queues; i++) {
-		c_size = 0;
 		rem_q_size = q_size;
 		first = NULL;
 		last = NULL;
-- 
2.34.1

