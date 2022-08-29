Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F9175A5613
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 23:25:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229601AbiH2VZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 17:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2VZf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 17:25:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95C14D53
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661808332;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GOfa2F9yg58fvogSsfGf7y2ObvFs8svdVEcJd6u8aig=;
        b=MA0WavVihvEhq2OebVA5sYTG3duTAKH7zyKNPpkeN8bunZylxaB/ORw8AEMYWm0SrJHQfZ
        sq8l5vQ6am5eQfBd4Zr35ztOdC7Cq6QU7EFGJ2tOxhbZpJp9+HpkKL6DUWFe8+Ie9skUKI
        TDESZxt1nM2XGGFAuRIduxoo5PQrT40=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-629-qVHzyaGgMn2SiZkZXXzCwg-1; Mon, 29 Aug 2022 17:25:31 -0400
X-MC-Unique: qVHzyaGgMn2SiZkZXXzCwg-1
Received: by mail-ed1-f72.google.com with SMTP id p4-20020a056402500400b00447e8b6f62bso6204274eda.17
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 14:25:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=GOfa2F9yg58fvogSsfGf7y2ObvFs8svdVEcJd6u8aig=;
        b=HC2J4l/Imoa3GWKOzPMQhW+qKvv4nKTR12jDxppp2cSpdQM4cL/ehiuWTf8VN0FPAC
         uxGCil1K+reWlF5GJVAu+kF9A/EuLZF9e/yn/b807tqofhhKdyUG4zXiy/wbTgBHHx/X
         IRI3MJQwkxVmhoPoAqbn2ZwgNJ9UBeJ0hPctv91HaL0l6+mmnU0K90iolrOCL6egy/Io
         72nnhY5CVNqp4LLe1JTDKRfKg26s5faXnvJ10IKFArUlQqRpowmH8eteXAFRvWmfFZLr
         UAZZ0FLnrQWtHbsIEbPMmrudwIDE7CyotCoDt28eVsfj17N/iC09G32cTHddtsBQLer8
         rtnw==
X-Gm-Message-State: ACgBeo2MsiF2HzPBuPpPb5iDu+fi0f35Hye0jEChct53sFegtiN6wBul
        eng6MOdLOnP/iLwTGGf5ytkDQNw2Dn6fCPcG7YixnreUF1OeHaMyqunQsVhRP9uej9C1Q1VJVIt
        t19VwTac3i/pvXRA7Lu3EcgoJ
X-Received: by 2002:a05:6402:350b:b0:43e:f4be:c447 with SMTP id b11-20020a056402350b00b0043ef4bec447mr18411881edd.427.1661808330249;
        Mon, 29 Aug 2022 14:25:30 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6/AKDPB35J+LJWWZ+VunHsJB5YDtOyhGJAoKGP8rLV4t1cWd4YHGBGegZv1ae80XyWs6HLoA==
X-Received: by 2002:a05:6402:350b:b0:43e:f4be:c447 with SMTP id b11-20020a056402350b00b0043ef4bec447mr18411867edd.427.1661808330032;
        Mon, 29 Aug 2022 14:25:30 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id cy19-20020a0564021c9300b00445d760fc69sm3308656edb.50.2022.08.29.14.25.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 14:25:29 -0700 (PDT)
Message-ID: <a48011b9-a551-3547-34b6-98b10e7ff2eb@redhat.com>
Date:   Mon, 29 Aug 2022 23:25:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: 6.0 tty regression, NULL pointer deref in flush_to_ldisc
Content-Language: en-US
To:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>
References: <4b4bba5d-d291-d9fa-8382-cdc197b7ed35@redhat.com>
 <e8d67c78-751e-2c44-edff-e7e441c3302d@linux.intel.com>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <e8d67c78-751e-2c44-edff-e7e441c3302d@linux.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/29/22 11:36, Ilpo Järvinen wrote:
> On Mon, 29 Aug 2022, Hans de Goede wrote:
> 
>> Hi All,
>>
>> This weekend I noticed that on various Bay Trail based systems which have
>> their bluetooth HCI connected over an uart (using hci_uart driver /
>> using the drivers/tty/serial bus) there is a NULL pointer deref in
>> flush_to_ldisc, see below for the full backtrace.
>>
>> I *suspect* that this is caused by commit 6bb6fa6908eb
>> ("tty: Implement lookahead to process XON/XOFF timely").
>>
>> I can cleanly revert this by reverting the following commits:
>>
>> ab24a01b2765 ("tty: Add closing marker into comment in tty_ldisc.h")
>> 65534736d9a5 ("tty: Use flow-control char function on closing path")
>> 6bb6fa6908eb ("tty: Implement lookahead to process XON/XOFF timely")
>>
>> ATM I don't have one of the affected systems handy. I will give
>> a 6.0-rc3 kernel with these 3 commits reverted a try tonight (CEST)
>> and I'll let you know the results.
>>
>> Note I can NOT confirm yet that these reverts fix things, so please
>> don't revert anything yet. I just wanted to give people a headsup
>> about this issue.
>>
>> Also maybe we can fix the new lookahead code instead of reverting.
>> I would be happy to add a patch adding some debugging prints the
>> systems run fine after the backtrace as long as I don't suspend them
>> so gathering logs is easy.
> 
> I guess this will help:
> 
> https://lore.kernel.org/linux-kernel/20220818115026.2237893-1-vincent.whitchurch@axis.com/

I can confirm that that patch fixes things, thanks.

Regards,

Hans

