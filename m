Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8DE505E05
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 20:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347429AbiDRSp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 14:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229900AbiDRSp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 14:45:57 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 695082E0A9
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:43:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650307397;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7Mu6cyCpF/3BISjDmjITKcopLcMo5pZQG/PaAVYDLr4=;
        b=IKpvctZKg/o5TTkdQOkMZV+Fz7YdqPFIg845jaZUiD0G9Sarsb/eMELsLSbmkRuQZ7Ngdr
        lVcY8cd0SGat32GGckh09d7fomSvYIh9rpzbrO4/dv5m1KpGlcvZPvl9V7QVu+Qp+BxOk6
        6oUejj+Hs39LkEVSsBw8aRhVUxgvmJA=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-557-d4ODusgeMo6AFSJv_NKnZA-1; Mon, 18 Apr 2022 14:43:16 -0400
X-MC-Unique: d4ODusgeMo6AFSJv_NKnZA-1
Received: by mail-qk1-f200.google.com with SMTP id bl27-20020a05620a1a9b00b0069994eeb30cso10920020qkb.11
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 11:43:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7Mu6cyCpF/3BISjDmjITKcopLcMo5pZQG/PaAVYDLr4=;
        b=6DXYBdodlT10r6q9RUTpyN+nEoyzfMNVk/DkMciMj5UBisWoMFRtQvDCed7XeyDiQs
         1wMdu3rD63RmgH2I6f551hICkngGI2+rqCMjc86s2+GWbWq2899SqPovDWfruWWvREQQ
         4vZI6QXLpfnOckNMzOW8UM3m4cC+uIMFu0dA37rS2h9OKo8XAd/TR66vnojgQPAWllbC
         WeZ/NP3XHVmon+PT4RddRuv0MW60xJAMu3X3dshQNZV6DhT1X8++tKKQkYcoTDjDhSoj
         4Oj/xX3Q1jsb95TNUgAxPUrXoz0eNZESNijIi3sl65TtmKi/kihCO/FvD3KW/vZDmvm+
         qhfQ==
X-Gm-Message-State: AOAM53325Sq9LBpBqGSJmE6u71o10zdxj9lOW7ZJAEHqGx4jimNtd8CW
        qz3t/Td8dEdmVFoYXvX5vgLqw21tLIohGN12Is0wfzrxCDd9lB1hPlG8tUi4Ay/5HHnUvZOUotr
        DwZJqqZK7YSZbKhIq2cKoRpZZ
X-Received: by 2002:a05:620a:424b:b0:67d:36cc:5afb with SMTP id w11-20020a05620a424b00b0067d36cc5afbmr7582587qko.598.1650307395844;
        Mon, 18 Apr 2022 11:43:15 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyfGQkn6dnqMjz7y0axxCwL1U3OsrmH65jMUG4jPmIQ3Nu/EHeBdM6RJfE75Zn/PAHSQMDxfA==
X-Received: by 2002:a05:620a:424b:b0:67d:36cc:5afb with SMTP id w11-20020a05620a424b00b0067d36cc5afbmr7582583qko.598.1650307395643;
        Mon, 18 Apr 2022 11:43:15 -0700 (PDT)
Received: from [192.168.0.188] ([24.48.139.231])
        by smtp.gmail.com with ESMTPSA id c3-20020ac87d83000000b002e1d1b3df15sm8141117qtd.44.2022.04.18.11.43.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 18 Apr 2022 11:43:15 -0700 (PDT)
Message-ID: <06087446-c053-7099-b8f1-40a467781186@redhat.com>
Date:   Mon, 18 Apr 2022 14:43:14 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] lib/Kconfig.debug: change KUnit tests to default to
 KUNIT_ALL_TESTS
Content-Language: en-US
To:     Daniel Latypov <dlatypov@google.com>, brendanhiggins@google.com,
        davidgow@google.com
Cc:     linux-kernel@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kselftest@vger.kernel.org, skhan@linuxfoundation.org
References: <20220405190619.540177-1-dlatypov@google.com>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <20220405190619.540177-1-dlatypov@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/22 15:06, Daniel Latypov wrote:
> This is in line with Documentation/dev-tools/kunit/style.rst.
> Some of these tests predate that so they don't follow this convention.
> 
> With this and commit b0841b51cac9 ("kunit: arch/um/configs: Enable
> KUNIT_ALL_TESTS by default"), kunit.py will now run these tests by
> default. This hopefully makes it easier to run and maintain the tests.
> If any of these were to start failing, people would notice much quicker.
> 
> Note: this commit doesn't update LINEAR_RANGES_TEST since that would
> select its dependency (LINEAR_RANGES). We don't want KUNIT_ALL_TESTS
> to enable anything other than test kconfigs.
> 
> Signed-off-by: Daniel Latypov <dlatypov@google.com>
> ---
I have tried posting something similar in the past!
https://lore.kernel.org/lkml/f427ed5cbc08da83086c504fbb3ad1bab50340cd.1618388989.git.npache@redhat.com/

Reviewed-by: Nico Pache <npache@redhat.com>
Acked-by: Nico Pache <npache@redhat.com>

