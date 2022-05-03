Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF7B0517E11
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:09:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbiECHMa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:12:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiECHMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:12:23 -0400
Received: from relay4.hostedemail.com (relay4.hostedemail.com [64.99.140.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AEDC2F388
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:08:49 -0700 (PDT)
Received: from omf01.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay12.hostedemail.com (Postfix) with ESMTP id B9CC7121F1B;
        Tue,  3 May 2022 07:08:48 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf01.hostedemail.com (Postfix) with ESMTPA id 8799E6000C;
        Tue,  3 May 2022 07:08:47 +0000 (UTC)
Message-ID: <f6421e8f75a030222bf9cc7ef191648f7495a511.camel@perches.com>
Subject: Re: [PATCH 12/12] staging: r8188eu: check the return of kzalloc()
From:   Joe Perches <joe@perches.com>
To:     xkernel.wang@foxmail.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Tue, 03 May 2022 00:08:46 -0700
In-Reply-To: <tencent_702C3C4AA9F65F0EE48859211795E3800205@qq.com>
References: <tencent_A80380E4306BE7BA73E450F084232B4DFC0A@qq.com>
         <tencent_702C3C4AA9F65F0EE48859211795E3800205@qq.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY
        autolearn=ham autolearn_force=no version=3.4.6
X-Stat-Signature: ojcbzps174iwotm4ttmiixjy5siz9zhh
X-Rspamd-Server: rspamout08
X-Rspamd-Queue-Id: 8799E6000C
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX19WfupWeU9aLuhwiAuAjGXwG8kD2eH7z/Y=
X-HE-Tag: 1651561727-358919
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2022-05-03 at 15:02 +0800, xkernel.wang@foxmail.com wrote:
> From: Xiaoke Wang <xkernel.wang@foxmail.com>
> 
> kzalloc() is a memory allocation function which can return NULL when
> some internal memory errors happen. So it is better to handle the return
> of it to prevent potential wrong memory access.
> 
> Besides, to propagate the error to the caller, the type of
> rtw_alloc_hwxmits() is changed to `int` and another check is added to
> its caller.
> Then if kzalloc() fails, the caller will properly jump to the
> corresponding error hanlding code.

It'd be better to use the typical error returns

> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
[]
> @@ -176,7 +176,9 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)
>  
>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;
>  
> -	rtw_alloc_hwxmits(padapter);
> +	res = rtw_alloc_hwxmits(padapter);
> +	if (res == _FAIL)
> +		goto free_xmit_extbuf;

	if (res)
		goto free_xmit_extbuf;

[]

> -void rtw_alloc_hwxmits(struct adapter *padapter)
> +int rtw_alloc_hwxmits(struct adapter *padapter)
>  {
>  	struct hw_xmit *hwxmits;
>  	struct xmit_priv *pxmitpriv = &padapter->xmitpriv;
> @@ -1495,6 +1497,8 @@ void rtw_alloc_hwxmits(struct adapter *padapter)
>  	pxmitpriv->hwxmit_entry = HWXMIT_ENTRY;
>  
>  	pxmitpriv->hwxmits = kzalloc(sizeof(struct hw_xmit) * pxmitpriv->hwxmit_entry, GFP_KERNEL);
> +	if (!pxmitpriv->hwxmits)

		return -ENOMEM;



