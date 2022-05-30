Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 397E553771F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 10:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233244AbiE3IPj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 04:15:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233724AbiE3IPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 04:15:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B56FC78924
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 01:14:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C970160DD8
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 08:14:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40B8C385B8;
        Mon, 30 May 2022 08:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1653898471;
        bh=8VgPejTLh/Va14hE2dsYxkbnUTnqDKlPzUmj0S1440c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aLlhtZamTkQ4LVZ26x6gszSywyBIqSGBxF4kvlBceOgl5LQscE6Y3GcIY9ChHW6Jv
         pMzki5cSmz0HLx7Ik/BKV3rnJC8MYWB9rQC3hAIdRrHFEsYV3cGKc1z9QnsUvsd5tC
         U1iJSOQLzOR4iUlLumEYWjGNCC4Vc5xRVD+uinz8=
Date:   Mon, 30 May 2022 10:14:28 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Haowen Bai <baihaowen@meizu.com>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Florian Schilhabel <florian.c.schilhabel@googlemail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: rtl8712: Fix pointer dereferenced before
 checking
Message-ID: <YpR85JgzGsTzYm3W@kroah.com>
References: <1653897933-25931-1-git-send-email-baihaowen@meizu.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1653897933-25931-1-git-send-email-baihaowen@meizu.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 30, 2022 at 04:05:32PM +0800, Haowen Bai wrote:
> The padapter->recvpriv.signal_qual_data is dereferencing before null
> checking, so move it after checking.
> 
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
>  drivers/staging/rtl8712/rtl8712_recv.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/rtl8712/rtl8712_recv.c b/drivers/staging/rtl8712/rtl8712_recv.c
> index 7f1fdd058551..8ed94b259dbe 100644
> --- a/drivers/staging/rtl8712/rtl8712_recv.c
> +++ b/drivers/staging/rtl8712/rtl8712_recv.c
> @@ -863,10 +863,12 @@ static void process_link_qual(struct _adapter *padapter,
>  {
>  	u32	last_evm = 0, tmpVal;
>  	struct rx_pkt_attrib *pattrib;
> -	struct smooth_rssi_data *sqd = &padapter->recvpriv.signal_qual_data;
> +	struct smooth_rssi_data *sqd;
>  
>  	if (!prframe || !padapter)
>  		return;
> +
> +	sqd = &padapter->recvpriv.signal_qual_data;

How can padapter ever be NULL in this codepath?

thanks,

greg k-h
