Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37BD34CCDDD
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238487AbiCDGgW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:36:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238473AbiCDGgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:36:02 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 289F518CC6A
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:34:42 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id m11-20020a17090a7f8b00b001beef6143a8so7164250pjl.4
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 22:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuM45wFUuSIisY95WP5NVnJXEE51k6K/a85cWiasSdw=;
        b=NZ/9T02L0QWzrbvkMunxnYe5K8qOFLdxTBfpDLND24BMIi7xVj587ooULQE5HJGOGU
         R6b5K7twFUOCHG1qBR0nFtV79M6EP8g1/6bPJCC7DjRYbT90k7AicaJ/FUqAWPJhIWbg
         PGW7x9hkYDZ2FDwXAzuwSJWI2501Va1SUy5u69+FhhjBRnHzxz1yy8FMIyrfNcL+yH0f
         Gl3DiKyWyHqATXKTdCm2D+5KwY8Bo3bYUsTILW0A0K0mAWeccsWiHXU2aB2w7FdIeuT1
         1DPfKZAUfDrBmxvHtdYkgM+Zrbks45rCUopCd8igu4RdbAJbxTPRbv5aRMqNDwtVtGlW
         GLfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nuM45wFUuSIisY95WP5NVnJXEE51k6K/a85cWiasSdw=;
        b=PakpS2wXaOP8KUi6h2favJRHiefH+Ew3eUvbLiUmoBcaKcOZ62tpyznODd22yRKWvq
         hBdH016aRz25YYsKIB8NPv/nkeAc4XFtp6olcjLvHHHHxMNr25PK6+Rs6eT7bsWXUYC0
         WcbEBnzoHy/rnaYnijZSOBWVWzjFGv/VGVHfVcp5PpMTf9ZIsVqJXt/M6wwLv8WsBH8q
         r3qnH4fz6+Qru8eKFF3ZYtDaXbDseGkFeJOu2c7ellEYfvyWZIPFrQZw92xJtNjs42h0
         BZ78s6B/aUG8B2v1qRKvvr+REGgFwu5zsp4fL6fEItnRRKIRxZjAU9bjp4yWARo1nukX
         bzEQ==
X-Gm-Message-State: AOAM533pc/7l7VGUPoGioYHXoAokSza2oG9+GEVKJna0NgrlfEca7bK/
        AFGlZifXaqy4/m2Xs+i/ovE=
X-Google-Smtp-Source: ABdhPJwXcDCE0jyhsOvhdlUoH2suq06HPWnLwccFgZkKB2BI+sktLAq5gWxbGrH+hxa83CfdP/1psg==
X-Received: by 2002:a17:902:ecc3:b0:151:c36f:d94c with SMTP id a3-20020a170902ecc300b00151c36fd94cmr44705plh.79.1646375681656;
        Thu, 03 Mar 2022 22:34:41 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id v10-20020a056a00148a00b004e0f420dd90sm4900007pfu.40.2022.03.03.22.34.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 22:34:41 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org, 42.hyeyoo@gmail.com
Subject: [PATCH v2 0/5] slab cleanups
Date:   Fri,  4 Mar 2022 06:34:22 +0000
Message-Id: <20220304063427.372145-1-42.hyeyoo@gmail.com>
X-Mailer: git-send-email 2.33.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Changes from v1:
	Now SLAB passes requests larger than order-1 page
	to page allocator.

	Adjusted comments from Matthew, Vlastimil, Rientjes.
	Thank you for feedback!

	BTW, I have no idea what __ksize() should return when an object that
	is not allocated from slab is passed. both 0 and folio_size()
	seems wrong to me.

Hello, these are cleanup patches for slab.
Please consider them for slab-next :)

Any comments will be appreciated.
Thanks.

Hyeonggon Yoo (5):
  mm/slab: kmalloc: pass requests larger than order-1 page to page
    allocator
  mm/sl[au]b: unify __ksize()
  mm/sl[auo]b: move definition of __ksize() to mm/slab.h
  mm/slub: limit number of node partial slabs only in cache creation
  mm/slub: refactor deactivate_slab()

 include/linux/slab.h |  36 ++++++------
 mm/slab.c            |  51 ++++++++---------
 mm/slab.h            |  21 +++++++
 mm/slab_common.c     |  20 +++++++
 mm/slob.c            |   1 -
 mm/slub.c            | 130 ++++++++++++-------------------------------
 6 files changed, 114 insertions(+), 145 deletions(-)

-- 
2.33.1

