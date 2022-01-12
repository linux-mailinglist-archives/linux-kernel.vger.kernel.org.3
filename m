Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EE4E48CA49
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 18:47:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355975AbiALRra (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 12:47:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243530AbiALRrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 12:47:13 -0500
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48CF3C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:47:13 -0800 (PST)
Received: by mail-pl1-x634.google.com with SMTP id e19so4976868plc.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 09:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=NpC29wdGQkvRFSqTFQqTxSqwNGdKYCmseo8W3G97ubE=;
        b=GAgC/h8xCxrO6N0dC1qj/yXJWbon/bW+JDesj0I2JiOKQ+njunALnN/0Q9Ha3zpv69
         UzCQO/rKwTqxs6Kr+242Yve07TC6BGLovdocwIEgQHZ6Xc4BELOQ8HvRc7oplAM4fBwK
         m/4fUXrG6eUrOo2R2vl3udmWr9A2JyM/sheXHc/3hLrsS4ZDMOw62twjtDCbpc8s1tyP
         O78uMIMncGSkcI0zqfktLBZ1EmUymVWeilV9ZATE/yxIwGwosRFWwc20RHywxDvbipRm
         a8G4XJu6eCdxXiA131a9BEPSbIgnA5P7i6l19tul/Zg+p8HR+MUeb9UeR9AuBNNvfqa6
         fEzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=NpC29wdGQkvRFSqTFQqTxSqwNGdKYCmseo8W3G97ubE=;
        b=L/d2J8RVrdjrM1FqxcMmUqEMCgFfOOHOn63IAa5Gl8kPoLAAR8fCh5K5qnLscbilJ9
         5JJMjfXXegxq7V2p9OkG4XMwgC+229+YEXQp4QaKX2Ppx9id88x4N+EH6LzddxopHRkD
         iNOVLKs5b6SBWCxN6gnXwzOqvflwYPlL3J01ALJcTY15zKg32N2Qd/VyN8zfW2bcQa5R
         7Z9XcX08kTRR9doYa7oXD1rNzUsq9GEpmFYNUI+jOLu4isnTQCx6887GgVw6z/1TDaGB
         J2gHEFCjD6ThpKhPpcZl/DwoX7pG8it9GTc90qCCvXBJVP6sOT241EfsB76Em3VbmXrh
         bvxQ==
X-Gm-Message-State: AOAM530gFrFbx8eUdEjJYq24k3I+M31h6ncfql15fzVvSpWLnVG9axAo
        o9O8HIvMOgkmkSs2L+f2XtA=
X-Google-Smtp-Source: ABdhPJzrbm0Y94hrgEyCzdAzdqyFHPYtrEGFUM20cT0T8nbc+lOEHtm99/KmelOx28eYcOCMpqAPIA==
X-Received: by 2002:a63:f80f:: with SMTP id n15mr657536pgh.394.1642009632492;
        Wed, 12 Jan 2022 09:47:12 -0800 (PST)
Received: from localhost (2603-800c-1a02-1bae-e24f-43ff-fee6-449f.res6.spectrum.com. [2603:800c:1a02:1bae:e24f:43ff:fee6:449f])
        by smtp.gmail.com with ESMTPSA id d21sm259267pgi.86.2022.01.12.09.47.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Jan 2022 09:47:11 -0800 (PST)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Wed, 12 Jan 2022 07:47:10 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Lai Jiangshan <laijs@linux.alibaba.com>
Subject: Re: [PATCH 0/4] workqueue: cleanups for schedule callbacks part2
Message-ID: <Yd8UHnqwTm+8XhIJ@slm.duckdns.org>
References: <20211223123140.3789-1-jiangshanlai@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211223123140.3789-1-jiangshanlai@gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 23, 2021 at 08:31:36PM +0800, Lai Jiangshan wrote:
> From: Lai Jiangshan <laijs@linux.alibaba.com>
> 
> The commit 6d25be5782e4 ("sched/core, workqueues: Distangle worker
> accounting from rq lock") changed the schedule callbacks for workqueue.
> 
> It simplified the connection between scheduler and workqueue.  But it
> caused some code useless and some comments outdated in workqueue which
> needs to be cleaned up.
> 
> Patch1-3 are the cleanups based on the fact that 6d25be5782e4 changed
> to use pool lock in wq_worker_sleeping().
> 
> Patch4 is based on the fact that schedule callbacks were changed to be
> only called from schedule() which means all modification to nr_running
> is on local CPU when the worker is concurrent managed.

Applied 1-4 to wq/for-5.18. I updated the comment on the last patch.

Thanks.

-- 
tejun
