Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C95E56AC7F
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 22:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiGGUHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 16:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236501AbiGGUHn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 16:07:43 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5758E5C97A;
        Thu,  7 Jul 2022 13:07:42 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id v16so16364197wrd.13;
        Thu, 07 Jul 2022 13:07:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=fjuxWDMkF+yIhZqXQNjKUPrxi+DzheW/VDkXkV1rktk=;
        b=OoqmEgGmh500chVuJVlqXj2ZHy2DTfFR+E/zia0hmHE30D3bPNQUH6sv9Nsp5bpjL4
         XN/1et4HTwgyXUzr70ngqml63VfaGSs/XD+AE58iTPz43mL084M9ORet4CzH2UycGH9U
         QOBfTSTv0N1XokCRzCt+3FDmLTXhRSrAloQCCjT2HV6fq5APd/HTrJnqIXCahwoqqgK2
         u9tbYOsHiz1wJBHHmB7kVQqWo1+5mEth/Yf6XtUr9au8DlcYSOFOwkMEXFjHZ15XdHnV
         5RTM599OM+0AG3KEWyJvAIFn0d7xCg+4mi16QRdO+NN0Heos/3z536xz/unXn5PUXeeb
         uhtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=fjuxWDMkF+yIhZqXQNjKUPrxi+DzheW/VDkXkV1rktk=;
        b=DiX/C2ydh5prlNWyZh2Gjxz+AvkgC+HC+T/NZ38irBDEC8R15rip3/v4QRzRVf8xHx
         SF9Gv3M2JLu81N2zAW9rFkZmXGwu36eBnkUOcuLMETvjp1C4Q6FXaBHsbgGbtXlTLks5
         cJzTDCddTUBJG3TCDpXbDkXTL6acfrvXsU0JPyld05wu/XhiVTpNdXsgEoeZm+C6SYMD
         z9vtnAT+TFjznpxM0NS7f6AzCbGYx+JiyR4F/sctoYXO+Jq/Kt7pc+prYQYx/8YK1aMC
         uiZJnEdwlC74tL4RSTdqtRJ284kz1MSYjGyKk3ys9JzDXxMs8CeEfLrhnZjFndU9pS6u
         Xp+w==
X-Gm-Message-State: AJIora9ydmfIDuOiQtw4RSXvyASTDwyfuOOvf8SqDcgvNDtwsEMr4n+l
        5IEQM9OAGhhbSSzK6bMipBE=
X-Google-Smtp-Source: AGRyM1u5GMnNA1gWjxyQ9e/nH6LQOA/TgocWjS8YQzdUSRxjbRLRQeuJgebt+5BMqGPUuTPOLiwSJQ==
X-Received: by 2002:a5d:48cf:0:b0:210:1229:2e7 with SMTP id p15-20020a5d48cf000000b00210122902e7mr44313567wrs.567.1657224460936;
        Thu, 07 Jul 2022 13:07:40 -0700 (PDT)
Received: from localhost.localdomain (host-79-53-109-127.retail.telecomitalia.it. [79.53.109.127])
        by smtp.gmail.com with ESMTPSA id n17-20020a05600c3b9100b0039ee391a024sm25096752wms.14.2022.07.07.13.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 13:07:39 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Tsuchiya Yuto <kitakar@gmail.com>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>
Cc:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Subject: [RESEND PATCH 2/3] staging: media: atomisp: Use kmap_local_page() in hmm_set()
Date:   Thu,  7 Jul 2022 22:07:17 +0200
Message-Id: <20220707200718.26398-3-fmdefrancesco@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220707200718.26398-1-fmdefrancesco@gmail.com>
References: <20220707200718.26398-1-fmdefrancesco@gmail.com>
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

The use of kmap() is being deprecated in favor of kmap_local_page()
where it is feasible. In file pci/hmm/hmm.c, function hmm_set() calls
kmap() / kunmap() where kmap_local_page() can instead do the mapping.

With kmap_local_page(), the mapping is per thread, CPU local and not
globally visible. Therefore, hmm_set()() is a function where the use
of kmap_local_page() in place of kmap() is correctly suited.

Convert the calls of kmap() / kunmap() to kmap_local_page() /
kunmap_local().

Tested-by: Hans de Goede <hdegoede@redhat.com>
Reviewed-by: Ira Weiny <ira.weiny@intel.com>
Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
---
 drivers/staging/media/atomisp/pci/hmm/hmm.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/media/atomisp/pci/hmm/hmm.c b/drivers/staging/media/atomisp/pci/hmm/hmm.c
index 6394385b6637..46ac082cd3f1 100644
--- a/drivers/staging/media/atomisp/pci/hmm/hmm.c
+++ b/drivers/staging/media/atomisp/pci/hmm/hmm.c
@@ -563,7 +563,7 @@ int hmm_set(ia_css_ptr virt, int c, unsigned int bytes)
 		idx = (virt - bo->start) >> PAGE_SHIFT;
 		offset = (virt - bo->start) - (idx << PAGE_SHIFT);
 
-		des = (char *)kmap(bo->page_obj[idx].page) + offset;
+		des = (char *)kmap_local_page(bo->page_obj[idx].page) + offset;
 
 		if ((bytes + offset) >= PAGE_SIZE) {
 			len = PAGE_SIZE - offset;
@@ -579,7 +579,7 @@ int hmm_set(ia_css_ptr virt, int c, unsigned int bytes)
 
 		clflush_cache_range(des, len);
 
-		kunmap(bo->page_obj[idx].page);
+		kunmap_local(des);
 	}
 
 	return 0;
-- 
2.36.1

