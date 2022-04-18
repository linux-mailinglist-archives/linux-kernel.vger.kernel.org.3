Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBF1505CC7
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:51:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346475AbiDRQxo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346454AbiDRQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 407493191E
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650300657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=osWjVIWrfBrDOezJiYzosX0/AGt77HLN11DnBu9dxXM=;
        b=i7VVms6jL6Uy+5pXQROLzlFHRFCfb+fRPrqylv3jTkr4S71WOUXhJjAOc7yVaiLM2qurBS
        YY8yFXr0E9UfaNhIqd89VOAlLDRYQ6lu6ljhEeT4FqFIbj5eiWvkqFwetLkGqqdCStkc2M
        iXXVssOvnyx9emvMBXU+ee+WEa7DD+w=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-526-2wAx_jr8NJW8hqmOrG3_DA-1; Mon, 18 Apr 2022 12:50:56 -0400
X-MC-Unique: 2wAx_jr8NJW8hqmOrG3_DA-1
Received: by mail-qk1-f200.google.com with SMTP id t3-20020a05620a034300b0069e60a0760cso5644348qkm.20
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:50:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=osWjVIWrfBrDOezJiYzosX0/AGt77HLN11DnBu9dxXM=;
        b=IdfO3sSsCYCPNqkohlWz4umwaclgRcxQ7xEG/XFiFkf0UtwtqOrnM6ATOOlu64mN/z
         JUSjnBT7WKwswVKGf1awZD4rqXG9n/9icFcpayCTo0n75cDLyfMbWe4mtL5ooZ3UK5BC
         pmcde1qtiPeM92GSpqa+K1S9nTL1M9QeNiQWKPQ5bCsDL0HuByc7Va8R6ypwL/6gagEr
         9hcnCcLpzZ9Dl9JBDpX98HMxxTGDDyio3UmUmz55gIIrtZtHuWmnhRUS2Nn3QDVTOeef
         E/xZbfto+ImzequnUIZyJryPfKTbNjzq83HwN6rVCO0hOofCfKlZ7X7RdvOMgKquDyum
         HxnA==
X-Gm-Message-State: AOAM533wkvVVLtkNk7ytnQ4vzQUNvBZ0OinvcPxtVYrWNe0IN7rZWOEg
        XLMeztJ/wY4eBuP1mW5/OxnUAAPhvKH2Py7tMaZXkLgCHtKvSzRhItiNgFGrKS6RJ/80gR/3FRd
        cfddrw8wsoXdTXyRIBN2guRlL
X-Received: by 2002:a05:6214:2465:b0:446:6211:5ebb with SMTP id im5-20020a056214246500b0044662115ebbmr3361531qvb.56.1650300655567;
        Mon, 18 Apr 2022 09:50:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyVa23kvS7eV3rLCazqxaSIEzbz1+8n7UWX5S6UH77Lfnn2xlvKnBMfjKgC7TKh0tDHy10ooQ==
X-Received: by 2002:a05:6214:2465:b0:446:6211:5ebb with SMTP id im5-20020a056214246500b0044662115ebbmr3361515qvb.56.1650300655351;
        Mon, 18 Apr 2022 09:50:55 -0700 (PDT)
Received: from treble.redhat.com ([2600:1700:6e32:6c00::35])
        by smtp.gmail.com with ESMTPSA id e15-20020ac8670f000000b002e22d9c756dsm7277059qtp.30.2022.04.18.09.50.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 09:50:54 -0700 (PDT)
From:   Josh Poimboeuf <jpoimboe@redhat.com>
To:     x86@kernel.org
Cc:     Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>
Subject: [PATCH v2 02/25] libsubcmd: Fix OPTION_GROUP sorting
Date:   Mon, 18 Apr 2022 09:50:21 -0700
Message-Id: <e167ea3a11e2a9800eb062c1fd0f13e9cd05140c.1650300597.git.jpoimboe@redhat.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1650300597.git.jpoimboe@redhat.com>
References: <cover.1650300597.git.jpoimboe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The OPTION_GROUP option type is a way of grouping certain options
together in the printed usage text.  It happens to be completely broken,
thanks to the fact that the subcmd option sorting just sorts everything,
without regard for grouping.  Luckily, nobody uses this option anyway,
though that will change shortly.

Fix it by sorting each group individually.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 tools/lib/subcmd/parse-options.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/tools/lib/subcmd/parse-options.c b/tools/lib/subcmd/parse-options.c
index 39ebf6192016..9fa75943f2ed 100644
--- a/tools/lib/subcmd/parse-options.c
+++ b/tools/lib/subcmd/parse-options.c
@@ -806,9 +806,9 @@ static int option__cmp(const void *va, const void *vb)
 
 static struct option *options__order(const struct option *opts)
 {
-	int nr_opts = 0, len;
+	int nr_opts = 0, nr_group = 0, len;
 	const struct option *o = opts;
-	struct option *ordered;
+	struct option *opt, *ordered, *group;
 
 	for (o = opts; o->type != OPTION_END; o++)
 		++nr_opts;
@@ -819,7 +819,18 @@ static struct option *options__order(const struct option *opts)
 		goto out;
 	memcpy(ordered, opts, len);
 
-	qsort(ordered, nr_opts, sizeof(*o), option__cmp);
+	/* sort each option group individually */
+	for (opt = group = ordered; opt->type != OPTION_END; opt++) {
+		if (opt->type == OPTION_GROUP) {
+			qsort(group, nr_group, sizeof(*opt), option__cmp);
+			group = opt + 1;
+			nr_group = 0;
+			continue;
+		}
+		nr_group++;
+	}
+	qsort(group, nr_group, sizeof(*opt), option__cmp);
+
 out:
 	return ordered;
 }
-- 
2.34.1

