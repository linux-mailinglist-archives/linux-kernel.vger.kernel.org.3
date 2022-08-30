Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51ED85A645D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 15:06:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230147AbiH3NGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 09:06:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiH3NGr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 09:06:47 -0400
X-Greylist: delayed 563 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 30 Aug 2022 06:06:42 PDT
Received: from smtp1.rz.tu-harburg.de (smtp1.rz.tu-harburg.de [IPv6:2001:638:702:20aa::205:38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8C3E97B1A
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 06:06:42 -0700 (PDT)
Received: from mail.tu-harburg.de (mail3.rz.tu-harburg.de [134.28.202.82])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.tu-harburg.de", Issuer "DFN-Verein Global Issuing CA" (verified OK))
        by smtp1.rz.tu-harburg.de (Postfix) with ESMTPS id 4MH6ld31TXzxR9;
        Tue, 30 Aug 2022 14:57:17 +0200 (CEST)
Received: from mailspring.rz.tuhh.de (mailspring.rz.tuhh.de [134.28.202.181])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: ccd5802@KERBEROS.TU-HARBURG.DE)
        by mail.tu-harburg.de (Postfix) with ESMTPSA id 4MH6ld1brZzJrCR;
        Tue, 30 Aug 2022 14:57:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuhh.de; s=x2022-35;
        t=1661864237; bh=3M5KoBjmdncSnK+7gaN5/nElfuzhGBpbhk1ql1rqzsM=;
        h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type:
         Content-Transfer-Encoding;
        b=uamaj48JtI3YvFPznHSpkCiq7cFrd+ToU6ra/DfYBft7xjTMaoq7dzEhtapbEmAcm
         X2B6Mc/j6LRB5dlg7T4toywzOEU93Yoc7xIbP55ivdvXf8UpzLLdzlaJ0LkZBZCorO
         y90rapyUfrzM00KDI0Z1wr4KSRPU9GsnHT/t7eXY=
From:   Christian Dietrich <christian.dietrich@tuhh.de>
To:     linux-kernel@vger.kernel.org
Cc:     Max =?utf-8?Q?Kr=C3=BCger?= <maxk@posteo.de>,
        John 'Warthog9' Hawley <warthog9@eaglescrag.net>
Subject: Unexpected behavior: Sending signalfd over AF_UNIX
Organization: Technische =?utf-8?Q?Universit=C3=A4t?= Hamburg
X-Commit-Hash-org: fa8b6bc392fa8cd66bd1773f47a6d531f437cf27
X-Commit-Hash-Maildir: 4826b0f25ca3598beaad655896227faaf1c9ec19
Date:   Tue, 30 Aug 2022 14:57:06 +0200
Message-ID: <s7b1qsx3n4t.fsf@dokucode.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[John is also on Cc: since I sent the mail before, but somehow vger ate
 the mail and it did not arrive on the LKML]

Hi everyone!

For a small pet project of mine[1], I experimented with signalfd and
wanted to send it over UNIX domain sockets. Thereby, I encountered an
unexpected behavior:

My expectation was that task A can create a signalfd and send it to
task B, whereby B becomes able to receive the signals of task A.

However, this is not whats happening there. What is actually happening
is that I can correctly transfer the fd to the other process. But
instead of read(2)-ing the siginfos of task A in task B, I now receive
the signals of task B on this foreign file descriptor.

And by looking at the code, this is also the implemented behavior.
There, the code references `current' at various places and signalfd_ctx
does not hold a `struct task_struct*' but only a signal mask.

As already said, this behavior was unexpected for me. What would be
less surpringing would be one of the following:

A. I cannot transfer the signalfd fd at all (are there non-transferable fds=
?)

B. I can read the signals of task A in task B

With B, there remains the question, whether I should read those signals
directed to task A or to its task group. If route B is chosen, it would
also be great to derive a signalfd from a pidfd.

And yes, the whole idea of sending my own signalfd to another task is
kind of insane. However, for the sake of orthogonality, this would just
be beautiful and I could point my students to this and say: Look! In
Linux, file descriptors are just capabilities that can be transferred
between processes.

chris

[1] I'm currently working on a system-call Christmas calendar that has
    a nice exercise for every day before Christmas.
--=20
Prof. Dr.-Ing. Christian Dietrich
Operating System Group (E-EXK4)
Technische Universit=C3=A4t Hamburg
Am Schwarzenberg-Campus 3 (E), 4.092
21073 Hamburg

eMail:  christian.dietrich@tuhh.de
Tel:    +49 40 42878 2188
WWW:    https://osg.tuhh.de/
