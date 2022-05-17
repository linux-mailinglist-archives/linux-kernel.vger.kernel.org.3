Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D292552A7B3
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 18:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350743AbiEQQOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 12:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232963AbiEQQOu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 12:14:50 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CEE72B9;
        Tue, 17 May 2022 09:14:49 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id i19so35621381eja.11;
        Tue, 17 May 2022 09:14:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tt7zm04FGXtuD21TiwMVKS3Q+xBPI2XIPf8jUpqW1y0=;
        b=iydMExLbtxZvc/lILbSGclEuP/4wxj1eepsr30NQdZjIVI9jsJNOpCBn01ZOU+7x1G
         gq691RQAGrDJQ8fOqMGMYiah/f1X5IJnoO1Nf7fVhOYM6BXsZfJfHBJXPsk67lT9pI3L
         GO8Xfcj4iwBqcpUjJQYhPBmcqN5D4rTb1f2w/3AWwQPqtyzfWF8yB1uVg8jdTJONU3Dx
         vqFpRD1zfgJWJnN+w2Xfgcm/oZmtK6Us53EVevWgGPalUo/SBAoX90NAcfO97i3DM6PB
         D2ZH9IDVu/gWXomdJPYyOpezKggARONvZjN9tZCfDwZjGxRp/6oj/HhUeNwp+z9hW+d1
         RDuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tt7zm04FGXtuD21TiwMVKS3Q+xBPI2XIPf8jUpqW1y0=;
        b=kjql98oLamrBDEwteeJoXh7pUwohsiQv3qwNfC4ykau91Z2mKOtlGkUROegPacMn+8
         LP24YdGwmf4L1UY5TkUGqp4M1d04ars4trmYJYuRdDDliGEVAZWwTOTO/jHlAfDkfu5g
         N7JazCJd6rWgta668GN0yfnTlrqshBGT0iVpGwn00SziYbeNi5CBqZPRe30hCZtz5p7j
         uh30ANvJ0MG5L+0Rp6Gg8FZOQohOXJA1RFtP0xcxPlvLqSVrvN0vxln+7bsRBMn2IHw/
         gMmdWH2YZ8PnrcQQB2LgzSdMQlJu6Mj1NUNjrNLbPn8mLsY1b475JwVO7Lu1wY7g4B+v
         oTJQ==
X-Gm-Message-State: AOAM532DUF9yVBONVD08V4qRJPZm+0B8SvxuV8WNV/4e2vtqZneyOX3K
        gehBIdODhJoZzfRfeuIyQKQC8nk5/i8DfNPINxM=
X-Google-Smtp-Source: ABdhPJzQSIp/iPhUJDlTKgL6WKPfrKEJVcGOjD5bg+BJM786iaaQEgaii0OIjcfd/jv0+QM2apMhLY5bCzdHgZ3tR5o=
X-Received: by 2002:a17:906:c10d:b0:6f4:a770:846e with SMTP id
 do13-20020a170906c10d00b006f4a770846emr20505102ejc.497.1652804087559; Tue, 17
 May 2022 09:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <44828f285aeacf0e941f4f6452b190b46146043f.camel@mniewoehner.de>
In-Reply-To: <44828f285aeacf0e941f4f6452b190b46146043f.camel@mniewoehner.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Tue, 17 May 2022 18:14:11 +0200
Message-ID: <CAHp75VcoLqByXy_VdhAu-j9oU_cL7FhdcegG=ePGkNK=cD+wKA@mail.gmail.com>
Subject: Re: [PATCH v2] platform/x86: intel-hid: fix _DSM function index handling
To:     =?UTF-8?Q?Michael_Niew=C3=B6hner?= <linux@mniewoehner.de>
Cc:     Alex Hung <alex.hung@canonical.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Platform Driver <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jiri Kosina <trivial@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 16, 2022 at 3:58 PM Michael Niew=C3=B6hner <linux@mniewoehner.d=
e> wrote:
>
> intel_hid_dsm_fn_mask is a bit mask containing one bit for each function
> index. Fix the function index check in intel_hid_evaluate_method
> accordingly, which was missed in commit 97ab4516205e ("platform/x86:
> intel-hid: fix _DSM function index handling").

Hence Fixes tag?

--=20
With Best Regards,
Andy Shevchenko
