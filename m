Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14D5E59BCA2
	for <lists+linux-kernel@lfdr.de>; Mon, 22 Aug 2022 11:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234345AbiHVJRu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 05:17:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbiHVJRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 05:17:47 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F039911166;
        Mon, 22 Aug 2022 02:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661159865; x=1692695865;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=6d17F0vfyYCfy1y5XTyYgJ9Isihgj/pGEDhDb6BTYVE=;
  b=daY5fbNpuTG0x1vbC99jrm1D3z0uyCb3IBqjDYLoeOFy2vY4aEc8V2Jj
   WXtR9oUSb89W24szU/gIW0wOObX4bpj2K5MsgpmkTfhwHbcNDvracuZZ4
   5QBgKBc+nxI7DKMR0rHYq2aUHec8rtjA2jnXzP175dySV7sfP8BOvTgBy
   aEELwCr/qds5dOs+eUR9w9eftosxIACneu1Jq8AReTMTJFV19/QE78bdW
   AMihvDFP2VJczn5e/Lps2aEMUg9X2/gFExfZGDKWGi9gP5eMOyhgoLKFA
   5YSEkYHEagkOOH+zMAkgbbK6tUHahJw7jwd9BqLvy6EO976c2U/hE3wwN
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10446"; a="290921152"
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="290921152"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 02:17:45 -0700
X-IronPort-AV: E=Sophos;i="5.93,254,1654585200"; 
   d="scan'208";a="608889608"
Received: from punajuuri.fi.intel.com (HELO paasikivi.fi.intel.com) ([10.237.72.43])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 02:17:43 -0700
Received: from paasikivi.fi.intel.com (localhost [127.0.0.1])
        by paasikivi.fi.intel.com (Postfix) with SMTP id 1660B20656;
        Mon, 22 Aug 2022 12:17:41 +0300 (EEST)
Date:   Mon, 22 Aug 2022 09:17:41 +0000
From:   Sakari Ailus <sakari.ailus@linux.intel.com>
To:     Marco Felsch <m.felsch@pengutronix.de>
Cc:     mchehab@kernel.org, laurent.pinchart+renesas@ideasonboard.com,
        jacopo+renesas@jmondi.org, akinobu.mita@gmail.com,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel@pengutronix.de
Subject: Re: [PATCH 2/4] media: mt9m111: fix subdev API usage
Message-ID: <YwNJtWCLsZgy3iHG@paasikivi.fi.intel.com>
References: <20220818144712.997477-1-m.felsch@pengutronix.de>
 <20220818144712.997477-2-m.felsch@pengutronix.de>
 <YwMiJYympE18tkmm@paasikivi.fi.intel.com>
 <20220822075101.75dv3cv2evb2qeqq@pengutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220822075101.75dv3cv2evb2qeqq@pengutronix.de>
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 22, 2022 at 09:51:01AM +0200, Marco Felsch wrote:
> Hi Sakari,
> 
> On 22-08-22, Sakari Ailus wrote:
> > Hi Marco,
> > 
> > On Thu, Aug 18, 2022 at 04:47:10PM +0200, Marco Felsch wrote:
> > > In case of I2C transfer failures the driver return failure codes which
> > > are not allowed according the API documentation. Fix that by ignore the
> > > register access failure codes.
> > > 
> > > Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
> > > ---
> > >  drivers/media/i2c/mt9m111.c | 116 ++++++++++++++++++++----------------
> > >  1 file changed, 66 insertions(+), 50 deletions(-)
> > > 
> > > diff --git a/drivers/media/i2c/mt9m111.c b/drivers/media/i2c/mt9m111.c
> > > index cdaf283e1309..53c4dac4e4bd 100644
> > > --- a/drivers/media/i2c/mt9m111.c
> > > +++ b/drivers/media/i2c/mt9m111.c
> > > @@ -455,7 +455,7 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
> > >  	struct mt9m111 *mt9m111 = to_mt9m111(client);
> > >  	struct v4l2_rect rect = sel->r;
> > >  	int width, height;
> > > -	int ret, align = 0;
> > > +	int align = 0;
> > >  
> > >  	if (sel->which != V4L2_SUBDEV_FORMAT_ACTIVE ||
> > >  	    sel->target != V4L2_SEL_TGT_CROP)
> > > @@ -481,14 +481,13 @@ static int mt9m111_set_selection(struct v4l2_subdev *sd,
> > >  	width = min(mt9m111->width, rect.width);
> > >  	height = min(mt9m111->height, rect.height);
> > >  
> > > -	ret = mt9m111_setup_geometry(mt9m111, &rect, width, height, mt9m111->fmt->code);
> > > -	if (!ret) {
> > > -		mt9m111->rect = rect;
> > > -		mt9m111->width = width;
> > > -		mt9m111->height = height;
> > > -	}
> > >  
> > > -	return ret;
> > > +	mt9m111_setup_geometry(mt9m111, &rect, width, height, mt9m111->fmt->code);
> > 
> > If the function can fail, it'd be much better to move it to s_stream
> > callback than ignore the error.
> > 
> > Same for the rest of such changes.
> 
> I did that in the following patch, but I can merge them if you want.

Yes, please.

-- 
Sakari Ailus
