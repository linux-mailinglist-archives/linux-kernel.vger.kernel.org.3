Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E8657B9DD
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 17:33:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237293AbiGTPdW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 11:33:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237358AbiGTPdR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 11:33:17 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C3E961DA5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:33:16 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id b6so10565901wmq.5
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 08:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=+ITN8/NzMqMN7zHfyXAOzFRekORzcIckFhvH54+KYKA=;
        b=IenLWnEEs9XlqJG2dIci50Gy15R7Qnd+SkxKyc3Wl+ZY1jRDLUw324Px2VWmv6BWTq
         klvrupR+wkZ2uE+ktWw/E/MZsehPUA9xXH0lb3ZIz/8jGvF6av59PCYnc5mpGIMkPgn6
         UU8m9zzN6CsMbYUw9XgvVv5J1c2JouJrPr80tGSuSBj6YfMDvoKDVPyfx12cpQ3+Hxne
         Nxi1BaodgAyIuxXt/EdoF/kW1WDrA0+eND1W2KqiQCmyIME0dVJLwIwARcoC8MdNzxbL
         Uje/Su6C7SDMC+f/R+xfRn8KNnewYX4fLONmv1pMQJ+TsK8NPHKcTqWMlR8vLNLwUp7k
         C40A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=+ITN8/NzMqMN7zHfyXAOzFRekORzcIckFhvH54+KYKA=;
        b=JTUj+wp815RUROW9WozKYqLFFqDv1QuDheaTchVrMTZs50ArnAwcFzJ2OR/8HLtau8
         470y8xosvhBYdNjjS1+MGe3G/fuAAtC6YyJJ+uNLDR0pW+un3/0JU8iEid/AChNcJkV1
         X+2AC1AMn+5hytn0TxA/tHQX1GbYZ6raX1ok6beJ368+PWm34EoW+LffSe5PSBiV0Mkr
         aJVzPqX+1uPbw5JWK0c+f4gXXCfrm+X/uZsRdEHrG26ilCeGNGVVHEX2FWf5JBYKdRjj
         7SgNp/IEI3bWXYmissAOgITyLo6rMBpjNwyds/bTOknioSLJrmhi2mURnpRVrnBHa5Wi
         psIw==
X-Gm-Message-State: AJIora+IFGftrXOjQxuA+Dct8MwCzP8zjJM86msFcj1oNMceJedVXJV8
        jUN33/D2YGiHrKc5dqjwssukqA==
X-Google-Smtp-Source: AGRyM1sd+rdWLzQsA2lQG5zNk6KUCSobzGcO7gB3VqchM9eamBm9L6oCUo0agfpc4MIGawpoudhbQg==
X-Received: by 2002:a05:600c:2d09:b0:3a3:1062:ce61 with SMTP id x9-20020a05600c2d0900b003a31062ce61mr4439786wmf.138.1658331195186;
        Wed, 20 Jul 2022 08:33:15 -0700 (PDT)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net. [86.27.177.88])
        by smtp.gmail.com with ESMTPSA id m126-20020a1ca384000000b003a03e63e428sm3276117wme.36.2022.07.20.08.33.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jul 2022 08:33:14 -0700 (PDT)
Date:   Wed, 20 Jul 2022 16:33:13 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     =?utf-8?B?aGFpYmluemhhbmco5byg5rW35paMKQ==?= 
        <haibinzhang@tencent.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Ard Biesheuvel <ard.biesheuvel@arm.com>,
        Martin Ma <Martin.Ma@arm.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "hewenliang4@huawei.com" <hewenliang4@huawei.com>
Subject: Re: [PATCH V2] arm64: fix oops in concurrently setting
 insn_emulation sysctls
Message-ID: <YtggOdLN5NuFkFrl@google.com>
References: <9A004C03-250B-46C5-BF39-782D7551B00E@tencent.com>
 <YtfzvK0T8pJacsDm@google.com>
 <20220720151344.GA16452@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220720151344.GA16452@willie-the-truck>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Jul 2022, Will Deacon wrote:

> On Wed, Jul 20, 2022 at 01:23:24PM +0100, Lee Jones wrote:
> > On Sat, 02 Jul 2022, haibinzhang(张海斌) wrote:
> > 
> > > How to reproduce:
> > >     launch two shell executions:
> > >        #!/bin/bash
> > >        while [ 1 ];
> > >        do
> > >            echo 1 > /proc/sys/abi/swp
> > >        done
> > > 
> > > Oops info:
> > >     Unable to handle kernel NULL pointer dereference at virtual address 0000000000000010
> > >     Internal error: Oops: 96000006 [#1] SMP
> > >     Call trace:
> > >     update_insn_emulation_mode+0xc0/0x148
> > >     emulation_proc_handler+0x64/0xb8
> > >     proc_sys_call_handler+0x9c/0xf8
> > >     proc_sys_write+0x18/0x20
> > >     __vfs_write+0x20/0x48
> > >     vfs_write+0xe4/0x1d0
> > >     ksys_write+0x70/0xf8
> > >     __arm64_sys_write+0x20/0x28
> > >     el0_svc_common.constprop.0+0x7c/0x1c0
> > >     el0_svc_handler+0x2c/0xa0
> > >     el0_svc+0x8/0x200
> > > 
> > > emulation_proc_handler changes table->data for proc_dointvec_minmax
> > > and so it isn't allowed to reenter before restoring table->data,
> > > which isn't right now.
> > > To fix this issue, keep the table->data as &insn->current_mode and
> > > use container_of() to retrieve the insn pointer. Another mutex is
> > > used to protect against the current_mode update but not for retrieving
> > > insn_emulation as table->data is no longer changing.
> > 
> > Looks as though this lost its Fixes tag during the rework.
> > 
> >   Fixes: 587064b610c7 ("arm64: Add framework for legacy instruction emulation")
> > 
> > Will, are you able to add this retroactively?
> 
> Sadly, this is now buried under some other patches so I'd have to rebase the
> branch if I were to add this and I don't think it's worth it just to add a
> tag.

No worries.  Just thought I'd ask.

> On the plus side, the patch has a Link: tag to this thread, so the
> Fixes tag is retrievable if you're determined enough.
> 
> If somebody wants this for stable, then I suppose they'll have to send
> a backport to make sure it doesn't get missed.

I'll add it to my TODO.

-- 
Lee Jones [李琼斯]
Principal Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
