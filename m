Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9F84C50B5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 22:25:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236224AbiBYVZc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 16:25:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236420AbiBYVZZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 16:25:25 -0500
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5EE21BE118;
        Fri, 25 Feb 2022 13:24:51 -0800 (PST)
Received: by mail-wr1-x432.google.com with SMTP id r10so6317717wrp.3;
        Fri, 25 Feb 2022 13:24:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9VVf1+C+ic0+UHKTIlPAU7kab9O4mDJTEXrG1CAIyA0=;
        b=Q7rUxqz/UgVude0iW3thhOW3RovvXofgrYhvLEAuApKO362jsR9iSOM+0gSLUxpagb
         vbOJOqqV0AgmO6twpSGsLhSjfG0uP25I041TafaBudI0rEjZfjQ5DsCDFwpPQxG3x+8S
         w7FAiX9G8jKynyY2u4wnmYXXe7QTPAY6yw4a0x3rE/V2ZJQ/OEi9b1gRCHL90iH/P6HU
         r7DG2S9+HoKPJX2rqTpJuHJV9tNz33TBOUmc2np/3q3PI6BHy/sXyt4HmuP+YREJMqHF
         fboAGnf7LpATIJcdhwWzD95a0ZSdhTwq4O3R5YOmYbJyOzSD5ZJ/W6i74/W9TSlkRm/b
         QofQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9VVf1+C+ic0+UHKTIlPAU7kab9O4mDJTEXrG1CAIyA0=;
        b=gHnaNfzTrvJo4ZQCei5c7/OVDMyhvDYZk/L8zCPhWOWoI6AuPqeJvgwS8WYYpZh8Vc
         uH2iabB0rcX8R6CGT0ZcVBgDqhBiAEfSpU+fVE6VZzNhkSNwj3HoW+zq0I+giH/QitG4
         qmjC6JEdIA/lIu441eBuhC8lheCzGCRuqAqg0Ihx6ySTFN3XiXkX2DC3QGH9yFA01vyh
         wetk3/U7GEpMRJh/2+vHOec40HNVduMXKZx8Je/UOKiS3TXUXPfcHV10SqoMGsmjMM04
         y3kR++bc/6JU2i6tb4N0FfxHoVLpAMyi1PbmRfYMmNasMT9MYZvH4OsXq+AxrLXlGM+M
         QTlQ==
X-Gm-Message-State: AOAM531mdE3ixB4SRMAB8bNodjvtPCZuvs4jzWmSrym2+/jd76Yq11hs
        /3AtmtpFCwcEdjfmCMq9rppB8ctaljteWOX+HM8=
X-Google-Smtp-Source: ABdhPJwVxOz7t8StaeYFX+WO6Gwh388/MH+up7+Bj4Znq3AUAgahurecB1E8GtgKjT4L3zzVjg5hX7Q4tcZENicFIIQ=
X-Received: by 2002:a05:6000:46:b0:1ed:c11e:6add with SMTP id
 k6-20020a056000004600b001edc11e6addmr7541874wrx.328.1645824290162; Fri, 25
 Feb 2022 13:24:50 -0800 (PST)
MIME-Version: 1.0
References: <20220225202614.225197-1-robdclark@gmail.com> <Yhk92RwhBqAAHcuT@intel.com>
In-Reply-To: <Yhk92RwhBqAAHcuT@intel.com>
From:   Rob Clark <robdclark@gmail.com>
Date:   Fri, 25 Feb 2022 13:24:37 -0800
Message-ID: <CAF6AEGtiGA3TOtAvud66TOz_=ODHACS5jfsYPVQFvex-+1xBBA@mail.gmail.com>
Subject: Re: [Freedreno] [PATCH 1/3] drm: Extend DEFINE_DRM_GEM_FOPS() for
 optional fops
To:     =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>
Cc:     Rob Clark <robdclark@chromium.org>,
        Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
        David Airlie <airlied@linux.ie>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        freedreno <freedreno@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 25, 2022 at 12:36 PM Ville Syrj=C3=A4l=C3=A4
<ville.syrjala@linux.intel.com> wrote:
>
> On Fri, Feb 25, 2022 at 12:26:12PM -0800, Rob Clark wrote:
> > From: Rob Clark <robdclark@chromium.org>
> >
> > Extend the helper macro so we don't have to throw it away if driver add=
s
> > support for optional fops, like show_fdinfo().
> >
> > Signed-off-by: Rob Clark <robdclark@chromium.org>
> > ---
> >  include/drm/drm_gem.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/include/drm/drm_gem.h b/include/drm/drm_gem.h
> > index 35e7f44c2a75..987e78b18244 100644
> > --- a/include/drm/drm_gem.h
> > +++ b/include/drm/drm_gem.h
> > @@ -327,7 +327,7 @@ struct drm_gem_object {
> >   * non-static version of this you're probably doing it wrong and will =
break the
> >   * THIS_MODULE reference by accident.
> >   */
> > -#define DEFINE_DRM_GEM_FOPS(name) \
> > +#define DEFINE_DRM_GEM_FOPS(name, ...) \
> >       static const struct file_operations name =3D {\
> >               .owner          =3D THIS_MODULE,\
> >               .open           =3D drm_open,\
> > @@ -338,6 +338,7 @@ struct drm_gem_object {
> >               .read           =3D drm_read,\
> >               .llseek         =3D noop_llseek,\
> >               .mmap           =3D drm_gem_mmap,\
> > +             ##__VA_ARGS__\
> >       }
>
> Would it not be less convoluted to make the macro only provide
> the initializers? So you'd get something like:
>
> static const struct file_operations foo =3D {
>         DRM_GEM_FOPS,
>         .my_stuff =3D whatever,
> };
>

Hmm, I like my color of the bikeshed, but I guess it is a matter of opinion=
 ;-)

BR,
-R
