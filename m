Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF34B59E547
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 16:45:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242125AbiHWOof (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 10:44:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241667AbiHWOoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 10:44:05 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F7113D762
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:05:30 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id q7so15680101lfu.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 05:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=m2LcsEg/iG8WMqoFUm6fmHvJ0U3cgdesBrs1ffwi3tg=;
        b=7oGZuJrpYaWJRNwMj4gyFep4ORkRtWLTkdzEs6YMpOBkebjHM1aHipJBiAb4pPaEsv
         tK/7wV2E5i4DFh9r1Ogv4e4PjKd2xmH7Qj2Gx76wYDZNCedBBg2akG45PuOtogvAq2GY
         WOtBBDChhmcUctSCHkMdEq5UhVFCmEwgxOCRdqJmaYjxoqcAUgmxrm9rbnx0Z4d3gZF+
         Jl3Zxz9EY5xtNNc/W3j6Hm8OC3Jd6YANlCJeSLgDyYsm8lSchRGjZvn538dezgNNoI24
         SIS86GCnCJ0tr6zC/uOh3htJmogBPJpJDKM2Tp7eSI3zEw07RU45H0vnHe1Gm3m4SO69
         SlEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=m2LcsEg/iG8WMqoFUm6fmHvJ0U3cgdesBrs1ffwi3tg=;
        b=311KoWpSlFW2mzZ7JG8TRnL1TI3BZjhjFWAJA2K0TZ32OfS7eHPSd23K8MPg+BD5vY
         SYiM2FKnjufqS6o+uuIFH/L7Jd0vcDYLplNo12NTKmapCInEWrkWzw+NGPM3a61hBYhC
         hwKPJPHuXFd9HgOPz91fpfSzk85Eo7RoKi+4QOXAnzzA9NE8axuGfmjDig7rexm01e+z
         JikTol17btnfzX6fvRo5r2MYzZPSsfXSSdgDYLifdyJO1FtryK09G6BRdCJ74TwKfjpK
         RqLwShpCdnxUzB8EdDtK3MMhhx7BRe0erqeqVX+O3xqsC599caa9wc+A7rMYuSXi1nR0
         Qw3w==
X-Gm-Message-State: ACgBeo0n62RmbrET0oFbxGpgO/I3SQ8a1yjZgZLcMI44pe5pTKLV8cLy
        cnlVnkq++Y3sGRc1c0kN0lxVmA==
X-Google-Smtp-Source: AA6agR7mpJj3mz/1uR0wh2EHotr4qyDMyGsPw+P000J4SV1M96EMF4BaItqNosJZ/QOTlqG29Y27Tg==
X-Received: by 2002:a05:6512:60f:b0:492:f01d:5d4f with SMTP id b15-20020a056512060f00b00492f01d5d4fmr1830075lfe.640.1661256272816;
        Tue, 23 Aug 2022 05:04:32 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.143])
        by smtp.gmail.com with ESMTPSA id j4-20020a056512344400b00492d09aed44sm1859901lfr.195.2022.08.23.05.04.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 05:04:32 -0700 (PDT)
Message-ID: <b64759d9-e183-99a2-3ec5-9241035eca69@openvz.org>
Date:   Tue, 23 Aug 2022 15:04:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC PATCH] memcg: adjust memcg for new cgroup allocations
Content-Language: en-US
To:     Tejun Heo <tj@kernel.org>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        gregkh@linuxfoundation.org, hannes@cmpxchg.org, kernel@openvz.org,
        linux-kernel@vger.kernel.org, mhocko@suse.com, shakeelb@google.com,
        songmuchun@bytedance.com, viro@zeniv.linux.org.uk,
        Christian Brauner <brauner@kernel.org>
References: <62188f37-f816-08e9-cdd5-8df23131746d@openvz.org>
 <45a04b75-d61b-4c7a-7169-c971995a6049@openvz.org>
 <20220817091728.GA23229@blackbody.suse.cz> <Yv0aMqMIafD7cOQX@slm.duckdns.org>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <Yv0aMqMIafD7cOQX@slm.duckdns.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/17/22 19:41, Tejun Heo wrote:
> Hello,
> 
> On Wed, Aug 17, 2022 at 11:17:28AM +0200, Michal Koutný wrote:
>> On Wed, Aug 17, 2022 at 10:42:40AM +0300, Vasily Averin <vvs@openvz.org> wrote:
>>> However, now we want to enable accounting for some other cgroup-related
>>> resources called from cgroup_mkdir. We would like to guarantee that
>>> all new accounted allocation will be charged to the same memory cgroup.
>>
>> Here's my point -- the change in the referenced patch applied to memory
>> controller hierarchies. This extension applies to any hierarchy that can
>> create groups, namely, a hierarchy without memory controller too. There
>> mem_cgroup_from_cgroup falls back to the root memcg (on a different
>> hierarchy).

My goal was to properly account kernfs and simple_xattr entries only, 
however I missed that it does not work in cgroup1 case.

>> If the purpose is to prevent unlimited creation of cgroup objects, the
>> root memcg is by principle unlimited, so it's just for accounting.

No, the goal is not to prevent unlimited creation of cgroup objects.
As Michal Hocko pointed it can be done via cgroup.max.descendants limits.

>> But I understand the purpose is to have everything under one roof,
>> unless the object lifetime is not bound to that owning memcg. Should
>> memory-less hierarchies be treated specially?
> 
> At least from my POV, as long as cgroup1 is not being regressed, we want to
> make decisions which make the best long term sense. We surely can
> accommodate cgroup1 as long as the added complexity is minimal but the bar
> is pretty high there. cgroup1 has been in maintenance mode for years now and
> even the basic delegation model isn't well established in cgroup1, so if we
> end up accounting everything in the root cgroup for most of cgroup1
> hierarchies, that sounds fine to me.

I would like to properly handle cgroup1 case too.
To do it we can enable accounting for new 'struct cgroup' objects, 
and bind them to memcg of creator task.

Thank you,
	Vasily Averin
