Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28B46584E8D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 12:12:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235811AbiG2KMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 06:12:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235802AbiG2KM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 06:12:29 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 38D477D7B2
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:12:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659089546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c2J3XvuQ0oM+oSDleexo3NR4dep7Npiqc3d/WHk8MLM=;
        b=M/6XNbK3oj/BcPxahcJAVs9RTkLMKphkTdPhQe5T2E+b9BT0YtqYpXuuVS1rCLGpkeqntz
        CZ+0alBpGxzg8xJFOnfhVBTUhk/+B5WsrfSRvxrcHZgOfJo84JVDjq+eMZE/c2YSlaVHtg
        zHIrv77IeQNpGICJVPLiw43LmExxrJY=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-669-kIanv_EKMSCTGLGWrtuZ3g-1; Fri, 29 Jul 2022 06:12:17 -0400
X-MC-Unique: kIanv_EKMSCTGLGWrtuZ3g-1
Received: by mail-wr1-f71.google.com with SMTP id d27-20020adfa41b000000b0021ee714785fso1067037wra.18
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 03:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:date:references:in-reply-to:subject:cc:to
         :from:x-gm-message-state:from:to:cc;
        bh=c2J3XvuQ0oM+oSDleexo3NR4dep7Npiqc3d/WHk8MLM=;
        b=7Hk45Ztwg2bbx6A2KxSbsaey+1TVJKNDEss8AKqcGbxdHbUL7mvexEBYz+ZSlwUuvf
         zN346eJlyaDys7JQm02+mm9614dKtWtUQ+Ou+b5PuzqvzvdJgRVMju1YafE1jJUxX/cO
         l6pzFz1EueqrqH755MbpXzo6YCNtNA1glQy3E67y/ycceHzoz4q5RnFhlPGvqUH8lMfV
         +7fP3rxRt4klkZ5EGc8s6guSvAaMOb6pHSWaoZ9z51FjJggSWsnbBmPmND+GR8b5GuQ8
         ZWpC4Q8tbDZiQtboxpFqW9JMnzLqpwH1F4zqzyP5T0on0u+x5augHG+sObGqkxzlaQSd
         jhhA==
X-Gm-Message-State: AJIora8TWkAA0BiHryenZlXAPXdsIrHv81jndEq1LJIHgyOtaqTt5zt0
        VrqJ2VSzAwZaLYBKbP7VZcOoJX8Q0s/fEO4PVCB2M3RCdrqabq46EiBFZiILlvLEISllv/WRZ4p
        BPn9CU6ifeoy8RS3dpIzqhowx
X-Received: by 2002:a1c:29c1:0:b0:3a3:79b0:1ced with SMTP id p184-20020a1c29c1000000b003a379b01cedmr1924611wmp.73.1659089536289;
        Fri, 29 Jul 2022 03:12:16 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1ssp341fB8621X4d9lKxWaMNan42AvZZ4HT4qTbN78qYr9AhXjnMnRocX8v1F11ZhsV3Xl8uQ==
X-Received: by 2002:a1c:29c1:0:b0:3a3:79b0:1ced with SMTP id p184-20020a1c29c1000000b003a379b01cedmr1924586wmp.73.1659089536031;
        Fri, 29 Jul 2022 03:12:16 -0700 (PDT)
Received: from vschneid.remote.csb ([185.11.37.247])
        by smtp.gmail.com with ESMTPSA id g5-20020a5d4885000000b0021e4edba1e5sm3191273wrq.111.2022.07.29.03.12.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 03:12:15 -0700 (PDT)
From:   Valentin Schneider <vschneid@redhat.com>
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <jiangshanlai@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Phil Auld <pauld@redhat.com>,
        Marcelo Tosatti <mtosatti@redhat.com>
Subject: Re: [RFC PATCH v2 1/2] workqueue: Unbind workers before sending
 them to exit()
In-Reply-To: <YuLH/l9YZYG6FRSW@slm.duckdns.org>
References: <20220727115327.2273547-1-vschneid@redhat.com>
 <20220727115327.2273547-2-vschneid@redhat.com>
 <CAJhGHyCeraX1jcea9kt_FBC561zBgECuw5qx8TAdCG0EHnT6kA@mail.gmail.com>
 <xhsmhedy5ecdg.mognet@vschneid.remote.csb>
 <YuK6zzmlFJ376UeD@slm.duckdns.org>
 <xhsmh8roddubi.mognet@vschneid.remote.csb>
 <YuLH/l9YZYG6FRSW@slm.duckdns.org>
Date:   Fri, 29 Jul 2022 11:12:14 +0100
Message-ID: <xhsmh1qu4dy81.mognet@vschneid.remote.csb>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/07/22 07:31, Tejun Heo wrote:
> Hello,
>
> On Thu, Jul 28, 2022 at 06:24:17PM +0100, Valentin Schneider wrote:
>> > I don't understand why this would need MEM_RECLAIM when it isn't sitting in
>> > the memory reclaim path. Nothing in mm side can wait on this.
>>
>> Vaguely reading the doc I thought that'd be for anything that would
>> directly or indirectly help with reclaiming memory (not explicitly sitting
>> in some *mm reclaim* path), and I assumed freeing up a worker would count as
>> that - but that's the understanding of someone who doesn't know much about
>> all that :-)
>
> Oh, it's just needed for things that mm might end up waiting on. Here,
> there's no way for mm to know about or trigger this at all, so it doesn't
> need the flag.
>

Got it, thanks!

>> > There actually are spurious wakeups. We can't depend on there being no
>> > wakeups than ours.
>>
>> Myes, I suppose if a to-be-destroyed kworker spuriously wakes before having
>> been unbound then there's not much point in having the unbinding (harm has
>> been done and the kworker can do_exit(), though arguably we could reduce
>> the harm and still move it away), but let me see what I can do here.
>
> Yeah, it kinda sucks but is a kernel-wide thing and pretty rare, so for the
> most part, we can pretend that they don't exist but under specific
> conditions, there can be asynchronous wakeups coming from whereever, so we
> gotta be crash proof against those.
>

That's sensible, I'll look into Lai's suggestion and see if I can come up
with something not-too-horrible.

