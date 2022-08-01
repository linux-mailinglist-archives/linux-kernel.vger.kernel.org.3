Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48400586F8D
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 19:28:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232660AbiHAR2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 13:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232953AbiHAR1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 13:27:11 -0400
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04DBDEC;
        Mon,  1 Aug 2022 10:27:10 -0700 (PDT)
Received: by mail-pj1-f51.google.com with SMTP id ha11so11544194pjb.2;
        Mon, 01 Aug 2022 10:27:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=nr9rJS7HHDAsJ3c3o2JmPMTLZcjCDSrntaUfrab90gA=;
        b=DqLC0wm3alcPZQWeskhrH5M29+aBsbxsoeH1csTPznatBSrSyD8R12LU50W5HuNiq+
         Kw3G8HtPk+gDqwPTl/ppUNCFqCZ3bodGYAQqf2MevMkfsMtEXzOQrs29LAVtcMujnHGI
         NvWCFQIYv7hV4mEfgNUWtFTHCR4s2dGhRrGGl8GLTiD4rv8V9bAcFXki9pEHfswV05c9
         TLJsymrdMg0TALJLueQNhYdI7wk3OXcdN+pStUMG4F7+42VA8NkYP044sTwMhuZfG3yf
         ixkCQT+xOsnuTO/JMBrraPG+tvSZqY23GRfbPl8oet4aIT8fwL7Lihq3sRI4Gq4QLQ2i
         wG4A==
X-Gm-Message-State: ACgBeo2VCnMk84+lyheBNkE8JqXwo/th1ZngREbgfulmFst29392jY7B
        ac+98QxUGfhQgPG5xh73F3Qq/3erdSs=
X-Google-Smtp-Source: AA6agR46C0GeD25vxGuaYhM5OK0cjGYXueWe4bvmvaPaGfKnwiejdLdxIhaEjh40lkwF8zK/OJ+ISA==
X-Received: by 2002:a17:90b:1d10:b0:1f0:76f7:d154 with SMTP id on16-20020a17090b1d1000b001f076f7d154mr21135866pjb.79.1659374829278;
        Mon, 01 Aug 2022 10:27:09 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:6496:b2a7:616f:954d? ([2620:15c:211:201:6496:b2a7:616f:954d])
        by smtp.gmail.com with ESMTPSA id b12-20020a17090a550c00b001f2fbf2c42esm9185845pji.26.2022.08.01.10.27.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 10:27:07 -0700 (PDT)
Message-ID: <bb84d2cd-afd7-f2fb-785f-5bf6ef6f9be6@acm.org>
Date:   Mon, 1 Aug 2022 10:27:05 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH V3] scsi: ufs: Get boot device storage type from command
 line
Content-Language: en-US
To:     "Chetan Chinnadagudihundi Ravindranath (Consultant) (QUIC)" 
        <quic_cchinnad@quicinc.com>
Cc:     jejb@linux.ibm.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org, Christoph Hellwig <hch@lst.de>
References: <1659034814-3473-1-git-send-email-quic_cchinnad@quicinc.com>
 <77330f3a-5f73-e10f-7e85-f3df304aa4d7@acm.org>
 <f1cf652a-4a36-fe60-5a98-14b9d97c9a41@quicinc.com>
 <d473f4b3-9aba-fe39-d88c-b762d9d779b0@acm.org>
 <d620614b-6c20-d7ed-af19-ca0accb427d6@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d620614b-6c20-d7ed-af19-ca0accb427d6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/30/22 00:54, Chetan Chinnadagudihundi Ravindranath (Consultant) 
(QUIC) wrote:
>  > why a change is being made:
> There are 2 variants of the android bootdev device. One is EMMC and 
> other is UFS. We would be not knowing the android boot storage type at 
> build time. So, we need to know the storage type at run time(bootup 
> time) by reading the  "androidboot.bootdevice=". We need to distinguish 
> between EMMC and UFS at bootup time and take appropriate action.
> 
>  > Information about why support is being added for the 
> androidboot.bootdevice parameter in the Qualcomm UFS host controller 
> driver:
> 
> We will get the "androidboot.bootdevice=" by reading cmdline
> case 1: if the boot image header version is 3
>          We get the bootdevice info by reading /proc/cmdline ( 
> __setup("androidboot.bootdevice=", get_android_boot_dev_v3);
> 
> Case 2: if the boot image header version is 4
>          We get the bootdevice info by reading /proc/bootconfig 
> (android_boot_dev_v4 = xbc_find_value("androidboot.bootdevice", &vnode))
> 
> Qualcomm UFS modules(ufs-qcom.c) calls this 
> get_storage_boot_device()(ufs-cmdline.c)   and get the bootdevice info 
> and take appropriate action. This code is yet to be upstreamed. Please 
> let me know if this info convincing.

Instead of posting the above information on the linux-scsi mailing list, 
it should be integrated in the description of the patch. Please do that 
before reposting this patch and also make sure that the code that uses 
this new kernel command line parameter is included in the same patch series.

Thanks,

Bart.
