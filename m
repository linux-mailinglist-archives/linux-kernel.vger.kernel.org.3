Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E18C49FBE1
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:40:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349349AbiA1OkB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:40:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245244AbiA1OkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:40:00 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E404C061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:40:00 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id h20-20020a17090adb9400b001b518bf99ffso11134170pjv.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Da56eqCpT5eZsQ7VAU7ez+0LQLRQGKjBHCcbtfBfsaE=;
        b=tDNLTzTMcPDvlgGiFjaQKZbSzVTdJd/meI7qSMDnPyqBjqeVZrKQapeK/+vPZoaj7F
         dDpqXSGisnPYBbUr3TRoDmLL/RJGUYQVvOVt8ifHsR4A2PHH7Dk67VSYXGVFDjGuqDI5
         kQxAFS0+AajErsU+0ylf8/VTB2iEiKEE/FVc4N5cuXITUGCzqqXP+35f3B+6dWT90k1f
         te4R3rshoEYzC6k+jV7CIv6iar7hGaN7QqbGkhatoDA6CxAb65z/oAJ3PYJYP8ZFeSKQ
         NPoeFj7DXC4Gg2tea95DQENygBck01PKXTedXkSd37ICVpcdzp/C3E4PWRdiDuLH71Uq
         h+7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Da56eqCpT5eZsQ7VAU7ez+0LQLRQGKjBHCcbtfBfsaE=;
        b=NLMOftI3cmT8suM/GO5j+i9YE9cOhSNLrsd3qIw4tUrt6xaGeYiJk8xX8AoTSeIxFe
         6YBkqxWZQsah++ZHp+3anFKLNzL7oqcEaI2hlLXCAh1WVJriyQKc5ZpPTspce+A4BPik
         oslug7bkctbAy2vYtXhlrsXvhSAB06ICrglfhOKEy7runXMjRkHQoE9MOdNO2Zy1ejHM
         qXYaoaxT0xBpjxvb5xwI1DL4BmKq557qNEvpInY6TCwSYuWyX5KdLUWDf2pTbdox/nM9
         2WonDHT0SEGEwO12PvSv/wIEaAaEbKAVahiunMMlisbOdmv2YNXz+vDz24pemtFnnE0V
         PrwQ==
X-Gm-Message-State: AOAM532HL0ZzpEKlQThsrRdnea7sHQk7PSNyCyxitvBXU671IWlNFNo0
        p1crqxrHuFOvAPnN7Fa8cJxIWYVwAvkum0o75WvnOQ==
X-Google-Smtp-Source: ABdhPJxIwXQ7ZpbUhLKW21kmDek5BCkLgMLBW/fdro2nwuivp4xixQ6F3zIy0pd4EGju2h/70DOhqhyE/VmftplT4x8=
X-Received: by 2002:a17:903:24d:: with SMTP id j13mr8457420plh.145.1643380800014;
 Fri, 28 Jan 2022 06:40:00 -0800 (PST)
MIME-Version: 1.0
References: <20220120001621.705352-3-jsd@semihalf.com> <202201202353.tVXCQlqh-lkp@intel.com>
 <YemXXCsy4lBsCmDx@smile.fi.intel.com>
In-Reply-To: <YemXXCsy4lBsCmDx@smile.fi.intel.com>
From:   =?UTF-8?B?SmFuIETEhWJyb8Wb?= <jsd@semihalf.com>
Date:   Fri, 28 Jan 2022 15:39:49 +0100
Message-ID: <CAOtMz3NE8iOE9KBMP+MVC71mkFWwsiQyjJGs+5Nct3diR2k-HA@mail.gmail.com>
Subject: Re: [PATCH 2/2] i2c: designware: Add AMD PSP I2C bus support
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kernel test robot <lkp@intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-i2c <linux-i2c@vger.kernel.org>,
        Jarkko Nikula <jarkko.nikula@linux.intel.com>,
        kbuild-all@lists.01.org,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Wolfram Sang <wsa@kernel.org>,
        Raul E Rangel <rrangel@chromium.org>,
        Marcin Wojtas <mw@semihalf.com>,
        Grzegorz Jaszczyk <jaz@semihalf.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

czw., 20 sty 2022 o 18:12 Andy Shevchenko
<andriy.shevchenko@linux.intel.com> napisa=C5=82(a):
>
> On Thu, Jan 20, 2022 at 11:33:05PM +0800, kernel test robot wrote:
>
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> >    drivers/i2c/busses/i2c-designware-amdpsp.c: In function 'psp_send_cm=
d':
> > >> drivers/i2c/busses/i2c-designware-amdpsp.c:130:2: error: implicit de=
claration of function 'writeq'; did you mean 'writel'? [-Werror=3Dimplicit-=
function-declaration]
> >      130 |  writeq((uintptr_t)__psp_pa((void *)req), &mbox->i2c_req_add=
r);
> >          |  ^~~~~~
> >          |  writel
> >    cc1: some warnings being treated as errors
>
> Adding io-64-nonatomic-lo-hi.h after io.h should fix this.

Correct, thanks! Actually io.h is directly included from
io-64-nonatomic-lo-hi.h.

Best Regards,
Jan


>
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
