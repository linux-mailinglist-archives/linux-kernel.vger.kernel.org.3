Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B1E35A0035
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 19:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239977AbiHXRR4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 13:17:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236489AbiHXRRx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 13:17:53 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34BF07C1FA
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:17:49 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id h9-20020a9d5549000000b0063727299bb4so12232748oti.9
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 10:17:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:from:to:cc;
        bh=MHYuEVNrNq6xOFLpayXIejomNu0GT0DBxEs7vGrd158=;
        b=WZmQ7PLNtEHmn6SJrYb0tXJV3lUfaM74pbLSdSKR9LMnaK5kGCvh1f3QY7J38pSoIB
         ik74LCQK95MUwF5xTdiHJ3JJ/wd36IqnmQneCLEzyFZ4ghGmFUX4vvXUG+dSM9XM77Nv
         lk/NSNsGdkxOFaxjdiv4zfitg8B6AUUzfSsrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:user-agent:from:references
         :in-reply-to:mime-version:x-gm-message-state:from:to:cc;
        bh=MHYuEVNrNq6xOFLpayXIejomNu0GT0DBxEs7vGrd158=;
        b=ALB8wUblQ9D9ebfmsaixiIfapymTUE9pq9TFZkdJAFyzftr8kVyq6Dm9BCE5ATlBAu
         RuAL9h8tMIMVrUraKxVFT69vCqgQxXKbNE5UPQOsCdgMk40nt+44Wdnu1XciaLOk6lSy
         lQQQ0vafltLZppe8418CqjlvTYTwWeg8XFiXWY7ZSiQ9uioqx9kuijF/EfgOPW5LXNY/
         vbtMfZxcxxETs/37VQ8Bzjqh6dA9LvBzPrYm6GsyElriMKr3tjpAC9efNZ3srCIFkUlQ
         P++UcQcRgG++feB+ByhGf7Crfsk9XDHYo7A3QsCGPHe0UhJLdOoEeoVbwDrCUhKg+R9Q
         h60w==
X-Gm-Message-State: ACgBeo3zpWwJacVOqRJ64Ltm3OjOOWAwIXZl0C+ptxifzHRZzLv4hlOg
        cBXI20/5QeRYb9eZ4I5sIJLYobuKP2eB402oHJobjQ==
X-Google-Smtp-Source: AA6agR4zBshr+gUc3WgavtY1TB1LNAO6aNOk9NTWdc2ol+fbKgwzW7gL98pe4oEy1a7xXcIHJjx4KwfdSoBCPBzli14=
X-Received: by 2002:a9d:738c:0:b0:638:9962:8cb6 with SMTP id
 j12-20020a9d738c000000b0063899628cb6mr11204441otk.73.1661361468554; Wed, 24
 Aug 2022 10:17:48 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 24 Aug 2022 12:17:47 -0500
MIME-Version: 1.0
In-Reply-To: <1661360356-21948-1-git-send-email-quic_khsieh@quicinc.com>
References: <1661360356-21948-1-git-send-email-quic_khsieh@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 24 Aug 2022 12:17:47 -0500
Message-ID: <CAE-0n52Mqv-qqb4n_Q4iO-reSncNikWd-2xNVG7pgwvx2ThTHw@mail.gmail.com>
Subject: Re: [PATCH] drm/msm/dp: correct 1.62G link rate at dp_catalog_ctrl_config_msa()
To:     Kuogee Hsieh <quic_khsieh@quicinc.com>, agross@kernel.org,
        airlied@linux.ie, bjorn.andersson@linaro.org, daniel@ffwll.ch,
        dianders@chromium.org, dmitry.baryshkov@linaro.org,
        robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org
Cc:     quic_abhinavk@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
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

Quoting Kuogee Hsieh (2022-08-24 09:59:16)
> At current implementation there is an extra 0 at 1.62G link rate which cause
> no correct pixel_div selected for 1.62G link rate to calculate mvid and nvid.
> This patch delete the extra 0 to have mvid and nvid be calculated correctly.
>
> Fixes: 937f941ca06f  "drm/msm/dp: Use qmp phy for DP PLL and PHY"

Should be

Fixes: 937f941ca06f ("drm/msm/dp: Use qmp phy for DP PLL and PHY")

> Signed-off-by: Kuogee Hsieh <quic_khsieh@quicinc.com>
> ---

Good catch! Thanks for fixing it.

Reviewed-by: Stephen Boyd <swboyd@chromium.org>
