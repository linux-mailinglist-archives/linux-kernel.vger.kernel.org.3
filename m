Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AEF44B84BC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 10:48:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232425AbiBPJsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 04:48:53 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiBPJsv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 04:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5B83B105A9D
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645004918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=R0KDZgp75NCn3GqeaHfIg3tMwSJcRByZ3Og05yrSr6w=;
        b=epWtiju5ATkegh4LUwVN34bfNn/voqYbOZUZE5EbBv/5wtnm0Y33RZRHyOWXKfwYoeKH8D
        rdljAbYoyeIJ/PIbYtTk6XpkUKIr3P3FED8NE32QL0hAtruHwFdcczDlQz8DEknHienL1k
        AfUNDzWQNeKH5QIbwv4Xe88pMyp14NE=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-264-3TK9wRSQMTOFZFeLPFg2Ug-1; Wed, 16 Feb 2022 04:48:37 -0500
X-MC-Unique: 3TK9wRSQMTOFZFeLPFg2Ug-1
Received: by mail-pg1-f197.google.com with SMTP id k6-20020a63d846000000b00365088c8f6aso995440pgj.6
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 01:48:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=R0KDZgp75NCn3GqeaHfIg3tMwSJcRByZ3Og05yrSr6w=;
        b=eZd6DTLT8tS5q1brpLYQAlSYzTj4j9HRJHtS+nCm5KY9jm4zPmI8gWP01dNarMqsUd
         9HO9JwLd1RFVYoeEtSFnFC5D3HJIGVsg9yJVrbwQmG5i2tpzv6w/nU6pK1YbsdHJkkOt
         2koaF2cwDiTpHOb8e26uFo4u6iyZzZASS1Uy6tcav/rILJqXKOc8Cno6NC01o0r59vgw
         cdkEBZqg5l6wmRbk2zowqQ1TS35s7iBEQ5q8mmkMoHbaFdpsfEgFYwIoTw3rmmhYsEkF
         1H0NMtspFaMOXuhhuNQquhhImfCuHMCuUFeuSotsGvU4Wsv24rf2BSVu2/K2XUEaFapt
         N1LQ==
X-Gm-Message-State: AOAM5338OZsM3lcCpOIm7Md2V3EbiHVXWYTxsqcSZI8gH30HK4A+JDBF
        a3nr5UXi0WQ2A6URGoKr76cLtdSrQc7siKxjgXyfEed0bL+wNprHgxNfdXBL/ezhOha9tT3OcnO
        wVkqz1i9mOVvH89a+qaXM3UPI2GzRwfbNgliLatl7Kwm67HvDtUDYcvNLlzItNOAnWsQUaLI+Hg
        ==
X-Received: by 2002:a17:90b:104:b0:1b8:d212:9b8e with SMTP id p4-20020a17090b010400b001b8d2129b8emr766283pjz.11.1645004916198;
        Wed, 16 Feb 2022 01:48:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJybAQIc6R/6zMXRczxvOWvn4bCG50xP5kjea3OzmnTzEPRiCP3Sdss04dZKrFD0kiE1paUwyA==
X-Received: by 2002:a17:90b:104:b0:1b8:d212:9b8e with SMTP id p4-20020a17090b010400b001b8d2129b8emr766237pjz.11.1645004915681;
        Wed, 16 Feb 2022 01:48:35 -0800 (PST)
Received: from localhost.localdomain ([64.64.123.81])
        by smtp.gmail.com with ESMTPSA id qe7sm11567835pjb.25.2022.02.16.01.48.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Feb 2022 01:48:35 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        Yang Shi <shy828301@gmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>, peterx@redhat.com,
        John Hubbard <jhubbard@nvidia.com>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>
Subject: [PATCH v4 0/4] mm: Rework zap ptes on swap entries
Date:   Wed, 16 Feb 2022 17:48:06 +0800
Message-Id: <20220216094810.60572-1-peterx@redhat.com>
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

v4:
- Rebase to v5.17-rc4
- Add r-b, and suggested-by on patch 2 [David]
- Fix spelling (s/Quotting/Quoting/) [David]

RFC V1: https://lore.kernel.org/lkml/20211110082952.19266-1-peterx@redhat.com
RFC V2: https://lore.kernel.org/lkml/20211115134951.85286-1-peterx@redhat.com
V3:     https://lore.kernel.org/lkml/20220128045412.18695-1-peterx@redhat.com

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

 mm/memory.c | 85 +++++++++++++++++++++++++++++++----------------------
 1 file changed, 50 insertions(+), 35 deletions(-)

-- 
2.32.0

