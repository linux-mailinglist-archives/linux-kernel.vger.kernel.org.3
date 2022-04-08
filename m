Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6F804F97BE
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 16:12:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236734AbiDHONQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 10:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236720AbiDHONM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 10:13:12 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B10B34CA0F
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 07:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649427067;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zqy0/ETekPLWIA7UmgVZ0eT5yPuRDnDxC9XVs/Ymk8c=;
        b=SFJXRJbZKwWdFsgifIPtH4UgtlWg6AIxbwaoU89f1YCPlpSsrKJHedT/ZbHGnbL/glUYnH
        vwZQPWFWLC9ZjHmF7TC0Z/K1bmiUipmppvoGoE+3wdaF/sBjVGll+SyBTo2olaXaUuH98Q
        WkpNdX+HszANLNr9bcMTqmIryjDlXRE=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-512-vt_K6kNqNHWqTap-Q5iJBA-1; Fri, 08 Apr 2022 10:11:06 -0400
X-MC-Unique: vt_K6kNqNHWqTap-Q5iJBA-1
Received: by mail-ej1-f70.google.com with SMTP id sc14-20020a1709078a0e00b006e773507c0cso4972310ejc.10
        for <linux-kernel@vger.kernel.org>; Fri, 08 Apr 2022 07:11:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=zqy0/ETekPLWIA7UmgVZ0eT5yPuRDnDxC9XVs/Ymk8c=;
        b=NavtFAiKp+IAdM6/9e5EnSnFtIWmvaB0NUTcUyxTFwdRUWGtYrWKnB475/67IvpLh3
         FDUP21UUbXEqwFMsqJ0PH4AfNXXZMKqrevYUzLwN5dAJh5jhxhhuj9j/BmXK5+t4FPt0
         lEvmgTmp3ahgss4xHraZ6/whpS8Q8NTd+5v4MjRDXxJMMWJAVEHSuXLpQ2Xa0ywIAxvg
         /PW7MJsfT5O5W7kH48Hr/2iZGQpT9eWp4TVa99oDlMB5AF4vcje8WOkf2lI2BfuRyJlC
         LsB6x2uOgwt9g4Yg9NtTEBf2veiR19Oze0T5vuR2FmuGqgpOyF0O2ZSkIWQ+J/wtgulz
         jFRg==
X-Gm-Message-State: AOAM531Y0kG4Qxm4Nv0dhrfcBERrEj7KGfAmM3RLZj6MvP6sk3Xgvsiv
        VdgidGqaPKtD30KYw/akUx1Et4UoXNrUZbSDl1W5fRacBQMn4eQvlqXxPik4jcfyjbhmwEHbdJC
        S6MjUXFV8WSPqG3CTXuf1KAli
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id i23-20020a05640200d700b004130673ba2fmr19804696edu.29.1649427064777;
        Fri, 08 Apr 2022 07:11:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxz2QYbOAS6gQvm5hSttLC55Jx/uzKl8NPt10gwYa8XKd5lkS0jIF6mruPngPWmHh2Ot4kDoA==
X-Received: by 2002:a05:6402:d7:b0:413:673:ba2f with SMTP id i23-20020a05640200d700b004130673ba2fmr19804684edu.29.1649427064609;
        Fri, 08 Apr 2022 07:11:04 -0700 (PDT)
Received: from [10.0.0.45] (host-95-245-33-130.retail.telecomitalia.it. [95.245.33.130])
        by smtp.gmail.com with ESMTPSA id gg7-20020a170906e28700b006e73ac96f99sm6694825ejb.224.2022.04.08.07.11.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 08 Apr 2022 07:11:04 -0700 (PDT)
Message-ID: <36540bb7-ada0-451b-f935-a3a1f9c83d41@redhat.com>
Date:   Fri, 8 Apr 2022 16:11:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] rtla: Minor fix to grammar in README.txt
Content-Language: en-US
To:     John Kacur <jkacur@redhat.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        RT <linux-rt-users@vger.kernel.org>,
        linux-trace-devel@vger.kernel.org,
        Steven Rostedt <rostedt@goodmis.org>
References: <20220402043939.6962-1-jkacur@redhat.com>
 <20220402043939.6962-2-jkacur@redhat.com>
 <24f79a7c-0146-ad0a-988a-608edd402faa@redhat.com>
 <6b8d24c-d793-866c-30a7-f015c7babd2d@redhat.com>
From:   Daniel Bristot de Oliveira <bristot@redhat.com>
In-Reply-To: <6b8d24c-d793-866c-30a7-f015c7babd2d@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>> -The rtla is a meta-tool that includes a set of commands that
>>> +The rtla tool is a meta-tool that includes a set of commands that
>> I do not like bike-shedding but 'the rtla tool is a meta-tool" sounds repetitive.
>>
>> Does:
>>
>> The rtla meta-tool includes a set of commands...
>>
>> sound good for you?
>>
>> -- Daniel
>>
>>
> Perfect
> 

Would you mind re-sending this patch?

You will also need to adjust the paragraph alignment as the first line is
shorter now ...
-- Daniel

