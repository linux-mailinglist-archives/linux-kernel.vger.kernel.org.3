Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99B150FBAD
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 13:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345232AbiDZLJa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 07:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231545AbiDZLJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 07:09:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B6A4D29806
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:06:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650971176;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DHfnXNbbraU+74d3T1xSt5cZBiLAUCkRDpQuxcIh3qo=;
        b=OtZQ5ozPgzFjZ586LYoKznp5B4cTc7ysE0wtVOIqzo0hg25xq6tcRWMzUeT0hCAnuybaTs
        KiJP9RtQJmTUv+MxNuJAbOXv8ezvAglZ+LAd4Xj3yrRtmrWmhJm3niS0jttZiG968tK7dV
        4DOhPR+0dg34uooBEBfBOTBLjS/CBx0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-183-jdBrqvlCPQW13Q3iKCq0BA-1; Tue, 26 Apr 2022 07:06:15 -0400
X-MC-Unique: jdBrqvlCPQW13Q3iKCq0BA-1
Received: by mail-wm1-f72.google.com with SMTP id d13-20020a05600c3acd00b0038ff865c043so1067475wms.3
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 04:06:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=DHfnXNbbraU+74d3T1xSt5cZBiLAUCkRDpQuxcIh3qo=;
        b=yXvecu4O84xBvsQNj57gO5i9aZmibrE/MmwGyOrRjnD9q8WjFrF//RtO7MSQwTpXCn
         lLxHpKn2k60DxP1o4LaUSHs+ylKRQUEmbhGBPSdkhScqZLPibGzKJi4iFDyJWWWoqEAO
         2jNaRCrjfJupKC+uhKz/vGPAeI9vK4cXv5b/qRCwNYPKTLjS23MElqg6OwIJE6drKuCr
         5Vv/KKeR42VVvSCWum9MVFH6XoaV2idixFJn3NGVnSFKLkXfKvzj/hryZqE3DOFnxG4f
         QMjLeg/Xu1M8O3fLTFy4TuhvfuQ5Zd/K+ZIciuANfSl1nSh7/wGFeAA41oeJlaeKPkeg
         YV9A==
X-Gm-Message-State: AOAM531unesxQ+VjkT7/T+/fvxD8voQkTkOPcHPx1Fo4gIGNtHI46+3q
        rjA/FHwUeyVFVm8KoKaQ5w4phyp0mVRw2Vvw1T68hr3VRIDV0aXRzAWJjOhwyIb5Byz92Y/1lfj
        AWA32dz2ryB4hGSFuk2s071bp
X-Received: by 2002:a05:6000:223:b0:20a:db3a:e761 with SMTP id l3-20020a056000022300b0020adb3ae761mr7883472wrz.43.1650971174193;
        Tue, 26 Apr 2022 04:06:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy+Ob9PQFNXcWbkfeMMvapipW9rElBZyeHIS9L5GSq7xdZt6/Me6QPwGd36G3ygXGirhLZhSw==
X-Received: by 2002:a05:6000:223:b0:20a:db3a:e761 with SMTP id l3-20020a056000022300b0020adb3ae761mr7883418wrz.43.1650971173519;
        Tue, 26 Apr 2022 04:06:13 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92? ([2a0c:5a80:1306:2f00:cfcf:62cf:6f38:dd92])
        by smtp.gmail.com with ESMTPSA id r17-20020a0560001b9100b00207afaa8987sm12848160wru.27.2022.04.26.04.06.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Apr 2022 04:06:13 -0700 (PDT)
Message-ID: <cf861ff3bf106b71994886cad7c4570b6ce9af0d.camel@redhat.com>
Subject: Re: [RFC PATCH 0/6] Drain remote per-cpu directly
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Minchan Kim <minchan@kernel.org>,
        Mel Gorman <mgorman@techsingularity.net>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Tue, 26 Apr 2022 13:06:12 +0200
In-Reply-To: <YmcnmZBtZEgJrrUv@google.com>
References: <20220420095906.27349-1-mgorman@techsingularity.net>
         <YmcnmZBtZEgJrrUv@google.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2022-04-25 at 15:58 -0700, Minchan Kim wrote:
> On Wed, Apr 20, 2022 at 10:59:00AM +0100, Mel Gorman wrote:
> > This series has the same intent as Nicolas' series "mm/page_alloc: Remote
> > per-cpu lists drain support" -- avoid interference of a high priority
> > task due to a workqueue item draining per-cpu page lists. While many
> > workloads can tolerate a brief interruption, it may be cause a real-time
> > task runnning on a NOHZ_FULL CPU to miss a deadline and at minimum,
> > the draining in non-deterministic.
> 
> Yeah, the non-deterministic is a problem. I saw the kworker-based draining
> takes 100+ms(up to 300ms observed) sometimes in alloc_contig_range if CPUs
> are heavily loaded.
> 
> I am not sure Nicolas already observed. it's not only problem of
> per_cpu_pages but it is also lru_pvecs (pagevec) draining.
> Do we need to introduce similar(allow remote drainning with spin_lock)
> solution for pagevec?

Yes, I'm aware of the lru problem. I'll start working on it too once we're done
with the page allocator (and if no-one beats me to it). That said, I don't know
if we can apply the exact same approach, the devil is in the details. :)

-- 
Nicolás Sáenz

