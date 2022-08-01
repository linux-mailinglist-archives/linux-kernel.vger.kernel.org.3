Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EDE1586B21
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:46:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234913AbiHAMp5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:45:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234981AbiHAMph (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:45:37 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 376B946DA4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:32:54 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j7so13933990wrh.3
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 05:32:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=nQEpMirCobOsOWattp713R2f+EJsY/28eyyRhLTxB+E=;
        b=1MBkA4LqiF8fI0dfhCjDcznALsi41csR8RWo8B2vXIaEqFfOsFRqiHCRFevYzqX8lq
         tdSDgz5bwsQG79hc3kd4cKyzpweWaDLj5euZHMZ8Q9zdEYqsShIHDKDFttv68frF9K51
         8F5YFa7BDVVbtQov0QIiY5bRRnf8WJxlf6auhTUNV9Po0xjI+/zxML6w8lS1N1rA5T3e
         2v+pH+AERHtt+02YqoXwVpiKGavKriiDMsM2ynRux63XWQdHX37BU//YBoiIm55BZ0X7
         RJq13GSYT2uWpGCrcFYjI2eWBsvW5nfLl9VW3XHlujK3xt5LVd9Ii05ttsfsiRg4YDAN
         gAtQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:references:date:in-reply-to
         :message-id:user-agent:mime-version;
        bh=nQEpMirCobOsOWattp713R2f+EJsY/28eyyRhLTxB+E=;
        b=hjQaujE/DsrL47KuwmB5e/dJP6eAhdC4EIOphIqtnziqEvDy9BNzp09QUCcwYId8QF
         /EqF9U685/DHsRFpRrZLt3eRGAARnOV7YCTOlsONH3FPQ1KdS4XKmmKoNNGhZGCeey76
         PgnoRhXOJUeYJQDITLK/VGsOdmBaDsv9CNDsE7K+zraof8UkKDNqSsLVYxC/R9HHf8oc
         hOCSNVbKYaIXtfjSzTY1stnoqb1Yrk9A2ojl2m4fc1gWw+3hF+jl1UcjrnJhRFN7J2F3
         szVSMS4oqjTl+TyVU9d39LDGhilWvSD6TjmvMvkxeseeeFPYEFFC1Xz+oFTwLgxNd+6q
         LdFA==
X-Gm-Message-State: ACgBeo0hhkQx/2LMT6bhSeM1U2mx2EiPPXEvjwB18giW46nKXTCeCSvz
        RrkKZSpQD2CoITMKWGjFqMTQtW/kfL0W6A==
X-Google-Smtp-Source: AA6agR7944sGCx6WI3LpU8LVDq4T/AE2Sxg90GKPb2BHCCrbdYHuOAn49HeQwObUPDO+UkB9PjVvcA==
X-Received: by 2002:adf:db4c:0:b0:21e:ef46:af22 with SMTP id f12-20020adfdb4c000000b0021eef46af22mr9755067wrj.424.1659357172791;
        Mon, 01 Aug 2022 05:32:52 -0700 (PDT)
Received: from localhost ([109.180.234.208])
        by smtp.gmail.com with ESMTPSA id e13-20020a5d65cd000000b0020fcaba73bcsm11806263wrw.104.2022.08.01.05.32.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Aug 2022 05:32:52 -0700 (PDT)
From:   Punit Agrawal <punit.agrawal@bytedance.com>
To:     Jeremy Linton <jeremy.linton@arm.com>
Cc:     Punit Agrawal <punit.agrawal@bytedance.com>,
        linux-pm@vger.kernel.org, rafael@kernel.org, lenb@kernel.org,
        viresh.kumar@linaro.org, robert.moore@intel.com, devel@acpica.org,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/1] ACPI: CPPC: Disable FIE if registers in PCC regions
References: <20220728221043.4161903-1-jeremy.linton@arm.com>
        <20220728221043.4161903-2-jeremy.linton@arm.com>
        <871qu4krb4.fsf@stealth>
        <a0bdc45a-c5c6-65ba-1ab8-e52dd26652d7@arm.com>
Date:   Mon, 01 Aug 2022 13:32:51 +0100
In-Reply-To: <a0bdc45a-c5c6-65ba-1ab8-e52dd26652d7@arm.com> (Jeremy Linton's
        message of "Fri, 29 Jul 2022 10:20:46 -0500")
Message-ID: <87tu6wjg98.fsf@stealth>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Jeremy Linton <jeremy.linton@arm.com> writes:

> Hi,
>
> On 7/29/22 07:59, Punit Agrawal wrote:
>> Hi Jeremy,
>> One comment / query below.
>> Jeremy Linton <jeremy.linton@arm.com> writes:
>> 
>>> PCC regions utilize a mailbox to set/retrieve register values used by
>>> the CPPC code. This is fine as long as the operations are
>>> infrequent. With the FIE code enabled though the overhead can range
>>> from 2-11% of system CPU overhead (ex: as measured by top) on Arm
>>> based machines.
>>>
>>> So, before enabling FIE assure none of the registers used by
>>> cppc_get_perf_ctrs() are in the PCC region. Furthermore lets also
>>> enable a module parameter which can also disable it at boot or module
>>> reload.
>>>
>>> Signed-off-by: Jeremy Linton <jeremy.linton@arm.com>
>>> ---
>>>   drivers/acpi/cppc_acpi.c       | 41 ++++++++++++++++++++++++++++++++++
>>>   drivers/cpufreq/cppc_cpufreq.c | 19 ++++++++++++----
>>>   include/acpi/cppc_acpi.h       |  5 +++++
>>>   3 files changed, 61 insertions(+), 4 deletions(-)
>>>
>> [...]
>> 
>>> diff --git a/drivers/cpufreq/cppc_cpufreq.c b/drivers/cpufreq/cppc_cpufreq.c
>>> index 24eaf0ec344d..ed607e27d6bb 100644
>>> --- a/drivers/cpufreq/cppc_cpufreq.c
>>> +++ b/drivers/cpufreq/cppc_cpufreq.c
>> [...]
>> 
>>> @@ -229,7 +233,12 @@ static void __init cppc_freq_invariance_init(void)
>>>   	};
>>>   	int ret;
>>>   -	if (cppc_cpufreq_driver.get == hisi_cppc_cpufreq_get_rate)
>>> +	if (cppc_perf_ctrs_in_pcc()) {
>>> +		pr_debug("FIE not enabled on systems with registers in PCC\n");
>> The message should probably be promoted to a pr_info() and exposed
>> as
>> part of the kernel logs. It is a change in the default behaviour we've
>> had until now. The message will provide some hint about why it was
>> disabled.
>> Thoughts?
>
> I personally flip flopped between making it pr_info or pr_debug and
> settled on debug because no one else was complaining about the
> cppc_fie consumption. Which to me, meant that the users of platforms
> utilizing PCC regions weren't sensitive to the problem, or weren't yet
> running a distro/kernel with it enabled, or any number of other
> reasons why the problem wasn't getting more attention. Mostly I
> concluded the FIE code hadn't shown up in "enterprise" distros yet..

I too was thinking that likely enterprise users haven't started digging
into the performance impact of enabling frequency invariance.

> But, yah, if no one is going to complain about the extra messages
> pr_info() is a better plan.

Thanks! I'll look out for the updated patch.

FIE was designed to improve load balancing (and arguably fairness
too). Hopefully, the message will aid users in looking more closely and
complain to system vendor / upstream if it matters to their workloads.
