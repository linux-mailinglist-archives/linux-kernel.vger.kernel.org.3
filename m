Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D6A54BFCB1
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 16:35:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233082AbiBVPff (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 10:35:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbiBVPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 10:35:31 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E6D216306C
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:35:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1645544102;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gzDriewqgRZ9io4uPq8+Th48FK+kOj3Iy64ttany+bU=;
        b=aXqe+FfJrZ6+pOUG/CLkiWL1/xkEymV3PmKybJMTIm2URTiKOwR4X3+O7/S8f5x7aqq6OQ
        8KBHWTyads1g0WiOY0TB8xBrajdoY0fZWepSqqqK1XDDZH3cvPLmBGAmG0WwHXgLaNjq8r
        4UV6FsbCIGoVeSY5juhZbOwSYVmMS+o=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-379-sM93uXe1MOqEysCM7XJrZg-1; Tue, 22 Feb 2022 10:35:01 -0500
X-MC-Unique: sM93uXe1MOqEysCM7XJrZg-1
Received: by mail-qv1-f69.google.com with SMTP id kc30-20020a056214411e00b0042cb92fe8bbso21465803qvb.8
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 07:35:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=gzDriewqgRZ9io4uPq8+Th48FK+kOj3Iy64ttany+bU=;
        b=FCWQUQQtUy0moxOIzuv2WvoG1Ll8LjAjGo7cIwN76XmVpljJPz9laETlmxnMFrb7IG
         40UKodUvmI5jo+XPVA4f+9i6T7LiTTFcJnMYPcFaOTF5qTIEubdt2d9edPNNNu71+4fQ
         weAiQSaJVWyqNgesX43XOYyrKmlcS2yt6KZENcxxeLVo8UjK49Fae/ROTgGNSlKb6RdG
         EqEVQkCrlhCO3oZy5xfU/ED7F2Hmy6Dk/gEsusf06w2u96f2jPds9LQ8omHjW1CLDWd9
         PuyhR13c670jcu4kJ1XMw6gqZ1rNYMakgNG2jfWC+H4kbfIT612FBD59WxZOxQG5LgXc
         sG4g==
X-Gm-Message-State: AOAM530nyEqFAXDSBMoEfJ/7zMEn9F+LF1EQvMuKs6AapnJXsvfrkzL1
        9tpMG0530bvxKkp8y2sFwB4NW7gZrL8Znh2XakIJCcfAdj8Z5TRgbtfWR4Pv/fT0myNpTeT/xeK
        +amc0ZX2ucwOBpJrRdXcUJrjX
X-Received: by 2002:a37:9744:0:b0:508:48cd:5f91 with SMTP id z65-20020a379744000000b0050848cd5f91mr15481955qkd.127.1645544100560;
        Tue, 22 Feb 2022 07:35:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw2JvSCA9d5bqs7ykg+cC+lHp7PPs64v92J2LbgKonNM67ESC05NAhByuZAggoWd6lP27ZDVA==
X-Received: by 2002:a37:9744:0:b0:508:48cd:5f91 with SMTP id z65-20020a379744000000b0050848cd5f91mr15481856qkd.127.1645544099190;
        Tue, 22 Feb 2022 07:34:59 -0800 (PST)
Received: from [192.168.1.9] (pool-68-163-101-245.bstnma.fios.verizon.net. [68.163.101.245])
        by smtp.gmail.com with ESMTPSA id e16sm33080419qty.47.2022.02.22.07.34.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Feb 2022 07:34:58 -0800 (PST)
Subject: Re: [PATCH v3] livepatch: Skip livepatch tests if ftrace cannot be
 configured
To:     Petr Mladek <pmladek@suse.com>, David Vernet <void@manifault.com>
Cc:     live-patching@vger.kernel.org, linux-kernel@vger.kernel.org,
        jpoimboe@redhat.com, jikos@kernel.org, mbenes@suse.cz,
        corbet@lwn.net, kernel-team@fb.com
References: <20220216161100.3243100-1-void@manifault.com>
 <YhOd/vQGnv9I1WCX@alley>
From:   Joe Lawrence <joe.lawrence@redhat.com>
Message-ID: <42dfc6bf-cc18-138b-9e9d-cf460e5277da@redhat.com>
Date:   Tue, 22 Feb 2022 10:34:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <YhOd/vQGnv9I1WCX@alley>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/22 9:13 AM, Petr Mladek wrote:
> On Wed 2022-02-16 08:11:01, David Vernet wrote:
>> livepatch has a set of selftests that are used to validate the behavior of
>> the livepatching subsystem.  One of the testcases in the livepatch
>> testsuite is test-ftrace.sh, which among other things, validates that
>> livepatching gracefully fails when ftrace is disabled.  In the event that
>> ftrace cannot be disabled using 'sysctl kernel.ftrace_enabled=0', the test
>> will fail later due to it unexpectedly successfully loading the
>> test_klp_livepatch module.
>>
>> While the livepatch selftests are careful to remove any of the livepatch
>> test modules between testcases to avoid this situation, ftrace may still
>> fail to be disabled if another trace is active on the system that was
>> enabled with FTRACE_OPS_FL_PERMANENT.  For example, any active BPF programs
>> that use trampolines will cause this test to fail due to the trampoline
>> being implemented with register_ftrace_direct().  The following is an
>> example of such a trace:
>>
>> tcp_drop (1) R I D      tramp: ftrace_regs_caller+0x0/0x58
>> (call_direct_funcs+0x0/0x30)
>>         direct-->bpf_trampoline_6442550536_0+0x0/0x1000
>>
>> In order to make the test more resilient to system state that is out of its
>> control, this patch updates set_ftrace_enabled() to detect sysctl failures,
>> and skip the testrun when appropriate.
>>
>> Suggested-by: Petr Mladek <pmladek@suse.com>
>> Signed-off-by: David Vernet <void@manifault.com>
> 
> Reviewed-by: Petr Mladek <pmladek@suse.com>
> Tested-by: Petr Mladek <pmladek@suse.com>
> 
> I am going to push it after two days or so unless anyone is against.
> 

Sorry for late replies as I'm just back from PTO, but v3 looks good to
me.  Thanks Petr and David.

Acked-by: Joe Lawrence <joe.lawrence@redhat.com>

-- 
Joe

