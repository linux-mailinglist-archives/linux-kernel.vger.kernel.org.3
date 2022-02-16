Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F0A34B8B83
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 15:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235090AbiBPOeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 09:34:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:36816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229379AbiBPOea (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 09:34:30 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8D70C2A520B
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645022056;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uAZTsZWbYnZinl4NvmWIbH2gwEcwA0kzPtah3A0t9z8=;
        b=KAmkwMMixQlpoQ+saS9f/0n5o0aU3bihhgH2kuA+fteuWo02vh8oy753wtGe9QmOuf75NN
        Im+mWppdliwKJjelfHmmrH/6rmI8ou8k+qZLbp5hq2tH6p4bPfFP7X8P2bMPgSIy07ld26
        HT3WMI26MIfhQayKuVVzB6O5QeHj8n8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-484-4-MGS2UiMAGTTW2wAYqUQQ-1; Wed, 16 Feb 2022 09:34:15 -0500
X-MC-Unique: 4-MGS2UiMAGTTW2wAYqUQQ-1
Received: by mail-wr1-f71.google.com with SMTP id k3-20020adfb343000000b001e463e6af20so1147250wrd.8
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 06:34:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uAZTsZWbYnZinl4NvmWIbH2gwEcwA0kzPtah3A0t9z8=;
        b=sY4Nry6HboIJY4u39Hq2NxAdmBgwa3M3smTOdLlpcbEL73jH2xPMd0yE/dRUgvinWw
         vjNrAnTUrLPvsgVldN8liaFYM7CMQoglZHYk8iI84Fu+GFDf+P9Aj3D5tI8EaUz1H3Y6
         yxxkNfMcEH6zohts2O3NqtXBu7ed6kv2DpSxAcNUUjKnoAF2ZvsOzPN1XhJrWusdCjRk
         8nI6g7KZVQOiBXjZDpGeSm57uFOFpKNqpCLz9D+g/InVExWQCRWsFxRGiPBWEG4EGl3v
         hkNlJCi+WBWN0bDcFOy0B5D0LEZlUHHDQl0Xw0Wn2xCNyHEnPR/jVkK0WBKwsU2cGQPg
         SCKA==
X-Gm-Message-State: AOAM531tS7TVVJCAD+KKy2+kl8ErIr/HUQoTnaginkHtwnKuWhOO0IRG
        wP6/9Go6ntt2oKrAV81HdXjbqFfnoAcQ/ukbPaN3RYGmDet+I6/qR0oz0xNVzrNqh8/5viwfzDv
        D4/EoBYvnMdpfwrTiXI1aDHQ=
X-Received: by 2002:a05:600c:364a:b0:37b:ac5d:b77b with SMTP id y10-20020a05600c364a00b0037bac5db77bmr1893320wmq.82.1645022054231;
        Wed, 16 Feb 2022 06:34:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzzApKQp57v8R5P0ECy6xhaxHgRhVyGNnH56VU0prns/IVuxgeGt0IWLf+ZxRJdmdEh/jD6kg==
X-Received: by 2002:a05:600c:364a:b0:37b:ac5d:b77b with SMTP id y10-20020a05600c364a00b0037bac5db77bmr1893300wmq.82.1645022053978;
        Wed, 16 Feb 2022 06:34:13 -0800 (PST)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id l12sm32506343wrs.11.2022.02.16.06.34.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Feb 2022 06:34:13 -0800 (PST)
Date:   Wed, 16 Feb 2022 14:34:12 +0000
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Phil Auld <pauld@redhat.com>
Cc:     frederic@kernel.org, tglx@linutronix.de, mingo@kernel.org,
        mingo@redhat.com, atomlin@atomlin.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220216143412.dwxjlkq4w2zeweld@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <YfxVpEO+UJTC+a9e@lorien.usersys.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YfxVpEO+UJTC+a9e@lorien.usersys.redhat.com>
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-03 17:22 -0500, Phil Auld wrote:
> As I said earlier, I don't think you want to call quiet_vmstat()
> unconditionally. And I don't think this will catch the cases you are
> trying to fix. Once the tick is stopped tick_nohz_stop_tick should not be
> getting called again until it's been restarted.

Phil,

Sorry about the delay. If I understand correctly, I see a scenario by which
tick_nohz_stop_tick() can be called on transition/or exit from idle (e.g.
default_idle_call()):

	1.	The idle/or scheduling-clock was previously
		stopped

	2.	It is considered safe for the scheduling-clock
	        tick to remain "stopped"/or omitted; no need to
		reprogram and enable a periodic tick
		(e.g. no queued/or expired pending timer)

	  ...
            do_idle
	      cpuidle_idle_call
	      {

		...

	.--     default_idle_call
	|         arch_cpu_idle
	|         goto exit_idle
        |
        |       exit_idle:
	|         __current_set_polling()
        |
	|     }
        |     tick_nohz_idle_exit()
        |     {
        |
        |       tick_stopped = ts->tick_stopped
        |
        |       if (tick_stopped)
        |         tick_nohz_idle_update_tick(ts, now)
        |           if (tick_nohz_full_cpu(smp_processor_id()))
        |             __tick_nohz_full_update_tick(ts, now)
        |             {
        |               int cpu = smp_processor_id()
        |
        |               if (can_stop_full_tick(cpu, ts))
        |                 tick_nohz_stop_sched_tick(ts, cpu)
        |                   if (tick_nohz_next_event(ts, cpu))
        '--                   tick_nohz_stop_tick(ts, cpu)
                      }
              }

If I understand correctly, __tick_nohz_full_update_tick() can return with
no changes to the current tick (e.g. expire time == KTIME_MAX), no?


Kind regards,

-- 
Aaron Tomlin

