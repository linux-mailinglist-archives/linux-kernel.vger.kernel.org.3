Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FB44AF7E2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 18:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237880AbiBIRLk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 12:11:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238032AbiBIRLi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 12:11:38 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3611DC05CB87
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 09:11:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644426701;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iQs4y9ejLWNczy8HXhh1vDnY6jrshkGK7+qkXn9tZ4Y=;
        b=b5bO9rxzsr195/xEjClWoKLthpEUNxdOZIt2g61sKfcL/RkheENI1EPoeJchx0VE+nNkQP
        ej32RP4pySao3P6JqgnzMwEP9+hwvwQ0qiCzU8+6NT9lIqOQnNcOD56b1qcX0KsgQXaGWe
        KrERPRttJqTvSLu2Mvdl2nXhPWRLhZE=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-472-B2PCK14uOam2VB7nvp8JNQ-1; Wed, 09 Feb 2022 12:11:38 -0500
X-MC-Unique: B2PCK14uOam2VB7nvp8JNQ-1
Received: by mail-ed1-f71.google.com with SMTP id en7-20020a056402528700b00404aba0a6ffso1745952edb.5
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 09:11:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=iQs4y9ejLWNczy8HXhh1vDnY6jrshkGK7+qkXn9tZ4Y=;
        b=sllokBBYmcTdLu74y2bYv8sHl0bflVLyJdxwCdgG2pFywv/pTX70S9jWEcBgRA1wGX
         9evpWPtyMTXlJh6afbnua/rC+nf1P00ZsXOJL/nMLoAx/wsOQmYw0xz/6WVsrRc1SJ5o
         xQgzVctpk/rMpGHLS+5ZyMWnMwuM/odU/ZonIihNsFtZajYRd2WK468/HXBOfCHD38JN
         HYOWWE7X8JxujoMh/pOkA94CaH/V+qagty5TdiMRDfWHQ3FPbvi3/QrgzFF2H05uH7Ax
         aOWu29EpYL2fPyqhFj5jDyKYWWJsTKABp6apae0yH398CWbWizAH7nAfDVuuqO9gpTBc
         qVEA==
X-Gm-Message-State: AOAM530VDiuRTr3EY6nLRJ0TwLVWeIbgjx60P4QDPxL7AeSzjLrI7Q3y
        U+JOeeuvh+JCRUDvI9Uspevr579IfZZoh5GBkXRBmL5vAsPhqULMor+4IE0zGez7piCFET+XpRg
        hs3h8Uoz1yVeZZa2w2ST6oQsu
X-Received: by 2002:a17:906:478c:: with SMTP id cw12mr2813195ejc.214.1644426696914;
        Wed, 09 Feb 2022 09:11:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxUXH92lhPWvXHhNKgOwcYNhiqoW2ncfoaMyf0NglUCkzpRmK0wIC/g3kQtRc6brn9RvFIPRg==
X-Received: by 2002:a17:906:478c:: with SMTP id cw12mr2813175ejc.214.1644426696700;
        Wed, 09 Feb 2022 09:11:36 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id bo9sm3946812edb.29.2022.02.09.09.11.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 09:11:36 -0800 (PST)
Message-ID: <fc3a4cdc-5a88-55a9-cfcc-fb7936484cc8@redhat.com>
Date:   Wed, 9 Feb 2022 18:11:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH 00/12] KVM: MMU: do not unload MMU roots on all role
 changes
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        vkuznets@redhat.com, mlevitsk@redhat.com, dmatlack@google.com
References: <20220209170020.1775368-1-pbonzini@redhat.com>
 <YgP04kJeEH0I+hIw@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <YgP04kJeEH0I+hIw@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/9/22 18:07, Sean Christopherson wrote:
> On Wed, Feb 09, 2022, Paolo Bonzini wrote:
>> The TDP MMU has a performance regression compared to the legacy MMU
>> when CR0 changes often.  This was reported for the grsecurity kernel,
>> which uses CR0.WP to implement kernel W^X.  In that case, each change to
>> CR0.WP unloads the MMU and causes a lot of unnecessary work.  When running
>> nested, this can even cause the L1 to hardly make progress, as the L0
>> hypervisor it is overwhelmed by the amount of MMU work that is needed.
> 
> FWIW, my flushing/zapping series fixes this by doing the teardown in an async
> worker.  There's even a selftest for this exact case :-)
> 
> https://lore.kernel.org/all/20211223222318.1039223-1-seanjc@google.com

I'll check it out (it's next on my list as soon as I finally push 
kvm/{master,next}, which in turn was blocked by this work).

But not zapping the roots is even better---especially when KVM is nested 
and the TDP MMU's page table rebuild is very heavy on L0.  I'm not sure 
if there are any (cumulative) stats that capture the optimization, but 
if not I'll add them.

Paolo

