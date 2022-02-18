Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C76D94BB905
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235121AbiBRMV5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:21:57 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbiBRMVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:21:55 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25C3112611
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:21:37 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id d10so14576267eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:21:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5rQzjNg8Ap+TS+qAAa9J5nP4Ln9L010vxP8ZND8mL8=;
        b=SlcyPV6fRqQE37dwD/3Ug5PkcCWk/QIRC0yLI5ldBfuW5Er1/gmMT68lmvmZ7W/FIz
         r7xX3k+akhQTVz9JsjxIeTRIBdy1Rv5aaoHc27bEehLSidk0J1V0aFhMVN8+05DYY493
         ML/Avjfy8ZcJ3l8p3viy9bahc4zxsaqOoH6HBNM4mMaYlke+fPxvRlYjHCmM1EUGh3Lx
         2Gak6M1R/TyqLTX56A/eZaEmWSm4zCS/RGEgDEt6v9UtgoWi7BClB2vx5k+0/OhxKqzQ
         3y1xYqmPUmOHyNkaI3vqvi99+79P5hIPd7z3i3NsonKltM0wn6uQADlGuEvr0MsD+rLE
         7/pA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=v5rQzjNg8Ap+TS+qAAa9J5nP4Ln9L010vxP8ZND8mL8=;
        b=NanBtqJNitlq4R5HzlaOaj89ZUUWWp653d4d7pazFMYhBXsnKtAFlx8xRYjfAHIKFT
         z4RDW3xdd7TVZRxCkqBg1IcknkpsiIUZYAH8LYUjAgd0K1GUEhQdTpZhJyMlL/hROVBn
         gGWELycHHck3bYqtZMzt5yg3U2ISAYzeE78gbB+FaRnlCLX4k3dbFUdtGHwsjVJfpqD9
         rnC4mDK6Ll1AGeNE4nfvvL6+6g+tefi6rHSZQrwlhr6Gk87OzTlo5xO8EDF2Tdh2oVs4
         66M2OamNGYfnBNpNlKYmU+8wAGSpEZV44Svnl9yG9faWo8RS9ktMD7tbBOTg0Ho3bXfW
         ceJg==
X-Gm-Message-State: AOAM533SZIDvtUNhwD1aEZ/NcMFMLpjJtm9+smz2bN8sOOXHL+MzLpmA
        1AW0IfMSec9azXc0j+30eMQ=
X-Google-Smtp-Source: ABdhPJzRD6rM2ZQbk4rIHyrLtPG9qB3m1IsriUMAxeKe1dWPNLAZsRH6kjeCmrFjxDTkzvm+e2LA7g==
X-Received: by 2002:a17:906:1393:b0:6ba:dfb1:4435 with SMTP id f19-20020a170906139300b006badfb14435mr6482685ejc.736.1645186895695;
        Fri, 18 Feb 2022 04:21:35 -0800 (PST)
Received: from orion.localdomain ([93.99.228.15])
        by smtp.gmail.com with ESMTPSA id j11sm3228750eda.106.2022.02.18.04.21.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Feb 2022 04:21:35 -0800 (PST)
Received: by orion.localdomain (Postfix, from userid 1003)
        id 41487A7FEF; Fri, 18 Feb 2022 13:20:44 +0100 (CET)
From:   =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
To:     linux-mm@kvack.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        vbabka@suse.cz, mhocko@kernel.org, mgorman@techsingularity.net,
        willy@infradead.org, liam.howlett@oracle.com, hughd@google.com,
        kirill@shutemov.name, riel@surriel.com, rostedt@goodmis.org,
        peterz@infradead.org,
        =?UTF-8?q?Jakub=20Mat=C4=9Bna?= <matenajakub@gmail.com>
Subject: [RFC PATCH 0/4] Removing limitations of merging anonymous VMAs
Date:   Fri, 18 Feb 2022 13:20:15 +0100
Message-Id: <20220218122019.130274-1-matenajakub@gmail.com>
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
order to merge two VMA's page offsets need to follow up.
Another problem when merging two VMA's is their anon_vma. In
current kernel these anon_vmas have to be the one and the same.
Otherwise merge is again not allowed.
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
about 1-3% of all merges (measured for internet browsing and
compilation use cases) that fail to merge in the current kernel.

This series of patches and documentation of the related code will
be part of my master's thesis.
This patch series is based on tag v5.17-rc4.

Jakub Matěna (4):
  mm: refactor of vma_merge()
  mm: adjust page offset in mremap
  mm: enable merging of VMAs with different anon_vmas
  mm: add tracing for VMA merges

 include/linux/rmap.h        |  17 ++-
 include/trace/events/mmap.h |  55 +++++++++
 mm/internal.h               |  11 ++
 mm/mmap.c                   | 232 ++++++++++++++++++++++++++----------
 mm/rmap.c                   |  40 +++++++
 5 files changed, 290 insertions(+), 65 deletions(-)

-- 
2.34.1

