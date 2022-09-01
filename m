Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF7845A9082
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 09:39:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiIAHjl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 03:39:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233358AbiIAHji (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 03:39:38 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38155125B92
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 00:39:28 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id f24so13583101plr.1
        for <linux-kernel@vger.kernel.org>; Thu, 01 Sep 2022 00:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=jKQ7DJuFlGc0DeoE65t6R98bq+rRazecEn3/wnqOMRk=;
        b=Rs23n814idO+jLBs6mAaDSR/LXXk4QceFHo+u0d6ZyYXJQkDe5lELJkIik2NkqSL3f
         6mJMRYCiQtDhwXIDzavpXxwq7cOC9asNbKwLnswX1aYyLYqJq5VbuOqiabu1oI7xbsyC
         0BEdeexQfQUNvehJLA0+2xDm+E6IzirZtK8FiELBdz9avQdMQ3m7811RZ9fR3pqbb5Q9
         5jMQ0lHA8Fhn9tZB33jCq5Lem3wc5sZCioX8fri3edKydPujEJymCLoV+JhDSpvO8I1T
         +fnRlq8HZJ8pMJLIbuJ36wZgFeAPmr1DQAtQQWv4a3aRCJGy6XHeWWFCPwO5cU8g2JWR
         mOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=jKQ7DJuFlGc0DeoE65t6R98bq+rRazecEn3/wnqOMRk=;
        b=nb571zsAjqyUrUcEBgnrmVOwMiSM3N4oG8n4a6mRanFDet238xbZzhDwFt//1YNyUx
         YgZeeVo826JfaBegA+KA5Fv1UUR2Dnq5MvqsPV0QKwJ5mA3a65W05aINXl8ALT6Cvj5R
         Y2N1sa0B4Cn8meToaQYOmyGJK0o9UENb0tBPcG/4OVk76y56c3K+W30QAVySVm1pvGkV
         OjY2kiG2gPg1NUYlPtBmraCC1lwmnwl0reIIMRvB23rq3cjcVQXq9kmP7fS7mNd43ubh
         UpqqDy5/WaPjCxDjsmMCHpH4XWYFY5bzLOxHLjKIULLzvjZ8gJ8Z0MQr+HGpMfT7QQFK
         gx7w==
X-Gm-Message-State: ACgBeo1QxQZnD6HnUZbP9knylew1cYeBj5ZNemuQA5+UXeUkh1rb4uRP
        QzvMDAgwpRBxfQd1wAYlDxgy71TtNzmH23iUcJ9Gvg==
X-Google-Smtp-Source: AA6agR7C+lij3Tk9OHrH29o8o4naNtxfG4BhQtHENCMVr/kkT/YKg4q6x67b09TvRvvSapbYeg350ZhPi7mAc9r8rxg=
X-Received: by 2002:a17:902:d505:b0:175:5313:2a3f with SMTP id
 b5-20020a170902d50500b0017553132a3fmr3929907plg.70.1662017966990; Thu, 01 Sep
 2022 00:39:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-4-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-4-sudeep.holla@arm.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 1 Sep 2022 09:39:13 +0200
Message-ID: <CAHUa44Fiunh_Ubk96+91p2+SW49xGGJ3MKoRfOVwTHU9AbuCHg@mail.gmail.com>
Subject: Re: [PATCH 3/9] firmware: arm_ffa: Remove ffa_dev_ops_get()
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
> The only user of this exported ffa_dev_ops_get() was OPTEE driver which
> now uses ffa_dev->ops directly, there are no other users for this.
>
> Also, since any ffa driver can use ffa_dev->ops directly, there will be
> no need for ffa_dev_ops_get(), so just remove ffa_dev_ops_get().
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/firmware/arm_ffa/driver.c | 9 ---------
>  include/linux/arm_ffa.h           | 6 ------
>  2 files changed, 15 deletions(-)

Reviewed-by: Jens Wiklander <jens.wiklander@linaro.org>

>
> diff --git a/drivers/firmware/arm_ffa/driver.c b/drivers/firmware/arm_ffa/driver.c
> index 213665e5ad0e..04e7cbb1b9aa 100644
> --- a/drivers/firmware/arm_ffa/driver.c
> +++ b/drivers/firmware/arm_ffa/driver.c
> @@ -644,15 +644,6 @@ static const struct ffa_dev_ops ffa_ops = {
>         .memory_lend = ffa_memory_lend,
>  };
>
> -const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev)
> -{
> -       if (ffa_device_is_valid(dev))
> -               return &ffa_ops;
> -
> -       return NULL;
> -}
> -EXPORT_SYMBOL_GPL(ffa_dev_ops_get);
> -
>  void ffa_device_match_uuid(struct ffa_device *ffa_dev, const uuid_t *uuid)
>  {
>         int count, idx;
> diff --git a/include/linux/arm_ffa.h b/include/linux/arm_ffa.h
> index 91b47e42b73d..556f50f27fb1 100644
> --- a/include/linux/arm_ffa.h
> +++ b/include/linux/arm_ffa.h
> @@ -55,7 +55,6 @@ int ffa_driver_register(struct ffa_driver *driver, struct module *owner,
>                         const char *mod_name);
>  void ffa_driver_unregister(struct ffa_driver *driver);
>  bool ffa_device_is_valid(struct ffa_device *ffa_dev);
> -const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev);
>
>  #else
>  static inline
> @@ -79,11 +78,6 @@ static inline void ffa_driver_unregister(struct ffa_driver *driver) {}
>  static inline
>  bool ffa_device_is_valid(struct ffa_device *ffa_dev) { return false; }
>
> -static inline
> -const struct ffa_dev_ops *ffa_dev_ops_get(struct ffa_device *dev)
> -{
> -       return NULL;
> -}
>  #endif /* CONFIG_ARM_FFA_TRANSPORT */
>
>  #define ffa_register(driver) \
> --
> 2.37.2
>
