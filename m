Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85B294E6A03
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 21:53:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354082AbiCXUyW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 16:54:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355534AbiCXUxJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 16:53:09 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8E83E0CC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:51:37 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id k10so7033519edj.2
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:51:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kWTv8rvzSud6vjQAPBruU1+NUsUkFIclJurG5+jMDKk=;
        b=iD6u/kx7rEMaMiEJQLhlCNXkeSS/pc5DIS25/uS7QK+u4Vx0am6v8p8Vnj/csxW/Dh
         Abo9xh6+gFlh1siWNxA6ksZo2zDZdU49sR4M0ZTN7yk44jPdjgQ+9PGdt5iLpcbAlJy5
         u77KgsNMtUPNxLuFfnPcVYDKBLswUw6B7jPVQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kWTv8rvzSud6vjQAPBruU1+NUsUkFIclJurG5+jMDKk=;
        b=7UnwtBaRCctcNAcvlTsr8kP3LfwWiYvoIaFeAsRc55B3D+owEZs27FPxUYP67U/KQC
         2oIGs2xjJ2NmHkWu9/RSlOQ5y8tRC/zdpEMxVSBTSdgoGsuRRMhkzVxf1uT8HLwQcvoS
         06faPrGveUxuhM/FiJ5ktyZG7Wk2WvZPku0KH99yc6cGH2RRu+2xs/7OvL2SFdsFknw7
         Kw/yQzimjHbUCtWkM3yKMagc7DqDOGTFWYasj+ilavn9/Moz/PcLX4TeEhLVsqjoG6Qd
         PBjx3mCIilR06EwNQDQkcfL8+WBVDBbKJfBluZYaSwSg7tD6BN1KEWiuFTAIQ83szagU
         MHtw==
X-Gm-Message-State: AOAM533TrhD3qR6oIyqh9HQlK+A5ACsqW3t3ajZLgnxRolkkzu4T7/Dp
        +EtJWpcgNNCdDhOqZxd4UInoDbsc+30nm56r
X-Google-Smtp-Source: ABdhPJx9h1UpU8kVRbXSAlNw0+u3Ph4n1mfEWcjwCzeQS1YPxJU4Lkla1UzOGojJvC7lFUSPO401YA==
X-Received: by 2002:a05:6402:198:b0:410:83e3:21d7 with SMTP id r24-20020a056402019800b0041083e321d7mr8934612edv.159.1648155095400;
        Thu, 24 Mar 2022 13:51:35 -0700 (PDT)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id 27-20020a17090600db00b006df6b34d9b8sm1546602eji.211.2022.03.24.13.51.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Mar 2022 13:51:34 -0700 (PDT)
Received: by mail-wr1-f54.google.com with SMTP id b19so8243000wrh.11
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 13:51:34 -0700 (PDT)
X-Received: by 2002:a05:6000:1704:b0:203:d857:aa7a with SMTP id
 n4-20020a056000170400b00203d857aa7amr5864281wrc.513.1648155093356; Thu, 24
 Mar 2022 13:51:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220324134819.v2.1.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
In-Reply-To: <20220324134819.v2.1.I816014b6c62da5a33af5021f3cc35cea66552c00@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 24 Mar 2022 13:51:21 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UdRzeHio5Vo+zmXDt9a8oUwXiZyHvxkqjx4HVcrx7W-g@mail.gmail.com>
Message-ID: <CAD=FV=UdRzeHio5Vo+zmXDt9a8oUwXiZyHvxkqjx4HVcrx7W-g@mail.gmail.com>
Subject: Re: [PATCH v2] panel-edp: drm/panel-edp: Add AUO B133UAN01
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        LKML <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Mar 24, 2022 at 1:48 PM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> Add support for the AUO B133UAN01 13.3" WUXGA panel.
>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
> Changes in v2:
> - autodetect and configure the panel based on the EDID data instead of
>   relying on a compatible string and hardcoded mode settings.
>
>  drivers/gpu/drm/panel/panel-edp.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>

Given the trivial nature of this change, I'll plan to land it in a few
days barring someone else yelling about it.

-Doug
