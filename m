Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B789752FDFB
	for <lists+linux-kernel@lfdr.de>; Sat, 21 May 2022 17:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348064AbiEUPud (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 21 May 2022 11:50:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230091AbiEUPu2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 21 May 2022 11:50:28 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649FC674FB
        for <linux-kernel@vger.kernel.org>; Sat, 21 May 2022 08:50:27 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1nsRMv-0007kO-Vo; Sat, 21 May 2022 17:50:17 +0200
Date:   Sat, 21 May 2022 17:50:17 +0200
From:   Martin Kaiser <lists@kaiser.cx>
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     dan.carpenter@oracle.com, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, gregkh@linuxfoundation.org,
        straube.linux@gmail.com, fmdefrancesco@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: r8188eu: add check for kzalloc
Message-ID: <20220521155017.7jjz7prdnspm2276@viti.kaiser.cx>
References: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220518075957.514603-1-jiasheng@iscas.ac.cn>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Jiasheng Jiang (jiasheng@iscas.ac.cn):

> As kzalloc() may return null pointer, it should be better to
> check the return value and return error if fails in order
> to avoid dereference of null pointer.
> Moreover, the return value of rtw_alloc_hwxmits() should also
> be dealt with.

> Fixes: 15865124feed ("staging: r8188eu: introduce new core dir for RTL8188eu driver")
> Signed-off-by: Jiasheng Jiang <jiasheng@iscas.ac.cn>
> ---
> Changelog

> v1 -> v2:

> *Change 1. Make rtw_alloc_hwxmits() return -ENOMEM on failure
> and zero on success.

> v2 -> v3

> *Change 1. Add "res = _FAIL".
> ---
>  drivers/staging/r8188eu/core/rtw_xmit.c    | 13 +++++++++++--
>  drivers/staging/r8188eu/include/rtw_xmit.h |  2 +-
>  2 files changed, 12 insertions(+), 3 deletions(-)

> diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
> index c2a550e7250e..2ee92bbe66a0 100644
> --- a/drivers/staging/r8188eu/core/rtw_xmit.c
> +++ b/drivers/staging/r8188eu/core/rtw_xmit.c
> @@ -178,7 +178,12 @@ s32	_rtw_init_xmit_priv(struct xmit_priv *pxmitpriv, struct adapter *padapter)

>  	pxmitpriv->free_xmit_extbuf_cnt = num_xmit_extbuf;

> -	rtw_alloc_hwxmits(padapter);
> +	res = rtw_alloc_hwxmits(padapter);

This commit introduces a regression.

res is now 0 if the allocation succeeds.

> +	if (res) {
> +		res = _FAIL;
> +		goto exit;
> +	}
> +
>  	rtw_init_hwxmits(pxmitpriv->hwxmits, pxmitpriv->hwxmit_entry);

>  	for (i = 0; i < 4; i++)
> @@ -1474,7 +1479,7 @@ s32 rtw_xmit_classifier(struct adapter *padapter, struct xmit_frame *pxmitframe)


res is still 0 here - but the caller of _rtw_init_xmit_priv compares
this return value with _SUCCESS (1) or _FAIL (0) and interprets it as
_FAIL.

[ 3893.464932] r8188eu: module is from the staging directory, the quality is unknown, you have been warned.
[ 3893.543204] Chip Version Info: CHIP_8188E_Normal_Chip_TSMC_D_CUT_1T1R_RomVer(0)
[ 3893.713123] EEPROM ID = 0x8129
[ 3893.719205] r8188eu 1-1.5:1.0: _rtw_init_xmit_priv failed
[ 3893.823102] usb 1-1.5: reset full-speed USB device number 4 using ci_hdrc
[ 3893.986936] usbcore: registered new interface driver r8188eu

>  	return res;
>  }
