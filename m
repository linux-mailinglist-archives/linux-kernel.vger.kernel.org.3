Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AB0046B3CA
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 08:22:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbhLGH0K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 02:26:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbhLGH0J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 02:26:09 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 698C2C061746
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 23:22:39 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id g19so12592946pfb.8
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 23:22:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=vOSlwJCnU3hV0MmoQQGLu4dlcaI9PmScMQSIZJx5Ris=;
        b=a0lstKPixIOEDSww0rvLpC04O7y9SlYkz+AeTdl/1P17u8G9GFQMM2B9+m44YjiM2g
         lpYcd2glY2vaG33ux1aO8szrg5yy+LQIJQ6TCupvwUW48GVknjyKol4mIKrEPbk6miDS
         cKFgvbFPut+xLAJVkz8q6aO38jEpM+Py3djW2nhZrlTFrxiQYhi/bNwO9ES9mPfji8vX
         E5ob86jxbm1XJAht0Hiqj6wWBhrroKLbaV89yauDXouofp+bu5o6sYTs0+00W9k/aK8h
         +R2/vN6N2oXFfYGvA4dahTfenLak9mt2B8tadZ3q8snUPVuq0oWNnjCbFk0z+zTr8JD1
         TF7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=vOSlwJCnU3hV0MmoQQGLu4dlcaI9PmScMQSIZJx5Ris=;
        b=5BdAHZRteHsYfezy+m1KYVuy+h9ajgqmcSAVG23GnXkCrM3V0yKmMQLGxfstdBdYmi
         O4gsdzQi+90B8NoEB9Kmt6tW4BCmlAIOENABUT21IURwYxETD5X7NeS5M8V/IQKyCvCZ
         8FPm5KOqdP0nRKU9QWLjrhtJc02by2421SEowqtEeWMopjx9C1Osmfj0u4LCvPcfk3rk
         YijfdjAps0B3i1tknkxGOnan5tWI5F3G9VzNX9wyHd/1N5P/f/8JEOlaz15XbWflxMYj
         L/OAKmKcvAivhOF5GZ3wWgop/waTh4NCFEHYfUdvRUHnJBnbnR2Vu8tUJxJQlf448XCq
         ejfg==
X-Gm-Message-State: AOAM531DKvFX0GnL4TFlD1tvGy9RW/pDFeW787puRzqxL6wwlcxcHPNZ
        kcdUceD7FAuPovIb76bFSKc=
X-Google-Smtp-Source: ABdhPJyT8x4mDfXrZcJ+dWSlKKgiwaZeCJ5DEuByZxqn2L2WIR9WUsiykMQW0qaXC4rxcRPF4nJaaQ==
X-Received: by 2002:a63:d802:: with SMTP id b2mr12383337pgh.34.1638861758884;
        Mon, 06 Dec 2021 23:22:38 -0800 (PST)
Received: from google.com ([2620:15c:202:201:25b0:d110:b844:ea00])
        by smtp.gmail.com with ESMTPSA id w17sm15277153pfu.58.2021.12.06.23.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 23:22:37 -0800 (PST)
Date:   Mon, 6 Dec 2021 23:22:35 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     lianzhi chang <changlianzhi@uniontech.com>
Cc:     linux-kernel@vger.kernel.org, gregkh@linuxfoundation.org,
        jirislaby@kernel.org, andriy.shevchenko@linux.intel.com,
        dan.carpenter@oracle.com, lkp@intel.com, 282827961@qq.com
Subject: Re: [PATCH v19] tty: Fix the keyboard led light display problem
Message-ID: <Ya8Lu1lo72w7JAud@google.com>
References: <20211201012235.9472-1-changlianzhi@uniontech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201012235.9472-1-changlianzhi@uniontech.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 09:22:35AM +0800, lianzhi chang wrote:
> +	if (kb->kbdmode != VC_RAW &&
> +		 kb->kbdmode != VC_MEDIUMRAW &&
> +		 kb->kbdmode != VC_OFF) {
> +		vt_switch = true;
> +		set_leds();
> +	}

As I mentioned earlier, please do this unconditionally.

Thanks.

-- 
Dmitry
