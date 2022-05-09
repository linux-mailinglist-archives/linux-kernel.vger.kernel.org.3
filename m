Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E52C51F5BF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236774AbiEIHdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234780AbiEIHdK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:33:10 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A88FFE70
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 00:29:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652081274;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=V2c9vBmEzL9GnOTwGUFGbuZHpMHymiK976kVFmr4dm0=;
        b=ZddCWJR8NsmBNVhcHBJSojocLLv+JlfPIf/oPTmo7yjInCa/Fb7rMZqAwWAFIzNEAa6M55
        Ic8BgKbgVuN7DsjADUv+IkDeXcPobnkh9Uk/bp58b+/EFL312HPJCFiN2QjdI4GJz5ux2Y
        ujr0USkV1g0Y8LuYPd+mLY2jtia5tVY=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-0EVxRxb_N_qXiPscsywzSQ-1; Mon, 09 May 2022 03:27:53 -0400
X-MC-Unique: 0EVxRxb_N_qXiPscsywzSQ-1
Received: by mail-ed1-f72.google.com with SMTP id k13-20020a50ce4d000000b00425e4447e64so7801129edj.22
        for <linux-kernel@vger.kernel.org>; Mon, 09 May 2022 00:27:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=V2c9vBmEzL9GnOTwGUFGbuZHpMHymiK976kVFmr4dm0=;
        b=HSEWLW4y0dTU63VeRGo77bFRx0NKKS85LZRaJDZBKaRyImLV19yMYJJdYSpE8bC62D
         vIYuzHxrAa2i9JGsAKeitA1bZGGW/a3uBIAfENiuYSebcbmf9ADAbbXrINpWle4XjZe2
         xOEBu8jdGILgN2WbeTbx6AtJWqKVcpm+jvCk+YCYvoL4hIx+rGv+PNDAiRX7r4J7DGcX
         TnjaDBnv1pMdrVnTwBRsTUiyNRw95td/Gi+/BCKAM1RwfHcMBNkBPLko8zfLHTGR1tJ/
         EcchPVEQPW83FMyTLT5lWz6aWkRgFnKhxnCfNPOTICIRofXAlMjy3fI+NOZOngz9AJBa
         D6SA==
X-Gm-Message-State: AOAM5331uyZkSkb32KsW3ZKSeMG3sdfDHnCGhwKSqdzftfL/cLUt6Sfp
        EO1RNIkpgCyAABCEZvhtkdoTWL8ujbr2riSmZWFSzKbDCn1cLXgc2qFOsA8BezcRYmOvVOs/fu2
        VH6pr+oeDvco9RICTm1/JGUB2
X-Received: by 2002:a05:6402:4256:b0:428:39:c6c7 with SMTP id g22-20020a056402425600b004280039c6c7mr15465373edb.374.1652081272625;
        Mon, 09 May 2022 00:27:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxtLYjqjd+JSRhyz+2aHDlDZujkKSuS44yxRLRXeGdCffdJgodAPLKfV+vb4QTZPqFG8D2GdQ==
X-Received: by 2002:a05:6402:4256:b0:428:39:c6c7 with SMTP id g22-20020a056402425600b004280039c6c7mr15465361edb.374.1652081272439;
        Mon, 09 May 2022 00:27:52 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id k14-20020aa7c04e000000b0042617ba639asm5967014edo.36.2022.05.09.00.27.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 00:27:52 -0700 (PDT)
Message-ID: <d9007c58-71a2-e081-c609-fbf04855b591@redhat.com>
Date:   Mon, 9 May 2022 09:27:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.18-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is a third round of bug-fixes for platform-drivers-x86
for 5.18:

 -  thinkpad_acpi AMD suspend/resume + fan detection fixes
 -  2 other small fixes
 -  1 hardware-id addition

Regards,

Hans


The following changes since commit eb2fd9b43fae0c51982ac4229535b6cfd77380db:

  platform/x86/intel: pmc/core: change pmc_lpm_modes to static (2022-04-27 16:55:54 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.18-4

for you to fetch changes up to 44acfc22c7d055d9c4f8f0974ee28422405b971a:

  platform/surface: aggregator: Fix initialization order when compiling as builtin module (2022-05-06 13:05:57 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.18-4

3th set of pdx86 fixes for 5.18:
 -  thinkpad_acpi AMD suspend/resume + fan detection fixes
 -  2 other small fixes
 -  1 hardware-id addition

The following is an automated git shortlog grouped by driver:

platform/surface:
 -  aggregator: Fix initialization order when compiling as builtin module
 -  gpe: Add support for Surface Pro 8

platform/x86/intel:
 -  Fix 'rmmod pmt_telemetry' panic

thinkpad_acpi:
 -  Correct dual fan probe
 -  Add a s2idle resume quirk for a number of laptops
 -  Convert btusb DMI list to quirks

----------------------------------------------------------------
Mario Limonciello (2):
      platform/x86: thinkpad_acpi: Convert btusb DMI list to quirks
      platform/x86: thinkpad_acpi: Add a s2idle resume quirk for a number of laptops

Mark Pearson (1):
      platform/x86: thinkpad_acpi: Correct dual fan probe

Maximilian Luz (2):
      platform/surface: gpe: Add support for Surface Pro 8
      platform/surface: aggregator: Fix initialization order when compiling as builtin module

Prarit Bhargava (1):
      platform/x86/intel: Fix 'rmmod pmt_telemetry' panic

 drivers/platform/surface/aggregator/core.c |   2 +-
 drivers/platform/surface/surface_gpe.c     |   8 ++
 drivers/platform/x86/intel/pmt/telemetry.c |   2 +-
 drivers/platform/x86/thinkpad_acpi.c       | 175 +++++++++++++++++++++++++++--
 4 files changed, 173 insertions(+), 14 deletions(-)

