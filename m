Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16EC85A30ED
	for <lists+linux-kernel@lfdr.de>; Fri, 26 Aug 2022 23:21:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244601AbiHZVUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 17:20:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344716AbiHZVUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 17:20:44 -0400
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487518B39
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:20:41 -0700 (PDT)
Received: by mail-oi1-x234.google.com with SMTP id v125so3544607oie.0
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 14:20:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=8LX/LWZmqa6eGAYDU2BrYIU+cWB57WWRs6WluHAKqX0=;
        b=S1I3a6uY5L7Y/jAwrrjQfT+MElLrT3t4+XRnTSCiDk18s1DhVAd8be3FaOAHXKBew5
         8cYKFjEviU9F5jUS0dgqbFvN+ptv2FP055xXYJugSpR+Z9HRn4jKIc54flBcDJaRwiGy
         ELMiNO4H271uGGlZ5iMwAIx2Imu4HP1Mhyk3yUUJis+riqhYZxk9GKz+/8oJbhywAWnm
         pezaE0Z5GPTw1+XNfqmj4+10wz1uAlDXgizaoEuMzy77GxdHttcfagsBol3Z9+YvnGyt
         CLPHANkO2JpNvJ1zQgmfYu6Ggf+yCa5SdBwtzg9aac+aZhGtdYu/8AUj7CHdnWJ/VwIb
         35Og==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=8LX/LWZmqa6eGAYDU2BrYIU+cWB57WWRs6WluHAKqX0=;
        b=iOS8E5jira3ekKzL/4+JUGNbIYUHb98197f/SMsXQwYyVWK3G4WihVm8DBUvlDQV4N
         g4MLXTdltZfXikXcGWv577NVBbAWYaMCmGPpBMC+IGU9TKuPsZg9eTpPknhgxgXdWRfR
         bOeN/u+uxXMo6/zL3Wc1grH6pufT3998e63sBo0TE4i+KHQPRDVSKZCQlKOXNcLUo5yn
         K7kDybU3SKC3DSdU6AunN1YK4m9TWJ6CIUpJtA/r5AmPEMcpomIULrt1pSVBhe/Lh0HN
         WzsMGPG/5ctwptZNTio0excQRf2VIQps3yeQ5ePxUNu3FkrLwbeFpfV/GUDq9EMo3pCl
         GrnQ==
X-Gm-Message-State: ACgBeo0EgVjU7M/B+z3809KNq2zuPt3xDMkiBh01TNTc249kN5nkxNPN
        J+LONR0Mg2HGYxMYXnVzOtdivcHNszuzy3qDu1rvd447t/JA
X-Google-Smtp-Source: AA6agR5qWLhqOOTSHmpbGvQVdH0QmxCHUjR5sZokf5s6WIW/9TEpoDZl2pcr80/wKgay4WYe18gGsc9v6kB0Y9ZA4G0=
X-Received: by 2002:a05:6808:3a9:b0:343:4b14:ccce with SMTP id
 n9-20020a05680803a900b003434b14cccemr2523259oie.41.1661548840989; Fri, 26 Aug
 2022 14:20:40 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1661449312.git.rgb@redhat.com> <c925257a4e99a76f8a8efef014a58ca7af40d537.1661449312.git.rgb@redhat.com>
In-Reply-To: <c925257a4e99a76f8a8efef014a58ca7af40d537.1661449312.git.rgb@redhat.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Fri, 26 Aug 2022 17:20:30 -0400
Message-ID: <CAHC9VhTC_CSQK9r0aEC4cAaAS04XhGZGSW7JdqRAB13OBtVL4g@mail.gmail.com>
Subject: Re: [PATCH ghak138 v2 3/4] audit: free audit_proctitle only on task exit
To:     Richard Guy Briggs <rgb@redhat.com>
Cc:     Linux-Audit Mailing List <linux-audit@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Eric Paris <eparis@parisplace.org>,
        Steve Grubb <sgrubb@redhat.com>, omosnace@redhat.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 3:33 PM Richard Guy Briggs <rgb@redhat.com> wrote:
>
> Since audit_proctitle is generated at syscall exit time, its value is
> used immediately and cached for the next syscall.  Since this is the
> case, then only clear it at task exit time.  Otherwise, there is no
> point in caching the value OR bearing the overhead of regenerating it.
>
> Fixes: 12c5e81d3fd0 ("audit: prepare audit_context for use in calling contexts beyond syscalls")
> Signed-off-by: Richard Guy Briggs <rgb@redhat.com>
> ---
>  kernel/auditsc.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Merged into audit/next, thanks.

-- 
paul-moore.com
