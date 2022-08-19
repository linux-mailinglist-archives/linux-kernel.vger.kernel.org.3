Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D615559A756
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 23:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351882AbiHSUwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:52:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352096AbiHSUvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:51:55 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8ACD10E961
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:51:09 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id x23so5068823pll.7
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:51:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=UbjdgasMWdhxwQlviQSCvgTrM7YMkVlQiQeuIEbCI20=;
        b=F5jfp85iJvdeHkq3B0caSImoaFK/cXUJleEHGYjDONaJzOZYoILas7eS0W4lwLtBfe
         pZcyIT8JUi0yodjaXKAh298KkYMF6jhuDdPAm66NpOd++zndjQq7fNUT7Qi4Rpp26CqQ
         e0pgcxUaCUEEER5i5r3/K1hC7yb/wamOA0xWe+iafFJxwvWVwLl7xtikGjOHptaq2nzd
         rIbGZCUXoYuTj41kJ07aMFAGjXnPQpELn1HxOzkIoxQcrtcIIO095VdiODAHP/fYKHzg
         WvMSZ/qA4wYSR0D/ZXZ2ky8ljA8RMNDHc1lwnFQpBHm6fG+D+yCirzW2uiT7GWDBQbak
         80VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=UbjdgasMWdhxwQlviQSCvgTrM7YMkVlQiQeuIEbCI20=;
        b=rT0Hr8ZIPKVTYF3iAOhJC/f79GcKSpc3PrDVoqcUM3CMG4SRmmmnbKmdc6PpZXkEMc
         CnISjk2PSyY1rgAtlWOnowFH1T5Hv3E4MkmSSoH6pxl+GUetK8Fmk7Cf6JdxJqcm+8uZ
         g6uDIk1YK7FgIsGl8ZXm7+Xsy3hD7i5dZb7M95vATLrpUCGn389JcFO1hy0O1KgwsRz+
         IwjogCVSYyD9dVMUCzJoE1t+Q0SqtwamzdNOeMdt54xDtAdol1hT3Kp2kif9HKzu+HCf
         J+2UwnaNR7y2bK0o3BbsToMq5mWtQT7YGQUirKZPez1lfdO0s0RhzGn2983YMPtj//W5
         8YtQ==
X-Gm-Message-State: ACgBeo2ebmOpUgvlcsEuq6taV035w5LXSslae1CCenxsVM37Z01J0zdH
        8/k719ZCH8ahi/mwxGjsNKV6U8KlcDRS5Q==
X-Google-Smtp-Source: AA6agR5dZq0HkCdk3nAVTwQn5i+uPCXZZn+hn/3WIuR2C4mIJR6smSBqCK14KRZBDKTLl2B3wZLWhA==
X-Received: by 2002:a17:90a:f88:b0:1fa:da0f:5e6 with SMTP id 8-20020a17090a0f8800b001fada0f05e6mr6885579pjz.102.1660942268166;
        Fri, 19 Aug 2022 13:51:08 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id e13-20020a631e0d000000b0041d5001f0ecsm3187717pge.43.2022.08.19.13.51.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:51:07 -0700 (PDT)
Date:   Fri, 19 Aug 2022 20:51:03 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Andrew Jones <andrew.jones@linux.dev>
Cc:     Peter Gonda <pgonda@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, marcorr@google.com,
        michael.roth@amd.com, thomas.lendacky@amd.com, joro@8bytes.org,
        mizhang@google.com, pbonzini@redhat.com, vannapurve@google.com
Subject: Re: [V3 10/11] KVM: selftests: Add ucall pool based implementation
Message-ID: <Yv/3t2oLDPUySpBd@google.com>
References: <20220810152033.946942-1-pgonda@google.com>
 <20220810152033.946942-11-pgonda@google.com>
 <20220816161350.b7x5brnyz5pyi7te@kamzik>
 <Yv5iKJbjW5VseagS@google.com>
 <20220818190514.ny77xpfwiruah6m5@kamzik>
 <Yv7LR8NMBMKVzS3Z@google.com>
 <20220819051725.6lgggz2ktbd35pqj@kamzik>
 <Yv/QPxeKczzmxR9H@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yv/QPxeKczzmxR9H@google.com>
X-Spam-Status: No, score=-14.4 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 19, 2022, Sean Christopherson wrote:
> Or can we just say that it's always immediate after memslot0?  That would allow
> us to delete the searching code in ARM's ucall_arch_init().

I have this coded up, will test on x86 and arm64 and send out a series (essentially
all of the non-SEV bits in this series).

Prescribing an MMIO address from __vm_create() has a some nice side effects.

  1) KVM treats writes to read-only memslots as MMIO, so a future cleanup would
     be to have __vm_create() create a memslot for the MMIO range to prevent
     silently clobbering the address.  I'll leave this for later because selftests
     currently assumes they can use all memslots except memslot0.

  2) It will simplify wwitching x86 and RISC-V to a common MMIO implementation,
     if we ever want to do that.  I.e. have common code for everything except s390.
