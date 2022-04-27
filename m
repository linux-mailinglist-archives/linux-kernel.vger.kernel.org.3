Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CA78511328
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 10:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359239AbiD0IHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 04:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243567AbiD0IHL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 04:07:11 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A70151585
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 01:04:00 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651046639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NVrj/IozLz+YLWMa6Aoyk1/gX+kCZfAflMvOSoBkH+U=;
        b=hRfN7NDAQ6mU9wp5eFxj+DYfCHPs9azOITyD2BKrRWG0JFePx7KCJTmu+rNLr5KB3sXW5m
        vD/VA9RgieHmpARGPQt4YAUGCf0frQwHN3SPu+ooQNKpBLtV0wEgIGpF5mEEq0Jpw+mBOG
        +bCQM8MpHbOGL61wq2Iru3KuEqA5ZaRI1f+1RhkI6xuO2jDNkldnVpBIu/ertS1HOUp+xB
        vH1KfL8RhmkqWeLBMeKAUFX5CT72lcolpIDSGbWepumi2Onr8hsbJK3SLPmTp1jtxV+Xyk
        i+Q2GSF6aEMASPkWEzy2NYL5DM8vwRCievUk/6Xh4aoaqAUl7eqh+2b/sERsIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651046639;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NVrj/IozLz+YLWMa6Aoyk1/gX+kCZfAflMvOSoBkH+U=;
        b=IPl5zJQ4XmUiSpIBPJlMNPVh+Fw5TE3wmL6lz2+trLDTLAUelYj15SAtSOpdktYrXScZCb
        eP50UJN3nNpdjkAw==
To:     Marcelo Tosatti <mtosatti@redhat.com>, linux-kernel@vger.kernel.org
Cc:     Nitesh Lal <nilal@redhat.com>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Alex Belits <abelits@belits.com>, Peter Xu <peterx@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Oscar Shiang <oscar0225@livemail.tw>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [patch v12 07/13] task isolation: sync vmstats conditional on
 changes
In-Reply-To: <20220315153314.042469218@fedora.localdomain>
References: <20220315153132.717153751@fedora.localdomain>
 <20220315153314.042469218@fedora.localdomain>
Date:   Wed, 27 Apr 2022 10:03:58 +0200
Message-ID: <87tuafx89d.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 15 2022 at 12:31, Marcelo Tosatti wrote:
>  
> +#ifdef CONFIG_TASK_ISOLATION
> +struct static_key vmstat_sync_enabled;

jump_label.h:

"The use of 'struct static_key' directly, is now DEPRECATED."

> +DEFINE_PER_CPU_ALIGNED(bool, vmstat_dirty);
> +
> +static inline void mark_vmstat_dirty(void)
> +{
> +	if (!static_key_false(&vmstat_sync_enabled))
> +		return;
> +
> +	raw_cpu_write(vmstat_dirty, true);

What's the justification for raw_cpu_write()?

>  
> @@ -1512,6 +1543,7 @@ static void pagetypeinfo_showfree_print(
>  		}
>  		seq_putc(m, '\n');
>  	}
> +	mark_vmstat_dirty();

Why does a function which just dumps information via /proc/pagetypeinfo
make vmstats dirty?

Thanks,

        tglx
