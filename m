Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E696516FA9
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 14:39:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244749AbiEBMnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 08:43:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233954AbiEBMnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 08:43:18 -0400
Received: from mail.marcansoft.com (marcansoft.com [IPv6:2a01:298:fe:f::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3102213D13;
        Mon,  2 May 2022 05:39:49 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: marcan@marcan.st)
        by mail.marcansoft.com (Postfix) with ESMTPSA id F3B7F41982;
        Mon,  2 May 2022 12:39:44 +0000 (UTC)
Message-ID: <c5413c42-b728-b88b-4229-9d4e3943413e@marcan.st>
Date:   Mon, 2 May 2022 21:39:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Content-Language: es-ES
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-serial@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20220502092505.30934-1-marcan@marcan.st>
 <Ym/EAGq3IzW5rYwr@kroah.com>
From:   Hector Martin <marcan@marcan.st>
Subject: Re: [PATCH] tty: serial: samsung_tty: Fix suspend/resume on S5L
In-Reply-To: <Ym/EAGq3IzW5rYwr@kroah.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2022 20.44, Greg Kroah-Hartman wrote:
> On Mon, May 02, 2022 at 06:25:05PM +0900, Hector Martin wrote:
>> We were restoring the IRQ masks then clearing them again, because
>> ucon_mask wasn't set properly. Adding that makes suspend/resume
>> work as intended.
>>
>> Signed-off-by: Hector Martin <marcan@marcan.st>
>> ---
>>  drivers/tty/serial/samsung_tty.c | 1 +
>>  include/linux/serial_s3c.h       | 3 +++
>>  2 files changed, 4 insertions(+)
> 
> Does this fix a specific older commit?
> 
> And should it be backported to older stable kernels?

It does fix the commit that introduced this device support in general; I
can add a Fixes line for that. I don't think anyone cares about
backporting though, since there are other fairly critical devices that
don't have support outright and there's still work to do before
suspend/resume is generally usable on these machines.

-- 
Hector Martin (marcan@marcan.st)
Public Key: https://mrcn.st/pub
