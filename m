Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D0884B5AC6
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 20:59:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229605AbiBNT5u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 14:57:50 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiBNT5p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 14:57:45 -0500
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B83C4182072
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:57:34 -0800 (PST)
Received: by mail-oo1-xc35.google.com with SMTP id i10-20020a4aab0a000000b002fccf890d5fso20602798oon.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 11:57:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=B3WRB1YL+L5+JbxjEZnwA++AmlGgE13EuGL+PRtHx8Q=;
        b=AG59o1FvNvGvpQjnEKK7YIua4+FGo7zkXCx11iAZy3iRr1cIHX4gAGKMYtlr+uUtkK
         vQ/XbgHjhIMTeqSRSpp3SphCTkg1b1RZgd7SdlkMgl0tVADRCb97t7zFbMb3q+qwalUh
         5mFP3ayooEfBQKfTTG8fK2M/3Zk7Sn+qMMyZE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B3WRB1YL+L5+JbxjEZnwA++AmlGgE13EuGL+PRtHx8Q=;
        b=VisHdv8bRA81l312VQ21z5r3kQCgSnGX2oZlY4NrZEZ/l3xMVlnfikNJ45GVRo51wF
         h2PoWhCz7NEa0YsWgqLjVP8zPcAf4cgyqkZfiUbQDNfL3KzWoglQve7pdUYjBoQZtWkI
         OhF8aFfA3H6kQpVi/f5K0a2nc0hIOJEV0EvW+eBdWp4QOdFbYdbGg2bV++a2q9AVJOiR
         atCwstDjUD7qZf3Dx7HsQDgMZbHNf+GTb48nf90VaCOVPXTjgy04umZWrksDL+MteX97
         PM31MDX1fsGUlByvVsCM8ZCS5uxzO/nnUDxTXHQO23ZnsGuGhA4OwtB7Hf758N//0pFU
         MXsQ==
X-Gm-Message-State: AOAM533zS6+lRt6r+6BBxD9oEh4WMmKGjAfwS/B5fE/SH2IY1ILmAB+X
        OAfn/wurittqqdaNWgzDHmQpVM3kJcMxhQ==
X-Google-Smtp-Source: ABdhPJy+kZEHNiyZXB8hQH3+c79ZYEF67uFWvHkrb/jUovgvh6gYuF9jGI1/GqjQlyBi5+IQy5S5qQ==
X-Received: by 2002:a17:90a:688e:: with SMTP id a14mr132426pjd.63.1644866725061;
        Mon, 14 Feb 2022 11:25:25 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id c4sm25662839pfl.131.2022.02.14.11.25.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Feb 2022 11:25:24 -0800 (PST)
Date:   Mon, 14 Feb 2022 11:25:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>
Cc:     Shuah Khan <shuah@kernel.org>, kernel@collabora.com,
        sherry.yang@oracle.com, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2] selftests: Use -isystem instead of -I to include
 headers
Message-ID: <202202141125.085DF9BA6@keescook>
References: <20220214160756.3543590-1-usama.anjum@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220214160756.3543590-1-usama.anjum@collabora.com>
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 09:07:56PM +0500, Muhammad Usama Anjum wrote:
> Selftests need kernel headers and glibc for compilation. In compilation
> of selftests, uapi headers from kernel source are used instead of
> default ones while glibc has already been compiled with different header
> files installed in the operating system. So there can be redefination
> warnings from compiler. These warnings can be suppressed by using
> -isystem to include the uapi headers.
> 
> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
