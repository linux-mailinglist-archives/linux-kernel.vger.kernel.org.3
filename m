Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A1FCC49DEB3
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 11:05:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238904AbiA0KF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 05:05:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238892AbiA0KFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 05:05:25 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E42EC06173B
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:05:25 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id o64so2439273pjo.2
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 02:05:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LBOQjqTrRKyhdvBvzMylROfqbjWsRkHJwbCc+XSqEB4=;
        b=hU+y8UUCtnvmLs91gy6C7O0CCHoYJ2TYmaHx7LExtXnAX3g2ZUWGqWjQGO9/EoDTHL
         LKJm5G2IXBdaabWdTa5DJp52fycGA3iBYSheTFsR6/eT0zTGBJ9vL1CUM+YzZJ4QOml5
         mjaQGcvCY2aRk+2I7XMu+2PSCwnYj1z7fGDwI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LBOQjqTrRKyhdvBvzMylROfqbjWsRkHJwbCc+XSqEB4=;
        b=r3xyW/g8zSAUl8XEh02mp848M5ZFoC9P7A4SPe5yVneo0vFdIZTH0om1qq9W0y1TCq
         ZHaRzzBvGd/qv51Qa67w08VjUbaTRgM6mn7g8C3lSi1iolEFjBqu7UMIpUTFiRIs3Pze
         eKIn7AXTp53Es1J6nx6eyYPQbrJ8x9rDCts0t9k2bS3VKsZ/uS7GvRa70UrurIGQHBiW
         ziyTbQgKugm4iPwiknpKKknUuOlsDyFiCuX92tovWlmrJiYMsCUbr2GKVtZ2LxeKfoNQ
         yS2PSGu1g6Kedi0n1fsTWRV0+scIxiQiv9nOai2/vqmPe1VkBm68T26Q9sa2gx7kP+cy
         ud1Q==
X-Gm-Message-State: AOAM530qaoE3khN1VxXsfFuNUuk/NS1ZYF2d3OgB8qVWuJ5HiSC3aRfR
        L7mbQ8NqESwYPLmRiZbenSePzg==
X-Google-Smtp-Source: ABdhPJwHB0qa1O7m8UjQXGx1IEj/br7glW0Yig/xNOufSEf8geSAYNnvEm+sDvMzb7zRtZzMRbp7zw==
X-Received: by 2002:a17:90b:1b46:: with SMTP id nv6mr3459486pjb.178.1643277924815;
        Thu, 27 Jan 2022 02:05:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p42sm4980243pfw.71.2022.01.27.02.05.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 02:05:24 -0800 (PST)
Date:   Thu, 27 Jan 2022 02:05:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Viresh Kumar <vireshk@kernel.org>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] staging: greybus: i2c: Use struct_size() helper in
 gb_i2c_operation_create()
Message-ID: <202201270204.D460EC35@keescook>
References: <20220121222250.GA73021@embeddedor>
 <202201241213.82E7D9F598@keescook>
 <20220126105404.GY1951@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220126105404.GY1951@kadam>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 01:54:04PM +0300, Dan Carpenter wrote:
> On Mon, Jan 24, 2022 at 12:19:03PM -0800, Kees Cook wrote:
> > This could still overflow if struct_size() returns SIZE_MAX. Perhaps:
> > 
> > 	if (check_add_overflow(struct_size(request, ops, msg_count),
> > 			       data_out_size, &request_size))
> > 		request_size = SIZE_MAX;
> > 
> > I should brush off the saturating arithmetic helpers series:
> > https://lore.kernel.org/all/20210920180853.1825195-1-keescook@chromium.org/
> 
> Yes, please!  Those seem like a million times easier to use.

Here they are! :) Please review:

https://lore.kernel.org/lkml/20220124232342.3113350-1-keescook@chromium.org/

Thanks!

-- 
Kees Cook
