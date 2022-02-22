Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68B994BEFDE
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 04:16:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239428AbiBVCzT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 21:55:19 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231241AbiBVCzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 21:55:18 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A3D525C72
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:54:54 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id p19so38154008ybc.6
        for <linux-kernel@vger.kernel.org>; Mon, 21 Feb 2022 18:54:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pTWIyZP+k2rrcUY6YOsZs3zseacI9EWGSS4sqz8sNKo=;
        b=FlXakkD+veWuWTWzUSD+2VkyDXMB+4bB9g8EA034TbiDOBbKPBTPGiqf00xbHyAj+R
         1+JmVDdBYIm6fYnXMzHNeMJbj1npKms53i7mKbDRaUGMV4dgh4g9QZbgGVgTK3biZ7er
         XMGqeD2yf6pnwGr1mKQMj+vpnpmSsvcHkIdOw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pTWIyZP+k2rrcUY6YOsZs3zseacI9EWGSS4sqz8sNKo=;
        b=gfOO7NKGtMHPkCfhscNpQtM5w++O5ytk6QWa7HylTM1yqmkXWRYVN81g9hrkb8J2/8
         IexDFpGZMiyC2QdKq7wfJEauF6VGC+9ijVsO6m8u6EFkutz00rTFm+XILNAFC+1eRuY3
         rWnkEkUltu5PZ+nDw7e4znbskrh0xkRvc5GcZQdm0hSM42t9f8KxJmS+5IhugAdnS2OO
         aymcbJolCYZEqwC3Hu7ajJJufUmbSPbiDK44GxtCpUQ1OKMEv+49oANUVboysDqfn2e6
         XXzXVbHhNIj1b7rCdLY+7PSTkjxYp120dxWSrlxCxMiZmeZqZmL6UIZKnV7qA/rSsxrY
         uTMg==
X-Gm-Message-State: AOAM531CszUnbRKLUKuh03yyY54RHp52FSfs38b1ZPjwxx5Arp59w0na
        XW63h2rcmY0bfDlLaMfE0Qj9CVO0A+jyso1y98c7cw==
X-Google-Smtp-Source: ABdhPJxXIWOV/8KmJIE6h3WY3JKwFygbyCz14qlx7kc+P1HhRD+kKQCYKOodK7IlxfG6jXwUsmQnJtv3ciFVybw35TM=
X-Received: by 2002:a25:2393:0:b0:61d:f1c0:a779 with SMTP id
 j141-20020a252393000000b0061df1c0a779mr20155835ybj.461.1645498493375; Mon, 21
 Feb 2022 18:54:53 -0800 (PST)
MIME-Version: 1.0
References: <20220210141931.291712-1-angelogioacchino.delregno@collabora.com>
 <20220210141931.291712-6-angelogioacchino.delregno@collabora.com>
 <CAGXv+5H0OkMk=1MZH3jCFSZbauJmEcgFADfDXDPf2r1wrp8wCw@mail.gmail.com> <211bd3ca-f786-b161-6f3d-dc6b8471ffc7@collabora.com>
In-Reply-To: <211bd3ca-f786-b161-6f3d-dc6b8471ffc7@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 22 Feb 2022 10:54:42 +0800
Message-ID: <CAGXv+5F9tdu=K0R1QGT-wj5zX-der+pxP5aWA1zcpGBmH0gUjw@mail.gmail.com>
Subject: Re: [PATCH 5/5] pinctrl: mediatek: common-v1: Commonize
 spec_ies_smt_set callback
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sean.wang@kernel.org, linus.walleij@linaro.org,
        matthias.bgg@gmail.com, linux-mediatek@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 9:40 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Il 21/02/22 10:58, Chen-Yu Tsai ha scritto:
> > On Thu, Feb 10, 2022 at 10:21 PM AngeloGioacchino Del Regno
> > <angelogioacchino.delregno@collabora.com> wrote:
> >>
> >> All of the MediaTek pinctrl drivers registering with pinctrl-mtk-common
> >> that are offering a .spec_ies_smt_set() callback are declaring their
> >> own function which is doing exactly the same on all drivers: calling
> >> mtk_pconf_spec_set_ies_smt_range() with their struct and a simple check.
> >>
> >> Commonize this callback by adding the ies and smt structure pointers
> >> to struct mtk_pinctrl_devdata and changing the callback signature to
> >> take it.
> >>
> >> Removing the callback and checking for the existence of the spec_smt
> >> and/or spec_ies data would allow us to staticize the function
> >> mtk_pconf_spec_set_ies_smt_range(), but this solution was avoided as
> >> to keep flexibility, as some SoCs may need to perform a very different
> >> operation compared to what this commonized function is doing.
> >>
> >> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> >
> > Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
>
> Hi Chen-Yu,
>
> did you mean Reviewed-by? :-)

(facepalm) Yes.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
