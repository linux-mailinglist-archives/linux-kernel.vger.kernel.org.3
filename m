Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F4D7515556
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 22:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380409AbiD2UU5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 16:20:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380339AbiD2UUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 16:20:54 -0400
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66DC89F3A1
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:17:35 -0700 (PDT)
Received: by mail-oi1-x22a.google.com with SMTP id l203so9718080oif.0
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 13:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=eclypsium.com; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYXkLp0fPhZ4miEUy66+jKkP3mtd+ed+kKhoj+7Arlw=;
        b=EZfC0Wd7Kbw6BPW9sWVjWND+mdI27q73yrr0HJYwPqOp8Lf/p0JKOj6VDiMsg+Q0nK
         sVE/iNKF2WknemJJDWIQ5jdCr8D15GQELuYdHcEGBfBPyNa+ngksK+vAtsb4jjuJOPCK
         mSd032rnnKOWxWDhHSF/O+kFKi5zt9r7wJcA/3QfhV8WabfXkaNFqRTfnbDadXZ3abR7
         BjLXEw2419+T7584YmKWNxqonpx3eslpPSpJPgLkVsou5xTbQ+I0JHWFfROD0SSIW6Cp
         MfLUrTvomaV4gapy9hV+NJyh0xABJybSoN9XHROU2VQ1urrERCYVwlLrTGG9QlmyxeoV
         gWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=nYXkLp0fPhZ4miEUy66+jKkP3mtd+ed+kKhoj+7Arlw=;
        b=k7hsyGAuc6MJyb1/E0ArYWWDDLngHPifyqg57ajPTEKXfUodr93gJsrNQnkocUf63d
         EoazNzg4cuFHqUCWeCSV0Rgd7DlpDCMqkfheWTDmPYivtLGvpsfEjXtxeHNCqQ0hz+Co
         axM3Y+5/bNBBQq/s0IVvOy3+/ED7M5N90eRvSdqh5eI7cQfXkR/SYvKNMzP0X2upLIsf
         YGeC/Xc1TWYWWZOEVPJZIA7AgT2rEw5QgtZYfJz0UsgK3+3aPN3n2igQV5Y6XAmXeYhx
         pXa8V8qXK6FMnj1X3HoUmHL3y8lWYwOBRCT9XAL4g49Q1Q7N6IAWqiqzXVUhvB1mPIDj
         t4nQ==
X-Gm-Message-State: AOAM531j2DUs6GmUiaMDsuHSdlOQQrAZD1yZWPIhOEBg0xUPRI4I8P+D
        RAiyUu/nk8NXVFF4ldnCFCVRAY/TiQUwpp56HhusHAczkrHHklqOVKxNXtMAN9n7T3PHOhUTDZp
        JPkVxImw6O1GRMeVR0gpE9rHQ4PBJMBxMLr8g4NJhFYq6NkOrLRTXVZSX0WqcaY2Z4WH16O6rWn
        WFzSLLJWJ5vuh3+uWLUOE=
X-Google-Smtp-Source: ABdhPJzSy3OSVGqtKyunus4UZG+M0Rq/rQsxtwQdjrAQqRXR2fT16vvwtUnNUofDKGpdsowU72xaew==
X-Received: by 2002:a05:6808:148b:b0:325:21ad:fd18 with SMTP id e11-20020a056808148b00b0032521adfd18mr540018oiw.227.1651263454355;
        Fri, 29 Apr 2022 13:17:34 -0700 (PDT)
Received: from localhost ([181.97.174.128])
        by smtp.gmail.com with ESMTPSA id f21-20020a4ace95000000b0035eb4e5a6b8sm1176122oos.14.2022.04.29.13.17.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Apr 2022 13:17:33 -0700 (PDT)
From:   Martin Fernandez <martin.fernandez@eclypsium.com>
To:     linux-kernel@vger.kernel.org, linux-efi@vger.kernel.org,
        platform-driver-x86@vger.kernel.org, linux-mm@kvack.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
        ardb@kernel.org, dvhart@infradead.org, andy@infradead.org,
        gregkh@linuxfoundation.org, rafael@kernel.org, rppt@kernel.org,
        akpm@linux-foundation.org, daniel.gutson@eclypsium.com,
        hughsient@gmail.com, alex.bazhaniuk@eclypsium.com,
        alison.schofield@intel.com, keescook@chromium.org,
        Martin Fernandez <martin.fernandez@eclypsium.com>
Subject: [PATCH v8 0/8] x86: Show in sysfs if a memory node is able to do encryption
Date:   Fri, 29 Apr 2022 17:17:09 -0300
Message-Id: <20220429201717.1946178-1-martin.fernandez@eclypsium.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Show for each node if every memory descriptor in that node has the
EFI_MEMORY_CPU_CRYPTO attribute.

fwupd project plans to use it as part of a check to see if the users
have properly configured memory hardware encryption
capabilities. fwupd's people have seen cases where it seems like there
is memory encryption because all the hardware is capable of doing it,
but on a closer look there is not, either because of system firmware
or because some component requires updating to enable the feature.

It's planned to make it part of a specification that can be passed to
people purchasing hardware

These checks will run at every boot. The specification is called Host
Security ID: https://fwupd.github.io/libfwupdplugin/hsi.html.

We choosed to do it a per-node basis because although an ABI that
shows that the whole system memory is capable of encryption would be
useful for the fwupd use case, doing it in a per-node basis gives also
the capability to the user to target allocations from applications to
NUMA nodes which have encryption capabilities.

I did some tests for some of the functions introduced (and modified)
in e820.c. Sadly KUnit is not able to test __init functions and data
so I had some warnings during the linking. There is a KUnit patch
already to fix that [1]. I wanted to wait for it to be merged but it
is taking more time than I expected so I'm sending this without tests
for now. I'm planning to add unit tests in the future to the e820
range update rework and e820_update_table.

[1] https://lore.kernel.org/lkml/20220419040515.43693-1-brendanhiggins@google.com/T/


Changes since v7:

Less kerneldocs

Less verbosity in the e820 code


Changes since v6:

Fixes in __e820__handle_range_update

Const correctness in e820.c

Correct alignment in memblock.h

Rework memblock_overlaps_region


Changes since v5:

Refactor e820__range_{update, remove, set_crypto_capable} in order to
avoid code duplication.

Warn the user when a node has both encryptable and non-encryptable
regions.

Check that e820_table has enough size to store both current e820_table
and EFI memmap.


Changes since v4:

Add enum to represent the cryptographic capabilities in e820:
e820_crypto_capabilities.

Revert __e820__range_update, only adding the new argument for
__e820__range_add about crypto capabilities.

Add a function __e820__range_update_crypto similar to
__e820__range_update but to only update this new field.


Changes since v3:

Update date in Doc/ABI file.

More information about the fwupd usecase and the rationale behind
doing it in a per-NUMA-node.


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

Martin Fernandez (8):
  mm/memblock: Tag memblocks with crypto capabilities
  mm/mmzone: Tag pg_data_t with crypto capabilities
  x86/e820: Add infrastructure to refactor e820__range_{update,remove}
  x86/e820: Refactor __e820__range_update
  x86/e820: Refactor e820__range_remove
  x86/e820: Tag e820_entry with crypto capabilities
  x86/efi: Mark e820_entries as crypto capable from EFI memmap
  drivers/node: Show in sysfs node's crypto capabilities

 Documentation/ABI/testing/sysfs-devices-node |  10 +
 arch/x86/include/asm/e820/api.h              |   1 +
 arch/x86/include/asm/e820/types.h            |  12 +-
 arch/x86/kernel/e820.c                       | 388 ++++++++++++++-----
 arch/x86/platform/efi/efi.c                  |  37 ++
 drivers/base/node.c                          |  10 +
 include/linux/memblock.h                     |   5 +
 include/linux/mmzone.h                       |   3 +
 mm/memblock.c                                |  62 +++
 mm/page_alloc.c                              |   1 +
 10 files changed, 431 insertions(+), 98 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-devices-node

-- 
2.30.2

