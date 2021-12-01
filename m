Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 847214652BF
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 17:28:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350693AbhLAQcE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 11:32:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350783AbhLAQb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 11:31:57 -0500
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3548C06174A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 08:28:36 -0800 (PST)
Received: by mail-pf1-x433.google.com with SMTP id g19so25015633pfb.8
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 08:28:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8+dtO1c88vu6uFSfXlhgdyr1qRRT4pb+0Qvd0uUFgcQ=;
        b=BzxPbu8Y8ILor1FygIY/Ap82Y0BzY6clCKjLKLIazW4+Yxs+WCJI0j0yhhfYss/41o
         X6FKLQEaKTd4DXvpfGI6TDpYf6DZq5cNa8OLtq3Z5BYJCXlWHUP2P5tBZSako7hw6qid
         MSopTLF12dRwpIjhJHqfpu38ukd6FaIiRXHvWc64v6w0OFGyXRM2rlFlk/C9w0hL0ht9
         2jE9DZpk6fJmbHBOflvlSXeDecjy+os1Xr1lp1d9+hRQMzmGtuRNMTVXiClhzYL6WtUw
         4LoeuWlb7TPqrDOmBuloS3TNKldTjJVRyE+FoXnz1IDRiJ2zTHtudeIe+yTAwnYFXUpy
         VvfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=8+dtO1c88vu6uFSfXlhgdyr1qRRT4pb+0Qvd0uUFgcQ=;
        b=Vake/9vcDSP0DKtlQ4Rhakz6uofXrYmsHnTff6umRpI54bzyLKEVH+fV6JU8+5pARP
         bvqPJh3Cf9aFS6yBGnyysdByEeeanNp/ueK2+G3Li9zQsgTOq9UaDOkJ3v8Ay8UDgDT4
         dbzLbGUJ+oaZTKQnUf4lDHiiPiLOOzNIAYwaoa0RVjYPcYlypYhrDRRDgt7qq3D1cT0E
         p9zcr3JAKoTJqoPnkhg73pDZtSpXR44TGlNZsI4t9ppD82ctX5w/8C5y3lr91/+PfJx7
         IhWe5AF4kX9+KIcVblhLcDbgv0fCVSWykE1URuUhVx4Rcp48SNlu/nLCxqEiimZ/Tv9y
         YqxA==
X-Gm-Message-State: AOAM530n9Gt/67u2Z3ym5viu1YS7+GQsi3ZHkyw9KZjaV6bAu3x5ZEXm
        39A5fUtRKS+gprZj2LdDqpA=
X-Google-Smtp-Source: ABdhPJyu4Lnf2hiooVLo5lmuADS5ioZqbAPiZ/AvSTo/pgWt0rssBnCg1XrLUgPWhnau68/qZIKa/A==
X-Received: by 2002:a63:1ca:: with SMTP id 193mr5442491pgb.88.1638376116059;
        Wed, 01 Dec 2021 08:28:36 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s72sm175454pgc.69.2021.12.01.08.28.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Dec 2021 08:28:35 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 1 Dec 2021 06:28:34 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH 0/2] workqueue: Fix hotplug/scheduler races
Message-ID: <YaeissBqeatm10+w@slm.duckdns.org>
References: <20211201151945.632214-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211201151945.632214-1-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 04:19:43PM +0100, Frederic Weisbecker wrote:
> It's a resend of "[RFC PATCH 0/2] workqueue: Fix hotplug races", with
> appropriate tags added and scheduler people Cc'ed.
> 
> Thanks.
> 
> 
> Frederic Weisbecker (2):
>   workqueue: Fix unbind_workers() VS wq_worker_running() race
>   workqueue: Fix unbind_workers() VS wq_worker_sleeping() race

For both,

Acked-by: Tejun Heo <tj@kernel.org>

Peter, Ingo, if there's no objection, I'll route these through the wq tree.

Thanks.

-- 
tejun
