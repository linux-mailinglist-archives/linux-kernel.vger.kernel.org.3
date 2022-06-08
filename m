Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC0505427F3
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 09:47:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiFHHKO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 03:10:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350558AbiFHGOl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 02:14:41 -0400
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com [209.85.218.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6BDD27CCA;
        Tue,  7 Jun 2022 22:43:02 -0700 (PDT)
Received: by mail-ej1-f44.google.com with SMTP id y19so39232120ejq.6;
        Tue, 07 Jun 2022 22:43:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=gMGNu91Gx6YDbvR5JQvBJeAlO/wMEvI2zj5hAaR6Zrg=;
        b=ZNUSS5+7wEikzr+myYGXjYuTlgHSrFKN1bnKbcf+5MHOQMg4/M59fH2xvMZricjyaA
         uNqAp3ba+UHXXZpafe9UHfCppv5BNjKN5nQa8zJ499KpzrFjIVWx9xf0VfWwr7lbM4Yr
         MpoqETpB1Y9xYCt7QZ7bEK0n+ZMvCgZ7pqEAM9O1E+6CEBLZDU68JFV0mg1I+csb1fdE
         5H+/EEgZtPYOp4hlZOLk96ds8+n+cb+8TOJ+2Ik5WcnN6xfMuEYb/tW0zFLDxT2d2eNI
         QptD+j+DqsBECFHYQe4IxbMBgmZUN/e4LpIS4Ior8WPFO2tle/FCa8pz3WxBtalfLgWQ
         iVmg==
X-Gm-Message-State: AOAM533GzLMWNY3Ylap5D9lN1QnT9T0q2cdxsBqwXqufAz/9UROV0FUv
        eZf5BLTGo8AHJ7lRlFPAExM=
X-Google-Smtp-Source: ABdhPJzQ8LZuW+1+srFEBy1aDK0rkmppPaNCYjNmU6aY098PL8I7MIVOTd14Xe6jxua4s6p/TOdfcw==
X-Received: by 2002:a17:906:66d4:b0:70f:e86d:61b with SMTP id k20-20020a17090666d400b0070fe86d061bmr22844751ejp.401.1654666939610;
        Tue, 07 Jun 2022 22:42:19 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id p18-20020a17090628d200b006f3ef214dbesm8539768ejd.36.2022.06.07.22.42.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Jun 2022 22:42:19 -0700 (PDT)
Message-ID: <83fb92d0-7006-a488-1ba2-490ade9b2604@kernel.org>
Date:   Wed, 8 Jun 2022 07:42:17 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 02/36] tty/vt: consolemap: rename and document struct
 uni_pagedir
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <20220607104946.18710-1-jslaby@suse.cz>
 <20220607104946.18710-2-jslaby@suse.cz>
 <46cbc044-5157-65d8-65f0-2ecbee908150@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <46cbc044-5157-65d8-65f0-2ecbee908150@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07. 06. 22, 14:36, Ilpo Järvinen wrote:
> On Tue, 7 Jun 2022, Jiri Slaby wrote:
> 
>> struct uni_pagedir contains 32 unicode page directories, so the name of
>> the structure is a bit misleading. Rename the structure to uni_pagedict,
>> so it looks like this:
>> struct uni_pagedict
>>    -> 32 page dirs
>>       -> 32 rows
>>         -> 64 glyphs
>>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
> 
> The rename looks incomplete:
> 
>>   drivers/tty/vt/consolemap.c    | 47 ++++++++++++++++++++--------------
>>   drivers/video/console/vgacon.c |  4 +--
>>   include/linux/console_struct.h |  6 ++---
>>   3 files changed, 33 insertions(+), 24 deletions(-)
> 
> vs
> 
> $ git grep -l vc_uni_pagedir
> drivers/tty/vt/consolemap.c
> drivers/tty/vt/vt.c
> drivers/usb/misc/sisusbvga/sisusb_con.c
> drivers/video/console/vgacon.c
> drivers/video/fbdev/core/fbcon.c
> include/linux/console_struct.h

I renamed only the type, not the variables/members. Maybe the latter 
makes sense too. I will do that as a follow-up patch.

thanks,
-- 
js
suse labs
