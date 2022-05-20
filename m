Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 30E3252EF27
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 17:26:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244444AbiETP0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 11:26:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350887AbiETP01 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 11:26:27 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21EB11A05D
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:26:25 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id bh5so7640633plb.6
        for <linux-kernel@vger.kernel.org>; Fri, 20 May 2022 08:26:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=8ckWBW9Fjr8xfgmBSfl+f9OgYv33qOKWhE+4JMMaKRw=;
        b=YYKHGP0IgfoQO6iOkN2ka8HPPVxXUyAoEDo+2ihZzUth1zktKy9n8ZiIrmV3i6Pr5f
         USXGGFoKspuxJPO0aMNObOuYCrsTSa2NpXp+464JfldeLFdnfFOZTf1ggDrjvjC5ocqm
         nzPALDWD90tkwTwHmPzPN0kppGLCHWFL2t3x2432bxvN+tpRZiW0aNxwVkYBkWlgjMrw
         a19vj/qDTkocip60j68nf4ZcF9Ma6xVFg7cfBczNrpOniGA0PT7awGCJRgxZupem+ZU5
         LVxWS/TR7q+8RwxKwdEJ9lEhi+JUn+JXW+cKdGde9mFMZT6Frg00Hc4ruPUVinzJeDWw
         V9Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8ckWBW9Fjr8xfgmBSfl+f9OgYv33qOKWhE+4JMMaKRw=;
        b=OLZi1jZP5aaELg999BPchQnCnd5UclGWJcTYhW9MdgNOEmqd72aMCWtkB/bTgm4SUN
         qt6PBKkWW/dc/KAuh/RWDO99H4KfuECGUx4mm/Ih+QOYYT7ThK/ot9MGTMTs0SlD1yNs
         4cJog0RziwIFGHLSeHO8UW3ncTZ8qHKkN+apCLDemTIcMVmbuTKVEurKAfRjOcGYG80d
         USU584T7cwmMhqeVG3PKdP/pLVU4yDxIYBOJgKvUH3u9xSLQcphTGBi6gFtmzubenTiG
         MMHIa7/zIWsnyhmQs4ai0FRlFsbowjrgCdEbIrnZqr3C10FCWnPdedW405wZ82Ertd+O
         a7Hw==
X-Gm-Message-State: AOAM5327Qnm8CCGBUm8BF95kL1kTvXZ+ecRadQ4zNq/QFMijzW7OOKBz
        MK/+EgW0NRp6Sdyre05h17gsbQ==
X-Google-Smtp-Source: ABdhPJyvH8cQUP9G2+GlRDfRUJU8C+SmDJDAAkcuc+H+1+M9X3nr7cpEqMmdgUw+vfbbiQeLFseMkw==
X-Received: by 2002:a17:902:854c:b0:158:35ce:9739 with SMTP id d12-20020a170902854c00b0015835ce9739mr10156221plo.150.1653060384458;
        Fri, 20 May 2022 08:26:24 -0700 (PDT)
Received: from google.com (157.214.185.35.bc.googleusercontent.com. [35.185.214.157])
        by smtp.gmail.com with ESMTPSA id u8-20020a1709026e0800b00161435e7475sm5843105plk.157.2022.05.20.08.26.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 20 May 2022 08:26:23 -0700 (PDT)
Date:   Fri, 20 May 2022 15:26:20 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Zeng Guang <guang.zeng@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, kvm@vger.kernel.org,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Gao Chao <chao.gao@intel.com>
Subject: Re: [PATCH] KVM: x86: Inhibit APICv/AVIC when changing apic id/base
 from the defaults
Message-ID: <YoezHLoQ3J2mjv1n@google.com>
References: <20220520144656.25579-1-guang.zeng@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220520144656.25579-1-guang.zeng@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 20, 2022, Zeng Guang wrote:
> From: Maxim Levitsky <mlevitsk@redhat.com>
> 
> Neither of these settings should be changed by the guest and it is a burden
> to support it in the acceleration code, so just inhibit APICv/AVIC in case
> such rare cases happen.
> 
> Signed-off-by: Maxim Levitsky <mlevitsk@redhat.com>
> Signed-off-by: Zeng Guang <guang.zeng@intel.com>
> ---

All of my comments on Maxim's posting still apply[*].  At this point, unless Paolo
wants wield his hammer of authority and do a bunch of fixup, the fastest way forward
will be to wait for Maxim to respond and post patches 1-3 of that series separately.

[*] https://lore.kernel.org/all/YoZrG3n5fgMp4LQl@google.com
