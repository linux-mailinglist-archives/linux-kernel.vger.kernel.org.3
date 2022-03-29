Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8414EB8EE
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 05:35:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242337AbiC3Dgy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 23:36:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242338AbiC3Dgv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 23:36:51 -0400
X-Greylist: delayed 4200 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 29 Mar 2022 20:35:03 PDT
Received: from mailout-pe-b.jellyfish.systems (mailout-pe-b.jellyfish.systems [198.54.127.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D7253BFBC
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 20:35:01 -0700 (PDT)
Received: from NEW-01.privateemail.com (unknown [10.35.5.64])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mailout-pe-b.jellyfish.systems (Postfix) with ESMTPSA id 4KSmk05VQbzGp9q;
        Tue, 29 Mar 2022 23:58:48 +0000 (UTC)
Received: from MTA-15.privateemail.com (unknown [10.50.14.40])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by NEW-01.privateemail.com (Postfix) with ESMTPS id A63C918000CB;
        Tue, 29 Mar 2022 19:58:48 -0400 (EDT)
Received: from mta-15.privateemail.com (localhost [127.0.0.1])
        by mta-15.privateemail.com (Postfix) with ESMTP id 7546A18000A6;
        Tue, 29 Mar 2022 19:58:48 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gibson.sh; s=default;
        t=1648598328; bh=O1+zd/KNW+ohI9diX5NoE537Fd17OXvDIMQlgHBfv2A=;
        h=From:To:Cc:Subject:Date:From;
        b=z8ZSuvZ5ov0G2HX1zVlDUpp9Ifxa4tjcVXZYMz2yXISq+HyEqX5wgESoApCtCioiY
         LUU32o61n+2R01db7mq8j9xarkJvGNLlo0D7FBEG9lrCWChDUXJuzL+kObO9+Ldm35
         UCGWu4E1MmOFMsquOPgH8OyT9xdGzX8rp6gqSWKctQRzKbg9UbsN5t72XXLt+WOIIG
         VpwORBebtycpzmaMrmgOpF7gt1e40Rl1uD4pGeGxCQ4u67cVypVdVIBARcn2sAvYIW
         MF9DDgkymnbTWj1XYEqv5/XMn/KVkJL3czcjBNH/HUgwQ0jzrZI3FzSAFsrzldLFa/
         v+Fiq1PC8vSuA==
Received: from spiderdemon.horst.lan (unknown [10.20.151.189])
        by mta-15.privateemail.com (Postfix) with ESMTPA id C72A418000A2;
        Tue, 29 Mar 2022 19:58:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=gibson.sh; s=default;
        t=1648598328; bh=O1+zd/KNW+ohI9diX5NoE537Fd17OXvDIMQlgHBfv2A=;
        h=From:To:Cc:Subject:Date:From;
        b=z8ZSuvZ5ov0G2HX1zVlDUpp9Ifxa4tjcVXZYMz2yXISq+HyEqX5wgESoApCtCioiY
         LUU32o61n+2R01db7mq8j9xarkJvGNLlo0D7FBEG9lrCWChDUXJuzL+kObO9+Ldm35
         UCGWu4E1MmOFMsquOPgH8OyT9xdGzX8rp6gqSWKctQRzKbg9UbsN5t72XXLt+WOIIG
         VpwORBebtycpzmaMrmgOpF7gt1e40Rl1uD4pGeGxCQ4u67cVypVdVIBARcn2sAvYIW
         MF9DDgkymnbTWj1XYEqv5/XMn/KVkJL3czcjBNH/HUgwQ0jzrZI3FzSAFsrzldLFa/
         v+Fiq1PC8vSuA==
From:   Daniel Gibson <daniel@gibson.sh>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Peter Hurley <peter@hurleysoftware.com>,
        Daniel Gibson <daniel@gibson.sh>
Subject: [PATCH 0/1]  tty: n_tty: Restore EOF push handling behavior
Date:   Wed, 30 Mar 2022 01:58:09 +0200
Message-Id: <20220329235810.452513-1-daniel@gibson.sh>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since Kernel 5.12 there was a bug in Pseudo-Terminals (it has been fixed
recently) in ICANON mode where the terminating newline was missing in a
read() if the line had exactly 64 chars PLUS newline - and that newline
was then returned at the beginning of the next line that was read().

https://bugzilla.kernel.org/show_bug.cgi?id=215611 has more information
on this bug, but I'll summarize things relevant to this patch here:

This bug was introduced by 3b830a9c34d5 ("tty: convert tty_ldisc_ops
'read()' function to take a kernel pointer") but it turned out that a
slight variation of it existed even before (if the newline was just
after the buffer size passed to read()).
That bug had been introduced by ac8f3bf8832a ("n_tty: Fix poll() after
buffer-limited eof push read") which fixed an edge-case very similar to
the one it broke - if there was a "EOF" pseudo-EOL character (that's
a __DISABLED_CHAR and thus not supposed to be returned to the reader)
directly after a read-buffer-sized line, this EOF character was supposed
to be silently discarded - and while doing this the case of a regular
EOL character (that's supposed to be returned to the reader, like '\n')
directly following the read-buffer was broken.
As this original bug was less likely to be triggered than the newer
64 char case (I guess usually the reader passes a buffer that's big
enough to hold the whole line) it has never been found.
This EOF/pseudo-EOL character handling is also called "EOF pushing", and
the character that's used for it is EOT (ASCII 0x4). Like a regular EOL
character it terminates a line that's written to a pseudo-terminal, but
unlike a regular EOL character it's not returned to the reader.

Anyway, the fix for the bug with 64 chars + newline (359303076163 
"tty: n_tty: do not look ahead for EOL character past the end of the buffer")
broke the edge case of discarding EOT after the read buffer size, which
causes the next read() to return 0, because it's detected as an empty
line with a newline-character that's not returned to the reader.

read() returning 0 in this case actually *is* valid behavior (FreeBSD
and OSX do it), and has the advantage that the reader can interpret it
as "the line I just received is over" - otherwise the reader can't know,
could as well have been an even longer line and the previous read() just
returned the first part of it.

On the other hand, read() returning 0 means EOF and the reader could
misinterpret it as "there's no more data, probably the other side
disconnected" and stop reading or even close the pseudo-terminal.
So it might indeed be a good idea to avoid this by silently discarding
EOF (EOT) characters and returning the next line, like Linux did before.
Solaris (or at least OpenIndiana 2021.10) does the same.

While both options are defensible (and are used by other Unix-likes),
IMHO it's best to stick to the "old" Linux behavior since 40d5e0905a03
("n_tty: Fix EOF push handling") of 2013, i.e. silently discard the EOF.

The following patch, which is based on a patch Linus gave me for
testing, restores that behavior.

I wrote a pretty extensive test for several edge-cases of PTYs in ICANON
mode (including the bugs mentioned before) which you can download at:
https://bugzilla.kernel.org/show_bug.cgi?id=215611#c10
I plan to port that standalone-test to kselftest eventually, but so far
haven't gotten around to doing that, so I'd prefer to get this patch
merged now and the test later once it's ported.


Daniel Gibson (1):
  tty: n_tty: Restore EOF push handling behavior

 drivers/tty/n_tty.c | 38 +++++++++++++++++++++++++++++++++++++-
 1 file changed, 37 insertions(+), 1 deletion(-)

-- 
2.25.1

