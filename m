Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A83B4CAA72
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 17:37:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242895AbiCBQhi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 11:37:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242765AbiCBQhc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 11:37:32 -0500
Received: from out1.migadu.com (out1.migadu.com [IPv6:2001:41d0:2:863f::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64634CEA04
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 08:36:49 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1646239006;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=u21KV9s2q5sfOslEpw/sDzZbvsgVEVjrwLfohbEqpJg=;
        b=OCYrJ0Dskjlu+HYjjFC97sPKj6F0lIMr+23nFt90d7yM5h0clSM+2Pu8RNAmPRlE3EBI2l
        T7qBpnA9NFvU0vwQSEa9iraxP+Gi8yJcYugpQuWF1Xty+8qE/EAHXAjMQ0f8qBZBo4cU91
        5kU0eNx02/50A/TPERPno6NbvxGbf4Q=
From:   andrey.konovalov@linux.dev
To:     Marco Elver <elver@google.com>,
        Alexander Potapenko <glider@google.com>
Cc:     Andrey Konovalov <andreyknvl@gmail.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        Andrey Ryabinin <ryabinin.a.a@gmail.com>,
        kasan-dev@googlegroups.com,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrey Konovalov <andreyknvl@google.com>
Subject: [PATCH mm 00/22] kasan: report clean-ups and improvements
Date:   Wed,  2 Mar 2022 17:36:20 +0100
Message-Id: <cover.1646237226.git.andreyknvl@google.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@google.com>

A number of clean-up patches for KASAN reporting code.

Most are non-functional and only improve readability.

The patches go on top of mm.

Andrey Konovalov (22):
  kasan: drop addr check from describe_object_addr
  kasan: more line breaks in reports
  kasan: rearrange stack frame info in reports
  kasan: improve stack frame info in reports
  kasan: print basic stack frame info for SW_TAGS
  kasan: simplify async check in end_report
  kasan: simplify kasan_update_kunit_status and call sites
  kasan: check CONFIG_KASAN_KUNIT_TEST instead of CONFIG_KUNIT
  kasan: move update_kunit_status to start_report
  kasan: move disable_trace_on_warning to start_report
  kasan: split out print_report from __kasan_report
  kasan: simplify kasan_find_first_bad_addr call sites
  kasan: restructure kasan_report
  kasan: merge __kasan_report into kasan_report
  kasan: call print_report from kasan_report_invalid_free
  kasan: move and simplify kasan_report_async
  kasan: rename kasan_access_info to kasan_report_info
  kasan: add comment about UACCESS regions to kasan_report
  kasan: respect KASAN_BIT_REPORTED in all reporting routines
  kasan: reorder reporting functions
  kasan: move and hide kasan_save_enable/restore_multi_shot
  kasan: disable LOCKDEP when printing reports

 include/linux/kasan.h     |   4 -
 mm/kasan/kasan.h          |  44 ++++--
 mm/kasan/report.c         | 312 ++++++++++++++++++++++----------------
 mm/kasan/report_generic.c |  34 ++---
 mm/kasan/report_hw_tags.c |   1 +
 mm/kasan/report_sw_tags.c |  15 ++
 mm/kasan/report_tags.c    |   2 +-
 7 files changed, 241 insertions(+), 171 deletions(-)

-- 
2.25.1

