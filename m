Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9081556BAF3
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238237AbiGHNgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 09:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237385AbiGHNgc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 09:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 529F863E8
        for <linux-kernel@vger.kernel.org>; Fri,  8 Jul 2022 06:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657287390;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jS9QPRZ27XhQQ8+oiZrtqWPGy1J/SaGEji7xBp7spQY=;
        b=MECj1QziEXYmSgCbqaoC3HMOC17xUJJ6Qej2b+KKMd2E7zcX4aoo0nC0YQhU1OpqyFtkUO
        IhcRGCm+FWOW4oWEkS9Vtv4IXs7gFuxwQhuGgH9BZoOerEnvoev/AvU6WOTx16QgB9ZtYs
        JeRmQ2Gj825/dzSqQx/z6y6JyxHnNko=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-287-5bXA_TTROPKKQ8GibrLKqA-1; Fri, 08 Jul 2022 09:36:29 -0400
X-MC-Unique: 5bXA_TTROPKKQ8GibrLKqA-1
Received: by mail-wm1-f70.google.com with SMTP id 2-20020a1c0202000000b003a2cfab44eeso988551wmc.6
        for <linux-kernel@vger.kernel.org>; Fri, 08 Jul 2022 06:36:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jS9QPRZ27XhQQ8+oiZrtqWPGy1J/SaGEji7xBp7spQY=;
        b=kyIh7BXvdRdrEPOqCYUdtN5EPt6SUe+XeI6J7PU7AE33qnNQxcLNQnWmB1y26eFYCR
         W09FhSQoo8G2MEbiJZB+mTOLcUHfFgXchtA6ciM4e4vLBn3FNGFDVMumursacmSK6ZyG
         p/2bw7RD8tzyiaz0XL7zxnEqau54QYqRrMZ+oetUQ2p86HeGr84DKpnVb6m2XiNfaM07
         0Z0gR9SAxuKc+QJcCzfq6Y96w8Q86HGZll+42q6JgxIf79oh06dXjh9VrVjc5/lFTB/g
         QCtlNmrc1YWYNb79w7BlwcWpylBaSP6aOZSkD6zdohibWOv5zGBvxuQUz6DuBk6bnctB
         o5tQ==
X-Gm-Message-State: AJIora82rvNDdWBVOPiyeZoP2OSN+VJrR/2faCVSiXk0ywDhtzSLt5DE
        4F8sD92lnM7h87eUPhSa1iyyk8XfRZXzYQVcurokFiGfklPPgD/f7AlN0npqcJekyCaBNK6Y5hb
        u1CxMPxiRNzAahTj0+TCOHUxl
X-Received: by 2002:a05:6000:1d98:b0:21b:aead:9b6c with SMTP id bk24-20020a0560001d9800b0021baead9b6cmr3332991wrb.531.1657287388239;
        Fri, 08 Jul 2022 06:36:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sISNaiqw7kzmnWF5De1JLKP1VEpdf/EMlWjYJDrqBYFBGhS9dQjE/+x6lUGaSIp2dBwKvoBw==
X-Received: by 2002:a05:6000:1d98:b0:21b:aead:9b6c with SMTP id bk24-20020a0560001d9800b0021baead9b6cmr3332971wrb.531.1657287387995;
        Fri, 08 Jul 2022 06:36:27 -0700 (PDT)
Received: from localhost.localdomain ([151.29.51.61])
        by smtp.gmail.com with ESMTPSA id 83-20020a1c0256000000b003a0375c4f73sm2121995wmc.44.2022.07.08.06.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Jul 2022 06:36:27 -0700 (PDT)
Date:   Fri, 8 Jul 2022 15:36:25 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Mel Gorman <mgorman@suse.de>, Ben Segall <bsegall@google.com>,
        Luca Abeni <luca.abeni@santannapisa.it>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/3] DL capacity-aware fixes
Message-ID: <Ysgy2XkdceBaHz04@localhost.localdomain>
References: <20220629122053.287165-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220629122053.287165-1-dietmar.eggemann@arm.com>
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29/06/22 14:20, Dietmar Eggemann wrote:
> While testing cpusets on asymmetric CPU capacity systems I realized that
> the admission control, which kicks in when the cpumask of a cpuset is
> about to be changed, is not capacity-aware. [PATCH 2/3] addresses this
> issue.
> 
> Overview:
> 
> [PATCH 1/3] - Not part of the DL related changes but here for
>               convenience : Inline helper function around
>               static_branch_unlikely(&sched_asym_cpucapacity)
> 
> [PATCH 2/3] - Make dl_cpuset_cpumask_can_shrink() capacity-aware.
> 
> [PATCH 3/3] - Save a multiplication in dl_task_fits_capacity() by using
> 	      already maintained dl_density.

I had a look as well and, other than Vincent's comment on 3/3, the set
looked good to me. Looking forward for v2. :)

Thanks,
Juri

