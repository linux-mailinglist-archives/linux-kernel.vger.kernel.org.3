Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8E33584557
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 20:08:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232849AbiG1RvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 13:51:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232697AbiG1RvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 13:51:14 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A92B22A408
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:13 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id id17so1422640wmb.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 10:51:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=YlUW33qUz1u3QNCrgfswPy2v8jgmUdUSwTGtmme6eU0=;
        b=gDYHTL3xoRdr9vSsvTGmVAXGy9L+evVGkWjk2OYYBZuR3GD/xaOvfRkn5MD9/JBvBS
         1RG64ID8OmN79RzUkupMYuRwR9GVfZ8Vhv/H4sStkU54BxKUX3rgso3H4KtGUU9T56hh
         KVfvjsoxRlp6eOr1RznozlMDbt3+I11MFFR4OURGxDxXIjcX1gKbM9E0uMybS9JV2vVa
         BLwoHeAk3b1rF3BPi45vczhNH9mhBCtEfJKcgi9u0a056e4c64yrlyBkc4sTtU0g0zVr
         +0OABpJqa8AmK0MimMB8sHLzCPwiVgSpOYlQQhAmG74kvPB1W66EWov+AVSVGOquACHr
         X+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=YlUW33qUz1u3QNCrgfswPy2v8jgmUdUSwTGtmme6eU0=;
        b=YHqPvN0u+nusnXhvlRg2k8NqVFWkN7LllejLdVQ0EmKblMlydBrj329WwTnaJH7WF8
         a2XmctDYJmCJ34SUZvuXn6LqOY345NmsvuVm26mEWmusUa9XyMUP/8A8GX1/GMVNTcAk
         jHyiOz5b6PRubwh7yK/PeES4PkV4MV62gJ+EsldwIGaoouCYgfVoHpR9+7OPf4fcP3Jr
         UM8hqX2j2OskUc2dzXRIq1OjBhoslNiLIzNbJnBvte8kYwyuINyuMopTvh9om5XH3o+c
         kUTgUqGlEOjz/1IvrrfvgMJJr489D+eDOedQR9iFgfhzkwLfqEnUeqPG/3OZs2pbpqod
         PmQA==
X-Gm-Message-State: AJIora/FROld/AH9V2J7tGa/sKSbXnME1GERFrE2eTbbIZltmpWPMwCi
        RKLf4Nva7Om0DoE8ILyW5HU=
X-Google-Smtp-Source: AGRyM1sPPRMmaaBCJ523PjfKUrU6TnxSMuf4S7TtJszu0YhyO9G/4nJ7bk51F33yS1etRuoMHzthGQ==
X-Received: by 2002:a05:600c:510f:b0:3a3:254c:b081 with SMTP id o15-20020a05600c510f00b003a3254cb081mr345788wms.65.1659030672106;
        Thu, 28 Jul 2022 10:51:12 -0700 (PDT)
Received: from elementary ([94.73.33.57])
        by smtp.gmail.com with ESMTPSA id n40-20020a05600c3ba800b003a2ed2a40e4sm6526699wms.17.2022.07.28.10.51.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 10:51:11 -0700 (PDT)
Date:   Thu, 28 Jul 2022 19:51:08 +0200
From:   =?iso-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
To:     javierm@redhat.com
Cc:     davidgow@google.com, dlatypov@google.com, tzimmermann@suse.de,
        mripard@kernel.org, daniel@ffwll.ch, airlied@linux.ie,
        maarten.lankhorst@linux.intel.com, jani.nikula@linux.intel.com,
        maira.canal@usp.br, isabbasso@riseup.net, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, geert@linux-m68k.org,
        dri-devel@lists.freedesktop.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 0/4] KUnit tests for RGB565 conversion
Message-ID: <20220728175108.GB52359@elementary>
References: <20220726230916.390575-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220726230916.390575-1-jose.exposito89@gmail.com>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 27, 2022 at 01:09:12AM +0200, José Expósito wrote:
> Hello everyone,
> 
> This series is a follow up of the XRGB8888 to RGB332 conversion KUnit
> tests.
> 
> As I mentioned in v2 [1] I suspected that the inconsistency handling
> the endian might need to be fixed.
> Fortunately, Geert Uytterhoeven fixed it in commit 4d9db10576ff
> ("drm/format-helper: Fix endianness in drm_fb_*_to_*() conversion
> helpers"), so I updated the tests to reflect his change.
> 
> Changes since v1:
> 
>  - Fix a bug reported by David Gow in the XRGB8888 to RGB332 tests
>  - Simplify the test structure as suggested by David Gow
>  - Add Tested-by Tales L. Aparecida and Acked-by Thomas Zimmermann
>  - Fix link in the last patch (Thomas Zimmermann)
> 
> Changes since v2:
> 
>  - Test endian as fixed in commit 4d9db10576ff ("drm/format-helper: Fix
>    endianness in drm_fb_*_to_*() conversion helpers")
>  - Fix Sparse warning reported by David Gow
>  - Add Reviewed-by David Gow
> 
> [1] https://lore.kernel.org/dri-devel/20220709115837.560877-1-jose.exposito89@gmail.com/
> 
> José Expósito (4):
>   drm/format-helper: Fix test on big endian architectures
>   drm/format-helper: Rename test cases to make them more generic
>   drm/format-helper: Support multiple target formats results
>   drm/format-helper: Add KUnit tests for drm_fb_xrgb8888_to_rgb565()
> 
>  .../gpu/drm/tests/drm_format_helper_test.c    | 169 ++++++++++++++----
>  1 file changed, 139 insertions(+), 30 deletions(-)
> 
> -- 
> 2.25.1
> 

As suggested by Thomas [1] I pushed the series to drm-misc-next.

I've found some conflicts in drm-tip in unreleated files I'm trying to
figure out on IRC though :(

Jose

[1] https://lore.kernel.org/dri-devel/4ba57f80-5025-c3a0-5f65-ec52643f0122@suse.de/
