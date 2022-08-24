Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6AE59FFE1
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 18:56:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239207AbiHXQ4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 12:56:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236806AbiHXQ4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 12:56:07 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB22B3DBE0;
        Wed, 24 Aug 2022 09:56:05 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id f3so5933751ilq.5;
        Wed, 24 Aug 2022 09:56:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=oLveuyfvOYuaw06GYMOw+ZeCVcoEAdv4UZbUS0ysFDA=;
        b=c9jHP3iw+q84+psn4+imRWQPyMMtCA6zdmTsSCISMsQqnhcjJ/3BpC1yliL+PlRJ61
         pLwTpVpFl8yPGrIzRomDZRgQMQCit8yGOxkrCQdF+ykfniNv3aLbvMVk2JyyqeYlVkzN
         oj8MxEoIW0P4t7YKHR9DSjyDRr7t9/uyB1cGQIiLO4UH5RilwJlbuu9JoPEYHi2GIGcD
         4IywnpJWzOF9IVfMKtmhW+6z+tzuGGTjOq4l5pyBnWrXVxej6fxD7kRfzp5MpMfFbhiS
         KV2kBWSHdyGk0/NS9NkM/BjfYm8ENDr7Smb57yDSHZjo7EvKLzznajJuokCBAdbmGQHf
         wHhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=oLveuyfvOYuaw06GYMOw+ZeCVcoEAdv4UZbUS0ysFDA=;
        b=ZhDMlu/303u8yJ9wdweNDUBNt3Ik7/+uHAm4UV5go0cEPOv5DoVqts2hbj6J9wjyaX
         Yc+wXdHxInQbnrl6oJ7fP0jmTLcNAVGCXn6oGeUt35nLyHt5dgx3oLC9o2w6HQ2xZasc
         TsvJQRkF8ON6uYnUp6Ew9lJLm6l5k/Lap5cOnS7bVjEZLwMiSwU5ZFBAJEsCZuLT2c9k
         EBBlUen/Xa8F9Kt+ZlcqWBxQUvho7/oyiJHU9JYxHwzygHyXSdoZF0jFAfpEQCeQUkTi
         0XP6fYO86WgEDObrauZO/OAkg12M6L2jh3iSrU8DT2r0RytpJgqIOJIiYyHuKxMiR7Un
         LBEQ==
X-Gm-Message-State: ACgBeo1EGIMWFsZIxf9AnY4vkDJNxDOS3rVW+Rpal3PgiBvA6oB5mTuk
        GAhSDjHe6t/QKTEs5bXWWa/n5VZj8I1/mTn1J8c=
X-Google-Smtp-Source: AA6agR7LGjMyFyYuYrqaRzu4thdoenEA2+VIzc7P/z85FxocSwqE5bDd1jdDVHDQvzDQSnH3zoFCHADJGOI7kiSypjI=
X-Received: by 2002:a05:6e02:20c1:b0:2e9:f747:ad54 with SMTP id
 1-20020a056e0220c100b002e9f747ad54mr2777742ilq.144.1661360165111; Wed, 24 Aug
 2022 09:56:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220824130702.10912-1-khalid.masum.92@gmail.com> <YwY4cVdB3tVVMIqJ@rowland.harvard.edu>
In-Reply-To: <YwY4cVdB3tVVMIqJ@rowland.harvard.edu>
From:   Khalid Masum <khalid.masum.92@gmail.com>
Date:   Wed, 24 Aug 2022 22:55:54 +0600
Message-ID: <CAABMjtFjt-j2AUiqWZf-vK9LL0067VCHY=oLha6e0k-Dt6Sbgg@mail.gmail.com>
Subject: Re: [PATCH] usb: host: Use helper function to get endpoint
To:     Alan Stern <stern@rowland.harvard.edu>
Cc:     linux-usb@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexey Sheplyakov <asheplyakov@basealt.ru>,
        Weitao Wang <WeitaoWang-oc@zhaoxin.com>,
        linux-kernel-mentees 
        <linux-kernel-mentees@lists.linuxfoundation.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 24, 2022 at 8:40 PM Alan Stern <stern@rowland.harvard.edu> wrote:
>
> On Wed, Aug 24, 2022 at 07:07:02PM +0600, Khalid Masum wrote:
>
>         ep = &udev->ep0;
>
> with no need to check for NULL.

Thanks, I shall send a v2 with this change.
> Alan Stern

-- Khalid Masum
