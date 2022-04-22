Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D831A50BA2F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:34:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448705AbiDVOhE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:37:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243004AbiDVOhC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:37:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B11565B3DA;
        Fri, 22 Apr 2022 07:34:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3E6A261E8D;
        Fri, 22 Apr 2022 14:34:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0873AC385A0;
        Fri, 22 Apr 2022 14:34:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650638047;
        bh=dIXCm0hZI/e6fnvOzi+R+cBoU+Z0Ola80tlgejCw1OE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n64HnYw/760Xua8ymLJgy6F9XFmN0jncLX0/Yt9BzsTj6EzPDmzN4qT30QKKxWM5q
         VqRlPVpFbpKMTISJ55hcoPd4CugCwVp1pNxpTT+SQ7qXWucmqU3MDssXxmA8jC0ysC
         O6bb0uEkIafnYGg3iPkz1ej/RmCnhMzh/sWnOQb8=
Date:   Fri, 22 Apr 2022 16:34:04 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Ilpo =?iso-8859-1?Q?J=E4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org,
        Gilles Buloz <gilles.buloz@kontron.com>,
        Johan Hovold <johan@kernel.org>
Subject: Re: [PATCH v3 3/5] tty: Add lookahead param to receive_buf
Message-ID: <YmK83NfVqEvGg8DW@kroah.com>
References: <20220411094859.10894-1-ilpo.jarvinen@linux.intel.com>
 <20220411094859.10894-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411094859.10894-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 12:48:57PM +0300, Ilpo Järvinen wrote:
> After lookahead for XON/XOFF characters is added by the next
> patch,

There is no "next" in a series.  This commit needs to be justified here,
right?

> the receive side needs to ensure the flow-control
> actions are not retaken later on when those same characters
> get received by TTY.
> 
> Thus, pass lookahead count to receive_buf and skip
> flow-control character actions if already taken for the
> character in question. Lookahead count will become live after
> the next patch.

You have all 72 columns, please use them.

> 
> The logic in n_tty_receive_char_closing is bit tricky.
> The lookahead_done checks cannot be combined with the main
> conditions because doing so would give chance for the part
> after || in the else if condition to execute when lookahead
> done is set (rather than just skipping the flow-control
> character like it should).
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/accessibility/speakup/spk_ttyio.c |  2 +-
>  drivers/bluetooth/hci_ldisc.c             |  2 +-
>  drivers/char/pcmcia/synclink_cs.c         |  2 +-
>  drivers/input/serio/serport.c             |  4 +-
>  drivers/isdn/capi/capi.c                  |  2 +-
>  drivers/misc/ti-st/st_core.c              |  2 +-
>  drivers/net/caif/caif_serial.c            |  4 +-
>  drivers/net/can/slcan.c                   |  2 +-
>  drivers/net/hamradio/6pack.c              |  4 +-
>  drivers/net/hamradio/mkiss.c              |  2 +-
>  drivers/net/mctp/mctp-serial.c            |  2 +-
>  drivers/net/ppp/ppp_async.c               |  2 +-
>  drivers/net/ppp/ppp_synctty.c             |  2 +-
>  drivers/net/slip/slip.c                   |  2 +-
>  drivers/tty/n_gsm.c                       |  2 +-
>  drivers/tty/n_hdlc.c                      |  2 +-
>  drivers/tty/n_null.c                      |  2 +-
>  drivers/tty/n_tty.c                       | 53 ++++++++++++++---------
>  drivers/tty/serdev/serdev-ttyport.c       |  3 +-
>  drivers/tty/synclink_gt.c                 |  2 +-
>  drivers/tty/tty_buffer.c                  |  8 ++--
>  drivers/tty/tty_io.c                      |  2 +-
>  drivers/tty/tty_port.c                    |  5 ++-
>  drivers/tty/vt/selection.c                |  2 +-
>  include/linux/tty_flip.h                  |  2 +-
>  include/linux/tty_ldisc.h                 | 20 ++++++---
>  include/linux/tty_port.h                  |  3 +-
>  net/nfc/nci/uart.c                        |  2 +-
>  sound/soc/codecs/cx20442.c                |  2 +-
>  sound/soc/ti/ams-delta.c                  |  2 +-
>  30 files changed, 83 insertions(+), 63 deletions(-)
> 
> diff --git a/drivers/accessibility/speakup/spk_ttyio.c b/drivers/accessibility/speakup/spk_ttyio.c
> index 08cf8a17754b..b33536eea1d3 100644
> --- a/drivers/accessibility/speakup/spk_ttyio.c
> +++ b/drivers/accessibility/speakup/spk_ttyio.c
> @@ -73,7 +73,7 @@ static void spk_ttyio_ldisc_close(struct tty_struct *tty)
>  
>  static int spk_ttyio_receive_buf2(struct tty_struct *tty,
>  				  const unsigned char *cp,
> -				  const char *fp, int count)
> +				  const char *fp, int count, unsigned int lookahead_count)

Ick, adding yet-another-parameter to a function is a mess as it's hard
to know what to do with this and what it means just by looking at when
it is called.


>  {
>  	struct spk_ldisc_data *ldisc_data = tty->disc_data;
>  	struct spk_synth *synth = ldisc_data->synth;
> diff --git a/drivers/bluetooth/hci_ldisc.c b/drivers/bluetooth/hci_ldisc.c
> index f537673ede17..08c329a4cdcc 100644
> --- a/drivers/bluetooth/hci_ldisc.c
> +++ b/drivers/bluetooth/hci_ldisc.c
> @@ -596,7 +596,7 @@ static void hci_uart_tty_wakeup(struct tty_struct *tty)
>   * Return Value:    None
>   */
>  static void hci_uart_tty_receive(struct tty_struct *tty, const u8 *data,
> -				 const char *flags, int count)
> +				 const char *flags, int count, unsigned int lookahead_count)
>  {
>  	struct hci_uart *hu = tty->disc_data;
>  
> diff --git a/drivers/char/pcmcia/synclink_cs.c b/drivers/char/pcmcia/synclink_cs.c
> index 78baba55a8b5..de9c151cfb12 100644
> --- a/drivers/char/pcmcia/synclink_cs.c
> +++ b/drivers/char/pcmcia/synclink_cs.c
> @@ -501,7 +501,7 @@ static void ldisc_receive_buf(struct tty_struct *tty,
>  	ld = tty_ldisc_ref(tty);
>  	if (ld) {
>  		if (ld->ops->receive_buf)
> -			ld->ops->receive_buf(tty, data, flags, count);
> +			ld->ops->receive_buf(tty, data, flags, count, 0);
>  		tty_ldisc_deref(ld);
>  	}
>  }
> diff --git a/drivers/input/serio/serport.c b/drivers/input/serio/serport.c
> index 669a728095b8..f0f19b5a2059 100644
> --- a/drivers/input/serio/serport.c
> +++ b/drivers/input/serio/serport.c
> @@ -114,8 +114,8 @@ static void serport_ldisc_close(struct tty_struct *tty)
>   * 'interrupt' routine.
>   */
>  
> -static void serport_ldisc_receive(struct tty_struct *tty,
> -		const unsigned char *cp, const char *fp, int count)
> +static void serport_ldisc_receive(struct tty_struct *tty, const unsigned char *cp,
> +				  const char *fp, int count, unsigned int lookahead_count)
>  {
>  	struct serport *serport = (struct serport*) tty->disc_data;
>  	unsigned long flags;
> diff --git a/drivers/isdn/capi/capi.c b/drivers/isdn/capi/capi.c
> index 0f00be62438d..beb4c78a7219 100644
> --- a/drivers/isdn/capi/capi.c
> +++ b/drivers/isdn/capi/capi.c
> @@ -454,7 +454,7 @@ static int handle_recv_skb(struct capiminor *mp, struct sk_buff *skb)
>  		skb_pull(skb, CAPIMSG_LEN(skb->data));
>  		pr_debug("capi: DATA_B3_RESP %u len=%d => ldisc\n",
>  			 datahandle, skb->len);
> -		ld->ops->receive_buf(tty, skb->data, NULL, skb->len);
> +		ld->ops->receive_buf(tty, skb->data, NULL, skb->len, 0);
>  	} else {
>  		printk(KERN_ERR "capi: send DATA_B3_RESP failed=%x\n",
>  		       errcode);
> diff --git a/drivers/misc/ti-st/st_core.c b/drivers/misc/ti-st/st_core.c
> index 7f6976a9f508..b2c96d72c0e3 100644
> --- a/drivers/misc/ti-st/st_core.c
> +++ b/drivers/misc/ti-st/st_core.c
> @@ -797,7 +797,7 @@ static void st_tty_close(struct tty_struct *tty)
>  }
>  
>  static void st_tty_receive(struct tty_struct *tty, const unsigned char *data,
> -			   const char *tty_flags, int count)
> +			   const char *tty_flags, int count, unsigned int lookahead_count)
>  {
>  #ifdef VERBOSE
>  	print_hex_dump(KERN_DEBUG, ">in>", DUMP_PREFIX_NONE,
> diff --git a/drivers/net/caif/caif_serial.c b/drivers/net/caif/caif_serial.c
> index 688075859ae4..cc97c436ec88 100644
> --- a/drivers/net/caif/caif_serial.c
> +++ b/drivers/net/caif/caif_serial.c
> @@ -159,7 +159,7 @@ static inline void debugfs_tx(struct ser_device *ser, const u8 *data, int size)
>  #endif
>  
>  static void ldisc_receive(struct tty_struct *tty, const u8 *data,
> -			const char *flags, int count)
> +			  const char *flags, int count, unsigned int lookahead_count)
>  {
>  	struct sk_buff *skb = NULL;
>  	struct ser_device *ser;
> @@ -237,7 +237,7 @@ static int handle_tx(struct ser_device *ser)
>  			update_tty_status(ser);
>  		} else {
>  			tty_wr = len;
> -			ldisc_receive(tty, skb->data, NULL, len);
> +			ldisc_receive(tty, skb->data, NULL, len, 0);

See, what does 0 here mean?  Who knows?  Not a good api :(



>  		}
>  		ser->dev->stats.tx_packets++;
>  		ser->dev->stats.tx_bytes += tty_wr;
> diff --git a/drivers/net/can/slcan.c b/drivers/net/can/slcan.c
> index ec294d0c5722..5e03e14c2d99 100644
> --- a/drivers/net/can/slcan.c
> +++ b/drivers/net/can/slcan.c
> @@ -471,7 +471,7 @@ static void slc_setup(struct net_device *dev)
>  
>  static void slcan_receive_buf(struct tty_struct *tty,
>  			      const unsigned char *cp, const char *fp,
> -			      int count)
> +			      int count, unsigned int lookahead_count)
>  {
>  	struct slcan *sl = (struct slcan *) tty->disc_data;
>  
> diff --git a/drivers/net/hamradio/6pack.c b/drivers/net/hamradio/6pack.c
> index 45c3c4a1101b..6ba4b05dff78 100644
> --- a/drivers/net/hamradio/6pack.c
> +++ b/drivers/net/hamradio/6pack.c
> @@ -426,8 +426,8 @@ static void sixpack_write_wakeup(struct tty_struct *tty)
>   * a block of 6pack data has been received, which can now be decapsulated
>   * and sent on to some IP layer for further processing.
>   */
> -static void sixpack_receive_buf(struct tty_struct *tty,
> -	const unsigned char *cp, const char *fp, int count)
> +static void sixpack_receive_buf(struct tty_struct *tty, const unsigned char *cp,
> +				const char *fp, int count, unsigned int lookahead_count)
>  {
>  	struct sixpack *sp;
>  	int count1;
> diff --git a/drivers/net/hamradio/mkiss.c b/drivers/net/hamradio/mkiss.c
> index c251e04ae047..498997ef429a 100644
> --- a/drivers/net/hamradio/mkiss.c
> +++ b/drivers/net/hamradio/mkiss.c
> @@ -875,7 +875,7 @@ static int mkiss_ioctl(struct tty_struct *tty, unsigned int cmd,
>   * and sent on to the AX.25 layer for further processing.
>   */
>  static void mkiss_receive_buf(struct tty_struct *tty, const unsigned char *cp,
> -	const char *fp, int count)
> +			      const char *fp, int count, unsigned int lookahead_count)
>  {
>  	struct mkiss *ax = mkiss_get(tty);
>  
> diff --git a/drivers/net/mctp/mctp-serial.c b/drivers/net/mctp/mctp-serial.c
> index 7cd103fd34ef..f1dfab4c54cb 100644
> --- a/drivers/net/mctp/mctp-serial.c
> +++ b/drivers/net/mctp/mctp-serial.c
> @@ -390,7 +390,7 @@ static void mctp_serial_push(struct mctp_serial *dev, unsigned char c)
>  
>  static void mctp_serial_tty_receive_buf(struct tty_struct *tty,
>  					const unsigned char *c,
> -					const char *f, int len)
> +					const char *f, int len, unsigned int lookahead_count)
>  {
>  	struct mctp_serial *dev = tty->disc_data;
>  	int i;
> diff --git a/drivers/net/ppp/ppp_async.c b/drivers/net/ppp/ppp_async.c
> index 15a179631903..87c205a02984 100644
> --- a/drivers/net/ppp/ppp_async.c
> +++ b/drivers/net/ppp/ppp_async.c
> @@ -338,7 +338,7 @@ ppp_asynctty_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
>  /* May sleep, don't call from interrupt level or with interrupts disabled */
>  static void
>  ppp_asynctty_receive(struct tty_struct *tty, const unsigned char *buf,
> -		  const char *cflags, int count)
> +		     const char *cflags, int count, unsigned int lookahead_count)
>  {
>  	struct asyncppp *ap = ap_get(tty);
>  	unsigned long flags;
> diff --git a/drivers/net/ppp/ppp_synctty.c b/drivers/net/ppp/ppp_synctty.c
> index 18283b7b94bc..b82f4bd82b21 100644
> --- a/drivers/net/ppp/ppp_synctty.c
> +++ b/drivers/net/ppp/ppp_synctty.c
> @@ -331,7 +331,7 @@ ppp_sync_poll(struct tty_struct *tty, struct file *file, poll_table *wait)
>  /* May sleep, don't call from interrupt level or with interrupts disabled */
>  static void
>  ppp_sync_receive(struct tty_struct *tty, const unsigned char *buf,
> -		  const char *cflags, int count)
> +		 const char *cflags, int count, unsigned int lookahead_count)
>  {
>  	struct syncppp *ap = sp_get(tty);
>  	unsigned long flags;
> diff --git a/drivers/net/slip/slip.c b/drivers/net/slip/slip.c
> index 88396ff99f03..7fccf28256a8 100644
> --- a/drivers/net/slip/slip.c
> +++ b/drivers/net/slip/slip.c
> @@ -686,7 +686,7 @@ static void sl_setup(struct net_device *dev)
>   */
>  
>  static void slip_receive_buf(struct tty_struct *tty, const unsigned char *cp,
> -		const char *fp, int count)
> +			     const char *fp, int count, unsigned int lookahead_count)
>  {
>  	struct slip *sl = tty->disc_data;
>  
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index fa92f727fdf8..45f022892b28 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -2500,7 +2500,7 @@ static void gsmld_detach_gsm(struct tty_struct *tty, struct gsm_mux *gsm)
>  }
>  
>  static void gsmld_receive_buf(struct tty_struct *tty, const unsigned char *cp,
> -			      const char *fp, int count)
> +			      const char *fp, int count, unsigned int lookahead_count)
>  {
>  	struct gsm_mux *gsm = tty->disc_data;
>  	char flags = TTY_NORMAL;
> diff --git a/drivers/tty/n_hdlc.c b/drivers/tty/n_hdlc.c
> index 94c1ec2dd754..2d7c94a38a92 100644
> --- a/drivers/tty/n_hdlc.c
> +++ b/drivers/tty/n_hdlc.c
> @@ -379,7 +379,7 @@ static void n_hdlc_tty_wakeup(struct tty_struct *tty)
>   * interpreted as one HDLC frame.
>   */
>  static void n_hdlc_tty_receive(struct tty_struct *tty, const __u8 *data,
> -			       const char *flags, int count)
> +			       const char *flags, int count, unsigned int lookahead_count)
>  {
>  	register struct n_hdlc *n_hdlc = tty->disc_data;
>  	register struct n_hdlc_buf *buf;
> diff --git a/drivers/tty/n_null.c b/drivers/tty/n_null.c
> index f913b665af72..6bce76b5bb1c 100644
> --- a/drivers/tty/n_null.c
> +++ b/drivers/tty/n_null.c
> @@ -34,7 +34,7 @@ static ssize_t n_null_write(struct tty_struct *tty, struct file *file,
>  
>  static void n_null_receivebuf(struct tty_struct *tty,
>  				 const unsigned char *cp, const char *fp,
> -				 int cnt)
> +				 int cnt, unsigned int lookahead_count)
>  {
>  }
>  
> diff --git a/drivers/tty/n_tty.c b/drivers/tty/n_tty.c
> index 90b3e06cbeb1..708cc85ac43d 100644
> --- a/drivers/tty/n_tty.c
> +++ b/drivers/tty/n_tty.c
> @@ -1226,11 +1226,15 @@ static bool n_tty_is_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
>  }
>  
>  /* Returns true if c is consumed as flow-control character */
> -static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c)
> +static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c,
> +					 bool lookahead_done)
>  {
>  	if (!n_tty_is_char_flow_ctrl(tty, c))
>  		return false;
>  
> +	if (lookahead_done)
> +		return true;

Why would this function be called if this option was true?



> +
>  	if (c == START_CHAR(tty)) {
>  		start_tty(tty);
>  		process_echoes(tty);
> @@ -1241,11 +1245,12 @@ static bool n_tty_receive_char_flow_ctrl(struct tty_struct *tty, unsigned char c
>  	return true;
>  }
>  
> -static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c)
> +static void n_tty_receive_char_special(struct tty_struct *tty, unsigned char c,
> +				       bool lookahead_done)
>  {
>  	struct n_tty_data *ldata = tty->disc_data;
>  
> -	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c))
> +	if (I_IXON(tty) && n_tty_receive_char_flow_ctrl(tty, c, lookahead_done))
>  		return;
>  
>  	if (L_ISIG(tty)) {
> @@ -1400,7 +1405,8 @@ static void n_tty_receive_char(struct tty_struct *tty, unsigned char c)
>  	put_tty_queue(c, ldata);
>  }
>  
> -static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c)
> +static void n_tty_receive_char_closing(struct tty_struct *tty, unsigned char c,
> +				       bool lookahead_done)

bool here, yet characters elsewhere?  That's messy :(

the overall idea is good, this implementation isn't quite there yet.

I did take the first patch in the series, it made sense.

thanks,

greg k-h
