Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D742F5352D5
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 19:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344197AbiEZRna (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 13:43:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344062AbiEZRn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 13:43:28 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E229DFDC
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:43:27 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id f4so2298694iov.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 10:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=Cf7d3NdarROeO1DBR6AQD9JX7+zz8hgqvCHij6VuBns=;
        b=i5RGf+k9walnItpnx9yAiefDNhrFFACOtNsgMSJlDnHnGephcTbEi+zjiQHLzVAo8+
         k4SOaRKhzngDYnGwYINC/jcFhBXif0tYHZG1v64RMdPBfa37Yi+uID+4jOE5YZBtIxsp
         /oNXEJf0IJTtKa/P3aFhK+s4XLxW35f0F62le9b/Gv75WZ0HZCkI4qfnO8HskWQDrc6S
         Ka9onSdDxRZz6vP8LqwtlPVdt1BRWqJ5NGq2vMOkOYPSXEgrqiGy/inAMtVE3RNMsGHZ
         MPjOhsctJI1j24aSzqOjcdy6C4/LB1SdNH1GTRd7nAlWFgQ1MGj7bYciI3JfvLXyP68P
         pCfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=Cf7d3NdarROeO1DBR6AQD9JX7+zz8hgqvCHij6VuBns=;
        b=ctzvsFfvvza81/VdDcfQ/WG+mb+/CL6zunSkQvyZLt/PxsNirzPtgqPTmBAOC9VYso
         w5OABVYTEiz0UXozSQ5reaZ2fPciVN3ttLt7QTtr2F3yG0m8n1LhoqLPYGEMJUMPM8MG
         nYYyYhOkMlmN6QeUx8mGgT/0z5ZgfmpLeUXTXOwpdyfOpduR0Qo0nWAQZxJO7EdXFCYQ
         syR0ABGTMpE05Hbtao8v6d/sDnUwa9LHocaNWHCxvqn7pFlzj76nit7ymdsjNtVou9xf
         nOaZvDer9BCyO2nVqUBv8iv8gy+leHvQUdO9EUUXQXHn6kquwC06bCQyIRIF0td2xfqJ
         G6Zg==
X-Gm-Message-State: AOAM530XFP7Ca7bvgbJaZQBMudkLZ3JKDtZ2EbKqLDrlwFqxct75vZNp
        B8Bp6gXNGRZit/hhUp5GwT1KaA==
X-Google-Smtp-Source: ABdhPJzAPHoImUvr5c2HdKzi8nCAIOvgk3aG8fJbLYXnzTkl+x/PRDnKjx1gTAaHdP+CGKkq/NKUiw==
X-Received: by 2002:a6b:8e0d:0:b0:65e:50f1:afd8 with SMTP id q13-20020a6b8e0d000000b0065e50f1afd8mr14714599iod.112.1653587006740;
        Thu, 26 May 2022 10:43:26 -0700 (PDT)
Received: from [127.0.1.1] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id x18-20020a927c12000000b002d149ec2606sm652748ilc.65.2022.05.26.10.43.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 May 2022 10:43:25 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     tj@kernel.org
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        bo.liu@linux.alibaba.com, kernel-team@fb.com, josef@toxicpanda.com
In-Reply-To: <Yn9ScX6Nx2qIiQQi@slm.duckdns.org>
References: <Yn9ScX6Nx2qIiQQi@slm.duckdns.org>
Subject: Re: [PATCH block/for-5.19] blk-iolatency: Fix inflight count imbalances and IO hangs on offline
Message-Id: <165358700562.497212.14751047590663347545.b4-ty@kernel.dk>
Date:   Thu, 26 May 2022 11:43:25 -0600
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

On Fri, 13 May 2022 20:55:45 -1000, Tejun Heo wrote:
> iolatency needs to track the number of inflight IOs per cgroup. As this
> tracking can be expensive, it is disabled when no cgroup has iolatency
> configured for the device. To ensure that the inflight counters stay
> balanced, iolatency_set_limit() freezes the request_queue while manipulating
> the enabled counter, which ensures that no IO is in flight and thus all
> counters are zero.
> 
> [...]

Applied, thanks!

[1/1] blk-iolatency: Fix inflight count imbalances and IO hangs on offline
      commit: 8a177a36da6c54c98b8685d4f914cb3637d53c0d

Best regards,
-- 
Jens Axboe


