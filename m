Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82A25552C28
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 09:35:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346822AbiFUHfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 03:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346241AbiFUHfI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 03:35:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C25E12E
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 00:35:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05D516137C
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 07:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AE2FC3411D;
        Tue, 21 Jun 2022 07:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655796906;
        bh=Cf7UCTgdKrrveRQ6rnVuV7I2bwM9cUPoyl/dpCzA7Rs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JDiNHc/wz9cKB0EyxkN9ub41k+GYGmYW7aDZJEDYHvV/9pRguXP+VeYCSfqH/2ayh
         a0knthkHjyPZlgid8OnVlk9Tf7EnL8g8s1xmKRhoqhtEn1VsrW++2Wd+YiwpxRaZX7
         GnpadbssiFj48hOgkg4cz3iZGSkEeDzVSuYAPeYKqlgKi7m3yRKEr3YByelw82crMq
         1Ead1u+46GfA+7GCs5ufnJj5Joyq/tvNGu/q0PxvXNzt2GiC/8SgNfggKYsXBcPhmm
         13H1o0t1Kqjk8g078Oae0d3v/e0kUJbgkC7FHSoRoq1Dv7oWs4EhLSvXKPc8jMM1Z3
         XfbGJ9d9RLFwg==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1o3YPb-0005XB-QX; Tue, 21 Jun 2022 09:34:59 +0200
Date:   Tue, 21 Jun 2022 09:34:59 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     Bo Liu <liubo03@inspur.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] gnss: Remove usage of the deprecated ida_simple_xxx API
Message-ID: <YrF0ozJgjCch7cC6@hovoldconsulting.com>
References: <20220616044733.3605-1-liubo03@inspur.com>
 <0ce75f78-4a67-efce-938f-634dc981fbd6@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ce75f78-4a67-efce-938f-634dc981fbd6@wanadoo.fr>
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 16, 2022 at 09:18:37PM +0200, Christophe JAILLET wrote:
> Le 16/06/2022 à 06:47, Bo Liu a écrit :
> > Use ida_alloc_xxx()/ida_free() instead of
> > ida_simple_get()/ida_simple_remove().
> > The latter is deprecated and more verbose.
> > 
> > Signed-off-by: Bo Liu <liubo03@inspur.com>

> even if a more detailed description about the reason of the added -1 
> would be welcomed:
> 
> Reviewed-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

I agree, that should have been mentioned. And thanks for reviewing.

> > ---
> >   drivers/gnss/core.c | 4 ++--
> >   1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/gnss/core.c b/drivers/gnss/core.c
> > index e6f94501cb28..1e82b7967570 100644
> > --- a/drivers/gnss/core.c
> > +++ b/drivers/gnss/core.c
> > @@ -217,7 +217,7 @@ static void gnss_device_release(struct device *dev)
> >   
> >   	kfree(gdev->write_buf);
> >   	kfifo_free(&gdev->read_fifo);
> > -	ida_simple_remove(&gnss_minors, gdev->id);
> > +	ida_free(&gnss_minors, gdev->id);
> >   	kfree(gdev);
> >   }
> >   
> > @@ -232,7 +232,7 @@ struct gnss_device *gnss_allocate_device(struct device *parent)
> >   	if (!gdev)
> >   		return NULL;
> >   
> > -	id = ida_simple_get(&gnss_minors, 0, GNSS_MINORS, GFP_KERNEL);
> > +	id = ida_alloc_max(&gnss_minors, GNSS_MINORS - 1, GFP_KERNEL);

I'm also not sure about the claim that the new interface is less
verbose.

The above line is exactly as long as the old one, but somewhat harder to
read due to the inclusive upper bound and the various allocator flavors
(ε, max, min, range).

> >   	if (id < 0) {
> >   		kfree(gdev);
> >   		return NULL;

Now applied with an amended commit message:

	https://git.kernel.org/pub/scm/linux/kernel/git/johan/gnss.git/commit/?h=gnss-next&id=c0c725d7350ec8b8453257676a440bb4b2df2422

Johan
