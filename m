Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD91448E948
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 12:35:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234537AbiANLfx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 06:35:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233085AbiANLfw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 06:35:52 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A95CC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:35:52 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id h12so3090282qkk.12
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 03:35:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=IfCH9yihWDYY8+Xfg00VuTh78B5SI+o90zOmStf59fM=;
        b=dmaIUma4/Xg9aRR3RM930DGBskp9yqyO4nZqte3cDCZrHMP283fYCABTbOtQq+Yilh
         GbZNxr2Zqch9caItP4PhS3KMgR/zMw/r+mhLoTVI8Jm79xBs0RAa+iPl430J0uhfVRnb
         yzSLIsH7GGoxPV9OkmWxTPKmZcN+9U8bjqm0oOHnCeIYxasa8uTGLbVBRLwYQ89L6ET0
         hvKj1iBe25LXbCkFfoYE1K9WQDFB2SfgdHozRkOfLBIXo0DYxSGVDp9wJv8R8BvCg0nS
         FEsPmnj47ypdjf39tk71lN3TML7DTQbx1i8P4B0r2v5l+5sSY4KZvJnGcWnVEs7qcou5
         nVwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=IfCH9yihWDYY8+Xfg00VuTh78B5SI+o90zOmStf59fM=;
        b=sUqGTriuKeuY9CXEBoQNKSQ0xDgpXPKpC18M4GszX+2ge11hxlYduCxVdaLXlXxF3W
         740iNrMWxwUeWSGEEcYzk/KUgRhk9L0Vlea4yKrz7bz16LXMyl2fLkX/qbziWpXFmffR
         wZqmpJgS3ZqqeMr9KnJnO4dkt+e7S+//iD0B1NvhuokEYQ7hJ/1LqBHsEA7AQyPo/FVo
         HdmpXzmcx7txZPyZt3jbc5TpT9h4T8iDI/a4Z512BER0/7/XnB8z+OQEEb72Wj2Xu4Q6
         gx6eAn0pHx1tksHgMWnEWSw14Lcg3EH3ZIVKMshlV6M+QXkvD5f+YTtbad6kOHU29cJr
         J3tw==
X-Gm-Message-State: AOAM531X7rQA4DC30YYKGuKwJozT/NtPC1wdKqd7AWDex8cW9GZExd2D
        /15yZ3fYJ8ksG9jNfNQchJSKmU+PkAA=
X-Google-Smtp-Source: ABdhPJz7lRBzmkHneVn9r/2aIdE5I1ao2F72Ia/O1wYRzDAGX1stT1HYxSCvoWhetoLuEAJTFGZpMw==
X-Received: by 2002:a37:694:: with SMTP id 142mr3362926qkg.383.1642160151192;
        Fri, 14 Jan 2022 03:35:51 -0800 (PST)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id v11sm2797637qtk.89.2022.01.14.03.35.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 03:35:50 -0800 (PST)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id 3FE5C2B5D4;
        Fri, 14 Jan 2022 06:35:50 -0500 (EST)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 6BE146000E1; Fri, 14 Jan 2022 06:35:49 -0500 (EST)
Date:   Fri, 14 Jan 2022 06:35:49 -0500
From:   nick black <dankamongmen@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Thomas Dickey <dickey@invisible-island.net>
Subject: [PATCH] console: answer OSC 10 and 11
Message-ID: <YeFgFZ4hwYftA1IB@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

XTerm and many other terminal emulators implement
Operating System Commands 10 and 11, allowing the
default foreground/background to be set and queried.
Extend the VT control sequence parser to recognize
and support these queries.

The VT already implements two OSCs, for changing
and resetting the palette. In doing so (many years
ago), it broke from the ANSI standard, and did not
require an ST terminator. Read all about it in
xterm(1) (see "brokenLinuxOSC"). I have followed this
grand tradition, and similarly not required ST.
Note that ST can still be safely sent by a client
program, as the VT consumes it. Indeed, my Notcurses
library does exactly this.

"Don't VTs always have black backgrounds?" Nope, you
can change the default background color with any
number of ANSI sequences, and then use the VT's
Private CSI "ESC [ 8 ]" to make the current color pair
the default attributes. Try it at home with, say:

  printf %b '\e[46m' '\e[8]' '\e[H\e[J'

The response follows XTerm's effective lead, using
%02x/%02x/%02x to format the RGB value, rather than
the %02x%02x%02x preferred by the preexisting
P (set palette) OSC. This was done to simplify
client libraries. Note that the spirit of the law,
that the reply is a "control sequence of the same
form which can be used to set", cannot be easily
honored given the semantics of the Linux private CSI
sequence. So it goes.

As a result, notcurses-info now properly detects the
default colors dynamically. Where it used to say:

 no known default fg no known default bg

It now says on boot:

 notcurses 3.0.4 on Linux 5.16.0nlb VT
 ...
 default fg 0xaaaaaa default bg 0x000000

and after a change like that above:

 notcurses 3.0.4 on Linux 5.16.0nlb VT
 ...
 default fg 0xaaaaaa default bg 0xaa5500

This is necessary to produce readable multicolor text
while respecting the user's background choice.

Signed-off-by: nick black <dankamongmen@gmail.com>

---
 drivers/tty/vt/vt.c            | 66 ++++++++++++++++++++++++++++------
 include/linux/console_struct.h |  1 +
 2 files changed, 56 insertions(+), 11 deletions(-)

diff --git drivers/tty/vt/vt.c drivers/tty/vt/vt.c
index f8c87c4d7399..08c55fc99688 100644
--- drivers/tty/vt/vt.c
+++ drivers/tty/vt/vt.c
@@ -1878,6 +1878,30 @@ int mouse_reporting(void)
 	return vc_cons[fg_console].d->vc_report_mouse;
 }
 
+/* handle the OSC query specified by vc->vc_oscmd. we currently handle only 10
+ * and 11 (default foreground and default background, respectively).
+ */
+static void handle_osc_query(struct tty_struct *tty, const struct vc_data *vc)
+{
+	char buf[20];
+	int len, idx;
+	/* response payload conforms to XTerm: %02x/%02x/%02x for R, G, and B. */
+	switch (vc->vc_oscmd) {
+	case 10: /* get default foreground */
+		idx = vc->vc_def_color & 0x0f;
+		break;
+	case 11: /* get default background */
+		idx = (vc->vc_def_color & 0xf0) >> 4;
+		break;
+	default:
+		return;
+	}
+	len = snprintf(buf, sizeof(buf), "\x1b]%d;rgb:%02x/%02x/%02x\x1b\\",
+		vc->vc_oscmd, vc->vc_palette[idx * 3],
+		vc->vc_palette[idx * 3 + 1], vc->vc_palette[idx * 3 + 2]);
+	respond_string(buf, len, tty->port);
+}
+
 /* console_lock is held */
 static void set_mode(struct vc_data *vc, int on_off)
 {
@@ -2075,8 +2099,8 @@ static void restore_cur(struct vc_data *vc)
 }
 
 enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
-	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
-	ESpalette, ESosc, ESapc, ESpm, ESdcs };
+	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore,
+	ESpalette, ESosc, ESoscmd, ESoscparam, ESapc, ESpm, ESdcs };
 
 /* console_lock is held (except via vc_init()) */
 static void reset_terminal(struct vc_data *vc, int do_clear)
@@ -2230,7 +2254,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_state = ESsquare;
 			return;
 		case ']':
-			vc->vc_state = ESnonstd;
+			vc->vc_state = ESosc;
 			return;
 		case '_':
 			vc->vc_state = ESapc;
@@ -2287,7 +2311,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			return;
 		}
 		return;
-	case ESnonstd:
+	case ESosc:
+		/* Operating System Commands are traditionally terminated with an ST
+		 * or a BEL, but Linux historically eschews said terminators.
+		 */
 		if (c=='P') {   /* palette escape sequence */
 			for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
 				vc->vc_par[vc->vc_npar] = 0;
@@ -2297,9 +2324,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		} else if (c=='R') {   /* reset palette */
 			reset_palette(vc);
 			vc->vc_state = ESnormal;
-		} else if (c>='0' && c<='9')
-			vc->vc_state = ESosc;
-		else
+		} else if (isdigit(c)) {
+			vc->vc_oscmd = c - '0';
+			vc->vc_state = ESoscmd;
+		} else
 			vc->vc_state = ESnormal;
 		return;
 	case ESpalette:
@@ -2348,7 +2376,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		if (c == ';' && vc->vc_npar < NPAR - 1) {
 			vc->vc_npar++;
 			return;
-		} else if (c>='0' && c<='9') {
+		} else if (isdigit(c)) {
 			vc->vc_par[vc->vc_npar] *= 10;
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
@@ -2556,7 +2584,23 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		return;
 	case ESapc:
 		return;
-	case ESosc:
+	case ESoscmd: /* extract the first OSC param, the command */
+		if (isdigit(c)) {
+			vc->vc_oscmd *= 10;
+			vc->vc_oscmd += c - '0';
+		} else if (c == ';') {
+			vc->vc_state = ESoscparam;
+		} else {
+			vc->vc_state = ESnormal;
+		}
+		return;
+	case ESoscparam: /* extract second OSC param */
+		/* All recognized numeric OSC commands take only '?', indicating a query.
+		 * See note above regarding ESosc about lack of OSC terminator ST.
+		 */
+		if (c == '?')
+			handle_osc_query(tty, vc);
+		vc->vc_state = ESnormal;
 		return;
 	case ESpm:
 		return;
@@ -3441,8 +3485,8 @@ static void con_cleanup(struct tty_struct *tty)
 }
 
 static int default_color           = 7; /* white */
-static int default_italic_color    = 2; // green (ASCII)
-static int default_underline_color = 3; // cyan (ASCII)
+static int default_italic_color    = 2; /* green */
+static int default_underline_color = 3; /* cyan */
 module_param_named(color, default_color, int, S_IRUGO | S_IWUSR);
 module_param_named(italic, default_italic_color, int, S_IRUGO | S_IWUSR);
 module_param_named(underline, default_underline_color, int, S_IRUGO | S_IWUSR);
diff --git include/linux/console_struct.h include/linux/console_struct.h
index d5b9c8d40c18..6d4fa51b62de 100644
--- include/linux/console_struct.h
+++ include/linux/console_struct.h
@@ -128,6 +128,7 @@ struct vc_data {
 	/* VT terminal data */
 	unsigned int	vc_state;		/* Escape sequence parser state */
 	unsigned int	vc_npar,vc_par[NPAR];	/* Parameters of current escape sequence */
+	unsigned int	vc_oscmd; /* Operating System Command selector */
 	/* data for manual vt switching */
 	struct vt_mode	vt_mode;
 	struct pid 	*vt_pid;
-- 
2.34.1


-- 
nick black -=- https://www.nick-black.com
to make an apple pie from scratch,
you need first invent a universe.
