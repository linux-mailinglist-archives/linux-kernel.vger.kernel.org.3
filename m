Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABC3A514AFA
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 15:46:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376354AbiD2NuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 09:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352209AbiD2NuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 09:50:09 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D87C4CABB6;
        Fri, 29 Apr 2022 06:46:51 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id v12so10841430wrv.10;
        Fri, 29 Apr 2022 06:46:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pEwUBKjRBpllrJk5qaKlRO87d8MdZtCNEWbpI2fUcw=;
        b=RHg27f73kpzQwZCijceWAxtRf7NJ/MfOEliQkAcG6IKKEG3bJ2iJ72vuKT23LtPKgp
         W39omxgefKec1a3gWl7NItN8E1BWvGvrXckVmWHfOkBmoRUseHw0Xb43g2I7Pbg08vmg
         JIc0JqeBoIFIRU8LKe/iWJW4iZA4YcCXFUZ+uESPmBjFEnagrO6ArqnGbiGmsdsoCRxq
         o/GRbaoEsQpxaDbUUkUIazJwUAFGTa+JqTLseu/IKoy1hDA7qdHqMyKWoPY+HAvxtn6a
         o4ZrmUK+ojeSa68029GNCGe8HU0iqoIJyqAJM44zYf1xGbMk9ETtlQw9d2oArBB6bhFf
         6I6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pEwUBKjRBpllrJk5qaKlRO87d8MdZtCNEWbpI2fUcw=;
        b=P/+vByy3WV5GN+/tp5pZ4M1sITDazIOhhcPUFtS7v6XR2hwy4AxbVz08nnFR4BsQ7j
         4ZWJIbSW2F0gJ/A2HLZXuR5WJfl8bGtt1zKSVQFAixFF418fxGjg+BqcRSYKb75nBHEI
         t3+i179NXhdNqb0t9sEak7UMrP/NewDsoJA15C4k2S+XzqWjy8lQcaTsnnucYIhBLtzd
         qSCs2eNvlRDeDefzbqly51F9waK7eHdp1Y1nzbwKjSyT+egw5zqvWr0wuiwZ/LXwdJii
         ggyLsF8HSnZ0ukyxrZTOCZJeThz3ILd9KRXSJdw7IfZj8iev80G5QPefzvvpoa4gam3i
         65gw==
X-Gm-Message-State: AOAM533a+J7YQ+c/zCGNt97bOHuTTRmn0CMQNHnmL0haOXvBy0Z7lcCu
        mpBXPU6wbqCb3yamT2CTZWE=
X-Google-Smtp-Source: ABdhPJxa6pGhZpFL51hmMw5AI1Jzp/w/JJRYmnitE4sEb0pj0428bQOYutQJOfW3tIM0R+gCvJn32A==
X-Received: by 2002:a05:6000:1f03:b0:20c:4d9e:7400 with SMTP id bv3-20020a0560001f0300b0020c4d9e7400mr1133227wrb.257.1651240010362;
        Fri, 29 Apr 2022 06:46:50 -0700 (PDT)
Received: from leap.localnet (host-79-50-86-254.retail.telecomitalia.it. [79.50.86.254])
        by smtp.gmail.com with ESMTPSA id n2-20020a1ca402000000b003942429cd1esm853641wme.10.2022.04.29.06.46.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Apr 2022 06:46:49 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Tsuchiya Yuto <kitakar@gmail.com>
Cc:     Sakari Ailus <sakari.ailus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Martiros Shakhzadyan <vrzh@vrzh.net>,
        Hans de Goede <hdegoede@redhat.com>,
        linux-media@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Ira Weiny <ira.weiny@intel.com>,
        outreachy@lists.linux.dev
Subject: Re: [PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
Date:   Fri, 29 Apr 2022 15:46:47 +0200
Message-ID: <3664993.kQq0lBPeGt@leap>
In-Reply-To: <2181693.iZASKD2KPV@leap>
References: <20220413225531.9425-1-fmdefrancesco@gmail.com> <2181693.iZASKD2KPV@leap>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=C3=AC 25 aprile 2022 20:29:03 CEST Fabio M. De Francesco wrote:
> On gioved=C3=AC 14 aprile 2022 00:55:31 CEST Fabio M. De Francesco wrote:
> > The use of kmap() is being deprecated in favor of kmap_local_page()
> > where it is feasible. The same is true for kmap_atomic().
> >=20
> > In file pci/hmm/hmm.c, function hmm_store() test if we are in atomic
> > context and, if so, it calls kmap_atomic(), if not, it calls kmap().
> >=20
> > First of all, in_atomic() shouldn't be used in drivers. This macro
> > cannot always detect atomic context; in particular, it cannot know
> > about held spinlocks in non-preemptible kernels.
> >=20
> > Notwithstanding what it is said above, this code doesn't need to care
> > whether or not it is executing in atomic context. It can simply use
> > kmap_local_page() / kunmap_local() that can instead do the mapping /
> > unmapping regardless of the context.
> >=20
> > With kmap_local_page(), the mapping is per thread, CPU local and not
> > globally visible. Therefore, hmm_store()() is a function where the use
> > of kmap_local_page() in place of both kmap() and kmap_atomic() is
> > correctly suited.
> >=20
> > Convert the calls of kmap() / kunmap() and kmap_atomic() /
> > kunmap_atomic() to kmap_local_page() / kunmap_local() and drop the
> > unnecessary tests which test if the code is in atomic context.
> >=20
> > Signed-off-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>
> > ---
> >  drivers/staging/media/atomisp/pci/hmm/hmm.c | 14 ++------------
> >  1 file changed, 2 insertions(+), 12 deletions(-)
>=20
> Hi Mauro,
>=20
> I'm writing for just a gentle ping for this and two other staging/
atomisp/=20
> patches that still seem to be waiting to be applied.
>=20
> In the meantime I would like to remind you that Hans de Goede has=20
> successfully tested this patch and the other two on both the front and=20
back=20
> cams of a chuwi hi8 tablet.

Hi Mauro,

In my previous message I forgot to remind you that two of these three=20
patches have also been reviewed by Ira Weiny (Intel).

I'd like to ask you again if there is still something left which prevents=20
these three patches from being accepted. The first of the three patches was=
=20
submitted on April 9, 2022.

=46or you convenience here are the links to the patches, the "Reviewed-by:"=
=20
and "Tested-by:" tags:

[PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_store()
https://lore.kernel.org/lkml/20220413225531.9425-1-fmdefrancesco@gmail.com/
https://lore.kernel.org/lkml/Yli+R7iLZKqO8kVP@iweiny-desk3/
https://lore.kernel.org/lkml/2d096f20-dbaa-1d49-96e9-a7ae6c19f7fe@redhat.co=
m/

[PATCH] staging: media: atomisp: Use kmap_local_page() in hmm_set()
https://lore.kernel.org/lkml/20220413212210.18494-1-fmdefrancesco@gmail.com/
https://lore.kernel.org/lkml/YldNhErgt53RqYp7@iweiny-desk3/
https://lore.kernel.org/lkml/0b04ad1a-e442-1728-ef2c-bab386a4c64c@redhat.co=
m/

[PATCH] staging: media: atomisp: Convert kmap() to kmap_local_page()
https://lore.kernel.org/lkml/20220408223129.3844-1-fmdefrancesco@gmail.com/
https://lore.kernel.org/lkml/b0aed731-b56f-4378-b50e-fc0cbccbdb84@redhat.co=
m/

Thanks,

=46abio M. De Francesco

P.S.: Do you want me to resend them all and add the above-mentioned tags?



