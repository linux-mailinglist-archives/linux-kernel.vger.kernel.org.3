Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29EF590084
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 17:44:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236431AbiHKPn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 11:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236479AbiHKPnl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 11:43:41 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D8A1A50E8
        for <linux-kernel@vger.kernel.org>; Thu, 11 Aug 2022 08:38:08 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id B797E5FD04;
        Thu, 11 Aug 2022 18:38:05 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660232285;
        bh=5w4LerBx6pluL5hWSjCUy6U5aknGE0ymDNztcNBibbY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=Tckq2EtgEiZUvdQAO1p+MllsNXNcoXG7HQ7THmKvR8j80dK3KOQ+fqTct2640cvSc
         1ufqAlnlY3OqHDKZVJEjQVLcLuA3A5qnsl7RklR+VXCYgWnQ3nh4p1XqsgYwcoSb+Y
         MKt/B0cRILv39RTH9wpxae0Ao7FKbIsYnejEcvGA199wEj9m/TjZIjofStB3Rzk1jR
         bwFbr9rjxv/mp/gDQRd2j+um3vc21AMSWnt2foacexSb9tUspZDlN/LoWbsRr3tgNQ
         fdQjcAdA4E56wjml1fYDBPBOQNYeUFPgIfy5flVYZEJHTqyj9UpuDyZtPQt+vHIZzd
         jTACYe0T/BzAQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Thu, 11 Aug 2022 18:38:04 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v1 0/2] tidy up zsmalloc implementation
Date:   Thu, 11 Aug 2022 18:37:53 +0300
Message-ID: <20220811153755.16102-1-avromanov@sberdevices.ru>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [172.16.1.6]
X-ClientProxiedBy: S-MS-EXCH01.sberdevices.ru (172.16.1.4) To
 S-MS-EXCH01.sberdevices.ru (172.16.1.4)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/11 13:20:00 #20096813
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

This patchset remove some unnecessary checks and adds clarifying 
comment. While analysis zs_object_copy() function code, I spent 
some time to understand what the call kunmap_atomic(d_addr) is for. 
It seems that this point is not trivial and it is worth adding
a comment.

Alexey Romanov (2):
  zsmalloc: zs_object_copy: add clarifying comment
  zsmalloc: remove unnecessary size_class NULL check

 mm/zsmalloc.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

-- 
2.30.1

