Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D213153CC65
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Jun 2022 17:38:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245590AbiFCPiX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Jun 2022 11:38:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239078AbiFCPiU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jun 2022 11:38:20 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 936742B26B
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jun 2022 08:38:19 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id v5so5796710qvs.10
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jun 2022 08:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=SJXhCrUR8OTVpnLcTOK6eseLDr1ev0Qsg1uNsb9nbv8=;
        b=Q3903lNQQOni7+M4c5ncDu0HLSUQTxvb297A868WBL3HKMBPQ9Vxh/IhIjiQX1r4Mf
         oyPtz/NaYgx9vPorrhxthWs8nTd6jQem8/d8QfACSCYmw293IQT2yN0P/EWNdgruyhFq
         lyiiTi+D0Udva2DO+r+itdpjfySDS4zPtxkSO5vNvipNuYnCsF7uECI0JMrsC4i6qpjG
         t5X6fC3832TP1X39Rj60D7oR6+/p9kggMlLea+C5PdyeOkXxzW274DDdPpsUZo82YHIa
         JFFvkH1sXQQxu2WphhiDNw8+u+F7dY6Bqc6KZ4bckG21U9BdPPBK7xWAyUe2m3/sxgjq
         f53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=SJXhCrUR8OTVpnLcTOK6eseLDr1ev0Qsg1uNsb9nbv8=;
        b=F+X6M3yAYOkklPEBbTOS+zD5h60fXUX+8LxJlG9wfXO0LHRkIBafvn8O8ryFkVPwJ0
         +tQnu4bJpZuDzp05Xe/Q20VPvXHLMmKAJYmDJdCDhqs9/ICFn+OCOZl8SyJncJP5kqMT
         g8nhE0j9zkFsrAyYid4aod0aUdVM5CLXed9IlA4uThNSOOH9EYbVXcGTUplrTzG3AjLB
         P2hQCFucq8veLYokZrqa61auEuL2NkIYfHZlEcZgp2cc3MV8feN60fB8eQKo80vkeybR
         ro869koRkulilLIJVx2Ax8DReMDXo5exjqSj83gABw4NVzw6GvadZ0ptSV8mFPHcinTT
         M7Lg==
X-Gm-Message-State: AOAM530bvBzaLYP+I+iRsMLcr0xkrGjR0z6uPfUfQuHKKRrifXrPiloA
        vzFOueU/URpt6rhArFNBxiZOR7uI3TMm9A==
X-Google-Smtp-Source: ABdhPJxdZQ9/SUfZZTAwPP0SSmcim7n4j2UV2gr4nbRDnef4WqhMGWV2G4k+wJYZM/q3KcMDiuC8dg==
X-Received: by 2002:a0c:df8c:0:b0:465:d376:1ec0 with SMTP id w12-20020a0cdf8c000000b00465d3761ec0mr7369798qvl.97.1654270698608;
        Fri, 03 Jun 2022 08:38:18 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:1d66])
        by smtp.gmail.com with ESMTPSA id y184-20020a37afc1000000b0069fc13ce225sm5204351qke.86.2022.06.03.08.38.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jun 2022 08:38:17 -0700 (PDT)
Date:   Fri, 3 Jun 2022 11:38:16 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Qi Zheng <zhengqi.arch@bytedance.com>
Cc:     mhocko@kernel.org, roman.gushchin@linux.dev, shakeelb@google.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        corbet@lwn.net, linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org
Subject: Re: [PATCH] mm: memcontrol: separate
 {pgscan,pgsteal}_{kswapd,direct} items in memory.stat of cgroup v2
Message-ID: <Ypoq6KLItUWsOq+E@cmpxchg.org>
References: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220603070423.10025-1-zhengqi.arch@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 03, 2022 at 03:04:23PM +0800, Qi Zheng wrote:
> There are already statistics of {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct of memcg event here, but now the sum
> of the two is displayed in memory.stat of cgroup v2.
> 
> In order to obtain more accurate information during monitoring
> and debugging, and to align with the display in /proc/vmstat,
> it better to display {pgscan,pgsteal}_kswapd and
> {pgscan,pgsteal}_direct separately.
> 
> Moreover, after this modification, all memcg events can be
> printed with a combination of vm_event_name() and memcg_events().
> This allows us to create an array to traverse and print, which
> reduces redundant seq_buf_printf() codes.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>

Sounds good to me. We inititally didn't do it because /proc/vmstat has
the breakdown to understand global reclaim behavior, and cgroup
reclaim doesn't have a kswapd. But it's nice to stay consistent, it's
helpful to understand if certain cgroups have a higher share of direct
global reclaim (GFP_TRANSHUGE* for example), and we very much do want
kswapd per cgroup down the line (we've had it in production for ages).

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
