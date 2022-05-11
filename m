Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02A26523D06
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 21:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346576AbiEKTHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 15:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237377AbiEKTHB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 15:07:01 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E45769716
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:06:58 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id dv4so2758319qvb.13
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 12:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=RFcLVWiWlqjohwWrz8ZmNxS2c0JbCUFp6Lb1Ilp7lsM=;
        b=Wqi934csibhv/mpquejGDXyoEtv7L4by8ZdjiC8Vt5xc0YCHBzZJVfZphSsZTUFtlk
         BWN+uBN6xJN4vfk6rYwpgxP0+Hto8wWvFVtfTc81X66yFGK+cH1Z1HReUfrgi+Yk1g8h
         vWplRp9WFeeKoSsIxxqRrUkTH0jt2TDkk/gNd00645n46RTD+bg1mhWdv97mtH3aF0HF
         yhMdAMiB2NXXE93IjVJ7yPGxLJnM429NTCqFxnYtxNrKudFgsM3k8cVwAAYJk1fp+qp5
         X/r/ZbGqcqzfvRKub5gm3w23S19pd4l2vLznyNBwE9dbtRWA6EbSBXEb7cMd6sqpbwND
         H4/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=RFcLVWiWlqjohwWrz8ZmNxS2c0JbCUFp6Lb1Ilp7lsM=;
        b=N+WOLY//zyaEUogVSua+lyKJE7PUENAy6org6KlawFY+evL7lG693ApZVDCdWTtb9R
         bbSGCp7hci2ADxjzMAzuXDvBtAxOSdjzwyTt8+XbcBFlUIRBGbmkOHUcokAoqRr9Wtdp
         Qs2neq/rs6cb2lkA87GE4lZkncqbhQyB7tSDzTgYnld5A9mc04SiTwbTdTJV1xjRHuz7
         2jfXdeXLhFr1rTxZVXb1d3e8mKLnn9O0RFewLrFmhCaDh26PQzZPYJhRBFuWvqa+QXLs
         W5MWo0NW9R0a7e4Xrs2dPXMatORuHf5ItG8iUoPnLOprVQNzKn9P4EBAxihNzYwZlD+x
         xjFA==
X-Gm-Message-State: AOAM533f8OeluX1UjgzdDY1Ikc1ZKXAwHWUJ3rirlOYDmQ6+GQG0pQq1
        qKSTkmRRf18WgEXKmPTCuEmznQ==
X-Google-Smtp-Source: ABdhPJwN87h/5O8XKH+GeEZgluUajrgQzz3p3faqLc70d9m7twEIqgosgWojvjricOwl86yxDeE5PA==
X-Received: by 2002:ad4:4ee6:0:b0:45a:fe5a:1e2c with SMTP id dv6-20020ad44ee6000000b0045afe5a1e2cmr18676356qvb.103.1652296017143;
        Wed, 11 May 2022 12:06:57 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:14fe])
        by smtp.gmail.com with ESMTPSA id k11-20020ac8140b000000b002f39b99f6a8sm1601966qtj.66.2022.05.11.12.06.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 May 2022 12:06:56 -0700 (PDT)
Date:   Wed, 11 May 2022 15:06:56 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Minchan Kim <minchan@kernel.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH v2 6/6] zswap: memcg accounting
Message-ID: <YnwJUL90fuoHs3YW@cmpxchg.org>
References: <20220510152847.230957-1-hannes@cmpxchg.org>
 <20220510152847.230957-7-hannes@cmpxchg.org>
 <20220511173218.GB31592@blackbody.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220511173218.GB31592@blackbody.suse.cz>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 11, 2022 at 07:32:18PM +0200, Michal Koutný wrote:
> Hello.
> 
> On Tue, May 10, 2022 at 11:28:47AM -0400, Johannes Weiner <hannes@cmpxchg.org> wrote:
> > +void obj_cgroup_charge_zswap(struct obj_cgroup *objcg, size_t size)
> > +{
> > +	struct mem_cgroup *memcg;
> > +
> > +	VM_WARN_ON_ONCE(!(current->flags & PF_MEMALLOC));
> > +
> > +	/* PF_MEMALLOC context, charging must succeed */
> > +	if (obj_cgroup_charge(objcg, GFP_KERNEL, size))
> > +		VM_WARN_ON_ONCE(1);
> 
> IIUC, the objcg is derived from the compressed page, i.e. same memcg
> (reparenting neglected for now). This memcg's memory.current is then
> charged with the compressed object size.

Correct. After which the uncompressed page is reclaimed and uncharged.
So the zswapout process will reduce the charge bottom line.

> Do I get it right that memory.zswap.current is a subset of memory.current?
>
> (And that zswap is limited both by memory.max and memory.zswap.max?)

Yes. Zswap is a memory consumer, and we want the compressed part of a
workload's memory to show up in the total memory footprint.

memory.zswap.* are there to configure zswap policy, within the
boundaries of available memory - it's by definition a subset.
