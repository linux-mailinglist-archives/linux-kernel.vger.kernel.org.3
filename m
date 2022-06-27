Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8844A55DD40
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:27:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242567AbiF0WUY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 18:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239498AbiF0WUW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 18:20:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5021C7642;
        Mon, 27 Jun 2022 15:20:21 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bn8so12687838ljb.2;
        Mon, 27 Jun 2022 15:20:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Lv97kZwIEvE6e2lFXgmW14bUeahaNYgjo3zqSJ3yKaU=;
        b=VfmTzmKnkxq/4yEFf3otLMH9pFlVljnvzOiK+yy+o/eZBHy24sXmub24Z8DMsd7STQ
         Ib8ctUGuIevuIybvT8cq0lyBA5pYiDtvjcOkasUR/G0EaDgtzLKxSdUwocx8jMWGsCvi
         3GDKDkzt/YS3CVbHxqtyccLTpaf4Eq+KntgjN8AuFtiUOaC6qHcMQliSUOHRa0Jkf25n
         7wGkyZ+bKoTqIGyu+doibLQUIsBZzciG2RI7REyQitl8h4Bv8DEx8NvbeetRivMTmEc0
         MdcP32b8Xq4lzvThur4amJKjIJH08UJXzvEzBNsT15XUgqG6hkIfw+A4WF4f9YM40BLG
         Cvow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Lv97kZwIEvE6e2lFXgmW14bUeahaNYgjo3zqSJ3yKaU=;
        b=fnl8/c2uQdwRYq0E8yWJv9jo6F1vDTRYVOdvgIcPIzspjODlyeGJ+TvWAC8bejovgW
         XGuVFYu2rGzSB0w1CtPko7AG3mdFxCWwO5O/qBNMVCnzKIp9myFOCXL66xGqWX/kREy/
         DKxgk7zZhQ8+2CFDeyauhSxBBjvH+zGerMPV5Qw8JOSvRIoTsgRBEpvMSfmzkIYaxoSe
         9VnbomFlh9UmOOhF9EPbsVa6sKaOAX8TY/2O5NgdCcLCeScFdWmiRGuUfEQlCXSUNMV8
         aLH1byyTDEhkLLhrqijTFFl+BJuDOmFxJcJ0GO3dNyn4d6K+H7+1v2+IrNEF//arURpc
         HVlw==
X-Gm-Message-State: AJIora90aVWXeAHRyaTwUVR/pdrdV934jLtpVo/gV5zKg/Wz5go203HQ
        MghT+hQvhTjQIgwyWPf7gxU=
X-Google-Smtp-Source: AGRyM1vIRfekQgVI3ucSH1aR0h1x2ezwGNpC+TWeVF+5DMFzj4tfSviRwOBCQPjPi17JO3mDKE8rjQ==
X-Received: by 2002:a2e:8283:0:b0:25b:b830:4535 with SMTP id y3-20020a2e8283000000b0025bb8304535mr5496242ljg.353.1656368419670;
        Mon, 27 Jun 2022 15:20:19 -0700 (PDT)
Received: from mobilestation ([95.79.140.178])
        by smtp.gmail.com with ESMTPSA id bf27-20020a2eaa1b000000b0025911ee8411sm1561397ljb.14.2022.06.27.15.20.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 15:20:17 -0700 (PDT)
Date:   Tue, 28 Jun 2022 01:20:14 +0300
From:   Serge Semin <fancer.lancer@gmail.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>
Cc:     Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Michael Turquette <mturquette@baylibre.com>,
        Dmitry Osipenko <digetx@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Alexey Malahov <Alexey.Malahov@baikalelectronics.ru>,
        Pavel Parkhomenko <Pavel.Parkhomenko@baikalelectronics.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH RESEND v5 1/8] reset: Fix devm bulk optional exclusive
 control getter
Message-ID: <20220627222014.3qlbakgtyp3noweo@mobilestation>
References: <20220624141853.7417-1-Sergey.Semin@baikalelectronics.ru>
 <20220624141853.7417-2-Sergey.Semin@baikalelectronics.ru>
 <b6e28520-01cc-f163-7ed2-a7f99ad6be26@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b6e28520-01cc-f163-7ed2-a7f99ad6be26@collabora.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 27, 2022 at 01:35:28AM +0300, Dmitry Osipenko wrote:
> On 6/24/22 17:18, Serge Semin wrote:
> > Most likely due to copy-paste mistake the device managed version of the
> > denoted reset control getter has been implemented with invalid semantic,
> > which can be immediately spotted by having "WARN_ON(shared && acquired)"
> > warning in the system log as soon as the method is called. Anyway let's
> > fix it by altering the boolean arguments passed to the
> > __devm_reset_control_bulk_get() method from
> > - shared = true, optional = false, acquired = true
> > to
> > + shared = false, optional = true, acquired = true
> > That's what they were supposed to be in the first place (see the non-devm
> > version of the same method: reset_control_bulk_get_optional_exclusive()).
> > 
> > Fixes: 48d71395896d ("reset: Add reset_control_bulk API")
> > Signed-off-by: Serge Semin <Sergey.Semin@baikalelectronics.ru>
> > 
> > ---
> > 
> > Changelog v4:
> > - This is a new patch added on v4 lap of the series.
> > ---
> >  include/linux/reset.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/linux/reset.h b/include/linux/reset.h
> > index 8a21b5756c3e..514ddf003efc 100644
> > --- a/include/linux/reset.h
> > +++ b/include/linux/reset.h
> > @@ -731,7 +731,7 @@ static inline int __must_check
> >  devm_reset_control_bulk_get_optional_exclusive(struct device *dev, int num_rstcs,
> >  					       struct reset_control_bulk_data *rstcs)
> >  {
> > -	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, true, false, true);
> > +	return __devm_reset_control_bulk_get(dev, num_rstcs, rstcs, false, true, true);
> >  }
> >  
> >  /**
> 

> Good catch,
> 
> Reviewed-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>

Thanks.

> 
> Although, this patch should be sent as standalone since it's unrelated
> to the rest of the clk patches.

Mainly you are right, but I've discovered the problem in the framework
of this patchset development. So it was more suitable for me to submit
the patch in the framework of it.

There is an implicit context too. Due to the patchset containing the
reset-control-related patches I has been trying to attract the
Philipp' attention for about four months now, but with no luck.
Having the kernel API fix-patch in the series was supposed to
implicitly raise the patchset valuability for him. I don't know what
else to do, but Stephen said he wanted to see what Philipp thought of
the reset-part of the series.

-Sergey

> 
> -- 
> Best regards,
> Dmitry
