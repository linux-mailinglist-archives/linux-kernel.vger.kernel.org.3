Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A37315430CB
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239613AbiFHMtm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 08:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239570AbiFHMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 08:49:40 -0400
Received: from mx1.tq-group.com (mx1.tq-group.com [93.104.207.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2291119A73D;
        Wed,  8 Jun 2022 05:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692577; x=1686228577;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bTEuPpHCpiyWA+h54w2IRHDnZA08e2LOl8H6omyG5ls=;
  b=HW5rjhqAslC+jlLuT4HG4HCc6dtVVPX5gi7d48CYbQHm0YR3jTBXq7zA
   GFZZLSWEbhFpcpj6Bf6j2Vf/ELYMEMSYe0rEDTMIkjFTR5AHGFSVSsqBk
   QeLImPSA8uHjgY7Nmqdj3KD4FKKaJF12q9phW51H6S7op3zuhuINLjIBW
   iGC4Ndc7UvnUqeUzgkX5f/NAEWUshF+oxZMvNkb6ABWEGQm+l7oApOtxV
   SQ4yTgEaDk0Wd+1sTNfL0mEs68AJR9y2S3jphHl1i1P64Xd1C/0oiMLid
   WKYontTOmGvGokCxDLbrG0QN+GuEjzzF79QKBVVRD1N4stPQtORgu7+2W
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330534"
Received: from unknown (HELO tq-pgp-pr1.tq-net.de) ([192.168.6.15])
  by mx1-pgp.tq-group.com with ESMTP; 08 Jun 2022 14:49:30 +0200
Received: from mx1.tq-group.com ([192.168.6.7])
  by tq-pgp-pr1.tq-net.de (PGP Universal service);
  Wed, 08 Jun 2022 14:49:30 +0200
X-PGP-Universal: processed;
        by tq-pgp-pr1.tq-net.de on Wed, 08 Jun 2022 14:49:30 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=tq-group.com; i=@tq-group.com; q=dns/txt; s=key1;
  t=1654692570; x=1686228570;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=bTEuPpHCpiyWA+h54w2IRHDnZA08e2LOl8H6omyG5ls=;
  b=YV9FS4sqgiNROgYj4JMYVPyOKjsfgLrJYgyo6fNHcLmGNvRmPpQd9zit
   /SScDTYBxF2BqHp7+YUHzIZaTXxu95rUChYJdHTujsgoDuba3RlAqC8nD
   vp0L+zb0h531TyXr1POl9ATB3hyFgWywBYziY5AklDJKaRmjTCBXRfafE
   u6Wpu72FzxBsSC0FHLBMt8j+hKZfWSIJA6sRuI4kxDDNJQEgKhpi22a5t
   u2BvvEL7KQ3sUUdyhIwqYT8jOI27aavkZ3EworN/PX5frBr5ne0iWH2R1
   5fqJmLzg+wJ05HBEKZOl4ZjSHL8TUOcXwb6OCOJkjjJq4bfizKveYY2jZ
   Q==;
X-IronPort-AV: E=Sophos;i="5.91,286,1647298800"; 
   d="scan'208";a="24330533"
Received: from vtuxmail01.tq-net.de ([10.115.0.20])
  by mx1.tq-group.com with ESMTP; 08 Jun 2022 14:49:30 +0200
Received: from localhost.localdomain (SCHIFFERM-M2.tq-net.de [10.121.49.136])
        by vtuxmail01.tq-net.de (Postfix) with ESMTPA id 5E100280056;
        Wed,  8 Jun 2022 14:49:30 +0200 (CEST)
From:   Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Lyude Paul <lyude@redhat.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org,
        Matthias Schiffer <matthias.schiffer@ew.tq-group.com>
Subject: [PATCH 0/9] Input: synaptics-rmi4 - Bootloader v7/v8 firmware update improvements
Date:   Wed,  8 Jun 2022 14:47:59 +0200
Message-Id: <20220608124808.51402-1-matthias.schiffer@ew.tq-group.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes the firmware update function with bootloader v8, allows to
recover from interrupted updates with v7/v8, and does some code cleanup.

I believe that the code that allows to recover from a broken partition
table is also necessary to make flashing a different partition table
work at all, but I wasn't able to verify that, as I don't have any firmware
images with different partition tables to test with. In any case, I'm
pretty sure that it is working correctly now, as recovery from a mostly
empty flash without partition table has been tested successfully.

I have only tested the new code with bootloader v8, and I don't have the
documentation / interfacing guide for v7, so it would be great if anyone
could check that I didn't break updates for v7.


Matthias Schiffer (9):
  Input: synaptics-rmi4 - fix firmware update operations with bootloader
    v8
  Input: synaptics-rmi4 - introduce rmi_f34v7_check_command_status()
    helper
  Input: synaptics-rmi4 - fix command completion check for bootloader
    v7/v8
  Input: synaptics-rmi4 - rewrite partition table unconditionally
  Input: synaptics-rmi4 - reset after writing partition table
  Input: synaptics-rmi4 - make rmi_f34v7_erase_all() use the "erase all"
    command
  Input: synaptics-rmi4 - remove unneeded struct register_offset
  Input: synaptics-rmi4 - simplify rmi_f34v7_start_reflash()
  Input: synaptics-rmi4 - drop useless gotos in rmi_f34v7_do_reflash()

 drivers/input/rmi4/rmi_f34.c   |  16 +-
 drivers/input/rmi4/rmi_f34.h   |  17 --
 drivers/input/rmi4/rmi_f34v7.c | 349 +++++++--------------------------
 3 files changed, 81 insertions(+), 301 deletions(-)

-- 
2.25.1

