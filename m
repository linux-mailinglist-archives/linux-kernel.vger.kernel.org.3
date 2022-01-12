Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E0F448CCEF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 21:14:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357335AbiALUOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 15:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357325AbiALUNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 15:13:43 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0498C061751;
        Wed, 12 Jan 2022 12:13:42 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id oa15so7297303pjb.4;
        Wed, 12 Jan 2022 12:13:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XMI3dbv7S6q2jB5/NVdmh3pFl60FzTgbFc2uAC8p4kQ=;
        b=WNdGX4sWq7OTOq6tvGxIIKvH3UBlRIANC2Pv4V6m0hc0ZZLdjqFY8Jtl6Q23Qq5e2G
         jHU+I5ciqJ8LhYAJBYBZuT6b5/cWT6ZC9iGb/q37U7Jm1bfZmKdOCueEdeUfZTqxLFVi
         rOEmnW3bKlifhvohIlJ7VTKFccteIR9AUKP4ya1gVpsyQdE8S0EWkzp82S86jZnNSIsx
         LtkyBbCL702Bh6BO/GgYdaEYZ9C0pvMefrKGrnGhy2SJ+Odk6MGjWfabSPV9rkGvO5RJ
         t04P/EXDhXVjBMC+VOKTjiVetCpaDxS3nrBJQOAc6apK322tGTdZFhlhWYF+XUUhoFTJ
         hK1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=XMI3dbv7S6q2jB5/NVdmh3pFl60FzTgbFc2uAC8p4kQ=;
        b=Vlj8Q8zylUHyno1H/A4iruh0NyLzTRFtSoIE2jKCRwtiYIcsuHNuX+Bwf4xSZfao2I
         g8mKFeM1DLKvPF8svAPWbZrOA2bHYzG9skHvZsoR9Bm844bzWOG350Bido4sI8WY1svi
         9GNW7d7GVcPV3tRWRjQSMdzj9978A84p1fYjODjxW80kxRL1KyVtJf8NMmon82glI270
         lEr8LBwAITRgtxuMUHmug1qE+KrhLqGqlhQjKEaVE/VhfhK0ZSnRcqW34l6BuWwvks7R
         bQ8zPqNltCGOf3GcK5ZBxmLhPZ7t5dyNRx/qzDdZnku4f0fMMXmljkv3Lhc5e6REGNpT
         pZhA==
X-Gm-Message-State: AOAM532R7QIyuqeFtgZDYrlfaUFI06FiB/uM5uctZnuB8Va7CIKPmVds
        csga8atBHmp5bVXAx7mgZn4=
X-Google-Smtp-Source: ABdhPJxq26drZEE9wV2Y1XH1ljH7HvENl4m541tSkiSwjR162ek5D4RLLMtTTVviKpZ4wLCDDi12mA==
X-Received: by 2002:a17:902:c942:b0:14a:604d:2c35 with SMTP id i2-20020a170902c94200b0014a604d2c35mr986692pla.153.1642018422294;
        Wed, 12 Jan 2022 12:13:42 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id s8sm397048pfu.190.2022.01.12.12.13.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 12:13:41 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 10:13:40 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     axboe@kernel.dk, jbacik@fb.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] blk: introduce iostat per cgroup module
Message-ID: <Yd82dJMxdQkssu4k@slm.duckdns.org>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
 <20220110091046.17010-14-jianchao.wan9@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220110091046.17010-14-jianchao.wan9@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 05:10:46PM +0800, Wang Jianchao wrote:
> From: Wang Jianchao <wangjianchao@kuaishou.com>
> 
> iostat can only track the whole device's io statistics. This patch
> introduces iostat per cgroup based on blk-rq-qos framework which
> can track bw, iops, queue latency and device latency and distinguish
> regular or meta data. The blkio.iostat per cgroup output in following
> format,
> vda-data bytes iops queue_lat dev_lat [ditto]  [ditto]
>     meta   \___________ ______________/    |        |
> 	               v                   v        v
> 	             read               write   discard
> In particular, the blkio.iostat of root only output the statistics
> of IOs from root cgroup. However, the non-root blkio.iostat outputs
> all of the children cgroups. With meta stats in root cgroup, hope
> to observe the performace of fs metadata.

I think using bpf is a way better solution for this kind of detailed
statistics. What if I want to know what portions are random, or the
distribution of IO sizes? Do I add another rq-qos policy or add another
interface file with interface versioning?

Thanks.

-- 
tejun
