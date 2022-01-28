Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32E1549FBE7
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:41:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349368AbiA1OlJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:41:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349356AbiA1OlH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:41:07 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66F54C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:41:06 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id n12-20020a05600c3b8c00b0034eb13edb8eso4809802wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:41:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxRA/z+rIvvKpPSi5vpIRUkcRSZ3WwPALJ5ojRw+TVY=;
        b=ogmYuHfaxqr6MuzBEAMi0rmjhc+yaBO7xXzb+RVf0cwWkP+ECWpCrfFjtL7dSdjLWV
         6QY8TS5p05WOZp/EEBTELv+3UraSzdJkORT0eXsSAHu4i/9Vyx4u8UjW1JyTnOM9VPKH
         1QjCl6AG3vL4s0RSqY6/GEH5/AgD9EnSaNVyyN//AQMLkvM1zaJv68OY+oNJ2xHQsnXV
         ZZIG86nT+YFLPP9FVDvfYjiSxSWkUnCHKL3l9VYj6yobltnA6lfv8MoorkfaFzkoVCwC
         tmyrl6HHa2fXa56IqZj4lxFrsWow4cJDfJx6cL65g4zzMFD8pr7R091aa+wUPiJZJz2V
         s/ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zxRA/z+rIvvKpPSi5vpIRUkcRSZ3WwPALJ5ojRw+TVY=;
        b=EN9btGiGG0no8SiMHDWNxIXp94KswyN9AbDz1zju6Cz9iUrA4pF/VHg/yBfHliNt6n
         VJq5TJtFqACSKQTFZB3udMP/RWSriM7SGIf6vnSWW0GDKBqu1uKSKnNUiUMPT2akBF3a
         p0oaZDrM1zup6iwUDFCLSeFDsIeLBOa4rrNSGThQc3Tkoxwfj2dr1pfOoiMYNODoJfmw
         giBt769D1cYbUfryyD+Gp9CHJ2K+eIZoUTcyJ47IprQONe9mGZNRkC3jezhh30X3hClX
         yF9ncvvW5ZRS16s7nzadTEKgwiWuKBzw/kNcOhlWJoWwo8Akka+/NqR4qJ1MJk4G6Shv
         wdlQ==
X-Gm-Message-State: AOAM532VphSTmZv+lxmUy1QzJDxzLfzCfDLJupyY4w+po821xggGFOrS
        9fU+xts0c6GsXmN2oA4pR6hNjw==
X-Google-Smtp-Source: ABdhPJwJifrlbLKVorSrG7JKpeTMTKUOqCLid0O4FsYzEbpJ4fA22S//Eks9XJ2hd9adjsSsaP1ppA==
X-Received: by 2002:a1c:a90d:: with SMTP id s13mr7732674wme.32.1643380864973;
        Fri, 28 Jan 2022 06:41:04 -0800 (PST)
Received: from maple.lan (cpc141216-aztw34-2-0-cust174.18-1.cable.virginm.net. [80.7.220.175])
        by smtp.gmail.com with ESMTPSA id j4sm5511130wrq.81.2022.01.28.06.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:41:04 -0800 (PST)
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Jason Wessel <jason.wessel@windriver.com>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Daniel Thompson <daniel.thompson@linaro.org>,
        kgdb-bugreport@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] kdb: Fix the putarea helper function
Date:   Fri, 28 Jan 2022 14:40:55 +0000
Message-Id: <20220128144055.207267-1-daniel.thompson@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently kdb_putarea_size() uses copy_from_kernel_nofault() to write *to*
arbitrary kernel memory. This is obviously wrong and means the memory
modify ('mm') command is a serious risk to debugger stability: if we poke
to a bad address we'll double-fault and lose our debug session.

Fix this the (very) obvious way.

Note that there are two Fixes: tags because the API was renamed and this
patch will only trivially backport as far as the rename (and this is
probably enough). Nevertheless Christoph's rename did not introduce this
problem so I wanted to record that!

Fixes: fe557319aa06 ("maccess: rename probe_kernel_{read,write} to copy_{from,to}_kernel_nofault")
Fixes: 5d5314d6795f ("kdb: core for kgdb back end (1 of 2)")
Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
---
 kernel/debug/kdb/kdb_support.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/debug/kdb/kdb_support.c b/kernel/debug/kdb/kdb_support.c
index df2bface866ef..85cb51c4a17e6 100644
--- a/kernel/debug/kdb/kdb_support.c
+++ b/kernel/debug/kdb/kdb_support.c
@@ -291,7 +291,7 @@ int kdb_getarea_size(void *res, unsigned long addr, size_t size)
  */
 int kdb_putarea_size(unsigned long addr, void *res, size_t size)
 {
-	int ret = copy_from_kernel_nofault((char *)addr, (char *)res, size);
+	int ret = copy_to_kernel_nofault((char *)addr, (char *)res, size);
 	if (ret) {
 		if (!KDB_STATE(SUPPRESS)) {
 			kdb_func_printf("Bad address 0x%lx\n", addr);

base-commit: e783362eb54cd99b2cac8b3a9aeac942e6f6ac07
--
2.34.1

