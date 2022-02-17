Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48F6F4B98C0
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 07:08:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234625AbiBQGIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 01:08:20 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234667AbiBQGIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 01:08:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39F9BC7E83
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645078080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=58IcYQPt3ZhNcNyChh1IrLVEmd4Lcb+cUPGc2UbHCU0=;
        b=Fu3BPmk3vMduARoGZXUgfjw/IrYWZyMmWwF49TpOlCxuWb+bbfY2AXlWKjLmS/5FKr9x9z
        Lodi73d3VDEC6SCcgY05o40Kxokh6oQQdCxmYhKGc2VpYoxxwo2EgvWQVf3eW3mfA/jX0L
        w9tlwoZKVjskGOLL5EXpcIZt9cgq3F8=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-657-Unw5HHG-PKWF1H9mHTV5nw-1; Thu, 17 Feb 2022 01:07:56 -0500
X-MC-Unique: Unw5HHG-PKWF1H9mHTV5nw-1
Received: by mail-pf1-f200.google.com with SMTP id n135-20020a628f8d000000b004e16d5bdcdbso2653608pfd.20
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 22:07:56 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=58IcYQPt3ZhNcNyChh1IrLVEmd4Lcb+cUPGc2UbHCU0=;
        b=1ASWeapVwVlIk/Bqw/bmPMpQvrR1/bi0+BP9TIPVo2/WcYGELgEGOHNbwp3l+iu9gn
         +S2W5vk0vdCJknxRksiA4VSXvM/ZzjnBCfQ9lzqGwmiDDNpssJiiSi7UhwrwlZ1f3UGm
         el8RHBClUD3mhP5SeQELfMuAneDsmtMAGNFrU66jJ5/Ef0LBWI4k4Kr9pN16NYSH6vj4
         AH1Hc3ss3JCeGLYr7bLaTznjKDkf2nOFKCZwyr0IQIed7zP5uIhvzzpOJIRq+vsVy02I
         eaSc59HDUZ8BhX1ipiPCMbU2NwxUrGJs4gTH2BeXNoBSYx72yqHDmoroDMn7CGnxCtWU
         25fQ==
X-Gm-Message-State: AOAM532nQSaVQwxM90FRJxrstGXjXOGjPTIrfTUUzXdn+s7WUloAUSrr
        PCE6Ls1bSuy7qZRBebvJlcfzdKDS/FSDjq5sWhg0sJ/XaS9dYmBiqCcdVB/7+4xXfgtlflsNRFJ
        5MtBtyrt+Eyej40AJt6laa8fC
X-Received: by 2002:a17:902:fe83:b0:14d:6e55:eea3 with SMTP id x3-20020a170902fe8300b0014d6e55eea3mr1415394plm.104.1645078075584;
        Wed, 16 Feb 2022 22:07:55 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzKtPr2kwyIYGum1Q09mgsPZ2ioQRfmHyRjvcp1K2tM0GogiQwyeAoUhJIKwFJRBmXDX8QrQ==
X-Received: by 2002:a17:902:fe83:b0:14d:6e55:eea3 with SMTP id x3-20020a170902fe8300b0014d6e55eea3mr1415382plm.104.1645078075270;
        Wed, 16 Feb 2022 22:07:55 -0800 (PST)
Received: from localhost.localdomain ([94.177.118.126])
        by smtp.gmail.com with ESMTPSA id j8sm224230pjc.11.2022.02.16.22.07.50
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 22:07:55 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     Alistair Popple <apopple@nvidia.com>,
        Matthew Wilcox <willy@infradead.org>, peterx@redhat.com,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        John Hubbard <jhubbard@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v5 0/4] mm: Rework zap ptes on swap entries
Date:   Thu, 17 Feb 2022 14:07:42 +0800
Message-Id: <20220217060746.71256-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v5:
- Patch 1:
  - A few comment fixups in patch 1 [John]
  - Tweak commit message (s/user/caller/) [Andrew]
- Add r-bs for John
- Reindent commit messages to 75 columns [John]

RFC V1: https://lore.kernel.org/lkml/20211110082952.19266-1-peterx@redhat.com
RFC V2: https://lore.kernel.org/lkml/20211115134951.85286-1-peterx@redhat.com
V3:     https://lore.kernel.org/lkml/20220128045412.18695-1-peterx@redhat.com
V4:     https://lore.kernel.org/lkml/20220216094810.60572-1-peterx@redhat.com

Patch 1 should fix a long standing bug for zap_pte_range() on zap_details
usage.  The risk is we could have some swap entries skipped while we should
have zapped them.

Migration entries are not the major concern because file backed memory always
zap in the pattern that "first time without page lock, then re-zap with page
lock" hence the 2nd zap will always make sure all migration entries are already
recovered.

However there can be issues with real swap entries got skipped errornoously.
There's a reproducer provided in commit message of patch 1 for that.

Patch 2-4 are cleanups that are based on patch 1.  After the whole patchset
applied, we should have a very clean view of zap_pte_range().

Only patch 1 needs to be backported to stable if necessary.

Please review, thanks.

Peter Xu (4):
  mm: Don't skip swap entry even if zap_details specified
  mm: Rename zap_skip_check_mapping() to should_zap_page()
  mm: Change zap_details.zap_mapping into even_cows
  mm: Rework swap handling of zap_pte_range

 mm/memory.c | 80 ++++++++++++++++++++++++++++++-----------------------
 1 file changed, 45 insertions(+), 35 deletions(-)

-- 
2.32.0

