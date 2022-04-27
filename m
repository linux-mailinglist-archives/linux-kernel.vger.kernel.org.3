Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0E551231F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233916AbiD0TzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234506AbiD0Tyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:54:54 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0E4360D80
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:51:40 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id f5so656902ilj.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 12:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=A3SuMQQGPXuzThm/aM6O06njtTvaZhBmlWvPZYpCL2M=;
        b=KP1HDZ4wptfcj0/cthgpkBLKrOPHem9S0qnn9gwCy5uZg1T6JFdVO34uWPhSQ2OGnh
         QpMw5xtcg0dPsyhyQKDwfaQN/qd24/pZdx42411N3huZzwpDOahme9p+aZgS/4E6mUT+
         w4nQYb7oAQ5jU9AcvPuyIwkf9FyzkkLAo1Rnt507+13b4tBI/vh59MHraZMa3tA2yGsp
         gP9Ht7wG4mpm/DTJEfJgHMZd0LVlaw5VOJY4aspS6bddWpoRIxVUB/IqJF3fV4PRGRfm
         A7s3XEBoGoKrK57M23wClox4n0QRE8rO7uekRsrIPU6Ep6TCVKE7+JVB76s8DueRp8+2
         6ueQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=A3SuMQQGPXuzThm/aM6O06njtTvaZhBmlWvPZYpCL2M=;
        b=i7TqSTpaurfh9DwwFSlG1xtb13ugqdy9k2dAKCep751NnXPLcSrVtbRNLBvWduJONG
         pYMxzOtCKmlj7QvXpfrzJPcvPwFiCnDxuxO/YYhxiN/VMq3dTzy2SDh1biIhdPDtzN+X
         RODTJWBJ8eLiCIUZUrXJUuhRgiV7kc7mLO5stejEJf26x7O9FU0uivCHT7vkoFZnLDiw
         DRNq032F7OaVcG4xDgAeBj2xL08scBdtkok4gW6zdNqCmAbetdQw8jWof8QbY/6amUny
         QZdWAwkaUL8WJ5k0o4bT8U0UUnj0ru/i3QF1tos9tdnbZpaKz8jFN8fb5CtP/G9uX3Ku
         lgmg==
X-Gm-Message-State: AOAM530MuoScujfbG0Dokvv4lyCBlKar7saU0/Ow2orCNjUwbwiwj5K/
        YMM/8NHpRBkNvFhdSxuRYUFTbA==
X-Google-Smtp-Source: ABdhPJw/VADmvZzVCQb095A1Ngx6/rnHArBaR5Oj+OxIFthrh6JB7HWwRaKDnQ/+58IoRtEE9m9a4A==
X-Received: by 2002:a05:6e02:1748:b0:2cd:a0ea:8ff4 with SMTP id y8-20020a056e02174800b002cda0ea8ff4mr6054458ill.269.1651089099496;
        Wed, 27 Apr 2022 12:51:39 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id u4-20020a92d1c4000000b002cc14bf22ddsm10050294ilg.77.2022.04.27.12.51.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 12:51:39 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org
Cc:     linux-block@vger.kernel.org, saravanand@fb.com,
        chris.obbard@collabora.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <YmmeOLfo5lzc+8yI@slm.duckdns.org>
References: <YmmeOLfo5lzc+8yI@slm.duckdns.org>
Subject: Re: [PATCH block-5.18] Revert "block: inherit request start time from bio for BLK_CGROUP"
Message-Id: <165108909873.140853.15966713411862913960.b4-ty@kernel.dk>
Date:   Wed, 27 Apr 2022 13:51:38 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Apr 2022 09:49:12 -1000, Tejun Heo wrote:
> This reverts commit 0006707723233cb2a9a23ca19fc3d0864835704c. It has a
> couple problems:
> 
> * bio_issue_time() is stored in bio->bi_issue truncated to 51 bits. This
>   overflows in slightly over 26 days. Setting rq->io_start_time_ns with it
>   means that io duration calculation would yield >26days after 26 days of
>   uptime. This, for example, confuses kyber making it cause high IO
>   latencies.
> 
> [...]

Applied, thanks!

[1/1] Revert "block: inherit request start time from bio for BLK_CGROUP"
      commit: 4cddeacad6d4b23493a108d0705e7d2ab89ba5a3

Best regards,
-- 
Jens Axboe


