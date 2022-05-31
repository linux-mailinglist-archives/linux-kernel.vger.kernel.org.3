Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB758538D76
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 11:08:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245077AbiEaJIG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 05:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242735AbiEaJID (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 05:08:03 -0400
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com [IPv6:2607:f8b0:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E611655206
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:07:59 -0700 (PDT)
Received: by mail-ot1-x335.google.com with SMTP id r14-20020a056830418e00b0060b8da9ff75so3053227otu.11
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 02:07:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RWsthZPxNDA39U3KIC6LMsBvLuzLbrfSrlsINFHYDcI=;
        b=GIYO75yR6RxABAavORON5hxUzN4kdiuq7iHSEQU+CYmSKkkfZ8vjYY7xX1gDRJoG5K
         WA75V3DNHdz/zDQXyHEiAH5srFHNeIsH2HYfdJMpQ9w1XsbSWECD8ZOulAam5RJpg6fY
         NhnvWk26PwIEleos7OZzKK8rR2pvXqVteUll6hvklGGoXj/S6IspbIDwpd+Ift+Vybjb
         wEeXzYj5OjZ94nZYdMK7gyTFAIti2MtbG/oejv+cr+8XhQ/mazoM4Ro7zRM68pWVz+zM
         YKZuF6uX6UrEUrH0DkPcfa89zq0xmnpzrmr6a9G0wxvHQdCMY77aNgspIxpSuNWyDxRN
         sSTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RWsthZPxNDA39U3KIC6LMsBvLuzLbrfSrlsINFHYDcI=;
        b=VM24LhbceZ8wBWvfIVkFd5WkDnjzhVPynkKlQdTpCD4VQK1pXoZ1QxjcyYaGAqgDh9
         PSt/Izviafzi4UuPbDbsaFPOvqx9u2RCQupq7A7m+JBgILsv0FzugJErdxuk2hCWXEOM
         v7JRTy/T1CYyagYi8rVFmssifqsZDlciJ0ave7emuvniG8OvRNEKCv6Gv46oxGcBjUSU
         W6xle2Nv6VPrvG0jin76LiDfW05PJ7DeB9XZGF5Y6gjrCKey8Ba6RbSoMgMo0KoPq4L8
         nEVtovh++M501M8HTY0dlCkjUktShFl3zbk/ZzrYfFPVMi0tH39PqHaNpefcKEHyB84E
         kfIw==
X-Gm-Message-State: AOAM533Zkxk9W7ygnaVWWfwU8XwedC3E7jFcz8FoM6utDz2eEnybdX0K
        A2BemfzOpHp8YjOR8IxApZSq7mtO5yHvlUiDlL+jAg==
X-Google-Smtp-Source: ABdhPJxVvTrJGlPKkgE3ckW+2BAEYRKazdCH8wFipcEpTVtbBTK4iTzPHd32UxIZGi3IQCROhrDqUirCGPDwLhTbJs0=
X-Received: by 2002:a9d:6f1a:0:b0:60b:20fd:ca75 with SMTP id
 n26-20020a9d6f1a000000b0060b20fdca75mr13961134otq.126.1653988078875; Tue, 31
 May 2022 02:07:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220517094532.2729049-1-poprdi@google.com>
In-Reply-To: <20220517094532.2729049-1-poprdi@google.com>
From:   =?UTF-8?Q?Tam=C3=A1s_Koczka?= <poprdi@google.com>
Date:   Tue, 31 May 2022 11:07:47 +0200
Message-ID: <CAPUC6bKo6EdacUVAWaJp+_Z_sEztnv96Li6zLpm-UR=2rZth-w@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: Collect kcov coverage from hci_rx_work
To:     Marcel Holtmann <marcel@holtmann.org>
Cc:     Andy Nguyen <theflow@google.com>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        linux-bluetooth@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, Aleksandr Nogikh <nogikh@google.com>,
        Dmitry Vyukov <dvyukov@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Everyone,

Thank you for reviewing the patch - I hope everything is going well.

Please feel free to ask me if you need any more information regarding it!

Thank you,
Tamas

On Tue, May 17, 2022 at 11:45 AM Tamas Koczka <poprdi@google.com> wrote:
>
> Annotate hci_rx_work() with kcov_remote_start() and kcov_remote_stop()
> calls, so remote KCOV coverage is collected while processing the rx_q
> queue which is the main incoming Bluetooth packet queue.
>
> Coverage is associated with the thread which created the packet skb.
>
> Signed-off-by: Tamas Koczka <poprdi@google.com>
> ---
>  net/bluetooth/hci_core.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
>
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index 45c2dd2e1590..703722031b8d 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -29,6 +29,7 @@
>  #include <linux/rfkill.h>
>  #include <linux/debugfs.h>
>  #include <linux/crypto.h>
> +#include <linux/kcov.h>
>  #include <linux/property.h>
>  #include <linux/suspend.h>
>  #include <linux/wait.h>
> @@ -3780,7 +3781,9 @@ static void hci_rx_work(struct work_struct *work)
>
>         BT_DBG("%s", hdev->name);
>
> -       while ((skb = skb_dequeue(&hdev->rx_q))) {
> +       for (; (skb = skb_dequeue(&hdev->rx_q)); kcov_remote_stop()) {
> +               kcov_remote_start_common(skb_get_kcov_handle(skb));
> +
>                 /* Send copy to monitor */
>                 hci_send_to_monitor(hdev, skb);
>
> --
> 2.36.0.550.gb090851708-goog
>
