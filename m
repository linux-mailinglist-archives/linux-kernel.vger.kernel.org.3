Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA7ED4B3812
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Feb 2022 21:56:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231875AbiBLUym (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Feb 2022 15:54:42 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231812AbiBLUyl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Feb 2022 15:54:41 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33C84606EB
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:54:37 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id z19so23022039lfq.13
        for <linux-kernel@vger.kernel.org>; Sat, 12 Feb 2022 12:54:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MU4w9d2rupYSgCDtLi7bbVuyryCwYta+2fP1NcZ044U=;
        b=hGI5UaHW/EgIgUQfpg4uAnSAnLbO7TfeKbaENqzh2uyGdS4QLZcl6nnh5PPLH9c0Vc
         iPcELz2wwegKV5dONCvC7jSndmEIg5T5/4nlgo30XlfKwMF/aUeP+5gqRs6/KVKgs8cU
         jJBOVO+HLD5UM3FlG+KActZzUDUK4EUFW7ZeXICtb/XzhuEfMgqXejypRMkdedC1aBU9
         x6yb2qLp+HjhImhUeUFS4jYfrp9zb99n7FPFWomY/Gy8ovxfuxIwNT8PyB2fm6V2hsRq
         ufU+tLQXlmXPXuCwJHroclPxqc92+nqUgxKx7LhmDdg0nN8JxIk5TTrpwq1kIxe9Ne4+
         pkAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MU4w9d2rupYSgCDtLi7bbVuyryCwYta+2fP1NcZ044U=;
        b=SqjNDgkfvTdt0SpmH0HOcm3LGl5pJ9WNAKS/5p4PngBOPPB3DDkEA6m/AMn88H44s/
         olbCiHcn6r4Sj4zt6WirmhiRkrkq1+/f2r4nKR/LmNV5M9jAAxS5MNveojQTIf1prtlE
         YN+bmdzFhQHcyolUF3Coufq6CTZhV9cLuPCAhKL11mq8Wm8Ure8IF3uIAK3I0pnKhIN2
         BzfDmJZ8wJughR4QCqTDge+hKR6EFokEqgEda5lYLGrlmZUhngXiPz4OwrKPUrAjhuSW
         OVmuZoJAFi4nR1Gib4KKP2DN3+ROsX4rScflGBlQ0QzuJMSArtPLTnpueMKrCuHK54eA
         0ehw==
X-Gm-Message-State: AOAM533IjG/qJ9csVYoo93yAMmXenTUSDMWWq/YosuFfdwh6vwOW4bAJ
        5efbpzNvBTACKWccYHIQwxByQ2y9miVXxd8/URo=
X-Google-Smtp-Source: ABdhPJxeMx1A0Rav1mH9g0gcBUjt1Lg7H2o0/+3JBT9gOSe39G8U6PzgB66irhveF9m12dlhvfzWC6Rv1Y67JR/BocU=
X-Received: by 2002:a05:6512:c09:: with SMTP id z9mr5246125lfu.669.1644699275297;
 Sat, 12 Feb 2022 12:54:35 -0800 (PST)
MIME-Version: 1.0
References: <20220212200649.541061-1-matthewwaltzis@gmail.com> <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220212204851.GA1660889@dhcp-10-100-145-180.wdc.com>
From:   Matt Waltz <matthewwaltzis@gmail.com>
Date:   Sat, 12 Feb 2022 13:53:59 -0700
Message-ID: <CABwBYcb0XhomznNOV62uH3Yo1J7XjHowuhF3H36owXtiVSp8JQ@mail.gmail.com>
Subject: Re: [PATCH] nvme-pci: fix prp list allocation
To:     Keith Busch <kbusch@kernel.org>
Cc:     Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
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

That is the wrong part of the specification, describing the PRP entries,
not the list pointer. The relevant portion of the spec (2.0a figure
109 page 129) says:

    If this entry is not the first PRP entry in the command or a
    PRP List pointer in a command, then the Offset portion of this
    field shall be cleared to 0h


On Sat, Feb 12, 2022 at 1:48 PM Keith Busch <kbusch@kernel.org> wrote:
>
> On Sat, Feb 12, 2022 at 01:06:49PM -0700, Matthew Waltz wrote:
> > Fixes kernel block errors originating from the hard-coded 256-byte
> > alignment of dma_pool_create(). The NVMe specification requires a PRP
> > List PBAO offset field of 0h, i.e. a PRP List must be aligned to the
> > configured 4096-byte memory page size.
>
> That is not correct. The spec (2.0a section 4.1.1) says:
>
>    The first PRP List entry [...] shall be qword aligned and may also
>    have a non-zero offset within the memory page.
