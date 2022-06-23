Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA77A558BF2
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 01:52:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230523AbiFWXwZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 19:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiFWXwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 19:52:23 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E08F3609E6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:21 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id go6so1171414pjb.0
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 16:52:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DefBYaY/G33kY4Ei9AvXETroX4rt5wpVrX5H893xFe8=;
        b=Sy4dpBK9sxm6P1WYqg3D7g3GCUd2xUq4x6AnHGjjnZ47T/sRJJjc+j4mWPXxBkFEog
         UfgGJJ/C3IVk9qX/R35CfCkxoJfLiiGuDPL/CjKxCDhatzE5d6L/bId9gF/Ly1abut+j
         /rSa+f/H32w8OoUvMKNIRmqfV18iOSY/2h0pvrt9iba25lUmFSq7XPERVAFN+f8Jq1W4
         lduN9LuS+ajFQ5q9rUIcl3i2lh09TtzIdBke9RxcDPtbwsS2kXOeUlv3R0lFsAqIcdXS
         846pHtNAJS22q7crZjwXOqoAV29uCgF4ZgUC4QiV2+lzpeoVQHYZ/JtMmT7oPW8mRlO8
         gcdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=DefBYaY/G33kY4Ei9AvXETroX4rt5wpVrX5H893xFe8=;
        b=pEjjYk9MNskMWeGU4BHAs2FbmNzBX+FYlkzgoWb2FR4ENgha9JrHGH1otgVf3E0Qjz
         kTgUAqubWldSoOorKoRoPSujEso35KLXwFDvWZSlFZI4Lhy1+EKnePOPiiF6thBKeG4X
         C3itj/usbeHnIahmH/hTXZn33sSyTkmTc5OVPlmulSI4+QqnT7L2Yw0RdKlRhXONpFfQ
         8Ua2qBwxNPnHJQnhMfrpnUJC/96+jlu9JWjFb0mEHwy1TFpmNNyjTXg0mGsxJVmylgww
         g7anYwk7TPCo8sM+xGBQBSrCFZgDJ7Jgo/477EnVAhxDWTyttkYToMmvxkVhiBBsH0hF
         m1Zw==
X-Gm-Message-State: AJIora9SfiWRrNamSQ9XFV0t6yOP1TE9DZ/dSjMbUlENR2jqnE6MkO1X
        zRRqf/tCTaasL/DO76HL2A==
X-Google-Smtp-Source: AGRyM1uJYsdX/CAb4fmaTrTq/2csUXOYUyJmGEi18K/Pcxpkbsb5kd+sUGMjL/8I4qf2COUNlcj3qA==
X-Received: by 2002:a17:903:234e:b0:16a:2d02:add7 with SMTP id c14-20020a170903234e00b0016a2d02add7mr19621461plh.10.1656028341391;
        Thu, 23 Jun 2022 16:52:21 -0700 (PDT)
Received: from ik1-406-35019.vs.sakura.ne.jp (ik1-406-35019.vs.sakura.ne.jp. [153.127.16.23])
        by smtp.gmail.com with ESMTPSA id r10-20020a170903020a00b00168eab11f67sm362571plh.94.2022.06.23.16.52.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 16:52:21 -0700 (PDT)
From:   Naoya Horiguchi <nao.horiguchi@gmail.com>
X-Google-Original-From: Naoya Horiguchi <naoya.horiguchi@linux.dev>
To:     linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Yang Shi <shy828301@gmail.com>,
        Oscar Salvador <osalvador@suse.de>,
        Muchun Song <songmuchun@bytedance.com>,
        Naoya Horiguchi <naoya.horiguchi@nec.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] mm, hwpoison: enable 1GB hugepage support (v2)
Date:   Fri, 24 Jun 2022 08:51:44 +0900
Message-Id: <20220623235153.2623702-1-naoya.horiguchi@linux.dev>
X-Mailer: git-send-email 2.25.1
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

Here is v2 of "enabling memory error handling on 1GB hugepage" patchset.

Major updates:

  - (patch 3/9) I made pud_huge() and follow_huge_pud() aware of non-present
    pud entry (based on Miaohe's comment).

  - (patch 4/9 and patch 5/9) I extended the mechanism to save raw error
    info to support multiple error subpages in a hugepage.  Additionally,
    I added a "unreliable" flag which prevents freeing hwpoison hugetlb
    if any raw error info is lost.

  - (patch 1/9 and 2/9) During testing some common cases for 1GB hugepage,
    I found a few issues in existing code, so this series starts
    with fixing them.

The remaining patches should have only minor updates since v1.

Patch dependency:

- "mm/memory-failure: disable unpoison once hw error happens"
  (actually the conflict is not logical one, but adding MF_SIMULATED to
   mf_flags conflicts with patch 6/9.)

v1: https://lore.kernel.org/linux-mm/20220602050631.771414-1-naoya.horiguchi@linux.dev/T/#u

Thanks,
Naoya Horiguchi
---
Summary:

Naoya Horiguchi (9):
      mm/hugetlb: remove checking hstate_is_gigantic() in return_unused_surplus_pages()
      mm/hugetlb: separate path for hwpoison entry in copy_hugetlb_page_range()
      mm/hugetlb: make pud_huge() and huge_pud() aware of non-present pud entry
      mm, hwpoison, hugetlb: support saving mechanism of raw error pages
      mm, hwpoison: make unpoison aware of raw error info in hwpoisoned hugepage
      mm, hwpoison: set PG_hwpoison for busy hugetlb pages
      mm, hwpoison: make __page_handle_poison returns int
      mm, hwpoison: skip raw hwpoison page in freeing 1GB hugepage
      mm, hwpoison: enable memory error handling on 1GB hugepage

 arch/x86/mm/hugetlbpage.c |   3 +-
 include/linux/hugetlb.h   |  13 ++++
 include/linux/mm.h        |   2 +-
 include/linux/swapops.h   |   9 +++
 include/ras/ras_event.h   |   1 -
 mm/hugetlb.c              |  78 ++++++++++++++--------
 mm/memory-failure.c       | 163 +++++++++++++++++++++++++++++++++++++---------
 7 files changed, 209 insertions(+), 60 deletions(-)
