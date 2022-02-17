Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63CA04BA593
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 17:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242993AbiBQQTA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 11:19:00 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239930AbiBQQS7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 11:18:59 -0500
Received: from mail-4317.proton.ch (mail-4317.proton.ch [185.70.43.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F293D26550B;
        Thu, 17 Feb 2022 08:18:43 -0800 (PST)
Date:   Thu, 17 Feb 2022 16:18:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=emersion.fr;
        s=protonmail2; t=1645114721;
        bh=xig78IbVhEkp/h3Vt76vo9JttYCE5O3eydjvdxHGgXU=;
        h=Date:To:From:Cc:Reply-To:Subject:Message-ID:In-Reply-To:
         References:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
         Message-ID;
        b=lqOBZMqEfCVq3VumfrDJrT7drykDVqUPX2D3vk364ddWATgj8xPNQrXL7fqBbtGpg
         c1b43UdLgmNm4g96P5YVN6Jq3Dd1PDCb9Qgl+/q81JHD42yDx5qm1Vl3QnE/P7ysLB
         wioiqgNVq2+cqYjnFIbcuRcouR9qQl9K6b5z45VxxxpTAuLEiBp+qHvIt5oWyt7NXG
         dWMUKvOU0bq5rH3P1yjDM2q9ISEdnvS7SOfpt1paw375giCIWg8IbBkyqgx4w8PM+I
         gV1/rSgl37Z383id/4R+onPCEUP9nj9N34qp2QwhppVkwSk77Ji3jo2VfsUBJ0nPuC
         rH48B50eaQYXQ==
To:     Geert Uytterhoeven <geert@linux-m68k.org>
From:   Simon Ser <contact@emersion.fr>
Cc:     Thomas Zimmermann <tzimmermann@suse.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        David Airlie <airlied@linux.ie>, Helge Deller <deller@gmx.de>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux/m68k <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>
Reply-To: Simon Ser <contact@emersion.fr>
Subject: Re: [PATCH 2/8] drm/fb-helper: Add support for DRM_FORMAT_C[124]
Message-ID: <z7NQYyKnuywG0bUt7Wr9e53SGgSZgbMVNKpLAOIP0mH3GljFQI3hd_aQFc8qaqwTbBq8yF3QvR9ugLxlivX-ogj508Vc60XHQPAN3IL5Uik=@emersion.fr>
In-Reply-To: <CAMuHMdVK7eWfod73JQAntO=7BAMEcS-ktH4NJmDjna3zUn7giw@mail.gmail.com>
References: <20220215165226.2738568-1-geert@linux-m68k.org> <20220215165226.2738568-3-geert@linux-m68k.org> <4fff0c08-adab-c1d5-4a7e-1513cb2bf7ca@suse.de> <CAMuHMdVK7eWfod73JQAntO=7BAMEcS-ktH4NJmDjna3zUn7giw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday, February 17th, 2022 at 17:12, Geert Uytterhoeven <geert@linux-=
m68k.org> wrote:

> > What is C0?
>
> A non-existing color-indexed mode with zero colors ;-)
> Introduced purely to make a check like in the comment below work.
> What we really want to check here is if the mode is color-indexed
> or not...

Maybe it would be worth introducing a drm_format_info_is_color_indexed
function? Would be self-describing when used, and would avoid to miss
some places to update when adding new color-indexed formats.
