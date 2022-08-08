Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6061D58CF6F
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 22:54:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbiHHUyh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 16:54:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244453AbiHHUyc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 16:54:32 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70BB215FDB
        for <linux-kernel@vger.kernel.org>; Mon,  8 Aug 2022 13:54:31 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id e127so15469928yba.12
        for <linux-kernel@vger.kernel.org>; Mon, 08 Aug 2022 13:54:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=aTpTyem7hydQrdauCJI2WQMASMRymFSEwd0UcF/UCsE=;
        b=XMP9oSMoQ90wtPcC/91xLp5SbJZA38a60hNa0NEz2TRR/auLCJsAO7NTaIfU8N1hN1
         4hdX8eAxd+EJQbsm554CuEr3RU4y0QFOTWo+6HByymPBGVRWgfLzkC12nsDfo+MwbCFp
         7UR8TdExmh6VrTcXylcMI/6zheq0oWhVfm8P0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=aTpTyem7hydQrdauCJI2WQMASMRymFSEwd0UcF/UCsE=;
        b=6FetjwwkWucrSktbpTprVEqMjGb1otlPXhEsVa6bgHavqdSenk4E5lyTEP6YQIZ1NN
         TzbmfsmgPCqEYd0bwNWnW02qI90PXKJzftb3VlBhNDK41YMj1Y/2Rf17s4sTA0fk4rtZ
         ZWQVzu2ZUoBoLaztphGNOF5pPI+XqnILq2k8xcXxWubK4q673YAIu5ecyS4NdzGCpEm3
         R5VSYujdfbJ0WSq54zfWbm4U/8P+JRS8cu/XtmSxQRF1wH7Q8CqMFyuMY5KkgbPdxvIh
         CtivXwhdkphEAm77QfoOWsVY9Ca5TbJPHt61bntBbzoEE/7XmI3TpHDX/rCd55LOAaw2
         F6Gg==
X-Gm-Message-State: ACgBeo0OKDt0NpCUj8Yxq39j9N9v/m5WdR5ZNjkKVqHgbd+uqVx1B/OD
        YLG4g3o1zJsic/yEJrnfbpw9gNHwUlTrvHDXQ42nJA==
X-Google-Smtp-Source: AA6agR47bYiQ/YcerY6PgRCIknae0Vr9RwG714iEU/HdDhjsTL85y/os3T9qGlLDZdANpmzmh9gl56FBuqOx7pf/bDI=
X-Received: by 2002:a25:7450:0:b0:67b:e79c:a1be with SMTP id
 p77-20020a257450000000b0067be79ca1bemr6570428ybc.196.1659992070709; Mon, 08
 Aug 2022 13:54:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220805151551.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
In-Reply-To: <20220805151551.1.Idd188ff3f9caddebc17ac357a13005f93333c21f@changeid>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Mon, 8 Aug 2022 13:54:19 -0700
Message-ID: <CACeCKafDg3VE0C8ZELvoET==RtmSpOHxC5R4Fnxmyyt+XSF3tA@mail.gmail.com>
Subject: Re: [PATCH] platform/chrome: cros_ec: Expose suspend_timeout in debugfs
To:     Evan Green <evgreen@chromium.org>
Cc:     Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Rajat Jain <rajatja@chromium.org>,
        Benson Leung <bleung@chromium.org>,
        Guenter Roeck <groeck@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Evan,

On Fri, Aug 5, 2022 at 3:17 PM Evan Green <evgreen@chromium.org> wrote:
>
> diff --git a/drivers/platform/chrome/cros_ec_debugfs.c b/drivers/platform/chrome/cros_ec_debugfs.c
> index 0dbceee87a4b1a..530378bd4359dd 100644
> --- a/drivers/platform/chrome/cros_ec_debugfs.c
> +++ b/drivers/platform/chrome/cros_ec_debugfs.c
> @@ -470,6 +470,9 @@ static int cros_ec_debugfs_probe(struct platform_device *pd)
>         debugfs_create_x32("last_resume_result", 0444, debug_info->dir,
>                            &ec->ec_dev->last_resume_result);
>
> +       debugfs_create_u16("suspend_timeout", 0664, debug_info->dir,
> +                          &ec->ec_dev->suspend_timeout);

Can we call this "suspend_timeout_ms" instead? That makes it clear what the
units being used are.

BR,

- Prashant
