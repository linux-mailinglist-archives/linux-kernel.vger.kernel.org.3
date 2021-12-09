Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 283E946F6DC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 23:30:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233647AbhLIWdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 17:33:33 -0500
Received: from relay030.a.hostedemail.com ([64.99.140.30]:34140 "EHLO
        relay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S230172AbhLIWdd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 17:33:33 -0500
Received: from omf19.hostedemail.com (a10.router.float.18 [10.200.18.1])
        by unirelay02.hostedemail.com (Postfix) with ESMTP id D07A321DA2;
        Thu,  9 Dec 2021 22:29:56 +0000 (UTC)
Received: from [HIDDEN] (Authenticated sender: joe@perches.com) by omf19.hostedemail.com (Postfix) with ESMTPA id 9C1F320026;
        Thu,  9 Dec 2021 22:29:54 +0000 (UTC)
Message-ID: <eb1f435113e1f42de2521e12fd0d588fca673735.camel@perches.com>
Subject: Re: [PATCH] scsi: elx: efct: Avoid a useless memset
From:   Joe Perches <joe@perches.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        james.smart@broadcom.com, ram.vegesna@broadcom.com,
        jejb@linux.ibm.com, martin.petersen@oracle.com, hare@suse.de,
        dwagner@suse.de
Cc:     linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Date:   Thu, 09 Dec 2021 14:29:51 -0800
In-Reply-To: <52c4bc82-f8eb-c884-dfd8-2579f6632517@wanadoo.fr>
References: <009cddb72f4a1b6d1744d5a8ab1955eb93509e41.1639086550.git.christophe.jaillet@wanadoo.fr>
         <4208b3d08a677601c73889f78dd25e5c9f056a86.camel@perches.com>
         <52c4bc82-f8eb-c884-dfd8-2579f6632517@wanadoo.fr>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.40.4-1ubuntu2 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: rspamout07
X-Rspamd-Queue-Id: 9C1F320026
X-Spam-Status: No, score=-4.87
X-Stat-Signature: fyxnnzhj46mcw84gyc5k9kjxmbceridk
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Session-ID: U2FsdGVkX1+X7yzEdz584GZV4ALaytCPIXWZ707yKl4=
X-HE-Tag: 1639088994-558743
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2021-12-09 at 23:19 +0100, Christophe JAILLET wrote:
> Le 09/12/2021 à 22:57, Joe Perches a écrit :
> > On Thu, 2021-12-09 at 22:51 +0100, Christophe JAILLET wrote:
> > > 'io->sgl' is kzalloced just a few lines above. There is no need to memset
> > > it another time.
> > 
> > Better to use kcalloc as well and delete the memset
> 
> Sure, thanks for spotting it Joe.
> 
> Should a clean v2 be sent or the patch in your reply is enough?
> As your proposal is better than mine, if a v2 is needed, can you do it?

Hi Christophe.

I just wondered about the multiplication in the memset.
You are the patch submitter and noticed it in the first place.
If needed I think you should do it.

cheers, Joe

> > diff --git a/drivers/scsi/elx/efct/efct_io.c b/drivers/scsi/elx/efct/efct_io.c
[]
> > @@ -56,13 +56,12 @@ efct_io_pool_create(struct efct *efct, u32 num_sgl)
> >   		}
> >   
> >   		/* Allocate SGL */
> > -		io->sgl = kzalloc(sizeof(*io->sgl) * num_sgl, GFP_KERNEL);
> > +		io->sgl = kcalloc(num_sgl, sizeof(*io->sgl), GFP_KERNEL);
> >   		if (!io->sgl) {
> >   			efct_io_pool_free(io_pool);
> >   			return NULL;
> >   		}
> >   
> > -		memset(io->sgl, 0, sizeof(*io->sgl) * num_sgl);
> >   		io->sgl_allocated = num_sgl;
> >   		io->sgl_count = 0;
> >   


