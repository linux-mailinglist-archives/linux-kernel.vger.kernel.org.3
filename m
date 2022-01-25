Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D36A049B420
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 13:40:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232001AbiAYMjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 07:39:17 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:40434 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1383383AbiAYMet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 07:34:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=M+vFOpEIP37an1qVa4Tcx18DBd85JSmMXYYJr1B8Juo=; b=C7E5MvFAQyqvD+w935ILNjP9el
        jz6JeKwWmB7nslSM4eIWlO2IEQZqrAmI4qGTh3MAKAHOMIaF4CgSx8ZYokwBZuneOyYPrTNqya3vr
        cdFBj2v+WEL7hlQv61X3qSTQ9hAmBvbha8oqY+OPJcTVVF36GDZfrIaGpLShqImcW7WIWbU5fNsbV
        HgFKIimlz0G6sisUbTaoDfzjwFQbetdTH33Q0Cbhdg5odiX1B/aHptvzMBN1MM8NgahFlt4A7rKrc
        7rnjhGYUjvmCFwZE8bEYwSaeikOIzNZ/+w0+sQrJwHEIdPskuQvGuPw9fCqRF+dvnxbvop2w8cUT+
        Ke4lD5GA==;
Received: from 200-207-58-141.dsl.telesp.net.br ([200.207.58.141] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nCL20-0007YA-BU; Tue, 25 Jan 2022 13:34:40 +0100
Message-ID: <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
Date:   Tue, 25 Jan 2022 09:34:23 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dyoung@redhat.com" <dyoung@redhat.com>
Cc:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "bhe@redhat.com" <bhe@redhat.com>,
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
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/2022 08:50, d.hatayama@fujitsu.com wrote:
>> +       while ((func = strsep(&buf, ","))) {
>> +               addr = kallsyms_lookup_name(func);
>> +               if (!addr) {
>> +                       pr_warn("panic_notifier_filter: invalid symbol %s\n", func);
>> +                       continue;
>> +               }
> 
> Could you remove this check?
> 
> panic_notifier_list is exported to kernel modules and this check
> prevents such users from using this feature.
> 
> Thanks.
> HATAYAMA, Daisuke


Hi, thanks for the review. First of all, notice that it's very likely
this patch isn't gonna get merged this way, we are considering a
refactor that included 2 panic notifiers: one a bit earlier (pre_dump),
that includes functions less risky, as watchdog unloaders, kernel offset
dump, etc, and the second panic notifier (post_dump) will keep the
majority of callbacks, and can be conditionally executed on kdump
through the usage of "crash_kexec_post_notifiers".

Anyway, I'm curious with your code review - how can we use this filter
with modules, if the filter setup is invoked as early_param(), before
modules load? In that case, module functions won't have a valid address,
correct? So, in that moment, this lookup fails, we cannot record an
unloaded module address in such list. Please, correct me if I'm wrong.

Cheers,


Guilherme
