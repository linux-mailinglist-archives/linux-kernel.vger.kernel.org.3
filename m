Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30AAB55EB9A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 20:01:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233045AbiF1SBR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 14:01:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiF1SBM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 14:01:12 -0400
Received: from hi1smtp01.de.adit-jv.com (smtp1.de.adit-jv.com [93.241.18.167])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84DBF12AF1;
        Tue, 28 Jun 2022 11:01:11 -0700 (PDT)
Received: from hi2exch02.adit-jv.com (hi2exch02.adit-jv.com [10.72.92.28])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by hi1smtp01.de.adit-jv.com (Postfix) with ESMTPS id 8F9685200D6;
        Tue, 28 Jun 2022 20:01:09 +0200 (CEST)
Received: from vmlxhi-182.adit-jv.com (10.72.92.119) by hi2exch02.adit-jv.com
 (10.72.92.28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2308.27; Tue, 28 Jun
 2022 20:01:09 +0200
From:   Michael Rodin <mrodin@de.adit-jv.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        =?UTF-8?q?Niklas=20S=C3=B6derlund?= <niklas.soderlund@ragnatech.se>,
        <linux-media@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-renesas-soc@vger.kernel.org>
CC:     Michael Rodin <mrodin@de.adit-jv.com>, <michael@rodin.online>,
        <erosca@de.adit-jv.com>
Subject: [PATCH v2 0/3] Improve error handling in the rcar-vin driver
Date:   Tue, 28 Jun 2022 20:00:19 +0200
Message-ID: <20220628180024.451258-1-mrodin@de.adit-jv.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <YqEO3/KekkZhVjW+@oden.dyn.berto.se>
References: <YqEO3/KekkZhVjW+@oden.dyn.berto.se>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.72.92.119]
X-ClientProxiedBy: hi2exch02.adit-jv.com (10.72.92.28) To
 hi2exch02.adit-jv.com (10.72.92.28)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,KHOP_HELO_FCRDNS,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

this series is a followup to the other series [1] started by Niklas Söderlund
where only the first patch has been merged. The overall idea is to be more
compliant with the Renesas hardware manual which requires a reset or stop
of capture in the VIN module before reset of CSI2. Another goal is to be
more resilient with respect to non-critical CSI2 errors so the driver does
not end in an endless restart loop. Compared to the previous version [2] of
this series the patch 3 is replaced based on the conclusion in [3] so now
userspace has to take care of figuring out if a transfer error was harmless
or unrecoverable. Other patches are adapted accordingly so no assumptions
about criticality of transfer errors are made in the kernel and the
decision is left up to userspace.

[1] https://lore.kernel.org/linux-renesas-soc/20211108160220.767586-1-niklas.soderlund+renesas@ragnatech.se/
[2] https://lore.kernel.org/all/1652983210-1194-1-git-send-email-mrodin@de.adit-jv.com/
[3] https://lore.kernel.org/all/YqEO3%2FKekkZhVjW+@oden.dyn.berto.se/

