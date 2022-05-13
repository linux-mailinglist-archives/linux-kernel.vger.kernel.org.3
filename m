Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 067F25259CF
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 04:59:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376605AbiEMC62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 22:58:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376599AbiEMC60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 22:58:26 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EDDA6CA8D
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:58:25 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id n18so6698657plg.5
        for <linux-kernel@vger.kernel.org>; Thu, 12 May 2022 19:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=BK1oXvJ5GIf2FU1suHezHNi/7qFAZl9bZMaNM3PZnw8=;
        b=gJmlP/0ESop7ZFumzjbllZ6BZQMA4/bSTF6CHpTcfj+y8XGiHzA31xniLi7L0bjEuG
         FBptfolfc1RU582mUDpnJ7Cy8qKSZ2RjkgLE3N1q85guO/NngmE9BW5KsAS9HR7hlrsK
         nTQmVjYQ0qMJGi0e+YdBBQ0zHq0NRb8hNEfUX1uiEeOlVudljDPcJHZTnOpVDuDdr/Hk
         2kC71/YnZ5r+aZBWNf1muN32gywzDNdf86TRIeWeVPBsVbkSFNiSctxYi7blBRlHfZKK
         Y/PBWZSdNYbqSl3AZ2zVXHHe80x+jzCWUKDXQUWcyRmnVVKbO661KF2ykr1Z7zMlb1V8
         ZTUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=BK1oXvJ5GIf2FU1suHezHNi/7qFAZl9bZMaNM3PZnw8=;
        b=XdFNhwaeAW/UUYRTfhPHr/dwyfHzRsyBmoMdqgkVQUlwpV0edckXaBrdoCqGs21wFw
         RSmCHBtvdOz04DxYIsQ2ZsK0U0R2K7e1/73ipHigL+CtrUTNv/GmxLw1DedAkTb6K/Sv
         MCcZLqQ7o17lIeExmHvDF9rWiCcngje6xiVPrdxrUhserPm8ZOa89X1jUHa1tiXO46oN
         NK2GtdqKN1ERsiisW7kI4re94AD7yPpuCYxDWmblZN8XH2/g236U9gb5y49m7a00Vvi4
         a3sVcZuuI7JE3lZ4GqaFpyH1bKdeEivJszZFTAur8eemsRIwLSK6keaZ7i1hCpG9Cm9J
         vtvg==
X-Gm-Message-State: AOAM531cDzbHlHeeGjK3dByAzN1ebcqhgue61aTwrnUEbxZ6VRxuNPxP
        0OoGLphUhGmtMYTGV2gu1qQ=
X-Google-Smtp-Source: ABdhPJxR/b2tOctSPYtdjnc1KCCHEU3LGIz7N5tLVUtkzZSR8i4GsI9cp5zeMXoMd7M6kXeKo/gioA==
X-Received: by 2002:a17:902:7783:b0:15f:21f8:a1d6 with SMTP id o3-20020a170902778300b0015f21f8a1d6mr2846282pll.66.1652410704709;
        Thu, 12 May 2022 19:58:24 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:6c64])
        by smtp.gmail.com with ESMTPSA id b9-20020a170902650900b0015e8d4eb263sm599117plk.173.2022.05.12.19.58.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 May 2022 19:58:23 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 12 May 2022 16:58:22 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Josh Don <joshdon@google.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        linux-kernel@vger.kernel.org,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Subject: Re: [PATCH] sched/core: add forced idle accounting for cgroups
Message-ID: <Yn3JTpXhWRTeahyG@slm.duckdns.org>
References: <20220513005427.2507335-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220513005427.2507335-1-joshdon@google.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 12, 2022 at 05:54:27PM -0700, Josh Don wrote:
> 4feee7d1260 previously added per-task forced idle accounting. This patch
> extends this to also include cgroups.
> 
> rstat is used for cgroup accounting, except for the root, which uses
> kcpustat in order to bypass the need for doing an rstat flush when
> reading root stats.
> 
> Only cgroup v2 is supported. Similar to the task accounting, the cgroup
> accounting requires that schedstats is enabled.

We've been collecting scheduler stats in cgroup core so that we always have
them available whether cpu controller is enabled or not. There's nothing
actually specific to cpu controller, right? Would it make sense to collect
the cpu core stats the same way as the rest of scheduler stats?

Thanks.

-- 
tejun
