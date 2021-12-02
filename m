Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B729B4668C9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 18:03:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347861AbhLBRHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 12:07:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234311AbhLBRHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 12:07:05 -0500
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A69DC06174A
        for <linux-kernel@vger.kernel.org>; Thu,  2 Dec 2021 09:03:43 -0800 (PST)
Received: by mail-qv1-xf29.google.com with SMTP id a24so73529qvb.5
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 09:03:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=C38w3ZZ18jbTTjlekVSCuVpjIpziGxAzWxW3SQkULxQ=;
        b=Dsheuy3KK9hD/uzKx1efwIdRoRSSs5vfMVLChkYAO4nx3Q/ZVNsxzqPy7LES5hIX8I
         v3pN0Mj7XPsnGPBBy4uHMea7AEgT4jgfpIxTaQr+cA0vRkAR9UYeTucYsutSyYO3Na8H
         Q5FfxhwYNRV+zCpyhndv9tdqarcoVPIQM+ZvF47rRa9ijJ8CqLsSA2fUYW+wIk/9ZLra
         yQKwBrkhHL5FDJRiQ1sMC7uIP4FK6sBBlaIcuSbskPLtXTL+tOjlcl2ndEM21d+9VOph
         TRPjl8fQQOlLCgmJy6MDFd7vh8eyMJpOz7UmAUzNJ2L795r3QGXG2IQc9F7vg5yNiqN6
         Ytbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=C38w3ZZ18jbTTjlekVSCuVpjIpziGxAzWxW3SQkULxQ=;
        b=LyvKPGgHF/ezS562uUMY86bioxVqc8i3q9GbBXnwdpfshRvts7fLCF+rF0AodTdvxg
         HGAQczXES3eJ07ZtkmKgqoPS3pTnpMCn5FOlO1eVTqhbuT6ZNu/McUziofqREAI2F5jm
         WOSJgyntYCCvOrQJxd8cwAA6GQUJTZQw38EB9RUdemaUbo7jAPaSOuzoa4iTQGhRN/Pj
         Rm4FKRuSRoJ0NOpT6e8MHibIGLHK/BlfWbH+gDXN1JNkTJrvyG9056tljrwb4RP/gp+E
         T0dNmcYmnDny4t1AkiXcx1djcSjVt5qZSfWttAqWgemS4uBiTv7xJ8RV2MXcB4sd63gB
         l0LA==
X-Gm-Message-State: AOAM532QE6bm2a/kYR+zBfKRYSYlMlWNKAOkusYGcDOevvrs2mHlILae
        N0K8CMaKllXrl42J+e7e11c0lrU5EtC/EQ==
X-Google-Smtp-Source: ABdhPJyI1EaGmExtViKyEZhF9KtLC5edTBPVzY5AF7F3/hFZ2ohSYUC5h5EH6tTt2sUIs0W9vRzlJA==
X-Received: by 2002:a05:6214:5097:: with SMTP id kk23mr14235502qvb.71.1638464622474;
        Thu, 02 Dec 2021 09:03:42 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id e7sm173963qtx.72.2021.12.02.09.03.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 09:03:41 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1mspUj-0071p7-9l; Thu, 02 Dec 2021 13:03:41 -0400
Date:   Thu, 2 Dec 2021 13:03:41 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Kees Cook <keescook@chromium.org>
Cc:     Bixuan Cui <cuibixuan@linux.alibaba.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        leon@kernel.org, akpm@linux-foundation.org, w@1wt.eu
Subject: Re: [PATCH -next] mm: delete oversized WARN_ON() in kvmalloc() calls
Message-ID: <20211202170341.GO5112@ziepe.ca>
References: <1638410784-48646-1-git-send-email-cuibixuan@linux.alibaba.com>
 <202112011944.28EF2FC44@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202112011944.28EF2FC44@keescook>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 07:46:01PM -0800, Kees Cook wrote:

> If we're rejecting the value, then it's still a pathological size, so
> shouldn't the check be happening in the caller? I think the WARN is
> doing exactly what it was supposed to do: find the places where bad
> sizes can reach vmalloc.

I think it meshes very poorly with the overflow work:

  p = kzalloc(struct_size(p, regions, num_regions), GFP_KERNEL);

If num_regions is user controlled data why should the calling driver
hvae to somehow sanitize num_regions (without bugs!) instead of
relying on struct_size() and kzalloc() to contain all the sanitation?

What you are suggesting just pushes security sensitive coding into
drivers, which I think is the opposite of what we all want?

Jason
