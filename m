Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD81E4C6CA0
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Feb 2022 13:34:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232437AbiB1MfL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Feb 2022 07:35:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229997AbiB1MfK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Feb 2022 07:35:10 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A856541FB9
        for <linux-kernel@vger.kernel.org>; Mon, 28 Feb 2022 04:34:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=KLObTzpFJ3JFXNqoLhXcI5yVpeoc073bLS8HdX2ztiQ=; b=Bb887ZalSzkmjPq0ejXoGiY+wT
        xy9UGV04gqVgMOOo+iBKyvUv6Y6DzOvTPAZcboJfypVUvyrhSx9smPZk3cRIZKa7kfAMp+oYVBB5w
        g+BtBVoRv9NRMkYy7li/ZVeFrxxzIj7VoQ/4vwasgDfvZ5D/7dGoy/jra9RIhrtQlGsYQuQn94/c4
        SH+/Uxa/eS1RlP9Tzwai8/enmwtupJu50x73rwc0a1ULNNVLAt0TycWgwxgHbn4uIgVNRbZfcdJEL
        d4FVQsbe8KRAPkusWI6AhbaZBbwZ1fWPKrGAuVPPq7Yqc9iY0vygeO7VZl+UgLuU2VVtiSM8AEER6
        5pdlO/Ug==;
Received: from [189.79.213.38] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nOfEE-000C20-HQ; Mon, 28 Feb 2022 13:34:14 +0100
Message-ID: <561910c7-ad9a-7f0f-ea98-125989146fdd@igalia.com>
Date:   Mon, 28 Feb 2022 09:33:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V6] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Petr Mladek <pmladek@suse.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, bhe@redhat.com, anton@enomsg.org,
        ccross@android.com, dyoung@redhat.com, feng.tang@intel.com,
        john.ogness@linutronix.de, keescook@chromium.org,
        kernel@gpiccoli.net, kexec@lists.infradead.org,
        rostedt@goodmis.org, tony.luck@intel.com, vgoyal@redhat.com
References: <20220214141308.841525-1-gpiccoli@igalia.com>
 <YhRFNKtxSE8Xrbfw@google.com>
 <7e15bc6a-ceae-aa3a-0a86-18d24181b0ed@igalia.com>
 <YhWNhzacAVDuFtwB@google.com> <YheXRmmWr619Qxin@alley>
 <YhhmnmgAlVCcVqSV@google.com> <YhjIsPpA0kN1yeOM@alley>
 <YhmPCE4zn5Nup+ou@google.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YhmPCE4zn5Nup+ou@google.com>
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

On 25/02/2022 23:23, Sergey Senozhatsky wrote:
> On (22/02/25 13:16), Petr Mladek wrote:
>>
>> The result looks good to me. We could do it as a followup patch.
> 
> Yup, sounds good to me. Thanks.

Cool, I also agree.

So Andrew: is there anything missing in order to get this patch merged?
If you prefer, I can send a new version...with the reviews' tags.
Lemme know =D

Thanks,


Guilherme
