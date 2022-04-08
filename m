Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1F084F9227
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbiDHJmV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:42:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbiDHJmS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:42:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4AB8813F2B
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:40:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649410813;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JYCqI2SE1+yxHN/rLqWe+JaeAZMuu0aWZKyvaN+2uVc=;
        b=KVKs6+pn6rVWR51mHZWW0A0/EgoTaRIuA9V1eRCv3d8+ab0OZiLtp+Gm9ad2XZm4Cy8S+j
        b3vjK02i219nSyLYGDUPsfrdxXQOSMqv5NU5m80B9ZfZe9RXIBhXU+XyfrVINDgJCnXps3
        WtMq8XcZdsxV+AXahMI4xPEQRFqUOvQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-553-Hzfi4zRzO3eA3p7PW3jUrw-1; Fri, 08 Apr 2022 05:40:12 -0400
X-MC-Unique: Hzfi4zRzO3eA3p7PW3jUrw-1
Received: by mail-qk1-f199.google.com with SMTP id bp31-20020a05620a459f00b00699fabcc554so3257442qkb.12
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 02:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JYCqI2SE1+yxHN/rLqWe+JaeAZMuu0aWZKyvaN+2uVc=;
        b=kSbtj4gOa561n+qAqKD2hGoZqMgtsJInHtgADNKXvIcqOaE+QA5K/tsawgwpUJ+atN
         g2sU6ootGhgzYGCJP/ojzy305tEzYtfNibg8bwAu/H3kR5n1nG30xtEtvto6XERpit8C
         SSn8TeDUn6nWr02laHIJu5WHkgD+4Qswf3qM0+EDROFtqLrvCYXuZDWOgHA08h92I6W1
         OSw5VJmrdRl4AEG0WjqyTXWt24nEqwC9rp0hHxyVt4Fxs4IhuzrdDGuVNIUYAuqvlMY+
         05yaRRu5JP1Rzzqarufj3mNvdhA+X31cZQgHfU07KliWODOn2HiE8ys+bjdfw6X4tk7J
         wCOQ==
X-Gm-Message-State: AOAM533GfEQibpTu/kktk8oFAbMdKg1gMYQ7tjl7HctJeGXYcwwNyqbJ
        wIYcTTGLNS+Le6ZTDjl3M8TjTfoGJyCE8PxxxHpO2kfhTTFzBzYPlToNJhJyx/Wf/YB2tQJHXGo
        f5uLBAkvZeYDQavZrhxs2n2yN
X-Received: by 2002:a05:620a:484:b0:67e:16fe:3689 with SMTP id 4-20020a05620a048400b0067e16fe3689mr11750576qkr.745.1649410811810;
        Fri, 08 Apr 2022 02:40:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxFf8q2Jank8eDGXSNXYQcm5a45Gsr/FBZVdsaqB5SC5uEdpC/5YfsZauHF62EuAyLms4Ef6g==
X-Received: by 2002:a05:620a:484:b0:67e:16fe:3689 with SMTP id 4-20020a05620a048400b0067e16fe3689mr11750568qkr.745.1649410811614;
        Fri, 08 Apr 2022 02:40:11 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id b21-20020a05620a04f500b0067b4895472esm13405172qkh.5.2022.04.08.02.40.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 02:40:11 -0700 (PDT)
Message-ID: <676fb197-d045-c537-c1f7-e18320a6d15f@redhat.com>
Date:   Fri, 8 Apr 2022 05:40:09 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v8] oom_kill.c: futex: Don't OOM reap the VMA containing
 the robust_list_head
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220408032809.3696798-1-npache@redhat.com>
 <20220408081549.GM2731@worktop.programming.kicks-ass.net>
 <87tub4j7hg.ffs@tglx> <ddf1755e-fe69-b60e-ee07-e78d663b11b2@redhat.com>
 <YlACJMp7AFaVa/Gt@dhcp22.suse.cz>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YlACJMp7AFaVa/Gt@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/8/22 05:36, Michal Hocko wrote:
> On Fri 08-04-22 04:52:33, Nico Pache wrote:
> [...]
>> In a heavily contended CPU with high memory pressure the delay may also
>> lead to other processes unnecessarily OOMing.
> 
> Let me just comment on this part because there is likely a confusion
> inlved. Delaying the oom_reaper _cannot_ lead to additional OOM killing
> because the the oom killing is throttled by existence of a preexisting
> OOM victim. In other words as long as there is an alive victim no
> further victims are not selected and the oom killer backs off. The
> oom_repaer will hide the alive oom victim after it is processed.
> The longer the delay will be the longer an oom victim can block a
> further progress but it cannot really cause unnecessary OOMing.
Is it not the case that if we delay an OOM, the amount of available memory stays
limited and other processes that are allocating memory can become OOM candidates?

-- Nico

