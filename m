Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBA8C500B0D
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 12:26:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242270AbiDNK2j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 06:28:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239011AbiDNK2g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 06:28:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 964636C94D;
        Thu, 14 Apr 2022 03:26:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3345161DCE;
        Thu, 14 Apr 2022 10:26:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44599C385A5;
        Thu, 14 Apr 2022 10:26:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1649931970;
        bh=ZQjNNGaDE88G+jCAsYeLoetA2Gs7aMcuSn6n5mbSGRQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KAT+o4XQH1FNm9EN+3rrEgo4JjdEeyC31cRmpj6eXF809docckODh6KUgWiqAskHz
         nuqzEc1O1r2oWJn+8Dv0UdL16IbjOgdzK1Vrfm8nL/AFnTrI6waLreybSzJEFuxoye
         dwmPIbuKN35WHObLKoGfjgUqyGfKmIMYtdpkzL14=
Date:   Thu, 14 Apr 2022 12:26:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Colin Ian King <colin.i.king@gmail.com>
Cc:     linux-staging@lists.linux.dev, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8192u: make read-only array EWC11NHTCap
 static const
Message-ID: <Ylf2uDiVLniQiACK@kroah.com>
References: <20220414101838.296944-1-colin.i.king@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414101838.296944-1-colin.i.king@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 11:18:38AM +0100, Colin Ian King wrote:
> Don't populate the read-only array EWC11NHTCap on the stack but instead
> make it static const. Also makes the object code a little smaller. Move
> comment to clean up checkpatch warning.
> 
> Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> ---
>  drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> index 358c35d9589c..b4cbe499ba37 100644
> --- a/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> +++ b/drivers/staging/rtl8192u/ieee80211/rtl819x_HTProc.c
> @@ -480,7 +480,8 @@ void HTConstructCapabilityElement(struct ieee80211_device *ieee, u8 *posHTCap, u
>  	}
>  	memset(posHTCap, 0, *len);
>  	if (pHT->ePeerHTSpecVer == HT_SPEC_VER_EWC) {
> -		u8	EWC11NHTCap[] = {0x00, 0x90, 0x4c, 0x33};	// For 11n EWC definition, 2007.07.17, by Emily
> +		/* For 11n EWC definition, 2007.07.17, by Emily */

This is not needed anymore, you know this...

Just delete it please.

thanks,

greg k-h
