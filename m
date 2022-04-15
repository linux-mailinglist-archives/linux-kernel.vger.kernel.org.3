Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2AFEF5023CC
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 07:22:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242339AbiDOFZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 01:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238474AbiDOFZH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 01:25:07 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B8D0E029
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:22:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id t11so13629487eju.13
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 22:22:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2kVVWIn4+ecvL3sYl2+PczgNl0kQB4IqaH+XmO1cCTM=;
        b=LkJ49FHDSq8yLqisCcngHd6LA8BVgBrFyzP+beFfpWfWErzakEMVHrueMnES3zpyA5
         RZ9IqUvZrHv23ZSSiS9pOJnoMo6yJZYXT+noKo89pwmlKtWkYryEFsghwigatChoGxCE
         3haxC4Zo+PbLew/hGx4GKMYn/mqVCcm6v6rn671/VD1obOHKsgW5oG2ieiEBRgk5F66J
         gUBU0ZYR8rBN9LSwR4fICBUx4nuDhq4KuOn4k51UoersScuUZh3bI80mhIMWRRkGzlzh
         24DQGVtskF8dDEUzdmHuWokRndeY851dz8DrTpx6/hojsdUmjUP89IYQRP1/Y6WkmNvv
         /gWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2kVVWIn4+ecvL3sYl2+PczgNl0kQB4IqaH+XmO1cCTM=;
        b=lNi/es+QWYYn/TDh7BA1DkATi0ous2ka2ITpXZ3pIQruHvuma234ZgWr89DIe1ttwb
         y1sIB6iUCbiAsL2cAEzAR/AdCMo1Cx/mAmK1YkxFOPXDppI2sFQjEO57z6NFsStvrPtX
         H+3mzh3i6Te02Ob1RzSMJ4Z3dr9KZ4VnuRWs2DSOjAhChQTi44NavI/o/igffUL6Yequ
         rfZJwIIk32CFlX5Mxoe2A/SG57wO7796EAYRgqyDi0urkBInR9mJMfKu+apuIZrutJu3
         syrOQrd91gaVFk1gCp80tp1nKwiaQ7qtBGHHRPxUWZs4nWejkeencJNYyfJYqd4p3FkU
         3ZVw==
X-Gm-Message-State: AOAM531n83xjkbWKCUjRYbmDcxod+DYU0gSdtksGbV7wrord/X2UNHDr
        Sl22UyxD7Gihf90KWgUYER8=
X-Google-Smtp-Source: ABdhPJwP3dV8IYq2ZWLU3I0rvu5B/j2WfmphCivl5cktVtOZCgDduhQ3flQZo48fGOogLKNONLZx+Q==
X-Received: by 2002:a17:906:c149:b0:6df:f047:1698 with SMTP id dp9-20020a170906c14900b006dff0471698mr5085735ejc.16.1650000159165;
        Thu, 14 Apr 2022 22:22:39 -0700 (PDT)
Received: from leap.localnet (host-79-43-11-75.retail.telecomitalia.it. [79.43.11.75])
        by smtp.gmail.com with ESMTPSA id 22-20020a17090600d600b006dfbc46efabsm1309308eji.126.2022.04.14.22.22.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Apr 2022 22:22:38 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     gregkh@linuxfoundation.org, davem@davemloft.net,
        dan.carpenter@oracle.com, len.baker@gmx.com, dave@stgolabs.net,
        edumazet@google.com, Haowen Bai <baihaowen@meizu.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Haowen Bai <baihaowen@meizu.com>
Subject: Re: [PATCH V2] staging: rtl8192e: Fix signedness bug in rtllib_rx_assoc_resp()
Date:   Fri, 15 Apr 2022 07:22:36 +0200
Message-ID: <8973092.rMLUfLXkoz@leap>
In-Reply-To: <1649988571-19923-1-git-send-email-baihaowen@meizu.com>
References: <1649988571-19923-1-git-send-email-baihaowen@meizu.com>
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

On venerd=EC 15 aprile 2022 04:09:31 CEST Haowen Bai wrote:
> function rtllib_rx_assoc_resp () unsigned errcode receive auth_parse()'s
> errcode -ENOMEM.
>=20
> Signed-off-by: Haowen Bai <baihaowen@meizu.com>
> ---
> V1->V2: reduce return random value; print its own error message.
>=20
>  drivers/staging/rtl8192e/rtllib_softmac.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
>=20

> [snip]

It looks like you are doing too many things and that those aren't even=20
discussed in your commit message.

> @@ -2292,8 +2292,8 @@ static void rtllib_rx_auth_resp(struct=20
rtllib_device *ieee, struct sk_buff *skb)
>  	if (errcode) {
>  		ieee->softmac_stats.rx_auth_rs_err++;
>  		netdev_info(ieee->dev,
> -			    "Authentication response status code=20
0x%x",
> -			    errcode);
> +			    "Authentication response status code %d",
> +			    le16_to_cpu(errcode));

Why did you call le16_to_cpu(errcode)?=20
If I'm not missing something, it looks that auth_parse() already returns=20
native endian u16 values.

Thanks,

=46abio M. De Francesco


