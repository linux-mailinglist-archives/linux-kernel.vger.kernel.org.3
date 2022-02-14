Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AED34B50F1
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:03:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353820AbiBNND3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:03:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:51002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349874AbiBNND1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:03:27 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A23674C7A4
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:03:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F7476145C
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:03:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0FB7C340E9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 13:03:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644843798;
        bh=aYi+WuTKinDGu6rJHTWCY9MMsW30L++vnHKXTv6N/7k=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=Js2KJ8uR+WjuUUisj1EBog/SomMJdWFDgc81vtBlWIFkRN6I0N24c25OSwSc0mWeW
         bVMIkUu80yvQqbEpgHU8v1x64S69uXWffSVoyylT9ECC9sN3aliDYgjey0a8a2g8g/
         M3hA/LwpjIony87lF/AAMGEqh4A2+q/176JxkKD2bCqsAUPA3pOvzUMXiHgO6jACK/
         DsYZu6E/eOuZy3gjMt4tzgl8A8fNC1xZhpSxWoJsPaxO9QbR8vwYkrE10gGUR8QBau
         /Rszf8nKSJUhr0A8QjY682wcG7NBQY8C4IhgGyHlHvIIp3yr2E6BQgXOHl0AbBN7/V
         iCem6MEwF23BQ==
Received: by mail-yb1-f169.google.com with SMTP id c6so45873944ybk.3
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:03:18 -0800 (PST)
X-Gm-Message-State: AOAM530rFumX36Y14yfcFbpj3t4OmkBO2vS5mkXF6DcwMOhoCO5GKNwO
        c02mS/rCQdcf0zZR51Y6YX5rbXzYr3EqxL/sn3Q=
X-Google-Smtp-Source: ABdhPJzhAoAJwPZSAwevB+toA63MV1dToPPq7bQhjEOifWG8aDOj/YiWn5INbL1kJK9AeaM60Nn1ZgjDhOi0xuePWAM=
X-Received: by 2002:a81:a888:: with SMTP id f130mr13961966ywh.46.1644843797800;
 Mon, 14 Feb 2022 05:03:17 -0800 (PST)
MIME-Version: 1.0
References: <20220214081210.3999831-1-ogabbay@kernel.org> <20220214081210.3999831-2-ogabbay@kernel.org>
 <20220214103829.1319-1-hdanton@sina.com>
In-Reply-To: <20220214103829.1319-1-hdanton@sina.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Mon, 14 Feb 2022 15:02:51 +0200
X-Gmail-Original-Message-ID: <CAFCwf11CZ_DrhUdxO1PpX_v=2i8GS_Vzd4DrERdbtZm-_V+FrA@mail.gmail.com>
Message-ID: <CAFCwf11CZ_DrhUdxO1PpX_v=2i8GS_Vzd4DrERdbtZm-_V+FrA@mail.gmail.com>
Subject: Re: [PATCH 2/2] habanalabs: allow user to set allocation page size
To:     Hillf Danton <hdanton@sina.com>
Cc:     Ohad Sharabi <osharabi@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 12:48 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Mon, 14 Feb 2022 10:12:10 +0200 Ohad Sharabi wrote:
> >
> >  struct hl_mem_in {
> >       union {
> > -             /* HL_MEM_OP_ALLOC- allocate device memory */
> > +             /**
> > +              * structure for device memory allocation (used with the HL_MEM_OP_ALLOC op)
> > +              * @mem_size: memory size to allocate
> > +              * @page_size: page size to use on allocation. when the value is 0 the default page
> > +              *             size will be taken.
> > +              */
>
> Nit, the 80-column-char format is prfered.
Maybe it is preferred, but afaik it is now allowed to use 100-chars,
and checkpatch no longer shouts about
it, so I don't see the harm.
>
> Wonder how to get the available page sizes in userspace?
We will add an opcode to our INFO ioctl to return the available page sizes.
The user will need to query this at the beginning of the application run.


>
> >               struct {
> > -                     /* Size to alloc */
> >                       __u64 mem_size;
> > +                     __u64 page_size;
> >               } alloc;
> >
> > -             /* HL_MEM_OP_FREE - free device memory */
> > +             /**
> > +              * structure for free-ing device memory (used with the HL_MEM_OP_FREE op)
> > +              * @handle: handle returned from HL_MEM_OP_ALLOC
>
> Nit, add a seperate cleanup patch for changes with no link to page size.
Yes, correct, I will split this up.

Thanks,
Oded
>
> > +              */
> >               struct {
> > -                     /* Handle returned from HL_MEM_OP_ALLOC */
> >                       __u64 handle;
> >               } free;
> >
> > -             /* HL_MEM_OP_MAP - map device memory */
> > +             /**
> > +              * structure for mapping device memory (used with the HL_MEM_OP_MAP op)
> > +              * @hint_addr: requested virtual address of mapped memory.
> > +              *             the driver will try to map the requested region to this hint
> > +              *             address, as long as the address is valid and not already mapped.
> > +              *             the user should check the returned address of the IOCTL to make
> > +              *             sure he got the hint address.
> > +              *             passing 0 here means that the driver will choose the address itself.
> > +              * @handle: handle returned from HL_MEM_OP_ALLOC.
> > +              */
> >               struct {
> > -                     /*
> > -                      * Requested virtual address of mapped memory.
> > -                      * The driver will try to map the requested region to
> > -                      * this hint address, as long as the address is valid
> > -                      * and not already mapped. The user should check the
> > -                      * returned address of the IOCTL to make sure he got
> > -                      * the hint address. Passing 0 here means that the
> > -                      * driver will choose the address itself.
> > -                      */
> >                       __u64 hint_addr;
> > -                     /* Handle returned from HL_MEM_OP_ALLOC */
> >                       __u64 handle;
> >               } map_device;
