Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3987C464C99
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 12:31:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348274AbhLALej (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 06:34:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233238AbhLALd6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 06:33:58 -0500
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D64F9C061574;
        Wed,  1 Dec 2021 03:30:32 -0800 (PST)
Received: by mail-pg1-x536.google.com with SMTP id l190so23273078pge.7;
        Wed, 01 Dec 2021 03:30:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :user-agent:mime-version:content-transfer-encoding;
        bh=dL2z4oREQdf8pZHNdec+/B6oXD8rfZzVKjnWJlVoW7U=;
        b=Hnf789KxSxQqKdQmI5TCb23Bq9Lxa/dECuDLWVrOCBa6ng00E9ywwuShEvbkiwuaES
         AAKwJHCtXLLvf/mCUceoSiRG+ojlU2Y249nhJJv9l1NfFqS+sgEH9GoCxyuLrG6s5Qa6
         J965EHu5DTMsB2oO3eawNc2TRiX0RHAOMwdKxLdi7fjV51qBuDCtodygj8PG+Cazl7sZ
         PlhQp+NeiUq8bhgDAlLFFsw1XFWIOKmBm8tryixeWFyCajYJ7NhpnorkvYu4k+O4KlCd
         w7VHK8osgSsRtD1R955ylLBSIVtqqFH1BLr/OD7cIRSVB2FE+wGsBTmEm/caI+KarJIh
         HV9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=dL2z4oREQdf8pZHNdec+/B6oXD8rfZzVKjnWJlVoW7U=;
        b=79txRsYBk+j49j8RgHs/x5EqjBKvJJWlREjjo2QbNzqEFxsLsDx+eYg4wzr1DT1RA+
         peC+jsS/pXPgWTP77+l4NZbXOBvNTjxZg3X8CRGDdqeTfFX6rt+jxl/lD3VJw8Fa2fMw
         mWPQvW9AJVNLOIH7kVioge7VxW7HEoj1Oj+Bne2moHJMP53T0nEB70dK7KqleB6gbm6I
         VfBGzUslQUGQfCozPq+qGZa55ZvFTeHQJrp4Z1zA90JcBPTUjVajGey2btG/r0wmx+ds
         s9kRg+gJ2q3lCBr1d7wu+7etlD7evQRjtCmvnOgBAM7bBzpFhMNCNn0ioZbreBaFpP9V
         5TPA==
X-Gm-Message-State: AOAM532GCiTXwWomBPihUuALtwYYbnPLenMrN/49gPFJq0oErWWbiruV
        AzZTemOY0B12TTeUKhz32Ic=
X-Google-Smtp-Source: ABdhPJwQ7C8eETxrUo+aWzjU7i5NGQdVt5o0edNs09T3PWyu9EnCcp/yGqBevaaYecftWeK4ZjmY3Q==
X-Received: by 2002:a62:a108:0:b0:4a7:8982:4a48 with SMTP id b8-20020a62a108000000b004a789824a48mr5517227pff.44.1638358231749;
        Wed, 01 Dec 2021 03:30:31 -0800 (PST)
Received: from ?IPv6:2400:4052:6980:3800:dba7:2b1f:3f26:a5ec? ([2400:4052:6980:3800:dba7:2b1f:3f26:a5ec])
        by smtp.gmail.com with ESMTPSA id i10sm1159010pjd.3.2021.12.01.03.30.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 03:30:31 -0800 (PST)
Message-ID: <02a92b97134db5a01f4231acdd38dcf12a4619b4.camel@gmail.com>
Subject: Re: [PATCH 04/17] media: atomisp: pci: do not use err var when
 checking port validity for ISP2400
From:   Tsuchiya Yuto <kitakar@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Nable <nable.maininbox@googlemail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Fabio Aiuto <fabioaiuto83@gmail.com>,
        "andrey.i.trufanov" <andrey.i.trufanov@gmail.com>,
        Patrik Gfeller <patrik.gfeller@gmail.com>,
        Hans de Goede <hdegoede@redhat.com>
Date:   Wed, 01 Dec 2021 20:30:27 +0900
In-Reply-To: <20211117222443.3d050caa@sal.lan>
References: <20211017161958.44351-1-kitakar@gmail.com>
         <20211017161958.44351-5-kitakar@gmail.com>
         <20211026092637.196447aa@sal.lan>
         <1a295721fd1f1e512cd54a659a250aef162bfb6f.camel@gmail.com>
         <20211028123944.66c212c1@sal.lan>
         <af7cdf9de020171567c2e75b713deb2ed073e4e3.camel@gmail.com>
         <20211101141058.36ea2c8e@sal.lan>
         <ab48bd8c69273e8b18ff652f3615b2698a777092.camel@gmail.com>
         <20211111183812.0f33fdaa@sal.lan> <20211117222443.3d050caa@sal.lan>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm really sorry about this delay recently. I can't spare much time now...

On Wed, 2021-11-17 at 22:24 +0000, Mauro Carvalho Chehab wrote:
> Hi 
> Em Thu, 11 Nov 2021 18:38:12 +0000
> Mauro Carvalho Chehab <mchehab@kernel.org> escreveu:
> 
> > > The `ifdef ISP2401` was the result of merging two different version of
> > > driver, added on the initial commit of upstreamed atomisp. And for the
> > > `ifdef ISP2401`, I confirmed I can remove (almost [1]) all of them against
> > > the initial commit of atomisp [2][3]
> > > 
> > > [1] here are the three exceptions:
> > >     ("NOTE: ifdef ISP2400/ISP2401 usage in aero-atomisp")
> > >     https://github.com/kitakar5525/linux-kernel/commit/1a8488cdd31ad38a3805824700b29d1e5213d3f2
> > > 
> > > [2] ("atomisp: pci: css2400: remove ISP2401 ifdefs")
> > >     https://github.com/kitakar5525/linux-kernel/commit/dd6723fc5b9fe040e33b227b509a7e004243edce
> > > [3] ("atomisp: pci: remove ISP2401 ifdefs for main pci driver")
> > >     https://github.com/kitakar5525/linux-kernel/commit/1734341f84a96945af7635f6fff061db910f746f  
> > 
> > Ok, if there are more if/ifdef ISP2401 that, if reverted will keep the
> > driver running with the firmware we're using, I'm all for it. Just send
> > the patches ;-)
> 
> I went ahead and solved several INPUT_SYSTEM related ifdefs on a way
> that it is compatible with Intel Aero firmware for the sh_css* files.
> Except if I made any mistake, the ifdefs that are related to the
> input system were already addressed.
> 
> I didn't notice any changes when running camorama on the PREVIEW
> node. 
> 
> Please test. Feel free to submit fixup patches if needed.

Thank you for your work. Just tried now and I also don't notice any
issues so far with the latest media_stage tree.

Regards,
Tsuchiya Yuto
