Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96B4E4FAA12
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 20:04:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242938AbiDISGE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 14:06:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233305AbiDISGA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 14:06:00 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43AEB94
        for <linux-kernel@vger.kernel.org>; Sat,  9 Apr 2022 11:03:52 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id g21so14179785iom.13
        for <linux-kernel@vger.kernel.org>; Sat, 09 Apr 2022 11:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mUG6QiQTmHfwgnDwUso5dIAM47XXDf7ghDlvuJZskMg=;
        b=HS3dzFtie/5Nyl5rwdbRdpbcwvuu/y1rpDazlF5GPV09aPpwT/ehBSkg6SZexjHnza
         dOapUYQtTICQQSZWinlzmucupskGQrRjlyet5Rc5ZW1+GX2AwCy4Hx6exsPrlXuW+Fvi
         aQnuEM2N8mb7x2WOIrGNmV3VtKBGMQ51dtAMvKrOEeD0Xn54uxWExsw82JQiyrik/jYe
         ulwQCLZX8t67W+Ol3TerRyx3hTfNAaEelr7Z+kihIQvpgP3CXXMfPiXHqzQ42ooW0VIM
         QSSJJqPpM4y88IVtwVfUmZiYWYtnlcHR/6LO+WY4RP5IQOZNCGEFIQDeSo2WspK887t+
         ZRPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mUG6QiQTmHfwgnDwUso5dIAM47XXDf7ghDlvuJZskMg=;
        b=kgt5KzlJSVuZMuJYzTljprToqxxl6ywjFlBCY9HdoRQ7sZWE2uC1Ra3em+yU57c7cH
         Q1LoK/ZRSOplEloHjEL52wW2ka8YetymDv3aAHidb0pzxQ6QPwLda6N0DHbipfi7Y8cA
         /ncuHwdsHWJ7mu1sRNKM0wwYVqYCIRiPbXXlKghk52w5WFYccxvFKo4ATrPoSmlibSj+
         havFOvurJGjAdCGjzImksbIaCy1JJE/B9deIxHz9SN95cujn64BTb3lWZGn6DSYmNV0T
         wMsuSoDsr/wxJz4cKTZqt5/drQERcbHZ0+FB6Q2sSfGoubi6jtKkYif8s83IYIIZ4S+s
         i/gA==
X-Gm-Message-State: AOAM531KmwGjmTEOweFB4jSJerag+8SgXU3q8zdACV1FAn20Sa38Ifyc
        rvQZTlHbPmM78R5tbGvT8KmVzurBft3cASsbQw4=
X-Google-Smtp-Source: ABdhPJz5IDX6IYiWakCJ7dXBepfl1RZ9dG5b0DCHXZir0DSkpbDhDr1LS6KVoI8RipCrEhQYTkdUrg==
X-Received: by 2002:a6b:f217:0:b0:64c:de54:4e8d with SMTP id q23-20020a6bf217000000b0064cde544e8dmr10563946ioh.48.1649527431633;
        Sat, 09 Apr 2022 11:03:51 -0700 (PDT)
Received: from localhost (ec2-13-59-0-164.us-east-2.compute.amazonaws.com. [13.59.0.164])
        by smtp.gmail.com with UTF8SMTPSA id w2-20020a92c882000000b002c81bffee08sm15706695ilo.55.2022.04.09.11.03.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Apr 2022 11:03:51 -0700 (PDT)
From:   Schspa Shi <schspa@gmail.com>
To:     swboyd@chromium.org, akpm@linux-foundation.org
Cc:     schspa@gmail.com, linux-kernel@vger.kernel.org
Subject: [PATCH] scripts/decode_stacktrace.sh: support old bash version
Date:   Sun, 10 Apr 2022 02:03:32 +0800
Message-Id: <20220409180331.24047-1-schspa@gmail.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Old bash version don't support associative array variables.
Avoid to use associative array variables to avoid error.

Without this, old bash version will report error as fellowing
[   15.954042] Kernel panic - not syncing: sysrq triggered crash
[   15.955252] CPU: 1 PID: 167 Comm: sh Not tainted 5.18.0-rc1-00208-gb7d075db2fd5 #4
[   15.956472] Hardware name: Hobot J5 Virtual development board (DT)
[   15.957856] Call trace:
./scripts/decode_stacktrace.sh: line 128: ,dump_backtrace: syntax error: operand expected (error token is ",dump_backtrace")

Signed-off-by: Schspa Shi <schspa@gmail.com>
---
 scripts/decode_stacktrace.sh | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/scripts/decode_stacktrace.sh b/scripts/decode_stacktrace.sh
index 5fbad61fe490..7075e26ab2c4 100755
--- a/scripts/decode_stacktrace.sh
+++ b/scripts/decode_stacktrace.sh
@@ -45,8 +45,13 @@ else
 	fi
 fi
 
-declare -A cache
-declare -A modcache
+declare aarray_support=true
+declare -A cache 2>/dev/null
+if [[ $? != 0 ]]; then
+	aarray_support=false
+else
+	declare -A modcache
+fi
 
 find_module() {
 	if [[ -n $debuginfod ]] ; then
@@ -97,7 +102,7 @@ parse_symbol() {
 
 	if [[ $module == "" ]] ; then
 		local objfile=$vmlinux
-	elif [[ "${modcache[$module]+isset}" == "isset" ]]; then
+	elif [[ $aarray_support == true && "${modcache[$module]+isset}" == "isset" ]]; then
 		local objfile=${modcache[$module]}
 	else
 		local objfile=$(find_module)
@@ -105,7 +110,9 @@ parse_symbol() {
 			echo "WARNING! Modules path isn't set, but is needed to parse this symbol" >&2
 			return
 		fi
-		modcache[$module]=$objfile
+		if [[ $aarray_support == true ]]; then
+			modcache[$module]=$objfile
+		fi
 	fi
 
 	# Remove the englobing parenthesis
@@ -125,7 +132,7 @@ parse_symbol() {
 	# Use 'nm vmlinux' to figure out the base address of said symbol.
 	# It's actually faster to call it every time than to load it
 	# all into bash.
-	if [[ "${cache[$module,$name]+isset}" == "isset" ]]; then
+	if [[ $aarray_support == true && "${cache[$module,$name]+isset}" == "isset" ]]; then
 		local base_addr=${cache[$module,$name]}
 	else
 		local base_addr=$(nm "$objfile" 2>/dev/null | awk '$3 == "'$name'" && ($2 == "t" || $2 == "T") {print $1; exit}')
@@ -133,7 +140,9 @@ parse_symbol() {
 			# address not found
 			return
 		fi
-		cache[$module,$name]="$base_addr"
+		if [[ $aarray_support == true ]]; then
+			cache[$module,$name]="$base_addr"
+		fi
 	fi
 	# Let's start doing the math to get the exact address into the
 	# symbol. First, strip out the symbol total length.
@@ -149,11 +158,13 @@ parse_symbol() {
 
 	# Pass it to addr2line to get filename and line number
 	# Could get more than one result
-	if [[ "${cache[$module,$address]+isset}" == "isset" ]]; then
+	if [[ $aarray_support == true && "${cache[$module,$address]+isset}" == "isset" ]]; then
 		local code=${cache[$module,$address]}
 	else
 		local code=$(${CROSS_COMPILE}addr2line -i -e "$objfile" "$address" 2>/dev/null)
-		cache[$module,$address]=$code
+		if [[ $aarray_support == true ]]; then
+			cache[$module,$address]=$code
+		fi
 	fi
 
 	# addr2line doesn't return a proper error code if it fails, so
-- 
2.24.3 (Apple Git-128)

