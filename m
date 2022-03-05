Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F5B4CE4D8
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Mar 2022 13:43:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231543AbiCEMoK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Mar 2022 07:44:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiCEMoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Mar 2022 07:44:06 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E09FA166A7B
        for <linux-kernel@vger.kernel.org>; Sat,  5 Mar 2022 04:43:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646484195;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8GqpN7gIPCwWSZ62iyPP0jbygDvqFyRDbk/03WQxzCo=;
        b=Dbh/IALKZRgPA3cjpf+i6vFxrGG07jXOyeKrYU47qBc+RUgDSLwe+ia3DyxO1+laVaV26u
        6+sbyvu9HKP9WXL/vRbhAqTtj1/hgR4EGutaxseIlLJLjJocqGnfLseFW2xMyXQEbiFxck
        3JvzEwkTDz1/oiqZjH1GlPsI1A7nwHg=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-636-lgdX4WNRNmyzyWxVedmWpQ-1; Sat, 05 Mar 2022 07:43:14 -0500
X-MC-Unique: lgdX4WNRNmyzyWxVedmWpQ-1
Received: by mail-pj1-f72.google.com with SMTP id mt1-20020a17090b230100b001beef010919so7664514pjb.7
        for <linux-kernel@vger.kernel.org>; Sat, 05 Mar 2022 04:43:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=8GqpN7gIPCwWSZ62iyPP0jbygDvqFyRDbk/03WQxzCo=;
        b=7A9nvLhwXVx1V2IJhexL18NcoNecpmXTOstMjPKuA8B3VEjeS7cyE1lMAei7XTpSkK
         sf9RQ5u5sG7SDyhazMekmlrv45yuWiuD3C3sjEuqHqyedrpn9i5bzGUQ/xtv+vIqIB3X
         pjoMHvR/O0ayVq4Fp4rKiPjYgojkLcpQ5wTy1AnI8hw+P2ua7XVrTCtaSctAosN8EkeV
         m5YnL9u8Saf0v25+b7kMhQ3zvzTwo8KAXF5FuLQYMfaPnaiR6neqeZut7JURLM1M7I3L
         p2Pw73UGK1oJV7xrG3LGL17t76iam04i4XAxz7Uqy2yxAWBT7yojsGPUbC49PnGbfFUb
         YfoQ==
X-Gm-Message-State: AOAM532f35qbMH0TP7ERmjRKq0i/Y0U20T4qE3U4Qm1SE4fIbRiTZmP7
        lZhZzqO99Xun6uhFV+68NmN8XO5BV2jcXOWvixuKn7rSH8mOPV+jOFY3GAAbK1quRjgpvIK5x9l
        8uHlwJKYeCZJASPX3Qgoti/OXfRBEwe9Oj/X980dlY6b0tLJDLAf4UOZyVSCnRKtcSZS/NNCKuw
        ==
X-Received: by 2002:a17:90a:4542:b0:1b9:bc2a:910f with SMTP id r2-20020a17090a454200b001b9bc2a910fmr3530239pjm.133.1646484192502;
        Sat, 05 Mar 2022 04:43:12 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwQOfYR7Y7u5dlrB2KRWzLGnzKbsJUjzPINaLf3a/iXbCGyBHHPekYnv12fb+marCAiF0kIVg==
X-Received: by 2002:a17:90a:4542:b0:1b9:bc2a:910f with SMTP id r2-20020a17090a454200b001b9bc2a910fmr3530216pjm.133.1646484192159;
        Sat, 05 Mar 2022 04:43:12 -0800 (PST)
Received: from [10.72.13.171] ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id j2-20020a655582000000b00372b2b5467asm7189298pgs.10.2022.03.05.04.43.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 05 Mar 2022 04:43:11 -0800 (PST)
Subject: Re: [PATCH 2/3] ceph: fix use-after-free in ceph_readdir
To:     Jeff Layton <jlayton@kernel.org>,
        =?UTF-8?Q?Lu=c3=ads_Henriques?= <lhenriques@suse.de>,
        Ilya Dryomov <idryomov@gmail.com>
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220304161403.19295-1-lhenriques@suse.de>
 <20220304161403.19295-3-lhenriques@suse.de>
 <55c6363a0ef0dcca3e6a7c882783f5d47dbbbdc7.camel@kernel.org>
From:   Xiubo Li <xiubli@redhat.com>
Message-ID: <79cd6979-cb02-c0a3-a4e9-d66f65d78976@redhat.com>
Date:   Sat, 5 Mar 2022 20:43:04 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <55c6363a0ef0dcca3e6a7c882783f5d47dbbbdc7.camel@kernel.org>
Content-Type: text/plain; charset=iso-8859-15; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/5/22 2:20 AM, Jeff Layton wrote:
> On Fri, 2022-03-04 at 16:14 +0000, Luís Henriques wrote:
>> After calling ceph_mdsc_put_request() on dfi->last_readdir, this field
>> should be set to NULL, otherwise we may end-up freeing it twince and get
>> the following splat:
>>
>>    refcount_t: underflow; use-after-free.
>>    WARNING: CPU: 0 PID: 229 at lib/refcount.c:28 refcount_warn_saturate+0xa6/0xf0
>>    ...
>>    Call Trace:
>>      <TASK>
>>      ceph_readdir+0xd35/0x1460 [ceph]
>>      ? _raw_spin_unlock+0x12/0x30
>>      ? preempt_count_add+0x73/0xa0
>>      ? _raw_spin_unlock+0x12/0x30
>>      ? __mark_inode_dirty+0x27c/0x3a0
>>      iterate_dir+0x7d/0x190
>>      __x64_sys_getdents64+0x80/0x120
>>      ? compat_fillonedir+0x160/0x160
>>      do_syscall_64+0x43/0x90
>>      entry_SYSCALL_64_after_hwframe+0x44/0xae
>>
>> Signed-off-by: Luís Henriques <lhenriques@suse.de>
>> ---
>>   fs/ceph/dir.c | 1 +
>>   1 file changed, 1 insertion(+)
>>
>> diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
>> index 0bcb677d2199..934402f5e9e6 100644
>> --- a/fs/ceph/dir.c
>> +++ b/fs/ceph/dir.c
>> @@ -555,6 +555,7 @@ static int ceph_readdir(struct file *file, struct dir_context *ctx)
>>   			      le32_to_cpu(rde->inode.in->mode) >> 12)) {
>>   			dout("filldir stopping us...\n");
>>   			ceph_mdsc_put_request(dfi->last_readdir);
>> +			dfi->last_readdir = NULL;
>>   			err = 0;
>>   			goto out;
>>   		}
> I think Xiubo fixed this in the testing branch late yesterday. It should
> no longer be needed.

Right and I have sent a new version of my previous patch to remove the 
buggy code.

- Xiubo

> Thanks,

