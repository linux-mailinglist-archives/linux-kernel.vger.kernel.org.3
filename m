Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 407704F050F
	for <lists+linux-kernel@lfdr.de>; Sat,  2 Apr 2022 18:49:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355542AbiDBQv0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 2 Apr 2022 12:51:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358480AbiDBQvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 2 Apr 2022 12:51:21 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 926E43F33D
        for <linux-kernel@vger.kernel.org>; Sat,  2 Apr 2022 09:49:28 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-e1dcc0a327so1366163fac.1
        for <linux-kernel@vger.kernel.org>; Sat, 02 Apr 2022 09:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fBPqA3mIoazbMcWh1HJQC0i7QW16Cn/Q0zy0h/lyGM4=;
        b=opdiIEImdazw2oXX9vf14k8HMCDV5ZVwl/h/PMR4FOMfvLCWp/n+83/7Vg+dYSR212
         vKTNev7s3/9SBQ1JWZAG1BNhW8gLp7S0W/uwmecvU4rCjWCg09YoM7FYfpL4DFBDT0Xz
         TydiyvLJLwp64q1+EQK0CdUcnNs8vhhfYSLHXdNYdVzUM/ZqWMspdsLWlM3pNjWg0Jg8
         QWCBmj3Qy0kTZvmt5jqzqyM93jD4wCG0WZ6W3WocTqjS5cDUoUMNJq0n7RR69cPTWFl6
         QHbGsBQW8fmnjtOCmwXvMUlHOkBz/LCGB73EPnZQ8JtrWNWn6inNr8L5zoO88rrkSj2b
         kvZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fBPqA3mIoazbMcWh1HJQC0i7QW16Cn/Q0zy0h/lyGM4=;
        b=yxOAgh/zLSTjv5ZuI4GpLs8hg0NppCeQkuzbf3oqWRSYiFhvjTQG5ZfsVWvKIgJCBz
         L0PhdBPoSb3hIUwldwu89T6EDUZBigDC5mWmVYTxtGD/PBUDGnFA7bF0lkrCijJBFNb1
         BRqMI+dV5Ve1p+LaiEbBaRV1Spfq86mWJ3Tkkr4PORKnhJjp53gM/mbAD+XAqKNQTrzR
         inv/ZDed/IMk4/s6oFmgGvArQ3Yil9ublxayHBXIeWwIsH2edLazF9EhX934HmI16laQ
         YgCwxEMQjMJlzP/Wm1I9j1vh4HlLI8Wh8Wf5We0Qq03A9QiwGgS1F5+3EbBMV4PJVMst
         /GTA==
X-Gm-Message-State: AOAM5339EMsokVfi/p3sVgEGFh+KX3vl6HU2jjySN7Bs/6X+sUUnMUtm
        xGiCtdEZ2nbIMn57m8MDNAM=
X-Google-Smtp-Source: ABdhPJxJWq+VuYlkerr9lIuYyPsl/SGyckYnNzw7rEgf7b+NzQYtayfwjM+JJJgCdJONRjads69UWw==
X-Received: by 2002:a05:6870:d182:b0:dd:bf35:48 with SMTP id a2-20020a056870d18200b000ddbf350048mr7297004oac.255.1648918167900;
        Sat, 02 Apr 2022 09:49:27 -0700 (PDT)
Received: from ?IPV6:2603:8090:2005:39b3::1004? (2603-8090-2005-39b3-0000-0000-0000-1004.res6.spectrum.com. [2603:8090:2005:39b3::1004])
        by smtp.gmail.com with ESMTPSA id h186-20020acab7c3000000b002ef5106248asm2315385oif.45.2022.04.02.09.49.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 02 Apr 2022 09:49:27 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <dcd28510-b585-b366-92fb-05c162904cc5@lwfinger.net>
Date:   Sat, 2 Apr 2022 11:49:25 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 1/2] staging: rtl8712: remove blank line after brace {
Content-Language: en-US
To:     Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>,
        outreachy@lists.linux.dev
Cc:     florian.c.schilhabel@googlemail.com, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <8c88829f625f9847a1db18fe467399594dacb064.1648902188.git.eng.alaamohamedsoliman.am@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/2/22 07:28, Alaa Mohamed wrote:
> Fix " CHECK: Blank lines aren't necessary after an open brace '{' "
> Reported by checkpatch
> 
> Signed-off-by: Alaa Mohamed <eng.alaamohamedsoliman.am@gmail.com>
> ---
>   drivers/staging/rtl8712/rtl8712_xmit.c | 25 ++++++++++++-------------
>   1 file changed, 12 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_xmit.c b/drivers/staging/rtl8712/rtl8712_xmit.c
> index 84a22eba7ebf..05ba0ca7d627 100644
> --- a/drivers/staging/rtl8712/rtl8712_xmit.c
> +++ b/drivers/staging/rtl8712/rtl8712_xmit.c
> @@ -147,7 +147,7 @@ static u32 get_ff_hwaddr(struct xmit_frame *pxmitframe)
>   }
>   
>   static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
> -					 struct hw_xmit *phwxmit,
> +						struct hw_xmit *phwxmit,
>   					 struct tx_servq *ptxservq,
>   					 struct  __queue *pframe_queue)
>   {
> @@ -167,7 +167,7 @@ static struct xmit_frame *dequeue_one_xmitframe(struct xmit_priv *pxmitpriv,
>   }
>   
>   static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
> -				     struct hw_xmit *phwxmit_i, sint entry)
> +					    struct hw_xmit *phwxmit_i, sint entry)
>   {
>   	unsigned long irqL0;
>   	struct list_head *sta_plist, *sta_phead;
> @@ -201,7 +201,7 @@ static struct xmit_frame *dequeue_xframe_ex(struct xmit_priv *pxmitpriv,
>   						tx_pending);
>   			pframe_queue = &ptxservq->sta_pending;
>   			pxmitframe = dequeue_one_xmitframe(pxmitpriv, phwxmit,
> -				     ptxservq, pframe_queue);
> +							   ptxservq, pframe_queue);
>   			if (pxmitframe) {
>   				phwxmit->accnt--;
>   				goto exit_dequeue_xframe_ex;
> @@ -292,14 +292,14 @@ void r8712_append_mpdu_unit(struct xmit_buf *pxmitbuf,
>   	r8712_xmit_complete(padapter, pxmitframe);
>   	if (pxmitframe->attrib.ether_type != 0x0806) {
>   		if ((pxmitframe->attrib.ether_type != 0x888e) &&
> -			(pxmitframe->attrib.dhcp_pkt != 1)) {
> +		    (pxmitframe->attrib.dhcp_pkt != 1)) {
>   			r8712_issue_addbareq_cmd(padapter,
> -					pxmitframe->attrib.priority);
> +						 pxmitframe->attrib.priority);
>   		}
>   	}
>   	pxmitframe->last[0] = 1;
>   	update_txdesc(pxmitframe, (uint *)(pxmitframe->buf_addr),
> -		pxmitframe->attrib.last_txcmdsz);
> +		      pxmitframe->attrib.last_txcmdsz);
>   	/*padding zero */
>   	last_txcmdsz = pxmitframe->attrib.last_txcmdsz;
>   	padding_sz = (8 - (last_txcmdsz % 8));
> @@ -334,7 +334,7 @@ void r8712_xmitframe_aggr_1st(struct xmit_buf *pxmitbuf,
>   }
>   
>   u16 r8712_xmitframe_aggr_next(struct xmit_buf *pxmitbuf,
> -			struct xmit_frame *pxmitframe)
> +			      struct xmit_frame *pxmitframe)
>   {
>   	pxmitframe->pxmitbuf = pxmitbuf;
>   	pxmitbuf->priv_data = pxmitframe;
> @@ -388,7 +388,7 @@ void r8712_dump_aggr_xframe(struct xmit_buf *pxmitbuf,
>   		/*default = 32 bytes for TX Desc*/
>   	}
>   	r8712_write_port(pxmitframe->padapter, RTL8712_DMA_H2CCMD,
> -			total_length + TXDESC_SIZE, (u8 *)pxmitframe);
> +			 total_length + TXDESC_SIZE, (u8 *)pxmitframe);
>   }
>   
>   #endif
> @@ -618,14 +618,13 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
>   	pxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits, hwentry);
>   	/* need to remember the 1st frame */
>   	if (pxmitframe) {
> -
>   #ifdef CONFIG_R8712_TX_AGGR
>   		/* 1. dequeue 2nd frame
>   		 * 2. aggr if 2nd xframe is dequeued, else dump directly
>   		 */
>   		if (AGGR_NR_HIGH_BOUND > 1)
>   			p2ndxmitframe = dequeue_xframe_ex(pxmitpriv, phwxmits,
> -							hwentry);
> +							  hwentry);
>   		if (pxmitframe->frame_tag != DATA_FRAMETAG) {
>   			r8712_free_xmitbuf(pxmitpriv, pxmitbuf);
>   			return false;
> @@ -663,7 +662,7 @@ int r8712_xmitframe_complete(struct _adapter *padapter,
>   		if (pxmitframe->frame_tag == DATA_FRAMETAG) {
>   			if (pxmitframe->attrib.priority <= 15)
>   				res = r8712_xmitframe_coalesce(padapter,
> -					pxmitframe->pkt, pxmitframe);
> +							       pxmitframe->pkt, pxmitframe);
>   			/* always return ndis_packet after
>   			 * r8712_xmitframe_coalesce
>   			 */
> @@ -715,10 +714,10 @@ static void dump_xframe(struct _adapter *padapter,
>   		ff_hwaddr = get_ff_hwaddr(pxmitframe);
>   #ifdef CONFIG_R8712_TX_AGGR
>   		r8712_write_port(padapter, RTL8712_DMA_H2CCMD, w_sz,
> -				(unsigned char *)pxmitframe);
> +				 (unsigned char *)pxmitframe);
>   #else
>   		r8712_write_port(padapter, ff_hwaddr, w_sz,
> -			   (unsigned char *)pxmitframe);
> +				 (unsigned char *)pxmitframe);
>   #endif
>   		mem_addr += w_sz;
>   		mem_addr = (u8 *)RND4(((addr_t)(mem_addr)));

Almost all of these changes are changing code alignment, NOT removing blank 
lines after a brace. Please do only one type of change for each patch, and 
please make the change indicated in the commit message.

NACK

Larry

