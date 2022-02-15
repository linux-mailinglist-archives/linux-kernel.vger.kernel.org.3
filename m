Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 919544B79FF
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Feb 2022 22:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239800AbiBOVxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Feb 2022 16:53:36 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:49192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234702AbiBOVxe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Feb 2022 16:53:34 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1268BB5601
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:53:24 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 98057B81D0C
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:53:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 498DCC340EC
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 21:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644962001;
        bh=Vfxjv7E56iaOFRTCObvj3BvVuslFzvG2n3OckI8Aumw=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=ud/+h1cDLctFXinnhjFDRa48kZs/Sv+52aBGhae3CUMR1ixHIyIH5oYqHkxx9XxE9
         7YOMVJHo9ApG1yi86kyolWpX24iIZ5CKk0M7Efr0GaH2lRN09W8+tfOSi9CEEwaBgW
         F287c+HHEKXmgQjnXSbK8ljE5Zvb3vUO/A99T7aq1++sTdgtjqLlhHGYN0LX/iaxtL
         fAoLjjkmkJZnfigW7zjsYIrhhhP5rsqvqIX8tovq1acLLuab8QzCMidGE9xcUXIbHx
         aZ0wI+UffNxCzoesfDAlvnEwWezGtdxHOBYF4USCONazR2UrovVz7o9/+kA45D0g3u
         UV1O4Cw/kMenA==
Received: by mail-ed1-f52.google.com with SMTP id u18so555927edt.6
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 13:53:21 -0800 (PST)
X-Gm-Message-State: AOAM533mqAveGr/9IV1J1YllxhS3cBejHXkCT2UXVcibBysz1ewZOrri
        aWS2R07I5uwLuBhcu7uGqlGbHuwZVJclwcO4Pg==
X-Google-Smtp-Source: ABdhPJwYZKHAsuuqxukUb3ew/CZgg5aKKKTyuRP2EBIW3EIb7cJwFue/JUV1JPmJrNN+olDMIRRtpNXvf0a48ySSLUo=
X-Received: by 2002:a50:e68d:: with SMTP id z13mr993946edm.307.1644961999559;
 Tue, 15 Feb 2022 13:53:19 -0800 (PST)
MIME-Version: 1.0
References: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
In-Reply-To: <20220214203132.4722-1-alyssa.rosenzweig@collabora.com>
From:   Rob Herring <robh@kernel.org>
Date:   Tue, 15 Feb 2022 15:53:07 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKdb0_N252hR=iv3Lpi6T9+iCRBwzBQhS7UQGFNhM5k=A@mail.gmail.com>
Message-ID: <CAL_JsqKdb0_N252hR=iv3Lpi6T9+iCRBwzBQhS7UQGFNhM5k=A@mail.gmail.com>
Subject: Re: [PATCH] drm/panfrost: Dynamically allocate pm_domains
To:     Alyssa Rosenzweig <alyssa.rosenzweig@collabora.com>
Cc:     dri-devel <dri-devel@lists.freedesktop.org>,
        Tomeu Vizoso <tomeu.vizoso@collabora.com>,
        Steven Price <steven.price@arm.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 14, 2022 at 2:31 PM Alyssa Rosenzweig
<alyssa.rosenzweig@collabora.com> wrote:
>
> MT8192 requires 5 power domains. Rather than bump MAX_PM_DOMAINS and
> waste memory on every supported Panfrost chip, instead dynamically
> allocate pm_domain_devs and pm_domain_links. This adds some flexibility;
> it seems inevitable a new MediaTek device will require more than 5
> domains.
>
> On non-MediaTek devices, this saves a small amount of memory.

How much? You measured it?

It's not that simple. kmalloc has finite allocation sizes (see
/proc/slabinfo). So unless panfrost_device shrinks or grows to the
next smaller or larger size, the memory used doesn't change. And each
devm_kmalloc adds its own overhead as well.

I'd do the oneliner changing it to 5 and be done with it. That being
said, we have plenty of examples of doing this both ways, so whatever
makes people happy.

Rob
