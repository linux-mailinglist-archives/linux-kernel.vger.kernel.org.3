Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8BB3652DF7C
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 23:42:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245363AbiESVmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 17:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244755AbiESVmH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 17:42:07 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6B70107893
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:41:58 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id w19-20020a9d6393000000b0060aeb359ca8so1008305otk.6
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:41:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:message-id:date:mime-version:user-agent:content-language:to
         :cc:references:from:subject:in-reply-to:content-transfer-encoding;
        bh=CpuiHu6st5jvRyMaG9VX7RMBtuAsBPj44JQMGd55xSk=;
        b=X1FGonc0itVjTaJy5AqOZm4ZPWMp6o//luJ4v+XTffdBLPZrA1yullEKYrYVTwSLo3
         1TK+BNFnpUwv1gFLulhTKSZfr/5MIgaqTHBHya7aH4f64OqcYFI9UARAqZnkjjAq2fjQ
         XHJ1bWtRjdwOJL/jPAredUfs5ZGMzP0parqGKOQJ1hukOGUrww/Jx+ttLyJ7ce9u8aDV
         gwG8WgOBlcQuOMOgIBiQKSuvyFhxiGHMTOJkGZWALAncZrzLeLH0C5L8tVpuzJdavhmX
         PK7jQz3jbvgevAa4kyujYNTX7ZfCHzIBSL0rkiBVfBBxacwcVnT6zercCqaKtAiWlKCl
         iJgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:subject:in-reply-to
         :content-transfer-encoding;
        bh=CpuiHu6st5jvRyMaG9VX7RMBtuAsBPj44JQMGd55xSk=;
        b=vQgWGYbCjm4OEMLQcnS3BPeLf1B62r633KfzWn33oVrLzW09/PigmjP+V0Mc0cK2D+
         12lq8GQyBQyNYU4XCwEK8dIF92rs3XKeIhDBAvIxhiNX7JnIM+4/F27IPTBppTVKXl+y
         +GBhnTSU2oREQQOrbrwxR81jYN373Xsou/xbmQ/rY9owHE5js3Wly0SUsVkyeBBW9Rjc
         xzuS0iM9vKLadmxJ8x75DmNyQEV7ExwWLvgI+thb0W2JSiLWhAz3kThM2UJZ4k8lA2Yz
         O7g25nU/kmjYpEvdzmRvNZkeza6c2FEeYBIufXlC9bRD6g9mbA1X/IJPgOJlkg7t8BCR
         QKBQ==
X-Gm-Message-State: AOAM5311JyR86XsjX6gVVBkrKOpkJZDr6/h+DE506XZNoycYnoeAggb8
        e08LsXnwV52HDsxiGZeZ8/8=
X-Google-Smtp-Source: ABdhPJwBml8d2YJQucekuCRaj6PIzvGEkJuWAcNUSWUvgdv8zUnJWbUcTHb2lE59ASNYwXO9JZWlAg==
X-Received: by 2002:a05:6830:310c:b0:606:66c8:53d4 with SMTP id b12-20020a056830310c00b0060666c853d4mr2686287ots.129.1652996518130;
        Thu, 19 May 2022 14:41:58 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t187-20020aca5fc4000000b00325cda1ffb4sm188141oib.51.2022.05.19.14.41.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 May 2022 14:41:57 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <28f3958f-dd25-cb1a-0a4c-040e7706ffc7@roeck-us.net>
Date:   Thu, 19 May 2022 14:41:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     Heiko Carstens <hca@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20220428172040.GA3623323@roeck-us.net> <YmvVkKXJWBoGqWFx@osiris>
 <yt9dk0apbicu.fsf@linux.ibm.com> <20220513165955.mkg5wvfi4dwpzoer@revolver>
 <YoOMsmq24FWsWWyr@osiris> <b18d5338-0031-a813-2825-207bea1b84cb@roeck-us.net>
 <20220519143541.dfzgoubmkboc6kk4@revolver>
From:   Guenter Roeck <linux@roeck-us.net>
Subject: Re: [PATCH] mapletree-vs-khugepaged
In-Reply-To: <20220519143541.dfzgoubmkboc6kk4@revolver>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/19/22 07:35, Liam Howlett wrote:
> * Guenter Roeck <linux@roeck-us.net> [220517 10:32]:
> 
> ...
>>
>> Another bisect result, boot failures with nommu targets (arm:mps2-an385,
>> m68k:mcf5208evb). Bisect log is the same for both.
> ...
>> # first bad commit: [bd773a78705fb58eeadd80e5b31739df4c83c559] nommu: remove uses of VMA linked list
> 
> I cannot reproduce this on my side, even with that specific commit.  Can
> you point me to the failure log, config file, etc?  Do you still see
> this with the fixes I've sent recently?
> 

This was in linux-next; most recently with next-20220517.
I don't know if that was up-to-date with your patches.
The problem seems to be memory allocation failures.
A sample log is at
https://kerneltests.org/builders/qemu-m68k-next/builds/1065/steps/qemubuildcommand/logs/stdio
The log history at
https://kerneltests.org/builders/qemu-m68k-next?numbuilds=30
will give you a variety of logs.

The configuration is derived from m5208evb_defconfig, with initrd
and command line embedded in the image. You can see the detailed
configuration updates at
https://github.com/groeck/linux-build-test/blob/master/rootfs/m68k/run-qemu-m68k.sh

Qemu command line is

qemu-system-m68k -M mcf5208evb -kernel vmlinux \
     -cpu m5208 -no-reboot -nographic -monitor none
     -append "rdinit=/sbin/init console=ttyS0,115200"

with initrd from
https://github.com/groeck/linux-build-test/blob/master/rootfs/m68k/rootfs-5208.cpio.gz

I use qemu v6.2, but any recent qemu version should work.

Hope this helps,
Guenter
