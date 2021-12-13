Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 918BC473625
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 21:39:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242991AbhLMUja (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 15:39:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242303AbhLMUj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 15:39:29 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 169BFC061574
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:39:29 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id k64so15954275pfd.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Dec 2021 12:39:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7U7SpVhaJqlRekCkuqabbataiuHulOV/UqdyZUkTKpI=;
        b=BbJA6E5ZKpt0snCX6tizQXaWuNHrLvnWhQKUykkvcxslCMelZ6/QA2cgvBM4MAB7wO
         3It3dRHtbHE2Sp5vbdjmTHwzWl9CT9/thqOA/LO/pvXZcncH6Rb4JHZUactkoS+xfc5P
         odch4+K+IeG0JSNQb7Q68K6UQPSsni0WbRe7Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7U7SpVhaJqlRekCkuqabbataiuHulOV/UqdyZUkTKpI=;
        b=fYUM1uxelxjQvRgDBrWw/1sAOr/FW84aal+eugAjFqUd57rz7YLOCYh51xLJ0hZC3q
         21VT4dTeD3ZbCypSMC9sVqi4DUfDXerEE4qXEQM0Tp0Aunwz99VRI4jCxgUGq9D5Xqb1
         6Rimi0VP59+REB6iAv4owdde9ChObkAGiOplwlJPJF+QQIgXGC3DCwxFFqkevdosI7Uk
         321X5Kz2e1rDxXm9z2CD0youzAUzboNdNk7HI2RoQpDyjDhAa6Q10+Ut2EahvOma7uep
         D9dp6Tj2xplLabAyAeVDJSY2Ex7hEgv7NyaVB8X53N+PtelWe9RNXcP8prwmrT6aUwZM
         RCMA==
X-Gm-Message-State: AOAM531cXVmLIxQ6+1CnXAOEuEMKp4//HwbcNnBl3AXdvhM+eVGxkdZO
        7hbI8c0LRsO89hN4cAr1jaIBAg==
X-Google-Smtp-Source: ABdhPJyIyDeOWFkaqyO4+QH72bHsH32NTFAnedf0kYCNhGtwwk18QXAZwRlLjFj0ymScsj90CRDMiw==
X-Received: by 2002:a63:4b11:: with SMTP id y17mr703577pga.214.1639427968693;
        Mon, 13 Dec 2021 12:39:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z2sm13252828pff.107.2021.12.13.12.39.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Dec 2021 12:39:28 -0800 (PST)
Date:   Mon, 13 Dec 2021 12:39:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Xiu Jianfeng <xiujianfeng@huawei.com>
Cc:     peterz@infradead.org, mingo@redhat.com, will@kernel.org,
        longman@redhat.com, boqun.feng@gmail.com, wangweiyang2@huawei.com,
        linux-kernel@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Re: [PATCH -next] lockdep: Use memset_startat() helper in
 reinit_class()
Message-ID: <202112131239.7BB7563C80@keescook>
References: <20211213132618.105737-1-xiujianfeng@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211213132618.105737-1-xiujianfeng@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 13, 2021 at 09:26:18PM +0800, Xiu Jianfeng wrote:
> use memset_startat() helper to simplify the code, there is no functional
> change in this patch.
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
