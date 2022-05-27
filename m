Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52169535D8E
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 11:44:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350668AbiE0Jod (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 05:44:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233004AbiE0Joa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 05:44:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B9715F6892
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653644668;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CyHN16US1gOOvkQvNTRd1rg4BKz//ilGPdW5uJvWU+A=;
        b=hQX2eEh8yBtD2/D85d0kZpWkJO93KuoJUyN+dEoCuDEXklCPtRGkDEorOC+XlHx7OYbIpE
        wyxllS0pgmLg4WsvJ6ympt5MHPOeDtAFRTiakRUJR7lrcklMbimHNcSBvNyzw7MDSspn2y
        fmzpwqMqguTSyf0uNNMEQ0LTz+z3yj0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-532-kBpc_VuXNiSeHGV3IecZpQ-1; Fri, 27 May 2022 05:44:27 -0400
X-MC-Unique: kBpc_VuXNiSeHGV3IecZpQ-1
Received: by mail-wr1-f70.google.com with SMTP id n13-20020a5d67cd000000b0021003b039e0so699200wrw.12
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 02:44:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=CyHN16US1gOOvkQvNTRd1rg4BKz//ilGPdW5uJvWU+A=;
        b=LDXvN6BBt9b+m5v3mcnjsxqsTttoWqEbef0sm3F3pCAsBDkNWOySOS9u4+jwxt9XeL
         hx5VPLl85EW/kssaQoti2weNSK2IDYB7spGU4IvfrOmTtNnEEC0sYfGeYIQ822est7pq
         1Bl6OfAeKEt7+QYZtZfSGzN3XQQ9B9wi/CHtU4zZqW3MPM0E9c8Tpg4/2nx76cULt+3T
         tagQua4pt+jGU3OLx4JdHJQgzXpt5wuop2PDXv4tCq2uGU/rc6A2lTUzJzrP25VT9ffV
         WIHAdXEinq09afQorcsrjRObDxsbOkCZNfQbb3BTDPzFzAGCdLVt+WYP+2IPEc9FF603
         5wHQ==
X-Gm-Message-State: AOAM531VIZwYttApdWj59vvbKRTtokzCypqnxFuXg08UbKomJKs9am0N
        XFX8T8BQMbOPlGvrjrCK6ofIE25WU6UPl953TLvpkmOXvAwNcJY20/No4NhUq309xEe5eZ8OHaL
        QhihIPAWP+5Zq+HtE/XS4SQB+
X-Received: by 2002:a5d:47a7:0:b0:20f:f216:bc81 with SMTP id 7-20020a5d47a7000000b0020ff216bc81mr13931978wrb.56.1653644666114;
        Fri, 27 May 2022 02:44:26 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxdWm2UQJhUeUPnBRWhvnzcZTyb9BIA/EIMgGo6ATGOZHv9VC8ScWm7IHBya7VsquyWgt/O7A==
X-Received: by 2002:a5d:47a7:0:b0:20f:f216:bc81 with SMTP id 7-20020a5d47a7000000b0020ff216bc81mr13931961wrb.56.1653644665775;
        Fri, 27 May 2022 02:44:25 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:e3ec:5559:7c5c:1928? ([2001:b07:6468:f312:e3ec:5559:7c5c:1928])
        by smtp.googlemail.com with ESMTPSA id x15-20020a1c7c0f000000b0039756cdc8e1sm1573927wmc.37.2022.05.27.02.44.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 May 2022 02:44:25 -0700 (PDT)
Message-ID: <97b4d324-9f74-0490-5d6c-c5b40acfc457@redhat.com>
Date:   Fri, 27 May 2022 11:44:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 1/2] KVM: VMX: Sanitize VM-Entry/VM-Exit control pairs at
 kvm_intel load time
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Lei Wang <lei4.wang@intel.com>
References: <20220525210447.2758436-1-seanjc@google.com>
 <20220525210447.2758436-2-seanjc@google.com>
 <8baca98e-63d6-f7dd-067b-05f8e0dc381f@redhat.com>
 <Yo/yhiVl++FTSa3S@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yo/yhiVl++FTSa3S@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/22 23:35, Sean Christopherson wrote:
> It's not for clarity, it's to prevent plopping an EXIT control into the ENTRY
> slot and vice versa.  I have a hell of a time trying to visually differentiate
> those, and a buggy pair isn't guaranteed to be detected at runtime, e.g. if both
> are swapped, all bets are off, and if one is duplicated, odds the warn may or may
> not show up unless hardware actually supports at least one of the controls, if not
> both.

Make the lines longer than 80 characters and align each element so that 
you have a line of VM_ENTRY_ and VM_EXIT_.  (It would not work if they 
were the same length, but they aren't).

Paolo

