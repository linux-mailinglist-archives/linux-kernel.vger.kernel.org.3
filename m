Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6575B4CC3B7
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 18:28:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235351AbiCCR26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 12:28:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231445AbiCCR2z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 12:28:55 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 616D928E24
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 09:28:08 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id c16-20020a17090aa61000b001befad2bfaaso5009733pjq.1
        for <linux-kernel@vger.kernel.org>; Thu, 03 Mar 2022 09:28:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ucEA3J1ya4GRs+I0A0pxTRPbekYvscFzYo/razXDByg=;
        b=Z0uYSem8nCEuzkLQw4trl/0KBRyeSAZdP+h9TK9qjKeFB7hJVjfN6qYzPVvZCWUsix
         GMKeMh8GMvp1HIO4vK85RsmY2JcqYXSfEt2sL2d1pZ+tAnb+3/NLiEJKmLTsBn2QYk8M
         UaCwZ/3Z1UXG/seNFK/fjDU0v04eieZak7kLA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ucEA3J1ya4GRs+I0A0pxTRPbekYvscFzYo/razXDByg=;
        b=dS24RZ2U4qd4DbGi2zUIp+Y1ZSist10SlSuh4Zqsggeohq6286iTdIndREDgfEHCN5
         dJtKpv5k+EIfA2fVdiWJORaJ/cMJ8oLfGbEItnuBUF+oJhre+M5O9tkvw6G414kuAGoG
         Rbox/xwFTPO6AJhI2bnnOwFBjuEWlNN0HNsVU8JmQ++jKsKSqoMnluTTHyKBGS3F9pzj
         l/WR9IyMjqO9FDINz94t4B9JUAzQJwIs4+owoHtTxIpR1uO9mNrBBhITOEAWa0fLAuG7
         BKvSEU+1oY8ELU3VhZPCGauvGZQDhGJEI82WtljtxAvV5uMI8RA8/kK+hgP5tWZVEA9O
         3/uQ==
X-Gm-Message-State: AOAM533rAhhLWdmEw7RVHY+T3MzP7mzBqzUIr+kjdJ0La2BZoJsanpDu
        L6VTh4X3oucof/fU3yXniYxsxg==
X-Google-Smtp-Source: ABdhPJy2mzFw4jO2AzK0JYWGiB+koyjvh1Dy0wGqm4Vkn9fhv16PKbXZ5sesO86D7nyMcNXd9iCe1Q==
X-Received: by 2002:a17:902:d4cc:b0:151:3857:817b with SMTP id o12-20020a170902d4cc00b001513857817bmr31774133plg.139.1646328487821;
        Thu, 03 Mar 2022 09:28:07 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id s9-20020a056a00194900b004e1583f88a2sm3050692pfk.0.2022.03.03.09.28.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Mar 2022 09:28:07 -0800 (PST)
Date:   Thu, 3 Mar 2022 09:28:04 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     David Gow <davidgow@google.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Vitor Massaru Iha <vitor@massaru.org>,
        Daniel Latypov <dlatypov@google.com>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>,
        linux-kbuild@vger.kernel.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        llvm@lists.linux.dev, x86@kernel.org,
        linux-hardening@vger.kernel.org
Subject: Re: [PATCH v3 7/7] UAPI: Introduce KUnit userspace compatibility
Message-ID: <202203030927.2D794F4@keescook>
References: <20220227184517.504931-1-keescook@chromium.org>
 <20220227184517.504931-8-keescook@chromium.org>
 <CABVgOSn6Oe8Ke=fnuVwgLh2r8HKjBW8pCe44Z35Qo1bVfz9A-A@mail.gmail.com>
 <YiC9NBjFgGv5T+gF@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YiC9NBjFgGv5T+gF@kroah.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 03, 2022 at 02:05:56PM +0100, Greg KH wrote:
> On Thu, Mar 03, 2022 at 04:27:13PM +0800, David Gow wrote:
> > On Mon, Feb 28, 2022 at 2:45 AM Kees Cook <keescook@chromium.org> wrote:
> > > diff --git a/include/uapi/misc/kunit.h b/include/uapi/misc/kunit.h
> > > new file mode 100644
> > > index 000000000000..afdffda583ae
> > > --- /dev/null
> > > +++ b/include/uapi/misc/kunit.h
> > > @@ -0,0 +1,181 @@
> > > +#ifndef __UAPI_MISC_KUNIT_H__
> > > +#define __UAPI_MISC_KUNIT_H__
> > > +/*
> > > + * This is a light-weight userspace drop-in replacement for the in-kernel
> 
> <snip>
> 
> Someone forgot a SPDX license line for the new file.  Didn't checkpatch
> complain about this?  :(

Yeah, that file has a bunch of problems. ;) The UAPI header checking
logic also freaks out, etc, etc. I'll being fixing that and the other
issues.

-- 
Kees Cook
