Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63DC048DD78
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 19:09:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237484AbiAMSI5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 13:08:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbiAMSI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 13:08:56 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AB32C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:08:56 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id j27so540640pgj.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 10:08:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=owfK01Qb37euHxpDEyn3tneo66/v6FhJTLsD0uzW7lI=;
        b=OQT405/Fj+GP8vAYppayq5u8ak3mEhOqp6jTjXyH6XR9Hxtlptd4UxtYhCyZCMZeiW
         R7y5Wlj5czCtRt/TCFB5PiKEPejVWXzbPJkcZVbFm284f1MSN5SXyj0gITJKzeGM0JL5
         xuDwwmwI+0eUuZ8QBmUyudqjTvXjsaHEh4KaU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=owfK01Qb37euHxpDEyn3tneo66/v6FhJTLsD0uzW7lI=;
        b=psLkybfDQKM8RYwNC80H7j5EdA4XnrO1z0nFkpBp0SR16fPHMscHzQwUWh7aPRPfpq
         mVLtUUtRaRgiyjxY+DEWaHBm7pvAVddxqp/u6zkYjWhlyWEaJYNZNutMGS1xTRWsI0MU
         8Rl1h/UWQOiqKpxr3YPaPVGyVRacObUn2OuXdJkEafEkfd0yGuAEMcKg1rgEs4rwoXjt
         E2+CekfzBaN1EuHLWEHdzaML2k6+b+sk9I1Y79ijQrkgmcbl/NHT5siml6kpdIJQDnZY
         GK731ZTUt+a5ujBYUkG8HiSNfus7nRL6B3Lz9BXcmKyH/fPsbijY9L4SVetkkz6RpYIE
         9qJw==
X-Gm-Message-State: AOAM5333d36NLZAAwA9c7tf3mAy3KfZYMlsyjAf37qQJTKS+ECzCFDZV
        fqbEFPqe5YdoBbXvNgYV0DTmcQ==
X-Google-Smtp-Source: ABdhPJztob53LUlDkz5iRoa/0K8XDFaUOgQjQMotK5dltFGHb0sU/EDGQ7r7+SCs8oiIvf8m/pnEyA==
X-Received: by 2002:a63:36c1:: with SMTP id d184mr4827586pga.102.1642097335744;
        Thu, 13 Jan 2022 10:08:55 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k8sm3649361pfu.72.2022.01.13.10.08.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 10:08:55 -0800 (PST)
Date:   Thu, 13 Jan 2022 10:08:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Borislav Petkov <bp@alien8.de>
Cc:     X86 ML <x86@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Eric Biederman <ebiederm@xmission.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86: Remove a.out support
Message-ID: <202201131008.E951797F@keescook>
References: <20220113160115.5375-1-bp@alien8.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113160115.5375-1-bp@alien8.de>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 13, 2022 at 05:01:15PM +0100, Borislav Petkov wrote:
> From: Borislav Petkov <bp@suse.de>
> 
> Commit
> 
>   eac616557050 ("x86: Deprecate a.out support")
> 
> deprecated a.out support with the promise to remove it a couple of
> releases later. That commit landed in v5.1.
> 
> Now it is more than a couple of releases later, no one has complained so
> remove it.
> 
> Signed-off-by: Borislav Petkov <bp@suse.de>

Yes please. :)

Reviewed-by: Kees Cook <keescook@chromium.org>

-- 
Kees Cook
