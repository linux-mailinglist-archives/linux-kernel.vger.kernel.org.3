Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 179C550874C
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378138AbiDTLt2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:49:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243482AbiDTLtZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A81C841604
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:46:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650455198;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QjJ7W2VWOdduuBY4m9CKgE899vRh3ylPTanzkeBGjMc=;
        b=jQCgbEQ4frdQI6Q7ctDkKtaLLpAjO+XlSxhD9iCFFStu+Z0Bd8TxvGdLL72Qcc/jIO1e6w
        xY/bm+sd9bS7/mfgfmDg4l4rL2o88avH8M30dkS+t6IdiQ2Bkc37PMjtUIoPVjaA9Mr6Gf
        kNi0Lyaesro1yMqjHB53WJawtY/IHBs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-363-pa8WxfzPPsqKgBuTFM7_ag-1; Wed, 20 Apr 2022 07:46:37 -0400
X-MC-Unique: pa8WxfzPPsqKgBuTFM7_ag-1
Received: by mail-wr1-f72.google.com with SMTP id n17-20020adfc611000000b0020a7e397ccaso318421wrg.23
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:46:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=QjJ7W2VWOdduuBY4m9CKgE899vRh3ylPTanzkeBGjMc=;
        b=4ow2gs8SGAh26Un953CXDiwIEVKtqGsHwyBZDALR64d9ffaJkjrDn968KPY050HV5d
         ElDWmMi5eiJgVwfuB8XxeB5BtjpyWx3RKI+U6oOqIyNDrhw5Zy8QAc9JZEYSmrmcalIC
         8cKb/mt4Y3bKLv3tmq9SO9uDWtI6bUeZJyyshyWm0562eEyccg8PbWdIsJ/XNkY48CjK
         PFK8CtF8GjevK81CHm7lg72ZVEBSyKdPXoTpgSHP3Bai6ri4xil8mqsIHjD7CUchXaDy
         QzjthjMRNwbJ5OzLpKw+nPIlkDTsLVhiCEXvNgNLz4kvcz4C2BQ7jqo6hGDfhbfH/Z/Q
         ALIQ==
X-Gm-Message-State: AOAM532MxIveoxzXOBkrAhNmzOtzcV8NmMSV+yN62AFAk+fFY3xEQIb0
        chLgMro0Uvx9L3x7qMJsVDwelRWposc7aSx5+ezOdRnTI3WouT53A0gBDttVvrHXyc+D2qqPD0b
        5b+Agn7FZpBIPO5U1+5OAU2uH
X-Received: by 2002:a7b:c394:0:b0:38e:b415:96af with SMTP id s20-20020a7bc394000000b0038eb41596afmr3275029wmj.68.1650455196358;
        Wed, 20 Apr 2022 04:46:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx2+4RvHcOr8kj3JC0i5jL5q7qHBvnI4Ln88+TPK0r7DrGphgB2Y1AKjG+BfGM8t7M0vvURqg==
X-Received: by 2002:a7b:c394:0:b0:38e:b415:96af with SMTP id s20-20020a7bc394000000b0038eb41596afmr3275004wmj.68.1650455196098;
        Wed, 20 Apr 2022 04:46:36 -0700 (PDT)
Received: from [192.168.8.102] (dynamic-046-114-174-058.46.114.pool.telefonica.de. [46.114.174.58])
        by smtp.gmail.com with ESMTPSA id l9-20020a1c7909000000b0038eb8171fa5sm18216643wme.1.2022.04.20.04.46.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 20 Apr 2022 04:46:35 -0700 (PDT)
Message-ID: <f3989523-bed1-d9d4-2007-19de8ba4d403@redhat.com>
Date:   Wed, 20 Apr 2022 13:46:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH v2 3/4] KVM: s390: selftests: Use TAP interface in the
 tprot test
Content-Language: en-US
To:     Janis Schoetterl-Glausch <scgl@linux.ibm.com>, kvm@vger.kernel.org,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        David Hildenbrand <david@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Shuah Khan <shuah@kernel.org>, linux-s390@vger.kernel.org
References: <20220419185857.128351-1-thuth@redhat.com>
 <20220419185857.128351-4-thuth@redhat.com>
 <267dc999-edc6-c8fc-b177-e06fb2d259b4@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
In-Reply-To: <267dc999-edc6-c8fc-b177-e06fb2d259b4@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/04/2022 13.38, Janis Schoetterl-Glausch wrote:
> On 4/19/22 20:58, Thomas Huth wrote:
>> The tprot test currently does not have any output (unless one of
>> the TEST_ASSERT statement fails), so it's hard to say for a user
>> whether a certain new sub-test has been included in the binary or
>> not. Let's make this a little bit more user-friendly and include
>> some TAP output via the kselftests.h interface.
>>
>> Signed-off-by: Thomas Huth <thuth@redhat.com>
>> ---
>>   tools/testing/selftests/kvm/s390x/tprot.c | 28 +++++++++++++++++++----
>>   1 file changed, 23 insertions(+), 5 deletions(-)
>>
>> diff --git a/tools/testing/selftests/kvm/s390x/tprot.c b/tools/testing/selftests/kvm/s390x/tprot.c
>> index c097b9db495e..baba883d7a6d 100644
>> --- a/tools/testing/selftests/kvm/s390x/tprot.c
>> +++ b/tools/testing/selftests/kvm/s390x/tprot.c
> 
> We're not committing ourselves to any particular test output, are we?
> Your patch considers the stages used for test setup tests themselves,
> which I'm fine with, but would not want to commit to keeping that way forever.

No commitment - just somewhat more verbose output. If you don't like it, we 
can also drop this patch, or do it in another way, I don't mind too much.

>> +#define HOST_SYNC(vmp, stage)			\
>> +{						\
>> +	HOST_SYNC_NO_TAP(vmp, stage);		\
>> +	ksft_test_result_pass("" #stage "\n");	\
>> +}
>> +
> 
> It should not be a problem, but is there any reason you're not using
> do { ... } while(0) or ({ ... }) instead of just braces?

Yes, that would be better, indeed.

  Thomas

