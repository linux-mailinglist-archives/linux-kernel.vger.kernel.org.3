Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD02F58B44A
	for <lists+linux-kernel@lfdr.de>; Sat,  6 Aug 2022 09:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241587AbiHFHot (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 6 Aug 2022 03:44:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230465AbiHFHor (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 6 Aug 2022 03:44:47 -0400
Received: from sender-of-o53.zoho.in (sender-of-o53.zoho.in [103.117.158.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2A0E11C35
        for <linux-kernel@vger.kernel.org>; Sat,  6 Aug 2022 00:44:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1659771850; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=b3K12+SyVErYDwLKEcAAHzlzpWFRanYDGTEPfYDxLCfK93RZLWSUxEUbJHoGiCQ+KIz0F/lFD7ThjB/Dwpx7ZTQGI5l0ImxN9UhMl8NgGL77iElL+TLB75kpTO02raICKgCiLAhg//QjWabE4G0VAzOkRxMw79DmrnnQZ/BoDEI=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1659771850; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=1j9B3a9+XvhyGJpimzS54jknD3atX0UsgCNgtn4m3hM=; 
        b=Bkl7cYgUfX4YpxKlh1KAtZwQPkFBzJXwcghxL5yO+Sp4yJPANM66zKE7lHXwO9QvcRHuGYNbRzkS//DtZtk2o5qSTwbx0GojbB3epfCVyUBuERL0LTrqYDi0FJxXbe2NLGEQg+DmM8BL/j6xL8xE028wJw+OB13vOh5lF5qtQJM=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1659771850;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=1j9B3a9+XvhyGJpimzS54jknD3atX0UsgCNgtn4m3hM=;
        b=mHsfL+o8SGKPIbTca18TuLmfTU56I7rcPPdbriwIMoNtp0iAg+P2DGg0kqcxRxLD
        VzbuE2fxUXC+SxNd+OPHe9cREukH0lQyQ6w7AgSWx3xTkCrMkM/yzZ0gIz75r0lVMtP
        bAmz68oSSokFuv+ZPzHavvwvTEaaBYdxUZlsX/3g=
Received: from localhost.localdomain (43.250.158.93 [43.250.158.93]) by mx.zoho.in
        with SMTPS id 1659771849686186.95964539009788; Sat, 6 Aug 2022 13:14:09 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Eric Biggers <ebiggers@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <cover.1659771577.git.code@siddh.me>
Subject: [PATCH v2 0/2] watch_queue: Clean up some code
Date:   Sat,  6 Aug 2022 13:13:40 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_RED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a dangling reference to pipe in a watch_queue after clearing it.
Thus, NULL that pointer while clearing.

This change renders wqueue->defunct superfluous, as the latter is only used
to check if watch_queue is cleared. With this change, the pipe is NULLed
while clearing, so we can just check if the pipe is NULL.

Extending comment for watch_queue->pipe in the definition of watch_queue
made the comment conventionally too long (it was already past 80 chars),
so I have changed the struct annotations to be kerneldoc-styled, so that
I can extend the comment mentioning that the pipe is NULL when watch_queue
is cleared. In the process, I have also hopefully improved documentation
by documenting things which weren't documented before.

Changes in v2:
- Merged the NULLing and removing defunct patches.
- Removed READ_ONCE barrier in lock_wqueue().
- Improved and fixed errors in struct docs.
- Better commit messages.

Siddh Raman Pant (2):
  include/linux/watch_queue: Improve documentation
  kernel/watch_queue: NULL the dangling *pipe, and use it for clear
    check

 include/linux/watch_queue.h | 100 ++++++++++++++++++++++++++----------
 kernel/watch_queue.c        |  12 ++---
 2 files changed, 79 insertions(+), 33 deletions(-)

--=20
2.35.1


