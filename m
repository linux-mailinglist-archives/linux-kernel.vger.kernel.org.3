Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8385A4F712B
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 03:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238617AbiDGB07 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 21:26:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240124AbiDGBTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 21:19:49 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 667CF1B72D5
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 18:15:26 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id f3so4096150pfe.2
        for <linux-kernel@vger.kernel.org>; Wed, 06 Apr 2022 18:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=67SY53azgMzssWukWO6AXIcinf82Rf3nAPDHa+IqhlQ=;
        b=MAChzFYtQNICmdqrAExZPki5u6vHj8GTdTxZag/4bzDo5W0JLbWW6l6+FFUu0DfxUv
         FKfiuSO1uStfSFwNQeE0B+UVoKFkVi/m+lLYyALFmpro8YhHsZf94gaxcRRObJHuAtjd
         SomWigjKFA8Gpnwv2dXshTTEgFoNSEldpEsZz69sqt8HhjJptP+BLWIQZyaLxrnXj9Uq
         8e8PXhkO3wmyz51WzhtR+A8a2wCmhqk+G9xi2qYckCHDEfYKu25n6a8D10zhaRrPKdtX
         DFIjVVhyHhoJO/oHc+Q+6Hrce3hc22q7eUHm5LivJrvIjwpaAAFfKV4WfINKMgSzQpqJ
         I/mA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=67SY53azgMzssWukWO6AXIcinf82Rf3nAPDHa+IqhlQ=;
        b=pbJa3OBhfbUNPLJwGhQciGSVA0xzCKb5htGDArCw51v+Q1evRLCxsii4IavCbvwhnk
         rtooHwLRpIC0WXF5uYbmSxx3wJixS4qJoWh2/kDgwDgFCMvZT3KG5sQOl7soQq3AMgEW
         hF4ZRjmoBEojGXSUpho8g8yVn2vwvG1szAdM/DlIqWopsnbWfD3iL1o0VXI6VkJ27Xfb
         3sZqd/wQKe2lNApXYGJkA/8YMnSO3Qkj2Z9euMpEF5nO//2NDc8Hg57voEICRG7lDfBB
         lOcS/MBrS9Je0RJvBIxRZwsJrsXKCcQfor8C4mO08hQRxlqTK6D3FgHIrGaNqbOkgH/O
         hl0g==
X-Gm-Message-State: AOAM5333i+PCeX2IDkXaSmF8Mm6JcJzaJdZuCI4BVqRKr36DAtHjkD8N
        nwOmfOTLTEBgCS5nTBL2mzQ=
X-Google-Smtp-Source: ABdhPJwMtjvF2nONDR+8O7Bl75hwcWR5WOrYWpJ3XCFloXajc6Ermx4Tgo5BXGtkU1c535Vprd9R4w==
X-Received: by 2002:a63:3d4b:0:b0:386:322:ff8c with SMTP id k72-20020a633d4b000000b003860322ff8cmr9472270pga.385.1649294126189;
        Wed, 06 Apr 2022 18:15:26 -0700 (PDT)
Received: from localhost.localdomain ([119.3.119.18])
        by smtp.gmail.com with ESMTPSA id w16-20020a63af10000000b0039953dfaa19sm6842108pge.20.2022.04.06.18.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 18:15:25 -0700 (PDT)
From:   Xiaomeng Tong <xiam0nd.tong@gmail.com>
To:     patrik.r.jakobsson@gmail.com
Cc:     airlied@linux.ie, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, xiam0nd.tong@gmail.com
Subject: Re: [PATCH] drm/gma500: fix a missing break in psb_driver_load
Date:   Thu,  7 Apr 2022 09:15:19 +0800
Message-Id: <20220407011519.13951-1-xiam0nd.tong@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <CAMeQTsbK+Akk0m3UUCx-U9F6ju_OVM0R6uZN5KB-Gu6C6Do1pw@mail.gmail.com>
References: <CAMeQTsbK+Akk0m3UUCx-U9F6ju_OVM0R6uZN5KB-Gu6C6Do1pw@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Apr 2022 09:27:19 +0200, Patrik Jakobsson wrote:
> On Fri, Apr 1, 2022 at 1:58 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
> >
> > Instead of exiting the loop as expected when an entry is found, the
> > list_for_each_entry() continues until the traversal is complete. To
> > avoid potential executing 'ret = gma_backlight_init(dev);' repeatly,
> > break the loop when the entry is found.
> >
> > Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>
> > ---
> >  drivers/gpu/drm/gma500/psb_drv.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/drivers/gpu/drm/gma500/psb_drv.c b/drivers/gpu/drm/gma500/psb_drv.c
> > index 2aff54d505e2..b61a8b0eea38 100644
> > --- a/drivers/gpu/drm/gma500/psb_drv.c
> > +++ b/drivers/gpu/drm/gma500/psb_drv.c
> > @@ -402,6 +402,9 @@ static int psb_driver_load(struct drm_device *dev, unsigned long flags)
> >                         ret = gma_backlight_init(dev);
> >                         break;
> >                 }
> > +
> > +               if (!ret)
> > +                       break;
> 
> Hi,
> We cannot do it like this either. If the first connector isn't LVDS or
> MIPI we would just break out of the iteration because ret is
> presumably 0 at start and gma_backlight_init() would never run.
> 
> -Patrik

Yes, you are correct. I have sent a v2 patch[1]: just goto out; when found.
Please check it, thank you very much.

[1]: https://lore.kernel.org/all/20220406113143.10699-1-xiam0nd.tong@gmail.com/

--
Xiaomeng Tong
 
> 
> >         }
> >         drm_connector_list_iter_end(&conn_iter);
> >
> > --
> > 2.17.1
