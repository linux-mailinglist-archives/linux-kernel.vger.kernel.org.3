Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B1A84C2DA5
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 14:55:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbiBXNyg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 08:54:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiBXNye (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 08:54:34 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E523113C3B4
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:54:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645710844;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=feRIEn1EMTywS/YZ2elPMkem2Aupjr0V2pvxGMXyLJA=;
        b=ANr0mFTd5rjkjK8P+fGzbEG+tUwzB1qxAYnFhg6lu6/c1nnaW8imdLzXyP52d4UrIZ+jfA
        GW5KaW3G+E0neGsbk/5EVPEvBcxqRwlTSCawNJLkSU6Dc8SHqYe3UtGAcrsbnb8G0SUHyC
        nx0qpPbbboU2Q/lNHgiEKSLC9898qqM=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-227-WBPECP4nNYqbhYY8JPzAGQ-1; Thu, 24 Feb 2022 08:54:02 -0500
X-MC-Unique: WBPECP4nNYqbhYY8JPzAGQ-1
Received: by mail-ej1-f71.google.com with SMTP id la22-20020a170907781600b006a7884de505so1248632ejc.7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 05:54:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=feRIEn1EMTywS/YZ2elPMkem2Aupjr0V2pvxGMXyLJA=;
        b=UzsDjYUVlf5TtkvT6tYd56b9lLNjo8ChXmjtkBj4L7KeGCkDK2m4X8c9fEBf9XODUT
         daYHQ5z58cEKo6GDm0NyChaWwgxgk2injjsFIh85d5lxP432p2t5CuKwDroqu1rAEdGA
         rNuS/XCMFG5EVz2UWgtKBl+gh3OEavxwIo1Q7HcELERDEvB6xAUigDmLYBLXNv4vlJqo
         6n7kOedZaqh4qG2OiFoPBWDvxRrK6yUHPbF9b0zdmuc+ml0T7D/7kPbLUXCTR6/whHrx
         ZJl8KNcVFieaJAgIA2a0QIbSmOF6PvOzmHFybcPKyGv9iz7ND+b+Tnmh8IjLo9qa1rLG
         AZ5A==
X-Gm-Message-State: AOAM530nsgaJ9iy9FuFaLuuv5vKV3KB/65bNDkMDIjXICX7w0qjuhPUM
        gzYgN94MwlMi+qaiUny0ZCnTicf1Rql74PoFjxsSzrJOgVGl/KP/L3Jwb6I/doW5T2Hgar95hg2
        feolr4wx2M/mPpAph2kT0aTK2
X-Received: by 2002:a05:6402:294e:b0:40f:905b:dab5 with SMTP id ed14-20020a056402294e00b0040f905bdab5mr2406923edb.103.1645710841534;
        Thu, 24 Feb 2022 05:54:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwoCnD4zV3OaNb0QEnnNVFM30U+N2AP2i9f7OL+iW7JbQVkIf4rYvgG8Fud0UtUx/4zPLvqHg==
X-Received: by 2002:a05:6402:294e:b0:40f:905b:dab5 with SMTP id ed14-20020a056402294e00b0040f905bdab5mr2406910edb.103.1645710841294;
        Thu, 24 Feb 2022 05:54:01 -0800 (PST)
Received: from ?IPV6:2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1? (2001-1c00-0c1e-bf00-1db8-22d3-1bc9-8ca1.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:1db8:22d3:1bc9:8ca1])
        by smtp.gmail.com with ESMTPSA id 18sm1395613ejj.1.2022.02.24.05.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 05:54:00 -0800 (PST)
Message-ID: <0cacb607-64a1-47de-7cf4-294d89045806@redhat.com>
Date:   Thu, 24 Feb 2022 14:54:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.17-4
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is another set of 2 bug-fixes for platform-drivers-x86
for 5.17:

 -  Fix suspend/resume regression on AMD Cezanne APUs in >= 5.16
 -  Fix Microsoft Surface 3 battery readings

Regards,

Hans


The following changes since commit ae09639e3b2a0291b37b122c94dd4f773cd4e513:

  platform/x86: int3472: Add terminator to gpiod_lookup_table (2022-02-21 14:47:59 +0100)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.17-4

for you to fetch changes up to 21d90aaee8d5c2a097ef41f1430d97661233ecc6:

  surface: surface3_power: Fix battery readings on batteries without a serial number (2022-02-24 13:48:39 +0100)

----------------------------------------------------------------
platform-drivers-x86 for v5.17-4

2 fixes:
 -  Fix suspend/resume regression on AMD Cezanne APUs in >= 5.16
 -  Fix Microsoft Surface 3 battery readings

The following is an automated git shortlog grouped by driver:

amd-pmc:
 -  Set QOS during suspend on CZN w/ timer wakeup

surface:
 -  surface3_power: Fix battery readings on batteries without a serial number

----------------------------------------------------------------
Hans de Goede (1):
      surface: surface3_power: Fix battery readings on batteries without a serial number

Mario Limonciello (1):
      platform/x86: amd-pmc: Set QOS during suspend on CZN w/ timer wakeup

 drivers/platform/surface/surface3_power.c | 13 +++++++---
 drivers/platform/x86/amd-pmc.c            | 42 ++++++++++++++++++++++++-------
 2 files changed, 43 insertions(+), 12 deletions(-)

