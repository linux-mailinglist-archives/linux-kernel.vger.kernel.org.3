Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55D8C565C35
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 18:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234858AbiGDQeG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 12:34:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234753AbiGDQd7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 12:33:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7E9EC95A1
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 09:33:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656952437;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nPN7O4yutTfR76QUYkCeWKTkYNzlpYj/Kwqr9wYgmXI=;
        b=HeUrghCyRIi5mih2IIWe9fue3x/k5+qpM6pEoTXiwREp58+31k5R0pNP95kykRPSuE+UE9
        UIOTDpna9qi9WZW+V/b6Gof3k+FIF9/OwDZaqvcCqFdHTqD/fseiXmJG9UumWg5ly/QgK+
        wm7JDOei7kAeqdj0v21uwDueJ3n8MMU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-jtaN-09lNkiUCivnpcmIoA-1; Mon, 04 Jul 2022 12:33:56 -0400
X-MC-Unique: jtaN-09lNkiUCivnpcmIoA-1
Received: by mail-wm1-f72.google.com with SMTP id 6-20020a1c0206000000b003a02cd754d1so4279404wmc.9
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 09:33:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=nPN7O4yutTfR76QUYkCeWKTkYNzlpYj/Kwqr9wYgmXI=;
        b=FvI2Ne3PSO/EGA/H+3CzKnbK5Qz3fMealg11jTyQ5lZzj5uZwNTKGOSGTavJq2O0tJ
         DKrvyexx/4M4cx4+vz2uCoJCoEiIvJFiBnYdEsKsuuTkfNgqO/lAYIQLq3qAFgw42m9H
         qZ5dXR8ecyg6cQFt1oDU8AEIJ57RzUMNUIeTGoX/doJgt4M8FIvxGPZVrDr/d1Mvug25
         uu5Urg4aFOjWjc32gBzkeo15qRImQmERQIJRwSQHgXXvLQ47BlCfAK0+WEZSCzS5Qpts
         dhjQa05b8g2NWkWRheaU4KZIrEW4xdc1Avad6GyCz1bRcmCEuU4gwk0f2xJ1mzKkMF7X
         QHgA==
X-Gm-Message-State: AJIora8oioLEa0sVxQMfnjKUQOgcZKRQinXsMmN7Q/mtvunRCtyEAAsP
        skZo4kEFT1q5YOdkT81WYJQoU4FY5NOacidK2UYVlyzrXZY04v15CKHvG5Vf2hc3spHe0aIwA/H
        QTG+ffiWUFvNC6LTxGHm+gMj/
X-Received: by 2002:a5d:534e:0:b0:21b:adf3:dc19 with SMTP id t14-20020a5d534e000000b0021badf3dc19mr26822712wrv.543.1656952435241;
        Mon, 04 Jul 2022 09:33:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uLhSWU8M2vNb4jyFr+doYws0qpQ2mbL5enVcLAf041KKQbSEGOxeoSAr/MZoztVPnyelvcfw==
X-Received: by 2002:a5d:534e:0:b0:21b:adf3:dc19 with SMTP id t14-20020a5d534e000000b0021badf3dc19mr26822690wrv.543.1656952434992;
        Mon, 04 Jul 2022 09:33:54 -0700 (PDT)
Received: from ?IPv6:2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac? ([2a0c:5a80:1b12:b300:47b0:25ba:1a2e:72ac])
        by smtp.gmail.com with ESMTPSA id x1-20020a1c7c01000000b003a02b135747sm19910694wmc.46.2022.07.04.09.33.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 09:33:54 -0700 (PDT)
Message-ID: <9de48555e9139c91289a48e9296c0af1a62811f3.camel@redhat.com>
Subject: Re: [PATCH 7/7] mm/page_alloc: Replace local_lock with normal
 spinlock
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Mel Gorman <mgorman@techsingularity.net>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Hugh Dickins <hughd@google.com>, Yu Zhao <yuzhao@google.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Date:   Mon, 04 Jul 2022 18:33:53 +0200
In-Reply-To: <20220624125423.6126-8-mgorman@techsingularity.net>
References: <20220624125423.6126-1-mgorman@techsingularity.net>
         <20220624125423.6126-8-mgorman@techsingularity.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.2 (3.44.2-1.fc36) 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-06-24 at 13:54 +0100, Mel Gorman wrote:
> struct per_cpu_pages is no longer strictly local as PCP lists can be
> drained remotely using a lock for protection. While the use of local_lock
> works, it goes against the intent of local_lock which is for "pure
> CPU local concurrency control mechanisms and not suited for inter-CPU
> concurrency control" (Documentation/locking/locktypes.rst)
>=20
> local_lock protects against migration between when the percpu pointer is
> accessed and the pcp->lock acquired. The lock acquisition is a preemption
> point so in the worst case, a task could migrate to another NUMA node
> and accidentally allocate remote memory. The main requirement is to pin
> the task to a CPU that is suitable for PREEMPT_RT and !PREEMPT_RT.
>=20
> Replace local_lock with helpers that pin a task to a CPU, lookup the
> per-cpu structure and acquire the embedded lock. It's similar to local_lo=
ck
> without breaking the intent behind the API. It is not a complete API
> as only the parts needed for PCP-alloc are implemented but in theory,
> the generic helpers could be promoted to a general API if there was
> demand for an embedded lock within a per-cpu struct with a guarantee
> that the per-cpu structure locked matches the running CPU and cannot use
> get_cpu_var due to RT concerns. PCP requires these semantics to avoid
> accidentally allocating remote memory.
>=20
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---

Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>

Thanks!

--=20
Nicol=C3=A1s S=C3=A1enz

