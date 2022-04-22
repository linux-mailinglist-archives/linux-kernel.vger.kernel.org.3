Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5119C50BCF6
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:27:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449683AbiDVQaB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:30:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1449654AbiDVQ3z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:29:55 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 129775EBD5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:26:48 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id l62-20020a1c2541000000b0038e4570af2fso5656158wml.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:26:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UQKwgkK7XcnD0Rg5dyzM5z8p1A79/VfuJ1pqbXYKM5g=;
        b=DB7OJJQM6ToLBwkgF1N6fJGkNaBv8n3ClPRlWkq03mVVL/VMuo988a/CRj/JU2y/J3
         LxIs6u2dVbU/dDDZQkfSypxNKRbl/F8k4++kuvNm1WnLAugDdOpzuNve1T0LTcewF0bY
         zmEP3SO2qgXPWgxHFH4ICYAlPt3RzE06HMA2A3AiJv7egQz6/emF65NCjuOgSU9ESYU4
         BDFntr1axQYaCcfEpgCW/juiNKBN5tRTlUoplhRG6UdiHRv6so2i2RIQqbOdUI5f8AnA
         6I5JDeixp+QaRbIk+MeGB/B/IoWYPnesEjbNFuitEtMfGJ/Nrz9uobpFuEWDZMT7afgN
         kKsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UQKwgkK7XcnD0Rg5dyzM5z8p1A79/VfuJ1pqbXYKM5g=;
        b=IHmV2LD74L33KsRl2lPIf6FXSLn7PU9FpqufcKrWxNfDEbeE7fctQUK+WK/hLwKP84
         5SemPVcNeMpkrRYwOCQu9W5Nqq0avG66DVmxQjY4Qk6rapXzuUVo2QMl56J4KfEJX78I
         QDvQitoHpuHr3Q1bvJpxFvDXMILefSbC7T2MdOdAWMMfGC9cfuEiyQcFwfMaLUYE0GFF
         wYzk/q4j/S/EmCU7AzkypumfIe36fNR1ZzU/Rh8/s3be8VIaJtWGLRgaXALqK8RhxFhF
         3CYTrXMFqAz3TCs1gn05GhJNR+DXk4JWKr4mxLp+wEIWjTuL9JsS0UDl1QEbDsD0ybPu
         pwPw==
X-Gm-Message-State: AOAM5324TA3TsMXK99jnE4rwvPX22tGoSY7anHFwulUT3/OUIfQghZPD
        5KD/sWjly8J37UMU1DYZY39syiuB/5a0Em2VYqzz
X-Google-Smtp-Source: ABdhPJz0usETe5tYcvsLPEcLUMTwIkTc1Rk3Ud2Ys3tDsyivrygwosiMcwEzjUWboIzGHFJlhESi2sq4OIiN1z5J2UY=
X-Received: by 2002:a1c:3b89:0:b0:38e:b37f:52d with SMTP id
 i131-20020a1c3b89000000b0038eb37f052dmr4774530wma.197.1650644806553; Fri, 22
 Apr 2022 09:26:46 -0700 (PDT)
MIME-Version: 1.0
References: <20220418145945.38797-1-casey@schaufler-ca.com> <20220418145945.38797-25-casey@schaufler-ca.com>
In-Reply-To: <20220418145945.38797-25-casey@schaufler-ca.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 22 Apr 2022 12:26:35 -0400
Message-ID: <CAHC9VhS04Q5BdOgJAo0QB-HZNSgCVRbp1-YZn7vitGfVrqyDuw@mail.gmail.com>
Subject: Re: [PATCH v35 24/29] LSM: Add a function to report multiple LSMs
To:     Casey Schaufler <casey@schaufler-ca.com>
Cc:     casey.schaufler@intel.com, jmorris@namei.org,
        linux-security-module@vger.kernel.org, selinux@vger.kernel.org,
        linux-audit@redhat.com, keescook@chromium.org,
        john.johansen@canonical.com, penguin-kernel@i-love.sakura.ne.jp,
        stephen.smalley.work@gmail.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 11:12 AM Casey Schaufler <casey@schaufler-ca.com> wrote:
>
> Add a new boolean function lsm_multiple_contexts() to
> identify when multiple security modules provide security
> context strings.
>
> Signed-off-by: Casey Schaufler <casey@schaufler-ca.com>
> ---
>  include/linux/security.h | 9 +++++++++
>  1 file changed, 9 insertions(+)

Acked-by: Paul Moore <paul@paul-moore.com>

-- 
paul-moore.com
