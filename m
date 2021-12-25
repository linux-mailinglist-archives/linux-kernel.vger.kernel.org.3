Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6458D47F31A
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 12:55:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231537AbhLYLzY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 06:55:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:52218 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhLYLzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 06:55:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640433321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=RbCIMAxVv0JrkVhM1hLvHjr9m59Zew8mLy6AboiFJEQ=;
        b=Uordj6EZbaR4jUprqhRxxGBWHqlaer56/3VyFHtMmHh5dny9yV4FGWcv8xvH/ICiD6vUCi
        44pRiC7zT5EfyevkJgyidYSvQynG6K6Q8McFAmzQWiX8YBIcYWUVtGC+Ss0uCLR9CDU0F8
        XxAPM/Ab5gD8+V05SMI8la4SF+RXLxE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-564-H8jtbGdVPv6HOPxkY4GMtw-1; Sat, 25 Dec 2021 06:55:16 -0500
X-MC-Unique: H8jtbGdVPv6HOPxkY4GMtw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4EB041006AA8;
        Sat, 25 Dec 2021 11:55:15 +0000 (UTC)
Received: from shalem.redhat.com (unknown [10.39.192.12])
        by smtp.corp.redhat.com (Postfix) with ESMTP id CED8E7ADB4;
        Sat, 25 Dec 2021 11:55:09 +0000 (UTC)
From:   Hans de Goede <hdegoede@redhat.com>
To:     Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andy@infradead.org>,
        Lee Jones <lee.jones@linaro.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/4] mfd: intel_soc_pmic_crc: Add crystal_cove_charger cell
Date:   Sat, 25 Dec 2021 12:55:05 +0100
Message-Id: <20211225115509.94891-1-hdegoede@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi All,

While doing a hobby project getting the mainline kernel to work on some
x86 tablets which come with Android pre-installed and which clearly have
never been meant to run Windows (or another generic OS) I encountered an
interesting setup for the bq24190 charger chip IRQ, it is not connected
to the main Bay Trail SoC, instead it runs through a special
external-charger IRQ pin on the CRC PMIC.

This series adds support for that.

Lee, patch 4/4 is included mostly FYI. It depends on current pdx86/for-next
and I plan to merge it through the pdx86 tree.

Patches 1-3 can be merged through the MFD tree indepdently.

Regards,

Hans


Hans de Goede (4):
  mfd: intel_soc_pmic_crc: Sort cells by IRQ order
  mfd: intel_soc_pmic_crc: Add crystal_cove_charger cell to BYT cells
  mfd: intel_soc_pmic_crc: Set main IRQ domain bus token to
    DOMAIN_BUS_NEXUS
  platform/x86: Add crystal_cove_charger driver

 drivers/mfd/intel_soc_pmic_core.c           |   4 +
 drivers/mfd/intel_soc_pmic_crc.c            |  35 +++--
 drivers/platform/x86/Makefile               |   2 +-
 drivers/platform/x86/crystal_cove_charger.c | 153 ++++++++++++++++++++
 4 files changed, 180 insertions(+), 14 deletions(-)
 create mode 100644 drivers/platform/x86/crystal_cove_charger.c

-- 
2.33.1

