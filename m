Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D241C4E5779
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 18:28:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343583AbiCWRaF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 13:30:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiCWRaC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 13:30:02 -0400
Received: from mail-io1-xd32.google.com (mail-io1-xd32.google.com [IPv6:2607:f8b0:4864:20::d32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A935AA4A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:28:31 -0700 (PDT)
Received: by mail-io1-xd32.google.com with SMTP id d62so2496373iog.13
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 10:28:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=LgnCvv2qE3S8Tqpp1/2DjvugQlyU9lcrJrUpyIMNMrQ=;
        b=mKDa/ZqD7NDxSaY4l0S6G4lgzGXJEl0gZCEPTE3GSbJDv+2fymW7CaflBSG4NfuYVL
         5yzCBy2AHpAi4Yz9IdAQ3eMXzAD/dp4HpWQmfcXnKB1AJvl1TJjD3XtYW+KScmGilk4w
         Owui8dsixk6DehiN5Rhz8QHjhgTabDXHgcQa9zsoHGJ8sBzEsWo8bebXMSSJSyDSGC01
         j27nkvOJPtRJrqHgK+rVIEqlgC8WWH5xXMI6/ZYx8ibZ2Jhu6oX2b6ARuv2mxIAS9CGW
         Dq7k5xKW9mspQEA4w4Dl9bnJzvkBlO8CgtMBHhvm3Sm9R3lEp38tG9w8KHof7FChyJkO
         V2ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=LgnCvv2qE3S8Tqpp1/2DjvugQlyU9lcrJrUpyIMNMrQ=;
        b=h//FjC3rLzkytis814Sv4W8+nyGisRTUbJsmgBOUEsHTr700ky1njgHXtR7AaaymWG
         Rsqm6IEeTmq8+etqo96dpkM74D0ODI54kUt6mEnPSGCjObjZm59yo+1LCFFcGBFb/9bz
         Mq2F2/bgh6HSo5JvZVoc9b7qXhmYWUizpZ2DKJZyNcT0wVzJlS11oe4ZAdwqewZCs/Di
         l9ELGmq6IP1JyX2I3ssqKNTi7rg7W5PmG1bNmXbJIBRIXfC+hHSBt4Bx5z2U50YH123k
         p8s8YI8TJNXKlulL3MPbEdAlRU0abDn713HYI41gtOsIveoFxtcDl6bOjfefWuzTRlg+
         RweQ==
X-Gm-Message-State: AOAM530Iyi0cWEAP6iSIrarZJF3ukMeQiZtY4Z2lDe4SG1TYQ6ABZLsp
        C1C2d9JakWJxAcSuuR1mVMtrbQ==
X-Google-Smtp-Source: ABdhPJyVvqHOYCIQvifvBP9cL1EAw3WnyYigwv1RusgVyObFlI+lYgfM14RmXBUdX5i9PZ5jUnLlmg==
X-Received: by 2002:a05:6602:2d49:b0:645:dcf0:3151 with SMTP id d9-20020a0566022d4900b00645dcf03151mr618760iow.61.1648056510629;
        Wed, 23 Mar 2022 10:28:30 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id w8-20020a056e0213e800b002c8279fb9dfsm278120ilj.57.2022.03.23.10.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 23 Mar 2022 10:28:29 -0700 (PDT)
Date:   Wed, 23 Mar 2022 17:28:26 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 18/22] KVM: arm64: Support SDEI ioctl commands on VM
Message-ID: <YjtYuk+Jx1dFPQQ9@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-19-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220322080710.51727-19-gshan@redhat.com>
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

On Tue, Mar 22, 2022 at 04:07:06PM +0800, Gavin Shan wrote:
> This supports ioctl commands on VM to manage the various objects.
> It's primarily used by VMM to accomplish migration. The ioctl
> commands introduced by this are highlighted as below:
> 
>    * KVM_SDEI_CMD_GET_VERSION
>      Retrieve the version of current implementation. It's different
>      from the version of the followed SDEI specification. This version
>      is used to indicates what functionalities documented in the SDEI
>      specification have been supported or not supported.

Don't we need a way to set the version as well? KVM is very much
responsible for upholding ABI of older specs. So, if a VMM and guest
expect SDEI v1.1, we can't just forcibly raise it to something else
during a migration.

The PSCI implementation is a great example of how KVM has grown its
implementation in line with a specification, all the while preserving
backwards compatibility.

>    * KVM_SDEI_CMD_GET_EXPOSED_EVENT_COUNT
>      Return the total count of exposed events.
> 
>    * KVM_SDEI_CMD_GET_EXPOSED_EVENT
>    * KVM_SDEI_CMD_SET_EXPOSED_EVENT
>      Get or set exposed event
> 
>    * KVM_SDEI_CMD_GET_REGISTERED_EVENT_COUNT
>      Return the total count of registered events.
> 
>    * KVM_SDEI_CMD_GET_REGISTERED_EVENT
>    * KVM_SDEI_CMD_SET_REGISTERED_EVENT
>      Get or set registered event.

Any new UAPI needs to be documented in Documentation/virt/kvm/api.rst

Additionally, we desperately need a better, generic way to save/restore
VM scoped state. IMO, we should only be adding ioctls if we are
affording userspace a meaningful interface. Every save/restore pair of
ioctls winds up wasting precious ioctl numbers and requires userspace
take a change to read/write an otherwise opaque value.

Marc had made some suggestions in this area already that Raghavendra
experimented with [1], and I think its time to meaningfully consider
our options. Basically, KVM_GET_REG_LIST needs to convey whether a
particular register is VM or vCPU state. We only need to save/restore a
VM state register once. That way, userspace doesn't have to care about
the underlying data and the next piece of VM state that comes along
doesn't require an ioctl nr nor VMM participation.

[1]: http://lore.kernel.org/r/20220224172559.4170192-3-rananta@google.com

--
Thanks,
Oliver
