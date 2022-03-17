Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CFFE4DCE14
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 19:54:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiCQSyX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 14:54:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiCQSyF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 14:54:05 -0400
X-Greylist: delayed 502 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 17 Mar 2022 11:52:47 PDT
Received: from srv1.home.kabele.me (unknown [IPv6:2a02:768:2704:8c1a:3eec:efff:fe00:2ce4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EA7CB223202;
        Thu, 17 Mar 2022 11:52:47 -0700 (PDT)
Received: from srv1.home.kabele.me (localhost [IPv6:::1])
        by srv1.home.kabele.me (Postfix) with ESMTP id 7423916927C;
        Thu, 17 Mar 2022 19:44:24 +0100 (CET)
Received: from localhost ([2a01:c22:8dfa:1400:beea:2810:7764:7afc])
        by srv1.home.kabele.me with ESMTPSA
        id 9D7GGYiBM2LuRjQAnmUwTQ
        (envelope-from <vit@kabele.me>); Thu, 17 Mar 2022 19:44:24 +0100
Date:   Thu, 17 Mar 2022 19:44:19 +0100
From:   Vit Kabele <vit@kabele.me>
To:     platform-driver-x86@vger.kernel.org
Cc:     r.marek@assembler.cz, devel@acpica.org, mingo@redhat.com,
        robert.moore@intel.com, linux-kernel@vger.kernel.org,
        linux-acpi@vger.kernel.org
Subject: [PATCH 0/3 RESEND] platform/x86, apcica: Sanitize EBDA pointer from
 memory
Message-ID: <YjOBg4Oys3qV1dbe@czspare1-lap.sysgo.cz>
Mail-Followup-To: platform-driver-x86@vger.kernel.org, r.marek@assembler.cz,
        devel@acpica.org, mingo@redhat.com, robert.moore@intel.com,
        linux-kernel@vger.kernel.org, linux-acpi@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Resend because I messed up the mailing list addresses]

When testing custom virtualization platform, we noticed that in cases
where the memory is initialized with random pattern, the Linux guest
tends to crash on EPT violation.

It turns out that (at least two) codepaths during boot do not check the
validity of EBDA pointer retrieved from BDA memory at address 0x40e.
In case that the returned address is over 640K, the kernel happily
touches the VGA memory (which was not present in our setup, hence the
EPT violation).

This may be problematic in other virtualized environment too, but it can
probably also happen on bare metal when booted with legacy free (e.g.
UEFI without CSM) firmware, because the BDA may not be initialized and
the VGA range might not be properly decoded.

The third patch of the series adds workaround for the situation where
EBDA is smaller than 1KiB and the ACPI code scanning for RSDP table
bumps to the VGA memory.

The two acpcia patches can eventually be squashed together, it's up to you.

I tested these patches on my lenovo laptop (and in QEMU if that counts).

Vit Kabele (3):
  platform/x86: Check validity of EBDA pointer in mpparse.c
  acpica: Check that the EBDA pointer is in valid range
  acpica: Do not touch VGA memory when EBDA < 1KiB

 arch/x86/include/asm/bios_ebda.h |  3 +++
 arch/x86/kernel/ebda.c           |  3 ---
 arch/x86/kernel/mpparse.c        | 12 +++++++++++-
 drivers/acpi/acpica/tbxfroot.c   | 25 ++++++++++++++++++-------
 4 files changed, 32 insertions(+), 11 deletions(-)

-- 
2.30.2

