Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0EE5500DB3
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 14:36:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243403AbiDNMiq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 08:38:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240746AbiDNMin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 08:38:43 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB7D28F992
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:36:17 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id p8so4705117pfh.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 05:36:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oBl86tDBOcIwFNxgNQn3qsyAEt6d0hjLFosFb++p05w=;
        b=bJbLkZzX06uhV+y3HRchA2xrtHtK6aB609aUL54xzNyyK2yMHOHZT9g1YjDOjPakKn
         VVbgHSc3D6BgJcQvbqxN1qu4TVmL9BANpFplX1Y+k9a5pCYr0wJ2KTB5MrTEHDF0X7DJ
         hZTbPipbV++UcBjpomnB7pM6zjGqKVEN60NksUofpzP4MhJgm1/0YLAjlP80V2WLCCOL
         480qqZcyNaXlXyHWY4oKjfS5RXaQZxDzvVJZnMK2wTCTv/U108BhfCYzYhiw9hcgCLGA
         pqLyKbWkhtvW9+YNDwTi+QEz7CnM+WoYbKNorkmV9ZIK945MknB6RUzIQMbKG9TNp8mk
         kEiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oBl86tDBOcIwFNxgNQn3qsyAEt6d0hjLFosFb++p05w=;
        b=6bdG6a/0evCzpqDF+T9x4R7TFcTIFr/4qIg9zIRRkYTWAzY4S4ZMEGL1VlW5doV6rw
         d71wfreK6c3xo1Q/BqrWDNtG3zC60eelgaVHIPUbGxNzSQmyc36fLwvSymUW0OGmD6k3
         idDCl1PI5uJRezIRamuBWr9lf3RVE+yuT7OFyWDcJUJRjBei5pq/u1SZzGb0fzrNzdfu
         YzqrMX+s86v9v2Xo9L2PHB/aX5LbXHi1kEo+76nEeNq2ucVQ5oxN33+2tHDXLIR0ATNC
         30pYNI23LK6QGscmP4TktY2aHVMq5noBrIGH6lTqg0VtQTNNlFYTk3Jq7C98GZ1q+sEo
         sXIw==
X-Gm-Message-State: AOAM533VQyDqyG8ExewqMhqZz3/af2rsrj54ecVvSJ6wZOc3i3hpq2fL
        Bo20jBdEaw0DQTFenkrqg0MN7+BwQ/0=
X-Google-Smtp-Source: ABdhPJwuF19A+7OMN1l7TtYYnnphTtoLl5bLFhXue5qQ0ujsEJpBkC5BL0TuY7BNjKlBxWiCsIF/3g==
X-Received: by 2002:a63:c66:0:b0:382:1f8c:ef72 with SMTP id 38-20020a630c66000000b003821f8cef72mr2102939pgm.425.1649939777401;
        Thu, 14 Apr 2022 05:36:17 -0700 (PDT)
Received: from hyeyoo ([114.29.24.243])
        by smtp.gmail.com with ESMTPSA id d5-20020a056a0024c500b004fae56b2921sm2237399pfv.167.2022.04.14.05.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 05:36:16 -0700 (PDT)
Date:   Thu, 14 Apr 2022 21:36:08 +0900
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
Subject: Re: [PATCH v2 00/23] common kmalloc for SLUB and SLAB v2
Message-ID: <YlgVOEl38AVzKO9z@hyeyoo>
References: <20220414085727.643099-1-42.hyeyoo@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414085727.643099-1-42.hyeyoo@gmail.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 05:57:04PM +0900, Hyeonggon Yoo wrote:
> Changes since v1:
> - The code is basically same, but split some patches to make it
> easier to review.
> - Adjusted comments and added Reviewed-by from Vlastimil. Thanks!
> 
> Hello, this series is cleanup of kmalloc code. After this series,
> kmalloc subsystem is perfectly generalized on SLAB and SLUB.
> 
> This series is not small, but each patch is easy to review and
> I bet you will like this :)
> 
> Many thanks to Matthew, Marco, Vlastimil who gave comments
> in previous series.
> 
> Any feedbacks will be appreciated.
> Thanks!

I mistakenly sent a wrong version of series, before fixing a build bug
and a build warning. The latest version is available at:

https://github.com/hygoni/linux/tree/slab-common-v5.19-v1r1

And below is difference between the series in this thread
and tree above is:

diff --git a/0018-mm-sl-au-b-generalize-kmalloc-subsystem.patch b/0018-mm-sl-au-b-generalize-kmalloc-subsystem-v2.patch
index 2389975..510f7fd 100644
--- a/0018-mm-sl-au-b-generalize-kmalloc-subsystem.patch
+++ b/0018-mm-sl-au-b-generalize-kmalloc-subsystem-v2.patch
@@ -207,7 +207,7 @@ index 3cd5d7a47ec7..daf626e25e12 100644
 +
 +      slab = folio_slab(folio);
 +      s = slab->slab_cache;
-+      __kmem_cache_free(s, object, _RET_IP_);
++      __kmem_cache_free(s, (void *)object, _RET_IP_);
 +}
 +EXPORT_SYMBOL(kfree);
 +

Fixed a warning here

diff --git a/0020-mm-slab_common-factor-out-__do_kmalloc_node.patch b/0020-mm-slab_common-factor-out-__do_kmalloc_node-v2.patch
index 133d293..30d9ca2 100644
--- a/0020-mm-slab_common-factor-out-__do_kmalloc_node.patch
+++ b/0020-mm-slab_common-factor-out-__do_kmalloc_node-v2.patch
@@ -60,7 +60,7 @@ index 6abe7f61c197..af563e64e8aa 100644
 -      ret = kasan_kmalloc(s, ret, size, gfpflags);
 -
 -      return ret;
-+      return __do_kmalloc_node(size, flags, node, caller);
++      return __do_kmalloc_node(size, gfpflags, node, caller);
  }
  EXPORT_SYMBOL(__kmalloc_node_track_caller);

And a build bug here.

Anything else looks just fine.
Thanks!

-- 
Thanks,
Hyeonggon
