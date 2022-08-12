Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8FEBB59138A
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 18:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239123AbiHLQKI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 12:10:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232085AbiHLQKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 12:10:04 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52927AE9C1;
        Fri, 12 Aug 2022 09:10:02 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id t2-20020a17090a4e4200b001f21572f3a4so1338658pjl.0;
        Fri, 12 Aug 2022 09:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :from:to:cc;
        bh=/nFggMMNNlaPmhaTo8QA+3I8BiLaazFsymmp6TLqsYY=;
        b=ZkFif2M0hv2wkSZ7HWWGusHaWBYqPNGCko51NBDvXYHxDVp+uAK/WKIpvIZJPdxKpK
         dvZQ1Hu/zvfxTBhGt63J0gznBBQFTQkZabqvzGX7hM0kAQejvsGlCsBPD01zzH+p+0lT
         OkKuDchdLH7qRsv4fggMwMiuPL4wQ3VW8oIg2iacYHkTfeFz0lp9WAg4J5fa9V4Sy2AO
         OA8aIeT5JDhgXWdDTgx5ln7S+nk6vfTObU84kIln2asfStcpVrSb6qq8+DHBEA87cMGw
         8g8WgCRIQNmvhE3MTlwbJWPmpcD3TQPqJYKBVpdbAQL6A3nNKep+WjqvBq0BoI54sOOZ
         a+Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc;
        bh=/nFggMMNNlaPmhaTo8QA+3I8BiLaazFsymmp6TLqsYY=;
        b=WsuMiXDzYWwqjaIbUhmKCXHDSpErc8W6KKnrw7qYS/tUvB2NSHIpisrL7AiTKsH71p
         xyibey/QMHnnkrW7/lUiOcQjB5i5Pd9YIdDi2jgw3HsUMAa72ez9NucMjn1MOBhR88Uf
         QOlS8/oLWiSIf65l261sJ5ZlVumgbVflkZ5cqK77pdM3MN+yC+tbVk1HosecSWFUdavC
         vAVb6l/pD/zpO/ztz+t5OIiL7/fhYb7qiHpvzxWH9Zzh5FfMuMuxdvte0uZGwRMJpOM2
         q4ESzRSYlicYF56ElHb55CY+dQM8pzPgDXFuLUIDJDj9QmTbngrGEzMP/tbn5ZSN+aw5
         Doyw==
X-Gm-Message-State: ACgBeo14avJLkkvGQH3a+fFyJGXPJgW+xP+BZQZ96hoLPllNZaTI21KY
        zDhaLxVcU8VadMi0xh1V0QQ=
X-Google-Smtp-Source: AA6agR53Bl0IP3qT+xd70jiFRyBLXCmxObNLrxZSkE42ZH0PbgaZAXD0iAmZKS/n9vdfRRMqtE3c6w==
X-Received: by 2002:a17:902:e552:b0:16c:571d:fc08 with SMTP id n18-20020a170902e55200b0016c571dfc08mr4716482plf.151.1660320601766;
        Fri, 12 Aug 2022 09:10:01 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b13-20020a170903228d00b001714fa07b74sm1984119plh.108.2022.08.12.09.10.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Aug 2022 09:10:00 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <57686aa5-b0bb-cd49-370c-ad1b376c48fd@roeck-us.net>
Date:   Fri, 12 Aug 2022 09:09:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Zhang Rui <rui.zhang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>, x86@vger.kernel.org
Cc:     tglx@linutronix.de, mingo@redhat.com, bp@alien8.de,
        dave.hansen@linux.intel.com, "H. Peter Anvin" <hpa@zytor.com>,
        Len Brown <len.brown@intel.com>,
        "Yu, Fenghua" <fenghua.yu@intel.com>
References: <41fc865a1e207ea03e15067c06856a92c58e18f6.camel@intel.com>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH 0/7] x86/topology: Improve CPUID.1F handling
In-Reply-To: <41fc865a1e207ea03e15067c06856a92c58e18f6.camel@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/12/22 08:08, Zhang Rui wrote:
> On Intel AlderLake-N platforms where there are Ecores only, the Ecore
> Module topology is enumerated via CPUID.1F Module level, which has not
> been supported by Linux kernel yet.
> 
> This exposes two issues in current CPUID.1F handling code.
> 1. Linux interprets the Module id bits as package id and erroneously
> reports a multi module system as a multi-package system.
> 2. Linux excludes the unknown Module id bits from the core_id, and
> results in duplicate core_id’s shown in a package after the first issue
> solved.
> 
> Plus that, a third problem is observed on Intel Hybrid ADL-S/P
> platforms. The return value of CPUID.1F SMT level EBX (number of
> siblings) differs on Pcore CPUs and Ecore CPUs, and results in
> inconsistent smp_num_siblings value based on the Pcore/Ecore CPU
> enumeration order.
> 
> Patch 1/7 and 2/7 fix the first two issues. And at the same time, it
> reveals a reality that the core_id could be sparse on platforms with
> CPUID.1F support.
> Patch 3/7 improves coretemp driver code to be able to handle sparse and
> large core id, which is the only driver that uses core_id as array
> index and run on platforms with CPUID.1F support.
> 

So far I only got this e-mail (and I don't find any of the other patches
elsewhere either), and it looks like the hwmon mailing list was not copied
on any of the patches. Please copy the hwmon mailing list for all changes
in hwmon code.

Thanks,
Guenter
