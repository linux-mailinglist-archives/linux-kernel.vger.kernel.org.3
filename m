Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 172404CD681
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 15:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234732AbiCDOhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 09:37:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239842AbiCDOhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 09:37:52 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 690191BAF1E
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 06:37:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646404622;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Yoh0Vw5aJSV68oQSDToYUo8gHl5lNF4ftXIM9R4rRuM=;
        b=bqXN3r/Ms3YXHPq8CYgFYNz4xHtVCcZRqr73PawwcR7BBCEkCNnA02dWK51dbMFkR6IWAd
        nvyZaWvcq9DfGFSvm5JlxHGHmBWgIeEUoJPsCzCkWNhj3xpKSHXlGTQjAii7yd2vhk+/gh
        yWGPnCzomsHswPRm5vwf0FXZVmpjqEg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-428-1GJVRBkwPBC-lw2fcddsaQ-1; Fri, 04 Mar 2022 09:37:01 -0500
X-MC-Unique: 1GJVRBkwPBC-lw2fcddsaQ-1
Received: by mail-wm1-f70.google.com with SMTP id 187-20020a1c19c4000000b0037cc0d56524so4222693wmz.2
        for <linux-kernel@vger.kernel.org>; Fri, 04 Mar 2022 06:37:01 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=Yoh0Vw5aJSV68oQSDToYUo8gHl5lNF4ftXIM9R4rRuM=;
        b=d/W8CUtkPNIALcWD1G5vRXNloz99fmkp5HLJ7pSnJyZufvqAmKfpdq30nhoPcd3Qyh
         T9UDKzGDAagXqzf48/+0InOpEQL7pbbjohOYWsdPyALuwC8g3fdGhqKEgGNAn7/bdtQg
         G9N7ocE3TlhwZDPVDce9skvi5X+IR1xdjCrrzWRP7+5DpyEhU9rz3oCY+lVi3BMxU/Ej
         w8PPkXPXxgPfkR6t4QCcA6owUtPWW876GhfIGLW21Q1zF5/t/F0+0VGII3guYcz4t2bp
         uWbvN9uOZivGgBxTgylSiWL5iNtX4DcUhPG4vkxMwkatRV4mauub5GPIq3GM86NNPIzD
         dKWg==
X-Gm-Message-State: AOAM530jLl8aup+o9UuZvRy3uZU8j1YT9uPE2HhElUAQqmXibo7SujuU
        8z604+LPuK28qk2w4qFmXEcawaA9qIJAMYIAjA9HQYlG6JrPXRugRts7Quts2IBYOC6QtdBhJTP
        0hZNbwaEIp83mG+ZkJLjY7JyN
X-Received: by 2002:a5d:6c65:0:b0:1f0:46d0:995c with SMTP id r5-20020a5d6c65000000b001f046d0995cmr8561067wrz.457.1646404620235;
        Fri, 04 Mar 2022 06:37:00 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwfp6Dig1IaRqa4G7p1FBmxxrOlC+Z0fxYrC+nsdBffvdyqp6auSqEEJSivIYst4oLcXiFEvg==
X-Received: by 2002:a5d:6c65:0:b0:1f0:46d0:995c with SMTP id r5-20020a5d6c65000000b001f046d0995cmr8561057wrz.457.1646404620038;
        Fri, 04 Mar 2022 06:37:00 -0800 (PST)
Received: from ?IPv6:2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8? ([2a0c:5a80:1b14:b500:abb:f9d1:7bc2:3db8])
        by smtp.gmail.com with ESMTPSA id f11-20020a7bcc0b000000b0037e0c362b6dsm5052933wmh.31.2022.03.04.06.36.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Mar 2022 06:36:59 -0800 (PST)
Message-ID: <b5e1f0d14a48c0815863af623cedbdc8c1bc255f.camel@redhat.com>
Subject: Re: [PATCH] tracing/osnoise: Force quiescent states while tracing
From:   Nicolas Saenz Julienne <nsaenzju@redhat.com>
To:     Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     mingo@redhat.com, linux-kernel@vger.kernel.org,
        mtosatti@redhat.com, paulmck@kernel.org, rostedt@goodmis.org
Date:   Fri, 04 Mar 2022 15:36:57 +0100
In-Reply-To: <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
References: <20220228141423.259691-1-nsaenzju@redhat.com>
         <78d798aa-388c-70bc-4227-985ba76c1d7e@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2022-03-04 at 15:28 +0100, Daniel Bristot de Oliveira wrote:
> On 2/28/22 15:14, Nicolas Saenz Julienne wrote:
> > At the moment running osnoise on an isolated CPU and a PREEMPT_RCU
> > kernel might have the side effect of extending grace periods too much.
> > This will eventually entice RCU to schedule a task on the isolated CPU
> > to end the overly extended grace period, adding unwarranted noise to the
> > CPU being traced in the process.
> > 
> > So, check if we're the only ones running on this isolated CPU and that
> > we're on a PREEMPT_RCU setup. If so, let's force quiescent states in
> > between measurements.
> > 
> > Non-PREEMPT_RCU setups don't need to worry about this as osnoise main
> > loop's cond_resched() will go though a quiescent state for them.
> > 
> > Note that this same exact problem is what extended quiescent states were
> > created for. But adapting them to this specific use-case isn't trivial
> > as it'll imply reworking entry/exit and dynticks/context tracking code.
> 
> Hey Nicolas,
> 
> While testing this patch with rtla osnoise on the 5.17.0-rc6-rt10+, when I hit
> ^c on osnoise top, the system freezes :-/.
> 
> Could you try that on your system?

Yes of course, I'll get a build going.

Were you using nohz_full?

-- 
Nicolás Sáenz

