Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 401E656ABA8
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 21:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236684AbiGGTPx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 15:15:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235542AbiGGTPw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 15:15:52 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2879959249;
        Thu,  7 Jul 2022 12:15:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=+o8pkZIhiPHM7Jw1oogE1u3DlZr0xeb1Ojroj1aZh9I=; b=e9weN/gDx4HMD4fLo/qgjp4kIP
        1Re6UaQ/yZodFjBo5Eymq0CCQnA2Dw0EwPgBbFaFAZytLvA4GG+N9E0d8qy++NLUr70HC2dWNUK3v
        GZxY9K04gFh1QNSSFGUultO6BY0SRuWGipWUfRrcmRo+AFZ4lE+zr5IfmxfKzXwVMB6Cw0oIczrxR
        6NmiV6XFB9x2WgT0r3P3axeMHGgaVVLzXVQmAJk22I7ARq96mTjgLwKwCjjA72Mdd9ocTDiuljKRi
        davX8qtBSezou6HAMNd13R7FHV+LFp7LQyHKh3V4Ac/6y16qRu1X8ItKRdIRvTkeeVCuLGCWw8qiM
        1d6PeKnA==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9Wyb-0099KS-L7; Thu, 07 Jul 2022 13:15:50 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1o9Wya-001ERT-7Z; Thu, 07 Jul 2022 13:15:48 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Guoqing Jiang <guoqing.jiang@linux.dev>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu,  7 Jul 2022 13:15:31 -0600
Message-Id: <20220707191533.293795-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, guoqing.jiang@linux.dev, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 0/2] Raid5 Bug Fixes
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

Please find two patches with fixes to the raid5 code.

The first patch fixes a bug in my recent commit that causes data
corruption in very specific circumstances.

The second patch fixes a theoretical issue with nested waits in
code that was recently cleaned up in the previous series (though the
issue always existed).

Thanks,

Logan

--

Logan Gunthorpe (2):
  md/raid5: Fix sectors_to_do bitmap overflow in raid5_make_request()
  md/raid5: Convert prepare_to_wait() to wait_woken() api

 drivers/md/raid5.c | 32 +++++++++++++++++---------------
 1 file changed, 17 insertions(+), 15 deletions(-)


base-commit: ff4ec5f79108cf82fe7168547c76fe754c4ade0a
--
2.30.2
