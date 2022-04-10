Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E2BD4FADEC
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 14:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242691AbiDJMrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 08:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiDJMrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 08:47:13 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA0B25EBFE
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 05:45:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 259E9CE0ED3
        for <linux-kernel@vger.kernel.org>; Sun, 10 Apr 2022 12:45:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0769BC385A1;
        Sun, 10 Apr 2022 12:44:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649594699;
        bh=uDDfnG5bAhcDP2q9ZjMVVdqN4Dtm4VK3H76v0t8Ytp8=;
        h=Date:From:To:Cc:Subject:From;
        b=btw7XrB3E1IXrdgiLSmwpclxzCWD3qQGdfxRQqaO/jcEEWxcM5FNthQlVoZ830h9K
         1OCQdYVi3GZe4DNnUGJ116lD35pfWNIAqi88YElovsw/LT8yG7rU70wce7ar+xiiyQ
         rTJdKZzNeB4yqOHMNz+HVKjTuA7emEjgZ7eyYy4Y=
Date:   Sun, 10 Apr 2022 14:44:56 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     linux-kernel@vger.kernel.org,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Saravana Kannan <saravanak@google.com>
Subject: [GIT PULL] Driver core changes for 5.18-rc2
Message-ID: <YlLRSO25cPZ7cLZR@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 3123109284176b1532874591f7c81f3837bbdc17:

  Linux 5.18-rc1 (2022-04-03 14:08:21 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/driver-core.git tags/driver-core-5.18-rc2

for you to fetch changes up to cdb4f26a63c391317e335e6e683a614358e70aeb:

  kobject: kobj_type: remove default_attrs (2022-04-05 15:39:19 +0200)

----------------------------------------------------------------
Driver core changes for 5.18-rc2

Here are 2 small driver core changes for 5.18-rc2.

They are the final bits in the removal of the default_attrs field in
struct kobj_type.  I had to wait until after 5.18-rc1 for all of the
changes to do this came in through different development trees, and then
one new user snuck in.  So this series has 2 changes:
	- removal of the default_attrs field in the powerpc/pseries/vas
	  code.  Change has been acked by the PPC maintainers to come
	  through this tree
	- removal of default_attrs from struct kobj_type now that all
	  in-kernel users are removed.  This cleans up the kobject code
	  a little bit and removes some duplicated functionality that
	  confused people (now there is only one way to do default
	  groups.)

All of these have been in linux-next for all of this week with no
reported problems.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Greg Kroah-Hartman (2):
      powerpc/pseries/vas: use default_groups in kobj_type
      kobject: kobj_type: remove default_attrs

 arch/powerpc/platforms/pseries/vas-sysfs.c |  6 ++++--
 fs/sysfs/file.c                            | 13 ------------
 include/linux/kobject.h                    |  1 -
 lib/kobject.c                              | 32 ------------------------------
 4 files changed, 4 insertions(+), 48 deletions(-)
