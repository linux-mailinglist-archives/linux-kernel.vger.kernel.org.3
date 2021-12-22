Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103CD47D676
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 19:22:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344595AbhLVSWG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 13:22:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233546AbhLVSWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 13:22:00 -0500
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 595C5C061574;
        Wed, 22 Dec 2021 10:22:00 -0800 (PST)
Received: by mail-qk1-x730.google.com with SMTP id m2so1521052qkd.8;
        Wed, 22 Dec 2021 10:22:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BGQG7MpUuO8Dn90FzY+KF2Mpbosynn3yvRmxHyLir74=;
        b=C973QPlhrs2ni/3VmkHzXswwW8Ao6y2tR7Dx/6m6zUL3M+H90aJzPqialTN3dzZ5wR
         1hFBzjDUIpbJt58axomcuBPkS7xYmAx24DFvjFjxZl3MxQPg4vcPFjCQycmwZhvfxVQI
         Cudi1zPDrJSuareaelfBVyPmcs9NeG/uR95KOwxjoLeGEzDmlbHEpqtgxp8l6kBS2x1O
         zP9UGRV1Z2m7zqrz5CXqXEejX/H/nSWsxpSL7NtVjSi6Nvkn9fWFRgCE29ZRlrNXzk9W
         h8Om8ptnjYO+L0bT4CG5b6g9PBXvW5Lfp8Wy3FLzq085IBukwTTAkKvya4IvQZ+1iKvC
         q6Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=BGQG7MpUuO8Dn90FzY+KF2Mpbosynn3yvRmxHyLir74=;
        b=SFjhCAY59Zhqn8b5Pu0o+SKkyFeH5acP79Ay/lxSGw/Wd5z0HjTQ/D7cvQhN7kUAnQ
         1g3HsYU2jTgLXxh/TwHSgZKiOWUPOBe0PJrG/kDSm5Quuf+wo/ppimuicyXqtvs5sy4Y
         lIVhOjqd9PuvQhKX6MCod8etUdMli92TtepJ3zCkgAw3QAgtzcuLX36ku581D+aHCp0/
         lJKqDAhOtWyCJS4bahT6OuVb3D4lAGyLYLp0MmtD87zEF/BbIKGCswbdIaYHK35DUy/o
         VuFtxzmoGNYZ8sUYz8y+c4JcBJaBMdupsVbCq7RH2kXTOub8pWfwF6IyAPQXG0aQjSNE
         4WXg==
X-Gm-Message-State: AOAM531N2/OoDaIhuIAheNiAVTz0iUMFPDU60x1BRo5w5ECMfopq7OrF
        45eqnYh3GkTnpW0zWl0SWR05UbxL1hk=
X-Google-Smtp-Source: ABdhPJzqukMloJR9MENOryu0ylESrjEf+RNFDMK1zRdsXFTrq1qcz3N7PooF4aYec1ylNFFX8ik6Fg==
X-Received: by 2002:a05:620a:21cc:: with SMTP id h12mr2278606qka.319.1640197319562;
        Wed, 22 Dec 2021 10:21:59 -0800 (PST)
Received: from shaak (69-165-204-82.cable.teksavvy.com. [69.165.204.82])
        by smtp.gmail.com with ESMTPSA id bm25sm2526307qkb.4.2021.12.22.10.21.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Dec 2021 10:21:59 -0800 (PST)
Date:   Wed, 22 Dec 2021 13:21:56 -0500
From:   Liam Beguin <liambeguin@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Peter Rosin <peda@axentia.se>, Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v11 07/15] iio: afe: rescale: use s64 for temporary scale
 calculations
Message-ID: <YcNsxNPWY4lc/PHf@shaak>
References: <20211222034646.222189-1-liambeguin@gmail.com>
 <20211222034646.222189-8-liambeguin@gmail.com>
 <CAHp75VciEd55KfQQ6VdK84-uufO-N5k0TLrvv9tn7-wj3n=Bug@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VciEd55KfQQ6VdK84-uufO-N5k0TLrvv9tn7-wj3n=Bug@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 22, 2021 at 02:25:31PM +0200, Andy Shevchenko wrote:
> On Wed, Dec 22, 2021 at 5:47 AM Liam Beguin <liambeguin@gmail.com> wrote:
> >
> > From: Liam Beguin <lvb@xiphos.com>
> >
> > All four scaling coefficients can take signed values.
> > Make tmp a signed 64-bit integer and switch to div_s64() to preserve
> > signs during 64-bit divisions.
> 
> Sounds to me like a fix with all necessary stuff needed about it:
> - Fixes tag
> - moving to the beginning of the series, where other fixes are

Will do

> -- 
> With Best Regards,
> Andy Shevchenko
