Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 260CB5A91EC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 10:18:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234093AbiIAISV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 04:18:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232531AbiIAISR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 04:18:17 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B19029A9AD
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 01:18:13 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id r22so15702908pgm.5
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 01:18:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cF/RmFVCOwDa0C9r1jNd+RSCZZWopdv4zTGSMMqnQYg=;
        b=Jw0iWvqxKMRhYRXTrCM/W0cn/4TCJkYsBWOsT0TOcah/lQR69Y5J4lFtCnK7Oqv0BV
         y4M/idItNlerd8WgbIw9T6zOJTfsuyYAyezPj6l9dDNax3y7julo5BRj8SsulsQC2h/0
         13IiHQaq+DkMClkPywCw0rsl1cTMT+lBt/w54jF/dgW0r3dDbmcv9axbucqhkUDeGTZd
         EsVwccnyaYUQ8s9mjIoeJ4685Sd5d5Fvg/vJraUtCFC2Kjn/4ns5n29hGEtNtctiXRuV
         SC/Da+UQSZ2j9kYt7xhYKDxiL3YhmQUW5xFRBEEd94GzmlKULFxCs8LgxzzuLZI8HfEg
         iH1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cF/RmFVCOwDa0C9r1jNd+RSCZZWopdv4zTGSMMqnQYg=;
        b=dLkPdOZ06w+uIbH5l2FV/OfMkugm5wft2XIvOdckUqTxLUXZCdgZlimLwUuy1EiEkl
         szyd+f1o1x9jR9CBgT0OQxFfIPPAipZRtwEAv5WNDPDsTpMXJi1uvs6DuAIYsBUNn8hx
         94rsplAN5TPMeV2RsyqnFgjM5K+7k3jliyjZvE5kWCew6AmR7QjYxLJrzS7jpbwtpy3o
         zqbFvwRGJJddDnBiHyrx+ath5cGEcIoqlcF6dhiPwOtbTPalGJfVPx7EPOt2E+gwgyj9
         2E5AwCzonfMAi6tlQyCwWmiob8gK3sOjoTRAfwbFy6MnZwmTRw75UJhhAmjcOoumJLgh
         8+nA==
X-Gm-Message-State: ACgBeo39e4jjF9dDzRmi265z6ik0cONoeAmtCLQ/7bXpagGgYM5KfRdQ
        AVxBgwkvIUKmoupU4InxrHta644rzqH6/7aDJcCjEw==
X-Google-Smtp-Source: AA6agR704/rLLfG9N0XsZkxsmDctBC8SSN+mHOQMv9FHVxfCosyZex/SxajZFIchbZX1Yk7EPe3trYK8sMACRsvjvBg=
X-Received: by 2002:a62:30c7:0:b0:52f:9a31:5935 with SMTP id
 w190-20020a6230c7000000b0052f9a315935mr30219274pfw.14.1662020292598; Thu, 01
 Sep 2022 01:18:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-6-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-6-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 10:18:01 +0200
Message-ID: <CAHUa44ETTyP+4ydNZ+A7y_vRuUsfDQtxox1Ox06aM5rcgLgYZA@mail.gmail.com>
Subject: Re: [PATCH 5/9] firmware: arm_ffa: Use FFA_FEATURES to detect if
 native versions are supported
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Achin Gupta <achin.gupta@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 30, 2022 at 12:07 PM Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Currently, the ffa_dev->mode_32bit is use to detect if the native 64-bit
> or 32-bit versions of FF-A ABI needs to be used. However for the FF-A
> memory ABIs, it is not dependent on the ffa_device(i.e. the partition)
> itself, but the partition manager(SPM).
>
> So, the FFA_FEATURES can be use to detect if the native 64bit ABIs are
> supported or not and appropriate calls can be made based on that.
>
> Use FFA_FEATURES to detect if native versions of MEM_LEND or MEM_SHARE
> are implemented and make of the same to use native memory ABIs later on.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 22 ++++++++++++++++------
>  1 file changed, 16 insertions(+), 6 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index de94073f4109..5f02b670e964 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -163,6 +163,7 @@ struct ffa_drv_info {
>         struct mutex tx_lock; /* lock to protect Tx buffer */
>         void *rx_buffer;
>         void *tx_buffer;
> +       bool mem_ops_native;
>  };
>
>  static struct ffa_drv_info *drv_info;
> @@ -594,6 +595,13 @@ static int ffa_features(u32 func_feat_id, u32 input_props, u32 *if_props)
>         return 0;
>  }
>
> +static void ffa_set_up_mem_ops_native_flag(void)
> +{
> +       if (!ffa_features(FFA_FN_NATIVE(MEM_LEND), 0, NULL) ||
> +           !ffa_features(FFA_FN_NATIVE(MEM_SHARE), 0, NULL))
> +               drv_info->mem_ops_native = true;
> +}
> +
>  static u32 ffa_api_version_get(void)
>  {
>         return drv_info->version;
> @@ -635,10 +643,10 @@ static int ffa_sync_send_receive(struct ffa_device *dev,
>  static int
>  ffa_memory_share(struct ffa_device *dev, struct ffa_mem_ops_args *args)
>  {
> -       if (dev->mode_32bit)
> -               return ffa_memory_ops(FFA_MEM_SHARE, args);
> +       if (drv_info->mem_ops_native)
> +               return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
>
> -       return ffa_memory_ops(FFA_FN_NATIVE(MEM_SHARE), args);
> +       return ffa_memory_ops(FFA_MEM_SHARE, args);
>  }
>
>  static int
> @@ -651,10 +659,10 @@ ffa_memory_lend(struct ffa_device *dev, struct ffa_mem_ops_args *args)
>          * however on systems without a hypervisor the responsibility
>          * falls to the calling kernel driver to prevent access.
>          */
> -       if (dev->mode_32bit)
> -               return ffa_memory_ops(FFA_MEM_LEND, args);
> +       if (drv_info->mem_ops_native)
> +               return ffa_memory_ops(FFA_FN_NATIVE(MEM_LEND), args);
>
> -       return ffa_memory_ops(FFA_FN_NATIVE(MEM_LEND), args);
> +       return ffa_memory_ops(FFA_MEM_LEND, args);
>  }
>
>  static const struct ffa_dev_ops ffa_ops = {
> @@ -765,6 +773,8 @@ static int __init ffa_init(void)
>
>         ffa_setup_partitions();
>
> +       ffa_set_up_mem_ops_native_flag();
> +
>         return 0;
>  free_pages:
>         if (drv_info->tx_buffer)
> --
> 2.37.2
>
