Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8634E6EFA
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Mar 2022 08:35:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354019AbiCYHgv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Mar 2022 03:36:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347483AbiCYHgu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Mar 2022 03:36:50 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A44553B5D
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:35:17 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id 9so4849719iou.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Mar 2022 00:35:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=F0MrQ+7f7irVz92hhE31+GxoOTRqqf7nkLXgWrnk+AY=;
        b=QlXrQfFErm9nmqJuIwFNttHecBo8vtSI0dcbdc68Zk3dtp2UPzmZsdQftZMwROOvoW
         kkx0SI0ZXdfz4nc11dMhHmK58CPlgtXAc5a13ZRfsAyVQ6KxUbdb8lmOgNR1KY0RZS/a
         fqpSa1ocM2fByvmUMXbZLUHc/SBLhwS4/hp6Y7RtwV5/rRz7EyhoFRtwxUgJWR/Yu65e
         cuEErTtkYIA4MEyhefLzSYJ9AElQaxu/UcBUJVneMkKIQpiQ6EtY57qFecDN8TVAwzDV
         vnScHzjxBxlNFWsF4T0kJ8ivkVwvoLT/+CJqMHxpFr7RWmTxo+qQmVHflho1tlk0Uo0o
         gPlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=F0MrQ+7f7irVz92hhE31+GxoOTRqqf7nkLXgWrnk+AY=;
        b=Qdgd3WT8Av/XMVenwMIAF+CLTLba9g18pxX6FZ0SVa808wF34tPNm9PZXl3osG3wmy
         r11oA9UOHWvoq+5upiiwXkhnsZEwFfPcEVQoAugGdzrNYTRoBXERApd82RZNaae7sy1y
         FpH30M3tULS3otk63wACzfUkTVj6CV2fQaIoufGQ108aDShPkqPyTYOcWO94GGiU2QSV
         5wfAbCWz0I2Ol2Za62cwWU7kxm68DLQp/Yq2Xok/z+Ru/VP1UuWACvIzePe+DMLTttA1
         GtyKrhcMcZWtKQhVEFQ0O1eMnhymMr2yjJJZqYK1nsaAmIL0AlfQbXB/+DY/FaxcQ7VF
         htEA==
X-Gm-Message-State: AOAM5311wUzz4HdCmgTfbMuMN789Vaiy9sjX/CLEW25yM9/8G9/iVj5G
        rN7M4PygmDGP6xwqRQcSV/7sVQ==
X-Google-Smtp-Source: ABdhPJyKAib7ZXAHBesSLCUBmAkLGhgEYACYuNaz1pPMRtCTnlSY/nTkv48NvdxoTzqfEXv0OWtBuQ==
X-Received: by 2002:a05:6638:1649:b0:31f:61f6:35f4 with SMTP id a9-20020a056638164900b0031f61f635f4mr5072950jat.205.1648193716120;
        Fri, 25 Mar 2022 00:35:16 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id p22-20020a5d8d16000000b006115627b87csm2600602ioj.55.2022.03.25.00.35.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 25 Mar 2022 00:35:15 -0700 (PDT)
Date:   Fri, 25 Mar 2022 07:35:12 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, maz@kernel.org,
        linux-kernel@vger.kernel.org, eauger@redhat.com,
        shan.gavin@gmail.com, Jonathan.Cameron@huawei.com,
        pbonzini@redhat.com, vkuznets@redhat.com, will@kernel.org
Subject: Re: [PATCH v5 18/22] KVM: arm64: Support SDEI ioctl commands on VM
Message-ID: <Yj1wsIy2rsVczmCJ@google.com>
References: <20220322080710.51727-1-gshan@redhat.com>
 <20220322080710.51727-19-gshan@redhat.com>
 <YjtYuk+Jx1dFPQQ9@google.com>
 <eae10132-a02d-b341-bdf5-be1b2096be4c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <eae10132-a02d-b341-bdf5-be1b2096be4c@redhat.com>
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

On Fri, Mar 25, 2022 at 02:59:52PM +0800, Gavin Shan wrote:
> > The PSCI implementation is a great example of how KVM has grown its
> > implementation in line with a specification, all the while preserving
> > backwards compatibility.
> > 
> 
> The only information feed by VMM is the exposed events. The events
> can't be registered from guest kernel, and raised from host to guest
> kernel until it's exposed by VMM.

I would suggest assuming that all SDEI events are exposed by default in
KVM. We will not require a VMM change to enable events individually.

> Besides, the exposed events will
> be defined staticly in host/KVM as we discussed on PATCH[02/22]. We
> also discussed to eliminate those ioctl commands. So I think we needn't
> to add KVM_SDEI_CMD_SET_VERSION. Further more, the version is only a
> concern to host itself if the migration can be done through the
> firmware pseudo system registers since the migration compatibility
> is the only concern to VMM (QEMU).

This all needs to work just like the KVM_REG_ARM_PSCI_VERSION version,
I'd recommend taking a look at how we handle that register in KVM.

> Yes, Currently, 0.1/0.2/1.0 versions are supported by PSCI. 0.1 is
> picked until VMM asks for 0.2 and 1.0 explicitly. However, it seems
> QEMU isn't using 1.0 PSCI yet and maybe more patch is needed to enable
> it.

As far as how it interacts with KVM, QEMU looks fine. The name of the
KVM_ARM_VCPU_PSCI_0_2 bit is quite frustrating. It actually implies that
KVM will enable it highest supported PSCI version. If the feature bit is
cleared then you only get PSCIv0.1

However, the DT node that QEMU sets up looks a bit crusty. The
properties for conveying PSCI function IDs were only ever necessary for
PSCIv0.1. The only property of interest any more is 'method', to convey
the SMCCC conduit instruction.

--
Thanks,
Oliver
