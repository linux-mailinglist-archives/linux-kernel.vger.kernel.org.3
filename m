Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E6864B133D
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbiBJQkc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:40:32 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244474AbiBJQk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:40:29 -0500
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7505397;
        Thu, 10 Feb 2022 08:40:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=B/ZQ0AKhexUA/i80GDAohIZZnfnEDMlKumXUHN+Riyk=; b=jUMqRmx4MztS6mYTp3RKIoRW+Z
        B621JnxCATZFMGNZhYuit7kcbXJnZZqmCFJL3b4YMXmv3e+A4LbHzfITEdKd+Qw499jie6/fIq3rG
        07abQuGcry2bBg3ImJVN/hmanL3S0IHN0IxSR7eXIRUM3blMuLj6KUMIaG2gWU6dr/JiylKkdNQIo
        vCHkrzM2HiVwpGa/cp7I/1GSsMf8sI7jdHbs8HE3EBk4cYyb9r2TSSzq5N+difEmKcX5MYXZ1nLm0
        Tj+W9wxhTVyhAMo1vqrRyQDyVq/PJiVZKoDG19He+4j8vC1aJIcnLGkF5xdrZ/CVcKpIY4DFGkDi1
        DRrU5aKw==;
Received: from 201-27-34-10.dsl.telesp.net.br ([201.27.34.10] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nICUL-000BX5-Fi; Thu, 10 Feb 2022 17:40:09 +0100
Message-ID: <7b45bc2b-f74d-8604-bd8a-4930f7b8f926@igalia.com>
Date:   Thu, 10 Feb 2022 13:39:50 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     "bhe@redhat.com" <bhe@redhat.com>
Cc:     Petr Mladek <pmladek@suse.com>,
        "dyoung@redhat.com" <dyoung@redhat.com>,
        "vgoyal@redhat.com" <vgoyal@redhat.com>,
        "d.hatayama@fujitsu.com" <d.hatayama@fujitsu.com>,
        "kexec@lists.infradead.org" <kexec@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "stern@rowland.harvard.edu" <stern@rowland.harvard.edu>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        "halves@canonical.com" <halves@canonical.com>,
        "kernel@gpiccoli.net" <kernel@gpiccoli.net>, mhiramat@kernel.org,
        d.hatayama@jp.fujitsu.com
References: <20220108153451.195121-1-gpiccoli@igalia.com>
 <TYAPR01MB6507D06BA6D32218F6E88198955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fda509a5-ea0d-4d1d-a1c1-ca5e80010fc0@igalia.com>
 <TYAPR01MB6507D9747647685B554B8F8F955F9@TYAPR01MB6507.jpnprd01.prod.outlook.com>
 <fb5e66b6-049a-22ab-5913-a04cc302b629@igalia.com> <YfPxvzSzDLjO5ldp@alley>
 <e2d39675-5df6-73fb-fa24-df906a97ee50@igalia.com>
 <YgMLd+avxyBplfk2@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YgMLd+avxyBplfk2@MiWiFi-R3L-srv>
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

On 08/02/2022 21:31, bhe@redhat.com wrote:
> [...]
>> So, what are the opinions from kdump maintainers about this idea?
>> Baoquan / Vivek / Dave, does it make sense to you? Do you have any
>> suggestions/concerns to add on top of Petr draft?
> 
> Yeah, it's reasonable. As I replied to Michael in another thread, I
> think splitting the current notifier list is a good idea. At least the
> code to archieve hyper-V's goal with panic_notifier is a little odd and
> should be taken out and execute w/o conditional before kdump, and maybe
> some others Petr has combed out.
> 
> For those which will be switched on with the need of adding panic_notifier
> or panic_print into cmdline, the heavy users like HATAYAMA and Masa can
> help check.
> 
> For Petr's draft code, does it mean hyper-V need another knob to trigger
> the needed notifiers? Will you go with the draft direclty? Hyper-V now
> runs panic notifiers by default, just a reminder.
> 

Hi Baoquan, thanks for your comments.

I'll need to study the Hyper-V code and how it's done today - I guess
most part of this implementation will be studying the notifiers we have
currently, split them among the 3 new notifiers and comb them into
patches, so they can be reviewed for all relevant maintainers (who know
the code we are changing).

I'm not sure if I go directly with the draft, likely it'll have some
changes, but the draft should be the skeleton of the new implementation.
Specially if you/other kdump maintainers agree it's a good idea =)

Cheers,


Guilherme
