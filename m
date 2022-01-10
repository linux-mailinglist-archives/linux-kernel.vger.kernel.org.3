Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F367A489AB6
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234171AbiAJNuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:50:10 -0500
Received: from smtp-out2.suse.de ([195.135.220.29]:33320 "EHLO
        smtp-out2.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230236AbiAJNuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:50:08 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 3CFF81F395;
        Mon, 10 Jan 2022 13:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1641822606; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dsFwmuk0CX7ltVsRVZVwGSb46zqyAdrIjBZaVQwQYsw=;
        b=Cxi4DKWB9qWnepRS9zf3XEXXuVPiwup7TAHvK+JLUGGtm0BerCUq/suWnWzntdzQYGF3vp
        4A7gSVRUNwFiTa0Pn5a/y453sqAHJcRcsarbauzov8BOEh8AuFd4prI5YG3MIQrHAareCG
        45Ry/WuimBqKLNFDp47Y0yZLBSubD2M=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1641822606;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=dsFwmuk0CX7ltVsRVZVwGSb46zqyAdrIjBZaVQwQYsw=;
        b=M5mR11XFV1E1tlCtH8DkYBxALX63UOfVbEIwxOyXJ/UNwj3kNqIG/LUHUFY+E3Z4bsllSl
        CmTHDgKRABSaB6AQ==
Received: from kitsune.suse.cz (kitsune.suse.cz [10.100.12.127])
        by relay2.suse.de (Postfix) with ESMTP id 28230A3B83;
        Mon, 10 Jan 2022 13:50:03 +0000 (UTC)
From:   Michal Suchanek <msuchanek@suse.de>
To:     keyrings@vger.kernel.org, linux-crypto@vger.kernel.org,
        linux-integrity@vger.kernel.org
Cc:     Michal Suchanek <msuchanek@suse.de>, kexec@lists.infradead.org,
        Philipp Rudo <prudo@redhat.com>,
        Mimi Zohar <zohar@linux.ibm.com>,
        Nayna <nayna@linux.vnet.ibm.com>, Rob Herring <robh@kernel.org>,
        linux-s390@vger.kernel.org, Vasily Gorbik <gor@linux.ibm.com>,
        Lakshmi Ramasubramanian <nramas@linux.microsoft.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Jessica Yu <jeyu@kernel.org>, linux-kernel@vger.kernel.org,
        David Howells <dhowells@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        Paul Mackerras <paulus@samba.org>,
        Hari Bathini <hbathini@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linuxppc-dev@lists.ozlabs.org,
        Frank van der Linden <fllinden@amazon.com>,
        Thiago Jung Bauermann <bauerman@linux.ibm.com>,
        Daniel Axtens <dja@axtens.net>, buendgen@de.ibm.com,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Baoquan He <bhe@redhat.com>,
        linux-security-module@vger.kernel.org
Subject: [PATCH v4 0/6] KEXEC_SIG with appended signature
Date:   Mon, 10 Jan 2022 14:49:52 +0100
Message-Id: <cover.1641822505.git.msuchanek@suse.de>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This is a refresh of the KEXEC_SIG series.

This adds KEXEC_SIG support on powerpc and deduplicates the code dealing
with appended signatures in the kernel.

powerpc supports IMA_KEXEC but that's an exception rather than the norm.
On the other hand, KEXEC_SIG is portable across platforms.

For distributions to have uniform security features across platforms one
option should be used on all platforms.

Thanks

Michal

Previous revision: https://lore.kernel.org/linuxppc-dev/cover.1637862358.git.msuchanek@suse.de/
Patched kernel tree: https://github.com/hramrach/kernel/tree/kexec_sig

Michal Suchanek (6):
  s390/kexec_file: Don't opencode appended signature check.
  powerpc/kexec_file: Add KEXEC_SIG support.
  kexec_file: Don't opencode appended signature verification.
  module: strip the signature marker in the verification function.
  module: Use key_being_used_for for log messages in
    verify_appended_signature
  module: Move duplicate mod_check_sig users code to mod_parse_sig

 arch/powerpc/Kconfig                     | 16 +++++++
 arch/powerpc/kexec/elf_64.c              | 12 +++++
 arch/s390/Kconfig                        |  2 +-
 arch/s390/kernel/machine_kexec_file.c    | 41 +----------------
 crypto/asymmetric_keys/asymmetric_type.c |  1 +
 include/linux/module_signature.h         |  1 +
 include/linux/verification.h             |  5 +++
 kernel/module-internal.h                 |  2 -
 kernel/module.c                          | 12 +++--
 kernel/module_signature.c                | 56 +++++++++++++++++++++++-
 kernel/module_signing.c                  | 34 +++++++-------
 security/integrity/ima/ima_modsig.c      | 22 ++--------
 12 files changed, 116 insertions(+), 88 deletions(-)

-- 
2.31.1

