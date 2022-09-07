Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78D855AFBF3
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 07:51:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiIGFvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 01:51:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbiIGFu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 01:50:59 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E5F95D0D4
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 22:50:48 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id r17so541898ejy.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 22:50:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date;
        bh=485XNaRuLgo/QNXREYEE3jQFUNZFYuPUp6wyA324/uM=;
        b=lXKB2dOByaXJeWp6iOGRoZ4RmLPZsu3HxzhaDnY3VxlB4vCBN7dn35f8/Kl/9WVfZp
         RnVffudQwdTclZc8hX0wTIQ3eNqmQ/74gM+x+8fG1kkqBpBy6mPY35LZJNh1ZW/Ea3k5
         cuJP2GV1youCGhJ4/XV1pgAiMBhenRllw1BzY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date;
        bh=485XNaRuLgo/QNXREYEE3jQFUNZFYuPUp6wyA324/uM=;
        b=nY9We+coqfVDS/B//xap8MY5B0ngiNhQC+ru6qDVaID37PhvBqKGWij1qLKzuztoag
         3/u8mK3MEaFvTY0hnBXm699S8vIuFzZ9z4n2AJYRlzJPDrMWnjBBfZW3IxcxB5usCYXW
         ozqhKirxs17QedbDekFWtJ7cmfEWEcQuvzQS/rjrXHrlH/jTNAHE3tvWtY1yWQRJm19N
         J21C9lsiMls6yYNd7Hy8xnXnJdh4d3abeYkdRRTAICXthOyC/CN/zPcXiZIRkCgU6Us+
         FU6cHfAE8Q91TrxFA/YKqK8d3pxdoXOuqYXxbp8+K1ZfetCciSpU072m8LhaPN21LDgj
         ULNQ==
X-Gm-Message-State: ACgBeo1mYXIgJxZX4h7EnKTa2g5/5gOtQtMffxIhDtoi1wX8juZho8Vc
        MsV2qhI9YddczVjvM8F1wnjkug==
X-Google-Smtp-Source: AA6agR6IS7WtWkmlIgHja/YyJbP8C4ZcmZo3NwhtbPvtpZSOQuctBQnsweC1nqC8Sxd6HQmJa9tQkQ==
X-Received: by 2002:a17:907:2e01:b0:731:1eb0:b9ff with SMTP id ig1-20020a1709072e0100b007311eb0b9ffmr1237025ejc.728.1662529846962;
        Tue, 06 Sep 2022 22:50:46 -0700 (PDT)
Received: from phenom.ffwll.local (212-51-149-33.fiber7.init7.net. [212.51.149.33])
        by smtp.gmail.com with ESMTPSA id eh13-20020a0564020f8d00b0044f0c01196esm887979edb.65.2022.09.06.22.50.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 06 Sep 2022 22:50:46 -0700 (PDT)
Date:   Wed, 7 Sep 2022 07:50:44 +0200
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
Message-ID: <YxgxNPYl5LhKpHrk@phenom.ffwll.local>
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
 <YxgwdGtNTnDdIqAv@phenom.ffwll.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YxgwdGtNTnDdIqAv@phenom.ffwll.local>
X-Operating-System: Linux phenom 5.18.0-4-amd64 
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,NO_DNS_FOR_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 07:47:32AM +0200, Daniel Vetter wrote:
> On Tue, Sep 06, 2022 at 08:35:49PM -0300, Igor Matheus Andrade Torrente wrote:
> > On 9/6/22 18:26, Sudip Mukherjee wrote:
> > > On Tue, Sep 6, 2022 at 4:59 PM Sudip Mukherjee (Codethink)
> > > <sudipm.mukherjee@gmail.com> wrote:
> > > > 
> > > > Hi All,
> > > > 
> > > > The builds of next-20220906 fails for mips, xtensa and arm allmodconfig.
> > > > 
> > > > The errors in mips and xtensa are:
> > > > 
> > > > ERROR: modpost: "__divdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > ERROR: modpost: "__udivdi3" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > 
> > > > The error in arm is:
> > > > 
> > > > ERROR: modpost: "__aeabi_uldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > ERROR: modpost: "__aeabi_ldivmod" [drivers/gpu/drm/vkms/vkms.ko] undefined!
> > > > 
> > > > 
> > > > Trying to do a git bisect to find out the offending commit.
> > > 
> > > git bisect points to 396369d67549 ("drm: vkms: Add support to the
> > > RGB565 format")
> > 
> > Are these architectures incapable of doing 64bits int division?
> 
> Yeah 32bit archs in general can't do that, and you have to use the right
> macros because otherwise gcc falls back to its own built-ins, and those
> don't exist in the kernel since the kernel isn't (cannot!) linked against
> any userspace library.
> 
> For pretty much this reasons it's really good to build test against 32bit
> x86, or probably more relevant these days, 32bit arm.

Forgot to add: include/math.h for all your division needs.
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
