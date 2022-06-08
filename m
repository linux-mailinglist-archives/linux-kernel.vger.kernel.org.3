Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB4A543950
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:45:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343695AbiFHQoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbiFHQoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:44:38 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DAC8106358
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 09:44:15 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d128so8059228qkg.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 09:44:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=OKe+1ryBcU5wu+GneAOFpMolJT5gcjQvw+XTgGCe/hU=;
        b=huoYm4nYtKhyzF5CNXfpbIhEWsLEpDpRIhEtY14/dYnVkEtH8rYfpLy4P3y9w+2xXA
         Q8aHhATX2gU2E3iKPxh6cZaJas7bmS7NcC1LU8hckdFLPvgld0Z0G4VD2CbG4kLcbRi3
         4RwnQ++KHfyBH98d2R6cvxz7S69z/glJtL58JCITDIzoaXBGjVn8DyJX3vJss3aiEZzO
         E0bJrX1UvWC0Pml6c49XYjkKME/u8Ytp0RIkMXLgHK45W5IO48PuiNU2zNmYLIItWoKY
         COl3RiPg57lOmW9lYyyPYJPvaB0ts/fGttIv/IVKVo8h96F1lnV/DM3IPs2uFBTnh6VC
         wWyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=OKe+1ryBcU5wu+GneAOFpMolJT5gcjQvw+XTgGCe/hU=;
        b=w6IFymiPbYr4LAg8o4btHXN76k5skR3IBFFhVjtuu3GryEsFj2ngG9DrlD8MNDHP5l
         zSrL4OKLJhJ8XFZB6DITb1TrUmOnTJd7SkC8tqRKduOv15aKwqR7aXdIfHdonv26ss9I
         3OMTaySyx1UPLa9xX8qu+IZZylu20kV+iOQcsvqStnmglyAIzOFpImDmbXmCrHo5LKly
         U3fwJMEoyOLMBMK+pXMCpjOehU13NTAg7Txw3+hJx/4DrPN/GvMbN+GKoFd5p0eZUY8w
         zAYJK9o/jifUG0uinQ2qYj8AAVkZhjzqOZIXBexn86RvTFY6w79f+Z5ia4sjTXaUvFME
         kFmw==
X-Gm-Message-State: AOAM5316l+8OIds3b8VKYUdh72mqPNadc1v2/1oGhTjjAavbrNa3Kff6
        GGegGoROiUPYS4n/Gi+XgFVB7Sn5r9eQ+1KAAn8=
X-Google-Smtp-Source: ABdhPJzNwxYrdy1kh0h3N3xUMS/invcRFbV/o+ic3nTzr2Q5cw3mBdJzapX7q93D6AtDdpHIIBjdtCh7DZrV8G6W5gY=
X-Received: by 2002:a37:a1c4:0:b0:6a6:ac4f:1d3f with SMTP id
 k187-20020a37a1c4000000b006a6ac4f1d3fmr15597451qke.666.1654706654377; Wed, 08
 Jun 2022 09:44:14 -0700 (PDT)
MIME-Version: 1.0
References: <20220605094018.9782-1-r.stratiienko@gmail.com>
 <5826286.lOV4Wx5bFT@jernej-laptop> <CAGphcdm=sOyppe8sAYMK6aeRXpxiHvj-h-Es6nigCNKBxdBNZQ@mail.gmail.com>
 <20220608081715.cblotjle6benihal@houat>
In-Reply-To: <20220608081715.cblotjle6benihal@houat>
From:   Roman Stratiienko <r.stratiienko@gmail.com>
Date:   Wed, 8 Jun 2022 19:44:03 +0300
Message-ID: <CAGphcdnz-fJUrtGoYXzmaCHd5rGR98_0e33a26Uh55c63Lh_rQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/sun4i: Enable output signal premultiplication for DE2/DE3
To:     Maxime Ripard <maxime@cerno.tech>
Cc:     =?UTF-8?Q?Jernej_=C5=A0krabec?= <jernej.skrabec@gmail.com>,
        wens@csie.org, airlied@linux.ie, Daniel Vetter <daniel@ffwll.ch>,
        Samuel Holland <samuel@sholland.org>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, megi@xff.cz
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

=D1=81=D1=80, 8 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 11:17, Maxime Ripar=
d <maxime@cerno.tech>:
>
> On Mon, Jun 06, 2022 at 01:16:06PM +0300, Roman Stratiienko wrote:
> > =D0=B2=D1=81, 5 =D0=B8=D1=8E=D0=BD. 2022 =D0=B3. =D0=B2 23:23, Jernej =
=C5=A0krabec <jernej.skrabec@gmail.com>:
> > >
> > > Dne nedelja, 05. junij 2022 ob 11:40:18 CEST je Roman Stratiienko nap=
isal(a):
> > > > Otherwise alpha value is discarded, resulting incorrect pixel
> > > > apperance on the display.
> > > >
> > > > This also fixes missing transparency for the most bottom layer.
> > >
> > > Can you explain that a bit more?
> >
> > Well... I would recommend reading Bartosz Ciechanowski's blog
> > https://ciechanow.ski/alpha-compositing/ or the Porter-Duff's 1984
> > whitepaper itself.
> >
> > HINT: That magic numbers from sun8i_mixer.h ( 0x03010301 ) corresponds
> > to SOURCE OVER mode.
> >
> > As you can see from the blending equation it outputs both pixel value
> > and alpha value (non-premultiplied data mode).
> >
> > Also single-layer non-premultiplied buffers may have for example
> > (R255,G255,B255,A2) pixel value, which should be sent as {R2, G2, B2}
> > through the physical display interface.
> >
> > When OUTCTL.PREMULTI disabled pixel, the RGB values passes as is, and
> > even 100% transparent data {R255, G255, B255, A0} will appear as 100%
> > opaque white.
>
> Without going into the full explanation about what alpha is, your commit
> log must describe what the bug is exactly, and most importantly how do
> you trigger it.

I do not understand what you want me to add. I checked alpha
appearance manually by
preparing framebuffers with data and presenting it on the display in
various combinations.

I attached the videos and tests as a proof. If you don't believe me
you can always check.

If you find something missing in the commit message or don't like to
see external links feel
free to amend it. From my point of view the patch is complete.

>
> Maxime

Roman
