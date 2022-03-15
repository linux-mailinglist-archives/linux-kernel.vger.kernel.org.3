Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 913B94D9226
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 02:15:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344216AbiCOBQY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 21:16:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344207AbiCOBQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 21:16:18 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFF6A34642
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:15:07 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso1011282pjo.5
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 18:15:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:in-reply-to:references:subject:message-id:date
         :mime-version:content-transfer-encoding;
        bh=YYXrSkA7DcKX+OZWoRaWmcezxkTTC0s3clPNsqj0tSs=;
        b=zf7n+VLD+TlQXBul0FjxSYL20r03zWROyOA5y4hxMFq+RWaP03LQynIiq5YiSKbkkk
         4FokEd9K2SBXzY3lcpBYaxnM/XggXqkIcGAl5r05eOeLMuqueQt1qHpL0y8ONY4UkRWB
         nBOQR2g1Id/IcgIVc7vZwbInbJNmzdP7pfzuyCm25Qt9oioTkTV7badO8iz5bBmcssLB
         0KIgZROVlTgkXqbEl5+PXmSTXM8mvNynBnTBPRurvJ4XazuIINdwhDb2y8z6I8b9DvMa
         CFUppDDNwXn58Mk4IdX6/z8JxMriMX7GpU4cFu1j/62+ZYdkJ1XGn6qd4uA2m29bS33j
         5CfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:in-reply-to:references:subject
         :message-id:date:mime-version:content-transfer-encoding;
        bh=YYXrSkA7DcKX+OZWoRaWmcezxkTTC0s3clPNsqj0tSs=;
        b=IKpkLip1QC+E31/G+onGxq2YWEXXxfNlNn/YqgBEmSI3Cn8kj9oMlKNs5cIZhhh8E1
         Rxgx+8rJzI6u3o6hOiAY6+dj5HT2dLsP8X1s1n1tx7wRqpaydM2wzM7HKlOGo8t79Uc+
         aC57JJK9XNau12+WX74Q318EvZ9BIBerdMuj15W5s8EVE+oZ+rwL/4CbreMeUN9tzATP
         nRm1UfVqy4KYSCuiFngkxcAYrlJRQjjVLciXzGwtqM6YR7XmaazviznRkviRQfOEBF/0
         5qfF6jNBE20BAvVN5Fc9BTh32aWq3ftXP03vdIyB8OgrVYQi1YH/hHhQn69UE0XJ+kuk
         fW7A==
X-Gm-Message-State: AOAM5309g7Ubhr5YRRpLkUJlDqrZtZEsoXPsr+sPuJCgJKj87VFYPCgk
        +O9xrRKF/Itid9Qld059WBR0tA==
X-Google-Smtp-Source: ABdhPJybZTuIVdsdqiq9XXOjoE5OhuzK9g5Qb+orkGS7bDm7/WhD/PUXavEFFaj8efC60jR46TlAXQ==
X-Received: by 2002:a17:90a:1f4d:b0:1bb:a657:ace5 with SMTP id y13-20020a17090a1f4d00b001bba657ace5mr1830551pjy.39.1647306907272;
        Mon, 14 Mar 2022 18:15:07 -0700 (PDT)
Received: from [127.0.1.1] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a7f0600b001c63352cadbsm510847pjl.29.2022.03.14.18.15.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Mar 2022 18:15:06 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     Tejun Heo <tj@kernel.org>
Cc:     Josef Bacik <josef@toxicpanda.com>, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org, kernel-team@fb.com
In-Reply-To: <Yi/eE/6zFNyWJ+qd@slm.duckdns.org>
References: <Yi71WZ3O9/YViHSb@slm.duckdns.org> <Yi/Us896/ftt5l4f@slm.duckdns.org> <Yi/eE/6zFNyWJ+qd@slm.duckdns.org>
Subject: Re: [PATCH v3 for-5.18/block] block: don't merge across cgroup boundaries if blkcg is enabled
Message-Id: <164730690621.219116.11184082869298025827.b4-ty@kernel.dk>
Date:   Mon, 14 Mar 2022 19:15:06 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022 14:30:11 -1000, Tejun Heo wrote:
> blk-iocost and iolatency are cgroup aware rq-qos policies but they didn't
> disable merges across different cgroups. This obviously can lead to
> accounting and control errors but more importantly to priority inversions -
> e.g. an IO which belongs to a higher priority cgroup or IO class may end up
> getting throttled incorrectly because it gets merged to an IO issued from a
> low priority cgroup.
> 
> [...]

Applied, thanks!

[1/1] block: don't merge across cgroup boundaries if blkcg is enabled
      commit: 6b2b04590b51aa4cf395fcd185ce439cab5961dc

Best regards,
-- 
Jens Axboe


