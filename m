Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8B8505C99
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 18:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346384AbiDRQq5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 12:46:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237766AbiDRQqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 12:46:49 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34671326FF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 09:44:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 1B3EBCE1006
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 16:44:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7ED97C385A1;
        Mon, 18 Apr 2022 16:44:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650300246;
        bh=JvnW2ozespb52lH6msQpgKbA7utUCamhmI6+q8wdsec=;
        h=Date:From:To:Cc:Subject:From;
        b=BvV/Unb2MbsQjxbXEqoYLkWXM1VRP325ae+RXseFDJVIzs4eP8A9pAUD406f5/dPL
         DxBQmuAYfNs288XsZJaMBSmOqOmrRAImDN7Lny81VLQiv2yNFAOnohidpJn7nJfBO5
         Ov49mdJgC13+xEoGrNs5ol3u4fVwnu0TUlhrSXyoQLo8ZPMV6mcnHbtCmcV5HQq2GM
         HlzzCfox97vHKXFEtWb3zNWYGMFPtRsk0bqB0vKPuG/dfIVcqRIKjVsIzEirGoeObX
         PVDKxFJqf7GYDo7o6h8eZn8gTqUAcVgwOR5U6Ypmr6Eb70nWpOPZBOsWfh91qQGyyh
         quD9Jg+Q01Y1w==
Date:   Tue, 19 Apr 2022 00:43:16 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
        Hans de Goede <hdegoede@redhat.com>
Subject: [GIT PULL] erofs fixes for 5.18-rc4
Message-ID: <Yl2VJEuDCWT4lycg@debian>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>,
        Chao Yu <chao@kernel.org>, Hongyu Jin <hongyu.jin@unisoc.com>,
        Hans de Goede <hdegoede@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider these two fixes for 5.18-rc4?

One patch fixes a use-after-free race related to the on-stack
z_erofs_decompressqueue, which happens very rarely but needs to
be fixed properly soon. The other patch fixes some sysfs Sphinx
warnings.

All commits have been in linux-next for a while and no merge
conflicts.

Thanks,
Gao Xiang


The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.18-rc4-fixes

for you to fetch changes up to 8b1ac84dcf2cf0fc86f29e92e5c63c4862de6e55:

  Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors (2022-04-15 23:51:54 +0800)

----------------------------------------------------------------
Changes since last update:

 - Fix use-after-free of the on-stack z_erofs_decompressqueue;

 - Fix sysfs documentation Sphinx warnings.

----------------------------------------------------------------
Hans de Goede (1):
      Documentation/ABI: sysfs-fs-erofs: Fix Sphinx errors

Hongyu Jin (1):
      erofs: fix use-after-free of on-stack io[]

 Documentation/ABI/testing/sysfs-fs-erofs |  5 +++--
 fs/erofs/zdata.c                         | 12 ++++--------
 fs/erofs/zdata.h                         |  2 +-
 3 files changed, 8 insertions(+), 11 deletions(-)
