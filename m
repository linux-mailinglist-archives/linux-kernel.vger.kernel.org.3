Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D1294883D5
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Jan 2022 14:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234253AbiAHNxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 08:53:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230023AbiAHNxY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 08:53:24 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79CA3C061574
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 05:53:24 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id a18so32541557edj.7
        for <linux-kernel@vger.kernel.org>; Sat, 08 Jan 2022 05:53:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IfBpMF7ZpiSkVVFjrUiS9oq4g5AGMq3hHhumCDyyUTo=;
        b=kQUhGaUdZLBCXPxF/kdwC3ug4bfeBbV/4DtwPQPwXGWJbO15X7gfmBVfUmPOgK5cM0
         /0sl/M0RT1dsEj1I+ky70JXWKTEEbYSlTpin4J79Pnmx0JO8CybEziMZrudI7RRrQfKE
         vD1cX5floz8zJtD2xc550oUS1VHhCWoOaPc9I1g2zfDTNmKU0VrPXjM3HnQNb6wSflGR
         9Uf+rv+hY9sl67qcsnHNglxufQNannXokbwSB+B7I4VD88s7XR3KR0pVfNf69JG3OTnG
         UBsxiH9v1pnKmPQIZQiPypi/qfwT3u8yTceeoyg+iajsRGvlmYLEDufz/3oAYN8jTJJH
         rI7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IfBpMF7ZpiSkVVFjrUiS9oq4g5AGMq3hHhumCDyyUTo=;
        b=qfZBubnNV/kmKnfTGEAjbtypEEkLCQFlKe/pEW0OPpfBZ6uHCUjLpK1l+5A47Izpzm
         hKxlKsgOq8y5fEOxX2oXPIs2B9sX2smELcXeolw2Qa6OJxdE31qvLPYUbFUYIzqIHJNn
         LnQtpFYenBeLC5HqThwHPB5AKhqkgnB72zjmwhxcM2zsBcrKLrQxM7ncoD3Iif7w+cJR
         DqurrPxRJEgD5xqPuKbP6nc0MVjzQDslcLWORI7AaE5nocQ9Qjf9WvgdeKFQxUSsAbnh
         +qXtSjEiuspHjsa+4FwQwnuxFuNpx6K1Y2nS6dPxejmPbQR34M44c/9lh+ZrTM+zuJzU
         5JAg==
X-Gm-Message-State: AOAM532Gqmi5RSWbKQI3++pcLDEH57zU8Zzrb/sjYdOpscEpIvj1BCBw
        Yo8SdAGddvzq2tkQKptKi88=
X-Google-Smtp-Source: ABdhPJzzyYjDVAKU1HN2s+625kayP58JZA+p6Gzt5uwrUrIVIXEWlS4+KTJ+wwWTvN5Fqk+jwW+s9A==
X-Received: by 2002:a17:906:2799:: with SMTP id j25mr52869223ejc.700.1641650002572;
        Sat, 08 Jan 2022 05:53:22 -0800 (PST)
Received: from t470p (host-79-36-120-235.retail.telecomitalia.it. [79.36.120.235])
        by smtp.gmail.com with ESMTPSA id k25sm537456ejk.179.2022.01.08.05.53.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Jan 2022 05:53:22 -0800 (PST)
Date:   Sat, 8 Jan 2022 14:53:19 +0100
From:   Alberto Merciai <alb3rt0.m3rciai@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linuxfancy@googlegroups.com,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Martin Kaiser <martin@kaiser.cx>,
        "Fabio M. De Francesco" <fmdefrancesco@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Saurav Girepunje <saurav.girepunje@gmail.com>,
        Ivan Safonov <insafonov@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Zameer Manji <zmanji@gmail.com>, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 03/56] staging: r8188eu: remove dead macro ClearToDs
Message-ID: <20220108135319.GA509144@t470p>
References: <20220103190326.363960-1-alb3rt0.m3rciai@gmail.com>
 <20220103190326.363960-4-alb3rt0.m3rciai@gmail.com>
 <Ydb5SrclLcYzUrsC@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydb5SrclLcYzUrsC@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Remove dead macro ClearToDs.
> 
> "dead"?  Was it ever alive?
> 
> I think you mean to write something like:
> 
> 	The #define ClearToDs() is not used anywhere in the r8188eu
> 	driver, so it can be safely removed.
> 
> right?
Yes, correct.

Thanks,
Alberto


