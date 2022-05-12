Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CA345253B3
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 19:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356892AbiELRbT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 13:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236997AbiELRbR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 13:31:17 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D445A369CE
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:31:12 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id c14so5444475pfn.2
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 10:31:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XagNVcsAwDnVbGgXVumYIiRNd5WuMQl7uKWl2bVu0dY=;
        b=RU+yCLmCHu7YQ0oeNJjyxZiB2tpfxTWnugc8GgBmz6zGe0kDVGYeSdv70Lti72Pryc
         /U1IMOsYdoidXtp8AKDz86br+dWmvGdF05cbBppuqf5rfPXpY+2PRReX+Tokl/4gbY+o
         S7ZH4Hm1oSHEBF16isFEUbPqiI8AXz7dPgzAFjX3KZaoSZ1BByz36PKAM0Ldj9AiYSrH
         /MgCEcs+MyccnWme3JbG+iquh9rL0OqBSXd9fs6A//Aj5HoNWzsBHKLpwaHzluLlfh2x
         7NQRB2h9Pk/VYYE45PmsSjhH0NSoJJyO+vIHIbzCqve2thjn+BY9Z31oPpxXPq3NNFBv
         /nLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XagNVcsAwDnVbGgXVumYIiRNd5WuMQl7uKWl2bVu0dY=;
        b=aT0Nb31S2gpoDLCiMZpa+KS2koPUaDU0mJo/mKscilXkK5/tIUk13wVf4SIK1egi/P
         7cATgxpWlJZTOD9cUEodGJdLumq78ZHi9C4pwwgSfXsODSJZj5nUROMOJwZeqEZiyWdl
         mc9khbTzY9++xNB8ejiwSOzFGPKV8bYIVE1/VEHZV/ND/BGRCXF1QWLmxXiOuLL3NgQQ
         OR6V+Q7/KrJO+PmpJWNqvt6xkf2wVN81V54a5u8ANNkDrG2fjLi3aT2NefIoomF5RgD9
         unEAlKB48pdOYk4ISbdwsF7c9n+gVVSXZMGFaFVHAfrAIEMCI8+bI5SKBXnjRf9jbZsU
         Tc9w==
X-Gm-Message-State: AOAM5332YqV9lnaPgvGoaqW1XcbUJxWAgfNqSnJbqhxrO/es2eJokxPS
        4WgV40qVbFwkgGbw2ythSguPetVm8LA=
X-Google-Smtp-Source: ABdhPJy6PeXOa2ttytOMkDQiQkDEzGbECMdtpHhT/MZ8eSVHruz7xyLgTq6k/GSn0L2PE0DiGo3Yqw==
X-Received: by 2002:a63:d450:0:b0:3c6:e382:c13b with SMTP id i16-20020a63d450000000b003c6e382c13bmr587228pgj.138.1652376672213;
        Thu, 12 May 2022 10:31:12 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id r7-20020a170902ea4700b0015e8d4eb289sm153095plg.211.2022.05.12.10.31.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 10:31:11 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 May 2022 07:31:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Phil Auld <pauld@redhat.com>
Cc:     linux-kernel@vger.kernel.org, mkoutny@suse.com, longman@redhat.com
Subject: Re: [PATCH] kselftest/cgroup: fix test_stress.sh to use OUTPUT dir
Message-ID: <Yn1EXjS+1FqAKkE6@slm.duckdns.org>
References: <20220512143439.26104-1-pauld@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220512143439.26104-1-pauld@redhat.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 10:34:39AM -0400, Phil Auld wrote:
> Running cgroup kselftest with O= fails to run the with_stress test due
> to hardcoded ./test_core. Find test_core binary using the OUTPUT directory.
> 
> Fixes: 1a99fcc035fb ("selftests: cgroup: Run test_core under interfering stress")
> Signed-off-by: Phil Auld <pauld@redhat.com>

Applied to cgroup/for-5.19.

Thanks.

-- 
tejun
