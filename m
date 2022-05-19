Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE9A52D687
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 16:57:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240033AbiESO5Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 10:57:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbiESO5W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:57:22 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BC512AAB;
        Thu, 19 May 2022 07:57:21 -0700 (PDT)
Received: from zn.tnic (p200300ea97465796329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:9746:5796:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id BC7BC1EC02B9;
        Thu, 19 May 2022 16:57:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1652972235;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=QM2AgS8b+x3vZSsAInR6w+0gUR0YyrK19nFDcbeaQwI=;
        b=ZA+YWwk7WITPRgs/b+BJXGlIk8LDT6Td88JnA6PfEiV7kwo0+t6Z1wYmhdG3i1+KROq1Pr
        fdW7Xy7fTmpao/U0V6vHcFyMcKG8WIZ+Z8o1xDO/KyF10p+uoDzu/YdT7ehsvNSkSCbDgC
        bKXSgFZaBK+gOgmc1i8QAgD74QhvAxo=
Date:   Thu, 19 May 2022 16:57:15 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        X86 ML <x86@kernel.org>, Tony Luck <tony.luck@intel.com>
Subject: [PATCH] platform/x86/intel/ifs: Add CPU_SUP_INTEL dependency
Message-ID: <YoZay8YR0zRGyVu+@zn.tnic>
References: <20220518202934.730a8aba@canb.auug.org.au>
 <8ead0da9-9545-b10d-e3db-7df1a1f219e4@infradead.org>
 <YoVlwN/IeVXoMaq1@zn.tnic>
 <df5ed1d0-6304-89b8-ad68-0cf6a59d8614@infradead.org>
 <YoVzUxSwhoim9TOX@zn.tnic>
 <65f17e84-83e4-c33a-1718-fbb5841cef46@infradead.org>
 <YoZaZ+HVyjKrwtSQ@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YoZaZ+HVyjKrwtSQ@zn.tnic>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Borislav Petkov <bp@suse.de>

The driver is using functions from a compilation unit which is enabled
by CONFIG_CPU_SUP_INTEL. Add that dependency to Kconfig explicitly
otherwise:

  drivers/platform/x86/intel/ifs/load.o: in function `ifs_load_firmware':
  load.c:(.text+0x3b8): undefined reference to `intel_cpu_collect_info'

Reported-by: Randy Dunlap <rdunlap@infradead.org>
Signed-off-by: Borislav Petkov <bp@suse.de>
---
 drivers/platform/x86/intel/ifs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/platform/x86/intel/ifs/Kconfig b/drivers/platform/x86/intel/ifs/Kconfig
index d84491cfb0db..7ce896434b8f 100644
--- a/drivers/platform/x86/intel/ifs/Kconfig
+++ b/drivers/platform/x86/intel/ifs/Kconfig
@@ -1,6 +1,6 @@
 config INTEL_IFS
 	tristate "Intel In Field Scan"
-	depends on X86 && 64BIT && SMP
+	depends on X86 && CPU_SUP_INTEL && 64BIT && SMP
 	select INTEL_IFS_DEVICE
 	help
 	  Enable support for the In Field Scan capability in select
-- 
2.35.1

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
