Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CDC785424AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 08:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376372AbiFHBe4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 21:34:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381951AbiFGVtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 17:49:22 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 387B51900ED
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 12:08:31 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id me5so36569994ejb.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jun 2022 12:08:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ly2K6RwUC0xQceY9gkjiyR1NrDY+373o7Stwfq7Edo8=;
        b=Sr4RPJ0nr2GZpTGnB63XLeYV+sZ11PmaJxxVtlKWt86mxu1ekdWtNjYzxVHj0IuKf5
         X+fnD/w3sWeMre0IMgkEivxZYCXGVcJkYQdWL5zk7gmAKxdQbhZx5MUgPKCbUxAydsFn
         t7b7xLFPBwK6woxotyHvhecOue2ay5ZIlh5qXuS2CNLWnRS70ZzD5kbcozgepZww8BoX
         8LGiX+MLYxkeEKFl0uJEqxVGyfUKcpvfusIU04r4JV4h6/96dbX1THptBWkADgzZaqDX
         TKo49V4mt1ZjRPBXsr8iuM0WRXzlXgWAqhaAAEzN/9fn8nduHStb0SmHyD8PzP+p7Kyc
         4zWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ly2K6RwUC0xQceY9gkjiyR1NrDY+373o7Stwfq7Edo8=;
        b=Tpge68S+J5odkyoGMn83SxF6qL/EoHu/76j80m5mJS1PJeHU3fw0s+KYMyssocibN2
         nlhMWZsbIN/PGGrGt/SDb9h/c2xlZFDOoEfgx5e1b6k+bnnqqlNvpp7sPJNmGgOqF0TR
         FNGqq5mM0ngPYwvEngrRdeKP8C2CEM4FS6nnoOKiVEIol2+dzhpRg2BZ2tPWIX3VY35Y
         Cv2eG0WIGkGYj5HzSGO6qog3TWacr82M1EAUzrVhAEioi5lj0AOcl4bDlk7cv0rZNCQI
         oBJPffKbgXMhQniECyrErCvThpsdhM9bJn/K3zP/iqUQFloax4hlbnxGNFBliTGkTDTn
         XkCQ==
X-Gm-Message-State: AOAM533KTzgru4JkjZvZjlbtehBKodTihEI4oQF0RGsgjIGxzWt0wv3Y
        H2tECBi1DGYhmVRVDQu+ns8E/RkCgvAhMuh6UngZK2NIP7g=
X-Google-Smtp-Source: ABdhPJzWxRQB/2wXoL3Vfr2wtMPhbfyjsFdRV8g50CZM5246EExQbSq92WL3xecfwhVwmo8o4hGRTZ/TC+TqBkBBZiI=
X-Received: by 2002:a17:907:8689:b0:6fe:e525:ea9c with SMTP id
 qa9-20020a170907868900b006fee525ea9cmr28506094ejc.720.1654628909344; Tue, 07
 Jun 2022 12:08:29 -0700 (PDT)
MIME-Version: 1.0
References: <20220607145639.2362750-1-tzungbi@kernel.org> <20220607145639.2362750-14-tzungbi@kernel.org>
In-Reply-To: <20220607145639.2362750-14-tzungbi@kernel.org>
From:   Guenter Roeck <groeck@google.com>
Date:   Tue, 7 Jun 2022 12:08:16 -0700
Message-ID: <CABXOdTdNas6ngk514LnLMGT8eZkZRT+dxYynQfsSWVhrJMkNhQ@mail.gmail.com>
Subject: Re: [PATCH v2 13/15] platform/chrome: cros_ec_proto: don't show MKBP
 version if unsupported
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
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

On Tue, Jun 7, 2022 at 7:57 AM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> It wrongly showed the following message when it doesn't support MKBP:
> "MKBP support version 4294967295".
>
> Fix it.
>
> Signed-off-by: Tzung-Bi Shih <tzungbi@kernel.org>

Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
> No v1.  New in the series.
>
>  drivers/platform/chrome/cros_ec_proto.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/platform/chrome/cros_ec_proto.c b/drivers/platform/chrome/cros_ec_proto.c
> index de6bc457e496..ee15a73eee38 100644
> --- a/drivers/platform/chrome/cros_ec_proto.c
> +++ b/drivers/platform/chrome/cros_ec_proto.c
> @@ -506,13 +506,13 @@ int cros_ec_query_all(struct cros_ec_device *ec_dev)
>         ret = cros_ec_get_host_command_version_mask(ec_dev,
>                                                     EC_CMD_GET_NEXT_EVENT,
>                                                     &ver_mask);
> -       if (ret < 0 || ver_mask == 0)
> +       if (ret < 0 || ver_mask == 0) {
>                 ec_dev->mkbp_event_supported = 0;
> -       else
> +       } else {
>                 ec_dev->mkbp_event_supported = fls(ver_mask);
>
> -       dev_dbg(ec_dev->dev, "MKBP support version %u\n",
> -               ec_dev->mkbp_event_supported - 1);
> +               dev_dbg(ec_dev->dev, "MKBP support version %u\n", ec_dev->mkbp_event_supported - 1);
> +       }
>
>         /* Probe if host sleep v1 is supported for S0ix failure detection. */
>         ret = cros_ec_get_host_command_version_mask(ec_dev,
> --
> 2.36.1.255.ge46751e96f-goog
>
