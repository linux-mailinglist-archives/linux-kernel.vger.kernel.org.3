Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC7F3573F63
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 00:06:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbiGMWGD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 18:06:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237253AbiGMWF5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 18:05:57 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F0945050
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:05:56 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id o5-20020a17090a3d4500b001ef76490983so351847pjf.2
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 15:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ra9hdzLCWwjPPBDp9cn53pB2Ci+cucubpWeaOQOj3nY=;
        b=Gqwc3+E6w0EUF/ryvZOM4ovQz3n3gcYqACQv2dejPsJfA5O/wU8nGEQUcv61RAF+cb
         hLl/cPYFWMfQCVdBsDh6NhSQWFAwOX8Vzp7WHXgVlMcXiSnFD5P5ZzxZh8QG5d2xHvML
         XMB2H3z/CnPx5yyHH/mxTYWTjLppLYUzCxWY5yP5dgOvi3W/TnIjjEchOdsaW7R2yhsR
         qXFwX9JnouBnIsaXd2fJHfUPY8wMNFKW7Z3oDBI4id2Z4vAU3i69EMRG958N2WGRYieX
         VmkGpHLFCwAH5dkmV521bX0NiGRWhSmQFJjy3YB49acExMxjqrhUmNFEdW52xyjux/ol
         apzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=ra9hdzLCWwjPPBDp9cn53pB2Ci+cucubpWeaOQOj3nY=;
        b=poEX7U/9GcdwkgWbGSBjFB5nFlX+UdWiT6a2ieJP6F0X/mn5cNU9rQeaUjOSjkwTga
         A0g9Ddv3kfBZkQypfYq8olwQszOdXPNBnEhE9yTKu1eroXhjoYM8n5yTjyd1iM89/c3B
         pbJ5ct+hYqNbr8kltcDYesoDATXhAfNCdXyQUq0INXc8K6xkO96jKA+lZKJn52LJvOAN
         Ysft+oy+yfzYEtz48AHVz2TVr2kzsAGqP1NKZeMWu5AZorNU7G6D86RjV4f8JECg1lLm
         vz9k/7rVDFRS3uwzAza6p5gT6zd5qazLNH984bJoqvVqtdcyAfRvVUFnJghRwK6t8IO1
         NIMg==
X-Gm-Message-State: AJIora+ee1VAHUkQlkrP6mtDQFVzkiPq6h+CT9hhLxBvieWqDPX4TMZO
        ZQk+3yX9XqKqzAsl0fYfJByMD7SxsdK5Wg==
X-Google-Smtp-Source: AGRyM1v3IuZuzLMmogJuClkxEYuGp/WqF2V6GQmHWVJT2/8FMaDWSfVLQo+pCfmtMA2ZAHXPmlphXQ==
X-Received: by 2002:a17:90b:4d07:b0:1ef:521c:f051 with SMTP id mw7-20020a17090b4d0700b001ef521cf051mr12406264pjb.164.1657749955684;
        Wed, 13 Jul 2022 15:05:55 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id mi9-20020a17090b4b4900b001ec84b0f199sm7050163pjb.1.2022.07.13.15.05.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 15:05:54 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 15:05:53 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Rodrigo Siqueira Jordao <Rodrigo.Siqueira@amd.com>,
        Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        LKML <linux-kernel@vger.kernel.org>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        David Airlie <airlied@linux.ie>,
        Maling list - DRI developers 
        <dri-devel@lists.freedesktop.org>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Daniel Axtens <dja@axtens.net>
Subject: Re: [PATCH] drm/amd/display: Add missing hard-float compile flags
 for PPC64 builds
Message-ID: <20220713220553.GB32544@roeck-us.net>
References: <20220618232737.2036722-1-linux@roeck-us.net>
 <584fc348-7a60-26a2-af61-9edc4f4830e4@amd.com>
 <CADnq5_NkVWqcxwLMBeskqpcSEYCEjUAK0hqvA_PAo7ACHKL2cA@mail.gmail.com>
 <6a026c9a-c4ee-deba-e028-4c0f478c1911@roeck-us.net>
 <CADnq5_OrxMMkazXEPHeZXp_bV890=r21DRx2QsqLXUFj4t8aYg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CADnq5_OrxMMkazXEPHeZXp_bV890=r21DRx2QsqLXUFj4t8aYg@mail.gmail.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 13, 2022 at 05:20:40PM -0400, Alex Deucher wrote:
[ ... ]
> > The problem is not the FPU operations, but the fact that soft-float
> > and hard-float compiled code is linked together. The soft-float and
> > hard-float ABIs on powerpc are not compatible, so one ends up with
> > an object file which is partially soft-float and partially hard-float
> > compiled and thus uses different ABIs. That can only create chaos,
> > so the linker complains about it.
> 
> I get that, I just don't see why only DCN 3.1.x files have this
> problem.  The DCN 2.x files should as well.
> 

No idea. Maybe ppc:allmodconfig only builds DCN 3.1.x, and other builds
don't use -Werror and the warning is ignored.

Guenter
