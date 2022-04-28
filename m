Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E071F51284A
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Apr 2022 02:48:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238615AbiD1AvP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 20:51:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231276AbiD1AvN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 20:51:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94ABF5DBEB
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:48:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B0F9B82AD5
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:47:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14F09C385AF
        for <linux-kernel@vger.kernel.org>; Thu, 28 Apr 2022 00:47:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651106878;
        bh=z76S75gHWRBeo2WeeqouXCUPQvpWiCldWKzSEf9wLvs=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=rCTodqKoEkhbHbnskTQlzdGc/rZXFY8qeiYBjKg1OmVyhRW7U3FNT9+nkuJzoPyEu
         9A5S/PGhPcNnm3csoR39/CPR09VntQDU14diH8Nws++a4CmouiEeqWjTyElosZW8Cn
         zDDPbCc5tWAOGOxTI8f2RiePHMkPkIS1dM2G/lCpkULT7QhEeN2IHhjop46NbQMaBG
         DmU5OtPgeunF+Dcs0iVcKXvrVozbuccHSODPPznjitqgEcaxx8jB0050rw8CLFI8l6
         No9cKe3WGfcIlYdUiGPmLnCE8BeZ7KtaF27Fn6WXFzZWXr0RzU6lkNfeDEWT7HabqZ
         YkgKhhjbrGyVA==
Received: by mail-wr1-f44.google.com with SMTP id i5so4612619wrc.13
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 17:47:57 -0700 (PDT)
X-Gm-Message-State: AOAM5313IVv1plKNf1Av3O/0gNrc4bD+n35FrN5xUtBkpwdgJOUQEZc2
        lmGnmFonh8bjIP304MpE7KwmN/OxK929l40KCHI=
X-Google-Smtp-Source: ABdhPJxGzxOVO1oQ28XErTn5grU1C68oVDLlC3tEYTQrXeg72jCtnscD+8a6dcuZ/lwywZE6Nylt+PUo7p5opvy2woU=
X-Received: by 2002:a5d:47ab:0:b0:20a:7f8a:ec69 with SMTP id
 11-20020a5d47ab000000b0020a7f8aec69mr24366063wrb.504.1651106876322; Wed, 27
 Apr 2022 17:47:56 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64e7:0:0:0:0:0 with HTTP; Wed, 27 Apr 2022 17:47:55
 -0700 (PDT)
In-Reply-To: <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
References: <da20d32b-5185-f40b-48b8-2986922d8b25@stargateuniverse.net> <CAHk-=wihuvzVTozzNLZT=uFzJH6uM7ZNKN7fYVpm0v2KkY6Jxg@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 28 Apr 2022 09:47:55 +0900
X-Gmail-Original-Message-ID: <CAKYAXd89Ypc09ZkuZT+w3TDscpB8_=wHY=JpZJb7LY1LDg+7Uw@mail.gmail.com>
Message-ID: <CAKYAXd89Ypc09ZkuZT+w3TDscpB8_=wHY=JpZJb7LY1LDg+7Uw@mail.gmail.com>
Subject: Re: NTFS3 driver is orphan already. What we do?
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Kari Argillander <kari.argillander@stargateuniverse.net>,
        Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
        ntfs3@lists.linux.dev, "Theodore Ts'o" <tytso@mit.edu>,
        Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Eric Biggers <ebiggers@kernel.org>,
        "Darrick J. Wong" <djwong@kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

2022-04-28 2:47 GMT+09:00, Linus Torvalds <torvalds@linux-foundation.org>:
> [ Sad state of affairs mostly edited out ]
>
> On Tue, Apr 26, 2022 at 2:22 AM Kari Argillander
> <kari.argillander@stargateuniverse.net> wrote:
>>
>> I also did suggest that I could co maintain this driver to take burden
>> from
>> Konstantin, but haven't got any replay.
>
> If you are willing to maintain it (and maybe find other like-minded
> people to help you), I think that would certainly be a thing to try.
I can help him.
>
> And if we can find *nobody* that ends up caring and maintaining, then
> I guess we should remove it, rather than end up with *two* effectively
> unmaintained copies of NTFS drivers.
And I'm currently working write support on read-only NTFS(fs/ntfs)
with the goal of being released in a few months. And after that, I am
planning to start working fsck in ntfsprogs in ntfs-3g to solve the
current lack of utility issue.

Thanks!
>
> Not that two unmaintained filesystems are much worse than one :-p
>
>            Linus
>
