Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E527536866
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 23:16:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354715AbiE0VQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 17:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243869AbiE0VQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 17:16:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A625AE0E4
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:16:42 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id n22so3894116eda.5
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 14:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWvlDm9hhFZkrdkaC2XFt8A0sbOQiaJ6DORh+Lhw6t4=;
        b=KLVb2+ZQN7uzvUyG53PLJ4bW9v/lK1hnNTEPLTSnKJMx1XDAMsoG0gSCiA5/EK6W9g
         eJhz2DcTPyc8DQxcwPtTwMM1+LB2IpnoMiivvViaP9prQ4XJppRIPWadklHfLOmsJ89R
         kB4Owxt2t9GWzcDKbnHacxYwvdww97EIIZPyR8uqjaAQ8ftttQiK0g+ny1BtTiCd0ulD
         S/H2uuaBbaMys1eN1qkzWPITJoxe3vuUq7BagicWa+2yIOen7pZNuQ8oUFxofKYxo4vq
         2VAdMM56PnhpvVpMKR8xI84zhY0f2c/tyWkAPoCz3qMNY8uZE/F0dIJk7P/prrsWGPyt
         7dbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zWvlDm9hhFZkrdkaC2XFt8A0sbOQiaJ6DORh+Lhw6t4=;
        b=lp861Hx0wI+b34smlPQJI52PWC+R/yqEIiSZAPIZHU0FXyMA6Q9l3fyZqvIBjceYJ9
         1D84VuD5PcStgUp+sph27y+TH+1Gq9/FQtv4JMG03VRg/kfaU/xhqxsJcQP98tIzwvbj
         nhLwh7Bjc78FHOjjT+IkZywQDbpxWp86X3vfFpyUO2wkPCiQ7wvKLd0kgqb4ZgPbZr4u
         eWL/A4+/EFm95u1Jz4BkYANHjCIZFCtZgPOdrPIzT+KQnH2I7LDUcjf+LmCRyoPMURxR
         Ea23XoK4qHiDZKOqVWkugf7tH7D+M3HNIDg9nZO+dZeXf1mld/6rw7ElE1w17wE3l+TC
         TLGA==
X-Gm-Message-State: AOAM530CFHCtlkK0DFXsFLyal1SBsw6EYv3hpcczT8L7Gt/7Ld1xueAK
        wvDc73vRXNafhGw81lZTA9M=
X-Google-Smtp-Source: ABdhPJziiLWf8KmbLEe2nDi77yclj3z5r9rxzbT0FP3vuoeKGDp/Fq1qhDenHdS+uXLKORJQqvhX0A==
X-Received: by 2002:a05:6402:4c1:b0:42b:e03f:d940 with SMTP id n1-20020a05640204c100b0042be03fd940mr8746801edw.235.1653686201174;
        Fri, 27 May 2022 14:16:41 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id g18-20020a170906869200b006f3ef214df2sm1771278ejx.88.2022.05.27.14.16.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 14:16:40 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 0DF9FA0017; Fri, 27 May 2022 23:17:10 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH v2 0/2] Refactor of vma_merge and new merge call
Date:   Fri, 27 May 2022 23:17:06 +0200
Message-Id: <20220527211708.839033-1-matenajakub@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

I am currently working on my master's thesis trying to increase
number of merges of VMAs currently failing because of page offset
incompatibility and difference in their anon_vmas. The following
refactor and added merge call included in this series is just two
smaller upgrades I created along the way.

The rest of the work is still being worked on but was send to mailing
list as a RFC:
https://lore.kernel.org/all/20220516125405.1675-1-matenajakub@gmail.com/

This patch series is based on tag v5.18-rc2. This is second version,
I forgot to include one header file in the first version.

Jakub Matěna (2):
  mm: refactor of vma_merge()
  mm: add merging after mremap resize

 mm/mmap.c   | 87 +++++++++++++++++++++++------------------------------
 mm/mremap.c |  8 +++--
 2 files changed, 43 insertions(+), 52 deletions(-)

-- 
2.35.1

