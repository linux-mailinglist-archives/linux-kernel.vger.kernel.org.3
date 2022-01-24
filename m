Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA1924982B1
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 15:49:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238166AbiAXOtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 09:49:25 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:39768 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238288AbiAXOtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 09:49:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=uqVI2/Ws/hkfMRXL2wXcv67mAYHEWv6EvXIqlX8je3w=; b=TYHxSTbJB1eaqzyxRRdVvUbh2s
        TFdCcwzmqxcgS5bRtO1I5FWMw5DN35sNUDb6r6+WI+8hr4Jcp6/YjhMkrrp/Q9rknQi0x2/Vh5fGG
        0JRIK278kWepmL6bMs1bxf0sP4MeBKHLdldnehPLqCpPW/yeftviI+6QfACb/YWJFLkXxWYT3suIO
        zCmy38Uagm3RkcIVJTOeNlxWxRAQA/wWFfSxDLY7cz2nzi2Y/9bnveuo7cu3v7bkBtFlzxITF5yYS
        giB9T69DYJj1pPwKrWwig1tMrVbCKyAvVdkpc07r8avXCpKJO0jpGVz2mlu9sFa3ypuypea4Mt3sI
        OlAxEHgg==;
Received: from 200-207-58-141.dsl.telesp.net.br ([200.207.58.141] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nC0eW-0002Du-A5; Mon, 24 Jan 2022 15:49:04 +0100
Message-ID: <ff3bc2cf-80bf-3bb0-0dcd-7f9cacdae45a@igalia.com>
Date:   Mon, 24 Jan 2022 11:48:44 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Petr Mladek <pmladek@suse.com>
Cc:     HATAYAMA Daisuke <d.hatayama@jp.fujitsu.com>,
        kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, vgoyal@redhat.com,
        stern@rowland.harvard.edu, akpm@linux-foundation.org,
        andriy.shevchenko@linux.intel.com, corbet@lwn.net,
        halves@canonical.com, kernel@gpiccoli.net,
        Will Deacon <will@kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Hidehiro Kawai <hidehiro.kawai.ez@hitachi.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        John Ogness <john.ogness@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, mikelley@microsoft.com
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <Yel8WQiBn/HNQN83@alley> <ccd9332e-2917-3020-3590-447fa660ff56@igalia.com>
 <20220122105514.GA18258@MiWiFi-R3L-srv>
 <20220123220711.44f1484c9b510eea8cda9c47@kernel.org>
 <20220124135902.GB8305@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220124135902.GB8305@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 10:59, Baoquan He wrote:
> [...]
> About pre_dump, if the dump is crash dump, hope those pre_dump notifiers
> will be executed under conditional check, e.g only if 'crash_kexec_post_notifiers'
> is specified in kernel cmdline. 

Hi Baoquan, based on Petr's suggestion, I think pre_dump would be
responsible for really *non-intrusive/non-risky* tasks and should be
always executed in the panic path (before kdump), regardless of
"crash_kexec_post_notifiers".

The idea is that the majority of the notifiers would be executed in the
post_dump portion, and for that, we have the
"crash_kexec_post_notifiers" conditional. I also suggest we have
blacklist options (based on function names) for both notifiers, in order
to make kdump issues debug easier.

Do you agree with that? Feel free to comment with suggestions!
Cheers,


Guilherme

