Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9621B4E657B
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 15:41:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243204AbiCXOmZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 10:42:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242275AbiCXOmX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 10:42:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503D4AA029
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:40:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D03AF61725
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:40:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DC5EC340F2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 14:40:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648132851;
        bh=mfKsxdtkIpZ9J3FZ0Q9caaL1BwUswSf9HAdn4/BSG1Q=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=PJlndPChWSVjMT+05twdCE+dwAM+ZQXaLSP23KhAv3NtB2xNyRV7rSS7CkrpdvZr3
         EUyC3TMQyw/LMJWW9r1lSlO/SZ6hXnlwI1YI8USiAXkNRLsy0ShiTb6AXTFILwzMtZ
         3WATbKCfzNelgIfNNloixiGhJBDYoVoBnxG8k7Eb3N8vFYgFbx2e8dg1USZEKeDMuI
         Dlw/xsAN5z9FQcQpvmh1DlU1UlvHHRwM1tq6zCGjU+ySO/LyHrPIbmcwQPDRlCo1O4
         YyiwkEm4JhXD2Z1xwf5DmI84AZrRoNh/wvscxBa9K2LPa65dimij9PYIrFxAHPE5/7
         W83VwhzpVGBpw==
Received: by mail-yb1-f180.google.com with SMTP id g24so8765864ybj.13
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 07:40:51 -0700 (PDT)
X-Gm-Message-State: AOAM532qoDrswE9xRyfeRnAhlAjJlDjSKp1DEqyWoRN2A+vN0A9Fzt+0
        CjGkHk9G/f/6cOj2bSisA1d5ZGtnQl1Nw1ChmrM=
X-Google-Smtp-Source: ABdhPJzMDwPU76J+zFlMMPfmXcq9mBNB7As2MWYDWUrV5yygmlG5AQRwIHmkTi901CBjGTBHEkJx+ty4IzS0p2LWTm0=
X-Received: by 2002:a25:d9c5:0:b0:633:8d44:ee75 with SMTP id
 q188-20020a25d9c5000000b006338d44ee75mr4609979ybg.403.1648132850293; Thu, 24
 Mar 2022 07:40:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220324071048.59659-1-jakobkoschel@gmail.com>
In-Reply-To: <20220324071048.59659-1-jakobkoschel@gmail.com>
From:   Oded Gabbay <ogabbay@kernel.org>
Date:   Thu, 24 Mar 2022 16:40:23 +0200
X-Gmail-Original-Message-ID: <CAFCwf11bn0-vyLGnkm_5q729L1F_mNAfcA7VRDgSk7by-h1Kyw@mail.gmail.com>
Message-ID: <CAFCwf11bn0-vyLGnkm_5q729L1F_mNAfcA7VRDgSk7by-h1Kyw@mail.gmail.com>
Subject: Re: [PATCH] habanalabs: replace usage of found with dedicated list
 iterator variable
To:     Jakob Koschel <jakobkoschel@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Ofir Bitton <obitton@habana.ai>,
        Dani Liberman <dliberman@habana.ai>,
        Ohad Sharabi <osharabi@habana.ai>,
        farah kassabri <fkassabri@habana.ai>,
        "Linux-Kernel@Vger. Kernel. Org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 24, 2022 at 9:11 AM Jakob Koschel <jakobkoschel@gmail.com> wrote:
>
> To move the list iterator variable into the list_for_each_entry_*()
> macro in the future it should be avoided to use the list iterator
> variable after the loop body.
>
> To *never* use the list iterator variable after the loop it was
> concluded to use a separate iterator variable instead of a
> found boolean [1].
>
> This removes the need to use a found variable and simply checking if
> the variable was set, can determine if the break/goto was hit.
>
> Link: https://lore.kernel.org/all/CAHk-=wgRr_D8CB-D9Kg-c=EHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/misc/habanalabs/common/command_submission.c | 11 +++++------
>  1 file changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/misc/habanalabs/common/command_submission.c b/drivers/misc/habanalabs/common/command_submission.c
> index 0a4ef13d9ac4..4927749e439c 100644
> --- a/drivers/misc/habanalabs/common/command_submission.c
> +++ b/drivers/misc/habanalabs/common/command_submission.c
> @@ -405,8 +405,7 @@ static void staged_cs_put(struct hl_device *hdev, struct hl_cs *cs)
>
>  static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
>  {
> -       bool next_entry_found = false;
> -       struct hl_cs *next, *first_cs;
> +       struct hl_cs *next = NULL, *iter, *first_cs;
>
>         if (!cs_needs_timeout(cs))
>                 return;
> @@ -441,13 +440,13 @@ static void cs_handle_tdr(struct hl_device *hdev, struct hl_cs *cs)
>         spin_lock(&hdev->cs_mirror_lock);
>
>         /* queue TDR for next CS */
> -       list_for_each_entry(next, &hdev->cs_mirror_list, mirror_node)
> -               if (cs_needs_timeout(next)) {
> -                       next_entry_found = true;
> +       list_for_each_entry(iter, &hdev->cs_mirror_list, mirror_node)
> +               if (cs_needs_timeout(iter)) {
> +                       next = iter;
>                         break;
>                 }
>
> -       if (next_entry_found && !next->tdr_active) {
> +       if (next && !next->tdr_active) {
>                 next->tdr_active = true;
>                 schedule_delayed_work(&next->work_tdr, next->timeout_jiffies);
>         }
>
> base-commit: f443e374ae131c168a065ea1748feac6b2e76613
> --
> 2.25.1
>
This patch is
Reviewed-by: Oded Gabbay <ogabbay@kernel.org>

Applied to -next.

Thanks,
Oded
