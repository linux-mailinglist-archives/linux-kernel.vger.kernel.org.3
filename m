Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0451555A339
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 23:03:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231984AbiFXVCG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 17:02:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231387AbiFXVCE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 17:02:04 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F11E7A6D8
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:02:03 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id r81-20020a1c4454000000b003a0297a61ddso2486494wma.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 14:02:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=bICz+32b/h7DCqXAyJl28t1XjDFQujGZ0o38fT2EYFg=;
        b=JUjukhU6pk5h5dOSVHG43IEe28r72tdMsgbz7yI57KJCgLvJi1RSeL2EImY4NkneSy
         yOvGtUWtyFsKRfXLexdbafWe9ND6SJwNUGlauCeTn4Mhp5a3wpNQIP80folGoYT/hj7z
         NPvMHc5X/Wwnsk+h6KXdu525l424wIhH2AU1o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :content-transfer-encoding:in-reply-to;
        bh=bICz+32b/h7DCqXAyJl28t1XjDFQujGZ0o38fT2EYFg=;
        b=NMIv6r1BJz/Jb67PdRNxQ1WQW1TxbNvYVJILvZLXDRCealX3kDXgG88d7hmOuEENEi
         CjFVuUTXFWN5yGvwIfwcCX0GEkmaHG7AUfF33ZNbUhXUBk8qMgBz75XXVrRPhCsL6Jpe
         JK4zQLcrlQSOqR9YMB98Xgz9KH06GQM8jw1SudOh/PGVEY/3v4NU50jGqEaslmu+rv2M
         sqDO/jk2r+ASXWBFDUvsxiHkH9qXTmQ6tsDuJ/cV9h6VBUqKJ1dNlszyHZ9ZmYcAvDUW
         +iJzAAHQA8GC6l0UvFOMn4pZR4q/C0JH5DrXlEGfJseDVaGdBC7eHc+5X95f5vBH8aEw
         OMjg==
X-Gm-Message-State: AJIora8Wz7xUcoCqqE3AQyY8M/FAcSzvpWLKhzgF20vCGf2xE1ExKG73
        Lyuom/eWX3j5lBoVdTDUjAm8eQ==
X-Google-Smtp-Source: AGRyM1vxZuIG5ij+m0wtySp6Re7xAcWpIozIYKGYnfhWR+ZlCjWYodHNUrrSWGuxJPqHoIHvyjDzAA==
X-Received: by 2002:a05:600c:286:b0:3a0:30f8:8a43 with SMTP id 6-20020a05600c028600b003a030f88a43mr1062338wmk.90.1656104521682;
        Fri, 24 Jun 2022 14:02:01 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id y10-20020a1c4b0a000000b0039c587342d8sm8225190wma.3.2022.06.24.14.02.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jun 2022 14:02:00 -0700 (PDT)
Date:   Fri, 24 Jun 2022 23:01:59 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Message-ID: <YrYmR+aCdO3ldORB@phenom.ffwll.local>
Mail-Followup-To: Javier Martinez Canillas <javierm@redhat.com>,
        =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-4-jose.exposito89@gmail.com>
 <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
X-Operating-System: Linux phenom 5.10.0-8-amd64 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 14, 2022 at 02:58:29PM +0200, Javier Martinez Canillas wrote:
> Hello José,
> 
> On 6/13/22 19:17, José Expósito wrote:
> 
> [snip]
> 
> > +KUnit (Kernel unit testing framework) provides a common framework for unit tests
> > +within the Linux kernel.
> > +
> 
> I think that it will be useful to have a reference to the KUnit kernel doc here,
> something like the following:
> 
> `KUnit <https://docs.kernel.org/dev-tools/kunit/index.html>`_ (Kernel Unit...
> 
> > +This section covers the specifics for the DRM subsystem. For general information
> > +about KUnit, please refer to Documentation/dev-tools/kunit/start.rst.
> > +
> > +How to run the tests?
> > +~~~~~~~~~~~~~~~~~~~~~
> > +
> > +In order to facilitate running the test suite, a configuration file is present
> > +in ``drivers/gpu/drm/kunit/.kunitconfig``. It can be used by ``kunit.py`` as
> > +follows:
> > +
> > +.. code-block:: bash
> > +
> > +	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
> > +		--kconfig_add CONFIG_VIRTIO_UML=y \
> > +		--kconfig_add CONFIG_UML_PCI_OVER_VIRTIO=y
> > +
> > +.. note::
> > +	The configuration included in ``.kunitconfig`` should be as generic as
> > +	possible.
> > +	``CONFIG_VIRTIO_UML`` and ``CONFIG_UML_PCI_OVER_VIRTIO`` are not
> > +	included in it because they are only required for User Mode Linux.
> > +
> > +
> 
> Maybe also add something like this ?
> 
> For example, the following command can be used to run the test for x86_64:
> 
> 	$ ./tools/testing/kunit/kunit.py run --kunitconfig=drivers/gpu/drm/kunit \
> 		--arch=x86_64
> 
> Regardless, the patch looks good to me:
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>

Hey so since you have a bunch of patches merged into drm already but seem
to lack drm-misc commit rights to push these yourself I think it's time to
get those:

https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc

And I guess Javier can help you with any questions you might have and make
sure the request gets through by poking folks on #dri-devel irc?

Cheers, Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
