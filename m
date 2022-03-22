Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58AD94E3748
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:11:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236028AbiCVDLU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:11:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235997AbiCVDLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:11:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D0FCB1B7B7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647918590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DBtHCrAqM8PwKsCvhHfbFfAvk2Wqf5blryM4kHsbRbI=;
        b=RCGELxqEwIljF5MraCQZv2CXmRQeZ1+FlnFwikdbiji12DEUeK+FaydYuCawZZ4t/7N1RM
        YJb8qaffkOEalnAwr/f425GMKUjkwHryI+vXrA37kJPqdq5AXd4rl8uLXYUAizjqjeI/Q9
        XecRUOz2rnn0rM/lhcxYHlyMLl6MCd4=
Received: from mail-io1-f72.google.com (mail-io1-f72.google.com
 [209.85.166.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-505-3bdkyZwHPUW3pzUPugxRYQ-1; Mon, 21 Mar 2022 23:09:49 -0400
X-MC-Unique: 3bdkyZwHPUW3pzUPugxRYQ-1
Received: by mail-io1-f72.google.com with SMTP id z10-20020a056602080a00b00645b9fdc630so11671210iow.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:09:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:references:from:cc:in-reply-to
         :content-transfer-encoding;
        bh=DBtHCrAqM8PwKsCvhHfbFfAvk2Wqf5blryM4kHsbRbI=;
        b=uoFi69ulSltgQ4oUOayNYpI2kJGASxIew4IDXtmDWlqgaaePRokwINqWeL7+R5NrGU
         E+024ujGtBcRa6NddBBCJT4DLnblyQagshqLlshKjQ8y4hM3ytq3p0uYZ+23R7fiL2bN
         gpJRuk4emWh1ktJoIL7cO2ueZ0LaJPhZ7IkR9y/kwXbi/HGtZuu2ZNCYmrXMletTHuGF
         qXz8V8IBMnmyIx8jvGusEq/pSRYHm6VEouUsPTEBWYuMxKuQDLhBSZVRWaJf9mFjwbxF
         j0rC/acc+jRvERMOKHagvB5BM9qxSIYjPiaLgEaQ8j9vSDm4tvjMuZLFDJYnFoFCsL84
         mPlw==
X-Gm-Message-State: AOAM532IXFwU7B7cOlOjPp6BTZUVNaL1sVfB8EFxUa0C3UP4x37fIFAL
        yrLfpLgLdzoKvaU4+Pwd3Bet5XdodiRh2Re8okHmrzEcixneBIk0PUyTqNMqSF/5ru3HGCq1OmZ
        RXkj91xu630OINGP7eGyvwShD
X-Received: by 2002:a92:9406:0:b0:2be:6ace:7510 with SMTP id c6-20020a929406000000b002be6ace7510mr10721171ili.291.1647918588742;
        Mon, 21 Mar 2022 20:09:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyvveSDS6+Wk3t25fD33XZkALpAjB2gIMNBsXYlv9C/guBU/azXhcdbQe9c8WLlaAPMh2jOsA==
X-Received: by 2002:a92:9406:0:b0:2be:6ace:7510 with SMTP id c6-20020a929406000000b002be6ace7510mr10721153ili.291.1647918588534;
        Mon, 21 Mar 2022 20:09:48 -0700 (PDT)
Received: from ?IPV6:2601:280:4400:a2e0:7336:512c:930d:4f0e? ([2601:280:4400:a2e0:7336:512c:930d:4f0e])
        by smtp.gmail.com with ESMTPSA id d14-20020a056602328e00b006494aa126c2sm7889638ioz.11.2022.03.21.20.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Mar 2022 20:09:48 -0700 (PDT)
Message-ID: <0d0fb94a-ff66-ac31-e126-0eaf4dca0d6a@redhat.com>
Date:   Mon, 21 Mar 2022 21:09:46 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v5] mm/oom_kill.c: futex: Close a race between do_exit and
 the oom_reaper
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>, Davidlohr Bueso <dave@stgolabs.net>
References: <20220318033621.626006-1-npache@redhat.com>
 <Yjg9ncgep58gFLiN@dhcp22.suse.cz> <20220322004231.rwmnbjpq4ms6fnbi@offworld>
 <c8bb0b6d-981c-8591-d5b6-17414c934758@redhat.com>
 <20220322025724.j3japdo5qocwgchz@offworld>
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
In-Reply-To: <20220322025724.j3japdo5qocwgchz@offworld>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/21/22 20:57, Davidlohr Bueso wrote:
> On Mon, 21 Mar 2022, Nico Pache wrote:
> 
>> We could proceed with the V3 approach; however if we are able to find a complete
>> solution that keeps both functionalities (Concurrent OOM Reaping & Robust Futex)
>> working, I dont see why we wouldnt go for it.
> 
> Because semantically killing the process is, imo, the wrong thing to do. My
> performance argument before however is bogus as the overhead of robust futexes
> is pretty negligible within the lifetime of a lock. That said, the users still
> have good(?) reasons for not wanting the lock holder to crash on them.

From my understanding, the whole point of the robust futex is to allow forward
progress in an application in which the lock holder CAN crash/exit/oom. So
semantically nothing is wrong with killing the futex holder... the whole point
of the robustness is to handle these cases. We just have a case were the oom
killer is racing with said handling of the futex, invalidating the memory before
the exit path (handle_futex_death) can awake one of the other waiters.

-- Nico
> 
> Thanks,
> Davidlohr
> 

