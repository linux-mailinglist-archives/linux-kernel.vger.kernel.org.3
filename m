Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCCEB4EDFB8
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 19:35:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231909AbiCaRgm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 13:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiCaRg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 13:36:29 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4228161A38;
        Thu, 31 Mar 2022 10:34:38 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id c15so702049ljr.9;
        Thu, 31 Mar 2022 10:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7qM824sS6qaLgSDzZBkMu0728+GM94bEbKxid0FDaSw=;
        b=ans9cQPDD/Bcxy8c6SvWao1RjIHo6wajUKKZOpjeeOnhiAnXXssLYPDwf/e3M9D5Mq
         Bo69mhH6rhiRYVtrNQV7Lst9UewuihSsjNJe5anLqbcSAGftyWr2LT6h9qVV1nzXz68K
         0QUZ7jfJaldu9N6lMlaTTtYfubkesA9xLlif0NSWBnFzdLFbmtD7Y4oejabNNRkcL+IM
         t2uORsApDGoVOz+FxcoF7xQkgJVFZvBtPLLTG7bPZwvfblT1U1zdbd20sUHZrSyO1554
         aBexCtyS5lKBelKrZ/MPGcbOT9IR4isXNC+au+aFJMfCFTutn4uw8kr8i/dxYkffZC7G
         bXyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7qM824sS6qaLgSDzZBkMu0728+GM94bEbKxid0FDaSw=;
        b=HpJGEINr25JzUNi2cMnlC6dQYuonRQ75+vaN5SvV7V2aqVytG0Q8nIgap3J7XAB82w
         E1Rak/ZghE6fglQ8TzeseqTNEQEN8GR378lH2MGfoXaqb9qpThiiHIVo3E338UqNhZlI
         7wqmu3m+XyrsmRrFuqftywqtT0zSrO1xPwxC+o8LCjQkLV1AAwYWUabL432d2RMino8a
         lXx6wKMxQzLEgx5nldScWrmyMKjXBdbifJWx906dkIQ3EmLqm502H/3+IVXwMd4pdwfl
         IdAL/WP8y3DF+17zq4/gqocVxmf1Xiv6tVIJKeyT3fr9u/RDPzLmMl9Kin+EDNCZmqSy
         S/Hg==
X-Gm-Message-State: AOAM5318ePYAGSj8RuICogd65p0nAi1MD++9cD2Gvt0WJ6tyDk3wX65/
        vzEsfLfN1OfOC6Aoqv3KaX0=
X-Google-Smtp-Source: ABdhPJzT+D0LszikZlweoZjrGWaHhUe+vXIeV9Rkh43UlrBK+TBFxLpNPv92lCgOKGYSvZduQJEDdA==
X-Received: by 2002:a2e:8189:0:b0:249:7d3a:ceb0 with SMTP id e9-20020a2e8189000000b002497d3aceb0mr10387568ljg.367.1648748073357;
        Thu, 31 Mar 2022 10:34:33 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id bd10-20020a05651c168a00b00247fe29d83csm2746992ljb.73.2022.03.31.10.34.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 10:34:33 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: [PATCH 3/5] keys: Remove redundant assignments
Date:   Thu, 31 Mar 2022 19:33:56 +0200
Message-Id: <20220331173358.40939-3-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220331173358.40939-1-michalorzel.eng@gmail.com>
References: <20220331173358.40939-1-michalorzel.eng@gmail.com>
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

Get rid of redundant assignments which end up in values not being
read either because they are overwritten or the function ends.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 security/keys/process_keys.c | 1 -
 security/keys/request_key.c  | 6 ++----
 2 files changed, 2 insertions(+), 5 deletions(-)

diff --git a/security/keys/process_keys.c b/security/keys/process_keys.c
index b5d5333ab330..8bdd6410f79a 100644
--- a/security/keys/process_keys.c
+++ b/security/keys/process_keys.c
@@ -92,7 +92,6 @@ int look_up_user_keyrings(struct key **_user_keyring,
 		return PTR_ERR(reg_keyring);
 
 	down_write(&user_ns->keyring_sem);
-	ret = 0;
 
 	/* Get the user keyring.  Note that there may be one in existence
 	 * already as it may have been pinned by a session, but the user_struct
diff --git a/security/keys/request_key.c b/security/keys/request_key.c
index 2da4404276f0..ad29023c9518 100644
--- a/security/keys/request_key.c
+++ b/security/keys/request_key.c
@@ -116,7 +116,7 @@ static int call_sbin_request_key(struct key *authkey, void *aux)
 {
 	static char const request_key[] = "/sbin/request-key";
 	struct request_key_auth *rka = get_request_key_auth(authkey);
-	const struct cred *cred = current_cred();
+	const struct cred *cred;
 	key_serial_t prkey, sskey;
 	struct key *key = rka->target_key, *keyring, *session, *user_session;
 	char *argv[9], *envp[3], uid_str[12], gid_str[12];
@@ -506,9 +506,7 @@ static struct key *construct_key_and_link(struct keyring_search_context *ctx,
 			kdebug("cons failed");
 			goto construction_failed;
 		}
-	} else if (ret == -EINPROGRESS) {
-		ret = 0;
-	} else {
+	} else if (ret != -EINPROGRESS) {
 		goto error_put_dest_keyring;
 	}
 
-- 
2.25.1

