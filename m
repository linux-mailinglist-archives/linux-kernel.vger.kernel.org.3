Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10379564949
	for <lists+linux-kernel@lfdr.de>; Sun,  3 Jul 2022 20:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232904AbiGCSfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 14:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232875AbiGCSf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 14:35:28 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C709FB8D;
        Sun,  3 Jul 2022 11:35:27 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id g4so13194699ybg.9;
        Sun, 03 Jul 2022 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y/XwvHrfAcaL5Dlg6DC44ZQayGB2ugp2yd+NGOlWjvk=;
        b=VzRi0V+rSVmqkRF+3nZu+Hm467maGKd3WrNF6MQ+r8iRY0UIY3p3/2xtkOgh7DYchj
         S8BQ4dj51XpgSljBDVznotY723aQiNU+2lM+Be73Z+HldVAjdrNTvQRssC0zrSlZ8wcJ
         pHPNrfPEzvtg8kpT6PMlRkCeomVJwgfG2F5aytDECsSrXybMi97Q5KfuH6PXyZM3Aa/M
         w5FuY21rDTWXH5EViS/GUQm8bVgodvYqFTV7Bs0IZ82yeHOWvlE5m5pBGbLiJAhm3VUU
         T2mTY9RxOycAS0+znFfp9S+mrhkcYkYJ7/UmBOVXCYv2sfSf1kJTOczyheyOE3ChYCM2
         EQ2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y/XwvHrfAcaL5Dlg6DC44ZQayGB2ugp2yd+NGOlWjvk=;
        b=XsNn86JTMLmwA1VkU+rm/yMVsiDp48NrpUUzycPEe86ihrDwVdt2FskqHXcOqfXT9c
         /q7DnI7GlQq0ta8l0C2wIqsJARU/Y5rgMZFZvROcQACv7DjVKgAPiU+vUSm+tSoEcMfu
         1tjFvVB+Gjyf6elB3/9Xni9xLN8sjGoBGGLG1RfvKFMRnOZkW3rnzxakmn3Ine2xwk0F
         fQ7zl6vtwLClW2SZiw0Ov8prxqbo86wPh5dNLa6ilD1lfuHWCFTjgciNbtuAetMdKjfp
         C1EumJ8x4MKLPzdWBHPc18877FIQTCL0Boj9UT3AH4mNwgk2tuTRcjYb9gkTjsfu68pS
         BWRA==
X-Gm-Message-State: AJIora9w1C3oS/PIPTrzYoo4yGHX/h8kBrjxUCSyHZXTupnLXoDIZLbQ
        YkpFEkOWcYNhFkpT6cROTBSQMWdwe9HG38ZV2VB7yQot3sRp5g==
X-Google-Smtp-Source: AGRyM1vi3g5NWtnrRvlcPZyNMhQ7MYLW6V0Ys7aF5nobfSZ5OuV+LupZZznhqTBvgwQQjZgzIMfbmge2aspS2VKIVFc=
X-Received: by 2002:a5b:68a:0:b0:66e:472a:83f4 with SMTP id
 j10-20020a5b068a000000b0066e472a83f4mr1932094ybq.570.1656873326848; Sun, 03
 Jul 2022 11:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20220703170039.2058202-1-LinoSanfilippo@gmx.de> <20220703170039.2058202-5-LinoSanfilippo@gmx.de>
In-Reply-To: <20220703170039.2058202-5-LinoSanfilippo@gmx.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 3 Jul 2022 20:34:50 +0200
Message-ID: <CAHp75VdvBfBM3Exm8BhJs7CzDaFwNYc7BLq-sLuwfzYTo4gyCA@mail.gmail.com>
Subject: Re: [PATCH v2 4/9] serial: core: sanitize RS485 delays read from
 device tree
To:     Lino Sanfilippo <LinoSanfilippo@gmx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>,
        devicetree <devicetree@vger.kernel.org>,
        "open list:SERIAL DRIVERS" <linux-serial@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lukas Wunner <lukas@wunner.de>, p.rosenberger@kunbus.com,
        Lino Sanfilippo <l.sanfilippo@kunbus.com>
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

On Sun, Jul 3, 2022 at 7:02 PM Lino Sanfilippo <LinoSanfilippo@gmx.de> wrote:
>
> From: Lino Sanfilippo <l.sanfilippo@kunbus.com>
>
> When setting the RS485 configuration from userspace via TIOCSRS485 the
> delays are clamped to 100ms. Make this consistent with the values passed
> in by means of device tree parameters.

I'm not sure I got it right. Is the values from DT now clampet as well
as user space does or other way around? In either way the commit
message misses the explanation why it's not a problem if user
previously passed bigger values either via user space or via DT,
because it's an ABI change, right?

-- 
With Best Regards,
Andy Shevchenko
