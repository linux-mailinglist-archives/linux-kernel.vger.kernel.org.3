Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A93014D4FF4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 18:09:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244325AbiCJRKo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 12:10:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbiCJRKh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 12:10:37 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E323115C18D
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:09:35 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id 15-20020a17090a098f00b001bef0376d5cso5788942pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 09:09:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20210112.gappssmtp.com; s=20210112;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=CXJIZNeGajqwp6jaZzleHdYhvxqijXnXTAupo8pKN9M=;
        b=lkIwxy6irebs+k/g2EEyfbXiasFCFgahK3OeU5fC2Ii0Y5QhEn2BSvvhMpLkQlo92x
         o7AI6Rt8Y7ZaHZS3TUKcz2wg/vR6Jb7fSn2JNwzdKOwq/I94ZLftFHUPTTAz2G/BHTFa
         z5Gnmchvcv3bT8PRLZ85jHkLetABtlxc229LHQVxqD8S0KAuV3bD7BgnITLcjewJxVbe
         BhAa7IPXGTPVWRa4DV+z0xzCIabyAxPU478EEd/8GFu2hhrpkyY4O+/KT+GxWupFSjQF
         3k7VOB5klVfc7wBJh7/6JRh9FmrP8aS8iFz+JWLZ6uKBSEbcwftUXPae7H25xv6Xngn7
         uauA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=CXJIZNeGajqwp6jaZzleHdYhvxqijXnXTAupo8pKN9M=;
        b=J8TAHaukx+3gjhh2ap+bq706/xciZeDkcOL9FTxp/PnV2vsxjGeK4OlNjC/KfvqjWX
         4Ssc7cz2TGBPFMSDORBACyN8zqrLCWTWzR10jiQespGMdB5VnCcITw8HcCIkvJHaSFFG
         fd6BKIDLu1lkugLmB5D1IHpuJLNaaNgo2ol4GWzZkkq3YpuJqv6286d2oq/3V1/zZ9lZ
         vKkAwfgJcA7nDZldGRjumQT+//9EtEitjHClkvuewOCbrgAssMxwSPVAiicJLtv2qyfo
         JLCMyXGY32aENW1xE2s4Wvz5c5t78OgC40zVO2bkxACdUOuMFo98JXWFYRtfgV3C1zJY
         IaIg==
X-Gm-Message-State: AOAM533oPhY/HIEEdkbWw9g1+4g/XRlAM2JAKBw0vuGXIXrugFv3Tyiz
        tNXFdPspSiEExN1/zRXB+q0hGw==
X-Google-Smtp-Source: ABdhPJyVpypYQN9Wk4w5jvTCoAvJF9ERDsONHaoBVGcGWK0xcagj5xUzmVuqgSTOM+V37tN6snUXVw==
X-Received: by 2002:a17:902:c40a:b0:151:a792:71f2 with SMTP id k10-20020a170902c40a00b00151a79271f2mr6129701plk.36.1646932175179;
        Thu, 10 Mar 2022 09:09:35 -0800 (PST)
Received: from localhost ([12.3.194.138])
        by smtp.gmail.com with ESMTPSA id js15-20020a17090b148f00b001bfc8614b93sm3926516pjb.1.2022.03.10.09.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:09:34 -0800 (PST)
Date:   Thu, 10 Mar 2022 09:09:34 -0800 (PST)
X-Google-Original-Date: Thu, 10 Mar 2022 09:08:29 PST (-0800)
Subject:     Re: [PATCH] riscv: Work to remove kernel dependence on the M-extension
In-Reply-To: <CAK8P3a3mzax-OiaxBcxM_RgKNsd6N8HW0odRmw38u2jKE5aYaQ@mail.gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>, michael@michaelkloos.com,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     Arnd Bergmann <arnd@arndb.de>
Message-ID: <mhng-3e1f2147-7acb-4dd7-8fce-41ec72def1d7@palmer-ri-x1c9>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 09 Mar 2022 23:54:17 PST (-0800), Arnd Bergmann wrote:
> On Thu, Mar 10, 2022 at 8:34 AM Palmer Dabbelt <palmer@dabbelt.com> wrote:
>> On Wed, 09 Mar 2022 02:02:27 PST (-0800), Arnd Bergmann wrote:
>> > On Wed, Mar 9, 2022 at 6:28 AM Michael T. Kloos <michael@michaelkloos.com> wrote:
>>
>> That'd be wonderful, but unfortunately we're trending the other way --
>> we're at the point where "words in the specification have meaning" is
>> controversial, so trying to talk about which flavors of the
>> specification are standard is just meaningless.  I obviously hope that
>> gets sorted out, as we've clearly been pointed straight off a cliff for
>> a while now, but LMKL isn't the place to have that discussion.  We've
>> all seen this before, nobody needs to be convinced this leads to a mess.
>>
>> Until we get to the point where "I wrote 'RISC-V' on that potato I found
>> in my couch" can be conclusively determined not compliant with the spec,
>> it's just silly to try and talk about what is.
>
> I would argue that codifying the required extensions through kernel source

The problem here isn't the required extensions, it's that vendors can 
claim to implement an extension on hardware that doesn't exhibit any of 
the behavior the specification expresses that systems with those 
extensions must have.  The D1 is a very concrete example of this.

> code is much stronger than interpreting a specification. Ideally the
> specification
> would match what the kernel requires, but it's not the end of the world if
> the kernel ends up making decisions that are different: If Linux can do
> runtime detection of non-M, non-A or pre-standard extensions and handle
> them correctly without a notable performance impact, it can do that. Or
> Linux could end up requiring things that are normally there but not
> in the scope of the spec.
>
> Regardless of who determines what the compatible subset is, I think there
> is value in splitting out Kconfig options that prevent booting on normal
> RV64GC machines (XIP, NOMMU, 32-bit, ...). This would probably
> not include the non-M option, as long as a non-M kernel works as
> expected on CPUs with the M instructions.

I get the value to having an option hiding these things, as users might 
shoot themselves in the foot.  I sent a patch, not sure it's exactly 
what we want but at least it's something concrete to discuss.
