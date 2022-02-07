Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B48D4AC101
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 15:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1391200AbiBGOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 09:19:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1389029AbiBGNvD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 08:51:03 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7CA92C0401C0
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 05:51:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644241861;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=msKQIf5m3RNJ8ndoRLO0bGCg3f8WFhwpKNN7KVs8sjk=;
        b=H/BBLsEau9tMutIpd1EYmv++jkFa+p+tgr3Z45IWnJfLf25I0xbVtge+GiGUrXmM2LFBOZ
        kFwNwgubg5up33J6nEuJB+PC0EF3+QnjrsFIgL/J8pKRf1C0IvLDWoXxDEyZv5rx1+R7C5
        eFcaNzecQCap7jwm5Q+eWGXnuNEvzMU=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-611-y9qTajqZOvKmpr-7Y9xD7A-1; Mon, 07 Feb 2022 08:51:00 -0500
X-MC-Unique: y9qTajqZOvKmpr-7Y9xD7A-1
Received: by mail-ej1-f71.google.com with SMTP id o7-20020a170906860700b006cbe6deec1bso649761ejx.22
        for <linux-kernel@vger.kernel.org>; Mon, 07 Feb 2022 05:51:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=msKQIf5m3RNJ8ndoRLO0bGCg3f8WFhwpKNN7KVs8sjk=;
        b=yLjjsnhYwBwOZ+RFThPdcQl+nMQHsnUVx0EMNS8vyyOGI8K7bhybUQI+TrudmC/GMu
         8SCkMpnSI93YdT/pf2S9Gn4DOYNXB1ndhVZGYv/QwKdP8cudrB4jUtOXQv1RabmPRCXD
         J3BYaJQkGFMI6hirSSoMiRMI1CQqPQn1N0R4gAWK/D0tCmAPyXak92pr7LKk+5W6DiKd
         ONQ2ooPnYMn4D0H/066uz+5U5m3nOMKyRXtwMlxOwdrzqtMitnLNQrqDbJlhPRbiVQZn
         eg8rUxkzry0Mtwx8c4Y/5fhTACWR4tGeJCZ6KJGb1Ylv5nQvwfr1eay1xt+kyueliZWq
         5c2g==
X-Gm-Message-State: AOAM533CiUMRSZWAZPh2wCQBx0HJM0X4HYLk4egH5RzLLqV2Et5rXyED
        KehN+ef74EZ0FXigRCg9ymIeay371YdNxMImYwActM5SKfrV4i4jBYwLpoPvZHKhv4a0yS2Pc4y
        wnqoVq1KR5PyXA/ndruHVLC1m
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr9943362ejc.648.1644241859351;
        Mon, 07 Feb 2022 05:50:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyy7q7L46GUgvrZDsUs7fcdkR+jHAnTyhwBqS2NTRUYS3qbGsv1f/ky1Xjl5fOHHMMPa2/MXg==
X-Received: by 2002:a17:907:e9e:: with SMTP id ho30mr9943343ejc.648.1644241859035;
        Mon, 07 Feb 2022 05:50:59 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:c8dd:75d4:99ab:290a? ([2001:b07:6468:f312:c8dd:75d4:99ab:290a])
        by smtp.googlemail.com with ESMTPSA id qh12sm225724ejb.172.2022.02.07.05.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Feb 2022 05:50:58 -0800 (PST)
Message-ID: <180d7f0f-8c58-2a52-02a7-bd014d81d7a3@redhat.com>
Date:   Mon, 7 Feb 2022 14:50:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 06/23] KVM: MMU: load new PGD once nested two-dimensional
 paging is initialized
Content-Language: en-US
To:     David Matlack <dmatlack@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        seanjc@google.com, vkuznets@redhat.com
References: <20220204115718.14934-1-pbonzini@redhat.com>
 <20220204115718.14934-7-pbonzini@redhat.com> <Yf178LYEY4pFJcLc@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yf178LYEY4pFJcLc@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/4/22 20:18, David Matlack wrote:
> On Fri, Feb 04, 2022 at 06:57:01AM -0500, Paolo Bonzini wrote:
>> __kvm_mmu_new_pgd looks at the MMU's root_level and shadow_root_level
>> via fast_pgd_switch.
> Those checks are just for performance correct (to skip iterating through
> the list of roots)?
> 
> Either way, it's probably worth including a Fixes tag below.
> 

There's no bug because __kvm_mmu_new_pgd is passed a correct new_role. 
But it's unnecessarily complex as shown by patches 7 and 9.

Paolo

