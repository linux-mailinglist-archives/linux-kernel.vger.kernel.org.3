Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0BC489E86
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 18:39:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238474AbiAJRi7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 12:38:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238197AbiAJRi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 12:38:57 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFFA0C06173F
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:38:56 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id e5so9303627wmq.1
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jan 2022 09:38:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=xmz/AVm2b65EMdhMR5w60JDXhN2SbhtQinseC44HFwg=;
        b=gKpTw5X2aIDIm2OQ32vcb3T/B6cBXsYNlTbg59TBnarzkHWId0PhllEO0NIVdnBVCp
         OpJ3oN7wuN9JfsKKdb11ufTktWDVW2kh5+2iOuajRhGJmdxPIfEdYSwmhHxqpp0Ey88d
         87qZrTlyR2+IkZxNCGasOUVaXgxGMMete5sYQMgfBdIb7Uy3SwNa9pTa3R+25zSdtGK0
         XINCUOfQj55UDjNdcvD0ySp2v5dtPGSJuPhudsBcYezs+IKptJVBipaRe/GinLL2/BwX
         sD4HcQWGqIftRPeKOZrTSg4wAc+n5O9NxlJgWVgVobZmiS/jy90wPZwz5rDEKML9S1wi
         ugaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=xmz/AVm2b65EMdhMR5w60JDXhN2SbhtQinseC44HFwg=;
        b=ljA6dyV43WSKpLYexJMdna3F7Uj2kJb+lhJtwsiZWf1foUamEvKInFQJBysqGlaGSo
         YCwaQZdzMdGiA1FGGTulJEPQyOwGX+mx5GvgRNYQsgmu27ERrdoPVtmA+hfgPi9dOzYh
         d9QJ1jgfRTdWO2QFpohVo1lz8D0RDI03ugJkWTE+jpSGpRISoX6yJoi7lxPzO2vxMBSh
         GBJb95P7nEftl7NL5P51//2q7kPDyPYaSYpm2m3luQvD/9PvoUBNJF3swOAE2fcCm6FS
         nZTmfwSXXZaU6CtkNWgfRBOFG2Duu4J7x8gcXLSCeQutBDo6Ftz16FaRmuOdAhnRHsIG
         E6fA==
X-Gm-Message-State: AOAM531uLjoU7Y43OIR8JHiMsZpMh1qmQ/uWDzGN69PobB32QoP1Qy0R
        xEQNEGz9lGhzEMjXxFt5w4dgeQ==
X-Google-Smtp-Source: ABdhPJx4Zi50awrry1dqRyh2S33+cqRYmOAZJT9VAHZ53hbiauH0SbTW3I+AytzweGOZBwYFpodJ6Q==
X-Received: by 2002:a05:600c:3783:: with SMTP id o3mr476146wmr.74.1641836335273;
        Mon, 10 Jan 2022 09:38:55 -0800 (PST)
Received: from google.com ([2a00:79e0:d:210:927:9b4:58f8:3bfa])
        by smtp.gmail.com with ESMTPSA id u16sm7109466wrn.24.2022.01.10.09.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 09:38:54 -0800 (PST)
Date:   Mon, 10 Jan 2022 17:38:54 +0000
From:   Matthias Maennich <maennich@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Miroslav Benes <mbenes@suse.cz>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Jessica Yu <jeyu@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Subject: Re: [PATCH] export: fix string handling of namespace in
 EXPORT_SYMBOL_NS
Message-ID: <YdxvLkrVJA/oXyhM@google.com>
References: <20220108140415.3360088-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220108140415.3360088-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 08, 2022 at 03:04:15PM +0100, Greg Kroah-Hartman wrote:
>Commit c3a6cf19e695 ("export: avoid code duplication in
>include/linux/export.h") broke the ability for a defined string to be
>used as a namespace value.  Fix this up by adding another layer of
>indirection to preserve the previous functionality.
>
>Fixes: c3a6cf19e695 ("export: avoid code duplication in include/linux/export.h")
>Cc: Miroslav Benes <mbenes@suse.cz>
>Cc: Emil Velikov <emil.l.velikov@gmail.com>
>Cc: Jessica Yu <jeyu@kernel.org>
>Cc: Quentin Perret <qperret@google.com>
>Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
>Cc: Matthias Maennich <maennich@google.com>
>Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Reviewed-by: Matthias Maennich <maennich@google.com>

Cheers,
Matthias

>---
>Note, I found this while forward porting an out-of-tree Android kernel
>patch from 5.4 to 5.10 that used module namespaces to help wall-off vfs
>symbols from being used by non-filesystem modules.  This issue does not
>affect any in-kernel code, so I am not so sure if it really is needed
>here, but it does restore the previous functionality that was being used
>in older kernels so it might be good to put back in case others want to
>do much the same thing.
>
> include/linux/export.h | 6 ++++--
> 1 file changed, 4 insertions(+), 2 deletions(-)
>
>diff --git a/include/linux/export.h b/include/linux/export.h
>index 27d848712b90..9a992809f57d 100644
>--- a/include/linux/export.h
>+++ b/include/linux/export.h
>@@ -162,8 +162,10 @@ struct kernel_symbol {
>
> #define EXPORT_SYMBOL(sym)		_EXPORT_SYMBOL(sym, "")
> #define EXPORT_SYMBOL_GPL(sym)		_EXPORT_SYMBOL(sym, "_gpl")
>-#define EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", #ns)
>-#define EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", #ns)
>+#define _EXPORT_SYMBOL_NS(sym, ns)	__EXPORT_SYMBOL(sym, "", #ns)
>+#define _EXPORT_SYMBOL_NS_GPL(sym, ns)	__EXPORT_SYMBOL(sym, "_gpl", #ns)
>+#define EXPORT_SYMBOL_NS(sym, ns)	_EXPORT_SYMBOL_NS(sym, ns)
>+#define EXPORT_SYMBOL_NS_GPL(sym, ns)	_EXPORT_SYMBOL_NS_GPL(sym, ns)
>
> #endif /* !__ASSEMBLY__ */
>
>-- 
>2.34.1
>
