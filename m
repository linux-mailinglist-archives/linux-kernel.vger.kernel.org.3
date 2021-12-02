Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C2D94669C2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 19:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376467AbhLBSTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 13:19:51 -0500
Received: from smtprelay0133.hostedemail.com ([216.40.44.133]:50292 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1344073AbhLBSTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 13:19:50 -0500
Received: from omf05.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay07.hostedemail.com (Postfix) with ESMTP id 4E9A918484CB8;
        Thu,  2 Dec 2021 18:16:26 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf05.hostedemail.com (Postfix) with ESMTPA id A265920016;
        Thu,  2 Dec 2021 18:16:24 +0000 (UTC)
Message-ID: <6fcddba84070c021eb92aa9a5ff15fb2a47e9acb.camel@perches.com>
Subject: Re: [PATCH] xen-blkfront: Use the bitmap API when applicable
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Juergen Gross <jgross@suse.com>, boris.ostrovsky@oracle.com,
        sstabellini@kernel.org, roger.pau@citrix.com, axboe@kernel.dk
Cc:     xen-devel@lists.xenproject.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 02 Dec 2021 10:16:23 -0800
In-Reply-To: <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
References: <1c73cf8eaff02ea19439ec676c063e592d273cfe.1638392965.git.christophe.jaillet@wanadoo.fr>
         <c529a221-f444-ad26-11ff-f693401c9429@suse.com>
         <d8f87c17-75d1-2e6b-65e1-23adc75bb515@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.77
X-Stat-Signature: 561o3yrhzhgof883pt4t3mmwux5dja7y
X-Rspamd-Server: rspamout03
X-Rspamd-Queue-Id: A265920016
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX18JTU2ijvwIy/Ds0rg5WhKwO4BPDfU4ABw=
X-HE-Tag: 1638468984-745583
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-02 at 19:12 +0100, Christophe JAILLET wrote:
> Le 02/12/2021 à 07:12, Juergen Gross a écrit :
> > On 01.12.21 22:10, Christophe JAILLET wrote:
> > > Use 'bitmap_zalloc()' to simplify code, improve the semantic and avoid 
> > > some open-coded arithmetic in allocator arguments.
> > > 
> > > Also change the corresponding 'kfree()' into 'bitmap_free()' to keep
> > > consistency.
> > > 
> > > Use 'bitmap_copy()' to avoid an explicit 'memcpy()'
[]
> > > diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
[]
> > > @@ -442,16 +442,14 @@ static int xlbd_reserve_minors(unsigned int 
> > > minor, unsigned int nr)
> > >       if (end > nr_minors) {
> > >           unsigned long *bitmap, *old;
> > > -        bitmap = kcalloc(BITS_TO_LONGS(end), sizeof(*bitmap),
> > > -                 GFP_KERNEL);
> > > +        bitmap = bitmap_zalloc(end, GFP_KERNEL);
> > >           if (bitmap == NULL)
> > >               return -ENOMEM;
> > >           spin_lock(&minor_lock);
> > >           if (end > nr_minors) {
> > >               old = minors;
> > > -            memcpy(bitmap, minors,
> > > -                   BITS_TO_LONGS(nr_minors) * sizeof(*bitmap));
> > > +            bitmap_copy(bitmap, minors, nr_minors);
> > >               minors = bitmap;
> > >               nr_minors = BITS_TO_LONGS(end) * BITS_PER_LONG;

		nr_minors = end;
?


