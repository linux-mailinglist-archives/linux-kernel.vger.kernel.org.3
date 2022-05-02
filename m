Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F20051699D
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 05:43:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357208AbiEBDrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 May 2022 23:47:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiEBDrK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 May 2022 23:47:10 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4DCC4D244
        for <linux-kernel@vger.kernel.org>; Sun,  1 May 2022 20:43:42 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id z18so14603878iob.5
        for <linux-kernel@vger.kernel.org>; Sun, 01 May 2022 20:43:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=zGNSlKgTRg237JpuejHa3caR1s/ok4pRQOehQdiihIc=;
        b=qfhvRSmDgBFYqZeJh5P65Y39gewiqAt13BPKf45fuv+ZkByqBgrYisQIl3DNsLp4hm
         s2ndoe+XBm2Lq2ZG2VPXBgtheIkGUIjcuAtK2SdC45eGXN698c8U7/A55TOwRCqAXH01
         G4+zDgmV49Yuvxc72MZ+kJOEEaICjznuSEqSJfAEfNR0WNJgiRdEBNX+tQ7WqytKbu7S
         An74GERQexjRDr7G7zsEKX60+w7htSVkVSp39iVwpWFHUHTTfcHsPjbBQ01q1MU9Y2d9
         qVH00CDBCOtQtgstADGKs8DYJKW3tBf5TlB5152RNZr8LlBI54mIX6phm43B2P+iDmtw
         H/XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=zGNSlKgTRg237JpuejHa3caR1s/ok4pRQOehQdiihIc=;
        b=zwB5QdrRdxzX3VSsck7AxRhBKZCTjbCFJ/8JD1eSIycFgcFptDqvNoXJuS+AfIYKRV
         UhOxYRjc8wwsFWrKh/G20Ooyr+3UcuemPJQCez1QKq3LQUDeCeOtrBJFJiwuw3SrxoIC
         1mFZS1U8Rcz7U4hlzLJ1HzL9EMwog1IG/I6tLjtQrBQtSoGmMXQ6v/mVHeQHjEd+r8z6
         U82pgxslxpkJwDmXwgyNu5RgW1Q36/OLu3oi5//j5TxW+4P3xU1+3Wa1qy9ioLorCRXY
         gwgCWt6u7wcjIl+6ejgKR3W/KEOfoGZ6jZ9YdWmWaIdhqecceN+Orb6+nM73l7/huiWc
         2zRQ==
X-Gm-Message-State: AOAM532OS7eUsKA6hizPpiVphb5+Zvhy6f247CUrfPRV/lzIr3EnZBrD
        KGrt/Pf9QrKqsoV3lTj+IY/jtg==
X-Google-Smtp-Source: ABdhPJyh1iMXhz1PULdaFy0uw0aVZ9erXWQ5/DyD6LOz5p3XTMx6qWKWFnFwv51JdBfOyRaVFyS+1Q==
X-Received: by 2002:a02:9a14:0:b0:32b:1f9f:352a with SMTP id b20-20020a029a14000000b0032b1f9f352amr4152355jal.209.1651463022025;
        Sun, 01 May 2022 20:43:42 -0700 (PDT)
Received: from google.com (194.225.68.34.bc.googleusercontent.com. [34.68.225.194])
        by smtp.gmail.com with ESMTPSA id t17-20020a6b0911000000b0065a47e16f61sm1821022ioi.51.2022.05.01.20.43.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 May 2022 20:43:41 -0700 (PDT)
Date:   Mon, 2 May 2022 03:43:38 +0000
From:   Oliver Upton <oupton@google.com>
To:     Gavin Shan <gshan@redhat.com>
Cc:     kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        eauger@redhat.com, Jonathan.Cameron@huawei.com,
        vkuznets@redhat.com, will@kernel.org, shannon.zhaosl@gmail.com,
        james.morse@arm.com, mark.rutland@arm.com, maz@kernel.org,
        pbonzini@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH v6 04/18] KVM: arm64: Support SDEI_EVENT_REGISTER
 hypercall
Message-ID: <Ym9TarUE6+lJ0izt@google.com>
References: <20220403153911.12332-1-gshan@redhat.com>
 <20220403153911.12332-5-gshan@redhat.com>
 <Ym1Nsaq/ERUx/ebD@google.com>
 <6e7cb20d-24c4-b357-8830-a68ff05638fe@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6e7cb20d-24c4-b357-8830-a68ff05638fe@redhat.com>
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

On Mon, May 02, 2022 at 10:55:51AM +0800, Gavin Shan wrote:
> > > +	unsigned long route_mode = smccc_get_arg(vcpu, 4);
> > 
> > This is really 'flags'. route_mode is bit[0]. I imagine we don't want to
> > support relative mode, so bit[1] is useless for us in that case too.
> > 
> > The spec is somewhat imprecise on what happens for reserved flags. The
> > prototype in section 5.1.2 of [1] suggests that reserved bits must be
> > zero, but 5.1.2.3 'Client responsibilities' does not state that invalid
> > flags result in an error.
> > 
> > Arm TF certainly rejects unexpected flags [2].
> > 
> > [1]: DEN0054C https://developer.arm.com/documentation/den0054/latest
> > [2]: https://github.com/ARM-software/arm-trusted-firmware/blob/66c3906e4c32d675eb06bd081de8a3359f76b84c/services/std_svc/sdei/sdei_main.c#L260
> > 
> 
> Yes, This chunk of code is still stick to old specification. Lets
> improve in next respin:
> 
>    - Rename @route_mode to @flags
>    - Reject if the reserved bits are set.
>    - Reject if relative mode (bit#1) is selected.
>    - Reject if routing mode (bit#0) isn't RM_ANY (0).

Bit[0] is ignored for private events, actually. So we really just reject
if any of bit[63:1] are set.

--
Thanks,
Oliver
