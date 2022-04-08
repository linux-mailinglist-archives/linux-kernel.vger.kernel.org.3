Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A54C14F8DE6
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 08:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234204AbiDHERV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 00:17:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232658AbiDHERT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 00:17:19 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1FC2D9A28
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 21:15:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=uTabu/53bsyjVq/ChwDFv7CtxaAxu/V7Z38X06Q53J8=;
  b=GCcL5h9eISAZu40VAIaRYGmVcO2zZWvbtlq4m0c24CoerRPi4HxCPVTo
   FnnS2mXXBEIcrSfMSyldAZgPP+2NgsQ2WX+TcXBt3TQ87QJIOytjey1iA
   l8mbqpKak2PwBsHsxpCQDS5tUpMHGGIIqBollj7SXqDt9U1gFsL/xVTpx
   8=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,243,1643670000"; 
   d="scan'208";a="30688890"
Received: from lputeaux-656-1-153-249.w217-128.abo.wanadoo.fr (HELO hadrien) ([217.128.47.249])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Apr 2022 06:15:14 +0200
Date:   Fri, 8 Apr 2022 06:15:14 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Rebecca Mckeever <remckee0@gmail.com>
cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] staging: rtl8192u: replace ternary statement with
 if and assignment
In-Reply-To: <36059ec66a2f3d58a8e339aa4f262772eabd3ef0.1649378587.git.remckee0@gmail.com>
Message-ID: <alpine.DEB.2.22.394.2204080614400.2199@hadrien>
References: <cover.1649378587.git.remckee0@gmail.com> <36059ec66a2f3d58a8e339aa4f262772eabd3ef0.1649378587.git.remckee0@gmail.com>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 7 Apr 2022, Rebecca Mckeever wrote:

> Replace ternary statement with an if statement followed by an assignment
> to increase readability and make error handling more obvious.
> Found with minmax coccinelle script.
>
> Signed-off-by: Rebecca Mckeever <remckee0@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> index 78cc8f357bbc..9885917b9199 100644
> --- a/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> +++ b/drivers/staging/rtl8192u/ieee80211/ieee80211_wx.c
> @@ -470,7 +470,9 @@ int ieee80211_wx_get_encode(struct ieee80211_device *ieee,
>  		return 0;
>  	}
>  	len = crypt->ops->get_key(keybuf, SCM_KEY_LEN, NULL, crypt->priv);
> -	erq->length = (len >= 0 ? len : 0);
> +	if (len < 0)
> +		len = 0;
> +	erq->length = len;

Maybe you could use max here?

julia

>
>  	erq->flags |= IW_ENCODE_ENABLED;
>
> --
> 2.32.0
>
>
>
