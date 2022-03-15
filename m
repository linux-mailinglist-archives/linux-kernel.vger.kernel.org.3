Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D50634D91E6
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:02:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344086AbiCOBDp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:03:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233143AbiCOBDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:03:44 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BF8644751;
        Mon, 14 Mar 2022 18:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1647306153; x=1678842153;
  h=from:to:cc:subject:date:message-id;
  bh=Hw9A4keT79FJ3WowoLGYtkIz82VMOIjLnVey1j4KeFg=;
  b=Xxdn8y1/qNYMbrCbFaOr4JhuHsXmTWvVLl9N0yJPInxItovsZB3ZTOT+
   xkO47/NvxtEb/tSC23xYqmw+YpxtGypjFvq+otiBFlnNkh7d0196BNDw6
   UfqCFlBCVYJbA2bV6Zi29psneotjMV0Se44G5pVEdTVjyy2fJuQ4vzGT5
   Jawn8ESKzrtD35JvzIA2DcORmsmzD6R2RIGBk0iaFk27S3GuwffLDjiUm
   y7XpcIK3zaVXkisUdiv+pfkqhxKijWPk62/gtmFZfggtKlkk+C5yJWcwZ
   wkjlTqnq60JbsEhRDaAz6liofFxaZ0uiVopO+ZxHwdz2pNPOxjzCqzfAz
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10286"; a="255912326"
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="255912326"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 18:02:33 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,181,1643702400"; 
   d="scan'208";a="515669288"
Received: from cathy-vostro-3670.bj.intel.com ([10.238.156.128])
  by orsmga006.jf.intel.com with ESMTP; 14 Mar 2022 18:02:31 -0700
From:   Cathy Zhang <cathy.zhang@intel.com>
To:     linux-sgx@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dave.hansen@intel.com, ashok.raj@intel.com, cathy.zhang@intel.com
Subject: [RFC PATCH v2 00/10] Support microcode updates affecting SGX
Date:   Tue, 15 Mar 2022 09:02:50 +0800
Message-Id: <20220315010300.10199-1-cathy.zhang@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v1:
https://lore.kernel.org/all/1742be9e-c18e-28c9-75c8-144bf1f6a311@intel.com/T/

Changes since v1:
 - Remove the sysfs file svnupdate. (Thomas Gleixner, Dave Hansen)
 - Let late microcode load path call ENCLS[EUPDATESVN] procedure
   directly. (Borislav Petkov)
 - Update cover letter by removing saying that "...triggered by
   administrators via sysfs...".
 - Drop the patch for documentation change.

cover letter:

== General Microcode Background ==

Historically, microcode updates are applied by the BIOS or early in
boot. In recent years, several trends have made these old approaches
less palatable.

First, the cadence of microcode updates has increased to deliver
security mitigations. Second, the value of those updates has increased,
meaning that any delay in applying them is unacceptable. Third, users
have become accustomed to approaches like hot patching their kernels
and have a growing aversion to reboots in general.

Users want microcode updates to behave more like a hot patching a
kernel and less like a BIOS update.

== SGX Attestation Background ==

SGX enclaves have an attestation mechanism. An enclave might, for
instance, need to attest to its state before it is given a special
decryption key. Since SGX must trust the CPU microcode, attestation
incorporates the microcode versions of all processors on the system
and is affected by microcode updates. This allows the entity to which
the enclave is attesting to make deployment decisions based on the
microcode version. For example, an enclave might be denied a decryption
key if it runs on a system that has old microcode without a specific
mitigation.

Unfortunately, this attestation metric (called CPUSVN) is only a
snapshot. When the kernel first uses SGX (successfully executes any
ENCLS instruction), SGX inspects all CPUs in the system and incorporates
a record of their microcode versions into CPUSVN. Today, that value is
locked and is not updated until a reboot.

== Problems ==

This means that, although the microcode may be update, enclaves can
never attest to this fact. Enclaves are stuck attesting to the old
version until a reboot.

Old enclaves created before the microcode update are presumed to be
compromised must not be allowed to attest with the new microcode
version.

== Solution ==

EUPDATESVN is a new SGX instruction which allows enclave attestation
to include information about updated microcode without a reboot.

Whenever a microcode update affects SGX, the SGX attestation
architecture assumes that all running enclaves and cryptographic
assets (like internal SGX encryption keys) have been compromised.
To mitigate the impact of this presumed compromise, EUPDATESVN success
requires that all SGX memory to be marked as "unused" and its contents
destroyed. This requirement ensures that no compromised enclave can
survive the EUPDATESVN procedure and provides an opportunity to
generate new cryptographic assets.

This series implements the infrastructure needed to track and tear
down bare-metal enclaves and then run EUPDATESVN, it will be called
by the late microcode load path after the microcode update.

This is a very slow operation. It is, of course, exceedingly disruptive
to enclaves but should be infrequent as microcode updates are released
on the order of every few months. Also, this is not the first piece of
the SGX architecture which will destroy all enclave contents.

A follow-on series will add Virtual EPC (KVM guest) support.

SGX Seamless should handle most SGX flows while doing SVN update, so, this
RFC series is based on SGX EDMM v2 which introduces SGX2 flows.
https://lore.kernel.org/lkml/cover.1644274683.git.reinette.chatre@intel.com/T/

Here is the spec for your reference:
https://cdrdv2.intel.com/v1/dl/getContent/648682?explicitVersion=true

Cathy Zhang (10):
  x86/sgx: Introduce mechanism to prevent new initializations of EPC
    pages
  x86/sgx: Provide VA page non-NULL owner
  x86/sgx: Save enclave pointer for VA page
  x86/sgx: Keep record for SGX VA and Guest page type
  x86/sgx: Save the size of each EPC section
  x86/sgx: Forced EPC page zapping for EUPDATESVN
  x86/sgx: Define error codes for ENCLS[EUPDATESVN]
  x86/sgx: Implement ENCLS[EUPDATESVN]
  x86/cpu: Call ENCLS[EUPDATESVN] procedure in microcode update
  x86/sgx: Call ENCLS[EUPDATESVN] during SGX initialization

 arch/x86/include/asm/microcode.h |   5 +
 arch/x86/include/asm/sgx.h       |  46 +++-
 arch/x86/kernel/cpu/sgx/encl.h   |   3 +-
 arch/x86/kernel/cpu/sgx/encls.h  |  16 ++
 arch/x86/kernel/cpu/sgx/sgx.h    |  23 +-
 arch/x86/kernel/cpu/common.c     |   9 +
 arch/x86/kernel/cpu/sgx/encl.c   |  46 +++-
 arch/x86/kernel/cpu/sgx/ioctl.c  |  53 +++-
 arch/x86/kernel/cpu/sgx/main.c   | 460 ++++++++++++++++++++++++++++++-
 arch/x86/kernel/cpu/sgx/virt.c   |  22 ++
 10 files changed, 658 insertions(+), 25 deletions(-)

-- 
2.17.1

