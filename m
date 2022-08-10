Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30A3158F075
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 18:32:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232774AbiHJQcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 12:32:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232990AbiHJQbz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 12:31:55 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7C9C82FA4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:31:53 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id s11-20020a1cf20b000000b003a52a0945e8so1257042wmc.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 09:31:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc;
        bh=VlxSVSh4TBV3g0hrz44ERG5bQdABeiPaNu0wSLgb4Pg=;
        b=X+fhvSQC7TSTK4j3QNGEQvlf6uuTzpYO/9AD715gfzd+7yaQux1eya4IyKMsorRVAM
         cRreGrBXnuJ3+8ccozEYY4N7Gn4WxqQ7WP64+MaQDOMf9n0Ze3sO1jfWIzEi+r9EVKUM
         PiTRLICNJLQZW3rkY4MxMd8VhJhyhshif2KxI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc;
        bh=VlxSVSh4TBV3g0hrz44ERG5bQdABeiPaNu0wSLgb4Pg=;
        b=nqfGFw3av7gKLsI0eq2QsutQ5aYhhQ2tBvL35x96bjk3fMCvzu1/PYK1c2hXwcc7bl
         H9ViRVvsSRDD55I1P2d/9ih6c3Mtg1wlgwfqFT7fARnLgT89SXC+LscMrXRNIixOkEmC
         zUXGxsdvtwdsuV62B1RMOH5HFh9pFjJAtnx3C32OSB0h9iGIXKjq5aLXl4hnCFRqslbF
         jcDOZoeCp4/La1ALhV4B/gz6oC5h7zmeTBxwWWKGvnBHkm8sn99PA5PIb0y5gl0+7oxO
         GtLWjSU94xUZYNDXQYp2zrZQKyGa0LBjTSE4sh4fTqA+d4MbiMDFiBvTgj+U6e//+7jk
         7qmw==
X-Gm-Message-State: ACgBeo3kdKriOc8zLtyvr1YX/+JEbtEbnV90FZuOdY/uvAQJxp3mTeOC
        8PPnngbJoULmS1B4VDIzZxmy7w==
X-Google-Smtp-Source: AA6agR6Kd0jjywQgmPLRp2Q+ytUTiLAiAgjJ619ktBQijD4gk6n84NU4HxO7RhUIl9YJIpn6Wquj+Q==
X-Received: by 2002:a05:600c:4f0e:b0:3a3:3077:e5b3 with SMTP id l14-20020a05600c4f0e00b003a33077e5b3mr3016818wmq.94.1660149112232;
        Wed, 10 Aug 2022 09:31:52 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id l3-20020a5d4803000000b0021e42e7c7dbsm16417354wrq.83.2022.08.10.09.31.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 09:31:51 -0700 (PDT)
Date:   Wed, 10 Aug 2022 18:31:49 +0200
From:   Daniel Vetter <daniel@ffwll.ch>
To:     =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
Cc:     David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 4/4] drm/format-helper: Add KUnit tests for
 drm_fb_xrgb8888_to_rgb565()
Message-ID: <YvPddQEptMj23HSj@phenom.ffwll.local>
Mail-Followup-To: =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        David Gow <davidgow@google.com>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Daniel Latypov <dlatypov@google.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>, David Airlie <airlied@linux.ie>,
        maarten.lankhorst@linux.intel.com,
        Jani Nikula <jani.nikula@linux.intel.com>,
        =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>,
        Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, dri-devel@lists.freedesktop.org,
        KUnit Development <kunit-dev@googlegroups.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220709115837.560877-1-jose.exposito89@gmail.com>
 <20220709115837.560877-5-jose.exposito89@gmail.com>
 <CABVgOSmhOBdXPH_=B_WRcUjMGC-wVPTLBwCdbgZLb0o3-O8pKw@mail.gmail.com>
 <20220717170054.GA1028249@elementary>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220717170054.GA1028249@elementary>
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

On Sun, Jul 17, 2022 at 07:00:54PM +0200, José Expósito wrote:
> José Expósito <jose.exposito89@gmail.com> wrote:
> > I already fixed the warning and added the reviewed by tags, however, I
> > noticed that rebasing the series on the latest drm-misc-next show this
> > error:
> > [...]
> 
> Sorry for the extra email. I forgot to mention that the error is only
> present in UML. Running in other architectures works as expected.
> Tested on x86_64 and PowerPC.

Maybe a regression in the kunit infrastructure? Just guessing here ...
-Daniel
-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
