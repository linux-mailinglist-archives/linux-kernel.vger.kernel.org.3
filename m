Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF0564E18
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 09:00:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGDHAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Jul 2022 03:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229693AbiGDHAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Jul 2022 03:00:02 -0400
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C892DC2;
        Mon,  4 Jul 2022 00:00:00 -0700 (PDT)
Received: by mail-ed1-f47.google.com with SMTP id r18so10440154edb.9;
        Mon, 04 Jul 2022 00:00:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=lxRbqE6zzxcYx3TuCHfmErH49kGAwmDatQ2HtHuBCXg=;
        b=e4xJd5kZnkZgUN+9rRlRfeKSR9SVtpqm9VjeRkuR2QHaea84Sm9N1knGYAUH7jtUhH
         SuuPPTyBSjxsh5YCnjjyAiz7CKLW+/DbPjSXnVeTuDFNfIDrOSTB6tPU0mxjcVjDq5vk
         TQ4X30bAt10be3imfUvQC2lKQxweIug5hsogcGx1AiiGBigWSbaJgzg5WmcjgNn7u4SQ
         rrAXbzsYPBNipWwZLlYyxgZT2/4vX9fMUE5ykGJNzqi7vaMY/S+EV03/cLxxxeu4Wega
         X58C6t62/m5GP4Jjf7CaVokr0KVl0vWeITtsbRxIlmc87AuAqCqCMRHxkLWEGl3E//7w
         CO8Q==
X-Gm-Message-State: AJIora/3lWC564pD05QBjEdUYjZ0wHhxDrF2VHjw8JaFc5XDYmdCbtvk
        42QxasHwniqq7lqDH8hi5xo=
X-Google-Smtp-Source: AGRyM1thb4nktMfrZE4YLDE20iEVdzXDKH8iaQhzNKvbyFIc6Qop8VDqqoV553XMdKfEgXRtDGrJNQ==
X-Received: by 2002:a05:6402:350f:b0:437:6618:174a with SMTP id b15-20020a056402350f00b004376618174amr36954962edd.329.1656917998787;
        Sun, 03 Jul 2022 23:59:58 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::49? ([2a0b:e7c0:0:107::49])
        by smtp.gmail.com with ESMTPSA id k13-20020a170906a38d00b006fed787478asm13952551ejz.92.2022.07.03.23.59.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 03 Jul 2022 23:59:58 -0700 (PDT)
Message-ID: <dcd42721-0df1-c42a-dd65-3785d7f233cd@kernel.org>
Date:   Mon, 4 Jul 2022 08:59:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH v2 6/6] serial: Consolidate BOTH_EMPTY use
Content-Language: en-US
To:     Andy Shevchenko <andy.shevchenko@gmail.com>
Cc:     =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        Greg KH <gregkh@linuxfoundation.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        William Hubbs <w.d.hubbs@gmail.com>,
        Chris Brannon <chris@the-brannons.com>,
        Kirk Reiser <kirk@reisers.ca>,
        Samuel Thibault <samuel.thibault@ens-lyon.org>,
        "David S. Miller" <davem@davemloft.net>,
        "linux-mips@vger.kernel.org" <linux-mips@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "speakup@linux-speakup.org" <speakup@linux-speakup.org>,
        "sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>
References: <20220621124958.3342-1-ilpo.jarvinen@linux.intel.com>
 <20220621124958.3342-7-ilpo.jarvinen@linux.intel.com>
 <03467516-3962-4ff2-23d2-2b3a1d647c5a@kernel.org>
 <CAHp75VeKhY6dN7j_yXQXUMhOqRwqQ2yN_qF95U9wU6K4uKPdaQ@mail.gmail.com>
 <c7115ff1-2a97-f5a0-a0c2-c7c1064af291@kernel.org>
 <CAHp75Vfsy5yY3saSCvCu87E-arifwEZXUNtFMrMn38gJY2LU0g@mail.gmail.com>
 <CAHp75VdSadbtkH1JeiPuJ_CSBDq82GaRWLvJFd8Egg7poY8Lxw@mail.gmail.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAHp75VdSadbtkH1JeiPuJ_CSBDq82GaRWLvJFd8Egg7poY8Lxw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 06. 22, 12:17, Andy Shevchenko wrote:
> On Thu, Jun 23, 2022 at 12:15 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
>> On Thu, Jun 23, 2022 at 10:24 AM Jiri Slaby <jirislaby@kernel.org> wrote:
>>> On 23. 06. 22, 10:11, Andy Shevchenko wrote:
>>>>      * prom_putchar_wait() should be implemented using
>>>>         read_poll_timeout_atomic(), incl. failure/timeout handling.
>>>>
>>>> Not sure since it is an early stage and scheduler might not work as
>>>> expected. Conversions to iopoll.h macros bitten us a few times already.
>>>
>>> Except _atomic does not use scheduler :).
>>
>> Sorry for a bit misleading comment, but I chased it down, so this what
>> I had in mind when commenting:
>> be24c6a71ecf ("soc: qcom: rpmh-rsc: Don't use ktime for timeout in
>> write_tcs_reg_sync()")
> 
> ...and this one (specifically for early stages)
> 
> c4d936efa46d ("Revert "usb: early: convert to readl_poll_timeout_atomic()"")

OK, makes sense.

thanks for pointers,
-- 
js
