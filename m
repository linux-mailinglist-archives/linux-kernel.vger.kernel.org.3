Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13D37573FEF
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 01:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbiGMXJX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 19:09:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiGMXJV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 19:09:21 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE73119292
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:09:20 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q82so11774406pgq.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 16:09:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=j+8RK9v8gWGa5a91FxFwYr8BWqBvGM+/s21xcS2xt8M=;
        b=iA7WMNFyc+2XPTgeCCgE9e/euFNEX10zqaFS1iIgoVZCInr/5Sb6xcueFpO3imu4iG
         enBbTqueyvLuuPDOVSAzW2/AbYP8h+2TBN58ChG2YJb/EpEU2Mf5kxQxA+0Tv2ra+sg8
         Lnq6gWbxojeU68uDvp3yCP888hp9nsLwZ4zMKGlYRkb9XfyqSGJAvNpRg97TH0kmb825
         qtiyXzCD6cVYRC7/tj/WNz0DbR5MLgVz6NsTLYhVOLpqLMRk1yRlcvFcGA2pAQNjHNz1
         7QMOph3xxPFAPDnRNUeJyLHrnFw/VjPeJswM9sSXayWF7HWPVCF1vOD0tuz9G0Hu63EN
         8SGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=j+8RK9v8gWGa5a91FxFwYr8BWqBvGM+/s21xcS2xt8M=;
        b=Hl7EbbuzR5d9QIgUP58KG0qqD0ZvEc8179irOTlhp10kVfSuVjI3yWsQJvadnEzyH+
         kQcqb6iCpYUPY2vrwcd1Zls6QoQ7R1X3eyX70viOmmUj+G6R5isf6hrARjL8bDotEjOV
         hdO+wGws5fAFswAc4NBEPNNeHh642Bz3V2KyGypfAV7Px9K/FTfLoEXh2egpBjyDz0FQ
         ZdGrdn0vzxp7WpxjmyqZ6xpWFo6lvk5tPsy81hDMK6BggC1w6TIjyJ/E5YbyGnvdvpCi
         vd6pBUuTpPC+EF4O//VGV86I0IMgeD4lPbwnufqMCGKnwecnXoN1KVYxcmFATxqMAKry
         jc5g==
X-Gm-Message-State: AJIora+k9MRuA5ZM1QYYImxkyr23tFZ5XScOSmREKfRjWykuWJK6xu9z
        ItI9aVtwiaF6fWO4k2cqKR6Otzg97hFqiQ==
X-Google-Smtp-Source: AGRyM1sbZBfhPjfNH4IFyitf+1xGqss1Qja+bIDVjylaz/VxJhz5dXPtuOpvzJN6BZkHP1Y5/Smlug==
X-Received: by 2002:a65:464d:0:b0:412:6e9f:a4e7 with SMTP id k13-20020a65464d000000b004126e9fa4e7mr4709555pgr.104.1657753760197;
        Wed, 13 Jul 2022 16:09:20 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id d1-20020a62f801000000b00528c26c84a3sm84399pfh.64.2022.07.13.16.09.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Jul 2022 16:09:18 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 13 Jul 2022 16:09:17 -0700
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
Message-ID: <20220713230917.GE32544@roeck-us.net>
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
> >
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

Seen in drivers/gpu/drm/amd/display/dc/clk_mgr/Makefile:

# prevent build errors regarding soft-float vs hard-float FP ABI tags
# this code is currently unused on ppc64, as it applies to Renoir APUs only
ifdef CONFIG_PPC64
CFLAGS_$(AMDDALPATH)/dc/clk_mgr/dcn21/rn_clk_mgr.o := $(call cc-option,-mno-gnu-attribute)
endif

Does that explain it ?

Guenter
