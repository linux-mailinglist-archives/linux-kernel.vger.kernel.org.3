Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33FA3586AD7
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234628AbiHAMcj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 08:32:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiHAMcY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 08:32:24 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CEA77392A
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 05:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5gyy20rCHxHhW8ugW8OEOWxPmnQJGbQ0xlIOrNar5yo=; b=J0NfEgoK+bkuRJvxHFO11cnOpU
        pELLmFWZzS3XGSSBJPC0oKoKTYSRqbiMOvfkoDnGcSaR9WxJl/VZ6H13T3vLenW6B5aCpTXLdaOd/
        n+RsOnVBYDt9oVKDJT4Xoc3MeusmMRlh0VQtTq0uUnEYFtNRh27vTd6HcY+uyirgVtepWVG/w7qJo
        T9SEt8ZBLViv1jSc7/cd4fPWCCyZNXKRIdO+fozyu0a0/ivp66HrnA6BEtQSG6nv9/NTUtbTGy2sv
        hdqJ5pYMHno8Vgrx5AQ7PWz2VjqkQdG9O8qlA4dUaRPypDHORaDozKP18xh5btC3/O1YrkU2WKCUi
        977TIYJg==;
Received: from [187.56.70.103] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1oIUHE-00Dk8T-BB; Mon, 01 Aug 2022 14:12:05 +0200
Message-ID: <2d4fa03a-f460-d995-88e8-7f0e58e557bd@igalia.com>
Date:   Mon, 1 Aug 2022 09:11:46 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH -next] panic: Add register_panic_notifier and
 unregister_panic_notifier
Content-Language: en-US
To:     Xu Qiang <xuqiang36@huawei.com>, pmladek@suse.com,
        akpm@linux-foundation.org, elver@google.com, mcgrof@kernel.org,
        tangmeng@uniontech.com, yangtiezhu@loongson.cn,
        john.ogness@linutronix.de, bigeasy@linutronix.de
Cc:     linux-kernel@vger.kernel.org, guohanjun@huawei.com,
        weiyongjun1@huawei.com
References: <20220801100509.62282-1-xuqiang36@huawei.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220801100509.62282-1-xuqiang36@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/08/2022 07:05, Xu Qiang wrote:
> Add two methods to manipulate panic_notifier_list and export them.
> Subsequently, panic_notifier_list is changed to static variable.
> 
> Signed-off-by: Xu Qiang <xuqiang36@huawei.com>

Hi Xu Qiang, first of all, thanks for your patch!
I'd like to mention 2 things about it:

(a) As-is, there's no much use for it - I mean, you're adding a helper
but you didn't change the uses of such notifier list addition (and there
are plenty of them). Are you intend to change it, or just use the new
API in new calls?

(b) Even more important: we are working in a panic notifier refactor
[0], and that'll add new lists. I'm still working on that, plan to
submit (relatively) soon. Maybe worth to wait it, if this one is not urgent?

Cheers,


Guilherme


[0]
https://lore.kernel.org/lkml/20220427224924.592546-1-gpiccoli@igalia.com/
