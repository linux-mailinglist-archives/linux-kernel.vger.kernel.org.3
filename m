Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D693487922
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:40:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239308AbiAGOkR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:40:17 -0500
Received: from fanzine2.igalia.com ([213.97.179.56]:56804 "EHLO
        fanzine2.igalia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbiAGOkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:40:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=J1DyS14Ehf45YNkMTdYATp+WR6rWMt9aGDPVcqj75fo=; b=H2svyVkPl/vrZ9Tav8Su/VGLEv
        V0KCDgXDzpzOjpwG8YqyvmLXUV86i/tPGpmB9d5woOdDmn1vcgf28QSV3yf+ARP9E3EVIhioI0MFA
        Oe/a+aJMuGIORot1UzzQmRskuq3+lPKB/hgnW8U87jylUhvUS8MaMMdqAHV0vlt0UofIjsgcFPIUO
        FtjbxNMgLKuabRHIRNf+/60lCAVR2NEPS/3T6uXAOK3CJxRpgE7hnSXvklE8d0w52BAD3lGm2KFoj
        nhzK54H5FbSHsRzAnRH+7z0+FnneFnS3isA+TFJtyHSsO6BaWT6DxOLDsWnP4pug1iwX4Xoh9UfuH
        C3AJxBqg==;
Received: from [179.113.53.20] (helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1n5qPY-0009q7-KN; Fri, 07 Jan 2022 15:40:08 +0100
Message-ID: <9a6e628e-a6fc-9879-288b-eedc32151234@igalia.com>
Date:   Fri, 7 Jan 2022 11:39:52 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Subject: Re: [PATCH V2] notifier/panic: Introduce panic_notifier_filter
Content-Language: en-US
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kexec@lists.infradead.org, linux-kernel@vger.kernel.org,
        dyoung@redhat.com, linux-doc@vger.kernel.org, bhe@redhat.com,
        vgoyal@redhat.com, stern@rowland.harvard.edu,
        akpm@linux-foundation.org, corbet@lwn.net, halves@canonical.com,
        kernel@gpiccoli.net
References: <20220106200007.112357-1-gpiccoli@igalia.com>
 <YdgtNvd68kWakErr@smile.fi.intel.com>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <YdgtNvd68kWakErr@smile.fi.intel.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 09:08, Andy Shevchenko wrote:
> [...]
>> +	while (buf) {
>> +		func = strsep(&buf, ",");
> 
> Don't we have a parser of this format already?
> Anyway, you may reduce code by
> 
> 	unsigned long addr;
> 	char *func = buf;
> 
> 	while ((func = strsep(&func, ",")) {
> 

Hi Andy, thanks for the review! Looking the kernel code for some similar
parameters, I couldn't see any better alternative (like a helper) to do
this parsing - checked for example the ftrace parameters (borrowed my
code from there, in fact heh), initcall_blacklist, module_blacklist,
usbcore.quirks, etc.

I'll try to follow your suggestion, to reduce a bit the code...though I
confess the original code reads more clearly for me.

Cheers,


Guilherme
