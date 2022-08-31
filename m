Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBE35A77A4
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 09:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230064AbiHaHix (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 03:38:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiHaHiv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 03:38:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36716BE4EF
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:38:50 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id s15so8583804ljp.5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 00:38:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=3Kt+FeOng/UOMbYpP0xjbg2+rCfL3Wu4EjlGGsEGffg=;
        b=hyay9cCyGM9c0iIRK/EzkRgHuPy7nROx0Uu1jQkmt2Kvdx5JJxeYJMqFXYKNvoPk5y
         fcBHaUfivVbFi1AwuZ/tbw6BlsgwxRni8zZbvhITniaEo4zOyIIIBSkEvtOm8gsaXR0u
         2ITa9AhB2Y71Axj6ViukdhLrNWWrK2o5RZ2VuibRpcTAHVznEggH9vyz82YXNJ4tA53I
         vI8+/asi9BMmH42cLBhNqL5DJaX3jlbWTP6nbvjer+67wG8TmA/HvOqoVR6pdyqrD9Ah
         OQhERKLkOGS17Gs/uSxqq6hq+ySokoLjICt9XpXJC/TurZ99FXaNFiNIBPjArNOlaAZD
         ZlgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=3Kt+FeOng/UOMbYpP0xjbg2+rCfL3Wu4EjlGGsEGffg=;
        b=OKpVEGGZdcJNv8SPNZzGHsI8qJ1pnP9eHVGCh14y6jHhf7PB3/jmTOhCKkecXYWSm5
         +BQERadbO0YQw0JCRXoH3dqyPiZf9iMgAShRaPj7mCONhUtFYZSXDwV28wTp0NxFs07Z
         n9y6wQKLcSVJ9hOwloyYWis4lwOO6bCWZ2jqn/cic8Fnzkr72TydpEOgZmgyyDUs3d3N
         3CcTpoxbAccRQ+1F63cv8ci4dULywpxtPL427ZE/n6ixKEca9C4DakL3tMEDbW+L4q4o
         OdFvWjWJIWEO0svtrNuAtdInmbm98H5Z3A42aQxGbIMpCf5noEILj8+OK2Hvb+SFB/Ly
         37xg==
X-Gm-Message-State: ACgBeo11lljhkL3N5B2bgLuk7YCXxqhJb4fzC/gPHNPndiOII8DH/vDe
        YDeiz/GZ6vcVqxhZF0sDdbLrWnIL7QhbCAPwHO+cMg==
X-Google-Smtp-Source: AA6agR66bKKoN5TXV7bkbrjQZ8xLPMHiN02YzHI2JBvrWbzBhqU1od1J/hQLYCMWDJW4VX5MibM52UfnjhPtf/Ra9Bc=
X-Received: by 2002:a2e:844a:0:b0:258:e7a6:353a with SMTP id
 u10-20020a2e844a000000b00258e7a6353amr8059564ljh.153.1661931528214; Wed, 31
 Aug 2022 00:38:48 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-3-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-3-sudeep.holla@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 31 Aug 2022 13:08:36 +0530
Message-ID: <CAFA6WYPkDod+CU=31P5n-HQq9TQUukprKtRVZw4as4G7bQbaDQ@mail.gmail.com>
Subject: Re: [PATCH 2/9] tee: optee: Use ffa_dev->ops directly
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
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

On Tue, 30 Aug 2022 at 15:38, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Now that the ffa_device structure holds the pointer to ffa_dev_ops,
> there is no need to obtain the same through ffa_dev_ops_get().
>
> Just use the ffa_dev->ops directly.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 7ab31740cff8..4c3b5d0008dd 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -793,11 +793,7 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         u32 sec_caps;
>         int rc;
>
> -       ffa_ops = ffa_dev_ops_get(ffa_dev);
> -       if (!ffa_ops) {
> -               pr_warn("failed \"method\" init: ffa\n");
> -               return -ENOENT;
> -       }
> +       ffa_ops = ffa_dev->ops;
>
>         if (!optee_ffa_api_is_compatbile(ffa_dev, ffa_ops))
>                 return -EINVAL;
> --
> 2.37.2
>
