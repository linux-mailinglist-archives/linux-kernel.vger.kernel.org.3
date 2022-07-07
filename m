Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA856A66C
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 16:59:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235503AbiGGO7D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 10:59:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236746AbiGGO6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 10:58:19 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CB23C32
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 07:57:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657205868;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=BPPyfbm7cP61/jDVpNfbjlUmaFCLU4YcNzeyYG8WmXc=;
        b=dBXBk+Df5Pj5p9vcoHut1p1ZjxXRc/8OnZzY1jwPeKahGX59HI/vT+unF7GRzTWeHVVh/E
        oxm+PFujqoznfgYyF4rONJhpXMUj582AAosA1ugTk6Dv3Ln8RyT30z0gi25Sn4Uq1xgnPl
        fMs4xlXlTvNad9fFSNCdi9v7HN8ID9w=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-K19ejAFcN4mbz_bQygF27Q-1; Thu, 07 Jul 2022 10:57:47 -0400
X-MC-Unique: K19ejAFcN4mbz_bQygF27Q-1
Received: by mail-wm1-f70.google.com with SMTP id v8-20020a05600c214800b003a1819451b1so9663273wml.7
        for <linux-kernel@vger.kernel.org>; Thu, 07 Jul 2022 07:57:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=BPPyfbm7cP61/jDVpNfbjlUmaFCLU4YcNzeyYG8WmXc=;
        b=a8U8e+5UvxsrFVlsPS+dg4ezc4iipzJy+hlj7586KH6Qa9lwoGNXXYcghwLTY9fnaa
         4mn6sMbEeRg5e0z/tH8KObZhhxJnTbLBoDcrYXKtfJu83JJ8QMjmMEs4meYgXmdd2jFB
         u51Xbv51fPYKCJrR7VMI6LofJWQyOeJAQgbXueNSY3U1N0+t8nyTOOj00r1HvUuu1+jZ
         TiLiAzch4LDenLTZu5hHbmSSi0ave3OSaV+TEiHEzIgckra6kyJAslz1XiukqAYQLW7M
         o4bVVhlkfeKOIm0xUj991IvUCQvIEqj/XOWoL24uKhuEtb5FM1pEYLf/BK004/fzqeB3
         AqYg==
X-Gm-Message-State: AJIora+BuXR9yj6490PqoVitJWTW2dnRmskgYx0bTws3bx9WSJqU0hyq
        pjb7YKDR6KWISUDkMha0c1WZvpCuuUYeOJJ4IXdGexAZCLkmK2OXUc7usSC18swf0GTfWvAxRAk
        sjXklOil9Q8MZRaUb19As9z7dtaf71QLOjwZbLiUa9D92/BHagr55Ww1OrVLK95GYdoRyzbyF4m
        CW
X-Received: by 2002:a05:600c:3511:b0:3a1:9992:f72f with SMTP id h17-20020a05600c351100b003a19992f72fmr5166870wmq.164.1657205866263;
        Thu, 07 Jul 2022 07:57:46 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1u0/E4oQnfuVVwr2Quhckj80YkdpdC1DUvgHP9mLEG3FQiLuZoO9arVkl3lDbI9tW7XUnCGwg==
X-Received: by 2002:a05:600c:3511:b0:3a1:9992:f72f with SMTP id h17-20020a05600c351100b003a19992f72fmr5166839wmq.164.1657205866008;
        Thu, 07 Jul 2022 07:57:46 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id y8-20020adfee08000000b0021d6e49e4ebsm9673078wrn.10.2022.07.07.07.57.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Jul 2022 07:57:45 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 22/28] KVM: VMX: Clear controls obsoleted by EPT at
 runtime, not setup
In-Reply-To: <CALMp9eRA0v6BK6KG81ZE_iLKF6VNXxemN=E4gAE4AM-V4gkdHQ@mail.gmail.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-23-vkuznets@redhat.com>
 <CALMp9eRA0v6BK6KG81ZE_iLKF6VNXxemN=E4gAE4AM-V4gkdHQ@mail.gmail.com>
Date:   Thu, 07 Jul 2022 16:57:44 +0200
Message-ID: <87wncpotqv.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jim Mattson <jmattson@google.com> writes:

> On Wed, Jun 29, 2022 at 8:07 AM Vitaly Kuznetsov <vkuznets@redhat.com> wrote:
>>
>> From: Sean Christopherson <seanjc@google.com>
>>
>> Clear the CR3 and INVLPG interception controls at runtime based on
>> whether or not EPT is being _used_, as opposed to clearing the bits at
>> setup if EPT is _supported_ in hardware, and then restoring them when EPT
>> is not used.  Not mucking with the base config will allow using the base
>> config as the starting point for emulating the VMX capability MSRs.
>>
>> Signed-off-by: Sean Christopherson <seanjc@google.com>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Nit: These controls aren't "obsoleted" by EPT; they're just no longer
> required.

Sean,

I'm going to update the subject line to "KVM: VMX: Clear controls
unneded with EPT at runtime, not setup" retaining your authorship in v3
(if there are no objections, of course).

>
> Reviewed-by: Jim Mattson <jmattson@google.com>
>

Thanks!

-- 
Vitaly

