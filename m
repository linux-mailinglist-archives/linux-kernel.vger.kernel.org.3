Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 469005A6B07
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Aug 2022 19:44:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiH3RoX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Aug 2022 13:44:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbiH3RoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Aug 2022 13:44:05 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C466558CE
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:40:59 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id s206so11314978pgs.3
        for <linux-kernel@vger.kernel.org>; Tue, 30 Aug 2022 10:40:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=X7JitvZ40xFd8j5KzH/sIuPG4bhnsbnZMIdQrR5Fai0=;
        b=b4Wz9KZiIfUfCTKt2eJ+DnUUT9wp4nBUCi5RRVpJp41rXdOaKz298FzBnW1J6Xfq4X
         5696Kh9mgNcyS5yoWO3qUQiPMJoeAi1kW8bCY/Om0faGdH9Izvx7lud7OxO3Xf1c8Tnk
         vhA8ZN+ST6xIjVt+MBf9HdGYK7iWL9uyfuIud1g5xzHrHENAxFgxOwn4bUTMAz/h97jI
         J2P0c5K6/7u+HXgz2APwqlTd05LWOXYKLyAjnVL4sw/JNOGwxJR9Ch6cyYuT+xl0R9Rp
         xKPOmTomUE3jIzrYyhs37pQNTc6Hldm6vIeHzXKew6qpVwUqhD/LBz8wJqdIVZQ7NgwC
         KTtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=X7JitvZ40xFd8j5KzH/sIuPG4bhnsbnZMIdQrR5Fai0=;
        b=R++ieysPWtSGC+Tl1HWo68zPNBsd5SZBTzF0HhEJQCtX4nBux5ggZTdD6i57uvp7tW
         iR9eWcS8w7v8EX5dE6+3xyWv36s89x7sTVl38oFnQkUyauQAzVDpROJByibOp3xlmV2D
         dWHmZXPif4qfc265i4h9hBGYYDfzzrEaBpOmFbI8LUJ9vy57zCzQhc/cthPLhi6rKppx
         1fMfI5l7xAcZbUi9IwDDsF9lhgq9uw+3E1XGKQ5lA3A0Vo5ik3rSKTMJOwif5ebPpuDI
         Pe2ORD+iMUr9P6ti1c83HZYJLCnBhpdOd2YimTQYXWsu9OgQBFQSPzq5Mp3mp8mPad5B
         UTxg==
X-Gm-Message-State: ACgBeo2K+oI3ndD9F91sOBJgNIX37Y+cwvsWAk9ffUJBaw0VlNShHkSa
        Ob3k5UVhot6Sk+OhkvXcoFDF8RN6NTnYSg==
X-Google-Smtp-Source: AA6agR4bXjThSD2dacT//3gKZ0o1hAghStfDSJzk9bLdtQvwFZwf3GzKCKzF+wm0xZ9+D0FdEn8T/Q==
X-Received: by 2002:a05:6a00:1996:b0:52e:b0f7:8c83 with SMTP id d22-20020a056a00199600b0052eb0f78c83mr22489521pfl.59.1661881236647;
        Tue, 30 Aug 2022 10:40:36 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id m18-20020a170902f65200b001732a019dddsm9957288plg.174.2022.08.30.10.40.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Aug 2022 10:40:36 -0700 (PDT)
Date:   Tue, 30 Aug 2022 17:40:32 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH RESEND v2 1/8] perf/x86/core: Completely disable guest
 PEBS via guest's global_ctrl
Message-ID: <Yw5LkLhzTRa1Zxzb@google.com>
References: <20220823093221.38075-1-likexu@tencent.com>
 <20220823093221.38075-2-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220823093221.38075-2-likexu@tencent.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 23, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> When a guest PEBS counter is cross-mapped by a host counter, software
> will remove the corresponding bit in the arr[global_ctrl].guest and
> expect hardware to perform a change of state "from enable to disable"
> via the msr_slot[] switch during the vmx transaction.
> 
> The real world is that if user adjust the counter overflow value small
> enough, it still opens a tiny race window for the previously PEBS-enabled
> counter to write cross-mapped PEBS records into the guest's PEBS buffer,
> when arr[global_ctrl].guest has been prioritised (switch_msr_special stuff)
> to switch into the enabled state, while the arr[pebs_enable].guest has not.
> 
> Close this window by clearing invalid bits in the arr[global_ctrl].guest.
> 
> Fixes: 854250329c02 ("KVM: x86/pmu: Disable guest PEBS temporarily in two rare situations")
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---
>  arch/x86/events/intel/core.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
> index 2db93498ff71..75cdd11ab014 100644
> --- a/arch/x86/events/intel/core.c
> +++ b/arch/x86/events/intel/core.c
> @@ -4052,8 +4052,9 @@ static struct perf_guest_switch_msr *intel_guest_get_msrs(int *nr, void *data)
>  		/* Disable guest PEBS if host PEBS is enabled. */
>  		arr[pebs_enable].guest = 0;
>  	} else {
> -		/* Disable guest PEBS for cross-mapped PEBS counters. */
> +		/* Disable guest PEBS thoroughly for cross-mapped PEBS counters. */
>  		arr[pebs_enable].guest &= ~kvm_pmu->host_cross_mapped_mask;
> +		arr[global_ctrl].guest &= ~kvm_pmu->host_cross_mapped_mask;
>  		/* Set hw GLOBAL_CTRL bits for PEBS counter when it runs for guest */
>  		arr[global_ctrl].guest |= arr[pebs_enable].guest;
>  	}

Please post this as a separate patch to the perf folks (Cc: kvm@).
