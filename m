Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BCE474865FA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 15:25:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240053AbiAFOZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 09:25:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38662 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S239963AbiAFOZP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 09:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641479115;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zjWVs4zPgcDdd1aPB3vpvvfX4YAHpkfDtqx3W+FXTKs=;
        b=WW8tT8hb9ukX7GvOvrmoOG/t+K1+TKR6hTO1pqgsS/mX9KcLrhixUVuEr2QFqWOqlpHBwG
        diRAbiRsd2Ao1p130hzPjEasd1Z/ntHD7WipgRwB0RBuzFNNB5Go3kaGTSFBlSKvW8PPuW
        7hHqrYsEnLyEOxnlLbpeVZR2trEnnos=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-393-QS7Vf5GOPGqjGTWXH7NxKQ-1; Thu, 06 Jan 2022 09:25:13 -0500
X-MC-Unique: QS7Vf5GOPGqjGTWXH7NxKQ-1
Received: by mail-qt1-f198.google.com with SMTP id b7-20020ac85bc7000000b002b65aee118bso2045029qtb.13
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 06:25:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zjWVs4zPgcDdd1aPB3vpvvfX4YAHpkfDtqx3W+FXTKs=;
        b=zf5A7wUEpuyX8qhycZavsev5MsgOtg/wJqh1tOvRPm39Q3W30Uwj5xRoLFhvjmJN0m
         p0CoSWklUN/RwIgk2A1dIME8oFG35MkHXNKctdav6FY0vQjU/M6anbg2EVDvsR9XpLv9
         bLHFly5KKoJ7p1lEprR8T9zqDKixnXwKyRmOpUdoFkBnsXK2JZSdc3Gnet0H5ET3ZfQQ
         PuDXZuze61D3t5qPGChzFv4sldtg8vLCgeu53+CIQ9EfA5MJ5RGvX2Vx+L+PXCgwsjac
         cB2REHmfc+EUbg3ysAYLny5wtWLqSdt0uCRt3/+do1THlTXhfuppBj12A22FfjajqNJ8
         3v9w==
X-Gm-Message-State: AOAM5327T6ty6FmCeU10uBn21MeAGotjUrzbpnWbs5Ivw1rIcRBapFF0
        MSDJQU5B8q584IQepwP7GX0ELg3JJZqMAybv17twtSYue5gBZN3QCMjqXWFnITjz7q0UbyUexWi
        xTU9Ksyt8wCw9rehiFUshq00=
X-Received: by 2002:ad4:5bc1:: with SMTP id t1mr55388663qvt.72.1641479113113;
        Thu, 06 Jan 2022 06:25:13 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzKOVTax9MmJ/BsDVA698jC46T1CAe6gjkx43IVQTeQeAFAMpgK/80f1GePVibIat+L71jWbA==
X-Received: by 2002:ad4:5bc1:: with SMTP id t1mr55388644qvt.72.1641479112906;
        Thu, 06 Jan 2022 06:25:12 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id u9sm1834967qta.17.2022.01.06.06.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 06:25:12 -0800 (PST)
Date:   Thu, 6 Jan 2022 09:25:11 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: dm sysfs: use default_groups in kobj_type
Message-ID: <Ydb7xzmOC8VN8miQ@redhat.com>
References: <20220106100231.3278554-1-gregkh@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220106100231.3278554-1-gregkh@linuxfoundation.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06 2022 at  5:02P -0500,
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> There are currently 2 ways to create a set of sysfs files for a
> kobj_type, through the default_attrs field, and the default_groups
> field.  Move the dm sysfs code to use default_groups field which has
> been the preferred way since aa30f47cf666 ("kobject: Add support for
> default attribute groups to kobj_type") so that we can soon get rid of
> the obsolete default_attrs field.
> 
> Cc: Alasdair Kergon <agk@redhat.com>
> Cc: Mike Snitzer <snitzer@redhat.com>
> Cc: dm-devel@redhat.com
> Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> ---
>  drivers/md/dm-sysfs.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
> index a05fcd50e1b9..e28c92478536 100644
> --- a/drivers/md/dm-sysfs.c
> +++ b/drivers/md/dm-sysfs.c
> @@ -112,6 +112,7 @@ static struct attribute *dm_attrs[] = {
>  	&dm_attr_rq_based_seq_io_merge_deadline.attr,
>  	NULL,
>  };
> +ATTRIBUTE_GROUPS(dm);

Bit strange to pass "dm" but then have ATTRIBUTE_GROUPS assume dm_attrs defined.
Feels like it'll invite janitors sending patches, that they never
compile, to remove dm_attrs.

>  
>  static const struct sysfs_ops dm_sysfs_ops = {
>  	.show	= dm_attr_show,
> @@ -120,7 +121,7 @@ static const struct sysfs_ops dm_sysfs_ops = {
>  
>  static struct kobj_type dm_ktype = {
>  	.sysfs_ops	= &dm_sysfs_ops,
> -	.default_attrs	= dm_attrs,
> +	.default_groups	= dm_groups,
>  	.release	= dm_kobject_release,
>  };
>  
> -- 
> 2.34.1
> 

But I've picked this patch up for 5.17.  Thanks.

