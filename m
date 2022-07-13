Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F3D4573D52
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 21:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236763AbiGMTom (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 15:44:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56726 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232144AbiGMTol (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 15:44:41 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67DA205E8;
        Wed, 13 Jul 2022 12:44:40 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id i2so7357963qkm.8;
        Wed, 13 Jul 2022 12:44:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AgWnvJuWvMs9BNQibg9dJXMSIiw7AP7RCPNxvoP8zeA=;
        b=ksIFue9YbxkNLn7R1csI9a8pPRDVDDl+Hi3uOkbmIG83c57hIIoiOpuSGJ0YRJWI0B
         nT4LotaiUcav8II4zOoIfmBWEQWHJcZO5dz73ddeJSrf4o0+SXgj3SeA3/4Y4go1QWCp
         dEGL1bEPsofw/Fv9z9QBd4WPYihJ1lP5ze4ZhqsIX9XMFjt5Y3AZRiYZFgp1WRs42q+P
         s2VtJZM3uvih9ByXdt5ekF8oG5NzenQvIuK2npxY7eJw2aEz2yvVMZVgaX/ScUYrKK3d
         2pAGOqO3/bCeFF0pJVyYq9Incpvt2YMjF8jBIFSVwEeUVG17JY10wGovFKoR5GCtnVah
         QXKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AgWnvJuWvMs9BNQibg9dJXMSIiw7AP7RCPNxvoP8zeA=;
        b=DS+zQxMFiQ367VyoX8uRmoOvoqxV9YrBcgSPDVvX6FLWvRnDxBqFH7VlC7ws7DNJwf
         Aii3c1g1WkGmch2sAELhZfqgFXXyoNlfH/txoPhy7H+qpDFeMgeeufflX02u82v4pZsV
         TmmgpTgsPRIqIZFoKeY1BSa0PXskQTj3vv0oLgjbTMiK8k1N/oka1uX9j+ZkQ/jTf1WL
         xXBvSBqiALVqE2ODcyUT76BHu8I5lvl/2WRbhgYZc32UrTjNAQ/lMzDpNLtVjzxZegaO
         aixqjFZcOMccUxDaNUOQZy4Kdz+cgl1+SjD7mRNHg36kl/LRAkiRNvZkJS2s1zg6Xd+W
         evqA==
X-Gm-Message-State: AJIora+oaUuFhacjadAGk04MkkuSN5DeWoBweZ6/0+GwoOpafz5BatH8
        UKchNe/nMq4w4InB8wgy9gI=
X-Google-Smtp-Source: AGRyM1tSwpKky1uUYM+YAOJtp/PC8wosYfmP/SdoTQ7bhXPQ4JhS1BVR1eToNz1LiMU6pW7hkJ1V1g==
X-Received: by 2002:a05:620a:190f:b0:6b5:9bf7:60d with SMTP id bj15-20020a05620a190f00b006b59bf7060dmr3624315qkb.627.1657741479762;
        Wed, 13 Jul 2022 12:44:39 -0700 (PDT)
Received: from localhost ([2601:4c1:c100:1230:7360:5d5d:6684:e04b])
        by smtp.gmail.com with ESMTPSA id n6-20020a05620a294600b006b59d5ead72sm5812403qkp.46.2022.07.13.12.44.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 12:44:39 -0700 (PDT)
Date:   Wed, 13 Jul 2022 12:44:38 -0700
From:   Yury Norov <yury.norov@gmail.com>
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     Sebastian Fricke <sebastian.fricke@collabora.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>, knaerzche@gmail.com,
        Collabora Kernel ML <kernel@collabora.com>,
        bob.beckett@collabora.com,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "open list:ARM/Rockchip SoC..." <linux-rockchip@lists.infradead.org>,
        linux-staging@lists.linux.dev, nicolas.dufresne@collabora.com,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>
Subject: Re: [PATCH 3/6] bitops: bitmap helper to set variable length values
Message-ID: <Ys8gpl3m+vvEM7Sy@yury-laptop>
References: <20220713163201.136202-1-sebastian.fricke@collabora.com>
 <Ys8Txuq9/u/EL6sj@yury-laptop>
 <CAHp75VeOLfKw4-+Dpn54yy6j=tdiBNA_2Kvhj7mUUjTD-M_vYA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHp75VeOLfKw4-+Dpn54yy6j=tdiBNA_2Kvhj7mUUjTD-M_vYA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 09:10:33PM +0200, Andy Shevchenko wrote:
> On Wed, Jul 13, 2022 at 8:56 PM Yury Norov <yury.norov@gmail.com> wrote:
> > On Wed, Jul 13, 2022 at 06:31:59PM +0200, Sebastian Fricke wrote:
> 
> ...
> 
> > I'd suggest you to try implementing
> >         bitmap_copy_from(dst, src, dst_off, len)
> > or even
> >         bitmap_copy_from(dst, dst_off, src, src_off, len)
> > if you expect that you'll need more flexibility in the future.
> 
> Do you think it would be useful?
> 
> We have bitmap_replace() & bitmap_remap(). Wouldn't that be enough?

bitmap_replace and bitmap_remap have no an 'offset' parameter.
