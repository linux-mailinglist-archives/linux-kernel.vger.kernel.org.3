Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 714DE5110B3
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 07:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357858AbiD0F6n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 01:58:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232683AbiD0F6k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 01:58:40 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA7E29C8A
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 22:55:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6457BB823F4
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:55:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFE39C385A7;
        Wed, 27 Apr 2022 05:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1651038926;
        bh=7ryt9LQ2AnCmNgOLWlW1ntp7sNciS6gRukldGrC/JKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rlshWiyttey+KX7dMg2B263XRHwOtWuEGLP8AFXgF7oCeZwsziGJKFTGQ8BxKZs2k
         1g6m523dBnFgX0hoyKBoQEuP+Ecvf59TlG+PaNwTBGq/xpQrVxfINFHT82H7kiUGE8
         RVlL+VYW2AdxuX0+TeiCseJDC/4cpXeytf0bKDyI=
Date:   Wed, 27 Apr 2022 07:55:17 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Philipp Hortmann <philipp.g.hortmann@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] staging: vt6655: Replace VNSvInPortD with ioread32
Message-ID: <Ymjaxby2vDJYz6KA@kroah.com>
References: <cover.1651036713.git.philipp.g.hortmann@gmail.com>
 <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7a5f7f98379fb2af2741f613f5ddda53e5d4813e.1651036713.git.philipp.g.hortmann@gmail.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 07:42:23AM +0200, Philipp Hortmann wrote:
> Replace macro VNSvInPortD with ioread32 and as it was
> the only user, it can now be removed.
> The name of macro and the arguments use CamelCase which
> is not accepted by checkpatch.pl
> 
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
> ---
> V1 -> V2: This patch was 5/7 and is now 4/6
> V2 -> V3: Inserted patch that was before in a different way in
>           "Rename macros VNSvInPortB,W,D with CamelCase ..."
>           This patch was part of 4/6 and is now 3/7
> V3 -> V4: Removed casting of the output variable
> V4 -> V5: Joint patch "Replace two VNSvInPortD with ioread64_lo_hi"
>           with this patch. Changed ioread64 to two ioread32 as
>           ioread64 does not work with 32 Bit computers.
>           Shorted and simplified patch description.
> V5 -> V6: Added missing version in subject
> ---
>  drivers/staging/vt6655/card.c        |  6 ++++--
>  drivers/staging/vt6655/device_main.c |  6 +++---
>  drivers/staging/vt6655/mac.h         | 18 +++++++++---------
>  drivers/staging/vt6655/rf.c          |  2 +-
>  drivers/staging/vt6655/upc.h         |  3 ---
>  5 files changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/staging/vt6655/card.c b/drivers/staging/vt6655/card.c
> index 022310af5485..0dd13e475d6b 100644
> --- a/drivers/staging/vt6655/card.c
> +++ b/drivers/staging/vt6655/card.c
> @@ -744,6 +744,7 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
>  	void __iomem *iobase = priv->port_offset;
>  	unsigned short ww;
>  	unsigned char data;
> +	u32 low, high;
>  
>  	MACvRegBitsOn(iobase, MAC_REG_TFTCTL, TFTCTL_TSFCNTRRD);
>  	for (ww = 0; ww < W_MAX_TIMEOUT; ww++) {
> @@ -753,8 +754,9 @@ bool CARDbGetCurrentTSF(struct vnt_private *priv, u64 *pqwCurrTSF)
>  	}
>  	if (ww == W_MAX_TIMEOUT)
>  		return false;
> -	VNSvInPortD(iobase + MAC_REG_TSFCNTR, (u32 *)pqwCurrTSF);
> -	VNSvInPortD(iobase + MAC_REG_TSFCNTR + 4, (u32 *)pqwCurrTSF + 1);
> +	low = ioread32(iobase + MAC_REG_TSFCNTR);
> +	high = ioread32(iobase + MAC_REG_TSFCNTR + 4);
> +	*pqwCurrTSF = low + ((u64)high << 32);

Are you _sure_ this is doing the same thing?

Adding 1 to a u64 pointer increments it by a full u64.  So I guess the
cast to u32 * moves it only by a u32?  Hopefully?  That's messy.

Why not keep the current mess and do:
	pqwCurrTSF = ioread32(iobase + MAC_REG_TSFCNTR);
	((u32 *)pqwCurTSF + 1) = ioread32(iobase + MAC_REG_TSFCNTR + 4);

Or does that not compile?  Ick, how about:
	u32 *temp = (u32 *)pqwCurTSF;

	temp = ioread32(iobase + MAC_REG_TSFCNTR);
	temp++;
	temp = ioread32(iobase + MAC_REG_TSFCNTR + 4);
As that duplicates the current code a bit better.

I don't know, it's like polishing dirt, in the end, it's still dirt...

How about looking at the caller of this to see what it expects to do
with this information?  Unwind the mess from there?

thanks,

greg k-h
