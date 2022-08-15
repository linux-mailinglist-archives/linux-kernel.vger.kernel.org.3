Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AE2259280D
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 05:21:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiHODU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 Aug 2022 23:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiHODUz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 Aug 2022 23:20:55 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9A0FA1A4
        for <linux-kernel@vger.kernel.org>; Sun, 14 Aug 2022 20:20:53 -0700 (PDT)
Received: from dggemv703-chm.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4M5fbd6rq0zkWKC;
        Mon, 15 Aug 2022 11:17:33 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 dggemv703-chm.china.huawei.com (10.3.19.46) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:20:51 +0800
Received: from localhost.localdomain (10.175.112.125) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 15 Aug 2022 11:20:50 +0800
From:   Tong Tiangen <tongtiangen@huawei.com>
To:     Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Albert Ou <aou@eecs.berkeley.edu>, <Conor.Dooley@microchip.com>
CC:     <linux-riscv@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        "Tong Tiangen" <tongtiangen@huawei.com>,
        <wangkefeng.wang@huawei.com>, Guohanjun <guohanjun@huawei.com>
Subject: [PATCH -next v2 0/2]riscv: some refactorings realted to uaccess and extable
Date:   Mon, 15 Aug 2022 03:20:23 +0000
Message-ID: <20220815032025.2685516-1-tongtiangen@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.112.125]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patchset do some refactorings related to riscv's uaccess and extable,
mainly for the usage of __get/put_user_nocheck() which not distinguish user
access and kernel access.

v1 -> v2: 
  According to Conor's suggestion, split into two logically independent
  patches.

Tong Tiangen (2):
  riscv: uaccess: rename __get/put_user_nocheck to __get/put_mem_nocheck
  riscv: extable: add new extable type EX_TYPE_KACCESS_ERR_ZERO support

 arch/riscv/include/asm/asm-extable.h |  12 ++
 arch/riscv/include/asm/uaccess.h     | 162 +++++++++++++--------------
 arch/riscv/mm/extable.c              |   1 +
 3 files changed, 94 insertions(+), 81 deletions(-)

-- 
2.25.1

