Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6879F55CDDC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:04:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233696AbiF0JQL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 05:16:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiF0JQJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 05:16:09 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FA192BC6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:15:59 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id x8so3942245pgj.13
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 02:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=bNnFBnKhPFGfGD+ImTf24fxxCOjOjTe6BgjaRqu3fj0=;
        b=OnVQVkCyLgFJ/5xuBfD/UW5NpC+9XCEeM7jOLbOkYJ4TyX8y4YX5yRo5nKzuCwbH+p
         ANAc2pid9t9+9Fq6xEf/WSraUXKandsYYlaNMKHT00wgzHsGzaVd/RAXhfPFbLcgxXdZ
         wptWlX+y9fC9XzeCDynu5zrxoXWclpXttGVWmxBCeTVWpfvWaP+enk8Z4hl2FlaF9Lxv
         cSnCuryVVNosuLx4yGD/1cwJwGBREJeyo2Svas9uTljqkLnLeu+74p6To2rbh/DwmRbw
         cgxhzOutUkAsFfiMvKf4Pa6znV+V9g//nCdY9h0mKYCJAWn76ISul/ws+sFrrVB+pLvJ
         h4yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=bNnFBnKhPFGfGD+ImTf24fxxCOjOjTe6BgjaRqu3fj0=;
        b=IZovpvmBeJFAOLRF96DdOwViVWaiDxaY6dJ785f5kCO7Q9OXoX6/I1saFEkXF6EUn+
         1zb0JgSko2d8HyocPei7SwTmDbI/sBDTTB49hU17Yy2UqA988XlQp7RBBTJncFGXGb1f
         KMsxmGY8C7wWNQzTglPzjzvmB3pgubplRbR4h4+0wSBb9MhFLBkBP/5VlMTgMrIoN1Bv
         En3fGTM3nQDT3Ofv1zcDH2GUebQmsoiX+pAWLJC6OsOaTRIJxeILvQCuLPYd6w3/N9dH
         AA77uGGp+5PWxDmViCtrucRlEfGlNSFC4444aP3bJUcJbIhxEyjFfTPF/gWFXSWmaOHY
         nE2w==
X-Gm-Message-State: AJIora9z/bjMNr/I38WhnySZQHiOSTzeE/qYqioAEGBOQByKQAjnFm2s
        NJ8nBZt7RJbD2wgUTCq3Y8o=
X-Google-Smtp-Source: AGRyM1ujKvNwyuAkcKckGo66HJukD4ksysJ5Oa5K4ItLJm0Eiy0JsdZPCYdAWAWcsSaK7m928YZGZg==
X-Received: by 2002:a63:4654:0:b0:405:e571:90b with SMTP id v20-20020a634654000000b00405e571090bmr11794488pgk.120.1656321359346;
        Mon, 27 Jun 2022 02:15:59 -0700 (PDT)
Received: from localhost ([121.167.227.144])
        by smtp.gmail.com with ESMTPSA id je20-20020a170903265400b00161f9e72233sm6640504plb.261.2022.06.27.02.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jun 2022 02:15:58 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Mon, 27 Jun 2022 18:15:57 +0900
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
Subject: Re: [PATCH v3] sched/core: add forced idle accounting for cgroups
Message-ID: <Yrl1Tdds6g7h60F3@mtj.duckdns.org>
References: <20220621234443.3506529-1-joshdon@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220621234443.3506529-1-joshdon@google.com>
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

Hello,

On Tue, Jun 21, 2022 at 04:44:43PM -0700, Josh Don wrote:
> 4feee7d1260 previously added per-task forced idle accounting. This patch
> extends this to also include cgroups.
> 
> rstat is used for cgroup accounting, except for the root, which uses
> kcpustat in order to bypass the need for doing an rstat flush when
> reading root stats.
> 
> Only cgroup v2 is supported. Similar to the task accounting, the cgroup
> accounting requires that schedstats is enabled.

Generally looks fine from cgroup side. One nitpick follow.

> +	seq_printf(seq, "forceidle_usec %llu\n", forceidle_time);

Would it make sense to namespace the name to reflect the fact that
this is tied to core scheduling? e.g. something like
core.force_idle_usec (and yeah, underscore between words, please). I
kinda hate that the feature is named "core". The word is so
overloaded.

Thanks.

-- 
tejun
