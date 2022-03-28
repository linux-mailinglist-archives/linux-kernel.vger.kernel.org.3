Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF7634E8FC4
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 10:08:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239146AbiC1IKK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 04:10:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231181AbiC1IKH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 04:10:07 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 488DC527D1
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 01:08:26 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1nYkQD-0007da-3d; Mon, 28 Mar 2022 10:08:17 +0200
Date:   Mon, 28 Mar 2022 10:08:17 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, straube.linux@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: Directly return instead of using local
 ret variable
Message-ID: <20220328080817.4r5n5z375hzqaxjf@viti.kaiser.cx>
References: <1648431715-21333-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1648431715-21333-1-git-send-email-baihaowen@meizu.com>
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

Thus wrote Haowen Bai (baihaowen@meizu.com):

> From: 白浩文 <baihaowen@meizu.com>

> fixes coccinelle warning:
> ./drivers/staging/r8188eu/core/rtw_mlme_ext.c:1518:14-17: Unneeded variable: "ret".
>  Return "_FAIL" on line 1549
> ./drivers/staging/r8188eu/core/rtw_mlme_ext.c:357:5-8: Unneeded variable: "res".
>  Return "_SUCCESS" on line 380

These are two unrelated changes. I guess you should split this into two
patches.

> Signed-off-by: 白浩文 <baihaowen@meizu.com>
> ---
>  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

> diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> index 10d5f12..4b7b0ee 100644
> --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> @@ -354,7 +354,6 @@ static u8 init_channel_set(struct adapter *padapter, u8 ChannelPlan, struct rt_c

>  int	init_mlme_ext_priv(struct adapter *padapter)
>  {
> -	int	res = _SUCCESS;
>  	struct registry_priv *pregistrypriv = &padapter->registrypriv;
>  	struct mlme_ext_priv *pmlmeext = &padapter->mlmeextpriv;
>  	struct mlme_priv *pmlmepriv = &padapter->mlmepriv;
> @@ -377,7 +376,7 @@ int	init_mlme_ext_priv(struct adapter *padapter)

>  	pmlmeext->active_keep_alive_check = true;

> -	return res;
> +	return _SUCCESS;
>  }

The caller does not check the return value. You should change the
function to void init_mlme_ext_priv...

>  void free_mlme_ext_priv(struct mlme_ext_priv *pmlmeext)
> @@ -1515,7 +1514,6 @@ unsigned int OnAtim(struct adapter *padapter, struct recv_frame *precv_frame)

>  unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_frame)
>  {
> -	unsigned int ret = _FAIL;
>  	struct sta_info *psta = NULL;
>  	struct sta_priv *pstapriv = &padapter->stapriv;
>  	u8 *pframe = precv_frame->rx_data;
> @@ -1546,7 +1544,7 @@ unsigned int on_action_spct(struct adapter *padapter, struct recv_frame *precv_f
>  	}

>  exit:
> -	return ret;
> +	return _FAIL;
>  }
>  unsigned int OnAction_qos(struct adapter *padapter, struct recv_frame *precv_frame)
> -- 
> 2.7.4

