Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F441561357
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 09:37:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232956AbiF3Hgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232787AbiF3Hgs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:36:48 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 808191A81B
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656574606;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PwzmZMvr1HwTOyfvLBeay0UNdb3hWyqojFY1Kj6edFc=;
        b=ToLNUmgJkq8DzTOgsn0F6CyBXO4GhnET3xsVFjXZzQITrVKdYUi+TGzvweqtV3j8d+7ndq
        PKk2qa7xTXfc1H5rWhgAGZBiXqQbv/Y4udEHncOAXN13bZRLyxsy4AKeABGb0ZTJwxNsmy
        QFVmsklU26EQ8hLT1I+tX/WkmjY+mHo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-660-tsqQ2h_9P6CyofEkBYS0nA-1; Thu, 30 Jun 2022 03:36:42 -0400
X-MC-Unique: tsqQ2h_9P6CyofEkBYS0nA-1
Received: by mail-wm1-f72.google.com with SMTP id e24-20020a05600c219800b003a0471b1904so1030821wme.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jun 2022 00:36:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PwzmZMvr1HwTOyfvLBeay0UNdb3hWyqojFY1Kj6edFc=;
        b=Mi1g8+ChmtSGoDB2us/Ubfi01Or+ino2l7AKgR7gyLj8qhRpOJcZcdCq48aUMK2lwG
         gQ0az0N09XGJ/QtiFqp3qIJFd3A0kV/AgfvKg6pku9bjUnh0ubCscuCKlCgZWDjT1PlE
         Ax+1KASJjeh5Y6Yp9JNLTxBk/kV+KZHTbtr1vAEGDzxBOYnju2l1XsI9FfXbg+67iOfP
         fcVWUi7ZtakWF0Ex+0rCxsJDgA75nCT4kLE+biZrkzR8JctmLeonLSWXZSbMOuQ4IWjK
         n1OH0QplheIobA0nkKJ/F9wB4S0ZAK7if66EJx9Tkb1WrrzyTRVKCphE6/yj4Rms4eT7
         EqfQ==
X-Gm-Message-State: AJIora9HRlVcGEe3MwMSP57eQvj3SAAzLSAKmQG9GdeBLQf9O+2f2HOa
        WrILJL01nhVzVWcCI8FWEowI51s0lX1l3xOh+rCj41vnuhA/liIkIe3t/vdhRq4R/tN9T0kJFeR
        FY8AaBSEQG1i6wwSQ3CKMUjbhYqFZO3LHteM+s0tjFUlg6A1b6FRrke2kugdETqp/xz0lZ6yBPK
        Ds
X-Received: by 2002:a5d:6704:0:b0:21b:8258:b773 with SMTP id o4-20020a5d6704000000b0021b8258b773mr6600904wru.284.1656574601153;
        Thu, 30 Jun 2022 00:36:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vE3BOs0DEpp+YFr2cGu7j4qggJVT3ycC/Awg1J1DjBCXCJeDvJEASklLYOzQTIogJGAkKlxA==
X-Received: by 2002:a5d:6704:0:b0:21b:8258:b773 with SMTP id o4-20020a5d6704000000b0021b8258b773mr6600874wru.284.1656574600876;
        Thu, 30 Jun 2022 00:36:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f20-20020a05600c155400b0039c41686421sm1868636wmg.17.2022.06.30.00.36.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jun 2022 00:36:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Jim Mattson <jmattson@google.com>
Cc:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 28/28] KVM: nVMX: Use cached host MSR_IA32_VMX_MISC
 value for setting up nested MSR
In-Reply-To: <CALMp9eRCbgYVGtAwpDWhytQSjeGeAOuqKZXVg3RpV92uKV5u0A@mail.gmail.com>
References: <20220629150625.238286-1-vkuznets@redhat.com>
 <20220629150625.238286-29-vkuznets@redhat.com>
 <CALMp9eRCbgYVGtAwpDWhytQSjeGeAOuqKZXVg3RpV92uKV5u0A@mail.gmail.com>
Date:   Thu, 30 Jun 2022 09:36:39 +0200
Message-ID: <87tu82siuw.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
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
>> vmcs_config has cased host MSR_IA32_VMX_MISC value, use it for setting
>> up nested MSR_IA32_VMX_MISC in nested_vmx_setup_ctls_msrs() and avoid the
>> redundant rdmsr().
>>
>> No (real) functional change intended.
>
> Just imaginary functional change? :-)
>

Well, yea) The assumption here is that MSR_IA32_VMX_MISC's value doesn't
change underneath KVM, caching doesn't change anything then. It is, of
course, possible that when KVM runs as a nested hypervisor on top of
something else, it will observe different values. I truly hope this is
purely imaginary :-)

>>
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Reviewed-by: Jim Mattson <jmattson@google.com>
>

Thanks!

-- 
Vitaly

