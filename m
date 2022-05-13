Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3965C525C39
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377737AbiEMHON (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:14:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377601AbiEMHOJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:14:09 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E312A9CC1;
        Fri, 13 May 2022 00:14:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D720B82C59;
        Fri, 13 May 2022 07:14:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA3B3C34100;
        Fri, 13 May 2022 07:14:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652426045;
        bh=EI+ONcSQlBGpFM7hWPN3KFhdRCNRtS+UuJKEdNX2cKk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=iyUzOxPoCXk/U39lYWWofaNcupx3ZpjG8s4P8PBre07niqseBsVwFDMlCeHAjirBc
         epCFDDoIsfyWe2lEFUVt3LKBcH4oWPVTJzDa9wn1galtcAnS0VgOv9JExeH9Wjjlo3
         LBxLO5OgCz4sV1WZxNGefIgioS1LR05+Jlne7rZ0M8jcdIZo+aCixgtd7Z6CBZahlN
         fduxPbc5basXUPEMh1d5AbykGJAr630CKZ67bBG0jp1gR81EbARB8Gp+n87g6JPGpa
         UK2M42McOiHtnfdcTiMEEmi+gH7iyJ0AHC/40jWXDcmAkeBdJiKjPfVu0IsOBW33Fm
         1+IemRICEdHlQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npPUw-0006gm-B4; Fri, 13 May 2022 09:14:02 +0200
Date:   Fri, 13 May 2022 09:14:02 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/5] serial: jsm: Use B0 instead of 0
Message-ID: <Yn4FOofAvoqdaY9D@hovoldconsulting.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
 <20220511101139.5306-6-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511101139.5306-6-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:11:39PM +0300, Ilpo Järvinen wrote:
> Use B0 to check zero baudrate rather than literal 0.
> 
> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/serial/jsm/jsm_cls.c | 2 +-
>  drivers/tty/serial/jsm/jsm_neo.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/tty/serial/jsm/jsm_cls.c b/drivers/tty/serial/jsm/jsm_cls.c
> index 046b624e5f71..ca05e84a7c90 100644
> --- a/drivers/tty/serial/jsm/jsm_cls.c
> +++ b/drivers/tty/serial/jsm/jsm_cls.c
> @@ -689,7 +689,7 @@ static void cls_param(struct jsm_channel *ch)
>  	/*
>  	 * If baud rate is zero, flush queues, and set mval to drop DTR.
>  	 */
> -	if ((ch->ch_c_cflag & (CBAUD)) == 0) {
> +	if ((ch->ch_c_cflag & (CBAUD)) == B0) {

Sure, why not. How about dropping the unnecessary parenthesis around
CBAUD while at it?

Johan
