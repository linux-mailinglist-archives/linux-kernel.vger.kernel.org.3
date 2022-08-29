Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 943545A46DD
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:12:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230054AbiH2KMG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:12:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229932AbiH2KLf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:11:35 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ED8B4E636
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661767891;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uiDEAc36fw1oVBz2RndBdLuRw9KgMIJyJTG6rMfsFiE=;
        b=PzU2TQVvFPvSO9HNXEL/ln2rwSzIV6jfN0MhjQiIiiEJDy8XwOzSk+b4VYW3kKWpM8u7nz
        gD07736G64Q+Fgwq9YT5e9YnzqFVfqdIHwXCcuUtEufadkx0lh6sOhfE9G4sAum+tf07/+
        q7TONg9U0qhPziMUhI4tz42BU8/dARQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-590-1TV9i-VUOP2pUPoIQKPDyA-1; Mon, 29 Aug 2022 06:11:30 -0400
X-MC-Unique: 1TV9i-VUOP2pUPoIQKPDyA-1
Received: by mail-ej1-f71.google.com with SMTP id hr32-20020a1709073fa000b00730a39f36ddso2067905ejc.5
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:11:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=uiDEAc36fw1oVBz2RndBdLuRw9KgMIJyJTG6rMfsFiE=;
        b=UpMu3W35BEmhtqs4zYuMHSu/QqkOHZV40O3ipg2cAhD1sm+U1A1jA3Yucoo+r8V4Oj
         l6C8DncBjdT/Qz02rfF0SFF/ZCG4sabMGbtCY8CXYxT/UK4mb0eWKufNWRqqMvTwD8gM
         U8IIQS+wY9CEWROqQLMqNCrubkDkao/yMp0jcpDEok4J3MclNhXcwalvZYL7BaBXE2JJ
         rKpzsMJBN/h+UZOJPj+7J50CaUKx5w9YVlck0O4EKCOCz45NnZwshdWlrRYeL9rbzI55
         HIeTl9hV7ya+XvthxznybchbziYM58HCeGlVuCQUA9O15F71/pmKvebVGcgXNVUgnpkJ
         jGcg==
X-Gm-Message-State: ACgBeo06tRcJ4a9OtiqWaWy+Nx1/UC0Bf89m9DaTOd5eYUN3pMyOkkqY
        MUrCQehkOz/UTmDlhhWil0ixSKAgYSSgK6KYVApGRJr5GZzZAgtDcVrf/SzqRz8o3Z/Z/3+lCXk
        V/FPYwxjlKuuycKEgJe2O8Ihh
X-Received: by 2002:a17:906:2245:b0:715:7c81:e39d with SMTP id 5-20020a170906224500b007157c81e39dmr13664981ejr.262.1661767888267;
        Mon, 29 Aug 2022 03:11:28 -0700 (PDT)
X-Google-Smtp-Source: AA6agR7M4/S/C3JxMIdV9wlV0VL4SAYsK3Ou30eFFHKFVgyE7NH7Ngn2CoK/Tp7ioWQhcY8xIdoyxw==
X-Received: by 2002:a17:906:2245:b0:715:7c81:e39d with SMTP id 5-20020a170906224500b007157c81e39dmr13664973ejr.262.1661767888059;
        Mon, 29 Aug 2022 03:11:28 -0700 (PDT)
Received: from [10.40.98.142] ([78.108.130.194])
        by smtp.gmail.com with ESMTPSA id ec14-20020a0564020d4e00b004483a543794sm3054189edb.96.2022.08.29.03.11.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 03:11:27 -0700 (PDT)
Message-ID: <ad157199-5127-ba77-e127-61b5de88fb60@redhat.com>
Date:   Mon, 29 Aug 2022 12:11:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
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

Ah, yes that indeed looks like it should help. I'll give that a try tonight
and report back the result.

Regards,

Hans

