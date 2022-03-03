Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DDC74CBD51
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiCCMEB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:04:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233048AbiCCMD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:03:57 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165CF7C17F;
        Thu,  3 Mar 2022 04:03:12 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id a23so10174329eju.3;
        Thu, 03 Mar 2022 04:03:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=C5MXByekrRs4p3Ek5KYAlI6yucTo9+FwBD2Nkb2Yalg=;
        b=Ui8PefNKbm6pGhWvMC4Rgetj9x5P35nwLzN4AfU/bmeo/+NAk8YQfR2Go19sCR8cyQ
         /PqFqJ43R2Q9JRo3sK5r0QqetjF7kOveg5AxR+JUHmkPS4pd2Vx+0e2eDeuYbHshKdUs
         6dZuz2h1ka0K5r4Mq/o6TgHrhzygalRwZYcss+Hv9/ggXpgz+Z7kttvij2vV/QOgQcQj
         BRJeT960/QLEYw+YH11zLPwQttYi/kRhUgvm/FqCmXrrfGt5BL3jp9NmOItttFyOrwkB
         JtwuDpkA79wtVcx/1eRtVNi/muu+FWGl8daCJLYXsIHp+H9zprA9oi+SdM2ESFZg0EHe
         NWPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=C5MXByekrRs4p3Ek5KYAlI6yucTo9+FwBD2Nkb2Yalg=;
        b=bTjY4dUk5hdNRFyMALMgd11MKIezU/ePltMCPOtDKfDj2KmqOLAUqdIMr4dosu5tyG
         wGt942n3ZHHRHrLFcE77D723v5W43pVfCFoF6dVCNpAy5HifPHqhPmPJB7GmUfNB88Bw
         WTaPhcDrGNAl4sI0YVqi/EE7B8t/y9McHkU+qntdZTTJduIPxf/wp0NafLpJ7wqM3ohB
         m0QukeWPC1ObapzCMRAR1CPnmUe3+No+/9vm1QYFTZFbbRm6XIxQ7xSOI5sxNn9mzJeK
         7Gqx86Wji+lnvDtjbM/L+hhdcXF8tAhR6d4sWd8Ghaei9h0ELM7RVKhD0s5cX28n3FsQ
         y6ZQ==
X-Gm-Message-State: AOAM531+ZFW4JI0jMHwtZSJ0XGdyJi1uRpsnUF1kFT5xOzJK2p9PaPSM
        ZVuUoTqea0zOlmTSaWK4gJZPdOQHZ9Kpgxvj6Fo=
X-Google-Smtp-Source: ABdhPJwJU7zLBGAAQRJjPbA6o0rwI5aOpqP0j+GHXxJvsNRbGuBkFEHZommJZIgcD8F/Pn66FMzvf+GQ5bB9WZ5mfDo=
X-Received: by 2002:a17:906:b157:b0:6d0:9f3b:a6aa with SMTP id
 bt23-20020a170906b15700b006d09f3ba6aamr26740267ejb.365.1646308990587; Thu, 03
 Mar 2022 04:03:10 -0800 (PST)
MIME-Version: 1.0
References: <20220303081428.12979-1-d.glazkov@omp.ru>
In-Reply-To: <20220303081428.12979-1-d.glazkov@omp.ru>
From:   Dongliang Mu <mudongliangabcd@gmail.com>
Date:   Thu, 3 Mar 2022 20:02:44 +0800
Message-ID: <CAD-N9QUR3H-r4g9jkyDhFnoozVeuUxBvQEMuiBRJ7Q6HHaGsaA@mail.gmail.com>
Subject: Re: [PATCH] KEYS: fix memory leak when reading certificate fails
To:     Denis Glazkov <d.glazkov@omp.ru>
Cc:     David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Mehmet Kayaalp <mkayaalp@linux.vnet.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org" 
        <linux-security-module@vger.kernel.org>
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

On Thu, Mar 3, 2022 at 7:49 PM Denis Glazkov <d.glazkov@omp.ru> wrote:
>
> In the `read_file` function of `insert-sys-cert.c` script, if
> the data is read incorrectly, the memory allocated for the `buf`
> array is not freed.
>
> Fixes: c4c361059585 ("KEYS: Reserve an extra certificate symbol for inserting without recompiling")
> Signed-off-by: Denis Glazkov <d.glazkov@omp.ru>
> ---
>  scripts/insert-sys-cert.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/insert-sys-cert.c b/scripts/insert-sys-cert.c
> index 8902836c2342..b98a0b12f16f 100644
> --- a/scripts/insert-sys-cert.c
> +++ b/scripts/insert-sys-cert.c
> @@ -251,6 +251,7 @@ static char *read_file(char *file_name, int *size)
>         if (read(fd, buf, *size) != *size) {
>                 perror("File read failed");
>                 close(fd);
> +               free(buf);
>                 return NULL;
>         }
>         close(fd);

Hi Denis,

There is another issue related to variable buf. On the success path,
buf will be assigned to variable cert in the main function. And cert
is not free when the main function exits.

> --
> 2.25.1
