Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1093C4E60CC
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 10:02:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349086AbiCXJEE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Mar 2022 05:04:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234192AbiCXJD7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Mar 2022 05:03:59 -0400
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221169D0CC
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:02:28 -0700 (PDT)
Received: by mail-ej1-x631.google.com with SMTP id qa43so7726406ejc.12
        for <linux-kernel@vger.kernel.org>; Thu, 24 Mar 2022 02:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Q0pr84jWpyF9HF9IcRwnJxsXg1/1KAMzdTSZaMqOal8=;
        b=JpV6XImnUXt0JBK3uECq/IbXisNCPGUDkVxFm1oUDxZGw7Lp4u7CaS3VIzVd+8rNuT
         vGZP8alBTGp0iq8GkX2RsYNAsiBvU2nbP4Zerqjl0G3u5G1KshAXsQA8TD9vaRR+GQwn
         OC4XQdAhcIcJZ6Tm3rqiU48z7sLpzEF/EJNAmadEG2F8VTK4qVH9j8MR+6VfLZazc8I+
         I2cqmNDemTVBF62QHwgtDQESNNuLoiARKsQtwIPJ3ov9nMQiuhhMXebo6JBWClBDIop+
         05xrWcGGPDjDrwBplIAcoOmWADIQdpHDPNAw+d772sSTpcGnhUff42Ma8s2WCyGDrLW5
         Ommw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Q0pr84jWpyF9HF9IcRwnJxsXg1/1KAMzdTSZaMqOal8=;
        b=TfZ9gM+kpzQlIrkb3ALgXIZ7+PSs/ECGB/l4igGKnAppwxFmDlyZ534If74ylknJEp
         vZ4L/BFwFLZUWF8ja3f7D3AXfxXYQ4Dnh4rLjxcldNR7Mf492x1xUTr5lADw65uxbKeI
         p53EWMPMe9ajGqNuC6jQxLsqio5KvW7eSYg3OyL+ruZ0ozVA8vBeyOCKo4dm4AhKpDwx
         yqjP+jwIwuPaJfcmxHP1VpP4FHuKASydSVXGzIkWWgaCW4FOxmNQcUercwPQHO0qejie
         Bu/saSfHcT6MUi/hk1FS9ABKgsblOb/WeRzFiVuM8L26E7GXPj15ilCtAz7o/nwmycPO
         YCRA==
X-Gm-Message-State: AOAM531ec4C2+TQXpHLRmiwv4r9ra3Q62/KPx8cDg+UbJaaHA/vEfwdH
        Z/xglCFY5Pai6tNWmQx7DzI=
X-Google-Smtp-Source: ABdhPJz19UiVU80Rfr3Z6DeD0tq7NFWcSb99BErADW6wIBDasVfcz8nDtYbaLXZY1IvAHS88OkVrrw==
X-Received: by 2002:a17:906:974e:b0:6bb:4f90:a6ae with SMTP id o14-20020a170906974e00b006bb4f90a6aemr4734153ejy.452.1648112546535;
        Thu, 24 Mar 2022 02:02:26 -0700 (PDT)
Received: from leap.localnet (host-95-249-145-232.retail.telecomitalia.it. [95.249.145.232])
        by smtp.gmail.com with ESMTPSA id gl2-20020a170906e0c200b006a767d52373sm836331ejb.182.2022.03.24.02.02.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Mar 2022 02:02:24 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Larry.Finger@lwfinger.net, florian.c.schilhabel@googlemail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, Sathish Kumar <skumark1902@gmail.com>
Cc:     Sathish Kumar <skumark1902@gmail.com>
Subject: Re: [PATCH v3] staging: rtl8712: Use completions for signaling
Date:   Thu, 24 Mar 2022 10:02:17 +0100
Message-ID: <3422492.iIbC2pHGDl@leap>
In-Reply-To: <20220323045515.2513-1-skumark1902@gmail.com>
References: <20220323045515.2513-1-skumark1902@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="ISO-8859-1"
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On mercoled=EC 23 marzo 2022 05:55:15 CET Sathish Kumar wrote:
> r8712_sitesurvey_cmd() uses a variable to notify r8712_SetFilter() that it
> has completed operation. There is no sort of assurance that the variable =
will
> actually change and it could cache the value the first time it is read and
> then never update it for the whole loop logic.
>=20
> Use completion variables because they are better suited for the purpose.
>=20
> This patch fixes the checkpatch.pl warnings like:
> CHECK: Avoid CamelCase: <blnEnableRxFF0Filter>
> +   u8 blnEnableRxFF0Filter;
>=20
> Signed-off-by: Sathish Kumar <skumark1902@gmail.com>
> ---
> Changes in v2:
>   - Remove the "bln" prefix
>=20
> Changes in v3:
>   - Replace the variable used for signaling with completion
> ---
>  drivers/staging/rtl8712/drv_types.h   | 3 +--
>  drivers/staging/rtl8712/rtl871x_cmd.c | 2 +-
>  drivers/staging/rtl8712/usb_intf.c    | 2 +-
>  drivers/staging/rtl8712/xmit_linux.c  | 8 +-------
>  4 files changed, 4 insertions(+), 11 deletions(-)
>=20
Hi Sathish,

=46irst of all, I must admit that you have impressed me :)

Aside from the specific code of this driver that I don't know and aside
from the specific problem that you've been suggested to fix, I see that
you have been able to research and understand the subjects that Greg and=20
I talked to you about.

By reading what Greg wrote soon after me, I believe that he was expecting
a slight different solution. I suggest you to read carefully what he writes
rather than what I write, just because he has at least 20 or more years=20
of experience than me and because I'm just a spare time type of kernel=20
developer.=20

You chose to use wait_for_completion() / complete() (notice that these API=
=20
use barriers indirectly). What I can say is that they look to be suited for=
=20
solving the issues that you have here, even if there are other approaches.

Since, as said, it looks like you have understood how to select and use the=
=20
one of the API that were suggested, you have my...

Reviewed-by: Fabio M. De Francesco <fmdefrancesco@gmail.com>

Thanks,

=46abio


