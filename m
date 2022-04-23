Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F10A50CAEA
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Apr 2022 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235910AbiDWOEq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Apr 2022 10:04:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235928AbiDWOEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Apr 2022 10:04:42 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 497BC6AA58
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:01:44 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-2f4e17a5809so51946257b3.2
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T8hqvwXzMDJqZ8Axnxfnhvq+3Bu/rfhoYjsi7PA4tsE=;
        b=SaaEKps4SdcXrfWLEhDKbRKvWuHqxD/qC9DthlbxTefT8zFbnCkKN6Twt0N/zWPsAU
         kJOzbP+3wq3L1DT7U8hKowgIHXNJSlfhEhCCYfjXkLsVcCgEaWIy3Ga1kCs9Pj1BgVou
         eETAD1Kace93r7bld1JcOoykJwmdEeNQd6b567WNlWqOJMytyl4gEqOx+RfI7++STaz7
         d8WiXLQeQEuCe01HMtqFsrTJopkuQYUY7UetF/X16zSVu9Ac6gXTXRhIO2i3L3SaVbou
         Cju3TdsCK+gMN7LKClrPxs1deGxBu6NTofsZp4LnlYrUunaHT7GuB+5CDuJ5wRWl69ZZ
         nxaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T8hqvwXzMDJqZ8Axnxfnhvq+3Bu/rfhoYjsi7PA4tsE=;
        b=SyE+Y6avvM9JnsZvLzl7sA7ZaBRmC6ZTJzMsisYDbqtIBpfqojKl1T37cTr72RsGN4
         HXB4FcvE0ZaMa30dXUO4jThTHHTcdv/Z8W1OtXNgMOmI9I6OYq4obmPatI2Plx4kDDmu
         KrcFnJk01wEAmQlJoKxM9hRLLRil0BrF/O4k7axm7hXaYH38urkT58A7IZzExEYXN6F0
         /bvIwl/fYDKh6eV369t91g0rdc17VSAAU6wsDaCrPt3xd6Vthn/X7FrdecI+0NO1YeCD
         dWCe1n9c7WShXYsbQvPkgroE44gnCEG/L8lY2qBmqXMIE2wOhh/ESrCXnahawwco5l7q
         KiyA==
X-Gm-Message-State: AOAM533bnmP87DZikQpEahqOwrdhXZdE/Q0dEebiphTogf64ZV6tv1TC
        FGJOxQp42TizW1A7Uuxr5w8pTBLrV56C2A==
X-Google-Smtp-Source: ABdhPJxsNaEps6ilaktgoEwtOSIY7NxJHT+V6V6MOj80bSa9QlpCvxee4wdQ5uX7FllpuzeE/S8bxPIyfYgnpw==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:20:ed76:c0a8:28b])
 (user=shakeelb job=sendgmr) by 2002:a25:8e90:0:b0:637:3d1f:cc39 with SMTP id
 q16-20020a258e90000000b006373d1fcc39mr8923198ybl.321.1650722503481; Sat, 23
 Apr 2022 07:01:43 -0700 (PDT)
Date:   Sat, 23 Apr 2022 14:01:41 +0000
In-Reply-To: <20220421234426.3494842-3-yosryahmed@google.com>
Message-Id: <20220423140141.si5uke4wwzkbvssv@google.com>
Mime-Version: 1.0
References: <20220421234426.3494842-1-yosryahmed@google.com> <20220421234426.3494842-3-yosryahmed@google.com>
Subject: Re: [PATCH v4 2/4] selftests: cgroup: return -errno from
 cg_read()/cg_write() on failure
From:   Shakeel Butt <shakeelb@google.com>
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        David Rientjes <rientjes@google.com>,
        Tejun Heo <tj@kernel.org>, Zefan Li <lizefan.x@bytedance.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Shuah Khan <shuah@kernel.org>, Yu Zhao <yuzhao@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Wei Xu <weixugc@google.com>, Greg Thelen <gthelen@google.com>,
        Chen Wandun <chenwandun@huawei.com>,
        Vaibhav Jain <vaibhav@linux.ibm.com>,
        "Michal =?utf-8?Q?Koutn=C3=BD?=" <mkoutny@suse.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Dan Schatzberg <schatzberg.dan@gmail.com>,
        cgroups@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 11:44:24PM +0000, Yosry Ahmed wrote:
> Currently, cg_read()/cg_write() returns 0 on success and -1 on failure.
> Modify them to return the -errno on failure.
> 
> Signed-off-by: Yosry Ahmed <yosryahmed@google.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
