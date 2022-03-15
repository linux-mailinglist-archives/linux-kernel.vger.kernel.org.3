Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CE44D95AB
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 08:52:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345696AbiCOHxu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 03:53:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345685AbiCOHxq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 03:53:46 -0400
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B6714BB9F;
        Tue, 15 Mar 2022 00:52:35 -0700 (PDT)
Received: by mail-qv1-f53.google.com with SMTP id im7so14425392qvb.4;
        Tue, 15 Mar 2022 00:52:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dLrWH/HTunHeNVedUT22wD7fuCnOVdEr3MibPq0EL+Y=;
        b=bWDLP7LVucTaZ+It9568Zs7W5OTWxw7DW+8xLKUZEKGn0R1EAroa5aFzxG3cyA7a1G
         BwwHES9sGgP/YCvi/AeygU0mADEdt5D8t3dQEHan42mZEfOsNMmnLUeYuH5cuRlJhw+C
         5400yDWKDBMnAh2M4kjaZwMQtL1hxTviAkse1E9GeTHum18CVZetkfYQ4o0CN5OE09tc
         8/ctSX2WfPrM8D2XNWMeLrmZp0EstKP4IDOa2TaFaljJ3mjei5LnZh4EB025ohQEs4GH
         IV5Fi/KpLHiavcQZz7PrF48uB4UYT2gtsfkjjhCTODZTIKNh2k1YXzIxKBsoycxibWjq
         uCig==
X-Gm-Message-State: AOAM533lGPKVvQMJjNJK+mQNgYmus+VWuClic/3GtmziNcYFmiA/pZik
        uz/j9J6QYVaAeHE7AOwXy+RA2MRoHR+mSw==
X-Google-Smtp-Source: ABdhPJwnGOcVjQQdgTn6iyrfVUcGkW82/pSUkvILuxFkyhghLPZibE7XkFBL83fx/k8/SBfUFiokzQ==
X-Received: by 2002:ad4:5b81:0:b0:440:a6f5:1fc3 with SMTP id 1-20020ad45b81000000b00440a6f51fc3mr7820809qvp.57.1647330754021;
        Tue, 15 Mar 2022 00:52:34 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id n8-20020ac85a08000000b002e06aa02021sm12770033qta.49.2022.03.15.00.52.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Mar 2022 00:52:33 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id t11so3941506ybi.6;
        Tue, 15 Mar 2022 00:52:33 -0700 (PDT)
X-Received: by 2002:a25:bc8f:0:b0:628:8649:5c4b with SMTP id
 e15-20020a25bc8f000000b0062886495c4bmr21295331ybk.207.1647330753044; Tue, 15
 Mar 2022 00:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1646683502.git.geert@linux-m68k.org> <8d3c0cc370b0214244b01a64c588e5e506531716.1646683502.git.geert@linux-m68k.org>
 <CAMuHMdVq19wpA_7nKKTm-G2EmK3cMxxP6nbR_u=vkazqCZ=KhQ@mail.gmail.com>
 <20220314170539.17400f93@eldfell> <CAMuHMdVj8wxAVbcov1wFsgt_knMkcySBH8nMoKjyr=G+mLQmjQ@mail.gmail.com>
 <1f915fcc-1d95-99d1-c7b7-dc4e3b49e09f@linux-m68k.org> <20220315093250.71352a56@eldfell>
 <CAMuHMdVU=JKwEn-=Wf3CYObtaLt2T7NmWrXUwdPHdvNsbgge=g@mail.gmail.com>
In-Reply-To: <CAMuHMdVU=JKwEn-=Wf3CYObtaLt2T7NmWrXUwdPHdvNsbgge=g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 15 Mar 2022 08:52:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdUOwVLBLmxaVUO4yADVCf1k7CyhBZiesHx2Fr4LW3QWMQ@mail.gmail.com>
Message-ID: <CAMuHMdUOwVLBLmxaVUO4yADVCf1k7CyhBZiesHx2Fr4LW3QWMQ@mail.gmail.com>
Subject: Re: [PATCH v2 05/10] drm/fourcc: Add DRM_FORMAT_C[124]
To:     Pekka Paalanen <ppaalanen@gmail.com>
Cc:     Finn Thain <fthain@linux-m68k.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Javier Martinez Canillas <javierm@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>, Helge Deller <deller@gmx.de>,
        Linux Fbdev development list <linux-fbdev@vger.kernel.org>,
        "Linux/m68k" <linux-m68k@vger.kernel.org>,
        DRI Development <dri-devel@lists.freedesktop.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
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

On Tue, Mar 15, 2022 at 8:51 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > Also, when drm_fourcc.h is describing pixel formats, it needs to
> > consider only how a little-endian CPU accesses them. That's how pixel
> > data in memory is described. Display hardware plays no part in that.
> > It is the driver's job to expose the pixel formats that match display
> > hardware behaviour.
>
> But if the "CPU format" does not match the "display support",

s/support/format/

> all pixel data must be converted?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
