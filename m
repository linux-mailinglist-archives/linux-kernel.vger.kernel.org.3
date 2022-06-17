Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 499F554F16D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 09:09:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380442AbiFQHJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 03:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380402AbiFQHIr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 03:08:47 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5878462CDE
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:40 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id w5-20020a17090aea0500b001ec7c45794bso187212pjy.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Jun 2022 00:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=tKM3xvFOU9BbHzW/2uuQbOBzRGB1RdsYKFUv60RJdxg=;
        b=cRelYOHqlySdg56lDY7wDD8qCGwBPr6ibudSH7Nv65Po/RJ/3CLzsfO0mgLoMjfgCD
         L38K4ISu+JEI74X/i0H2oH+u6N0O9BUdCrfPbBkZIZ5WjqamLz5/6/bfLLQukSkWalnF
         Wo5bwLmyB1OE85RLdcwEBcBAXGCIPrfSXYvpcQhXhR99s+U6YyDsAPSzz/2SIMyNjV5Q
         7oH3X51UibU84QBz2HVuCsI0oYFEVf1OjU4rFhtOXnP8DFN7frZjtFAwA8Zudgaki/Xt
         2SJucg4GGn6clqwKgtOB98sV2PyApzJYCqRiwb501ccwZn08pfr4/rPeJ/N6MpIYcM1I
         SQCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=tKM3xvFOU9BbHzW/2uuQbOBzRGB1RdsYKFUv60RJdxg=;
        b=Yl1OX2+/R9A/CgPmtwjH5+Z0EQotx/7ZKu/6PYJajbtqlybwBSXDYLSjNoq0BuQJmr
         WxduoqBxuhpbaMeLIgjSOoxy4fLLguaNaNjji+RQWFg/f7Kxt/GOMmYPfTo3I+jvc0yH
         z0anaEeb0Z5ubuKpSH9wi3SgvmNlg46UK7dh5IsEPkj0D/VAVh+UlmgofmYc1OHEnzvr
         c4piZW6kKbAAz4ehF38XliSUZfGmQzUd8TDJcMEJxfJLVc2eds+Er27UV3GLkfOnXV+S
         y7TD1thqUFlU8y7HMsTxihXVVIuSQJalg8I1gHsWFIDBbfFWWkXf0IPNvrRrP4XHN+Sq
         WsLg==
X-Gm-Message-State: AJIora/j1ue6hOI/rQqeMVZiIZ4ayiXtP5QftRvDl71A7I+ayYZhWtul
        bz/136EfvDtvZXWQ7brf4PqWFQ==
X-Google-Smtp-Source: AGRyM1vh2901KtWuAh/a/NRuzghOqX+27vND6C04We/BO58wByPDazd2slZkqQgFHUupQSy9H5DqLQ==
X-Received: by 2002:a17:902:728f:b0:168:b18e:9e0d with SMTP id d15-20020a170902728f00b00168b18e9e0dmr8130408pll.174.1655449719851;
        Fri, 17 Jun 2022 00:08:39 -0700 (PDT)
Received: from FVFDK26JP3YV.bytedance.net ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id j1-20020a170903028100b00163d4c3ffabsm2757868plr.304.2022.06.17.00.08.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 17 Jun 2022 00:08:39 -0700 (PDT)
From:   Lei He <helei.sig11@bytedance.com>
To:     herbert@gondor.apana.org.au, davem@davemloft.net,
        dhowells@redhat.com, mst@redhat.com
Cc:     arei.gonglei@huawei.com, jasowang@redhat.com,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        pizhenwei@bytedance.com, helei.sig11@bytedance.com,
        f4bug@amsat.org, berrange@redhat.com
Subject: [PATCH 3/4] crypto: remove unused field in pkcs8_parse_context
Date:   Fri, 17 Jun 2022 15:07:53 +0800
Message-Id: <20220617070754.73667-5-helei.sig11@bytedance.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20220617070754.73667-1-helei.sig11@bytedance.com>
References: <20220617070754.73667-1-helei.sig11@bytedance.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: lei he <helei.sig11@bytedance.com>

remove unused field 'algo_oid' in pkcs8_parse_context

Signed-off-by: lei he <helei.sig11@bytedance.com>
---
 crypto/asymmetric_keys/pkcs8_parser.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/crypto/asymmetric_keys/pkcs8_parser.c b/crypto/asymmetric_keys/pkcs8_parser.c
index e507c635ead5..f81317234331 100644
--- a/crypto/asymmetric_keys/pkcs8_parser.c
+++ b/crypto/asymmetric_keys/pkcs8_parser.c
@@ -21,7 +21,6 @@ struct pkcs8_parse_context {
 	struct public_key *pub;
 	unsigned long	data;			/* Start of data */
 	enum OID	last_oid;		/* Last OID encountered */
-	enum OID	algo_oid;		/* Algorithm OID */
 	u32		key_size;
 	const void	*key;
 	const void	*algo_param;
-- 
2.20.1

