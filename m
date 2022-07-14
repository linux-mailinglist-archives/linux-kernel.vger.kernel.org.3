Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD7B6575046
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 16:04:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240070AbiGNOEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 10:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240440AbiGNOEM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 10:04:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9817DBE3A
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:03:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657807391;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XtdxK0LWmb1Jf+89i4Nsc+LkvKFkGHcgSyZX0xXxyI=;
        b=NnsgVZBehmaGDqlaqhcB9ejgATG423Ji+A2vfEAMrjbwgbCY365UQb9A60fVQHdjtDlJ69
        +Dw9ojJrzpBYxwsp5bVL15rUs2thEk3z4oqSkRr1NuGKlTk6rcirayKR6D6YC9JenuYA0L
        7xgVFoUK6/8mXlY/uQ8sPZt5zJhSUfc=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-240-4tM0pFyLNwWTG2wJrKSbwg-1; Thu, 14 Jul 2022 10:03:08 -0400
X-MC-Unique: 4tM0pFyLNwWTG2wJrKSbwg-1
Received: by mail-ed1-f71.google.com with SMTP id w13-20020a05640234cd00b0043a991fb3f3so1588327edc.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 07:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7XtdxK0LWmb1Jf+89i4Nsc+LkvKFkGHcgSyZX0xXxyI=;
        b=6N/OA1iSqSShJ2KaRn9HsduCchQqnX6dLFbDezN1+Ytc+cb2z8TxXQffSAZRBLAgw4
         VLXNXO4864g4cnxdRRRoi/UrYyq4KWYoOSrM0z9Fmp5lNDlIhHtf9r8r9xE36iBRmYrR
         Zs6sdNOJWRWlTWhSRf/4u7EuWz+C59jMcPLUQrDEgjSO1/mn4JevfH2QDODmk7vaJtO7
         +A16GSPwYljpywXimjWO4hl48jtZ6B32d96eJNuu4xzcCokPc4wQ9Rkx/nREbBpvzfMM
         u3afbBDDsyMCUgukSEN3FbtmPuQ5TP8Qj3iZNmRJ+oEXwsf1AyKnTX8uUnnYHv89anKS
         S7Eg==
X-Gm-Message-State: AJIora+mc1hL9yy+VD/wODmqdpA8rzPGj1wD3dzvo0WmzEDEBfy98h2Y
        NLj2897QDQvBzt2iJtgp+gvhZ8ILUc3HFDb/WjXwbukeqWbX/srz5QzGMNyzLyRnKVEWq/yW4px
        vDfCp7HvBlQPh6YI5pXdBrsMf
X-Received: by 2002:a05:6402:40ce:b0:43a:918d:a73f with SMTP id z14-20020a05640240ce00b0043a918da73fmr12619740edb.387.1657807387223;
        Thu, 14 Jul 2022 07:03:07 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1t8bK5AXcuJxMiU/pYnK7wAsXNRmsbk7m7pn+eL/yzuEBAI/N/AVsUo8KbNwnQSVLyg0gEIxA==
X-Received: by 2002:a05:6402:40ce:b0:43a:918d:a73f with SMTP id z14-20020a05640240ce00b0043a918da73fmr12619713edb.387.1657807386962;
        Thu, 14 Jul 2022 07:03:06 -0700 (PDT)
Received: from ?IPV6:2001:b07:6468:f312:9af8:e5f5:7516:fa89? ([2001:b07:6468:f312:9af8:e5f5:7516:fa89])
        by smtp.googlemail.com with ESMTPSA id b10-20020a1709063caa00b0072ee79bb8ebsm228499ejh.126.2022.07.14.07.03.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 07:03:06 -0700 (PDT)
Message-ID: <cd5d029c-b396-45ef-917b-92e054659623@redhat.com>
Date:   Thu, 14 Jul 2022 16:03:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH] KVM: selftests: Double check on the current CPU in
 rseq_test
Content-Language: en-US
To:     Gavin Shan <gshan@redhat.com>, kvmarm@lists.cs.columbia.edu
Cc:     kvm@vger.kernel.org, linux-kselftest@vger.kernel.org,
        linux-kernel@vger.kernel.org, seanjc@google.com,
        mathieu.desnoyers@efficios.com, shuah@kernel.org, maz@kernel.org,
        oliver.upton@linux.dev, shan.gavin@gmail.com
References: <20220714080642.3376618-1-gshan@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
In-Reply-To: <20220714080642.3376618-1-gshan@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/14/22 10:06, Gavin Shan wrote:
> In rseq_test, there are two threads created. Those two threads are
> 'main' and 'migration_thread' separately. We also have the assumption
> that non-migration status on 'migration-worker' thread guarantees the
> same non-migration status on 'main' thread. Unfortunately, the assumption
> isn't true. The 'main' thread can be migrated from one CPU to another
> one between the calls to sched_getcpu() and READ_ONCE(__rseq.cpu_id).
> The following assert is raised eventually because of the mismatched
> CPU numbers.
> 
> The issue can be reproduced on arm64 system occasionally.

Hmm, this does not seem a correct patch - the threads are already 
synchronizing using seq_cnt, like this:

	migration			main
	----------------------		--------------------------------
	seq_cnt = 1
	smp_wmb()
					snapshot = 0
					smp_rmb()
					cpu = sched_getcpu() reads 23
	sched_setaffinity()
					rseq_cpu = __rseq.cpuid reads 35
					smp_rmb()
					snapshot != seq_cnt -> retry
	smp_wmb()
	seq_cnt = 2

sched_setaffinity() is guaranteed to block until the task is enqueued on 
an allowed CPU.

Can you check that smp_rmb() and smp_wmb() generate correct instructions 
on arm64?

Paolo

>    host# uname -r
>    5.19.0-rc6-gavin+
>    host# # cat /proc/cpuinfo | grep processor | tail -n 1
>    processor    : 223
>    host# pwd
>    /home/gavin/sandbox/linux.main/tools/testing/selftests/kvm
>    host# for i in `seq 1 100`;   \
>          do echo "--------> $i"; \
>          ./rseq_test; sleep 3;   \
>          done
>    --------> 1
>    --------> 2
>    --------> 3
>    --------> 4
>    --------> 5
>    --------> 6
>    ==== Test Assertion Failure ====
>      rseq_test.c:265: rseq_cpu == cpu
>      pid=3925 tid=3925 errno=4 - Interrupted system call
>         1  0x0000000000401963: main at rseq_test.c:265 (discriminator 2)
>         2  0x0000ffffb044affb: ?? ??:0
>         3  0x0000ffffb044b0c7: ?? ??:0
>         4  0x0000000000401a6f: _start at ??:?
>      rseq CPU = 4, sched CPU = 27
> 
> This fixes the issue by double-checking on the current CPU after
> call to READ_ONCE(__rseq.cpu_id) and restarting the test if the
> two consecutive CPU numbers aren't euqal.
> 
> Fixes: 61e52f1630f5 ("KVM: selftests: Add a test for KVM_RUN+rseq to detect task migration bugs")
> Signed-off-by: Gavin Shan <gshan@redhat.com>
> ---
>   tools/testing/selftests/kvm/rseq_test.c | 5 +++--
>   1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/rseq_test.c b/tools/testing/selftests/kvm/rseq_test.c
> index 4158da0da2bb..74709dd9f5b2 100644
> --- a/tools/testing/selftests/kvm/rseq_test.c
> +++ b/tools/testing/selftests/kvm/rseq_test.c
> @@ -207,7 +207,7 @@ int main(int argc, char *argv[])
>   {
>   	int r, i, snapshot;
>   	struct kvm_vm *vm;
> -	u32 cpu, rseq_cpu;
> +	u32 cpu, rseq_cpu, last_cpu;
>   
>   	/* Tell stdout not to buffer its content */
>   	setbuf(stdout, NULL);
> @@ -259,8 +259,9 @@ int main(int argc, char *argv[])
>   			smp_rmb();
>   			cpu = sched_getcpu();
>   			rseq_cpu = READ_ONCE(__rseq.cpu_id);
> +			last_cpu = sched_getcpu();
>   			smp_rmb();
> -		} while (snapshot != atomic_read(&seq_cnt));
> +		} while (snapshot != atomic_read(&seq_cnt) || cpu != last_cpu);
>   
>   		TEST_ASSERT(rseq_cpu == cpu,
>   			    "rseq CPU = %d, sched CPU = %d\n", rseq_cpu, cpu);

