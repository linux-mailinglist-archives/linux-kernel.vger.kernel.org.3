Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FD252E1BF
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 03:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344249AbiETBMl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 21:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40272 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233927AbiETBMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 21:12:37 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEADF1238A9
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:12:36 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-2fb7cb07885so59540427b3.23
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 18:12:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tRp9XwLCJd757nd6S6xrPEWJRWBLPfMUrN42v2RElFU=;
        b=kLj1335gWXNqN3m0x4aikHu59YFs4w9jVsakDkYazDHkv7NdPPTHMDWcCBbO3/UU6H
         C4koYXf/EG3VCj89YpQGoAsQcqkjWiUI4krLBCoyZ0vffn/xz7p+GjRLzkI0Djr3cUR7
         icY3wNQnvbaXZORjv/+6eb+8c/8U5ZM0Sd2cE2skWOCrjurR8T/B9QDmAf8S1w48L3bR
         87Z4HB468t+jYhTBRp28yYN2j311pzzKaC5m+TmiItPYKSuvb9j5Zd5tiOdshLhQ5Ts2
         I54OjEYN9vXGiN83EaXLux5pHpSMsc31hiSPBrS5buR9BD8XZhC4mZXKH3ayBQ0DRmHS
         IVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tRp9XwLCJd757nd6S6xrPEWJRWBLPfMUrN42v2RElFU=;
        b=ip0M2rioek4ZS4/e30es4xxqUPHMxFtKvnIjBgcrIiTpqoXpM4kCRK23muhd+i4wwn
         DAnIxWDk5mEB8JG6ko35V5xn8ls0/co+7t95yk1S0Xyms/5JYLFn3kNWfQ9fQM5guJXb
         bpGbpDdobnYaIU1gYKcLLiAxbxfeSo6BtsR6+ar8GwUqiD2FWYGe7GsO58/m+CI3yhHB
         Gxg7SXFaLZNccO9gB5P6WuEVb9UrEX+3POQUbRXd1zmk8BC9UmZGHZ292D7iV4aDtj8D
         gHGEB+nM1RLgKMv71qO6WISKJF7BBtW4t0DnhE37Fa50ZnOyA9LM4ZjRO2NaJN5vm39p
         yNaQ==
X-Gm-Message-State: AOAM531lBC/WMTrSkrVDEha/zv7HumBGdt8/lTjKcP5kPjNqvNJkqHXk
        sHPeSUe+SzU5aAU+tAJdUjqLzyYkcBMr4Q==
X-Google-Smtp-Source: ABdhPJyuiwPd0mGkX3bVtfcgfftvAb+9azlm4isHk7kCY2QP2shRGSH8dq+GIVT0R0Fjh1DkLbeEJW8MtvjZ4A==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:1f85:0:b0:64b:a5fc:e881 with SMTP id
 f127-20020a251f85000000b0064ba5fce881mr7404391ybf.514.1653009156066; Thu, 19
 May 2022 18:12:36 -0700 (PDT)
Date:   Fri, 20 May 2022 01:12:33 +0000
In-Reply-To: <22ccf325-6aa5-9b55-4729-d03f34125650@openvz.org>
Message-Id: <20220520011233.fxbqxcljfcrjk44n@google.com>
Mime-Version: 1.0
References: <Ynv7+VG+T2y9rpdk@carbon> <22ccf325-6aa5-9b55-4729-d03f34125650@openvz.org>
Subject: Re: [PATCH 2/4] memcg: enable accounting for kernfs nodes and iattrs
From:   Shakeel Butt <shakeelb@google.com>
To:     Vasily Averin <vvs@openvz.org>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        kernel@openvz.org, linux-kernel@vger.kernel.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 13, 2022 at 06:51:55PM +0300, Vasily Averin wrote:
> kernfs nodes are quite small kernel objects, however there are few
> scenarios where it consumes significant piece of all allocated memory:
> 
> 1) creating a new netdevice allocates ~50Kb of memory, where ~10Kb
>    was allocated for 80+ kernfs nodes.
> 
> 2) cgroupv2 mkdir allocates ~60Kb of memory, ~10Kb of them are kernfs
>    structures.
> 
> 3) Shakeel Butt reports that Google has workloads which create 100s
>    of subcontainers and they have observed high system overhead
>    without memcg accounting of kernfs.
> 
> It makes sense to enable accounting for kernfs objects, otherwise its
> misuse inside memcg-limited can lead to global memory shortage,
> OOM and random kills of host processes.
> 
> Signed-off-by: Vasily Averin <vvs@openvz.org>

Acked-by: Shakeel Butt <shakeelb@google.com>

You can keep the ack if you decide to include simple_xattr_alloc() in
following version or different patch.
