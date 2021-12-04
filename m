Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD414468480
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Dec 2021 12:32:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384793AbhLDLf0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Dec 2021 06:35:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240942AbhLDLfZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Dec 2021 06:35:25 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93185C061751
        for <linux-kernel@vger.kernel.org>; Sat,  4 Dec 2021 03:31:59 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id e3so22356113edu.4
        for <linux-kernel@vger.kernel.org>; Sat, 04 Dec 2021 03:31:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=GooOIiXrE5oPnohZHDuYVBOk/AGEAvYFkup6wdSNpaE=;
        b=mKYPmc9bfweBc+WtTm39SF93PRyLkvKL3pUPHaRE4idLbKQ9thO8M/1Ylftp07WRKa
         6nQIqtPGPNQvmo9L4PdtfRNS64+MFFdHRKoHDJxSIS4kf2u3L1rfbWVqWaBqgzqv3BVo
         o8Lc1AfkgMRwnBhI24NtBQCu2sS01HpW3z1LTvrTsywrrQ1OCw36yynwFTe4kho6BoI6
         Eud1K7NkYKUtQKrMTNsUOXXpDVJ/pYpWLAa2cLD7xGMqA7A+Msuk3b5eJsx7Vp9IcVip
         zxrpzmLjHMQi4Jvrwku/cKm2DZVPSTaZxxcFDfrVpNQPK3KtV6LzVgtBV1k37G/y+wqP
         cciQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=GooOIiXrE5oPnohZHDuYVBOk/AGEAvYFkup6wdSNpaE=;
        b=GFM2PbNxOUnsY2WcUJlmxS87oF4eD0pvDIqNFH1oJAAD76c/chetLj+n3GNTJDEso8
         jSFD1dQNY4qd4a2y22jU/432FkR94UwxSQeHx79oKo+s56UZ8Xum+ooJskeLIh7xAzjA
         ulGTVJb0dL24cnvDdWECvAy0F9wHQRANQV4icgA2mjOiEd9lNhnBJ2+nZuXSSFcNDukb
         +2jcHk86CPq2+e5U8WHzh7lJG+LIA1hODKnvUTqW7zaBaYpz1NvENfeyh0C33WN5dq2L
         Y8rmaUGGTGu8Npt88M9yrBI7g6RnLSc9zWRA00ERt4sWWRDWoJVStlauOoElu2A/NzlO
         ixiQ==
X-Gm-Message-State: AOAM533WvZrF6RQZ6Uto+nPc3t7+XWSC++vYF/LfToVeu3iHMXLDB21G
        RcZxJONDFyz9Kj/D+00KULQ=
X-Google-Smtp-Source: ABdhPJx/XvGaGSZUvaRJUTw9fPP7CEUuiTWfVuZq60Q7q2Iep+jestcIngt/+75NCtwAzV3VhQoRwg==
X-Received: by 2002:a05:6402:2744:: with SMTP id z4mr35133046edd.310.1638617518251;
        Sat, 04 Dec 2021 03:31:58 -0800 (PST)
Received: from bulldog (host-79-17-112-183.retail.telecomitalia.it. [79.17.112.183])
        by smtp.gmail.com with ESMTPSA id r24sm3655144edv.18.2021.12.04.03.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Dec 2021 03:31:57 -0800 (PST)
Date:   Sat, 4 Dec 2021 12:31:56 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Pavel Skripkin <paskripkin@gmail.com>
Cc:     Forest Bond <forest@alittletooquiet.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tommaso Merciai <tomm.merciai@gmail.com>,
        Karolina Drobnik <karolinadrobnik@gmail.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Aldas =?utf-8?B?VGFyYcWha2V2acSNaXVz?= <aldas60@gmail.com>,
        Lucas Henneman <lucas.henneman@linaro.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: vt6655: remove unused variable byMinChannel
Message-ID: <20211204113156.GA3940683@bulldog>
References: <20211204103053.3934783-1-alb3rt0.m3rciai@gmail.com>
 <e64fe951-8e57-4c28-5451-71872247c57a@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e64fe951-8e57-4c28-5451-71872247c57a@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 02:29:32PM +0300, Pavel Skripkin wrote:
> On 12/4/21 13:30, Alberto Merciai wrote:
> > Remove set but not used variable byMinChannel.
> > 
> > ---
> 
> Signed-off-by: is missing :)
ouch, forgot it.. :P

Thanks,

Alberto
