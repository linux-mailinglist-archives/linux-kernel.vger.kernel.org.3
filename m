Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C2C474B805C
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 06:49:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344619AbiBPFg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 00:36:26 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230002AbiBPFgZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 00:36:25 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ED15FE41F;
        Tue, 15 Feb 2022 21:36:13 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id 195so1197217pgc.6;
        Tue, 15 Feb 2022 21:36:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=DHet3yLd9Skx6GUsFhlbjTrUaFrWYl/Ujhg4C1ElY0s=;
        b=hstIR6P2t0zMgZpmECKtmv0XRUeQRFgHkBIr0NItNxCqpLowRKUHu7rXPyLncUwKn2
         JqAEP+vSNix1/Pu1lZOIzSS2JpATKHW22y9d8VWAIdtBbHqO0OtkUOO9gW1woUNddrDn
         0o+2pJTZsJZ12NKEbQ1jmLyFy04zna0YnjqM3sfwdTFhdN3re4G6YlmI1VIB+BL7iNdW
         ywqh9vTLNWweD5v3pAs/Tw3RulhHSK8rPeJOO3d5CJeGIvnvE1Pu6oenvrS1kipkoiX5
         crhCV9Vn5F7Xp0La0J8+/PZwct6F6BNSkOTG1N4YEPWezG/JKr7gWPIFCwWTtlKvLsHN
         B7xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=DHet3yLd9Skx6GUsFhlbjTrUaFrWYl/Ujhg4C1ElY0s=;
        b=WScpXwdQq+BcLTOkq5QkRDn8G/uvbwTvPuw7JDOqseL/5tZ0wDCcD0RSl2nFfPXtAu
         FS0Q0+4/zILBY96YeXdyFSqbBMBTzBcXWY4f7l7/wPwfugwUcqCy/WvRNuyQPYLpLzLK
         xwmmseNX/yZe+bJUxJwkPxWasM3aSvx/1FimVu7MXa2+RtuXxhnOrw79EcyhBDXVldzF
         QbBYuSDYj9vuWjmpPVKUteTyqaIN0sRPRBbcCz33iv5pI04pI2ptW/qamV9H7mIZ95mr
         kh3iINpU5Z1+ziOOF0gYUbxpVqgQLOkHr3wqTF8YeTfPtXDvyOdOC3Hx8V7FsoT/yata
         LpFw==
X-Gm-Message-State: AOAM533mgtfOXxb/WDOpZWVoAr51mnMBT2MUySRc4HBzdoVu/W3xf1q3
        x1jQRnYG6kSD1kApjqkWd1gIKM9DY88=
X-Google-Smtp-Source: ABdhPJz2v0OfsBMOzK0oWK/dTBba7wXHr4UlPv6m4CAUvEpZpJ5Shehn+1PQChKGuSnD21yaojvQXA==
X-Received: by 2002:a05:6a00:10c8:b0:4e1:7e17:9ca0 with SMTP id d8-20020a056a0010c800b004e17e179ca0mr1576787pfu.72.1644989772612;
        Tue, 15 Feb 2022 21:36:12 -0800 (PST)
Received: from google.com ([2620:15c:202:201:4e4a:b0ff:e926:40e2])
        by smtp.gmail.com with ESMTPSA id o7sm4281006pfw.114.2022.02.15.21.36.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Feb 2022 21:36:11 -0800 (PST)
Date:   Tue, 15 Feb 2022 21:36:09 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     benjamin.tissoires@redhat.com, Jiri Kosina <jikos@kernel.org>,
        linux-kernel@vger.kernel.org, linux-input@vger.kernel.org,
        Sean O'Brien <seobrien@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
Subject: Re: [PATCH v3 1/4] Input: Extract ChromeOS vivaldi physmap show
 function
Message-ID: <YgyNScQJNVjJpqEc@google.com>
References: <20220211012510.1198155-1-swboyd@chromium.org>
 <20220211012510.1198155-2-swboyd@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220211012510.1198155-2-swboyd@chromium.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 05:25:07PM -0800, Stephen Boyd wrote:
> Let's introduce a common library file for the physmap show function
> duplicated between three different keyboard drivers. This largely copies
> the code from cros_ec_keyb.c which has the most recent version of the
> show function, while using the vivaldi_data struct from the hid-vivaldi
> driver. This saves a small amount of space in an allyesconfig build.
> 
> $ ./scripts/bloat-o-meter vmlinux.before vmlinux.after
> 
> add/remove: 3/0 grow/shrink: 2/3 up/down: 412/-720 (-308)
> Function                                     old     new   delta
> vivaldi_function_row_physmap_show              -     292    +292
> _sub_I_65535_1                           1057564 1057616     +52
> _sub_D_65535_0                           1057564 1057616     +52
> e843419@49f2_00062737_9b04                     -       8      +8
> e843419@20f6_0002a34d_35bc                     -       8      +8
> atkbd_parse_fwnode_data                      480     472      -8
> atkbd_do_show_function_row_physmap           316      76    -240
> function_row_physmap_show                    620     148    -472
> Total: Before=285581925, After=285581617, chg -0.00%
> 
> Cc: Jiri Kosina <jikos@kernel.org>
> Cc: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Cc: "Sean O'Brien" <seobrien@chromium.org>
> Cc: Douglas Anderson <dianders@chromium.org>
> Cc: Zhengqiao Xia <xiazhengqiao@huaqin.corp-partner.google.com>
> Signed-off-by: Stephen Boyd <swboyd@chromium.org>
> ---
>  drivers/hid/Kconfig                   |  1 +
>  drivers/hid/hid-vivaldi.c             | 27 +++++--------------
>  drivers/input/Kconfig                 |  7 +++++
>  drivers/input/Makefile                |  1 +
>  drivers/input/keyboard/Kconfig        |  2 ++
>  drivers/input/keyboard/atkbd.c        | 22 +++++----------
>  drivers/input/keyboard/cros_ec_keyb.c | 32 ++++++++--------------
>  drivers/input/vivaldi-keymap.c        | 39 +++++++++++++++++++++++++++
>  include/linux/input/vivaldi-keymap.h  | 28 +++++++++++++++++++

Since you called the config INPUT_VIVALDIFMAP I think we should call
these files vivaldi-fmap.(h|c) as well. They are not really keymaps.

Anyway, this makes sense to me. Jiri, Benjamin, do you want to merge
this or do you want to take it all throgh your tree?

Thanks.

-- 
Dmitry
