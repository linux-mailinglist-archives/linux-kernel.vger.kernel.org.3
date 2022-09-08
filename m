Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60E385B21E2
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 17:20:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231862AbiIHPUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 11:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbiIHPUL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 11:20:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78F3E33A0F
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 08:20:09 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q63so17065878pga.9
        for <linux-kernel@vger.kernel.org>; Thu, 08 Sep 2022 08:20:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rOPP6Uu5swigMSQksbn2hbHol8fqfH4qx3zUzGuou0s=;
        b=SKw6t8rRS2GQn2M3D3NgOKrXQm8g6fMc6V31zBcuAt+NDWOtQgspdYheDwHP8gP7uc
         nRxip98S3briinM+V1vqUJXMJK+gk45KiZLtG/+aI3i2z1MHqAqbPHypbpczSXd+Y+fn
         amaEH6OX7wYBlUQ0Te6IqV22hhCG3x5PcZHVdNTfakbn+nxFHMossCoN1E+zqM8HPBLX
         a+CvW8keM4LjPisGpEfgomsc74y0AufuDco72laoiazzGJuNJd5aG4l/j1ClmZD2dInr
         LavX9mOoNeQFC7Ph2QvoGjtdIscd3zF83kU4eEZi2Tgzsu+Six5FZAOo8nrerlSeNgu7
         DN9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rOPP6Uu5swigMSQksbn2hbHol8fqfH4qx3zUzGuou0s=;
        b=jnaYIpQsS2Awwwi01FBW/vuhFI1HNzKDAs1CbJIahfnKV5pJnY8WbbDJviWLBMLzK4
         b37zj1wBxVv+eYtc2luwI63eYjgWWoJQhtExb/Em/sN19A03by7yqULe8mBNn2RUxi2k
         hFKAIPPX/4Ss1xuk649xmutSE/8OQROCCWzDe2YCUSql0X+FEMzwIXE21SgJw/B3Zq71
         ML3yS7jihzMX7HF4nf99lfHjE5uLuyMQz2YqrSRqs2HWek++6Dt73uM8zaU2sJUEWJwe
         i0uSGRshiNlo4SgmemKLH1xMFzSqXmzUBvvzfkpj9yuPQXRwZmyWVOjuvRrEcx4gHk9P
         KiVw==
X-Gm-Message-State: ACgBeo3XBKYdPRgcZYur9oCXYc6x/71SlW/Tff0fFu97LGmbAgqt0chD
        BzGwXDH+K7d2vrC2lDc7/RCEpGifQSya9g==
X-Google-Smtp-Source: AA6agR4uHgeZKOXawKaDnTBpniqg5EdDE/6lD8B729vKktfYTbo+w4REsRSc00v1h3FYfQa3nqKCZw==
X-Received: by 2002:a05:6a00:1408:b0:53a:97e2:d725 with SMTP id l8-20020a056a00140800b0053a97e2d725mr9496127pfu.39.1662650408726;
        Thu, 08 Sep 2022 08:20:08 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b30-20020aa78ede000000b00540d03f522fsm205433pfr.66.2022.09.08.08.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Sep 2022 08:20:08 -0700 (PDT)
Date:   Thu, 8 Sep 2022 15:20:04 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vipin Sharma <vipinsh@google.com>
Cc:     pbonzini@redhat.com, jmattson@google.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] KVM: x86: Fix mce_banks memory leak on mci_ctl2_banks
 allocation failure
Message-ID: <YxoIJLlgEfNa/pDY@google.com>
References: <20220819182258.588335-1-vipinsh@google.com>
 <Yw6FD867fK2Blf1G@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yw6FD867fK2Blf1G@google.com>
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

On Tue, Aug 30, 2022, Sean Christopherson wrote:
> On Fri, Aug 19, 2022, Vipin Sharma wrote:
> > If mci_ctl2_banks allocation fails, kvm goes to fail_free_pio_data and
> > forgets about freeing mce_banks memory causing memory leak.
> > 
> > Individually check memory allocation status and free memory in the correct
> > order.
> > 
> > Fixes: 281b52780b57 ("KVM: x86: Add emulation for MSR_IA32_MCx_CTL2 MSRs.")
> > Signed-off-by: Vipin Sharma <vipinsh@google.com>
> > ---
> 
> Pushed to branch `for_paolo/6.1` at:
> 
>     https://github.com/sean-jc/linux.git
> 
> Unless you hear otherwise, it will make its way to kvm/queue "soon".

Doh.  Dropping this as Paolo already sent a different fix[*] to Linus, commit
3c0ba05ce9c9 ("KVM: x86: fix memoryleak in kvm_arch_vcpu_create()").

Sorry :-(

[*] https://lore.kernel.org/all/20220901122300.22298-1-linmiaohe@huawei.com
