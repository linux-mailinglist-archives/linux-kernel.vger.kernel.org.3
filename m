Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED5C056653F
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:42:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiGEImD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229826AbiGEImB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:42:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 39C4B6459
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657010520;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PBMOa/d2tjfgeB/QHIx1dN7myWa507lkje9vgtYdk1M=;
        b=DTQelUl8wKFVnoju4QcxlPChq7wYxmiirhh9V6Y0bhhyW6ncDpP/FH6MWZZM3e92BYh9Fh
        sHTEQvEj1npoVlQGB4j/5q+arbxfjBdDztdHhJjLbnaJ9gYh3KH58WiBb4/OV8UYHUI1CI
        rhi59SDolJOw8tZi5w6eDtSEWqIq2m8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-575-IESLkTDaMHO71Fs17u0dnw-1; Tue, 05 Jul 2022 04:41:29 -0400
X-MC-Unique: IESLkTDaMHO71Fs17u0dnw-1
Received: by mail-wr1-f72.google.com with SMTP id l11-20020adfbd8b000000b0021d754b84c5so190742wrh.17
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:41:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=PBMOa/d2tjfgeB/QHIx1dN7myWa507lkje9vgtYdk1M=;
        b=VnWvnF7w41s0g5db4H5Yv0/1ELWohlBtkkmzZiQByh8N7SJ7FcH4Sk2Fusrhr7oUqj
         W84WGnmgnCxlMyMC2rU1DIj0EtvArfH1CqGVf3GmZO0S4OQwOLTBKadCuclVdrkvejdQ
         o/bf8A317upEB9FMOKyrAGzh+jDhYUo92KE9DQDW2t0eA6S5jWCPq2PC9J37O1WK3sk8
         1JAJLurIV1ac4GiU+7IrVvlChVP6Ug/P4qzPnQ5Wj7Ibr22N5z+DVukhbGjPW3Ha9Hou
         4BbK8D4344Pdn6tP7jRhVAtQNZFCVdNu9YddPsiT7Vmi2oJJVJC3lec40E5ZaAxprZRD
         LEiA==
X-Gm-Message-State: AJIora8uzsgyWRclidFJ23ls8zEtS0rjPJ+yNgxWH730gwRO4lWqhv+l
        8vLi8e2jtprxpSUWYRPf+7vAgo7Tuoerq9Yiqux/drwthkXzaVPGJbvAd7kywDhJu2be6s6aHjS
        yGuJwo1F2mL3UI2cRwO01JUvf
X-Received: by 2002:a05:600c:4282:b0:3a0:2ddf:4df3 with SMTP id v2-20020a05600c428200b003a02ddf4df3mr35291746wmc.45.1657010487756;
        Tue, 05 Jul 2022 01:41:27 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sGnHWLme//B+hbcAQKsKiJmsBsmUMTZFJ9LGNlyeIvIOH67tTiyDoMStTGpwMudz/TipXL+Q==
X-Received: by 2002:a05:600c:4282:b0:3a0:2ddf:4df3 with SMTP id v2-20020a05600c428200b003a02ddf4df3mr35291729wmc.45.1657010487581;
        Tue, 05 Jul 2022 01:41:27 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id s14-20020a5d510e000000b0021d60994b0asm8522281wrt.100.2022.07.05.01.41.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 01:41:27 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Juri Lelli <juri.lelli@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: Re: [PATCH] linux/wait: Fix __wait_event_hrtimeout for RT/DL tasks
In-Reply-To: <20220627095051.42470-1-juri.lelli@redhat.com>
References: <20220627095051.42470-1-juri.lelli@redhat.com>
Date:   Tue, 05 Jul 2022 09:41:26 +0100
Message-ID: <xhsmhtu7weytl.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/06/22 11:50, Juri Lelli wrote:
> Changes to hrtimer mode (potentially made by __hrtimer_init_sleeper on
> PREEMPT_RT) are not visible to hrtimer_start_range_ns, thus not
> accounted for by hrtimer_start_expires call paths. In particular,
> __wait_event_hrtimeout suffers from this problem as we have, for
> example:
>
> fs/aio.c::read_events
>   wait_event_interruptible_hrtimeout
>     __wait_event_hrtimeout
>       hrtimer_init_sleeper_on_stack <- this might "mode |= HRTIMER_MODE_HARD"
>                                        on RT if task runs at RT/DL priority
>         hrtimer_start_range_ns
>           WARN_ON_ONCE(!(mode & HRTIMER_MODE_HARD) ^ !timer->is_hard)
>           fires since the latter doesn't see the change of mode done by
>           init_sleeper
>
> Fix it by making __wait_event_hrtimeout call hrtimer_sleeper_start_expires,
> which is aware of the special RT/DL case, instead of hrtimer_start_range_ns.
>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Reported-by: Bruno Goncalves <bgoncalv@redhat.com>
> Signed-off-by: Juri Lelli <juri.lelli@redhat.com>

Makes sense, that's now aligned with what e.g.
schedule_hrtimer_range_clock() does.

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

