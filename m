Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE1FB5017BA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359509AbiDNPpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 11:45:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350546AbiDNP23 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:28:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E034E2DD3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:09:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649948969;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xPC1Y2muJZRmIAmU2vFNWQJ1nI7VdYew8mF3Uluw4dw=;
        b=YRykr0YPWSrNYZ3Q/0wQ+rVfLqZbjWOSkOqwBHUGK69xiW9PpEstdffTbVWJSMyZ6YHkO0
        5nmTESufHpV5SVXld22HRWzDRnd2pg5guAco+ZdxhmWExK8s5p11etiZYsCfLpQBfgLh34
        UMgXwLtqamECb07e5fYhMeU91zqcLvU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-zkK8BIx5PaGreAmL0OCv1Q-1; Thu, 14 Apr 2022 11:09:28 -0400
X-MC-Unique: zkK8BIx5PaGreAmL0OCv1Q-1
Received: by mail-wr1-f69.google.com with SMTP id i64-20020adf90c6000000b00203f2b5e090so878624wri.9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:09:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=xPC1Y2muJZRmIAmU2vFNWQJ1nI7VdYew8mF3Uluw4dw=;
        b=dgN2E0Z1CGElWsB5Pq3o7MdAFTQCMhL/IW078hKjpN+FJ1nRlYU6wNVxh+LOZ0RqTu
         uFZ+w2fLZaaEQpqFu187wUc/jkenYuhcVe1YHAMsjGtbW44ObSbZoqy2gziS1C+EqFuy
         /qRKY2RvvZXnjPxgeSs+DtKJSo8bFvurtySrBpeuA9iZU7XS9u5IxInkE9Y57lTRJchI
         dxx48WwkdnCMD99+IECjGZI3qUoWJlePakVzOKrN2Tf3yY/NZgYFXmkeumjvWg2QN7W6
         cAh8eUiikNVs7+YLkpwZ3/9j8glCpDJSsdWHQMf2dDmcifSOr+9BFoyhTZ5B1FC97ILY
         W0Gg==
X-Gm-Message-State: AOAM530nHIQG6woeVPesfPuD108T5/dXQIuG9OQ/z8o9FVe2hri0rCFS
        +rxUc/P1ygMiygVfY2ZSr+ImrMX9mi3pxDOs+vq9n+Ej8rafYYf2Y4Xo/qymAdvPvve/6eLCFeh
        zk14mf05ONhGURV5gRUjbWXXe
X-Received: by 2002:a05:600c:4e8b:b0:38c:90cf:1158 with SMTP id f11-20020a05600c4e8b00b0038c90cf1158mr4095895wmq.107.1649948967321;
        Thu, 14 Apr 2022 08:09:27 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8bw6bCudEh07zRGiT3FUd7Y1RFhksv7ICEXTx+ik3SJbSbdOfPUPm4HcCtqPBbR6/zoS29g==
X-Received: by 2002:a05:600c:4e8b:b0:38c:90cf:1158 with SMTP id f11-20020a05600c4e8b00b0038c90cf1158mr4095873wmq.107.1649948967044;
        Thu, 14 Apr 2022 08:09:27 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id m3-20020a5d6243000000b001e33760776fsm2001356wrv.10.2022.04.14.08.09.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:09:26 -0700 (PDT)
Message-ID: <bf10e7c9-0654-1608-1085-0e8359aaa391@redhat.com>
Date:   Thu, 14 Apr 2022 17:09:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v3 00/22] https://www.spinics.net/lists/kvm/msg267878.html
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220414074000.31438-1-pbonzini@redhat.com>
 <2939c0cb-8e0c-7de4-7143-2df303bbb542@redhat.com>
 <Ylg3m4qZ23wO+5oo@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Ylg3m4qZ23wO+5oo@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 17:02, Sean Christopherson wrote:
>> Uh-oh, wrong subject.  Should be "KVM MMU refactoring part 2: role changes".
>>
>> Supersedes:<20220221162243.683208-1-pbonzini@redhat.com>
>
> Still Spinics huh?  I thought you were using b4 these days?:-)

I use Patchew for tracking and either b4 or Patchew for application, but 
sometimes a certain search engine has different preferences.

Paolo

> KVM Forum 2019 - Reports of my Bloat Have Been Greatly Exaggerated - Paolo Bonzini, Red Hat, Inc.
> 
> KVM Forum 2022 - Reports of my Fossilization Have Been Greatly Understated - Paolo Bonzini, Red Hat, Inc.
> 

