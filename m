Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03F6355CA5A
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 14:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236140AbiF0Mgr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 08:36:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233892AbiF0Mgl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 08:36:41 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1108DEB9
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:36:40 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id v14so12864049wra.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 05:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=jhMnhvP16Ty9k8cx9JCXsgpH4aaz/Fmtpfaqc20VWcw=;
        b=U2eoD6YDVpV31d326aqV/g/RltpyIY9rjQhWggIwoWRflNvpYzNZjKN5ZWbHmBMAni
         BxvYB5z4hvivkexCcJPbQVEWe2aJV4lWBt/7wWqncgkl2lFMlZuDesqTog7utiql1i5/
         Xz+MmTHHTMwk6bNlD+gi+eqn1zpJbjwNe/9uHC+VDab2/YDsuNFLHOq8TgipaXv7/N3W
         UY4moBD/9CIxU4vaWTuOi/rQOb8x7su6rnXCgGxD0vBfZGpC4348dQ0dHayejMpY152u
         72GldKPx+N641AUIDCh8tF+cEUt5AZRc1Zd9qNdxRvOlV7AowEZmC+bfG8Njf1HBUajK
         CHbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=jhMnhvP16Ty9k8cx9JCXsgpH4aaz/Fmtpfaqc20VWcw=;
        b=7y5INFcJlszsIbqB5rtVIVMTyU+gVYhllTcT0mRG3V3JO+ON8Flfj1SEWdd6H/daSW
         KsDX5RPffrZSYWJ6GQsaqlNfMPD334VqEnlHEMb3MtffVFPE3y9vaZQzqKu4j4COSlfl
         Ndwf6KB9GhoXfHv2JX7WypAjm+kXF3xITDKWuvIsXCeHM5wkO7y2aJeTDDOqnsK/jLo/
         wLVetdk/1erF+uqriMEauBA2MDiAOjJG2D/F8pM4IiZZx7HREsu5sZV4ZrDvWQ/rJU2v
         Mvm0S8XmwtoAv0THNWbci/WVLUkIZZiarcAWNA+CclHuj3Kl8u2xP7Lu694uTa0z7WUC
         /oLQ==
X-Gm-Message-State: AJIora/nyUIcgLK7zgql5Tp6E032OFuj6gqXco21k3wq2N0desdDzDh6
        7LWeZrst3hdX5V0+WXF94YM=
X-Google-Smtp-Source: AGRyM1svJUkoG5oAT5Lk55huQ5TszxhpG9aNgEtz8h6NX5RX9cQJEWBIL7AVwXyu5Ir1dSZHN90+xg==
X-Received: by 2002:a5d:5107:0:b0:21b:8c5d:1072 with SMTP id s7-20020a5d5107000000b0021b8c5d1072mr12859255wrt.378.1656333399251;
        Mon, 27 Jun 2022 05:36:39 -0700 (PDT)
Received: from elementary ([94.73.36.128])
        by smtp.gmail.com with ESMTPSA id e12-20020a5d530c000000b002185d79dc7fsm10398933wrv.75.2022.06.27.05.36.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 05:36:38 -0700 (PDT)
Date:   Mon, 27 Jun 2022 14:36:36 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Javier Martinez Canillas <javierm@redhat.com>
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        maarten.lankhorst@linux.intel.com, mripard@kernel.org,
        airlied@linux.ie, jani.nikula@linux.intel.com,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, Maxime Ripard <maxime@cerno.tech>
Subject: Re: [PATCH v3 3/3] drm/doc: Add KUnit documentation
Message-ID: <20220627123636.GA1772666@elementary>
References: <20220613171738.111013-1-jose.exposito89@gmail.com>
 <20220613171738.111013-4-jose.exposito89@gmail.com>
 <c50e5c87-3198-08b7-1e32-d0959af1f296@redhat.com>
 <YrYmR+aCdO3ldORB@phenom.ffwll.local>
 <b16eba9c-30cc-c71f-ad95-eb5398f84af8@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b16eba9c-30cc-c71f-ad95-eb5398f84af8@redhat.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Javier, Daniel,

On Fri, Jun 24, 2022 at 11:18:40PM +0200, Javier Martinez Canillas wrote:
> Hello Daniel,
> 
> On 6/24/22 23:01, Daniel Vetter wrote:
> >
> > [...]
> > 
> > Hey so since you have a bunch of patches merged into drm already but seem
> > to lack drm-misc commit rights to push these yourself I think it's time to
> > get those:
> > 
> > https://drm.pages.freedesktop.org/maintainer-tools/commit-access.html#drm-misc
> >
> > And I guess Javier can help you with any questions you might have and make
> > sure the request gets through by poking folks on #dri-devel irc?
> >
> 
> Yes, he already requested commit access and got the acks, so I think is
> just a matter of time until he has this sorted out.
> 
> José, please don't hesitate to ask if you need any help or clarification
> once you have a setup to push your patches. The dim documentation [0] is
> superb but I know that it can be somewhat stressful the first time :)

Thanks for creating my ssh account :D

The tool is really well documented, setting it up was a piece of cake.
I pushed the patches to drm-misc-next. The output didn't show any
errors or warnings, hopefully meaning that I didn't mess up.

Jose

> [0]: https://drm.pages.freedesktop.org/maintainer-tools/dim.html
>  -- 
> Best regards,
> 
> Javier Martinez Canillas
> Linux Engineering
> Red Hat
> 
