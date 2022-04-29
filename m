Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED8D0514FD7
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 17:46:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349906AbiD2Pt6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 11:49:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347090AbiD2Ptz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 11:49:55 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C14EB33346
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 08:46:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=Alxq0FvrpCIqa3YFE1kEclM8OeYiKJgbg8XXuogi09g=; b=rw6cIbHYd3KsIAq9YCTkSNndcS
        ybhhwAsf35RbHLHKRJPX0OeojGPUtFmSqWYTtCCIxwBoMWYVoesnmSj+EqHbxbWonPr4MZVqOf3r7
        QBKRrQLVfv63wdpl4jcV0gTLP6S0FsafOD9UhVyPBIMdWBlA3m2XhSkEjZ3oajlYbbvNp0mZTHxmb
        ZSJs/05Qsok+yBzvon4saR2VpgNIkKrZmAJbNrS6MjkulqIjTsTGzUCElcZXLc33COVGD5vHdPcHE
        CyPQ3tgXkULQ3Ld6AtwgqrCdr1p/B9G1VPqZOLCju6PzmOGs5ngeO1EU5xm9SEBStSH3RyXLRV975
        voN5guKw==;
Received: from [179.113.53.197] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nkSp5-00005h-HR; Fri, 29 Apr 2022 17:46:23 +0200
Message-ID: <f71e33e5-dc7b-375e-e086-11ab9aca1311@igalia.com>
Date:   Fri, 29 Apr 2022 12:46:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH 11/30] um: Improve panic notifiers consistency and
 ordering
Content-Language: en-US
To:     Johannes Berg <johannes@sipsolutions.net>
Cc:     linux-kernel@vger.kernel.org,
        "linux-um@lists.infradead.orgAnton Ivanov" 
        <anton.ivanov@cambridgegreys.com>,
        Richard Weinberger <richard@nod.at>
References: <20220427224924.592546-1-gpiccoli@igalia.com>
 <20220427224924.592546-12-gpiccoli@igalia.com>
 <98a1bff1a4cc798f0a02fd10a5f3b291c68ad1d7.camel@sipsolutions.net>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <98a1bff1a4cc798f0a02fd10a5f3b291c68ad1d7.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/04/2022 05:30, Johannes Berg wrote:
> [trimming massive CC list]
> 
> On Wed, 2022-04-27 at 19:49 -0300, Guilherme G. Piccoli wrote:
>>
>> Also, we remove a useless header inclusion.
> 
> I wouldn't say it's useless, generally we try not to rely on implicit
> includes so much? And you at least now use NOTIFY_DONE from it.
> 
> Otherwise looks fine to me.
> 
> johannes

Hi Johannes, thanks for your prompt response, and for clearing a bit the
*huge* CC list, it got really humongous...

I agree with you here - I missed that there's also a reboot notifier in
"mconsole_kern.c", so seems it makes sense to keep the header. I'll fix
that for V2, ok? If it was only a panic notifier I would consider it
useless maybe, but we have non-panic notifier as well heh

Cheers,


Guilherme
