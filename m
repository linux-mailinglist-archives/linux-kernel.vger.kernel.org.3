Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1EB4D496CF8
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Jan 2022 17:50:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234552AbiAVQuo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Jan 2022 11:50:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbiAVQun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Jan 2022 11:50:43 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64712C06173B;
        Sat, 22 Jan 2022 08:50:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13A3060C8A;
        Sat, 22 Jan 2022 16:50:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1ABF7C004E1;
        Sat, 22 Jan 2022 16:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642870241;
        bh=ai0bdkmLLaUZQn85MEo6wjda/B1Gn0TYIt50xX7bav8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=a1WB4UCC3y3FTy844pQGgaXTRuTQKxiha1wcVBV+APvTA5S6Pzs12czlWURM9+Gyx
         IIn774d4IUkBgLqmGUe6FWxkFbJmgDAmCQdt+9rzlDc5C+YfO1v0YKig01cWZeSqRO
         rQB5MDYGyT2eQDj5hSTE7/XK20aUNqsOx/8o46VhHwKrktxo+i5zLsajdMJpFNonX7
         XllWDkmWZqg8/EIbvsXMFBJb/5zJQPP+uku9iK4LhuoyEigqU36QnQHCZWi7hqVo7D
         2EBsRzOW+UDkkpvfe8pbeliIh6VADIgduSsvAVbXYm6Dyzh/K1nF8OAkX7p7b+ox7O
         UgY7ucYVDly+A==
Date:   Sat, 22 Jan 2022 16:56:49 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] iio: hw_consumer: Use struct_size() helper in
 kzalloc()
Message-ID: <20220122165649.4c3a3f9e@jic23-huawei>
In-Reply-To: <202201201532.1F9C5BD@keescook>
References: <20220120225243.GA37225@embeddedor>
        <202201201532.1F9C5BD@keescook>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 15:33:14 -0800
Kees Cook <keescook@chromium.org> wrote:

> On Thu, Jan 20, 2022 at 04:52:43PM -0600, Gustavo A. R. Silva wrote:
> > Make use of the struct_size() helper instead of an open-coded version,
> > in order to avoid any potential type mistakes or integer overflows that,
> > in the worst scenario, could lead to heap overflows.
> > 
> > Also, address the following sparse warnings:
> > drivers/iio/buffer/industrialio-hw-consumer.c:63:23: warning: using sizeof on a flexible structure
> > 
> > Link: https://github.com/KSPP/linux/issues/174
> > Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>  
> 
> Looks good to me.
> 
> Reviewed-by: Kees Cook <keescook@chromium.org>
> 
Good thing to tidy up, but I'm a little curious why I'm not
seeing these reports with latest sparse?
Ah. Found it via the report linked
CF='-Wflexible-array-sizeof'

Probably worth mentioned that in the patch descriptions. I've added it
to this one. 

I'm still setting the sparse report even with this patch.

What am I missing?

Jonathan

