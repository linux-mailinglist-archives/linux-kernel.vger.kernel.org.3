Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42E6546624F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357239AbhLBLbA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:31:00 -0500
Received: from foss.arm.com ([217.140.110.172]:33830 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S241592AbhLBLa7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:30:59 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A7E6A1435;
        Thu,  2 Dec 2021 03:27:36 -0800 (PST)
Received: from lakrids.cambridge.arm.com (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 661123F7D7;
        Thu,  2 Dec 2021 03:27:35 -0800 (PST)
From:   Mark Rutland <mark.rutland@arm.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     andreyknvl@gmail.com, catalin.marinas@arm.com, dvyukov@google.com,
        glider@google.com, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, ryabinin.a.a@gmail.com, will@kernel.org
Subject: [PATCH 0/3] arm64: kasan: log potential KASAN shadow aliases
Date:   Thu,  2 Dec 2021 11:27:28 +0000
Message-Id: <20211202112731.3346975-1-mark.rutland@arm.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When using KASAN_GENERIC or KASAN_SW_TAGS, many representable pointer
values (e.g. NULL) don't have a legitimate shadow address. If KASAN
instrumentation attempts to access the shadow for such pointers, it will
fault on an unusual-looking address, e.g.

| Unable to handle kernel paging request at virtual address dfff800000000001

To make this easier to debug, this series makes the arm64 fault handling
code log the corresponding memory range for potential shadow acceses,
e.g.

| Unable to handle kernel paging request at virtual address dfff800000000001
| Possible KASAN shadow access for range [0000000000000008..000000000000000f]

Thanks,
Mark.

Mark Rutland (3):
  kasan: move kasan_shadow_to_mem() to shared header
  arm64: mm: use die_kernel_fault() in do_mem_abort()
  arm64: mm: log potential KASAN shadow alias

 arch/arm64/mm/fault.c | 13 ++++++++-----
 include/linux/kasan.h |  6 ++++++
 mm/kasan/kasan.h      |  6 ------
 3 files changed, 14 insertions(+), 11 deletions(-)

-- 
2.30.2

