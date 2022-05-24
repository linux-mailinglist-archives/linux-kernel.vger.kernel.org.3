Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C27D53299C
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 13:45:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236413AbiEXLpr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 07:45:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbiEXLpp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 07:45:45 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6275DEAE
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:45:43 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id 14so8670365qkl.6
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 04:45:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=CR09yeXsFtoUOg9OMladANfYR85/7BwnLnQK+uR1N0Y=;
        b=fvqp9+cdKj6LUnqaiDF1ifg3kW67yhA7mfjWX6ZFH2sG5F8ll4k55tNdNMuoB1M4to
         Z1AV36+WHxVDjTPLY6bzHrbo5yJXPiJYOceulRYWs7upkmVU3JGKtI50rd0LWM/Pmo91
         Z65P8xlljk+pDOkEJB58JvWaTZZdZ5QPbzT38ZFoJGHl/G+l2Jz7Limq9k4aafPrTBoO
         VQeW7Q/M2I8PndKg6WFmKst0Pc3oRyJmlwI0SCBvP/h9UWXS8S2mRljTo/QRrsFQH+/T
         7FlXtbCY5LpzOlJWW9Vrj3DkOYOFXiz3oUu1znM50xY05BDXckQpGZUkOI6gWeA7kRD+
         P8Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=CR09yeXsFtoUOg9OMladANfYR85/7BwnLnQK+uR1N0Y=;
        b=Xv8spnbB9JozIGRmwdNpYsRESJSlJ+bubQdLkEGLmDyCzE0HoPVgv9f3UwCTupZCyj
         tYUHruCimE2bcQymWTnutSDtDCwv92v2tcI+Epcgq4wEA5IqoznN/PFAhEXfy1wQOQMo
         xweNN+y51hnA5pmSwA7RxgJd1w/LNHV/aYd+T9cPaiYDVduPAiewQ4lsBaomU7xxIPsv
         MdPsyXJFiTlmUmKwTEn9zOoS5LgTxw6O1cv+yu/O59MTUTo11BJBw8DXno3PplA/hCGg
         pVQGB0gxWidrdnQ4By3PaW0LfYyr24I54vDbFBZIIhgsXpl5oY0tt9jedpfk3FJSto0d
         z7dQ==
X-Gm-Message-State: AOAM531YCD+Ts8BUSIWV6+pUl95kmmgAQNVT/VwfmOJA+QGn4u6uiRN/
        4sRk1Ndedzn2PjrJrutaP5fjVQ==
X-Google-Smtp-Source: ABdhPJy+mRmOWARy6q76pkXL/ov/YwM3Sjk6bTK9qOTgTtk/PBNAMmayhuzsas+dwXg1UhhNSG9LBQ==
X-Received: by 2002:a05:620a:bc6:b0:67c:ce55:d2d4 with SMTP id s6-20020a05620a0bc600b0067cce55d2d4mr17064770qki.175.1653392742579;
        Tue, 24 May 2022 04:45:42 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:741f])
        by smtp.gmail.com with ESMTPSA id cg7-20020a05622a408700b002f9050bb622sm5988169qtb.69.2022.05.24.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 04:45:42 -0700 (PDT)
Date:   Tue, 24 May 2022 07:45:40 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Michal Hocko <mhocko@suse.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        Cgroups <cgroups@vger.kernel.org>, linux-doc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Shakeel Butt <shakeelb@google.com>
Subject: Re: [PATCH] memcg: provide reclaim stats via 'memory.reclaim'
Message-ID: <YozFZI2euSjWPgDb@cmpxchg.org>
References: <20220518223815.809858-1-vaibhav@linux.ibm.com>
 <YoYj4sLJfGke5IGT@dhcp22.suse.cz>
 <87zgjcg4xs.fsf@vajain21.in.ibm.com>
 <YodDaFVeU33bu7yQ@dhcp22.suse.cz>
 <CAJD7tkYwv2LDZeV2F5pxuniw7LCNjBapDCm3WuRhzwTH-jN3PA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJD7tkYwv2LDZeV2F5pxuniw7LCNjBapDCm3WuRhzwTH-jN3PA@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 23, 2022 at 03:50:34PM -0700, Yosry Ahmed wrote:
> I think it might be useful to have a dedicated entry in memory.stat
> for proactively reclaimed memory. A case where this would be useful is
> tuning and evaluating userspace proactive reclaimers. For instance, if
> a userspace agent is asking the kernel to reclaim 100M, but it could
> only reclaim 10M, then most probably the proactive reclaimer is not
> using a good methodology to figure out how much memory do we need to
> reclaim.
> 
> IMO this is more useful, and a superset of just reading the last
> reclaim request status through memory.reclaim (read stat before and
> after).

+1
