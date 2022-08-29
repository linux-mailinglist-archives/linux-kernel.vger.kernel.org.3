Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CA135A45D9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 11:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbiH2JQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 05:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiH2JQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 05:16:38 -0400
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com [209.85.218.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD915281A
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:16:37 -0700 (PDT)
Received: by mail-ej1-f54.google.com with SMTP id kk26so14379067ejc.11
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 02:16:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=EZyAKGxDJWQWEgkfKzptYNGJYnD9auk8Xlm/WrZ7jdU=;
        b=d1aqREwB7C2c1lguMj7cO3Fo+Im3ujyrobnrfIY2VqxxMGlcAxB0spySQteOm9fSsy
         N/05PcdFeVMrlE5TLB9WRStdBWJCzHDyaC968vVKy98bi2YqLJMQ8DDi0kKW6z/fN7dw
         HKZJ1UxGsRzqGfFzvPr7RA0o+e+UoXqitmpIiJb3nzPVnQlNNixVow3PWud3GQY4KW8u
         2gpRJYTqQS6jFLOmBFrV2s8q9QdoljvkkeJ0/syk6IspnaOXeh8qWf5i1tzwSheeUWaT
         ZQDvKuKpEX4ixAMpQTlUbqK9T+vi50HmL7Xl3VsUG9CF3H+HSIzqNNY7hUgD3lGxbCLz
         BT0A==
X-Gm-Message-State: ACgBeo0qMpu7qbB1gyGiqf2/jciwJnfcOtvvmDh+Qf884dogfwJs8OWU
        /jDqgjI0ZCo1+/NdsPED4OkKqtsh0jA3yg==
X-Google-Smtp-Source: AA6agR7L7Zo8+3boKcduPEH8hNCqgDk58TMtCsjz06qKSqqKWkUKDWoye5odSbnSHlehicIrNvED8g==
X-Received: by 2002:a17:906:9752:b0:738:364a:4ac with SMTP id o18-20020a170906975200b00738364a04acmr13022013ejy.759.1661764596299;
        Mon, 29 Aug 2022 02:16:36 -0700 (PDT)
Received: from ?IPV6:2a0b:e7c0:0:107::70f? ([2a0b:e7c0:0:107::70f])
        by smtp.gmail.com with ESMTPSA id c15-20020a056402120f00b0043bbb3535d6sm5398344edw.66.2022.08.29.02.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Aug 2022 02:16:35 -0700 (PDT)
Message-ID: <b772c39f-c5ae-8f17-fe6e-6a2bc4d1f83b@kernel.org>
Date:   Mon, 29 Aug 2022 11:16:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Weird RIP printed in BUGs [was: 6.0 tty regression, NULL pointer
 deref in flush_to_ldisc]
Content-Language: en-US
To:     Hans de Goede <hdegoede@redhat.com>,
        =?UTF-8?Q?Ilpo_J=c3=a4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux regressions mailing list <regressions@lists.linux.dev>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, Oleg Nesterov <oleg@redhat.com>
References: <4b4bba5d-d291-d9fa-8382-cdc197b7ed35@redhat.com>
From:   Jiri Slaby <jirislaby@kernel.org>
In-Reply-To: <4b4bba5d-d291-d9fa-8382-cdc197b7ed35@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 29. 08. 22, 10:37, Hans de Goede wrote:
> [   28.626537] BUG: kernel NULL pointer dereference, address: 0000000000000000
> [   28.626555] #PF: supervisor instruction fetch in kernel mode
> [   28.626563] #PF: error_code(0x0010) - not-present page
> [   28.626569] PGD 0 P4D 0
> [   28.626580] Oops: 0010 [#1] PREEMPT SMP PTI
> [   28.626589] CPU: 2 PID: 8 Comm: kworker/u8:0 Tainted: G         C  E      6.0.0-rc2+ #102
> [   28.626598] Hardware name: MPMAN Converter9/Converter9, BIOS 5.6.5 07/28/2015
> [   28.626604] Workqueue: events_unbound flush_to_ldisc
> [   28.626617] RIP: 0010:0x0
> [   28.626633] Code: Unable to access opcode bytes at RIP 0xffffffffffffffd6.

Irrelevant to the original report, this new message format (the old 
being "Bad RIP value") confuses me. It always makes me think how can RIP 
be -42. So can we either:

1) print regs->ip value (0x0000000000000000) instead of prologue value 
(regs->ip - 42 = 0xffffffffffffffd6) here? Even though we really pass 
"regs->ip - 42" to copy_code()), or

2) don't print "RIP" in that message. So only "at 0xffffffffffffffd6"

? (I can send a patch for whichever is preferred, if anything.)

thanks,
-- 
js
suse labs

