Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BEDC50EFB4
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 06:19:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239859AbiDZEWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 00:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229885AbiDZEWX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 00:22:23 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 112FE31909
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:19:17 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2f7d621d1caso58349287b3.11
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 21:19:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=W0GcaF8LUNtQ/VcGNv7yf0Gg7VDi4U2EzhXVUK76yEg=;
        b=njLi7DoIAgYOwTX3faFgIDrku+P0ZmnRNcTGq7I3qUSmwUMsnLbEb1+i5FJRtHG9KP
         b0KQjHU59aK6VFLy9n9bNXp9O9BSYLxERSEWkZq87GAuP+ybEUAo6umNBMiDtOxXds3A
         7LbA5TzBtmJJOKPKs5uKdHVwPg40ILTmfxDdgywrZl4Lpuc/X9xu7iDjCpbyRmfEc+DO
         /pmGYrqaaKtd6LkU+HsqXVEw4pxLgxns7YDexb3YDBxPDt6/ogBbSrXah8C3lCJ3QPcV
         7VuuIbquM7j+6FzFmxzOM/8Fvms4UH4V7sxjrdUfCRfbBn4/M3kzXMhQ4g2lLUY9Kxrb
         p5yQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=W0GcaF8LUNtQ/VcGNv7yf0Gg7VDi4U2EzhXVUK76yEg=;
        b=qASUG9tEGYhJXwONwDn7zn6anexvWUof9qkTGsPeyOeMGacfRuZLMRPPd74XE9Qv2r
         wFp7sm8YYVJY9bbYpJJPx+UJ/JcZKLw0ujSduQ6lZPDIR5ZRW6ZZupvT6dw5rMD6tZEQ
         pz0BC8tqX+yLb2YfAwEltksAlraJ99e6EgsJDQhj4kEMaFkHvdCLBULSjXvUM7yabS54
         2JUkMIQw1wvFiZfjxlc8XIqN9Hk34KvU4b0AalztRT+t4dy3xKDNaN9SCQ4NFNn2y5JO
         p8U18fz1nNzeikCxBPc0RYk0uLRy9SPMkRM8fMpEgZbXff4DO487kRqzIXpEVRM9fGtS
         gbXg==
X-Gm-Message-State: AOAM532M8qXibAGjxmkbeZsL5gYliZ3OOXrBR4oSqOB9Tr9A4RGbqjZP
        +yCi4lx7qalZq/YxHkYE0HAEF8iRO4LgmHQ00q8Riw==
X-Google-Smtp-Source: ABdhPJwqBv79DUWRQoYAXWxj7RmGgqEUHzGXj7uhZygu0z3BYwVgDlEdfTSZGsYX1lKCipPV7DtAYkndeVbuxoy/T/k=
X-Received: by 2002:a81:7b05:0:b0:2f4:e45a:b06e with SMTP id
 w5-20020a817b05000000b002f4e45ab06emr19622038ywc.458.1650946756147; Mon, 25
 Apr 2022 21:19:16 -0700 (PDT)
MIME-Version: 1.0
References: <20220422013215.2301793-1-tweek@google.com> <YmK9lhEENKFnr6sd@bombadil.infradead.org>
In-Reply-To: <YmK9lhEENKFnr6sd@bombadil.infradead.org>
From:   =?UTF-8?Q?Thi=C3=A9baud_Weksteen?= <tweek@google.com>
Date:   Tue, 26 Apr 2022 14:18:59 +1000
Message-ID: <CA+zpnLfS4nTjXYYgE_BNcjQPF1vWynOe_118YgTZa9S5G9dVdg@mail.gmail.com>
Subject: Re: [PATCH v2] firmware_loader: use kernel credentials when reading firmware
To:     Luis Chamberlain <mcgrof@kernel.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Vander Stoep <jeffv@google.com>,
        Saravana Kannan <saravanak@google.com>,
        Alistair Delva <adelva@google.com>,
        Adam Shih <adamshih@google.com>,
        SElinux list <selinux@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
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

> Can you elaborate on the last sentence? It's unclear how what you
> describe is used exactly to allow driver to use direct filesystem
> firmware loading.

I realize my use of the word "device" here was unfortunate. I meant devices as
Android devices/systems. This may have contributed to the confusion.

Previously, Android systems were not setting up the firmware_class.path
command line argument. It means that the userspace fallback was always
kicking-in when a driver called request_firmware. This was handled by the
ueventd process on Android, which is generally given access to all firmware
files.

Now that more devices are setting up firmware_class.path, the call to
request_firmware will end up using kernel_read_file_from_path_initns, which
would have used the current process credentials.

>
> And, given the feedback from Android it would seem this is a fix
> which likely may be desirable to backport to some stable kernels?

Yes, that's right.

Thanks
