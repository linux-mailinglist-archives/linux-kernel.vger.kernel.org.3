Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 15D1F4956F0
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 00:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244278AbiATXXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 18:23:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiATXXh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 18:23:37 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95279C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:23:37 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id w12-20020a17090a528c00b001b276aa3aabso12040611pjh.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 15:23:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=lduCeOqPdSTlCLiMlTMlBr0TrHGcn0qNkeRoiqzXtfY=;
        b=Tagcjltxo0I0fKDczR2ACgPLHMs3KryA/yK5fII/qCYbLC7DaQfWzu3vZ0RSeSEiAF
         NyVkTlt1UDl/h8adLLt0YYKrxJ3ibYWoukquSdkv7P/RPG7vWmOk/Qw+cf9ipSogVY27
         0mPk5B1yGWcfPI7YS1wAtGS22rHM5k3Yp1uUM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=lduCeOqPdSTlCLiMlTMlBr0TrHGcn0qNkeRoiqzXtfY=;
        b=0v7ex/feeUY7La+5bGSx01J/H/wketqUBnvCHOXk9rLie1oVJg6ICvX9z8/UhJ4XEQ
         +uO1wVjJsbb1SbP6ulbUyc2aflJwEF++V5EcQB7AWGZCy+G/8qq4ikq/xAEuoFEmCCBt
         ni7t69ryTaYsIVIYFNeqiGin3FdZwrjKrzmRaYyq7cGlg+QXbHd6CAlj3lVWzqDhpY2O
         iuT3a6is4k3+mkHwvai9ac7fAPy0RRJwHM/qOySQtZ1OLZr1sSt8LcYhPvquQALkp9ae
         LF21e5Ufsc4KjDfSzIdzt0TafLx2Y9AYMtHwiGlSEH6nNKhV2BKEva33xOhDNQNMRxbb
         6thA==
X-Gm-Message-State: AOAM532LxduoT95SImzCmRwrQC1JJ1Ew+d+HXMxSFdjfX7Ix3F0Z+1/q
        8UFJzL46ncNCNMydbWLgFt3/Qg==
X-Google-Smtp-Source: ABdhPJwufFh4eVcPYvGSPoZKSaXE7v6aGiTtmnW3kUWA081zSJz5fs8kHlDamGxEGn8AOy2r8M1j2Q==
X-Received: by 2002:a17:902:d509:b0:14a:fbb1:86c3 with SMTP id b9-20020a170902d50900b0014afbb186c3mr1066845plg.78.1642721017197;
        Thu, 20 Jan 2022 15:23:37 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id v4sm4438260pfu.202.2022.01.20.15.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 15:23:36 -0800 (PST)
Date:   Thu, 20 Jan 2022 15:23:36 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     Johan Hovold <johan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH][next] USB: serial: ti_usb_3410_5052: Use struct_size()
 helper in ti_write_byte()
Message-ID: <202201201523.9751D119@keescook>
References: <20220120213131.GA32119@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220120213131.GA32119@embeddedor>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 03:31:31PM -0600, Gustavo A. R. Silva wrote:
> Make use of the struct_size() helper instead of an open-coded version,
> in order to avoid any potential type mistakes or integer overflows that,
> in the worst scenario, could lead to heap overflows.
> 
> Also, address the following sparse warnings:
> drivers/usb/serial/ti_usb_3410_5052.c:1521:16: warning: using sizeof on a flexible structure
> 
> Link: https://github.com/KSPP/linux/issues/174
> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>

Looks good.

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
