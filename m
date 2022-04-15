Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10A7F502948
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348619AbiDOMDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352946AbiDOMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:03:15 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079805F66
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:00:31 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id bh17so15021799ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:00:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6kqH16YGChi7cR6OY4DfJvP5AINYxh9jadunKUmdgXA=;
        b=hEZzrZjAwZ0SU9iznl61RWIYbckAE1eQqIlkGEAsNrkkxIIXWieoPaa1PDiQdKTbRR
         gshASQy/9AH9EIx7yROdkgfbd9aj3l4ecpOVamHcdpBkf0x6IzBF6FXf62rAeIAgXj+3
         7rmd3Isp+E4MM7AW7aJ2uql3D6+OEnOaiiBJmDYt+GHq49X70Wl2S7Hr0C3YIMBg0wxc
         fhkM3wQptEy8vxVWHaI0d2poguBk0svGMPnXD2idXfP7oadHN4F9sMpoEY08xEjqyZx4
         Pqzo69dt9sTU2VfOElMNEHdURZ7k4ag5LzmOaYg6Z5IYnfYdHlGi67xmiicIIT+8JLQe
         Ct+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6kqH16YGChi7cR6OY4DfJvP5AINYxh9jadunKUmdgXA=;
        b=oo/PoAZF37sp/KBr3RS8GN2GOtjke8KJsemCvZnRLF6cpdfwGaIg6WreyVq2iSbeaU
         vhgYjJWxqucKHTNRmTyTM3VpEd9K5ESPTf6G4424PsRwimueSyOHzBPIpknyGIcaXOZm
         ZibzfYRPa4AzmJzlx9hsJlpyxdYnJsp40okNFfF+CbZyDFg9pNTmKGpNVuFSRjKDSCL4
         fWAMK7cXClbfyE9Cf/XhjRPqjfXcDJujtaK9MAkciY2wOn2UR1R8+/+agUjiUinQTn77
         Oa72uQnl5fmWyiPZrpWQ6kX5/kduqaVtGf6ar+IQpePW4474QHmnkaPduIgZlcXGDzbh
         SxfA==
X-Gm-Message-State: AOAM533rXfWd6AOQv82awHOsTDuZrE0dzPYUQnClqoe8zbw8y1t6HCzf
        TVeD4VHtMgVBiljmTW1cm4k=
X-Google-Smtp-Source: ABdhPJxUFly3iyIA/Nc6nu5ywm0GWFxZlnp3H+TcVrbcwIA0QrvFVUiticir27LzkdriJtKowS+SOw==
X-Received: by 2002:a17:907:72c3:b0:6e8:b602:9793 with SMTP id du3-20020a17090772c300b006e8b6029793mr5911358ejc.704.1650024029571;
        Fri, 15 Apr 2022 05:00:29 -0700 (PDT)
Received: from zero.. (host-79-54-81-151.retail.telecomitalia.it. [79.54.81.151])
        by smtp.gmail.com with ESMTPSA id dn7-20020a17090794c700b006e8b176143bsm1621164ejc.155.2022.04.15.05.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:00:29 -0700 (PDT)
From:   Alessandro Astone <ales.astone@gmail.com>
To:     tkjos@android.com, gregkh@linuxfoundation.org, brauner@kernel.org,
        arve@android.com, linux-kernel@vger.kernel.org, maco@android.com
Cc:     Alessandro Astone <ales.astone@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 1/2] binder: Address corner cases in deferred copy and fixup
Date:   Fri, 15 Apr 2022 14:00:15 +0200
Message-Id: <20220415120015.52684-2-ales.astone@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220415120015.52684-1-ales.astone@gmail.com>
References: <20220415120015.52684-1-ales.astone@gmail.com>
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

When handling BINDER_TYPE_FDA object we are pushing a parent fixup
with a certain skip_size but no scatter-gather copy object, since
the copy is handled standalone.
If BINDER_TYPE_FDA is the last children the scatter-gather copy
loop will never stop to skip it, thus we are left with an item in
the parent fixup list. This will trigger the BUG_ON().

This is reproducible in android when playing a video.
We receive a transaction that looks like this:
    obj[0] BINDER_TYPE_PTR, parent
    obj[1] BINDER_TYPE_PTR, child
    obj[2] BINDER_TYPE_PTR, child
    obj[3] BINDER_TYPE_FDA, child

Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
---
 drivers/android/binder.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 8351c5638880..31176edb1069 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2295,6 +2295,7 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
 {
 	int ret = 0;
 	struct binder_sg_copy *sgc, *tmpsgc;
+	struct binder_ptr_fixup *tmppf;
 	struct binder_ptr_fixup *pf =
 		list_first_entry_or_null(pf_head, struct binder_ptr_fixup,
 					 node);
@@ -2349,7 +2350,11 @@ static int binder_do_deferred_txn_copies(struct binder_alloc *alloc,
 		list_del(&sgc->node);
 		kfree(sgc);
 	}
-	BUG_ON(!list_empty(pf_head));
+	list_for_each_entry_safe(pf, tmppf, pf_head, node) {
+		BUG_ON(pf->skip_size == 0);
+		list_del(&pf->node);
+		kfree(pf);
+	}
 	BUG_ON(!list_empty(sgc_head));
 
 	return ret > 0 ? -EINVAL : ret;
-- 
2.35.1

