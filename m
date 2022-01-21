Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31E2F496091
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 15:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381029AbiAUORp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 09:17:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:53188 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380957AbiAUORh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 09:17:37 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BF75FB81FE5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 14:17:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84AFFC340E1;
        Fri, 21 Jan 2022 14:17:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642774653;
        bh=hxuds/obYcwPcFU6X3D2FkXHmQMyBLLAckdWAQA63KI=;
        h=Date:From:To:cc:Subject:From;
        b=mXV2QQwtsFj/wFlhskRYbjZ39Ykd9ZjrWY19js/0chDv1xPYgPwCXbw7gA2FtiAbJ
         t2cQZ7YIkPXvo5q+I2GFYnWC9JrI/yL+XSWQ49LFPl2kSEVJdJvH7e+EkmfXIxeBDl
         VSALa3fb4SttTJPSmolBgf6Vo3Vp690AwQ5RGVOeGSR6yTWLBbNTjtTQ0BoQFsxjg0
         aGL4yM3wvHdgmqUq17CNN87GGdHIfW5l6GGUHng9Kb822LRsdpzeMMqdOykQkA6FQw
         SYeldDvniNSof6z3UDO64mRuvIDY+faiRN1cauZOn8ZrLJIggpQECwj9yZLiLkOYyT
         Lx3CuKIwdcqsg==
Date:   Fri, 21 Jan 2022 15:17:30 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
cc:     linux-kernel@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: [GIT PULL] HID fixes
Message-ID: <nycvar.YFH.7.76.2201211513260.28059@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

please pull from

  git://git.kernel.org/pub/scm/linux/kernel/git/hid/hid.git for-linus

to receive HID fixes for 5.17. Highlights:

=====
- fix for race condition that could lead to NULL pointer dereferences or 
  UAF during uhid device destruction (Jann Horn)
- contact count handling regression fixes for Wacom devices (Jason 
  Gerecke)
- fix for handling unnumbered HID reports handling in Google Vivaldi 
  driver (Dmitry Torokhov)
=====

Thanks.

----------------------------------------------------------------
Dmitry Torokhov (1):
      HID: vivaldi: fix handling devices not using numbered reports

Jann Horn (2):
      HID: uhid: Fix worker destroying device without any protection
      HID: uhid: Use READ_ONCE()/WRITE_ONCE() for ->running

Jason Gerecke (3):
      HID: wacom: Reset expected and received contact counts at the same time
      HID: wacom: Ignore the confidence flag when a touch is removed
      HID: wacom: Avoid using stale array indicies to read contact count

Karl Kurbjun (1):
      HID: Ignore battery for Elan touchscreen on HP Envy X360 15t-dr100

Stephen Boyd (1):
      HID: vivaldi: Minor cleanups

 drivers/hid/hid-ids.h     |  1 +
 drivers/hid/hid-input.c   |  2 ++
 drivers/hid/hid-vivaldi.c | 41 ++++++++++++++++++++++++++++++---------
 drivers/hid/uhid.c        | 49 +++++++++++++++++++++++++++++++++--------------
 drivers/hid/wacom_wac.c   | 39 +++++++++++++++++++++++++++++++++----
 5 files changed, 105 insertions(+), 27 deletions(-)

-- 
Jiri Kosina
SUSE Labs

