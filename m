Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8669A4CB004
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 21:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243516AbiCBUjS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 15:39:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235653AbiCBUjQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 15:39:16 -0500
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30710403CA
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 12:38:30 -0800 (PST)
Received: by mail-oi1-x232.google.com with SMTP id x193so2914249oix.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 12:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=QJV9wMy/DzXQPXsbSuyFmVzcsqoF1stE/+aya76n8qA=;
        b=NDC3WLqJSIrlz0+6hJxCWkI9iAA5lRqUBp65d7Q+G5hdcHRRUf4O5H+ryEWbJfVkMv
         XGcpZ31mZHN4z7XrI2bePwsxYrZtFNXUW1Q/zrG3eBYGvj7ZaAZMB5WdnaDOf3J2p66d
         N8i0LA4H6U3M9Z57cVXruJ1m1QU0ibNC9WYP61INzcfX4sOV6rpGad02wgiJFkrJ9a0T
         t3dp8z7BTOwi1n2oCJwkm8y1vJXLFU1HgARufGpXVu7RiYHJxl0eu9fwnvGDgzzqUNVQ
         zm/iJ/x7H2S+aScD1356/U5icX1j/Fy2MU8t1nkv4/xQE0QEcKghhtmQRuT+NaBQnn1C
         2IEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=QJV9wMy/DzXQPXsbSuyFmVzcsqoF1stE/+aya76n8qA=;
        b=iC3nIYUxbFiV5lXY7LO2fBNQkVdK2GztBSsVqmRxsCVtdKG4wXcR31RxMhqH5y9JVC
         3a6IBsg0SwJWRu/Mtm4ZZIzGs070ZhWa6Z8afulo9ClIC8IdqBUKRvHkUAg0ducIHs3N
         nvi1AOsKn0Mxq0btU2FJdJYTgwJKDgDAZlRv60DIOH/cJ/+Qf7Hv4LCADmB7ME6cdpI1
         T4w7HtA+RuQpmAcD2o3xQERhRH6YDknHIZqneU0e2DgJUgy+eqfAbQwoAZre0qxX/zck
         +9rrMkawQGL04mjq95gSYB63tvatZBgyO2NG7E9X8jG8feAu1y29+pWP9+6sDUSp6bxT
         1FLA==
X-Gm-Message-State: AOAM532/cNozqRksfLof//BJad1BKNf41Q4fWj/iKbseQ6WVICuy/4rH
        qq1OVbbjFupgw28E+FYilhDEYQ==
X-Google-Smtp-Source: ABdhPJxRhBNyccS2s8ylBo1gwq2VZ8xcU9gbJhn+89OK+nNf+clhZLl7aHlNiXUiEiGUhKJgX9UUcA==
X-Received: by 2002:a05:6808:1645:b0:2d4:377e:eb92 with SMTP id az5-20020a056808164500b002d4377eeb92mr1615612oib.166.1646253509370;
        Wed, 02 Mar 2022 12:38:29 -0800 (PST)
Received: from ripple.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id m2-20020a9d4002000000b005a2678bbc5csm19590ote.24.2022.03.02.12.38.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 12:38:28 -0800 (PST)
Date:   Wed, 2 Mar 2022 12:38:00 -0800 (PST)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@ripple.anvils
To:     Michal Hocko <mhocko@suse.com>
cc:     Andrew Morton <akpm@linux-foundation.org>, cgel.zte@gmail.com,
        naoya.horiguchi@nec.com, minchan@kernel.org, hannes@cmpxchg.org,
        rogerq@kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, guo.ziliang@zte.com.cn,
        Zeal Robot <zealci@zte.com.cn>,
        Ran Xiaokai <ran.xiaokai@zte.com.cn>,
        Jiang Xuexin <jiang.xuexin@zte.com.cn>,
        Yang Yang <yang.yang29@zte.com.cn>
Subject: Re: [PATCH linux-next] mm: swap: get rid of deadloop in swapin
 readahead
In-Reply-To: <Yh889CjjSxigdEAY@dhcp22.suse.cz>
Message-ID: <94de248f-94fa-91d-eb80-2ea75548282d@google.com>
References: <20220221111749.1928222-1-cgel.zte@gmail.com> <YhyAfSTkXFmIam9+@dhcp22.suse.cz> <20220228073315.c855e15b108089187a40d2b0@linux-foundation.org> <Yh889CjjSxigdEAY@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-18.1 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2 Mar 2022, Michal Hocko wrote:
> 
> I might be really missing something but I really do not see how is this
> any different from the page allocator path which only does cond_resched
> as well (well, except for throttling but that might just not trigger).
> Or other paths which just do cond_resched while waiting for a progress
> somewhere else.
> 
> Not that I like this situation but !PREEMPT kernel with RT priority
> tasks is rather limited and full of potential priblems IMHO.

As I said in previous mail, I have really not given this as much
thought this time as I did in the 2018 mail thread linked there;
but have seen that it behaves more badly than I had imagined, in
any preemptive kernel - no need for RT.  We just don't have the
stats to show when this code here spins waiting on code elsewhere
that is sleeping.  I think the difference from most cond_resched()
places is that swapin is trying to collect together several factors
with minimal locking, and we should have added preempt_disable()s
when preemption was invented.  But it's only swap so we didn't notice.

Hugh
