Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A1B84E2F99
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 19:05:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351969AbiCUSGa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 14:06:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241367AbiCUSG3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 14:06:29 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1FDE5DE4C
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 11:05:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=+zScwtX/0ywSew6B96Ie7Los4HXBqMBl4omHP7aKR20=; b=Yxg3Sck22bJIBXWdYeu1MSghNA
        eu5QpotV/MH5f/7hKrBXUJpIGTxiLClWOW9VbqKPXP2L9QcGgdHCiF6KX3Q9Ltl/IlLBix6kVj2Do
        ddaveWLy3aBJpacLKlA7vRbjH8rt2YsMNO0bpSwmiRHhJeIz/T3BcR5887S324WZ5E7Hzg1ASiSFc
        3w3yhIBZ1bSMWlxCWeLrlFPU88AUSlPeu0NS9SWuQtZhcO4OvHffO/KMkRCPSvTZ59lZ5OVe1wnWv
        QjYBCKikz8IffhdI0vnPzYD7R2rkcwDpVPTLQ8cUS+O2pfKQ/82Y9A1GbP21FRDC/B+C2bI6m6Qlp
        kFJyhmBw==;
Received: from [187.39.124.208] (helo=[192.168.0.110])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nWMOn-0008Ht-Mr; Mon, 21 Mar 2022 19:04:58 +0100
Message-ID: <307799df-fddd-6c46-7dd5-323ea5628892@igalia.com>
Date:   Mon, 21 Mar 2022 15:04:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Question about the Broadcom Always On register panic handling
Content-Language: en-US
To:     Florian Fainelli <f.fainelli@gmail.com>,
        computersforpeace@gmail.com
Cc:     "Guilherme G. Piccoli" <kernel@gpiccoli.net>, opendmb@gmail.com,
        justinpopo6@gmail.com, mmayer@broadcom.com,
        bcm-kernel-feedback-list@broadcom.com, kexec@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <6dac422b-d509-b863-0b31-98a07808ac0d@igalia.com>
 <781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <781cafb0-8d06-8b56-907a-5175c2da196a@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/03/2022 13:32, Florian Fainelli wrote:
> [...]
> The AON (standing for always-on) is a small domain in the SoC that can 
> retain its state across various system wide sleep states and specific 
> reset conditions. The AON DATA RAM is a small ram of a few words (< 1KB) 
> which can store persistent information across such events.
> 
> The purpose of this write was initially to help with indicating to the 
> boot loader that a panic occurred and so that it should try its best to 
> preserve the DRAM contents holding that buffer for recovery by the Linux 
> kernel as opposed to wiping out DRAM clean again. I cannot go into the 
> mechanics of what happens publicly unfortunately.
> 

Thanks a lot Florian! This is very good information, it's enough for me
- I'd like to be sure it's not rebooting the board or something
"extreme" like that, so in the end...it's kinda the opposite, it's
preserving the DRAM.


>>
>> Any information that helps me to document such panic event is very
>> welcome, and in case you have AON documentation, it'd be also pretty great!
> 
> Why are you asking specifically about this if I may ask? If you are a 
> legitimate Broadcom STB customer you can reach out to our support and I 
> am sure the question will come back for me to answer.

Oh I'm not a Broadcom STB customer, I'm just working in the panic
notifiers and was curious about this one. When I submit my series (soon)
it's likely that there  will be a small refactor of this notifier plus a
comment, with your great explanation.

Regarding the full AON documentation, I just asked in case it's public
and I couldn't find - it's unfortunate that a lot of code in the kernel
is based on closed specifications, but I understand we can't do much
about that. Your response was very useful, and enough for my work =)

Cheers,


Guilherme
