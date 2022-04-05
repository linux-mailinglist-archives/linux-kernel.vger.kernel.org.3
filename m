Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15F144F4DDB
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 03:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1583593AbiDEXxR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 19:53:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238262AbiDEN4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 09:56:34 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F194118F46
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 05:56:39 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id bu29so23184572lfb.0
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 05:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RGi3wdqEmb8bOd+XtGboC+n40TEtF0S3Ny1xAXSWPpw=;
        b=qUent6wGui7nCIEVw9WbCQAr1HMcwKn0ulXfuo6ucPOZB9RuGM0I3RNYHNgYmU18qf
         2E0TBJc/667dA3RMGQu9G+uluOhBEJ5ZHHa/0Dg3OOdQjv6ZNkHK3w2Tc0A3QsQdASH5
         Wx4QzkIGUqOD287+KDgdcFYdL3WNTkcxdQMS1kWSN1x6OrN5c73DGfWZyXI4ekebinTj
         Efe5HxgcRJFy7NXNZwW01najt1HneNBBx/TzsKH52QV6/Aju/csCU7XnKSfjZTYTPmex
         3ugbXkIWuiXejOkNlEUMvhUDp6YbiBVgZ6FqH0YXnsgWEpFh5Ou5+lhhkp33toJdOkij
         NsIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RGi3wdqEmb8bOd+XtGboC+n40TEtF0S3Ny1xAXSWPpw=;
        b=3JWBSoNaxNjnBGcid1chm55AHvqmH81bVuqzLk5ZTz+3suWtlwvmEaGK7Ar4cm+Hd4
         PRddzRaUtT00Idi64lq9y+PE97Xe8/paJg1tsO4BDb/rvolQY3Za0y0fzzka6+u4AWPk
         UKz+hK4IPQMS/i5lBhHmkGIn2vAZ+pfSf1EqhGMJPFfM9q6Xrakth1krcRC1XHzZyjoO
         hfwgQj4Zgrz+iZh40V0or8Hrj+lOaWtrUck0EtWxsucwXQ/k9c4f74nwialgSkizNvrI
         F/5vBKFFlJKBEE0HVOdCbCX54HIaWkF07p6WcFiRzWGDeONgYnIgnFqfD+SOHvkMe5j5
         yyDQ==
X-Gm-Message-State: AOAM531ZjJCJAlJxy37+o3nX+hj+dAvZ0ck7N0CoNXQpucV9wAYhhO5/
        f+NM6QqhaGftW63/gGz/1sNvd2Ac3FJCDwkMMrM+7w==
X-Google-Smtp-Source: ABdhPJyPnt90BGsp9MQfi8pMUfikS551+uaydptc6Mr6i289uBfmsYBBLH7TZFDhHmNkQM8iXvEVUs7GJlUn3tTOUXc=
X-Received: by 2002:ac2:4e98:0:b0:448:3039:d170 with SMTP id
 o24-20020ac24e98000000b004483039d170mr2713577lfr.233.1649163396464; Tue, 05
 Apr 2022 05:56:36 -0700 (PDT)
MIME-Version: 1.0
References: <20c6efa9a4c7423bbfb9352705c4a53a@hyperstone.com>
 <5eaae8e215d84dd3a4f7e09782478a29@hyperstone.com> <YkW1qGY3uJPhrmf1@smile.fi.intel.com>
 <c1726b6966e74c9fa9fb4a6ac56dedf9@hyperstone.com>
In-Reply-To: <c1726b6966e74c9fa9fb4a6ac56dedf9@hyperstone.com>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Tue, 5 Apr 2022 14:56:00 +0200
Message-ID: <CAPDyKFr=5HyNPc0Ly8ARHCk5hk2vWe4QEG=qu4iRYiGC1TD7LA@mail.gmail.com>
Subject: Re: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
To:     =?UTF-8?Q?Christian_L=C3=B6hle?= <CLoehle@hyperstone.com>
Cc:     "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 5 Apr 2022 at 11:20, Christian L=C3=B6hle <CLoehle@hyperstone.com> =
wrote:
>
> Understood and sure, then I'll take 2/2 back.
> @Ulf, would you like a v2 just containing 1/2 or is it fine like this?

It's fine as is, I will pick up patch1 very soon.

Kind regards
Uffe

>
>
>
>
> From: andriy.shevchenko@linux.intel.com <andriy.shevchenko@linux.intel.co=
m>
> Sent: Thursday, March 31, 2022 4:07 PM
> To: Christian L=C3=B6hle
> Cc: Ulf Hansson; linux-kernel@vger.kernel.org; linux-mmc@vger.kernel.org;=
 adrian.hunter@intel.com; digetx@gmail.com; avri.altman@wdc.com
> Subject: Re: [PATCH 2/2] mmc: mmc_spi: enable Highspeed for above 25MHz
>
> On Thu, Mar 31, 2022 at 07:29:37AM +0000, Christian L=C3=B6hle wrote:
> > Any setup supporting more than 25MHz is able to utilize
> > highspeed, so enable it even when not explicitly specified.
>
> I'm not sure about this. I prefer to be on the safer side, i.e.
> follow only what is supplied by firmware (ACPI / DT).
>
> --
> With Best Regards,
> Andy Shevchenko
>
>
>     =3D
> Hyperstone GmbH | Reichenaustr. 39a  | 78467 Konstanz
> Managing Director: Dr. Jan Peter Berns.
> Commercial register of local courts: Freiburg HRB381782
>
