Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287DB51698D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:06:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355501AbiEBDJ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353074AbiEBDJY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:09:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D40AD289B0
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 20:05:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651460757;
        h=from:from:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qfBorVSUOCzQ7q3zYlG2+R/WTZRAKdQmUnILyiogGHk=;
        b=NAeQFv+IfNNSvZJGgfPIMll9eTaD1EXOwPJgfND3gjqUS6hrblD2YQhn2jnf4BZJH61gwY
        th51CNdP5FzrxnqOEFW6Ww3Io4SawfMasbyFhIq9L3BSefvDJk9Tm9sKfWL3VDUbrlF7E0
        I2kgfsopk95PgZw/wknwknjp77oKzSk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-43-6GRA4kaIMLWNyA4Yy77asw-1; Sun, 01 May 2022 23:05:51 -0400
X-MC-Unique: 6GRA4kaIMLWNyA4Yy77asw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 38EA61E13783;
        Mon,  2 May 2022 03:05:51 +0000 (UTC)
Received: from [10.72.12.86] (ovpn-12-86.pek2.redhat.com [10.72.12.86])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 44B7040869CB;
        Mon,  2 May 2022 03:05:44 +0000 (UTC)
Reply-To: Gavin Shan <gshan@redhat.com>
Subject: Re: [PATCH v6 15/18] KVM: arm64: Support SDEI_FEATURES hypercall
To:     Oliver Upton <oupton@google.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-16-gshan@redhat.com> <Ym4uyaGGhPXlnkHQ@google.com>
From:   Gavin Shan <gshan@redhat.com>
Message-ID: <9a522677-cfee-5a72-af27-8a401546ad14@redhat.com>
Date:   Mon, 2 May 2022 11:05:42 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <Ym4uyaGGhPXlnkHQ@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.1
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Oliver,

On 5/1/22 2:55 PM, Oliver Upton wrote:
> On Sun, Apr 03, 2022 at 11:39:08PM +0800, Gavin Shan wrote:
>> This supports SDEI_FEATURES hypercall. It's used by guest to
>> retrieve the supported features, which are number of slots for
>> the interrupt binding events and relative mode for the event
>> handler. Currently, none of them is supported.
>>
>> Signed-off-by: Gavin Shan <gshan@redhat.com>
>> ---
>>   arch/arm64/kvm/sdei.c | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/arm64/kvm/sdei.c b/arch/arm64/kvm/sdei.c
>> index e1f6ab9800ee..ab0b7b5e3191 100644
>> --- a/arch/arm64/kvm/sdei.c
>> +++ b/arch/arm64/kvm/sdei.c
>> @@ -527,6 +527,23 @@ static unsigned long hypercall_reset(struct kvm_vcpu *vcpu, bool private)
>>   	return ret;
>>   }
>>   
>> +static unsigned long hypercall_features(struct kvm_vcpu *vcpu)
>> +{
>> +	unsigned long feature = smccc_get_arg(vcpu, 1);
>> +	unsigned long ret;
>> +
>> +	switch (feature) {
>> +	case 0: /* BIND_SLOTS */
>> +	case 1: /* RELATIVE_MODE */
> 
> Can you create macros for these?
> 

Surely I will do. Thanks for your review and comments :)

Thanks,
Gavin

