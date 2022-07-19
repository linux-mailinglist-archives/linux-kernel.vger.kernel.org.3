Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82C19579583
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 10:48:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235469AbiGSIsR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 04:48:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236975AbiGSIsE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 04:48:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CA4DE3C8F5
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:48:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1658220483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T+a4ycFhjarx9mlzPS8D1+gxrl/DhKN12r6qeEGChLA=;
        b=PCAAuKJKSsHYwVgr6toKdI2fGDV78h1avr/tSDo/OA1895ba77Sx85DGbJUXf07oPx1nCs
        tftc+tm9sJYpgGJBynmgn2DMflMhHaB5XrmNvUBbjPdmH2wU7TD+hpp0Up1iThpCcUXX84
        flS2jSBvqDclso7nixuJkt2ukbnXHw0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-38-NKEMc7geP_SysSCd1gzGuA-1; Tue, 19 Jul 2022 04:47:55 -0400
X-MC-Unique: NKEMc7geP_SysSCd1gzGuA-1
Received: by mail-ed1-f69.google.com with SMTP id h20-20020a05640250d400b0043b6a4a2f11so3044749edb.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 01:47:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=T+a4ycFhjarx9mlzPS8D1+gxrl/DhKN12r6qeEGChLA=;
        b=mm9TXW6ls+IEQf0/J5XTbuwjYaEFpBHRORFMO8f3EhYIhnCqkb6WwBDua0q31NstsO
         YWFHUBJCl6709qqhiAYioOdfRa0zEMcpQ+/CY83LQCx8cT6KjTlfKYxjvhBj5Qrwe+TR
         PZifTHG8zNWS/u9tc+ZmLCas17GURh8YK+8JZ2MbFH+xf+d3uZEuHX28yjolhk9uBxux
         PPN/o7jMJuhBvO+pzLJU/dfIzhA+VaI1HM2r9E5FkLWNhTkx1En8cWT7jyJhh0islnfT
         QXABfMfqXkTTdV/EJZS67ZCU1wkQX+V9LWqBNiCsbCn8tMd9yCHAumovbB9nLMwcYNsV
         51Yg==
X-Gm-Message-State: AJIora+uWcLtDPwwEP3a4xiTGe/K3otkNRbelxDf70BjnqLbeE1HJsU3
        mBB3q1l0YpruhG1dnFqgkiwaWCYUC0JzJOTrVbn5vnw2Kdx5nHANfbOEDN/UHLAn8EJvOkXHEI1
        wHOuFFTFv6/gcgIo5HHYeNVlQ
X-Received: by 2002:a17:906:58d0:b0:72e:e25a:46e7 with SMTP id e16-20020a17090658d000b0072ee25a46e7mr23821055ejs.459.1658220474640;
        Tue, 19 Jul 2022 01:47:54 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1uQHMU5eoA6/zvvcSw83C7AvpAZZ6w2gQJAz0OpyfqTXsmBvyBSiOUUf7stsy8sZJD7iFQfXg==
X-Received: by 2002:a17:906:58d0:b0:72e:e25a:46e7 with SMTP id e16-20020a17090658d000b0072ee25a46e7mr23821038ejs.459.1658220474380;
        Tue, 19 Jul 2022 01:47:54 -0700 (PDT)
Received: from [192.168.0.198] (host-80-104-20-93.retail.telecomitalia.it. [80.104.20.93])
        by smtp.gmail.com with ESMTPSA id q14-20020a17090676ce00b00722e50dab2csm6393555ejn.109.2022.07.19.01.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Jul 2022 01:47:54 -0700 (PDT)
Message-ID: <cff61541-2c12-964c-ad87-3852a5a1e8f8@redhat.com>
Date:   Tue, 19 Jul 2022 10:47:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] linux/wait: Fix __wait_event_hrtimeout for RT/DL tasks
Content-Language: en-US
To:     Juri Lelli <juri.lelli@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Bruno Goncalves <bgoncalv@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Valentin Schneider <vschneid@redhat.com>
References: <20220627095051.42470-1-juri.lelli@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <20220627095051.42470-1-juri.lelli@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/27/22 11:50, Juri Lelli wrote:
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

Reviewed-by: Daniel Bristot de Oliveira <bristot@kernel.org>
-- Daniel

