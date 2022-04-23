Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7847850CA84
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 15:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235712AbiDWNVB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 09:21:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233341AbiDWNVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 09:21:00 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F72B2117E5
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:18:03 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2eb2bc9018aso93140367b3.18
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 06:18:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Jmlk3DqwaEBaVBLzTd1kbUUz4icf8kJ9wDD4tXETqTs=;
        b=tcW1c6qW82jBz5nCN0RwRIROmBDXBjYQaBTvl6CyaY4jryJ3rsU/VWZVvv/lgdk8Oq
         F9Ozp10PiNVyjEystyc6dusqsDvapLv1MpcKsLK/XtqZHAZ9jl75ugUrBIiH5m7d4ah6
         WiMGHgI09mOdrk1FPHaZOFnWcnisHKbgrUP6x/UhwdNs7R5wuqds4PoZi/LZj+tCdjJp
         uTuj3/6WoxFYMMaCG2i6V8aCN+0nLElxw3mDuLxkyumtJpwy7W0Xneuf5YMswqhGju+U
         Af+Id7zSqX8aWeY0EFFTMfOOLbwaR6qbKAO4lnAApOIEoI0tGboj149z5WPnzVXdPJ5z
         TB/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Jmlk3DqwaEBaVBLzTd1kbUUz4icf8kJ9wDD4tXETqTs=;
        b=nArYQRqkJ3tSe+ZSRYwiXiOIdL0VPcGx6pv/ZFXWbXE5EmkK9V4m8b74K+/YdAbXVy
         MEQTjTpKo2P6vEJDulAmrR6o0c6Ak4H3f00+ejxrHAiM3y3gj81qDwqEWAECcPoBcKGN
         IpEXFfBsHmJMQH6S6SX90TzgAPnlot+6Xv/OXyT75gVk48QxJZyF8QHkx53GONUijLji
         ZvmGmVTBJbxLWHg7fEFlXnEWeFimTWSXYye9cviRt7wvMmPgAaTEWoag3xR70kRGk/yq
         s/WjBI9PiPvhWpoMWxTvGV3a9o/NY6uvrp/GqpwfqJx8I9NwH4R56MEXw1w5uLlHpP9Q
         e9PA==
X-Gm-Message-State: AOAM532Nu8/cx+WbHQfWRpTFHBqh+1dMbujVIUbwCOUeiIqaiWIvatPm
        xDvFnGSvUfGI+Kng5Kxis7//fh7RnEFMtA==
X-Google-Smtp-Source: ABdhPJwqNQuWBP+rr8jYh//2Me7hXgMWRhcR2bSBcY24fHQjz0IW8s8sTvGb/a3zNb8YnbOsn/JtZFHE1VwkAg==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:bb43:0:b0:645:43cf:736c with SMTP id
 b3-20020a25bb43000000b0064543cf736cmr8648089ybk.493.1650719882767; Sat, 23
 Apr 2022 06:18:02 -0700 (PDT)
Date:   Sat, 23 Apr 2022 13:17:59 +0000
In-Reply-To: <c60767c9-03fe-2c9b-9844-752ef0df5b03@openvz.org>
Message-Id: <20220423131759.dv5eqdpdfoa2drh4@google.com>
Mime-Version: 1.0
References: <c60767c9-03fe-2c9b-9844-752ef0df5b03@openvz.org>
Subject: Re: [PATCH] mm/memcg: minor cleanup in non-memcg_kmem version of mem_cgroup_from_obj()
From:   Shakeel Butt <shakeelb@google.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 23, 2022 at 05:23:03AM +0300, Vasily Averin wrote:
> Replace leading spaces by tab:
>  WARNING: please, no spaces at the start of a line
>  #X: FILE: include/linux/memcontrol.h:1480:
>  +       return NULL;$
> 
> Fixes: commit 8380ce479010 ("mm: fork: fix kernel_stack memcg stats for various stack implementations")
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>
