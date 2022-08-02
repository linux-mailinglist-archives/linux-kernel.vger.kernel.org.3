Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DF75587CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 15:03:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbiHBNDq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 Aug 2022 09:03:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232569AbiHBNDo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Aug 2022 09:03:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A36CB21A
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 06:03:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659445422;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=q9G2G8Gu5RKJUdwRd8+XrMp7icbYEK8BR98QSXem+dE=;
        b=EFTQrM9SX/fsG24jiGUleFYYVYx3wjXU7VUUiDK4JrWOFP6ppd6CJg909kYLRX0lcdR2SI
        cv2vF8FdOMZig5t8qaAgM2J2u6cmtoRTLFTmtcW1sPnKTbXYaod7kiNz5VsrXHqjXwAhWA
        FjI+kcoq2NQ1axXOOBDd1DioVW5DaeU=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-kPG58sSYNuGi68l28jHg1A-1; Tue, 02 Aug 2022 09:03:41 -0400
X-MC-Unique: kPG58sSYNuGi68l28jHg1A-1
Received: by mail-wm1-f70.google.com with SMTP id i131-20020a1c3b89000000b003a4f0932ec3so12980wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 Aug 2022 06:03:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=q9G2G8Gu5RKJUdwRd8+XrMp7icbYEK8BR98QSXem+dE=;
        b=ue5FVNTTrMcey5RzEQeAgQ04l8mC+CUt0IC1UjN5nlUHm5112DnxEy21ZQktQDeroD
         DWYujI71wjKA+ibuYwXoqgZnGkf0Awct6W3eMu5XEhclWxc+XxoDBNq15KJeF6vrXFFy
         /II3IQ2PvXB0zc6SbtkKPL0cg0eah82kfiorZ2x9gA9WTqKlJsY7GsySJ4cO9/XgaARo
         mWn48R0M5xdtue8bRAgqp28j5cNIgO1GkKTjyrZT0An9G6BYKUmiNdxUnYRxtJmulT2i
         9pHDyJJtGPA4b4ueT5Jjh4TdaDmmfc7zz4mHirjegJptb95LRox9wh1hYJQ48Gydjsfk
         ndfg==
X-Gm-Message-State: ACgBeo2ZtUz+2jTWeSYGcSuwpQ4Iye/5/r3IYduR2AqHHy1uWKwkFro9
        j3V61cJ7EWlpdBaEB3EIFOtB4fZnOl2J8ESqS3kiVYIRYZ9M2fSIFzpvPUd3J4eHt4xuylQe/k2
        C5drAGNeDuWkE845komBBfqOrObwx9cl6Nq3yfiLg0a26D+2xlWe6MoCRSsA60UsD6sIuWmNk40
        EO
X-Received: by 2002:a5d:64e2:0:b0:21d:38e8:2497 with SMTP id g2-20020a5d64e2000000b0021d38e82497mr12253769wri.142.1659445420302;
        Tue, 02 Aug 2022 06:03:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6DOS3SQRla4MpJdwzB2g2Z3+URqWp8A6RPEqmiNSoJz93I9qLSiQKDBTUSjxU0zCoo/8ZISQ==
X-Received: by 2002:a5d:64e2:0:b0:21d:38e8:2497 with SMTP id g2-20020a5d64e2000000b0021d38e82497mr12253733wri.142.1659445419933;
        Tue, 02 Aug 2022 06:03:39 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id f11-20020a05600c4e8b00b003a31673515bsm26399540wmq.7.2022.08.02.06.03.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Aug 2022 06:03:37 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <seanjc@google.com>
Cc:     kvm@vger.kernel.org,
        Anirudh Rayabharam <anrayabh@linux.microsoft.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        linux-hyperv@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 09/25] KVM: VMX: nVMX: Support TSC scaling and
 PERF_GLOBAL_CTRL with enlightened VMCS
In-Reply-To: <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
References: <20220714091327.1085353-1-vkuznets@redhat.com>
 <20220714091327.1085353-10-vkuznets@redhat.com>
 <YtnMIkFI469Ub9vB@google.com>
 <48de7ea7-fc1a-6a83-3d6f-e04d26ea2f05@redhat.com>
 <Yt7ehL0HfR3b97FQ@google.com>
 <870d507d-a516-5601-4d21-2bfd571cf008@redhat.com>
 <YuMKBzeB2cE/NZ2K@google.com>
 <62ac29cb-3270-a810-bad1-3692da448016@redhat.com>
Date:   Tue, 02 Aug 2022 15:03:35 +0200
Message-ID: <87les623x4.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 7/29/22 00:13, Sean Christopherson wrote:
>> The only flaw in this is if KVM gets handed a CPUID model that enumerates support
>> for 2025 (or whenever the next update comes) but not 2022.  Hmm, though if Microsoft
>> defines each new "version" as a full superset, then even that theoretical bug goes
>> away.  I'm happy to be optimistic for once and give this a shot.  I definitely like
>> that it makes it easier to see the deltas between versions.
>
> Okay, I have queued the series but I still haven't gone through all the 
> comments.

The biggest problem with this version is the EFER.LMA problem on i386
discovered (and, thankfully, fixed in the suggested patch) by
Sean. To address this and all other comment I'm going to put together a
v5 on top of the current kvm/queue (as I don't yet see any of this stuff
there).

>  So this will _not_ be in the 5.21 pull request.

At first I thought you meant 5.20 but then I got the pun: 5.20 will
likely become 6.0 and so 5.21 pull request will just never happen :-)

-- 
Vitaly

