Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC68531276
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 18:22:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiEWNzW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 09:55:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236686AbiEWNzT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 09:55:19 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5FE56F92
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:55:16 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id n10so14129333pjh.5
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 06:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Df9yWQ/aDxzNckvtabHN6S/25VXwYOsM+nyYbdaI3a8=;
        b=TzTbXf5jrW5oQ4yIsnoZCjia8f/YM/jmgfc1tLNqZmzCb3k08ZDczecDygA0fXzxW0
         M81MuFj8NK6DtCT/7OVTIJAv3BhESb+ZGlV+g6JnG+cYwI4CMLm02QiKYbzV39WLLSMS
         komvx0Xcb0OjEcfD56VP8GFPwyRc8+XD62mjfdTjYLgCGwqfkwDFeTyxa0gvcwRln5V/
         eppJDWhh1gIYIIsgZb6SvwT1JFJc8Rc2PSnfcYkaYqyCR0LGr7wqnJA8xusq60qOrKuG
         qGuAxRsk7r+MPmY10Dyd8BT8HZLGxWoTa7CzLg8N/e+uS1IVHCPP3SOQTgQY7OVwOhG9
         40mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Df9yWQ/aDxzNckvtabHN6S/25VXwYOsM+nyYbdaI3a8=;
        b=4iyB3pQWxv5h8UGspMjyVHWCmNRZ3Ks9V5TJEFZgzmYII7qdQlB5XLTszvBm6CyfkU
         +0fiAF1oeSwPHtDaDd9wF8n+rrTArkYGALjK3euLtBaL5zWMZguGrb+l8VxJrQhj8vAv
         6glw4VoBxXU2QgK0VbN9meuTAIgCKZgKX0ZKxnAz46XXHspmd5GlxBk/KfIiQff2MC6A
         IbQamAFof7mErKIvnqR20thj/56tFik20hRuYxiD7kZJ/WVFYDmDyHeRuiw51J/GWM8b
         0+UNdS+cohZwjfqerpQunVH86m3wWyffw0YVim89bzfKh7uiD4yI60ZRYXIRQTKDCHdH
         GIqw==
X-Gm-Message-State: AOAM530Egf4LNP2rfp+sDVO3uEDB1jJMytgwuYiPq/EZn0oajD/RgaSw
        ljrinIP8hLZXZCknwEsTvFQ0bQ==
X-Google-Smtp-Source: ABdhPJzTAKPyvsoV7ZaiJUcH3STTBACV6avvux7V/4Wgew6Anu+8+y7upkEqa6ojZ1VZGLBk9Poqrg==
X-Received: by 2002:a17:902:a413:b0:156:15b:524a with SMTP id p19-20020a170902a41300b00156015b524amr23014244plq.106.1653314116404;
        Mon, 23 May 2022 06:55:16 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:2c28:f36b:423b:6bc6])
        by smtp.gmail.com with ESMTPSA id a15-20020a170902eccf00b0016170bb6528sm5211384plh.113.2022.05.23.06.55.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 May 2022 06:55:15 -0700 (PDT)
Date:   Mon, 23 May 2022 21:55:10 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     dan.carpenter@oracle.com, Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Shakeel Butt <shakeelb@google.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Shuah Khan <shuah@kernel.org>,
        David Vernet <void@manifault.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Subject: Re: [PATCH] cgroup: Fix an error handling path in
 alloc_pagecache_max_30M()
Message-ID: <YouSPobNcFH/cuuu@FVFYT0MHHV2J.usts.net>
References: <628312312eb40e0e39463a2c06415fde5295c716.1653229120.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <628312312eb40e0e39463a2c06415fde5295c716.1653229120.git.christophe.jaillet@wanadoo.fr>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 22, 2022 at 04:18:51PM +0200, Christophe JAILLET wrote:
> If the first goto is taken, 'fd' is not opened yet (and is un-initialized).
> So a direct return is safer.
> 
> Fixes: c1a31a2f7a9c ("cgroup: fix racy check in alloc_pagecache_max_30M() helper function")
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
