Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59F374EE75F
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 06:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244874AbiDAEc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 00:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232741AbiDAEcq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 00:32:46 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B235C1FF431
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:30:56 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id t11so2966100ybi.6
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 21:30:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=PjBvR0dAm80PmgfJzJt2hGMFU/x9BOyTDKcoptqgwx0=;
        b=kJMay4fVLDENECNlphQ79WBRJP0IoZbVeM9+X+XSCsug4JDCxGAvzvPx8XhpmbczvQ
         +Mez9GVXTxH6cTHpmydV6Zl9jFW7BFu5L57zVVZtKCB8rmr5rl2OOlMXeLjth7/p/n/W
         6NZtCsncV1WI4uVA+R2rK+ww0E7hReTFAPIAg4x6WxD6lEb24azdIojUTn5Im+XbT/eU
         1zkfBy33KTZ2m6exL6gWTUUinKcIeiwqL3JyPxte68Su/HOBtH5UX/ueHuuHvtvHN4mC
         X3pSDOaqSnYxtowsabCd8VlQvs/7C4Pd4okFYEZ2YNyXw61mQgDgNRJSatC7kYT9NP2w
         zv7A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=PjBvR0dAm80PmgfJzJt2hGMFU/x9BOyTDKcoptqgwx0=;
        b=3c20Ga0YJxA/Yhgf8pk7Q0wjuxOytwSE79QhSpNeVOlwGQPwfjQ82Oj9wwqNn6pqwX
         jaxfhpuIW/DTXCOm7sEpPXr0j+LxssQLN3RuGRCF6QrDA8IWyuAGe99zpa0+6ALjkACm
         4OwjUBhXze1qp84Ka8RXq+dxlvK2SnJwhaGpeu4Fc3wlCE3ltT6U9ZQk8orAzxlaY2nx
         NsvP1PI8QNFnV+vTf313pidSBVTBYWmc1xjtc7fZthuAQfbQtHWYI9svtg+3dFKQJl7K
         UMGn/ikJKDdiNNL9/OCnbjabpAK58MEBwsHlQQlc1Gc0bmvt7tdSAnc/KxEH6NanK/3j
         SItg==
X-Gm-Message-State: AOAM530W/OugLsZtoMw+HD9kWK5/OwegDKNPzqpu+x6hy6/dlH99f8Hg
        AtUW3tPk/ak3O3inyk8+smQIlwga3GB24+mG8x2JotdTDHVMHA==
X-Google-Smtp-Source: ABdhPJyc1iNDbSeZ01gaX2/NC8f4Pgl0sHX3EafzDNf7c6y1fcJCaMSsQqApSzbhQhpc25GxuLUZzgehCLNXwMjlgNw=
X-Received: by 2002:a25:c049:0:b0:634:6751:e8d2 with SMTP id
 c70-20020a25c049000000b006346751e8d2mr7293293ybf.6.1648787455925; Thu, 31 Mar
 2022 21:30:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220330191440.1cc1b2de2b849d1ba93d2ba7@linux-foundation.org>
 <89B53D3A-FCC5-4107-8D49-81D5B9AE5172@linux.dev> <20220331063956.5uqnab64cqnmcwyr@google.com>
 <YkVcbElWjomA7ofF@dhcp22.suse.cz> <20220331181126.815cfe2b05b4281d32b7bf49@linux-foundation.org>
In-Reply-To: <20220331181126.815cfe2b05b4281d32b7bf49@linux-foundation.org>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Fri, 1 Apr 2022 12:30:19 +0800
Message-ID: <CAMZfGtUfsGECdA8Nj=_xCurs3LgnB9ATc7J=dFA4_V_Zy-1FnQ@mail.gmail.com>
Subject: Re: [PATCH v2] mm/list_lru: Fix possible race in memcg_reparent_list_lru_node()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Shakeel Butt <shakeelb@google.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Waiman Long <longman@redhat.com>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 1, 2022 at 9:11 AM Andrew Morton <akpm@linux-foundation.org> wr=
ote:
>
> On Thu, 31 Mar 2022 09:46:52 +0200 Michal Hocko <mhocko@suse.com> wrote:
>
> > On Thu 31-03-22 06:39:56, Shakeel Butt wrote:
> > > On Wed, Mar 30, 2022 at 07:48:45PM -0700, Roman Gushchin wrote:
> > > >
> > > >
> > > [...]
> > > >
> > > >
> > > > But honestly, I=E2=80=99d drop the original optimization together w=
ith
> > > > the fix, if only there is no _real world_ data on the problem and
> > > > the improvement. It seems like it has started as a nice simple
> > > > improvement, but the race makes it complex and probably not worth
> > > > the added complexity and fragility.
> > >
> > > I agree with dropping the original optimization as it is not really
> > > fixing an observed issue which may justify adding some complexity.
> >
> > Completely agreed. The patch as it is proposed is not really acceptable
> > IMHO and I have to say I am worried that this is not the first time we
> > are in a situation when a follow up fixes or unrelated patches are
> > growing in complexity to fit on top of a performance optimizations whic=
h
> > do not refer to any actual numbers.
>
> Yup.  I did this:
>
> From: Andrew Morton <akpm@linux-foundation.org>
> Subject: mm/list_lru.c: revert "mm/list_lru: optimize memcg_reparent_list=
_lru_node()"
>
> 405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_node()")
> has subtle races which are proving ugly to fix.  Revert the original
> optimization.  If quantitative testing indicates that we have a
> significant problem here then other implementations can be looked at.
>
> Fixes: 405cc51fc1049c73 ("mm/list_lru: optimize memcg_reparent_list_lru_n=
ode()")
> Cc: Waiman Long <longman@redhat.com>
> Cc: Roman Gushchin <roman.gushchin@linux.dev>
> Cc: Muchun Song <songmuchun@bytedance.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Shakeel Butt <shakeelb@google.com>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>
