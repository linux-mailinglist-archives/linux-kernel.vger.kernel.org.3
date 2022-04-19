Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64EDD507BB8
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 23:11:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346744AbiDSVNp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 17:13:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346674AbiDSVNn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 17:13:43 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9435121257
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:10:59 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id d198so11363667qkc.12
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 14:10:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WnNdXhUuHATImW9JHxx0jAQhjPW7uQy+AQSOTpvyn88=;
        b=n+9QqXc3Ftz8xNj8iOWqmGYnzg2nXtKebRpGK69TfE8hPbe4ADCqbWxAhZoIjxDTsf
         sJq8DBXVnW+DfgKev30iE5miKIJqAYT53PUQBxIwDLttICVLYwR3rhb9sSPo5q5fltcQ
         hTfNNok/wP/YbdfCdGkclJzs3XnwIWGQoa5Vrpy8COg8nps9e9kSOx3po7Qv60B2zBRl
         xfVBYo9Mtv1UdxFnId3HIfNrbrJelEAzVdU7HwJzCiX1ji20uTV2uLCMPibXglLrwp5a
         vORWeZ3bp8exBwlXHouL05flY2gOBSP0ypllOWGt52EV9ug7KtTxge9n2MLuYsNPk+di
         yhcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WnNdXhUuHATImW9JHxx0jAQhjPW7uQy+AQSOTpvyn88=;
        b=1ha6a+Hmq8s24uWQfO9BsH2YOtcd5aAPFSJgDZxMi5FVRfl9hVnOcWk0IrQP5cXqYm
         +CRS1HiPacCQolRJZq6pqFCEaIgQXe5ERg8WDpinJXtVuQA3qccTnUp+FRc6tmcXTaXl
         oIY1KHsbUWmhmqnvYugf1o6RK+bwR3AIh/1ujdaybOsDZG6Oive4DHjPkTGDurc1L7eB
         TGrAR+65+Zr4QRnXzV6fRjv7M3Ubagx85BVONJOvUVTXJrEJziNuba/C1ky7QWHsX0dC
         n56piGCBNzbiBNDW4Y7Oehq05S9XSx7S+QdSK6FX8cKinatLmJ/db1liXTsI8gHIxevc
         aZng==
X-Gm-Message-State: AOAM533vDuhMMosnE3MuTwC/xZp1+V0L5/QzhRn/weiMOyXwD5iJLfWe
        72tzYc4p2uG8M/HfnWE6cA==
X-Google-Smtp-Source: ABdhPJxLzxp+JQHvuji7sFUC6p4TSQzUdisLzYA8qtzDGwOV+B/BnmdatZ0870iphWvi1Oi08rITsg==
X-Received: by 2002:a05:620a:d87:b0:67b:311c:ecbd with SMTP id q7-20020a05620a0d8700b0067b311cecbdmr11017000qkl.146.1650402658294;
        Tue, 19 Apr 2022 14:10:58 -0700 (PDT)
Received: from moria.home.lan (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id v23-20020ae9e317000000b0069ea555b54dsm532576qkf.128.2022.04.19.14.10.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Apr 2022 14:10:57 -0700 (PDT)
Date:   Tue, 19 Apr 2022 17:10:55 -0400
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Yang Shi <shy828301@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH rfc 0/5] mm: introduce shrinker sysfs interface
Message-ID: <20220419211055.jtzfvqagsiwrco6r@moria.home.lan>
References: <20220416002756.4087977-1-roman.gushchin@linux.dev>
 <20220419183654.axbxcjehs6fpqg4z@moria.home.lan>
 <Yl8EhZIbePmlmJ6D@carbon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yl8EhZIbePmlmJ6D@carbon>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 19, 2022 at 11:50:45AM -0700, Roman Gushchin wrote:
> On Tue, Apr 19, 2022 at 02:36:54PM -0400, Kent Overstreet wrote:
> > On Fri, Apr 15, 2022 at 05:27:51PM -0700, Roman Gushchin wrote:
> > > 7) Don't display cgroups with less than 500 attached objects
> > >   $ echo 500 > count_memcg
> > >   $ cat count_memcg
> > >     53 817
> > >     1868 886
> > >     2396 799
> > >     2462 861
> > > 
> > > 8) Don't display cgroups with less than 500 attached objects (sum over all nodes)
> > >   $ echo "500" > count_memcg_node
> > >   $ cat count_memcg_node
> > >     53 810 7
> > >     1868 886 0
> > >     2396 799 0
> > >     2462 861 0
> > > 
> > > 9) Scan system/root shrinker
> > >   $ cat count
> > >     212
> > >   $ echo 100 > scan
> > >   $ cat scan
> > >     97
> > >   $ cat count
> > >     115
> > 
> > This part seems entirely overengineered though and a really bad idea - can we
> > please _not_ store query state in the kernel? It's not thread safe, and it seems
> > like overengineering before we've done the basics (just getting this stuff in
> > sysfs is a major improvement!).
> 
> Yes, it's not great, but I don't have a better idea yet. How to return the number
> of freed objects? Do you suggest to drop this functionality at all or there are
> other options I'm not seeing?

I'd just drop all of the stateful stuff - or add an ioctl interface.
