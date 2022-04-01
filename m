Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00B544EEAED
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 12:03:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344889AbiDAKFb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 06:05:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344898AbiDAKFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 06:05:11 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B750616BF9B
        for <linux-kernel@vger.kernel.org>; Fri,  1 Apr 2022 03:03:22 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q19so2038792pgm.6
        for <linux-kernel@vger.kernel.org>; Fri, 01 Apr 2022 03:03:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tX+BPVS9BPv8n6VKzSXnF+wc68I5Je6Qk2J6Ghu6RDQ=;
        b=n9knzbXGB/jvF5BOCglcNRiyMIDFcfNQoZLTD2PfR8ROW2mvj+nV0iRrPEdLKZpSph
         vzguSb7cXa66bjzphVmti0yNptHSJQQlAQ6i7yVkYnors74fkIpWuC9+/Odv4N6xiou4
         P1/aduWBtjC0YlAzg0a1qF1MienP9LHtj8dNGo+LKuyI95nIEZ6GOuBWVzdz+NQACbci
         0WRRETdAVG5wG4w0Hi4DCQ6vliDs/yi5iwJk4+CIvvqunJLzmhe7/7TlroQoSbizUdzq
         62rYhZYgHiSBQLRfl9CvSawykOK0o7aWxB+WKpGLZ5Z6uy8GEwy5YJKqx65PTQVZF/Ac
         AQYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tX+BPVS9BPv8n6VKzSXnF+wc68I5Je6Qk2J6Ghu6RDQ=;
        b=3sU7k6XVy1rxQ0PykkzAh3PcXC3ETCeelh6vDnce18NSn5GO09AOybk6n4dlwb4Nwr
         r/hWwzZIh1WNXNDY80pWncK8ZAu7J7/WONaw8qAcIcIQJrxRrrGNomdDEPgsPJ2yeUfE
         SlOkK7K3nMoYoMKqqM+BtQX8bqncMPe5q7fSPbLaUEeqerKo0vVuaLSGkxpjckSH5XLV
         Q7f+pdUQlYYJRE37+15L3ZRoi8mepcCn94+cjBpFu5k77DPGGP2XbINbzPKh+gARRFJs
         xHwcEZHZstxtOdcvWsZf06EnNfp8mwipQAzflZl84EvF3mYdWVf6kRhn2W1btpDM8c60
         dcLA==
X-Gm-Message-State: AOAM5333+WWVYgzlcIvjcF3A+sByaChsIji1D7MpK15JFtePBChmmDOe
        Ozl05XptcTSCM8hXTBSjRiyjXC2Tp+4ON7T4A18=
X-Google-Smtp-Source: ABdhPJyIPfkp/BerqOovqJMj2WSOiOe9iqYASkuWLcLT7uQMcDzKykZZOUsc0aeY8wKuxeEpNgTHO8kXyukBN3JBL7Y=
X-Received: by 2002:a05:6a00:c85:b0:4fa:f806:10f5 with SMTP id
 a5-20020a056a000c8500b004faf80610f5mr10024572pfv.43.1648807402184; Fri, 01
 Apr 2022 03:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220330120246.25580-1-xiam0nd.tong@gmail.com> <20220330120246.25580-5-xiam0nd.tong@gmail.com>
In-Reply-To: <20220330120246.25580-5-xiam0nd.tong@gmail.com>
From:   Patrik Jakobsson <patrik.r.jakobsson@gmail.com>
Date:   Fri, 1 Apr 2022 12:03:10 +0200
Message-ID: <CAMeQTsa1YeB2GFyUUJ2PJxACZ2dgWprN8mneka=VXDn5o-7+HA@mail.gmail.com>
Subject: Re: [PATCH 4/5] gma500: fix a missing break in cdv_intel_dp_set_m_n
To:     Xiaomeng Tong <xiam0nd.tong@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        Zhao Yakui <yakui.zhao@intel.com>,
        Dave Airlie <airlied@redhat.com>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 2:03 PM Xiaomeng Tong <xiam0nd.tong@gmail.com> wrote:
>
> Instead of exiting the loop as expected when an entry is found, the
> list_for_each_entry() continues until the traversal is complete. It
> could lead to a invalid reference to 'lane_count/bpp' after the loop.
>
> The invalid reference to 'lane_count/bpp' is here:
>         cdv_intel_dp_compute_m_n(bpp, lane_count,
>
> To fix this, when found the entry, add a break after the switch statement.
>
> Fixes: 8695b61294356 ("gma500: Add the support of display port on CDV")
> Signed-off-by: Xiaomeng Tong <xiam0nd.tong@gmail.com>

This loop already breaks when the desired conditions are met (see the
if statements).

> ---
>  drivers/gpu/drm/gma500/cdv_intel_dp.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/drivers/gpu/drm/gma500/cdv_intel_dp.c b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> index ba6ad1466374..e6473b8da296 100644
> --- a/drivers/gpu/drm/gma500/cdv_intel_dp.c
> +++ b/drivers/gpu/drm/gma500/cdv_intel_dp.c
> @@ -1016,6 +1016,8 @@ cdv_intel_dp_set_m_n(struct drm_crtc *crtc, struct drm_display_mode *mode,
>                         bpp = dev_priv->edp.bpp;
>                         break;
>                 }
> +
> +               break;
>         }
>
>         /*
> --
> 2.17.1
>
