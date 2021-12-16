Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D50544767B2
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 03:05:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232769AbhLPCF1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Dec 2021 21:05:27 -0500
Received: from szxga02-in.huawei.com ([45.249.212.188]:28322 "EHLO
        szxga02-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232752AbhLPCFX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Dec 2021 21:05:23 -0500
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4JDwRg36LLzbhsX;
        Thu, 16 Dec 2021 10:05:03 +0800 (CST)
Received: from [10.67.110.112] (10.67.110.112) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 16 Dec 2021 10:05:21 +0800
Subject: Re: [PATCH -next, v2] audit: use struct_size() helper in kmalloc()
To:     "Gustavo A. R. Silva" <gustavoars@kernel.org>
CC:     <paul@paul-moore.com>, <eparis@redhat.com>,
        <keescook@chromium.org>, <linux-kernel@vger.kernel.org>,
        <linux-hardening@vger.kernel.org>
References: <20211215030420.72324-1-xiujianfeng@huawei.com>
 <20211215220004.GA21862@embeddedor>
From:   xiujianfeng <xiujianfeng@huawei.com>
Message-ID: <ade6655d-a62e-1d57-d623-4bfc93ebbc57@huawei.com>
Date:   Thu, 16 Dec 2021 10:05:21 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20211215220004.GA21862@embeddedor>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.110.112]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2021/12/16 6:00, Gustavo A. R. Silva 写道:
> On Wed, Dec 15, 2021 at 11:04:20AM +0800, Xiu Jianfeng wrote:
>> Make use of struct_size() helper instead of an open-coded calculation.
> I think you should also mention the flexible array transformation in
> struct audit_rule_data.

thanks,  and due to the previous patch has been merged into linux-next, 
a diff patch about struct_size() and

a seperate patch about flexible array will be send.

>
> Thanks
> --
> Gustavo
>
>> Link: https://github.com/KSPP/linux/issues/160
>> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
>> ---
>>   include/uapi/linux/audit.h | 2 +-
>>   kernel/audit.c             | 4 ++--
>>   kernel/audit_tree.c        | 2 +-
>>   kernel/auditfilter.c       | 4 ++--
>>   4 files changed, 6 insertions(+), 6 deletions(-)
>>
>> diff --git a/include/uapi/linux/audit.h b/include/uapi/linux/audit.h
>> index 9176a095fefc..8eda133ca4c1 100644
>> --- a/include/uapi/linux/audit.h
>> +++ b/include/uapi/linux/audit.h
>> @@ -514,7 +514,7 @@ struct audit_rule_data {
>>   	__u32		values[AUDIT_MAX_FIELDS];
>>   	__u32		fieldflags[AUDIT_MAX_FIELDS];
>>   	__u32		buflen;	/* total length of string fields */
>> -	char		buf[0];	/* string fields buffer */
>> +	char		buf[];	/* string fields buffer */
>>   };
>>   
>>   #endif /* _UAPI_LINUX_AUDIT_H_ */
>> diff --git a/kernel/audit.c b/kernel/audit.c
>> index d4084751cfe6..7778eca34837 100644
>> --- a/kernel/audit.c
>> +++ b/kernel/audit.c
>> @@ -1446,7 +1446,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>>   			if (err)
>>   				return err;
>>   		}
>> -		sig_data = kmalloc(sizeof(*sig_data) + len, GFP_KERNEL);
>> +		sig_data = kmalloc(struct_size(sig_data, ctx, len), GFP_KERNEL);
>>   		if (!sig_data) {
>>   			if (audit_sig_sid)
>>   				security_release_secctx(ctx, len);
>> @@ -1459,7 +1459,7 @@ static int audit_receive_msg(struct sk_buff *skb, struct nlmsghdr *nlh)
>>   			security_release_secctx(ctx, len);
>>   		}
>>   		audit_send_reply(skb, seq, AUDIT_SIGNAL_INFO, 0, 0,
>> -				 sig_data, sizeof(*sig_data) + len);
>> +				 sig_data, struct_size(sig_data, ctx, len));
>>   		kfree(sig_data);
>>   		break;
>>   	case AUDIT_TTY_GET: {
>> diff --git a/kernel/audit_tree.c b/kernel/audit_tree.c
>> index 72324afcffef..e7315d487163 100644
>> --- a/kernel/audit_tree.c
>> +++ b/kernel/audit_tree.c
>> @@ -94,7 +94,7 @@ static struct audit_tree *alloc_tree(const char *s)
>>   {
>>   	struct audit_tree *tree;
>>   
>> -	tree = kmalloc(sizeof(struct audit_tree) + strlen(s) + 1, GFP_KERNEL);
>> +	tree = kmalloc(struct_size(tree, pathname, strlen(s) + 1), GFP_KERNEL);
>>   	if (tree) {
>>   		refcount_set(&tree->count, 1);
>>   		tree->goner = 0;
>> diff --git a/kernel/auditfilter.c b/kernel/auditfilter.c
>> index 4173e771650c..42d99896e7a6 100644
>> --- a/kernel/auditfilter.c
>> +++ b/kernel/auditfilter.c
>> @@ -637,7 +637,7 @@ static struct audit_rule_data *audit_krule_to_data(struct audit_krule *krule)
>>   	void *bufp;
>>   	int i;
>>   
>> -	data = kmalloc(sizeof(*data) + krule->buflen, GFP_KERNEL);
>> +	data = kmalloc(struct_size(data, buf, krule->buflen), GFP_KERNEL);
>>   	if (unlikely(!data))
>>   		return NULL;
>>   	memset(data, 0, sizeof(*data));
>> @@ -1092,7 +1092,7 @@ static void audit_list_rules(int seq, struct sk_buff_head *q)
>>   				break;
>>   			skb = audit_make_reply(seq, AUDIT_LIST_RULES, 0, 1,
>>   					       data,
>> -					       sizeof(*data) + data->buflen);
>> +					       struct_size(data, buf, data->buflen));
>>   			if (skb)
>>   				skb_queue_tail(q, skb);
>>   			kfree(data);
>> -- 
>> 2.17.1
>>
> .
