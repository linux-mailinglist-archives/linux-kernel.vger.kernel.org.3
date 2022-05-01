Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B525516663
	for <lists+linux-kernel@lfdr.de>; Sun,  1 May 2022 18:58:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352747AbiEAQ6E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 12:58:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352834AbiEAQ5g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 12:57:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18E35403F5
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 09:53:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D04A1B80E31
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 16:53:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96444C385A9;
        Sun,  1 May 2022 16:53:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651423989;
        bh=nkjHtAJ4XLlAFk1INlv36kPJqLeaDiFCFeY0oL7x8Vo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QJRCCCNcwfEFyUnEvQxuaGu3PICioUHQah5L43GkUUnMidPPm3E9+9Vtc4rVE3gRw
         kgRaFov0/mgd1zze/UrFCQYvRl5ZTYmVatfetoAFnwtXm8cX/wWFm2Z/vmBgHBjLek
         PMtdoXRsF1uzAd0BJA1ECjQMvazKGkPIkYX5o1dI=
Date:   Sun, 1 May 2022 18:53:02 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] staging: vt6655: Replace unused return value of
 card_get_current_tsf
Message-ID: <Ym667tWcJtK08lm5@kroah.com>
References: <cover.1651422181.git.philipp.g.hortmann@gmail.com>
 <2533d7e6b64660e0c23e495a56737fc35b2f916b.1651422181.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2533d7e6b64660e0c23e495a56737fc35b2f916b.1651422181.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 01, 2022 at 06:37:11PM +0200, Philipp Hortmann wrote:
> Replace unused return value with u64 to increase readability,
> reduce address and dereference operators and omit pqwCurrTSF that
> uses CamelCase which is not accepted by checkpatch.pl
> 
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> Diffs for testing:
>         u64 qwNextTBTT;
> 
>         qwNextTBTT = card_get_current_tsf(priv); /* Get Local TSF counter */
> +       dev_info(&priv->pcid->dev, "CARDbSetBeaconPeriod 0x%016llx", qwNextTBTT);

Don't put a diff in a diff please, git _should_ handle it, but I know
other tools that will choke on it.

>         qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
> 
>         /* set HW beacon interval */
> @@ -810,7 +810,7 @@ void CARDvSetFirstNextTBTT(struct vnt_private *priv,
>         u64 qwNextTBTT;
> 
>         qwNextTBTT = card_get_current_tsf(priv); /* Get Local TSF counter */
> +       dev_info(&priv->pcid->dev, "CARDvSetFirstNextTBTT 0x%016llx", qwNextTBTT);
>         qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
>         /* Set NextTBTT */
>         VNSvOutPortD(iobase + MAC_REG_NEXTTBTT, (u32)qwNextTBTT);
> Log:
> vt6655 0000:01:05.0: CARDbSetBeaconPeriod  0x00 00 00 01 4a 89 52 c4
> vt6655 0000:01:05.0: CARDvSetFirstNextTBTT 0x00 00 00 01 4a 89 52 dc
> ---
>  drivers/staging/vt6655/card.c        | 20 +++++++++-----------
>  drivers/staging/vt6655/card.h        |  2 +-
>  drivers/staging/vt6655/device_main.c |  2 +-
>  3 files changed, 11 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index d1dfd96e13b7..50d70ebff83a 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -288,7 +288,7 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
>  	u64 local_tsf;
>  	u64 qwTSFOffset = 0;
>  
> -	card_get_current_tsf(priv, &local_tsf);
> +	local_tsf = card_get_current_tsf(priv);

{sigh}  I should read all patches in the series before complaining about
previous ones, sorry about that.

Looks much better, except for the function name.



>  
>  	if (qwBSSTimestamp != local_tsf) {
>  		qwTSFOffset = CARDqGetTSFOffset(byRxRate, qwBSSTimestamp,
> @@ -320,9 +320,9 @@ bool CARDbUpdateTSF(struct vnt_private *priv, unsigned char byRxRate,
>  bool CARDbSetBeaconPeriod(struct vnt_private *priv,
>  			  unsigned short wBeaconInterval)
>  {
> -	u64 qwNextTBTT = 0;
> +	u64 qwNextTBTT;
>  
> -	card_get_current_tsf(priv, &qwNextTBTT); /* Get Local TSF counter */
> +	qwNextTBTT = card_get_current_tsf(priv); /* Get Local TSF counter */
>  
>  	qwNextTBTT = CARDqGetNextTBTT(qwNextTBTT, wBeaconInterval);
>  
> @@ -739,7 +739,7 @@ u64 CARDqGetTSFOffset(unsigned char byRxRate, u64 qwTSF1, u64 qwTSF2)
>   *
>   * Return Value: true if success; otherwise false
>   */
> -bool card_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
> +u64 card_get_current_tsf(struct vnt_private *priv)
>  {
>  	void __iomem *iobase = priv->port_offset;
>  	unsigned short ww;
> @@ -753,16 +753,14 @@ bool card_get_current_tsf(struct vnt_private *priv, u64 *pqwCurrTSF)
>  			break;
>  	}
>  	if (ww == W_MAX_TIMEOUT)
> -		return false;
> +		return 0;
>  	low = ioread32(iobase + MAC_REG_TSFCNTR);
>  	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
>  #ifdef __BIG_ENDIAN

Note, this #ifdef really should never be in kernel code if you are doing
things properly.  There are functions to handle this correctly...

Things get "fun" when you have devices in one endian running on busses
of other endian.  Hopefully this driver never has to deal with that, but
for many others we do, so please stick with the normal functions to
handle this whenever possible.

thanks,

greg k-h
