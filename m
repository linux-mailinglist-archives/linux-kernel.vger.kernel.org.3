Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E2F52DC2E
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 20:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiESSBv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 14:01:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243498AbiESSBq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 14:01:46 -0400
Received: from smtp1.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E6275A14F;
        Thu, 19 May 2022 11:01:44 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by smtp1.de.adit-jv.com (Postfix) with ESMTPS id 5ECC73C00BA;
        Thu, 19 May 2022 20:01:42 +0200 (CEST)
Received: from vmlxhi-121.localdomain (10.72.92.132) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Thu, 19 May
 2022 20:01:42 +0200
From:   Michael Rodin <mrodin@de.adit-jv.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
CC:     Michael Rodin <mrodin@de.adit-jv.com>, <michael@rodin.online>,
        <erosca@de.adit-jv.com>
Subject: Improve error handling in the rcar-vin driver
Date:   Thu, 19 May 2022 20:00:06 +0200
Message-ID: <1652983210-1194-1-git-send-email-mrodin@de.adit-jv.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.72.92.132]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series is a followup to the other series [1] started by Niklas Söderlund
where only the first patch has been merged. The overall idea is to be more
compliant with the Renesas hardware manual which requires a reset or stop
of capture in the VIN module before reset of CSI2. Another goal (achieved
by the patch 3/3) is to be more resilient with respect to non-critical CSI2
errors so the driver does not end in an endless restart loop.

Patch 1/3 has been taken from [1] with some additional documentation changes.
Patch 2/3 is included without any changes.
Patch 3/3 is based on discussions in [2], where I also found one method to
trigger CSI2 errors in the video pipeline on a Salvator board for testing
by manipulating CSI2-related registers in the adv7482:

$ i2cset -f -y 4 0x64 0x00 0x04
$ i2cset -f -y 4 0x64 0x00 0x24

[1] https://lore.kernel.org/linux-renesas-soc/20211108160220.767586-1-niklas.soderlund+renesas@ragnatech.se/
[2] https://lore.kernel.org/linux-renesas-soc/20220309192707.GA62903@vmlxhi-121.adit-jv.com/

