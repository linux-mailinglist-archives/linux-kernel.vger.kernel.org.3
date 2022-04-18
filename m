Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62556505F40
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 23:19:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235494AbiDRVVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 17:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbiDRVVk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 17:21:40 -0400
Received: from mail.skyhub.de (mail.skyhub.de [5.9.137.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E242CE1E;
        Mon, 18 Apr 2022 14:19:00 -0700 (PDT)
Received: from zn.tnic (p200300ea971b58fe329c23fffea6a903.dip0.t-ipconnect.de [IPv6:2003:ea:971b:58fe:329c:23ff:fea6:a903])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 267451EC02DD;
        Mon, 18 Apr 2022 23:18:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1650316735;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:in-reply-to:in-reply-to:  references:references;
        bh=ZdHaIKGQNbKcpxAG33l2mCMPzkhskvV/79vXGyONBdE=;
        b=rCgkJFGu63MD/P5IchutEIumzk9av7Ovsy5n6J3yiw5ivGsYabu4sjELTQXaLyVX+Dmxr+
        oKsP5rpUtkoJMP9+0iWy+lvVCzAqJZxTcP3VcAlPFJqYM7jPMZKPQzp4rjcXnNDgoVRZHY
        nhHNXq3J9+FW5961h+HhQbbOvmZKRI4=
Date:   Mon, 18 Apr 2022 23:18:54 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     Tom Lendacky <thomas.lendacky@amd.com>
Cc:     Dionna Amalie Glaze <dionnaglaze@google.com>,
        linux-kernel@vger.kernel.org, linux-tip-commits@vger.kernel.org,
        Brijesh Singh <brijesh.singh@amd.com>, x86@kernel.org
Subject: Re: [tip: x86/sev] virt: Add SEV-SNP guest driver
Message-ID: <Yl3Vvhw+NKfC503u@zn.tnic>
References: <20220307213356.2797205-44-brijesh.singh@amd.com>
 <164940891958.389.8256762641375131456.tip-bot2@tip-bot2>
 <CAAH4kHZpwbJSE6tDz-3ZzMH75rmgDYvBQ5_gLteXRmEk54yORQ@mail.gmail.com>
 <Yl2cffonOopK6JrM@zn.tnic>
 <18e9197a-9e8d-a06f-3a55-bb548e649258@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <18e9197a-9e8d-a06f-3a55-bb548e649258@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 18, 2022 at 12:40:11PM -0500, Tom Lendacky wrote:
> The driver name is used when registering the driver in
> snp_init_platform_device() and isn't really referenced after that. The
> module name is sevguest.ko, while the device name ends up being
> /dev/sev-guest.
> 
> All that really matters is the device name that is exposed to user space.
> But if we want things to match, then, yes, we can change the name that is
> used in arch/x86/kernel/sev.c and drivers/virt/coco/sevguest/sevguest.c
> to "sev-guest" if that works. Do you want the module name to also be
> sev-guest.ko?

Just to ack this on the ML after our IRC discussion: yeah, let's keep
the common driver name sev-guest in order to avoid confusion. Other
functionality like SEV-ES or only SEV can still go in there, if needed,
but the name can remain.

Thx.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
