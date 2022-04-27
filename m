Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6574F51220F
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 21:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbiD0THU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 15:07:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232245AbiD0TG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 15:06:57 -0400
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FA267C243
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:53:45 -0700 (PDT)
Received: by mail-qv1-xf2c.google.com with SMTP id r8so1688477qvx.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 11:53:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5Bxi6KofN0Ih5O2P5EXy7XNcKRJLdVQH6xt19JcR/Cc=;
        b=65NapwWd4Bu52BgiMzSrFcem1E52ZJnpS0GWN6sZuF8lZ5D+NZ9Ww0Anh9KupdJguI
         UzAS0QkUzTyoa4mXefmL3ncFHMeJEYGiv8Y4ZWUY5GqWqlu6l8H3TeskMI6hQscaCpfY
         xFTNfO8WOciEzvX0JjGttg51D/9bWg1IxH7Q9heQTyN0Ax1r1H6fpSgxb1qUOYSOt4/b
         VLQI177Dk/OGl9IygOnXPdYVJLVXXFN59R2Qt3TQ2OMHxqMptwsfkrNXKPx5A6KaTz0c
         ZfjzEibO+5o5S6D/+WwZ8cM2fs2lXZy9mXt7BWxQ6A3lY0GIvJq4h5tUVYWmcEZW3FdV
         8Jzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5Bxi6KofN0Ih5O2P5EXy7XNcKRJLdVQH6xt19JcR/Cc=;
        b=z1NSrFpuUQpf5cqD0+IlanSMIhfl63nJ+ulC/7S0dvDwmsXyAuq1xGnGCyTiwuNmv9
         4/5b4FrxmGaTbe4piC7mLr4YxpAQ+CPwivQnPFJ+S9MjrQejrhbboQ0Z1T0qvUrNH52B
         jb6ObthuVatzl+d346VaCBI2QcNDQVhqh9XqjGULH+tA3XQZ1h+rFqnjwlk48A0nS4Bx
         koaly4nWeZOWU4Xcf3E6F72SWll3ERzaCEix7jOZLaxwrv2XLKeGkG1bKzalYGmF8Idg
         zpkR6cwsyJW8mTeDcrgLj3TH92oHBV2tGG3KMM94uq41qHiahazA2yJlD4h89anFsthi
         HTTQ==
X-Gm-Message-State: AOAM531uPi4YDPVtPPH7RQS4oC55L5pDX2sO/iXjDsS8KFSj00uqiX3a
        mzYRSB2iDiTRbFW8ZYVvi9AYBw==
X-Google-Smtp-Source: ABdhPJy8dRFnCXB+gsjhhIqlkGq+xCQRJDXI9iajkuXVfgL7CeLRLL3u3OvlYSHjyEszbXwsVMwtjg==
X-Received: by 2002:a0c:c3c6:0:b0:42c:17e4:9a75 with SMTP id p6-20020a0cc3c6000000b0042c17e49a75mr21460568qvi.124.1651085624374;
        Wed, 27 Apr 2022 11:53:44 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:f617])
        by smtp.gmail.com with ESMTPSA id r9-20020ac85c89000000b002f378738ed4sm3690092qta.7.2022.04.27.11.53.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Apr 2022 11:53:44 -0700 (PDT)
Date:   Wed, 27 Apr 2022 14:53:08 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Shakeel Butt <shakeelb@google.com>,
        Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@fb.com
Subject: Re: [PATCH 4/5] mm: zswap: add basic meminfo and vmstat coverage
Message-ID: <YmmRFOXJsjLj4a7T@cmpxchg.org>
References: <20220427160016.144237-1-hannes@cmpxchg.org>
 <20220427160016.144237-5-hannes@cmpxchg.org>
 <20220427113654.ef8f543d7ba279952deff6f7@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220427113654.ef8f543d7ba279952deff6f7@linux-foundation.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 27, 2022 at 11:36:54AM -0700, Andrew Morton wrote:
> On Wed, 27 Apr 2022 12:00:15 -0400 Johannes Weiner <hannes@cmpxchg.org> wrote:
> 
> > Currently it requires poking at debugfs to figure out the size and
> > population of the zswap cache on a host. There are no counters for
> > reads and writes against the cache. As a result, it's difficult to
> > understand zswap behavior on production systems.
> > 
> > Print zswap memory consumption and how many pages are zswapped out in
> > /proc/meminfo. Count zswapouts and zswapins in /proc/vmstat.
> 
> /proc/meminfo is rather prime real estate.  Is this important enough to
> be placed in there, or should it instead be in the more lowly
> /proc/vmstat?

The zswap pool size is capped to 20% of available RAM, and we usually
have a utilization of tens of gigabytes. I think it's fair to say it's
a first class memory consumer when enabled, and actually a huge hole
in /proc/meminfo coverage right now.

> /proc/meminfo is documented in Documentation/filesystems/proc.rst ;)
> 
> That file appears to need a bit of updating for other things.

"The following is from a 16GB PIII, which has highmem enabled."

lmao.

I'll send a general update for that, and a delta fixlet for 4/5.

Thanks!
