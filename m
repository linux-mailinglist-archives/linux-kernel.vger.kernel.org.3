Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AC3F505F9A
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 00:06:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbiDRWHz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 18:07:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbiDRWHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 18:07:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3586CE03C;
        Mon, 18 Apr 2022 15:05:12 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 11so13957927edw.0;
        Mon, 18 Apr 2022 15:05:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qvyMTbp6qzFtYs01g3/WRgGGqHIALLjUx9LyH/RZFQw=;
        b=jt8J3wmF1cufjRi2NhOBWl2z41tnRDI/8d1DDhxwtqFY2aY7Z+c5naIyB66DARgQm5
         OFWtN+Xanr8XKb9dBpX2mgE4orYXWKjQzPBHuKUYaVMSKbOEvFA0TqL106mQ1FC8ilPp
         jM0EW/UHmX8BdKPibC4iZFlGLDwEF/YqCs7ISQf8q5IP3g/7axKLNFlhVerJMf30Sqrp
         mWYO+5LhENR7b9PIo3mAh1BUMZzpCDdYQIhQj2keM+EUlxYya9kDruL48q1EZ6G8ZbzZ
         9+76fZGTMVEai3DOWgGkbWM+vMUrKE/gppTWtGCBVLmEe+JFT2cuynZ0NhXzX2/FvVSg
         0UoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qvyMTbp6qzFtYs01g3/WRgGGqHIALLjUx9LyH/RZFQw=;
        b=fj8kQ9ekhz75rar+pWOBqWgOAWilTT9W1faVwqhUpL5Ud2Hl4qFNluhf13htJ5Fr1a
         1GYM3GORoUIeGCcGe72PO1fcntKob0TRXMVGN0plX09qkwzLWXWYLgjcDV0vul1GSKG0
         b2S9yh6vLbnMpm0CrnYwXWAGcFeyXESihUfYs6Jo629YIIQiutsHY+g6k6MAesj3zLWG
         sUjC40OnNu73zXkzougqSWvhpZrKh4r8GmH/2hZlSsJ2/djfSHSGm8PxsiWXPthFG5ha
         P3b6dzrcbMQH1DIucOo/EHJIyA5pS3o+iiFjPGl5NKcoEWrcpkVXuo3lyCJxd0aImvn5
         PsUw==
X-Gm-Message-State: AOAM533lD8p+oetSnmZSjsrE8ly8f9Esc5RFvVZYdtrjDO2CIn9OFaU6
        POo1OH/HkSB+WZLqm/c3u6E=
X-Google-Smtp-Source: ABdhPJyfCezo9Tr9RFzy90vhk2rAq++34sWEtmK4x+AGeOegyZ8ipPNU4litJv+L/weVN/9Oal7aUg==
X-Received: by 2002:aa7:c946:0:b0:416:226f:f8a6 with SMTP id h6-20020aa7c946000000b00416226ff8a6mr14172729edt.360.1650319510489;
        Mon, 18 Apr 2022 15:05:10 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id q19-20020a17090676d300b006e8ab621e6dsm5022698ejn.19.2022.04.18.15.05.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 Apr 2022 15:05:09 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Ira Weiny <ira.weiny@intel.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Andrew Morton <akpm@linux-foundation.org>,
        SeongJae Park <sj@kernel.org>,
        Jiajian Ye <yejiajian2018@email.szu.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matthew Wilcox <willy@infradead.org>,
        Peter Zijlstra <peterz@infradead.org>,
        outreachy@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/vm: Include kernel-doc from highmem-internal.h
Date:   Tue, 19 Apr 2022 00:05:07 +0200
Message-ID: <8118428.NyiUUSuA9g@leap>
In-Reply-To: <Yl3Z8Qll+zGo4v/D@iweiny-desk3>
References: <20220418081740.21001-1-fmdefrancesco@gmail.com> <Yl3Z8Qll+zGo4v/D@iweiny-desk3>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 18 aprile 2022 23:36:49 CEST Ira Weiny wrote:
> On Mon, Apr 18, 2022 at 10:17:40AM +0200, Fabio M. De Francesco wrote:
> > In Documentation/vm/highmem.rst the kernel-doc comments are missing,
> > therefore kunmap_local() and kunmap_atomic() are yet undocumented.
> >=20
> > Add a kernel-doc directive to include the above-mentioned kernel-doc
> > comments in highmem.rst.
> >=20
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Ira Weiny <ira.weiny@intel.com>
> > Cc: Matthew Wilcox <willy@infradead.org>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
>=20
> I thought I saw a patch fly by which changed the comment of=20
kunmap_atomic() in
> include/linux/highmem-internal.h?  Did I miss that somewhere?

No, you're right. I had noticed just some minutes before reading your=20
review that a made a typo.

I wanted to write: "In Documentation/vm/highmem.rst some kernel-doc=20
comments are missing" instead for some unknown reason I wrote "the" in=20
place of "some" :(

I'll fix it ASAP.

> This is a good inclusion for now.  However, I think I would rather see=20
this as
> part of a new series which puts the bulk of the documentation with the=20
code as
> I proposed in patch 1/2 in your other series.

I have also read your review of the patch above. I agree with you that the=
=20
"how" should be placed in the kernel-doc comments in the code. And I also=20
agree that this patch should be part of a new version of a reorganized=20
series.

I'll start working on your suggestions by tomorrow morning (it's midnight=20
here in Italy).

> For this particular change:
>=20
> Reviewed-by: Ira Weiny <ira.weiny@intel.com>

Thank you so much for your review,

=46abio

> > ---
> >=20
> > This patch must be applied and built on top of=20
> > "[PATCH v3 2/2] Documentation/vm: Include kernel-doc to highmem.rst"
> > https://lore.kernel.org/lkml/20220415231917.25962-3-fmdefrancesco@gmail=
=2Ecom/
> >=20
> >  Documentation/vm/highmem.rst | 1 +
> >  1 file changed, 1 insertion(+)
> >=20
> > diff --git a/Documentation/vm/highmem.rst b/Documentation/vm/
highmem.rst
> > index 5dcee6233cd5..1a3e6a8f5d3e 100644
> > --- a/Documentation/vm/highmem.rst
> > +++ b/Documentation/vm/highmem.rst
> > @@ -161,3 +161,4 @@ Functions
> >  =3D=3D=3D=3D=3D=3D=3D=3D=3D
> > =20
> >  .. kernel-doc:: include/linux/highmem.h
> > +.. kernel-doc:: include/linux/highmem-internal.h
> > --=20
> > 2.34.1
> >=20
>=20




