Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DE954EDC6
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Jun 2022 01:07:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379295AbiFPXHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 19:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378348AbiFPXHq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 19:07:46 -0400
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958F513D55
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:07:45 -0700 (PDT)
Received: by mail-il1-x135.google.com with SMTP id a15so1909481ilq.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 16:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linuxfoundation.org; s=google;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=A/ErIrNj5gItrQCkLlcIujK6eoGjp3nC9yABjFCnK/8=;
        b=dqGsgNArhDuF3C4hLhzp+lhKzSPCpnjS1CN0m8V2rVj3xLISsiNjMqpGoEp0xfWG/8
         QadAGuhCBY7yWgoT3uNjJMIyx0CSG/wAyOPavmcGjx6Olz6I1vG3ePcCnNArbMg1OP9Z
         xIDkKeBumj5d6hBpuSqw78YfEdqxBNSDGcSNU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=A/ErIrNj5gItrQCkLlcIujK6eoGjp3nC9yABjFCnK/8=;
        b=ylKnd6OtLUFChdp6UZfFhQCBiszC3MjTiWu/pqABWx1pS61BPq4+/cka3LHk4lAyvg
         9iugJclNmzNlwFPLbUZIirs9MaLuXrxRHglBq9lmp/RrDLtoTSp9QCznGiX4JLOiriJG
         Q4Olb4gK6ILUUiJkHC4IeLovuY1YKPAtg/BANmg17TLW7xwzYobygjyuUmIn94gqCUxp
         KJzEcXNOOnweNjLWjdgSq1XeU/hJiZIcdEoun9PZGwjYPbXuPaoJmwbzCKepbJl408hX
         +gXCoHFWjQzleIaAZD9iH0yv7UdNGq1VO3LkGuqyAfl2HzM1uaohotr/PdFMQPN/J/vZ
         c7vg==
X-Gm-Message-State: AJIora+IAE7ABDyG+Ri0njMZ6Sz70W4oOB9alI9uCd2wApMZkqrUlN6I
        SToC2VbwzJXsOy1jptJWEI5QYw==
X-Google-Smtp-Source: AGRyM1vwvwGPuBp7z/XIoKlWkDKMY8JnO1t3HY94c0elZo3/2d39TUYxR+t5/rxgFh1iaB+puAZQAA==
X-Received: by 2002:a05:6e02:1a43:b0:2d3:cded:23dc with SMTP id u3-20020a056e021a4300b002d3cded23dcmr3942385ilv.43.1655420865020;
        Thu, 16 Jun 2022 16:07:45 -0700 (PDT)
Received: from [192.168.1.128] ([38.15.45.1])
        by smtp.gmail.com with ESMTPSA id z4-20020a029384000000b0032e91c1f73csm1439619jah.92.2022.06.16.16.07.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Jun 2022 16:07:44 -0700 (PDT)
Subject: Re: [PATCH] selftests: make use of GUP_TEST_FILE macro
To:     Nico Pache <npache@redhat.com>, Joel Savitz <jsavitz@redhat.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shuah Khan <shuah@kernel.org>, Linux MM <linux-mm@kvack.org>,
        linux-kselftest@vger.kernel.org,
        Shuah Khan <skhan@linuxfoundation.org>
References: <20220609203217.3206247-1-jsavitz@redhat.com>
 <CAA1CXcARipJgCW4PrxxUqf9fyCcD7+M1B0NRRZpdCfPXfrzrdQ@mail.gmail.com>
From:   Shuah Khan <skhan@linuxfoundation.org>
Message-ID: <30ac57f2-c95b-27f3-888e-d89c125770b0@linuxfoundation.org>
Date:   Thu, 16 Jun 2022 17:07:44 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
In-Reply-To: <CAA1CXcARipJgCW4PrxxUqf9fyCcD7+M1B0NRRZpdCfPXfrzrdQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/9/22 3:50 PM, Nico Pache wrote:
> LGTM! Good catch :)
> 
> Acked-by: Nico Pache <npache@redhat.com>
> 
> On Thu, Jun 9, 2022 at 4:37 PM Joel Savitz <jsavitz@redhat.com> wrote:
>>
>> Commit 17de1e559cf1 ("selftests: clarify common error when running
>> gup_test") had most of its hunks dropped due to a conflict with another
>> patch accepted into Linux around the same time that implemented the same
>> behavior as a subset of other changes.
>>
>> However, the remaining hunk defines the GUP_TEST_FILE macro without
>> making use of it. This patch makes use of the macro in the two relevant
>> places.
>>
>> Furthermore, the above mentioned commit's log message erroneously describes
>> the changes that were dropped from the patch.
>>
>> This patch corrects the record.
>>
>> Fixes: 17de1e559cf1 ("selftests: clarify common error when running gup_test")
>>
>> Signed-off-by: Joel Savitz <jsavitz@redhat.com>
>> ---

Applied to linux-kselftest fixes for next rc

thanks,
-- Shuah
