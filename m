Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE2164E6739
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 17:47:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351784AbiCXQtQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 12:49:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235237AbiCXQtO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 12:49:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 934189F39C
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 09:47:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648140461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=UpCGOPzrBlCTuSLxyy7t5OA4eAmMttPs1iO1RjGpOPM=;
        b=Thl8aXPzIMvtIuY3+Kuz/kd7nIKtrypz+pG4M57XUBBuycCZH34y3Q+bLGs6slhRhD96Ir
        i5eUvHo8YWBSl+bs4NE/vwIGasco35eHG06rmtH2e6daVB8pF1Ifp2HCPcJ0PbG71+Iw+q
        4SJh68STnVq0LeyNkGJouiVxMvV4VEg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-322-dIf3rhLWMo-LZ_2lu4oU5Q-1; Thu, 24 Mar 2022 12:47:40 -0400
X-MC-Unique: dIf3rhLWMo-LZ_2lu4oU5Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C810E1C05AE0;
        Thu, 24 Mar 2022 16:47:39 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.132])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 49797417E32;
        Thu, 24 Mar 2022 16:47:38 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@kernel.org>,
        Mark Pearson <markpearson@lenovo.com>,
        "David E . Box" <david.e.box@linux.intel.com>,
        =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>,
        Sebastian Reichel <sre@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH 0/4] Documentation/ABI: platform/x86: Sphinx warning fixes
Date:   Thu, 24 Mar 2022 17:47:33 +0100
Message-Id: <20220324164737.21765-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
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

