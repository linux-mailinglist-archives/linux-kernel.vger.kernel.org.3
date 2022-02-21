Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D16444BE29F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 18:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355793AbiBULRU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 06:17:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355928AbiBULPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 06:15:18 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A524F203
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:53:56 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id y11so8453583pfi.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 02:53:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTRDHofTdwvUN9zQVLPcmnC4B3N1IwwGzil1DZn2MNI=;
        b=bRYbJHdnzUV20447VYiF1k5Sw/qcQcjBivjcQlGrEo94ptSXAqYCjqYLASx2RXXns3
         y3GUiq3IiatAn5p/dngQk7o6MuV0lF+mfBqwbh354gpU+6K1Hc90MZJRHb8RQuRZMfCh
         GDhV3H36Kk4qJknPHX8IODppZ3imiwYdOSFICVBQkXFI2imypb5c8WP9v9M4+Bb+Gaae
         T3ZVRowvS3ew4oJKJCvhSIOd66LDw7rFfMSqOOp4UOZ6XVboK5EHiCMTGuScaUlagmdY
         ps3M9UH0AHGJYutmQPq//AQX8yWKQXdHN5GOxnW/MxnRTO3bERRBmMIW9w+1gSsEgQ0F
         SQxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YTRDHofTdwvUN9zQVLPcmnC4B3N1IwwGzil1DZn2MNI=;
        b=xsKA1cu9d4q7ZzWo1+Wsnv/Q7pZOarUH7Qdsu+eteu/QHnUq4o2m2omvoMLM1G4RBV
         BJb7b0p7FJhYDet1hCVgl4/fFTIs6ZXZgkTqihaOThOT5zJFang9QX/JfGiDTgwDwpYX
         NsJuUTYU1grjr5ct0z6jPhxBhQ9uGyPG1dDldX4LdN828h9ukEpa3McA/89ST/HAuOVd
         motRsVXnYbdzMXOrJ5/+QMNoyRwm4nG8iZwyNwAcbWBSaKxa5poWP7isUlFz8p5uPJaX
         qm6HDB9ObW4clgy7+iYfmPkLJF27+yNXCBS3/fxSuyeXP0ZTt7eZsc0NoKzyneOFUrbj
         qczQ==
X-Gm-Message-State: AOAM532DbkKbz1KGb9/1CBLbcArQf5HBvp+1a1Rh3rqliGeRlf6xqX09
        +6HywX6mnHCmgu2YWzYiPJZA8xi0uHlKPA==
X-Google-Smtp-Source: ABdhPJzo4VPD1mPjBCuDtv/jkPosY4cRii2Au2fYlSlF4qUX8rgY0oOqjASCIIYfCloE6AGV8Y2H9A==
X-Received: by 2002:a63:e747:0:b0:372:c757:c569 with SMTP id j7-20020a63e747000000b00372c757c569mr15625292pgk.516.1645440836142;
        Mon, 21 Feb 2022 02:53:56 -0800 (PST)
Received: from ip-172-31-19-208.ap-northeast-1.compute.internal (ec2-18-181-137-102.ap-northeast-1.compute.amazonaws.com. [18.181.137.102])
        by smtp.gmail.com with ESMTPSA id u6sm2214725pfk.203.2022.02.21.02.53.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Feb 2022 02:53:55 -0800 (PST)
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     linux-mm@kvack.org
Cc:     Roman Gushchin <guro@fb.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        David Rientjes <rientjes@google.com>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        Hyeonggon Yoo <42.hyeyoo@gmail.com>
Subject: [PATCH 0/5] slab cleanups
Date:   Mon, 21 Feb 2022 10:53:31 +0000
Message-Id: <20220221105336.522086-1-42.hyeyoo@gmail.com>
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

Hi. These are cleanup patches of slab. Please consider them for slab-next :)
Correctness of locking for patch 5 is checked using lockdep.

Hyeonggon Yoo (5):
  mm/sl[au]b: Unify __ksize()
  mm/sl[auo]b: Do not export __ksize()
  mm/slab: Do not call kmalloc_large() for unsupported size
  mm/slub: Limit min_partial only in cache creation
  mm/slub: Refactor deactivate_slab()

 include/linux/slab.h |  23 +++++++---
 mm/slab.c            |  23 ----------
 mm/slab_common.c     |  28 ++++++++++++
 mm/slob.c            |   1 -
 mm/slub.c            | 101 +++++++++++++++++--------------------------
 5 files changed, 84 insertions(+), 92 deletions(-)

-- 
2.33.1

