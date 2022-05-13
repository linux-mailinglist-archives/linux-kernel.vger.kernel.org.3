Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31792525C2E
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377681AbiEMHKb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:10:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352515AbiEMHK3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:10:29 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 804A72A3774;
        Fri, 13 May 2022 00:10:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 03ED4CE2CFD;
        Fri, 13 May 2022 07:10:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B820C34100;
        Fri, 13 May 2022 07:10:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652425825;
        bh=mID18fXQqC7NIYUUm4cbw2vY9pjGLLMMdf914py8+lA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=n76a5HrIC3G4NQ8t9FzaHlBGapPqhTJIA+kLuGCo4r4Q2x49mJhQF1zo2zT1WJ21S
         q2K0w664T3IriznhZvRqrA6HIIZzumi836aFQmnY+xLwG0eBQ+/Uk2W51QSZ8LvReW
         4UQ3j7ndM/NpjcnP32GF/dlTKbBiytrX9DsbM54IZc3ReNgtZTc6kOvlKcGK7zfyBR
         Zfu/yJjYdJThveYY82AAS5jOsRP4zxqMiNzEkQrP8DmV/2bn3+i6AairpobBqDvFlc
         5RaetKyzjRC5ybrSmJzG5qjMGmOtqg9e99FI9RoChfNLLTJH8emasugGVfQCqMUNy9
         a4lAD2M+F1Dhg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1npPRN-0006ey-VS; Fri, 13 May 2022 09:10:22 +0200
Date:   Fri, 13 May 2022 09:10:21 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Ilpo =?utf-8?B?SsOkcnZpbmVu?= <ilpo.jarvinen@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] tty/termbits: remove #ifdef IBSHIFT that is always
 defined
Message-ID: <Yn4EXQisXkK9w0cs@hovoldconsulting.com>
References: <20220511101139.5306-1-ilpo.jarvinen@linux.intel.com>
 <20220511101139.5306-4-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511101139.5306-4-ilpo.jarvinen@linux.intel.com>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 01:11:37PM +0300, Ilpo Järvinen wrote:
> IBSHIFT is defined by all architectures.

This also changed recently so mention the commit in question.

Subject is overly verbose here too.

> Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
> ---
>  drivers/tty/tty_baudrate.c | 11 +----------
>  1 file changed, 1 insertion(+), 10 deletions(-)
> 
> diff --git a/drivers/tty/tty_baudrate.c b/drivers/tty/tty_baudrate.c
> index 07bbbfee5635..d10318956c97 100644
> --- a/drivers/tty/tty_baudrate.c
> +++ b/drivers/tty/tty_baudrate.c

> @@ -194,12 +187,10 @@ void tty_termios_encode_baud_rate(struct ktermios *termios,
>  			 */
>  			if (ofound == i && !ibinput)
>  				ifound  = i;
> -#ifdef IBSHIFT
>  			else {
>  				ifound = i;
>  				termios->c_cflag |= (baud_bits[i] << IBSHIFT);
>  			}
> -#endif

Please add the missing brackets to the if branch when removing the ifdef.

Johan
