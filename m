Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AF1351777F
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 21:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233598AbiEBTl1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 15:41:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57286 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiEBTlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 15:41:24 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21C6065D4
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 12:37:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id t25so2830632ljd.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 12:37:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=J7CBsRSCXXbD2/NTY2D5JamVPix8X/S/pKY0BP5yLBM=;
        b=t558DsrcLANHfzoqL9k9rSR9hcDj2jp1a50++NsDsBG6Kqz8P1S5fyIO6vJzyeSnPY
         jFiS4a0TeP4oHp5+RCGhQezFeLCtr+ShAPkOlDPoanNfqphdGAdeEsopDn1HP0uTtmzl
         C+C1HgrN9fh76OvW++baovvPOP1si22RlJzrXefq4EEQaldw/C+ijUjxUxttekLO0mOJ
         jcK/lL9vBtiDxfDMTyxX0gQLfAt6JOhU2s8V536Mf8LPQCzyog9upddfbV27W5pSPiGV
         VpoLsS+GyYSl1fM2UJsRtiQCnZP3f6aY9+34QzJxKXQrXyeRPYErVgH2Xhxj7Cev4prC
         BxYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=J7CBsRSCXXbD2/NTY2D5JamVPix8X/S/pKY0BP5yLBM=;
        b=JJIMYfn0jMRazDsezXljBgRTaVFvJy+f0rMJHSHyoo7Q5z1rtNjRLtuLm7fyvtlh/+
         a94FKKm0ZmgSilMtQNpZgKTvIa40FzVIK0Tdd7qQRCB9aGdZ/gm9YXSt+sVX7Uqd78g+
         C0SaMfopqv279jXp91m5m19CTKafIheQvIiRAHD6Ly4SxMST1791jDuzhI9yxsDpOWh9
         nrmovQ3jdaMRxxA1oDZ+1sbnPUoQCnOS2aNW5N5CPT9eYG1GI3f8H1yRJf8v6p0viVXZ
         3bLJuN/9OQ8wzWzNsMsHGwG0d4Pht16UdDZmBCTnsVOQRZprdyS+cp3zFPxJ5knbCUCy
         aYcQ==
X-Gm-Message-State: AOAM532TPkKX2bK3QqaWXMSE1ngELyUgQZAY7k8/zdvXphjmPdLSWJao
        ddxzOwyehH1F6b+NUarMWbX7Kg==
X-Google-Smtp-Source: ABdhPJxDKQ1glTiWrGq7xgdFpGeMkHjOz9EqJyGVjvY/OadZro3UgEgWuIyZiDuVAogp/hCPxUS4lQ==
X-Received: by 2002:a2e:86c6:0:b0:246:3c93:1c8a with SMTP id n6-20020a2e86c6000000b002463c931c8amr8410222ljj.354.1651520272491;
        Mon, 02 May 2022 12:37:52 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.177])
        by smtp.gmail.com with ESMTPSA id e7-20020a056512090700b0047255d211aesm774858lft.221.2022.05.02.12.37.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 May 2022 12:37:51 -0700 (PDT)
Message-ID: <7509fa9f-9d15-2f29-cb2f-ac0e8d99a948@openvz.org>
Date:   Mon, 2 May 2022 22:37:49 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: kernfs memcg accounting
Content-Language: en-US
To:     =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>
Cc:     Roman Gushchin <roman.gushchin@linux.dev>,
        Vlastimil Babka <vbabka@suse.cz>,
        Shakeel Butt <shakeelb@google.com>, kernel@openvz.org,
        Florian Westphal <fw@strlen.de>, linux-kernel@vger.kernel.org,
        Michal Hocko <mhocko@suse.com>, cgroups@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Tejun Heo <tj@kernel.org>
References: <7e867cb0-89d6-402c-33d2-9b9ba0ba1523@openvz.org>
 <20220427140153.GC9823@blackbody.suse.cz>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <20220427140153.GC9823@blackbody.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/22 17:01, Michal Koutný wrote:
> Hello Vasily.
> 
> On Wed, Apr 27, 2022 at 01:37:50PM +0300, Vasily Averin <vvs@openvz.org> wrote:
>> diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
>> index cfa79715fc1a..2881aeeaa880 100644
>> --- a/fs/kernfs/mount.c
>> +++ b/fs/kernfs/mount.c
>> @@ -391,7 +391,7 @@ void __init kernfs_init(void)
>>  {
>>  	kernfs_node_cache = kmem_cache_create("kernfs_node_cache",
>>  					      sizeof(struct kernfs_node),
>> -					      0, SLAB_PANIC, NULL);
>> +					      0, SLAB_PANIC | SLAB_ACCOUNT, NULL);
> 
> kernfs accounting you say?
> kernfs backs up also cgroups, so the parent-child accounting comes to my
> mind.
> See the temporary switch to parent memcg in mem_cgroup_css_alloc().

Dear Michal,
I did not understand your statement. Could you please explain it in more details?

I see that cgroup_mkdir()->cgroup_create() creates new kernfs node for new
sub-directory, and with my patch account memory of kernfs node to memcg 
of current process.
Do you think it is incorrect and new kernfs node should be accounted
to memcg of parent cgroup, as mem_cgroup_css_alloc()-> mem_cgroup_alloc() does?
Perhaps you mean that in this case kernfs should not be counted at all,
as almost all neighboring allocations do?

Thank you,
	Vasily Averin
