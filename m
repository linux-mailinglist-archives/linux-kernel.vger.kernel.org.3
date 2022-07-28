Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB17583B37
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235520AbiG1J1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 05:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235398AbiG1J1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 05:27:23 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9FBF165D40
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:27:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659000441;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LrxQSWciaWJjGdDz7VQeuucGTXw62npYksns5+Sozgk=;
        b=ATfVOxmWSkRH7ZBFtBSI0o29I/urswpG32IhmuGaqdeGpNu4UO2g0fIuWfsUgf2+jdExaG
        SoCYU5hGiw14UF68thT0ChujJ4giRzasVQqFoD0owyLhdsc8RY0ZF45hWuH7bRK5GDikxg
        hFNXvKrc0nyNvQWvs3rb7qk8F+i1FnY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-391-PnlwxStjMfqH-71LQUt28g-1; Thu, 28 Jul 2022 05:27:20 -0400
X-MC-Unique: PnlwxStjMfqH-71LQUt28g-1
Received: by mail-wm1-f71.google.com with SMTP id z20-20020a1c4c14000000b003a3020da654so263080wmf.5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 02:27:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=LrxQSWciaWJjGdDz7VQeuucGTXw62npYksns5+Sozgk=;
        b=Qvi/RAori9QMLaSENCbCxMD2Dm8UzQwXXEhqCphc35kOgJydOtWFxyyksIyZfbrKDO
         s/sSondalxsg4Dz5Hg6kaQweorkfenW2qNAoYTj9nQ4CZshEyufsBYN7oK37QOC/fsV/
         tJAZhbkfqjYfTDvWyvyJIJOalG92MXYZffKBiEl2qJRNHHjjmEQxpuEK6p5mEwmR3IFH
         C1fJraSKTrrNQ4xAFNSHTvKkDhWPdM+NoyCgMvsJQ7NGobIC0uwKqYInkutUUrn6zlyG
         yh/vDF1gIpxdSmR59bhNSrt1YY35tCOPjqzciLpRroaZqMHgvKjUCbQZuQwooil00vrJ
         ws0w==
X-Gm-Message-State: AJIora8Z1Wke/+/PJjQ1N8orPzwtDX4uSkWSXWOyAZtyDryeOrwo9hlt
        S4Ujb6P43JxBLb3OveYnH7V5sJ+kvXar2ZjclXpNg718nIDMxviFc9cYUv5AbR5LExc2a7ZpHA0
        eGPHjaxpepF65kH9sIriLUejF
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id x1-20020adfffc1000000b0021d66a1c3eemr16041387wrs.364.1659000439057;
        Thu, 28 Jul 2022 02:27:19 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1upxqCVjXPJAiQREZPjwda4AYwu3LBOidqDUdl61pYBbKHbL+vvbmNlzGyLJV5MOoy3LxjH1A==
X-Received: by 2002:adf:ffc1:0:b0:21d:66a1:c3ee with SMTP id x1-20020adfffc1000000b0021d66a1c3eemr16041365wrs.364.1659000438748;
        Thu, 28 Jul 2022 02:27:18 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id g17-20020a5d4891000000b0021f0558e51asm444942wrq.55.2022.07.28.02.27.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 Jul 2022 02:27:18 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Zhen Lei <thunder.leizhen@huawei.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Zhen Lei <thunder.leizhen@huawei.com>
Subject: Re: [PATCH] sched: Print each field value left-aligned in
 sched_show_task()
In-Reply-To: <20220727060819.1085-1-thunder.leizhen@huawei.com>
References: <20220727060819.1085-1-thunder.leizhen@huawei.com>
Date:   Thu, 28 Jul 2022 10:27:17 +0100
Message-ID: <xhsmhh731egei.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/07/22 14:08, Zhen Lei wrote:
> Currently, the values of some fields are printed right-aligned, causing
> the field value to be next to the next field name rather than next to its
> own field name. So print each field value left-aligned, to make it more
> readable.
>
> Before:
>       stack:    0 pid:  307 ppid:     2 flags:0x00000008
> After
>       stack:0     pid:308   ppid:2      flags:0x0000000a
>
> This also makes them print in the same style as the other two fields:
>       task:demo0           state:R  running task
>
> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>

Reviewed-by: Valentin Schneider <vschneid@redhat.com>

