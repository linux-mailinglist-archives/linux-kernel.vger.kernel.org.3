Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFFB14739DE
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 01:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239717AbhLNA7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 19:59:34 -0500
Received: from mga05.intel.com ([192.55.52.43]:21411 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229672AbhLNA7d (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 19:59:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1639443573; x=1670979573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=L6jgS68pBQsKTDwJOmjT362qV5oWIuBto7KSF/hnE60=;
  b=KO2l2/pgjxBaMfwkhoyUfCzGtoWdRwh4gwyDyzHXP1LQxxuRw7KW5VW2
   +rhopyhJ1zK0XUSxBZR/o5f+a6s4ogOTLhZDZ7HsyGw7Z9qkr4///ujAd
   wrYjeQvfL+KWGDSPU/j1uqxQYb8/YFtWeGUO5kRHllWtoIoGGw8tMnIkk
   zaARHT1hP8hBTpDrDQg/RC4WmbdkbBcyu5mRsLFZ7ixUepdwnlh+O5WtD
   Vwrm8JtZ8GvA7d5ZY6KFsttA2eMAv/vcz1sI83CO+HD8olcEPiKqZe2HS
   fBPytfpcVrfH3b8138xnmS5g2oNOydf0ACV0RZ75SILchT/Ckq/Ps9Z8d
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10197"; a="325139606"
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="325139606"
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2021 16:59:32 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,203,1635231600"; 
   d="scan'208";a="505148553"
Received: from chang-linux-3.sc.intel.com ([172.25.66.175])
  by orsmga007.jf.intel.com with ESMTP; 13 Dec 2021 16:59:32 -0800
From:   "Chang S. Bae" <chang.seok.bae@intel.com>
To:     tglx@linutronix.de, bp@suse.de, dave.hansen@linux.intel.com,
        mingo@kernel.org, luto@kernel.org, x86@kernel.org,
        herbert@gondor.apana.org.au
Cc:     linux-kernel@vger.kernel.org, linux-crypto@vger.kernel.org,
        ebiggers@kernel.org, dan.j.williams@intel.com,
        charishma1.gairuboyina@intel.com, kumar.n.dwarakanath@intel.com,
        lalithambika.krishnakumar@intel.com, ravi.v.shankar@intel.com,
        chang.seok.bae@intel.com
Subject: [PATCH v4 00/13] x86: Support Key Locker
Date:   Mon, 13 Dec 2021 16:51:59 -0800
Message-Id: <20211214005212.20588-1-chang.seok.bae@intel.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Recall that AES-NI [1] is a set of CPU instructions to perform encryption
operations. Like all other software encryption implementations it relies on
OS memory protections to keep clear-text key material from being
exfiltrated across security domains. However, there are demonstrated
methods for exfiltrating data across security domains.

Key Locker [2] is a CPU feature to reduce key exfiltration opportunities
while maintaining a programming interface similar to AES-NI. It converts
the AES key into an encoded form, called the 'key handle' [3]. The key
handle is a wrapped version of the clear-text key where the wrapping key
has limited exposure. Once converted, all subsequent data encryption using
new AES instructions (AES-KL) uses this key handle, reducing the exposure
of private key material in memory.

As mentioned, Key Locker introduces a CPU-internal wrapping key. This key
is loaded in a CPU state that software can not access, and then it is used
to convert the AES keys. At every boot, a new randomized key is
generated and loaded. Thus, the key handle is revoked upon system reboot
(including kexec-reboot).

== Threat Model and Mitigation Description ==

A targeted attack is with brief physical access [4] to the victim device in
unlock state or with the screen locked, but with keys in memory. For
example, the attacker might use a malicious USB peripheral to exploit a
kernel bug or perform a cold boot attack [4], and then extract the disk
encryption master key. Using this master key, the attacker will be able to
extract the contents of the disk. This includes data yet-to-be-written when
acquiring the device from the victim user at a later point in time and
performing forensic analysis.

Key Locker reduces opportunities for long-lived keys to be exfiltrated from
system RAM. Once the key is converted to a key handle, the clear text key
is no longer available to a class of data exfiltration techniques.

== Disk Encryption Use Case ==

Disk encryption uses Key Locker to mitigate key exfiltration as follows:

1. Configuration for Key Locker: AES-KL shows up in /proc/crypto as a
   distinct cipher option. From there, tools like cryptsetup [5] can select
   AES-KL vs AES-NI. For example,

   $ cryptsetup luksFormat --cipher="capi:xts-aes-aeskl-plain" <device>

Note: AES-KL has a performance tradeoff. See details in 'Performance'
below.

2. Disk encryption flow with key protection:

* The cryptsetup utility is responsible for loading the volume key into the
  kernel's keyring and passing a reference of the key. Once dm-crypt [6]
  has set up the volume, user space is responsible for invalidating the key
  material so that only the key handle remains in memory. Cryptsetup does
  this, e.g. via crypt_free_volume_key() and crypt_safe_free().

* The AES-KL code in the kernel's crypto library uses the key handle
  instead of the actual clear text key.

== Non Use Cases ==

Bare metal disk encryption is the only use case intended by these patches.
Userspace usage is not supported because there is no ABI provided to
communicate and coordinate wrapping-key restore failures to userspace.
For now, the key restore failures are only coordinated with kernel users.
For this reason a "keylocker" indicator is not published in /proc/cpuinfo.
At the same time, the kernel can not prevent userspace from using the
AES-KL instructions when Key Locker support has been enabled, so the lack
of userspace support is only documented, not actively enforced. Key Locker
support is not enumerated to VM guests.

== Performance ==

This feature comes with some performance penalty vs AESNI. The cryptsetup
utility [5] has been used to measure the Key Locker performance. Below
results have been measured [8] on an Intel 11th-gen Core Processor, code
named Tigerlake mobile part [9].

Below is the average encryption and decryption rates with key size of 256b.

Commands:
cryptsetup version – 2.3.4
$ cryptsetup benchmark-c aes-cbc -s 256
$ cryptsetup benchmark-c aes-xts -s 256

Tests are approximate using memory only (no storage IO).

+-----------+---------------+---------------+
| Cipher    |   Encryption  | Decryption    |
| (AES-NI)  |    (MiB/s)    | (MiB/s)       |
+-----------+---------------+---------------+
| AES-CBC   |     1242.6    |   4446.5      |
| AES-XTS   |     4233.3    |   4359.7      |
+-----------+-------------------------------+

+-----------+---------------+---------------+
| Cipher    |   Encryption  | Decryption    |
| (AES-KL)  |    (MiB/s)    | (MiB/s)       |
+-----------+---------------+---------------+
| AES-CBC   |     505.3     |   2097.8      |
| AES-XTS   |     1130      |   696.4       |
+-----------+-------------------------------+

The cryptsetup benchmark indicates Key Locker raw throughput can be  ~5x
slower than AES-NI. For disk encryption, storage bandwidth may be the
bottleneck before encryption bandwidth, but the potential performance
difference is why AES-KL is advertised as a distinct cipher in /proc/crypto
rather than the kernel transparently replacing AES-NI usage with AES-KL.

== Patch Series ==

The series touches two areas -- the x86 core and the x86 crypto library:

* PATCH01-09: Implement Key Locker support in the x86 core.  A new internal
  wrapping key is loaded at boot time and then it is restored from deep
  sleep states. The implication is that, e.g., a dm-crypt user needs to
  re-enter the private key at every power-on, per typical expectations, but
  it does not expect the user to re-enter the key over suspend events.
  The AES-KL code in the kernel's crypto library depends on this key
  support. Build up this support via helpers in the feature-dedicated .c
  file. Include documentation.

* PATCH10-13: For the x86 crypto library, it first prepares the AES-NI code
  to accommodate the new AES implementation. Then incrementally add base
  functions and CBC and XTS modes support. The code was found to pass the
  crypto test.

This series is based on 5.16-rc5.

Changes from v3 [7]:
* Drop ECB and CTR mode support (PATCH10/11). (Eric Biggers)
* Fix build warning and errors (PATCH8/11). (Eric Biggers)
* Trim the AES-KL objects by using symbols exported from the AES-NI (PATCH10).
  (Eric Biggers)
* Simplify the assembler dependency check (PATCH11). (Peter Zijlstra)
* Trim the Kconfig help text (PATCH11). (Dan Williams)

Thanks to Dan Williams, Charishma Gairuboyina, and Kumar Dwarakanath for
help with the cover letter.

== Reference ==

[1] Intel Advanced Encryption Standard Instructions (AES-NI):
    https://www.intel.com/content/www/us/en/developer/articles/technical/advanced-encryption-standard-instructions-aes-ni.html
[2] Intel Key Locker Specification:
    https://software.intel.com/content/dam/develop/external/us/en/documents/343965-intel-key-locker-specification.pdf
[3] This encoded form contains ciphertext of AES key, Additional
    Authentication Data, and integrity tag information. Section 1.4 Handle
    Format [2] describes the format.
[4] Key Locker cannot protect the user data in the event of a full system
    compromise, or against the scenarios where the attack can observe the
    creation of the key handle from the original key.
[5] cryptsetup: https://gitlab.com/cryptsetup/cryptsetup
[6] DM-crypt:
    https://www.kernel.org/doc/html/latest/admin-guide/device-mapper/dm-crypt.html
[7] V3: https://lore.kernel.org/lkml/20211124200700.15888-1-chang.seok.bae@intel.com/
[8] Intel publishes information about product performance at
    https://www.Intel.com/PerformanceIndex.
[9] Tigerlake:
    https://www.intel.com/content/www/us/en/products/docs/processors/embedded/11th-gen-product-brief.html

Chang S. Bae (13):
  Documentation/x86: Document Key Locker
  x86/cpufeature: Enumerate Key Locker feature
  x86/insn: Add Key Locker instructions to the opcode map
  x86/asm: Add a wrapper function for the LOADIWKEY instruction
  x86/msr-index: Add MSRs for Key Locker internal wrapping key
  x86/keylocker: Define Key Locker CPUID leaf
  x86/cpu/keylocker: Load an internal wrapping key at boot-time
  x86/power/keylocker: Restore internal wrapping key from the ACPI S3/4
    sleep states
  x86/cpu: Add a configuration and command line option for Key Locker
  crypto: x86/aes - Prepare for a new AES implementation
  crypto: x86/aes-kl - Support AES algorithm using Key Locker
    instructions
  crypto: x86/aes-kl - Support CBC mode
  crypto: x86/aes-kl - Support XTS mode

 .../admin-guide/kernel-parameters.txt         |    2 +
 Documentation/x86/index.rst                   |    1 +
 Documentation/x86/keylocker.rst               |   98 ++
 arch/x86/Kconfig                              |    3 +
 arch/x86/crypto/Makefile                      |    5 +-
 arch/x86/crypto/aes-intel_asm.S               |   26 +
 arch/x86/crypto/aes-intel_glue.c              |  153 +++
 arch/x86/crypto/aes-intel_glue.h              |   48 +
 arch/x86/crypto/aeskl-intel_asm.S             | 1014 +++++++++++++++++
 arch/x86/crypto/aeskl-intel_glue.c            |  296 +++++
 arch/x86/crypto/aesni-intel_asm.S             |   74 +-
 arch/x86/crypto/aesni-intel_glue.c            |  301 ++---
 arch/x86/crypto/aesni-intel_glue.h            |   22 +
 arch/x86/include/asm/cpufeatures.h            |    1 +
 arch/x86/include/asm/disabled-features.h      |    8 +-
 arch/x86/include/asm/keylocker.h              |   45 +
 arch/x86/include/asm/msr-index.h              |    6 +
 arch/x86/include/asm/special_insns.h          |   32 +
 arch/x86/include/uapi/asm/processor-flags.h   |    2 +
 arch/x86/kernel/Makefile                      |    1 +
 arch/x86/kernel/cpu/common.c                  |   21 +-
 arch/x86/kernel/cpu/cpuid-deps.c              |    1 +
 arch/x86/kernel/keylocker.c                   |  199 ++++
 arch/x86/kernel/smpboot.c                     |    2 +
 arch/x86/lib/x86-opcode-map.txt               |   11 +-
 arch/x86/power/cpu.c                          |    2 +
 crypto/Kconfig                                |   36 +
 tools/arch/x86/lib/x86-opcode-map.txt         |   11 +-
 28 files changed, 2157 insertions(+), 264 deletions(-)
 create mode 100644 Documentation/x86/keylocker.rst
 create mode 100644 arch/x86/crypto/aes-intel_asm.S
 create mode 100644 arch/x86/crypto/aes-intel_glue.c
 create mode 100644 arch/x86/crypto/aes-intel_glue.h
 create mode 100644 arch/x86/crypto/aeskl-intel_asm.S
 create mode 100644 arch/x86/crypto/aeskl-intel_glue.c
 create mode 100644 arch/x86/crypto/aesni-intel_glue.h
 create mode 100644 arch/x86/include/asm/keylocker.h
 create mode 100644 arch/x86/kernel/keylocker.c


base-commit: 2585cf9dfaaddf00b069673f27bb3f8530e2039c
--
2.17.1

