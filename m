Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6CBA586B52
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:50:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234921AbiHAMu0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:50:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234910AbiHAMuF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:50:05 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F171F558E
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659357814;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WS+3ThxPSCx9TTKskcZREuLQziOp6sjXVWQAmlUDQSk=;
        b=FVCJsevcROy29U55TBRUGiycjdi0KJYWwt+/8lQ8bolc01BRsqvBDKMCRd+Rv3Vsg7ASl/
        XHAzUCEim1XZiDYLatJt6JWA6JBhphn6tqkF4Vryy9tLEeLFeT5Us0FEx1ZeTp+N961f8f
        2umEBCY1WC1VFOuw4BV8j4zloaRMD6o=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-Ttfj_AOqNlyJTgT90NU3Sg-1; Mon, 01 Aug 2022 08:43:33 -0400
X-MC-Unique: Ttfj_AOqNlyJTgT90NU3Sg-1
Received: by mail-ej1-f70.google.com with SMTP id ne36-20020a1709077ba400b0072b64ce28aaso2946670ejc.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:43:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=WS+3ThxPSCx9TTKskcZREuLQziOp6sjXVWQAmlUDQSk=;
        b=3/DlgOcXNveZ5kOC4bKBJNqhIf2pNR2LlSVLl0BzWj7Mtf6HnH9sBqdXtzzNp2sKTb
         GKW/AIOs7VOCKyIVqFoUyhdyzq0pLwFN1kyg1949NmUvq3EBT47KF4TdfPUyYKpbedBv
         BMlcMn2ByOQVkaVzb/j4WI0+dKFIErxj2OFGNVtY6QfXBn1cuRba0NJ85DYXw99Nqyt6
         eakMllBVuD3T6Pma9zWu/4gMkOmFTmISfPR4QI/VjBF3m5EMznDDUcaO6XAqbhfdirZE
         8ktOrajcrm/KN72debwRAkN6lZ9NZQ+KWf51nmrAFMdHtmQnfwEY258lr4La4TOk/Kwv
         xFfQ==
X-Gm-Message-State: AJIora/FGUoO1D4ku1Rnzs9dOq6ma2WYLV+ERTjW5cWkgjq4OHChTyPO
        CDkxwr0++pRDqQXdwi5rv2qdNIkg4VF9PAco82ELsn9Ovhfj2q8W++5KI7OgAlI5K74APDrYmpd
        tv5cbdWrhCScMf4WANB1JN3sR
X-Received: by 2002:a05:6402:430a:b0:43b:ea0d:dc59 with SMTP id m10-20020a056402430a00b0043bea0ddc59mr15559107edc.387.1659357812824;
        Mon, 01 Aug 2022 05:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vOjWj0y3iMX53pyz5V46T+O5+5Aq6q+J+CKRYTdzRlJRudv67mcAECsSA+HsYERrnBrII1gA==
X-Received: by 2002:a05:6402:430a:b0:43b:ea0d:dc59 with SMTP id m10-20020a056402430a00b0043bea0ddc59mr15559087edc.387.1659357812628;
        Mon, 01 Aug 2022 05:43:32 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id d27-20020a056402517b00b0043577da51f1sm6740601ede.81.2022.08.01.05.43.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 05:43:31 -0700 (PDT)
Message-ID: <54fbb1e1-c9b1-db59-6388-1aab74eb5b11@redhat.com>
Date:   Mon, 1 Aug 2022 14:43:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 4/5] selftests/kvm/x86_64: set rax before vmcall
Content-Language: en-US
To:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andrei Vagin <avagin@google.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Sean Christopherson <seanjc@google.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jianfeng Tan <henry.tjf@antfin.com>,
        Adin Scannell <ascannell@google.com>,
        Konstantin Bogomolov <bogomolov@google.com>,
        Etienne Perot <eperot@google.com>
References: <20220722230241.1944655-1-avagin@google.com>
 <20220722230241.1944655-5-avagin@google.com> <87y1w819o7.fsf@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <87y1w819o7.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/1/22 13:32, Vitaly Kuznetsov wrote:
> Fixes: ac4a4d6de22e ("selftests: kvm: test enforcement of paravirtual cpuid features")

Queued, thanks.

Paolo

