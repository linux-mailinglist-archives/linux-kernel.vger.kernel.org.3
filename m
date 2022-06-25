Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3267155AD01
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 00:52:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233567AbiFYWv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 18:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233513AbiFYWv4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 18:51:56 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AE6813F39
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:51:55 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-3176d94c236so54942177b3.3
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 15:51:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x/3CJY8b07RBucsswH4q0R75uAfMe2AO1c8Bas6krMQ=;
        b=xp+KQrZlauuD2PE/DYgNZ7pEu5ZnYTvujmpuigZnI27SuYCTRDZ+6Uq69d826Ft5n4
         0ocKLmD1LJVQCIQM0g534Sp8j+mcafQ/lRP/YAXaK96Z0pL02FcHPhz/H4xbvzv7NXRs
         hqzeIYtW2QfHbrFxNmlm2EsXdsX6mdB4aNt+Hhh4pHsD+mBZjBxy1fYuDhdy/214s9bf
         B7lIZsHZsrduLVnF0p2mWI1C4b7dm4VYhSJgcTlSY/L8NJs9HSnR2CHmVhtfWpV4XhdW
         ha7mn2+M2TSHVhehLAQzirOJsaBcfSi3fjeRjtykv7iiFXsx3o2K0ww0DGoqrIF+dU/I
         0fMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x/3CJY8b07RBucsswH4q0R75uAfMe2AO1c8Bas6krMQ=;
        b=2N/TCFM8YHlBdnGTnVcioV8jcwkx0auZO2m3iX8cUgHql30T7aS11CtXPx3ZBKAGIp
         NH73ld/mW1kuzO+YBEM+rvC0WBNr8sbzoJpl1CuBRnH656ZlRrQxHqK8EkcYFD+dj3Jw
         vBXpoOLX+9+kKLnqFtTNlHBvMqNixtKLubYrsm3MLs9/yOKaoni60vUdQFd6RE1WrPcA
         GY9fDLdJw9FrwvIBYgXvhkDDmuZkkK8HmtYY4y0jObTrlDMch71kFfZW0HZwvZ6QgcBL
         T1Abpx9x3+9HeuTL6sTqdSULwoVMZr9s/ffKVRTxmz6Z9xhmMeYlzhizhms/7dl5KNtV
         NTfg==
X-Gm-Message-State: AJIora9K/upS+qA94+Kn+TYHyfvdC6/tF3goBEvheNOV1zRk1OsEwN8F
        K9WtcINBmzGaavspYd5cjPc28yx0fZVlMK3TldV+Kc28LHA=
X-Google-Smtp-Source: AGRyM1umXxfdalPMIDRFDGUVcUE4Jii7SRvJss2hlJNKGIYyu+4E52LaAQK1djFUeRB8dmAFR8j+DlFSVYQXtF4zXqw=
X-Received: by 2002:a0d:e20a:0:b0:317:ce36:a3a0 with SMTP id
 l10-20020a0de20a000000b00317ce36a3a0mr6827319ywe.448.1656197514196; Sat, 25
 Jun 2022 15:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <1654921357-16400-1-git-send-email-quic_srivasam@quicinc.com>
In-Reply-To: <1654921357-16400-1-git-send-email-quic_srivasam@quicinc.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Sun, 26 Jun 2022 00:51:43 +0200
Message-ID: <CACRpkdbX3GyVxJ1wNhDTdykSFAEY9dkpLXWhP5+Lzh7pxd5oYg@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] [PATCH v4 0/2] Add pinctrl support adsp bypass platforms
To:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Cc:     agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@quicinc.com, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, quic_rohkumar@quicinc.com,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org,
        linux-gpio@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 6:23 AM Srinivasa Rao Mandadapu
<quic_srivasam@quicinc.com> wrote:

> This patch set is to make clock voting optinal for adsp bypass
> sc7280 platforms.
>
> Changes Since V3:

This v4 patch set applied. Bjorn can yell if he has concerns and I'll
pull it out again.

Yours,
Linus Walleij
