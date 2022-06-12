Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4F40547A32
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 14:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236844AbiFLMzs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 08:55:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231398AbiFLMzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 08:55:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9E5DF3D1E4
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655038545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=QIKykbyrNNm1Wral+I5eFaur3PFJU57q+42L2hj1KHI=;
        b=ZYth8s/qLV2mswZOYUkan2Jc3y5QwOBcA0E8oycBHvi3oHw08C45n3fyjQdV/djYlWADZX
        TrhyvV7mnAtklASPT6xek09WxBwq1YKDllD9l5WlmGVP1iukwwPZ1q9LC/Axogm3NK9zbA
        ICqlAkQnUguwj7bQmv2KWetM962bbio=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-142-XsczC9GtO1yvUfRqTV-5xQ-1; Sun, 12 Jun 2022 08:55:44 -0400
X-MC-Unique: XsczC9GtO1yvUfRqTV-5xQ-1
Received: by mail-ej1-f69.google.com with SMTP id gh36-20020a1709073c2400b0070759e390fbso911046ejc.13
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jun 2022 05:55:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=QIKykbyrNNm1Wral+I5eFaur3PFJU57q+42L2hj1KHI=;
        b=5oqw5r5offvVNwp59pv2zkUFbKUqd9VrwsPSDwJfHmAnRYv0iZ5h6rJiXgzUT+IUXr
         Kk1BL8Hk1jG+5Rjt5Nfw5EgkS3vRKU8yFr5wq1F+gQXIih79okDAx0pwojJzEnG8AC8u
         Ekl/FsxfUbJvZuR0wa9U4Ynms4Lz6zuSUoJkVYCkwWpaPAzXJMJAaam82PldCBBWnIKF
         TiR74TokyGWE1jMqC/r/AQn3mXmmx4AoC0yH4kDCTnIFI3Pq9HTYPmdv933MhGoGHV2O
         kNGKRztaHXS11frtNKo5RtL/C+0nIEWkoRgGiG3kjI07+3GIHqUcM08EvvCxyoTi3gsj
         6c8Q==
X-Gm-Message-State: AOAM532DEBOnIQi8eDWKgzHu8d/D/wbN3zdz2vOMtzSQA2qbG0Pr2s1W
        ox471JTyYqok/8EE98RMsiRW9uivK4cU8SZLrSHJYPlvgP4j6P+e2rATzIUNJxj8ePw/rGi4f2s
        bFRja6R/RWHMSRz7dKGOXD3eY
X-Received: by 2002:a17:906:544e:b0:6f3:bd59:1a93 with SMTP id d14-20020a170906544e00b006f3bd591a93mr47998350ejp.421.1655038542920;
        Sun, 12 Jun 2022 05:55:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGda6jV94ijBtpP/dvyylDlakPx3jOjzohspNDADS+WXZHsHx4rhqSbiG5HQuAprOuJtlJ+w==
X-Received: by 2002:a17:906:544e:b0:6f3:bd59:1a93 with SMTP id d14-20020a170906544e00b006f3bd591a93mr47998343ejp.421.1655038542745;
        Sun, 12 Jun 2022 05:55:42 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id fu9-20020a170907b00900b006feb875503fsm2428972ejc.78.2022.06.12.05.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 Jun 2022 05:55:42 -0700 (PDT)
Message-ID: <8c5b557d-7e6b-cbb7-316b-f26c567b08cd@redhat.com>
Date:   Sun, 12 Jun 2022 14:55:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
From:   Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] platform-drivers-x86 for 5.19-2
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Mark Gross <mgross@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here is the first round of fixes for platform-drivers-x86 for 5.19:

 -  Fix hp-wmi regression on HP Omen laptops introduced in 5.18
 -  Several hardware-id additions
 -  A couple of other tiny fixes

Regards,

Hans


The following changes since commit f2906aa863381afb0015a9eb7fefad885d4e5a56:

  Linux 5.19-rc1 (2022-06-05 17:18:54 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/pdx86/platform-drivers-x86.git tags/platform-drivers-x86-v5.19-2

for you to fetch changes up to d4fe9cc4ff8656704b58cfd9363d7c3c9d65e519:

  platform/x86/intel: hid: Add Surface Go to VGBS allow list (2022-06-12 14:41:17 +0200)

----------------------------------------------------------------
platform-drivers-x86 for v5.19-2

Highlights:
 -  Fix hp-wmi regression on HP Omen laptops introduced in 5.18
 -  Several hardware-id additions
 -  A couple of other tiny fixes

The following is an automated git shortlog grouped by driver:

barco-p50-gpio:
 -  Add check for platform_driver_register

gigabyte-wmi:
 -  Add support for B450M DS3H-CF
 -  Add Z690M AORUS ELITE AX DDR4 support

hp-wmi:
 -  Use zero insize parameter only when supported
 -  Resolve WMI query failures on some devices

platform/mellanox:
 -  Add static in struct declaration.
 -  Spelling s/platfom/platform/

platform/x86/intel:
 -  hid: Add Surface Go to VGBS allow list
 -  pmc: Support Intel Raptorlake P
 -  Fix pmt_crashlog array reference

----------------------------------------------------------------
August Wikerfors (1):
      platform/x86: gigabyte-wmi: Add support for B450M DS3H-CF

Bedant Patnaik (1):
      platform/x86: hp-wmi: Use zero insize parameter only when supported

David Arcari (1):
      platform/x86/intel: Fix pmt_crashlog array reference

Duke Lee (1):
      platform/x86/intel: hid: Add Surface Go to VGBS allow list

Geert Uytterhoeven (1):
      platform/mellanox: Spelling s/platfom/platform/

George D Sworo (1):
      platform/x86/intel: pmc: Support Intel Raptorlake P

Jiasheng Jiang (1):
      platform/x86: barco-p50-gpio: Add check for platform_driver_register

Jorge Lopez (1):
      platform/x86: hp-wmi: Resolve WMI query failures on some devices

Michael Shych (1):
      platform/mellanox: Add static in struct declaration.

Piotr Chmura (1):
      platform/x86: gigabyte-wmi: Add Z690M AORUS ELITE AX DDR4 support

 drivers/platform/mellanox/Kconfig         |  2 +-
 drivers/platform/mellanox/nvsw-sn2201.c   |  2 +-
 drivers/platform/x86/barco-p50-gpio.c     |  5 ++++-
 drivers/platform/x86/gigabyte-wmi.c       |  2 ++
 drivers/platform/x86/hp-wmi.c             | 29 +++++++++++++++++++----------
 drivers/platform/x86/intel/hid.c          |  6 ++++++
 drivers/platform/x86/intel/pmc/core.c     |  1 +
 drivers/platform/x86/intel/pmt/crashlog.c |  2 +-
 8 files changed, 35 insertions(+), 14 deletions(-)

