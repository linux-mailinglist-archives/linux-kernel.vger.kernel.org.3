Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1BDC557554
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 10:24:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiFWIYQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 04:24:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230006AbiFWIYN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 04:24:13 -0400
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8797848892;
        Thu, 23 Jun 2022 01:24:09 -0700 (PDT)
Received: by mail-ej1-f50.google.com with SMTP id mf9so19097553ejb.0;
        Thu, 23 Jun 2022 01:24:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=je97Zmu9ZIV2AyqWdPVDsLNA9EKzzISpQbnMs7O+hLA=;
        b=KYVmQwnrxiCoug29I0G4VehxA1+Kbu6oavqgW1HojBzwn89MJs4Z92X98QLd2T8g81
         DBFFCdxEtN3nwF2P3al2pY+9ArspK4fU8R49zmv6mL1xIeewLa3sEnP3nkkcP21cqof8
         3Iv9aT8G7dvMA6md9eK9WWhuzOKpiTb/xm01LbYsDgN+xqnsfU2vaXWheco6xPAKuKT5
         oR931R2L4uwYHhIgupCI9BCIHs4/Dmnd2IvYPq3kirtJWESdr8U1NuQwNHLTyS7sHy70
         FeSred4+Jbq6jCAEXoC2P3FUI4Uz+TDXWkdZ2Z3opjgmMTG5qkSNpCvSOmjW9GHk/Rxn
         wP9A==
X-Gm-Message-State: AJIora9AEGXy3aKi6VmhPIY74N8S9qhZmozsNt1hsPdKFDcLNJ0Optj8
        08vh9WHib2S6bbt9Pwpg4nCrRyTLQ64OF+wW
X-Google-Smtp-Source: AGRyM1tQkctV7PGvSEx3E4tG2gVc0zSZvBOMmNeC/R1LG1xUn4SfCS59LrKaZal29UVgYo74xLGspA==
X-Received: by 2002:a17:907:9689:b0:71e:56c1:838b with SMTP id hd9-20020a170907968900b0071e56c1838bmr7081732ejc.304.1655972648153;
        Thu, 23 Jun 2022 01:24:08 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id e15-20020a056402190f00b0043580ac5888sm9205712edz.82.2022.06.23.01.24.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Jun 2022 01:24:07 -0700 (PDT)
Message-ID: <c7115ff1-2a97-f5a0-a0c2-c7c1064af291@kernel.org>
Date:   Thu, 23 Jun 2022 10:24:06 +0200
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
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <CAHp75VeKhY6dN7j_yXQXUMhOqRwqQ2yN_qF95U9wU6K4uKPdaQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 23. 06. 22, 10:11, Andy Shevchenko wrote:
>     * prom_putchar_wait() should be implemented using
>        read_poll_timeout_atomic(), incl. failure/timeout handling.
> 
> 
> Not sure since it is an early stage and scheduler might not work as 
> expected. Conversions to iopoll.h macros bitten us a few times already.

Except _atomic does not use scheduler :).

-- 
-- 
js
suse labs
