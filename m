Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 993AD48F371
	for <lists+linux-kernel@lfdr.de>; Sat, 15 Jan 2022 01:20:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231481AbiAOAUH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 19:20:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230450AbiAOAUG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 19:20:06 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577D9C061574;
        Fri, 14 Jan 2022 16:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:Content-Type:MIME-Version:
        Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=RO/5y8HN7zPObC7kKeadO21COfIT8ymMOCtOZ5TJz+w=; b=AEUUzycjcNniu2XHDfBVwHP202
        5DzBTeRdkUIC7uCWaJv5L+L3tjIXaBYXhkYi8S6uCyzaDt5XtcguwTe0Bzc2/tW1P2EwMPx99S23m
        rqMjpsvxonLEM6WNsogVWWu/g8hwQpWZdecXQS8Hjmw3NreZRPXbJz3sscIz2mLDWIcjkZGgL+SzS
        8Nr+R442HfcQEfnLKMjrZNB236vn3odkUqQG/wFEAhQBtkDFBsHVzYxNmRwrQA+xGwNgu0lEsJDHr
        6+1WHucw40f4OrmOo8ogtlfAxnPh1QJl+P751PxEySipaHUcHY8mrYhxkwp3ZvAIP3Sikfv701l7T
        zeIMf83A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8WnY-00AUes-GI; Sat, 15 Jan 2022 00:20:00 +0000
Date:   Fri, 14 Jan 2022 16:20:00 -0800
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Colin Ian King <colin.king@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Yu Chen <chen.yu@easystack.cn>, linux-kernel@vger.kernel.org,
        linux-modules@vger.kernel.org, mcgrof@kernel.org
Subject: Modules updates for v5.17-rc1
Message-ID: <YeITMG7bKozB2xVQ@bombadil.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: Luis Chamberlain <mcgrof@infradead.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Linus,

Here are the modules changes for v5.17-rc1. This is my second pull
request to you, the first one was for v5.16-rc1. Hopefully this time
around this all looks good now, otherwise please let me know and I'll
be sure to tidy up more.

The following changes since commit daadb3bd0e8d3e317e36bc2c1542e86c528665e5:

  Merge tag 'locking_core_for_v5.17_rc1' of git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip (2022-01-11 17:24:45 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mcgrof/linux.git modules-next

for you to fetch changes up to a97ac8cb24a3c3ad74794adb83717ef1605d1b47:

  module: fix signature check failures when using in-kernel decompression (2022-01-14 09:40:49 -0800)

----------------------------------------------------------------
Colin Ian King (1):
      kernel: Fix spelling mistake "compresser" -> "compressor"

Dmitry Torokhov (2):
      module: add in-kernel support for decompressing
      module: fix signature check failures when using in-kernel decompression

Greg Kroah-Hartman (1):
      module.h: allow #define strings to work with MODULE_IMPORT_NS

Jessica Yu (1):
      MAINTAINERS: Remove myself as modules maintainer

Luis Chamberlain (1):
      MAINTAINERS: add mailing lists for kmod and modules

Yu Chen (1):
      module: Remove outdated comment

 MAINTAINERS                 |   6 +-
 include/linux/module.h      |   3 +-
 include/uapi/linux/module.h |   1 +
 init/Kconfig                |  13 +++
 kernel/Makefile             |   1 +
 kernel/module-internal.h    |  19 ++++
 kernel/module.c             |  45 +++++---
 kernel/module_decompress.c  | 271 ++++++++++++++++++++++++++++++++++++++++++++
 8 files changed, 340 insertions(+), 19 deletions(-)
 create mode 100644 kernel/module_decompress.c

----------------------------------------------------------------

modules changes for v5.17-rc1

The biggest change here is in-kernel support for module decompression.
This change is being made to help support LSMs like LoadPin as otherwise
it loses link between the source of kernel module on the disk and binary
blob that is being loaded into the kernel.

kmod decompression is still done by userspace even with this is done,
both because there are no measurable gains in not doing so and as it
adds a secondary extra check for validating the module before loading it
into the kernel.

Although this change was only merged on January 11th, the patches have
been being reviewed since early december. There was at least one fix
already found for it and merged.

The rest of the changes are minor, the only other change worth mentionin
there is Jessica Yu is now bowing out of maintenance of modules as she's
taking a break from work.

While there were other changes posted for modules, those have not yet
received much review of testing so I'm not yet comfortable in merging
any of those changes yet.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>

  Luis
