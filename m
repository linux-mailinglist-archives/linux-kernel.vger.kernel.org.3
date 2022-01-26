Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9577949CBC6
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 15:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241908AbiAZOEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 09:04:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235083AbiAZOEn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 09:04:43 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9D6FC06161C
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 06:04:42 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9711FB81E4D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 14:04:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0D10C340E3;
        Wed, 26 Jan 2022 14:04:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1643205880;
        bh=71yBoAkz9EZAZNyiaT1bhPweesUtxVlpM7mYhClnBnI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Yln0IrsCC7+IeXlfgpacJwvTpmT1poAmX1dUkbBRJbkXnHN3I46rzc7g91Odhgq+z
         pML4UQXNnrrG2ZVK2CVw9LiZ/tuOHaFU/VFpqWq7qfu7oeN8CO6Za3+wSX7TKd5vNZ
         X7PChF+z4rRnz7HP3Ms65uj8cuoo5Gt9Fj84tKMQ=
Date:   Wed, 26 Jan 2022 15:04:36 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     nick black <dankamongmen@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        linux-kernel@vger.kernel.org,
        Thomas Dickey <dickey@invisible-island.net>
Subject: Re: [PATCH v2] console: answer OSC 10 and 11
Message-ID: <YfFU9Dp1Bfa4Ljss@kroah.com>
References: <Ye495ub177QSJxM7@schwarzgerat.orthanc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ye495ub177QSJxM7@schwarzgerat.orthanc>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:49:26AM -0500, nick black wrote:
> XTerm and many other terminal emulators implement
> Operating System Commands 10 and 11, allowing the
> default foreground/background to be set and queried.
> Extend the VT control sequence parser to recognize
> and support these queries.

Nit, can you use the full 72 columns here?

> The VT already implements two OSCs, for changing
> and resetting the palette. In doing so (many years
> ago), it broke from the ANSI standard, and did not
> require an ST terminator. Read all about it in
> xterm(1) (see "brokenLinuxOSC"). I have followed this
> grand tradition, and similarly not required ST.
> Note that ST can still be safely sent by a client
> program, as the VT consumes it. Indeed, my Notcurses
> library does exactly this.
> 
> "Don't VTs always have black backgrounds?" Nope, you
> can change the default background color with any
> number of ANSI sequences, and then use the VT's
> Private CSI "ESC [ 8 ]" to make the current color pair
> the default attributes. Try it at home with, say:
> 
>   printf %b '\e[46m' '\e[8]' '\e[H\e[J'
> 
> The response follows XTerm's effective lead, using
> %02x/%02x/%02x to format the RGB value, rather than
> the %02x%02x%02x preferred by the preexisting
> P (set palette) OSC. This was done to simplify
> client libraries. Note that the spirit of the law,
> that the reply is a "control sequence of the same
> form which can be used to set", cannot be easily
> honored given the semantics of the Linux private CSI
> sequence. So it goes.
> 
> As a result, notcurses-info now properly detects the
> default colors dynamically. Where it used to say:
> 
>  no known default fg no known default bg
> 
> It now says on boot:
> 
>  notcurses 3.0.4 on Linux 5.16.0nlb VT
>  ...
>  default fg 0xaaaaaa default bg 0x000000
> 
> and after a change like that above:
> 
>  notcurses 3.0.4 on Linux 5.16.0nlb VT
>  ...
>  default fg 0xaaaaaa default bg 0xaa5500
> 
> This is necessary to produce readable multicolor text
> while respecting the user's background choice.
> 
> Signed-off-by: nick black <dankamongmen@gmail.com>
> ---
> Changes in v2:
>  - Reverse in-kernel BGR to RGB
> 
>  drivers/tty/vt/vt.c            | 67 ++++++++++++++++++++++++++++------
>  include/linux/console_struct.h |  1 +
>  2 files changed, 58 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
> index f8c87c4d7399..a10629bcaaa1 100644
> --- a/drivers/tty/vt/vt.c
> +++ b/drivers/tty/vt/vt.c
> @@ -1878,6 +1878,31 @@ int mouse_reporting(void)
>  	return vc_cons[fg_console].d->vc_report_mouse;
>  }
>  
> +/* handle the OSC query specified by vc->vc_oscmd. we currently handle only 10
> + * and 11 (default foreground and default background, respectively).
> + */
> +static void handle_osc_query(struct tty_struct *tty, const struct vc_data *vc)
> +{
> +	char buf[20];
> +	int len, idx;
> +	/* response payload conforms to XTerm: %02x/%02x/%02x for R, G, and B. */

Nit, new line needed after variable list.



> +	switch (vc->vc_oscmd) {
> +	case 10: /* get default foreground */
> +		idx = vc->vc_def_color & 0x0f;
> +		break;
> +	case 11: /* get default background */
> +		idx = (vc->vc_def_color & 0xf0) >> 4;
> +		break;

Does 10 and 11 have a #define or enum anywhere?

> +	default:
> +		return;

No need to return an error?  Why not?

> +	}
> +	/* transpose internal BGR to RGB on output */
> +	len = snprintf(buf, sizeof(buf), "\x1b]%d;rgb:%02x/%02x/%02x\x1b\\",
> +		vc->vc_oscmd, vc->vc_palette[idx * 3 + 2],
> +		vc->vc_palette[idx * 3 + 1], vc->vc_palette[idx * 3]);
> +	respond_string(buf, len, tty->port);
> +}
> +
>  /* console_lock is held */
>  static void set_mode(struct vc_data *vc, int on_off)
>  {
> @@ -2075,8 +2100,8 @@ static void restore_cur(struct vc_data *vc)
>  }
>  
>  enum { ESnormal, ESesc, ESsquare, ESgetpars, ESfunckey,
> -	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore, ESnonstd,
> -	ESpalette, ESosc, ESapc, ESpm, ESdcs };
> +	EShash, ESsetG0, ESsetG1, ESpercent, EScsiignore,
> +	ESpalette, ESosc, ESoscmd, ESoscparam, ESapc, ESpm, ESdcs };
>  
>  /* console_lock is held (except via vc_init()) */
>  static void reset_terminal(struct vc_data *vc, int do_clear)
> @@ -2230,7 +2255,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>  			vc->vc_state = ESsquare;
>  			return;
>  		case ']':
> -			vc->vc_state = ESnonstd;
> +			vc->vc_state = ESosc;
>  			return;
>  		case '_':
>  			vc->vc_state = ESapc;
> @@ -2287,7 +2312,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>  			return;
>  		}
>  		return;
> -	case ESnonstd:
> +	case ESosc:
> +		/* Operating System Commands are traditionally terminated with an ST
> +		 * or a BEL, but Linux historically eschews said terminators.
> +		 */
>  		if (c=='P') {   /* palette escape sequence */
>  			for (vc->vc_npar = 0; vc->vc_npar < NPAR; vc->vc_npar++)
>  				vc->vc_par[vc->vc_npar] = 0;
> @@ -2297,9 +2325,10 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>  		} else if (c=='R') {   /* reset palette */
>  			reset_palette(vc);
>  			vc->vc_state = ESnormal;
> -		} else if (c>='0' && c<='9')
> -			vc->vc_state = ESosc;
> -		else
> +		} else if (isdigit(c)) {
> +			vc->vc_oscmd = c - '0';
> +			vc->vc_state = ESoscmd;

We used to jump to ESosc here, what happened to that if the command is
invalid?

> +		} else
>  			vc->vc_state = ESnormal;
>  		return;
>  	case ESpalette:
> @@ -2348,7 +2377,7 @@ static void do_con_trol(struct tty_struct *tty, struct vc_data *vc, int c)
>  		if (c == ';' && vc->vc_npar < NPAR - 1) {
>  			vc->vc_npar++;
>  			return;
> -		} else if (c>='0' && c<='9') {
> +		} else if (isdigit(c)) {

Different change, you can put this in a different patch.

thanks,

greg k-h
