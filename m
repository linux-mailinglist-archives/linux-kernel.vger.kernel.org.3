Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3543E580300
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236477AbiGYQl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236507AbiGYQlp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:41:45 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F6D1DA54
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:41:32 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id e5so8654002qts.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 Jul 2022 09:41:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=v0Fv+XIjssvZKgFM5LQcb8oFSEVF6SdtJS8HXkaCGG0=;
        b=3QxjhGAUDPV3GRaFaoJVT9T+OOXNTZ13AG3KfIqthhNKATudxFjJHRZqCYOcuJtIK0
         RFbJelGraAA7ADvrFcTvoACcPEmPO9FHdXoZ8scMvZ8Py8hJjbUAcm3mrHZG2a+8dfiu
         jJz3k9uorP5zoWG0g9A1yrNwZjfRedzU3BbJtPZQy11Ts4/OnsNOyxJfizhK/cSQsr1W
         dhxkuga64cCsmfd+mdYtgYPikV83NIg0g+yxgnVHXe6T3jDOUIlyWm/irCW4nWCcsXY0
         fG5mlS4HNpuKW4RgHgsxzBFfLfZn5aWfNFilSvvdsrIe8toMNQLojl9mc2J6c2NUYEOI
         IXKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=v0Fv+XIjssvZKgFM5LQcb8oFSEVF6SdtJS8HXkaCGG0=;
        b=MORrgUXIT4wqLBbe0+K0AfnC+VjEq0x/bbPtpxUnpXd0gsDvrqXnQ6KKluG7CPTxJ7
         4+Kh0ZY8RXI/+DHOG8gFIuxvNrO3jgh4lfxz+u0n4oNyccJOYZE2m7Odnb4n8j3J37K8
         QjK0oHDQ/OuQhf1x0R8z+uD2v3qiuGUTyJqOQLm0D7wgG2hTWaF0f7S0w8rX5GiJY+Mg
         mwpHp9YBhU5wt6lm3p7N6H5o71SIwGamGb9KaF+ig5c/UVucxobXl2MKaqrD3stvhkLm
         BOR+4O9EIFj4PNZC0m0v1UUpnjXsXi7YBtpLc0+LowGJHx5pDDjqiJXztsy63xMabd0p
         X4jg==
X-Gm-Message-State: AJIora9JA+pJPTzXfO0wthqWbvWGrwxR/cSPBGUc1S7bndLFEOvlmEo/
        Ef3DV61KDUxFPVKiYzznGukPaQ==
X-Google-Smtp-Source: AGRyM1sgW7yWZ9Eym1B0Bz1koa30wmOCyPu27dOyzJBkyosUDaLeuiNz42s8fI4JjDRz6ZInmB+AtA==
X-Received: by 2002:ac8:578c:0:b0:31f:4be:8e00 with SMTP id v12-20020ac8578c000000b0031f04be8e00mr11152800qta.181.1658767292060;
        Mon, 25 Jul 2022 09:41:32 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:994f])
        by smtp.gmail.com with ESMTPSA id t4-20020a37ea04000000b006b66293d79dsm1382040qkj.80.2022.07.25.09.41.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jul 2022 09:41:31 -0700 (PDT)
Date:   Mon, 25 Jul 2022 12:41:31 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Chengming Zhou <zhouchengming@bytedance.com>
Cc:     surenb@google.com, mingo@redhat.com, peterz@infradead.org,
        tj@kernel.org, corbet@lwn.net, akpm@linux-foundation.org,
        rdunlap@infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, songmuchun@bytedance.com,
        cgroups@vger.kernel.org
Subject: Re: [PATCH 5/9] sched/psi: don't create cgroup PSI files when
 psi_disabled
Message-ID: <Yt7Hu141PirDh/pw@cmpxchg.org>
References: <20220721040439.2651-1-zhouchengming@bytedance.com>
 <20220721040439.2651-6-zhouchengming@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220721040439.2651-6-zhouchengming@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 21, 2022 at 12:04:35PM +0800, Chengming Zhou wrote:
> commit 3958e2d0c34e ("cgroup: make per-cgroup pressure stall tracking configurable")
> make PSI can be configured to skip per-cgroup stall accounting. And
> doesn't expose PSI files in cgroup hierarchy.
> 
> This patch do the same thing when psi_disabled.
> 
> Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
