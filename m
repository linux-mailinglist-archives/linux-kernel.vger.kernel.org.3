Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97F84597475
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 18:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240360AbiHQQs5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 12:48:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240641AbiHQQsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 12:48:53 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B4012AC6B
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:48:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660754928;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=5DFVkzD/EoUahef5UFlOF/HjlPxQz4n3aaKR684FIcs=;
        b=HkQyS+fjQ+z5VM1+eS49KQWufkYfCVGoB4zuCs+ReuqyTD2z+go87x6OXhd9OxK9F/de+v
        Q07wfkYZ54NtTiK3580eb8wQVOpEwzudaU8cbYv64KnfmzB7lu2DyREP1UlAP6Goo5+eqm
        EagKw852FNVyj2mh+k+6hx8zIe/z3Tk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-146-WuDxAH3CNNO5RnuHcRW-6w-1; Wed, 17 Aug 2022 12:48:47 -0400
X-MC-Unique: WuDxAH3CNNO5RnuHcRW-6w-1
Received: by mail-wm1-f69.google.com with SMTP id c64-20020a1c3543000000b003a61987ffb3so587478wma.6
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 09:48:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=5DFVkzD/EoUahef5UFlOF/HjlPxQz4n3aaKR684FIcs=;
        b=KlMTQfh7w3b2dRuy/lWmBctQJJgzvFWV73O6kgKFMf+x5CE3B5gkrQqmKfCMQxuUXi
         Uzr987E8Y5kqr2zeDt+17G6o3JkENcWwW1K9wc/eUQH6pXapH/AB2+4IxTqe+k3C39Gm
         5Dw6hgmufdAiU/jMcg5n2XPbZe2AU0IAHqG+BWeoUOkg7PrnJ7Nc+tmMcYSu7tEY0B9q
         XT/bsqs3jOSMg8uNaxo6kLlVST2+Bv4HW2CNDA3TNKCwO8SHEugt/OoRqmztwFfCOvu9
         2DnLMFN/8mB/CnWIWx+tI+wrhVPoF2/cgoEua2vV1Hh4CU3ZhHrzENgZdFuZxFINmazw
         bzsw==
X-Gm-Message-State: ACgBeo2nMSeSW2vrxKnkMGhZmgTWBxbLyDpCdKDEMQvXmglrTj2l/i8Y
        pDu3bdr99fh8SmNbd85kcUSYp/Qxna53j4ZpnbkRVigFTACoUl4owFMGznBrWRoMhHYbYtuHyO7
        0O8oSMTEt9tBj39Sc5B0KhQw=
X-Received: by 2002:a05:6000:1d84:b0:224:f447:b1a7 with SMTP id bk4-20020a0560001d8400b00224f447b1a7mr11173078wrb.688.1660754926620;
        Wed, 17 Aug 2022 09:48:46 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5i4dXA6MKTm6lpvo4WUCwQkLL4WH0t9yjfFoqhof/ix+iWvYDvswDU/v+Dl7p87H00CRUIvw==
X-Received: by 2002:a05:6000:1d84:b0:224:f447:b1a7 with SMTP id bk4-20020a0560001d8400b00224f447b1a7mr11173062wrb.688.1660754926407;
        Wed, 17 Aug 2022 09:48:46 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id x15-20020a5d490f000000b002205a5de337sm13271283wrq.102.2022.08.17.09.48.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 09:48:45 -0700 (PDT)
Date:   Wed, 17 Aug 2022 17:48:44 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Marcelo Tosatti <mtosatti@redhat.com>
Cc:     frederic@kernel.org, cl@linux.com, tglx@linutronix.de,
        mingo@kernel.org, peterz@infradead.org, pauld@redhat.com,
        neelx@redhat.com, oleksandr@natalenko.name, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH v6 2/2] tick/sched: Ensure quiet_vmstat() is called when
 the idle tick was stopped too
Message-ID: <20220817164844.zyypokjmzjfznuhu@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220808194820.676246-1-atomlin@redhat.com>
 <20220808194820.676246-3-atomlin@redhat.com>
 <YvvdtwrIX+TUgn3A@fuller.cnet>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YvvdtwrIX+TUgn3A@fuller.cnet>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue 2022-08-16 15:11 -0300, Marcelo Tosatti wrote:
> Aaron,
> 
> It is also necessary to remove the delayed_work_pending check from
> quiet_vmstat:
> 
> @@ -1987,10 +1970,7 @@ void quiet_vmstat(void)
>         if (system_state != SYSTEM_RUNNING)
>                 return;
>  
> -       if (!delayed_work_pending(this_cpu_ptr(&vmstat_work)))
> -               return;
> -
> -       if (!need_update(smp_processor_id()))
> +       if (!__this_cpu_read(vmstat_dirty))
>                 return;
>  
> 
> Because, consider the following situation:
> 
> 
> vmstat_shepherd CPU				nohz_full CPU
> 
> 						
> 						vmstat_dirty = false
> 						enter nohz_full
> 						return to userspace
> check vmstat_dirty, unset,
> delayed work cancelled.
> 						dirties per-CPU vmstats
> 						vmstat_dirty = true
> 						return to userspace
> 						(quiet_vmstat will skip
> 						 clearing stats because
> 						 delayed work was not queued).

Hi Marcelo,

Yes, I agree - the above scenario can occur.


Kind regards,

-- 
Aaron Tomlin

