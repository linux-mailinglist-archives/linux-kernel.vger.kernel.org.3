Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D3754DC507
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 12:48:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233125AbiCQLtk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 07:49:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232301AbiCQLtg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 07:49:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 752BB149240
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 04:48:19 -0700 (PDT)
From:   Thomas Gleixner <tglx@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647517697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOmvLUBIbr9zqkOIsEaWgWSiQHfKAg5TEEhFF/0BnOM=;
        b=mwqne6bWyXBpslp3vcIvx9yZqYZwon743EcSjmvKgG+KO5d4J146bw3yuvNJEH//Ml1W4I
        XVmtg5V39U/FNBzSv+ieuoNh7UoQTq675bc5sWF71Iv8U5S+Laji1qckI+ovaT3C8Da7BQ
        zoSZP7/H6S9uqAMtTdQVbSdz5rt7I6zFSxH/G6Zb5q8J4O4ii1/bQfRH2ES9xVLq8pqmRN
        JSDvZz0aD5G7BKPRJlHxANq3xATOH35b92rVe3rUUa/wYUqa0cl09Y/c6yPLHYaS1HwU1g
        4I8C3+TFv/qLwk8cHhOsZIdtiZNuipB+XBkomz4SxhxSV43slUYnmhR29Hnfww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647517697;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EOmvLUBIbr9zqkOIsEaWgWSiQHfKAg5TEEhFF/0BnOM=;
        b=a6P18OZcRlV4BGm5FM8lGjNnib5u0yXZUpaQv0cHXoIfh+suMXgA9Sg1dmvnVbnA9yxfFA
        eHXz9GjvHdaIIfBA==
To:     Dave Hansen <dave.hansen@intel.com>,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
        mingo@redhat.com, bp@alien8.de, luto@kernel.org,
        peterz@infradead.org
Cc:     sathyanarayanan.kuppuswamy@linux.intel.com, aarcange@redhat.com,
        ak@linux.intel.com, dan.j.williams@intel.com, david@redhat.com,
        hpa@zytor.com, jgross@suse.com, jmattson@google.com,
        joro@8bytes.org, jpoimboe@redhat.com, knsathya@kernel.org,
        pbonzini@redhat.com, sdeep@vmware.com, seanjc@google.com,
        tony.luck@intel.com, vkuznets@redhat.com, wanpengli@tencent.com,
        thomas.lendacky@amd.com, brijesh.singh@amd.com, x86@kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCHv6 11/30] x86/tdx: Handle in-kernel MMIO
In-Reply-To: <b1c1c4f1-8e5d-3c5a-8433-e101bbf79600@intel.com>
References: <20220316020856.24435-1-kirill.shutemov@linux.intel.com>
 <20220316020856.24435-12-kirill.shutemov@linux.intel.com>
 <b1c1c4f1-8e5d-3c5a-8433-e101bbf79600@intel.com>
Date:   Thu, 17 Mar 2022 12:48:17 +0100
Message-ID: <87o824241q.ffs@tglx>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16 2022 at 14:53, Dave Hansen wrote:
> On 3/15/22 19:08, Kirill A. Shutemov wrote:
>> In other words, even if all of the work was done to paravirtualize all
>> x86 MMIO users and virtio, this approach would still be needed. There
>> is essentially no way to get rid of this code.
> ...
>> == Patching TDX drivers ==
> ...> This approach will be adopted in the future, removing the bulk of
>> MMIO #VEs. The #VE-based MMIO will remain serving non-virtio use cases.
>
> I still don't like this very much, but I can't argue with my own logic. :)
>
> BTW, TDX folks...  I expect you to, today, start coming up with a
> comprehensive list of the MMIO-induced #VE's and the reasoning why they
> should or should not be paravirtualized.  You're going to get grumpy
> maintainers if this is done haphazardly as one-offs when users hit
> performance issues.

Grumpy maintainers? That's a meme. I've never seen that happen. :)
