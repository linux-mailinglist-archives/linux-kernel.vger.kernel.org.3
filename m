Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18FDA4B2084
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 09:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244559AbiBKIqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 03:46:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:37628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348131AbiBKIqV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 03:46:21 -0500
Received: from mail-vs1-xe2c.google.com (mail-vs1-xe2c.google.com [IPv6:2607:f8b0:4864:20::e2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56228E80;
        Fri, 11 Feb 2022 00:46:20 -0800 (PST)
Received: by mail-vs1-xe2c.google.com with SMTP id m24so9408228vsp.7;
        Fri, 11 Feb 2022 00:46:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EEi9rjZri+XFBAgqsZ4Dh190lYm+ILIASE0FNRwP8Bc=;
        b=cFM3Bo93sb4bZ5QWlYpqdSzufSzk0QZyX40jtGtPY8m7paLI35o0hPq9I1jrJy0Wdp
         iwXU11s96NYMpWRFcxaZOpOc+ZxQ0mzu47f0b9h6rHqrhxNgFoDfstTf8sqqeu1u66Fo
         hYpFaktZhhi3XifvracAqeotZx87nLuOeEzW79zXtHRbZl9EUYxvE6WVMd4TWE6WaWlV
         +xcCNM8T1OQpCU7utzg9IvVpiuY83nqcXawNIA1+DZyYfc0lWevHHsLNlS0dVOoJAhHs
         wlc7F7lpbGHwP79ZlDlcKPAdQmEkxuVkp8Pve0DOVvEm9ffy6dNgXz2aAMl6kQSFHdzE
         2LUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EEi9rjZri+XFBAgqsZ4Dh190lYm+ILIASE0FNRwP8Bc=;
        b=I7tJ7VAx41jO1VC3BW/+xF1JaaqZV94gnsay457QIVjnk3HsuLN1gTaMxvErgrR+ye
         KbvIFi9UTDVCbP2HB6Pt3M9Bet+NH8DULdRtXQXIXxF/ZJEPoSg19gsO/Elh2Invk/7p
         XBgdEFpmezEvdfDSVzPKbupFOZnSOM8mgDlXgVAFULGS7nDelYrH2YyA+Lic+eXnHpGb
         jcg+tcj9/78+p1LT9B2XMGierg8xB78Sd2wZhrKT6iaQY86f/CuauTqpqkCgzGtMGZe1
         xnFbvBe1sb+bDzgpeO/hsJANrGPbcpwXqYb0v83rQvJe9jIpsIcAvWk/1+IdKnOL1l/N
         Kwaw==
X-Gm-Message-State: AOAM532l+xoq9Vuv+//dg6HvwUxWGVdYI1bnIV+v+IPo4zIO2xR2tC3b
        G7YtOLjSbWOH6FZKnjl3gJ1DjX8H2IO6gLVZIQ==
X-Google-Smtp-Source: ABdhPJwS3UPkWHoBkGQeoYjm2Fjxk5btkaW/VYsdRqv4tooP2EqAOa4W8SISuMt7dDyz+x3iDwqnPL/QwZ0/R/eV61I=
X-Received: by 2002:a05:6102:1611:: with SMTP id cu17mr212809vsb.28.1644569179482;
 Fri, 11 Feb 2022 00:46:19 -0800 (PST)
MIME-Version: 1.0
References: <20220211001345.3429572-1-gch981213@gmail.com>
In-Reply-To: <20220211001345.3429572-1-gch981213@gmail.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Fri, 11 Feb 2022 08:46:08 +0000
Message-ID: <CALjTZva7fKOzG7u4QYhZ+3ZGN2p5DV+fLh6WbFLFtSSfjKQ-ug@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ralink: mt7621: do memory detection on KSEG1
To:     Chuanhong Guo <gch981213@gmail.com>
Cc:     linux-mips@vger.kernel.org,
        Ilya Lipnitskiy <ilya.lipnitskiy@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Guo,

On Fri, 11 Feb 2022 at 00:14, Chuanhong Guo <gch981213@gmail.com> wrote:
>
> It's reported that current memory detection code occasionally detects
> larger memory under some bootloaders.
> Current memory detection code tests whether address space wraps around
> on KSEG0, which is unreliable because it's cached.
>
> Rewrite memory size detection to perform the same test on KSEG1 instead.
> While at it, this patch also does the following two things:
> 1. use a fixed pattern instead of a random function pointer as the magic
>    value.
> 2. add an additional memory write and a second comparison as part of the
>    test to prevent possible smaller memory detection result due to
>    leftover values in memory.

[patch snipped]

No issues here, and it does seem to have fixed the RAM size detection
on my Redmi AC2100. It's always been a very sporadic failure here, so
I'll be keeping an eye on it to see if there are any further
misdetections. :)
In any case, feel free to add my

Tested-by: Rui Salvaterra <rsalvaterra@gmail.com>

Thanks,
Rui
