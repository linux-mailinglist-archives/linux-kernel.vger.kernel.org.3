Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D6654B7616
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 21:48:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243340AbiBOTBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 14:01:22 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbiBOTBU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 14:01:20 -0500
Received: from mail-il1-f174.google.com (mail-il1-f174.google.com [209.85.166.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72E53EBBB9;
        Tue, 15 Feb 2022 11:01:10 -0800 (PST)
Received: by mail-il1-f174.google.com with SMTP id o10so15611883ilh.0;
        Tue, 15 Feb 2022 11:01:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=UBBmp4DgxbJ3nAuN//yjsP9FmwDmp49m+83tg2kI50Y=;
        b=6KSrOYonYhJ96jW2hVv9ABGA6wGvjVAGSBDIWIkDZfVJeFFLNYTWrC+UKCD0awloRm
         awRfE98zhFXgc1eY4XQpHrve1mkprkNcMZkbzpqnKjqlIfy6iR8sDj+nyDMefQXUyTcW
         e/CxiaVzfI+wd6qgYLHqzVzvZhFXjby3+5kkLOrV2/KPZKtbiqLBCAnnaDpTEi6sPu7P
         Ubr9frcZ7aaTPde3eoLV8qhtz+62gU01WcME2slB9ytmF/xClKBDmntdpO6VfIUymkBV
         wFNH4UfUpqcpbUsqy3ZC4SG2BLpsAgT3oklL/arWGjdIVCxcNkAoIt/g4vqqH96cU7fp
         tXsw==
X-Gm-Message-State: AOAM533TF06t0Ob0aiGfgkHM4vJvPetYhvencW3rUU644hwHWRIy01+0
        tP9DyUvNEDbHvuCMOQjqRA==
X-Google-Smtp-Source: ABdhPJzr1JvD7wkz7BTuJejx6Q5hZPGEsJZTOE5TvygVd8PbAcJonZNUWrC4RHzDEmQr1FWxeEBVHA==
X-Received: by 2002:a05:6e02:1687:: with SMTP id f7mr281589ila.143.1644951668921;
        Tue, 15 Feb 2022 11:01:08 -0800 (PST)
Received: from robh.at.kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id q18sm18818854ils.78.2022.02.15.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 11:01:08 -0800 (PST)
Received: (nullmailer pid 3747771 invoked by uid 1000);
        Tue, 15 Feb 2022 19:01:06 -0000
Date:   Tue, 15 Feb 2022 13:01:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH 2/2] perf: Expand perf_branch_entry.type
Message-ID: <Ygv4cmO/zb3qO48q@robh.at.kernel.org>
References: <1643348653-24367-1-git-send-email-anshuman.khandual@arm.com>
 <1643348653-24367-3-git-send-email-anshuman.khandual@arm.com>
 <Yfpxv9+TP9rP72wL@FVFF77S0Q05N>
 <6168f881-92a4-54f8-929a-c2f40a36c112@arm.com>
 <Yf1N/EWjlQ/bEA0D@FVFF77S0Q05N>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yf1N/EWjlQ/bEA0D@FVFF77S0Q05N>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 04:02:04PM +0000, Mark Rutland wrote:
> On Fri, Feb 04, 2022 at 10:25:24AM +0530, Anshuman Khandual wrote:
> > On 2/2/22 5:27 PM, Mark Rutland wrote:
> > > On Fri, Jan 28, 2022 at 11:14:13AM +0530, Anshuman Khandual wrote:
> > >> @@ -1370,8 +1376,8 @@ struct perf_branch_entry {
> > >>  		in_tx:1,    /* in transaction */
> > >>  		abort:1,    /* transaction abort */
> > >>  		cycles:16,  /* cycle count to last branch */
> > >> -		type:4,     /* branch type */
> > >> -		reserved:40;
> > >> +		type:6,     /* branch type */
> > > 
> > > As above, is this a safe-change ABI-wise?
> > 
> > If the bit fields here cannot be expanded without breaking ABI, then
> > there is a fundamental problem. Only remaining option will be to add
> > new fields (with new width value) which could accommodate these new
> > required branch types.
> 
> Unfortunately, I think expanding this does break ABI, and is a fundamental
> problem, as:
> 
> (a) Any new values in the expanded field will be truncated when read by old
>     userspace, and so those may be mis-reported. Maybe we're not too worried
>     about this case.

'type' or specfically branch stack is not currently supported on arm64. 
Do we expect an old userspace which this didn't work on to start working 
with a new kernel?

Given at least some of the new types are arch specific, perhaps 
the existing type field should get a new 'PERF_BR_ARCH_SPECIFIC' or 
'PERF_BR_EXTENDED' value (or use PERF_BR_UNKNOWN?) which means read a 
new 'arch_type' field.

Another option is maybe some of these additional types just shouldn't be 
exposed to userspace? For example, are branches to FIQ useful or leaking 
any info about secure world? Debug mode branches also seem minimally 
useful to me (though I'm no expert in how this is used).


> (b) Depending on how the field is placed, existing values might get stored
>     differently. This could break any mismatched combination of
>     {old,new}-kernel and {old,new}-userspace.
> 
>     In practice, I think this means that this is broken for BE, and happens to
>     work for LE, but I don't know how bitfields are defined for each
>     architecture, so there could be other brokenness.
> 
> Consider the test case below:

[...]

> ... where the low bits of the field have moved, and so this is broken even for
> existing values!

So that is a separate issue to be fixed and not directly related to the 
size of 'type'. Looks like it needs similar '#if 
defined(__LITTLE_ENDIAN_BITFIELD)' treatment as some of the other struct 
bitfields. Though somehow BE PPC hasn't had issues?

Rob
