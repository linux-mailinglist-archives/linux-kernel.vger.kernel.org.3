Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 104A2532CF6
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 17:09:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237532AbiEXPI4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 11:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiEXPIy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 11:08:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 96CC57890D
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:08:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653404931;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=F3oBMgO+hCxSnEMbdD2Kd4e6rlC5Fzw1CIMzw7rrxbA=;
        b=ZrtEJBNhZlbr1BWCh/HAEeSXlMkeoPLexIYSjz1QssDxOfuRcnSCmzlQHJu8O/q5s4xI52
        6hb6rK6tKE50cGPDYKsUxDlxnFuK+xrQi+TxzCUm5uGyNTvl8kBjENK1AyTOp0U6TcllH1
        Lq5oIemL01omupn6EDtoP1xRzAgyOMg=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-538-0HQsYM1EPt6C9R7ra_35Mw-1; Tue, 24 May 2022 11:08:49 -0400
X-MC-Unique: 0HQsYM1EPt6C9R7ra_35Mw-1
Received: by mail-wr1-f70.google.com with SMTP id s18-20020a5d6a92000000b0020ffa2781beso335691wru.20
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 08:08:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=F3oBMgO+hCxSnEMbdD2Kd4e6rlC5Fzw1CIMzw7rrxbA=;
        b=aFMv8PfXzP+3W/x48SZwPzQYt1g4BBPd3GRedZTrtIHrBK2nUE+QgdwAGw0wj4Lg1H
         ZdjLw6RM/7C2l2Lwdhc54C42VBUMAdKXK0CsgZHJjcMpH2zoEX/qjPwo46+BVjXmA3EM
         1zDBVwnvUCbRBHMaII8HR36NHmeAjBrBYRoIxqVkm46my6ie8Dq4sKpTMV3VSP3OBFF2
         jEst+yNuTFJjx196mwza0qfSmIo2koI4KdtmtDdzyKd9StatURqOitJ49ufeb0x0tdWx
         Lw7TkDS60hko0nkl7q4L71AXAkd1ULQq7GRo+qO5/jPl9WHMItUK7pIpyF5+qJHijtQj
         MLiA==
X-Gm-Message-State: AOAM531x+T/oo5vOEoaU8JLNrTdRiC/4t0nMhEEtKdl+b5ZHvauuUPWJ
        0DXE4jSSbUI58SgmVpEvKvADlSMJIuGLoiEwkSfkaNEJIhtgvR3M/XMiUAS2eq6cZfFNmMcbcMq
        jIG3Pw97ciMVmBYzxn9EqvhIM
X-Received: by 2002:a05:6000:1689:b0:20e:6de0:a578 with SMTP id y9-20020a056000168900b0020e6de0a578mr21835317wrd.85.1653404928504;
        Tue, 24 May 2022 08:08:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyemfL+4xKdX8ASaLUEDrPvWxSWigGFv+/SoWVTCc5P4TEem/qKmwuDwfuAEBHhJQFdhsx4xw==
X-Received: by 2002:a05:6000:1689:b0:20e:6de0:a578 with SMTP id y9-20020a056000168900b0020e6de0a578mr21835290wrd.85.1653404928155;
        Tue, 24 May 2022 08:08:48 -0700 (PDT)
Received: from [192.168.1.129] (205.pool92-176-231.dynamic.orange.es. [92.176.231.205])
        by smtp.gmail.com with ESMTPSA id p13-20020adfba8d000000b0020cdcb0efa2sm13400711wrg.34.2022.05.24.08.08.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 08:08:47 -0700 (PDT)
Message-ID: <e917386a-1901-3412-1e7b-537e1cd42b2e@redhat.com>
Date:   Tue, 24 May 2022 17:08:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH v2 3/3] selftests/filesystems: add a vfat RENAME_EXCHANGE
 test
Content-Language: en-US
To:     Muhammad Usama Anjum <usama.anjum@collabora.com>,
        linux-kernel@vger.kernel.org
Cc:     Chung-Chiang Cheng <cccheng@synology.com>,
        Lennart Poettering <lennart@poettering.net>,
        Colin Walters <walters@verbum.org>,
        Peter Jones <pjones@redhat.com>,
        Alexander Larsson <alexl@redhat.com>,
        Alberto Ruiz <aruiz@redhat.com>,
        Christian Kellner <ckellner@redhat.com>,
        OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
        Shuah Khan <shuah@kernel.org>, linux-kselftest@vger.kernel.org
References: <20220524073604.247790-1-javierm@redhat.com>
 <20220524073604.247790-4-javierm@redhat.com>
 <170151f7-9d46-6b01-e281-0f675a3b523f@collabora.com>
From:   Javier Martinez Canillas <javierm@redhat.com>
In-Reply-To: <170151f7-9d46-6b01-e281-0f675a3b523f@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Muhammad,

Thanks a lot for your feedback.

On 5/24/22 16:54, Muhammad Usama Anjum wrote:
> On 5/24/22 12:36 PM, Javier Martinez Canillas wrote:
>> diff --git a/tools/testing/selftests/filesystems/fat/Makefile b/tools/testing/selftests/filesystems/fat/Makefile
>> new file mode 100644
>> index 000000000000..93ee73c16828
>> --- /dev/null
>> +++ b/tools/testing/selftests/filesystems/fat/Makefile
>> @@ -0,0 +1,7 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +TEST_PROGS := run_fat_tests.sh
>> +TEST_GEN_PROGS_EXTENDED := rename_exchange
> Please create a .gitignore file and add rename_exchange to it.
>

Sorry, you mentioned that in the first revision but I missed.

Yes, I'll do it that on v3.
 
>> +CFLAGS += -O2 -g -Wall -I../../../../usr/include/
> Build may fail if kernel on which this test is being build has old
> headers. Always use $(KHDR_INCLUDES) instead of
> "-I../../../../usr/include/" to use the kernel headers from the kernel
> source instead of the natively installed headers.
> 

Sure, I'll do that as well.

-- 
Best regards,

Javier Martinez Canillas
Linux Engineering
Red Hat

