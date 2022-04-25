Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4E350E559
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 18:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243295AbiDYQR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 12:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243288AbiDYQR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 12:17:26 -0400
Received: from mail-io1-xd2b.google.com (mail-io1-xd2b.google.com [IPv6:2607:f8b0:4864:20::d2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F7311F611
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:14:20 -0700 (PDT)
Received: by mail-io1-xd2b.google.com with SMTP id y85so16403683iof.3
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 09:14:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ssvMxEnSf8Abrb4Q0sbcMxRw0VW47mziY0ir9WsjUiY=;
        b=rdSIv8F4IyCtcjNP1ZDImRtkXJpc90T6m82UbT8VJmvEHYwwMqS1YO8ja2JYfmut8q
         zgvazqVDXSKt4NozVdkoITXWFxnXxAgWlNsIw7GWWXcVuW+zGb88UZp/hPyIVOCLkV3U
         28UAN3emaodZP32790gYfTY4E/+wom8k3qDa/NZKfoM0hfTqk1QvYN2Ff5/QuXAtnLdR
         DxWDYe8QxfYphIsAWsyWzr0t9ZOY8xzf3S5QCFuM+u93x85QKF4JFu3iqyLiPahSEGU0
         UR/jXdyPM3K6Eq4sr4DGkq/qq6YUsc46pvRmlotDetdTOpI4nwAd0WoTwg63anAY7rHa
         SgbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ssvMxEnSf8Abrb4Q0sbcMxRw0VW47mziY0ir9WsjUiY=;
        b=LOxEFfb8C2gySvSnJvF6Ox4F+goOSS9RTgJsBiBBSHrQidmqKkoxfklMs/R6ftOfHC
         MXhE44OLqeRx7LCLyQHZFKx907WjGjv/Wsq1drE7uRhMvyT+OepbeKo3Ds3NH0fvQD6E
         hpN5kVmycpLagDyykYVMJUEBXG3LWuZ3kaEfvduPR4TepnpJALj/gRrlw1q77aU+5AGc
         Rx1FZI1OBE9lDXcoAaMp3XMzoTrEJQQh+bcRa7xCdHeboM+YU4RwPWIZAaYIE1zPGC04
         K7oRbNqkr1/je27Hnafb/OlLjSWJmWPYp8PAOH51Wy4vOe8IYs/dSVxDfQ/PRk5g3bWB
         7z8w==
X-Gm-Message-State: AOAM5301E8uqsx+9TWejKDVvpPRB89pNr7gGLpk94vAkQ+S9/tyODS8Z
        gzTJI7UlGFdL7DYchemUzInh/cS6JjRu0HPcMU/FiA==
X-Google-Smtp-Source: ABdhPJwHwhHCFix6yfeXZwbsDXszZ/FXhdzTN89sEtbPiY/UyQK2PM4Z1FoeFd47bS78B8+uV6hrWZr0zMsEM/SejxY=
X-Received: by 2002:a05:6602:2e0d:b0:64f:8bfd:a83 with SMTP id
 o13-20020a0566022e0d00b0064f8bfd0a83mr7321644iow.200.1650903259819; Mon, 25
 Apr 2022 09:14:19 -0700 (PDT)
MIME-Version: 1.0
References: <20220415001321.252848-1-jmeurin@google.com> <20220421234244.2172003-1-jmeurin@google.com>
 <20220425104201.173e65fa@xps13>
In-Reply-To: <20220425104201.173e65fa@xps13>
From:   Jean-Marc Eurin <jmeurin@google.com>
Date:   Mon, 25 Apr 2022 09:14:08 -0700
Message-ID: <CAL3wywVS0EyBNQ_vp+TDdxO1=x4PgTZoyzGJ8-5qXzhCd0uOcw@mail.gmail.com>
Subject: Re: [PATCH v4 0/3] mtd: mtdoops: Add timestamp to the dumped oops header.
To:     Miquel Raynal <miquel.raynal@bootlin.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Miquel,


On Mon, Apr 25, 2022 at 1:42 AM Miquel Raynal <miquel.raynal@bootlin.com> wrote:
>
> Hi Jean-Marc,
>
> jmeurin@google.com wrote on Thu, 21 Apr 2022 16:42:41 -0700:
>
> > The current header consists of 2 32-bit values which makes it difficult
> > and error prone to expand. This creates a structure for the header.
> >
> > Some oops only have time relative to boot, this adds an absolute timestamp.
> >
> > Changelog since v3:
> >   Fix the printk format for sizeof to %zu.
> >
> > Changelog since v2:
> > - Add a timestamp to the header.
> >
> > Changelog since v1:
> > - Create a header structure to simplify code.
> > - Patches in series.
> > - Patch prefix.
> >
> > Jean-Marc Eurin (3):
> >   mtd: mtdoops: Fix the size of the header read buffer.
> >   mtd: mtdoops: Create a header structure for the saved mtdoops.
> >   mtd: mtdoops: Add a timestamp to the mtdoops header.
>
> Looks like the last patch was not sent to the list?
>

I'm not sure what happened.  I've just sent it and then noticed that
the mail threading is wrong.  Let me know if you want me to resend the
full thread.

I'm really sorry about that :-( and thanks for all your help.

Jean-Marc
