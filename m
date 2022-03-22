Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64D584E3647
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 02:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235152AbiCVBzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 21:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235114AbiCVBzC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 21:55:02 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C81D638182
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647914014;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uFNsqpDgHlwcJWc3v3norTXsqUprQGWM/kHX+J5t3Ig=;
        b=CU4rrbrhdqNXGnIrPTPsCesSzSt7HCOk8SABmV+D1BU+y3sT0CNbXObs5QdIrg9dUighwg
        +iPh2J+cziu2K+av0IoStpWz+HIpL3IleChN51pTrgIwzacK3bJHbXaq/DaD/cXIfNa+jZ
        cGRu6cdUuSQ5CZEoZjabNoglFCccEcI=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-434-6Bd3W-KdPhaqKInQzmq6Ag-1; Mon, 21 Mar 2022 21:53:33 -0400
X-MC-Unique: 6Bd3W-KdPhaqKInQzmq6Ag-1
Received: by mail-il1-f199.google.com with SMTP id t16-20020a056e02061000b002c7ddaa0006so7174019ils.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 18:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=uFNsqpDgHlwcJWc3v3norTXsqUprQGWM/kHX+J5t3Ig=;
        b=o1eCtlWbMXHcHIfBFOvwo9CUwerWs8/65rQkF/HhlfTi6FoDXzCSMpnCGPCq078g51
         FKHTb/lv2tnaEyqP9JwwceHa6X9uvxHfEkST3sF4K6brD5n/1rcD7NkSfNmeywKmDhaf
         0e+NTVAtjThHW72Zdeax3ZaDzoul6IKLaLy4v6S/4ZaaTrExLRKibORkDNXw/abzoRYh
         eYIt9cTTN12wPkvhLJy06L1Raa8sf4b7gDvFLW1kXjfsO1ujceAL3T8cw5KQqalBYjyl
         TAhyJ9mMbjpB10fCL+3yuvpGMoTjNlp8XYEjmzU6G53jLxrCVDfjncf/DpgXQpUweWqp
         6Ytw==
X-Gm-Message-State: AOAM531kAS/RlJhw5ZVJ9vESAgylSCqZXq8irWhMknl5WSAwUDiEG8MM
        VGb+43O/nhVCtRiCs7T38uzjhgp3bBZ5yfvLZvuwIu6JTPp81zcjMbr2cuKyiq2hBUlaiVIkeP7
        /Sz+2Lwk8ve+FsSHQwHQfKPWh
X-Received: by 2002:a02:862a:0:b0:319:dc78:e4c0 with SMTP id e39-20020a02862a000000b00319dc78e4c0mr12827505jai.43.1647914012396;
        Mon, 21 Mar 2022 18:53:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8bte1WXFTU8OUCyGzAx1f7rsxslZ1ODKlNKZMhc1jWXF7e+o9XaEshaQnbT2hydNoyTxl/Q==
X-Received: by 2002:a02:862a:0:b0:319:dc78:e4c0 with SMTP id e39-20020a02862a000000b00319dc78e4c0mr12827493jai.43.1647914012199;
        Mon, 21 Mar 2022 18:53:32 -0700 (PDT)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id h4-20020a5e9744000000b006415b179a0dsm9157661ioq.37.2022.03.21.18.53.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 18:53:31 -0700 (PDT)
Message-ID: <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
Date:   Mon, 21 Mar 2022 19:53:29 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and
 the oom_reaper
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz> <20220322004231.rwmnbjpq4ms6fnbi@offworld>
From:   Nico Pache <npache@redhat.com>
Cc:     linux-mm@kvack.org, Andrea Arcangeli <aarcange@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>, Baoquan He <bhe@redhat.com>,
        Christoph von Recklinghausen <crecklin@redhat.com>,
        Don Dutile <ddutile@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Andre Almeida <andrealmeid@collabora.com>,
        David Rientjes <rientjes@google.com>
In-Reply-To: <20220322004231.rwmnbjpq4ms6fnbi@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 18:42, Davidlohr Bueso wrote:
> On Mon, 21 Mar 2022, Michal Hocko wrote:
> 
>> The more I am thinking about this the more I am getting convinced that
>> we should rather approach this differently and skip over vmas which can
>> be holding the list. Have you considered this option?
> 
> While I tend to agree with this over a hacky trylock approach, I cannot
> help but think that v3 was the right thing to do, at least conceptually.
Yeah conceptually the V3 was the first correct patch. It could use some slight
cleanup with a wrapper like in this v5 (has_robust_list), and instead of
returning it should set MMF_OOM_SKIP.
> Robust futex users here care enough about dealing with crashes while holding
> a lock that they sacrifice the performance of regular futexes. So the OOM
> killer should not cause this very thing. I went through previous threads
> but other than the user base (which I don't think would be very large
> just because of the performance implications), was there any other reason
> to no just set MMF_OOM_SKIP upon a robust list?
We could proceed with the V3 approach; however if we are able to find a complete
solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
working, I dont see why we wouldnt go for it.

If we can't find a good/reliable way to check if the vma contains the robust
list then I think we should just skip the OOM like in the v3.

Cheers,
-- Nico

> 
> Thanks,
> Davidlohr
> 

