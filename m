Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E28E65297B5
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 05:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234422AbiEQDMV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 23:12:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230144AbiEQDMS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 23:12:18 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F221B1D0E5
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:12:16 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id a10so17982561ioe.9
        for <linux-kernel@vger.kernel.org>; Mon, 16 May 2022 20:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=1kuEDxhPJAEoL+pT1AeoocUUxdiiHKoBFkSkZvL+zTE=;
        b=MwI1QIx35vX1X2b4JzO+XSYcC0c4I+ihLcGgCP6FK2jTm+GGZFCJDhuTGoAPBkQLc/
         VW948CJ7molBxVHIVACnnWLmYIcBSm2Qc3oRv99jfBAgesfc9SnMAvypFVgkF6kyClmo
         dfxqT2Iih3GWPQIpZYCe2qJpofO9HFUQmQD1k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=1kuEDxhPJAEoL+pT1AeoocUUxdiiHKoBFkSkZvL+zTE=;
        b=P+3nLZQDZ3wZ59EXcIOIPrk/zHxyMJdLBaWkRtQDH+Bt4+HwbbVQowlqUDP5I9phFf
         OoBxkshCUckSj8W5DJFQhLsFJq2awyKbnfF4pOpUR0cnvXOQ5zZbhqFfx/kiDut9KGi7
         tEZ0czVoJA2zfnCXaeWrCwy+dNyIBoBEEUOr74svdguty1jKSklM4g50OKTZd6F6B8fq
         7hAwXp2dkG6At4uZVpEDB8NfjKE5KqQh/0GoALemo1BHxEXxAdQ5CxQY0afjUURATj+v
         C2FIoiBcLJJzPZjSyw3HwjffUOp5LDhOk9UdcoxHYPbQ0IIAZr0/BiOFqF7ESEfvsGyv
         lD0g==
X-Gm-Message-State: AOAM530XLupH/sBYWKEOZRlOfH+GsHaZeoI0ED9J2q7g5ErRsVNjCkk5
        HhFxw0RyQZOyelysm+OMnUz6Cg==
X-Google-Smtp-Source: ABdhPJyKur7KEmswRvvVt7T+HSxN6g34XcNeFHOa9PWInnFFz3vXE+rekPH9pYMo+VYF9f0Xl/sBlA==
X-Received: by 2002:a05:6638:3397:b0:32b:a9da:9603 with SMTP id h23-20020a056638339700b0032ba9da9603mr10415917jav.283.1652757136387;
        Mon, 16 May 2022 20:12:16 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id f19-20020a056638329300b0032e102760c5sm2458323jav.73.2022.05.16.20.12.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 May 2022 20:12:15 -0700 (PDT)
Subject: Re: [PATCH v2 1/2] mm: drop oom code from exit_mmap
To:     Suren Baghdasaryan <surenb@google.com>, akpm@linux-foundation.org
Cc:     mhocko@suse.com, rientjes@google.com, willy@infradead.org,
        hannes@cmpxchg.org, guro@fb.com, minchan@kernel.org,
        kirill@shutemov.name, aarcange@redhat.com, brauner@kernel.org,
        hch@infradead.org, oleg@redhat.com, david@redhat.com,
        jannh@google.com, shakeelb@google.com, peterx@redhat.com,
        jhubbard@nvidia.com, shuah@kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        kernel-team@android.com, Shuah Khan <skhan@linuxfoundation.org>
References: <20220516075619.1277152-1-surenb@google.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <66da8e2f-62e5-2a09-e8ad-960d77bde75c@linuxfoundation.org>
Date:   Mon, 16 May 2022 21:12:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <20220516075619.1277152-1-surenb@google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/16/22 1:56 AM, Suren Baghdasaryan wrote:
> The primary reason to invoke the oom reaper from the exit_mmap path used
> to be a prevention of an excessive oom killing if the oom victim exit
> races with the oom reaper (see [1] for more details). The invocation has
> moved around since then because of the interaction with the munlock
> logic but the underlying reason has remained the same (see [2]).
> 
> Munlock code is no longer a problem since [3] and there shouldn't be
> any blocking operation before the memory is unmapped by exit_mmap so
> the oom reaper invocation can be dropped. The unmapping part can be done
> with the non-exclusive mmap_sem and the exclusive one is only required
> when page tables are freed.
> 
> Remove the oom_reaper from exit_mmap which will make the code easier to
> read. This is really unlikely to make any observable difference although
> some microbenchmarks could benefit from one less branch that needs to be
> evaluated even though it almost never is true.
> 
> [1] 212925802454 ("mm: oom: let oom_reap_task and exit_mmap run concurrently")
> [2] 27ae357fa82b ("mm, oom: fix concurrent munlock and oom reaper unmap, v3")
> [3] a213e5cf71cb ("mm/munlock: delete munlock_vma_pages_all(), allow oomreap")
> 
> Signed-off-by: Suren Baghdasaryan <surenb@google.com>
> Acked-by: Michal Hocko <mhocko@suse.com>
> ---
Looks good to me.

Reviewed-by: Shuah Khan <skhan@linuxfoundation.org>

thanks,
-- Shuah
