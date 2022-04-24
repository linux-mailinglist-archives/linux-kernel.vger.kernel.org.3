Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE39E50D491
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 21:10:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238196AbiDXTNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 15:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233688AbiDXTNg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 15:13:36 -0400
Received: from conuserg-10.nifty.com (conuserg-10.nifty.com [210.131.2.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E3DC5;
        Sun, 24 Apr 2022 12:10:10 -0700 (PDT)
Received: from grover.sesame (133-32-177-133.west.xps.vectant.ne.jp [133.32.177.133]) (authenticated)
        by conuserg-10.nifty.com with ESMTP id 23OJ8o66019069;
        Mon, 25 Apr 2022 04:08:58 +0900
DKIM-Filter: OpenDKIM Filter v2.10.3 conuserg-10.nifty.com 23OJ8o66019069
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nifty.com;
        s=dec2015msa; t=1650827339;
        bh=kJnjAmfszd07kvXQgrws7scTsZH1PmGYmYs1or5Wwg0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=V7Nq7nspoDGXmiH44GZC70tq5y14JoacggAS6fyScmeWDqbVrV4KMT9/dIOW3sYIN
         fEOH5b+hokJDBkkpJmKplIQb5F2RgGol4GdK7AwHj5oiArxW4z8CalV8wrTbRnas4e
         ho3VS1ZrTxFDTf7dBRlR1oBqAcmtCXH3qnw6moZGqVaSYHJlYyZlC7gz9aVM0G9dzP
         INzQbAdINXxWU5J7NX5H3Y3pv5mvcNDE75Wt5PuLpq8506a/dt/XNymBRfaziN7agV
         LTtIzoe7IElCnfXc/xp35cfyX0wzGa21LH29mX+C6pTz1T/UG5xr3ccyvy6wtt2GKH
         I+g5GA8cVRPlg==
X-Nifty-SrcIP: [133.32.177.133]
From:   Masahiro Yamada <masahiroy@kernel.org>
To:     linux-kbuild@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>
Subject: [PATCH 12/27] modpost: move struct namespace_list to modpost.c
Date:   Mon, 25 Apr 2022 04:07:56 +0900
Message-Id: <20220424190811.1678416-13-masahiroy@kernel.org>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20220424190811.1678416-1-masahiroy@kernel.org>
References: <20220424190811.1678416-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_SOFTFAIL,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is no good reason to define struct namespace_list in modpost.h

struct module has pointers to struct namespace_list, but that does
not require the definition of struct namespace_list.

Move it to modpost.c.

Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
---

 scripts/mod/modpost.c | 5 +++++
 scripts/mod/modpost.h | 5 -----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/scripts/mod/modpost.c b/scripts/mod/modpost.c
index 4c074d6c1721..6f2748340746 100644
--- a/scripts/mod/modpost.c
+++ b/scripts/mod/modpost.c
@@ -281,6 +281,11 @@ static struct symbol *find_symbol(const char *name)
 	return NULL;
 }
 
+struct namespace_list {
+	struct namespace_list *next;
+	char namespace[];
+};
+
 static bool contains_namespace(struct namespace_list *list,
 			       const char *namespace)
 {
diff --git a/scripts/mod/modpost.h b/scripts/mod/modpost.h
index 6a90bfc08458..2dbafbda9b0f 100644
--- a/scripts/mod/modpost.h
+++ b/scripts/mod/modpost.h
@@ -109,11 +109,6 @@ buf_printf(struct buffer *buf, const char *fmt, ...);
 void
 buf_write(struct buffer *buf, const char *s, int len);
 
-struct namespace_list {
-	struct namespace_list *next;
-	char namespace[];
-};
-
 struct module {
 	struct list_head list;
 	int gpl_compatible;
-- 
2.32.0

