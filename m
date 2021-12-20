Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6054547A3EE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 04:28:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237307AbhLTD2w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 22:28:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbhLTD2v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 22:28:51 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10440C061574;
        Sun, 19 Dec 2021 19:28:51 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id x21so10316591lfa.5;
        Sun, 19 Dec 2021 19:28:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fRcTObY/+9A4hixoekg+KAnW7I8Bz5CnTH8eOyUtBR8=;
        b=llE/Xtta9p8PDPP2HjgM4E2Fdmz/7/XHPUSymjov1e3QjqtwtDcQHM1zauXoPq2o3E
         Uh5NBEB5UlM2cw6vu4gU8kHtlcFZzceFQ2JuH0psRovlJSJU5zIXLE7Ai4nb0fvIDSoL
         NQwxtw7jHRxvUkNAIxhurHOhZd41+mOpcHzintP82eG9pc3OEydxz+XJAAwYHT40amR3
         kX7YRkc/Lap7oSZ+t0EyEh4bLIqlEwb7FCKDk0qUO0GMXUzq0WRJpdL+yiAbB+MIk8h2
         WQLP7hiXfZDpljJq3jUGi8nTGZt9GMoxtcEquDmE2K1dGsLBnHEIlaw2NUkrXhYm8m+K
         TMMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fRcTObY/+9A4hixoekg+KAnW7I8Bz5CnTH8eOyUtBR8=;
        b=LVuTZfFqfW2APKC9lqhYaYsJjWhGZrHakQzSe0UXBE6nCHK3vNXOT6pyGI2ITdUYu3
         uT2crPa/iKRjC40kQt9RNCCpmKAx2z/Y3P691RDK1a/94ziLoN8fVyYZZfWuHmGBslCQ
         BGIFTDpC+I44ugSUyEScQTsmJp+dKXqD8gylQUHeiAoSoB0V/aSa6/eHtyF3N/YmwTXb
         ZJ/mPzmzGU/jrcDzMX8CL+zgbdAKIxfCnDQMr2wx8OBE2PHLuT0VlFnpxyAekbesgVPH
         QnoN9N+BF5c4vM65r/25GTLGVdG52w/muIflG474DR9Q9mFDhtNqe3oxbSIVpGZ6wIvt
         SWWw==
X-Gm-Message-State: AOAM533JzogozXziwaD38yjvnsal3Q7mNAyP6k0B+FU/7Q/o2JsXymfS
        HQuFfMLoe1oa0v8pUH0tO5gVsD0Roxn8x6ovVx5PUz81
X-Google-Smtp-Source: ABdhPJx2BwtN5YBznRrSXCI2e7hzjlnUteNBIeZR4uHN5mmQ2tL3lJA8R5TRygaRR22/4cLFWEr0EEQ9p+Rr5MGpvMo=
X-Received: by 2002:a05:6512:a8d:: with SMTP id m13mr13938249lfu.638.1639970929272;
 Sun, 19 Dec 2021 19:28:49 -0800 (PST)
MIME-Version: 1.0
References: <20211212115506.180629-1-gnurou@gmail.com> <9b20ae5d-be8f-59dd-3136-2a9f7ce216e9@suse.com>
 <CAAVeFu+sLzNUztnW4Vyr6ukCyjxTwCT-L4Y2xEWsRx=CPuarPw@mail.gmail.com> <c4b4aa34-12d9-7000-6398-d94a7ebffdfc@suse.com>
In-Reply-To: <c4b4aa34-12d9-7000-6398-d94a7ebffdfc@suse.com>
From:   Alexandre Courbot <gnurou@gmail.com>
Date:   Mon, 20 Dec 2021 12:28:36 +0900
Message-ID: <CAAVeFuJ+kSW9KNOwa_bTzbbeZ=-LfnvL4MR2hDqCsykkdqkKLQ@mail.gmail.com>
Subject: Re: [usb-storage] Re: [PATCH] usb: storage: do not use UAS with
 Logitec LGB-4BNHUC
To:     Oliver Neukum <oneukum@suse.com>
Cc:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 15, 2021 at 11:03 PM Oliver Neukum <oneukum@suse.com> wrote:
>
>
> On 15.12.21 12:41, Alexandre Courbot wrote:
> > Unfortunately I am not familiar with the storage subsystem so I'm not
> > sure which quirks would be good candidates to try, would you have
> > suggestions? As for the command, reproduction is rather random and I
> > did not keep traces of all instances.
>
> Hi,
>
>
> could you try "fgkm" ?

Trying with this and will narrow down if it looks stable. Please
expect a few weeks before the (hopefully more refined) patch.

Cheers,
Alex.
