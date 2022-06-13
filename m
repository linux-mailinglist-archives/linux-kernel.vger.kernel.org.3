Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11097549D97
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Jun 2022 21:24:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349918AbiFMTY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 15:24:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350071AbiFMTXW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 15:23:22 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9C63522CD
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:19:55 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id h5so8031055wrb.0
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jun 2022 10:19:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=v9wOSbkkFgoouudCT5M9ut11ttnj6LGZRsAbuaQUW4w=;
        b=AhRXQM/ukGy67WqPvSWEdkzh2PE+yy+GSFhlwgy+rjdEcBQcH5eTH7wmfvOFQZ2+2g
         S2NoTKCqKPCjaIsxjCSDZKihElHpfrXopMf0Gvr1nWl6qFzmc4Rc9R/OCX8XXiAnZ3z2
         3mMZ1tYsDbkbr+HujclIPj1SogBHfm7NDSF8qEzfkoEuxVDqnMvotCfqtMgGcOLnrt0C
         FNZiHc/RrEuV5NC0Wjh+Ib++wXt99f9T+4ntJIv7vi99j0/qXrAejs2G2swfZ3NBBBeS
         i7Xxq0fQR9Et8WY8Hl5XgxQuIs4n+t1h9QP85QyB0kf3CHBK1OLwHHO8Ifsq88iyH651
         YxAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=v9wOSbkkFgoouudCT5M9ut11ttnj6LGZRsAbuaQUW4w=;
        b=nCkV3cqEN6RQbDuqk3TMnO1MMUOTTXasPNvlDDl3/h7/2j/wRWTtsWPheSmzIsGEHx
         7i5moMOuVjx0xUjVwOpp3pg4KM21NYpxz9ZcDUMqEaxrB2Z8Nc4O88Dgzs+1SRCEZ0Ty
         yZ42cBaD4B8PizPI414WVbcQO2if7DTNrPuOZSa7IFcePINhTJNiRS8BiANgazzb+uwu
         JJ3vQqVUZ0Ymeh1XJsRSoZ3cSHssWky1aB421ZrYta46v3QamZ086EbWMhbS1iWLUYr/
         L22K5GmhbuTRAin4iudZoFYEU/7ZevPQ4W+Izgp4+v6qVlLp4HlxgD4N1+q6KYmCb+ka
         +Jlw==
X-Gm-Message-State: AJIora/U0c3rmIFTEvwGcR5JZfpqs+doFZ0Wl2ayPOsK8OLVBQE5XTa9
        gOahYKBZlcAxkR8qRBcv5UU=
X-Google-Smtp-Source: AGRyM1vK1IbbnFk2rcDMjgTifM9dW4eAfDBLjuP8C26mHS6Fg6KbDO8FnPheE0vldCzWcRT9Eblp7g==
X-Received: by 2002:a05:6000:1688:b0:218:47d6:5e46 with SMTP id y8-20020a056000168800b0021847d65e46mr785988wrd.699.1655140794288;
        Mon, 13 Jun 2022 10:19:54 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id r8-20020a05600c424800b0039740903c39sm9879039wmm.7.2022.06.13.10.19.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jun 2022 10:19:53 -0700 (PDT)
Date:   Mon, 13 Jun 2022 19:19:51 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     javierm@redhat.com, davidgow@google.com, airlied@linux.ie,
        dlatypov@google.com, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, tzimmermann@suse.de,
        kunit-dev@googlegroups.com
Subject: Re: [PATCH v2 1/3] drm/rect: Add DRM_RECT_INIT() macro
Message-ID: <20220613171951.GA132742@elementary>
References: <20220612161248.271590-1-jose.exposito89@gmail.com>
 <20220612161248.271590-2-jose.exposito89@gmail.com>
 <87pmjdyp62.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87pmjdyp62.fsf@intel.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 10:53:57AM +0300, Jani Nikula wrote:
> On Sun, 12 Jun 2022, José Expósito <jose.exposito89@gmail.com> wrote:
> > Add a helper macro to initialize a rectangle from x, y, width and
> > height information.
> >
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> >  include/drm/drm_rect.h | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/include/drm/drm_rect.h b/include/drm/drm_rect.h
> > index 6f6e19bd4dac..945696323c69 100644
> > --- a/include/drm/drm_rect.h
> > +++ b/include/drm/drm_rect.h
> > @@ -47,6 +47,18 @@ struct drm_rect {
> >  	int x1, y1, x2, y2;
> >  };
> >  
> > +/**
> > + * DRM_RECT_INIT - initialize a rectangle from x/y/w/h
> > + * @x: x coordinate
> > + * @y: y coordinate
> > + * @w: width
> > + * @h: height
> > + *
> > + * RETURNS:
> > + * A new rectangle of the specified size.
> > + */
> > +#define DRM_RECT_INIT(x, y, w, h) { (x), (y), (x) + (w), (y) + (h) }
> 
> Please use designated initializers.
> 
> It might help type safety if it also contained a (struct drm_rect) cast.

Thanks a lot for your review Jani, just emailed v3 with your suggested
changes.

Jose
 
> BR,
> Jani.
> 
> 
> > +
> >  /**
> >   * DRM_RECT_FMT - printf string for &struct drm_rect
> >   */
> 
> -- 
> Jani Nikula, Intel Open Source Graphics Center
