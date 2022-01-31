Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D85314A468B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 13:05:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349566AbiAaMFS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 07:05:18 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59216 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348422AbiAaMFA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 07:05:00 -0500
Date:   Mon, 31 Jan 2022 12:04:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643630697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGTQhtVgf5dGBh99npk53TZ71Mccdds6HoXUBYZU7nw=;
        b=VgDQXXl9s+MRxZQtpdDA4U+sqdJk1LDZ7JjLRB1UtW1TZ2AEGC3CdClp9dYHYnqQ7MGIYU
        exIcINk1HL7aP9/a50waaRh1sIxgnNZ0c7//Ndsz5zQH/KmiGl4DPaWv1dK1SmLWFZA/mq
        EksMtjkb5tsma7VPBbqPgOmTaVVDS57HpYxGtV6SE7CfPc0wKeJtKW0j/QcVwZV/QHuO32
        idua+Aq+DPm6lvwlUGzQcjxeVxGAw2zxQOZp8NhBSTLuQlvZfawtQCjh1w5FdJD1lTa5xf
        fToYGnPLC/UsSHkVzdhelj3phgEZuOpEda48QXLf4LdwpqG24lkR1xNvDaJ7jQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643630697;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=UGTQhtVgf5dGBh99npk53TZ71Mccdds6HoXUBYZU7nw=;
        b=GA6dRp7RYTdjdyrPWA5zoA+azwzIX1TmGLofdo44w6uGzacXctwOoqn1PgVbgaFdMXmgTp
        59OMHgxovoIjH/DQ==
From:   "tip-bot2 for Sergei Trofimovich" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/urgent] objtool: Fix truncated string warning
Cc:     Adam Borowski <kilobyte@angband.pl>, mliska@suse.cz,
        Sergei Trofimovich <slyich@gmail.com>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220120233748.2062559-1-slyich@gmail.com>
References: <20220120233748.2062559-1-slyich@gmail.com>
MIME-Version: 1.0
Message-ID: <164363069582.16921.3459888464931150219.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the objtool/urgent branch of tip:

Commit-ID:     82880283d7fcd0a1d20964a56d6d1a5cc0df0713
Gitweb:        https://git.kernel.org/tip/82880283d7fcd0a1d20964a56d6d1a5cc0d=
f0713
Author:        Sergei Trofimovich <slyich@gmail.com>
AuthorDate:    Thu, 20 Jan 2022 23:37:48=20
Committer:     Josh Poimboeuf <jpoimboe@redhat.com>
CommitterDate: Mon, 24 Jan 2022 10:09:06 -08:00

objtool: Fix truncated string warning

On GCC 12, the build fails due to a possible truncated string:

    check.c: In function 'validate_call':
    check.c:2865:58: error: '%d' directive output may be truncated writing be=
tween 1 and 10 bytes into a region of size 9 [-Werror=3Dformat-truncation=3D]
     2865 |                 snprintf(pvname, sizeof(pvname), "pv_ops[%d]", id=
x);
          |                                                          ^~

In theory it's a valid bug:

    static char pvname[16];
    int idx;
    ...
    idx =3D (rel->addend / sizeof(void *));
    snprintf(pvname, sizeof(pvname), "pv_ops[%d]", idx);

There are only 7 chars for %d while it could take up to 9, so the
printed "pv_ops[%d]" string could get truncated.

In reality the bug should never happen, because pv_ops only has ~80
entries, so 7 chars for the integer is more than enough.  Still, it's
worth fixing.  Bump the buffer size by 2 bytes to silence the warning.

[ jpoimboe: changed size to 19; massaged changelog ]

Fixes: db2b0c5d7b6f ("objtool: Support pv_opsindirect calls for noinstr")
Reported-by: Adam Borowski <kilobyte@angband.pl>
Reported-by: Martin Li=C5=A1ka <mliska@suse.cz>
Signed-off-by: Sergei Trofimovich <slyich@gmail.com>
Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20220120233748.2062559-1-slyich@gmail.com
---
 tools/objtool/check.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/objtool/check.c b/tools/objtool/check.c
index c2d2ab9..7c33ec6 100644
--- a/tools/objtool/check.c
+++ b/tools/objtool/check.c
@@ -2854,7 +2854,7 @@ static inline bool func_uaccess_safe(struct symbol *fun=
c)
=20
 static inline const char *call_dest_name(struct instruction *insn)
 {
-	static char pvname[16];
+	static char pvname[19];
 	struct reloc *rel;
 	int idx;
=20
