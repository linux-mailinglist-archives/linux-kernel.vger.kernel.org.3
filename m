Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2756B5AF80F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 00:42:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiIFWmq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 18:42:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiIFWmn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 18:42:43 -0400
Received: from mail-pj1-f54.google.com (mail-pj1-f54.google.com [209.85.216.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD74910A8
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 15:42:42 -0700 (PDT)
Received: by mail-pj1-f54.google.com with SMTP id o2-20020a17090a9f8200b0020025a22208so9196794pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 15:42:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=t+0cW+3xRq0TDzHntuF5BNTNFm6t7OwODbZ0zBnd/X4=;
        b=NUSaYkIUptX39/1wnDJ33tGulLzeqSLbvmv6f7M2FeFJvHvz4/DRCQpMNwW8IvGaId
         UQtv7Wu7iDPDhGA/WCtRtOoqbZtInG/Ab0Ee+sOFIlbxNfGwt60Nf6SU9nfcKAAT+Us8
         3MJHgt4WWn6gMBKC4s6MZo7S93A3LZhDIqHXpU1WQK+VRcDDD0+ymSgKRd6dAv/eJBC3
         tJrkJT2+i0EaT/kfkwkghRaYyRfUxFu0PyOKSNWJvm6flLB2qFhvAE2BZos4mCemz/OZ
         kLyX2WCxv3b5doZfwWUasozCQYyjomIuG5NsPS6X4uN3k71y8BPUjLqTJZfiDo3UFuvy
         9GZQ==
X-Gm-Message-State: ACgBeo3FakWTJtf6L5lbEdK6WmsE0jup2Wx5Mc1KlcKfpD3mvnXlNSDa
        4YJAIw6TUVEcM5clzjrD7TM=
X-Google-Smtp-Source: AA6agR5HOniH6QubUCzWWuVS2GbFDW4C9k2NjOPl/2aVuBUDGMQ52iRi4iQzVbNOxSQDC7X/McEz+w==
X-Received: by 2002:a17:902:ce01:b0:172:59a6:fb3d with SMTP id k1-20020a170902ce0100b0017259a6fb3dmr685968plg.119.1662504161852;
        Tue, 06 Sep 2022 15:42:41 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:4e4a:abd5:5969:d00e? ([2620:15c:211:201:4e4a:abd5:5969:d00e])
        by smtp.gmail.com with ESMTPSA id q14-20020a170902a3ce00b0017684444f57sm8328130plb.224.2022.09.06.15.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 15:42:41 -0700 (PDT)
Message-ID: <481c1c85-3af8-da6f-b532-598a004b102d@acm.org>
Date:   Tue, 6 Sep 2022 15:42:39 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH 1/2] testing/selftests: Add tests for the is_signed_type()
 macro
Content-Language: en-US
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Kees Cook <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org
References: <20220826162116.1050972-1-bvanassche@acm.org>
 <20220826162116.1050972-2-bvanassche@acm.org>
 <d2399574-ec64-7765-b6ef-1e792a7e0d5c@rasmusvillemoes.dk>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <d2399574-ec64-7765-b6ef-1e792a7e0d5c@rasmusvillemoes.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/22 02:41, Rasmus Villemoes wrote:
> On 26/08/2022 18.21, Bart Van Assche wrote:
>> Although not documented, is_signed_type() must support the 'bool' and
>> pointer types next to scalar and enumeration types. Add a selftest that
>> verifies that this macro handles all supported types correctly.
>>
> 
>> +static void is_signed_type_test(struct kunit *test)
>> +{
>> +	KUNIT_EXPECT_EQ(test, is_signed_type(bool), false);
>> +	KUNIT_EXPECT_EQ(test, is_signed_type(signed char), true);
>> +	KUNIT_EXPECT_EQ(test, is_signed_type(unsigned char), false);
> 
> Nice. You could consider adding
> 
> #ifdef __UNSIGNED_CHAR__
> KUNIT_EXPECT_EQ(test, is_signed_type(char), false);
> #else
> KUNIT_EXPECT_EQ(test, is_signed_type(char), true);
> #endif
> 
> The kernel depends on the compiler providing __UNSIGNED_CHAR__ in two
> places (one in ext4, one in printf test suite).

(reduced Cc-list)

Hi Rasmus,

Since I would like to implement the above suggestion I tried to look up 
other uses of the __UNSIGNED_CHAR__ macro. However, I couldn't find any. 
Did I perhaps do something wrong?
  $ git grep -w __UNSIGNED_CHAR__ origin/master | wc
       0       0       0

Thanks,

Bart.
