Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B29564E72A6
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 13:01:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354619AbiCYMCN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 08:02:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346906AbiCYMCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 08:02:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EE917CA0EA
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648209632;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=10+nSXQNAg/4PmcT0QAA6OoqJ8vSM5os5GO4TM9qJS4=;
        b=ILNcPyrnW9SCdg69pA55YOk1htOZ7BdnyYH5zFlaygcMRub4zy9pZiOaCidBvV+kbZ29c9
        ZkMC4I63m77g8SLcjhlOmqmvcvYSRCWqU24A7Q7GOfw0UVMekzvqWvtpftdtiiqrrPdcY4
        aUPYjP6PnjsCRC7aiSstGhZanNejf7s=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-104-2ogvKO7HOOaT0HKWIc9xwg-1; Fri, 25 Mar 2022 08:00:31 -0400
X-MC-Unique: 2ogvKO7HOOaT0HKWIc9xwg-1
Received: by mail-ej1-f72.google.com with SMTP id gx12-20020a1709068a4c00b006df7e8181ceso4003475ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 05:00:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=10+nSXQNAg/4PmcT0QAA6OoqJ8vSM5os5GO4TM9qJS4=;
        b=sfWHCd3yRYa5TP4eyZJck98rgMlPQkIpRcjmWELr+Ltg0z4z3U1qmkXSayoSAam9jU
         3DBYxGYYRlPhfaNnO/Qu5gOSGOHBUXnOewQ02dbenMqoo470FZpavJ++H8B7xGuKebq4
         iUmTiDm/lWjp2DshEo98IYJjgkKhM/X4fHmBOga8xSulKid1VRrfVdRtcGcBZQTygWcO
         zSuTSdRIQQVIkMFwkRMl84vd9F2fl+qhX5MaIBzJUGJs8LA3qyEXA01Wvw5tP+fEiOU5
         SsDKQ4ULhemwiFwk6Pww8cykmCM+Tkxu4+H/SJ+xxi+Okw46bXY+Tu1K4nNdU932kUJd
         xg2Q==
X-Gm-Message-State: AOAM532ZF/4pAmA3GI+noGZ+hisyWnEO2X3Qb7oZyvHMpoi2Alhkxs+B
        XcpyjNnjOVe3x2eHw4AgcO0sqPL+fdACLTnYUFMiFmNzVKnD48uVmUxX4BsBv3uzCkm8yS8soQ1
        aV+aq7rTlb9+2QNfmK3XY172Z
X-Received: by 2002:a17:907:6297:b0:6da:6388:dc58 with SMTP id nd23-20020a170907629700b006da6388dc58mr11564389ejc.472.1648209630074;
        Fri, 25 Mar 2022 05:00:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzgUJ1KG6o3aXpN9MoCJl3rCrAS3LicB9qyC0jgTVWLsfh3+fdU8putTI+I2ZZGOMHgszw0lQ==
X-Received: by 2002:a17:907:6297:b0:6da:6388:dc58 with SMTP id nd23-20020a170907629700b006da6388dc58mr11564357ejc.472.1648209629808;
        Fri, 25 Mar 2022 05:00:29 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:1c09:f536:3de6:228c? ([2001:b07:6468:f312:1c09:f536:3de6:228c])
        by smtp.googlemail.com with ESMTPSA id n2-20020a17090673c200b006db8ec59b30sm2194205ejl.136.2022.03.25.05.00.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Mar 2022 05:00:29 -0700 (PDT)
Message-ID: <dba0ecc8-90ae-975f-7a27-3049d6951ba0@redhat.com>
Date:   Fri, 25 Mar 2022 13:00:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH v2 0/9] KVM: x86/MMU: Optimize disabling dirty logging
Content-Language: en-US
To:     Ben Gardon <bgardon@google.com>, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        David Matlack <dmatlack@google.com>,
        Jim Mattson <jmattson@google.com>,
        David Dunn <daviddunn@google.com>,
        Jing Zhang <jingzhangos@google.com>,
        Junaid Shahid <junaids@google.com>
References: <20220321224358.1305530-1-bgardon@google.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220321224358.1305530-1-bgardon@google.com>
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

On 3/21/22 23:43, Ben Gardon wrote:
> Currently disabling dirty logging with the TDP MMU is extremely slow.
> On a 96 vCPU / 96G VM it takes ~256 seconds to disable dirty logging
> with the TDP MMU, as opposed to ~4 seconds with the legacy MMU. This
> series optimizes TLB flushes and introduces in-place large page
> promotion, to bring the disable dirty log time down to ~3 seconds.
> 
> Testing:
> Ran KVM selftests and kvm-unit-tests on an Intel Haswell. This
> series introduced no new failures.

Thanks, looks good.  The one change I'd make is to just place the 
outcome of build_tdp_shadow_zero_bits_mask() in a global (say 
tdp_shadow_zero_check) at kvm_configure_mmu() time.  The 
tdp_max_root_level works as a conservative choice for the second 
argument of build_tdp_shadow_zero_bits_mask().

No need to do anything though, I'll handle this later in 5.19 time (and 
first merge my changes that factor out the constant part of 
vcpu->arch.root_mmu initialization, since this is part of the same ideas).

Paolo

