Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCC74D81AA
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 12:51:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239669AbiCNLwC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 07:52:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237669AbiCNLwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 07:52:00 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F1D73F312;
        Mon, 14 Mar 2022 04:50:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=5tca+TAwShJLomr3kMuD+RKN41E2Sud56aTrN49/wAs=;
  b=sZ6GqgN6LulclYMfrUGCFxnkK/8pww9se3SwTz6FOtPpcNrwPpBd+KQJ
   uocAZuk55q0BSZBflnbCyHtvtpyHyjGc/Nvhh2b+uYReATG6xYpslxJ9l
   iNJk5inyO3KJOwI78DJP0qJHrQ8Fba3Fgk9//L56GkGPt+pLtHSlzG22S
   w=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.90,180,1643670000"; 
   d="scan'208";a="25996944"
Received: from dt-lawall.paris.inria.fr ([128.93.67.65])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Mar 2022 12:50:48 +0100
Date:   Mon, 14 Mar 2022 12:50:48 +0100 (CET)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: julia@hadrien
To:     Dan Carpenter <dan.carpenter@oracle.com>
cc:     Joe Perches <joe@perches.com>,
        James Smart <james.smart@broadcom.com>,
        kernel-janitors@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Harshit Mogalapalli <harshit.m.mogalapalli@oracle.com>,
        Kees Cook <keescook@chromium.org>
Subject: Re: [PATCH 4/6] scsi: lpfc: use kzalloc
In-Reply-To: <20220314113407.GM3293@kadam>
Message-ID: <alpine.DEB.2.22.394.2203141247120.2561@hadrien>
References: <20220312102705.71413-1-Julia.Lawall@inria.fr> <20220312102705.71413-5-Julia.Lawall@inria.fr> <846e22e76ba9e4c620df159b073bbf4e058a35f0.camel@perches.com> <20220314113407.GM3293@kadam>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 14 Mar 2022, Dan Carpenter wrote:

> On Sat, Mar 12, 2022 at 01:45:01PM -0800, Joe Perches wrote:
> > On Sat, 2022-03-12 at 11:27 +0100, Julia Lawall wrote:
> > > Use kzalloc instead of kmalloc + memset.
> > []
> > > diff --git a/drivers/scsi/lpfc/lpfc_debugfs.c b/drivers/scsi/lpfc/lpfc_debugfs.c
> > []
> > > @@ -6272,10 +6272,8 @@ lpfc_debugfs_initialize(struct lpfc_vport *vport)
> > >  				 phba->hba_debugfs_root,
> > >  				 phba, &lpfc_debugfs_op_slow_ring_trc);
> > >  		if (!phba->slow_ring_trc) {
> > > -			phba->slow_ring_trc = kmalloc(
> > > -				(sizeof(struct lpfc_debugfs_trc) *
> > > -				lpfc_debugfs_max_slow_ring_trc),
> > > -				GFP_KERNEL);
> > > +			phba->slow_ring_trc = kzalloc((sizeof(struct lpfc_debugfs_trc) * lpfc_debugfs_max_slow_ring_trc),
> > > +						      GFP_KERNEL);
> >
> > kcalloc
> >
>
> Did someone have a Coccinelle script that converted kzalloc() to
> kcalloc()?

Not sure if I have ever done that.  A long time ago, I made one that
starts with kmalloc and picks kzalloc or kcalloc.  Perhaps Kees did such a
thing?

I'll see if it would be useful.

julia
