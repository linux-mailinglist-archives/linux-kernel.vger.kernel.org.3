Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E03D565317
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 13:13:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233955AbiGDLNH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 07:13:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbiGDLNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 07:13:04 -0400
Received: from kylie.crudebyte.com (kylie.crudebyte.com [5.189.157.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C1CEFD38
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 04:13:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
        Content-ID:Content-Description;
        bh=WNP0ZMyD6GxVrQdemfnOUO9FL85lre3PmCHI5+4eook=; b=Rzs78zrxsfYZNsAyQmZuEWqTAe
        jeYtNQbFoJPZVcxeUQSGmn+2f73F3EXBo+DGIKkR3XX6+aakkhxOkkkZra1jUtBgf5JPzjejUqFp6
        fXb4mxKtJ47CsP1naB1qSIjMSuS3fxNww4ud+RP7omeIXi+FE4DuCMBET0BNltC+1WKwc8sTfEFhD
        +40cuJ/XJh5MTQXCNPxeISxaiBgLlveIXLYMOYECP30zhE3AecQG+Eb/yct1jOGmLOJM+bIuGsEog
        q+pdUUrUHMSdPDbyNPDEfRUEHJge6/uHKcvJkWpheZ3OXp6NCrHq/u8BLOv7gb69JorXXlVuO+hEm
        ZxMDYCFg5mJQjf4+KxZPkf2uHiopM/kWRlzHvvbFP10LRYj0Qgt/rHx823/Vcdif7F2BXwfhuQYYH
        CaKmOnsaONv95tO0eG0glqu3o89zdc+msQRyVGTo+qMOgs5/Jmr8hqzfPzf/CxID52hp8JlP5zOzV
        PesGN8orkeJ3XDNps9rgTCg6YGdoLbTRp1WX8OjjstuWq2VMEF00FCR+2cBiUhTD9juM9PGWCSIRn
        pzh9hBtcgKpWJ4fGDCmtBZVQRQqXGowJspVS0Wwdh3RFIKqhhzaeMSVeVIqHMMUpza5iXqCCrEsVW
        syGFmulApR17z1aU65dje+yomxv1FFwxJWnSRpLik=;
From:   Christian Schoenebeck <linux_oss@crudebyte.com>
To:     Kent Overstreet <kent.overstreet@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     linux-kernel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>
Subject: Re: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Mon, 04 Jul 2022 13:12:51 +0200
Message-ID: <2335194.JbyEHpbE5P@silver>
In-Reply-To: <YsJgxoTyYxX1NwyW@codewreck.org>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704030557.fm7xecylcq4z4zkr@moria.home.lan>
 <YsJgxoTyYxX1NwyW@codewreck.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Montag, 4. Juli 2022 05:38:46 CEST Dominique Martinet wrote:
> +Christian, sorry I just noticed you weren't in Ccs again --
> the patches are currently there if you want a look:
> https://evilpiepirate.org/git/bcachefs.git/log/?h=9p_mempool

I wonder whether it would make sense to update 9p section in MAINTAINERS to 
better reflect current reality, at least in a way such that contributors would 
CC me right away?

Eric, Latchesar, what do you think?

> > @@ -270,10 +276,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type,
> > unsigned int max_size)> 
> >  	if (!req)
> >  	
> >  		return ERR_PTR(-ENOMEM);
> > 
> > -	if (p9_fcall_init(c, &req->tc, alloc_msize))
> > -		goto free_req;
> > -	if (p9_fcall_init(c, &req->rc, alloc_msize))
> > -		goto free;
> > +	p9_fcall_init(c, &req->tc, 0, alloc_msize);
> > +	p9_fcall_init(c, &req->rc, 1, alloc_msize);
> 
> mempool allocation never fails, correct?
> 
> (don't think this needs a comment, just making sure here)
> 
> This all looks good to me, will queue it up in my -next branch after
> running some tests next weekend and hopefully submit when 5.20 opens
> with the code making smaller allocs more common.

Hoo, Dominique, please hold your horses. I currently can't keep up with 
reviewing and testing all pending 9p patches right now.

Personally I would hold these patches back for now. They would make sense on 
current situation on master, because ATM basically all 9p requests simply 
allocate exactly 'msize' for any 9p request.

However that's exactly what I was going to address with my already posted 
patches (relevant patches regarding this issue here being 9..12):
https://lore.kernel.org/all/cover.1640870037.git.linux_oss@crudebyte.com/
And in the cover letter (section "STILL TODO" ... "3.") I was suggesting to 
subsequently subdivide kmem_cache_alloc() into e.g. 4 allocation size 
categories? Because that's what my already posted patches do anyway.

How about I address the already discussed issues and post a v5 of those 
patches this week and then we can continue from there?

Best regards,
Christian Schoenebeck



