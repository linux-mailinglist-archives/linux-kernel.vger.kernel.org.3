Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA60D4D786E
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 22:28:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235598AbiCMV3N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 17:29:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230385AbiCMV3J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 17:29:09 -0400
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41AEE255AB
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:28:00 -0700 (PDT)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-2e2ca8d7812so82370347b3.13
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 14:28:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kMbbSXeuuVuuTs669VGVPiqKk5sYijV81mJywT7+SYQ=;
        b=qCIbgh1hhic7psMQ3Brv/zUqNUeuV4Vb5RbHdc6HNtSu7mDzBpSBHda9392NK1yI8R
         1V6O2zn60vAUJZZ1PiOOuaHQFAyTk7Z/Fi2j1Bf1oHg4C0FNLynb9lLlU+sn4s8p+aux
         /NHkUnMT6WeM3vZ/VnbpisxKt+pbTNzOglmGIB/4EgjgsplEd164ilsqFKiTDmuRB2Fd
         bh8l25F/Wa6+ksklovFsdkSyXHP++kBDlDbXj4Cykrj6+kG6v/0rjNfcSre8soz5AtTV
         2XWbXooYGZlKg2ktB7NkT7GzQuV3ycZckvAdNoFeN6AbE54OFT2bVkxRffVvsaC4ujX4
         S0Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kMbbSXeuuVuuTs669VGVPiqKk5sYijV81mJywT7+SYQ=;
        b=Q9Z/DfmyGak8VyTHuXBhectWnELDq/cs9uq3RBRMfZZTr7aFaF4GKkjCbZGr5vkHHJ
         fQCN2i6myJXPs/u0Cp3rI+huKuyYEiQjNvshisLS2QaQoFFcTpMHoNS/1CLhheRTv8gf
         RRoduwqCjRNSQPTLy4lnlprj/NOuub8iWbMZpY3aiaGF7CR6RiPT02B0+n0di4UC0bLZ
         2c+Tcm/3qCvq6I4PKjSEarwCmhzAPsskBDMozb4cUCzM/iI6yBA74gYBApZXDP7G3YFj
         f6pezEuV8XjS+8n2O1Lfgg5opyPA8wbWcHkQmBu90fNYPNI0RVTmHMFLjQxSm/KemH5o
         dGYA==
X-Gm-Message-State: AOAM532g00j72Zh7YPwB2P3zgY+q1jUk9RIa3NP4MdVNkrZyfOLYsZVQ
        AgV6rE6XkbsgAgj+mz9G+h0yDBshmVf/zYDJzHfQjw==
X-Google-Smtp-Source: ABdhPJyoVATrmtdXU5YGPBbpEoF/1Z+Jdn9w9QfpXBMvz/HzxT+n1v2FIcXvgWnKr5Akom1tswDuq1uSVuuVFO99ZFs=
X-Received: by 2002:a81:846:0:b0:2db:f920:5c62 with SMTP id
 67-20020a810846000000b002dbf9205c62mr16607788ywi.489.1647206879050; Sun, 13
 Mar 2022 14:27:59 -0700 (PDT)
MIME-Version: 1.0
References: <20220312154321.GC1189@xsang-OptiPlex-9020> <15307f8a-c202-75d8-1361-dae0146df734@suse.cz>
 <CANn89i+fM0k+=Qw0M0fso1f-Ya8--5+==gtcWqCpo=Gu-ca1Ow@mail.gmail.com>
 <8f499c76-68cb-a2c3-01fd-c8759e2fd317@suse.cz> <CANn89iJwBe4+C8KP--c_9O6QE_Tou+1Z0+ugtuniG-06nzxPmg@mail.gmail.com>
 <Yi5ftFbykAZLLCwf@casper.infradead.org>
In-Reply-To: <Yi5ftFbykAZLLCwf@casper.infradead.org>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 13 Mar 2022 14:27:48 -0700
Message-ID: <CANn89iL9u-dWpgNF7YGrQ4RQ5M_BwmS8Hqq3DPeWJunKRbu-PA@mail.gmail.com>
Subject: Re: [mm/page_alloc] 8212a964ee: vm-scalability.throughput 30.5% improvement
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        kernel test robot <oliver.sang@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        0day robot <lkp@intel.com>, Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org,
        "Huang, Ying" <ying.huang@intel.com>,
        "Tang, Feng" <feng.tang@intel.com>, zhengjun.xing@linux.intel.com,
        fengwei.yin@intel.com, Eric Dumazet <eric.dumazet@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 13, 2022 at 2:18 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Sun, Mar 13, 2022 at 02:10:12PM -0700, Eric Dumazet wrote:
> > @@ -3065,6 +3062,12 @@ static int rmqueue_bulk(struct zone *zone,
> > unsigned int order,
> >          */
> >         __mod_zone_page_state(zone, NR_FREE_PAGES, -(i << order));
> >         spin_unlock(&zone->lock);
> > +       list_for_each_entry_safe(page, tmp, list, lru) {
> > +               if (unlikely(check_pcp_refill(page))) {
> > +                       list_del(&page->lru);
> > +                       allocated--;
> > +               }
> > +       }
>
> ... you'd need to adjust __mod_zone_page_state() too, right?

Probably !
This was only to show the basic idea, as I said, not even compiled or tested :)
