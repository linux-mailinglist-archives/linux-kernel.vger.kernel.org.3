Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 311604CAC6F
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 18:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231251AbiCBRtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 12:49:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229556AbiCBRtQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 12:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93BCB220D3
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 09:48:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646243312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ish057kHJjR2Es3o2X8vkZcDc0WMwyYLfwxQbeB+OyA=;
        b=ImDlJoPOtqovLFnHqnimP+6BB1odVbUHYf89A8qLVhNKNRx5qxM93pmelgsUozFHYwyj0+
        pjqbomGdKZh6lBKkcuek5L5MQBbj2+ZZutdudwmYVyymNl4Jbwx2kYshaug15HAuvMb+xw
        PmI7MbTvOQdPq3P9GfBfBAmPGTM9GfM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-382-fRZH69syPpGlhEzkN1kqlw-1; Wed, 02 Mar 2022 12:48:31 -0500
X-MC-Unique: fRZH69syPpGlhEzkN1kqlw-1
Received: by mail-wm1-f69.google.com with SMTP id s129-20020a1ca987000000b0038707017dd7so92428wme.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 09:48:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Ish057kHJjR2Es3o2X8vkZcDc0WMwyYLfwxQbeB+OyA=;
        b=nA7SRZeNlWJLBjKkLpWpp88EvB9e4xTZsqu0TUf70xeMUqCzYNvqxy+FGM+p+dAVdh
         pqZop5XV+GocxT/nc7Wfh1oYGKjD8IQq5FaPopDtkT9Jb0PEp+ei/3iCR9H6WDlWWCyL
         Bz6okDjcb0yAUNKUO7L1VE7FsCe79zVjpvGDGl0aXGn0aZ+kaEuhq1bvfElRqEzDZQNI
         q+U70pTcIF5ar9H0Fm+MVmOeG1jzqVVnXbn6LF02cUQz/XX7JAZxEY43j+AlwvLdR7yG
         citsl3pze+Vq6IGVy0XjLlxbe/ymxjMAXLPYrQNzAFWW9+Vv09DGwTL4aTEc4rBqifhk
         95Ow==
X-Gm-Message-State: AOAM533CJbucuLiKU7yXcKGWCIlFNf+ydVIhjlLzyKnd/DuueQPldAUZ
        lJIgdOyF9Opw6+x2jCHcs0xZUC8F3ORSfyJ75ATWZO+Ze8V/RYqeel4tJzjcGAlj8yFak+sPjq/
        zQa8ByLASaqz5sZqNuGIhrnMg
X-Received: by 2002:a5d:4a8f:0:b0:1f0:4af2:4e29 with SMTP id o15-20020a5d4a8f000000b001f04af24e29mr292229wrq.519.1646243310196;
        Wed, 02 Mar 2022 09:48:30 -0800 (PST)
X-Google-Smtp-Source: ABdhPJykaH1cjF8Bel4wvi23J3mDvwOhoDqUEVzkDqVEnsn90rg5c2+5PKw3CzHay2FDBT8xLhmG5g==
X-Received: by 2002:a5d:4a8f:0:b0:1f0:4af2:4e29 with SMTP id o15-20020a5d4a8f000000b001f04af24e29mr292213wrq.519.1646243309890;
        Wed, 02 Mar 2022 09:48:29 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2583118wrr.88.2022.03.02.09.48.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Mar 2022 09:48:29 -0800 (PST)
Message-ID: <a0eee64e-763a-0db3-29d1-e19ee80ba1ee@redhat.com>
Date:   Wed, 2 Mar 2022 18:48:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] KVM: allow struct kvm to outlive the file descriptors
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        dmatlack@google.com
References: <20220302174321.326189-1-pbonzini@redhat.com>
 <Yh+trXegvWs+e5l3@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yh+trXegvWs+e5l3@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/2/22 18:47, Sean Christopherson wrote:
>> +	/* This is safe, since we have a reference from open(). */
>> +	__module_get(THIS_MODULE);
> This isn't sufficient.  For x86, it only grabs a reference to kvm.ko, not the
> vendor module.  Instead, we can do:
> 
> 	if (!try_module_get(kvm_chardev_ops.owner))
> 		return ERR_PTR(-EINVAL);
> 
> And then on top, revert commit revert ("KVM: set owner of cpu and vm file operations").
> vCPUs file descriptors hold reference to the VM, which means they indirectly hold a
> reference to the module. So once the "real" bug of struct kvm not holding a reference
> to the module is fixed, grabbing a reference when a VM/vCPU inode is opened becomes
> unnecessary.
> 

Got it, I'll wait for David to post the right thing. :)

Paolo

