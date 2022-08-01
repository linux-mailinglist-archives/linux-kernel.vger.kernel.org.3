Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32865586F1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 18:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232452AbiHAQ7w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 12:59:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiHAQ7t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 12:59:49 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD4430F7F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 09:59:48 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id kb8so6923710ejc.4
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:59:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=2ohzoTnMg+RTfFmKzF5lv5JZKTlVsrqOLhSFHUgYUD4=;
        b=dVzDLxfI55aRRjxNZ3XGHDb5p13AsxgHUrT4vS5IGadbAgN6BmaVEBuvmzRIpFh8Xb
         aJ4DXzaJgYirnTQagBuqTV+CNZHVNNnti5A79N9jRQc2OcK/ElJgmgsuiCmtUI4qoSZv
         EaSiQXYE62EY7N/MqnxidCWrFDEvdfmo3ZAfw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=2ohzoTnMg+RTfFmKzF5lv5JZKTlVsrqOLhSFHUgYUD4=;
        b=dsCIYPCDxUlLy1+vRRK4sa3yKiGOJOcmWNiDXsWmzaJ5t5CYJmiBD0BFbIPg9+Vg/b
         uuTJ8p5nLl4k+Q5N372b58NFeub+yimxWCkYvXDh9MzQ4ChGentzDIGKU1f2LvbvtOql
         fmOXH+pPuKQpZxLFKu/iIJ8tK3jeybEdP14rDzXNjc6okQp/I8FW5DXc1+zUkEGH28KX
         AMj1FXrPw72/GyNKd8fYk/51jWgWj4hQRzxnJv0UFcCNFJ0XvdkvhqeAPed0RGy+PVwk
         rsb3GLU80lUAfiHJNKJnliwunZDosh0AWKNG3bcnDen2pX3vBEaVTie0BpR5MmfG221L
         1oVA==
X-Gm-Message-State: ACgBeo3wOXZQW+ch+wp/Qlsd72yafIgsqPfXeX8nt8nixcYcC3ovignc
        Y3Je/js8fjLHRgvdWzRGcnjhKmc27krE1rFRVmg=
X-Google-Smtp-Source: AA6agR4k80qVBvrp8gMVzBC+0ZNVY/PzNFJI4/iWW0W9rx+HQXD9Vyzsxxz6zPDVvSrdhJZuxnc66Q==
X-Received: by 2002:a17:907:2ce8:b0:730:567c:9649 with SMTP id hz8-20020a1709072ce800b00730567c9649mr7904809ejc.503.1659373187228;
        Mon, 01 Aug 2022 09:59:47 -0700 (PDT)
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com. [209.85.221.44])
        by smtp.gmail.com with ESMTPSA id ec15-20020a0564020d4f00b0043c83ac66e3sm7007506edb.92.2022.08.01.09.59.46
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Aug 2022 09:59:46 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id p10so10696654wru.8
        for <linux-kernel@vger.kernel.org>; Mon, 01 Aug 2022 09:59:46 -0700 (PDT)
X-Received: by 2002:a5d:638b:0:b0:220:6e1a:8794 with SMTP id
 p11-20020a5d638b000000b002206e1a8794mr189022wru.193.1659373186348; Mon, 01
 Aug 2022 09:59:46 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wgrz5BBk=rCz7W28Fj_o02s0Xi0OEQ3H1uQgOdFvHgx0w@mail.gmail.com>
 <YugEzRwHDjUd+Qta@agluck-desk3.sc.intel.com>
In-Reply-To: <YugEzRwHDjUd+Qta@agluck-desk3.sc.intel.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 1 Aug 2022 09:59:30 -0700
X-Gmail-Original-Message-ID: <CAHk-=wi5fBCz1gT+9+AK9tH+hWkJD_jL2=OejHZrAnEPBeSt7Q@mail.gmail.com>
Message-ID: <CAHk-=wi5fBCz1gT+9+AK9tH+hWkJD_jL2=OejHZrAnEPBeSt7Q@mail.gmail.com>
Subject: Re: Linux 5.19
To:     Tony Luck <tony.luck@intel.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 1, 2022 at 9:52 AM Tony Luck <tony.luck@intel.com> wrote:
>
> On Sun, Jul 31, 2022 at 02:43:03PM -0700, Linus Torvalds wrote:
> > (*) I'll likely call it 6.0 since I'm starting to worry about getting
> > confused by big numbers again.
>
> Are you confused by gradually smaller "big numbers"? Last major release
> update went:
>
>         v4.19 v4.20 v5.0

You are only proving my point.  The 4.0 transition was v3.19 .. v4.0.

"Confusion" isn't some sudden-onset "hit-by-a-freight-train" thing.

It slowly creeps up on you, like a ninja sloth on the hunt.

              Linus
