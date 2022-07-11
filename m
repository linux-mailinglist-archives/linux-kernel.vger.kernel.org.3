Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB6A570857
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:29:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbiGKQ2z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:28:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiGKQ2q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:28:46 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 623CC101D2
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:28:43 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x91so6946687ede.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:28:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZMmtVpPiwASBZ5ENHcu9qdCA56EEAIZ9X2ai07zSNO8=;
        b=FhzyZZ/X0td3uXrVpkUrteQnmPw9RajyY9btUHHZVvCoavEZMXbVGoXdWPMA9i/F8v
         XFbdRDHAFBXVEJ/rIf55jlMTy/PAkPgmA7MMEr4AWgo+7+Y3ifG1sTcyvsjOevcatNht
         /CRkMiQEp8SIP1X7zRFUsIXX3pDWosMEyS6HM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZMmtVpPiwASBZ5ENHcu9qdCA56EEAIZ9X2ai07zSNO8=;
        b=aRR+qCDIh8HdIeSLgYkE9EBzdzVlCsabXXd9EKdwJUzk53J0rEoXcD0W/2RGlTt+BR
         Yqb8TyasI/Qm81ueXaYGQ46qLBXLMtxv5IOT16D4pOG4W5dFFLPINQV1XMqvwV06GYcj
         C3o7NutggdQOKS3655I14+gd7tRfD8PaDH8LxVBngkECvKCzcfj3m/PqXIiLpqoAUm0a
         47gQofwiVXa7MoRlCbidWfN6W0iwS8irTh1/I7ELhx2wMTFST5g0ZBUECl81XPibF8xG
         bduBgqeye457CTloQ34RYn0T2RsDf0aLN1fhizJ0kBJ12I1QY5e3VXc2YVO48LjUwD+s
         AD4Q==
X-Gm-Message-State: AJIora+fHKX+O4kRSCZ56Yw30LYeNwQpEFFC9mNXHOL0RKr2JWJTeG2J
        by/R04hHaRliiPx5Qro18p0isSTsUyJBlpQ+8RQ=
X-Google-Smtp-Source: AGRyM1tQni+3Ar7Xs++OUq+y7BEr9jg/VjHOGBTy2go/ZBU7fDt3Nx/Q+/LUA9bjjaiRt62ACqbshQ==
X-Received: by 2002:a05:6402:510c:b0:43a:e041:a371 with SMTP id m12-20020a056402510c00b0043ae041a371mr3555600edd.424.1657556921743;
        Mon, 11 Jul 2022 09:28:41 -0700 (PDT)
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com. [209.85.128.48])
        by smtp.gmail.com with ESMTPSA id ch15-20020a0564021bcf00b0043a71c376a2sm4599902edb.33.2022.07.11.09.28.41
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Jul 2022 09:28:41 -0700 (PDT)
Received: by mail-wm1-f48.google.com with SMTP id bi22-20020a05600c3d9600b003a04de22ab6so3359507wmb.1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:28:41 -0700 (PDT)
X-Received: by 2002:a05:600c:3ace:b0:3a0:4ea4:5f77 with SMTP id
 d14-20020a05600c3ace00b003a04ea45f77mr16753502wms.57.1657556920698; Mon, 11
 Jul 2022 09:28:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220711092431.1.I4016c759fd7fe2b32dd482994a20661f36e2cae3@changeid>
In-Reply-To: <20220711092431.1.I4016c759fd7fe2b32dd482994a20661f36e2cae3@changeid>
From:   Doug Anderson <dianders@chromium.org>
Date:   Mon, 11 Jul 2022 09:28:27 -0700
X-Gmail-Original-Message-ID: <CAD=FV=X4Eb9Be=CoJ3nY6__QXp6eLMU2uJirW1HpUcDMYwESeQ@mail.gmail.com>
Message-ID: <CAD=FV=X4Eb9Be=CoJ3nY6__QXp6eLMU2uJirW1HpUcDMYwESeQ@mail.gmail.com>
Subject: Re: [PATCH] usb: misc: onboard_hub: Fix 'missing prototype' warning
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux USB List <linux-usb@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Ravi Chandra Sadineni <ravisadineni@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Jul 11, 2022 at 9:25 AM Matthias Kaehlcke <mka@chromium.org> wrote:
>
> When building with 'W=1' the compiler complains about missing
> prototypes for onboard_hub_create/destroy_pdevs(). Include the
> header with the prototypes to fix this.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
> ---
>
>  drivers/usb/misc/onboard_usb_hub_pdevs.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Douglas Anderson <dianders@chromium.org>
