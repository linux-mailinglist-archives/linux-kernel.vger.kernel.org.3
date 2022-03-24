Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E4DD4E6737
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:47:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351779AbiCXQsk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:48:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiCXQsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:48:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CD7FB9F39C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:47:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648140426;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UpCGOPzrBlCTuSLxyy7t5OA4eAmMttPs1iO1RjGpOPM=;
        b=BOTzXS5axYehkBji1q8aOlaYiXM5cY8HKKIC4sUEBtW0T+Wmp7VkEGpApUxfq9yKiLl7pI
        IzxKI/kpY8dcjbFc5sac7amik+5ekHU4eyrdxWlKK5bk4Qsc1cGVu+Qbiagal+0bpL1QsA
        0zeTBY0X/rczshy3ESff7Z+/2IwEMEU=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-58-sLUBI_nLOv2CuHEM17eIlA-1; Thu, 24 Mar 2022 12:46:59 -0400
X-MC-Unique: sLUBI_nLOv2CuHEM17eIlA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E4BD380670D;
        Thu, 24 Mar 2022 16:46:59 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7DFD840D2853;
        Thu, 24 Mar 2022 16:46:57 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/4] Documentation/ABI: platform/x86: Sphinx warning fixes
Date:   Thu, 24 Mar 2022 17:46:52 +0100
Message-Id: <20220324164656.21725-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

After Stephen reported some Sphinx warnings for files under
Documentation/ABI/testing, I had to first figure out how to reproduce
these. It turns out that to regenerate the htmldocs for files under
Documentation/ABI/testing once has to run:

touch Documentation/admin-guide/abi-testing.rst && make htmldocs

This turned up warnings in multiple sysfs ABI files for platform/x86
drivers, as well as in some new functionality in sysfs-class-power,
which was merged through the platform-drivers-x86 tree.

I plan to merge this series through the platform-drivers-x86 tree and
send this out in a fixed pull-req to Linus once 5.18-rc1 is out.

Regards,

Hans

p.s.

platform-drivers-x86 authors, for future patch submissions touching
files under Documentation/ABI/testing please run:

touch Documentation/admin-guide/abi-testing.rst && make htmldocs

and make sure no warnings are introduced.


Hans de Goede (4):
  Documentation/ABI: sysfs-driver-intel_sdsi: Fix sphinx warnings
  Documentation/ABI: sysfs-class-firmware-attributes: Fix Sphinx errors
  Documentation/ABI: sysfs-class-firmware-attributes: Misc. cleanups
  Documentation/ABI: sysfs-class-power: Fix Sphinx error

 .../testing/sysfs-class-firmware-attributes   | 48 ++++++++++---------
 Documentation/ABI/testing/sysfs-class-power   |  1 +
 .../ABI/testing/sysfs-driver-intel_sdsi       | 18 +++----
 3 files changed, 37 insertions(+), 30 deletions(-)

-- 
2.35.1

