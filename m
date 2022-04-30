Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0936515E0A
	for <lists+linux-kernel@lfdr.de>; Sat, 30 Apr 2022 16:07:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381686AbiD3OK0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 30 Apr 2022 10:10:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232641AbiD3OKX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 30 Apr 2022 10:10:23 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 130A46622D
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:07:02 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id r83so8560568pgr.2
        for <linux-kernel@vger.kernel.org>; Sat, 30 Apr 2022 07:07:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=3qyc93eVxjKciEghxxTNYojB9G3OXnPRX/JlJbaTsqE=;
        b=U+dQbv3vRNOyjnDfUPoNdWsgzn5/IazTAZXYJ1oiWvw2MiyXcpukRMTSt6xUdU7Zd1
         6IMOwSY3x2927gzcrZFoaW6nhQnSEVegvx+hj/7rsAu9t8Ncfv6naAvq2CcCtBy5fnnt
         Vp0qpCCzoxhFnCLQ6zaaaCZ/XG59yY4rk2fxx5FRWpGgvC/KUD+3NQMlwrZQuk5qCrYV
         vZWJ+hF+V6zNW2d117flQvCNVGBtqSwXnjYQQcyxxYEsj3sJhghswF7uMmu6eSQ8CbEk
         jZB1jkJNQagXXJvJTTq72odRA60rMqgUHzOdddtApJYSAmrUR4iHaWrOzqP0TpxlRJMa
         v1eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=3qyc93eVxjKciEghxxTNYojB9G3OXnPRX/JlJbaTsqE=;
        b=nrREWCFPqR1HhI527FKARYml3/fCFVIHicFDPVxG1HPiqm3vHc4VjUWjJ3wYXXqZ/x
         LE4CEyYEtoXPRJaf7a8AdH+D0/HVvHAYb6LW3jLHLqBIWIw1XDxHBUIuBES9T4FBb26g
         kK6IfgcIO2+hZSmheUPRHXgdMbDmS56AwsZn1kfnRk2vM23GjnL5Dd+or//1IkMSuxIz
         hldVQmXiGZXJ2AKbyu/w3XZFe04ZPBL0aqLhR0pGpHNdMWiBrWWxK9jIsEXXPQCTJ+GC
         CwLBNd+6FL8YfzIfOgOyuEBB4KlRrpwxc/VwvKb1dn7no/697WjrkXxeD0KtCyXuXa4r
         BDwA==
X-Gm-Message-State: AOAM5323P2YbZePObdFdK8TY+R4za52BZmyq9SuIZ8xInSVd5yyffYTh
        MBQXlI19zO8ieEKH3J42ezSyZgLMg0DIIsmYu7c=
X-Google-Smtp-Source: ABdhPJyZ0IE9luX0BgG75JlBIYlhHQrEWVcw73ftjswKMSv09tEN7s8KAxRALXvinyLi1g2RqVpWfg==
X-Received: by 2002:a05:6a00:b4d:b0:50d:7e9f:1ff0 with SMTP id p13-20020a056a000b4d00b0050d7e9f1ff0mr3836232pfo.80.1651327621495;
        Sat, 30 Apr 2022 07:07:01 -0700 (PDT)
Received: from ip-172-31-27-201.ap-northeast-1.compute.internal (ec2-18-183-95-104.ap-northeast-1.compute.amazonaws.com. [18.183.95.104])
        by smtp.gmail.com with ESMTPSA id y17-20020aa78051000000b0050dc76281b2sm1619127pfm.140.2022.04.30.07.06.58
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Apr 2022 07:07:00 -0700 (PDT)
Date:   Sat, 30 Apr 2022 14:06:55 +0000
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Vlastimil Babka <vbabka@suse.cz>
Cc:     Marco Elver <elver@google.com>,
        Matthew WilCox <willy@infradead.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 14/23] mm/slab_common: print cache name in tracepoints
Message-ID: <20220430140654.GB25819@ip-172-31-27-201.ap-northeast-1.compute.internal>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
 <20220414085727.643099-15-42.hyeyoo@gmail.com>
 <bbb97e3c-e597-dd6e-e213-55bc1779d901@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bbb97e3c-e597-dd6e-e213-55bc1779d901@suse.cz>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2022 at 04:05:14PM +0200, Vlastimil Babka wrote:
> On 4/14/22 10:57, Hyeonggon Yoo wrote:
> > Print cache name in tracepoints. If there is no corresponding cache
> > (kmalloc in SLOB or kmalloc_large_node), use KMALLOC_{,LARGE_}NAME
> > macro.
> > 
> > Signed-off-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
> 
> Regarding tracepoints, I'm not sure it's a good idea to unify kmalloc and
> kmem_cache_alloc. I think the common use case is to trace kmalloc as there
> are many different callers, and then I'm not interested in kmem_cache_alloc
> callers much.

Make sense.

> What I would suggest instead is:
> - drop the _node versions, add node to normal versions
> - drop the kmem_alloc EVENT_CLASS, as kmalloc is different enough from
> kmem_cache_alloc (see next points), define separately as TRACE_EVENT().
> - printing cache_name makes sense to add for kmem_cache_alloc (also allows
> filtering events) but not for kmalloc.
> - kmem_cache_alloc with name can then drop the bytes_req, bytes_alloc as
> they are fixed for given name (and can be read from slabinfo).

Those suggestions makes sense to me.
kmalloc and kmem_cache_alloc are a bit different.

> Not using a common tracepoint will prevent some later unifications/cleanup
> (patch 21?), but hopefully not too much?

In v2 unification of __kmalloc_node()/kfree() somewhat depends on unified tracepoint.
I'll try to unify them with this approach in v3.
