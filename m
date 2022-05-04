Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32059519D1E
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 12:38:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348236AbiEDKlp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 4 May 2022 06:41:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348207AbiEDKlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 May 2022 06:41:32 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E63EF289BF
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 03:37:56 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id bq30so1604144lfb.3
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 03:37:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hXrHNwJC3BAV97iHU4og2HGxITVvzbeFV0KAKwYw/nI=;
        b=QTTdNNHxLgnl1v1dobnNNIk2xfsStVyPHrDEqovPV2KjeX8NQrpD0xCiZDb/x3oQFO
         LwKab/3vcamG1Nv6zhbuJiDlW4+pPxM3ynh8drc2LqBHXvAv6MztHHfeE/ns5yaBcZ0m
         ulSKV5CPTLVaKIjvaQVWxxIlfzvJRF/Uh2rF3/Bix5DaZoaJmUrMOtxjQHotAWoS9C0C
         yMc45JdckmSKuo9Qs4Xc/Y8Snz1ODJbFq2UBiN04hBiv9SeOHOW79fhgHqQIlsLUpy76
         6YLE3CxLBLsbYrToQL/1cLrNt7caLUc0XrHTiBAF90VQDXWsOGw5Vphlk7rIPgDPcGVl
         Jseg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hXrHNwJC3BAV97iHU4og2HGxITVvzbeFV0KAKwYw/nI=;
        b=M3h9XcVGjGW9umJjC19/ocGG01YP7MS9qAq2azYwglz8VYUwRMtOwgPGWhMOVWQo5j
         RjrLQkr1bBPj2VLUljzKLAOP77hU559d/URQQ6QoE36mcgAht1xWWc0aWkz1ZoQc46Nb
         WTF/Z9F2AC8+0iz6vVo0CvV2AYByDpZBPb91UGCgCIOhdqiA12/nmoNYeCfmrIYDM93h
         P09oudnHqV35ByANLYIRDCFaKyzf4CWWA40I1IFNsVpP/mBm5oPGIRyukgpsYKFQ4ye9
         ia5X4z7og1IIa6WvNlAUfwXFZitvj8agi7D23fJdJ1ef4R3CN7ZLbLOjlRBUDFoaP9iC
         YbLA==
X-Gm-Message-State: AOAM533wnZ5MaFVpYvgrjTJH77vIDAwHYMVKc7yZZ0+C6GGMSEzWskJz
        A7e1vvzkJLJR30pdINS5m4ydYpKaQUOS4h58bLisOA==
X-Google-Smtp-Source: ABdhPJyvrZpc1dvJUHpgzPqhSF7EzFjSFbIrL2BjM/E8E9i49RX6cCpueU1FHEwqnwkLycU6waf9TfwywbIR9IY7q7k=
X-Received: by 2002:a05:6512:5cb:b0:472:f7e:a5f5 with SMTP id
 o11-20020a05651205cb00b004720f7ea5f5mr13185193lfo.358.1651660675327; Wed, 04
 May 2022 03:37:55 -0700 (PDT)
MIME-Version: 1.0
References: <20220425105339.3515368-1-chi.minghao@zte.com.cn>
In-Reply-To: <20220425105339.3515368-1-chi.minghao@zte.com.cn>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Wed, 4 May 2022 12:37:18 +0200
Message-ID: <CAPDyKFporsmucBfHWN4vuBTmGNFKM028K6AWZu9k2rAb2cfZRw@mail.gmail.com>
Subject: Re: [PATCH] mmc: block: use kobj_to_dev()
To:     cgel.zte@gmail.com
Cc:     axboe@kernel.dk, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Minghao Chi <chi.minghao@zte.com.cn>,
        Zeal Robot <zealci@zte.com.cn>
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

On Mon, 25 Apr 2022 at 12:53, <cgel.zte@gmail.com> wrote:
>
> From: Minghao Chi <chi.minghao@zte.com.cn>
>
> Use kobj_to_dev() instead of open-coding it.
>
> Reported-by: Zeal Robot <zealci@zte.com.cn>
> Signed-off-by: Minghao Chi <chi.minghao@zte.com.cn>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/block.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
> index b35e7a95798b..983151b7296d 100644
> --- a/drivers/mmc/core/block.c
> +++ b/drivers/mmc/core/block.c
> @@ -330,7 +330,7 @@ static struct attribute *mmc_disk_attrs[] = {
>  static umode_t mmc_disk_attrs_is_visible(struct kobject *kobj,
>                 struct attribute *a, int n)
>  {
> -       struct device *dev = container_of(kobj, struct device, kobj);
> +       struct device *dev = kobj_to_dev(kobj);
>         struct mmc_blk_data *md = mmc_blk_get(dev_to_disk(dev));
>         umode_t mode = a->mode;
>
> --
> 2.25.1
>
>
