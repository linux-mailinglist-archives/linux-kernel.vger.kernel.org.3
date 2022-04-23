Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8635B50CA67
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiDWNNr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:13:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235720AbiDWNNf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:13:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B646918E08
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650719436;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Wij39qJ9HWPhVr791bjyPrFYtgEnPWODJDqQF2hE5C4=;
        b=WjdODTvEld4tDtlS+lc8YhaeMaAVeTt9/jH96zHyNLGKKxeeqFQ9fPSGYTYJxdUcpPiMs5
        P06685oZx+yfGrRId4VAZ/jsb99u+fFSsST+Pd6aurofsQLRRC3USC+CmCFlwM58cuuurN
        qgwKkm6HRqoN+/OUUgK3VM8bDZSLkds=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-509-0t3Z-RvgOMSZBOZwi5B81Q-1; Sat, 23 Apr 2022 09:10:35 -0400
X-MC-Unique: 0t3Z-RvgOMSZBOZwi5B81Q-1
Received: by mail-qv1-f71.google.com with SMTP id s19-20020ad44b33000000b00456107e1120so1810438qvw.0
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:10:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Wij39qJ9HWPhVr791bjyPrFYtgEnPWODJDqQF2hE5C4=;
        b=WIoGYXH5fLlliIzY7T7l+sSCTHA3zQXVFGPtaJo6hx9MizJvf8tksRoBXuO4JJhrQM
         UdVoM+9LjVVfOyVyfXZbSFnnvAPvIxhf7sTHFHH9z6ip8iBbxhXqxkMU3wmz3/UHX/oB
         J0ngzyPqSGQzKeBD0Xbtebnt3v3d5C07HJItmb6H2crMPSVX7OlCaSxGpMamNYnPAnST
         5eUi2q6IocGQUnVQAKttrpg9GE9PFykvzp5JHXo+5+Ayt6gCDZhT2dPdeMRfeBWopYL3
         mftX8ZtuKtblw8ycKW+g8av3KwHOSrCFGzj+/fK0m12zkQEipe4qSQ3hhRFj0FUaYIaw
         l2Pg==
X-Gm-Message-State: AOAM531an3UsU6XWHxSRPtgj55CVZivqtgX/fTcJNplbv2CRTUIQRvng
        n/OpYIR8S6MIYjzPOWh1J9gWcEh2XpjiHur4E9QFU1cVdAfnT2xjF1tWxfnOnUeoKfiL9p8zCx6
        v8VHKnAcJfdhDQHeSdwu8pFTm
X-Received: by 2002:a05:6214:21c2:b0:446:529d:fbee with SMTP id d2-20020a05621421c200b00446529dfbeemr6726387qvh.106.1650719434909;
        Sat, 23 Apr 2022 06:10:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwWqrYzu4Si5AwvbGKg7LWrjxMSKeUOHEcrlmxnE8PbfEereCgweyLbtYiOzUEYXONTVCdpLA==
X-Received: by 2002:a05:6214:21c2:b0:446:529d:fbee with SMTP id d2-20020a05621421c200b00446529dfbeemr6726378qvh.106.1650719434758;
        Sat, 23 Apr 2022 06:10:34 -0700 (PDT)
Received: from dell-per740-01.7a2m.lab.eng.bos.redhat.com (nat-pool-bos-t.redhat.com. [66.187.233.206])
        by smtp.gmail.com with ESMTPSA id v23-20020ae9e317000000b0069ea555b54dsm2261137qkf.128.2022.04.23.06.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 06:10:34 -0700 (PDT)
From:   Tom Rix <trix@redhat.com>
To:     sanju.mehta@amd.com, vkoul@kernel.org
Cc:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        Tom Rix <trix@redhat.com>
Subject: [PATCH] dmaengine: ptdma: change pt_tx_status to static
Date:   Sat, 23 Apr 2022 09:10:26 -0400
Message-Id: <20220423131026.798269-1-trix@redhat.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sparse reports thise issue
ptdma-dmaengine.c:262:1: warning: symbol 'pt_tx_status' was not declared. Should it be static?

pt_tx_status, like other pt_* functions in ptdam-dmaengine.c, is assigned
to a function pointer and is not used directly outside of this file.
So change its storage-class specifier to static.

Signed-off-by: Tom Rix <trix@redhat.com>
---
 drivers/dma/ptdma/ptdma-dmaengine.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/dma/ptdma/ptdma-dmaengine.c b/drivers/dma/ptdma/ptdma-dmaengine.c
index ea07cc42f4d0..cc22d162ce25 100644
--- a/drivers/dma/ptdma/ptdma-dmaengine.c
+++ b/drivers/dma/ptdma/ptdma-dmaengine.c
@@ -258,7 +258,7 @@ static void pt_issue_pending(struct dma_chan *dma_chan)
 		pt_cmd_callback(desc, 0);
 }
 
-enum dma_status
+static enum dma_status
 pt_tx_status(struct dma_chan *c, dma_cookie_t cookie,
 		struct dma_tx_state *txstate)
 {
-- 
2.27.0

