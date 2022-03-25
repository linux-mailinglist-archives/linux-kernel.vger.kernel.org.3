Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA7EF4E721C
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 12:21:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355562AbiCYLXP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 07:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346207AbiCYLXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 07:23:13 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 93B8BD1CF6
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:21:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648207298;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AC31SmN1xrzT0hiknezp8tHe0XvYdjbL43hI7yRc6I8=;
        b=U+OzrecbIctU+oX/yEHfk+7YooKluIfGHsAPYge6vtYOUMRQHKkhlwqmHDmZwaH+Kz786j
        5sqNG++b9BetkikkTlLWicHoImn0ZJyigcdHfqXMmfIfHd02Idw1e/YU2vRCr0c/gw2edO
        +PY8ckMN4w9+jLyKeiNas0sQ/IeOa8Q=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-_EBgUc80P5SeVp4mVLTefg-1; Fri, 25 Mar 2022 07:21:37 -0400
X-MC-Unique: _EBgUc80P5SeVp4mVLTefg-1
Received: by mail-ed1-f72.google.com with SMTP id w8-20020a50d788000000b00418e6810364so4708346edi.13
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 04:21:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AC31SmN1xrzT0hiknezp8tHe0XvYdjbL43hI7yRc6I8=;
        b=MuLf/i+1p4ciJ6p19FDOrj+Ej0ecDC0ViGStY6A4JPfVepU5LRdr97lhWtqlb+TQxA
         9kcQevnCY2DITdzisVhqn1AJG5coxDslFFradeihwfC2p1W4oZnT1s+OHfv1pj2iiIow
         avKqhR0tHb7/xbqQ5oNX+JswVnK8+vdRFTEV3Lk2Vs0rgh5hQQ9lrhdNfZK1fFI1CUTI
         IY1UgnxsnC3fdF03zf/kZ+KZ3o1nJty760fyha/LaykGvwz5clyUcDelT9sIXutJSBSo
         /aFu1yqehboJ+zt+/+yCuRvAUplxRg6He8IEHHzsbAUy8ebHZqGIQPu7ST02mbhW+6P1
         iV+Q==
X-Gm-Message-State: AOAM530WgQqGWe3cbfcqg5DbbLsP908gaySiY1dCb/o4lZRzPbw5LRL8
        yGC0xW9KjI1a+XcJx/EH9I9ijpSUN8JH9EcD4bujrH8bM3uY2jFXnlDgZjqT2Zg38WBqX221FVM
        AG7p4LOxXskCcD++Ho6HTNUhx
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id ds2-20020a170907724200b006dab561d523mr10829006ejc.118.1648207296180;
        Fri, 25 Mar 2022 04:21:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyRaH3RiGK52JWiLBhsoZq6pW8PFaiUxhuzhlAvmuh/6hiXDyLkGAYLCfXeBTG6ECKMXpWD8A==
X-Received: by 2002:a17:907:7242:b0:6da:b561:d523 with SMTP id ds2-20020a170907724200b006dab561d523mr10828983ejc.118.1648207295973;
        Fri, 25 Mar 2022 04:21:35 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id i10-20020aa7dd0a000000b00419286d4824sm2688498edv.40.2022.03.25.04.21.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 04:21:35 -0700 (PDT)
Message-ID: <78e3f054-829e-b00d-6c65-9ae622f301df@redhat.com>
Date:   Fri, 25 Mar 2022 12:21:28 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [FYI PATCH] Revert "KVM: x86/mmu: Zap only TDP MMU leafs in
 kvm_zap_gfn_range()"
Content-Language: en-US
To:     Sean Christopherson <seanjc@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
References: <20220318164833.2745138-1-pbonzini@redhat.com>
 <d6367754-7782-7c29-e756-ac02dbd4520b@redhat.com>
 <Yj0FYSC2sT4k/ELl@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <Yj0FYSC2sT4k/ELl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/25/22 00:57, Sean Christopherson wrote:
> Can I have 1-2 weeks to try and root cause and fix the underlying issue before
> sending reverts to Linus?  I really don't want to paper over a TLB flushing bug
> or an off-by-one bug, and I really, really don't want to end up with another
> scenario where KVM zaps everything just because.

Well, too late...  I didn't want to send a pull request that was broken, 
and Mingwei provided a convincing reason for the breakage.

Paolo

