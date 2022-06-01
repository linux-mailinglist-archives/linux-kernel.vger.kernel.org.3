Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BCCA2539EF1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 10:03:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350006AbiFAIDQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 04:03:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347889AbiFAIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 04:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E59414614A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 01:03:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654070591;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Xgdti+VwJR3VZPhJkWljxyzD9ChCNJZ2LKlv/SAahT4=;
        b=LVgSnApf+ihxVDd7BIswWjH5nIJ788mIPyHsKBib8OPxeSOx6do1AuJRg9UWzzugKilRK+
        tjxA93ZTHuArxY3XPTiK+SLJfPzuijHe8Phevtz/XEI3qpEtLkYWS3GNas+ipY/RdPTyHi
        g7eIRAC+iSIix6gw6QKGdDX4GUQJ86U=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-626-uu0W-15tOreF66Y7z6KVRg-1; Wed, 01 Jun 2022 04:03:09 -0400
X-MC-Unique: uu0W-15tOreF66Y7z6KVRg-1
Received: by mail-ed1-f69.google.com with SMTP id q29-20020a056402249d00b0042d90fd98deso698407eda.12
        for <linux-kernel@vger.kernel.org>; Wed, 01 Jun 2022 01:03:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=Xgdti+VwJR3VZPhJkWljxyzD9ChCNJZ2LKlv/SAahT4=;
        b=mIqaIKzCbxK+GkT0TpBkWcWupJasf8rS0eIoZdLfOtOVELOgKkS6w5MuQ0u2t9vjcX
         LnHBbkXeoFg50WEMH1YaXG4580k7QQpYqFTYfu0PN0Os7na2yZXNRzgTfQ1bgQ2jMVxL
         crlCnAoPIOflMGzz30Yo9VQ1jtEPq1lsGo5Pm16mYu7SL7ZW+BJKcg+jLaJKcelSMQTH
         duYQijE6Q7KtXOmtAXbfHeRjTgVf7/E/Vpj+wRVdv+V7ZHoSiGsym6ZXjkH5d8nPhB/+
         IX9wd3C314jf5A7pDcj4sHr2N+7ryJGkFoW6qfKG2z07ldgo1jzuy3Nr/gKEnxOPbWHs
         7F4w==
X-Gm-Message-State: AOAM532igbCOEf5c0gBp8WL0sgcJnWUPjJ1Rc6ME1iJr6Zp7G/6PWcXo
        BloJZsqKm0b/S3zJqktaXBHTuzY8pgYDjTEZJ9+TTm1+loRDs7BPHH2mBwFAIRbxIUQo33n8z/Y
        duw58UJYSJZI7JjQsES66mQYu
X-Received: by 2002:a05:6402:34c1:b0:42b:4047:20b8 with SMTP id w1-20020a05640234c100b0042b404720b8mr57064169edc.88.1654070588076;
        Wed, 01 Jun 2022 01:03:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwgO9mu44S3VLlU3/wD7qn0U/ff1HsZNyCf5jYGov3NDArM7pwpMiurcfJY5MoE5bqD3r/3EA==
X-Received: by 2002:a05:6402:34c1:b0:42b:4047:20b8 with SMTP id w1-20020a05640234c100b0042b404720b8mr57064153edc.88.1654070587868;
        Wed, 01 Jun 2022 01:03:07 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id wj17-20020a170907051100b006fed9a0eb17sm388609ejb.187.2022.06.01.01.03.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Jun 2022 01:03:07 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        "Durrant, Paul" <pdurrant@amazon.co.uk>
Cc:     "Allister, Jack" <jalliste@amazon.com>,
        "bp@alien8.de" <bp@alien8.de>,
        "diapop@amazon.co.uk" <diapop@amazon.co.uk>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "jmattson@google.com" <jmattson@google.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "metikaya@amazon.co.uk" <metikaya@amazon.co.uk>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "rkrcmar@redhat.com" <rkrcmar@redhat.com>,
        "sean.j.christopherson@intel.com" <sean.j.christopherson@intel.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "wanpengli@tencent.com" <wanpengli@tencent.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: Re: ...\n
In-Reply-To: <YpcMw2TgNWzrcoRm@worktop.programming.kicks-ass.net>
References: <YpYaYK7a28DFT5Ne@hirez.programming.kicks-ass.net>
 <20220531140236.1435-1-jalliste@amazon.com>
 <YpYpxzt4rmG+LFy9@hirez.programming.kicks-ass.net>
 <059ab3327ac440479ecfdf49fa054347@EX13D32EUC003.ant.amazon.com>
 <YpcMw2TgNWzrcoRm@worktop.programming.kicks-ass.net>
Date:   Wed, 01 Jun 2022 10:03:06 +0200
Message-ID: <87r148olol.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, May 31, 2022 at 02:52:04PM +0000, Durrant, Paul wrote:

...

>> 
>> I'll bite... What's ludicrous about wanting to run a guest at a lower
>> CPU freq to minimize observable change in whatever workload it is
>> running?
>
> *why* would you want to do that? Everybody wants their stuff done
> faster.
>

FWIW, I can see a valid use-case: imagine you're running some software
which calibrates itself in the beginning to run at some desired real
time speed but then the VM running it has to be migrated to a host with
faster (newer) CPUs. I don't have a real world examples out of top of my
head but I remember some old DOS era games were impossible to play on
newer CPUs because everything was happenning too fast. Maybe that's the
case :-)

-- 
Vitaly

