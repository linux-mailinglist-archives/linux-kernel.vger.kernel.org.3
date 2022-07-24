Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E25457F5FB
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Jul 2022 18:18:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233160AbiGXQSm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Jul 2022 12:18:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGXQSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Jul 2022 12:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AD86DFA9
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 09:18:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AAC4A61173
        for <linux-kernel@vger.kernel.org>; Sun, 24 Jul 2022 16:18:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9800C3411E;
        Sun, 24 Jul 2022 16:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1658679519;
        bh=nDB+o49XcTpu/QVchsj6bZI0yKCqaAixiuirPza3+48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UJzeNwXBJ0O8+CNaWnyB44zQJf7QVtC/EXMa5JFo1E2JZX2Oy1I5mQBuFjEHPC1gu
         jGwTxtO+RXLhvqc00dBcjmlHdeqkME4UHAX0gQ7QGMM4+Ki9/gQCh3wmAhKcjMSSCv
         4cpwm1I/jaebiho4+BwZ/ksOJsCprRSBjSCbsNAQ=
Date:   Sun, 24 Jul 2022 18:18:36 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: handle errors from
 ReadAdapterInfo8188EU
Message-ID: <Yt1w3MvAI7M4rKbD@kroah.com>
References: <20220724161405.146488-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220724161405.146488-1-martin@kaiser.cx>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 24, 2022 at 06:14:05PM +0200, Martin Kaiser wrote:
> --- a/drivers/staging/r8188eu/os_dep/usb_intf.c
> +++ b/drivers/staging/r8188eu/os_dep/usb_intf.c
> @@ -332,7 +332,8 @@ static struct adapter *rtw_usb_if1_init(struct dvobj_priv *dvobj,
>  	rtl8188eu_interface_configure(padapter);
>  
>  	/* step read efuse/eeprom data and get mac_addr */
> -	ReadAdapterInfo8188EU(padapter);
> +	if (ReadAdapterInfo8188EU(padapter) < 0)
> +		goto handle_dualmac;

You threw away the error returned to you here, why?  Shouldn't it
propagate upward?

thanks,

greg k-h
