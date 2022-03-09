Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DCBB4D2EFC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiCIMWd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:22:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229744AbiCIMW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:22:29 -0500
Received: from smtp77.iad3b.emailsrvr.com (smtp77.iad3b.emailsrvr.com [146.20.161.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE39F17584E
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 04:21:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mev.co.uk;
        s=20190130-41we5z8j; t=1646828490;
        bh=1ToLucqmLc0fECQ0cyF4pYdwXhpwTwSDM8erZd2a6qM=;
        h=Date:Subject:To:From:From;
        b=Zam3uuIj97II5VPV4O8Z+1dSDHpaq2d3ELQWZlV+7uzTa2eNK88Xgohl7YEfEJLkb
         1rXkBvSIs56Me69JnHUS2MfFoPiv3nokcU8jaj6Up1+Awk/kVBAWIE3USSMQQJFcWe
         cTlg59azPFIbW5S1Xa9yysCzMfU1PJ7TnKu9HN9s=
X-Auth-ID: abbotti@mev.co.uk
Received: by smtp10.relay.iad3b.emailsrvr.com (Authenticated sender: abbotti-AT-mev.co.uk) with ESMTPSA id 8C56CE00CE;
        Wed,  9 Mar 2022 07:21:29 -0500 (EST)
Message-ID: <dc925476-dcd4-0540-61cf-f888e67220b7@mev.co.uk>
Date:   Wed, 9 Mar 2022 12:21:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH 8/8] Constify comedi_lrange struct pointer
Content-Language: en-GB
To:     Hatim Muhammed <hatimmohammed369@gmail.com>,
        linux-kernel@vger.kernel.org
Cc:     greg@kroah.com, hsweeten@visionengravers.com
References: <20220309091250.13290-1-hatimmohammed369@gmail.com>
From:   Ian Abbott <abbotti@mev.co.uk>
Organization: MEV Ltd.
In-Reply-To: <20220309091250.13290-1-hatimmohammed369@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Classification-ID: 2f4b55cc-ca97-4c16-9b39-bbcb1f7b3ce2-1-1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2022 09:12, Hatim Muhammed wrote:
> From: Hatim Muhammed <hatimmohammed369@gmail.com>
> 
> Signed-off-by: Hatim Muhammed <hatimmohammed369@gmail.com>
> ---
>   drivers/comedi/drivers/das16.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/comedi/drivers/das16.c b/drivers/comedi/drivers/das16.c
> index 937a69ce0977..d1eeb5896f2d 100644
> --- a/drivers/comedi/drivers/das16.c
> +++ b/drivers/comedi/drivers/das16.c
> @@ -956,7 +956,7 @@ static const struct comedi_lrange *das16_ai_range(struct comedi_device *dev,
>   
>   	/* get any user-defined input range */
>   	if (pg_type == das16_pg_none && (min || max)) {
> -		struct comedi_lrange *lrange;
> +		const struct comedi_lrange *lrange;
>   		struct comedi_krange *krange;
>   
>   		/* allocate single-range range table */
> @@ -990,7 +990,7 @@ static const struct comedi_lrange *das16_ao_range(struct comedi_device *dev,
>   
>   	/* get any user-defined output range */
>   	if (min || max) {
> -		struct comedi_lrange *lrange;
> +		const struct comedi_lrange *lrange;
>   		struct comedi_krange *krange;
>   
>   		/* allocate single-range range table */

NAK.  I'm pretty sure this will result in new compiler warnings because 
*lrange really isn't const.

-- 
-=( Ian Abbott <abbotti@mev.co.uk> || MEV Ltd. is a company  )=-
-=( registered in England & Wales.  Regd. number: 02862268.  )=-
-=( Regd. addr.: S11 & 12 Building 67, Europa Business Park, )=-
-=( Bird Hall Lane, STOCKPORT, SK3 0XA, UK. || www.mev.co.uk )=-
