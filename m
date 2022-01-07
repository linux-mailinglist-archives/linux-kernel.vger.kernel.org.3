Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F45487E29
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 22:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229844AbiAGVWh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 16:22:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiAGVWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 16:22:36 -0500
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B571EC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Jan 2022 13:22:35 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id l8so3594568plt.6
        for <linux-kernel@vger.kernel.org>; Fri, 07 Jan 2022 13:22:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KVvdzrCcejlgQyEU53DIDORePmYECEDbLTKf/bOJTBs=;
        b=j56nzy8NR0wF9HzkCnybljDYBlT6C1NLe96tegGlFyiCN0ZQY3X/6ygOg/ocFmqOHl
         e/U7zYStfYmDh/1uyKpuw5eJTYg4j5CwNzufJcEps9gGot0N6dSTlZoeZymFRV39adAN
         PlPSwxFrhRGWB9ImrwOSKqzGRHLyX/qAkk5Yj4fAuGTZ0SCc7yrtkhhU9hhDdJN3Q5yc
         Ccqg9gQJIG+DSKLiSz9n0Ddd5vdImlHsVec2VINvpOf3YtAmXG4j94Y0+i/Sw1nw/y/y
         0hGK5Egl7yjxQQAD7vPLryaObdj8t1OgTxGqkD556SSaDfU8g+bcI1tSzYvYGWQaO0u0
         CtfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KVvdzrCcejlgQyEU53DIDORePmYECEDbLTKf/bOJTBs=;
        b=vZpnjj+iYovm4d/8aqB5nm+dxDXjLwexzS8TmEtF/bUJpLTHZvkKmvXERNncuAlBfz
         77u1X3Qm/5ANyoriJKvCrzhoAWjdP0BGUm13jw7L5kzDhi0J3mqd0qrcV6UTiW/6tnDi
         cViHZNqBIKEa9LS1xR9geAoZI9FXk0j9bw9GSPgLL+F2fM3utrfFWsYQhI8h1Q6Dwb9W
         rbOexSyiz9ZCGwnc0wlSqCOC3d9/XrsojGIY8HIG8M3ezMVc8Efs4OJnSqo3fTGlmqHu
         4wajOT60iLbevRSr0o6lZJSk3PuNEZ7fpy2F5JIwCiZcDDxgxUk43hExiINV66sFrwGI
         PaSw==
X-Gm-Message-State: AOAM530MJevEb1HMARyrrOZz9usU83A4se38Gr0ULk/c0SPyzLCj4kYb
        7+D17GtZrFg8dZgueYQtL3mNzeXQKaToVw==
X-Google-Smtp-Source: ABdhPJz8hfo0ngRKapUTF0FggKy5Bn1vN7j6vfshMhaRBdQSpCbfLT2EchyP4OQDA5ohlqpMTzNN/g==
X-Received: by 2002:a17:90b:4d90:: with SMTP id oj16mr418981pjb.158.1641590555046;
        Fri, 07 Jan 2022 13:22:35 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id y10sm7690983pjy.24.2022.01.07.13.22.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Jan 2022 13:22:34 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 7 Jan 2022 11:22:33 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nitesh Lal <nilal@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz <nsaenzju@redhat.com>,
        Christoph Lameter <cl@gentwo.de>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: Re: [PATCH 2/8] workqueue: Decouple HK_FLAG_WQ and HK_FLAG_DOMAIN
 cpumask fetch
Message-ID: <YdivGRl9GoMvhdR7@slm.duckdns.org>
References: <20220104144944.1278663-1-frederic@kernel.org>
 <20220104144944.1278663-3-frederic@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220104144944.1278663-3-frederic@kernel.org>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 04, 2022 at 03:49:38PM +0100, Frederic Weisbecker wrote:
> To prepare for supporting each feature of the housekeeping cpumask
> toward cpuset, prepare each of the HK_FLAG_* entries to move to their
> own cpumask with enforcing to fetch them individually. The new
> constraint is that multiple HK_FLAG_* entries can't be mixed together
> anymore in a single call to housekeeping cpumask().
> 
> This will later allow, for example, to runtime modify the cpulist passed
> through "isolcpus=", "nohz_full=" and "rcu_nocbs=" kernel boot
> parameters.
> 
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Juri Lelli <juri.lelli@redhat.com>
> Cc: Marcelo Tosatti <mtosatti@redhat.com>
> Cc: Nitesh Lal <nilal@redhat.com>
> Cc: Nicolas Saenz <nsaenzju@redhat.com>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Christoph Lameter <cl@gentwo.de>
> Cc: Tejun Heo <tj@kernel.org>
> Cc: Zefan Li <lizefan.x@bytedance.com>
> Cc: Alex Belits <abelits@marvell.com>

Acked-by: Tejun Heo <tj@kernel.org>

Thanks.

-- 
tejun
