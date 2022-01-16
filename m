Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2497148FD7E
	for <lists+linux-kernel@lfdr.de>; Sun, 16 Jan 2022 15:43:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235467AbiAPOnQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 16 Jan 2022 09:43:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:35910 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235447AbiAPOnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Jan 2022 09:43:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642344194;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=4aMSKSVca3eK/QwHqEjdmSijixRqInpTgDhVvW0va+A=;
        b=QRAejxZjI4aPYqZzCnikeFHnmCBOv8h30AOJNljZO7Hw2n+sNJ4I+5KblcRaImn5W4fm2a
        MaHm3dmaGxek/KKwSwEtW4TrS6IlYhZi0LHlnX58StF+tp0/YMNfPQ8WuStO+vrz56yyfs
        h0w37X15MKeeiXR7faa/ES51MrzjyFU=
Received: from mail-ot1-f72.google.com (mail-ot1-f72.google.com
 [209.85.210.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-wAwzAyM_NqyRSj5c_0GAMQ-1; Sun, 16 Jan 2022 09:43:13 -0500
X-MC-Unique: wAwzAyM_NqyRSj5c_0GAMQ-1
Received: by mail-ot1-f72.google.com with SMTP id z33-20020a9d24a4000000b00579320f89ecso4346223ota.12
        for <linux-kernel@vger.kernel.org>; Sun, 16 Jan 2022 06:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=4aMSKSVca3eK/QwHqEjdmSijixRqInpTgDhVvW0va+A=;
        b=j3R6aBk5XMtACvOq3CrPPVNOOLPGjurZDdGld9JC59B9HppNQUuAQvVHM48amMWUPK
         H+LSLFCbKjxqX+NjgYW0DiQFAmjtn3iiCd4/56/J45In++0yjjx1mMpzbbPmoAPvoDlX
         Z1a6u0U9bO5W8LhZ5wm2VdRjuJhgIuMwHzgnCQF4DieiTQw+foRCHxkTK5yqjYU2XvFa
         sSpRVywER0IhHc0ajlMaqZ3OYWS2+kMwcTdSjrheI6qsgKdUy/d7Aik+/KN4FabsZrPM
         sgxDZq5rEMPKDegGox1LJwZXjOkgBfcUEyp3SWToMxvev6T3hyV26dVu7sXlpjaCdRi/
         PaBA==
X-Gm-Message-State: AOAM531AKPm7QXP6+gUvpz2SxtD8iwZRaw1eNrPut3N2NPa5yh0w5CFU
        D8F1JYaOrYiAOV0yTggP3+ZCLEUxH7id16+eV15+6MVgxI08ZvUcWXsU0aEl+H6tcWD1399T+RK
        mHr4AtxH5LTWj8PPDNBFqbYnD
X-Received: by 2002:a9d:744b:: with SMTP id p11mr11033528otk.63.1642344192795;
        Sun, 16 Jan 2022 06:43:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx26tGb+Mube4WbOUOxEPS24lxlghEKsEQl+/YDScNYF7dZHgpQUo80OY2jcFvotKU3rsfKcQ==
X-Received: by 2002:a9d:744b:: with SMTP id p11mr11033516otk.63.1642344192642;
        Sun, 16 Jan 2022 06:43:12 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w19sm4958027oiw.29.2022.01.16.06.43.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 16 Jan 2022 06:43:12 -0800 (PST)
From:   trix@redhat.com
To:     trond.myklebust@hammerspace.com, anna.schumaker@netapp.com
Cc:     linux-nfs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] NFS: simplify check for freeing cn_resp
Date:   Sun, 16 Jan 2022 06:43:01 -0800
Message-Id: <20220116144301.399581-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

nfs42_files_from_same_server() is called to check if freeing
cn_resp is required.  Instead of calling a function, check
the pointer.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 fs/nfs/nfs4file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
index e79ae4cbc395e..677631ea4cfb3 100644
--- a/fs/nfs/nfs4file.c
+++ b/fs/nfs/nfs4file.c
@@ -180,7 +180,7 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
 	ret = nfs42_proc_copy(file_in, pos_in, file_out, pos_out, count,
 				nss, cnrs, sync);
 out:
-	if (!nfs42_files_from_same_server(file_in, file_out))
+	if (cn_resp)
 		kfree(cn_resp);
 	if (ret == -EAGAIN)
 		goto retry;
-- 
2.26.3

