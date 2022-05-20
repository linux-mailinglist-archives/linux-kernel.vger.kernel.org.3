Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FA652F360
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 20:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353039AbiETSn5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 14:43:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353027AbiETSnv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 14:43:51 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B28D814A6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:43:50 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso8586404pjg.0
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 11:43:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=mtXHfcEJa6gaynzn3mJFjpr2Kt1NnYIFnTGWwVddj24=;
        b=Nb93/h3uoEP/gk3DQInvuup6FkW7I8/YtUj4+LqGyWSECATnwUI3lw2UaIZSqJEXM8
         AOwGBZxmmup2nbdQiw72KRcUEMqJ2WSZ3ivPDcm9uB1O7y2pXlBB1W1uz7x44DbeIkzn
         y9cIaUSIHB8YDHQloQ4OsBxRMpQb9iT0prOYZdn7nkoy+wDZh2W0guko1qjiPmQ1c5Zi
         dOcrBdf9IlN1E61bxedvV8qlmAhH+8CvyGhdRoJsIubrN6KcxZAyFJE9ZfxU9ojezeVP
         kVyoSD3RpCoUlUltlkb9QyLq4OzjGv2SlfBdvw4lsHxWHUIKXUvqXktuvEp2oVxDAs5F
         cK/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=mtXHfcEJa6gaynzn3mJFjpr2Kt1NnYIFnTGWwVddj24=;
        b=mCJkEu6g68hkBrw8QPfTUE7caV60EdSbf6YZEH2Iip6fdSvQt7tRsJuRQ2oNyO4+Jx
         Bc0CFiAp3qbU0y3AXY7JKti8GDnszJVVqXXEEL8fMq5jxcwt8pznVBcHp+YdCBvVtExZ
         1rgu2qa6414TmWy9xTV2OXGX0d1Fz7Q1pIo/jRrls6IaL9tLogIX9eG56WCXiQiOxF+2
         AoS2poE9nvWxTwQ8kKy9Pr+ZCBpIibKYRjAovx0pBtjyRzLUbxpJqO4GmQmO2V29zDOf
         VyTuxMXX/wuygwLiJHRc/4LesjNj7DPSfVhvUnhJ5D7bjETn9nKA8TlUKp6q3F6DJ3IS
         HUHA==
X-Gm-Message-State: AOAM531uPS6+LiF33OGKNNHolCE9kC7sSsXyiXAOIW07UHOlVTGP5/ri
        9GsevOICMJ0/gjJaEQnrHVI=
X-Google-Smtp-Source: ABdhPJwcKmGMHcq0pq8E/eO1/GwDjQ275yWibv2K5vs4kmhx43te8byIyERMFcr85pAQP3lEetlxrQ==
X-Received: by 2002:a17:90a:b88:b0:1df:2b03:20c with SMTP id 8-20020a17090a0b8800b001df2b03020cmr12398664pjr.46.1653072229733;
        Fri, 20 May 2022 11:43:49 -0700 (PDT)
Received: from localhost ([2620:10d:c090:400::4:1761])
        by smtp.gmail.com with ESMTPSA id w6-20020a6556c6000000b003db7de758besm103926pgs.5.2022.05.20.11.43.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 11:43:49 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Fri, 20 May 2022 08:43:47 -1000
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
        linux-kernel <linux-kernel@vger.kernel.org>,
        Cruz Zhao <CruzZhao@linux.alibaba.com>
Subject: Re: [PATCH] sched/core: add forced idle accounting for cgroups
Message-ID: <YofhY8kcTrQOs2iF@slm.duckdns.org>
References: <20220513005427.2507335-1-joshdon@google.com>
 <Yn3JTpXhWRTeahyG@slm.duckdns.org>
 <CABk29Nv=J_ZUnDTkRhwdQop=REr_XDGjJxn_zVy4kBqwx8K57w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABk29Nv=J_ZUnDTkRhwdQop=REr_XDGjJxn_zVy4kBqwx8K57w@mail.gmail.com>
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

Sorry about late reply and thanks for the ping. I missed this one.

On Fri, May 13, 2022 at 12:23:16PM -0700, Josh Don wrote:
> Yea, that's right, this doesn't require the cpu controller to be
> enabled. Are you suggesting to add a new field to cgroup_base_stat?

Yes, that's what I meant. I think it'd fit there better.

> One other weird artifact of collecting forceidle time is that a cpu
> may account it on behalf of its hyperthread sibling. Currently, the
> core rstat code always accounts to the current cpu's percpu rstat
> field. I can add an accounting function to support writes to a
> different cpu's field, in order to make sure that the per-cpu totals
> are correct (the forceidle accounting code holds rq->__lock, which
> protects all HT siblings of a core). percpu totals aren't currently
> exported in cgroup v2, but this is useful information that we'll
> consume, so it would be nice to keep it accurate.

Sure, as long as it doesn't incur overhead when not used.

Thanks.

-- 
tejun
