Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D02457BD2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 19:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232727AbiGTRto (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 13:49:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229881AbiGTRtm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 13:49:42 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23104528BA
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:49:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id r24so4519336plg.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 10:49:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=OGZ6EVWX47iCkpURH7H3jNVGerihNoxgBZpPgKoFRr8=;
        b=O3aL38WUU88GpHHYgqPXQWchcKkMKntZmXceWbN9//3BO/ipwbkli8WNWEDDeohigQ
         VJFg4kTsW/AeAfksCnc8aoq34ZDnH3IadJsWoJEC2j8nzKStyzCpX5ECTyrzDIemyUAY
         JP7f+W3dq7f8qdOAAyWdYvVQbmqhyf1F/2Ee8px0W57cUTduj9dU73oOFdTX4w0+tHoT
         QML868lIp9RUjf/AerCOe4eUiQhay1UNZP6GRKmv8Sjf0MXvi8/hlHWYS+Em+et6OBn7
         URLUv8UFz3try8UtTUQzYGpjcGO5vMCBXZHAuKzHeRYfCg+IoxFN/iZI4zAU8mV3kIuV
         Kiiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=OGZ6EVWX47iCkpURH7H3jNVGerihNoxgBZpPgKoFRr8=;
        b=dG9snFDvrFuWkBqN1Hv2swnli6ZUHvCmewNMb1TlQQaVzbpOay8LCeEAduHvFDZgO7
         wXZjipcF0F7NJ+8bc1xvRV8O8KMyvYdoLVTVH9eERtxnm5kEzmkEs8af+O1UPCU8wD+W
         XrlXVgu2ikH5XWAXhYk3HzfpdaL4bLlebgqXANLfJQpf1xS+//1w51uduVHhqJMkqYfx
         Vb2AL5ytXGG0SNXA+4l9K90bxxa9SDr/l/rMEc8LKjBVVgr2klfg99O1Mq2z/7Pqc+8c
         9FGEjHJ/imcV2TIY/LC8B+5ZkGbSVBwy3eQc8J2gWcLd0qG4RedHAxGlwxXnuW7hwvEo
         QmNw==
X-Gm-Message-State: AJIora8e3/BYFP4NvUSqyLsYLudcXV7cZ4lucsZNQjR+/tyDZnVu6Iq+
        vWCHR7qiV9r7okSNfuWbyq4EJw==
X-Google-Smtp-Source: AGRyM1uLpyDev3mfEmiYT/AYGBq/z+bL/mCYCp3mQHbT+sPz+DLYt966JJnwm3sZVaTPWN0xVo+OYw==
X-Received: by 2002:a17:90a:4b05:b0:1f2:1c2a:6fea with SMTP id g5-20020a17090a4b0500b001f21c2a6feamr5249743pjh.115.1658339381553;
        Wed, 20 Jul 2022 10:49:41 -0700 (PDT)
Received: from google.com (123.65.230.35.bc.googleusercontent.com. [35.230.65.123])
        by smtp.gmail.com with ESMTPSA id r2-20020aa79ec2000000b005284e98304csm13694155pfq.205.2022.07.20.10.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 10:49:40 -0700 (PDT)
Date:   Wed, 20 Jul 2022 17:49:37 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Kechen Lu <kechenl@nvidia.com>
Cc:     kvm@vger.kernel.org, pbonzini@redhat.com, vkuznets@redhat.com,
        somduttar@nvidia.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v3 1/7] KVM: x86: only allow exits disable before
 vCPUs created
Message-ID: <YthAMfGD3nHtrOg9@google.com>
References: <20220615011622.136646-1-kechenl@nvidia.com>
 <20220615011622.136646-2-kechenl@nvidia.com>
 <Ytg3kHHdft8IqIP+@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Ytg3kHHdft8IqIP+@google.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 20, 2022, Sean Christopherson wrote:
> On Tue, Jun 14, 2022, Kechen Lu wrote:
> > From: Sean Christopherson <seanjc@google.com>
> > 
> > Since VMX and SVM both would never update the control bits if exits
> > are disable after vCPUs are created, only allow setting exits
> > disable flag before vCPU creation.
> > 
> > Fixes: 4d5422cea3b6 ("KVM: X86: Provide a capability to disable MWAIT
> > intercepts")
> 
> Don't wrap the Fixes: line (ignore any complaints from checkpatch).

Sorry, I didn't see that you had sent v4 already and replied to some v3 patches.
This one still holds true for v4 (very minor nit though).
