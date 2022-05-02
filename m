Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC0CC516AE7
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 08:34:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383483AbiEBGhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 02:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351045AbiEBGhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 02:37:37 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2089327B15
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 23:34:10 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id z19so15498569edx.9
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 23:34:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZkYcyb2ACFjey9zLn1zohQQeCKLJQivrZnOFkcxwXlM=;
        b=c9o10kuSwfeywvkoJ+vqV7vjhEN32IuV5UU0hbtcWv5FcN2FU7/VcOt0Iy5kB25otc
         QhOctcvm0gL/RYg6wXe8o46cHbT8X4o9W82lwv4DAWx/Ld/L9nz+R+edPXmVEFV6ZqwL
         Wf4gtaJ/OF0l+YZqOjltNM856ZIjCr6I4wbJ9mVdE1UwUgvxie4djX5PZNw45/228+dn
         qaGx7OOyWOgZB59RNK/eMz8XHbHm15HY/YkBE0U3sO8sH1b4DcPRIptfg0TsoZt5jCzG
         GAzvljVxg7xlSAHDKU9im/eW9IL/Jxi7xao5itGNVyBhoImYrkVjgq+NxUfLgxUWrwEN
         ULKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZkYcyb2ACFjey9zLn1zohQQeCKLJQivrZnOFkcxwXlM=;
        b=H4+98k9uFhJUtWWYKutYxRuCW9c88kP6uGzEYutcmodet/dW0UgTmWRvF4XFfVLLI2
         ZfJju/yLAeh1A+BLK9sCh2B9jZ43fhlNV1pWjBYEW/Si4JKCwRdFVLTQFbfacG4+YH5A
         nyBrpgOrzWxm6ZbL0kij8qpahQg9OJtI+fNQNWqylUbjznuwCAbwsnTPPOJgklN4QoSu
         OyCuLHRASMnL+XV78vgAMVfIjiRY08TfPx4Cx+alTNeC7D+ouW6dUwpFKA3UzIlbGmWk
         j849apUVAUHlRZ2porFpX19o2ZZCNIKkv7bGdWhPX9mZRmjUmkrA7kpcxsKReAXM0r1J
         sbFg==
X-Gm-Message-State: AOAM530qfvBEBQXl5TkBqgrzGLLsg+uVDSp7ovW++nyQQLQSTGMjkesh
        YmPF0mGVPZ3wwHhJ0Gxisw+tQA==
X-Google-Smtp-Source: ABdhPJyQbJUpQeNg5zS7ztqhducINcseZFJGq/6U6ieX2j+aJvFl1F8Ihm5yQ4BREY46Jq7VakM3Cg==
X-Received: by 2002:a05:6402:298b:b0:41d:675f:8b44 with SMTP id eq11-20020a056402298b00b0041d675f8b44mr11874109edb.377.1651473248366;
        Sun, 01 May 2022 23:34:08 -0700 (PDT)
Received: from [192.168.0.187] (xdsl-188-155-176-92.adslplus.ch. [188.155.176.92])
        by smtp.gmail.com with ESMTPSA id e19-20020a056402105300b0042617ba6384sm6260342edu.14.2022.05.01.23.34.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 01 May 2022 23:34:07 -0700 (PDT)
Message-ID: <405e3948-7fb2-01de-4c01-29775a21218c@linaro.org>
Date:   Mon, 2 May 2022 08:34:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH net v5 2/2] nfc: nfcmrvl: main: reorder destructive
 operations in nfcmrvl_nci_unregister_dev to avoid bugs
Content-Language: en-US
To:     duoming@zju.edu.cn
Cc:     linux-kernel@vger.kernel.org, kuba@kernel.org,
        gregkh@linuxfoundation.org, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, alexander.deucher@amd.com,
        akpm@linux-foundation.org, broonie@kernel.org,
        netdev@vger.kernel.org, linma@zju.edu.cn
References: <cover.1651194245.git.duoming@zju.edu.cn>
 <bb2769acc79f42d25d61ed8988c8d240c8585f33.1651194245.git.duoming@zju.edu.cn>
 <8656d527-94ab-228f-66f1-06e5d533e16a@linaro.org>
 <73fe1723.69fe.1807498ab4d.Coremail.duoming@zju.edu.cn>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <73fe1723.69fe.1807498ab4d.Coremail.duoming@zju.edu.cn>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/04/2022 11:13, duoming@zju.edu.cn wrote:
> Hello,
> 
> On Fri, 29 Apr 2022 09:27:48 +0200 Krzysztof wrote:
> 
>>> There are destructive operations such as nfcmrvl_fw_dnld_abort and
>>> gpio_free in nfcmrvl_nci_unregister_dev. The resources such as firmware,
>>> gpio and so on could be destructed while the upper layer functions such as
>>> nfcmrvl_fw_dnld_start and nfcmrvl_nci_recv_frame is executing, which leads
>>> to double-free, use-after-free and null-ptr-deref bugs.
>>>
>>> There are three situations that could lead to double-free bugs.
>>>
>>> The first situation is shown below:
>>>
>>>    (Thread 1)                 |      (Thread 2)
>>> nfcmrvl_fw_dnld_start         |
>>>  ...                          |  nfcmrvl_nci_unregister_dev
>>>  release_firmware()           |   nfcmrvl_fw_dnld_abort
>>>   kfree(fw) //(1)             |    fw_dnld_over
>>>                               |     release_firmware
>>>   ...                         |      kfree(fw) //(2)
>>>                               |     ...
>>>
>>> The second situation is shown below:
>>>
>>>    (Thread 1)                 |      (Thread 2)
>>> nfcmrvl_fw_dnld_start         |
>>>  ...                          |
>>>  mod_timer                    |
>>>  (wait a time)                |
>>>  fw_dnld_timeout              |  nfcmrvl_nci_unregister_dev
>>>    fw_dnld_over               |   nfcmrvl_fw_dnld_abort
>>>     release_firmware          |    fw_dnld_over
>>>      kfree(fw) //(1)          |     release_firmware
>>>      ...                      |      kfree(fw) //(2)
>>
>> How exactly the case here is being prevented?
>>
>> If nfcmrvl_nci_unregister_dev() happens slightly earlier, before
>> fw_dnld_timeout() on the left side (T1), the T1 will still hit it, won't it?
> 
> I think it could be prevented. We use nci_unregister_device() to synchronize, if the
> firmware download routine is running, the cleanup routine will wait it to finish. 
> The flag "fw_download_in_progress" will be set to false, if the the firmware download
> routine is finished. 

fw_download_in_progress is not synchronized in
nfcmrvl_nci_unregister_dev(), so even if fw_dnld_timeout() set it to
true, the nfcmrvl_nci_unregister_dev() happening concurrently will not
see updated fw_download_in_progress.

> 
> Although the timer handler fw_dnld_timeout() could be running, nfcmrvl_nci_unregister_dev()
> will check the flag "fw_download_in_progress" which is already set to false and nfcmrvl_fw_dnld_abort()
> in nfcmrvl_nci_unregister_dev() will not execute.

I am sorry, but you cannot move code around hoping it will by itself
solve synchronization issues.

Best regards,
Krzysztof
