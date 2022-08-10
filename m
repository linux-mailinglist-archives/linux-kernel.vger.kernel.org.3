Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E22858E497
	for <lists+linux-kernel@lfdr.de>; Wed, 10 Aug 2022 03:38:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230110AbiHJBhq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 Aug 2022 21:37:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiHJBhH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Aug 2022 21:37:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BFB5061B05
        for <linux-kernel@vger.kernel.org>; Tue,  9 Aug 2022 18:37:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660095424;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fDv7Pkf2Mty62Q47m8/QIRgG7qucyNEE5ltfwkyv+3E=;
        b=GOQiluKqUrTP6cqp/eEWH8ExkThJkgjx0qWlWSLGe7J559CixyZMMdmC7uBuBUBftgUGNz
        EolQMu/tNlYZg3lJuwUMI2LGnEevizkpEW4oO2lmhpHx/Qqbm0tUzYCX5plHSvTYI739Jg
        QgkMo3Gs8VVkaFfehJzROrfN9XzygIg=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-383-43pIiNFQPjq97qJMTTPtxA-1; Tue, 09 Aug 2022 21:37:03 -0400
X-MC-Unique: 43pIiNFQPjq97qJMTTPtxA-1
Received: by mail-qk1-f200.google.com with SMTP id bs33-20020a05620a472100b006b97dc17ab4so2534643qkb.6
        for <linux-kernel@vger.kernel.org>; Tue, 09 Aug 2022 18:37:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=fDv7Pkf2Mty62Q47m8/QIRgG7qucyNEE5ltfwkyv+3E=;
        b=Sx4NMLoVTGgfbFyvhPRy2PdxAV8CKvhljwWU5IQb0IubBF6BesHpK5z+3Vd2FKHbKB
         vJ3o2CqwdjIgCQX+UGq8HkwaQ7wd4IYH54DTXqZaiZ1NiO2Voogp8yo3cEunBLuWr21g
         FhfqH1KSHepauiQ7e9u6GE+g7Fm/eXYcHn+LaBRWF8V3Yj0+0KyFQ0MtKazBMPGWC0Tt
         F9rBctHCtDtiavbsX6U6c0iX7qxV8aUKSo99vucNwTDDpGY1WJJtcmfd0VHkjjwAzy2C
         9sBZtYjsbOa3IQdUGNnhDTZ2lE8CNIy6yqTm96l1TjsDZeXH7e4lAD8lrmZvqytZ9l4b
         udcA==
X-Gm-Message-State: ACgBeo2QYiPwZ7/MiO47uox7HmtxfPyyATmN1rODAZGZoURzVEspqqUF
        s6y+rqz+cNJVZ7U9+CwHFl0FXDjHzOr7WcfktAQvEHl3V44lAxmueolPJQsExrIT2iwrcOpJ8bb
        f29jaebBoLgtSTU/vu9DlvKXe
X-Received: by 2002:a05:622a:5c7:b0:320:f913:76a0 with SMTP id d7-20020a05622a05c700b00320f91376a0mr22413531qtb.115.1660095423167;
        Tue, 09 Aug 2022 18:37:03 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6Wv3i51PLvqvZIGParL/hMF7UGnnqIvKrsgzpUw+f5GPmER0Nz9G4myzKTTrm6eQxhSVqMsQ==
X-Received: by 2002:a05:622a:5c7:b0:320:f913:76a0 with SMTP id d7-20020a05622a05c700b00320f91376a0mr22413520qtb.115.1660095422933;
        Tue, 09 Aug 2022 18:37:02 -0700 (PDT)
Received: from [192.168.98.18] ([107.12.98.143])
        by smtp.gmail.com with ESMTPSA id e123-20020a376981000000b006b5f68bc106sm11767006qkc.110.2022.08.09.18.37.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Aug 2022 18:37:02 -0700 (PDT)
Message-ID: <0ec636c5-0162-c208-5c53-22f2ce53ea91@redhat.com>
Date:   Tue, 9 Aug 2022 21:37:01 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [RFC net] bonding: 802.3ad: fix no transmission of LACPDUs
Content-Language: en-US
To:     Hangbin Liu <liuhangbin@gmail.com>
Cc:     netdev@vger.kernel.org, Jay Vosburgh <j.vosburgh@gmail.com>,
        Veaceslav Falico <vfalico@gmail.com>,
        Andy Gospodarek <andy@greyhouse.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Shuah Khan <shuah@kernel.org>,
        linux-kernel@vger.kernel.org, linux-kselftest@vger.kernel.org
References: <c2f698e6f73e6e78232ab4ded065c3828d245dbd.1660065706.git.jtoppins@redhat.com>
 <YvMJYb0VDJW+6CRh@Laptop-X1>
From:   Jonathan Toppins <jtoppins@redhat.com>
In-Reply-To: <YvMJYb0VDJW+6CRh@Laptop-X1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/9/22 21:26, Hangbin Liu wrote:
> On Tue, Aug 09, 2022 at 01:21:46PM -0400, Jonathan Toppins wrote:
>> ---
>>   MAINTAINERS                                   |  1 +
>>   drivers/net/bonding/bond_3ad.c                |  2 +-
>>   .../net/bonding/bond-break-lacpdu-tx.sh       | 88 +++++++++++++++++++
> 
> Hi Jon,
> 
> You need a Makefile in this folder and set TEST_PROGS so we can generate the
> test in kselftest-list.txt.
> 

Thank you. I have a v2 coming. I also broke up the fix from the test 
that way it is simpler to backport.

-Jon

