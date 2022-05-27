Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70A3A535EA3
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 12:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345991AbiE0Krz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 06:47:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239766AbiE0Krw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 06:47:52 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D1A16549
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:47:51 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id v15so2480864edl.9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 03:47:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fT1it2KZU2gPXkEvlWdCKHS58rx52JxhTKoYGvWFsI=;
        b=RRHjbEWLo2//B4DPzz6ni5o3BsNnS6apiG3aXTQnDHlIWIIzK1KijymcswiWzlHFtY
         f4mkpH7cLheY6r/TX6hJMUhSaomWTESb3RUoKXH78dVbYDcmz3byk7MprwemE3lMoHSW
         wUK8bcIJJz2Bz+wUoLKwSwowL5/Xky9sXpdWuaXefgSn90q6kXSIt12TUok6I4kXq8fD
         IYrnZbMGB2z/eoeNFjIU+Rp07MPbWuCQpNtw+/QZHXQl3HVcKre9Qsw+Itnwwu3Zx7ge
         +D41kdUtz7/9UjllTAR1Z+MUwIwRF9gRjD2uxegnYRu+HC+WtUnOj5wkl/Sn33XOCida
         +Qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=/fT1it2KZU2gPXkEvlWdCKHS58rx52JxhTKoYGvWFsI=;
        b=jMLh13Nv0D+cwokfbTZJ1lqK6A2WjB7SlCWeSyk2y2Z+LUplgL0F1Pf1YfmV/IIjGf
         lmPlrm9Z1z8rXxGvoZbNU8dLPbXLYUqioYMJuIghJx5tOpRi7KB1vrTXifDX4ikgpEgw
         nza+SYth2F3LNmloTeYQdNiW8gaXAYUSTAaljZSMuNV1u7gbaJdxEW/wwNzfDBO5KBGb
         f6fEBuLFSV7NogizUlg1nmbp0BSF77Rx8DwAQ+KT3+9E2PlwANXMD1juQXsM9BpoFlJc
         FT05xdYt1jpzldpoNDhLk0tO8xNl0cncbnwbLcfatYyNzEwt/0IPVr4+wqHLKYaTTZQj
         7eig==
X-Gm-Message-State: AOAM530un/eCrMf9mJvV5HVu+YwpkfSH3zB3Bv2/JxpBxTnJk17hC8BC
        xkhkIwYY3b/1COt49z3P6lrB0sOCf2/BovB0
X-Google-Smtp-Source: ABdhPJwd8nCaOgRfb6mdXbAKJwYlhIYmPv5Kq25qkC6wi7PtkgjVQe2mNDQE+tW1St0c5Vc6Lsh7gQ==
X-Received: by 2002:a05:6402:4392:b0:42b:612:b275 with SMTP id o18-20020a056402439200b0042b0612b275mr41609136edc.288.1653648470130;
        Fri, 27 May 2022 03:47:50 -0700 (PDT)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id c13-20020a50d64d000000b0042617ba63cfsm1926153edj.89.2022.05.27.03.47.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 May 2022 03:47:49 -0700 (PDT)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 4BD67A028F; Fri, 27 May 2022 12:48:18 +0200 (CEST)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, vbabka@suse.cz, mhocko@kernel.org,
        mgorman@techsingularity.net, willy@infradead.org,
        liam.howlett@oracle.com, hughd@google.com, kirill@shutemov.name,
        riel@surriel.com, rostedt@goodmis.org, peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [PATCH 0/2] Refactor of vma_merge and new merge call
Date:   Fri, 27 May 2022 12:48:08 +0200
Message-Id: <20220527104810.24736-1-matenajakub@gmail.com>
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

This patch series is based on tag v5.18-rc2.

Jakub Matěna (2):
  mm: refactor of vma_merge()
  mm: add merging after mremap resize

 mm/mmap.c   | 87 +++++++++++++++++++++++------------------------------
 mm/mremap.c |  8 +++--
 2 files changed, 43 insertions(+), 52 deletions(-)

-- 
2.35.1

