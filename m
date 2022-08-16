Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 599B85964DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 23:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237695AbiHPVpi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 17:45:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237694AbiHPVpf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 17:45:35 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4672B66A72
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:45:35 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-334dc616f86so12462707b3.8
        for <linux-kernel@vger.kernel.org>; Tue, 16 Aug 2022 14:45:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=cD5rOQ4YArx1DGntEs82qTS6C7ZmDFTWDSo8kt2UBGU=;
        b=PmNG5jn90K7uUN6EOmc8Cjgsv36j/xPfdmZWQ827X/Xi9w/o6L9uCvgHnURPDJYV6y
         DeUVaHu8DOfec/IGep8/lnmcJUNB7IU/RowaG9LJWDA7HXAMPWehh/HzuH4sNvoWF+oc
         788pMQ9JdxR6BUosX0S588IPIVrvdkSxLSc5U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=cD5rOQ4YArx1DGntEs82qTS6C7ZmDFTWDSo8kt2UBGU=;
        b=lyk885qfVFU+DB4lklCTX4QHt0LbvcCaJaA2KMhj1gWOKgML9kuQlNMXaT0dhh1cze
         bInw3nHz7nNSy0A8mn5kQ1pYJfi7DvWdRpugWYrTooaqpv+35htG18iXTJ1nM2d6M3w7
         D2yZ9VSokclkQoiPq+OWov5d9S7ys9UVSh31xdKDmWaS2Dld3Exe11cbRTZC/7eKNMuT
         Z74IYaY4NWtuElTFx7dSzj9qCtZGzBNh4yQfPvu6EDW3DZQRh8Ps7GTdMI3KPI3Q6MYE
         f5vDo+fC2fo/MUvrrswUIZ3Jg4NBZUl68d3PD79md1Sqo8AHOPUlq02Yi/tcGNaYRsiR
         /XMg==
X-Gm-Message-State: ACgBeo38gFQEoM4OOMrRO9RNMawd1yEkv+FyuNbwOk74EgaaUMYpy8AI
        a22mXmm6vWBkkO5uEdY1v95cvCd9RWfxHMJvJFLaXA==
X-Google-Smtp-Source: AA6agR6B+jEIHpD5t5DZH3quwJvxKWQ85YfNyChK128SiFlHpxaqCJYHLZdFD75IdFbZVQoovbPEi0L0Rcqx/nTZmAI=
X-Received: by 2002:a25:69c4:0:b0:68d:e2ba:b39d with SMTP id
 e187-20020a2569c4000000b0068de2bab39dmr4063922ybc.196.1660686334991; Tue, 16
 Aug 2022 14:45:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220815063555.1384505-1-pmalani@chromium.org>
 <20220815063555.1384505-5-pmalani@chromium.org> <YvsnE55zGVGxGpPv@google.com>
In-Reply-To: <YvsnE55zGVGxGpPv@google.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 16 Aug 2022 14:45:24 -0700
Message-ID: <CACeCKacHM7rOCziEXqRW7G24cgTi--vo76NrkCjwauxG4WbXDA@mail.gmail.com>
Subject: Re: [PATCH v5 4/7] platform/chrome: cros_typec_switch: Add event check
To:     Tzung-Bi Shih <tzungbi@kernel.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        bleung@chromium.org, Daisuke Nojiri <dnojiri@chromium.org>,
        "Dustin L. Howett" <dustin@howett.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Guenter Roeck <groeck@chromium.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Xiang wangx <wangxiang@cdjrlc.com>
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

On Mon, Aug 15, 2022 at 10:11 PM Tzung-Bi Shih <tzungbi@kernel.org> wrote:
>
> On Mon, Aug 15, 2022 at 06:34:24AM +0000, Prashant Malani wrote:
> > The Chrome EC updates Type-C status events when mux set requests from
>
> To be consistent to the series, I guess you would like to use ChromeOS
> instead of Chrome?

Fixed in v6.

>
> > +static int cros_typec_send_clear_event(struct cros_typec_switch_data *sdata, int port_num,
> > +                                    u32 events_mask)
> > +{
> [...]
> > +     return cros_ec_cmd(sdata->ec, 0, EC_CMD_TYPEC_CONTROL, &req,
> > +                        sizeof(req), NULL, 0);
>
> The line can join to the previous line without exceeding col-100.
Fixed in v6.
