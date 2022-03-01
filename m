Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6297D4C96DE
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:26:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238379AbiCAU06 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:26:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239212AbiCAUYf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:24:35 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4DBD9BD6
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:22:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646166142;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=afO6tVXgk/44QRrigzeqCyc7zYs4NKCHyGdl1A3TxuE=;
        b=IelG7sZMmAMpXUIC0GQXxKZU49HlwlZtqRu81h/Ao4agOiyOBHVI3Px6z2kP7d/xEUPKkL
        DZvjwaDg1AleCMLSDyjCe9Jg/8UlslXVTHYvCGXBrAZ6b6vwlNn9v4gq/5qa3JF7F664Wm
        5K7oJT32eepFJ+4nt1WY7sgLnUiZGvE=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-635-AU6OMA6jOvauREATUhSSRg-1; Tue, 01 Mar 2022 15:22:21 -0500
X-MC-Unique: AU6OMA6jOvauREATUhSSRg-1
Received: by mail-wr1-f71.google.com with SMTP id k20-20020adfc714000000b001e305cd1597so3740466wrg.19
        for <linux-kernel@vger.kernel.org>; Tue, 01 Mar 2022 12:22:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=afO6tVXgk/44QRrigzeqCyc7zYs4NKCHyGdl1A3TxuE=;
        b=Aw9jqsfFOsj+xuYkcwbgFyR7CwteqbhrnNCc4ojO6zsAOqY0Y+g/J12krZn/k8ajl0
         jpCMaKl4lO7ZRtNXdpnizPbe1fyqWRKWLpiuwvG+SgXbK54LGjwx21mjXIfWCqj0uGm0
         /QdDQVF9vc4yjj7/IBc0E38g0DdI/zUhgTMpo1C3mFKUxsiM1BSLjO6GGwjXyhUQ8waS
         HvW0Rfh4dpsY7L852TboRj7vtZh8lbUPLzxElEy9k8lWK5ikNmIMIIutzKZpHMuK+vF1
         kaHqFnCd2dzLbntLyuGiy3BMdbkPORIRWroPVpCDQ0wyRAv8KCkiNXirSnkKawkqbxYw
         Dw1w==
X-Gm-Message-State: AOAM531C5vyNIMp3yPVhTuMAQB59VrU+rqv+r29bgZ392uEQwfeHWi+G
        it4Q3OguuAHTXndzWeDpLG5W5sfZUyynJEUQQoTMgW7IYO+hA0qvjT1CEk+m0BUNowV8NX0FYwk
        89mitwYXY9GiW+aKrZAs+daQJ
X-Received: by 2002:a1c:f617:0:b0:383:5aab:9c51 with SMTP id w23-20020a1cf617000000b003835aab9c51mr291667wmc.79.1646166140526;
        Tue, 01 Mar 2022 12:22:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzwr13telToZtSzN/w7BmWg66Pm80pZ7pLJeriiz+zVQ61Xnj+4nQJLimirDLghYYkM+Wu+6g==
X-Received: by 2002:a1c:f617:0:b0:383:5aab:9c51 with SMTP id w23-20020a1cf617000000b003835aab9c51mr291656wmc.79.1646166140324;
        Tue, 01 Mar 2022 12:22:20 -0800 (PST)
Received: from ?IPV6:2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e? ([2001:b07:6468:f312:5e2c:eb9a:a8b6:fd3e])
        by smtp.googlemail.com with ESMTPSA id r17-20020a056000015100b001ea7db074cdsm20019421wrx.117.2022.03.01.12.22.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 01 Mar 2022 12:22:19 -0800 (PST)
Message-ID: <3fee5315-e55d-278c-e522-d0e6fb2cadd0@redhat.com>
Date:   Tue, 1 Mar 2022 21:22:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH AUTOSEL 5.4 02/11] KVM: Fix lockdep false negative during
 host resume
Content-Language: en-US
To:     Sasha Levin <sashal@kernel.org>, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Cc:     Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org
References: <20220301201951.19066-1-sashal@kernel.org>
 <20220301201951.19066-2-sashal@kernel.org>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220301201951.19066-2-sashal@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/1/22 21:19, Sasha Levin wrote:
> From: Wanpeng Li <wanpengli@tencent.com>
> 
> [ Upstream commit 4cb9a998b1ce25fad74a82f5a5c45a4ef40de337 ]
> 
> I saw the below splatting after the host suspended and resumed.
> 
>     WARNING: CPU: 0 PID: 2943 at kvm/arch/x86/kvm/../../../virt/kvm/kvm_main.c:5531 kvm_resume+0x2c/0x30 [kvm]
>     CPU: 0 PID: 2943 Comm: step_after_susp Tainted: G        W IOE     5.17.0-rc3+ #4
>     RIP: 0010:kvm_resume+0x2c/0x30 [kvm]
>     Call Trace:
>      <TASK>
>      syscore_resume+0x90/0x340
>      suspend_devices_and_enter+0xaee/0xe90
>      pm_suspend.cold+0x36b/0x3c2
>      state_store+0x82/0xf0
>      kernfs_fop_write_iter+0x1b6/0x260
>      new_sync_write+0x258/0x370
>      vfs_write+0x33f/0x510
>      ksys_write+0xc9/0x160
>      do_syscall_64+0x3b/0xc0
>      entry_SYSCALL_64_after_hwframe+0x44/0xae
> 
> lockdep_is_held() can return -1 when lockdep is disabled which triggers
> this warning. Let's use lockdep_assert_not_held() which can detect
> incorrect calls while holding a lock and it also avoids false negatives
> when lockdep is disabled.
> 
> Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
> Message-Id: <1644920142-81249-1-git-send-email-wanpengli@tencent.com>
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>   virt/kvm/kvm_main.c | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index f31976010622f..adda0c6672b56 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -4427,9 +4427,7 @@ static int kvm_suspend(void)
>   static void kvm_resume(void)
>   {
>   	if (kvm_usage_count) {
> -#ifdef CONFIG_LOCKDEP
> -		WARN_ON(lockdep_is_held(&kvm_count_lock));
> -#endif
> +		lockdep_assert_not_held(&kvm_count_lock);
>   		hardware_enable_nolock(NULL);
>   	}
>   }

Acked-by: Paolo Bonzini <pbonzini@redhat.com>

