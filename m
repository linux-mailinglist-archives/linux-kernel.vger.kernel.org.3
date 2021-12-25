Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C65347F422
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Dec 2021 18:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230252AbhLYRqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Dec 2021 12:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbhLYRqS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Dec 2021 12:46:18 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 215F9C061401;
        Sat, 25 Dec 2021 09:46:18 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id l5so10095142edj.13;
        Sat, 25 Dec 2021 09:46:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NXb9uQGaBtKvbUMdmPuJokNHrFa4LJfUh42PbPdY2O0=;
        b=m2+AcCualK7LXu4tDURUtUBF5v2codGDVRlKX9kp0wQ9/h7Bkjk/tRqiIUPyjcYCfp
         3X4EmNvokdC3x2jFzo1kcKFMt3WORIxJHm0M+nCvwNwSpKF8TinpKsbpvWeIHNVqsh11
         trRqYXsitm2Xyyaqw3GANaaehNAVQgHADFVoKpniZdGqFUa4ic2iBB0a1Iz38+CAzOKL
         O7AO3nmqk5R7pi+4B+xBk0xtCEvgM3sBOtF0wWZviuOTemG5wIrn71vMmd1jRIXwKTFF
         zTHlqtNGQbM5wn+u7eLXTKagMaOjAXk2a1gVE+qLqyQ63KXpP7hIcWoJRNO3wJDrTwy4
         GEBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NXb9uQGaBtKvbUMdmPuJokNHrFa4LJfUh42PbPdY2O0=;
        b=PmPHH9ZzmcgmYWAcCbfJNTvWTKmMhLT8jXJbsQqdkiS6juAgMstoH21kihK+Ix2Gqv
         w2pqZB1ZAuFdNBhbfHZC/+TGcRXCBoyU0Sc5jAcn5rPavh/e/MroUufU2S95jI4QREft
         l+ZoSkv8Cqkxv1bXYHL/YNnqc+0r0mit2xePUPhvrX1FqfO0vdXAJPZCndCAMLxGx+R/
         vdNUGifw+tqgndLDDMRbRBcaOtEx4V48oPM8pwO1hN1md6QhRoNgriVlrdZ/oG9RQ26Y
         g5lctAS9XY2fghb8dl8yRLtQRQH6e5P0yDVEryDg9st30m4QUJWcV48Tl7919U4SSUdj
         nCQw==
X-Gm-Message-State: AOAM530YVQ1arLLd+e/KTryFwf6Pykj+cj8opxbmflteHPqj+46reXL0
        BIu+NZ0fZCiTSBzgjSCVpnULSLJshyhPIB7Uag0=
X-Google-Smtp-Source: ABdhPJzFNqtcTmeGAERJ2OocFZXaP5GIk96d2ImLGhcYfpgRxVghQdn5+Y0P7jDmGNN7swGGetBiSan5jGNfi97Fc0w=
X-Received: by 2002:a17:906:3ed0:: with SMTP id d16mr8497390ejj.636.1640454376658;
 Sat, 25 Dec 2021 09:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20211223002225.3738385-1-f.fainelli@gmail.com> <20211223002225.3738385-6-f.fainelli@gmail.com>
In-Reply-To: <20211223002225.3738385-6-f.fainelli@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 25 Dec 2021 19:45:40 +0200
Message-ID: <CAHp75VeLAuGbeh+DJ=Oox5o8vdt=iLxr80sS3RrZbdJ9smh4OA@mail.gmail.com>
Subject: Re: [PATCH 5/9] mtd: rawnand: brcmnand: Allow working without interrupts
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     "open list:MEMORY TECHNOLOGY..." <linux-mtd@lists.infradead.org>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Brian Norris <computersforpeace@gmail.com>,
        Kamal Dasu <kdasu.kdev@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Cai Huoqing <caihuoqing@baidu.com>,
        Colin Ian King <colin.king@intel.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:BROADCOM SPECIFIC AMBA DRIVER (BCMA)" 
        <linux-wireless@vger.kernel.org>,
        "open list:BROADCOM STB NAND FLASH DRIVER" 
        <bcm-kernel-feedback-list@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 25, 2021 at 1:41 AM Florian Fainelli <f.fainelli@gmail.com> wrote:
>
> The BCMA devices include the brcmnand controller but they do not wire up
> any interrupt line, allow the main interrupt to be optional and update
> the completion path to also check for the lack of an interrupt line.
>
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>

> -       unsigned int            irq;
> +       int                     irq;

instead.,,

> +       ctrl->irq = platform_get_irq_optional(pdev, 0);
> +       if (ctrl->irq >= 0) {

ret = ...
if (ret > 0) {

And drop 0 from the equation, OF never uses 0 as valid vIRQ.

-- 
With Best Regards,
Andy Shevchenko
