Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39AAC509340
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 00:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383031AbiDTXBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 19:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356367AbiDTXBl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 19:01:41 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32CB6167E8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:58:51 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id i3-20020a056830010300b00605468119c3so2098308otp.11
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 15:58:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:in-reply-to:references:from:user-agent:date:message-id
         :subject:to:cc;
        bh=D/sEi/2+cVqpCIq91LcVmWCZlF+pWsMqa17bfCQo3OU=;
        b=hCDsogPxydJMDkQ7gKztLKAEpi3v1TiAqC/NcA4UkhO4iJYHUO6SZDdqSxQwpv2H5j
         B0ZNeLFb4y3Bjtm7hPANo7XuEBdttK8x00YkOmhPzTxB/oeoUYgssEUDBzHanAgDxhOC
         x3fBBNGIdyLbaTTGWNeT9EySdGmM5ZGB6VmPI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:in-reply-to:references:from
         :user-agent:date:message-id:subject:to:cc;
        bh=D/sEi/2+cVqpCIq91LcVmWCZlF+pWsMqa17bfCQo3OU=;
        b=qd72uhyAhgGbhg9drzEEcjXvy/EifANhVH4zInLtlOY/B/uZnbPvyCxDJmB9ADn+es
         DDvNm2lYc8+XOR1HLy2EV9x+erDSeu431592rysgnPLstiPt7KIlHsNO5O7GKih+nPi/
         UHah6RUgq/SIaoygj5wXiirNrwEqwu2rWBAExTN9ouCJuceW5yTAPw4jc85x58xKqv0U
         iFEx69Rj+H+FUXvOiRVyZShTakiXvGmH7KitBliDTtqXjIySRimEix3/Q4Vk7hmto1X8
         0vYtP5SJI/sGBr6l7hD+zfzAbruxvqL3gbCqMXEtRgXzn1Ib8lu4GzSr3kM7JjFog31p
         EkSw==
X-Gm-Message-State: AOAM530dNXQ6IqOYDhiFWOw1O9w+rG53pCC0CC9W9X//OWP/RcQuRalt
        7MRfrWdzCtDJm+3bKvvcP1ckStFbEmc83M0tWqc4AQ==
X-Google-Smtp-Source: ABdhPJxVwjd5x5zLGqJQIHe9mf25daLALtOL8ozyt8Hvub9dABrVZsKj8sNwp81VZNO9erWnf6HfF7+CU1PIT/aikfw=
X-Received: by 2002:a9d:b85:0:b0:5cb:3eeb:d188 with SMTP id
 5-20020a9d0b85000000b005cb3eebd188mr8524679oth.77.1650495530519; Wed, 20 Apr
 2022 15:58:50 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 20 Apr 2022 15:58:49 -0700
MIME-Version: 1.0
In-Reply-To: <02d31565-4ae4-a319-30b0-76a6e4917f6f@quicinc.com>
References: <1649280493-4393-1-git-send-email-quic_khsieh@quicinc.com>
 <625ce8a0-4e25-5513-5599-c1cdebf5a3a5@linaro.org> <09fd563f-4a2c-f670-51c2-0e5ff023816d@quicinc.com>
 <CAA8EJpqzucFGf8ndDi2LZqtKiOt_w=_h1oPAUNVCdmUyh_3+zA@mail.gmail.com>
 <2039ef97-4fdb-bffe-1e02-18ae79c18be4@quicinc.com> <27bb2732-b322-75b0-3883-773e6eb4b1b9@linaro.org>
 <02d31565-4ae4-a319-30b0-76a6e4917f6f@quicinc.com>
From:   Stephen Boyd <swboyd@chromium.org>
User-Agent: alot/0.10
Date:   Wed, 20 Apr 2022 15:58:49 -0700
Message-ID: <CAE-0n51F+S4a2mQoyWa-TpJcd73hstm2Sh1uO+4T_75UaWQASQ@mail.gmail.com>
Subject: Re: [PATCH v2] drm/msm/dp: enhance both connect and disconnect
 pending_timeout handle
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Kuogee Hsieh <quic_khsieh@quicinc.com>
Cc:     robdclark@gmail.com, sean@poorly.run, vkoul@kernel.org,
        daniel@ffwll.ch, airlied@linux.ie, agross@kernel.org,
        bjorn.andersson@linaro.org, quic_abhinavk@quicinc.com,
        quic_aravindh@quicinc.com, quic_sbillaka@quicinc.com,
        freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Kuogee Hsieh (2022-04-15 17:06:48)
>
> On 4/14/2022 4:34 PM, Dmitry Baryshkov wrote:
> >
> > I'm not sure how should the driver react if the client doesn't disable
> > the output, but then the sink gets reattached?
>
> I do not know that either.
>
> But it should not happen as long as framework response to uevent.

In talking with seanpaul@ it sounds like we can update the link status
to BAD with drm_connector_set_link_status_property() and then put it
back to GOOD when the link is re-established. This way userspace will
know it needs to retry the modeset. Does that help here?
