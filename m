Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 28E75486DAC
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 00:23:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245456AbiAFXXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 18:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234795AbiAFXXw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 18:23:52 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C6E5C061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 15:23:52 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id 205so3786496pfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 15:23:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=tA6UK24AjxIZbFxR8bfz/TxU3vWQsg6ckR6coRFMG9M=;
        b=hpqplUo9NjouO1Uj3U3bTzajcYggQzKmWFru89eqsz9f5u1Peh4w1SJiVhTz8GId2h
         b2jESvhCWATWnf/bGxEIVV2c80pnBKhgnKqSvteuQMtIzwEnriEWQKdYQ26+J73rm1KK
         h/IoHYX5zWfyTl5/M2nPICXemTvSH/f4kQBxX+FkhnLq701WrzqudFEJU61jDXuRPXkp
         Kla8GUuZACOR45U8GoVpI4gqU22nnEC07VaPHpULxKIxD2jDGe/JpRwGa+OWL6P1Rw4l
         nxCq6CuV0NaYDqaQ7+bKMNrbnWvXDnCdsWSqQQ5FlRsiTMplDyH9yBWZBi+4NXqwyVIa
         Omsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=tA6UK24AjxIZbFxR8bfz/TxU3vWQsg6ckR6coRFMG9M=;
        b=XctJG3yHKHt2mZWd+kOXb/VgnlkR6yGRPs1sln5xCWnj0WWuE3DZQa2GihA27JoE3V
         6wB7m93Gl3ibnj6R/d01N7hVSMOlMWtbHe6fNEPp2mBBERviBMCq8mOwC6fOhxms+6Mk
         yjNnuaJ+BWhccZu2Kwp5jkOuJRAlIEtU0Wzuo4NHP8a4KI9brUYwa9McqteJrkb5sh6c
         DHerHtNF17iB5svQYZGxSA4lMi94qIFX3SyVG1PgmSCjAcgrboKIy7mbFBYd7m+i7MhW
         8KUSa9Nk6tJ//nXZ0Rq/y552UV+iVg5nsrj/MzDf7tr1QV1GG7FhS72uZNz7njEaWtuh
         M0sg==
X-Gm-Message-State: AOAM532W2+s6QBvH2+6CUpZF59EvDB1pcqOArI37vyHnUmddFPklIw0v
        2AP2LDXStcgXvFW0s7WAfFU=
X-Google-Smtp-Source: ABdhPJzLjNEAnwHzhwbXnJoVtPzugA8gFSrPCQmEtpnU8iJMKCVbIym3jojydUwKQyOgfeulw1Pucw==
X-Received: by 2002:a63:3509:: with SMTP id c9mr51184737pga.332.1641511431800;
        Thu, 06 Jan 2022 15:23:51 -0800 (PST)
Received: from szeter (n220-236-173-54.sbr3.nsw.optusnet.com.au. [220.236.173.54])
        by smtp.gmail.com with ESMTPSA id i17sm3424104pfk.44.2022.01.06.15.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 15:23:51 -0800 (PST)
Date:   Fri, 7 Jan 2022 10:23:07 +1100
From:   Samuel Zeter <samuelzeter@gmail.com>
To:     Nathan Chancellor <nathan@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 0/2] *** Fix reformat_objdump.awk ***
Message-ID: <Ydd522/ivtZunIXl@szeter>
References: <20220106023606.283953-1-samuelzeter@gmail.com>
 <Ydc8wUjX4hnHg7ZE@archlinux-ax161>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ydc8wUjX4hnHg7ZE@archlinux-ax161>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for the feedback, Nathan.

> For the future, I recommend putting the maintainers in the "To" field,
> rather than "Cc", to ensure they actually see it. Additionally, I see
> some small nits in the commit message that the tip maintainers might
> comment on, see
> 
> https://www.kernel.org/doc/html/latest/process/maintainer-tip.html#changelog
> 
Thanks for the link, I missed that one. What were the nits apparent to you
in the commit message?

Sam.
