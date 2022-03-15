Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D1DE4DA453
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 22:06:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351795AbiCOVH0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 17:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343868AbiCOVHX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 17:07:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CDC5255BC0
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:06:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647378370;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=emsFlxwu2Fpzz4LWF/dJeqV7CMDiP7wZEH5sRvwPHYI=;
        b=SecC7YL5V0epz78EBZSLIc/7Mbkxbo8hVwecjQSkCfgt3TEd2lncCZyOPn8nCSYgQXVIF0
        mivUWyyecWMRNk/L6Vd5DLRxmSaf53IXb904BtyX8s5Fld1tyq1ABYD+K7R42XyOvsij0J
        uQvuGyzkGabWN8Kyy9VZfyhpcElgOOw=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-607-qaizVjXUP4eKePHBXdxsOw-1; Tue, 15 Mar 2022 17:06:08 -0400
X-MC-Unique: qaizVjXUP4eKePHBXdxsOw-1
Received: by mail-ej1-f71.google.com with SMTP id ey18-20020a1709070b9200b006da9614af58so51788ejc.10
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 14:06:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=emsFlxwu2Fpzz4LWF/dJeqV7CMDiP7wZEH5sRvwPHYI=;
        b=vGu8a5SYp28zehCzG3spjnXVFRtjh+IEvvQ2xx6o7hmyxfQagS2KP/WKmkpSKuYPg3
         FGMZOIDRVF/r+Ka5uCxkz7wuH3m8B+KQAYdWCorpAFyclZzNUFFsgqNMKrvfHOKlwtnm
         pjkxm7xnevJHRuOcGb9Os2lHtbBRqs/3iSAfV/s0/RqZ1Imt1WcDS70rGDdawLEvCrfo
         zdl7f2hq0uzcxEcWhQDiZIYpN2r/punZlITsAPyKe/xfelBu4uT5+Vx++UKcdoVS+JGG
         +IZFkzftFpvW2ehGx0qMlhNBvX6jGEgWXnr3+QPVLu7StvpVOS93CecUEyLPstXoyMcX
         TMrQ==
X-Gm-Message-State: AOAM531idKaEKr8wh73fkH98CXFQ9XnwsuEpp1WGVChecZPV3StZvzRM
        uk3/+zN6n/9sfM1SmbXpvqeeO4ovYxhtVWwHWQ4qU7C3nmkRetrXmUNnCsYhtfHNsOoKDcIA8rp
        Qz9v8jNdYrRThgyUsuySp9v6X
X-Received: by 2002:a17:907:96a8:b0:6db:4c68:1393 with SMTP id hd40-20020a17090796a800b006db4c681393mr24116130ejc.87.1647378367376;
        Tue, 15 Mar 2022 14:06:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzE4fUDhYm2sNjarm9dSLvKXqwJDtQNDnrVXJGWOPwLtqbXXpUkCFSU8NNt0KzN353BvFc3EQ==
X-Received: by 2002:a17:907:96a8:b0:6db:4c68:1393 with SMTP id hd40-20020a17090796a800b006db4c681393mr24116110ejc.87.1647378367151;
        Tue, 15 Mar 2022 14:06:07 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:63a7:c72e:ea0e:6045? ([2001:b07:6468:f312:63a7:c72e:ea0e:6045])
        by smtp.googlemail.com with ESMTPSA id s8-20020a170906354800b006da9dec91f2sm52534eja.163.2022.03.15.14.06.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 14:06:06 -0700 (PDT)
Message-ID: <5cc80cc7-8088-3bb7-4bbe-40c527465658@redhat.com>
Date:   Tue, 15 Mar 2022 22:06:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2 0/5] KVM: X86: permission_fault() for SMAP
Content-Language: en-US
To:     Lai Jiangshan <jiangshanlai@gmail.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>
Cc:     Lai Jiangshan <jiangshan.ljs@antgroup.com>
References: <20220311070346.45023-1-jiangshanlai@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220311070346.45023-1-jiangshanlai@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/11/22 08:03, Lai Jiangshan wrote:
> From: Lai Jiangshan<jiangshan.ljs@antgroup.com>
> 
> Some change in permission_fault() for SMAP.  It also reduces
> calls two callbacks to get CPL and RFLAGS in come cases, but it
> has not any measurable performance change in tests (kernel build
> in guest).

I am going to queue patches 1-4.  The last one shouldn't really have any 
performance impact with static calls.

Paolo

