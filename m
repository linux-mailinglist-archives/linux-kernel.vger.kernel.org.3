Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A86154C7797
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 19:24:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiB1SZJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 13:25:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240474AbiB1SYg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 13:24:36 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745971CB3;
        Mon, 28 Feb 2022 10:04:33 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id n14so16733860wrq.7;
        Mon, 28 Feb 2022 10:04:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=VaJ7vYxiYDppNFuFvcEyYJgrljTaiSuZmK98Y+vY7wA=;
        b=obM0ggc5iSG7+04jAJpVvM5h8etlFLjmoe4ZZzOTzBcDwFsuhkVO6s1roPpWq1YY2e
         w4zuUXbjfJz1VoC3A662BS3NzR0t1zoJoMYFf2e5luAQqjP3126oAW+Zg0g2q/ZdFwWk
         e+HkxNtaNf8rwIpVk2O8pm66muF7nUj5YcB1tdSePCn7gdQ9Fqh8jWHTYcBXQoj9dcJo
         ZesQnXxaL2zja28D99QyC50dHVtYWGDCHSXVRUgFZ9JymjrBnrMRLkajEZwCaMW+gUBN
         awKBE4/e8bAG7z25vJGrzkGIRgvmewZY4NOINQ5RAonQJlzElctNPnRmdia/W70r7N0E
         o2fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=VaJ7vYxiYDppNFuFvcEyYJgrljTaiSuZmK98Y+vY7wA=;
        b=L8kJIN6X+xl0Wm9B6mu2UBl46XO8rbK7sOYE6MWAOF9b0omyGGxbn+5ljM+ndyaX63
         ddyvLEvZif1zW5ZwmGeP+qQ8ymorrGr2UxwOLRdCS2KLnD8SlNESrcmioQbdgvpZa5Tw
         UtG1uKhnsxP2DKJaTtCkRhV9ENhiXD9nCZng/Xoh02xz7fRCzTAtLucV1pL3SBZPrBe4
         4XajTq+kVetyOua7fAFSHgQ9BGeYPk4am7JwyZRDoXb2vr3fxVPqN36gHo0kkGLfmqHQ
         is8HYWYExxS2jR8nqFwzBsMlak2Dn/EkmfYC1Xt3aLxjymWpeHLo9jnUi+npPS+yAPGW
         3wAw==
X-Gm-Message-State: AOAM531E+m6nIk5Lsy74dKVnuUYux/frYnVAijktuNaUulDjLa2oCkXz
        Zcv0GqrvtkMRClqhhIgSoqs=
X-Google-Smtp-Source: ABdhPJz81jTbv3NaGz+ja9PXaKPd0Fkk+Zfd69cpLTOt2pT1n5NhmnRVNBauIgQZyRJh5mxeY3fULA==
X-Received: by 2002:adf:dd12:0:b0:1ea:9398:8f4f with SMTP id a18-20020adfdd12000000b001ea93988f4fmr15899502wrm.458.1646071472587;
        Mon, 28 Feb 2022 10:04:32 -0800 (PST)
Received: from elementary ([94.73.33.246])
        by smtp.gmail.com with ESMTPSA id m6-20020a5d56c6000000b001edb64e69cdsm11208628wrw.15.2022.02.28.10.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Feb 2022 10:04:32 -0800 (PST)
Date:   Mon, 28 Feb 2022 19:04:30 +0100
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Maxime Ripard <maxime@cerno.tech>,
        kieran.bingham+renesas@ideasonboard.com, airlied@linux.ie,
        daniel@ffwll.ch, dri-devel@lists.freedesktop.org,
        linux-renesas-soc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] drm: rcar-du: switch to devm_drm_of_get_bridge
Message-ID: <20220228180430.GA14803@elementary>
References: <20220221073757.12181-1-jose.exposito89@gmail.com>
 <20220221085619.bqyr2etq4xjjqa4p@houat>
 <YhOCRQhDClgsBAtV@pendragon.ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YhOCRQhDClgsBAtV@pendragon.ideasonboard.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 02:15:01PM +0200, Laurent Pinchart wrote:
> On Mon, Feb 21, 2022 at 09:56:19AM +0100, Maxime Ripard wrote:
> > I guess lvds->panel can be removed from the rcar_lvds struct as well?
> 
> It's used in rcar_lvds_get_lvds_mode() though, so this patch introduces
> a regression.

True, my bad. Sorry about that.
