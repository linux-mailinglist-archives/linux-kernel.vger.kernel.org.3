Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED455919E8
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 12:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239182AbiHMKpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 Aug 2022 06:45:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237459AbiHMKpA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Aug 2022 06:45:00 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CCFC27FEF;
        Sat, 13 Aug 2022 03:44:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id i14so5828887ejg.6;
        Sat, 13 Aug 2022 03:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :from:to:cc;
        bh=faMMpjPtybNNka6ejfIMqU3qok+o9ew7dmDnWKZzcxI=;
        b=LZzCv7O/9t7QRNgysw6SJUSx/6UOGD6zErpTiMgH9KadClkfazwBt8sDqG+UIcy32m
         W8oiR0PeJ6USfPWKK6DO2xlKU1CFP4+qXNRN+qJGopKgydPoEh1IGlN2Gw838fDB+wEn
         sSFQumJmmco/hPJp93QPCNp3mbVqg6v9Snfsq5iqSXCEAaRKq2gKejCdSmNoalM8rYC5
         lIR1FnQjGab3Z6j/9lUUwtDbqiiAnzrciE1CnxMBQejdE+qCxyc+PDIcyxqImUQ04S7X
         wlTn2/LlRDmItqS/gCtZfG7yQQmfiClHAoliQ1pxDxRCLpJEI08/nPNum/YJDnQy10Pp
         YcUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:sender
         :x-gm-message-state:from:to:cc;
        bh=faMMpjPtybNNka6ejfIMqU3qok+o9ew7dmDnWKZzcxI=;
        b=XercUSLQmN9NSmDI9I34BkZcpE0SXt40GBDde4hBuVFCjVYiYR+TFyR4mzMqrNfjiF
         wdqf6mueUZyX7tesWSz3e8U7vYy05iqYc6sT753bMGe95v9q3x+nUDhtjykWA8xMYctZ
         8S/khLY7aUncZHcU9/L6Ub+lC1OPey7lZVqERkZOG78PPcZyFhTG3u04nIq/FLYrBCqX
         oO9pnn+SiLz4u4LvQiaXZ+bXjOizfaZfU4rypLfYjLtSBQxn/5rHg7/b30nCAY3JUHJc
         i31yRKcSvjcrPp0LLi+o4jU40jWKH8By/IlHLqWUfaTlt1bj+ggd6xxw0UPwXbJvcYzS
         6POg==
X-Gm-Message-State: ACgBeo07iex2BQjIb5tjr5yxMtYzTTM/s4TobfUs0qHsrqf7WljjymSz
        pch+QsUq16UVdJcmAjdPDXg=
X-Google-Smtp-Source: AA6agR7ss9Oz8AT3rch6AhUFv4plkkAY3KML0Lov2Xmuj2pQ9rFSmS3I7EPe8V/wubIes8HrptdkfA==
X-Received: by 2002:a17:907:60c8:b0:730:9efe:ecbd with SMTP id hv8-20020a17090760c800b007309efeecbdmr5065262ejc.90.1660387497734;
        Sat, 13 Aug 2022 03:44:57 -0700 (PDT)
Received: from gmail.com (84-236-113-143.pool.digikabel.hu. [84.236.113.143])
        by smtp.gmail.com with ESMTPSA id b10-20020a0564021f0a00b0043df40e4cfdsm2802356edb.35.2022.08.13.03.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Aug 2022 03:44:57 -0700 (PDT)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date:   Sat, 13 Aug 2022 12:44:55 +0200
From:   Ingo Molnar <mingo@kernel.org>
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org,
        linux-hwmon@vger.kernel.org, tglx@linutronix.de, mingo@redhat.com,
        bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
        corbet@lwn.net, fenghua.yu@intel.com, jdelvare@suse.com,
        linux@roeck-us.net, len.brown@intel.com
Subject: Re: [PATCH 0/7] x86/topology: Improve CPUID.1F handling
Message-ID: <YveAp8W3zZliQXrq@gmail.com>
References: <20220812164144.30829-1-rui.zhang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220812164144.30829-1-rui.zhang@intel.com>
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


* Zhang Rui <rui.zhang@intel.com> wrote:

> On Intel AlderLake-N platforms where there are Ecores only, the Ecore
> Module topology is enumerated via CPUID.1F Module level, which has not
> been supported by Linux kernel yet.
> 
> This exposes two issues in current CPUID.1F handling code.
> 1. Linux interprets the Module id bits as package id and erroneously
>    reports a multi module system as a multi-package system.
> 2. Linux excludes the unknown Module id bits from the core_id, and results
>    in duplicate core_id’s shown in a package after the first issue solved.
> 
> Plus that, a third problem is observed on Intel Hybrid ADL-S/P platforms.
> The return value of CPUID.1F SMT level EBX (number of siblings) differs on
> Pcore CPUs and Ecore CPUs, and results in inconsistent smp_num_siblings
> value based on the Pcore/Ecore CPU enumeration order. This could bring
> some potential issues although we have not observed any functionalities
> issues so far.
> 
> Patch 1/7 and 2/7 fix the first two issues. And at the same time, it
> reveals a reality that the core_id could be sparse on platforms with
> CPUID.1F support.
> Patch 3/7 improves coretemp driver code to be able to handle sparse core
> id, which is the only driver that uses core_id as array index and run on
> platforms with CPUID.1F support.
> 
> Patch 4/7 to 7/7 propose a fix for the third problem and update the
> related Documents.

Yeah, so patch 3/7 probably needs to come first - otherwise there's a 
window for bisection breakage.

Thanks,

	Ingo
