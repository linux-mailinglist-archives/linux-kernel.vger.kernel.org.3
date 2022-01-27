Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F86749D77F
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 02:32:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiA0Bcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 20:32:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231771AbiA0Bcl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 20:32:41 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84E45C06161C;
        Wed, 26 Jan 2022 17:32:41 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id e81so3087453oia.6;
        Wed, 26 Jan 2022 17:32:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qCtH/ypAXmYDr6RjK5BruZCO9IbiFs41tnc4Av1HVRU=;
        b=nb2+zVVoP5FgZ/oje4rt8CeGz1R/DGOSEfXupo/v7APMgjJhEFbgciWKE46gkTGUVe
         0EwyHsWhcGnf4PIjplvT98i/TND9CELEcBMomOE1JBXMTk4E0Q5M64QWjnEsEdK1BCsH
         FaqyQFxgWSKgPFijB94WEgDiXNKFzThnVl2B7TEH6U//Ue1EPOa+hR6laCvypxKX8e2x
         sFwwnaLWN2j0BW+P8wFRbdxBiOATFGh7c5YZEAOJLZIW8yqFrno2iTAlxcULdcv/mQQT
         vhUhYAU+e438SMuZ9ud4l8AV5XjMrYPxBHfNxwliJMT/CZEaXnlhlP/Dvn1hGeGF2unb
         WGuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=qCtH/ypAXmYDr6RjK5BruZCO9IbiFs41tnc4Av1HVRU=;
        b=PNILo2tVLslHazVj+bW0i859BCbG2FgmQKgSPirgePrXE6l7zhr0aAGJa1ctdX6rRL
         MIBIst16qpx9JwuZ4Og8+uvEaqudXp2a7GIoPmIeQRpijldonmt40K8USBbXBKMShsQX
         qFXcddKtFSXaGzIYjcF/hGMkoMVixkAoM2auxsehXhcf/VKzX4cy6IYZmt/tBVU2V/Uy
         g/Gt+1fzLvvJ1D2cwp7JFv6elPyc7wIDxtGYu/59IjYwq8EDE5ROltW/rNxoRkq5amLe
         ByRqi7mQG86sKGVwnVCIWhnZCWNasT8G5n+E/5OqpkoAZT+SAYIYwS9WCtGUP3+FLhNP
         HOrw==
X-Gm-Message-State: AOAM530xX7u93I5bHDOsu5eLibMxDMVA6gc4zeY9SXtTCMGPnmmzEdTJ
        evZalCwqc0kShcm6K/Eo6iA=
X-Google-Smtp-Source: ABdhPJx6/0rs2bzhh4CVU1hxj+vuEjMK50dLStrQMPv/HowItDMJ7Ii7kF0yqliE6QiTiZe5UAaRmA==
X-Received: by 2002:a05:6808:1a12:: with SMTP id bk18mr5435394oib.44.1643247160872;
        Wed, 26 Jan 2022 17:32:40 -0800 (PST)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id n22sm8245730ooq.27.2022.01.26.17.32.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Jan 2022 17:32:40 -0800 (PST)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Wed, 26 Jan 2022 17:32:38 -0800
From:   Guenter Roeck <linux@roeck-us.net>
To:     Laibin Qiu <qiulaibin@huawei.com>
Cc:     axboe@kernel.dk, ming.lei@redhat.com, john.garry@huawei.com,
        martin.petersen@oracle.com, hare@suse.de,
        akpm@linux-foundation.org, bvanassche@acm.org,
        andriy.shevchenko@linux.intel.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next V5] blk-mq: fix tag_get wait task can't be awakened
Message-ID: <20220127013238.GA1478141@roeck-us.net>
References: <20220113025536.1479653-1-qiulaibin@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220113025536.1479653-1-qiulaibin@huawei.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 13, 2022 at 10:55:36AM +0800, Laibin Qiu wrote:
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
> Fix this by recalculating wake_batch when inc or dec active_queues.
> 
> Fixes: 0d2602ca30e41 ("blk-mq: improve support for shared tags maps")
> Suggested-by: Ming Lei <ming.lei@redhat.com>
> Suggested-by: John Garry <john.garry@huawei.com>
> Signed-off-by: Laibin Qiu <qiulaibin@huawei.com>

I understand this problem has been reported already, but still:

This patch causes a hang in several of my qemu emulations when
trying to boot from usb. Reverting it fixes the problem. Bisect log
is attached.

Boot logs are available at
https://kerneltests.org/builders/qemu-arm-aspeed-master/builds/230/steps/qemubuildcommand/logs/stdio
but don't really show much: the affected tests simply hang until they
are aborted.

Guenter

---
bisect log:

# bad: [0280e3c58f92b2fe0e8fbbdf8d386449168de4a8] Merge tag 'nfs-for-5.17-1' of git://git.linux-nfs.org/projects/anna/linux-nfs
# good: [64f29d8856a9e0d1fcdc5344f76e70c364b941cb] Merge tag 'ceph-for-5.17-rc1' of git://github.com/ceph/ceph-client
git bisect start 'HEAD' '64f29d8856a9'
# bad: [b087788c20aa959f83df989b31fdcc4182b2d067] Merge tag 'ata-5.17-rc1-part2' of git://git.kernel.org/pub/scm/linux/kernel/git/dlemoal/libata
git bisect bad b087788c20aa959f83df989b31fdcc4182b2d067
# bad: [0854dc81e108c90cccda6d1fc54bc270f16a3cc9] Merge tag 'docs-5.17-2' of git://git.lwn.net/linux
git bisect bad 0854dc81e108c90cccda6d1fc54bc270f16a3cc9
# good: [75242f31db6cabf602a5eb84c13b579099d72a65] Merge tag 'rtc-5.17' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux
git bisect good 75242f31db6cabf602a5eb84c13b579099d72a65
# good: [f3a78227eef20c0ba13bbf9401f0a340bca3ad16] Merge tag 'io_uring-5.17-2022-01-21' of git://git.kernel.dk/linux-block
git bisect good f3a78227eef20c0ba13bbf9401f0a340bca3ad16
# bad: [3c7c25038b6c7d66a6816028219914379be6a5cc] Merge tag 'block-5.17-2022-01-21' of git://git.kernel.dk/linux-block
git bisect bad 3c7c25038b6c7d66a6816028219914379be6a5cc
# bad: [e6a2e5116e07ce5acc8698785c29e9e47f010fd5] block: Remove unnecessary variable assignment
git bisect bad e6a2e5116e07ce5acc8698785c29e9e47f010fd5
# bad: [413ec8057bc3d368574abd05dd27e747063b2f59] loop: remove redundant initialization of pointer node
git bisect bad 413ec8057bc3d368574abd05dd27e747063b2f59
# bad: [180dccb0dba4f5e84a4a70c1be1d34cbb6528b32] blk-mq: fix tag_get wait task can't be awakened
git bisect bad 180dccb0dba4f5e84a4a70c1be1d34cbb6528b32
# first bad commit: [180dccb0dba4f5e84a4a70c1be1d34cbb6528b32] blk-mq: fix tag_get wait task can't be awakened
