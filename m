Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36098586DBF
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 17:28:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233542AbiHAP2B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 11:28:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231162AbiHAP16 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 11:27:58 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1A2A18B00
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 08:27:56 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 162C9208DA;
        Mon,  1 Aug 2022 15:27:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659367675; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KHDf+mkEf2uyS/FOctUkKFcg+NIfbTiXqkX7YGmKhTU=;
        b=xoORvErQ9LsGSOpD6vbE4q9WLTazfnnQCjwPF/MxlWHK101XyryE1leARpF/6DKeZue/z/
        byhA8dCN737eA+odbAkdzbUCXIm2IINia7/sskNzHe41ieyZZQM62oWh7j/l0Idg18KpNH
        dOx/j7waHaL2bgpzxirgRF7iI0LRNTw=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659367675;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=KHDf+mkEf2uyS/FOctUkKFcg+NIfbTiXqkX7YGmKhTU=;
        b=YBm/huXrmonzoeU19Ad72K0dEAs3VK62A7slkdpXYxGDK1kIjwNsg8O+TDRkzIsqG2MojN
        ik3ARAtJcLm2rJCQ==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 098C013A72;
        Mon,  1 Aug 2022 15:27:55 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id wxNFAvvw52KzdQAAMHmgww
        (envelope-from <bp@suse.de>); Mon, 01 Aug 2022 15:27:55 +0000
Date:   Mon, 1 Aug 2022 17:27:50 +0200
From:   Borislav Petkov <bp@suse.de>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     x86-ml <x86@kernel.org>, lkml <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] x86/kdump for v6.0
Message-ID: <Yufw9vdoONCXEiE7@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

please pull two x86/kdump updates for 6.0.

That branch will conflict a bit with the previous x86/build pull, the
resolution is simple though (courtesy of mingo):

Merge: 68b8e9713c8e 2d17bd24b016
Author: Ingo Molnar <mingo@kernel.org>
Date:   Tue Jul 26 09:06:10 2022 +0200

    Merge branch 'x86/build' into x86/kdump, to resolve conflict
    
    The following commit in x86/build made the use of BUILD_BIN2C unnecessary:
    
      2d17bd24b016 ("x86/purgatory: Omit use of bin2c")
    
    Propagate this to x86/kdump as well, where the following commit
    modified the same "config KEXEC_FILE" block:
    
      b69a2afd5afc ("x86/kexec: Carry forward IMA measurement log on kexec")
    
     Conflicts:
            arch/x86/Kconfig
    
    Signed-off-by: Ingo Molnar <mingo@kernel.org>

diff --cc arch/x86/Kconfig
index 670e0edc074f,901cb59d3a90..86969a880c77
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@@ -2032,8 -2032,6 +2032,7 @@@ config KEXE
  config KEXEC_FILE
  	bool "kexec file based system call"
  	select KEXEC_CORE
- 	select BUILD_BIN2C
 +	select HAVE_IMA_KEXEC if IMA
  	depends on X86_64
  	depends on CRYPTO=y
  	depends on CRYPTO_SHA256=y

Thx.

---

The following changes since commit 32346491ddf24599decca06190ebca03ff9de7f8:

  Linux 5.19-rc6 (2022-07-10 14:40:51 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git tags/x86_kdump_for_v6.0_rc1

for you to fetch changes up to 68b8e9713c8ec90af93c16e1de51cca18cefdb56:

  x86/setup: Use rng seeds from setup_data (2022-07-11 09:59:31 +0200)

----------------------------------------------------------------
- Add the ability to pass early an RNG seed to the kernel from the boot
loader

- Add the ability to pass the IMA measurement of kernel and bootloader
to the kexec-ed kernel

----------------------------------------------------------------
Borislav Petkov (1):
      Merge tag 'v5.19-rc6' into tip:x86/kdump

Jason A. Donenfeld (1):
      x86/setup: Use rng seeds from setup_data

Jonathan McDowell (1):
      x86/kexec: Carry forward IMA measurement log on kexec

 arch/x86/Kconfig                      |  1 +
 arch/x86/include/uapi/asm/bootparam.h | 15 +++++--
 arch/x86/kernel/e820.c                |  6 +--
 arch/x86/kernel/kexec-bzimage64.c     | 74 +++++++++++++++++++++++++++++++++--
 arch/x86/kernel/setup.c               | 73 ++++++++++++++++++++++++++++++++++
 drivers/of/kexec.c                    | 13 +++---
 include/linux/ima.h                   |  5 +++
 include/linux/of.h                    |  2 -
 security/integrity/ima/ima_kexec.c    |  2 +-
 9 files changed, 171 insertions(+), 20 deletions(-)

-- 
Regards/Gruss,
    Boris.

SUSE Software Solutions Germany GmbH
GF: Ivo Totev, Andrew Myers, Andrew McDonald, Martje Boudien Moerman
(HRB 36809, AG Nürnberg)
