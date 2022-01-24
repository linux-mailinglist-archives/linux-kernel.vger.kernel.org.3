Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 237924978B8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 06:49:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235439AbiAXFta (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 00:49:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbiAXFt3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 00:49:29 -0500
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3881C06173B
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 21:49:28 -0800 (PST)
Received: by mail-qk1-x731.google.com with SMTP id d11so18889614qkj.12
        for <linux-kernel@vger.kernel.org>; Sun, 23 Jan 2022 21:49:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition;
        bh=+s8wCnWsTVg7vDdn0Dyg2pPBJKBG25qTB45iu3UC1Fc=;
        b=ON1YYzBxUZso0QvkOnWcpy6lUO6w2Mu7lAKl/5+qtOiWvTjjOsvqO30Qxwajn984hG
         RnUGZfj0SuShuiXfT92Tb7pzHDDUsZEzdZRD7baAxAHcfHfxMLD0JwWr/1MfbnBjNO7t
         yETbTtXwufC8QhWhqlPOLb9qjLE2PP+52CDsIgtwIr0sSzMjAeEMn2iSSEG73lTYx7+r
         8q1BVQAPCLSSy26dTtF6JxYKB9K84eDfJDNv/h9Vmf6ruoS2K8qo0jB4/2PvpEtSLaZZ
         xpeY96ApmEswcKpgbWOulmTHkefiEBTp9BKYj0HGlIEZ5wg3AlP5356sR4QAyZGEYZs5
         1Sww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=+s8wCnWsTVg7vDdn0Dyg2pPBJKBG25qTB45iu3UC1Fc=;
        b=BvcrrsZBxtGvwBDl4j1Mn1pgqcNaW5vm4lfW+I3OPSbl66UP/dUFH4QXcMdbuMzxVi
         hUl4vvs96NFwCbi2pPZ6/pfRyYtRDXl5ZbWZ9k6epr/sM3dWJdsN+uOE2h77bD35Jk0F
         zOkwMt14L2HX39CHsJ+1Pi/nILqiN2ieTA5xSpq1BvQbMeqSXPY1JUfkE+AwbIkoSxzU
         M1b3cwhVYdjJI5+aYCNcHJsQQNl7TKX33UfDMcW7NQOvlRYMdnK465TTWnGnByrUSSYT
         0pepkoMYpAM6jtmTzKB924MNCf5Nd37R1GAP+9UiemV9/TZ8gJGYQQoviYZhz7lFiwCR
         db4A==
X-Gm-Message-State: AOAM533xTWz+kXtvzjzanSWavPkX5MLLWTJ+sdAm/Z2EX/B6WeEqt/vs
        jnfx/nOtncZxMXYHqw3Plka7hnfzByE=
X-Google-Smtp-Source: ABdhPJxuvjDBEj1fS9tSqLNgITnYGxe83q9ABmalPFBfMg0lHZy6ZVNI+tfqggXbkVm0A70P/th2Iw==
X-Received: by 2002:a37:9405:: with SMTP id w5mr2916530qkd.682.1643003367757;
        Sun, 23 Jan 2022 21:49:27 -0800 (PST)
Received: from vps.qemfd.net (vps.qemfd.net. [173.230.130.29])
        by smtp.gmail.com with ESMTPSA id t123sm6994416qkh.31.2022.01.23.21.49.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Jan 2022 21:49:27 -0800 (PST)
Received: from schwarzgerat.orthanc (schwarzgerat.danknet [192.168.128.2])
        by vps.qemfd.net (Postfix) with ESMTP id A47942B1C6;
        Mon, 24 Jan 2022 00:49:26 -0500 (EST)
Received: by schwarzgerat.orthanc (Postfix, from userid 1000)
        id 9E0DB600433; Mon, 24 Jan 2022 00:49:26 -0500 (EST)
Date:   Mon, 24 Jan 2022 00:49:26 -0500
From:   nick black <dankamongmen@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Thomas Dickey <dickey@invisible-island.net>
Subject: [PATCH v2] console: answer OSC 10 and 11
Message-ID: <Ye495ub177QSJxM7@schwarzgerat.orthanc>
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
Changes in v2:
 - Reverse in-kernel BGR to RGB

 drivers/tty/vt/vt.c            | 67 ++++++++++++++++++++++++++++------
 include/linux/console_struct.h |  1 +
 2 files changed, 58 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index f8c87c4d7399..a10629bcaaa1 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1878,6 +1878,31 @@ int mouse_reporting(void)
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
+	/* transpose internal BGR to RGB on output */
+	len = snprintf(buf, sizeof(buf), "\x1b]%d;rgb:%02x/%02x/%02x\x1b\\",
+		vc->vc_oscmd, vc->vc_palette[idx * 3 + 2],
+		vc->vc_palette[idx * 3 + 1], vc->vc_palette[idx * 3]);
+	respond_string(buf, len, tty->port);
+}
+
 /* console_lock is held */
 static void set_mode(struct vc_data *vc, int on_off)
 {
@@ -2075,8 +2100,8 @@ static void restore_cur(struct vc_data *vc)
 }
 
 enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
-	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
-	ESpalette, ESosc, ESapc, ESpm, ESdcs };
+	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore,
+	ESpalette, ESosc, ESoscmd, ESoscparam, ESapc, ESpm, ESdcs };
 
 /* console_lock is held (except via vc_init()) */
 static void reset_terminal(struct vc_data *vc, int do_clear)
@@ -2230,7 +2255,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 			vc->vc_state = ESsquare;
 			return;
 		case ']':
-			vc->vc_state = ESnonstd;
+			vc->vc_state = ESosc;
 			return;
 		case '_':
 			vc->vc_state = ESapc;
@@ -2287,7 +2312,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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
@@ -2297,9 +2325,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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
@@ -2348,7 +2377,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
 		if (c == ';' && vc->vc_npar < NPAR - 1) {
 			vc->vc_npar++;
 			return;
-		} else if (c>='0' && c<='9') {
+		} else if (isdigit(c)) {
 			vc->vc_par[vc->vc_npar] *= 10;
 			vc->vc_par[vc->vc_npar] += c - '0';
 			return;
@@ -2556,7 +2585,23 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
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
@@ -3441,8 +3486,8 @@ static void con_cleanup(struct tty_struct *tty)
 }
 
 static int default_color           = 7; /* white */
-static int default_italic_color    = 2; // green (ASCII)
-static int default_underline_color = 3; // cyan (ASCII)
+static int default_italic_color    = 2; /* green */
+static int default_underline_color = 3; /* cyan */
 module_param_named(color, default_color, int, S_IRUGO | S_IWUSR);
 module_param_named(italic, default_italic_color, int, S_IRUGO | S_IWUSR);
 module_param_named(underline, default_underline_color, int, S_IRUGO | S_IWUSR);
diff --git a/include/linux/console_struct.h b/include/linux/console_struct.h
index d5b9c8d40c18..6d4fa51b62de 100644
--- a/include/linux/console_struct.h
+++ b/include/linux/console_struct.h
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

