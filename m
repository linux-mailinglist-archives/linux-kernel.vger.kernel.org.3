Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 207D253BB44
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 16:57:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236284AbiFBO4h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 10:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236275AbiFBO43 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 10:56:29 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82DF32AD5F2
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 07:56:25 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id s12so3261746ejx.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jun 2022 07:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCSSFQ2L4JXpdmXrE1zZ/i+Swl9oJ6KcROQdZ1N3Ha8=;
        b=ITZNq6NL54WMwUJGlIfxvdXqqOqhvvCVLdmzhwDzjVYtZoXqK/cElJsPRARmEaVe3x
         n+jVzu4v3nvlV2c7IJFSYkm5LXlZzZH2ujl0FiOQ9Z9rnMLleRRdaFJDfwhCfmx/Zv8L
         XNqtFYriy+qTO3tQmgY6aqVsGhqB7Hrww9Ypy9DFg/vMxYzcXYOaSe7BcTjQbClI9Syl
         2ysK/PXoPGwVP3Ns8dIW9wZRm500ED6Jr57O8MBF/3Yzl0wY+xHa79x1ja1/6hBc8XCQ
         BFQLCWqTG0ijre9u3cVf0qTPjjUX9qpH/zObaEgGaXgO+sMB0rMDymdaGebAESww0kax
         YqHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=zCSSFQ2L4JXpdmXrE1zZ/i+Swl9oJ6KcROQdZ1N3Ha8=;
        b=fKE3u8/6r7mgfL3kbrt4vcR8AlENqvQ4OBVH/FBV8CvEpW2JttGSeqDELBHmBuoXhs
         xXGCTfEwaD7mv3Y2PO2R6xAVCk/n4NLpGx7cRMNXMJCvlL13attMApXQVzvAMpaKtXrJ
         OkgMaHX6hUB+9U7BjddogQH0UHSKNU9blFSooj6N2f1ozi+M746kwPWSLIhHRHmvyMl1
         QzNWE1rr5nC8kBLI2qk7IYUpOmdR4PMVeVS9ZNblW4MFVfbQHipiOu00tlqZZX+zk3vs
         3+7gPJYklL5Tgqq2VvJwM58qOc5Z/atcGWDpjm5QiVQM2zA965DoPTBWU6sPA8DZV/zC
         C4Og==
X-Gm-Message-State: AOAM530BetAcdeiudihbzcWPrKjZiwAUlehGHRlOxhYZU9alXXmYBbjZ
        FsuRxcizD5vK5v+0lga4bJ4=
X-Google-Smtp-Source: ABdhPJyHM+S/vrNSui5eDofEaJLcLlz5Ju+mz8n8aLIwipJ9sog0+AFkOD1upwCZfy9Aj/HP+VkkrQ==
X-Received: by 2002:a17:907:6d1f:b0:6fe:e53b:7f53 with SMTP id sa31-20020a1709076d1f00b006fee53b7f53mr4659077ejc.375.1654181783946;
        Thu, 02 Jun 2022 07:56:23 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id wj17-20020a170907051100b006fed9a0eb17sm1800254ejb.187.2022.06.02.07.56.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jun 2022 07:56:23 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 2879BA0884; Thu,  2 Jun 2022 16:56:57 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH v2 0/2] Refactor of vma_merge and new merge call
Date:   Thu,  2 Jun 2022 16:56:40 +0200
Message-Id: <20220602145642.16948-1-matenajakub@gmail.com>
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

This patch series is based on tag v5.18. This is third version,
I added a mremap expand merge test, added a comment and new variables to
the merge call and based the series on a newer kernel version.

Jakub Matěna (2):
  mm: refactor of vma_merge()
  mm: add merging after mremap resize

 mm/mmap.c   | 87 +++++++++++++++++++++++------------------------------
 mm/mremap.c |  8 +++--
 2 files changed, 43 insertions(+), 52 deletions(-)

-- 
2.35.1

