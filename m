Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE0084785CC
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 08:59:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232146AbhLQH7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 02:59:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbhLQH67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 02:58:59 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABEB0C061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 23:58:59 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id c6so1198240plg.3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 23:58:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=eefAs3uL+WsP/rtSEU8dzklWrmIu4i6QjwBqLTZ/hfY=;
        b=QO3SKqr3s85NIH6folKr6ARjtdn0FpcSWxAjYQ8Kf1ArQ9TkSxAnPeIJ7krpgXH2T3
         BKDPoIyntL67rtMaKjxle/N47TRbO8CqZmNRgIncJ0MWqfgm7lFSYl17Du/cczt2GIRL
         BQylFmGXml80PFh3D54WALi1dRHYdIjI6v12GzeZvvkOPNlrMVHA03AfDreIPLzSuUOL
         hqyZNLmMOeDrcP1fOfJ/PgLRP/tpqUWNZ9haCKNd/w1JFcoYCdtsPl3OjT+a3ENT7YXG
         foY3G/Z4T2lOUmOg80dXjexkbVim7u1HvMRXHrHBhmOpMknudR31X4dvYoAbPo4USPys
         akpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=eefAs3uL+WsP/rtSEU8dzklWrmIu4i6QjwBqLTZ/hfY=;
        b=AiXrXTVl1GtZYRhdtdbJBRWXOhx1CBAuhBLdzU27hmGdmJw9DnROF1kbh2uyorGWiB
         670gNzqFlyxz9oM1Vs6zaM//6rYbBdjPRweD4rWXKxH5LHs6lCmBqBqu5nd2nZxWrifm
         M8Z7j6y9qliOcnu1Sbb1qlCaQPqSkttjakffgg8U4Aq1/Eo6nwq1dj3HYzFZdNlBmckq
         XY5yuyImV3eKHqtisEqMrHHVNc0YzkQsVfh363R10FHMv46GE/saMAHQ4sV87DVOw2JZ
         stkV+aiBcFtkMb2gtW5RVbxuw/ykyQQPgKTTcbk3+Z59S4pI3IMLTyhbmbp3RNR1jeHs
         8Ubw==
X-Gm-Message-State: AOAM530423A9X4gWbG93D7dPr5xEfa9BnjYQVF+acEA/d1MfiFw1tMKj
        GZWQ9uU7uTcbe58Ze+qRMFmGdA==
X-Google-Smtp-Source: ABdhPJxrzU37n52OwF5xrWjQsktvMG10nV6vo8UF0tY2+s1bHeuacDCJcm1DJJtgW2C8aC2i8PoCvA==
X-Received: by 2002:a17:902:8346:b0:148:b843:751a with SMTP id z6-20020a170902834600b00148b843751amr1887639pln.141.1639727939034;
        Thu, 16 Dec 2021 23:58:59 -0800 (PST)
Received: from leoy-ThinkPad-X240s ([204.124.181.134])
        by smtp.gmail.com with ESMTPSA id w16sm7674003pgh.81.2021.12.16.23.58.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Dec 2021 23:58:58 -0800 (PST)
Date:   Fri, 17 Dec 2021 15:58:50 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Kees Cook <keescook@chromium.org>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Sami Tolvanen <samitolvanen@google.com>,
        Nicholas Piggin <npiggin@gmail.com>,
        James Morse <james.morse@arm.com>,
        Marc Zyngier <maz@kernel.org>, Joey Gouly <joey.gouly@arm.com>,
        Peter Collingbourne <pcc@google.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        James Clark <james.clark@arm.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [RFCv1 4/4] perf: arm_spe: Dynamically switch PID tracing to
 contextidr
Message-ID: <20211217075850.GC371207@leoy-ThinkPad-X240s>
References: <20211021134530.206216-1-leo.yan@linaro.org>
 <20211021134530.206216-5-leo.yan@linaro.org>
 <202110210848.35971643C6@keescook>
 <20211101152835.GB375622@leoy-ThinkPad-X240s>
 <YapEUlcyDZ6TuE6n@arm.com>
 <20211205135103.GA42658@leoy-ThinkPad-X240s>
 <Ya9J8HnMWxBy3MJv@arm.com>
 <20211207123118.GA255238@leoy-ThinkPad-X240s>
 <YbDrhQLeBdn0wqKT@arm.com>
 <20211210075918.GD622826@leoy-ThinkPad-X240s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210075918.GD622826@leoy-ThinkPad-X240s>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 03:59:18PM +0800, Leo Yan wrote:

[...]

> > You could also check there if the PID is in the root
> > namespace and avoid setting CONTEXTIDR (or write 0).
> 
> This could introduce mess.  Writing 0 can lead the decoder to take it
> as idle thread; if skip setting CONTEXTIDR, the tracer might use a
> stale stale PID number (the previous one ID number).
> 
> Alternatively, if you accept to always set PID to CONTEXTIDR in
> contextidr_thread_switch(), it would be fine for me and we can only
> need to control PID packets in SPE and CoreSight drivers.
> 
> Please let me know your opinion, thanks!

Gentle ping, Catalin.  If anything is blur and you want me to clarify,
please let me know.  Sorry if you are in holiday and if so we can
delay after holiday.

Thanks,
Leo
