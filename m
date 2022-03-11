Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6A54D67F8
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 18:46:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350901AbiCKRrW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 12:47:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244920AbiCKRrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 12:47:09 -0500
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com [IPv6:2a00:1450:4864:20::632])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0761E11EF01
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:05 -0800 (PST)
Received: by mail-ej1-x632.google.com with SMTP id bi12so20729492ejb.3
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 09:46:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qT0C/6DOfDnLQQ9CEAOqIUTYmrrNFB0d3Kmyk6GQhvw=;
        b=puPhQxXfJGzYH+7ST3DhcePE8oIDJfjvn0ssWGRr4GYIShmkKrJxfcsQdxOp+9l7Ya
         7Ith4Fyu5wlKOAxHpwaPqM3/37xQ/JhNRyJFbFnIJi2YslfOiDy+MywVwF4YqXJ+VCXk
         iROpqXuI4rSl26OZ8JD3EJiRT9FWa/MzpKPoiubRY6OXHIoqVbFQBEruAo3VdWxusVnq
         jtj8mSbn9stUuR+Y5D/NQxRQbabfTtOrBl3wNgb4VjMrediwPpXVhiLE9QrGS1683stL
         +LZw6cHaxMBjqh7aJT1SbrKmFq8wedns2JNjYY7/8qH6bayXhdkeiBgydMRT22dx3iEW
         r0iQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=qT0C/6DOfDnLQQ9CEAOqIUTYmrrNFB0d3Kmyk6GQhvw=;
        b=P/5Nmu9c9E6NCfBzwIMQnFdXInsoQ4XkQUTScctx07Y4VeGcCSrqjYRiqY40iNHmZr
         QFolq5WSry1DNYCD+H1mdeqPDuoGVunYvxduropLMIULOzTyqZ/FBCm4mrLUTeh3Pcwa
         D4HjZjKdiY2cuV0crq/+H1Grj0h6pEoAEYiqmsAmuTWrWwvOy9D8zWAoP1u89o0YdoSc
         AzCCAYIwOljjOnBexK9UsdeLu5jfrktz0CI2/HBf8TV9uyUtOVewmhAf+tEGgHB9WU8n
         Ygfz2GSF8eTz7s5VeVm43Pc/pUH7QHX+I+ZD42rZTozrPE65EuhB2g7saa1T646h3baA
         ODbg==
X-Gm-Message-State: AOAM532aAJA157iYORtXUEWk6N5nO8PS0WTjQzH1hba4dEJFpGIbGlnw
        UL7UGMOIQPAwxZZVfXztZfE=
X-Google-Smtp-Source: ABdhPJwy3DVt+jNjoeR35CJN/CVq8mdmJ861/fihAeEdk6RNpPFcZ/1vHGbwOzp8mZtMqTe0SYYmVw==
X-Received: by 2002:a17:906:2899:b0:6d6:e479:1fe2 with SMTP id o25-20020a170906289900b006d6e4791fe2mr9671565ejd.394.1647020763499;
        Fri, 11 Mar 2022 09:46:03 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id qb30-20020a1709077e9e00b006d6f8c77695sm3188187ejc.101.2022.03.11.09.46.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Mar 2022 09:46:01 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 7F7A1A00BB; Fri, 11 Mar 2022 18:46:03 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH v2 0/4] Removing limitations of merging anonymous VMAs
Date:   Fri, 11 Mar 2022 18:45:58 +0100
Message-Id: <20220311174602.288010-1-matenajakub@gmail.com>
X-Mailer: git-send-email 2.34.1
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

Motivation
In the current kernel it is impossible to merge two anonymous VMAs
if one of them was moved. That is because VMA's page offset is
set according to the virtual address where it was created and in
order to merge two VMAs page offsets need to follow up.
Another problem when merging two VMA's is their anon_vma. In
current kernel these anon_vmas have to be the one and the same.
Otherwise merge is again not allowed.
There are several places from which vma_merge() is called and therefore
several use cases that might profit from this upgrade. These include
mmap (that fills a hole between two VMAs), mremap (that moves VMA next
to another one or again perfectly fills a hole), mprotect (that modifies
protection and allows merging with a neighbor) and brk (that expands VMA
so that it is adjacent to a neighbor).
Missed merge opportunities increase the number of VMAs of a process
and in some cases can cause problems when a max count is reached.

Solution
Following series of these patches solves the first problem with
page offsets by updating them when the VMA is moved to a
different virtual address (patch 2). As for the second
problem merging of VMAs with different anon_vma is allowed
(patch 3). Patch 1 refactors function vma_merge and
makes it easier to understand and also allows relatively
seamless tracing of successful merges introduced by the patch 4.

Limitations
For both problems solution works only for VMAs that do not share
physical pages with other processes (usually child or parent
processes). This is checked by looking at anon_vma of the respective
VMA. The reason why it is not possible or at least not easy to
accomplish is that each physical page has a pointer to anon_vma and
page offset. And when this physical page is shared we cannot simply
change these parameters without affecting all of the VMAs mapping
this physical page. Good thing is that this case amounts only for
about 1-3% of all merges (measured on jemalloc (0%), redis (2.7%) and
kcbench (1.2%) tests) that fail to merge in the current kernel.
Measuring also shows slight increase in running time, jemalloc (0.3%),
redis (1%), kcbench (1%). More extensive data can be viewed at
https://home.alabanda.cz/share/results.png

This series of patches and documentation of the related code will
be part of my master's thesis.
This patch series is based on tag v5.17-rc4. This is a second version
including minor changes that arose from the first RFC like formatting.
Speed and failed merge percentage data are also included.

Jakub Matěna (4):
  mm: refactor of vma_merge()
  mm: adjust page offset in mremap
  mm: enable merging of VMAs with different anon_vmas
  mm: add tracing for VMA merges

 include/linux/rmap.h        |  17 ++-
 include/trace/events/mmap.h |  83 +++++++++++++++
 mm/internal.h               |  12 +++
 mm/mmap.c                   | 206 ++++++++++++++++++++++++------------
 mm/rmap.c                   |  77 ++++++++++++++
 5 files changed, 325 insertions(+), 70 deletions(-)

-- 
2.34.1

