Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 106464B6A50
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 12:08:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiBOLIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 06:08:40 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbiBOLIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 06:08:39 -0500
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85AEE107D07;
        Tue, 15 Feb 2022 03:08:29 -0800 (PST)
Received: by mail-ej1-f50.google.com with SMTP id jg20so18482378ejc.3;
        Tue, 15 Feb 2022 03:08:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=9sbWkD2U+y8Lkxl8cJufoOZ+3ZJ3ycFIwhx8nuwGqqg=;
        b=QJ/GtD4b945oNmNC2ECiJnFSTPVGKWj/0p5eIy2kYCzcO19hD7olWpywMoljcThpC2
         o+br1nVAGfDHBmX1SoinPG2KuKZlaIOcgvJdPGp6ClyheNMVC4l1gkzHwWtkh1fRO6gQ
         9McQ56fZsyDxl6PHAhFYyNsmdlLgUF7IdzHxfUq++aFqRd05r3A6CS6b+nixdM7Rj60v
         jt0ZQP+GhHZM78pxEi/DmJ1rx+ojur1brzqnUP0V0EcNc0s8WDnWWpedpu4A1FMgXPKi
         Wluqev63vkmVXnoWduVbPbVnArYX/ytlk+45Gr0xWSwTYtqTmsrUgFVuJTFlTLm5L9R2
         CXpA==
X-Gm-Message-State: AOAM5309brMPvOeNiRpNycmhuwrZf9TSvoFLLlSKwn8XelLSNMlvv7CX
        53S+/fj/uq/5DKBCHqKckAbRWUczy8c=
X-Google-Smtp-Source: ABdhPJxlka2khF6Q0W4fGy3UoXtwupRBZYZCs1Q88uAdbmhixt2LsF3jbpSxB6K4UJENSmSiiCiWSg==
X-Received: by 2002:a17:906:99c2:: with SMTP id s2mr2481497ejn.317.1644923307918;
        Tue, 15 Feb 2022 03:08:27 -0800 (PST)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id z5sm11521283eja.20.2022.02.15.03.08.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Feb 2022 03:08:27 -0800 (PST)
Message-ID: <f8ffca37-6029-6103-e3cf-0c2c62d04485@kernel.org>
Date:   Tue, 15 Feb 2022 12:08:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.1
Subject: Re: [PATCH v1 1/1] serial: 8250_mid: Balance reference count for PCI
 DMA device
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-serial@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Qing Wang <wangqing@vivo.com>
References: <20220215100920.41984-1-andriy.shevchenko@linux.intel.com>
 <db576c63-73e2-b5f8-bc8b-057bdab2264d@kernel.org>
 <YguAncl92hV2vUkm@smile.fi.intel.com> <YguBEJ1cc0TMQLuE@smile.fi.intel.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <YguBEJ1cc0TMQLuE@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15. 02. 22, 11:31, Andy Shevchenko wrote:
> On Tue, Feb 15, 2022 at 12:29:49PM +0200, Andy Shevchenko wrote:
>> On Tue, Feb 15, 2022 at 11:11:41AM +0100, Jiri Slaby wrote:
>>> On 15. 02. 22, 11:09, Andy Shevchenko wrote:
>>>> The pci_get_slot() increases its reference count, the caller
>>>> must decrement the reference count by calling pci_dev_put().
>>
>>> And what about the -EINVAL case?
>>
>> What about it? The ->probe() calls ->exit() in its error path.
>> Or did I miss something?
> 
> Or you mean that we call pci_dev_put() on NULL pointer?
> This is completely valid case and handled in the callee.

No, I mixed up patches :P. This was meant as a comment to
"serial: 8250_lpss: Balance reference count for PCI DMA device"

byt_serial_exit() isn't called when byt_serial_setup() fails with EINVAL 
if I'm looking correctly.

thanks,
-- 
js
suse labs
