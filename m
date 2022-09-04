Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6EA25AC34B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 09:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiIDHqy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 03:46:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbiIDHqv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 03:46:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F77341993;
        Sun,  4 Sep 2022 00:46:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id m10-20020a17090a730a00b001fa986fd8eeso9452275pjk.0;
        Sun, 04 Sep 2022 00:46:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date;
        bh=MNCodJQdObDjrnT0Izj/sQ+uO9mQ8GTBinVlGbDhzBg=;
        b=ltndlkcpAl4jmPWsFREMk9p7wATBSb+I5sr1s7EcJOc1fYxYE0FNr+s6CxN3dfcJq+
         w65m3eIvHbRQgHaEfHsCkQrjbq2pMqoeh9LzPCvwWzBm7lPmECkdv3+Gk38aL5JNml8k
         IvTFF9+YG9UExawUu+55auCNI870adk8PDDRrgQUx/cqGVbl8kqATXEg77Gx3wc2TqG8
         nirxyo7o/waKYQabtQlr9gik3sbUZi5jWHBAgyo+SjILRZ4xmDXOdIkSd+n0rNZh1lSN
         Qb7rbI+9OCZzUeamNn7Js+gmNSSb6Yy4E0lKkh56ONfIJZFrGX7b+wzFnvD1HJn+Mrwb
         sASw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=MNCodJQdObDjrnT0Izj/sQ+uO9mQ8GTBinVlGbDhzBg=;
        b=eVE5BAgitLOdzOeur6LhpTBhZmrN+pqCyNhSzxqWu9qFYHqtuHa+RaGoezEFVt4zeB
         E5Ir7TTIGCHNrLbpm8K8WdZMSfxpsybckigdgdKMYrTAVyJ0dg3xPQOCTdQTIke+9oRI
         L5ieD5cWlpowLOG6ADtwZJhRuNqADPY1p6Ek5A/F9zmXDP2IW/dTdHhCPigMFWxGAQKe
         0m+W6/TnUC/dvoYGF+UIxOfSCx0AoXk4atRkuu7gcMGUZPLlkGvZAtE8XatvxrXZLlRo
         NEXh+C3sG8Zl4a2D+76npCAl729p0A+kjflMkyTYKvND3yv5fbighDCh6Z+nH3/VxMhY
         5B4g==
X-Gm-Message-State: ACgBeo3bhiLNfmh7mNEWfWj+2Y2NolJU2KiUErh75kw67VjBgSW5YNOW
        TgICidnXwYyc0EllIwnOBjTozXWQRRA=
X-Google-Smtp-Source: AA6agR41XDk23/RDtx6Hla5UHGEscly4WpsCTJEoYwfuGZWi+BSAHQcmeYfRyCp9G9X9B3PNOBVS8w==
X-Received: by 2002:a17:902:ecc6:b0:174:90c5:613b with SMTP id a6-20020a170902ecc600b0017490c5613bmr33591646plh.28.1662277609493;
        Sun, 04 Sep 2022 00:46:49 -0700 (PDT)
Received: from cloud-MacBookPro ([2601:646:8201:c2e0:a34:9c8c:fea7:d064])
        by smtp.gmail.com with ESMTPSA id x22-20020a170902821600b0016f057b88c9sm4918559pln.26.2022.09.04.00.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 04 Sep 2022 00:46:48 -0700 (PDT)
Date:   Sun, 4 Sep 2022 00:46:47 -0700
From:   Binyi Han <dantengknight@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: [PATCH] mm: fix dereferencing possible ERR_PTR
Message-ID: <20220904074647.GA64291@cloud-MacBookPro>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Smatch checker complains that 'secretmem_mnt' dereferencing possible
ERR_PTR().
Let the function return if 'secretmem_mnt' is ERR_PTR, to avoid
deferencing it.

Signed-off-by: Binyi Han <dantengknight@gmail.com>
---
 mm/secretmem.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mm/secretmem.c b/mm/secretmem.c
index e3e9590c6fb3..3f7154099795 100644
--- a/mm/secretmem.c
+++ b/mm/secretmem.c
@@ -285,7 +285,7 @@ static int secretmem_init(void)
 
 	secretmem_mnt = kern_mount(&secretmem_fs);
 	if (IS_ERR(secretmem_mnt))
-		ret = PTR_ERR(secretmem_mnt);
+		return PTR_ERR(secretmem_mnt);
 
 	/* prevent secretmem mappings from ever getting PROT_EXEC */
 	secretmem_mnt->mnt_flags |= MNT_NOEXEC;
-- 
2.25.1

