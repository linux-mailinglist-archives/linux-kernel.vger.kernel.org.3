Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EE6552CEE1
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 11:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235746AbiESJCc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 05:02:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235764AbiESJC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 05:02:29 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E759A76D1;
        Thu, 19 May 2022 02:02:28 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id gi33so136916ejc.3;
        Thu, 19 May 2022 02:02:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=THpG01QnqTAAfo+jNCu5AXbH2/rIQPzXpYrqduPsMlM=;
        b=3gsP/dyyZEb7uDifMBdKLdRIW6Qs8vJTf0I83tlA7stcVfAl88T2J+J4bsWJl8QA2+
         1mW8daEmgDXIUIlp+tVwXczuX930lrzhjzqgHpDNYf1UUIR1KvsIzW73Le/YjjHPpraI
         C5qlin541UHwcR4X0KTqabGar1G+DuMZlFi/+4N6daYFYJHbI9ADq/HlJ4mPgJ9Rejzw
         yPoS/rX4H5x+RJuWaij0Rk5sGaWfOm5o/0QYZzZ05kt1gHuHIYk0Hn6HgeL9PUHsbkxC
         udXds6cGnZCPsTxwJoEmV2MkJru7yYQx83sKzoz3pnpES8IvCmBomURZ5yjljf9MPSBj
         0OsQ==
X-Gm-Message-State: AOAM533ExILvnLKCJuJT0VnomZ/H+WxHYfYB5Tp6kSh35IAsBEGzVshE
        OTcM8at0UrTxZqCncpYMpLg=
X-Google-Smtp-Source: ABdhPJw+lC9whLnqbBMumURJrOM0ojoOt9qoF7cCu5Ekou9qvC+nxuif8HEOuNQfIb5DfbuW8KODfg==
X-Received: by 2002:a17:907:6d96:b0:6fe:6da7:6bc6 with SMTP id sb22-20020a1709076d9600b006fe6da76bc6mr3195793ejc.57.1652950946941;
        Thu, 19 May 2022 02:02:26 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id q18-20020aa7cc12000000b0042aa40e76cbsm2529102edt.80.2022.05.19.02.02.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 02:02:24 -0700 (PDT)
Message-ID: <b61169e6-259c-f47e-b91f-c6cf3a5e5f39@kernel.org>
Date:   Thu, 19 May 2022 11:02:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 1/4] serial: pmac_zilog: remove unfinished DBDMA support
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>
References: <20220519075653.31356-1-jslaby@suse.cz>
 <2f7a739f-61b4-a1af-7c9b-70c5b93c6281@linux.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <2f7a739f-61b4-a1af-7c9b-70c5b93c6281@linux.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19. 05. 22, 10:56, Ilpo Järvinen wrote:
> On Thu, 19 May 2022, Jiri Slaby wrote:
> 
>> The support for DBDMA was never completed. Remove the the code that only
>> maps spaces without real work.
>>
>> Cc: Michael Ellerman <mpe@ellerman.id.au>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Cc: Paul Mackerras <paulus@samba.org>
>> Signed-off-by: Jiri Slaby <jslaby@suse.cz>
>> ---
>>   drivers/tty/serial/pmac_zilog.c | 38 +--------------------------------
>>   drivers/tty/serial/pmac_zilog.h |  9 --------
>>   2 files changed, 1 insertion(+), 46 deletions(-)
>>
>> diff --git a/drivers/tty/serial/pmac_zilog.c b/drivers/tty/serial/pmac_zilog.c
>> index c903085acb8d..2953ff64a892 100644
>> --- a/drivers/tty/serial/pmac_zilog.c
>> +++ b/drivers/tty/serial/pmac_zilog.c
> 
> How about dropping this too:
> #include <asm/dbdma.h>

Good point, fixed, will send v2 eventually.

thanks,
-- 
js
suse labs
