Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27F384D18A3
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 14:04:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347039AbiCHNFk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 08:05:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346893AbiCHNFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 08:05:38 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5815547AEE;
        Tue,  8 Mar 2022 05:04:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=y2IyLNhcIcqW/P9xsp3kK8t+WoLf+fyXhFG9KATTpEU=; b=FNkRgec82ncuQvKLVwyz4kOmJ8
        4U/FYkpMDZxDHCgItgQ85ivg4FhuKpnd2kbdnwnQdNeKvLRvSqtGxzL7z8RfSKEbwjzsZHVwYQRsf
        nTysstqkRhPaf+M6YkMyP4nGFDYW2kTVmNq18WFEw9JPc0RJ+0iBh2+1ki+n6aKER/b+KuUb50EY1
        5LgC1OB5Z7FZeLvzA/1PeZ1j5aJkK1bGU9l/qgqvc7XamjscU//dNYyd2mDiI8r33J/HHSyu9JSS4
        UwR9LAo6DabWmyo/j0gUA6LaJDzAcQ87lgkFJAsG9cdqIMqihCpRBDLtxyh7W+M8E13Yxi/ervoQU
        8lJv6jPw==;
Received: from [187.56.66.217] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nRZVp-000CZ4-Dc; Tue, 08 Mar 2022 14:04:25 +0100
Message-ID: <23044cc6-ae58-d464-d5d1-3b5e6d4202c8@igalia.com>
Date:   Tue, 8 Mar 2022 10:04:06 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Petr Mladek <pmladek@suse.com>
Cc:     "bhe@redhat.com" <bhe@redhat.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>
References: <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
 <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
 <YiYQ/w6Hn5Zb67di@MiWiFi-R3L-srv>
 <788ab36d-ef65-4cc8-4edf-a46d2687d97e@igalia.com> <YidSI33Uk8wHDuO9@alley>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YidSI33Uk8wHDuO9@alley>
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

On 08/03/2022 09:54, Petr Mladek wrote:
> [...]
> Honestly, I am not that keen about enforcing the priorities.
> 
> It would make sense only when the ordering is really important.
> Then there should be some rules. It should be obvious why
> something has to be done earlier than something else.
> 
> From my POV, it is just another complexity. Someone will need to
> assign the priority to the existing notifiers. People will wonder
> about it for newly added notifiers.
> 
> Reproducibility seems to be the only motivation. Is it really a
> problem? Do the notifiers affect each other?
> 
> Also the notifiers are typically registered by some early boot
> code. It will define some ordering out of box.
> 
> Best Regards,
> Petr

OK Petr, makes sense. I feel that one the pros of the approach would be
to document all the notifiers in the header, but I guess nothing
prevents me to do that heh
I don't need enforcing the priorities for this.

I liked the idea of having everything "reproducible" as you said, but we
could face the problem of how to order some independent notifiers...
would be something "ad-hoc".

I'll progress here without priorities for now, if somebody see an
advantage for that, we can use it.

Thanks for your points,


Guilherme
