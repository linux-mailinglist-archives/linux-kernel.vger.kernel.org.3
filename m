Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6A1C4FCE50
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 06:56:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347151AbiDLE6Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 00:58:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347174AbiDLE6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 00:58:22 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CDEE33EB0;
        Mon, 11 Apr 2022 21:56:03 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id bg24so4839699pjb.1;
        Mon, 11 Apr 2022 21:56:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZDxyd/adi3fkSI+1jAcisi2UBvnL6C6PcXGBplZX2u8=;
        b=p+Rs/hvFdSFaj6LoK3tiNZCsFmbX+R2B5xDjEGbsEuD5rTvtY+7/3CprRZ/QmzUMZL
         CqjKYBO854g/BU95kxaajdXdZFO8y11UFvqPztDsmO1amqsc78ZNlsr5ipLba7a7KA0T
         CYtjca+7c1Xpdmd/Szo1BzlRC4f2LOfsWSMEa1Q5Ns0HgYPsC9pq4AxrGadgi1EfJy5n
         X1pYrKmcv3Wbl+PggS5/ukqqJhtjCaf9qZKyALGdrwNR11fC4hcib4yp5qCWpmSZVdyb
         i+9dqEDvqfdCYNq+ydlhvg3kEwlfM1npgkVMElv8eZI9p2487gVADDcZCsmVBXsPl7m9
         ttBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=ZDxyd/adi3fkSI+1jAcisi2UBvnL6C6PcXGBplZX2u8=;
        b=Qxjj4MXodg+88StngeK5ppVzWDHJ4vDHh6px4uA6UWbXtkPy7OMCArnZuK9+vy+ucG
         k7fu1QX5jMr5tETrVdVZ3WAnaDmRu2QVle9899khA/4lln373LBXbPdJFmayqL38PO9B
         GrvbRKgeVAkaqftF1I/tLbdbFeI8SwHIN3JeE8V4RHooweIhcPzEL346V+CQm+Y3aW2e
         WBWU7gQOAC1vKAyaH/3l73amKi746zRV6Gkhibu5d/X4DZG4+4qGH3jlFrrGtA1h8q2I
         hrbYA3JyCAgkbR01uJYH4Qn4EVlVpC182yGv0WWuiWVrfSvrWiomhhtXT1Tjg3fC4a36
         CJeg==
X-Gm-Message-State: AOAM53258i+PYEGgVLay6RTeHfsLDXf0aL6WkdiDXD9EqOShsCdye5jA
        CFOyVsPSzM3/m8D9jbU1s2w=
X-Google-Smtp-Source: ABdhPJz/M/CGf5j20eOYNfGCIGqfS/YmISxAz19JpTLThxaMhI467H76iT17xT8Ke61WLyHZICR79A==
X-Received: by 2002:a17:902:ec92:b0:158:71e5:fcda with SMTP id x18-20020a170902ec9200b0015871e5fcdamr6028529plg.143.1649739362586;
        Mon, 11 Apr 2022 21:56:02 -0700 (PDT)
Received: from [192.168.255.10] ([203.205.141.113])
        by smtp.gmail.com with ESMTPSA id y20-20020aa79af4000000b005056a0171bdsm15689430pfp.6.2022.04.11.21.55.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Apr 2022 21:56:02 -0700 (PDT)
Message-ID: <fa9f787d-467d-18e1-79bf-72a720bbde86@gmail.com>
Date:   Tue, 12 Apr 2022 12:55:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH] perf/x86/amd: cpu_hw_events::perf_ctr_virt_mask should
 only be used on host
Content-Language: en-US
To:     Dongli Si <kvmx86@gmail.com>
Cc:     acme@kernel.org, alexander.shishkin@linux.intel.com, bp@alien8.de,
        dave.hansen@linux.intel.com, hpa@zytor.com, jmattson@google.com,
        jolsa@kernel.org, joro@8bytes.org, kim.phillips@amd.com,
        liam.merwick@oracle.com, linux-kernel@vger.kernel.org,
        linux-perf-users@vger.kernel.org, mark.rutland@arm.com,
        mingo@kernel.org, namhyung@kernel.org, peterz@infradead.org,
        tglx@linutronix.de, x86@kernel.org
References: <edfc8bd1-8dc3-9e88-d9c3-6a427b039a98@gmail.com>
 <20220412012530.794790-1-sidongli1997@gmail.com>
From:   Like Xu <like.xu.linux@gmail.com>
Organization: Tencent
In-Reply-To: <20220412012530.794790-1-sidongli1997@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/4/2022 9:25 am, Dongli Si wrote:
> On Mon 11 Apr 2022 22:29:18 +0800, Like Xu wrote:
>> Or you can work it out to make nested vPMU functional on AMD.
> Unless in the future kvm wants to emulate on L1 HV the behavior of not
> count when HO bit is set and SVM is disabled, otherwise it doesn't make

In fact, I would prefer that we make a little effort to enable nested vPMU.

> sense to use perf_ctr_virt_mask in the guest to mask HO bit. At least for
> now, this patch helps clarify what perf_ctr_virt_mask actually does.

This has been clarified by the commit 1018faa6cf23.

> 
>> This is not a typical revert commit.
> Thanks for pointing out the problem with my patch,
> I will write another patch specifically to revert this commit.

The indispensable commit df51fe7ea1c1 is concerned with the symmetric use of
'disable_mask' in both __x86_pmu_enable_event() and x86_pmu_disable_event().

I had this false assumption at that time, and we'd better support HOST, GUEST}ONLY
bits in the L1 for L2 guest, and if not, it's bug. Please help. :D

> 
>> Please check the chronological order of the related commits and the motivations.
> I know that commit df51fe7ea1c1c fixed the problem of use vPMU on old KVM,
> but I think it's a speculative way and make things a little obscure,
> because this #GP is actually a KVM problem rather than a guest problem,

And we have 9b026073db2f to fix KVM for older guest kernel.

> I think it is the user's responsibility to update their host kernel.
> 
>>> +	/*
>>> +	 * When SVM is disabled, set the Host-Only bit will cause the
>>> +	 * performance counter to not work.
>> It's ridiculous. Based on the AMD APM Table 13-3. Host/Guest Only Bits,
>> the performance counter would count "Host events" rather than "not work".
> You are wrong, you can test it on the host, and the description of the
> commit 1018faa6cf23 also pointed out this problem, this is the result of an
> experiment, AMD APM has not documented this problem.

I have to say it's true on a ZEN3 host after a quick experiment.

> 
> I forgot to say this is the behavior on the host, I will improve this
> comment to specify 'why' more clearly, like this:
> 	/*
> 	 * It turns out that when SVM is disabled on the host (L0), set the

Again, we need the semantics to hold true on L1.

> 	 * Host-Only bit will cause the performance counter to not count.
> 	 */
> 
>> Note, your proposal change should work on the L0, L1 and L2.
> Yes, I tested it on L0, L1, L2 with 5.18-rc1 and it works as expected.

Specifically for L1, we need rely on the EFER[SVME] check instead of the
meaningless "boot_cpu_has(X86_FEATURE_HYPERVISOR)".

> 
> There is a related discussion here:
> https://lore.kernel.org/all/20220320002106.1800166-1-sidongli1997@gmail.com/
> 
> Regards,
> Dongli
> 
> 
