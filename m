Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACD050C9A6
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 13:38:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235294AbiDWLlo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 07:41:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235272AbiDWLlj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 07:41:39 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C5281BA831;
        Sat, 23 Apr 2022 04:38:40 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id y32so18491588lfa.6;
        Sat, 23 Apr 2022 04:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Ev9c+aQfJ7ziXboVPkC046QKOXTPSKhl1eNr/1ea/k=;
        b=q1R7jkimPBYNFPNI2CYFzTvfKXY046g833+P7K0KaIwCsJoTR9y46F/3Ul1+YtqavO
         GoyjUmrSKh44/tRcPs9iUobc4Ydbnyb9V2TQU8pZQxFIQ2XyhElzpw7uGpVNR3DXRQzY
         m9n0Kq60W8He9V3HhmqSZUKFVgt4mySs1DtLF/D+MPDap8dbVt8Gti7t2NwE507r5mXZ
         3clLM6NKJMc+Zd9+kfdrgLjJRExHozEtwhC/M74SmSKnWQ1AtLne4YIFJVcgjubWa2bO
         2Tusb6XXYbMDegSudmDHkjoLVX2FHAaH5iZSSMOnWTye6cIqQhgsH+74vMD2QrnoOYst
         O1Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Ev9c+aQfJ7ziXboVPkC046QKOXTPSKhl1eNr/1ea/k=;
        b=UxPTdSK4Mlwn8kmCAkLMG8CNOD4zI4XFZ7l03BfIx+9VmIdQQbyCjUp06wPIWtiOxn
         DTitmnxEXQxbVg3Jwe91+APKLKz+TreAOLgrGmNcYz3ob/CyY/N2I1u4FCZTTXhMtTHa
         mZw1BJyoDp4Fv44eMGJ90yAcN+b2aYvUNUNsmlK8EEGZzfJFAmSsNNFuM1B7XssXd0HV
         dnzprhBxhVUhNPnu8n+IY5Z8sO9wDLev4yTKwS6oAhMe361ZTlYKPORrSTi50lwdMcOc
         4x7WY8sKLUBSIexDWvmNJ1bd2sXIHwq3HbrOQtxr9q7pONXTdFVToEuvC9/5BNEI4Oe/
         1zDw==
X-Gm-Message-State: AOAM530QgnA5/yV31LaM3rPcurhY5mg0xOuKIKy5AqO/eInYacwcd8DH
        3V2TEp5do3yIDiE4871kFUo=
X-Google-Smtp-Source: ABdhPJyB4OUxiICa7Qfg6q4ykypeL5HiK8Dtl8PVPKWvzS3a3V+PKR8t0PBmguoJ7Og7goWDJ6G2Dg==
X-Received: by 2002:a05:6512:1093:b0:471:953c:6ffa with SMTP id j19-20020a056512109300b00471953c6ffamr6378337lfg.618.1650713918816;
        Sat, 23 Apr 2022 04:38:38 -0700 (PDT)
Received: from morzel-asus.lan (static-91-225-135-18.devs.futuro.pl. [91.225.135.18])
        by smtp.gmail.com with ESMTPSA id g17-20020a2e9cd1000000b0024db538c2absm526411ljj.7.2022.04.23.04.38.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Apr 2022 04:38:38 -0700 (PDT)
From:   Michal Orzel <michalorzel.eng@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>
Cc:     Michal Orzel <michalorzel.eng@gmail.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: [PATCH RESEND v2 4/5] block/partitions/atari: Remove redundant assignment
Date:   Sat, 23 Apr 2022 13:38:10 +0200
Message-Id: <20220423113811.13335-4-michalorzel.eng@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220423113811.13335-1-michalorzel.eng@gmail.com>
References: <20220423113811.13335-1-michalorzel.eng@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Get rid of redundant assignment to a variable part_fmt from function
atari_partition. It is being assigned a value that is never read until
the end of function.

Reported by clang-tidy [deadcode.DeadStores]

Signed-off-by: Michal Orzel <michalorzel.eng@gmail.com>
---
 block/partitions/atari.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/partitions/atari.c b/block/partitions/atari.c
index da5994175416..9655c728262a 100644
--- a/block/partitions/atari.c
+++ b/block/partitions/atari.c
@@ -140,7 +140,6 @@ int atari_partition(struct parsed_partitions *state)
 				/* accept only GEM,BGM,RAW,LNX,SWP partitions */
 				if (!((pi->flg & 1) && OK_id(pi->id)))
 					continue;
-				part_fmt = 2;
 				put_partition (state, slot,
 						be32_to_cpu(pi->st),
 						be32_to_cpu(pi->siz));
-- 
2.25.1

