Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85F304CA85B
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:44:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243182AbiCBOok (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:44:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243179AbiCBOog (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:44:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7BF1D60CE3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 30ECCB81FFC
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 14:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72C6BC340F1;
        Wed,  2 Mar 2022 14:41:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646232231;
        bh=nhXXBu0cF26IikhGW2po8nwE/w5P96Wega5gfKm7YOA=;
        h=Date:From:To:Cc:Subject:From;
        b=Py8eyPMi0Wm4CGiB2MKL+k90uui5vlOSEdCFxzxbywpMz+us1a2rZBE6YMXBO8ZwR
         TPitOwvYSpRrGKgkXSC5xw2iEHiZOo5trPq9XGIqIL2z8vu8UIAVf0GEKyc3TXQ2RK
         8JbyEt99+CMo3tcytUcWRNgvCw/+ri7bkLxZVE2icKzwKbY5QiIOvALtnbSZT6TnKV
         HJx0TiVDHCJep9ltAM6GaE0zsMe1vE6YSsdGHVX2xwwT8qMeXeDmCc497y9mRMTpDS
         kK2KDPgher4woqro+R9ujI6wM8r3Ze9krSHsUqBLDoaKt2sCeQXhQZjWU/BP3uLBp1
         uJ/r3XqCiFaTA==
Date:   Wed, 2 Mar 2022 22:41:14 +0800
From:   Gao Xiang <xiang@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>
Subject: [GIT PULL] erofs fix for 5.17-rc7
Message-ID: <Yh+CCr04nTTappWl@hsiangkao-PC>
Mail-Followup-To: Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-erofs@lists.ozlabs.org,
        Chao Yu <chao@kernel.org>, Yue Hu <huyue2@yulong.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Could you consider this pull request for 5.17-rc7?

It's a one-line patch to fix the new ztailpacking feature on > 4GiB
filesystems because z_idataoff can get trimmed improperly.

Even if ztailpacking is still a brand new EXPERIMENTAL feature, it'd
be better to fix the issue as soon as possible to avoid backporting
unnecessary..

The original patch has been in linux-next for a week and no merge
conflicts. Except that I added a new RVB tag from Chao today.

Thanks,
Gao Xiang

The following changes since commit cfb92440ee71adcc2105b0890bb01ac3cddb8507:

  Linux 5.17-rc5 (2022-02-20 13:07:20 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/xiang/erofs.git tags/erofs-for-5.17-rc7-fixes

for you to fetch changes up to 22ba5e99b96f1c0dbdfa4f4e1d9751b4c8348541:

  erofs: fix ztailpacking on > 4GiB filesystems (2022-03-02 21:58:45 +0800)

----------------------------------------------------------------
Change since last update:

 - Fix ztailpacking z_idataoff getting trimmed on > 4GiB filesystems.

----------------------------------------------------------------
Gao Xiang (1):
      erofs: fix ztailpacking on > 4GiB filesystems

 fs/erofs/internal.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)
