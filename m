Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 879E44EDBBC
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 16:33:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237536AbiCaOfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 31 Mar 2022 10:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbiCaOfH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 31 Mar 2022 10:35:07 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 590BBB86C
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648737197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PCSbQr6xvWn8hoYvS5YW2D5+aEPHScZTxNMPCPMZ7KE=;
        b=IZ0i+bqFu9O0Btm6Rvq2pzi0lIn/3O8dhlqX9cbLCGVNzyfB/6bpSPS+Od2rRmZzed854E
        Q0BSxgR0qd503fSLzrUR+yXz4llOoUIoEuxly3j6ncL+x/4x9yNKfuUmKkydTS0do5rSC0
        QN9YuhdEiT3aS+rPSgzTc9AiFTnOvkE=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-639-k88NeU_JMBS2FZrCMxFkyg-1; Thu, 31 Mar 2022 10:33:15 -0400
X-MC-Unique: k88NeU_JMBS2FZrCMxFkyg-1
Received: by mail-wr1-f69.google.com with SMTP id h33-20020adf9024000000b00203fcba8aadso6536019wrh.15
        for <linux-kernel@vger.kernel.org>; Thu, 31 Mar 2022 07:33:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PCSbQr6xvWn8hoYvS5YW2D5+aEPHScZTxNMPCPMZ7KE=;
        b=zdylkIX5hpHou9D7BkW+KhxcMb82cjbMutItdzEx1VnOPp0ZvroIj4Io+ZUTgiu5UZ
         WYguKw0GCCi9vLfGaDke5FbeC3Lgj19FLfJTDz7sPkZKQF9kDnP8INKuwGwSsyYxGvzk
         5srSyaM0L0uYT+smydVKJvCd3VkzNZevqcU0XQHUJQvFJ85Ub/e2MlnjPkVuahZ3mPXa
         pm/USrfaB8qihs9G+/z8rySsC2WJhWfpxyATjdTzXBvj4lWOD+rd0C1uuHFvKAhXL1de
         vb012+PvTzLREirDDyp2rhyIaedgpbeYsv3FMMBt7tQEDS9f9fRAjOiqsqCsG2laJ1D0
         4+BA==
X-Gm-Message-State: AOAM532UQnkHpDfQfEp/kjXd338+l6//zscpTZxgWVnUXYlrVXXTkxwW
        Ur6YraXm7sMFwmNbipvkM49y3laTxW+bneNJjomCcyzv5MtaQD4bXiOC47FRMTMl2l26yqkJV4N
        X+qJYjpyzvy2JgX/YatSM5p8=
X-Received: by 2002:a5d:6484:0:b0:205:8a53:f365 with SMTP id o4-20020a5d6484000000b002058a53f365mr4335875wri.121.1648737193232;
        Thu, 31 Mar 2022 07:33:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxGMXY7sBuPd9yAeY8pTRD2a8bEE8tmyiCLp9R8jU86g/AB/ez6PndB+arGWU39QAEbGiqygA==
X-Received: by 2002:a5d:6484:0:b0:205:8a53:f365 with SMTP id o4-20020a5d6484000000b002058a53f365mr4335859wri.121.1648737193001;
        Thu, 31 Mar 2022 07:33:13 -0700 (PDT)
Received: from localhost (cpc111743-lutn13-2-0-cust979.9-3.cable.virginm.net. [82.17.115.212])
        by smtp.gmail.com with ESMTPSA id 7-20020a05600c028700b0038cc9bfe6a4sm7054074wmk.37.2022.03.31.07.33.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 31 Mar 2022 07:33:11 -0700 (PDT)
Date:   Thu, 31 Mar 2022 15:33:10 +0100
From:   Aaron Tomlin <atomlin@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     Aaron Tomlin <atomlin@atomlin.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Christoph Lameter <cl@linux.com>, tglx@linutronix.de,
        mingo@kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Phil Auld <pauld@redhat.com>
Subject: Re: [RFC PATCH] tick/sched: Ensure quiet_vmstat() is called when the
 idle tick was stopped too
Message-ID: <20220331143310.vhsnywx3z7obdycf@ava.usersys.com>
X-PGP-Key: http://pgp.mit.edu/pks/lookup?search=atomlin%40redhat.com
X-PGP-Fingerprint: 7906 84EB FA8A 9638 8D1E  6E9B E2DE 9658 19CC 77D6
References: <20220203214339.1889971-1-atomlin@redhat.com>
 <20220217124729.GA743618@lothringen>
 <20220217142615.xqtiydixvnumyvei@ava.usersys.com>
 <20220217163205.GA748087@lothringen>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220217163205.GA748087@lothringen>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-02-17 17:32 +0100, Frederic Weisbecker wrote:
> Then I can see two other issues:
> 
> 1) Can an interrupt in idle modify the vmstat and thus trigger the need to
>    flush it? I believe it's the case and then the problem goes beyond nohz_full
>    because if the idle interrupt fired while the tick is stopped and didn't set
>    TIF_RESCHED, we go back to sleep without calling quiet_vmstat().
> 
> 2) What if we are running task A in kernel mode while the tick is stopped
>    (nohz_full). Task A modifies the vmstat and goes to userspace for a long
>    while.
> 
> Your patch fixes case 1) but not case 2). The problem is that TIMER_DEFERRABLE
> should really be about dynticks-idle only and not dynticks-full. I've always
> been afraid about enforcing that rule though because that would break old
> noise-free setups. But perhaps I should...

Hi Frederic,


Firstly, apologies for the delay.

In reference to case 2:

If I understand correctly, even if TIMER_DEFERRABLE is removed
refresh_cpu_vm_stats() cannot be invoked since the scheduling-clock tick is
disabled i.e. non-deferrable timers are serviced by the tick, no?
So, the only option would be to interrupt the workload - not desirable - or
detect any remaining differentials prior to entering userspace?


Kind regards,

-- 
Aaron Tomlin

