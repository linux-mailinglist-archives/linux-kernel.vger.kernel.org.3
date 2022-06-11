Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9DBE5477CD
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 00:02:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232331AbiFKVzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 17:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiFKVzM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 17:55:12 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A95D248CF
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:55:11 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id h19so2972609edj.0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:55:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ghSA0tuQ6VU/fN8bZWOyRJMi2B9MX3nLEaeMYI+I+TA=;
        b=NRINHvlp/wCMpRoQYQm8j4hi5AFgFPobmgkp15BfbQcjmPOQ6/vXVNNBqpTd56zSVK
         BoydC9AqHmdYUgo4xPR5ZfyMvhyY6jJ5UEcN8SIhQOdiHdhKOb3ucYtJcjUY6a1bbAbT
         KFBgzvCjo/tvLNq7q/uMXiK9Kmr+whYMPca5o=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ghSA0tuQ6VU/fN8bZWOyRJMi2B9MX3nLEaeMYI+I+TA=;
        b=bPFDx3Pbs720z58/1KYV36FuLZwEYU+WbJpvWyhF4I+kPNMIuXAEz8ltZWcJqdCNoe
         QUbun4oTyo+XjUQTey2aemC6XXbx8HrHtdmy/hwooOE3mC1+uMEP9hgWIHXtTN1mOIV6
         e5wdhRrqlMxr0W2C4F1n9z3y6+NAoUFj5c8mDqpVvfUDbMGb+dH6PGprxzVpwb4Lbr66
         bTHue+8LfXTqxNL+pLpEHmhJAABLjDPvQNBq/7CCO1Qx+7giXOxsHcmh7eT4ENvLwXKq
         YQ/qSTagGT3+8yHINQ9i887aRvU42TlWhx7itj1Na1/gyH5YpPdurx+QRA4Ft0vLWYp/
         30xA==
X-Gm-Message-State: AOAM531Y/nsgPqwlQOtqhB/SFd3lDrjgrNOfY0SC15GMEOWFGy6ek3I4
        mftF9lY67+KzbwS2fZ99LGq0TJPM1kENUZ3A
X-Google-Smtp-Source: ABdhPJzctfs9bCmJOgY7J5wVY3cCFdpa9mw9RPLkMlTqRQ0ykn6ZI9nS7TM6mh6aINugtEZ1x5ajUw==
X-Received: by 2002:a05:6402:1e8b:b0:41c:59f6:2c26 with SMTP id f11-20020a0564021e8b00b0041c59f62c26mr57957809edf.156.1654984509500;
        Sat, 11 Jun 2022 14:55:09 -0700 (PDT)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id i19-20020a170906445300b006feba31171bsm1578399ejp.11.2022.06.11.14.55.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Jun 2022 14:55:07 -0700 (PDT)
Received: by mail-wr1-f41.google.com with SMTP id q15so2714901wrc.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 14:55:07 -0700 (PDT)
X-Received: by 2002:a5d:608d:0:b0:218:3cfa:afe9 with SMTP id
 w13-20020a5d608d000000b002183cfaafe9mr34490637wrt.422.1654984507137; Sat, 11
 Jun 2022 14:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20220611095445.1.I534072d346b1ebbf0db565b714de9b65cbb24651@changeid>
In-Reply-To: <20220611095445.1.I534072d346b1ebbf0db565b714de9b65cbb24651@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Sat, 11 Jun 2022 14:54:55 -0700
X-Gmail-Original-Message-ID: <CAD=FV=UPcBmCAd005rcARD_CemVwBd80QpDeVddO=Mcggg2Chw@mail.gmail.com>
Message-ID: <CAD=FV=UPcBmCAd005rcARD_CemVwBd80QpDeVddO=Mcggg2Chw@mail.gmail.com>
Subject: Re: [PATCH] drm: Fix htmldocs indentation warning w/ DP AUX power requirements
To:     dri-devel <dri-devel@lists.freedesktop.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Daniel Vetter <daniel@ffwll.ch>, David Airlie <airlied@linux.ie>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Jani Nikula <jani.nikula@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Lyude Paul <lyude@redhat.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        =?UTF-8?B?VmlsbGUgU3lyasOkbMOk?= <ville.syrjala@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
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

On Sat, Jun 11, 2022 at 9:55 AM Douglas Anderson <dianders@chromium.org> wrote:
>
> Two blank lines are needed to make the rst valid.
>
> Fixes: 69ef4a192bba ("drm: Document the power requirements for DP AUX transfers")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Douglas Anderson <dianders@chromium.org>
> ---
>
>  include/drm/display/drm_dp_helper.h | 2 ++
>  1 file changed, 2 insertions(+)

Pushed with Sam's Ack.

7d188c521d9e drm: Fix htmldocs indentation warning w/ DP AUX power requirements

-Doug
