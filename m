Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA2564C587A
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 23:17:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiBZWHl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 17:07:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiBZWHh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 17:07:37 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F2C32BA9C3;
        Sat, 26 Feb 2022 14:07:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B8AB6102D;
        Sat, 26 Feb 2022 22:06:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6EF7C340E8;
        Sat, 26 Feb 2022 22:06:57 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="LzsRMBNg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1645913215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=01UTf7O373LIbwYDGLgA49GLqG6GmaXy+U95oNhQ3+0=;
        b=LzsRMBNg6OFO5ODbemd2Twz9Q4lUpxgd3FtxsZbsMVnon4+5vRpPBE7d5D5+C7pfX+gRkN
        FXisqHN6Jsa0bevElU/eGrkOZgPdPEky0q8n04HaKD8QrtuMiEb0mqGDD3E2El6PR5z1ka
        llHnwCaG5A6hoj7ldhOzOiJk8mSWdTU=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id ada8a9c2 (TLSv1.3:AEAD-AES256-GCM-SHA384:256:NO);
        Sat, 26 Feb 2022 22:06:55 +0000 (UTC)
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
To:     Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Cc:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-crypto@vger.kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Alexander Graf <graf@amazon.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH v5 0/3] ACPI: VM fork detection for RNG
Date:   Sat, 26 Feb 2022 23:06:36 +0100
Message-Id: <20220226220639.1173594-1-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rafael & Len,

This patchset is directed toward you two specifically. Patches 1/3 and
3/3 have been through the ringer of review a bit already and do not
specifically require your attention, but in v4 we wound up getting hung
up on an ACPI API limitation. This v5 fixes that limitation with its 2/3
patch, with a trivial one line fix, which does require your attention.

Patches 1/3 and 3/3 will go through my random.git tree. However, 3/3
actually depends on 2/3 in order to compile without warnings (and be
functional at all). Therefore, it would be nice if you would provide an
"Acked-by" on it and permit me to /also/ take it through my random.git
tree (if it looks like a correct patch to you, of course). This would
make the merge logistics a lot easier. Plus it's a small +1/-1 line
change.

Please have a look and let me know what you think.

Thanks,
Jason

Cc: linux-crypto@vger.kernel.org
Cc: linux-acpi@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: Alexander Graf <graf@amazon.com>
Cc: Ard Biesheuvel <ardb@kernel.org>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Alexander Graf (1):
  ACPI: allow longer device IDs

Jason A. Donenfeld (2):
  random: add mechanism for VM forks to reinitialize crng
  virt: vmgenid: introduce driver for reinitializing RNG on VM fork

 MAINTAINERS                     |   1 +
 drivers/char/random.c           |  50 +++++++++++-----
 drivers/virt/Kconfig            |  11 ++++
 drivers/virt/Makefile           |   1 +
 drivers/virt/vmgenid.c          | 100 ++++++++++++++++++++++++++++++++
 include/linux/mod_devicetable.h |   2 +-
 include/linux/random.h          |   1 +
 7 files changed, 150 insertions(+), 16 deletions(-)
 create mode 100644 drivers/virt/vmgenid.c

-- 
2.35.1

