Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 485EF4E9740
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 15:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242764AbiC1NE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 09:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbiC1NEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 09:04:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7ED6663C3
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:03:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648472592;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=/u9IbKTaxd7JfWbYIumOYCvcuDGJC1EVRBB8DOZNjec=;
        b=I6ZCdoptpziw1f0gCzeQDSYZIovAZwyHcttnR2NoMfT/XBmlBoNFdNncWuhMmH+KSGuJT3
        9M9XrTjn7glNizAQULtLxCU5Jj6kQt1Xl2LV4QD95pjMzj4LNMygQQa8gA8YhlDKo2Q2l3
        loSnyOL5aaFzMCZBHn9/0NaSZ46l+/c=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-yLNN0cBuOlaIWs9-hYRWyw-1; Mon, 28 Mar 2022 09:03:06 -0400
X-MC-Unique: yLNN0cBuOlaIWs9-hYRWyw-1
Received: by mail-qk1-f198.google.com with SMTP id d12-20020a379b0c000000b0067d8cda1aaaso8336267qke.8
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 06:03:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/u9IbKTaxd7JfWbYIumOYCvcuDGJC1EVRBB8DOZNjec=;
        b=1DNl2puxtSEkQYyppvsvTGoUCfN1txCJWa0NaglalDC+Ufdz6+DSiguPX9zEpDTIuH
         oBaPlAlPEs1yq68oop9cHiZ5aTIJJvgRtKEPO+XvY0bNHKougtdwifZoIN+8Aijgg3hl
         2gCDizU3ghQ5E8QQC049uiEuv14m4zEvjVtcCbur8CY7i9VyWxPMjVtjDlFWJlLeeHtt
         G/ctQGE1g13Lm6texoWsAdsFfoV9RwyA8XIy4nDqmdYWEzTGpO0fN6xHc337ViZj3TtK
         N9Pn5W9IZWGtCnEUGtU+uhEAUzd3TuFiCMxQPRXAoDuec/p2qen4uO8meQRwqGlqzzHu
         GCcA==
X-Gm-Message-State: AOAM533BuocirXKe1rCuYWX/s/DYKXzMDFmXiTxxnbIfOjn5mRPgwHcZ
        JudwtsT9V8P63EpaP3GHl9zFyyCxZHjVM9myZbeub8PEb7MonopNH478U7vT7DsrgBIlV24ea3n
        cdpeh9jWuSg2rugqRA9MQIwNA
X-Received: by 2002:a05:6214:c4a:b0:441:2c0e:1cb4 with SMTP id r10-20020a0562140c4a00b004412c0e1cb4mr20296004qvj.98.1648472585601;
        Mon, 28 Mar 2022 06:03:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwwc0BWvMkauz8RL1WHra/Cyzf5posV9J1/75Ci8EjT4n+fT/8/G2vr6453bVFQNKYlS5HK8A==
X-Received: by 2002:a05:6214:c4a:b0:441:2c0e:1cb4 with SMTP id r10-20020a0562140c4a00b004412c0e1cb4mr20295947qvj.98.1648472585197;
        Mon, 28 Mar 2022 06:03:05 -0700 (PDT)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id m16-20020a05620a24d000b0067ecf605ef5sm8576234qkn.105.2022.03.28.06.03.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Mar 2022 06:03:04 -0700 (PDT)
From:   trix@redhat.com
To:     sfrench@samba.org, nathan@kernel.org, ndesaulniers@google.com
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] cifs: fix enum usage
Date:   Mon, 28 Mar 2022 06:03:00 -0700
Message-Id: <20220328130300.3090213-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang build fails with
cifsfs.c:709:18: error: implicit conversion from enumeration
  type 'enum statusEnum' to different enumeration
  type 'enum tid_status_enum'
  tcon->status = CifsExiting;
               ~ ^~~~~~~~~~~

The type of the element status changed, so enum needed to change.
Replace CifsExiting with TID_EXITING.

Fixes: 7e5c8c02911b ("smb3: cleanup and clarify status of tree connections")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/cifs/cifsfs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 0789bf1496c74..a47fa44b6d52b 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -706,7 +706,7 @@ static void cifs_umount_begin(struct super_block *sb)
 		spin_unlock(&cifs_tcp_ses_lock);
 		return;
 	} else if (tcon->tc_count == 1)
-		tcon->status = CifsExiting;
+		tcon->status = TID_EXITING;
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	/* cancel_brl_requests(tcon); */ /* BB mark all brl mids as exiting */
-- 
2.26.3

