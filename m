Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DAEE563751
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 18:03:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231262AbiGAQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbiGAQDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 12:03:11 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3438C7C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 09:03:10 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id w83so4118055oiw.1
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 09:03:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rqJwHgmuBoxIt5vyJ91QW4DLByGUx5uWYxmbDTSBAHs=;
        b=VywtSoL1CTz2IcDC1UnChIFSEQg26g5qy3uVpJLlxOiDpHgfueGl+AJ2Ho7YdeL1VJ
         diXLfccXWkdUu56eOBb8/T2Z553tlASEgvNics8H0nnjUgbetB1LEKE6VCtkx/4dX0ic
         SY3RbTlUCn7kqm9AIL8X0FBlHikbBrjeO7os283DggS+b+pnndUbWtodmPIaNmqkelC3
         BW4pt+hE86H7pIMhlscJmimNRkl+Aun0/qxu4gMfR+NN4IPN8B0zKGQ0xpqoCTPT3+An
         tJR+gKNwy1M2gF8Sa8e/P+CaL1pxLKIbMUTO/Rosb7iqcHHEB2dFti+dSDF3E8Ni9X2Z
         sQAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rqJwHgmuBoxIt5vyJ91QW4DLByGUx5uWYxmbDTSBAHs=;
        b=PCnzJM2SJo6rKJWRjRlmmrDA+H6kSrkwymiolVd4K6c/t6gVWY2sZGkGNxxOm1AjVQ
         ahT+JkeEqk/oRSWFIqimLmi29cg21W81LWOQhMMIAKGXjq16bl5pIKq/nsKuhCR0M1oC
         ih1qKz1RV+Y2tA/uEKC9x9qXQ0yqM/sqrOjMnxJi6XfQqNDyhyMET/WDM/2vTifEK9j3
         xFgY52Pz03nbYh2+kpsgGfvHklGNgbiNHqR0Wl/V7XGu5abG1PrYtzMPENURVAbQlRHI
         MFYLcp/lMjYxQdN30BQzBKbRmVOEqIpybLy/fx+1Rg/KaYk6VJZfDbbJpEWF9KVqPeha
         WWWA==
X-Gm-Message-State: AJIora/jBPQ+/6dmLnq91NHsPRXL7p+NKid9QnI/3nLQh+QkQ6C6uolm
        ECY0qhyNvpXEqgbFuN0vKwLASo/ntpwqQxL6NQhl8Q==
X-Google-Smtp-Source: AGRyM1uRa9Sidpo3z6KZT3YxqtiTxT8O/4sGDDwSBBqVSkVSRDKb4+wrt9ouf45phdlZFYvPXTUA07bEPbYOM0DUm48=
X-Received: by 2002:a05:6808:2124:b0:335:7483:f62d with SMTP id
 r36-20020a056808212400b003357483f62dmr10390571oiw.112.1656691390201; Fri, 01
 Jul 2022 09:03:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-20-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-20-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Fri, 1 Jul 2022 09:02:59 -0700
Message-ID: <CALMp9eQjxwNLEV6f-xh+7DpfZ=og_Zf0B9isDqSa2KPMaj8wgg@mail.gmail.com>
Subject: Re: [PATCH v2 19/28] KVM: VMX: Add missing VMEXIT controls to vmcs_config
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> As a preparation to reusing the result of setup_vmcs_config() in
> nested VMX MSR setup, add the VMEXIT controls which KVM doesn't
> use but supports for nVMX to KVM_OPT_VMX_VM_EXIT_CONTROLS and
> filter them out in vmx_vmexit_ctrl().
>
> No functional change intended.
>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
