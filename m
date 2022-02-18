Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B2C4BBE3C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 18:19:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238225AbiBRRS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 12:18:56 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238570AbiBRRSp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 12:18:45 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CEEA65D1AB
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:17:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645204675;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7dZcSV2Uv5l2PGNp5lATuM06Bp3rDpiylATyLlFeY84=;
        b=IIA4/RZNWcLcz/+Yc2+bl8SIqI0+UIbtu4WuvyN9Ag55jkAn2TxtPnYoL7rHbZTP+G5YkH
        o+XJvS6hDOVJZFEGI1X+ObG99x1DjvzEGDxBYWTcwfBpACcIvKGXp6tZo5awVjRAbouopW
        7anPoi2k9svb7XyKZh3+h8xaEe51jWU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-552-gzjJMq4vNpamBWwmLVqlVA-1; Fri, 18 Feb 2022 12:17:53 -0500
X-MC-Unique: gzjJMq4vNpamBWwmLVqlVA-1
Received: by mail-wm1-f70.google.com with SMTP id p24-20020a05600c1d9800b0037be98d03a1so6229087wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 09:17:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7dZcSV2Uv5l2PGNp5lATuM06Bp3rDpiylATyLlFeY84=;
        b=4WakLS0jl2J1KW6AIX4a8Ort1ajf5G6WfFB9NQlnV86AnvipHZizEN49rJzGV/O0Vx
         f7MXDrIQf5nH50c/o0bgaEsOyhBF2L3hiIGG2Unn20enfHnwmCpo/evV3N53rkQ+T/Bu
         5JaMTxdASJmRwKZpGFBkz13UESFcho9q7zswrgoP/CFvcNYQGi6qLjS0ijq18nf2En5x
         udDjsj9ueTz4D8wBJheV5FY1W12DrEf++g2CG4L386g5rEeo6LHvh43Wu3eSH/a1udW7
         Mz7vj9qMcfzvdRSbu87lWoz2d2cl/Nok+nVH4JxpdQyXQ0Yw8Apu/BF6ZavHYvqEwmIf
         /imw==
X-Gm-Message-State: AOAM530aLvmIQUJSUbi7V7p1X+de+ka+0XxzvWJz3Sswwr7MTYY2o7ic
        f4fQTITIHYbvn9BAKRAGeuDuhBNnVFrkkfSizH1RR/1eW7M5Nw2MRwcKNzRV2garyi0bbzaJdE5
        1xQyigCNcGW66XsbxH71cDa0U
X-Received: by 2002:a05:6000:18c8:b0:1e4:b8f4:da8f with SMTP id w8-20020a05600018c800b001e4b8f4da8fmr6969524wrq.199.1645204671852;
        Fri, 18 Feb 2022 09:17:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyY5FTYmJEwXfkrd2Ezeeyz/sLJDt8iOSxwKTt+YEJIOAC62rZBIt4qJftKdXphpHZFmYhoGg==
X-Received: by 2002:a05:6000:18c8:b0:1e4:b8f4:da8f with SMTP id w8-20020a05600018c800b001e4b8f4da8fmr6969512wrq.199.1645204671607;
        Fri, 18 Feb 2022 09:17:51 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id n15sm13833015wri.33.2022.02.18.09.17.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Feb 2022 09:17:50 -0800 (PST)
Message-ID: <eff2543a-10ab-611a-28e2-18999d21ddd8@redhat.com>
Date:   Fri, 18 Feb 2022 18:17:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 5/6] KVM: x86: make several AVIC callbacks optional
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
References: <20220217180831.288210-1-pbonzini@redhat.com>
 <20220217180831.288210-6-pbonzini@redhat.com> <Yg/IGUFqqS2r98II@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yg/IGUFqqS2r98II@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/18/22 17:23, Sean Christopherson wrote:
> The "AVIC" callbacks are being deleted, not
> made optional, it's kvm_x86_ops' APICv hooks that are becoming optional.

Maybe "make several APIC virtualization callbacks optional".

>> +KVM_X86_OP_OPTIONAL(apicv_post_state_restore)
>
> apicv_post_state_restore() isn't conditional, it's implemented and wired up
> unconditionally by both VMX and SVM.

True, on the other hand there's no reason why a hypothetical third 
vendor would have to support it.  The call is conditional to 
apicv_active being true.

Paolo

