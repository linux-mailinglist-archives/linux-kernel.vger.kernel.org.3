Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CABC74D8BC1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 19:23:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243894AbiCNSWv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 14:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243735AbiCNSWp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 14:22:45 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94FAE37AA1
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:21:34 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id g17so28748068lfh.2
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:21:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1oixq+wvjYzthzNZ1BYgX3Lz4ydO/fekdRIrbKTsbhM=;
        b=E+Jc37Qf4L7KuZZ++HrRrbaMHzs7fTmNZ3xJc4VLSrjU6m2rek2V98HZcbgjE/khdf
         FIaSgoeSe2ChD9MeFM2oTHI/U9n+mGoTvZLQRFjQzBZYRspuYdgvATFj/ixr5dPm7d15
         UDXlDF/o6mlPgO6+geol5z3gDquxFJv1VfRj8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1oixq+wvjYzthzNZ1BYgX3Lz4ydO/fekdRIrbKTsbhM=;
        b=Za4XBxpzDepdeCyJo/irkr74COTPkCzazyIhKuEsoSn/GUSlE7tRz5v9BY7UK/ORPQ
         Wla6ayJCKBjPYYrewwYA23m6n4kZooDGRIOnQkd/wtjtR53Mp+BaJpXYWUMaYN60emFg
         PjUp1gZDa8uEKL3VNQ7J0ra5UBo4psROOKubmxdZbJEj1YHwcfbcEV6MpUuvUtqRzVOh
         C4C6Y54CR/Ip3lyapu/eGRyzCw9sRvcEgkpP8wKdmtjbBKNrOMvbOvK0NtvViP8TYBvn
         WoBEgd6/WiDhcTp2n8dxYibzGdvayFx+TTRyhUxlxgzjxqbq3dtkhsWUEVdwl3lafWwU
         bRyA==
X-Gm-Message-State: AOAM531PxYjW/1Ir0wSCfPCqzotLexzOEWlLF5gPcMUmjcdqAHhqjzzD
        6w3AIO2evW96oBuLJfLZURrwok5RBvxzl6vP
X-Google-Smtp-Source: ABdhPJw+jD89KdDhx8945/zguF3Zv9GzQ9R8PrMUST90E+gT6YPTwiI/I1io0pWzRQCfjOBkxJ4sZg==
X-Received: by 2002:a05:6512:401f:b0:448:429f:186a with SMTP id br31-20020a056512401f00b00448429f186amr14239344lfb.414.1647282086776;
        Mon, 14 Mar 2022 11:21:26 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id s6-20020ac25fa6000000b0044313e88020sm3402561lfe.202.2022.03.14.11.21.25
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Mar 2022 11:21:25 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id c15so6592027ljr.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 11:21:25 -0700 (PDT)
X-Received: by 2002:a2e:9904:0:b0:247:ec95:fdee with SMTP id
 v4-20020a2e9904000000b00247ec95fdeemr14708357lji.291.1647282085278; Mon, 14
 Mar 2022 11:21:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220314154605.11498-1-lukas.bulwahn@gmail.com>
In-Reply-To: <20220314154605.11498-1-lukas.bulwahn@gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 14 Mar 2022 11:21:08 -0700
X-Gmail-Original-Message-ID: <CAHk-=wju=Lx3b5NQ9KntQ=0JvvXcJfpjt_nZOMWV43OWwPrUQw@mail.gmail.com>
Message-ID: <CAHk-=wju=Lx3b5NQ9KntQ=0JvvXcJfpjt_nZOMWV43OWwPrUQw@mail.gmail.com>
Subject: Re: [PATCH] aio: drop needless assignment in aio_read()
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc:     Benjamin LaHaise <bcrl@kvack.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>, linux-aio@kvack.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        kernel-janitors@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 14, 2022 at 8:46 AM Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:
>
> Drop this needless assignment in aio_read().
>
> No functional change. No change in resulting object code.

Ack, that assignment is indeed dead. As such, compilers will remove it
and it doesn't "hurt", but it is pointless and possibly confusing.

> I cc'ed Linus as he is the author of the referred commit, but I expect
> that this clean-up just goes the usual way to Al Viro and then in some
> git pull to Linus.

Sounds good to me.

                   Linus
