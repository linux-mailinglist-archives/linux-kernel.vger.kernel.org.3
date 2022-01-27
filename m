Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E5DA49E7F7
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 17:48:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244114AbiA0Qr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 11:47:59 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:59078 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238557AbiA0Qr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 11:47:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=6ry8NU6KqQ/Zz8ssxlnKVfGeEGVMNQjTGYINnzlZzNc=; b=QVfCMai+H1d6AdaS+BsYVlRPB/
        87rG4JejPHMKfUxGI0s+jYnJgKw0nbsvg+nnp2jW9w6m/D0pdS64cq91DnQXkZGEFtr0lij+5hiCo
        76jLjaQguFw0oN0E7jVwYbPr3jWLB9BAOZ12dWZ4JNvenxiXrJsj4lp//HC4mbcN5kxHTlGU7KUlQ
        qwELAHNxQLP8MEQQpt0NDjQ6wG01GjxOBp5dX3oJ92K2usd2wWreBM7bDPrED6LlgBoLyTf0zml09
        nkCBdDFsXDWNn/jR6rZp6YlLp4VVnMaKqqR4XPWlQTeC8x7+9DQw62mHOUmn4TYDyKeuSor4ibq8R
        EPzp8HKg==;
Received: from 200-207-58-141.dsl.telesp.net.br ([200.207.58.141] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1nD7w7-0006Nl-Kb; Thu, 27 Jan 2022 17:47:51 +0100
Message-ID: <7b93afff-66a0-44ee-3bb7-3d1e12dd47c2@igalia.com>
Date:   Thu, 27 Jan 2022 13:47:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V4] panic: Move panic_print before kmsg dumpers
Content-Language: en-US
To:     Baoquan He <bhe@redhat.com>, akpm@linux-foundation.org
Cc:     linux-kernel@vger.kernel.org, pmladek@suse.com, anton@enomsg.org,
        ccross@android.com, dyoung@redhat.com, feng.tang@intel.com,
        john.ogness@linutronix.de, keescook@chromium.org,
        kernel@gpiccoli.net, kexec@lists.infradead.org,
        rostedt@goodmis.org, senozhatsky@chromium.org, tony.luck@intel.com,
        vgoyal@redhat.com
References: <20220124203101.216051-1-gpiccoli@igalia.com>
 <20220126052246.GC2086@MiWiFi-R3L-srv>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20220126052246.GC2086@MiWiFi-R3L-srv>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2022 02:22, Baoquan He wrote:
> [...]
>>  	if (!_crash_kexec_post_notifiers) {
>> +		if (kexec_crash_loaded())
>> +			panic_print_sys_info(false);
>> +
> 
> Please reconsider this change. As I said in another thread, it's not
> suggested when adding any action before kdump switching and the action
> doesn't benefit kdump switching.
> 
> We don't oppose execute handling before kdump switching as long as
> it's executed conditionally. For those conditional extra handling and
> the followoing crash dumping's stability, it's not under kdump's care.
> 

Hi Baoquan, thanks for your review - I understand your concern, so let's
reconsider the change, as you suggest. The only thing is that the
specific bit that concerns you is not really a code added by the hereby
proposed patch, but it was in another patch I submitted, that reached
linux-next.

So, Andrew : can I ask you to please remove the following patch from
linux-next?

"panic: allow printing extra panic information on kdump"
https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=56439cb78293

(I'll also send this request in the original thread of the patch, for
completeness).

Baoquan: once it's removed from linux-next, I'll rework this proposed
patch and send a V5, hopefully a version that you consider more safe =)
Cheers,


Guilherme
