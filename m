Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2FF55986D4
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 17:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344007AbiHRPD4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 11:03:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344012AbiHRPDr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 11:03:47 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F5A24082
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:03:41 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id j8so3735389ejx.9
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:03:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=80/EAklMgMmVc7+HRt3hhNecCleYekXbl0EPWCDjc+c=;
        b=eE33E4S6PX1YDzLHM0eWlaaEQtcHJ/gF4SGTxR+tXmvZZ1Cnv+qlD1aXH8fiSvuWWl
         hQ2HggDjmDis3NZLY79V1oMy4KhjFqNclXM91U+/iIQsnIdie00suskSyk761MUhqh1j
         1gZXQabGb6GZ9vg3rv5LcNibMTmJuCK+ve3j4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=80/EAklMgMmVc7+HRt3hhNecCleYekXbl0EPWCDjc+c=;
        b=jsFmR8Qrw20J0U1A/S8eAelY41vgbVazuSITLQtaT2Nw9GKleHIEy7ePeYw8eYaEys
         5cx0sPzva4NJIEk7zrTY1ElkB7VZF70nisE7eTGYnfN9b0BGXiRRkxTx8dCe9ISjpHI/
         W9CNUmV5Ac77u5E0b/uVKN4Vq+x65RH383GMbxBBEc1Q3rCjgcOXwANF9t9P+XMpVfu/
         GI/HKColbw/JxDCwJyrtrhf5M/ict/tBVz/78Weo3MWeUJ7ZvWLRt/hxoZ0Vg2mcXjWe
         94hWfrFsusxxLNoWAG5GQZjbBG6rXLmsk0dWvUj+W/MgtCNkeo1+r70Z19IEaRB8KrfP
         W3SQ==
X-Gm-Message-State: ACgBeo1aOA5Wm/N52wOqaTWfdcqhvl/+pKXpxwvXsSuWRrBg3J7RCkW/
        46Yq/ObTikVrBmT4lDsMTsDVcC3u/fHhXQFj
X-Google-Smtp-Source: AA6agR4/dcGFrTAlIPeVw1qvLHxjGGk9IcBx+RdEbK+qhj9L78phkpRI8HxJIRNp9c2mWeIcgj2kIg==
X-Received: by 2002:a17:907:d07:b0:72e:ec79:ad0f with SMTP id gn7-20020a1709070d0700b0072eec79ad0fmr2195376ejc.296.1660835018949;
        Thu, 18 Aug 2022 08:03:38 -0700 (PDT)
Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com. [209.85.128.44])
        by smtp.gmail.com with ESMTPSA id n22-20020a170906701600b007262a5e2204sm924845ejj.153.2022.08.18.08.03.37
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 Aug 2022 08:03:37 -0700 (PDT)
Received: by mail-wm1-f44.google.com with SMTP id k18-20020a05600c0b5200b003a5dab49d0bso1070469wmr.3
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 08:03:37 -0700 (PDT)
X-Received: by 2002:a05:600c:5114:b0:3a6:1ab9:5b3d with SMTP id
 o20-20020a05600c511400b003a61ab95b3dmr2104036wms.93.1660835017557; Thu, 18
 Aug 2022 08:03:37 -0700 (PDT)
MIME-Version: 1.0
References: <20220815093905.134164-1-hsinyi@chromium.org> <CAD=FV=XYNKF8q1mttru_J188pYMjSphQsEfQAO1Bt7GvjJRKXw@mail.gmail.com>
 <CAJMQK-gjg9evLY3oP5rgaGoRdQQTLqnK2-FChaabJTCxLTTmYA@mail.gmail.com>
 <CAMuczyUH1tefU_4+dx495_5kdrxRdA3pmXS-eyjzMCcYFfjNXQ@mail.gmail.com> <CAJMQK-jEgRq68JXSWtS4y5_39vJ1pWCT2-Atg31__veRtnuREA@mail.gmail.com>
In-Reply-To: <CAJMQK-jEgRq68JXSWtS4y5_39vJ1pWCT2-Atg31__veRtnuREA@mail.gmail.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Thu, 18 Aug 2022 08:03:24 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UXFiA4hW8_cmO0Di-NCpqvkjTqqOfbc6DfD5Rs8aT6hA@mail.gmail.com>
Message-ID: <CAD=FV=UXFiA4hW8_cmO0Di-NCpqvkjTqqOfbc6DfD5Rs8aT6hA@mail.gmail.com>
Subject: Re: [PATCH] drm/bridge: ps8640: Add double reset T4 and T5 to
 power-on sequence
To:     Hsin-Yi Wang <hsinyi@chromium.org>
Cc:     Rock Chiu <rock.chiu@paradetech.corp-partner.google.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 17, 2022 at 8:22 PM Hsin-Yi Wang <hsinyi@chromium.org> wrote:
>
> On Thu, Aug 18, 2022 at 11:19 AM Rock Chiu
> <rock.chiu@paradetech.corp-partner.google.com> wrote:
> >
> > How does T4/T5  impact the real case? We talked previously the T4/T5
> > shouldn't cause user impact.
> > Do we have testing data from ODM?
> >
> Please leave comments below the previous comment's headline.
>
> I'm confused. The reason I upstreamed this patch is because this is in
> your application note and you asked us to help upstream it. Now do you
> mean that we don't need T4 and T5?

I think Rock is asking what problems the extra delay is causing. In
other words: why do we care about keeping these delays short?

The answer is that it affects boot speed and also resume speed of
devices. Adding these two delays here means that there's an extra 100
ms before the user can see something on the screen. That may not seem
like a lot, but those kinds of delays add up quickly. At least on
Chromebooks, booting quickly is always a big goal.

-Doug
