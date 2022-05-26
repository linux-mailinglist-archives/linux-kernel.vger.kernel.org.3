Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B533534866
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 03:54:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344810AbiEZBx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 21:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344786AbiEZBxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 21:53:53 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CBE9A7769
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:53:52 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z11so521270pjc.3
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 18:53:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2pxcPCM5VX3sDe5qyFbWo9KsQkuEix+lNtMfCJKnED8=;
        b=5FR6mDsGsdcRK/I2zLo0w4AmRmztswHxOMlOghEitUIUoFhbADRYuzTLEQOf1nH0ae
         kaBCxEXhH1e39HsFefV5KmXovUyqB9ZwSqz6pd0qlA1lj2z8Jg/wU1ozt74F2qYbNAZj
         m63WUwjKmvePg7TjRroTXI6TC2DsdWOCr8bpTkmIrzgpSoCsv1DCodVMB37ZJQLlRvc7
         yi7w0mLdNpHijHwKxwLJMpwieN/kVBttxwPW5S5CTNG8Rp9ESGT9wK7YnN9kADCpN+A8
         WL+U47BRmXfRDAoXnxUo1T6Mm6WwQTHpv7u4PSzkqM7Y3jSZh9CIz6DcbAaxzhFN4OQN
         CsMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2pxcPCM5VX3sDe5qyFbWo9KsQkuEix+lNtMfCJKnED8=;
        b=zvZhHblNgERf9RAefRnGZTn0qSBAz8OGFBK+rdCjbMRD0EiV9jhV0vpMdBLcC6sZeU
         aA0pqP+A5hT3i+ZsBjSp3XJHPHhhXWQMwjTGNBhTUD9vNFUilm6aBJt1OcnnwrciVhPM
         01BjZqgD4CsDzSlcpS9sKAus7RlLLD4jP7mlYCBxKiEFB2Ql6yqP1mQstRHzBv3JRRGa
         rb7x+/Kv9nZi4Y6zsZ6g919N4KFKf3NDuXayLBIusRs7NV7mEZo+Cr6r99F8g4tmMwTB
         sf8Qe3QJe1FDyDFWDTKlZkqoOa7QFKy6DYCE+RwgNTrVMnLfCLHyxmuZZFOsJ1nK0SF6
         prXg==
X-Gm-Message-State: AOAM533GgkOYxi6qe2M4VnwgsiInf36tOd7dmTcqB7n/CCYoQahSLhn5
        6KJSDbz0r/UwdQjI6eZA8H+AhQ==
X-Google-Smtp-Source: ABdhPJxLVXYPbhDTW6AtuaVmmhyNvqcx7+jSSXywyFBxJNlDjtHcVlRLEq4+CwmtINLsa++1kLB5vg==
X-Received: by 2002:a17:902:b703:b0:158:2667:7447 with SMTP id d3-20020a170902b70300b0015826677447mr35269851pls.92.1653530031588;
        Wed, 25 May 2022 18:53:51 -0700 (PDT)
Received: from localhost ([2408:8207:18da:2310:c40c:3e14:bb57:48be])
        by smtp.gmail.com with ESMTPSA id 65-20020a620644000000b0050dc7628166sm68190pfg.64.2022.05.25.18.53.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 May 2022 18:53:51 -0700 (PDT)
Date:   Thu, 26 May 2022 09:53:47 +0800
From:   Muchun Song <songmuchun@bytedance.com>
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Dave Chinner <dchinner@redhat.com>,
        linux-kernel@vger.kernel.org,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Hillf Danton <hdanton@sina.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Subject: Re: [PATCH v4 1/6] mm: memcontrol: introduce mem_cgroup_ino() and
 mem_cgroup_get_from_ino()
Message-ID: <Yo7dqwUZhpe2amtF@FVFYT0MHHV2J.googleapis.com>
References: <20220525202600.2910982-1-roman.gushchin@linux.dev>
 <20220525202600.2910982-2-roman.gushchin@linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220525202600.2910982-2-roman.gushchin@linux.dev>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 25, 2022 at 01:25:55PM -0700, Roman Gushchin wrote:
> Shrinker debugfs requires a way to represent memory cgroups without
> using full paths, both for displaying information and getting input
> from a user.
> 
> Cgroup inode number is a perfect way, already used by bpf.
> 
> This commit adds a couple of helper functions which will be used
> to handle memcg-aware shrinkers.
> 
> Signed-off-by: Roman Gushchin <roman.gushchin@linux.dev>

Acked-by: Muchun Song <songmuchun@bytedance.com>

Thanks.
