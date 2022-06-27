Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2871C55CB85
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:00:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239965AbiF0TCS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237682AbiF0TCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:02:14 -0400
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F124110F1;
        Mon, 27 Jun 2022 12:02:11 -0700 (PDT)
Received: from pendragon.ideasonboard.com (62-78-145-57.bb.dnainternet.fi [62.78.145.57])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id D62711C82;
        Mon, 27 Jun 2022 21:02:09 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1656356530;
        bh=QUJv18/6zJCD1zJscujVYpMclJuiO0AH8NqgXjGTLyc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Qb18xkKwTBQRMZIWOf73u/aeJvB1hUGv8ueemWZ6yDcz0XXwhxdPu3/xHGqBR24Z/
         Rr8189T/5dFIVMmzndrcZfs46vVevAWKh732FN0I6HyPk1CrgAM9ZfwCksqEWUG/7R
         NZBYrOcCARXvH7yQZvY8orietph1Mzbisp67EvaA=
Date:   Mon, 27 Jun 2022 22:01:51 +0300
From:   Laurent Pinchart <laurent.pinchart@ideasonboard.com>
To:     Sebastian Fricke <sebastian.fricke@collabora.com>
Cc:     linux-media@vger.kernel.org, kernel@collabora.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Ricardo Ribalda <ribalda@chromium.org>,
        Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
        Daniel Scally <djrscally@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Nicolas Dufresne <nicolas.dufresne@collabora.com>,
        Benjamin Gaignard <benjamin.gaignard@collabora.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: Fix incorrect P010 chroma order description
Message-ID: <Yrn+nwBu/PD6djq/@pendragon.ideasonboard.com>
References: <20220627071224.16787-1-sebastian.fricke@collabora.com>
 <YrltXpTYqMZK/AZV@pendragon.ideasonboard.com>
 <20220627170209.hzf3ezujtrm2ahau@basti-XPS-13-9310>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220627170209.hzf3ezujtrm2ahau@basti-XPS-13-9310>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On Mon, Jun 27, 2022 at 07:02:09PM +0200, Sebastian Fricke wrote:
> On 27.06.2022 11:42, Laurent Pinchart wrote:
> > On Mon, Jun 27, 2022 at 09:12:23AM +0200, Sebastian Fricke wrote:
> >> The chroma order of P010 is `CbCr`,
> >> match with the descriptions in `include/uapi/linux/videodev2.h` and the
> >> documentation.
> >>
> >> Fixes: 5374d8fb75f31 Add P010 video format
> >
> > This should be
> >
> > Fixes: 5374d8fb75f3 ("media: Add P010 video format")
> 
> I assume this can probably be fixed while merging it right? So, I don't
> have to resend it.

No need to resend indeed, this can be fixed when merging.

> > I recommend adding the following to your ~/.gitconfig:
> >
> > [pretty]
> >	fixes = Fixes: %h (\"%s\")
> >
> > You can then use `git show --pretty=fixes -s` to generate the right
> > Fixes: tag. If you fix lots of bugs, an alias in your ~/.bashrc is also
> > useful:
> >
> > gpf() {
> >	git show --pretty=fixes -s ${1:-HEAD} | xclip -selection clipboard
> > }
> 
> Thanks a lot for the advice :).
> 
> >
> >> Signed-off-by: Sebastian Fricke <sebastian.fricke@collabora.com>
> >
> > Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
> >
> >> ---
> >>  drivers/media/v4l2-core/v4l2-ioctl.c | 2 +-
> >>  1 file changed, 1 insertion(+), 1 deletion(-)
> >>
> >> diff --git a/drivers/media/v4l2-core/v4l2-ioctl.c b/drivers/media/v4l2-core/v4l2-ioctl.c
> >> index e2526701294e..e03362c8aef9 100644
> >> --- a/drivers/media/v4l2-core/v4l2-ioctl.c
> >> +++ b/drivers/media/v4l2-core/v4l2-ioctl.c
> >> @@ -1306,7 +1306,7 @@ static void v4l_fill_fmtdesc(struct v4l2_fmtdesc *fmt)
> >>  	case V4L2_PIX_FMT_NV61:		descr = "Y/CrCb 4:2:2"; break;
> >>  	case V4L2_PIX_FMT_NV24:		descr = "Y/CbCr 4:4:4"; break;
> >>  	case V4L2_PIX_FMT_NV42:		descr = "Y/CrCb 4:4:4"; break;
> >> -	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CrCb 4:2:0"; break;
> >> +	case V4L2_PIX_FMT_P010:		descr = "10-bit Y/CbCr 4:2:0"; break;
> >>  	case V4L2_PIX_FMT_NV12_4L4:	descr = "Y/CbCr 4:2:0 (4x4 Linear)"; break;
> >>  	case V4L2_PIX_FMT_NV12_16L16:	descr = "Y/CbCr 4:2:0 (16x16 Linear)"; break;
> >>  	case V4L2_PIX_FMT_NV12_32L32:   descr = "Y/CbCr 4:2:0 (32x32 Linear)"; break;

-- 
Regards,

Laurent Pinchart
