Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 658165905AB
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 19:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236526AbiHKRTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 13:19:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235270AbiHKRSf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 13:18:35 -0400
Received: from ale.deltatee.com (ale.deltatee.com [204.191.154.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07BE398CB8;
        Thu, 11 Aug 2022 10:14:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:MIME-Version:Message-Id:Date:Cc:To:From
        :references:content-disposition:in-reply-to;
        bh=0WBH3Y4rYTh90rPLxupZdKv6P+bY7E5sqeNBGenrUSw=; b=hEr30uX6mheZ4FG9n8yWx7VpvU
        z0keuLldb/JLPhN3suo2d6b8/PUhpaSlZASTP5Cj7Z1+L9aOweuBKcPlZpcSb7pP0JTX16Cx7AnFY
        6WRQIhb/l3WClvv7WOnksnWQxskihzoMFPL79ijTR8VC24NgvtMmKWx2hiFeADzxa/QeoJ1oEkkhJ
        86u2w9dqYEK0h3wRYN09K10bB4QU3Qq7rjEaTZ3aacm8i3UEAEmd+SOvrE8jxlmpftknx1DvuUFS9
        2XhsJwImU08YebM1Ty2YFUM3f40wRBy+LLJ9yGrzByWyNK2p1Lc6JxclkSRI0FA168+nSFMT7G2nN
        0G+5j7Mg==;
Received: from cgy1-donard.priv.deltatee.com ([172.16.1.31])
        by ale.deltatee.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlJ-00EAye-Ri; Thu, 11 Aug 2022 11:14:27 -0600
Received: from gunthorp by cgy1-donard.priv.deltatee.com with local (Exim 4.94.2)
        (envelope-from <gunthorp@deltatee.com>)
        id 1oMBlH-000cR5-Mb; Thu, 11 Aug 2022 11:14:23 -0600
From:   Logan Gunthorpe <logang@deltatee.com>
To:     linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        Song Liu <song@kernel.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Guoqing Jiang <guoqing.jiang@linux.dev>,
        Stephen Bates <sbates@raithlin.com>,
        Martin Oliveira <Martin.Oliveira@eideticom.com>,
        David Sloan <David.Sloan@eideticom.com>,
        Logan Gunthorpe <logang@deltatee.com>
Date:   Thu, 11 Aug 2022 11:14:12 -0600
Message-Id: <20220811171417.147697-1-logang@deltatee.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 172.16.1.31
X-SA-Exim-Rcpt-To: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, song@kernel.org, hch@infradead.org, guoqing.jiang@linux.dev, sbates@raithlin.com, Martin.Oliveira@eideticom.com, David.Sloan@eideticom.com, logang@deltatee.com
X-SA-Exim-Mail-From: gunthorp@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
Subject: [PATCH 0/5] More fixups for raid5
X-SA-Exim-Version: 4.2.1 (built Sat, 13 Feb 2021 17:57:42 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hey,

The first patch in this series is a fix for another race issue with
the test infrastructure.

The remaining 4 patches address Christoph's feedback in my previous
patchset that I sent rather late in the cycle. (Sorry about that).

This series is based on current md-next (ae0a80935d6a6).

Logan

--

David Sloan (1):
  md: Flush workqueue md_rdev_misc_wq in md_alloc()

Logan Gunthorpe (4):
  md/raid5: Refactor raid5_get_active_stripe()
  md/raid5: Drop extern on function declarations in raid5.h
  md/raid5: Cleanup prototype of raid5_get_active_stripe()
  md/raid5: Don't read ->active_stripes if it's not needed

 drivers/md/md.c          |   1 +
 drivers/md/raid5-cache.c |   3 +-
 drivers/md/raid5.c       | 132 ++++++++++++++++++++-------------------
 drivers/md/raid5.h       |  32 ++++++----
 4 files changed, 90 insertions(+), 78 deletions(-)


base-commit: ae0a80935d6a65764b0db00c8b03d3807b4110a6
--
2.30.2
