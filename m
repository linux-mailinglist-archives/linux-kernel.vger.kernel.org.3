Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id ACDBD49B6AF
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 15:45:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388976AbiAYOol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 09:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1579870AbiAYOkn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 09:40:43 -0500
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E2D6C061781
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:40:41 -0800 (PST)
Received: by mail-qk1-x733.google.com with SMTP id s12so24709061qkg.6
        for <linux-kernel@vger.kernel.org>; Tue, 25 Jan 2022 06:40:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gtrPmzwuc49PRDcKSoMWbGgV3vDQg/A9aITmSjuzp5c=;
        b=g1fQpKeNAHgn9G8Omr0cljidyKQ3ENNVBrAJmALmgqehDrb40DaX8BQY+PzqLEJeq9
         8Ju+pVg6yx3/nYZnsCiCAKOgJpFO/o081p79KVhTcRQvnPfVGP/YOgiFLNt49d8W5kO1
         UACjHga4PuMhduxst5D7SG1SwibPnayMnti2RB3KciYWwdVKcemFTgb9ptcd6jMVmT46
         HsQjEm6PGHOjarzAf1htN0pDGqxw728n7mhMAHtU1PnquagyK4d9aFCLHTASS7YSFnX/
         PTSKGqGAi1nGvMcgALpHVkDsxVp6eLJ17WuWrI59bAFNYAyqjaylr9Sq99tHNG9rY+mH
         ifpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gtrPmzwuc49PRDcKSoMWbGgV3vDQg/A9aITmSjuzp5c=;
        b=L46CRVo8NMyYi44F0PWEYl0Jf25pfBwvRa1FV0i6owPKHO1u+I9WLgnrdYm6bhKC9v
         Tszzf9JE3jLTm2b7Yixe5gISDxiSsDyNBO4NZPmpc4pjmOLJTuqSaPIQJ2C62937yDbh
         sFnrWuQwaqKeOZO3wsk2y6GbUIaDNXvt/P9GJltzY12ExJRuqTjBu08tRGHthzTUOxaU
         7JVIZnRvP+lce3wvw/oV1Rpiige1ArA8ZShofJ3z5AcZY4rbM/LaskN8NQsYCvtrJNk+
         2m3LTwtbQ6SC9iIbGdJ4miPsg4PNpjO1HcXQ26MU8QCZgh1g5C8/AkelKwIrFphRGwNT
         2FpA==
X-Gm-Message-State: AOAM5303ZwceaGZGQbOwTdEBaHfhQ91cG+BydN0RanxZalRJpPybI9wP
        dYpFBgqVLENlZhpLeorY8AqiQcS5utmLzA==
X-Google-Smtp-Source: ABdhPJyRZolfkQavX9zknwnVBh+FWcx40CHIQtmwXZZ7myvC9M8hi9kfamtRYMhgnfy90nzpnZEcsQ==
X-Received: by 2002:a05:620a:56a:: with SMTP id p10mr1893232qkp.102.1643121640735;
        Tue, 25 Jan 2022 06:40:40 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id h10sm9606707qko.90.2022.01.25.06.40.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Jan 2022 06:40:40 -0800 (PST)
Date:   Tue, 25 Jan 2022 09:40:39 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Huangzhaoyang <huangzhaoyang@gmail.com>
Cc:     Suren Baghdasaryan <surenb@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        Ingo Molnar <mingo@redhat.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv4] psi: fix possible trigger missing in the window
Message-ID: <YfAL55Xydar/jKrl@cmpxchg.org>
References: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1643093818-19835-1-git-send-email-huangzhaoyang@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:56:58PM +0800, Huangzhaoyang wrote:
> From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> 
> When a new threshold breaching stall happens after a psi event was
> generated and within the window duration, the new event is not
> generated because the events are rate-limited to one per window. If
> after that no new stall is recorded then the event will not be
> generated even after rate-limiting duration has passed. This is
> happening because with no new stall, window_update will not be called
> even though threshold was previously breached. To fix this, record
> threshold breaching occurrence and generate the event once window
> duration is passed.
> 
> Suggested-by: Suren Baghdasaryan <surenb@google.com>
> Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
