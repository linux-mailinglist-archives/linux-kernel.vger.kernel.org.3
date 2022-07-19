Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D335A579862
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 13:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235941AbiGSL00 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 07:26:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232548AbiGSL0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 07:26:23 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C992213D62
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:26:20 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id n2so9496180qkk.8
        for <linux-kernel@vger.kernel.org>; Tue, 19 Jul 2022 04:26:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Zj2vSwWLjHhdOghbkFyO2x020jbfnFjdb1H8pyvZ0As=;
        b=kEHeD8Jooc4pSo0l4igOizCdoICj/kVQfN533zGFK13r0+qe2E+aT8IhcwKP1gqOU6
         eLBpxTlVClzXs81a4n/YYbvu3jhV8zIOlW98B3D9PdpOtW/UgnTmf9c113f69lvHi4e4
         5CfQP4HXnTIq/JX3VMiQIT1AHQh4YDAeIQnDg4Fgk5tJzKqXKoXaJfD8teIM8veEqMcw
         Rlvclbp8y3valaTMFJzXDJTbi5d6sfDly9wLxddlXY6rB3dXn8aToq//vJcO5YBVAsTv
         KaLmfIyK3rSOWJUMJJNqXDHa6rehVwM+HY1wZ3AhSmU6tmnUA2tevqtOm9ILKTDxEGr6
         Apow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Zj2vSwWLjHhdOghbkFyO2x020jbfnFjdb1H8pyvZ0As=;
        b=XY2/1ggt38wCKlKKWgF23+rgyAdkBxT8zpG3O8B2mfxvd2sGTirpym1FoXXz/Jg9tx
         vzxBud3+NCXKQDM+Uq6M2zPtJdceA/J9SZayNuj4VFTdhatQGuSCOAWRfgG0OMYFmrrk
         h6u2+AHhSI2YcFmpyfyj0nvriLFDpFU1RFWENic3W+uxUdmdxNmBIRInsC6ckoLX1s04
         tVZlqbV3PavH6BfXNriulfVqvc/lInFAfNO82dPAxDikKcHmDjjObKBrGjFs/xTzTIQU
         TRWxetopsxBXjWLrGiWuXkDNKVyRfhwuXISJWi3Mc6Bsx/ZWEffb+g9zmGmD9Cxj1VKL
         o2WA==
X-Gm-Message-State: AJIora8/av5Ti7l6TUV1szF5R814M+JafMXTbPLEs3/wKKXlA6MrKVJA
        YiZKZhOC0naZsRHQ6QXWt/ot3kk6hES3QDdlG+0=
X-Google-Smtp-Source: AGRyM1vnEAZbtXcRbBKdb0v90eSYy+6qITpc1hAy6u9D25CBQU4p6BZweUCVK4xB+S88cr1OkyCGlKT5qwtcSFW3fhI=
X-Received: by 2002:a37:946:0:b0:6b5:c58a:6ab1 with SMTP id
 67-20020a370946000000b006b5c58a6ab1mr15045126qkj.663.1658229979845; Tue, 19
 Jul 2022 04:26:19 -0700 (PDT)
MIME-Version: 1.0
References: <CABXGCsPRrUoNtO4J8H8aLWRCGGZkwHqtOZV9Edamd2pXVB0ooA@mail.gmail.com>
 <DM5PR12MB24695F88092ADF033A2522E6F18F9@DM5PR12MB2469.namprd12.prod.outlook.com>
 <CAHbf0-GssD3jP4ZjVQeP1Bgu+uHE3OXAEWLeZJA5VdWHzqbBjQ@mail.gmail.com>
In-Reply-To: <CAHbf0-GssD3jP4ZjVQeP1Bgu+uHE3OXAEWLeZJA5VdWHzqbBjQ@mail.gmail.com>
From:   Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date:   Tue, 19 Jul 2022 16:26:09 +0500
Message-ID: <CABXGCsMvJ6JWc3yO8Lv38ZHEHzhhOZUipA4cuc5E=RPSt0WbZQ@mail.gmail.com>
Subject: Re: Command "clinfo" causes BUG: kernel NULL pointer dereference,
 address: 0000000000000008 on driver amdgpu
To:     Mike Lothian <mike@fireburn.co.uk>
Cc:     "Chen, Guchun" <Guchun.Chen@amd.com>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 19, 2022 at 1:40 PM Mike Lothian <mike@fireburn.co.uk> wrote:
>
> I was told that this patch replaces the patch you mentioned
> https://patchwork.freedesktop.org/series/106078/ and it the one
> that'll hopefully land in Linus's tree
>

Great, I confirm that both patches solve the issue.
As I understand the second patch [1] is more right and it should be
land merged 5.19 soon, right?

And since we are talking about clinfo, there is a question.
No one has encountered the problem that on configurations with two
GPUs, it hangs in a cycle since it completely occupies one processor
core. In my case, one GPU is in the RENOIR processor, and the other is
a discrete AMD Radeon 6800M. In the BIOS there is no ability to turn
off the integrated GPU in the processor, so there is no way to check
this configuration with each GPU separately. In the kernel log there
is no error so it is most likely a user space issue , but I am not
sure about it.

clinfo backtrace is here [2]

[1] https://patchwork.freedesktop.org/series/106078/
[2] https://pastebin.com/wv5iGibi

-- 
Best Regards,
Mike Gavrilov.
