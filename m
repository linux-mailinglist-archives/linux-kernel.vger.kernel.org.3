Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50BCB55396F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 20:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241043AbiFUSQM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 14:16:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiFUSQH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 14:16:07 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FB6726AE2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:16:04 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l126-20020a1c2584000000b0039c1a10507fso7682076wml.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 11:16:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=apT0ANeqWm9+pTrO0iJp5VV6HKv4djCO1v/acmOTfvY=;
        b=hZdZgaOVVwP88XsbsOuXHWqYWNO3vi/CPma1pPt2mdtVBbrxU8v0OjThEwgFsS8Y88
         RDXq4pC4pVwbdtAWQjFCA7i85PR2yFDuiJhp+M4NWQbuoDvA9p+sf0DsSETdyVy3rmm3
         8yDIfFmHHzpFoeZHFVfoZ3/NCCZPQnz+OTLNI/sKUqzExRGLltZkw6PGjUOc3w8KGwty
         aE99kVNJDW7lHm/sCq4YUofpGmtVHOhsH2/pj/6mrUyyum5NOOdyfDam0f1o+LaJ60Cp
         m21ltz8RI0TSaCrwZreyeiVsHBBFZ4Q7xBxF++IcjJetO4bdwb1Dgm8Bp7EMvOZVWO+V
         ufzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=apT0ANeqWm9+pTrO0iJp5VV6HKv4djCO1v/acmOTfvY=;
        b=NNiWqyWh/2cnER8WyG7QrB0gcLRj3K0syNZioa3q9SoK8teGm83LIPBkNCI+CbqbW5
         VSgRf1zWh33s2PWzqIhPOYFCUycGHTsIQk8HI4KCiYpyhvylYicL2EazLydeSLhJPUAM
         JaF6u9FWqjh7bLmSibpP7idCJZ7nsGoKpWF0aETDu8qsdM8HdHwG0ErmiJ8ghsR5zCl/
         3MeaXhTlwjePuDaB55uW9r/0e8oA3hpoeDX3QtLBc8nIocr6ZUHMsmEqxvxLFmNwbFfP
         Dey1PuyXbE2/JK1j7gIKNwY3pepg0gdsJuKoCvYW65DP409sOwGQ8LTdmmKkOLxIPFag
         GxQQ==
X-Gm-Message-State: AJIora+ivpBtCE9bSVP/FF/CDjsMdm36hF2wTvy85GrPc8xDkzFNnjcZ
        oAAGpq+xpLVn5uKKr6HDnTM=
X-Google-Smtp-Source: AGRyM1v2x8XQjMkHBy22K+zRqshHQGdU3odTKCt3cgCbAs2n1G0K+OjjEtYRm9ugKZrBBh8mKn0+Kw==
X-Received: by 2002:a05:600c:a07:b0:39e:da6e:fc49 with SMTP id z7-20020a05600c0a0700b0039eda6efc49mr29346749wmp.143.1655835362839;
        Tue, 21 Jun 2022 11:16:02 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id b18-20020a056000055200b0021a38089e99sm16670822wrf.57.2022.06.21.11.16.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Jun 2022 11:16:02 -0700 (PDT)
Date:   Tue, 21 Jun 2022 20:15:59 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        maarten.lankhorst@linux.intel.com,
        Maxime Ripard <mripard@kernel.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v4 3/3] drm/doc: Add KUnit documentation
Message-ID: <20220621181559.GB3209@elementary>
References: <20220620160640.3790-1-jose.exposito89@gmail.com>
 <20220620160640.3790-4-jose.exposito89@gmail.com>
 <CABVgOS=nmio08_==bOhXK1qLBoGVBO9=7A9srcp6PBUS06CTqA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABVgOS=nmio08_==bOhXK1qLBoGVBO9=7A9srcp6PBUS06CTqA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi David,

On Tue, Jun 21, 2022 at 05:38:38PM +0800, David Gow wrote:
> On Tue, Jun 21, 2022 at 12:06 AM José Expósito
> <jose.exposito89@gmail.com> wrote:
> >
> > Explain how to run the KUnit tests present in the DRM subsystem and
> > clarify why the UML-only options were not added to the configuration
> > file present in drivers/gpu/drm/.kunitconfig [1] [2].
> >
> > [1] https://lore.kernel.org/dri-devel/CABVgOSn8i=LO5p7830h2XU1Jgg0KrN0qTnxkOMhf1oTgxjaKKw@mail.gmail.com/
> > [2] https://lore.kernel.org/dri-devel/CAGS_qxqpiCim_sy1LDK7PLwVgWf-LKW+uNFTGM=T7ydk-dYcEw@mail.gmail.com/
> >
> > Reviewed-by: Maxime Ripard <maxime@cerno.tech>
> > Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>
> > Acked-by: Thomas Zimmermann <tzimmermann@suse.de>
> > Signed-off-by: José Expósito <jose.exposito89@gmail.com>
> > ---
> 
> This looks good (and doesn't seem to introduce any 'make htmldocs'
> build issues on my machine).
> 
> You could also mention that using --arch=x86_64 (or similar) instead
> of the UML options is another, equally viable option for running the
> tests. That'd make it more obvious how to run on different
> architectures: UML, while a good default, is quite different to other
> architectures in not having any PCI support out-of-the-box.
> 
> (Maybe we should make the --arch=um default config include these
> options? Or have um-pci as another architecture. We did decide not to
> bother with SMP and x86, though...)

Javier suggested the same:
https://lore.kernel.org/dri-devel/20220614180952.GA7067@elementary/

I prefer to keep the docs as simple as possible and link the KUnit
docs for more information. However, you both have way more experience 
than me and agree on the topic, so I'll be happy to include it in v5
if you think it is a good idea.
 
> Regardless, this is
> Reviewed-by: David Gow <davidgow@google.com>

Thanks for reviewing and building the docs, appreciate it.
Jose

> Cheers,
> -- David


