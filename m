Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 949034692F9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 10:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241524AbhLFJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 04:54:11 -0500
Received: from mx3.molgen.mpg.de ([141.14.17.11]:40137 "EHLO mx1.molgen.mpg.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S241503AbhLFJyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 04:54:10 -0500
Received: from [192.168.0.2] (ip5f5aea86.dynamic.kabel-deutschland.de [95.90.234.134])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pmenzel)
        by mx.molgen.mpg.de (Postfix) with ESMTPSA id CA94B61E5FE00;
        Mon,  6 Dec 2021 10:50:39 +0100 (CET)
Message-ID: <61e772a7-6e46-7c0f-32ba-b3e3ad88062c@molgen.mpg.de>
Date:   Mon, 6 Dec 2021 10:50:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH] Bluetooth: btusb: Handle download_firmware failure cases.
Content-Language: en-US
To:     mark-yw.chen@mediatek.com
Cc:     aaron.hou@mediatek.com, kaichuan.hsieh@canonical.com,
        linux-bluetooth@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        marcel@holtmann.org, johan.hedberg@gmail.com,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Sean Wang <sean.wang@mediatek.com>
References: <20211206092546.27216-1-mark-yw.chen@mediatek.com>
From:   Paul Menzel <pmenzel@molgen.mpg.de>
In-Reply-To: <20211206092546.27216-1-mark-yw.chen@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Mark,


Some small nitpicks:

Am 06.12.21 um 10:25 schrieb mark-yw.chen@mediatek.com:
> From: mark-yw.chen <mark-yw.chen@mediatek.com>

Instead of the user name, maybe you can use Mark Chen (or the whole name)?

     $ git config --global user.name "Mark Chen"
     $ git commit --amend --reset-author="Mark Chen 
<mark-yw.chen@mediatek.com>"

Also could you please remove the trailing dot/period at the end of the 
git commit message summary?

> For Mediatek chipset, if there are no firmware bin or command_timeout,
> the process should be terminated in btusb_mtk_setup().

Otherwise what happens?

> Signed-off-by: mark-yw.chen <mark-yw.chen@mediatek.com>
> Change-Id: I99f1d7b72fa70643d9123e7e6cdc8d0b4369ce52

To what Gerrit instance does the Change-Id belong? Without that 
information (Reviewed-on tag?), it should be removed?

> ---
>   drivers/bluetooth/btmtk.c | 1 +
>   drivers/bluetooth/btusb.c | 4 ++++
>   2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/bluetooth/btmtk.c b/drivers/bluetooth/btmtk.c
> index c2ee5c4b975a..526dfdf1fe01 100644
> --- a/drivers/bluetooth/btmtk.c
> +++ b/drivers/bluetooth/btmtk.c
> @@ -121,6 +121,7 @@ int btmtk_setup_firmware_79xx(struct hci_dev *hdev, const char *fwname,
>   				} else {
>   					bt_dev_err(hdev, "Failed wmt patch dwnld status (%d)",
>   						   status);
> +					err = -EIO;
>   					goto err_release_fw;
>   				}
>   			}
> diff --git a/drivers/bluetooth/btusb.c b/drivers/bluetooth/btusb.c
> index ab169fc673ea..3ea04b1d0750 100644
> --- a/drivers/bluetooth/btusb.c
> +++ b/drivers/bluetooth/btusb.c
> @@ -2554,6 +2554,10 @@ static int btusb_mtk_setup(struct hci_dev *hdev)
>   			 dev_id & 0xffff, (fw_version & 0xff) + 1);
>   		err = btmtk_setup_firmware_79xx(hdev, fw_bin_name,
>   						btusb_mtk_hci_wmt_sync);
> +		if (err < 0) {
> +			bt_dev_err(hdev, "Failed to setup firmware (%d)", err);

The verb is spelled with a space: set up.

Also, this error message seems unrelated to the patch in question. Maybe 
add it in a separate commit?

> +			return err;
> +		}
>   
>   		/* It's Device EndPoint Reset Option Register */
>   		btusb_mtk_uhw_reg_write(data, MTK_EP_RST_OPT, MTK_EP_RST_IN_OUT_OPT);
> 


Kind regards,

Paul
