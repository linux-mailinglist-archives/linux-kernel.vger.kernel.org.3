Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 024D955E1EE
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:34:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244150AbiF1D7M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 23:59:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244143AbiF1D7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 23:59:11 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80A9528E02
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:59:09 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id a11so13348474ljb.5
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 20:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=MFS2x9pNQLwXGwuNgzQ1iIUHTuj+zHNF+6//GrDccok=;
        b=mxbVmJ++2Cc5/l/lqWx9Fs7t2Zg7/rpqevzlWyOhXZcy9grpe35G9l9ySScKLev9uU
         Dz4LDLeUYcVPDUSNls7Ymx0CeJl3DwKUSThgh4DQBTI8XLC2NylaXNKQahTJuNrrhUjh
         aREqf+FUffagdLwymwDwlWSSZTJY8wZ/FbaTDj6Cjw5imW4HlIy0AFuvLVetwmwNEHvp
         qh5Lj5ek3pFqkm0PtNrDLngV8a5QKRAFrMwMy8CK7R61VAE541rKqNoB9E4tl9f5IEsO
         KlC6BIKb6Pz11uDudiW1HiZtesTcxv+lpD+FqTR2LY+0s3ApEMvSGfdZXdhf8T98XTo0
         pVEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=MFS2x9pNQLwXGwuNgzQ1iIUHTuj+zHNF+6//GrDccok=;
        b=USIUGgjMrzkHqeTnM+vdhBl9IYxcrbs1uwq2bsCuXivt7IJ9/gsPa7iiyw3ZyFMi9X
         5y2tMdIfBiRSnzIpymKivZbciWhwhymg5+yOmbsEQgyUNN2ZJ2MeNnNimzy5RnITJGE/
         weg6mYDC0e5oqmCgZWDCmitG/IuYuuF8RWsfYC5i3vrWe4Egw9dVrQlSEshHTgo5g2nr
         Rc5Fa9JfwpXFSh4xpOsQcVVTF9DdwQzwFpS7bT0mHIIOGFUWF4lIIvDFibWaZxC5MnIw
         fhzLlK/hx1YD+lR0v8Vgz907ay7e7CSyDtd/CbrhFmn9DN0tL68wuwQy8ObX76qDdEbu
         hXnQ==
X-Gm-Message-State: AJIora8gr+JlcypBK8XZxx8FSQA1W2DOIGcNeaxQtG96qiszZZIONqAK
        SvCFC2QAOf36n3gcYt83sqlCum25tu9KjQ==
X-Google-Smtp-Source: AGRyM1v+P/2CJeZ+6sSIGo0bMtoNBlqMfhE/1f+IChMa8AR46nz3yFZFoohHBHPpjnE3p8uTTovsEQ==
X-Received: by 2002:a05:651c:19aa:b0:25b:d22a:dfc7 with SMTP id bx42-20020a05651c19aa00b0025bd22adfc7mr1008009ljb.410.1656388747749;
        Mon, 27 Jun 2022 20:59:07 -0700 (PDT)
Received: from [192.168.1.65] ([46.188.121.129])
        by smtp.gmail.com with ESMTPSA id s13-20020a05651c200d00b0025a928f3d63sm1586153ljo.61.2022.06.27.20.59.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 20:59:07 -0700 (PDT)
Message-ID: <17916824-ba97-68ba-8166-9402d5f4440c@openvz.org>
Date:   Tue, 28 Jun 2022 06:59:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH cgroup] cgroup: set the correct return code if hierarchy
 limits are reached
Content-Language: en-US
To:     Roman Gushchin <roman.gushchin@linux.dev>
Cc:     Shakeel Butt <shakeelb@google.com>,
        =?UTF-8?Q?Michal_Koutn=c3=bd?= <mkoutny@suse.com>,
        Michal Hocko <mhocko@suse.com>, Tejun Heo <tj@kernel.org>,
        Zefan Li <lizefan.x@bytedance.com>,
        Johannes Weiner <hannes@cmpxchg.org>, kernel@openvz.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Muchun Song <songmuchun@bytedance.com>, cgroups@vger.kernel.org
References: <186d5b5b-a082-3814-9963-bf57dfe08511@openvz.org>
 <d8a9e9c6-856e-1502-95ac-abf9700ff568@openvz.org> <YrpO9CUDt8hpUprr@castle>
From:   Vasily Averin <vvs@openvz.org>
In-Reply-To: <YrpO9CUDt8hpUprr@castle>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/28/22 03:44, Roman Gushchin wrote:
> On Mon, Jun 27, 2022 at 05:12:55AM +0300, Vasily Averin wrote:
>> When cgroup_mkdir reaches the limits of the cgroup hierarchy, it should
>> not return -EAGAIN, but instead react similarly to reaching the global
>> limit.
>>
>> Signed-off-by: Vasily Averin <vvs@openvz.org>
>> ---
>>  kernel/cgroup/cgroup.c | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
>> index 1be0f81fe8e1..243239553ea3 100644
>> --- a/kernel/cgroup/cgroup.c
>> +++ b/kernel/cgroup/cgroup.c
>> @@ -5495,7 +5495,7 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
>>  		return -ENODEV;
>>  
>>  	if (!cgroup_check_hierarchy_limits(parent)) {
>> -		ret = -EAGAIN;
>> +		ret = -ENOSPC;
> 
> I'd not argue whether ENOSPC is better or worse here, but I don't think we need
> to change it now. It's been in this state for a long time and is a part of ABI.
> EAGAIN is pretty unique as a mkdir() result, so systemd can handle it well.

I would agree with you, however in my opinion EAGAIN is used to restart an
interrupted system call. Thus, I worry its return can loop the user space without
any chance of continuation.

However, maybe I'm confusing something?

Thank you,
	Vasily Averin
