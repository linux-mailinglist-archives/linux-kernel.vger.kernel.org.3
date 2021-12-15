Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2EDA747511D
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Dec 2021 03:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbhLOCzK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Dec 2021 21:55:10 -0500
Received: from szxga01-in.huawei.com ([45.249.212.187]:15735 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239407AbhLOCzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Dec 2021 21:55:06 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4JDKXN2D5yzWtFl;
        Wed, 15 Dec 2021 10:52:04 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 15 Dec 2021 10:55:03 +0800
Subject: Re: [PATCH -next] audit: use struct_size() helper in kmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     <paul@paul-moore.com>, <eparis@redhat.com>,
        <keescook@chromium.org>, <linux-audit@redhat.com>,
        <linux-kernel@vger.kernel.org>, <wangweiyang2@huawei.com>,
        <linux-hardening@vger.kernel.org>
References: <20211214114854.133328-1-xiujianfeng@huawei.com>
 <20211214175448.GA13107@embeddedor> <20211214181040.GA13575@embeddedor>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <90976674-0ae9-2c5f-cfa6-02ff7aac0c18@huawei.com>
Date:   Wed, 15 Dec 2021 10:55:03 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20211214181040.GA13575@embeddedor>
Content-Type: text/plain; charset="gbk"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


ÔÚ 2021/12/15 2:10, Gustavo A. R. Silva Ð´µÀ:
> On Tue, Dec 14, 2021 at 11:54:48AM -0600, Gustavo A. R. Silva wrote:
>> On Tue, Dec 14, 2021 at 07:48:54PM +0800, Xiu Jianfeng wrote:
>>> Make use of struct_size() helper instead of an open-coded calucation.
>>>
>>> Link: https://github.com/KSPP/linux/issues/160
>>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>>> ---
>>>   kernel/audit.c       | 2 +-
>>>   kernel/audit_tree.c  | 2 +-
>>>   kernel/auditfilter.c | 2 +-
>>>   3 files changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/kernel/audit.c b/kernel/audit.c
>>> index d4084751cfe6..f33028578c60 100644
>>> --- a/kernel/audit.c
>>> +++ b/kernel/audit.c
> This could use struct_size(), too:
>
> 1461                 audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
> 1462                                  sig_data, sizeof(*sig_data) + len);
>
>>> @@ -1446,7 +1446,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>>>   			if (err)
>>>   				return err;
>>>   		}
>>> -		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
>>> +		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
>>>   		if (!sig_data) {
>>>   			if (audit_sig_sid)
>>>   				security_release_secctx(ctx, len);
>>> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>>> index 72324afcffef..e7315d487163 100644
>>> --- a/kernel/audit_tree.c
>>> +++ b/kernel/audit_tree.c
>>> @@ -94,7 +94,7 @@ static struct audit_tree *alloc_tree(const char *s)
>>>   {
>>>   	struct audit_tree *tree;
>>>   
>>> -	tree = kmalloc(sizeof(struct audit_tree) + strlen(s) + 1, GFP_KERNEL);
>>> +	tree = kmalloc(struct_size(tree, pathname, strlen(s) + 1), GFP_KERNEL);
>>>   	if (tree) {
>>>   		refcount_set(&tree->count, 1);
>>>   		tree->goner = 0;
>>> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
>>> index 4173e771650c..19352820b274 100644
>>> --- a/kernel/auditfilter.c
>>> +++ b/kernel/auditfilter.c
> Also, in this same file the following piece of code could use
> struct_size(), too:
>
> 1093                         skb = audit_make_reply(seq, AUDIT_LIST_RULES, 0, 1,
> 1094                                                data,
> 1095                                                sizeof(*data) + data->buflen);
>
> Thanks
> --
> Gustavo
thanks, I missed these two places, I will add them in the v2 patch.
>>> @@ -637,7 +637,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
>>>   	void *bufp;
>>>   	int i;
>>>   
>>> -	data = kmalloc(sizeof(*data) + krule->buflen, GFP_KERNEL);
>>> +	data = kmalloc(struct_size(data, buf, krule->buflen), GFP_KERNEL);
>> Why don't you also transform the zero-length array in struct
>> audit_rule_data into a flexible-array member:
>>
>> 508 struct audit_rule_data {
>> 509         __u32           flags;  /* AUDIT_PER_{TASK,CALL}, AUDIT_PREPEND */
>> 510         __u32           action; /* AUDIT_NEVER, AUDIT_POSSIBLE, AUDIT_ALWAYS */
>> 511         __u32           field_count;
>> 512         __u32           mask[AUDIT_BITMASK_SIZE]; /* syscall(s) affected */
>> 513         __u32           fields[AUDIT_MAX_FIELDS];
>> 514         __u32           values[AUDIT_MAX_FIELDS];
>> 515         __u32           fieldflags[AUDIT_MAX_FIELDS];
>> 516         __u32           buflen; /* total length of string fields */
>> 517         char            buf[0]; /* string fields buffer */
>> 518 };
>>
>> Thanks
>> --
>> Gustavo
>>
>>>   	if (unlikely(!data))
>>>   		return NULL;
>>>   	memset(data, 0, sizeof(*data));
>>> -- 
>>> 2.17.1
>>>
>>>
>>>
>>>
> .
