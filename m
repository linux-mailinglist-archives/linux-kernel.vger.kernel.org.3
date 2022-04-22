Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AE3750B9C5
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 16:13:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1448507AbiDVOPl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 10:15:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379901AbiDVOPh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 10:15:37 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 82A635A5B9
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650636762;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=icM2kJqBL5swedCTabkxjhxKVdLrnSGbQ92HmnIvSYg=;
        b=JrzsHb+Ryd2jqDnZleS3a8VK8LWd3LU//8JpP716layoRB04j4JPrLJlQTFeGic+Q8xFEL
        zP2PDLzBktCTN5unt2QymhBsnjTtQkfT+K8E3VwsIxuFsDcufQbuI/VPr8wqZPfX8lmjGg
        LcHk7fb/NpjQEqavGnczhP+fHb6AfIw=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-lGz7hQExMPO6vA0oKna20g-1; Fri, 22 Apr 2022 10:12:41 -0400
X-MC-Unique: lGz7hQExMPO6vA0oKna20g-1
Received: by mail-qk1-f200.google.com with SMTP id j12-20020ae9c20c000000b0069e8ac6b244so5507055qkg.1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 07:12:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=icM2kJqBL5swedCTabkxjhxKVdLrnSGbQ92HmnIvSYg=;
        b=H/0dL2vUxeyBZ7HyAqpRM8fVM1OUYgjPr+vG7tjnxAPTN7i5HHNJWCP1vieSqUraz5
         Ul4Wq0nwXjWlh3CEFe+EK3FegdnCmtx0ERLpcphNRvC+XuyPHX8RX1UdcpvTQjOm/O77
         HHo5fgqJ/C3pV/wuUD567CcZPWY+TkaCf6zTyvm+GNp2jXJA1HFbwHvhv9wPcPU0izWe
         p2bfUrrGSN8UGVtXjp+RFo8aDHpW36HtvCsyB3KyfI4rqZebR6khZOw24nDio4DP+qga
         y9Lfx/ijJfVKYQGa00M4NHiv/iGUgC6NIREJALWMpsvPzDvvlrHoGmpkaZlHC0mM9Vl7
         /AMA==
X-Gm-Message-State: AOAM531EYknAtEA2uVg4SmMSvyklYzgWQoTz5gMCPfl292p+MIqeQpMA
        bad69unkWaVd7fAKzIyF6eXiH9ZtqF82X6dJVoLBWURSidRTWDy7NMiHPPxWbgcsdeIj6cA7Bot
        Uoab0xLzSYsQrY7yXSBqeQwQA
X-Received: by 2002:a37:6041:0:b0:680:f510:79c8 with SMTP id u62-20020a376041000000b00680f51079c8mr2887068qkb.570.1650636760936;
        Fri, 22 Apr 2022 07:12:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxD2Cj3ZZhQfaByRYJjN4P7n/034MshjTtdGQjVPY/4hzMhBzbBnxIlHQURGCeoxRKwJndQlA==
X-Received: by 2002:a37:6041:0:b0:680:f510:79c8 with SMTP id u62-20020a376041000000b00680f51079c8mr2887042qkb.570.1650636760699;
        Fri, 22 Apr 2022 07:12:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:5610:6e80::41? ([2600:1700:5610:6e80::41])
        by smtp.gmail.com with ESMTPSA id b126-20020a37b284000000b0069a11927e57sm935609qkf.101.2022.04.22.07.12.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Apr 2022 07:12:40 -0700 (PDT)
Message-ID: <19b324a4-f69c-1624-fbc7-e178b7c31d81@redhat.com>
Date:   Fri, 22 Apr 2022 10:12:39 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [RFC 2/3] futex: exit: Print a warning when futex_cleanup fails
Content-Language: en-US
To:     Matthew Wilcox <willy@infradead.org>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Darren Hart <dvhart@infradead.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        =?UTF-8?Q?Andr=c3=a9_Almeida?= <andrealmeid@collabora.com>,
        Arjan van de Ven <arjan@infradead.org>,
        Ulrich Drepper <drepper@redhat.com>
References: <20220421190533.1601879-1-npache@redhat.com>
 <20220421190533.1601879-3-npache@redhat.com>
 <YmGwzRIHFlKZk3Hm@casper.infradead.org>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <YmGwzRIHFlKZk3Hm@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 15:30, Matthew Wilcox wrote:
> On Thu, Apr 21, 2022 at 03:05:32PM -0400, Nico Pache wrote:
>> @@ -1007,13 +1013,15 @@ static inline void exit_pi_state_list(struct task_struct *curr) { }
>>  static void futex_cleanup(struct task_struct *tsk)
>>  {
>>  	if (unlikely(tsk->robust_list)) {
>> -		exit_robust_list(tsk);
>> +		if (!exit_robust_list(tsk))
>> +			pr_info("futex: exit_robust_list failed");
> 
> Doesn't this allow a malicious user process to spam the kernel logs
> with messages?  There needs to be a ratelimit on this, at least.
Fair point, we'd need a ratelimited print if we want to continue forward with
this. Additionally we may want to limit this print to debug kernels, but thats
just a thought.

Thanks for the review :)
-- Nico

