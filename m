Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF7724748E9
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 18:08:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236328AbhLNRIn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 12:08:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbhLNRIl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 12:08:41 -0500
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F120BC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:08:40 -0800 (PST)
Received: by mail-pf1-x434.google.com with SMTP id r130so18429238pfc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 09:08:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PNMBPkOZLTOjGHzj7TrbFcH7DnoXgRnqiGbYIqbL1q4=;
        b=I5YCEBIuM4wLVG+10oAs8zl2Y8rw4EHHkAmh/I4E44zFP9tBSFGtnyO5a1sedypDbj
         9sLt1sCqcmti07lntyomqev0i0pxZDoUdJkoc8rs8XwjjfWTNYIxW23VZIvfWCq0lzLS
         3QnfygM5ZPPJhjpTUgG584iBA3igOerNtlu78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PNMBPkOZLTOjGHzj7TrbFcH7DnoXgRnqiGbYIqbL1q4=;
        b=vL5emyj2OaF7ai3tAZ9yi7bkpUcmGU4CP2YBCwSfHku7KPb0LdXse57roN/oBFB0Ga
         oIh9B9K6Rj+ZY//XgKY8+fRyT3RnOI8FG+bokN3WzvcydXGJOse7x8i6rOvA2iyt+MPa
         gWvsWIwKFd4sDv6A1q29WftHHbROi8ppW0lqGt/9fP2ZjdtnWfTJFsWrv3+DYqen9/9m
         BkDrGHhTmpN6JuKXGw29J81SLJteJ94+Tnlg0+h867J0beH9cH/VvLVkOA1or/IyJW8o
         ij9MChptJ4I1Irz5I+QpfFANuOGXn+cilBzj6V/Bbe6/j1AeeXNRNZhelJLgoZInIKxg
         GPLQ==
X-Gm-Message-State: AOAM5326Q8Pw+ua+7VE1JT6cdyoNl3jW6GYQPe1Mmg1QxmA2htoFmqLd
        zb8TDNHaB42lj5Wop7qNQehbDQ==
X-Google-Smtp-Source: ABdhPJwqjW4UK7mVPGEv5vhhpnk4m9IYAQDxyH+VhHu5Np86nXt828Bh4x/umWIjuN85a32RUYKnwA==
X-Received: by 2002:a65:654f:: with SMTP id a15mr4564083pgw.195.1639501720555;
        Tue, 14 Dec 2021 09:08:40 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id b19sm412774pfv.63.2021.12.14.09.08.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Dec 2021 09:08:40 -0800 (PST)
Date:   Tue, 14 Dec 2021 09:08:39 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     paul@paul-moore.com, eparis@redhat.com, linux-audit@redhat.com,
        linux-kernel@vger.kernel.org, wangweiyang2@huawei.com,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] audit: use struct_size() helper in kmalloc()
Message-ID: <202112140908.80D89AC9@keescook>
References: <20211214114854.133328-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211214114854.133328-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 14, 2021 at 07:48:54PM +0800, Xiu Jianfeng wrote:
> Make use of struct_size() helper instead of an open-coded calucation.
> 
> Link: https://github.com/KSPP/linux/issues/160
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
