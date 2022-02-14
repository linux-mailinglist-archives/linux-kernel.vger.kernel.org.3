Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B2C4B5920
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 18:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357261AbiBNRv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 12:51:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241238AbiBNRvy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 12:51:54 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6DF8FB3D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:51:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644861105;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=sRClfikrb2SAycFi2aWUxJvEEU6PW+e2USfmkK1Iaug=;
        b=hNtJzop8tBuUjBxYMNcDHojafmCBcnu5Lix97G7PH4twCLWt7p1/CXegO7pyIfTU00lwrC
        XnSK+Fma4MRllbd/UQV6jyseAap6v/GDdx5UiJnkLV2v6I662EsyxlHL9qOYdpSidwXgrX
        bJePuxCVub0kqg1fXrj2Ofkz057Mhmw=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-245-1sTIU3SIMA-ByqUfCfxBLA-1; Mon, 14 Feb 2022 12:51:44 -0500
X-MC-Unique: 1sTIU3SIMA-ByqUfCfxBLA-1
Received: by mail-oo1-f72.google.com with SMTP id l10-20020a4ac60a000000b002de84253574so10987938ooq.19
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 09:51:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=sRClfikrb2SAycFi2aWUxJvEEU6PW+e2USfmkK1Iaug=;
        b=sBHDqcCIIzAa7MEahFjt4wGE7rEwJog866Ln5YHONPDrgCDejHXP0WWvlg8mhdcGpm
         FqdDF6P/BJRWe20cCMusLyIDYrAz2I3xQVERvo/Z03KzU0Bd/EARTwgPoba1vps/JFcQ
         cLuil1oL0ZGhguJNCeR9auA7UHyvZ/8ncKlwYF4hEjawnHGKJcQCS9pOR1BJQV5KMYyx
         XswNbw3WGvaaQAA2VY4pTnx0+Rf276+N+n8dEl/R+z5535MHn3YhhTJMcufm3X9rCIne
         /2vKU1J6mwBCRezEHzvJhOssJeT04bF+hx7eME0uPadXhOulPzO/L7AZ3dO5j6P85DDr
         VPJg==
X-Gm-Message-State: AOAM533yfBaeFSDeZjD3ivKftqoRxxFXaKecgd5WKluZXrNOqOPv/J9X
        n2iMOhBSXk8Bkh7+udcilvpIW+Z4robhcqUJ8fVaIXDipDyBr7+hvyJ7DsDnJQQ5N95RFLpOjI+
        +cDEVLbxKSpV1UcE2TuqKpr8G
X-Received: by 2002:a9d:6e84:: with SMTP id a4mr18932otr.43.1644861103174;
        Mon, 14 Feb 2022 09:51:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzcnHxTDhHzI4mHvMfEWEZ41qbHYDvsaNz05h/swvvbijMzbRD2lKpXlDtrTUoDdBuBcdn0Yg==
X-Received: by 2002:a9d:6e84:: with SMTP id a4mr18930otr.43.1644861102975;
        Mon, 14 Feb 2022 09:51:42 -0800 (PST)
Received: from localhost.localdomain.com (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id w20sm12910024ooe.3.2022.02.14.09.51.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 09:51:42 -0800 (PST)
From:   trix@redhat.com
To:     jk@codeconstruct.com.au, matt@codeconstruct.com.au,
        davem@davemloft.net, kuba@kernel.org, nathan@kernel.org,
        ndesaulniers@google.com
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, Tom Rix <trix@redhat.com>
Subject: [PATCH] mctp: fix use after free
Date:   Mon, 14 Feb 2022 09:51:38 -0800
Message-Id: <20220214175138.2902947-1-trix@redhat.com>
X-Mailer: git-send-email 2.26.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tom Rix <trix@redhat.com>

Clang static analysis reports this problem
route.c:425:4: warning: Use of memory after it is freed
  trace_mctp_key_acquire(key);
  ^~~~~~~~~~~~~~~~~~~~~~~~~~~
When mctp_key_add() fails, key is freed but then is later
used in trace_mctp_key_acquire().  Add an else statement
to use the key only when mctp_key_add() is successful.

Fixes: 4a992bbd3650 ("mctp: Implement message fragmentation & reassembly")
Signed-off-by: Tom Rix <trix@redhat.com>
---
 net/mctp/route.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/net/mctp/route.c b/net/mctp/route.c
index 17e3482aa770..0c4c56e1bd6e 100644
--- a/net/mctp/route.c
+++ b/net/mctp/route.c
@@ -419,13 +419,14 @@ static int mctp_route_input(struct mctp_route *route, struct sk_buff *skb)
 			 * this function.
 			 */
 			rc = mctp_key_add(key, msk);
-			if (rc)
+			if (rc) {
 				kfree(key);
+			} else {
+				trace_mctp_key_acquire(key);
 
-			trace_mctp_key_acquire(key);
-
-			/* we don't need to release key->lock on exit */
-			mctp_key_unref(key);
+				/* we don't need to release key->lock on exit */
+				mctp_key_unref(key);
+			}
 			key = NULL;
 
 		} else {
-- 
2.26.3

