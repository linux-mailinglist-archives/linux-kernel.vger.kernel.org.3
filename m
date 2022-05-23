Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D530531E41
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 23:56:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbiEWV4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 17:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230489AbiEWV4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 17:56:08 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3330D5FEA;
        Mon, 23 May 2022 14:56:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=l55w7vFL87VUFoT4THPFWPLSv0S+CeTc0rHopwPFTiU=; b=dj1oVTMOGNAspE6ON1Wo31A+97
        X7itrFGIFJj2i8VJFQYyXAf+r0oEiZuPDDzLCt//bbyRURSbgy4AlMNPawOBKwyoV46Ssr/SXKsx9
        NaWwWRnwbx+1/Oiz9ysLVV+ZkSdP6aYA/m0qSZOyho9Cxddj4GPb5Y/1ZDM4FCimpVg8QGCYeddFY
        EIZbtrTpEJyPyPWs0fCZhvvxkkb4clGpQELMjKq6CezFzvqL2/uSS+xmlJHtFhMePgsJOjzykFit7
        B0EhE2Qmu23d8YFX34ORhtIBEwHAO96t9Hm0W0qnVsFKa4B8xZWCLYLBEtXsh0rPvVkjW3H72md/Z
        NOrukhWg==;
Received: from 200-161-159-120.dsl.telesp.net.br ([200.161.159.120] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ntG1y-00Gn8d-Al; Mon, 23 May 2022 23:56:02 +0200
Message-ID: <56a8553d-92fe-875b-ad2a-f0354a496599@igalia.com>
Date:   Mon, 23 May 2022 18:55:43 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
Subject: Re: [PATCH 12/30] parisc: Replace regular spinlock with spin_trylock
 on panic path
Content-Language: en-US
To:     Helge Deller <deller@gmx.de>
Cc:     linux-kernel@vger.kernel.org, linux-parisc@vger.kernel.org
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-13-gpiccoli@igalia.com>
 <6a7c924a-54a9-c5ea-8a9d-3ea92987b436@gmx.de>
 <0dda86c0-3a54-8c70-d1e7-18bbb4d41bab@igalia.com>
 <43de5653-7587-3e8e-274c-b2729649d0fd@gmx.de>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <43de5653-7587-3e8e-274c-b2729649d0fd@gmx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/05/2022 18:31, Helge Deller wrote:
> Hello Guilherme,
> 
> On 5/23/22 22:40, Guilherme G. Piccoli wrote:
>> On 28/04/2022 13:55, Helge Deller wrote:
>>> [...]
>>> You may add:
>>> Acked-by: Helge Deller <deller@gmx.de> # parisc
>>
>> Hi Helge, do you think would be possible to still pick this one for
>> v5.19 or do you prefer to hold for the next release?
> 
> Actually, I'd prefer if you push this patch together with the whole
> series upstream at once. The patch itself makes not much sense without
> your series...
> 
>> I'm working on V2, so if it's merged for 5.19 I won't send it again.
> 
> Helge

Sure Helge, I guess I can do that - will resubmit for V2.

But notice the patch is self-contained, as it fixes a current issue in
the code - the risk for a lockup due to spinlock taking on atomic
context. It doesn't require the panic refactor to be merged in order to
achieve its goal...

I agree that such issue is rare to trigger though, so definitely no
hurry is needed =)

Cheers,


Guilherme
