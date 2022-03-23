Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B4A64E57F1
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:55:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343847AbiCWR4r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:56:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343850AbiCWR4p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:56:45 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EDF6BCB4
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:55:15 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id q11so2616628iod.6
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=PqjJXkRPd2m4fHW7zLlzzJ1D2JbPgS4DO8KeESR34/E=;
        b=kZu2MlxKm4TNZBvgOghSAFo5NR+ctEUYlJYRRkIiuzmM1ykFamILWWhzDO8EMecPc5
         6xqgOn/gtlYLunFPctAB5ciFAEBoydz51eJoeCrf4JgSA2IQsHs69Eg2r8HDQKX5JRd2
         dkkOpKB8CsPeJKN2OpskZlknijt9Ks0Rai/VLmPJN1QXbDspVqFwqJ12VvyU7ud1NnEa
         FZU/oyiEvjEKCG8GCoUNu48GDPeHdXrtRgyeSojd5KcqMrSPbYbn0f0zcigRH3CVSJhG
         O9cC8Gc99HbfDjaRM/SYGn352eUwoVqcC9hPyJ/TAHzQUj22374hoTMB4lxoEB02y+DF
         fPUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=PqjJXkRPd2m4fHW7zLlzzJ1D2JbPgS4DO8KeESR34/E=;
        b=ELdF9zUAt2zbYIbzV5pseL7Wwt6hf6WZSAM/COoUpJH75bkcFYNi3AKLuwUNzp6/q5
         dTlAztZsZzWZGMV+NpHt6bpD0UMKkewDfHH+gxsC/jWio1pFNDB/mcej3WTdfwx0LAik
         WXdoh4woAqANPV3E/qxtAtTaZwfQEP+LWWXGhD3+k5PzTb7xHMPpTpHGWzKFRq2zYkTI
         iinszR+2L5dzzOPxkEOB6EGtCnVM5d0prO9ufFYDbgZuBiqeF5bLxueiqx5zi3pyT5KW
         wuKIudgzukS6DKKnW59LsJhuK7/lQqCFuvSglZMc+veQak7QpHv0Rx3CnPdL2bvnmWhP
         +fCg==
X-Gm-Message-State: AOAM5327IxmPpAD46RPER2bdls4jOI7q4x/hBT0XkkYNzjC9g+taONE6
        6gOg57fsv++349946UaVDbc+7Q==
X-Google-Smtp-Source: ABdhPJwR2B0E+l4rro6BffINpb+kaE4XruvntOQYHgHUtjRPfYY26xFlWw65UnkzQlX4TCJMWBFoeA==
X-Received: by 2002:a05:6638:218f:b0:321:3fa6:79b8 with SMTP id s15-20020a056638218f00b003213fa679b8mr632693jaj.206.1648058114784;
        Wed, 23 Mar 2022 10:55:14 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id f4-20020a92b504000000b002c21ef70a81sm357051ile.7.2022.03.23.10.55.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:55:14 -0700 (PDT)
Date:   Wed, 23 Mar 2022 17:55:10 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 19/22] KVM: arm64: Support SDEI ioctl commands on vCPU
Message-ID: <Yjte/g4yG+gw7vnt@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-20-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-20-gshan@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 22, 2022 at 04:07:07PM +0800, Gavin Shan wrote:
> This supports ioctl commands on vCPU to manage the various object.
> It's primarily used by VMM to accomplish migration. The ioctl
> commands introduced by this are highlighted as below:
> 
>    * KVM_SDEI_CMD_GET_VCPU_EVENT_COUNT
>      Return the total count of vCPU events, which have been queued
>      on the target vCPU.
> 
>    * KVM_SDEI_CMD_GET_VCPU_EVENT
>    * KVM_SDEI_CMD_SET_VCPU_EVENT
>      Get or set vCPU events.
> 
>    * KVM_SDEI_CMD_GET_VCPU_STATE
>    * KVM_SDEI_CMD_SET_VCPU_STATE
>      Get or set vCPU state.

All of this GET/SET stuff can probably be added to KVM_{GET,SET}_ONE_REG
immediately. Just introduce new registers any time a new event comes
along. The only event we have at the end of this series is the
software-signaled event, with async PF coming later right?

Some special consideration is likely necessary to avoid adding a
register for every u64 chunk of data. I don't think we need to afford
userspace any illusion of granularity with these, and can probably lump
it all under one giant pseudoregister.

>    * KVM_SDEI_CMD_INJECT_EVENT
>      Inject SDEI event.

What events are we going to allow userspace to inject? IIUC, the
software-signaled event is an IPI and really under the control of the
guest. Async PF is entriely under KVM control.

I do agree that having some form of event injection would be great. VM
providers have found it useful to allow users to NMI their VMs when they
get wedged. I just believe that userspace should not be able to trigger
events that have a defined meaning and are under full KVM ownership.

IMO, unless the async PF changes need to go out to userspace, you could
probably skip event injection for now and only worry about SDEI within a
VM.

--
Thanks,
Oliver
