Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CDD5517F26
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 09:48:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232239AbiECHwF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 03:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231856AbiECHwB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 03:52:01 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48B2A205C8
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 00:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651564108;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RK4+d7IXOmnVvMuBtdXRM0A5n8ssUbmBR+IC4Lj417Y=;
        b=Y6+xiWT8KH5q6hivjGp2YhtqI3wds2P+up2rx9/WdXa4M/Q25yywapYOYFhZi06caYaR0N
        SdZqmQFH5e/WT2MtNZiV0XP2OFXu+fR4JN3znWalRed92VMjYAidlcOgV3NoYMXx9iGhN5
        gWupVhSwZ8YN9mNCIB+lIlwxWSwLSII=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-19-lCQbyzxjP9q_U-HPtzJ3UQ-1; Tue, 03 May 2022 03:48:25 -0400
X-MC-Unique: lCQbyzxjP9q_U-HPtzJ3UQ-1
Received: by mail-ed1-f70.google.com with SMTP id cf16-20020a0564020b9000b00425d543c75dso9604886edb.11
        for <linux-kernel@vger.kernel.org>; Tue, 03 May 2022 00:48:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=RK4+d7IXOmnVvMuBtdXRM0A5n8ssUbmBR+IC4Lj417Y=;
        b=4Vg5Xmukgo9aPuRAeobu0OMQkBlb9omNu8sS14/50pB9fFH6ag+MALZf90aj5Vkn4Q
         zS0HMABVRALEWv3phml9v9sxsUl0nc7CfD/GAyUcAq0l4LNnSoux5SIF8kRAXNeqogAL
         WE1y8eGQxh9ci7oC1LANFTD8hSJT1zuY56KcDyPGH274oadr511yWniG0MgcZwBav5aR
         +QfpSx/Mdvp8b8brKyurHI9zEOT5R0X36rl1pm1JdzfphPfB2qV13Z+C2X2zthLwlam2
         +6J97lBP/JRbRisJwnDU3arrFwiPwschf7qiojKpmKhBHm25l4fhdDPFfAnHeL8GiMU3
         bHbA==
X-Gm-Message-State: AOAM530BBj7UaLgR+XzQS0HPGNS+XTmz5do4f5ntreSlP9HVl0W6wOKO
        9QghwtC4sA0YT10ZQCcWDganO2i/sAiiZhGnEmd0SGcvGtNDD7Z2ve2WZht+G1u6XBvEwo5KuNq
        ZLdK8UBRgD75QUIDGkCfGaxvc
X-Received: by 2002:a17:906:19c3:b0:6ec:c7b:ed28 with SMTP id h3-20020a17090619c300b006ec0c7bed28mr14140040ejd.612.1651564103919;
        Tue, 03 May 2022 00:48:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwAaULOlxzyT0iv2iUzlfT8MNaSJkBtBPmhJ5VcL6pKgzwEbSFqaxeTus5zp8qT3F+CAYQj5A==
X-Received: by 2002:a17:906:19c3:b0:6ec:c7b:ed28 with SMTP id h3-20020a17090619c300b006ec0c7bed28mr14140028ejd.612.1651564103744;
        Tue, 03 May 2022 00:48:23 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id dq10-20020a170907734a00b006f3ef214deasm4366641ejc.80.2022.05.03.00.48.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 May 2022 00:48:23 -0700 (PDT)
Message-ID: <84b5b002-9d5f-e87d-ef54-95a161a72718@redhat.com>
Date:   Tue, 3 May 2022 09:48:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 0/4] platform: allow ATOM PMC code to be optional
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Paul Gortmaker <paul.gortmaker@windriver.com>,
        linux-kernel@vger.kernel.org,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Len Brown <lenb@kernel.org>, linux-acpi@vger.kernel.org,
        Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20220428062430.31010-1-paul.gortmaker@windriver.com>
 <YmpoeJtFNSyCq1QL@smile.fi.intel.com> <20220428181131.GG12977@windriver.com>
 <827dc313-33ff-1c91-afaf-7645b655a1be@redhat.com>
 <YnABLhyUGR+ZRQ+u@smile.fi.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YnABLhyUGR+ZRQ+u@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 5/2/22 18:05, Andy Shevchenko wrote:
> On Mon, May 02, 2022 at 04:30:57PM +0200, Hans de Goede wrote:
>> On 4/28/22 20:11, Paul Gortmaker wrote:
> 
> ...
> 
>> As for users breaking support for BYT/CHT setups because they forget
>> to enable this, without X86_INTEL_LPSS being enabled BYT/CHT are pretty
>> much broken anyways and since patch 2/4 adds a "select PMC_ATOM" to the
>> X86_INTEL_LPSS Kconfig option I'm not really worried about that.
>>
>> I'm afraid this patch-set might break some randomconfig builds though,
>> but I cannot see anything obviously causing such breakage here, so
>> I think it would be fine to just merge this series as is and then
>> see if we get any breakage reports.
>>
>> Andy, are you ok with me moving ahead and merging this series as is?
> 
> It seems as is can't be fulfilled due to your own comment, but in general I'm
> not objecting the idea. So, go ahead if you feel it's ready.

Right, my later comment to just replace PMC_ATOM with X86_INTEL_LPSS
supersedes this.

I'll send out a patch with that approach so that this can get some
comments / review.

Regards,

Hans

  

