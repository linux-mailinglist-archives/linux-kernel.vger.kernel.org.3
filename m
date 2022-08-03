Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA6EC588F4E
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 17:25:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238041AbiHCPZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 11:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233041AbiHCPZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 11:25:08 -0400
Received: from smtp-fw-80007.amazon.com (smtp-fw-80007.amazon.com [99.78.197.218])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4D825FDB
        for <linux-kernel@vger.kernel.org>; Wed,  3 Aug 2022 08:25:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.es; i=@amazon.es; q=dns/txt; s=amazon201209;
  t=1659540307; x=1691076307;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Tbu2vI/tuQpJhdPLbiU7SzaNS+QVhrT4UaYznxDPAGo=;
  b=PwiM9MseAso+d9qYizAKUqLkzNMJBd+ArBmzMTnX4w8r8lSzqCkyWzQe
   AtETtTXtohYTHIK8sRTgO9P5A+pLYcAKgsERe/QeDGG4xQ6oJPdxjJ4Bl
   EmV/bK/n0KbV9ldI6JC8B9eYNsIIyzLGCzDVFHI+DNJX2v0+5abJ1Raz/
   M=;
X-IronPort-AV: E=Sophos;i="5.93,214,1654560000"; 
   d="scan'208";a="115297759"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com) ([10.25.36.214])
  by smtp-border-fw-80007.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2022 15:21:44 +0000
Received: from EX13D37EUA003.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan2.pdx.amazon.com [10.236.137.194])
        by email-inbound-relay-pdx-2a-e6c05252.us-west-2.amazon.com (Postfix) with ESMTPS id C002143D01;
        Wed,  3 Aug 2022 15:21:42 +0000 (UTC)
Received: from f4d4887fdcfb.ant.amazon.com (10.43.162.134) by
 EX13D37EUA003.ant.amazon.com (10.43.165.7) with Microsoft SMTP Server (TLS)
 id 15.0.1497.36; Wed, 3 Aug 2022 15:21:37 +0000
From:   <bchalios@amazon.es>
To:     <linux-kernel@vger.kernel.org>
CC:     <bchalios@amazon.es>, <tytso@mit.edu>, <Jason@zx2c4.com>,
        <dwmw@amazon.co.uk>, <graf@amazon.de>, <xmarcalx@amazon.co.uk>,
        <gregkh@linuxfoundation.org>
Subject: [PATCH 0/2] virt: vmgenid: add generation counter
Date:   Wed, 3 Aug 2022 17:21:25 +0200
Message-ID: <20220803152127.48281-1-bchalios@amazon.es>
X-Mailer: git-send-email 2.32.1 (Apple Git-133)
MIME-Version: 1.0
X-Originating-IP: [10.43.162.134]
X-ClientProxiedBy: EX13D07UWB003.ant.amazon.com (10.43.161.66) To
 EX13D37EUA003.ant.amazon.com (10.43.165.7)
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Babis Chalios <bchalios@amazon.es>

Linux recently added support for the VM Generation ID mechanism from
Microsoft. The way this works currently is using the 128-bit blob
provided by the vmgenid device to re-seed the RNG. While this works it
has two main issues, (a) it is inherently racy due to the fact that it
relies on a ACPI notification being delivered and handled and (b) the ID
is unsuitable for exposing to user-space.

This patch-set extends the vmgenid device to introduce a generation
counter, a 32-bit counter which is different every time the unique ID
changes. The addition to the original implementation in QEMU can be
found here:
https://lists.nongnu.org/archive/html/qemu-devel/2022-08/msg00524.html.

The first patch re-works slightly the current vmgenid driver to add a
function that parses an object from the vmgenid device and returns the
physical address of the vmgenid data. The second patch uses that
function to parse additionally the address of the generation counter
from the vmgenid namespace. The counter is then exposed to the
user-space through a misc-device which provides `read` and `mmap`
interfaces.

Babis Chalios (2):
  virt: vmgenid: add helper function to parse ADDR
  virt: vmgenid: add support for generation counter

 Documentation/virt/vmgenid.rst | 120 ++++++++++++++++++++++++++
 drivers/virt/vmgenid.c         | 151 ++++++++++++++++++++++++++++-----
 2 files changed, 251 insertions(+), 20 deletions(-)
 create mode 100644 Documentation/virt/vmgenid.rst

-- 
2.37.1

Amazon Spain Services sociedad limitada unipersonal, Calle Ramirez de Prado 5, 28045 Madrid. Registro Mercantil de Madrid . Tomo 22458 . Folio 102 . Hoja M-401234 . CIF B84570936

