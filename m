Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99B14CD31A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 12:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238188AbiCDLNC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 06:13:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237218AbiCDLNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 06:13:00 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0799B1B01B6
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 03:12:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646392332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AUSVwhnfRZoC3iB2YwKFKxHIJ6yrWchu41uAkpUPwY4=;
        b=MXy/d/EyCVeh9gmvu791clf5XToQGT5jqbm3RLdWBbOhtBxexlzXJjiVH0AfMKRY7tAfbR
        vNai8biU1FthGNFmlk0p9rbzM4KxbsfySdZS/2irV3o2GfZ0qquhXS6jJuo/KgArL+qt8Y
        pxZ8pO59XZ/qUmbtCCeW6WDv0u4JzkA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-421-fTHAwu5oMceetfMqD1akZA-1; Fri, 04 Mar 2022 06:12:10 -0500
X-MC-Unique: fTHAwu5oMceetfMqD1akZA-1
Received: by mail-wm1-f72.google.com with SMTP id l2-20020a1ced02000000b0038482a47e7eso2706592wmh.5
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 03:12:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AUSVwhnfRZoC3iB2YwKFKxHIJ6yrWchu41uAkpUPwY4=;
        b=StebT69mTidv6Vo5Fupp3rX4ZKT81G/tSzoISGWPu9H9+cEi3xXM1y2nZ6tkL3E/ig
         mIWwKPr8t+eqThO4cKt2Oox+lL7dc029F0GuLqNPX+h2SzvsVsc40l48hubZL7PnItUh
         5HW1U/Qeg+5191wyAruUVB3EWAnwE5Ap/Ms2c26VninEnl+L+07v/V35liJRSlC1IrRb
         V+jhq/0FMhp1jwkZTb5CohNkv6emRJsELMaxnhnOXjbx023GwhGRmLRtoYlc+yBOkSvd
         CT66zslfqJ29eC5hRIDuEUKWiJNwjy+pU0+asxehzp1Sv5zGmTOPYBlw5P3f3HxT1Nxp
         TVSA==
X-Gm-Message-State: AOAM530kZ779I6i2zQa/nBk3HBhVnCxDGIzpX5IuWG9berTTUjdk4MZ1
        dPK4DkkuUmzP/GpWxn7Wt9wdTRSgXXS3QHV7TD8tEUzRbd9potxniYxq77yTjzuzc0WKHgpU4mk
        p2zsxMfhCbZu8iECXm+LCkyg=
X-Received: by 2002:a5d:598f:0:b0:1e3:649:e6c3 with SMTP id n15-20020a5d598f000000b001e30649e6c3mr30074419wri.520.1646392329761;
        Fri, 04 Mar 2022 03:12:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvcDuGsktUT/oYRoSqkT5GCN7ol05dt6eg/Yp3ZoumXCrcGzAwTCnCSrQyurvMrQV4T5HLjQ==
X-Received: by 2002:a5d:598f:0:b0:1e3:649:e6c3 with SMTP id n15-20020a5d598f000000b001e30649e6c3mr30074410wri.520.1646392329543;
        Fri, 04 Mar 2022 03:12:09 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id bg18-20020a05600c3c9200b0037c2ef07493sm5716793wmb.3.2022.03.04.03.12.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 03:12:08 -0800 (PST)
Date:   Fri, 4 Mar 2022 11:12:07 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Thompson <daniel.thompson@linaro.org>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "pmladek@suse.com" <pmladek@suse.com>,
        "cl@linux.com" <cl@linux.com>, "mbenes@suse.cz" <mbenes@suse.cz>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "jeyu@kernel.org" <jeyu@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "void@manifault.com" <void@manifault.com>,
        "atomlin@atomlin.com" <atomlin@atomlin.com>,
        "allen.lkml@gmail.com" <allen.lkml@gmail.com>,
        "joe@perches.com" <joe@perches.com>,
        "msuchanek@suse.de" <msuchanek@suse.de>,
        "oleksandr@natalenko.name" <oleksandr@natalenko.name>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>
Subject: Re: [PATCH v9 13/14] module: Move kdb_modules list out of core code
Message-ID: <20220304111207.pmopl7vgxrniwava@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220228234322.2073104-1-atomlin@redhat.com>
 <20220228234322.2073104-14-atomlin@redhat.com>
 <20220302161917.gx5icfszakoye4uh@maple.lan>
 <20220302203153.3kcmwu662szf3drt@ava.usersys.com>
 <a87aac32-52b1-3d56-6331-1c241fea032f@csgroup.eu>
 <YiDEmRf3X0fxSayK@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YiDEmRf3X0fxSayK@infradead.org>
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-03-03 05:37 -0800, Christoph Hellwig wrote:
> On Wed, Mar 02, 2022 at 08:56:23PM +0000, Christophe Leroy wrote:
> > Do we really want to hide the 'struct list_head modules' from external 
> > world ?
> > 
> > Otherwise we could declare it in include/linux/module.h ?
> I'd just move the trivial code that uses it from kernel/kdb/ to
> kernel/module/ as it is tied to module internals and just uses the
> KDB interfaces exposed to other parts of the kernel.

Hi Christoph,

This is a great idea. I'll do this instead.


Kind regards,

-- 
Aaron Tomlin

