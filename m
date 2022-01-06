Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 181F14866A6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 16:21:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240432AbiAFPU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 10:20:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48385 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240393AbiAFPU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 10:20:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641482456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2YqsIWQ53eG2PDcqAucmDLmwn9f5p0XCph507eireqE=;
        b=MbV4RbxIi0SW1AJKc9frYo8x0dHoD/88ZHqwj/d4+H2QxfjELRJiBPx+WjYqkDLopifIKO
        zTNfvAaxPQXflSeso2dgmjmOCbde6PXw78HOajzlWieGOOPtDuE5PDzrsBOCI52VUPZiFr
        m5PP9LNf2dWFTZPd2lmXd0tSYv0vBYU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639--A69SwpmPtGmOBk2HOdXrA-1; Thu, 06 Jan 2022 10:20:53 -0500
X-MC-Unique: -A69SwpmPtGmOBk2HOdXrA-1
Received: by mail-qt1-f200.google.com with SMTP id j26-20020ac8405a000000b002c472361f33so2178563qtl.16
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 07:20:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2YqsIWQ53eG2PDcqAucmDLmwn9f5p0XCph507eireqE=;
        b=FdM4LXvSMlGdnyqN9ajNi6cZ+eDi99bKr9e0YbkagmdvGB+NTMH6qG5V8diOCOByaK
         YDOyRzO4jP4Rvc62NTE19DSXOWOa1ypbaQtm0Ihnd46QqEnVKfWqUYa1AZ//gSsSG/ae
         unfQD402aWNEOhxSv682T73DM46z2Z7vW+7Jzrark26EsNH+UMtyUuFZpjnKvP5jc+Np
         tUp25OLCJjD1llu6wgUQsy5S+52CETBVD7RauN8JQAJkJjDZ+VyfBbwrKvSkKsnaPvcc
         fGjPG250e8KW3y7RyEgZ6Enza9C0nBx5Vfx6mnl8r8duOAQXDrZLyZOq4kSSwrPcjku1
         Y8QQ==
X-Gm-Message-State: AOAM5315bR22lX/22qjKh+2Q/I3sLZiqqRjTk9FwXrQeNes8DrncfMMh
        29AfRQ6Rwm2s7iV81DQ0giHi1W/1DBws3KLMhDnjTAbOu1ltvAwU0qgoZvHuJF4cM7gbCvMY1ek
        Al8InIzKa+em8axNXaqsVZ98=
X-Received: by 2002:a37:a8c3:: with SMTP id r186mr41125582qke.17.1641482453029;
        Thu, 06 Jan 2022 07:20:53 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyFM593HrigTWcxavtgf6tlraL5xApzNd6Y/8YuQALyJTC0/s7sqWNFOjYapn01OHOTMHltcQ==
X-Received: by 2002:a37:a8c3:: with SMTP id r186mr41125573qke.17.1641482452828;
        Thu, 06 Jan 2022 07:20:52 -0800 (PST)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id r8sm1561658qkk.91.2022.01.06.07.20.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jan 2022 07:20:52 -0800 (PST)
Date:   Thu, 6 Jan 2022 10:20:51 -0500
From:   Mike Snitzer <snitzer@redhat.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, Alasdair Kergon <agk@redhat.com>,
        dm-devel@redhat.com
Subject: Re: dm sysfs: use default_groups in kobj_type
Message-ID: <YdcI02dcV2aj1x/L@redhat.com>
References: <20220106100231.3278554-1-gregkh@linuxfoundation.org>
 <Ydb7xzmOC8VN8miQ@redhat.com>
 <YdcE+9ppXYnPzijZ@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YdcE+9ppXYnPzijZ@kroah.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 06 2022 at 10:04P -0500,
Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:

> On Thu, Jan 06, 2022 at 09:25:11AM -0500, Mike Snitzer wrote:
> > On Thu, Jan 06 2022 at  5:02P -0500,
> > Greg Kroah-Hartman <gregkh@linuxfoundation.org> wrote:
> > 
> > > There are currently 2 ways to create a set of sysfs files for a
> > > kobj_type, through the default_attrs field, and the default_groups
> > > field.  Move the dm sysfs code to use default_groups field which has
> > > been the preferred way since aa30f47cf666 ("kobject: Add support for
> > > default attribute groups to kobj_type") so that we can soon get rid of
> > > the obsolete default_attrs field.
> > > 
> > > Cc: Alasdair Kergon <agk@redhat.com>
> > > Cc: Mike Snitzer <snitzer@redhat.com>
> > > Cc: dm-devel@redhat.com
> > > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > > ---
> > >  drivers/md/dm-sysfs.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > > 
> > > diff --git a/drivers/md/dm-sysfs.c b/drivers/md/dm-sysfs.c
> > > index a05fcd50e1b9..e28c92478536 100644
> > > --- a/drivers/md/dm-sysfs.c
> > > +++ b/drivers/md/dm-sysfs.c
> > > @@ -112,6 +112,7 @@ static struct attribute *dm_attrs[] = {
> > >  	&dm_attr_rq_based_seq_io_merge_deadline.attr,
> > >  	NULL,
> > >  };
> > > +ATTRIBUTE_GROUPS(dm);
> > 
> > Bit strange to pass "dm" but then have ATTRIBUTE_GROUPS assume dm_attrs defined.
> > Feels like it'll invite janitors sending patches, that they never
> > compile, to remove dm_attrs.
> 
> 0-day would instantly catch that :)
> 
> That's the way the ATTRIBUTE_GROUPS() macro works.  It's tricky, yes,
> and I don't like it all that much, but couldn't come up with a better
> way at the time.  It saves lots and lots of boiler-plate code from
> having to be typed all the time.

OK, thanks for the insight.

Mike

