Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48ADB5336DE
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 08:44:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244211AbiEYGoo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 02:44:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234014AbiEYGom (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 02:44:42 -0400
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C526F496;
        Tue, 24 May 2022 23:44:41 -0700 (PDT)
Received: by mail-wm1-f43.google.com with SMTP id f23-20020a7bcc17000000b003972dda143eso511795wmh.3;
        Tue, 24 May 2022 23:44:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=SZuJ09hQlt2AMKYsAuJM6SKJdNtOf4FccUCFIw8KEc4=;
        b=H0MKJOEOgQwtp7awEZwQFJUsLX3tZ6MDBw+GcWpet28zHay80LankTngGca+qfvNt4
         GoNRM2O38lw8sn4jRiiLL6mW0z3ji7bVwY615CBb8Bzwm5nByW5cCCkpKt2NfvPQ6Ej0
         IZRLOyNvi+Py4dWannt4qdeBo7jtLNoIc8Pc/501ckbPh8nVMhcxOzUO8XEJ4qMkPTvC
         Sdm/p4My+6xm2dI/PDAHFDIhL6hDBqvx2mJK4QZ9VF+7BpGdQNnS3ATPNDafqirETw9B
         +j8kjHHF1NUf+2sL2VGRu4TFTpGejfQzYVsNF65QSKmtSNRAVh+bTKgio0wgss7UJqrL
         tu3w==
X-Gm-Message-State: AOAM533umnNLOKKxRFkI7RRlvHOswtGCgUgk0M/i9hjEgkTCb9I0XZm4
        rHabcgEQUh2XF6XnOA7edifY6gZn7eA09Q==
X-Google-Smtp-Source: ABdhPJw7AkOlRhS9rLgDR25jCOUKo2Yjs0sHVXyDJN2vYIJLq4NM0wwL7nMW1hByhmX9Ci/o6JB8hg==
X-Received: by 2002:a05:600c:4147:b0:397:3c98:b6d with SMTP id h7-20020a05600c414700b003973c980b6dmr6693185wmm.111.1653461079936;
        Tue, 24 May 2022 23:44:39 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c15-20020a05600c0a4f00b003942a244f3asm941839wmq.19.2022.05.24.23.44.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 May 2022 23:44:39 -0700 (PDT)
Message-ID: <5c691c83-480b-8731-7e6a-7f28536c9a59@kernel.org>
Date:   Wed, 25 May 2022 08:44:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: lirc build broken [was: [GIT PULL for v5.18-rc1] media updates]
Content-Language: en-US
From:   Jiri Slaby <jirislaby@kernel.org>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Sean Young <sean@mess.org>
References: <20220322101406.459e2950@coco.lan>
 <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
In-Reply-To: <a0470450-ecfd-2918-e04a-7b57c1fd7694@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25. 05. 22, 8:42, Jiri Slaby wrote:
> On 22. 03. 22, 10:14, Mauro Carvalho Chehab wrote:
>> Hi Linus,
>>
>> Please pull from:
>>    git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media 
>> tags/media/v5.18-1
> ...
>> Sean Young (10):
> ...
>>        media: lirc: remove unused lirc features
> 
> Hi,
> 
> this breaks lirc build:
>> [   59s] lircd.cpp:489:49: error: 'LIRC_CAN_SET_REC_FILTER' was not 
>> declared in this scope; did you mean 'LIRC_CAN_SET_REC_CARRIER'?
>> [   59s]   489 |                     || (curr_driver->features & 
>> LIRC_CAN_SET_REC_FILTER)) {
>> [   59s]       |                                                 
>> ^~~~~~~~~~~~~~~~~~~~~~~
>> [   59s]       |                                                 
>> LIRC_CAN_SET_REC_CARRIER
>> [   59s] lircd.cpp: In function 'void loop()':
>> [   59s] lircd.cpp:2069:82: error: 'LIRC_CAN_NOTIFY_DECODE' was not 
>> declared in this scope; did you mean 'DRVCTL_NOTIFY_DECODE'?
>> [   59s]  2069 |                         if (curr_driver->drvctl_func 
>> && (curr_driver->features & LIRC_CAN_NOTIFY_DECODE))
>> [   59s]       
>> |                                                                                  
>> ^~~~~~~~~~~~~~~~~~~~~~
>> [   59s]       
>> |                                                                                  
>> DRVCTL_NOTIFY_DECODE
> 
> So the uapi header defines should be brought back, IMO.

(And lirc fixed at the same time.)

> thanks,-- 
js
