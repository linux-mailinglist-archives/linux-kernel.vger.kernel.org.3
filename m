Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6541A50294E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:01:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352850AbiDOMD1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:03:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353094AbiDOMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:03:15 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5928CD80
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:00:26 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id z99so9701002ede.5
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 05:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYOzeG29CXQZt+EUoBxDz5C2HqXrmoOTzgQchubVUnw=;
        b=KZ1WXwhUoVJ1zKh6jOVB6NKwa3rVSOVll0LX11G4LMJqZLgrOxdc0Nido2wf0KVrUL
         QbQZKb0zUh4GA4wvEjtxfg3xoDC6KfjI+4tPj5cY6S7O/RDOfoORt7ug0e8KBYIKR6F1
         wqsK2jvTdM10VMSKLArdMdrDIGuqSTMK2Vfp0ha7XSdzDlsAo4NcDaebpfgbeRsFqp2q
         23ZoGiV4d88hD1mjxTITOwv4KYkZwQG5DcdIWbeNpnplVuWRsg2jNkshVCjtGo55sdMj
         bGZ9n2yhZ+PZnwQ5hRQBXkaUaoPWuL/RfDB670nLElFI50nivFFG3SavzzLIEQsgcOI4
         SQGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=VYOzeG29CXQZt+EUoBxDz5C2HqXrmoOTzgQchubVUnw=;
        b=XrKroXJanGmmXZR3SIzCtLLUYJLPnvSGtSOcrgNSSA6jRE2ivGxtLdJnktNlDaBkY3
         0BTlMKDBu/OzWrZA+aYGNL8f3az97yY8kxjV1oGWF3OkNdPlJZtTN4tL9aE/ci9sYFM3
         ciMWauymQ+h6Tim+Lpx2IvqCiY6a3rodvUZewzmrrG216ADfpJlFSrqD/wFwsYIWI6Gv
         g3WcTLdRDjWbu4zYymJeK6PdGVCQaAss/NagYYWPkp1DKh1NnXnynePBsni4Fu7YhRx5
         CrzXTowtbEKpqmYgVwQSFrboB2ZyGGI47lxG55UCxezdLuK4lZ/PnpqJYQMpKMMYSciM
         63nQ==
X-Gm-Message-State: AOAM5317DZbrAqx+ywoIHDjVMcSfTC03a93FCkKolihnZ0MIZzVGZnf+
        ucjUpshQcCc5DpLGuoBhTwLd4V1QDMeWFQ==
X-Google-Smtp-Source: ABdhPJwkTo4cD5aGUjTPLaU3oHB2nbvGjo+BUYM2n4Cpb96cwuWM+dWa1P41qWbDtEA92qUfOrfN9g==
X-Received: by 2002:aa7:da8d:0:b0:41d:71be:d8bd with SMTP id q13-20020aa7da8d000000b0041d71bed8bdmr7888461eds.71.1650024024869;
        Fri, 15 Apr 2022 05:00:24 -0700 (PDT)
Received: from zero.. (host-79-54-81-151.retail.telecomitalia.it. [79.54.81.151])
        by smtp.gmail.com with ESMTPSA id dn7-20020a17090794c700b006e8b176143bsm1621164ejc.155.2022.04.15.05.00.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 Apr 2022 05:00:24 -0700 (PDT)
From:   Alessandro Astone <ales.astone@gmail.com>
To:     tkjos@android.com, gregkh@linuxfoundation.org, brauner@kernel.org,
        arve@android.com, linux-kernel@vger.kernel.org, maco@android.com
Cc:     Alessandro Astone <ales.astone@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Hridya Valsaraju <hridya@google.com>,
        Suren Baghdasaryan <surenb@google.com>
Subject: [PATCH v2 2/2] binder: Gracefully handle BINDER_TYPE_FDA objects with num_fds=0
Date:   Fri, 15 Apr 2022 14:00:14 +0200
Message-Id: <20220415120015.52684-1-ales.astone@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Some android userspace is sending BINDER_TYPE_FDA objects with
num_fds=0. Like the previous patch, this is reproducible when
playing a video.

Before commit 09184ae9b575 BINDER_TYPE_FDA objects with num_fds=0
were 'correctly handled', as in no fixup was performed.

After commit 09184ae9b575 we aggregate fixup and skip regions in
binder_ptr_fixup structs and distinguish between the two by using
the skip_size field: if it's 0, then it's a fixup, otherwise skip.
When processing BINDER_TYPE_FDA objects with num_fds=0 we add a
skip region of skip_size=0, and this causes issues because now
binder_do_deferred_txn_copies will think this was a fixup region.

To address that, return early from binder_translate_fd_array to
avoid adding an empty skip region.

Fixes: 09184ae9b575 ("binder: defer copies of pre-patched txn data")
Signed-off-by: Alessandro Astone <ales.astone@gmail.com>
---
 drivers/android/binder.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index 31176edb1069..f3b639e89dd8 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2491,6 +2491,9 @@ static int binder_translate_fd_array(struct list_head *pf_head,
 	struct binder_proc *proc = thread->proc;
 	int ret;
 
+	if (fda->num_fds == 0)
+		return 0;
+
 	fd_buf_size = sizeof(u32) * fda->num_fds;
 	if (fda->num_fds >= SIZE_MAX / sizeof(u32)) {
 		binder_user_error("%d:%d got transaction with invalid number of fds (%lld)\n",
-- 
2.35.1

