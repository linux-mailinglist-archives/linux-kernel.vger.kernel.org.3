Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5613B467E1C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 20:22:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382825AbhLCT0N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:26:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382821AbhLCT0M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:26:12 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74FB3C061359
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 11:22:48 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id kl8so3750561qvb.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Dec 2021 11:22:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANF2YozXkZ/Ma7nQsyNWs6tgBsm2cwF++KgkH2V+msY=;
        b=ZYhsxXpD0mGY2oqFx+RaRUfwzl0VpP6ZV9szBbuxhq1LBtrWuKE0vhimTJzvcg+zDa
         sfzG2+TknlaqMmI6RpOlKFaRHcD9CvWDX9CHl5NgswAH0qDHxesQn6xcod7R0OA/Y4pk
         AmpAvRPS0BCX5SvzoaEiTU9R1y1gnho/Fg7yYMjBDd1N2GsccPJ9X8rYTP2tusqlGITB
         JL6+v8rdFH6Kv82rm5flzu91kB0j1PTgrya8QBdxnT1d/1drMWYwqcC/crBMLUkaT4gN
         Rzd0ev2GRbhveZdYW9DO2LwQHHIPHDTv8ftSVykwSy9AEN14h7vkbAx++KJm83Oi2dUv
         Qvvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=ANF2YozXkZ/Ma7nQsyNWs6tgBsm2cwF++KgkH2V+msY=;
        b=PooXsz1wKnaxNH1vKjRk3BahQpY+JiihQ6dRYRkRfaTT5zg3TyZ4GKUA265DApr5iV
         FBIUGlyZKlyYnB+bsq5fmeSh5QZeMT2Ij1WonEzU20voY7+iqywSqedZT94mIw4mUr4s
         2yOQxIc/TIo0CqzN7IIhm9Zt8R98p5c5jx1dJ4cQyk4eup4mxhgPhRe7QKasZsAItnVD
         n+daaxbry7VClVxfeNIWHOTKvdR91buUZmjdNi6i1YUkptrzvm72M3bllOrHoE10eRtX
         uWQFDleQme0JS/v+a/PVTWdZpiOOjzMHaeOpk02+JO6DvG8upy2QyCUFtMNb4ItlgGKI
         1h/A==
X-Gm-Message-State: AOAM533gchtPgEEJyYTEZetDZIubE0EAI7TW/NEeI4OiFeCjjpLrW2dk
        3uPg3lIUZpqRW361auOR6292lshoVXxJ+DPaUNEvwIEJBLKuu9orjyL4GGaaamvNvdRhgeGp4TX
        vNHQw3QgCtuQDpMTYBvj7wlZjGdXuBEAQCC7cadpmNViJuPX0aTWTX7e09/nyuX3hS18c+7bD29
        bSwUHY6mKadgg1G+1/IOU=
X-Google-Smtp-Source: ABdhPJyXWkPwQVmZmqs083B9CeHPzZGK70TGRqlHMkD4evC17cikecKIZkE7Ay8fTkI7veAOIfGPoA==
X-Received: by 2002:a0c:f750:: with SMTP id e16mr21182404qvo.110.1638559367537;
        Fri, 03 Dec 2021 11:22:47 -0800 (PST)
Received: from localhost (7-153-16-190.fibertel.com.ar. [190.16.153.7])
        by smtp.gmail.com with ESMTPSA id y10sm2701035qkp.128.2021.12.03.11.22.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Dec 2021 11:22:47 -0800 (PST)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v3 0/5] x86: Show in sysfs if a memory node is able to do encryption
Date:   Fri,  3 Dec 2021 16:21:43 -0300
Message-Id: <20211203192148.585399-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show for each node if every memory descriptor in that node has the
EFI_MEMORY_CPU_CRYPTO attribute.

fwupd project plans to use it as part of a check to see if the users
have properly configured memory hardware encryption capabilities. It's
planned to make it part of a specification that can be passed to
people purchasing hardware. It's called Host Security ID:
https://fwupd.github.io/libfwupdplugin/hsi.html

This also can be useful in the future if NUMA decides to prioritize
nodes that are able to do encryption.


Changes since v2:

e820__range_mark_crypto -> e820__range_mark_crypto_capable.

In e820__range_remove: Create a region with crypto capabilities
instead of creating one without it and then mark it.


Changes since v1:

Modify __e820__range_update to update the crypto capabilities of a
range; now this function will change the crypto capability of a range
if it's called with the same old_type and new_type. Rework
efi_mark_e820_regions_as_crypto_capable based on this.

Update do_add_efi_memmap to mark the regions as it creates them.

Change the type of crypto_capable in e820_entry from bool to u8.

Fix e820__update_table changes.

Remove memblock_add_crypto_capable. Now you have to add the region and
mark it then.

Better place for crypto_capable in pglist_data.


Martin Fernandez (5):
  mm/memblock: Tag memblocks with crypto capabilities
  mm/mmzone: Tag pg_data_t with crypto capabilities
  Tag e820_entry with crypto capabilities
  x86/efi: Tag e820_entries as crypto capable from EFI memmap
  drivers/node: Show in sysfs node's crypto capabilities

 arch/x86/include/asm/e820/api.h   |  1 +
 arch/x86/include/asm/e820/types.h |  1 +
 arch/x86/kernel/e820.c            | 59 ++++++++++++++++++++++++-------
 arch/x86/platform/efi/efi.c       | 25 +++++++++++++
 drivers/base/node.c               | 10 ++++++
 include/linux/memblock.h          |  5 +++
 include/linux/mmzone.h            |  3 ++
 mm/memblock.c                     | 49 +++++++++++++++++++++++++
 mm/page_alloc.c                   |  1 +
 9 files changed, 142 insertions(+), 12 deletions(-)

-- 
2.30.2

