Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2D4B51F789
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237610AbiEII7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 04:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237317AbiEII20 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 04:28:26 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74EB21CD26E;
        Mon,  9 May 2022 01:23:52 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 125-20020a1c1983000000b003941f354c62so7808795wmz.0;
        Mon, 09 May 2022 01:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=i2Qi/S+sxiKTAHGOLDcEAQw/gh3Pm7CUHMb/ImnrN98=;
        b=TKMNQCoHsDWM0Vhziyc+UWMGRULw3+jpIFn5vR6V7YfePDO1JEQGn3/wf6k/G+6C1r
         a4pHh2roArWTc5Lj/fWW9IISjlNNHjX+uDSg0uKJmXPnkgenwliXEZcFRE1O5BzPGSgl
         U9orIvXDfFIrXyTkJPWpJ+h17ko6Zt8daFIsUgaFFRpYAe/fxVN+uV0HTflMuOUqHFMY
         FeL9t6YFO9MCa+pGeXNB+CnPaodvsQOdyI3PCyHDkgbt/4KAxYzbTP901OqdvXN/XQnp
         G5cL2ghJqQUGDxuc3I467heMMj2bSvash8bqSGsSH/IAahr6P+grhGMtO94Zt7xJPwXs
         RReQ==
X-Gm-Message-State: AOAM531APj4itGUA9hicGwhP9nGhTNxtmBBQtjfqTZpoa8J1cYcazndH
        tRf4c44CcmX1qK5Dbwh/0a0=
X-Google-Smtp-Source: ABdhPJyUm/4FivbVYFxx04hFqb+p/qzyCNH80khFiViR3ip7WCNUdsDOdGUPm5QNg7L35nSIzjE10A==
X-Received: by 2002:a05:600c:48a6:b0:394:39c3:52 with SMTP id j38-20020a05600c48a600b0039439c30052mr21449886wmp.66.1652084630862;
        Mon, 09 May 2022 01:23:50 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id az20-20020adfe194000000b0020aca418f26sm10531303wrb.1.2022.05.09.01.23.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 May 2022 01:23:50 -0700 (PDT)
Message-ID: <c29b3438-a2ed-99b9-4aae-f06eb4f2cfb5@kernel.org>
Date:   Mon, 9 May 2022 10:23:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH 2/2] tty: n_gsm: fix deadlock and link starvation in
 outgoing data path
Content-Language: en-US
To:     "D. Starke" <daniel.starke@siemens.com>,
        linux-serial@vger.kernel.org, gregkh@linuxfoundation.org
Cc:     linux-kernel@vger.kernel.org
References: <20220506144725.1946-1-daniel.starke@siemens.com>
 <20220506144725.1946-2-daniel.starke@siemens.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <20220506144725.1946-2-daniel.starke@siemens.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06. 05. 22, 16:47, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> The current implementation queues up new control and user packets as needed
> and processes this queue down to the ldisc in the same code path.
> That means that the upper and the lower layer are hard coupled in the code.
> Due to this deadlocks can happen as seen below while transmitting data,
> especially during ldisc congestion. Furthermore, the data channels starve
> the control channel on high transmission load on the ldisc.
> 
> Introduce an additional control channel data queue to prevent timeouts and
> link hangups during ldisc congestion. This is being processed before the
> user channel data queue in gsm_data_kick(), i.e. with the highest priority.
> Put the queue to ldisc data path into a tasklet and trigger it whenever new

Tasklet? There is an ongoing work to phase them all out. So please don't 
add a new one -- you'd have to use something different.

...
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -5,6 +5,14 @@
>    *
>    *	* THIS IS A DEVELOPMENT SNAPSHOT IT IS NOT A FINAL RELEASE *
>    *
> + * Outgoing path:
> + * tty -> DLCI fifo -> scheduler -> GSM MUX data queue    ---o-> ldisc
> + * control message               -> GSM MUX control queue --´
> + *
> + * Incoming path:
> + * ldisc -> gsm_queue() -o--> tty
> + *                        `-> gsm_control_response()
> + *
>    * TO DO:
>    *	Mostly done:	ioctls for setting modes/timing
>    *	Partly done:	hooks so you can pull off frames to non tty devs
> @@ -210,6 +218,9 @@ struct gsm_mux {
>   	/* Events on the GSM channel */
>   	wait_queue_head_t event;
>   
> +	/* ldisc write task */
> +	struct tasklet_struct tx_tsk;
> +
>   	/* Bits for GSM mode decoding */
>   
>   	/* Framing Layer */
> @@ -240,9 +251,11 @@ struct gsm_mux {
>   	unsigned int tx_bytes;		/* TX data outstanding */
>   #define TX_THRESH_HI		8192
>   #define TX_THRESH_LO		2048
> -	struct list_head tx_list;	/* Pending data packets */
> +	struct list_head tx0_list;	/* Pending control packets */
> +	struct list_head tx1_list;	/* Pending data packets */
>   
>   	/* Control messages */
> +	struct timer_list kick_timer;	/* Kick TX queuing on timeout */
>   	struct timer_list t2_timer;	/* Retransmit timer for commands */
>   	int cretries;			/* Command retry counter */
>   	struct gsm_control *pending_cmd;/* Our current pending command */
> @@ -369,6 +382,8 @@ static const u8 gsm_fcs8[256] = {
>   
>   static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
>   static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
> +static void gsmld_write_trigger(struct gsm_mux *gsm);
> +static void gsmld_write_task(unsigned long arg);
>   
>   /**
>    *	gsm_fcs_add	-	update FCS
> @@ -419,6 +434,29 @@ static int gsm_read_ea(unsigned int *val, u8 c)
>   	return c & EA;
>   }
>   
> +/**
> + *	gsm_read_ea_val	-	read a value until EA
> + *	@val: variable holding value
> + *	@data: buffer of data
> + *	@clen: length of buffer
> + *
> + *	Processes an EA value. Updates the passed variable and
> + *	returns the processed data length.
> + */
> +static int gsm_read_ea_val(unsigned int *val, const u8 *data, int clen)

So clen can be negative provided it is (signed) int?

> +{
> +	int len;
> +
> +	for (len = 0; clen > 0; len++, clen--) {
> +		if (gsm_read_ea(val, *data++)) {
> +			/* done */
> +			len += 1;

len++

> +			break;
> +		}
> +	}

Anyway, is that a harder-to-read variant of:
   unsigned int len = 0;

   for (; clen > 0; clen--) {
     len++;
     if (gsm_read_ea(val, *data++))
       break;
   }
?

> +	return len;
> +}
> +
>   /**
>    *	gsm_encode_modem	-	encode modem data bits
>    *	@dlci: DLCI to encode from
> @@ -544,94 +582,6 @@ static int gsm_stuff_frame(const u8 *input, u8 *output, int len)
>   	return olen;
>   }
>   
> -/**
> - *	gsm_send	-	send a control frame
> - *	@gsm: our GSM mux
> - *	@addr: address for control frame
> - *	@cr: command/response bit seen as initiator
> - *	@control:  control byte including PF bit
> - *
> - *	Format up and transmit a control frame. These do not go via the
> - *	queueing logic as they should be transmitted ahead of data when
> - *	they are needed.
> - *
> - *	FIXME: Lock versus data TX path
> - */
> -
> -static void gsm_send(struct gsm_mux *gsm, int addr, int cr, int control)
> -{
> -	int len;
> -	u8 cbuf[10];
> -	u8 ibuf[3];
> -	int ocr;
> -
> -	/* toggle C/R coding if not initiator */
> -	ocr = cr ^ (gsm->initiator ? 0 : 1);
> -
> -	switch (gsm->encoding) {
> -	case 0:
> -		cbuf[0] = GSM0_SOF;
> -		cbuf[1] = (addr << 2) | (ocr << 1) | EA;
> -		cbuf[2] = control;
> -		cbuf[3] = EA;	/* Length of data = 0 */
> -		cbuf[4] = 0xFF - gsm_fcs_add_block(INIT_FCS, cbuf + 1, 3);
> -		cbuf[5] = GSM0_SOF;
> -		len = 6;
> -		break;
> -	case 1:
> -	case 2:
> -		/* Control frame + packing (but not frame stuffing) in mode 1 */
> -		ibuf[0] = (addr << 2) | (ocr << 1) | EA;
> -		ibuf[1] = control;
> -		ibuf[2] = 0xFF - gsm_fcs_add_block(INIT_FCS, ibuf, 2);
> -		/* Stuffing may double the size worst case */
> -		len = gsm_stuff_frame(ibuf, cbuf + 1, 3);
> -		/* Now add the SOF markers */
> -		cbuf[0] = GSM1_SOF;
> -		cbuf[len + 1] = GSM1_SOF;
> -		/* FIXME: we can omit the lead one in many cases */
> -		len += 2;
> -		break;
> -	default:
> -		WARN_ON(1);
> -		return;
> -	}
> -	gsmld_output(gsm, cbuf, len);
> -	if (!gsm->initiator) {
> -		cr = cr & gsm->initiator;
> -		control = control & ~PF;
> -	}
> -	gsm_print_packet("-->", addr, cr, control, NULL, 0);
> -}
> -
> -/**
> - *	gsm_response	-	send a control response
> - *	@gsm: our GSM mux
> - *	@addr: address for control frame
> - *	@control:  control byte including PF bit
> - *
> - *	Format up and transmit a link level response frame.
> - */
> -
> -static inline void gsm_response(struct gsm_mux *gsm, int addr, int control)
> -{
> -	gsm_send(gsm, addr, 0, control);
> -}
> -
> -/**
> - *	gsm_command	-	send a control command
> - *	@gsm: our GSM mux
> - *	@addr: address for control frame
> - *	@control:  control byte including PF bit
> - *
> - *	Format up and transmit a link level command frame.
> - */
> -
> -static inline void gsm_command(struct gsm_mux *gsm, int addr, int control)
> -{
> -	gsm_send(gsm, addr, 1, control);
> -}
> -
>   /* Data transmission */
>   
>   #define HDR_LEN		6	/* ADDR CTRL [LEN.2] DATA FCS */
> @@ -664,61 +614,158 @@ static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
>   }
>   
>   /**
> - *	gsm_data_kick		-	poke the queue
> + *	gsm_send_packet	-	sends a single packet
>    *	@gsm: GSM Mux
> - *	@dlci: DLCI sending the data
> + *	@msg: packet to send
>    *
> - *	The tty device has called us to indicate that room has appeared in
> - *	the transmit queue. Ram more data into the pipe if we have any
> - *	If we have been flow-stopped by a CMD_FCOFF, then we can only
> - *	send messages on DLCI0 until CMD_FCON
> + *	The given packet is encoded and send out. No memory is freed.
> + *	The caller must hold the gsm tx lock.
> + */
> +static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg)
> +{
> +	int len, ret;
> +
> +
> +	if (gsm->encoding == 0) {
> +		gsm->txframe[0] = GSM0_SOF;
> +		memcpy(gsm->txframe + 1, msg->data, msg->len);
> +		gsm->txframe[msg->len + 1] = GSM0_SOF;
> +		len = msg->len + 2;
> +	} else {
> +		gsm->txframe[0] = GSM1_SOF;
> +		len = gsm_stuff_frame(msg->data, gsm->txframe + 1, msg->len);
> +		gsm->txframe[len + 1] = GSM1_SOF;
> +		len += 2;
> +	}
> +
> +	if (debug & 4)
> +		print_hex_dump_bytes("gsm_send_packet: ", DUMP_PREFIX_OFFSET,
> +				     gsm->txframe, len);
> +	gsm_print_packet("-->", msg->addr, gsm->initiator, msg->ctrl, msg->data,
> +			 msg->len);
> +
> +	ret = gsmld_output(gsm, gsm->txframe, len);
> +	if (ret <= 0)
> +		return ret;
> +	gsm->tx_bytes -= msg->len;
> +
> +	return 0;
> +}
> +
> +/**
> + *	gsm_is_ctrl_flow_msg	-	checks if control flow message
> + *	@msg: message to check
>    *
> - *	FIXME: lock against link layer control transmissions
> + *	Returns non zero if the given message is a flow control command of the
> + *	control channel. Zero is returned in any other case.
>    */
> +static int gsm_is_ctrl_flow_msg(struct gsm_msg *msg)
> +{
> +	int ret;
> +	unsigned int cmd;
> +
> +	if (msg->addr > 0)
> +		return 0;
> +
> +	ret = 0;
> +	switch (msg->ctrl & ~PF) {
> +	case UI:
> +	case UIH:
> +		cmd = 0;
> +		if (gsm_read_ea_val(&cmd, msg->data + 2, msg->len - 2) < 1)
> +			break;
> +		switch (cmd & ~PF) {
> +		case CMD_FCOFF:
> +		case CMD_FCON:
> +			ret = 1;
> +			break;
> +		default:
> +			break;
> +		}
> +		break;
> +	default:
> +		break;
> +	}
> +
> +	return ret;
> +}
>   
> -static void gsm_data_kick(struct gsm_mux *gsm, struct gsm_dlci *dlci)
> +/**
> + *	gsm_data_kick	-	poke the queue
> + *	@gsm: GSM Mux
> + *
> + *	The tty device has called us to indicate that room has appeared in
> + *	the transmit queue. Ram more data into the pipe if we have any.
> + *	If we have been flow-stopped by a CMD_FCOFF, then we can only
> + *	send messages on DLCI0 until CMD_FCON. The caller must hold
> + *	the gsm tx lock.
> + */
> +static int gsm_data_kick(struct gsm_mux *gsm)
>   {
>   	struct gsm_msg *msg, *nmsg;
> -	int len;
> +	struct gsm_dlci *dlci;
> +	int ret;
>   
> -	list_for_each_entry_safe(msg, nmsg, &gsm->tx_list, list) {
> -		if (gsm->constipated && msg->addr)
> +	clear_bit(TTY_DO_WRITE_WAKEUP, &gsm->tty->flags);
> +
> +	/* Serialize control messages and control channel messages first */
> +	list_for_each_entry_safe(msg, nmsg, &gsm->tx0_list, list) {
> +		if (gsm->constipated && !gsm_is_ctrl_flow_msg(msg))
> +			return -EAGAIN;
> +		ret = gsm_send_packet(gsm, msg);
> +		switch (ret) {
> +		case -ENOSPC:
> +			return -ENOSPC;
> +		case -ENODEV:
> +			/* ldisc not open */
> +			gsm->tx_bytes -= msg->len;
> +			list_del(&msg->list);
> +			kfree(msg);
>   			continue;
> -		if (gsm->encoding != 0) {
> -			gsm->txframe[0] = GSM1_SOF;
> -			len = gsm_stuff_frame(msg->data,
> -						gsm->txframe + 1, msg->len);
> -			gsm->txframe[len + 1] = GSM1_SOF;
> -			len += 2;
> -		} else {
> -			gsm->txframe[0] = GSM0_SOF;
> -			memcpy(gsm->txframe + 1 , msg->data, msg->len);
> -			gsm->txframe[msg->len + 1] = GSM0_SOF;
> -			len = msg->len + 2;
> -		}
> -
> -		if (debug & 4)
> -			print_hex_dump_bytes("gsm_data_kick: ",
> -					     DUMP_PREFIX_OFFSET,
> -					     gsm->txframe, len);
> -		if (gsmld_output(gsm, gsm->txframe, len) <= 0)
> +		default:
> +			if (ret >= 0) {
> +				list_del(&msg->list);
> +				kfree(msg);
> +			}
>   			break;
> -		/* FIXME: Can eliminate one SOF in many more cases */
> -		gsm->tx_bytes -= msg->len;
> -
> -		list_del(&msg->list);
> -		kfree(msg);
> +		}
> +	}
>   
> -		if (dlci) {
> -			tty_port_tty_wakeup(&dlci->port);
> -		} else {
> -			int i = 0;
> +	if (gsm->constipated)
> +		return -EAGAIN;
>   
> -			for (i = 0; i < NUM_DLCI; i++)
> -				if (gsm->dlci[i])
> -					tty_port_tty_wakeup(&gsm->dlci[i]->port);
> +	/* Serialize other channels */
> +	if (list_empty(&gsm->tx1_list))
> +		return 0;
> +	list_for_each_entry_safe(msg, nmsg, &gsm->tx1_list, list) {
> +		dlci = gsm->dlci[msg->addr];
> +		/* Send only messages for DLCIs with valid state */
> +		if (dlci->state != DLCI_OPEN) {
> +			gsm->tx_bytes -= msg->len;
> +			list_del(&msg->list);
> +			kfree(msg);
> +			continue;
> +		}
> +		ret = gsm_send_packet(gsm, msg);
> +		switch (ret) {
> +		case -ENOSPC:
> +			return -ENOSPC;
> +		case -ENODEV:
> +			/* ldisc not open */
> +			gsm->tx_bytes -= msg->len;
> +			list_del(&msg->list);
> +			kfree(msg);
> +			continue;
> +		default:
> +			if (ret >= 0) {
> +				list_del(&msg->list);
> +				kfree(msg);
> +			}
> +			break;
>   		}
>   	}
> +
> +	return 1;
>   }


That feels like a LOT of code shuffling. It's unreviewable. Please split 
into several patches.

thanks,
-- 
js
suse labs
