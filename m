Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD060512581
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 00:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238253AbiD0Wt7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 18:49:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237258AbiD0Wtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 18:49:45 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14AE347076
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:46:25 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id k23so6157159ejd.3
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 15:46:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ktLjh0arY7M9jHkCEl8as+aaLtThvm0ZUfC/SiXTrT0=;
        b=deJz5bfr1wzbr/xa1nRDWV0Z2KQa4zDAniqQ9qqH+0/M7kOOIqGgya9NtzEe+Q7B/K
         fZU+C1XHzzyFz/Vj605IEDbk+6nwhB3vofo5hRBrsaRko/bvBIgVN+1FweCXo/Eb/UXr
         3o2US3nJ+oAyow2HF+srqWZyFOZP594EkwS+Br/PH0+FS77gWzsEnO7IBXwk5kz12K41
         FxyAtZAXtJul2flX6xNcPy+Bv6IkuoK3OUYGbUcPCje7EXrijBZBsqKiuSfS+/mW0POY
         9Yjn3nBtSOCJ7BYIkBBfu5ip6Ojb/SgzOrZRWqTCKbPv/Pqs+YqramtF81zqQbGybMhX
         85Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ktLjh0arY7M9jHkCEl8as+aaLtThvm0ZUfC/SiXTrT0=;
        b=0QXzI3euy4rhL2NGTg5UBn6NIFn+uoZJHy/pCX33nDpfoONWFXlrGa/69qj5753nSB
         B4NqunikJ4BzUtT3QOcTXwtjWnbCjdKP9KA6/ntoPqMRzizEUZKe440kwcNQ1ZPP683y
         mrnOJ1E19RnjVzeklSe1Tir0A0/uR7hZFKFEhIRo3q4x7dBy71kc0/Pki3cI8RA3FWCU
         XrhN4nIA6mnLtA12wfTyMCjTTaC41Dr5jR8eats0CEWvEGgHV0ZX+pOEnwRjcPHR10iu
         25CORDj07zayeBa47jWqfGxVjkbZ1xvUnsLYdyEoVyK9gEPR/fdL/o+MyMl/rjOsRtWA
         TsyQ==
X-Gm-Message-State: AOAM530RlNEnDXS/KBKp5oHAFNbFjeIbxubZzV5Z6ns0/sUOOaui7BKj
        v+uPZd/ybZ2MsmuIB+XBMfg=
X-Google-Smtp-Source: ABdhPJy7LMe2OaP7udKjAf2xITYTQLijS7OwSP4EpEcGzbE21HmKPDvNRCEXDAEHPGHDJ6Gp9GRvlw==
X-Received: by 2002:a17:906:1691:b0:6f3:a3bf:451a with SMTP id s17-20020a170906169100b006f3a3bf451amr14130112ejd.61.1651099583709;
        Wed, 27 Apr 2022 15:46:23 -0700 (PDT)
Received: from nlaptop.localdomain (ptr-dtfv0poj8u7zblqwbt6.18120a2.ip6.access.telenet.be. [2a02:1811:cc83:eef0:f2b6:6987:9238:41ca])
        by smtp.gmail.com with ESMTPSA id o14-20020a170906774e00b006d5b915f27dsm7351657ejn.169.2022.04.27.15.46.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 15:46:23 -0700 (PDT)
From:   Niels Dossche <dossche.niels@gmail.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Mina Almasry <almasrymina@google.com>,
        Niels Dossche <dossche.niels@gmail.com>
Subject: [PATCH 2/2] selftest/vm: test that mremap fails on non-existent vma
Date:   Thu, 28 Apr 2022 00:44:39 +0200
Message-Id: <20220427224439.23828-3-dossche.niels@gmail.com>
X-Mailer: git-send-email 2.35.2
In-Reply-To: <20220427224439.23828-1-dossche.niels@gmail.com>
References: <20220427224439.23828-1-dossche.niels@gmail.com>
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

Add a regression test that validates that mremap fails for vma's that
don't exist.

Signed-off-by: Niels Dossche <dossche.niels@gmail.com>
---
 tools/testing/selftests/vm/hugepage-mremap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/testing/selftests/vm/hugepage-mremap.c b/tools/testing/selftests/vm/hugepage-mremap.c
index 1d689084a54b..585978f181ed 100644
--- a/tools/testing/selftests/vm/hugepage-mremap.c
+++ b/tools/testing/selftests/vm/hugepage-mremap.c
@@ -178,6 +178,12 @@ int main(int argc, char *argv[])
 
 	munmap(addr, length);
 
+	addr = mremap(addr, length, length, 0);
+	if (addr != MAP_FAILED) {
+		printf("mremap: Expected failure, but call succeeded\n");
+		exit(1);
+	}
+
 	close(fd);
 	unlink(argv[argc-1]);
 
-- 
2.35.2

