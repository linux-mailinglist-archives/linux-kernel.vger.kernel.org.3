Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B1A499F4B
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 00:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1588589AbiAXW40 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 17:56:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457425AbiAXVzF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 16:55:05 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEBBC07E297;
        Mon, 24 Jan 2022 12:36:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 78A2A614FF;
        Mon, 24 Jan 2022 20:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15638C340E7;
        Mon, 24 Jan 2022 20:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643056569;
        bh=N6HkrGlOPhp/lfQrBU6OuWeAmsz4cFxje4P56uyHS08=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tMvS0u9vqPHiJmamtWo2hxIfeAM+s7Ecv0ZmZJ0nQZ3D9W1YwYkePQzqZdW43jJC/
         pfn1HewwRr0fGJ+xwd5Szt17yDi6vy2vdgPuuIuDHKlaCZuIULmPqLbZn9cVnX2nzn
         AtH4RV7t+kJEaz7frVA2Aebsq/f/78dU+4jAly/NqVY6WvAUtuMyruYuYh2yF/EwF4
         nhXr1MwoYKa6iexDzDGY+fGXeEWHH1cVD03wqebpbpxEwrgzZAcxu4mUZBDTrdMb4K
         albBIx6R0f/tPjsk7yittG9m7wqN75cGDYd3L2DxSO/JotyKF7DmJsKKXj/81iMtvq
         fD0RpJx+KWiuQ==
Date:   Mon, 24 Jan 2022 14:42:53 -0600
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Viresh Kumar <vireshk@kernel.org>, Johan Hovold <johan@kernel.org>,
        Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: greybus: i2c: Use struct_size() helper in
 gb_i2c_operation_create()
Message-ID: <20220124204253.GA11735@embeddedor>
References: <20220121222250.GA73021@embeddedor>
 <202201241213.82E7D9F598@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202201241213.82E7D9F598@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 24, 2022 at 12:19:03PM -0800, Kees Cook wrote:
> On Fri, Jan 21, 2022 at 04:22:50PM -0600, Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version,
> > in order to avoid any potential type mistakes or integer overflows that,
> > in the worst scenario, could lead to heap overflows.
> > 
> > Also, address the following sparse warnings:
> > drivers/staging/greybus/i2c.c:111:24: warning: using sizeof on a flexible structure
> > 
> > Link: https://github.com/KSPP/linux/issues/174
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
> > ---
> >  drivers/staging/greybus/i2c.c | 4 +---
> >  1 file changed, 1 insertion(+), 3 deletions(-)
> > 
> > diff --git a/drivers/staging/greybus/i2c.c b/drivers/staging/greybus/i2c.c
> > index de2f6516da09..9dfc6791c20e 100644
> > --- a/drivers/staging/greybus/i2c.c
> > +++ b/drivers/staging/greybus/i2c.c
> > @@ -108,9 +108,7 @@ gb_i2c_operation_create(struct gb_connection *connection,
> >  		else
> >  			data_out_size += (u32)msg->len;
> >  
> > -	request_size = sizeof(*request);
> > -	request_size += msg_count * sizeof(*op);
> > -	request_size += data_out_size;
> > +	request_size = struct_size(request, ops, msg_count) + data_out_size;
> 
> This could still overflow if struct_size() returns SIZE_MAX. Perhaps:

uggh... I got too excited with all the new cases reported. 
> 
> 	if (check_add_overflow(struct_size(request, ops, msg_count),
> 			       data_out_size, &request_size))
> 		request_size = SIZE_MAX;

Yep; I'll respin and include this change, thanks!
> 
> I should brush off the saturating arithmetic helpers series:
> https://lore.kernel.org/all/20210920180853.1825195-1-keescook@chromium.org/

Yeah; those helpers are very much needed in many places we need to audit...

--
Gustavo
