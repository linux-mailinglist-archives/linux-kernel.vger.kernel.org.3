Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E4CB5690E6
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 19:43:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234115AbiGFRn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 13:43:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234156AbiGFRnQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 13:43:16 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FC732AE0B;
        Wed,  6 Jul 2022 10:43:08 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id p11so11565559qkg.12;
        Wed, 06 Jul 2022 10:43:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RTX+2ZmhNLKv9X3CqjJGf6dksV/0DVIM74S01uC3qWA=;
        b=UqIyAfWAmZmjeU+EenLlPE0VmOtNlBXkBvRtQFrmqf8vibXabUa6dSf+8yGO0vHnKp
         KDVdg7apxQvX4d1b8Ws9MgOGuWWx8V/RiOVVlGerPweObz2WTWdlCIU0lScSj3Z/zWed
         q86ogK3mNR3AWuWOAsbWQ/bfhMEX3ZWqlFhL1Cj1RyXz064GT0JeUAYIvGOqpnRpqwgI
         sL0MyAgDqQorU98niV7Gl6c5Yflqp4eoXbBJ3F21nx5ktSlXFQyJD430kkNgeoYhfc9N
         XW/wra8Tu8vQbBtgs3K5c+Mp9Xr+d8y5EozH1/A69cPUbirDxHP4lfMr/YOp/uIZVUgG
         oCqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RTX+2ZmhNLKv9X3CqjJGf6dksV/0DVIM74S01uC3qWA=;
        b=5SUtGyoDleKWR1sHq4FJnE3f9+hhyBOyzs55jgwLXs6tEi7ysMLCRnU1rqR+mDroTP
         DnrafOc2cQseHO8T9uekT222vMHvdCfyE0BgfSiDzr2pLRdlmAHMjvMX+dOwVz0Nbxh2
         +T4kpCV+rvgTy3No33KtU2Puh9a7PUMrb1pQFrDGTm+3I8q2zw3yzTLVk+cKxKor9sTU
         De0Ln4FEEld8jRCsPIIxt0v46uwbinZoBT29jyzsPDrXW+ydZDyE87mmmtYu7B78Ebhw
         C33MkCbd+jEur4AmCvRmIc5xax9xKypF75hTgE/J6iL4JBes6aGrcaha3soq5Oc1IqTi
         /snQ==
X-Gm-Message-State: AJIora/ioIo9Vpue6eLjqV+SXA8Tm2JjvjoZWoI6D17Ka2zmqBzSNNLx
        g1qR3Ug9qciTZUCoo2vgWyNvc6XiQ3GQ7g==
X-Google-Smtp-Source: AGRyM1tpnu+LAuLYoIyI9/LCG9g4Hwiof2ASLOuavcg0x5s9g9u1zNCfiYJuBjjfPsO8eZ6Udpuckg==
X-Received: by 2002:a05:620a:1206:b0:6b5:1758:de95 with SMTP id u6-20020a05620a120600b006b51758de95mr2855134qkj.100.1657129387265;
        Wed, 06 Jul 2022 10:43:07 -0700 (PDT)
Received: from localhost (c-69-254-185-160.hsd1.ar.comcast.net. [69.254.185.160])
        by smtp.gmail.com with ESMTPSA id f10-20020a05620a280a00b006a69d7f390csm30803845qkp.103.2022.07.06.10.43.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Jul 2022 10:43:06 -0700 (PDT)
From:   Yury Norov <yury.norov@gmail.com>
To:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        David Howells <dhowells@redhat.com>,
        Ingo Molnar <mingo@kernel.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        NeilBrown <neilb@suse.de>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Russell King <linux@armlinux.org.uk>,
        Vlastimil Babka <vbabka@suse.cz>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mm@kvack.org
Cc:     Yury Norov <yury.norov@gmail.com>
Subject: [PATCH 09/10] headers/deps: mm: align MANITAINERS and Docs with new gfp.h structure
Date:   Wed,  6 Jul 2022 10:42:52 -0700
Message-Id: <20220706174253.4175492-10-yury.norov@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220706174253.4175492-1-yury.norov@gmail.com>
References: <20220706174253.4175492-1-yury.norov@gmail.com>
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

After moving gfp types out of gfp.h, we have to align MAINTAINERS
and Docs, to avoid warnings like this:

>> include/linux/gfp.h:1: warning: 'Page mobility and placement hints' not found
>> include/linux/gfp.h:1: warning: 'Watermark modifiers' not found
>> include/linux/gfp.h:1: warning: 'Reclaim modifiers' not found
>> include/linux/gfp.h:1: warning: 'Useful GFP flag combinations' not found

Signed-off-by: Yury Norov <yury.norov@gmail.com>
---
 Documentation/core-api/mm-api.rst | 8 ++++----
 MAINTAINERS                       | 1 +
 2 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/Documentation/core-api/mm-api.rst b/Documentation/core-api/mm-api.rst
index f5b2f92822c8..1ebcc6c3fafe 100644
--- a/Documentation/core-api/mm-api.rst
+++ b/Documentation/core-api/mm-api.rst
@@ -22,16 +22,16 @@ Memory Allocation Controls
 .. kernel-doc:: include/linux/gfp.h
    :internal:
 
-.. kernel-doc:: include/linux/gfp.h
+.. kernel-doc:: include/linux/gfp_types.h
    :doc: Page mobility and placement hints
 
-.. kernel-doc:: include/linux/gfp.h
+.. kernel-doc:: include/linux/gfp_types.h
    :doc: Watermark modifiers
 
-.. kernel-doc:: include/linux/gfp.h
+.. kernel-doc:: include/linux/gfp_types.h
    :doc: Reclaim modifiers
 
-.. kernel-doc:: include/linux/gfp.h
+.. kernel-doc:: include/linux/gfp_types.h
    :doc: Useful GFP flag combinations
 
 The Slab Cache
diff --git a/MAINTAINERS b/MAINTAINERS
index 3cf9842d9233..7c0b8f28aa25 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -12850,6 +12850,7 @@ T:	quilt https://ozlabs.org/~akpm/mmotm/
 T:	quilt https://ozlabs.org/~akpm/mmots/
 T:	git git://github.com/hnaz/linux-mm.git
 F:	include/linux/gfp.h
+F:	include/linux/gfp_types.h
 F:	include/linux/memory_hotplug.h
 F:	include/linux/mm.h
 F:	include/linux/mmzone.h
-- 
2.34.1

