Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8348957DCEB
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:52:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235147AbiGVIvL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:51:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235020AbiGVIue (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:50:34 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129943B976;
        Fri, 22 Jul 2022 01:50:34 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x24-20020a17090ab01800b001f21556cf48so7570170pjq.4;
        Fri, 22 Jul 2022 01:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=O/NbGM5kJjRqIAfAkXYggB/ERlvKPV9lzrEH17cTzVU=;
        b=eYGbdaRu+qY7Z4aDMxmm1rR81L5jtkCkJQaZdx7QGhTGL93r2kDufbITPBYwd5Crfe
         NxSRuMBOVT490FewDGGPEqIwgENUAjM/X97YMWS07PH+LPtmfQ26ffG9dyzfYqJwVM9K
         akO/5K2ALIaPUo7kWg1m32v/drNAijzlzX0dVXTKa2XYuy9fEp+WdBKqUKBzJipQO7t6
         9P6jWbFguO+jBG2jXZvCexqVNAcOgtTb4pjUo8qZ2ZW1uZpHCOkpynYdZLZF7CgcRSmp
         pddi896FJbH5H4a1iSBuD86rmG/deo2rVZ9QSTYn+2glKWmrqo6WD/YQ+N43AAW4/ddn
         gDvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=O/NbGM5kJjRqIAfAkXYggB/ERlvKPV9lzrEH17cTzVU=;
        b=Ti4pbw0HQqEp6xwbVyCM5K7xY0MkUSjefNzdhZM3MwAm/SkkXHKenvGBewrHL02gww
         VEVvdzBuGedQvlhcanYViT7WNHZrdQkALn2m8/2SFKs8iC+td63F/49Jee4MB16xkUJB
         ljfcSqNj3TAGzZMoN3tHWBM+JH0uzzLXm9AHuBpwcXMZJCZRIMygMpqD5fobAUVJlgen
         743Up6ZogQDjM8y0To4NB1BzAeHu6I72kll9kv59hYOfBrH88YLrvlkFagh1ROeyCFFV
         i685oPEke/LRP4quZ4dXlGlH0ajwUudjz/v17gxN8De3hFd/8rG2+g8scas98vVGj8fl
         rkeA==
X-Gm-Message-State: AJIora8Z8zq+GrU2s8dBiqJltiz3E8bKZ2zH3WXLA4OUcH/1p9GFCmdj
        kwYONgrLHTsFEV3qIwJd+3c=
X-Google-Smtp-Source: AGRyM1us+umJEjBCkMBqnMpr40e1Me6PRIvRqhajmFBdp63TFBVGRUSKkpQ4eMjvrgszDgGHqGo7Xg==
X-Received: by 2002:a17:902:7612:b0:16d:2dbe:26f2 with SMTP id k18-20020a170902761200b0016d2dbe26f2mr2609786pll.94.1658479833470;
        Fri, 22 Jul 2022 01:50:33 -0700 (PDT)
Received: from debian.me (subs03-180-214-233-91.three.co.id. [180.214.233.91])
        by smtp.gmail.com with ESMTPSA id e6-20020a17090301c600b0016cdefd5e95sm3040341plh.8.2022.07.22.01.50.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Jul 2022 01:50:32 -0700 (PDT)
Received: by debian.me (Postfix, from userid 1000)
        id B3539104981; Fri, 22 Jul 2022 15:50:23 +0700 (WIB)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     linux-doc@vger.kernel.org
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Halil Pasic <pasic@linux.ibm.com>,
        Tony Krowiak <akrowiak@linux.ibm.com>,
        Jason Herne <jjherne@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 6/8] Documentation: s390: escape *kvm->arch.crypto.pqap_hook pointer inside inline code
Date:   Fri, 22 Jul 2022 15:49:45 +0700
Message-Id: <20220722084946.22965-7-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220722084946.22965-1-bagasdotme@gmail.com>
References: <20220722084946.22965-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The *kvm->arch.crypto.pqap_hook pointer triggers inline emphasis
warning, due to unescaped asterisk. Escape it into inline code.

Link: https://lore.kernel.org/linux-next/20220721201058.2a276286@canb.auug.org.au/
Fixes: e32d3827f3d5b2 ("s390/Docs: new doc describing lock usage by the vfio_ap device driver")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/s390/vfio-ap-locking.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/s390/vfio-ap-locking.rst b/Documentation/s390/vfio-ap-locking.rst
index 4194b78ace0e94..cfbb661ea72e63 100644
--- a/Documentation/s390/vfio-ap-locking.rst
+++ b/Documentation/s390/vfio-ap-locking.rst
@@ -107,7 +107,7 @@ The PQAP Hook Lock (arch/s390/include/asm/kvm_host.h)
    };
 
 The PQAP Hook Lock is a r/w semaphore that controls access to the function
-pointer of the handler (*kvm->arch.crypto.pqap_hook) to invoke when the
+pointer of the handler (``*kvm->arch.crypto.pqap_hook``) to invoke when the
 PQAP(AQIC) instruction sub-function is intercepted by the host. The lock must be
 held in write mode when pqap_hook value is set, and in read mode when the
 pqap_hook function is called.
-- 
An old man doll... just what I always wanted! - Clara

