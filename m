Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6B4C4B3CD3
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Feb 2022 19:24:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237779AbiBMSYz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Feb 2022 13:24:55 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230009AbiBMSYw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Feb 2022 13:24:52 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C1065717C
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:24:46 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id z16so3551189pfh.3
        for <linux-kernel@vger.kernel.org>; Sun, 13 Feb 2022 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qIMt0RmWAsQWauyJZDRkp+AWN8bvJQqBJlsPfpkOQXE=;
        b=ceJfHs1cLBxsz5BKk+/jEK/pAPjb0m9drL+HpSH4kfb4H706RHjLsyJawdA/Yxb4lE
         erlTmiX/pmE/EiKd2LQvYVMdyq5kZGyMEJEnpWsvN7kJQR7NAe9D06I++F4jVmWdLWgB
         y1N/T3PCkSejTGnWCRvxEpIGCqN0Ns1w1WbWQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qIMt0RmWAsQWauyJZDRkp+AWN8bvJQqBJlsPfpkOQXE=;
        b=dnAPQwWhXgOXooRqQ5rUs39ru+RNfwzYEOOYl0ojwsLqKDVnYX3aaMiUdrM4dXfAOV
         vHXhHSHrJ3C9T3c4Ol5KrUz9U/UdZW/6dvXyDGP4MUc4yjdGoj3jzwTILIPXBe83Y6uO
         t8fUmNbYHSGrRJGjIMY3TAIiAsIZUqp190gjDptohtre/Qe8nbKfG/27UHI5zvWmCkWr
         Cyx/f9PVFsHY4jq6gf9OZuymWiQ+PL4cb4+CYH0tV1RU6O0pnrNOiYFPesLSTttvyNiM
         R3aJhWcS0kuvjTCUMkHQNClTjg+td2u3zz+1x/6LBfkQk2pTsQ+T+W1aHgM7mPAWwSLj
         sPNA==
X-Gm-Message-State: AOAM533afxMNggWQaQUDdLNKEVb40N0WbniAqbosukvig84YfECSGYhm
        5NwhJfWvH0kGblYDl/HMDKxS7A==
X-Google-Smtp-Source: ABdhPJwINsV0XJhP9HuH1sANDjByEYfXqHi97i/CHzledo+kTYPeqHWze6uGAfg2ugeAuBqpfriInQ==
X-Received: by 2002:a05:6a00:9a9:: with SMTP id u41mr10793347pfg.75.1644776685873;
        Sun, 13 Feb 2022 10:24:45 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c23sm2642759pfi.136.2022.02.13.10.24.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Feb 2022 10:24:45 -0800 (PST)
From:   Kees Cook <keescook@chromium.org>
To:     Josh Poimboeuf <jpoimboe@redhat.com>
Cc:     Kees Cook <keescook@chromium.org>,
        =?UTF-8?q?Valdis=20Kl=C4=93tnieks?= <valdis.kletnieks@vt.edu>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        "Justin Forbes" <jmforbes@linuxtx.org>,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: [PATCH v2] tools: Fix use-after-free for realloc(..., 0)
Date:   Sun, 13 Feb 2022 10:24:43 -0800
Message-Id: <20220213182443.4037039-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=2060; h=from:subject; bh=UDNf8UBq2T0ezuPPJ2TeXHBzHIPtm6yrBQnmEtMJVKc=; b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBiCUzqGx4ok+q1/PygEiy3RiPBLR7jygYB1WUQ+GCG Yn3uT6SJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYglM6gAKCRCJcvTf3G3AJpG0D/ 4ojQYj0flSG5P58fm/djxCldhf2qaFTgEzpsQVuu52jXjGVHIb6sMAiaTYQc/gVvKpnJ5TOjPz+5Fs yeOm0juNwOo2ZuovTZcoEJI17cR80rdwq96jN6TUMIycK4NrqRXc8DGrvp+A447Pi6UurGMdWZ9XWq YHYZ8yqAIYOENuM5UbHoig2xLrDMEbnCzaG5CM2iAWCXM77qq6X6Hsy/EJf6jPj3z3h9DyrH+U77JS F2Zf/25Ja5+RZSAasITedL7ikkIqNt81rZsSk5vVkEyO99MaeVN7HbYb4L+TN3CiX5GFsCPCUEIecg aF+YlHOXYX1n0SpfewDAC0yzd0KTjcpzqXyet+BYscaPXJ7aw2sxLC0dZ6K21UlkNn8gPu8hSEr1Gd IlL3P16TLFlWuydqlADn1hPgFuUmaN6sgfwPkeDEX03u/1sxDFm7JaR8zmMmYGzR4EE+Mri2Qcy6zE wLCbKtizssa2vh0pK3yF3AQFVm1bnaF+L1UGqsk15McE+LH07otlTV4R7J784U2pE6OjuYZZrQ1xm+ 8/6K8CLEzTZySrXi0pC+Aq1vbj1dthc5lqBXzra+CtACyPTeXH/fjEcZ6C4XqiEE4PBDvVtIvFElnQ rO9omxtUrKMZN5JE01S1BKPiZXsNQmE9wJctJ+R5iIEsOJGA/ZGbv+oIQC2Q==
X-Developer-Key: i=keescook@chromium.org; a=openpgp; fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

GCC 12 was correctly reporting a potential use-after-free condition in
the xrealloc helper. Fix the warning by avoiding an implicit "free(ptr)"
when size == 0:

In file included from help.c:12:
In function 'xrealloc',
    inlined from 'add_cmdname' at help.c:24:2: subcmd-util.h:56:23: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   56 |                 ret = realloc(ptr, size);
      |                       ^~~~~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~
subcmd-util.h:58:31: error: pointer may be used after 'realloc' [-Werror=use-after-free]
   58 |                         ret = realloc(ptr, 1);
      |                               ^~~~~~~~~~~~~~~
subcmd-util.h:52:21: note: call to 'realloc' here
   52 |         void *ret = realloc(ptr, size);
      |                     ^~~~~~~~~~~~~~~~~~

Reported-by: "Valdis Klētnieks" <valdis.kletnieks@vt.edu>
Fixes: 2f4ce5ec1d44 ("perf tools: Finalize subcmd independence")
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Signed-off-by: Kees Cook <keescook@chromium.org>
---
v1: https://lore.kernel.org/lkml/20220212181855.3460176-1-keescook@chromium.org/
v2: simplify logic (josh)
---
 tools/lib/subcmd/subcmd-util.h | 11 ++---------
 1 file changed, 2 insertions(+), 9 deletions(-)

diff --git a/tools/lib/subcmd/subcmd-util.h b/tools/lib/subcmd/subcmd-util.h
index 794a375dad36..b2aec04fce8f 100644
--- a/tools/lib/subcmd/subcmd-util.h
+++ b/tools/lib/subcmd/subcmd-util.h
@@ -50,15 +50,8 @@ static NORETURN inline void die(const char *err, ...)
 static inline void *xrealloc(void *ptr, size_t size)
 {
 	void *ret = realloc(ptr, size);
-	if (!ret && !size)
-		ret = realloc(ptr, 1);
-	if (!ret) {
-		ret = realloc(ptr, size);
-		if (!ret && !size)
-			ret = realloc(ptr, 1);
-		if (!ret)
-			die("Out of memory, realloc failed");
-	}
+	if (!ret)
+		die("Out of memory, realloc failed");
 	return ret;
 }
 
-- 
2.30.2

