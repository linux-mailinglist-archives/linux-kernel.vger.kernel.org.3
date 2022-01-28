Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71B8549F29D
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 05:54:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346099AbiA1Ey2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 23:54:28 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24348 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231566AbiA1Ey1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 23:54:27 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643345666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=resJk/tEdOzCb4HMrYNBbb0HwztWbu+r7ZIeropsSuw=;
        b=cPXPRSe5IbPGnDT0ROKoTPDHgo+w78iRFAkX25HO1ZVc5dt6IXq0Z5DwFsCjV1XrzMW9aA
        e8xjQQL2XNrKDRvKx45IzmZbAP75a5kgY4Ya1diOtlT771Yp7Xc3N/9CSPYgxSTAnsZHQt
        ws1nbVqRh9reZICW0iSBJ2RE9fD5+h0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-672-VQmb2JphPjqMoNcEdBulKA-1; Thu, 27 Jan 2022 23:54:25 -0500
X-MC-Unique: VQmb2JphPjqMoNcEdBulKA-1
Received: by mail-wm1-f71.google.com with SMTP id s1-20020a1ca901000000b0034ece94dd8cso5308144wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 20:54:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=resJk/tEdOzCb4HMrYNBbb0HwztWbu+r7ZIeropsSuw=;
        b=5sJpnoKTTXjtqJJSgt0GautmT6eZZHyu8zEkOnKT619JSKXLzVdotTiMFJvCIHVW2q
         umAbY92wUD5f6/gGwwdPi+8kSNso3ccjKj9EFxYKfOW4MtG7gLp+6i2ZVl1N71CgbwYT
         lN7G9sFo114XSY80prBQ7Ar76R/xh4W8KHnWJguOgK0T+NPKsh0MdUc5Ky6KMtIyl2KD
         W1f4Kyr4XHU/jS6v8ZT86Hf7oY8CCWjmLGtyZUtANHUDmjWjCOACHfX/N9Y/duJZFtKx
         ruTpwyTQ0140BVtGuYlTTczp2ZiJvVpckBN2qF1+WFgqxidt8uVSfG5O/g5Xapf1qkco
         kGMA==
X-Gm-Message-State: AOAM533sFpPZzVrRSK4W+Uzt1LZaCrsIS3lJjM2XKfZLxSbb1EJG7Zt5
        8EIEhGFd3Sl233WFyWaPLg5/Yhos5zZksHEG96mZWSI7TZboEiVvEhvM9/h5gLyMJSgk2oK2oWS
        ZDUHo59Xw4cDqWohRBtcWPvSw
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr14457872wme.51.1643345664235;
        Thu, 27 Jan 2022 20:54:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz/cbngk6JPIWe7eDn77j5uX7Q7CZTQwNG84coFmrPmCGvDYAJ1k7y6Mm20IH62h5mnyIOGoQ==
X-Received: by 2002:a1c:a98f:: with SMTP id s137mr14457846wme.51.1643345663947;
        Thu, 27 Jan 2022 20:54:23 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id i13sm814014wrf.3.2022.01.27.20.54.18
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 27 Jan 2022 20:54:23 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com, Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: [PATCH v3 0/4] mm: Rework zap ptes on swap entries
Date:   Fri, 28 Jan 2022 12:54:08 +0800
Message-Id: <20220128045412.18695-1-peterx@redhat.com>
X-Mailer: git-send-email 2.32.0
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v3:
- Patch 1:
  - Fix !non_swap_entry() case and hwpoison case too [Hugh]
  - Added reproducer program in commit message
  - Introduced should_zap_cows() helper
- Added patch 2, "mm: Rename zap_skip_check_mapping() to should_zap_page()"
- Added patch 3, "mm: Change zap_details.zap_mapping into even_cows"

RFC V2: https://lore.kernel.org/lkml/20211115134951.85286-1-peterx@redhat.com
RFC V1: https://lore.kernel.org/lkml/20211110082952.19266-1-peterx@redhat.com

Thanks to Hugh's help, we're pretty clear on the history of zap_details and
swap skipping behavior, hence dropping the RFC tag.

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

Only patch 1 needs to be backported to stable.

Please review, thanks.

Peter Xu (4):
  mm: Don't skip swap entry even if zap_details specified
  mm: Rename zap_skip_check_mapping() to should_zap_page()
  mm: Change zap_details.zap_mapping into even_cows
  mm: Rework swap handling of zap_pte_range

 mm/memory.c | 85 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

-- 
2.32.0

