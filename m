Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F112F52F133
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 18:59:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351988AbiETQ72 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 12:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352002AbiETQ70 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 12:59:26 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7274F185CA7
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:59:24 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id v5-20020a17090a7c0500b001df84fa82f8so8338849pjf.5
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 09:59:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYQDC1M1CZuV48ZKXFN2Cts3NE6JaCCl55IecsECCIQ=;
        b=M2zhhYWqVviqmDNnxEiQDv/RJlQXUZm/wKUzFX2XXcauWrMuLZcv/0U470u5TYKyoe
         tt/lDtFS4I/NNDdX/kbT1xYfUIDVLRX4kCTtrC7wvzXhmoSbmsfIsW/dzAg8Jq+9PyzZ
         CmeH0rP9fPtVaTpXNZj6bBnLN6DWF9xBvWWbA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=xYQDC1M1CZuV48ZKXFN2Cts3NE6JaCCl55IecsECCIQ=;
        b=2ZnzBorSYL8kWDsuEf7RXxniZKWjidT9NRwZ9Om1kNup7aWSoH1AdtOJnO9DL8nCLJ
         Qt5zMMq6KbjqcTGjJY+zi68Z2Bes6Vv7hkTU8gCbrda252oOjj6NyOJ1LBSpkrgqBRxh
         FoDRYXU2y0XNZX8lewMQ0/4jOG0S+/hgqJwTHGnqC0/N57ehG22Vc4tVMvqImPAljSvG
         IRZwldSSLEoihY/XOwJyy/YahbEKmgE6Ajq3afJX/5fO50yoowgySJPJUgE19mwjLfyD
         skjffk6hF0hLin5K230g/8jG3UlcPkruIJEflLvHcaB1Spf4BTjIGlm6doCVDjAc+hvA
         dWKw==
X-Gm-Message-State: AOAM530+EsZWlQChjBoUHlkf7K+3EnyIBr9kIN/g8nPSKqb2BNWNZ9DS
        8AJgM6KON2u7x7HwS+u+N58HnQ==
X-Google-Smtp-Source: ABdhPJxjRfg0cpH+6s9pfLq6EVrFAcB33wko4OyN8aWvmZyc7qC4HjGFRusHIjWqBLjPgzFWHhq/pQ==
X-Received: by 2002:a17:902:6a85:b0:161:96bc:ef5d with SMTP id n5-20020a1709026a8500b0016196bcef5dmr10886093plk.46.1653065964024;
        Fri, 20 May 2022 09:59:24 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c27-20020aa7953b000000b0050dc762814fsm2118848pfp.41.2022.05.20.09.59.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 09:59:23 -0700 (PDT)
From:   Kees Cook <keescook@chromium.org>
To:     Jan Harkes <jaharkes@cs.cmu.edu>
Cc:     Kees Cook <keescook@chromium.org>, coda@cs.cmu.edu,
        codalist@coda.cs.cmu.edu, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: [PATCH] fs/coda: Do not use partially allocated struct
Date:   Fri, 20 May 2022 09:59:22 -0700
Message-Id: <20220520165922.2140450-1-keescook@chromium.org>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3530; h=from:subject; bh=EWsLugKK7JxpFFTFhQ1Z0fK45IDltRDRvfWym7LQs3Q=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBih8jpTzLdzGg2nhFSnqG3MKgGXprAQ22QYIvmLkld ioSekFuJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYofI6QAKCRCJcvTf3G3AJijWEA CDYjMcRBUsPF1YvvwLlPdbR7tj2Cxwbaz3jZwo8+bmpf/QPPIQ0LZ/zs8oiCqxn+gRqAoYyADk9AjI Ewg5kwPFd1gb+hlb5VlEmW26dR9ZJ7t1WOMLRmkf80g7LtwEasxIhhVrsxNgxB2RaM2KwHE7fzVhF0 0AVOj5tdhU8bdb4LsGUSEKHHM6W1E6oHRRUiQ5l3/J7JoqGBHonv/ZDf3aNCunYAzUD+Aylc/FI1vT grQ5UFERil8mOHjF7+pCXaTf6ghvCmZdbvabAFbJJo+glzzddZ+GTxT1CZJk+/+gtttZvNFrffEdn/ KqC2Byn+inuM6iUzSPDsOTRBriPLwEXmui9ALV5i81A/o1x2q6uHsCuWka5Sbm001GfbVqbPM15oV+ ejjzI13Qpy3ut8hbZrjWqj87aDgY2/Pev46nG1b06kWuKrphuN6OPQqXpb3hGmiLxmLeGhtZWDFJEG d1TG8suzvAIUWUpT8+/j8zWBiqCmPvS3apGg6QmKH3P3Kkelx3XDsNuEjlkFXhX03UOz0ugce5g3t4 uJ6ZqU57a2b4wuPaETGkK+CsxQAMX/IsKcMZUAXRxC1wPqBB2ZyOWr0YIX3Iqc+fyVeniLracfiG7o 9fYFFVCMR32Vg5XRpil38WXEsAxcVITGhJ1+g0q8ifv/3Zu9G2EOTjlSl4kw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 does not like seeing a partially allocated structure being used,
especially when a pointer is being passed out of function scope. Since
only the struct coda_in_hdr member of union inputArgs is being allocated
and used, just replace union inputArgs with struct coda_in_hdr.

../fs/coda/upcall.c: In function 'coda_upcall':
../fs/coda/upcall.c:801:22: warning: array subscript 'union inputArgs[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]
  801 |         sig_inputArgs->ih.opcode = CODA_SIGNAL;
      |                      ^~
In file included from ../include/linux/fs.h:45,
                 from ../include/linux/huge_mm.h:8,
                 from ../include/linux/mm.h:700,
                 from ../fs/coda/upcall.c:22:
In function 'kvmalloc',
    inlined from 'kvzalloc' at ../include/linux/slab.h:758:9,
    inlined from 'coda_upcall' at ../fs/coda/upcall.c:794:18:
../include/linux/slab.h:750:16: note: object of size 20 allocated by 'kvmalloc_node'
  750 |         return kvmalloc_node(size, flags, NUMA_NO_NODE);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
../fs/coda/upcall.c: In function 'coda_upcall':
../fs/coda/upcall.c:802:22: warning: array subscript 'union inputArgs[0]' is partly outside array bounds of 'unsigned char[20]' [-Warray-bounds]
  802 |         sig_inputArgs->ih.unique = req->uc_unique;
      |                      ^~
In function 'kvmalloc',
    inlined from 'kvzalloc' at ../include/linux/slab.h:758:9,
    inlined from 'coda_upcall' at ../fs/coda/upcall.c:794:18:
../include/linux/slab.h:750:16: note: object of size 20 allocated by 'kvmalloc_node'
  750 |         return kvmalloc_node(size, flags, NUMA_NO_NODE);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Cc: Jan Harkes <jaharkes@cs.cmu.edu>
Cc: coda@cs.cmu.edu
Cc: codalist@coda.cs.cmu.edu
Signed-off-by: Kees Cook <keescook@chromium.org>
---
 fs/coda/upcall.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/coda/upcall.c b/fs/coda/upcall.c
index 59f6cfd06f96..21e4f5f446b2 100644
--- a/fs/coda/upcall.c
+++ b/fs/coda/upcall.c
@@ -711,7 +711,7 @@ static int coda_upcall(struct venus_comm *vcp,
 		       union inputArgs *buffer)
 {
 	union outputArgs *out;
-	union inputArgs *sig_inputArgs;
+	struct coda_in_hdr *ih;
 	struct upc_req *req = NULL, *sig_req;
 	int error;
 
@@ -791,22 +791,22 @@ static int coda_upcall(struct venus_comm *vcp,
 	sig_req = kmalloc(sizeof(struct upc_req), GFP_KERNEL);
 	if (!sig_req) goto exit;
 
-	sig_inputArgs = kvzalloc(sizeof(struct coda_in_hdr), GFP_KERNEL);
-	if (!sig_inputArgs) {
+	ih = kvzalloc(sizeof(*ih), GFP_KERNEL);
+	if (!ih) {
 		kfree(sig_req);
 		goto exit;
 	}
 
 	error = -EINTR;
-	sig_inputArgs->ih.opcode = CODA_SIGNAL;
-	sig_inputArgs->ih.unique = req->uc_unique;
+	ih->opcode = CODA_SIGNAL;
+	ih->unique = req->uc_unique;
 
 	sig_req->uc_flags = CODA_REQ_ASYNC;
-	sig_req->uc_opcode = sig_inputArgs->ih.opcode;
-	sig_req->uc_unique = sig_inputArgs->ih.unique;
-	sig_req->uc_data = (void *)sig_inputArgs;
-	sig_req->uc_inSize = sizeof(struct coda_in_hdr);
-	sig_req->uc_outSize = sizeof(struct coda_in_hdr);
+	sig_req->uc_opcode = ih->opcode;
+	sig_req->uc_unique = ih->unique;
+	sig_req->uc_data = (void *)ih;
+	sig_req->uc_inSize = sizeof(*ih);
+	sig_req->uc_outSize = sizeof(*ih);
 
 	/* insert at head of queue! */
 	list_add(&(sig_req->uc_chain), &vcp->vc_pending);
-- 
2.32.0

