Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D5614FBFC0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 17:00:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347596AbiDKPDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 11:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347630AbiDKPCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 11:02:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D092422299;
        Mon, 11 Apr 2022 08:00:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6091761530;
        Mon, 11 Apr 2022 15:00:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD324C385A4;
        Mon, 11 Apr 2022 15:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649689225;
        bh=WQgiPWw15vZto8Oz4YQkJk3Gl2iuHt80f6Y58X7n7co=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=WlLeKH9ng0yCZvpA3Et0fAqBe5kAgqcQwXe7UKuqut42rDdVgVCfcNjlqzjgYHei+
         C20cmatbGojQapZUjpDeFOEijhnpcHNSMZnQOxZc8jehKDi/gp+eXd+t2B6t9re9he
         ZcC2XiAVUFQridhcvTxShgjHRERKHyOMRxc0U97XHF2E/QC5+qMeJjx2YcMP4VoFb6
         uhNIsaVL7rLa48QHVtmMksDGttg4kwySmeVQs5YpDw2mWwQmD6zULx4fJpDt08W6Zu
         MABLvJTzOtS8ImU/jlYohoqlUZk+WIzu4eq/k6lM8z9dcgj3wc0N0i2zTZw/GJjKwD
         R0vdXURSU5aGw==
Date:   Mon, 11 Apr 2022 17:00:22 +0200 (CEST)
From:   Jiri Kosina <jikos@kernel.org>
To:     Josh Kilmer <srjek2@gmail.com>
cc:     linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Subject: Re: [PATCH] hid: asus: ROG NKey: Ignore portion of 0x5a report
In-Reply-To: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com>
Message-ID: <nycvar.YFH.7.76.2204111658520.30217@cbobk.fhfr.pm>
References: <CAMXW6=97T1tzT=FSyzZN6jBAKgzUDOjqRoH-FMAPLHk1gsD=mA@mail.gmail.com>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Mar 2022, Josh Kilmer wrote:

> On an Asus G513QY, of the 5 bytes in a 0x5a report, only the first byte
> is a meaningful keycode. The other bytes are zeroed out or hold garbage
> from the last packet sent to the keyboard.
> 
> This patch fixes up the report descriptor for this event so that the
> general hid code will only process 1 byte for keycodes, avoiding
> spurious key events and unmapped Asus vendor usagepage code warnings.
> 
> Signed-off-by: Josh Kilmer <srjek2@gmail.com>

Hi Josh,

thanks for the patch.

A couple remarks:

> ---
>  drivers/hid/hid-asus.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
> index 08c9a9a60ae4..73fb9fc0701c 100644
> --- a/drivers/hid/hid-asus.c
> +++ b/drivers/hid/hid-asus.c
> @@ -1212,6 +1212,14 @@ static __u8 *asus_report_fixup(struct
> hid_device *hdev, __u8 *rdesc,
>         rdesc = new_rdesc;
>     }
> 
> +   if (drvdata->quirks & QUIRK_ROG_NKEY_KEYBOARD &&
> +           *rsize == 331 && rdesc[190] == 0x85 && rdesc[191] == 0x5a &&
> +           rdesc[204] == 0x95 && rdesc[205] == 0x05) {
> +       hid_info(hdev, "Fixing up Asus N-KEY keyb report descriptor\n");
> +       // On the 0x5A input report, change count from 5 to 1
> +       rdesc[205] = 0x01;
> +   }

- your mail client whitespace-damaged the patch, so it can't be applied; 
  could you please fix that and resend?

- the comment above is (a) using non-standard kernel commenting style, and 
  quite honestly (b) seems a little bit superfluous

Could you please fix that up and resend?

Thanks,

-- 
Jiri Kosina
SUSE Labs

