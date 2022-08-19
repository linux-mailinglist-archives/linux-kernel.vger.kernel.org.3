Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D43C59A6D1
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:04:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351582AbiHSUDw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:03:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351558AbiHSUDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:03:48 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 430EF40555
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:03:47 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id dc19so10669950ejb.12
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=9n5RFn8TAV/PffgBuvz2HviY+YN6byWrm18eu2DfQto=;
        b=Ip/Z93LjOs20PVD0ORy+d2AlF7JTde7DigljJbgUklC8daxceXrlHlC+osry84FYst
         RhLGh7wZAKwAOM6Mv9UPKCwzkc1Sdwwl3EsKEpat05HMIhVvQx7Dm7h8pN3OoRSnIuir
         PlAV/67SwQQUcuotu1/3g6SFa6BGGnl+9Qp00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=9n5RFn8TAV/PffgBuvz2HviY+YN6byWrm18eu2DfQto=;
        b=7CZRjvsUgVhlcQ6l+GEMo8dxL8jFKbvTvMyRRzTKAcSRmX4DjBfonq62M7mblwf4bu
         yq3+Y4DUl/07YzIERAS4L8pSlISIDSURYMYcPc+1Yn+JPb1gCA4DMiRPMCaKLM7chY97
         wICbU9F+7HXT56ccMugDmEXne76EEENZt66ZoL99PRjzrIQMBRDcteXr/pZ8jxW5Y0zO
         Y9Z50nKozt0JTGpEEYN04AbATtcVxSEXxrH500rbnTYLDy6VNcdQGUnD8sX3IkrTNxv4
         QXN9diIsSfNpUpU/GNWIqOttCcsekxuCxQFDzNbhnF6mkBr9PTdfR4+XaPa4fDYRyuYb
         mxmQ==
X-Gm-Message-State: ACgBeo20GGdchrpEyL38N0SKyHlsKTUh00HrFcfEK26XNL0FhbGsmvI1
        RAGeN4Q7UCP2oVoudWpxnF89nXi7YholP0KMwWQ=
X-Google-Smtp-Source: AA6agR5Y9KRXZzjtZlLT8n+2+o84v6+kG78xaQSg1sL8RhXRL6rohNl9eOiGlzKNLTB7I1wmLbx8aQ==
X-Received: by 2002:a17:907:7354:b0:73c:d528:94ae with SMTP id dq20-20020a170907735400b0073cd52894aemr3252331ejc.274.1660939425590;
        Fri, 19 Aug 2022 13:03:45 -0700 (PDT)
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com. [209.85.128.52])
        by smtp.gmail.com with ESMTPSA id 25-20020a170906311900b0073a96816eb0sm1468739ejx.222.2022.08.19.13.03.44
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 13:03:44 -0700 (PDT)
Received: by mail-wm1-f52.google.com with SMTP id k6-20020a05600c1c8600b003a54ecc62f6so2971852wms.5
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 13:03:44 -0700 (PDT)
X-Received: by 2002:a05:600c:4e8b:b0:3a5:f5bf:9c5a with SMTP id
 f11-20020a05600c4e8b00b003a5f5bf9c5amr9034593wmq.85.1660939423911; Fri, 19
 Aug 2022 13:03:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220819194336.382740-1-ahalaney@redhat.com>
In-Reply-To: <20220819194336.382740-1-ahalaney@redhat.com>
From:   Doug Anderson <dianders@chromium.org>
Date:   Fri, 19 Aug 2022 13:03:31 -0700
X-Gmail-Original-Message-ID: <CAD=FV=VH5_i5uVcaXQrrHQWF0=ffnqFpZkmexpqoEFr7RFn_3Q@mail.gmail.com>
Message-ID: <CAD=FV=VH5_i5uVcaXQrrHQWF0=ffnqFpZkmexpqoEFr7RFn_3Q@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Clean up on enable failure
To:     Andrew Halaney <ahalaney@redhat.com>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, bmasney@redhat.com
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

Hi,

On Fri, Aug 19, 2022 at 12:44 PM Andrew Halaney <ahalaney@redhat.com> wrote:
>
> If regulator_enable() fails, enable_count is incremented still.
> A consumer, assuming no matching regulator_disable() is necessary on
> failure, will then get this error message upon regulator_put()
> since enable_count is non-zero:
>
>     [    1.277418] WARNING: CPU: 3 PID: 1 at drivers/regulator/core.c:2304 _regulator_put.part.0+0x168/0x170
>
> The consumer could try to fix this in their driver by cleaning up on
> error from regulator_enable() (i.e. call regulator_disable()), but that
> results in the following since regulator_enable() failed and didn't
> increment user_count:
>
>     [    1.258112] unbalanced disables for vreg_l17c
>     [    1.262606] WARNING: CPU: 4 PID: 1 at drivers/regulator/core.c:2899 _regulator_disable+0xd4/0x190
>
> Fix this by decrementing enable_count upon failure to enable.
>
> With this in place, just the reason for failure to enable is printed
> as expected and developers can focus on the root cause of their issue
> instead of thinking their usage of the regulator consumer api is
> incorrect. For example, in my case:
>
>     [    1.240426] vreg_l17c: invalid input voltage found
>
> Fixes: 5451781dadf8 ("regulator: core: Only count load for enabled consumers")
> Signed-off-by: Andrew Halaney <ahalaney@redhat.com>
> ---
>
> I'm new to using the regulator framework, but I _believe_ this is a
> cosmetic bug that's fixed by this patch. I went down a bit of a rabbit
> hole because of the original WARN() message, so I'm trying to prevent
> others from doing the same :)
>
> Please let me know what you think, I tested on the misconfigured system
> and on a working system and things seemed to work as expected.
>
> Thanks,
> Andrew
>
>  drivers/regulator/core.c | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)

This looks right to me. Thanks!

Reviewed-by: Douglas Anderson <dianders@chromium.org>
