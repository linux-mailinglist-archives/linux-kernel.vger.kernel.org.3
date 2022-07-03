Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26AAF564852
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 17:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232552AbiGCPTe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 11:19:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231145AbiGCPTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 11:19:32 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3216B8F
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 08:19:31 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id l68so4018453wml.3
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 08:19:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+CMs8UMxqlzkS/Qmt0OCCCKfDi92HEEc4PUy8wummUs=;
        b=RQOq+mQs9FgWUuYaRg9hDTuBRcwKYe+KY7O7x9AcozKgRKkzNA8O2ydVuVZ1x+tH6H
         LMsY/P8flCSaptp79IYJasRg/CCBKY/n9y2JU9wXxkVNWs5D/mrvW1GImFb0E8mIS+FM
         ynl10XKGOGztnDeezxSwB4pqQp/3VhSvpRG55310dC2lFZUXw2e0i9fqoXiJ53BP/i68
         eGqiCcup5XLo+jOgGrcASUrCIrYw/GhDhwVT5YLiyVIM4t0Joe+39h38MwVkqndxTOfK
         cd0viRJ44tRDsq4fNEQZ40Aw8P8xXyrjXmONQFKoIhHldZ8sclQzGrnT45wn8Z3npTVE
         w6lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+CMs8UMxqlzkS/Qmt0OCCCKfDi92HEEc4PUy8wummUs=;
        b=G51SGFhShu9pCTGka6VG26lgCvEiWZSNSV6IliEbOBJsggSGYI9c7Pj9dbhaAVd/aC
         3Vctri7Kp9+D6AQ4mI0FFBNdeaJhkpseNqbbow2TQtV//xX1TjO+l+HCUJDH9pia0uGa
         5umbwPVVuq8Cyyx+v3Zxy8L1XFXnzhsZOh71ZLnd4cmAhNAtxH3uPu9VcaYk4jjHQe/s
         w54n+n3p0QoQVoEVH/YX1Yi1TmzAJscVGwAXRAQUCeiDxpTCt9SNz/aQ28Q0LtQ+0PnP
         CMi7eykgBr3gEyFvec6TgMahx8djM+t+EfXKKfb8oEzc+4GpUMIhWGx+jiU1n0mA+JPe
         bvAg==
X-Gm-Message-State: AJIora8GBhC3Evw6rwI4ugANO+xuvGzobvFjw75CY/OyKl1dMhZzBAL5
        5LKroLSQn+Pq91zbhCog55g=
X-Google-Smtp-Source: AGRyM1v2CJgezpMOiZS+/XQO8P8h1S1Kyf6c+QVbF8BG5113gnVeUqUs2XTlqyNY5H4wB5WNO7E+NA==
X-Received: by 2002:a05:600c:286:b0:3a0:49ce:51bf with SMTP id 6-20020a05600c028600b003a049ce51bfmr25543836wmk.18.1656861569566;
        Sun, 03 Jul 2022 08:19:29 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id e2-20020adfdbc2000000b0021b9f126fd3sm28187755wrj.14.2022.07.03.08.19.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 08:19:29 -0700 (PDT)
Date:   Sun, 3 Jul 2022 17:19:26 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     David Gow <davidgow@google.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
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
Subject: Re: [PATCH 0/4] KUnit tests for RGB565 conversion
Message-ID: <20220703151926.GA130430@elementary>
References: <20220627161132.33256-1-jose.exposito89@gmail.com>
 <CABVgOSmC6WJxMo58VH0WSD7wdLn7_TmTktm=6txrn0ECXCNJZQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABVgOSmC6WJxMo58VH0WSD7wdLn7_TmTktm=6txrn0ECXCNJZQ@mail.gmail.com>
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

Sorry for not getting back to you sooner, I've been swamped with work
this week.

On Wed, Jun 29, 2022 at 03:27:44PM +0800, David Gow wrote:
> These look pretty good overall to me, but there is one big issue
> (which is actually with the previous series -- oops!), and a few small
> stylistic thoughts.
> 
> For the big issue: these tests don't work on big-endian systems. The
> 'swab' bit in this series reminded me to check, and sure enough, all
> of the tests fail (including the rgb332 ones).
> 
> I tested it on PowerPC with:
>  ./tools/testing/kunit/kunit.py run
> --kunitconfig=drivers/gpu/drm/tests --arch=powerpc
> --cross_compile=powerpc64-linux-gnu-
> 
> So that's something which needs to be fixed.

Oops, yes, definitely something that I need to fix!
I'll include an extra patch at the beginning of v2 fixing this bug.

> The smaller stylistic thoughts basically all revolve around the
> complexity of convert_xrgb8888_cases: there are arrays of structs with
> arrays of unions of structs (with function pointers in them). This
> isn't a problem: it's actually a lot more readable than that
> description implies, but there are other ways it could be tackled
> (which have their own tradeoffs, of course).
> 
> One possibility would be to split up the test into a separate test per
> destination format. They could reuse the convert_xrgb8888_cases array,
> and just each access a different result. You could make things even
> clearer (IMO) by replacing the results[] array with a separate, named,
> member (since you don't need to iterate over them any more), and
> remove the need to have the function pointer and swab union/members by
> just hardcoding those in the separate test functions. It'd also make
> the results a bit clearer, as each destination format would get its
> own separate set of results.
> 
> Of course, that's just an idea: I don't actually have a problem with
> the existing design either (other than the endianness issue, of
> course).

I like from your approach that the output of the tests would be easier
to understand. At the moment, if a test fails, there is not enough
context to know which target format failed. I'll explore this approach
and see how it looks like.

Thanks,
Jose

> Cheers,
> -- David


