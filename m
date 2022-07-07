Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F39C56AA63
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 20:22:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236147AbiGGSW1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 14:22:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235666AbiGGSWT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 14:22:19 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C18A7564F3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 11:22:18 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id e63-20020a253742000000b0066e1afdb46aso11400378yba.1
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 11:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=R1WcdFk/TWy+sEGVd4Eg6xNGBTF47VVsySZzXRRJmuQ=;
        b=p0IZo4quADAm9LtBXYER13jRilXxoEbNNtWctNbyaz94erFfW+/Ae4hr4rVCQ6taf0
         RmvqWwPSaYaZpN4RAUiJKaeUTKAWY6RA2Ge7MirqMcudrm05hCquBdlmHuCtPCgW16Xz
         8dFkgNLraPLJDys+pHz0L/ELmkfeGXC+ojce8v36eAWvM8/4fimra2bPU+YQzvuk8kTO
         cMj85XWyMp3nRUmvJfof1bHn8YbcbePJGEB8tVkbFN0MosoJiWlKlcUiwIOFvOlp719z
         KZr2S/fCabh/SdU+11LuCoGVEAFPO1dgHcFjbmOlMSMcFuvAaXi2snaZ6PZpE7Vsmds3
         /0CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=R1WcdFk/TWy+sEGVd4Eg6xNGBTF47VVsySZzXRRJmuQ=;
        b=faFzqzBs+JPHmIMOcRthLcT8HuowwPHkoKPV+mPaZNu7+tVbfgKXIzq8wV1jNFRWsk
         dRuwC0+4HTBovqQSummjuKvMbo+PehForXajxERwm2j0f5ttQ3Oxi57GWTWwFHtawI0j
         D2ezWiF6ufugy//HXf3LRI8MEBrKZo9DScM2ZnCeSk+hKtEFWIThDtV9JvYQjwLdeKVm
         wrZyJLfKAxM7QQqIimkHPyyDhGSU4utrn4Qj1IS3ZzWWgKeAh6JQGN3RWp0VyCNxPFuV
         YE+F5QhM5Jf8Bj5doUid0szjq9k61Nf01jOuHo96LHoqVweqt9LxemQwPfY1mEk/L3La
         GL5g==
X-Gm-Message-State: AJIora8hg29NzLG2mQ5UG5YjW0cge2LvWkLouj2xUcg345lMmreccio8
        PBSwYXrK6Vmy2c2T/R/KQv8D1tVejDwIIYEr3A==
X-Google-Smtp-Source: AGRyM1tmNx0T2KWxtxST94klObq1uh9KpQnah6fe41ByOMvHcjrVTSMEGMhluBFJBCjdo2HJ7Z4GUvoKoyA7AFMMDw==
X-Received: from justinstitt.mtv.corp.google.com ([2620:15c:211:202:4640:519a:f833:9a5])
 (user=justinstitt job=sendgmr) by 2002:a25:9345:0:b0:66e:3100:c83d with SMTP
 id g5-20020a259345000000b0066e3100c83dmr29236559ybo.185.1657218138053; Thu,
 07 Jul 2022 11:22:18 -0700 (PDT)
Date:   Thu,  7 Jul 2022 11:20:52 -0700
In-Reply-To: <20220706235648.594609-1-justinstitt@google.com>
Message-Id: <20220707182052.769989-1-justinstitt@google.com>
Mime-Version: 1.0
References: <20220706235648.594609-1-justinstitt@google.com>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
Subject: [PATCH v2] net: rxrpc: fix clang -Wformat warning
From:   Justin Stitt <justinstitt@google.com>
To:     justinstitt@google.com
Cc:     davem@davemloft.net, dhowells@redhat.com, edumazet@google.com,
        kuba@kernel.org, linux-afs@lists.infradead.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        marc.dionne@auristor.com, nathan@kernel.org,
        ndesaulniers@google.com, netdev@vger.kernel.org, pabeni@redhat.com,
        trix@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When building with Clang we encounter this warning:
| net/rxrpc/rxkad.c:434:33: error: format specifies type 'unsigned short'
| but the argument has type 'u32' (aka 'unsigned int') [-Werror,-Wformat]
| _leave(" = %d [set %hx]", ret, y);

y is a u32 but the format specifier is `%hx`. Going from unsigned int to
short int results in a loss of data. This is surely not intended
behavior. If it is intended, the warning should be suppressed through
other means.

This patch should get us closer to the goal of enabling the -Wformat
flag for Clang builds.

Link: https://github.com/ClangBuiltLinux/linux/issues/378
Signed-off-by: Justin Stitt <justinstitt@google.com>
---
diff from v1 -> v2: 
* Change format specifier from %u to %x to properly represent hexadecimal.

 net/rxrpc/rxkad.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/rxrpc/rxkad.c b/net/rxrpc/rxkad.c
index 08aab5c01437..258917a714c8 100644
--- a/net/rxrpc/rxkad.c
+++ b/net/rxrpc/rxkad.c
@@ -431,7 +431,7 @@ static int rxkad_secure_packet(struct rxrpc_call *call,
 		break;
 	}
 
-	_leave(" = %d [set %hx]", ret, y);
+	_leave(" = %d [set %x]", ret, y);
 	return ret;
 }
 
-- 
2.37.0.rc0.161.g10f37bed90-goog

