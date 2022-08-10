Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0656158EF0C
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 17:13:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233003AbiHJPN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 Aug 2022 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233016AbiHJPNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Aug 2022 11:13:20 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 463A5760F2
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:13:19 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id c16so1913661qkk.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 08:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=cG8xvQKiBdJX9SXoS6vRmGgtJj6VHwGg1+M+QpFiZX0=;
        b=P8yh3XYP1aTmKsbIM63fGeAMQUiciJA+lCZPsYCLMw5bhhOErtxWu7OSdtanxU2vGV
         irT56MEwr1wkp0dfHKUXMf0HmyKVRQWEX19IDltFSJ/ZI/210R/1G22JU81/JNd5gym1
         rYJ+S8lSQPCBWsR7Rft//UpcpJXL+9eu1l6QT7cLkxHbeLuSMdYDYODtd+37cMukJd0x
         c30bIL+1+FLzUcDyVITJrSb9fjMSRXUnqCT8sVeNSEvZw1a41p1vnrUwRsv9P+aOHkuf
         GIv8W+GhtD99Hm0AKPt2E5KQhjmKXiRUFryebKgNI9Z4KmozZJwduXfWFN1GjwesAXbG
         mhUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=cG8xvQKiBdJX9SXoS6vRmGgtJj6VHwGg1+M+QpFiZX0=;
        b=OPqHRLAt4IWHGHoCaTIUB2rDNq69PJ9ZjVb+w5F086Y+XMCgZRStkYig57Btsg0F6N
         YzugRtPg9YDqOompg0MMEyUil5BV7DdTW9IlfoRsb3Hgd7eh+ej7D0QCuLoxtwNV/Fwd
         Von9bw8J7NzPNeOn+fX0nspOsvzBPdM6SPwMEqkCKDRmD37ZezgEBTiAtxx8NkJH9tJg
         DscsWFk3zlIhYkt9dnqHkxORrugG2azriqRvVzFXSLS7FsRKcyb1Jl46PAiSZYTbcpyw
         eJ1EhJrChX9C2KzaG5rWvybkysiJo7xI8hxBv3AUgV5jMXBt7GHqsBvhPKdKw4vfgxgT
         9fAA==
X-Gm-Message-State: ACgBeo2fEQdtpkbD0ncqXFAzFNYWVdTYEQiY7CQqXfXqmxUffeBOrZD/
        QFkSQxphnMmYjyIHZ9geZBfk1w==
X-Google-Smtp-Source: AA6agR5MbKuI2+wPy80WHIHRlvRqNb/Sxy4oLN4wSbHdzVqBiJ536d9K2IbYsN98EU3FqFo9C8psnQ==
X-Received: by 2002:a05:620a:471f:b0:6b6:1c52:9b7d with SMTP id bs31-20020a05620a471f00b006b61c529b7dmr21470582qkb.394.1660144398385;
        Wed, 10 Aug 2022 08:13:18 -0700 (PDT)
Received: from localhost (2603-7000-0c01-2716-00ea-7f88-5fd9-01cd.res6.spectrum.com. [2603:7000:c01:2716:ea:7f88:5fd9:1cd])
        by smtp.gmail.com with ESMTPSA id s11-20020a05622a1a8b00b0031d283f4c4dsm12904101qtc.60.2022.08.10.08.13.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 08:13:18 -0700 (PDT)
Date:   Wed, 10 Aug 2022 11:13:17 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Hao Jia <jiahao.os@bytedance.com>
Cc:     mingo@redhat.com, peterz@infradead.org, mingo@kernel.org,
        juri.lelli@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] sched/psi: Remove redundant cgroup_psi() when
 !CONFIG_CGROUPS
Message-ID: <YvPLDdl/y5cfGy38@cmpxchg.org>
References: <20220806120510.96131-1-jiahao.os@bytedance.com>
 <20220806120510.96131-4-jiahao.os@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220806120510.96131-4-jiahao.os@bytedance.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 06, 2022 at 08:05:10PM +0800, Hao Jia wrote:
> cgroup_psi() is only called under CONFIG_CGROUPS.
> We don't need cgroup_psi() when !CONFIG_CGROUPS,
> so we can remove it in this case.
> 
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

Acked-by: Johannes Weiner <hannes@cmpxchg.org>
