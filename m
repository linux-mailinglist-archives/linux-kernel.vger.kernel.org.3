Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98174F8134
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 16:01:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237509AbiDGODs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 10:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232037AbiDGODq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 10:03:46 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6CE7CA0BD3
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 07:01:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649340103;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iPVjUD4VGANcIQRfm5QWOv0d3iQPwruTr6X8FPFV1Gg=;
        b=eMZe9Jeu2JWiugzr+686Syu3U4+J1RTvr1cPNIma0uRrYGxRxCeSIjdbLXQCeuoIpfwJEX
        tPiVukqv/lKiUHVjLKE0t7F4rKr+M0Q4qn25eXFsB05R0h3oC/CvFFd6Hz8n57xcztWzZi
        TTL4Xuj8B9y+MNw/mhRq2JRzyhbk5do=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-312-GGf6Ci9uOWGsebKwvaYGgA-1; Thu, 07 Apr 2022 10:01:42 -0400
X-MC-Unique: GGf6Ci9uOWGsebKwvaYGgA-1
Received: by mail-wm1-f69.google.com with SMTP id q6-20020a1cf306000000b0038c5726365aso3017819wmq.3
        for <linux-kernel@vger.kernel.org>; Thu, 07 Apr 2022 07:01:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=iPVjUD4VGANcIQRfm5QWOv0d3iQPwruTr6X8FPFV1Gg=;
        b=1l2/xOgQyP/mqQvABf9dBmO9XT+q3LwTqy4cl81SalNS6yG7QjyX3LqA69rVs0nVC/
         mvy/UvL6D7vKzrR5tsQE+cdPhd8dTwa/W3+Nl0vauvO4fhrY7i70vWz3kw+9qA7pogpJ
         7aqDbYPgtuStb9+BYFSHcBgl75JGI14f3WowjH6Jw5Yidbupy2/Gj5gg40iRJ91si+ce
         KMpaR4INfsslLmjyGoedicwdsOTvlj1XUOoDpFnGFx0TaRoUaXTpf/WaHrjAG9ZyONQQ
         ChSumsGGIr7lW/VHXvQuFCPaGm0VjtJFwBZl1cjnOthAOvblBASddfyXHjWIulb+U8jY
         czzQ==
X-Gm-Message-State: AOAM533DJNYxVgq/rIF/YO/Ro8wGUd/NyuL3gr+7BaOVoWmcylX9osax
        5Za7u+VY3PAscenGofRZWh0KNvTinWtrTsKEdtoBBuYV2nqreMDAfOyvpchoipJ1JcBB400GNtQ
        VeTkjvKvIYDaeWSTnRb9mlAg2
X-Received: by 2002:a05:600c:1910:b0:38c:bff7:b9db with SMTP id j16-20020a05600c191000b0038cbff7b9dbmr12633648wmq.182.1649340100896;
        Thu, 07 Apr 2022 07:01:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxU/dYZtfiATAomIrnRvl8FEyxkNIr3CwJEqCIWLwzLHA8afMCdfS5sdwqZVv6K+GTlXvZw4A==
X-Received: by 2002:a05:600c:1910:b0:38c:bff7:b9db with SMTP id j16-20020a05600c191000b0038cbff7b9dbmr12633611wmq.182.1649340100678;
        Thu, 07 Apr 2022 07:01:40 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id v1-20020adf9e41000000b00205c3d212easm17786210wre.51.2022.04.07.07.01.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 07:01:40 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <seanjc@google.com>,
        Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>, kvm list <kvm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Shuah Khan <shuah@kernel.org>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: WARNING: at arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156
 mark_page_dirty_in_slot
In-Reply-To: <YkMxGLAG0zqEzt1V@google.com>
References: <CA+G9fYsd+zXJqsxuYkWLQo0aYwmqLVA_YeBu+sr546bGA+1Nfg@mail.gmail.com>
 <YkMxGLAG0zqEzt1V@google.com>
Date:   Thu, 07 Apr 2022 16:01:39 +0200
Message-ID: <87tub56lh8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <seanjc@google.com> writes:

> On Tue, Mar 29, 2022, Naresh Kamboju wrote:
>> While running kselftest kvm test cases on x86_64 devices the following
>> kernel warning was reported.
>
> ...
>
>> [   62.510388] ------------[ cut here ]------------
>> [   62.515064] WARNING: CPU: 1 PID: 915 at
>> arch/x86/kvm/../../../virt/kvm/kvm_main.c:3156
>> mark_page_dirty_in_slot+0xba/0xd0
>> [   62.525968] Modules linked in: x86_pkg_temp_thermal fuse
>> [   62.531307] CPU: 1 PID: 915 Comm: hyperv_clock Not tainted 5.17.0 #1
>> [   62.537691] Hardware name: Supermicro SYS-5019S-ML/X11SSH-F, BIOS
>> 2.0b 07/27/2017
>> [   62.545185] RIP: 0010:mark_page_dirty_in_slot+0xba/0xd0
>
> Long known issue.  I think we're all waiting for someone else to post an actual
> patch.
>
> Vitaly, can you formally post the below patch, or do you need feedback first?
>
> https://lore.kernel.org/all/874k51eddp.fsf@redhat.com/
>

Sorry, missed this. Will do.

-- 
Vitaly

