Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 742B25658D5
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 16:40:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234911AbiGDOk2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 10:40:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231392AbiGDOj7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 10:39:59 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A6DCE10579
        for <linux-kernel@vger.kernel.org>; Mon,  4 Jul 2022 07:39:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656945571;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wCMz5VEjgh0a16F+GvqlNuK+LlxD4fJRGJ+ZP9uVyJY=;
        b=AE8xjIx4WgxFWo7ya3SjIsBjK0Nc02uTPwi94RPHHoNHno0t2SYA6jV05xW8hUCYRx7daM
        izmI9vnGBqd8ksOvK2r4eA5iR7gK19xZ/vIsTVE5ad+ac1MJvKY/CXh4q9j+vnUBv5zUy9
        ohXNMIAK8itVA0BfnnDI1KGy/bHoKig=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-xJ7bIjSpOAGMqNNqcFaCxg-1; Mon, 04 Jul 2022 10:39:30 -0400
X-MC-Unique: xJ7bIjSpOAGMqNNqcFaCxg-1
Received: by mail-wm1-f69.google.com with SMTP id r206-20020a1c44d7000000b003a02fa133ceso341252wma.2
        for <linux-kernel@vger.kernel.org>; Mon, 04 Jul 2022 07:39:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version:content-transfer-encoding;
        bh=wCMz5VEjgh0a16F+GvqlNuK+LlxD4fJRGJ+ZP9uVyJY=;
        b=izbxu5wPGhamKNzsRkAHzs4A/tU97w8rV2/l6d7XhFpq7wa+b1m7fzb9yRJbtz8izY
         PqkREb+LMbSjGqtKomDt8NGWJl+lT42JRGmF6Kx4IpLh6DRyEMFL2LD30N1tDPEcihKv
         EFAgvSEzmSBN8pT3VthMZLJ3KNFq4rTwZKF74irUbGqvTOromJrD50AWmYyjK6GjysK+
         V2FqJxc80mnNQe4FR9U9Y+kzifOwWf4oH4Kl5BsK2gmGB9HRICXoJO7dbKtfdITzA21r
         3NZdtSMNHcC4yug3HJ4/Lo/oAN26zpLUnfToeBYpFO+ElLIie6Ql+5EkpBABWBGfzTFg
         TVDQ==
X-Gm-Message-State: AJIora8S//gzrgITOmTsIpge/5woWPal9pcYZcX+1rCM30oOaZTSuYey
        lc4AIxEhQs/MuqXk2FIvql9l8G8ou0YEDtePRQYlHmpbwsCXt5KH9oWFHYmO8pp7UL7MpHReLQT
        fYIHDjQ2UJ0vN4btxvHxR1oy2
X-Received: by 2002:adf:e192:0:b0:21d:62ee:ef10 with SMTP id az18-20020adfe192000000b0021d62eeef10mr10874528wrb.693.1656945568644;
        Mon, 04 Jul 2022 07:39:28 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vK9yFq5TtBqijKFUvUIA5jBzlFurw+SMeF+JDU0BPHBDT3jR6zh/U6RFoRcEAIg/cR5h+p9w==
X-Received: by 2002:adf:e192:0:b0:21d:62ee:ef10 with SMTP id az18-20020adfe192000000b0021d62eeef10mr10874505wrb.693.1656945568348;
        Mon, 04 Jul 2022 07:39:28 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id g14-20020a05600c4ece00b0039c99f61e5bsm17932446wmq.5.2022.07.04.07.39.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Jul 2022 07:39:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Hao Jia <jiahao.os@bytedance.com>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com
Cc:     linux-kernel@vger.kernel.org, Hao Jia <jiahao.os@bytedance.com>
Subject: Re: [PATCH] sched/topology: Optimized copy default topology in
 sched_init_numa()
In-Reply-To: <20220627105349.80715-1-jiahao.os@bytedance.com>
References: <20220627105349.80715-1-jiahao.os@bytedance.com>
Date:   Mon, 04 Jul 2022 15:39:27 +0100
Message-ID: <xhsmh35fhgcww.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/22 18:53, Hao Jia wrote:
> The size of struct sched_domain_topology_level is 64 bytes.
> For NUMA platforms, almost all are multi-core (enable CONFIG_SCHED_MC),
> That is to say, the default_topology array has at least 128 bytes that
> need to be copied in sched_init_numa(). For most x86 platforms,
> CONFIG_SCHED_SMT will be enabled, so more copies will be required.
>
> And memcpy() will be optimized under different architectures.
> Fortunately, for platforms with CONFIG_NUMA enabled,
> these optimizations are likely to be used.
> So, let's use memcpy to copy default topology in sched_init_numa().
>
> Tests are done in an Intel Xeon(R) Platinum 8260 CPU@2.40GHz machine
> with 2 NUMA nodes each of which has 24 cores with SMT2 enabled, so 96
> CPUs in total.
>
> Use RDTSC to count time-consuming, and based on 5.19-rc4.
>
> Enable CONFIG_SCHED_SMT && CONFIG_SCHED_CLUSTER && CONFIG_SCHED_MC,
> So the default_topology array has 256 bytes that need to be copied
> in sched_init_numa().
>                      5.19-rc4   5.19-rc4 with patch
> average tsc ticks    516.57      85.33   =EF=BC=88-83.48%*=EF=BC=89
>
> Enable CONFIG_SCHED_MC, So the default_topology array has
> 128 bytes that need to be copied in sched_init_numa().
>                      5.19-rc4   5.19-rc4 with patch
> average tsc ticks    65.71       55.00   =EF=BC=88-16.30%*=EF=BC=89
>
> Signed-off-by: Hao Jia <jiahao.os@bytedance.com>

It's not a very hot path but I guess this lets you shave off a bit of boot
time... While you're at it, you could add an early

  if (nr_node_ids =3D=3D 1)
          return;

since !NUMA systems still go through sched_init_numa() if they have a
kernel with CONFIG_NUMA (which should be most of them nowdays) and IIRC
they end up with an unused NODE topology level.

Regardless:

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

