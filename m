Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CECAA592F10
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 14:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241177AbiHOMjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 08:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241250AbiHOMjn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 08:39:43 -0400
Received: from mail.sberdevices.ru (mail.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7D7E237DF
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 05:39:40 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mail.sberdevices.ru (Postfix) with ESMTP id 396985FD05;
        Mon, 15 Aug 2022 15:39:39 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1660567179;
        bh=5w4LerBx6pluL5hWSjCUy6U5aknGE0ymDNztcNBibbY=;
        h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type;
        b=T2gQ/uTwysZ2kk9h86fOA35JzxspP8yzBRmkrnZmEvONYsRAPR+x+E11HVx6DgYqs
         tr372abgLcaGWtwM49ByFpgaCU6fBujSxoMpPFlQCfFxj0yEjyUFII1T5REN//Fd6D
         LGPj0y73Zk8xrqwQIIRttEYdHtaes5GyiN3jyEKmuYt+MjBdVybrgQHVkFxH/h1rS+
         XhS4xLWcTrVZ1KisUdT9nbl6sGdzIsg1yWaw8M8cTMgHDktjJikToo/I3xUCOKBPvg
         RS46uf8BAs2D/qY7mU/5yCZdN6yI/wR2972LY3SiHg+LokmMU2bIq0qgQh6+v66aBT
         r8fkq1AE2Z8HQ==
Received: from S-MS-EXCH01.sberdevices.ru (S-MS-EXCH01.sberdevices.ru [172.16.1.4])
        by mail.sberdevices.ru (Postfix) with ESMTP;
        Mon, 15 Aug 2022 15:39:38 +0300 (MSK)
From:   Alexey Romanov <avromanov@sberdevices.ru>
To:     <minchan@kernel.org>, <senozhatsky@chromium.org>,
        <ngupta@vflare.org>, <akpm@linux-foundation.org>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <kernel@sberdevices.ru>, Alexey Romanov <avromanov@sberdevices.ru>
Subject: [PATCH v2 0/2] tidy up zsmalloc implementation
Date:   Mon, 15 Aug 2022 15:39:28 +0300
Message-ID: <20220815123930.37736-1-avromanov@sberdevices.ru>
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
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2022/08/15 08:42:00 #20120161
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

