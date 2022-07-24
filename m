Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8D657F60A
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:50:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230453AbiGXQts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:49:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXQtq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:49:46 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDAF1057C
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:49:45 -0700 (PDT)
Received: from fraeml701-chm.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4LrTZg4dxWz67Mxp;
        Mon, 25 Jul 2022 00:46:03 +0800 (CST)
Received: from lhreml724-chm.china.huawei.com (10.201.108.75) by
 fraeml701-chm.china.huawei.com (10.206.15.50) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id
 15.1.2375.24; Sun, 24 Jul 2022 18:49:42 +0200
Received: from localhost.localdomain (10.69.192.58) by
 lhreml724-chm.china.huawei.com (10.201.108.75) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sun, 24 Jul 2022 17:49:39 +0100
From:   John Garry <john.garry@huawei.com>
To:     <will@kernel.org>, <catalin.marinas@arm.com>,
        <linux-arm-kernel@lists.infradead.org>, <arnd@arndb.de>,
        <olof@lixom.net>, <soc@kernel.org>
CC:     <jpoimboe@kernel.org>, <linux-kernel@vger.kernel.org>,
        John Garry <john.garry@huawei.com>
Subject: [PATCH 0/2] arm64 defconfig: Get faddr2line working
Date:   Mon, 25 Jul 2022 00:43:22 +0800
Message-ID: <1658681004-132191-1-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

scripts/faddr2line has not worked by default for arm64 since 5.17

Firstly, since commit f9b3cd245784 ("Kconfig.debug: make DEBUG_INFO
selectable from a choice"), CONFIG_DEBUG_INFO was not getting enabled by
default (and this is required for faddr2line to work).

Secondly, commit dcea997beed6 ("faddr2line: Fix overlapping text section
failures, the sequel") caused a breakage for arm64, as reported at the
following:
https://lore.kernel.org/lkml/3bd9817d-1959-c081-e5d0-8b0e70b3f41e@huawei.com/

Josh has sent fixes/improvements for faddr2line at the following:
https://lore.kernel.org/lkml/cover.1658426357.git.jpoimboe@kernel.org/

In this series I enable CONFIG_DEBUG_INFO by enabling
CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT, which seems the sensible
option.

As for merging this, I am not sure who would pick it up - any takers
welcome.

Note: this is based on next-20220722 and it may be wiser to sync the
defconfig manually (instead of using 1/2). Indeed I am not sure what is
the policy is of sync'ing this anyway.

Thanks! 

John Garry (2):
  arm64: defconfig: Sync with savedefconfig
  arm64: defconfig: Enable DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT

 arch/arm64/configs/defconfig | 85 ++++++++++++++++--------------------
 1 file changed, 37 insertions(+), 48 deletions(-)

-- 
2.35.3

