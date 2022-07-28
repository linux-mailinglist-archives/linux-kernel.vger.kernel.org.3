Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2878584182
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 16:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232573AbiG1Of1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 10:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232525AbiG1OfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 10:35:06 -0400
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC726627A
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:34:14 -0700 (PDT)
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 17FC23F11F
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 14:34:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1659018853;
        bh=smAmLQDqaAhXYtvdpeSgEu24V4rDJU+98olXFW6DsY0=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=QXAt1CJF2EncS3zzwCWphaId3zC1GCQzRylnxNWCJgprHfPesmUztoSXIa6YQrZyP
         2U2cjXyivXwrxfZqwUgQBwnxjMftuR6b0ysmFyY/CABXpqjbAkbnJG5+eUGtOTEbao
         phWhvqps66Sr/xuxF+Avdv0cMOg6Z1DD+q+Z8CLwh9VFJ/ElblETxb5zoa9uJkOsOD
         IlfQ+c3wK73jA65BRNAt4h66bPn41dtQ+MN1QdaU77hpBOPv1Pep2ixAjMqxv98hE6
         iIBN3sbPPX9MIEmcz9iI90o0NcrEiAXUaG7/z4Twee9C7z802hjrs935ugtUfsMgZ1
         lZwGmZmbLt/KA==
Received: by mail-io1-f71.google.com with SMTP id v5-20020a5d9405000000b0067c98e0011dso594795ion.1
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 07:34:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=smAmLQDqaAhXYtvdpeSgEu24V4rDJU+98olXFW6DsY0=;
        b=mMeWOvtF0oieSbcLykIRLWb1iK1RpieUobt/gK9CzzognzTOT3k91fX85OFYtojkU7
         +JANTo2nOTRfYl5/IR/x0bHPawoqgKpFQ9SfVd9wdBUt1ux9OFMMms+1+bkktKEet9SD
         nCX4EHF8fgeHnwU9sxbd+nm3w4RFwJzcKEV4XhjoVx1FewV+dGkD6OjyM0yg342geOrb
         FhnTfCgZmUw0GylnQy7u8D1gFVup1g6a/sHLIeWxnRwSj2Vxy0Vx2RZbNIee0z9a8Etu
         63vVPsQ01c+d0ehlaUuoIKTns7t87IAefGwJHEUYP9utSyuYcvjZXXqRSvogloWa7Pi6
         3rbw==
X-Gm-Message-State: AJIora+6xe2w1SFo7gWGHdABmNXf8sTWZNr9cSj4ZnkaA1J8nMfRFYFb
        bVZYQ3VKlC7xvJEKjKBoKuL/xmBPHkynGNFP5YA30GabHD2oZVGYsxdIPy2IPOwKlz6vhRs+3e6
        khED6JCcxyGOK9WASrSTTO2HgvkV1EwZijp8TDoto9zTfSJf2WRLfXyKmDQ==
X-Received: by 2002:a05:6638:1312:b0:341:40a1:7e20 with SMTP id r18-20020a056638131200b0034140a17e20mr10730103jad.228.1659018851755;
        Thu, 28 Jul 2022 07:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sO8Inr1oA7DW5DfOY7SZGAvnWP2w936SHR2YGe8sa8XqC9EHtPsYxNlwAzfgb53552GDvTByb6QG/2yAh7A8k=
X-Received: by 2002:a05:6638:1312:b0:341:40a1:7e20 with SMTP id
 r18-20020a056638131200b0034140a17e20mr10730093jad.228.1659018851534; Thu, 28
 Jul 2022 07:34:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220728122602.2500509-1-cascardo@canonical.com> <YuKCpLOLeDOI7GII@zn.tnic>
In-Reply-To: <YuKCpLOLeDOI7GII@zn.tnic>
From:   Dimitri John Ledkov <dimitri.ledkov@canonical.com>
Date:   Thu, 28 Jul 2022 15:33:35 +0100
Message-ID: <CADWks+aosM99jv9WwLvFo3LPEnsqts+2bJPzMnRqJX70qz51cg@mail.gmail.com>
Subject: Re: [PATCH] x86/bugs: Do not enable IBPB at firmware entry when IBPB
 is not available
To:     Borislav Petkov <bp@alien8.de>
Cc:     Thadeu Lima de Souza Cascardo <cascardo@canonical.com>,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Peter Zijlstra <peterz@infradead.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 at 13:35, Borislav Petkov <bp@alien8.de> wrote:
>
> drop stable@
>
> On Thu, Jul 28, 2022 at 09:26:02AM -0300, Thadeu Lima de Souza Cascardo wrote:
> > Some cloud hypervisors do not provide IBPB on very recent CPU processors,
> > including AMD processors affected by Retbleed.
>
> Which hypervisors are those? How relevant is that use case?
>
> How do I reproduce it here?

Azure public cloud (so it is Azure custom hyper-v hypervisor) these
instance types https://docs.microsoft.com/en-us/azure/virtual-machines/dav4-dasv4-series
booted as gen2 (UEFI boot, so Dasv4-series instance types). A
particular one is chosen in our automated testing, and always fails. I
believe more than one instance type from that series of instance types
is affected.

I haven't tested but
https://docs.microsoft.com/en-us/azure/virtual-machines/dasv5-dadsv5-series
are probably affected too.

It's a class of popular-ish instance types, meaning that it could
potentially take out a class of users who due to availability,
performance, and/or pricing choose to run their workloads on those
instance types. Potentially causing them a major outage of being
unable to boot and/or reboot.

-- 
okurrr,

Dimitri
