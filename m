Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 59B5F49D470
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 22:25:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232184AbiAZVZa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 16:25:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbiAZVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 16:25:29 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F0BEC06173B
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:25:29 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id b15so748934plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 13:25:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8cYOSIzBeCCvl67dzxyoTm+jt5+mbY2FFXmHT/tqjIQ=;
        b=PCUgqceqh1J8Pg5J8m0EehUb0kzu76DXX1+6cMdvMptnq/vniCHtGOLU1kymRnNNj8
         vfoe9Q2AzKsC92YdsV+tGK0PI6dDTHsNV4N/7V19vQS6OH5s1Geq0610TguiEtogA/zR
         ygAUle1h34TgIhnKGKOkGszhzJb6S6BxjKZXQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8cYOSIzBeCCvl67dzxyoTm+jt5+mbY2FFXmHT/tqjIQ=;
        b=bOlF9athhNdVp5oZ1R0JkaY/Rk2nzwRTCkwZldm76YE0rDmRyun2uYHMASdWIDtQiv
         C0vHpr36rE7EsPuyKEHQMkpeJNauDFhh+HZMgI01INapcdhyjaWxwrludZ/YogPODDxD
         F1a9s0+GW0jgLHQE3tAiAl+vhTvmgE+hjP3x8iz0NOVtK0U3jtlxkWQe3hhWzdKDdTtH
         Hn0DAIEWRr356RX/4s4fUV7MBglNQ1zBIp6yPvjE10PK/i1Qme2IAuduBaRS7m9HKk+J
         5Gq5+HXcqpV0yUKnBbolxktqeJFVzpEr+vJGNad98M4vSWaIV428PzNDUwYnNjg2TJ++
         T03w==
X-Gm-Message-State: AOAM5330eOwQ08IEBLSUtXu3jEXl6nChtbhWt414xFZfuRdCO0/EtOyd
        +nmSk4fyo2jpWJHgLXyvD0GvbuLOdiUetQ==
X-Google-Smtp-Source: ABdhPJzZkMjLb/kAeRvM5EtITBXTJXdFe7H7QLq1NH2HE2lwIkyTbbOxzNtSIZL7KwDC4i9mayEjLg==
X-Received: by 2002:a17:902:7d8c:: with SMTP id a12mr528436plm.75.1643232328685;
        Wed, 26 Jan 2022 13:25:28 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id a13sm4839110pgv.27.2022.01.26.13.25.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 13:25:28 -0800 (PST)
Date:   Wed, 26 Jan 2022 13:25:27 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Ariadne Conill <ariadne@dereferenced.org>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        Eric Biederman <ebiederm@xmission.com>,
        Alexander Viro <viro@zeniv.linux.org.uk>
Subject: Re: [PATCH v2] fs/exec: require argv[0] presence in
 do_execveat_common()
Message-ID: <202201261323.9499FA51@keescook>
References: <20220126114447.25776-1-ariadne@dereferenced.org>
 <202201261202.EC027EB@keescook>
 <a8fef39-27bf-b25f-7cfe-21782a8d3132@dereferenced.org>
 <202201261239.CB5D7C991A@keescook>
 <5e963fab-88d4-2039-1cf4-6661e9bd16b@dereferenced.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e963fab-88d4-2039-1cf4-6661e9bd16b@dereferenced.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 26, 2022 at 03:13:10PM -0600, Ariadne Conill wrote:
> Looks good to me, but I wonder if we shouldn't set an argv of
> {bprm->filename, NULL} instead of {"", NULL}.  Discussion in IRC led to the
> realization that multicall programs will try to use argv[0] and might crash
> in this scenario.  If we're going to fake an argv, I guess we should try to
> do it right.

They're crashing currently, though, yes? I think the goal is to move
toward making execve(..., NULL, NULL) just not work at all. Using the
{"", NULL} injection just gets us closer to protecting a bad userspace
program. I think things _should_ crash if they try to start depending
on this work-around.

-- 
Kees Cook
