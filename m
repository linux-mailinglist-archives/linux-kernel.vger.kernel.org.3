Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F286F5AA4B0
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 02:55:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234209AbiIBAyP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 20:54:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232705AbiIBAyN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 20:54:13 -0400
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9618585FDA
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 17:54:12 -0700 (PDT)
Received: by mail-vs1-xe29.google.com with SMTP id o123so616632vsc.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 17:54:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=Z4jZhw7mGJwuXQjUPY9DDPjI76uAYRiiTmD0/hJHRkM=;
        b=nIyyFwXzkH01PkquT1Rue1bNSrCVjD98245QZcpk8KOScszIgLbylNpaBS6YJIdqKU
         FsL0wilrkLm1cskXgcVpKf7/PMkTTrsk9DFvWcoOl3UfIKORtrfnWAWZ0B+MsB3vxnP5
         tf5cUegvBBAOZxP2g18E3tNH/y4vZLj9oYlPH9WBzF2/7Yw7C9FUHrCVkglCA+CCgF2G
         hpoOhk382Kck/l5yOtaVuEQ3LnbDeKIVssUmtras+Tb/lOdozkc2HlH7gT1Q10K7vZeV
         L7T850wzHs2FGE4KMnUpzLlZUQ/w0A9I07zJ/41S7rBnyTiWpCeh4wpiV+90LuQLXQwB
         ufIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=Z4jZhw7mGJwuXQjUPY9DDPjI76uAYRiiTmD0/hJHRkM=;
        b=wF5vAgjiHoednxoGBSRzVI0Pxxhm6H6xpX2bvxLl/O4XpMBC5NEkQiEjxaPb7OnCYG
         Dyhb+aAtgkWvsZVxQaawLa6cAWf1mv/I1ju5lpA+v5xnsBX5UBLCe6Z5aFVv/GCWfypm
         PeFEyVcDqOhyKqbEDcH3V7OY/h4jg7hONsMQ0lyeLBiuPy6Ag/2hSQm3PcB4bM9xrt6x
         YT6sNzpS00yV3+CRXtB+qI+GtCt9A0uI38nts+0VCFSH05vkfMNPINaEdFSP8YsBRaXY
         46rC0QMKiloWKk0B8+o+c0oR3cstlF81JZU152zbNrr8GI59zXw1P6NfTan54dSmZHTs
         8sMg==
X-Gm-Message-State: ACgBeo1CsVfm/2B0yeX3kTHp51gPulhmwwBmWF/1tiDb2w7iC913Dx+h
        JKEMeVxQ+j1cbqEdVrz8AdXgo4xYL9yfUyXtwhW7hg==
X-Google-Smtp-Source: AA6agR4eK/rvBWvQKYqMgWclKa76PDOzLtRuN2u8uCKDsbgPEogq6bx3tt/nJSUP7wDE9TpWE+18IrBrRutIk5cRqlE=
X-Received: by 2002:a67:d313:0:b0:390:ee9f:610a with SMTP id
 a19-20020a67d313000000b00390ee9f610amr6689227vsj.17.1662080051630; Thu, 01
 Sep 2022 17:54:11 -0700 (PDT)
MIME-Version: 1.0
References: <20220829195805.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
In-Reply-To: <20220829195805.1.Ic8eabc8ed89a07c3d52726dd017539069faac6c4@changeid>
From:   Abhishek Pandit-Subedi <abhishekpandit@google.com>
Date:   Thu, 1 Sep 2022 17:54:00 -0700
Message-ID: <CAN61AdcHDEB=nG7sti8uiqv534P1N21VCx+XuqnkVUOjeoADkg@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Call shutdown for HCI_USER_CHANNEL
To:     linux-bluetooth@vger.kernel.org
Cc:     Abhishek Pandit-Subedi <abhishekpandit@chromium.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Please avoid merging.

After additional testing, I've found a problem with btusb->shutdown
not working for Intel controllers.

btusb_shutdown_intel uses __hci_sync_cmd(...) to send the command and
the command complete will not get captured because it is using hci
user channel. We'll need a more invasive change to remove the
userchannel flag during close so that the stack can properly clean up.


On Mon, Aug 29, 2022 at 7:58 PM Abhishek Pandit-Subedi
<abhishekpandit@google.com> wrote:
>
> From: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
>
> Some drivers depend on shutdown being called for proper operation.
> There's no reason to restrict this from being called when using
> HCI_USER_CHANNEL.
>
> Signed-off-by: Abhishek Pandit-Subedi <abhishekpandit@chromium.org>
> ---
> This is easy to reproduce on QCA6174-A, which uses the hci_qca driver.
> Simply open the socket, bind as userchannel and close again. It will
> succeed the first time and fail the second time (because shutdown wasn't
> called). A similar bug also occurs with btmtksdio (using MT7921).
>
> Question for maintainers: What is a driver supposed to be doing during
> shutdown? We should add some documentation to `struct hci_dev` to
> clarify.
>
>
>  net/bluetooth/hci_sync.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
> index e08c0503027d..be78fd708f16 100644
> --- a/net/bluetooth/hci_sync.c
> +++ b/net/bluetooth/hci_sync.c
> @@ -4680,7 +4680,6 @@ int hci_dev_close_sync(struct hci_dev *hdev)
>         }
>
>         if (!hci_dev_test_flag(hdev, HCI_UNREGISTER) &&
> -           !hci_dev_test_flag(hdev, HCI_USER_CHANNEL) &&
>             test_bit(HCI_UP, &hdev->flags)) {
>                 /* Execute vendor specific shutdown routine */
>                 if (hdev->shutdown)
> --
> 2.37.2.672.g94769d06f0-goog
>
