Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6608854B850
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 20:10:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352236AbiFNSKQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Jun 2022 14:10:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345182AbiFNSJ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jun 2022 14:09:58 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6805A36326
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:09:57 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id c21so12354889wrb.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jun 2022 11:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5HS94b3zbhVHb3Euo3cragOg32oYy8HF4UEWBUR8dUc=;
        b=V3qhmoGdsgNZcH8lUWlVMk6P90TX4Owzcc39OBsyC5vIH2wHwzKrMW2ejWwQzJzuXg
         lwSR1flwIYS+63bofMdKCitcj60wIN4X8YCqeuer8MH3GXN21xbu117aIIboDPyPh1j7
         4DZxi8Go2FK2Gs8qw+hiNhpo+TlTJnWNBi/Epi3uupwSxEVroA/KnwW0ToHp/AaHf81m
         RWc2VnuSo3Fs7a6MLqpj1+1UXkJghCJkYRKi9/tBoWOHYOq/csFT6Kp7CiP3XMwmuTpV
         A84X50mZNHlCzvEaELQs2VTLiu1GK1maLmMUGJFbPPhfilIWA5juT0NRieHgnKQZtfJz
         rgKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5HS94b3zbhVHb3Euo3cragOg32oYy8HF4UEWBUR8dUc=;
        b=XMmej8mDqnBm5wcgC2pFvNKB8f/NaEp96UW4wx8lvrfDpRFOa+f36xV96sFCkcbzvW
         9ZzKgSVHA0qhe+MJx60KIqLEa7V2gUR3QWxEeSsamiz09/fAPQS0ShyTE4oqB1HUknqb
         egi5gg97GgHviw7mDFcw8PztqEIeo5AOeOdh6ZDc2ugKFDRuTj8QbMWNAD2NNm94Ag4S
         THs9z+3NR8ooIGy1x1E47SJ/iqmDUfpMMe3maXdppKXA6/4qLtD9/jkUSJlxGDUTbv96
         8JIUVAQMhIxLCvgYFpFQGRhapLmGXWbdKus3btqx7cfHwhyIj99yWqvaI9/mXRAKhidN
         jdMg==
X-Gm-Message-State: AJIora98loCSEGR/sZPjjxYRugaYogx5VH4tZEvVtpf9gsz1u0tCi1Tn
        vDAptGfV4lctBrwAt26sbVZmD+itt5U3rw==
X-Google-Smtp-Source: AGRyM1srLaIZ5Tq7ZiceCpCZ/v1Gtwa91Vj1Y1Dju2PSoqBndetCk80NVd5YKPXq4Y2H4aIzwPYz6w==
X-Received: by 2002:adf:ae09:0:b0:20e:e4f0:2133 with SMTP id x9-20020adfae09000000b0020ee4f02133mr6128115wrc.104.1655230195632;
        Tue, 14 Jun 2022 11:09:55 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id g7-20020a5d4887000000b0021350f7b22esm12418652wrq.109.2022.06.14.11.09.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jun 2022 11:09:55 -0700 (PDT)
Date:   Tue, 14 Jun 2022 20:09:52 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, daniel@ffwll.ch, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Message-ID: <20220614180952.GA7067@elementary>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-4-jose.exposito89@gmail.com>
 <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier,

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

There is a link in the next paragraph. Once the documentation is
generated the path "Documentation/dev-tools/kunit/start.rst" is
transformed into a link.
 
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

I didn't want to go into much detail because the KUnit docs are
a very good resource and already explain how to run the tests in your
favorite architecture.

Since running the test on x86_64 should not change the results, I'd
prefer to keep it simple and trust the KUnit docs for the "advanced"
options.
 
> Regardless, the patch looks good to me:
> 
> Reviewed-by: Javier Martinez Canillas <javierm@redhat.com>


Thanks a lot for taking the time to review it. I'll add the tag if a v4
is required after chatting with the guys working on the AMDGPU tests.

Jose

> -- 
> Best regards,
> 
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
> 
