Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D45AE59975C
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 10:36:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346989AbiHSI3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 04:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346304AbiHSI3T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 04:29:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E98487081;
        Fri, 19 Aug 2022 01:29:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EA84E61740;
        Fri, 19 Aug 2022 08:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C477CC433D6;
        Fri, 19 Aug 2022 08:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1660897756;
        bh=M4VWYblRt2gWcvwEQ+QqgGUBT83iqSspiF7691z4rhs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=mBOkUGxomIE+kpa3/DMm06qc9sAEa82+90DQqSnjOxaYHvs/kDfwSof2wvzO8e54K
         jFleToSQ2tMctSD4NfjqlQBH0KUftn+sQMIDwNN8VoJc13Ajm0c3rMY5wnPCtqJ9QJ
         ssGeMuDM69q64hIwdsHPnQlOPDUzQr7Y0YNh7h8I=
Date:   Fri, 19 Aug 2022 10:29:13 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Shuah Khan <skhan@linuxfoundation.org>
Cc:     valentina.manea.m@gmail.com, shuah@kernel.org,
        mailhol.vincent@wanadoo.fr, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Hongren Zenithal Zheng <i@zenithal.me>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: Re: [PATCH] usbip: add USBIP_URB_* URB transfer flags
Message-ID: <Yv9J2d1bVe7Xntxu@kroah.com>
References: <20220816215711.55025-1-skhan@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220816215711.55025-1-skhan@linuxfoundation.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Overall, nice work, thanks for adding this, minor comments below:

On Tue, Aug 16, 2022 at 03:57:11PM -0600, Shuah Khan wrote:
> USBIP driver packs URB transfer flags in PDUs that are exchanged

What is a "PDU"?

> between Server (usbip_host) and Clinet (vhci_hcd). URB_* flags
> are internal to kernel and could change. Where as USBIP URB flags
> exchanged in PDUs are USBIP user API must not change.
> 
> Add USBIP_URB* flags to make this an expclicit API and change the
> client and server to map them. Details as follows:
> 
> Client tx path (USBIP_CMD_SUBMIT):
> - Maps URB_* to USBIP_URB_* when it sends USBIP_CMD_SUBMIT packet.
> 
> Server rx path (USBIP_CMD_SUBMIT):
> - Maps USBIP_URB_* to URB_* when it receives USBIP_CMD_SUBMIT packet.
> 
> Flags aren't included in USBIP_CMD_UNLINK and USBIP_RET_SUBMIT packets
> and no special handling is needed for them in the following cases:
> 
> - Server rx path (USBIP_CMD_UNLINK)
> - Client rx path & Server tx path (USBIP_RET_SUBMIT)
> 
> Update protocol documentation to reflect the change.
> 
> Suggested-by: Hongren Zenithal Zheng <i@zenithal.me>
> Suggested-by: Alan Stern <stern@rowland.harvard.edu>
> Signed-off-by: Shuah Khan <skhan@linuxfoundation.org>
> ---
>  Documentation/usb/usbip_protocol.rst | 11 ++--
>  drivers/usb/usbip/stub_rx.c          |  8 ++-
>  drivers/usb/usbip/usbip_common.c     | 95 +++++++++++++++++++++++++++-
>  drivers/usb/usbip/vhci_tx.c          |  1 +
>  drivers/usb/usbip/vudc_rx.c          |  1 +
>  include/uapi/linux/usbip.h           | 40 ++++++++++++
>  6 files changed, 146 insertions(+), 10 deletions(-)
> 
> diff --git a/Documentation/usb/usbip_protocol.rst b/Documentation/usb/usbip_protocol.rst
> index 0b8541fda4d8..1c5b1db86fd0 100644
> --- a/Documentation/usb/usbip_protocol.rst
> +++ b/Documentation/usb/usbip_protocol.rst
> @@ -341,12 +341,13 @@ USBIP_CMD_SUBMIT:
>  +-----------+--------+---------------------------------------------------+
>  | 0x14      | 4      | transfer_flags: possible values depend on the     |
>  |           |        | URB transfer_flags (refer to URB doc in           |

You can drop the second "URB" here, as it's an USBIP document being
referred to, right?

> +|           |        | include/uapi/linux/usbip.h and                    |
>  |           |        | Documentation/driver-api/usb/URB.rst)             |
> -|           |        | but with URB_NO_TRANSFER_DMA_MAP masked. Refer to |
> -|           |        | function usbip_pack_cmd_submit and function       |
> -|           |        | tweak_transfer_flags in drivers/usb/usbip/        |
> -|           |        | usbip_common.c. The following fields may also ref |
> -|           |        | to function usbip_pack_cmd_submit and URB doc     |
> +|           |        | but with USBIP_URB_NO_TRANSFER_DMA_MAP masked.    |
> +|           |        | Refer to usbip_pack_cmd_submit() and              |
> +|           |        | tweak_transfer_flags() in drivers/usb/usbip/      |
> +|           |        | usbip_common.c. The following fields may also     |
> +|           |        | refer to usbip_pack_cmd_submit() and URB doc      |
>  +-----------+--------+---------------------------------------------------+
>  | 0x18      | 4      | transfer_buffer_length:                           |
>  |           |        | use URB transfer_buffer_length                    |
> diff --git a/drivers/usb/usbip/stub_rx.c b/drivers/usb/usbip/stub_rx.c
> index 5dd41e8215e0..638d33120f26 100644
> --- a/drivers/usb/usbip/stub_rx.c
> +++ b/drivers/usb/usbip/stub_rx.c
> @@ -464,7 +464,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>  	int nents;
>  	int num_urbs = 1;
>  	int pipe = get_pipe(sdev, pdu);
> -	int use_sg = pdu->u.cmd_submit.transfer_flags & URB_DMA_MAP_SG;
> +	int use_sg = pdu->u.cmd_submit.transfer_flags & USBIP_URB_DMA_MAP_SG;
>  	int support_sg = 1;
>  	int np = 0;
>  	int ret, i;
> @@ -514,7 +514,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>  				num_urbs = nents;
>  				priv->completed_urbs = 0;
>  				pdu->u.cmd_submit.transfer_flags &=
> -								~URB_DMA_MAP_SG;
> +								~USBIP_URB_DMA_MAP_SG;
>  			}
>  		} else {
>  			buffer = kzalloc(buf_len, GFP_KERNEL);
> @@ -556,6 +556,7 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>  			return;
>  		}
>  
> +		/* Unpack the pdu to an urb (map USBIP_URB_* to URB_* flags) */

No need to mention the mapping everywhere in these comments as the
function handles that.

>  		usbip_pack_pdu(pdu, priv->urbs[0], USBIP_CMD_SUBMIT, 0);
>  	} else {
>  		for_each_sg(sgl, sg, nents, i) {
> @@ -566,6 +567,9 @@ static void stub_recv_cmd_submit(struct stub_device *sdev,
>  			if (!priv->urbs[i])
>  				goto err_urb;
>  
> +			/* Unpack the pdu to an urb (map USBIP_URB_* to
> +			 * URB_* flags)
> +			 */
>  			usbip_pack_pdu(pdu, priv->urbs[i], USBIP_CMD_SUBMIT, 0);
>  			priv->urbs[i]->transfer_buffer = sg_virt(sg);
>  			priv->urbs[i]->transfer_buffer_length = sg->length;
> diff --git a/drivers/usb/usbip/usbip_common.c b/drivers/usb/usbip/usbip_common.c
> index 2ab99244bc31..bb0596588327 100644
> --- a/drivers/usb/usbip/usbip_common.c
> +++ b/drivers/usb/usbip/usbip_common.c
> @@ -344,6 +344,95 @@ static unsigned int tweak_transfer_flags(unsigned int flags)
>  	return flags;
>  }
>  
> +/*
> + * USBIP driver packs URB transfer flags in PDUs that are exchanged
> + * between Server (usbip_host) and Client (vhci_hcd). URB_* flags
> + * are internal to kernel and could change. Where as USBIP URB flags
> + * exchanged in PDUs are USBIP user API must not change.
> + *
> + * USBIP_URB* flags are exported as explicit API and client and server
> + * do mapping from kernel flags to USBIP_URB*. Details as follows:
> + *
> + * Client tx path (USBIP_CMD_SUBMIT):
> + * - Maps URB_* to USBIP_URB_* when it sends USBIP_CMD_SUBMIT packet.
> + *
> + * Server rx path (USBIP_CMD_SUBMIT):
> + * - Maps USBIP_URB_* to URB_* when it receives USBIP_CMD_SUBMIT packet.
> + *
> + * Flags aren't included in USBIP_CMD_UNLINK and USBIP_RET_SUBMIT packets
> + * and no special handling is needed for them in the following cases:
> + * - Server rx path (USBIP_CMD_UNLINK)
> + * - Client rx path & Server tx path (USBIP_RET_SUBMIT)
> + *
> + * Code paths:
> + * usbip_pack_pdu() is the common routine that handles packing pdu from
> + * urb and unpack pdu to an urb.
> + *
> + * usbip_pack_cmd_submit() and usbip_pack_ret_submit() handle
> + * USBIP_CMD_SUBMIT and USBIP_RET_SUBMIT respectively.
> + *
> + * usbip_map_urb_to_usbip() and usbip_map_usbip_to_urb() are used
> + * by usbip_pack_cmd_submit() and usbip_pack_ret_submit() to map
> + * flags.
> + */
> +
> +struct urb_to_usbip_flags {
> +	unsigned int urb_flag;
> +	unsigned int usbip_flag;

u32 or u64 for these?

> +};
> +
> +#define NUM_USBIP_FLAGS	17
> +
> +static const struct urb_to_usbip_flags flag_map[NUM_USBIP_FLAGS] = {
> +	{URB_SHORT_NOT_OK, USBIP_URB_SHORT_NOT_OK},
> +	{URB_ISO_ASAP, USBIP_URB_ISO_ASAP},
> +	{URB_NO_TRANSFER_DMA_MAP, USBIP_URB_NO_TRANSFER_DMA_MAP},
> +	{URB_ZERO_PACKET, USBIP_URB_ZERO_PACKET},
> +	{URB_NO_INTERRUPT, USBIP_URB_NO_INTERRUPT},
> +	{URB_FREE_BUFFER, USBIP_URB_FREE_BUFFER},
> +	{URB_DIR_IN, USBIP_URB_DIR_IN},
> +	{URB_DIR_OUT, USBIP_URB_DIR_OUT},
> +	{URB_DIR_MASK, USBIP_URB_DIR_MASK},
> +	{URB_DMA_MAP_SINGLE, USBIP_URB_DMA_MAP_SINGLE},
> +	{URB_DMA_MAP_PAGE, USBIP_URB_DMA_MAP_PAGE},
> +	{URB_DMA_MAP_SG, USBIP_URB_DMA_MAP_SG},
> +	{URB_MAP_LOCAL, USBIP_URB_MAP_LOCAL},
> +	{URB_SETUP_MAP_SINGLE, USBIP_URB_SETUP_MAP_SINGLE},
> +	{URB_SETUP_MAP_LOCAL, USBIP_URB_SETUP_MAP_LOCAL},
> +	{URB_DMA_SG_COMBINED, USBIP_URB_DMA_SG_COMBINED},
> +	{URB_ALIGNED_TEMP_BUFFER, USBIP_URB_ALIGNED_TEMP_BUFFER},
> +};
> +
> +static unsigned int urb_to_usbip(unsigned int flags)
> +{
> +	unsigned int map_flags = 0;
> +	int loop;
> +
> +	for (loop = 0; loop < NUM_USBIP_FLAGS; loop++) {
> +		if (flags & flag_map[loop].urb_flag)
> +			map_flags |= flag_map[loop].usbip_flag;
> +	}
> +	pr_debug("%s: flag = %u map_flags = %u\n", __func__,
> +		 flags, map_flags);

When using pr_debug (or dev_dbg()), you already have access to the
__func__ in the output automatically, so there's never a need to add it
again, it would just show up twice.

Also, this should be dev_dbg(), as it's a driver, and you have access to
the device being handled (well, it needs to be passed to the
function...)

> +
> +	return map_flags;
> +}
> +
> +static unsigned int usbip_to_urb(unsigned int flags)
> +{
> +	unsigned int map_flags = 0;
> +	int loop;
> +
> +	for (loop = 0; loop < NUM_USBIP_FLAGS; loop++) {
> +		if (flags & flag_map[loop].usbip_flag)
> +			map_flags |= flag_map[loop].urb_flag;
> +	}
> +	pr_debug("%s: flag = %u map_flags = %u\n", __func__,
> +		 flags, map_flags);

Same debug comment as above.

> +
> +	return map_flags;
> +}
> +
>  static void usbip_pack_cmd_submit(struct usbip_header *pdu, struct urb *urb,
>  				  int pack)
>  {
> @@ -354,14 +443,14 @@ static void usbip_pack_cmd_submit(struct usbip_header *pdu, struct urb *urb,
>  	 * will be discussed when usbip is ported to other operating systems.
>  	 */
>  	if (pack) {
> -		spdu->transfer_flags =
> -			tweak_transfer_flags(urb->transfer_flags);
> +		/* map after tweaking the urb flags */
> +		spdu->transfer_flags = urb_to_usbip(tweak_transfer_flags(urb->transfer_flags));
>  		spdu->transfer_buffer_length	= urb->transfer_buffer_length;
>  		spdu->start_frame		= urb->start_frame;
>  		spdu->number_of_packets		= urb->number_of_packets;
>  		spdu->interval			= urb->interval;
>  	} else  {
> -		urb->transfer_flags         = spdu->transfer_flags;
> +		urb->transfer_flags         = usbip_to_urb(spdu->transfer_flags);
>  		urb->transfer_buffer_length = spdu->transfer_buffer_length;
>  		urb->start_frame            = spdu->start_frame;
>  		urb->number_of_packets      = spdu->number_of_packets;
> diff --git a/drivers/usb/usbip/vhci_tx.c b/drivers/usb/usbip/vhci_tx.c
> index 0ae40a13a9fe..0cf3413ea32d 100644
> --- a/drivers/usb/usbip/vhci_tx.c
> +++ b/drivers/usb/usbip/vhci_tx.c
> @@ -25,6 +25,7 @@ static void setup_cmd_submit_pdu(struct usbip_header *pdup,  struct urb *urb)
>  		USBIP_DIR_IN : USBIP_DIR_OUT;
>  	pdup->base.ep	     = usb_pipeendpoint(urb->pipe);
>  
> +	/* pack the pdu from urb. Map URB_* to USBIP_URB_* flags */
>  	usbip_pack_pdu(pdup, urb, USBIP_CMD_SUBMIT, 1);
>  
>  	if (urb->setup_packet)
> diff --git a/drivers/usb/usbip/vudc_rx.c b/drivers/usb/usbip/vudc_rx.c
> index d4a2f30a7580..b0efd6e00e6b 100644
> --- a/drivers/usb/usbip/vudc_rx.c
> +++ b/drivers/usb/usbip/vudc_rx.c
> @@ -26,6 +26,7 @@ static int alloc_urb_from_cmd(struct urb **urbp,
>  	if (!urb)
>  		goto err;
>  
> +	/* unpack the pdu to a urb. Map USBIP_URB_* to URB_* flags */
>  	usbip_pack_pdu(pdu, urb, USBIP_CMD_SUBMIT, 0);
>  
>  	if (urb->transfer_buffer_length > 0) {
> diff --git a/include/uapi/linux/usbip.h b/include/uapi/linux/usbip.h
> index fd393d908d8a..22d25ebde0cc 100644
> --- a/include/uapi/linux/usbip.h
> +++ b/include/uapi/linux/usbip.h
> @@ -24,4 +24,44 @@ enum usbip_device_status {
>  	VDEV_ST_USED,
>  	VDEV_ST_ERROR
>  };
> +
> +/* USB URB Transfer flags:
> + *
> + * USBIP server and client (vchi) pack URBs in TCP packets.
> + *
> + * - Client (vhci) clears the DMA flag and sends it off to the server.
> + * - Server (usbip-host) masks some flags and re-submits client urb to
> + *   usbcore.
> + * - USBIP protocol has its own direction field and doesn't use URB_DIR_IN
> + *
> + * As a result of coying the transfer flags, they now have become part

"coying"?  :)

> + * of the API. Any changes to kernel flags now impact the USBIP user-space.
> + * In addition, it will be compatibility problem between server and client.
> + * These defines aren't directly referenced and it is an obscure usage
> + * hidden away in the packets.

No need to mention the history here, just say "here are the flags for
the transfer types"


> + *
> + * Add code to translate the values between the numbers used in userspace
> + * and the numbers used in the kernel. This will help with any future
> + * changes to kernel flags breaking the API.

There's no code being added in this uapi file, so you might want to
reword all of this.  Possibly by removing most of it, as the history
here might not be necessary to document.


> + */
> +
> +#define USBIP_URB_SHORT_NOT_OK		0x0001
> +#define USBIP_URB_ISO_ASAP		0x0002
> +#define USBIP_URB_NO_TRANSFER_DMA_MAP	0x0004
> +#define USBIP_URB_ZERO_PACKET		0x0040
> +#define USBIP_URB_NO_INTERRUPT		0x0080
> +#define USBIP_URB_FREE_BUFFER		0x0100
> +#define USBIP_URB_DIR_IN		0x0200
> +#define USBIP_URB_DIR_OUT		0
> +#define USBIP_URB_DIR_MASK		USBIP_URB_DIR_IN
> +
> +#define USBIP_URB_DMA_MAP_SINGLE	0x00010000
> +#define USBIP_URB_DMA_MAP_PAGE		0x00020000
> +#define USBIP_URB_DMA_MAP_SG		0x00040000
> +#define USBIP_URB_MAP_LOCAL		0x00080000
> +#define USBIP_URB_SETUP_MAP_SINGLE	0x00100000
> +#define USBIP_URB_SETUP_MAP_LOCAL	0x00200000
> +#define USBIP_URB_DMA_SG_COMBINED	0x00400000
> +#define USBIP_URB_ALIGNED_TEMP_BUFFER	0x00800000
> +
>  #endif /* _UAPI_LINUX_USBIP_H */
> -- 
> 2.34.1
> 
