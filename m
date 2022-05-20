Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7626B52E125
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 02:25:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343991AbiETAZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 20:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343983AbiETAZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 20:25:11 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C61512E31D
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:25:10 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id a19so6400720pgw.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 17:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:subject:to:cc:references:in-reply-to:mime-version
         :message-id:content-transfer-encoding;
        bh=yv36DBCzX/BQaDUaqPNqLF92qej9eDU0JwdcEZTabGk=;
        b=JcWqXFaY/sALkfW1Dx8cAjkIqdWGEUHyQUznTSVbbLbl1mbRMmFY8SuVJfLHUo2De5
         +A9/rvaAd0QTZ0rG2FjtXgzuTMAiK1Yx8cOEW2gdKRx1En7X3z0ifUDGIw9CM/KdQgfI
         adPvR8voG2EFvXZ7e7d8JYB/9LxDXn2ge1AuGmGy16vZFlsIy0r6qXdabjRyjlG8meg2
         mgpbuc/qynMsQSeQE01YRArkFzbCm+b3ik+CMLc/TC4WwOIHVYaDTvo7Fk9ZJ0AJ2E0o
         ot42Ht/JwKLFz5sFS4t0fC4hI0SEf2xZLLZLNrAstbJv5aq665+t25FyqlHwzhrtoj4H
         9q2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:subject:to:cc:references:in-reply-to
         :mime-version:message-id:content-transfer-encoding;
        bh=yv36DBCzX/BQaDUaqPNqLF92qej9eDU0JwdcEZTabGk=;
        b=GTBV30Ml5cUtmqDJG9bZHTppuS7CIy65yWIKm41tbRuVib5OnnwtgodHei/zWbwqBL
         neGcWPod84mjQlM3UGjkNjKWiPBGgv6ph3idqRNKjMJcaeCfTAmW/CzOwjQi5ijPST6o
         wCFMgIKlAN5zqhuVxCvqtFWZ5uQl50q2lWJtxzPh+3qoYg/ggQAxergombRyUCpKDDtB
         IR+YHaFlSO2VYcbqP0HkEKjOlj9nn8DHTaUJaoLEF524E4j+NVCNJgs5PqYxPjtZxOnQ
         97CdInA57ibAgISj3PBR3D4+jXCCdNVlKwCrshNQMw4bIJ60F3xJ5N/PvNb7Hk/d+bqU
         +z1Q==
X-Gm-Message-State: AOAM530GNV02y02vcKEfDsWCwxjzXaVQR/+5ASshDoK9lwVCofwtUZAf
        F1FOnWWrz/HGaMsFetAVbJ4=
X-Google-Smtp-Source: ABdhPJztXAbmH6BKWG9SQczKiPGMvBDhoc7zmfBNN5RglBamtXskVMyL+yYcdpdohA8XOXnd0Wwhmw==
X-Received: by 2002:a05:6a00:1a44:b0:510:a043:3b09 with SMTP id h4-20020a056a001a4400b00510a0433b09mr7110029pfv.62.1653006310004;
        Thu, 19 May 2022 17:25:10 -0700 (PDT)
Received: from localhost ([118.208.131.68])
        by smtp.gmail.com with ESMTPSA id b24-20020a056a0002d800b0050dc76281besm263161pft.152.2022.05.19.17.25.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 May 2022 17:25:09 -0700 (PDT)
Date:   Fri, 20 May 2022 10:25:04 +1000
From:   Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH v6 20/29] init/main: Delay initialization of the lockup
 detector after smp_init()
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
Cc:     Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        iommu@lists.linux-foundation.org, Joerg Roedel <joro@8bytes.org>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>,
        Ricardo Neri <ricardo.neri@intel.com>,
        Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>, x86@kernel.org
References: <20220506000008.30892-1-ricardo.neri-calderon@linux.intel.com>
        <20220506000008.30892-21-ricardo.neri-calderon@linux.intel.com>
        <1652178524.7j2o02lrl8.astroid@bobo.none>
        <20220513231640.GA9074@ranerica-svr.sc.intel.com>
In-Reply-To: <20220513231640.GA9074@ranerica-svr.sc.intel.com>
MIME-Version: 1.0
Message-Id: <1653005608.3e5k2jq3of.astroid@bobo.none>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Excerpts from Ricardo Neri's message of May 14, 2022 9:16 am:
> On Tue, May 10, 2022 at 08:38:22PM +1000, Nicholas Piggin wrote:
>> Excerpts from Ricardo Neri's message of May 6, 2022 9:59 am:
>> > Certain implementations of the hardlockup detector require support for
>> > Inter-Processor Interrupt shorthands. On x86, support for these can on=
ly
>> > be determined after all the possible CPUs have booted once (in
>> > smp_init()). Other architectures may not need such check.
>> >=20
>> > lockup_detector_init() only performs the initializations of data
>> > structures of the lockup detector. Hence, there are no dependencies on
>> > smp_init().
>>=20
>=20
> Thank you for your feedback Nicholas!
>=20
>> I think this is the only real thing which affects other watchdog types?
>=20
> Also patches 18 and 19 that decouple the NMI watchdog functionality from
> perf.
>=20
>>=20
>> Not sure if it's a big problem, the secondary CPUs coming up won't
>> have their watchdog active until quite late, and the primary could
>> implement its own timeout in __cpu_up for secondary coming up, and
>> IPI it to get traces if necessary which is probably more robust.
>=20
> Indeed that could work. Another alternative I have been pondering is to b=
oot
> the system with the perf-based NMI watchdog enabled. Once all CPUs are up
> and running, switch to the HPET-based NMI watchdog and free the PMU count=
ers.

Just to cover smp_init()? Unless you could move the watchdog=20
significantly earlier, I'd say it's probably not worth bothering
with.

Yes the boot CPU is doing *some* work that could lock up, but most=20
complexity is in the secondaries coming up and they won't have their own=20
watchdog coverage for a good chunk of that anyway.

If anything I would just add some timeout warning or IPI or something in
those wait loops in x86's __cpu_up code if you are worried about=20
catching issues here. Actually the watchdog probably wouldn't catch any
of those anyway because they either run with interrupts enabled or
touch_nmi_watchdog()! So yeah that'd be pretty pointless.

Thanks,
Nick
