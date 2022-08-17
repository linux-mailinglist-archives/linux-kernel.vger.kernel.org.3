Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A2305978D0
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 23:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241849AbiHQVPq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 17:15:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241421AbiHQVPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 17:15:44 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5333657560
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:15:43 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id o7so413893pfb.9
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=W68mRWKkzm4aDvuZ9fpamtsHCYcoX/l6oOU0+8H2cO4=;
        b=ghlXe6amfyyPTIvD8h2OzBZpSNxzzwySTwBtK1UPSmnioTgnh6ix6wHqO5kkTg0id+
         msSOuCmLyksrTHImHfmjouS47CtMFxITU5gi9f9dvldGB5A+XaCdOygO9Wk1kI2fG01k
         mnkM6RBrYtjI5H9PhOLA9YFlbm3DdpnK9Iq/2bqLHlbzzTpDQvfbmoKgltQTn0/p6NAc
         DCKybAFDCfMwKpL/UM2ZDY1iiUGT/jsB60Wt2vXKlXfCy4i8Axz5tjYLUI3gqKqx83+P
         WiTAExMVQs73pP/z+J3YbTy8VXkGUNvfdnVY18SLK8UfHsWoced8Q2a6VlJc/8tg5gh3
         g7ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=W68mRWKkzm4aDvuZ9fpamtsHCYcoX/l6oOU0+8H2cO4=;
        b=OfbsObQMgoEeNg3rCtC7xuZv0wZX5pZ58LlB8TW7PHiqgy4JFO11unugZlLUhKnco5
         f/WQ4Jmsr4PWsGFx4RVWhuywzGIL7UIjaDN5H9nZwwABPxY3k51g2bgs6H2SNp4YvqrR
         3Re/AsONZEuCbwzeyOIYhGRxl3PCQYjNV734Zg8SXfggXm0evFjSvjkQ4RSfGgruZYTC
         TA/wHnSpPf50eyO12KDesrq4LzsFknfDjTQOyrukQK9VP4QZhzGdQSNQDnt7t6riBK73
         uwhLe/8aiaFSlxmAlti5JtUAiekCPN7kOCAaoFf0eDcM+qFYE3gn6wjGde1fUWDsBUrs
         CNfg==
X-Gm-Message-State: ACgBeo3HEqnF6ht8LFI0TsBMaS98BXACc7Ihma0uUnFk/6adxE5MfMb/
        tx2ThrmWmOuy8haQ0tlvFPX/7CIe+0VYfCjpRL0vNA==
X-Google-Smtp-Source: AA6agR6xwfKf6D6wqNoQEEBkzrbPSMQzcv/mEr1zpbHYDP+XutaFQHfIfvT6kzRf52oEndp3Hrk4Z/xqu9kGSqZXvJM=
X-Received: by 2002:a05:6a00:2392:b0:52e:b4fb:848 with SMTP id
 f18-20020a056a00239200b0052eb4fb0848mr62888pfc.8.1660770942604; Wed, 17 Aug
 2022 14:15:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220816185801.651091-1-shy828301@gmail.com>
In-Reply-To: <20220816185801.651091-1-shy828301@gmail.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Wed, 17 Aug 2022 14:15:31 -0700
Message-ID: <CALvZod5kbOf+-jVWBhb1ior0oyWUKjMT57bip_eGGxWwSDVf=A@mail.gmail.com>
Subject: Re: [PATCH] mm: memcg: export workingset refault stats for cgroup v1
To:     Yang Shi <shy828301@gmail.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        Muchun Song <songmuchun@bytedance.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 16, 2022 at 11:58 AM Yang Shi <shy828301@gmail.com> wrote:
>
> Workingset refault stats are important and usefule metrics to measure

*useful

> how well reclaimer and swapping work and how healthy the services are,
> but they are just available for cgroup v2.  There are still plenty users
> with cgroup v1, export the stats for cgroup v1.
>
> Signed-off-by: Yang Shi <shy828301@gmail.com>

Acked-by: Shakeel Butt <shakeelb@google.com>
