Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3646B48DE65
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 20:52:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231417AbiAMTwi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 14:52:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229913AbiAMTwh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 14:52:37 -0500
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C978C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:52:37 -0800 (PST)
Received: by mail-il1-x136.google.com with SMTP id d14so6643713ila.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 11:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=lVJTudrXft+iXXdcVg46xxo9DPC8R8kvUkGEeS6WFG8=;
        b=FIthwgEuXBTelzPjyICiBtiZHOfv+VKeCf/1UwNnfbzvy9M+aIuVKjcoEsPjJFHXQk
         mb0mMWDBF92f2omtbHnMCHylhi79Beagu7WKgYg6PPANtcwYpF6eZ8qvFK/tB2WWQFmD
         ELRWC8/Vj4cOQS0TeFkQXbGEnJafLpdBFj0sC3vCgCyD5qveZVKnROh14eyDnQW9aOd+
         Z/J8JjyOwvxre+t3mTRpz7JSK92X7G7lvGZEBdpqg+sG1GVDJm6GXsjFQ/J/8Qv+bBff
         cVgsjU0ozChhxgsCExQq8FQ21bbKGqXwXJ/H+/KxeBdxmRLLC7LA6wLv4/rZSPqzXRrO
         IIQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=lVJTudrXft+iXXdcVg46xxo9DPC8R8kvUkGEeS6WFG8=;
        b=JhgK3Qk5ZCoaHzV5OnPBPxE7qNIe1ceOWauvjrkt5ucCG2wf2Fr9xVxFUKXPlT7wjy
         QrreHWQcZzT0FkZqPYAUiP7b1szz0iyx5wLpO0q2ZsgjDA+25t0LTx9lMdjvNnBCwGsH
         afjT7wxwkaGB4rrgdY4ZFWKG5DJYoBUrnz+ekfinK3jbzrXQvL2w6aZku6oJYEniSDxG
         11p9stqnsD+QJXMVFp2q3qbed5sbsHQDQTXY3okTzEkqnmG/byrHlRTymQmB1zO3m0LY
         LNqXObEE2vgRUMOUaMt3JLY+twz64M6rvtoxgcmPnGiNna9f1XxD1p9jsHI2Yer3LXBS
         NKxA==
X-Gm-Message-State: AOAM530RU45lG36Hw3ujpCJSmVy8xebE4rX4CqdBFv4ZZneShXMITwua
        Mh/lftEbN/SIUVwKPc+riY9jEQ==
X-Google-Smtp-Source: ABdhPJw1gYiIbTPi1LFOIaY+dRb4I5KFM/zPN+G1Vl/v8chXaf+03x8NiLNK9t9VLz0CVz2bn9LupA==
X-Received: by 2002:a05:6e02:1529:: with SMTP id i9mr3160891ilu.149.1642103556507;
        Thu, 13 Jan 2022 11:52:36 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id 8sm168691ily.67.2022.01.13.11.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 11:52:36 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     Laibin Qiu <qiulaibin@huawei.com>, ming.lei@redhat.com,
        john.garry@huawei.com
Cc:     akpm@linux-foundation.org, bvanassche@acm.org,
        linux-kernel@vger.kernel.org, hare@suse.de,
        linux-block@vger.kernel.org, andriy.shevchenko@linux.intel.com,
        martin.petersen@oracle.com
In-Reply-To: <20220113025536.1479653-1-qiulaibin@huawei.com>
References: <20220113025536.1479653-1-qiulaibin@huawei.com>
Subject: Re: [PATCH -next V5] blk-mq: fix tag_get wait task can't be awakened
Message-Id: <164210355584.171739.7914692743898015276.b4-ty@kernel.dk>
Date:   Thu, 13 Jan 2022 12:52:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 10:55:36 +0800, Laibin Qiu wrote:
> In case of shared tags, there might be more than one hctx which
> allocates from the same tags, and each hctx is limited to allocate at
> most:
>         hctx_max_depth = max((bt->sb.depth + users - 1) / users, 4U);
> 
> tag idle detection is lazy, and may be delayed for 30sec, so there
> could be just one real active hctx(queue) but all others are actually
> idle and still accounted as active because of the lazy idle detection.
> Then if wake_batch is > hctx_max_depth, driver tag allocation may wait
> forever on this real active hctx.
> 
> [...]

Applied, thanks!

[1/1] blk-mq: fix tag_get wait task can't be awakened
      commit: 180dccb0dba4f5e84a4a70c1be1d34cbb6528b32

Best regards,
-- 
Jens Axboe


