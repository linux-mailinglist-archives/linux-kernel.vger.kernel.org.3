Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AB0E2486A76
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jan 2022 20:27:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243307AbiAFT1p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jan 2022 14:27:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243233AbiAFT1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jan 2022 14:27:45 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1E5BC061245
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jan 2022 11:27:44 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id c71so1847689edf.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jan 2022 11:27:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLU+4pXKXLqbKm6pb0YwpMhniA0RhW86iVzjkY/V/yU=;
        b=OR0e+UsSNT7ozFA7ZLEtZnBWZsn8uNW2OFZwrpOOBSjNQhIQ7bAc2yTekhocTSyQgN
         r+GTr6VIUQSDhtqEhs21F6JPZz6OyW7Is0QyBdvgiKo2cbAelC7SEttqLsaeK2oONGgA
         K4uYMU9/b9XB2uxycgZ9YT99bF/xbUnsasTMFR8sdZAWxq+OgJR5BnGQdFordTfseTuc
         dRmewWmXkMzQ+eSIvwKtq6mei2B6oq4pf7WlqAsvIJfnRp4sM7JuCty5eeFvHJmqeERk
         teTNwA2XMD3JWvnr96YUV/HM8CYI0j3VbVyyefFv90s43yruvrP2JPqy0JhNNuS7Bd9l
         nuSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLU+4pXKXLqbKm6pb0YwpMhniA0RhW86iVzjkY/V/yU=;
        b=ueBgSya7fge/zq4n61FZAZ3UyvhtqxpMFNDLWUkQQw/OfhkQrjoTPTMyAKbdsPbcl0
         K843ZKobO7wWrC4iSjvBOtDr58PuTdY7wAgaacLT5zRVigk85pFoTqYF6NXwLH7IGj3u
         hOQ1RWVFMn6BTFCrSr6QFNI6l4a/Y0y7Znjh2xHQJC1gr4xUALq3WlAF3hUJz9j9RBGO
         RajZi8OPNFgE7LbEqwHRJuxZpJg9Ae/Nuq2x8upsoEb7JWeMH8a9mCqz1OBG1XzeryM1
         qDqErJgY8fENSVgIOy0Ykje44kT0s9hKqU4UHcFGl4y7VOfTN/regjCE3LCxNs5VSb6Z
         dUsA==
X-Gm-Message-State: AOAM531CHCqiKzvLgMtAsdVo3HP6ZFigANGleA0rw5tvucUvg/I4kkIr
        08FxbFFBlYJGwy6ptBQY8iCuEeRD5i+YagRUIrzvP44T94Q=
X-Google-Smtp-Source: ABdhPJyHu9mjyJqIsE15eieR2GKUAnQrHM2DBhDius93D+UNYMgPzTbkuErO9hI24l5i8UEmxS2/4SBlKWeQUagIoWk=
X-Received: by 2002:a05:6402:354d:: with SMTP id f13mr51460949edd.135.1641497263269;
 Thu, 06 Jan 2022 11:27:43 -0800 (PST)
MIME-Version: 1.0
References: <20220106175019.3116389-1-festevam@gmail.com> <Ydc2EHf5f12w4YcW@sirena.org.uk>
In-Reply-To: <Ydc2EHf5f12w4YcW@sirena.org.uk>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 6 Jan 2022 16:27:32 -0300
Message-ID: <CAOMZO5Czbr=vuvZdqc6+odAQv0M-LJEQVz6uke8OXnoG6wLqwA@mail.gmail.com>
Subject: Re: [PATCH v2] regmap: debugfs: Free debugfs_name buffer after usage
To:     Mark Brown <broonie@kernel.org>
Cc:     Matthias Schiffer <matthias.schiffer@ew.tq-group.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

On Thu, Jan 6, 2022 at 3:33 PM Mark Brown <broonie@kernel.org> wrote:

> OK, but what's the logic here?  The name is getting thrown away here but

I did more debugging and this is what I found:
The 'debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent
'regmap' already present!' message
happens since commit cffa4b2122f5 ("regmap: debugfs: Fix a memory leak
when calling regmap_attach_dev").

Prior to this commit map->debugfs_name would always be allocated via
kasprintf().

After this commit, the allocation only happens when !map->debugfs_name.

This matches with my observations:

- The first allocation for dummy-iomuxc-gpr@20e0000 works as
map->debugfs_name is NULL.
- The second time map->debugfs_name is not NULL, so there is no allocation
via kasprintf(), and the map->debugfs_name uses the 'old' entry from
the previous buffer.

This causes the directory name to be duplicated and fails to be created.

That's why clearing map->debugfs_name causes a new kasprintf()
allocation and restores the correct behavior.

Prior to  cffa4b2122f5 ("regmap: debugfs: Fix a memory leak when
calling regmap_attach_dev"):

# mount -t debugfs none /sys/kernel/debug/
# cat /sys/kernel/debug/regmap/dummy-iomuxc-gpr@20e0000/registers
00: 00000000
04: 48611005
08: 0000000c
0c: 01e00000
10: f00000cf
14: 0000000e
18: 007f007f
1c: 007f007f
20: fffd4000
24: 00000000
28: 00003800
2c: 00000000
30: 0f004490
34: 0593e4a4
# cat /sys/kernel/debug/regmap/20e0000.pinctrl-gpr/registers
00: 00000000
04: 48611005
08: 0000000c
0c: 01e00000
10: f00000cf
14: 00000007
18: 007f007f
1c: 007f007f
20: fffd4000
24: 00000000
28: 00003800
2c: 00000000
30: 0f004490
34: 0593e4a4

After commit cffa4b2122f5 ("regmap: debugfs: Fix a memory leak when
calling regmap_attach_dev):

The 'debugfs: Directory 'dummy-iomuxc-gpr@20e0000' with parent
'regmap' already present!' message is seen.

# cat /sys/kernel/debug/regmap/20e0000.pinctrl-gpr/registers
cat: can't open
'/sys/kernel/debug/regmap/20e0000.pinctrl-gpr/registers': No such file
or directory

# cat /sys/kernel/debug/regmap/dummy-iomuxc-gpr@20e0000/registers
00: 00000000
04: 48611005
08: 0000000c
0c: 01e00000
10: f00000cf
14: 00000009
18: 007f007f
1c: 007f007f
20: fffd4000
24: 00000000
28: 00003800
2c: 00000000
30: 0f004490
34: 0593e4a4

> clearly there is a file still so I'm not seeing how anything is going to
> clean that file up.  That means that if the device gets freed we'll end
> up with the old debugfs file hanging around pointing at nothing.  Like I
> said (originally in response to Matthias' patch but pasted in this
> thread as well):
>
> | (we should probably clean up the one with no device but that's not what
> | your commit does).  I think what you need to look at here is that we
>
> The use after free extends beyond just the filename, we're also loosing
> track of the already created file, which does seem to be an existing
> bug.  To be more explicit this means we need a call to regmap_debugfs_exit()
> which will clean up all the existing debugfs stuff before we loose
> references to it.

As shown above, I don't see the '
/sys/kernel/debug/regmap/20e0000.pinctrl-gpr' directory being created,
so there is nothing to clean.

Where exactly would you like me to call regmap_debugfs_exit()?

Thanks
