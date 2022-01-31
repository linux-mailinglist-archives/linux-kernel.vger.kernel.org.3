Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FCDF4A4C83
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:53:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380634AbiAaQxX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:53:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232421AbiAaQxV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:53:21 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7592CC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:53:21 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z1so10813564qto.3
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 08:53:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kCLY9awXUZ+VaBKEx7Kf5fe8lUKb+8FACIctpfMa/JA=;
        b=vcKL8lE+2CbEB7y6dB2JbuBXT040U9YHCdWxDounbU74q0EijmUnVJ989O7FOH2YfG
         sIyFOWWg/pJqWPPaxxt4JSHVuQrwqNVtNr6SLvVBRxJ2NihBphaaUXwhHi7Ps8gRoRK+
         hzBa0M0K2TBF6HlXg8gEU+nnS0Yyt9XDisazb66sFWHRm9yfzCdH7T+KJNyBdXsyUGB/
         mqaAFN+OPNz38LWlbBIEICRfpAHOdAE93OghZ77qivsyHj6bsGl4RPvxQEouzM+j0agZ
         /MoQ4WH1Jcb20Hbor6rBTGTmrsKgI/wQqvx93dKfYMhQuxtvtGBmRAVxhFhWaFchsH5E
         mpYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kCLY9awXUZ+VaBKEx7Kf5fe8lUKb+8FACIctpfMa/JA=;
        b=lbMadilcFCO0cLUpsLIil5aaympT8REaFAAMjPlcWv+sfl0d3M2x/zULmKrE4ZY0fE
         Cl0Jhq2uHyzdL4qH16CByNS54q1wdmvRDuQPtsVJWv8lff9xbbToAegD7/a2xQyVCKqm
         laziugqlax5Ww07ok6KUvTU+HZeQXbShLEJQxm+NAqsfV3e4uoSr9SHIvATXrYl9GaFj
         i9RqIQ1W+OHv5rrEkVzmD9PfN9p7y6E9Yq/Q8SoDrv1lG9+e3Qe+Z32eXHWjd5DsyQeJ
         LW/jKwNn9ht7ciSvodVnfbgBxTzkx9QQ6nyGIJcA9bbBy0brSgR4UGCyZlGQeQYQsUkB
         AbzA==
X-Gm-Message-State: AOAM5327DnfdNPWHQE3sm5KjRTkVXqbJxe0z3/hcOpIaqZhWrmb/pUYb
        lMHEyCRqzQpKGbxRbcfNosphfQ==
X-Google-Smtp-Source: ABdhPJzq6qUK+RHhdfQHgFLxnHu2bNiYFr6RdYOhaqYJ8Xy5yY0Nu+L3RURiz+5GAJCB0TPzTQawag==
X-Received: by 2002:a05:622a:1303:: with SMTP id v3mr15653667qtk.257.1643648000595;
        Mon, 31 Jan 2022 08:53:20 -0800 (PST)
Received: from localhost (cpe-98-15-154-102.hvc.res.rr.com. [98.15.154.102])
        by smtp.gmail.com with ESMTPSA id s13sm8887569qki.97.2022.01.31.08.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Jan 2022 08:53:20 -0800 (PST)
Date:   Mon, 31 Jan 2022 11:53:19 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Michal Hocko <mhocko@suse.com>
Cc:     Waiman Long <longman@redhat.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Petr Mladek <pmladek@suse.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        linux-kernel@vger.kernel.org, cgroups@vger.kernel.org,
        linux-mm@kvack.org, Ira Weiny <ira.weiny@intel.com>,
        Rafael Aquini <aquini@redhat.com>
Subject: Re: [PATCH v2 3/3] mm/page_owner: Dump memcg information
Message-ID: <YfgT/9tEREQNiiAN@cmpxchg.org>
References: <20220129205315.478628-1-longman@redhat.com>
 <20220129205315.478628-4-longman@redhat.com>
 <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfeuK5j7cbgM+Oo+@dhcp22.suse.cz>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 31, 2022 at 10:38:51AM +0100, Michal Hocko wrote:
> On Sat 29-01-22 15:53:15, Waiman Long wrote:
> > It was found that a number of offlined memcgs were not freed because
> > they were pinned by some charged pages that were present. Even "echo
> > 1 > /proc/sys/vm/drop_caches" wasn't able to free those pages. These
> > offlined but not freed memcgs tend to increase in number over time with
> > the side effect that percpu memory consumption as shown in /proc/meminfo
> > also increases over time.
> > 
> > In order to find out more information about those pages that pin
> > offlined memcgs, the page_owner feature is extended to dump memory
> > cgroup information especially whether the cgroup is offlined or not.
> 
> It is not really clear to me how this is supposed to be used. Are you
> really dumping all the pages in the system to find out offline memcgs?
> That looks rather clumsy to me. I am not against adding memcg
> information to the page owner output. That can be useful in other
> contexts.

We've sometimes done exactly that in production, but with drgn
scripts. It's not very common, so it doesn't need to be very efficient
either. Typically, we'd encounter a host with an unusual number of
dying cgroups, ssh in and poke around with drgn to figure out what
kind of objects are still pinning the cgroups in question.

This patch would make that process a little easier, I suppose.
