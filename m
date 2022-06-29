Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C52B560944
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 20:37:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230286AbiF2Shf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 14:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230457AbiF2Sh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 14:37:26 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE6423B57D
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:37:25 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id t26-20020a9d775a000000b006168f7563daso12826479otl.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 11:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PaRp7sZ9pT6Fzdv3ZScb3FYkSVAIhU7p3YcLa6CAkcA=;
        b=Ni0aNaonaAvtN8XBj3KHLXAe5Ml+1uTgE5dkIpCjjpyHkADS7VIc9iV2hfkoT5wn02
         WwclfjXNFqcKh1tLNDsviVvyTGydXpGg/9XX4ddJfMNWi2q+cQI85VUFYv2zZOj4J1BW
         LrfBIfDt+/GbxG8GuWVRDNLy4GBhr9IHDnuOC7bChrGWbB9k+GW8hsgMARQor5D1lM9L
         D93WUgpmCTJeMlVs3GWwNlUShAQgA+jtq7ZKeoWUXFoBF4CdG1+v6TjaBdncJbQDNi8w
         cWN7UqTmj28XvzC3INxW0piHnK+xHOVM+2yYw2OakH6Xd9Syzk2WJpZ1CN5OBEKcT/7G
         0IPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaRp7sZ9pT6Fzdv3ZScb3FYkSVAIhU7p3YcLa6CAkcA=;
        b=0UKFr5qB54Bxoenj5GpXpVW6pudl8DHXgMiUgJahZMpEr3bLbr1HvlN2DvzHVX0Q+v
         +FHfhYu5OEhIrw+IL2uO+2NYUEs0AwxPq3KxwD/lofI6gQguf1yp18JIasctGU4Qruv1
         fQtDTDk+gdrvQt5mx6z8DJ+IiC6wyTGa5MNiDtfMIvRriZtwtyEZ7f6+j91IcfYwC24M
         JxEWiAo+SusFrepcv29IgyuKgY415/e2f1rkAW3w4tBH0SM1GjLRfQcQjy8BCbQR02Xr
         T/1I5WIySERKY14LfBVR1MHGblRBxCCQ69l/xtpQuBbRhhW778Js81gwTJnwXVTnqJj8
         2s/Q==
X-Gm-Message-State: AJIora/MYGhH4D/EP/mUf5kfk4RtxRiWm3ifUXYwS3ZbQr8Dn3LPfiR6
        VNdOBwHFhAnNjFvsTlpnFk3eIoMPcWryPNI45nLkLg==
X-Google-Smtp-Source: AGRyM1uwmRwJtBJbAjDBszCqW/QovNsVpnMcD6vb39n9hiioGfwdFOA4bNnvWRWv81jMrK5m4kMcmXq+ObZ8Y3GFQvc=
X-Received: by 2002:a05:6830:1d5b:b0:616:de98:2556 with SMTP id
 p27-20020a0568301d5b00b00616de982556mr2213754oth.367.1656527845061; Wed, 29
 Jun 2022 11:37:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220629150625.238286-1-vkuznets@redhat.com> <20220629150625.238286-29-vkuznets@redhat.com>
In-Reply-To: <20220629150625.238286-29-vkuznets@redhat.com>
From:   Jim Mattson <jmattson@google.com>
Date:   Wed, 29 Jun 2022 11:37:14 -0700
Message-ID: <CALMp9eRCbgYVGtAwpDWhytQSjeGeAOuqKZXVg3RpV92uKV5u0A@mail.gmail.com>
Subject: Re: [PATCH v2 28/28] KVM: nVMX: Use cached host MSR_IA32_VMX_MISC
 value for setting up nested MSR
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
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>
> vmcs_config has cased host MSR_IA32_VMX_MISC value, use it for setting
> up nested MSR_IA32_VMX_MISC in nested_vmx_setup_ctls_msrs() and avoid the
> redundant rdmsr().
>
> No (real) functional change intended.

Just imaginary functional change? :-)

>
> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
