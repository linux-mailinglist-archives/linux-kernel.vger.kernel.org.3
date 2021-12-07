Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D4DB46C094
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 17:18:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239568AbhLGQVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbhLGQVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 11:21:34 -0500
Received: from mail-il1-x134.google.com (mail-il1-x134.google.com [IPv6:2607:f8b0:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0323CC061574
        for <linux-kernel@vger.kernel.org>; Tue,  7 Dec 2021 08:18:04 -0800 (PST)
Received: by mail-il1-x134.google.com with SMTP id w1so1628226ilh.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Dec 2021 08:18:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=98f/j99AuJzhZ6H5G/BaaKmxrlUIJ+qa/P4gIH2gWOw=;
        b=se7fm4oskX7jefsflWX65qMvO6PKk5Vo6IwV/PRz7zFtyMYQE2iYOK+wEqcMZjY9o5
         S8JlXR/lfXvbuJxbpBCafNY3X9IjzakaxHaxWi+6u5yTDiqlf4xinpJGOtr+ARR4kuC/
         TUgwJYSg6a761I8ND1z2BOf3gmjtfygD2UFF5u9v53BvNAtsn4Ez9qxLVyUkyUeF6Kr4
         QcLbfhCZE3Cbb7ORBHhC0iCAx6xvBUnMhySVGFRuGoxEA9wGqsXA7ChauWsCcf9dF3yB
         s15PRFBIhzw2QiBoEHdZbNScPYUsAR+1CWyqDum1MsWOTjRcs7NN/TzPtgtrEG9sKbe1
         2GZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=98f/j99AuJzhZ6H5G/BaaKmxrlUIJ+qa/P4gIH2gWOw=;
        b=C55upurlecFfJIlgVw+FplWRRkxGLMo5EUDkdGZUEMl2GKVBR7tGN/AQmHV9hzXQ6s
         3qT+9EPkvJZaBNzLSHehWZTcLXvdfR6YHN9QQWy84DM3y4FGZIv/CdYDLfdeQulLgPm8
         f0M286wZPaG3b/gta8h6nemEuZ2NUPETlZCNdihlQYQCEdviMeCn1yd0Xxik5IriwNDd
         kd4w2R0UXV4PJlrUGF86xeilOHzie6dpqSeKF+UCzT1Z5Kn++CrJAjVlZGCsGknQ15Uc
         RuelCTaS06WUW5KXCHjuLukdcE6i3jUlf61ceMEAEn1H06QoBkzDJ9rgCU6Vo+SSGpid
         qElw==
X-Gm-Message-State: AOAM5300k7M9EbrhOaVIp5okV63U8g1QfhvuljPgv9BsLdEwI/+3KjZH
        2fJbUBuLAt3f1zae+6kZrQ+GXPpvW8bAYclg
X-Google-Smtp-Source: ABdhPJz111zaVwF/YHQfSDLhMEcjob8y5Likudp/zcGxdQ9NGB8pmN5q3jD2siCFohjNC35oN8G9ag==
X-Received: by 2002:a92:8751:: with SMTP id d17mr380244ilm.148.1638893883342;
        Tue, 07 Dec 2021 08:18:03 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w10sm95941ill.36.2021.12.07.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Dec 2021 08:18:02 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     John Garry <john.garry@huawei.com>
Cc:     linux-block@vger.kernel.org, kashyap.desai@broadcom.com,
        linux-kernel@vger.kernel.org, hare@suse.de, ming.lei@redhat.com
In-Reply-To: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
References: <1638794990-137490-1-git-send-email-john.garry@huawei.com>
Subject: Re: [PATCH v2 0/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
Message-Id: <163889388252.160645.10327363566878499665.b4-ty@kernel.dk>
Date:   Tue, 07 Dec 2021 09:18:02 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 6 Dec 2021 20:49:47 +0800, John Garry wrote:
> In [0] Kashyap reports high CPU usage for blk_mq_queue_tag_busy_iter()
> and callees for shared tags.
> 
> Indeed blk_mq_queue_tag_busy_iter() would be less optimum for moving to
> shared tags, but it was not optimum previously.
> 
> This series optimises by having only a single iter (per regular and resv
> tags) for the shared tags, instead of an iter per HW queue.
> 
> [...]

Applied, thanks!

[1/3] blk-mq: Drop busy_iter_fn blk_mq_hw_ctx argument
      (no commit info)
[2/3] blk-mq: Delete busy_iter_fn
      (no commit info)
[3/3] blk-mq: Optimise blk_mq_queue_tag_busy_iter() for shared tags
      (no commit info)

Best regards,
-- 
Jens Axboe


