Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35F865AF66D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 22:58:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbiIFU5V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 16:57:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229842AbiIFU5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 16:57:03 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C1CA9E2FD
        for <linux-kernel@vger.kernel.org>; Tue,  6 Sep 2022 13:56:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662497811;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LPRivCeSjBulelI1+kw/PdRERXMqiUKrh1hGXvPKua8=;
        b=FZb2urG9JKgh4QumL+yOI5Uls3DG30x9kgTDm5k1dD4oarmZCTKtLzwcU90gM/on5wVOWF
        DAt6/272FclKdUpD50hfm00YmqY+cf6UpS3BXEgpY0N1ZFiHdCQLrKKtfMUu8Wyn9UIEsE
        DpqPEe70RwIAyuPaygdfqBqUoHw8cnM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-663-cj98G2QpOcm7JWnKY42eng-1; Tue, 06 Sep 2022 16:56:50 -0400
X-MC-Unique: cj98G2QpOcm7JWnKY42eng-1
Received: by mail-ed1-f69.google.com with SMTP id q18-20020a056402519200b0043dd2ff50feso8211546edd.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Sep 2022 13:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=LPRivCeSjBulelI1+kw/PdRERXMqiUKrh1hGXvPKua8=;
        b=BwxVxhFN5SqAgHE2TKwtzxdIwDzOyj6dTIl6V6Ip1lgodN3NQuWTkfTJoWfk3ETKZU
         NFR/asGE3ZpSqte0M8okmwuZU23bmKQ/4lwbiOBpUNEduJU9vQWNHlw4f17e/VbIRuiw
         bpvrwbZSQKBmXII0I8PYq75Z3Ckowrpe1Gs045JggZ1G3PvWEESiXFP4o2lqCY8zEzbA
         XVpBGLOw/5drRnA/wXhWYoFBQBAWfP+ZCjNZzAZjJGe/c92v1vet0LI6auLW9f16/mXQ
         /AKF5GIRTZ821S5GDez5t2EU9IowBrCsmXJIvDTBnQfwYSXIE4ST3RHH6IfToNqu1+8v
         8QYQ==
X-Gm-Message-State: ACgBeo2fwQIWVNMPZBTUi4WJotXe/JkXlB+kSyaFtyKXfVxI4c/ci1Bs
        wzlqw8No8G8p3YaN0rmeHclWAHPFlDTC73axwf9XB8KZ/LKbm44CxKuWRNkzEPLy8hWN1rh5fp3
        2/6/hsJPmlErPeUO1qBo9ObTe
X-Received: by 2002:a17:907:7b93:b0:770:1d4f:4de9 with SMTP id ne19-20020a1709077b9300b007701d4f4de9mr218709ejc.201.1662497809302;
        Tue, 06 Sep 2022 13:56:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5+FpCsJzk4NbZ93QZn7KJ5CfN6FaCiztEXmhUnS5W0y0TA2BvpLNKWLw815Om1soqjBIGb+g==
X-Received: by 2002:a17:907:7b93:b0:770:1d4f:4de9 with SMTP id ne19-20020a1709077b9300b007701d4f4de9mr218699ejc.201.1662497809123;
        Tue, 06 Sep 2022 13:56:49 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81? (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl. [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
        by smtp.gmail.com with ESMTPSA id b13-20020a17090630cd00b007308812ce89sm7070197ejb.168.2022.09.06.13.56.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Sep 2022 13:56:48 -0700 (PDT)
Message-ID: <6ff23930-325b-4207-12fc-4d8fd5bea1ff@redhat.com>
Date:   Tue, 6 Sep 2022 22:56:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH] x86/cpu: Avoid writing MSR_IA32_TSX_CTRL when writing it
 is not supported
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     "Rafael J . Wysocki" <rafael@kernel.org>,
        Pavel Machek <pavel@ucw.cz>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H . Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, Dave Hansen <dave.hansen@intel.com>
References: <20220906201743.436091-1-hdegoede@redhat.com>
 <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
From:   Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <YxexAl+i+6MGjf7K@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 9/6/22 22:43, Peter Zijlstra wrote:
> On Tue, Sep 06, 2022 at 10:17:43PM +0200, Hans de Goede wrote:
>> On an Intel Atom N2600 (and presumable other Cedar Trail models)
>> MSR_IA32_TSX_CTRL can be read, causing saved_msr.valid to be set for it
>> by msr_build_context().
>>
>> This causes restore_processor_state() to try and restore it, but writing
>> this MSR is not allowed on the Intel Atom N2600 leading to:
> 
> FWIW, virt tends to do this same thing a lot. They'll allow reading
> random MSRs and only fail on write.

Right. So I guess I should send a v2 with an updated commit
message mentioning this ?

Regards,

Hans

