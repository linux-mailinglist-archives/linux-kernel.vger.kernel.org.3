Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2605E4C2EA2
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:46:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235619AbiBXOqq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:46:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232242AbiBXOqo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:46:44 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 648245A143
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:46:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RKi3ocJiTETOIJ5W2sRyo1ALvjXfAm2CZZ83RFejYIs=; b=MUltjm+t33sy7mS5YS4UfTgVdX
        bfPq1EiKBxC9+jskLmVQqkN7AawgasWGxLeAayrDzziEzpaKqRRG49/5AAwK7TKEAcq8Blz1uW5pN
        YIDipMgyvNdPXi/v6TYggUS18fSft6a1u03jFtmZHjMrOekr7sByYqJEy8rqCoY+zNBOliQ/uR8ce
        9Tui/Fn/d8mL5Sq7Fr5co6mYPd4JpW714ws/r7IzDCVAshP8rUEAlHdPWV93Omhq/oCxCLYVsk500
        smslN1vKjMTxIxKIbMC4ig4sV3ddrsJlV/1Wg6qPKnU0HSwiY2F1X0uKd7PINJNEckYK4gWRL/BiV
        9VxgmJ+A==;
Received: from [189.79.213.38] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nNFNb-0007qr-4h; Thu, 24 Feb 2022 15:46:03 +0100
Message-ID: <39f64d7d-714f-0be4-2854-10c00bcc9cda@igalia.com>
Date:   Thu, 24 Feb 2022 11:45:42 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, anton@enomsg.org,
        ccross@android.com, dyoung@redhat.com, feng.tang@intel.com,
        john.ogness@linutronix.de, keescook@chromium.org,
        kernel@gpiccoli.net, kexec@lists.infradead.org,
        rostedt@goodmis.org, tony.luck@intel.com, vgoyal@redhat.com
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com> <YheXRmmWr619Qxin@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YheXRmmWr619Qxin@alley>
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

On 24/02/2022 11:33, Petr Mladek wrote:
> [...]
> That said, I could live with the patch as is. I leave the decision
> to Andrew. Feel free to use:
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> 
> Best Regards,
> Petr

Thanks a bunch Petr and Sergey for the reviews (and the tags).

I also vote to keep the patch as-is and get it merged, maybe eventually
improving that along with the complex panic notifiers task [0]. I could
definitely do it over there...

Andrew, is this fine for you?
Thanks,


Guilherme

[0] https://lore.kernel.org/lkml/YfPxvzSzDLjO5ldp@alley/
