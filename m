Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E7445AA0A5
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 22:08:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234823AbiIAUIA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 16:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234306AbiIAUHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 16:07:52 -0400
Received: from sender-of-o50.zoho.in (sender-of-o50.zoho.in [103.117.158.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE9A898354
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 13:07:49 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1662062825; cv=none; 
        d=zohomail.in; s=zohoarc; 
        b=EQptWnhg3JSH0gD54XqAKCRQV+o+hVQY4IYmzReNKQhTx5th/R1yIUbMJuObrzXBFkGqOCu/MDGe19/hyOfN3b4dEomyORcJYBJydmZ0Ld6AP5cgnmkzpUzurM7XT4rrkMiE+rOtr7A++v3H59s+ObtMBRxPO3TEGbSgeKRDG78=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.in; s=zohoarc; 
        t=1662062825; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=1j9B3a9+XvhyGJpimzS54jknD3atX0UsgCNgtn4m3hM=; 
        b=Ek46Zva6JJAE8tmnRoU57vSf5xWpTQsUCDllK+RVZWP1unAiK5BUFYM0wglTIKA3Fd4jDMhYYWpQhPHdxVE+Gx03xKqPBbERXZCaiFeuENvx+FkY7zO7iiuidqC7Y98u8zOIrgEFEim8mExyyfmWGEXf7YHIdVbduuMIccuDFqs=
ARC-Authentication-Results: i=1; mx.zohomail.in;
        dkim=pass  header.i=siddh.me;
        spf=pass  smtp.mailfrom=code@siddh.me;
        dmarc=pass header.from=<code@siddh.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1662062825;
        s=zmail; d=siddh.me; i=code@siddh.me;
        h=From:From:To:To:Cc:Cc:Message-ID:Subject:Subject:Date:Date:MIME-Version:Content-Transfer-Encoding:Content-Type:Message-Id:Reply-To;
        bh=1j9B3a9+XvhyGJpimzS54jknD3atX0UsgCNgtn4m3hM=;
        b=pF/hCgNbHJAWM48rUU/C7j5aEXWyPst0brvqLUHqKO7DIxRTyX/8EZ/SGP0++Jwu
        ZWdz/Lnz5z5wzYpnR6lVwvv/ATFe0nk+G0LUJQqE65ASp2nZ281uoOs6And3Kwi/yAA
        fHcVsg/SyyS6PH0N+ozlEks325hCPFKyk0ok8fdM=
Received: from localhost.localdomain (103.249.233.18 [103.249.233.18]) by mx.zoho.in
        with SMTPS id 166206282365234.66171267020229; Fri, 2 Sep 2022 01:37:03 +0530 (IST)
From:   Siddh Raman Pant <code@siddh.me>
To:     Jonathan Corbet <corbet@lwn.net>,
        David Howells <dhowells@redhat.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Eric Dumazet <edumazet@google.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Message-ID: <cover.1659771577.git.code@siddh.me>
Subject: [RESEND PATCH v2 0/2] watch_queue: Clean up some code
Date:   Fri,  2 Sep 2022 01:36:54 +0530
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-ZohoMailClient: External
Content-Type: text/plain; charset=utf8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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


