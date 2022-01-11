Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A39F48BB24
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 00:01:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346700AbiAKXBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jan 2022 18:01:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233525AbiAKXBk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jan 2022 18:01:40 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8DB8C06173F
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:01:39 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id u21so2428456edd.5
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:01:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=b8xGwb6bxapB0UXlu0Xx56F1dpfAwDFJuxyurOCX0cA=;
        b=JGMJ95jpmcSfIGK4Ik68I9qPG4WOvyoHle2cDu5D+sBMPOclHTWYJhYgCVJNpTZL0O
         UKEWG6fogcYshkz/N0H89Q/tUVZ2ETmWSNLDIuCAT8ILRHNJ6nf+JuXgIX3c5YHjt9b/
         CxZl6Pg/fswspoktujTtplKUdN2ZRtQ/sEw5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=b8xGwb6bxapB0UXlu0Xx56F1dpfAwDFJuxyurOCX0cA=;
        b=aZzS6aoeuWz8+ViMPJkVg8MZiq3s4hG0UmaUxe06cUUNJi2dd8wez9PStRsG+OKd2X
         kY5F043D8xfU1dPdjQBQ9mSFwF/U5CfuKtQuvk8xJAb0J0lkbtMrAdm8wu9277w6CQyG
         I5Re2hs3ElD1cI3AISww5dDADbnWuF86PwPICuSTOHLski5d85SIIXdtgZlmUOcMrK7/
         eg/iVEKkPXdMn9pYUGJfsFC4lt7areZncTuJ5qo9eUWnQVQzrbtncbp8PdI0W58TgTPK
         YvCCQh6Mg8quKy8c6/heaG8FeYikxRF9k/DWk4ndAoty9aq7ghuE0/tr2pHr51oLmDVF
         aAyA==
X-Gm-Message-State: AOAM531ean2Z93wDXhMuKcvbir7zeMgay/D/nl2c+sFt+v6mHXbXgkhf
        y41tLF5LJS3EWxMBBvxGLKaQvZAu9EWIloPq+8g=
X-Google-Smtp-Source: ABdhPJxwOjW+Ca7oF70vNIalIljN5k47ecrPNlHACXMLs+XIZIQYw25GJsVlVPasJtE6AwTz7jCSEA==
X-Received: by 2002:a17:907:608d:: with SMTP id ht13mr5241235ejc.97.1641942098227;
        Tue, 11 Jan 2022 15:01:38 -0800 (PST)
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com. [209.85.128.50])
        by smtp.gmail.com with ESMTPSA id j4sm5549329edk.64.2022.01.11.15.01.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 15:01:37 -0800 (PST)
Received: by mail-wm1-f50.google.com with SMTP id q141-20020a1ca793000000b00347b48dfb53so506217wme.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jan 2022 15:01:37 -0800 (PST)
X-Received: by 2002:a05:600c:4f49:: with SMTP id m9mr4251032wmq.8.1641942097293;
 Tue, 11 Jan 2022 15:01:37 -0800 (PST)
MIME-Version: 1.0
References: <41707c7dd9705b8bb04a6d56aee349ff17c4af50.camel@linux.ibm.com>
 <CAHk-=wi6O9cpRxWEnYMXjeMis47456UrVCksV6K_WCgjUmYEXQ@mail.gmail.com> <e645dbdcd74699ff92242c51f743cffe0ea3ae14.camel@linux.ibm.com>
In-Reply-To: <e645dbdcd74699ff92242c51f743cffe0ea3ae14.camel@linux.ibm.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Jan 2022 15:01:21 -0800
X-Gmail-Original-Message-ID: <CAHk-=wgFGZp3YFb4xd9UErmnJYhOzOKZVpdyV959e_3=_d8iww@mail.gmail.com>
Message-ID: <CAHk-=wgFGZp3YFb4xd9UErmnJYhOzOKZVpdyV959e_3=_d8iww@mail.gmail.com>
Subject: Re: [GIT PULL] integrity subsystem updates for v5.17
To:     Mimi Zohar <zohar@linux.ibm.com>
Cc:     linux-integrity <linux-integrity@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 11, 2022 at 2:55 PM Mimi Zohar <zohar@linux.ibm.com> wrote:
>
> Yes, I received the Nitrokey Start and followed the maintainer-pgp-
> guide (and Nitrokey) directions at the time.  It was hard finding a
> working gpg server, but I finally found one, at least I thought I found
> one.

You probably _did_ find a working pgp server, but with all the pgp
poisoning, the replication of the keys doesn't tend to work very well
any more.

So if I don't then happen to use the same server, I won't get the key updates.

Oh well. It's not like pgp wasn't always a UI disaster. It's just that
key replication _used_ to work fairly well.

               Linus
