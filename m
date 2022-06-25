Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 359F555A855
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:10:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232291AbiFYI6t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 04:58:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232277AbiFYI6q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 04:58:46 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ACFD2CE1A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:58:45 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id d14so4811871pjs.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 01:58:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=yBLfi92gAlfWDayXHgzw4YwyIEMK5sbZZcp3v3R4WvY=;
        b=vWECR4lLdOmckfTvOtrYhFODIrM4aq0XBkbDVkccpRjJ3+cMeUvXRYavTTP+yfUnbX
         w6+J8m/kcwHkSZzmeu90jyJ4IHHBP0StpdY3RIXtbqNihYBxZAT27XARGx07UqgXeU3y
         01EYfl9HNI/lphnYRGJjUaO46ig2ViHWHtRFePaayXwsyi8aoJCj72pwSANRc1WThHL1
         tmtUkNuzPsKLzhrXfUX7uXSPKmb3opDWoWCq8GFZe3XYLVPj4P86uCXjA1fiZoOMC3kA
         g8mg9T5IRuUlgBoPJ7tT/uIOH458e1rOQLqTqaGGZ9RSmZ07ahQTQbgL0xbfqf4bvYR8
         FB5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yBLfi92gAlfWDayXHgzw4YwyIEMK5sbZZcp3v3R4WvY=;
        b=iuHSSLw1Nqj9kEZKLl6ka3A7n6c7OeJXoIVCo0eYewryuRHViv50Qc26TFfKnVjuqQ
         /QWn/S5y4MPDWZH226WXjCpZsApFvLAn/QkMqFgeZwk9jkYe9OCZ4MwBF1HL++9ilu/5
         poyyZuUVxad/Sc3KtStrDU3Il7WtP3Mjvu0cE9bcl+GS9wtyKv4BexcKd3qMQpm5Y8BH
         GSm5vXigV87YEc/ixgKfl7QeKi6MfbldLSLHKIS4qhsh7v0IBnNriJbHJoOe7xO0wwbS
         73LNNu/D1DbHVTR6iF5vkde9M4CSmuG3eNT2WUlUr1QMg1UUn1ERzhIu3QM7Z36d2YQn
         YvMQ==
X-Gm-Message-State: AJIora+2GhpLsBSWIFiUGQxEPrDla5sWm8MJ3tGi4ERkOacYhabp7hW8
        YD3i2Armksp+T+FROnN+Yr+vsQ==
X-Google-Smtp-Source: AGRyM1sYJQcyA2mxkXzZ9zdfOKE7155NN545ntISrtYfLfZWk2r2d66rK3coFs1+Gxw1q5DvzPxpBQ==
X-Received: by 2002:a17:90a:bf86:b0:1ec:cc6d:c0f with SMTP id d6-20020a17090abf8600b001eccc6d0c0fmr3451167pjs.202.1656147524621;
        Sat, 25 Jun 2022 01:58:44 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c80d:fa4f:de4d:bed5])
        by smtp.gmail.com with ESMTPSA id e14-20020a170902ef4e00b0016a275623c1sm3157808plx.219.2022.06.25.01.58.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Jun 2022 01:58:44 -0700 (PDT)
Date:   Sat, 25 Jun 2022 16:58:38 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Xiang Yang <xiangyang3@huawei.com>
Cc:     hannes@cmpxchg.org, mhocko@kernel.org, roman.gushchin@linux.dev,
        shakeelb@google.com, akpm@linux-foundation.org,
        cgroups@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] mm/memcontrol.c: replace cgroup_memory_nokmem with
 mem_cgroup_kmem_disabled()
Message-ID: <YrbOPktTSb00DvYw@FVFYT0MHHV2J.usts.net>
References: <20220625061844.226764-1-xiangyang3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220625061844.226764-1-xiangyang3@huawei.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 25, 2022 at 02:18:44PM +0800, Xiang Yang wrote:
> mem_cgroup_kmem_disabled() checks whether the kmem accounting is off.
> Therefore, replace cgroup_memory_nokmem with mem_cgroup_kmem_disabled(),
> which is the same work in percpu.c and slab_common.c.
> 
> Signed-off-by: Xiang Yang <xiangyang3@huawei.com>

Reviewed-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
