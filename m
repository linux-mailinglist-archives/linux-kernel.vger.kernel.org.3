Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F305B4A2FB1
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Jan 2022 14:12:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349577AbiA2NMW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Jan 2022 08:12:22 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:37386 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348857AbiA2NMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Jan 2022 08:12:19 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B1712B811E0
        for <linux-kernel@vger.kernel.org>; Sat, 29 Jan 2022 13:12:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2CEAC340E5;
        Sat, 29 Jan 2022 13:12:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643461937;
        bh=08if04KoV5lkcdH71jfrvu1BKS9wbH5jokwAUzYFiqA=;
        h=Date:From:To:Cc:Subject:From;
        b=uYyUcHJPKrf18PDyKm4k9q2U731exa7fQ0OSQXwPVTmEayOWoBKBMzvz28744c9Ex
         9kjc+FWamOGDmDa72GCpwFpNuVStJXvi0t71mCvDo+Se0lPYBw64g3nNzkpb0K6z45
         nEcAuiXvIJtDwxaxXyg3I9Sz5+bWR8nQoUeENARE=
Date:   Sat, 29 Jan 2022 14:12:14 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>, linux-kernel@vger.kernel.org
Subject: [GIT PULL] Char/Misc driver fixes for 5.17-rc2
Message-ID: <YfU9LsK5kzsyBmRH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit c2c94b3b187dc92b2002809f489e0f24a41e91bc:

  Merge tag 'drm-next-2022-01-21' of git://anongit.freedesktop.org/drm/drm (2022-01-21 09:25:38 +0200)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git tags/char-misc-5.17-rc2

for you to fetch changes up to fc55e63e148f1db2180867da875460a00aac8bd1:

  counter: fix an IS_ERR() vs NULL bug (2022-01-26 19:40:33 +0100)

----------------------------------------------------------------
Char/Misc driver fixes for 5.17-rc2

Here are two small char/misc driver fixes for 5.17-rc2 that fix some
reported issues.  They include:
	- fix up a merge issue in the at25.c driver that ended up
	  dropping some lines in the driver.  The removed lines ended
	  being needed, so this restores it and the driver works again.
	- counter core fix where the wrong error was being returned,
	  NULL should be the correct error for when memory is gone here,
	  like the kmalloc() core does.

Both of these have been in linux-next this week with no reported issues.

Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

----------------------------------------------------------------
Dan Carpenter (1):
      counter: fix an IS_ERR() vs NULL bug

Kees Cook (1):
      eeprom: at25: Restore missing allocation

 drivers/counter/counter-core.c | 15 ++++++---------
 drivers/misc/eeprom/at25.c     |  4 ++++
 2 files changed, 10 insertions(+), 9 deletions(-)
