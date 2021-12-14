Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095A7474DEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Dec 2021 23:35:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233996AbhLNWf1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 17:35:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230098AbhLNWfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 17:35:24 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45CBCC06173E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:35:24 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id o20so68548113eds.10
        for <linux-kernel@vger.kernel.org>; Tue, 14 Dec 2021 14:35:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=6Taqzw6uxeOIOz97UH1duZRnhJhqeOLAqf5B3wtCszw=;
        b=3XQ3OzXwM28f7t6cRqcC2uz9L/EUC/1Vj7nj7y0cii9SH61V7WOztETWrUU9KGbXBu
         fGsyXT/lDDb8GVMvNR4IG7HRO8XcoGg1pSnsdepdASsbb1DLx3dUdJF3a4pwG/b2Gc8z
         QJ/+YvXTLuBd9ZVV01x6aAMCAciHqOm/3EYwriMLzvm9YaV5DOD6eaNv8t2Tf/IsA4QX
         cKvns0LQkxNWKIe10shY8uWN/AsQb4T2mBr0MovuDZwxteAXUcIPOTTob5VeKyz44SEc
         nwqBGigONGybMiTiNpcEBHETuv5N/yDVq4DAmdJQQanz27XS4PLIP68cS6437PxfXQBu
         6Fng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=6Taqzw6uxeOIOz97UH1duZRnhJhqeOLAqf5B3wtCszw=;
        b=7pMrdGhJ/syyucQxAH4s2fkYOSTdtV6QG/1kEbam6T9ylOnzTMBwnkAn5C5JF7cQRj
         l1vZeFcEddJluuXFdaOhqJ98W/bWyrIct35SwjzRLb14wxHKrTeoKn6dXItYxklS9G93
         WHKDr67OgGVxjsNmyg9pc0CwNV0gFYdx92y+hw9z9ZO6fcqWQW6fZIozLrplyzXqYAiF
         Oe4qJEqVDzNjaNukpNk8uFxA2vY+3N5cKSU7X9o9NSwKpjP0EY45kyM8xQ3X0tZv9q4z
         L5H8lBIDNNa2ujJjZ43Srvu/XpDbHUxxEQurenYwLshzasNqMb7pzQLtfITFBlih5DnP
         qRFg==
X-Gm-Message-State: AOAM5306UOH9kNb9XUmqjAzB+kJiMUQjfqd8pKQA7Z6IzN0dAnw6wyiC
        f6FqXU/8kSRHqXzG5Q3bIX7AfJIsO7o2jkYhI8I29SW9Iw==
X-Google-Smtp-Source: ABdhPJzrhSLBszBAsbKMvRWAEL5mwarxpeHAo0Hs04BfQSDVdwA8FQLQOahYYlf86Z67Q5qzBqU1J0p2zVrmmqVZS/g=
X-Received: by 2002:a17:906:9b86:: with SMTP id dd6mr8505011ejc.701.1639521322615;
 Tue, 14 Dec 2021 14:35:22 -0800 (PST)
MIME-Version: 1.0
References: <20211208083320.472503-1-leo.yan@linaro.org> <20211208083320.472503-7-leo.yan@linaro.org>
In-Reply-To: <20211208083320.472503-7-leo.yan@linaro.org>
From:   Paul Moore <paul@paul-moore.com>
Date:   Tue, 14 Dec 2021 17:35:11 -0500
Message-ID: <CAHC9VhThB=kDsXr8Uc_65+gePucSstAbrab2TpLxcBSd0k39pQ@mail.gmail.com>
Subject: Re: [PATCH v2 6/7] audit: Use task_is_in_init_pid_ns()
To:     Leo Yan <leo.yan@linaro.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Leon Romanovsky <leon@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jan Harkes <jaharkes@cs.cmu.edu>, coda@cs.cmu.edu,
        Eric Paris <eparis@redhat.com>,
        Balbir Singh <bsingharora@gmail.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, codalist@coda.cs.cmu.edu,
        linux-audit@redhat.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 8, 2021 at 3:33 AM Leo Yan <leo.yan@linaro.org> wrote:
>
> Replace open code with task_is_in_init_pid_ns() for checking root PID
> namespace.
>
> Signed-off-by: Leo Yan <leo.yan@linaro.org>
> ---
>  kernel/audit.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I'm not sure how necessary this is, but it looks correct to me.

Acked-by: Paul Moore <paul@paul-moore.com>

> diff --git a/kernel/audit.c b/kernel/audit.c
> index 121d37e700a6..56ea91014180 100644
> --- a/kernel/audit.c
> +++ b/kernel/audit.c
> @@ -1034,7 +1034,7 @@ static int audit_netlink_ok(struct sk_buff *skb, u16 msg_type)
>         case AUDIT_MAKE_EQUIV:
>                 /* Only support auditd and auditctl in initial pid namespace
>                  * for now. */
> -               if (task_active_pid_ns(current) != &init_pid_ns)
> +               if (!task_is_in_init_pid_ns(current))
>                         return -EPERM;
>
>                 if (!netlink_capable(skb, CAP_AUDIT_CONTROL))
> --
> 2.25.1

-- 
paul moore
www.paul-moore.com
