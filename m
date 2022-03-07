Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F0704D0124
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 15:26:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243159AbiCGO0w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 09:26:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233094AbiCGO0t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 09:26:49 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08B0C79392;
        Mon,  7 Mar 2022 06:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6c2lABTBXkqH3piZDcmcp4tKU51yf7bKQlChnZc1puI=; b=HyVEq1Id5fcjuyIM4h//ARGHuz
        ff2H2jPEeb0oQHzHhlFvu7XWNBpRXYZRtbj06y8FdPl9OCE9axsnOleYh8LkdrPDRxy+OMcSfalZD
        vNdFQ0Ak9lQCR0auV5QO+i3LuVMg/8qV4/9xDeHyQOuB9xCsH59kOhyuxHqGCrUw4NwpWXjgW33ni
        onr2xAefdxEi+WUlg8mbppSWplYnrr0hSjK/SITKuWDXpvDE6v9omrkvPs9kRYKUbNU2J6kGhXcqY
        7ZZ2dJXpV6rL9tlm7tUUw4dR8KYUYlGg3+v8pUX4+hZ4nYKjEQTpOtFZVe97+PZTN/oBuMSgrpdHb
        UsOXtVtA==;
Received: from [187.56.66.217] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nREJ0-000BxM-KQ; Mon, 07 Mar 2022 15:25:46 +0100
Message-ID: <788ab36d-ef65-4cc8-4edf-a46d2687d97e@igalia.com>
Date:   Mon, 7 Mar 2022 11:25:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     "bhe@redhat.com" <bhe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
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
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <73011b6f-084b-43f5-cc01-1818a8a57e56@igalia.com>
 <YiV/HbXftVF2iAvU@MiWiFi-R3L-srv>
 <e1033adc-46ff-5dbc-e739-1bf725b6fed0@igalia.com>
 <YiYQ/w6Hn5Zb67di@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YiYQ/w6Hn5Zb67di@MiWiFi-R3L-srv>
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

On 07/03/2022 11:04, bhe@redhat.com wrote:
> [...]
> Ah, sorry, I even didn't notice that. That's awesome if we can make use
> of that. While I still have concerns:
> 

Thanks, nice that you liked the idea.

> 1) about those we have decided to take out from panic notifier list and
> put before kdump, e.g the Hypver-V notifier, how will we do with it? Are
> we going to handle them as we have discussed?
> 

While implementing that I will think of something, but if
understood/remember correctly Hyper-V gonna be one of the first to run
in the first notifier list proposed by Petr - so we might still use
ordering by priority there, having Hyper-V being the first heh

> 2) Combing and settling priority for all existing panic notifier looks
> great, even though it will take some effort. How about the later newly
> added one? How can we guarantee that those new notifiers are getting
> appropriate priority to mark their order? Sometime we even don't know
> a new panic notifier is added since code change may be made in any
> component or driver.
> 

This is a great point! How to do it? One idea is to have a special
registering function for panic notifiers that checks for priority field
missing, and good documentation is a good idea as well, always.

But if you / others have other suggestions, let me know - appreciate that.
Cheers,


Guilherme
