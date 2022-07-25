Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05A23580330
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 18:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236606AbiGYQ4c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 12:56:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236595AbiGYQ4a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 12:56:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728EC63EF;
        Mon, 25 Jul 2022 09:56:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F1CC6133A;
        Mon, 25 Jul 2022 16:56:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DE71C341C6;
        Mon, 25 Jul 2022 16:56:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658768189;
        bh=tA7ufvftUZ4Si6vln+XGsiLl02n/Q0rUD3gC+QeQ6/g=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=gHg1tyKc/Cx/ozxH37SOsT7MaLsHimHxPGrgEFZIMTI1JRhygETidNKyH97IKsoVG
         as9wPqUsK2P0LkDLB5FRSDFkMMrk0USMDiwV/uoS8dKgTj5qwP1Si2bYfwRJNg09Yd
         JGSI5Ym/vlc9zX50BCgqT2X17Pe6M3YoZWDXC1O7EwpILWlQMraoS64v9k3dR0O7as
         ik+ttkEehtbl6fBi0MQJZLY9C95XhXdW38GlmtTY7lMvOeyWowN6eFoZFq2SD5wNi0
         Reo1x1ncF4+74ag+P0Mb+vAxfSoxoSetxBrVL5S2Asp88BuQZhzbpnN22PMS0CEySb
         rSoLpXzRkTp6w==
Received: by mail-vs1-f53.google.com with SMTP id b67so3525414vsc.1;
        Mon, 25 Jul 2022 09:56:29 -0700 (PDT)
X-Gm-Message-State: AJIora90/n5qBaBUgG/0OKlRoi4Px0esew/SoSEYtK1yDMcrRHN35CYv
        duYu1UAn4rGjG1UDycQNgLifDDs1XH3tCUxsOQ==
X-Google-Smtp-Source: AGRyM1s+RbKXY0yZYZSQLq13nI/L92i26QjHoCKT82M1PO/ve6CZT1LCzTjXhEKgoXZlXqcpFZee2SPd9TEoYycEyK4=
X-Received: by 2002:a67:c18d:0:b0:358:5bb6:2135 with SMTP id
 h13-20020a67c18d000000b003585bb62135mr1654050vsj.53.1658768188442; Mon, 25
 Jul 2022 09:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220725155955.46439-1-goriainov@ispras.ru>
In-Reply-To: <20220725155955.46439-1-goriainov@ispras.ru>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Mon, 25 Jul 2022 10:56:17 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLGMAx=C8hm+MD5mOfQD31Nhz=DrtBg3230q6qBMzyRog@mail.gmail.com>
Message-ID: <CAL_JsqLGMAx=C8hm+MD5mOfQD31Nhz=DrtBg3230q6qBMzyRog@mail.gmail.com>
Subject: Re: [PATCH] scripts/dtc: Fix memory leak in check_msg()
To:     Stanislav Goriainov <goriainov@ispras.ru>
Cc:     Frank Rowand <frowand.list@gmail.com>, devicetree@vger.kernel.org,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        ldv-project@linuxtesting.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 25, 2022 at 10:00 AM Stanislav Goriainov
<goriainov@ispras.ru> wrote:
>
> When the function check_msg() is called, memory for str is allocated
> via xasprintf() and xasprintf_append() (as well as for file_str),
> but is not freed anywhere later (although file_str is).
>
> Found by Linux Verification Center (linuxtesting.org) with SVACE.
>
> Fixes: c2e7075ca830 ("scripts/dtc: Update to upstream version v1.4.7-57-gf267e674d145")

scripts/dtc/ is sync'ed periodically with upstream dtc. We don't take
patches against it. You must submit this to upstream dtc.

> Signed-off-by: Stanislav Goriainov <goriainov@ispras.ru>
> ---
>  scripts/dtc/checks.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/dtc/checks.c b/scripts/dtc/checks.c
> index 781ba1129a8e..92ffc8de6a52 100644
> --- a/scripts/dtc/checks.c
> +++ b/scripts/dtc/checks.c
> @@ -114,6 +114,7 @@ static inline void  PRINTF(5, 6) check_msg(struct check *c, struct dt_info *dti,
>         }
>
>         fputs(str, stderr);
> +       free(str);
>  }
>
>  #define FAIL(c, dti, node, ...)                                                \
> -- 2.34.1
>
