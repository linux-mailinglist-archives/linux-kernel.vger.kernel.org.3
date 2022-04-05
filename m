Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97BCB4F4EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:56:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582639AbiDEXtC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:49:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457759AbiDEQll (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:41:41 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D340BDB48B
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:39:42 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id h4so20148395wrc.13
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:39:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaKfLsrc3XZWQqIO8eaNOg8ge8Ji7+/v6181V2TTNcc=;
        b=JraWzk1dVN/s3YPWE6AvnD8A2YawUca/c3wTpCGfOdGLOT8iR2qjz4I+fhRoLWBgX2
         K7oMk4HbYHpaYL9fuNNWTai6d7Pj42JbBJlt2Gz+PD0fE9oqprY7L8ttYme+mU7z9Jy1
         +lhTImI4F6qLi8PjuAJ/1obQWkx8AOn7vjMigrVpE/AN+8lDNchnUtVhW0Tck6xQmMfh
         iy0SNQ+ihW/IAfNCg1Nto4R8eELJSwOc9qtml31BHz5imNVjYjwvhOgHic2iVy40TQ5F
         CvQdLyDvYta1IFqW/lHpkZtgW694UNC7mEt+89LMaoBBneC9UnOYt1wfhoy+o1Zyo8zA
         w+3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=RaKfLsrc3XZWQqIO8eaNOg8ge8Ji7+/v6181V2TTNcc=;
        b=fJ8uIS+yY0L48c13Btu8fr8FH9spXtrwGARzPG43kicbFQTtpZ8i+cXOO+JsPQQPsp
         7F/P09NlM9ei8fDVFbYql+m4HD+1EF4/b/aDReqqYyeo3Ud187yNvYTjE+zqdN1GIb7o
         83/dtCUbV9Z15BVdKxEDnG1viYrUqNknrEA419w809LSRJHx2E7XzVZFEsjpDE/GyI/Y
         Kw6wi2K4V6pA84JqNKJLCnQtwA36IPulTNdYasYQ9QSI3tvkEXCbqqNavVEwORef8I+m
         sa9GtoOoU3L0giMU/zFiEjc9UQCd1GJHNy9X3hL13eA7ZbvKASQBJOAhbCL8AKJxdSaS
         RzdA==
X-Gm-Message-State: AOAM531CwhVI4EQIFq0Ii4HzCwVjPjQpaTVEHW+1VY7PyS8cyqxcYWPm
        2QZrhyuSqdr9dJfmwrrFjUmhUw==
X-Google-Smtp-Source: ABdhPJzRwIFnGuM3S2npgVv4565/6c5hTUeCqw3z/u/h3ykqBZowMeUDAykTZGUr3Ql4am57RL0yCA==
X-Received: by 2002:a05:6000:1a8d:b0:204:8cdb:279b with SMTP id f13-20020a0560001a8d00b002048cdb279bmr3365958wry.296.1649176781233;
        Tue, 05 Apr 2022 09:39:41 -0700 (PDT)
Received: from localhost ([2a02:168:96c5:1:55ed:514f:6ad7:5bcc])
        by smtp.gmail.com with ESMTPSA id k11-20020a5d6d4b000000b0020599079f68sm12454249wri.106.2022.04.05.09.39.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Apr 2022 09:39:40 -0700 (PDT)
From:   Jann Horn <jannh@google.com>
To:     "Theodore Ts'o" <tytso@mit.edu>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, Jann Horn <jannh@google.com>
Subject: [PATCH] random: Fix signal_pending() usage
Date:   Tue,  5 Apr 2022 18:39:31 +0200
Message-Id: <20220405163931.1108442-1-jannh@google.com>
X-Mailer: git-send-email 2.35.1.1094.g7c7d902a7c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

signal_pending() checks TIF_NOTIFY_SIGNAL and TIF_SIGPENDING, which signal
that the task should bail out of the syscall when possible.
This is a separate concept from need_resched(), which checks
TIF_NEED_RESCHED, signalling that the task should preempt.

In particular, with the current code, the signal_pending() bailout probably
won't work reliably.

Change this to look like other functions that read lots of data, such as
read_zero().

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Jann Horn <jannh@google.com>
---
 drivers/char/random.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/char/random.c b/drivers/char/random.c
index 1eb220a5f44f..7f0253455d4e 100644
--- a/drivers/char/random.c
+++ b/drivers/char/random.c
@@ -540,13 +540,13 @@ static ssize_t get_random_bytes_user(void __user *buf=
, size_t nbytes)
 	crng_make_state(chacha_state, (u8 *)&chacha_state[4], CHACHA_KEY_SIZE);
=20
 	do {
-		if (large_request && need_resched()) {
+		if (large_request) {
 			if (signal_pending(current)) {
 				if (!ret)
 					ret =3D -ERESTARTSYS;
 				break;
 			}
-			schedule();
+			cond_resched();
 		}
=20
 		chacha20_block(chacha_state, output);

base-commit: 0c3e7b36d92681bba4c73c198a35e5a806d6f3ff
--=20
2.35.1.1094.g7c7d902a7c-goog

