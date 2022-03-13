Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B6F44D7637
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 16:12:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234843AbiCMPNV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 11:13:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234928AbiCMPNE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 11:13:04 -0400
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B27BC88B1D;
        Sun, 13 Mar 2022 08:11:35 -0700 (PDT)
Received: by mail-lj1-x22f.google.com with SMTP id q10so18493812ljc.7;
        Sun, 13 Mar 2022 08:11:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/YZP9Ni2/PwKGjjsTkna0G1iD0zfuNVerQEipZQiGvA=;
        b=b1ujd0ijJIGHBJN+zrURnFyHRx4NopdcVGI0z9MfmBCpfGy2OdHjc5FX16lcehD14G
         /w45pj2zr947mi2rn7XgbCFPuHlIucaV+3vNc3DgsSwX6Nw/M6/nd+HPGGqp55iAcwF8
         4SXE/3cfMCuJKVazPCJjgZvyoWKV2wupiADe8ryXr6rf8i5d4n7/RppwwNnArHMirdVz
         Cger62S9mh1AWsMinGAIbro9loEjL5d6FwGyiLlNitsjGBrpukIftWzMAhL1WWZUlCJG
         nRgmur7C3hQZEvbVwxCZQY4JdqUBnsAxVzfFA4b25Pqc1Ar3R4K3PVI9UC/1pTfBM3ec
         uf+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/YZP9Ni2/PwKGjjsTkna0G1iD0zfuNVerQEipZQiGvA=;
        b=ZjAMyAal5lFf7pnyXjFuSUC7ygnU1SiDAaeQaBUapnC087JIxHqy/trak4s8H3cjdf
         DILz7cTUhSZEqFHYe1XryObSTAdBVgkWiHTy00NysuwW2qNDOfJtoFSCipeTDWd4DSL1
         WN6U7UChDT87/XMDwia+vgrhz4rSpTcQxAUOFGlVa49ZN0ZKAocDuC2vZx/qQew47Xu+
         9uFrb6Cwrn+x2vlH32RqHH+aHk+Di5plhiRanPzc/IdpXu4WFb4gWkU/diaFasFpx+6s
         ZtdtM+srRcy/FjxYdexhKZw4dD2dju9C/DWjTIS0uF/0HPqadzIse6jPArQQGotiXc4m
         gQgA==
X-Gm-Message-State: AOAM532lY3uMI5wDbrTVtFefctDlS4ACkgGhaphBMWtBynCFntKtar/6
        jAogw7NHhQRAA0tAyDCEO0E=
X-Google-Smtp-Source: ABdhPJyYfMsmbhnKzf9G48TbiEjgm3TG236ZS2wwECO+FK3GwCwJOcE9wxPcZGcCj1Cj2myeRtNO6Q==
X-Received: by 2002:a2e:b0cc:0:b0:235:dcdf:e6e9 with SMTP id g12-20020a2eb0cc000000b00235dcdfe6e9mr12399014ljl.88.1647184277427;
        Sun, 13 Mar 2022 08:11:17 -0700 (PDT)
Received: from [192.168.1.11] ([94.103.229.107])
        by smtp.gmail.com with ESMTPSA id i6-20020a2ea366000000b00248073ae9a2sm2851984ljn.84.2022.03.13.08.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 08:11:16 -0700 (PDT)
Message-ID: <0d8dfedb-1c2c-1a70-18dc-0c4439cf4bda@gmail.com>
Date:   Sun, 13 Mar 2022 18:11:15 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH] media: stkwebcam: move stk_camera_read_reg() scratch
 buffer to struct stk_camera
Content-Language: en-US
To:     Tom Rix <trix@redhat.com>, mchehab@kernel.org,
        hverkuil-cisco@xs4all.nl, cai.huoqing@linux.dev,
        xose.vazquez@gmail.com
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220312173049.1410977-1-trix@redhat.com>
 <65a1d178-8511-a023-2655-94540114086c@gmail.com>
 <c3723690-cacb-0c42-cc5d-397a3363b4da@redhat.com>
From:   Pavel Skripkin <paskripkin@gmail.com>
In-Reply-To: <c3723690-cacb-0c42-cc5d-397a3363b4da@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

On 3/13/22 02:48, Tom Rix wrote:
> These do show up in my usual static analysis and it why I was looking at
> this file.
> 
> And was sidetracked by the short malloc.
> 
> Unfortunately I looked and there are many other similar instances
> treewide ~100
> 

Most of them are in very old drivers and I don't think they ever be 
fixed. I've looked into one bug reported by syzkaller and there was like 
30 calls w/o proper error handling in one driver. Redoing whole driver 
logic without access to hw seems dangerous :))


> These aren't caught in checkpatch, so working on that..
> 

I think, it's not checkpath responsibility. Maybe it worth adding such 
check to smatch. I tried to implement such checker, but never finished it :(



With regards,
Pavel Skripkin
