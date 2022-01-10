Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 037B7489C65
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 16:39:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiAJPjp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 10:39:45 -0500
Received: from mail-qv1-f47.google.com ([209.85.219.47]:46927 "EHLO
        mail-qv1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229641AbiAJPjm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 10:39:42 -0500
Received: by mail-qv1-f47.google.com with SMTP id r6so14746567qvr.13;
        Mon, 10 Jan 2022 07:39:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HrUqLYnp+EBghrZhAUPX70obMslHMCDhZEuASiV4UeM=;
        b=aPqRo2tVFgy5ejkycuuE2RCuA2wchgNt3NDzkxNvr2CfGPHinCf6uWN+WeZ8x55Mco
         y6B602y//KUayN+bkdU0LhPN2xoYnEjM4VLKDoO9l3I/nDTfgIvNbuS4w2LzsSu/eY8U
         aGckrPplTRm8zOzRqVS3KS0nt1HO655GxjHpfViRNhyV2lcYdn3WX77MAdg5BsjrNhZD
         y8SfRcoEqhNrK7K9dfwqYeym4/O0eSb4GJhhCmGgmwYUo/wQBuHY5ICvN1l+9ARYJEEL
         2vGkTl0Pq0fPuhVRK4KUbfC/qgvhk9mmhVhmBt5ulyQ0Xj2Qwof0DnayJfB3WWeVeoiy
         YgTg==
X-Gm-Message-State: AOAM532heNwesyyRKA1a8VQiA5JXyHVVFJsQwy5ETJOmhDcZeReYaX1J
        USgwyXkPxNINCDnkxvlswtep4KLTD68Vls9n7VTUGwxV
X-Google-Smtp-Source: ABdhPJze83vnfcSiJmIhtzb6F6zbpyVwh+LYKhbWg3NN76UJypnrzMoWY3TD+e9UUogomhrrOaAgYt98zyI82BOx5Ls=
X-Received: by 2002:a05:6214:20a2:: with SMTP id 2mr68120313qvd.52.1641829181417;
 Mon, 10 Jan 2022 07:39:41 -0800 (PST)
MIME-Version: 1.0
References: <20220107073407.GG22086@kili> <20220107134617.GA895400@chenyu-desktop>
 <20220110061713.GA1951@kadam>
In-Reply-To: <20220110061713.GA1951@kadam>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 10 Jan 2022 16:39:30 +0100
Message-ID: <CAJZ5v0gdB_y9MVasdGhMCUPKZBzNPo1NxxkHh_QeKjh1DwPPfA@mail.gmail.com>
Subject: Re: [PATCH] ACPI: pfr_telemetry: Fix info leak in pfrt_log_ioctl()
To:     Dan Carpenter <dan.carpenter@oracle.com>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Len Brown <lenb@kernel.org>,
        ACPI Devel Maling List <linux-acpi@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 7:17 AM Dan Carpenter <dan.carpenter@oracle.com> wrote:
>
> On Fri, Jan 07, 2022 at 09:46:17PM +0800, Chen Yu wrote:
> > On Fri, Jan 07, 2022 at 10:34:07AM +0300, Dan Carpenter wrote:
> > > The "data_info" struct is copied to the user.  It has a 4 byte struct
> > > hole after the last struct member so we need to memset that to avoid
> > > copying uninitialized stack data to the user.
> > >
> > > Fixes: b0013e037a8b ("ACPI: Introduce Platform Firmware Runtime Telemetry driver")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > ---
> > > When you're adding a new driver to the kernel then please use the new
> > > driver's prefix instead of just the subsystem prefix.
> > >
> > >  Bad: ACPI: Introduce Platform Firmware Runtime Telemetry driver
> > > Good: ACPI / pfr_telemetry: Introduce Platform Firmware Runtime Telemetry driver
> > >
> > Thanks for pointing this out.
> > > Otherwise it's just up to me to guess what prefix you wanted.
> > >
> > >  drivers/acpi/pfr_telemetry.c | 1 +
> > >  1 file changed, 1 insertion(+)
> > >
> > > diff --git a/drivers/acpi/pfr_telemetry.c b/drivers/acpi/pfr_telemetry.c
> > > index da50dd80192c..9abf350bd7a5 100644
> > > --- a/drivers/acpi/pfr_telemetry.c
> > > +++ b/drivers/acpi/pfr_telemetry.c
> > > @@ -83,6 +83,7 @@ static int get_pfrt_log_data_info(struct pfrt_log_data_info *data_info,
> > >     union acpi_object *out_obj, in_obj, in_buf;
> > >     int ret = -EBUSY;
> > >
> > > +   memset(data_info, 0, sizeof(*data_info));
> > Just one minor question, how about moving above before:
> > data_info->status = out_obj->package.elements[LOG_STATUS_IDX].integer.value;
> > after the sanity check of the _DSM result?
>
> I guess I wanted to keep all the memsets together.  I feel like if the
> data is invalid, then it's going to be a slow path and it's not worth
> optimizing that case.  If the data is invalid then a little slow down is
> the least of our concerns.

Patch applied, thanks!

Yu, this series needs to spend a few days more in linux-next, because
of the fixes against it sent lately.
