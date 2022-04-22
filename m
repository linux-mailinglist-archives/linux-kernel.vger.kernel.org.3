Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D605D50B4E2
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 12:21:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446503AbiDVKXW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 06:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1446488AbiDVKXT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 06:23:19 -0400
Received: from viti.kaiser.cx (viti.kaiser.cx [IPv6:2a01:238:43fe:e600:cd0c:bd4a:7a3:8e9f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68D021FA62
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 03:20:25 -0700 (PDT)
Received: from martin by viti.kaiser.cx with local (Exim 4.89)
        (envelope-from <martin@viti.kaiser.cx>)
        id 1nhqOg-0007ex-MY; Fri, 22 Apr 2022 12:20:18 +0200
Date:   Fri, 22 Apr 2022 12:20:18 +0200
From:   Martin Kaiser <martin@kaiser.cx>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] staging: r8188eu: use ARRAY_SIZE for mlme_sta_tbl
Message-ID: <20220422102018.7xh3eqhnswd7tktp@viti.kaiser.cx>
References: <20220417102221.466524-1-martin@kaiser.cx>
 <20220417102221.466524-7-martin@kaiser.cx>
 <20220422100800.GG2462@kadam>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220422100800.GG2462@kadam>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: Martin Kaiser <martin@viti.kaiser.cx>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thus wrote Dan Carpenter (dan.carpenter@oracle.com):

> On Sun, Apr 17, 2022 at 12:22:21PM +0200, Martin Kaiser wrote:
> > Use ARRAY_SIZE instead of hard-coding the number of entries in the
> > mlme_sta_tbl array.

> > Signed-off-by: Martin Kaiser <martin@kaiser.cx>
> > ---
> >  drivers/staging/r8188eu/core/rtw_mlme_ext.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)

> > diff --git a/drivers/staging/r8188eu/core/rtw_mlme_ext.c b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > index abb910f33c1c..973adebdd69c 100644
> > --- a/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > +++ b/drivers/staging/r8188eu/core/rtw_mlme_ext.c
> > @@ -404,7 +404,7 @@ void mgt_dispatcher(struct adapter *padapter, struct recv_frame *precv_frame)
> >  		return;

> >  	index = (le16_to_cpu(hdr->frame_control) & IEEE80211_FCTL_STYPE) >> 4;
> > -	if (index > 13)
> > +	if (index > ARRAY_SIZE(mlme_sta_tbl))
>                   ^
> This is an off by one.  Should be >=.  The auto builders would have
> caught this eventually.

Thanks for spotting this, Dan. You're right, the array has 14 elements :-(

This has already made it into staging-next, I'll fix it in a new patch.

Best regards,
Martin

> >  		return;
> >  	fct = mlme_sta_tbl[index];

> regards,
> dan carpenter

