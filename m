Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B64511A5A
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 16:56:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235144AbiD0NBi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 09:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235076AbiD0NBg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 09:01:36 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B26162C66DC;
        Wed, 27 Apr 2022 05:58:25 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id q8so1479486plx.3;
        Wed, 27 Apr 2022 05:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=pNSvpo4QWccajCxpCePsKswiAx+NwxjUiJYzt3ZtdWM=;
        b=LwKplNmSEkTQw+JSbpj2IRAvZCw4yjHl0sNVCER90ey7S5JduVpQGaq3gqEJJmGKCX
         rKO5kGl6CPh/vl4R/ct9NXqi0VCqTHcrHZ75Bex3FRTyrL+wBhzUcdLPUapjp6Vj0dJI
         eu7H9Dne6xdgDeaFPEZoxiPwh7EDZOy7qbqItfaIusxGxUJe7PFY6uGtthIXR8mFqlyh
         EoAZgaUUyBorfCwaVunuur1sdygci5KQPIoeGahM7zGRyO6pvx5jvVxW42VWD6BIGRLj
         cug4b31+uso0kHBoy/DGWTLiTKv0+UGgkJMmW6mb3qXSN60T8yrHrOFK1SZE3MLYlRHw
         8p4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=pNSvpo4QWccajCxpCePsKswiAx+NwxjUiJYzt3ZtdWM=;
        b=0aY1z4D5asa9MNdIKi8jOMUzDFOw70qUC3QxwaKG+FDvQR6m/RFts4vByEQhy7v0KE
         L+nr0CvtgyZPWG5BgVfzhDag9XJ2Y1nPvcyyBV04RSw6DRsj3kOpMAP3y5p2vCRDhcS4
         IbZfirfPw1sW4fCoM3f9qzuHCOV+zonTVTx9WTmmr1GUtI57gfZY2P7XyVzAR8a9iX9G
         aakIIQrgWjmwEWksnTGFbvRE5VU9ly36471DEU3NBM+bopzgen1bACPUuFPE+Pk2+xy0
         idNq1LK5IONhOCYaN6sTX4tjI4o86HhXr2d0JCE2auYoNXE5aswa0sFl0mcQUrzQ32v2
         XmpQ==
X-Gm-Message-State: AOAM533+nGaCtVwYtT2SOc5crNQ1kXCd5CcO5XlI55Ibr/7DSFHw3giC
        qdKNAjVx+rIKnVX7yJ1lFr/Yvd5hNAI=
X-Google-Smtp-Source: ABdhPJyUhXYVhzQ9HdukUIH8Lt76iARMHSOhLknwOZsTL0InvkauM1X0tJqq/PFsjaKHfO1cIAnQLw==
X-Received: by 2002:a17:902:edd0:b0:15c:6f65:d06b with SMTP id q16-20020a170902edd000b0015c6f65d06bmr25432406plk.91.1651064305209;
        Wed, 27 Apr 2022 05:58:25 -0700 (PDT)
Received: from [192.168.11.5] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id 123-20020a620681000000b004fa7c20d732sm18502417pfg.133.2022.04.27.05.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 05:58:24 -0700 (PDT)
Message-ID: <cfd3bcc0-b51d-0c68-c065-ca1c4c202447@gmail.com>
Date:   Wed, 27 Apr 2022 21:58:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: en-US
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Shenghong Han <hanshenghong2019@email.szu.edu.cn>,
        Haowen Bai <baihaowen@meizu.com>,
        Jonathan Corbet <corbet@lwn.net>, Alex Shi <seakeel@gmail.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
From:   Akira Yokosawa <akiyks@gmail.com>
Subject: [PATCH] docs: vm/page_owner: Use literal blocks for param description
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [PATCH] docs: vm/page_owner: Use literal blocks for param description

Sphinx generates hard-to-read lists of parameters at the bottom
of the page.  Fix them by putting literal-block markers of "::"
in front of them.

Signed-off-by: Akira Yokosawa <akiyks@gmail.com>
Fixes: 57f2b54a9379 ("Documentation/vm/page_owner.rst: update the documentation")
Cc: Shenghong Han <hanshenghong2019@email.szu.edu.cn>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Haowen Bai <baihaowen@meizu.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Alex Shi <seakeel@gmail.com>
---
Hello Andrew,

This is the first time I send a patch in your way.
So I'm not sure this works as I intend.
If anything goes wrong, please let me know.

This issue is in discussion in a linux-doc thread triggered by
a post from Haowen Bai [1]. (Warning: The thread looks confused
due to Haowen's unnecessary uses of In-Reply-To: headers.)
Jon suggested the route via your tree, but he keeps posting
to linux-doc.

[1]: https://lore.kernel.org/all/1650424016-7225-3-git-send-email-baihaowen@meizu.com/

Haowen's patch uses tables to improve the look of param lists.
I suggested him using literal blocks instead, but I failed to
hear any response. So I'm sending my version of the fix in your
way.

I believe this fix is worth for 5.18-rcX.

Side note 1: I see another patch queued for -next around here, which
has broken indents by white spaces.  You might want to fix or drop it.

Side note 2: page_owner.rst is not covered in MAINTAINERS.
You might want to add an entry, maybe, under "PAGE TABLE CHECK".

Again, if there is anything I can do better, please let me know.

Best,

        Akira
--
 Documentation/vm/page_owner.rst | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/Documentation/vm/page_owner.rst b/Documentation/vm/page_owner.rst
index 65204d7f004f..7e0c3f574e78 100644
--- a/Documentation/vm/page_owner.rst
+++ b/Documentation/vm/page_owner.rst
@@ -110,7 +110,7 @@ Usage
    If you want to sort by the page nums of buf, use the ``-m`` parameter.
    The detailed parameters are:
 
-   fundamental function:
+   fundamental function::
 
 	Sort:
 		-a		Sort by memory allocation time.
@@ -122,7 +122,7 @@ Usage
 		-s		Sort by stack trace.
 		-t		Sort by times (default).
 
-   additional function:
+   additional function::
 
 	Cull:
 		--cull <rules>
@@ -153,6 +153,7 @@ Usage
 
 STANDARD FORMAT SPECIFIERS
 ==========================
+::
 
 	KEY		LONG		DESCRIPTION
 	p		pid		process ID

base-commit: af2d861d4cd2a4da5137f795ee3509e6f944a25b
-- 
2.25.1

