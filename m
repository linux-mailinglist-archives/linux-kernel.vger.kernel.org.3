Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E35E5A8975
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 01:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232690AbiHaXQm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 19:16:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232804AbiHaXQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 19:16:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05676B10;
        Wed, 31 Aug 2022 16:15:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B092261CA0;
        Wed, 31 Aug 2022 23:15:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C49AC43470;
        Wed, 31 Aug 2022 23:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661987731;
        bh=t5oLcB72prq3YZIUNqEPd41rqmg1WT6c81QZ9d4pP+M=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=JJdmPXPkEb5KAKQK58RkRFZHp1vv/m8fBIUnjEflCbguv06gYYw1DSVpEI4f0D7LM
         LXXQQgdNq4P0FbaVyafoFtrcaIQLnD/++c5UNeRYMmc4t73njQZZL20AgSOIeJFgkl
         XLEJKnXc+LaBQJ9J4jRoy8xd+K6eDrET6XciWkxycpjYIuPhO9V2HKLiUroeCWzcnl
         RnAXqbsSYpLUfHnofp6UwdE7NP/4msYxuOssnMpjz+Wb6HwCkhNh5+1YdJxysz0NXi
         iPXyG/3KN5lwEdy5hl7ZTeLBvAqmFegAYlF2bwsnsmFYev69JvgoHFapHfFH6jNkA9
         27YJmjiBu7Zbw==
Received: by mail-wm1-f54.google.com with SMTP id k17so8119249wmr.2;
        Wed, 31 Aug 2022 16:15:31 -0700 (PDT)
X-Gm-Message-State: ACgBeo22+/pZNAmKBSY/RRf2Z4RE2GxIbxseFJ8NANd3+KG3QFZo5OwA
        ylGYzciK19WVmI3PryXoJr+dILwCCwO1ZM7YMTE=
X-Google-Smtp-Source: AA6agR47KiLpOQ7NE1BygeJXvnbTMo/oeCM40gdLvUbCGWvJBjgiyVkpD3aAMowLLny9he+rPkeYkuNhYvm0xzcjn34=
X-Received: by 2002:a1c:7408:0:b0:3a5:c9c1:f226 with SMTP id
 p8-20020a1c7408000000b003a5c9c1f226mr3264966wmc.47.1661987729340; Wed, 31 Aug
 2022 16:15:29 -0700 (PDT)
MIME-Version: 1.0
References: <6675f56fc8b0910f17ec506d534cf5330ff04733.1660177086.git.objelf@gmail.com>
In-Reply-To: <6675f56fc8b0910f17ec506d534cf5330ff04733.1660177086.git.objelf@gmail.com>
From:   Sean Wang <sean.wang@kernel.org>
Date:   Wed, 31 Aug 2022 16:15:17 -0700
X-Gmail-Original-Message-ID: <CAGp9LzrzfAO0_Tejjg=NLBbq-TLC7JV=e05m9t97X1wbgxZ8+w@mail.gmail.com>
Message-ID: <CAGp9LzrzfAO0_Tejjg=NLBbq-TLC7JV=e05m9t97X1wbgxZ8+w@mail.gmail.com>
Subject: Re: [PATCH v5] Bluetooth: btusb: mediatek: fix WMT failure during
 runtime suspend
To:     luiz.dentz@gmail.com
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        =?UTF-8?B?U2VhbiBXYW5nICjnjovlv5fkupgp?= <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>, Eddie.Chen@mediatek.com,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        ted.huang@mediatek.com, Stella Chang <Stella.Chang@mediatek.com>,
        Tom.Chou@mediatek.com, steve.lee@mediatek.com, jsiuda@google.com,
        frankgor@google.com, abhishekpandit@google.com,
        michaelfsun@google.com, mcchou@chromium.org, shawnku@google.com,
        linux-bluetooth@vger.kernel.org,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        lkml <linux-kernel@vger.kernel.org>,
        Jing Cai <jing.cai@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luiz,

If the patch looks good to you, could you help apply the patch to
bluetooth.git? It can fix the issue present in the stable kernel, I
would like to backport it earlier once it appears in the Linus tree.

Sean

On Wed, Aug 10, 2022 at 5:59 PM <sean.wang@mediatek.com> wrote:
>
> From: Sean Wang <sean.wang@mediatek.com>
>
> WMT cmd/event doesn't follow up the generic HCI cmd/event handling, it
> needs constantly polling control pipe until the host received the WMT
> event, thus, we should require to specifically acquire PM counter on the
> USB to prevent the interface from entering auto suspended while WMT
> cmd/event in progress.
>
> Fixes: a1c49c434e15 ("Bluetooth: btusb: Add protocol support for MediaTek
>  MT7668U USB devices")
> Co-developed-by: Jing Cai <jing.cai@mediatek.com>
> Signed-off-by: Jing Cai <jing.cai@mediatek.com>
> Signed-off-by: Sean Wang <sean.wang@mediatek.com>
> ---
> v2:
> 1. move usb_autopm_[get, put]_interface to btusb_mtk_hci_wmt_sync whenever
> wmt cmd is invoked.
> 2. add the explanation why we needed the specific
> usb_autopm_[get, put]_interface there.
>
> v3: correct the version and there is no logic changed
> v4: fix GitLint fail due to Title exceeds max length
> v5: rebase to fix patches does not apply
> ---
>  drivers/bluetooth/btusb.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index 30dd443f395f..70d61bb4a053 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2480,15 +2480,29 @@ static int btusb_mtk_hci_wmt_sync(struct hci_dev *hdev,
>
>         set_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
>
> +       /* WMT cmd/event doesn't follow up the generic HCI cmd/event handling,
> +        * it needs constantly polling control pipe until the host received the
> +        * WMT event, thus, we should require to specifically acquire PM counter
> +        * on the USB to prevent the interface from entering auto suspended
> +        * while WMT cmd/event in progress.
> +        */
> +       err = usb_autopm_get_interface(data->intf);
> +       if (err < 0)
> +               goto err_free_wc;
> +
>         err = __hci_cmd_send(hdev, 0xfc6f, hlen, wc);
>
>         if (err < 0) {
>                 clear_bit(BTUSB_TX_WAIT_VND_EVT, &data->flags);
> +               usb_autopm_put_interface(data->intf);
>                 goto err_free_wc;
>         }
>
>         /* Submit control IN URB on demand to process the WMT event */
>         err = btusb_mtk_submit_wmt_recv_urb(hdev);
> +
> +       usb_autopm_put_interface(data->intf);
> +
>         if (err < 0)
>                 goto err_free_wc;
>
> --
> 2.25.1
>
