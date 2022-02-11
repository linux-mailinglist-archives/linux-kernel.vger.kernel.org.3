Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C32E04B2B29
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 18:01:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351873AbiBKRAn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 12:00:43 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:56968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351864AbiBKRAk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 12:00:40 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0A26CC8
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:00:38 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id w7so12168955ioj.5
        for <linux-kernel@vger.kernel.org>; Fri, 11 Feb 2022 09:00:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=j04MZc7+Vllk/SHsVsvPL62aWIq/a7UweoKiSdDovz8=;
        b=U5HR3RIgVsW3EN89TU5D4lkYEFA+vDIX5nj7bkmLfAuZEmrki8f0fvqnkdSzwdLFlC
         +uYNpj0IGaaZwkIt83tpes5r1g3B3VmPgWiTb5QmO0L8PjNaHLsFciuxc5vHZ7kI0bc1
         s+x6JQaDlPOl2NnRMX16uD5Lj34GKT5GWous40Vsp9s+I9eauif1QAQGFYmzfLQPF9Rk
         UjTrexosgjIhjP7H3P7BrDPp9XYkuj6xIUbCam5a3Q3akjdX27auaKp2Sr5xusrkSmWq
         mYsVT+Vv630I0d+FSSgwrB7Fntz9yfn29ko++D630ik1lxHuCvBB2a7ThqSN2ZXE7JMR
         4zwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=j04MZc7+Vllk/SHsVsvPL62aWIq/a7UweoKiSdDovz8=;
        b=L8jZJsfI+jQo58w62eAq3wLdoUe/S8qAW68LhYevs7u92z2F8Khw8Sl0z85s42Z1Ql
         4s7/GtKktSNv5ONxEURz3yRmlTg8BgPZHiPcaTGOxqKgojUqs+8HUH2YMXxPR/qN18ev
         xauTtz+lz3QuNDG8uuerGYy03ZvR9fltQIppW8JH2h+oLqRmV8Tq8L7q9IO55bX3+hyX
         6Rk0pnTz74NGQdGfj/XH6Qd4HVoZbKSsoUxzcgPLJOCWJ6N2Fd88w32QalvOY5scluh7
         Se0Iasxf4VKTpbi71eDQfwNgCzVdXSmi29KdtTrztY8NxjK8QlsrzYJxUEV5J5bSISsS
         193w==
X-Gm-Message-State: AOAM5300fIdzpb4Jx0ykm+7EPsZNEsSlxuWSNl/JT5vc+DP5gQhQWoie
        LpOLZHYAygUtI7wtScC/3JdDzCcpVrV8ROaE
X-Google-Smtp-Source: ABdhPJxux5F6R5SvtJI/DzQlxnzd3eFWXbeOX9EF3IQMxW67V7t0NP5IQyqA2R8Tjc8c0z7wGxPuyg==
X-Received: by 2002:a05:6638:1038:: with SMTP id n24mr1404494jan.36.1644598837958;
        Fri, 11 Feb 2022 09:00:37 -0800 (PST)
Received: from x1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id k11sm13565121iob.23.2022.02.11.09.00.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Feb 2022 09:00:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     rostedt@goodmis.org, Yang Shi <shy828301@gmail.com>,
        xiyou.wangcong@gmail.com, kch@nvidia.com, hch@infradead.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
In-Reply-To: <20220210225222.260069-1-shy828301@gmail.com>
References: <20220210225222.260069-1-shy828301@gmail.com>
Subject: Re: [v8 PATCH] block: introduce block_rq_error tracepoint
Message-Id: <164459883724.122482.1096803254957441815.b4-ty@kernel.dk>
Date:   Fri, 11 Feb 2022 10:00:37 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 10 Feb 2022 14:52:22 -0800, Yang Shi wrote:
> Currently, rasdaemon uses the existing tracepoint block_rq_complete
> and filters out non-error cases in order to capture block disk errors.
> 
> But there are a few problems with this approach:
> 
> 1. Even kernel trace filter could do the filtering work, there is
>    still some overhead after we enable this tracepoint.
> 
> [...]

Applied, thanks!

[1/1] block: introduce block_rq_error tracepoint
      commit: d5869fdc189f0f12a954a48d58a48104a2f5d044

Best regards,
-- 
Jens Axboe


