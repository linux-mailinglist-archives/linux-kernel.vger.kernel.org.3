Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A565950259B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 08:31:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350468AbiDOGeF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 02:34:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350458AbiDOGd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 02:33:56 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D21F45BE52;
        Thu, 14 Apr 2022 23:31:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81CB5B8282C;
        Fri, 15 Apr 2022 06:31:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 981C2C385A6;
        Fri, 15 Apr 2022 06:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1650004286;
        bh=vNvTyZfr+G0pyUo1bitL8R5ZCYiZCbBy0L86pD4L9zg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y95mTntUPcQegNJbDJWA4bBSmAn2sSaDxOHc56ExScPJYvpvNbZ571XWuBqUjfcXG
         mYAl+lcETjSs9XwYcXZ+otSKnKPbP75hNLd+gLZHbQrG3zlJ1Sq4p2vpbocXxfOaiR
         mPv7EywZ2DvLLoFjVgikn+Lmyg50EFtiOBsVJgUA=
Date:   Fri, 15 Apr 2022 08:31:23 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "D. Starke" <daniel.starke@siemens.com>
Cc:     linux-serial@vger.kernel.org, jirislaby@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 16/20] tty: n_gsm: fix invalid command/response bit check
 for UI/UIH frames
Message-ID: <YlkRO6fAPCuWyT1Y@kroah.com>
References: <20220414094225.4527-1-daniel.starke@siemens.com>
 <20220414094225.4527-16-daniel.starke@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414094225.4527-16-daniel.starke@siemens.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 02:42:21AM -0700, D. Starke wrote:
> From: Daniel Starke <daniel.starke@siemens.com>
> 
> n_gsm is based on the 3GPP 07.010 and its newer version is the 3GPP 27.010.
> See https://portal.3gpp.org/desktopmodules/Specifications/SpecificationDetails.aspx?specificationId=1516
> The changes from 07.010 to 27.010 are non-functional. Therefore, I refer to
> the newer 27.010 here. Chapter 5.4.3.1 states the CR bit in UI and UIH
> frames shall always be set 1 by the initiator and 0 by the responder.

This has nothing to do with the change you made here.


> Currently, gsm_queue() has a pre-processor gated (excluded) check which
> treats all frames that conform to the standard as malformed frames.
> Remove this optional code to avoid confusion and possible breaking changes
> in case that someone includes it.

Again, nothing to do with the code change.

> 
> Fixes: e1eaea46bb40 ("tty: n_gsm line discipline")

This "fixes" nothing :(

> Cc: stable@vger.kernel.org

How is commenting out unused code a stable backport requirement?

> Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
> ---
>  drivers/tty/n_gsm.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
> index e9a7d9483c1f..f4ec48c0d6d7 100644
> --- a/drivers/tty/n_gsm.c
> +++ b/drivers/tty/n_gsm.c
> @@ -1896,10 +1896,6 @@ static void gsm_queue(struct gsm_mux *gsm)
>  	case UI|PF:
>  	case UIH:
>  	case UIH|PF:
> -#if 0
> -		if (cr)
> -			goto invalid;
> -#endif

All you are doing is cleaning up dead code.  Not a big deal, and not
worth all the text above to confuse people :(

thanks,

greg k-h
