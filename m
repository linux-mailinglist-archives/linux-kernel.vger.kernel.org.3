Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86C6B5AFBEF
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229620AbiIGFrr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:47:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbiIGFro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:47:44 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177D066111
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:47:36 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id r17so530720ejy.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:47:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=YtQGFFP4vhfdUxZhJrZK2jqmDRC5K71pRjy06kzufEA=;
        b=D4MSYe3HuhjfTCnhlWTUWIOL1gN6qSsC/IeXJ+WxDvobPcnhhWhthaLWp0Je7KM9C9
         xxNzLsp/6fSpM6Eo3j+14h/npT0wAePR8BbgHcgnA0v9OHztxQZcZ2kh5hfdkdywI7gT
         OoVvmsCvGYfkaVg+Um+yGHT49wN9zNqGX2DyA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=YtQGFFP4vhfdUxZhJrZK2jqmDRC5K71pRjy06kzufEA=;
        b=VdzkRslBIW3mSH5QKVzDW6CMXROsi+N+ZHoV6aUup99qlfZZXQXj1Tvj6LliiJf2bn
         T3/qPvJ5KG6LJBQBMmAjAfM9BiuVJWzpiMrz3F9dyTbPVy70LJqtP8bW30cXZSDPvIIF
         3zoheCFLcYE7cYefAYfXpv96C1C16NL+rH333BwcXV0YP0WQFsHxSI3RmVCkbm5Nt7gI
         RQEKh48b+b2QU3HqiPBKMQLABCZs71em4DaKkhbCMNjBNutRAG5962Y55kjZyugZzoGm
         lskah+fcjMR8StcPNvoEjsaUZ/A7fCUH5EjnYiPh9uuDHAv1LtL+s9Iufxcat5YUDOm6
         ZiRw==
X-Gm-Message-State: ACgBeo1tzafXU7kmxKWln7VYwFPxn/fo9o+jtYFqnOMMNKgXhGbenzra
        rpRSTdXy9uGYtTr6MUVgQSI/YQ==
X-Google-Smtp-Source: AA6agR6l0Nv5Ojf99/mgkxk+bfFH+4lR+cupi/L8llhX+dNx0PezxjkLx3qkT51MqwmWQ0AJP9vECQ==
X-Received: by 2002:a17:907:6d8a:b0:73b:d9e4:e628 with SMTP id sb10-20020a1709076d8a00b0073bd9e4e628mr1189348ejc.75.1662529654688;
        Tue, 06 Sep 2022 22:47:34 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062d4a00b0073dafb227c0sm7799536eji.161.2022.09.06.22.47.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 22:47:34 -0700 (PDT)
Date:   Wed, 7 Sep 2022 07:47:32 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Igor Matheus Andrade Torrente <igormtorrente@gmail.com>
Cc:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
Subject: Re: build failure of next-20220906 due to 396369d67549 ("drm: vkms:
 Add support to the RGB565 format")
Message-ID: <YxgwdGtNTnDdIqAv@phenom.ffwll.local>
Mail-Followup-To: Igor Matheus Andrade Torrente <igormtorrente@gmail.com>,
        Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Melissa Wen <melissa.srw@gmail.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Rodrigo Siqueira <rodrigosiqueiramelo@gmail.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-next <linux-next@vger.kernel.org>,
        David Airlie <airlied@linux.ie>,
        Haneen Mohammed <hamohammed.sa@gmail.com>
References: <YxducgSzR6/zyHD7@debian>
 <CADVatmNfc1YT02v5-FaMoGN==MOx5ZJ=o8YMQAH19Gvf91betA@mail.gmail.com>
 <8e4350df-0c73-6ca2-a25f-28a40a1856db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8e4350df-0c73-6ca2-a25f-28a40a1856db@gmail.com>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 08:35:49PM -0300, Igor Matheus Andrade Torrente wrote:
> On 9/6/22 18:26, Sudip Mukherjee wrote:
> > On Tue, Sep 6, 2022 at 4:59 PM Sudip Mukherjee (Codethink)
> > <sudipm.mukherjee@gmail.com> wrote:
> > > 
> > > Hi All,
> > > 
> > > The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.
> > > 
> > > The errors in mips and xtensa are:
> > > 
> > > ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > 
> > > The error in arm is:
> > > 
> > > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > 
> > > 
> > > Trying to do a git bisect to find out the offending commit.
> > 
> > git bisect points to 396369d67549 ("drm: vkms: Add support to the
> > RGB565 format")
> 
> Are these architectures incapable of doing 64bits int division?

Yeah 32bit archs in general can't do that, and you have to use the right
macros because otherwise gcc falls back to its own built-ins, and those
don't exist in the kernel since the kernel isn't (cannot!) linked against
any userspace library.

For pretty much this reasons it's really good to build test against 32bit
x86, or probably more relevant these days, 32bit arm.

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
