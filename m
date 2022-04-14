Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219A3501772
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 17:59:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245327AbiDNPij (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350516AbiDNOW0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 10:22:26 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D4FA81C129
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:14:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649945667;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uR52VEUgdLuIE+LY3/QpjNTmgRHtWU8OzOHA0XF4HA0=;
        b=T1jTixnol/svmA3W+ew5lE5MBEJ6NT4DZ2jaB9xUJKoxbG0kNIYyFokPxlN1qykF4BKPpz
        jQKOqaMIY/Q54l6a6CgcAZw/DL/VJOU8j5SkRRZenBIHbbMXQYjSb+YRRRIframkt1QRhl
        DkGC0JbDNYwxud4z02uzQwvkUaGAT5A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-161-ZGt1r2j7MzGBfqnNSL-HNQ-1; Thu, 14 Apr 2022 10:14:25 -0400
X-MC-Unique: ZGt1r2j7MzGBfqnNSL-HNQ-1
Received: by mail-ed1-f70.google.com with SMTP id i4-20020aa7c9c4000000b00419c542270dso3123294edt.8
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 07:14:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=uR52VEUgdLuIE+LY3/QpjNTmgRHtWU8OzOHA0XF4HA0=;
        b=XeLosUdYNTcBd5buBVHCjI/p1Y1CPTOEdecXiDCBYhc/rfdKrxcaoWb2SDR8tCNlH7
         XwrLnmzdm2TQIioeIncDgsqv9z32narCmgvWPRjByGY7qaDw/dQ+12G6XbWC9DzGsYQk
         Fi1oiKeaH48+39RQi4/dWYVq5zO8TyLn408zcAwFs6dkfpFVyIEfsWBinHkgKg0SLKez
         Kp53UGy2iamxhAgrQJQ3WDTZhtwHUEM2QZ1FeE1ENrUtFMVq1JDsYzEQ2bBi5wwZ0uTe
         6RXS9R5oy5oYAm575u5Uz8htpDOJeLchAH2wH5dfeRSCzee8OeVPBXFLJVo3Bhw4q/co
         ZITw==
X-Gm-Message-State: AOAM53306x5nFL9Jg/5CkN4bhRskhpz+SoT0Rq5gIv9t0f1gSMdJ1j+z
        OcDo0Ya/L7Pos/yU2WrkMapz3TG0LUDViv/l40KXPVLQyVySkuQCsPl5JKCV76gAhNYFqGJ6JHu
        3IYi6SiLfgoN+6oYNtzFtLuvE
X-Received: by 2002:a17:907:60d4:b0:6e8:7121:3c80 with SMTP id hv20-20020a17090760d400b006e871213c80mr2524220ejc.352.1649945664680;
        Thu, 14 Apr 2022 07:14:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxgVLYzoVDiUfeqSoyRwO1FqdqEBRnjqijOHeNVeW+ly2ZzZPVOmYJjIYonFaZCShzsE51Lfg==
X-Received: by 2002:a17:907:60d4:b0:6e8:7121:3c80 with SMTP id hv20-20020a17090760d400b006e871213c80mr2524198ejc.352.1649945664413;
        Thu, 14 Apr 2022 07:14:24 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id o17-20020a056402439100b0041938757232sm1125687edc.17.2022.04.14.07.14.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 07:14:23 -0700 (PDT)
Message-ID: <bf15209d-2c50-9957-af24-c4f428f213b1@redhat.com>
Date:   Thu, 14 Apr 2022 16:14:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH] kvm: selftests: Fix cut-off of addr_gva2gpa lookup
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>,
        Peter Xu <peterx@redhat.com>
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Andrew Jones <drjones@redhat.com>
References: <20220414010703.72683-1-peterx@redhat.com>
 <Ylgn/Jw+FMIFqqc0@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ylgn/Jw+FMIFqqc0@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 15:56, Sean Christopherson wrote:
>> -	return (pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
>> +	return ((vm_paddr_t)pte[index[0]].pfn * vm->page_size) + (gva & 0xfffu);
> This is but one of many paths that can get burned by pfn being 40 bits.  The
> most backport friendly fix is probably to add a pfn=>gpa helper and use that to
> place the myriad "pfn * vm->page_size" instances.
> 
> For a true long term solution, my vote is to do away with the bit field struct
> and use #define'd masks and whatnot.

Yes, bitfields larger than 32 bits are a mess.

Paolo

