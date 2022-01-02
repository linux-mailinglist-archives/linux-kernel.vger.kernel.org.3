Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EAEC482C5B
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Jan 2022 18:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230038AbiABR1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Jan 2022 12:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229520AbiABR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Jan 2022 12:27:45 -0500
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31429C061761
        for <linux-kernel@vger.kernel.org>; Sun,  2 Jan 2022 09:27:44 -0800 (PST)
Received: from dslb-188-104-058-096.188.104.pools.vodafone-ip.de ([188.104.58.96] helo=martin-debian-2.paytec.ch)
        by viti.kaiser.cx with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <postmaster@kaiser.cx>)
        id 1n44dw-0005O2-J3; Sun, 02 Jan 2022 18:27:40 +0100
Received: from martin by martin-debian-2.paytec.ch with local (Exim 4.94.2)
        (envelope-from <martin@martin-debian-2.paytec.ch>)
        id 1n44dv-000FsI-Vs; Sun, 02 Jan 2022 18:27:39 +0100
Date:   Sun, 2 Jan 2022 18:27:39 +0100
From:   Martin Kaiser <martin@kaiser.cx>
To:     Michael Straube <straube.linux@gmail.com>
Cc:     gregkh@linuxfoundation.org, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 6/7] staging: r8188eu: IntArray and C2hArray are set
 but never used
Message-ID: <YdHgiz6SwKdBV3Z1@martin-debian-1.paytec.ch>
References: <20220101084937.3411-1-straube.linux@gmail.com>
 <20220101084937.3411-7-straube.linux@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220101084937.3411-7-straube.linux@gmail.com>
Sender: "Martin Kaiser,,," <martin@martin-debian-2.paytec.ch>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Michael Straube (straube.linux@gmail.com):

> The fields IntArray and C2hArray of struct hal_data_8188e are set but
> never used. Remove them and remove interrupt_handler_8188eu() since it
> does nothing now.

> While at it, remove the unsed defines USB_INTR_CONTENT_CPWM1_OFFSET
> and USB_INTR_CONTENT_CPWM2_OFFSET as well.

> Signed-off-by: Michael Straube <straube.linux@gmail.com>
> ---
> v3: Remove INTERRUPT_MSG_FORMAT_LEN from rtl8188e_recv.h.
> v2: Remove interrupt_handler_8188eu() since it does nothing now.

>  drivers/staging/r8188eu/hal/usb_ops_linux.c   | 20 -------------------
>  .../staging/r8188eu/include/rtl8188e_hal.h    |  3 ---
>  .../staging/r8188eu/include/rtl8188e_recv.h   |  1 -
>  .../staging/r8188eu/include/rtl8188e_spec.h   |  7 -------
>  4 files changed, 31 deletions(-)

> diff --git a/drivers/staging/r8188eu/hal/usb_ops_linux.c b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> index 9ec55a77dccd..4a0ab4053e90 100644
> --- a/drivers/staging/r8188eu/hal/usb_ops_linux.c
> +++ b/drivers/staging/r8188eu/hal/usb_ops_linux.c
> @@ -183,24 +183,6 @@ int rtw_writeN(struct adapter *adapter, u32 addr, u32 length, u8 *data)
>  	return RTW_STATUS_CODE(ret);
>  }

> -static void interrupt_handler_8188eu(struct adapter *adapt, u16 pkt_len, u8 *pbuf)
> -{
> -	struct hal_data_8188e *haldata = &adapt->haldata;
> -
> -	if (pkt_len != INTERRUPT_MSG_FORMAT_LEN) {
> -		DBG_88E("%s Invalid interrupt content length (%d)!\n", __func__, pkt_len);
> -		return;
> -	}
> -
> -	/*  HISR */
> -	memcpy(&haldata->IntArray[0], &pbuf[USB_INTR_CONTENT_HISR_OFFSET], 4);
> -	memcpy(&haldata->IntArray[1], &pbuf[USB_INTR_CONTENT_HISRE_OFFSET], 4);
> -
> -	/*  C2H Event */
> -	if (pbuf[0] != 0)
> -		memcpy(&haldata->C2hArray[0], &pbuf[USB_INTR_CONTENT_C2H_OFFSET], 16);
> -}
> -
>  static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
>  {
>  	u8	*pbuf;
> @@ -342,8 +324,6 @@ static int recvbuf2recvframe(struct adapter *adapt, struct sk_buff *pskb)
>  							pattrib->MacIDValidEntry[0],
>  							pattrib->MacIDValidEntry[1]
>  							);
> -			} else if (pattrib->pkt_rpt_type == HIS_REPORT) {
> -				interrupt_handler_8188eu(adapt, pattrib->pkt_len, precvframe->rx_data);
>  			}
>  			rtw_free_recvframe(precvframe, pfree_recv_queue);
>  		}
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_hal.h b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> index 2ce42d647a34..239d0db55639 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_hal.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_hal.h
> @@ -246,9 +246,6 @@ struct hal_data_8188e {

>  	u32	UsbBulkOutSize;

> -	/*  Interrupt relatd register information. */
> -	u32	IntArray[3];/* HISR0,HISR1,HSISR */
> -	u8	C2hArray[16];
>  	u8	UsbTxAggMode;
>  	u8	UsbTxAggDescNum;

> diff --git a/drivers/staging/r8188eu/include/rtl8188e_recv.h b/drivers/staging/r8188eu/include/rtl8188e_recv.h
> index bc30eb4634bb..0be9896eaf0f 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_recv.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_recv.h
> @@ -37,7 +37,6 @@ enum rx_packet_type {
>  	HIS_REPORT,/*  USB HISR RPT */
>  };

> -#define INTERRUPT_MSG_FORMAT_LEN 60
>  void rtl8188eu_init_recvbuf(struct recv_buf *buf);
>  s32 rtl8188eu_init_recv_priv(struct adapter *padapter);
>  void rtl8188eu_free_recv_priv(struct adapter * padapter);
> diff --git a/drivers/staging/r8188eu/include/rtl8188e_spec.h b/drivers/staging/r8188eu/include/rtl8188e_spec.h
> index e59fd2fe82c5..009222b4a95d 100644
> --- a/drivers/staging/r8188eu/include/rtl8188e_spec.h
> +++ b/drivers/staging/r8188eu/include/rtl8188e_spec.h
> @@ -475,13 +475,6 @@ Default: 00b.
>  #define	MSR_INFRA			0x02
>  #define	MSR_AP				0x03

> -/*   88EU (MSR) Media Status Register	(Offset 0x4C, 8 bits) */
> -#define	USB_INTR_CONTENT_C2H_OFFSET	0
> -#define	USB_INTR_CONTENT_CPWM1_OFFSET	16
> -#define	USB_INTR_CONTENT_CPWM2_OFFSET	20
> -#define	USB_INTR_CONTENT_HISR_OFFSET	48
> -#define	USB_INTR_CONTENT_HISRE_OFFSET	52
> -
>  /*  88E Driver Initialization Offload REG_FDHM0(Offset 0x88, 8 bits) */
>  /* IOL config for REG_FDHM0(Reg0x88) */
>  #define CMD_INIT_LLT			BIT(0)
> -- 
> 2.34.1

Acked-by: Martin Kaiser <martin@kaiser.cx>
