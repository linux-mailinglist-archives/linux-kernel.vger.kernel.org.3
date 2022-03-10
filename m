Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42A854D531E
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 21:32:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244823AbiCJUd1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 15:33:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232725AbiCJUdW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 15:33:22 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B022F3284
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:32:20 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id x4so7872383iop.7
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 12:32:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=DLr3mQYXmDHbd+LBhBUi7dTKTmk6a0trl2Y2FAGkhQk=;
        b=I/+Xd9JvfV4nd6qZCvwS8Ojf1XjyRTKJ2gaOyW9PLvPZXe72yXxjTZDQVFwtIOA4CD
         7gj7jC/qRFTME2IISxgQqFam3G3Cee2O3wpazRsMEMN0TEh3VVhYaDwyCKAK+rlwrZ7b
         5z2UClc6rkg6OE+PGBWlvmDS4qeULrf+P2Kiw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=DLr3mQYXmDHbd+LBhBUi7dTKTmk6a0trl2Y2FAGkhQk=;
        b=VKIXqVGoohL2NcoMeYG6HiBOtoxkRg3Ml//F6aW95lydXH3dZdAUnFM3mfj+O1Hl4j
         rzsfoKGPkPjMsL9Q717560+S29uthoZlRpCuVK4r+OKUajGI+SEZ12kunSHad+CWNUTq
         M4bT5Me6M+aSR8sL/YEtf2n5vOSvcz/8KJsPsz2FfsFZVuqmpK2u2yRpVarCUSeiShH2
         krpPIYAkQ/Y0aem49qKRDpCqL7ZZ2XGH0yjLaANafZ/Q6HiCJ0wnIKQGo9qaKK2bVNVJ
         bDHceNbzONV0HcMEIqjhULJ16fpd1BBAmjEt6NXkLCi0ePqSwxx0nVbf/lQOHY1c3zkq
         ETHg==
X-Gm-Message-State: AOAM532pwY7ch3nTl1TjPqxGxxNA6/z4YOP6Iy17Sk1sSOJ2EbZceR4G
        E5hX+p8PZ9Rcz0MLoRAiT1KEcQ==
X-Google-Smtp-Source: ABdhPJzGYJJ66lGrR9KD/M0EG6Zi/5nRvruDQV4FiOAuS/Sc7kzsbS/JS9cK6MUhafBgg6dI6oMGQg==
X-Received: by 2002:a6b:ce01:0:b0:610:8f2:3b7 with SMTP id p1-20020a6bce01000000b0061008f203b7mr5389673iob.25.1646944339851;
        Thu, 10 Mar 2022 12:32:19 -0800 (PST)
Received: from [192.168.1.128] ([71.205.29.0])
        by smtp.gmail.com with ESMTPSA id b10-20020a056602000a00b0064074921986sm3169961ioa.41.2022.03.10.12.32.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 12:32:19 -0800 (PST)
Subject: Re: [PATCH v3] selftests/resctrl: Print a message if the result of
 MBM&CMT tests is failed on Intel cpu
To:     "tan.shaopeng@fujitsu.com" <tan.shaopeng@fujitsu.com>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Shuah Khan <shuah@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-kselftest@vger.kernel.org" <linux-kselftest@vger.kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220304103957.487660-1-tan.shaopeng@jp.fujitsu.com>
 <9647f7ed-6a02-8603-0de4-3292d4d13157@linuxfoundation.org>
 <TYAPR01MB63307F1C04270DD2D09ACF238B0B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <480705b1-6f22-e129-2db0-2a9c5841eacc@linuxfoundation.org>
Date:   Thu, 10 Mar 2022 13:32:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <TYAPR01MB63307F1C04270DD2D09ACF238B0B9@TYAPR01MB6330.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=iso-2022-jp; format=flowed; delsp=yes
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/10/22 1:18 AM, tan.shaopeng@fujitsu.com wrote:
> Hi Shuah,
> 
>> On 3/4/22 3:39 AM, Shaopeng Tan wrote:

>> Also need to be rebased on mainline latest
> 
> I will rebased on mainline latest in next version.
> 

>> Why is this a global? I am not seeing a reason. These detect_*()s could be
>> moved to resctrl.h and get rid of globals.
>>
>> Instead of adding intel check to detect_amd() add detect_intel() or is_intel()
>> and have ut return true of it detects intel.
> 
> "is_amd" and "is_intel" are called many times,
> in this way, detect_vendor is called only once.
> 
You can do the lookup once and save the value to return for
subsequent calls instead of using global values is_amd
and is_intel.

thanks,
-- Shuah

