Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4580D55DC7F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:26:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237262AbiF0TBH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 15:01:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235333AbiF0TBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 15:01:04 -0400
Received: from mail-io1-f48.google.com (mail-io1-f48.google.com [209.85.166.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36BD927A;
        Mon, 27 Jun 2022 12:01:03 -0700 (PDT)
Received: by mail-io1-f48.google.com with SMTP id u20so10533908iob.8;
        Mon, 27 Jun 2022 12:01:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mansG8D/+FHV5zKPQQEebcvobqiL0Z6byNaHC/Nv9l8=;
        b=eNrE/aymDRsU7KURxePVHhuchGZGKOOBGvg/zaUmLHfHiPi4wa0340XzOF6ZXiSRSJ
         DL/oYIpP4nlknVWV/V9JwBh5P45kYDe1MoE5+MwcAuJRo8gFXjVF0rgIwKOLSvWe2f2B
         nBw07KctxLhIfNyHekdvjJEvagbRFqE15UED9hO5IINtxx81cDnTkUAY6HnxvW+NNAcC
         R3RKqQyE32Jrl1CKiGb2jkJqi2qTwjYYMEJuyPQh/Bi7Zp17NoJcV/uDX43ntGP3rSaJ
         adi/rnl0C/IHr6gE3Zz3pbCGFykh/5XbaiVMsj1G3scl5aCpe5KNzhSI1pfDnZaqP++M
         8u6w==
X-Gm-Message-State: AJIora+JBgmwK9wNqTjPGjqYfAp3wsr7Mfi2dmsIPF7Vi30+oZ7auw46
        iiUqBRoOey7h7l3yAGGsWnWikpN/c3D/srH3tIE=
X-Google-Smtp-Source: AGRyM1sCj0QgrRzCd2qoIY8dKEVPxjeocNnrlmC+yjIGUeOFa99tz5xaUDIkhmLdxAH5x2JaUOKfZxVqxpaCKduF1PI=
X-Received: by 2002:a05:6638:1342:b0:33c:8cd9:3208 with SMTP id
 u2-20020a056638134200b0033c8cd93208mr5516066jad.301.1656356462460; Mon, 27
 Jun 2022 12:01:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220613120755.14306-1-peter.wang@mediatek.com>
In-Reply-To: <20220613120755.14306-1-peter.wang@mediatek.com>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Mon, 27 Jun 2022 21:00:51 +0200
Message-ID: <CAJZ5v0ipi5frHBGWWcFpGCYL7au=dF6vUG772h0r0pnCYsi5Zg@mail.gmail.com>
Subject: Re: [PATCH v1] PM-runtime: Check supplier_preactivated before release supplier
To:     peter.wang@mediatek.com
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Len Brown <len.brown@intel.com>, Pavel Machek <pavel@ucw.cz>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        wsd_upstream <wsd_upstream@mediatek.com>,
        "moderated list:ARM/Mediatek SoC..." 
        <linux-mediatek@lists.infradead.org>, chun-hung.wu@mediatek.com,
        alice.chao@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        powen.kao@mediatek.com, qilin.tan@mediatek.com,
        lin.gui@mediatek.com, tun-yu.yu@mediatek.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2022 at 2:08 PM <peter.wang@mediatek.com> wrote:
>
> From: Peter Wang <peter.wang@mediatek.com>
>
> With divice link of DL_FLAG_PM_RUNTIME, if consumer call pm_runtime_get_suppliers
> to prevent supplier enter suspend, pm_runtime_release_supplier should
> check supplier_preactivated before let supplier enter suspend.

Why?

> If the link is drop or release, bypass check supplier_preactivated.
>
> Signed-off-by: Peter Wang <peter.wang@mediatek.com>
> ---
>  drivers/base/core.c          |  2 +-
>  drivers/base/power/runtime.c | 15 ++++++++++++---
>  include/linux/pm_runtime.h   |  5 +++--
>  3 files changed, 16 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/base/core.c b/drivers/base/core.c
> index 7cd789c4985d..3b9cc559928f 100644
> --- a/drivers/base/core.c
> +++ b/drivers/base/core.c
> @@ -486,7 +486,7 @@ static void device_link_release_fn(struct work_struct *work)
>         /* Ensure that all references to the link object have been dropped. */
>         device_link_synchronize_removal();
>
> -       pm_runtime_release_supplier(link, true);
> +       pm_runtime_release_supplier(link, true, true);
>
>         put_device(link->consumer);
>         put_device(link->supplier);
> diff --git a/drivers/base/power/runtime.c b/drivers/base/power/runtime.c
> index 676dc72d912d..3c4f425937a1 100644
> --- a/drivers/base/power/runtime.c
> +++ b/drivers/base/power/runtime.c
> @@ -314,10 +314,19 @@ static int rpm_get_suppliers(struct device *dev)
>   * and if @check_idle is set, check if that device is idle (and so it can be
>   * suspended).
>   */
> -void pm_runtime_release_supplier(struct device_link *link, bool check_idle)
> +void pm_runtime_release_supplier(struct device_link *link, bool check_idle,
> +       bool drop)
>  {
>         struct device *supplier = link->supplier;
>
> +       /*
> +        * When consumer hold supplier, supplier cannot enter suspend.
> +        * Driect release supplier and let supplier enter suspend is not allow.
> +        * Unless the link is drop, direct relsease supplier should be okay.
> +        */
> +       if (link->supplier_preactivated && !drop)
> +               return;
> +
>         /*
>          * The additional power.usage_count check is a safety net in case
>          * the rpm_active refcount becomes saturated, in which case
> @@ -338,7 +347,7 @@ static void __rpm_put_suppliers(struct device *dev, bool try_to_suspend)
>
>         list_for_each_entry_rcu(link, &dev->links.suppliers, c_node,
>                                 device_links_read_lock_held())
> -               pm_runtime_release_supplier(link, try_to_suspend);
> +               pm_runtime_release_supplier(link, try_to_suspend, false);
>  }
>
>  static void rpm_put_suppliers(struct device *dev)
> @@ -1838,7 +1847,7 @@ void pm_runtime_drop_link(struct device_link *link)
>                 return;
>
>         pm_runtime_drop_link_count(link->consumer);
> -       pm_runtime_release_supplier(link, true);
> +       pm_runtime_release_supplier(link, true, true);
>  }
>
>  static bool pm_runtime_need_not_resume(struct device *dev)
> diff --git a/include/linux/pm_runtime.h b/include/linux/pm_runtime.h
> index 9e4d056967c6..354ffb1eaec0 100644
> --- a/include/linux/pm_runtime.h
> +++ b/include/linux/pm_runtime.h
> @@ -88,7 +88,8 @@ extern void pm_runtime_get_suppliers(struct device *dev);
>  extern void pm_runtime_put_suppliers(struct device *dev);
>  extern void pm_runtime_new_link(struct device *dev);
>  extern void pm_runtime_drop_link(struct device_link *link);
> -extern void pm_runtime_release_supplier(struct device_link *link, bool check_idle);
> +extern void pm_runtime_release_supplier(struct device_link *link,
> +       bool check_idle, bool drop);
>
>  extern int devm_pm_runtime_enable(struct device *dev);
>
> @@ -315,7 +316,7 @@ static inline void pm_runtime_put_suppliers(struct device *dev) {}
>  static inline void pm_runtime_new_link(struct device *dev) {}
>  static inline void pm_runtime_drop_link(struct device_link *link) {}
>  static inline void pm_runtime_release_supplier(struct device_link *link,
> -                                              bool check_idle) {}
> +                                              bool check_idle, bool drop) {}
>
>  #endif /* !CONFIG_PM */
>
> --
> 2.18.0
>
