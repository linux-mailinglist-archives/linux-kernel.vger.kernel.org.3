Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B06A4BEB20
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 20:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiBUTMJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 14:12:09 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232744AbiBUTME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 14:12:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE6A1AF10;
        Mon, 21 Feb 2022 11:11:39 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 186F0B81239;
        Mon, 21 Feb 2022 19:11:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34DC5C340E9;
        Mon, 21 Feb 2022 19:11:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645470696;
        bh=DkA8aPgi/+Xs3ZKPhsQKSJF8FSlF1+U60cOE9sfcDF4=;
        h=From:To:Cc:Subject:Date:From;
        b=cnF015ESh+yodrPHTjFevOIA50Vmyrkz9oGozW76VjSwul4mXTs2fTZ8iBjpnKIZM
         ag7FzQ/t9+wA85kfw7ytlfLPNu2if5luKn5rpnDCK8mbL7I7hr3eGXwYg5d+YmrX7v
         vvcJMtbjJRGw+l5xrb1T8D/WNLS0urAzSG2P6xMkJ7PzhH/1guIhIQ3Y2yIKkxQBR1
         k/NlNzEQgdboUAryHjJYMj9QiDq8frMT+0VjFjBc/PknfIimDGLsGM5OvnuGnGUSuc
         Yp0WseV0kKjsI9TTftSzY7QQmyISrP3hfQXqyF/muesmLiu+cYiD60K1QJzahrI9Pe
         r83BcOl7pbvcg==
From:   broonie@kernel.org
To:     Greg KH <greg@kroah.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: linux-next: manual merge of the driver-core tree with the battery tree
Date:   Mon, 21 Feb 2022 19:11:31 +0000
Message-Id: <20220221191131.1661101-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the driver-core tree got a conflict in:

  drivers/power/supply/ab8500_chargalg.c

between commits:

  75ee3f6f0c1a0 ("power: supply: ab8500_chargalg: Drop enable/disable sysfs")
  05906f58c8225 ("power: supply: ab8500_chargalg: Drop charging step")
  d662a7df36e1e ("power: supply: ab8500: Swap max and overvoltage")

from the battery tree and commit:

  a8e223094c7a8 ("power_supply: ab8500: use default_groups in kobj_type")

from the driver-core tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc drivers/power/supply/ab8500_chargalg.c
index b5a3096e78a14,64a3f5bbfff14..0000000000000
--- a/drivers/power/supply/ab8500_chargalg.c
+++ b/drivers/power/supply/ab8500_chargalg.c
@@@ -254,12 -279,12 +254,6 @@@ static enum power_supply_property ab850
  	POWER_SUPPLY_PROP_HEALTH,
  };
  
--struct ab8500_chargalg_sysfs_entry {
--	struct attribute attr;
--	ssize_t (*show)(struct ab8500_chargalg *di, char *buf);
--	ssize_t (*store)(struct ab8500_chargalg *di, const char *buf, size_t length);
--};
--
  /**
   * ab8500_chargalg_safety_timer_expired() - Expiration of the safety timer
   * @timer:     pointer to the hrtimer structure
