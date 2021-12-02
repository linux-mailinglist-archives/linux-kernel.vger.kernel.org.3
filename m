Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BF6B465F2F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 09:14:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356055AbhLBIRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 03:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356050AbhLBIRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 03:17:42 -0500
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC7E1C061574
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 00:14:19 -0800 (PST)
Received: by mail-pl1-x629.google.com with SMTP id q17so19648259plr.11
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 00:14:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wJxQPii2eM0OjBaUwzKIAcC+30dSRaA4PHYRb7ql8XY=;
        b=mLsFwzeKWy8lpWdemNEIznpcOmPd8Klm6htYELaEZuTsuz2LVe/lGSQZovS0UxMneQ
         aGgF++CyK5fTIqhwAoV3NN23HmbAVNMp5uTi7ag4pncBHEF54KrCiiXWd11WI9iZuR05
         xGNf7KR3luZ+wTalqKYsf25tGiGVLnI+CcTc8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wJxQPii2eM0OjBaUwzKIAcC+30dSRaA4PHYRb7ql8XY=;
        b=eLBVCZygLf25dC4mWKXoQKiDO3Td9LkPzurbDwrklQzZElJgogcIRMePZ4pmE4q7PN
         0jzI0xei84jpT8M4rN46BmNqsZyf3wTDPqXRd7nV2LttMB/3myjEoGBqYC8Q9JFR+LDm
         ZMqoQ4d9x0jvvs+S1VUbttfSc3ygLOGePRzGMLiaociAl3aAgDsypTXp0RolS1cjd70S
         NmfG+Fvbe+0yYme5uE7hps8OWIzKhGGYrNSlLn7fEf+8XEOvHgxxjro3SKQ5zyR9IIQ+
         p4z000dskIybnilM2Z2Ucavw5tofnQzaRpeCNVAnU9aGmwnoYks17wCSSCz/SBE2tTyo
         guUQ==
X-Gm-Message-State: AOAM530L03GGaHO0pGjejW/+l+L/KxQM5so2xJCnZ0zS239Gf+pnGHfH
        RozKSKKBn7HEoYMDthRtobgz3Q==
X-Google-Smtp-Source: ABdhPJw5UHuID70Zi2x18cwMdDKJ9F7/Xbo83ZPrNqO2xBrXz/vvr5BGHj+4KwiELOwY02vQ4jWicA==
X-Received: by 2002:a17:902:d395:b0:141:a913:1920 with SMTP id e21-20020a170902d39500b00141a9131920mr13872811pld.81.1638432859544;
        Thu, 02 Dec 2021 00:14:19 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y6sm2510371pfi.154.2021.12.02.00.14.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 00:14:19 -0800 (PST)
Date:   Thu, 2 Dec 2021 00:14:18 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     Luis Chamberlain <mcgrof@kernel.org>, Jessica Yu <jeyu@kernel.org>,
        linux-kernel@vger.kernel.org, linux-modules@vger.kernel.org
Subject: Re: [PATCH] module: add in-kernel support for decompressing
Message-ID: <202112020012.8B4C205@keescook>
References: <YaMYJv539OEBz5B/@google.com>
 <202112011112.83416FCA2C@keescook>
 <YafYvA5JWMgb6PVy@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YafYvA5JWMgb6PVy@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 12:19:08PM -0800, Dmitry Torokhov wrote:
> On Wed, Dec 01, 2021 at 11:24:35AM -0800, Kees Cook wrote:
> > On Sat, Nov 27, 2021 at 09:48:22PM -0800, Dmitry Torokhov wrote:
> > >  /* Flags for sys_finit_module: */
> > >  #define MODULE_INIT_IGNORE_MODVERSIONS	1
> > >  #define MODULE_INIT_IGNORE_VERMAGIC	2
> > > +#define MODULE_INIT_COMPRESSED_DATA	4
> > 
> > bikeshedding: adding "_DATA" seems redundant/misleading? The entire
> > module is compressed, so maybe call it just MODULE_INIT_COMPRESSED ?
> 
> OK, or maybe MODULE_INIT_COMPRESSED_FILE since we are indeed dealing
> with a file?

Sounds good to me! :)

As far as my tangent on using the crypto subsystem, I think that looks
like a long path, so your existing routines are likely the right place
to start. I still wonder if it might be able to use of the "acomp" API
instead of calling directly into the specific decompressor.

-- 
Kees Cook
