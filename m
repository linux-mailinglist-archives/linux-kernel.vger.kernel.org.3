Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EF1BF4A6918
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Feb 2022 01:12:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243105AbiBBAL7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Feb 2022 19:11:59 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43070 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230521AbiBBAL6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Feb 2022 19:11:58 -0500
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1643760717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOrEamvuFtQ8hwjrMNbMubntGV3eJFlD+/MzjdupxXA=;
        b=IWLt3w3zkl31hJLYnw2Jnkge+8JVwDcSnDYTid7ZvfDmnLP/0pEHQ1J51qQ+nQBtEohaXe
        UVA9x8yW3Z0cibJLZm7ZEUQSbKN8NCfJdMrTnsu3k+V1uSUJeSaJ8uxUjiAZrx4EoRz0Ly
        kRHhuwfyMKNeIzr5KK0iG8SUaEFb7wqePOhpMNN/w19IAqdIBARS43BwP11yQVo2S0zjK8
        8ZaZkI5jhth3FLoU0ECNOsVgo6pHPphc9Ezp8w72kOERkXdlqgPm57ntpJOOS79sQpX7ul
        ClaFr7pRQ47Lp9UBoiYZjdeyYrkx7puBJ1Oi6k6xyeWHWfMCD7YLPHRK/nt5HQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1643760717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DOrEamvuFtQ8hwjrMNbMubntGV3eJFlD+/MzjdupxXA=;
        b=W2RVlpk45Yhnfant0rpTrtXnx7SYqw+FflftuA+kS+CWEORVpQm4IPmjGzh/EvmAyu0RZ6
        HYTZTVjjtc11MIDg==
To:     "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, dave.hansen@intel.com,
        luto@kernel.org, peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Subject: Re: [PATCHv2 19/29] x86/topology: Disable CPU online/offline
 control for TDX guests
In-Reply-To: <87o83qw2m5.ffs@tglx>
References: <20220124150215.36893-1-kirill.shutemov@linux.intel.com>
 <20220124150215.36893-20-kirill.shutemov@linux.intel.com>
 <87o83qw2m5.ffs@tglx>
Date:   Wed, 02 Feb 2022 01:11:56 +0100
Message-ID: <87leyuw2ib.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 02 2022 at 01:09, Thomas Gleixner wrote:

> On Mon, Jan 24 2022 at 18:02, Kirill A. Shutemov wrote:
>>  static bool intel_cc_platform_has(enum cc_attr attr)
>>  {
>> -	if (attr == CC_ATTR_GUEST_UNROLL_STRING_IO)
>> +	switch (attr) {
>> +	case CC_ATTR_GUEST_UNROLL_STRING_IO:
>> +	case CC_ATTR_HOTPLUG_DISABLED:

Not that I care much, but I faintly remember that I suggested that in
one of the gazillion of threads.
