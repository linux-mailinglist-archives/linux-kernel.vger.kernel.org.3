Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE04559EAAD
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:14:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231265AbiHWSLq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230426AbiHWSLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:11:18 -0400
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A74946F266
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:23:01 -0700 (PDT)
Received: by mail-pj1-x1030.google.com with SMTP id s31-20020a17090a2f2200b001faaf9d92easo17706933pjd.3
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:23:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc;
        bh=sr+/MYTdy+Hb+ViTpSI674A/Fgsv5oXGjKt3k8niW6E=;
        b=F8K1uc4a7GIvY5YEhN3k3CQDZGWvAusCXcTbHH8+tdzRfb/CwXlDJj26VRtrQct2Lz
         A/xIrxjjnqjvNFqaXgFCYTsm+hndyJD/E3x+T0rC78RVK6eKc30Ovr9uxOSKqtHaMnfH
         Hvf2xY7Wc5Q/dUIrUeisGkp1ONwdWT4sN6wqUjrcZyySfjgcbSNz4JySvZ4e17bt5LYe
         xmNQxcnWcYBVUpUNtqPiK+hCqU4KQhZObnn8xx2YsAxRBRIhvqCrILcE1kLcWWebiVdY
         D4r4sZZl+TH8U973SfKYksBMDBsimN/hnFwVtskI+SKzvsxfMuOnsi6rkKcDnZXviKNn
         jvSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc;
        bh=sr+/MYTdy+Hb+ViTpSI674A/Fgsv5oXGjKt3k8niW6E=;
        b=oL2t3nphINX5I2uH0HqjuwmO6AZ31ZcnSWDN9bkw44VDFOUxlFKJOlOl7lSnEXYMOM
         VBHj2+NilOM3Nlncu+OtRAbpmiOTDXrgixuDVNRY8KIh3K/wpLNIyyYZvMF76LMoI6AH
         6vBXi5tXwMJYH4trvb1cxspYJta48YnyeF6O6Ukkb6RhTNoeS51R6QbpEv70QGZxUKoE
         X1G9VBoJSOW+yV7RtMX5KO77vHXLyLVwJ3JP4l77T++as1KPFxyb76yhE9O6TWtTMJXj
         gyoFwB+wHjwUVumwWiejBbIkgyYhEsKOHsLGz1ErZ0E6FPe1iqUEoFh9riM+SoeBVqda
         Yn3w==
X-Gm-Message-State: ACgBeo0aHcPvB2YnQrvS91ITAAMODJLD4LL0lFb3osgg9vSi7dtwcSRe
        eTvO91RZxilv8aJNSpsvwV/Z4CAxb1U=
X-Google-Smtp-Source: AA6agR54r7eQ8pJOXAqC2eJalPRtAmQd1x/ma/uKsnCxb+E4KrezW3C/YEF98fdT2JI0IvCxI4+Pmw==
X-Received: by 2002:a17:90b:198e:b0:1fb:fb8:1072 with SMTP id mv14-20020a17090b198e00b001fb0fb81072mr4017061pjb.51.1661271780957;
        Tue, 23 Aug 2022 09:23:00 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id x124-20020a623182000000b00534cb3872edsm10965706pfx.166.2022.08.23.09.23.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 23 Aug 2022 09:23:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Tue, 23 Aug 2022 06:22:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Michal =?iso-8859-1?Q?Koutn=FD?= <mkoutny@suse.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk,
        Christian Brauner <brauner@kernel.org>
Subject: Re: [RFC PATCH] memcg: adjust memcg for new cgroup allocations
Message-ID: <YwT+4zHz2gUWnI5S@slm.duckdns.org>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <45a04b75-d61b-4c7a-7169-c971995a6049@openvz.org>
 <20220817091728.GA23229@blackbody.suse.cz>
 <Yv0aMqMIafD7cOQX@slm.duckdns.org>
 <b64759d9-e183-99a2-3ec5-9241035eca69@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b64759d9-e183-99a2-3ec5-9241035eca69@openvz.org>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Tue, Aug 23, 2022 at 03:04:31PM +0300, Vasily Averin wrote:
> I would like to properly handle cgroup1 case too.
> To do it we can enable accounting for new 'struct cgroup' objects, 
> and bind them to memcg of creator task.

I'm not sure it'd be a good idea to introduce two different behaviors for
handling the same thing. I'd just leave cgroup1 as-is.

Thanks.

-- 
tejun
