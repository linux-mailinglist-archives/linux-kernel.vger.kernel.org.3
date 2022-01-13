Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E5F248DC75
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 18:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237002AbiAMRBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 12:01:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229899AbiAMRBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 12:01:34 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9853FC061574;
        Thu, 13 Jan 2022 09:01:34 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id l16so1777425pjl.4;
        Thu, 13 Jan 2022 09:01:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=KSw+hDhWe24fKC3qXXaTSGNk+ScSs08030XzSASvR6c=;
        b=EXxqLt9cdWGSgMHZXy01dGEqC/QnRvJKKqoQHRmZM3i6eGo/Jhfgo2AfEJ2wUSfIpa
         cdCNShoTG53bJniTkfxFSln+khbEEpBGRYDdm0msJf4RCEO9WxVLRpPfJnFCkvYfEHfG
         7QrdjcB457fzAyr0IcHoeTAHptRAwzTEXzHd7GMxgn7QtAuAu2apGxzeFaGeMEvUjgnl
         CmMgU71h6jC7Hf5Y4Zf/2EKriIvJqT7dp7eXbwk8LlkHLwAGtk2n8gLQK0URtKmUGq78
         KiZpQAN100B4sr+OY7z63Jz6ss6LZrxG30atS1O+X4Fohh261pd2fmhxIwgx+X1hJlFL
         oBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=KSw+hDhWe24fKC3qXXaTSGNk+ScSs08030XzSASvR6c=;
        b=0jDiNJfTku0Ya0zpTZE3uqzV2QOJO/IVT4Kh5yoo4dBNrPoQd+AqblvZVHViWuxHw3
         UGPRkmKw6smCcyvpTyEPDaCh/zSlypkfqNcDwTgZuBnDA8uph/j2pW4Hne8hf9Cq0NAZ
         SzcIMUnpwknd7YiHTFnxJC2C4qrTOJCJdQAooWAvnBzLUFtI7PzWXKQKGvBIQ3SW/erc
         xGMOlbnLdqk7J3ikkSBySunN7eh95LJ+bClc4z3gthsawF7WKys3CdOTgZAbt7cWl+9N
         iqKHQp5H+0UHfS4bDR8Q6uRXuNzKd2kTWVPmbPg4I2nr+2Cj3pR+rA62ckDAY1s1r/Vq
         3VZg==
X-Gm-Message-State: AOAM531lhkmhjpYRhfH6ixL0TamNQ78D3LqrDemO9gdO+FeyREQx4/vQ
        Dxg9fR9jD0A7WiCtfjh+SjA=
X-Google-Smtp-Source: ABdhPJxCRzJbUUpK1rCkpfRJ/J7rblLFoyLPAFzscwFeIlfxHBFVWxZbaDISATuhY7yVwjUW+0W2yg==
X-Received: by 2002:a17:902:8b8b:b0:149:66d6:b034 with SMTP id ay11-20020a1709028b8b00b0014966d6b034mr5267979plb.129.1642093293973;
        Thu, 13 Jan 2022 09:01:33 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id mi3sm2680801pjb.26.2022.01.13.09.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 09:01:33 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 13 Jan 2022 07:01:31 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Wang Jianchao <jianchao.wan9@gmail.com>
Cc:     axboe@kernel.dk, jbacik@fb.com, bvanassche@acm.org,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 13/13] blk: introduce iostat per cgroup module
Message-ID: <YeBa68w4nQQvBM9Z@slm.duckdns.org>
References: <20220110091046.17010-1-jianchao.wan9@gmail.com>
 <20220110091046.17010-14-jianchao.wan9@gmail.com>
 <Yd82dJMxdQkssu4k@slm.duckdns.org>
 <faafdf29-6d8b-82a8-c69d-4ab3e623b489@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <faafdf29-6d8b-82a8-c69d-4ab3e623b489@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu, Jan 13, 2022 at 10:40:27AM +0800, Wang Jianchao wrote:
> bw/iops/lat of data or metadata of one cgroup is very basic statistics

bw and iops can already be derived from the cumulative counters in io.stat.
Latencies without distribution are often what we tradtionally exposed not
because they're great but because exposing distributions is so cumbersome
from kernel. Also, latency numbers at cgroup level isn't *that* useful
anyway. There isn't a lot you can deduce for the particular cgroup from that
number.

> which kernel could provide especially when cgroup is employed everywhere.
> And we love to collect them all the time during the instance in cgroup is
> running.

It's really not that difficult to collect these numbers from bpf with pretty
low overhead. There's the problem of deployment for which there isn't "the"
right and convenient way but it'd be more worthwhile to put efforts towards
that.

> > What if I want to know what portions are random, or the
> > distribution of IO sizes? 
> This looks really detailed statistics :)
> > Do I add another rq-qos policy or add another
> > interface file with interface versioning?
> This iostat module can not provide all the kinds of statistics we want
> but just some very basic things. And maybe it can provide better hooks
> to install the ebpf program to collect detailed statistics.

I mean, "really basic" means different things for different folks. Bytes /
ios, we all seem to agree. Beyond that, who knows? There already are enough
hooks to collect stats that you're trying to collect. The examples in py-bcc
might be a good place to start.

Thanks.

-- 
tejun
