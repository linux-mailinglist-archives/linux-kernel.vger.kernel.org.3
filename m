Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F5564FF706
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 14:43:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235604AbiDMMqG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 08:46:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiDMMqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 08:46:05 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE59205F8;
        Wed, 13 Apr 2022 05:43:40 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id g18so3650796ejc.10;
        Wed, 13 Apr 2022 05:43:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=ftC/R4apSkNj0SBqqxvCqMvFLEojqjXxdMp+rh20DA0=;
        b=g6n6tIhHD0mQsqnftSq0RvbOPkokjzp0OX6uB573Dl4Hg33fSlWFnA34EiK23DLgNh
         eoIYQl8pXTIYUWza3XQk9sgkNkTOak01u7xQM9EFXMBIS52VtmXtfwCB+Yt1FuB3q6f8
         y933dRXKqEq2ryGE6q/m3daCSQsXwBzOxC7DFBy+/2AiutsS6XB9B0L6mfwgGg6Yq204
         2U/sKAEgZobJxZkGlKO+D7Yqr3QNICiikmNIs58QDVMHzZyq948MgiQHO+hl854Sb1Xj
         nISEr9b+v8O049yvizRVjSfLhzmVr4GJneyqFOueBrrP+/f0xoz/E+KAcIGh6iDbfVMh
         S7rQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=ftC/R4apSkNj0SBqqxvCqMvFLEojqjXxdMp+rh20DA0=;
        b=mGbcYvSGIum+AQMAeYlB1vdqkWCxA8swbLGUcqcrG4H6nlqSJ22aAfB2iCsK3NexPe
         MZSvLSCsOWxBkVPdCD9FIHytw0FmZvCslZH9AMnD0fCpMp9lzGWduu+sgd9mdFKJsHS6
         kV91LM6EjkTUQugC9BuhboOgQXOE88Gu1fpxTrOMkLcVZDSEoUyZ89lEbi9C1qALPPXY
         Tje8+i53L4Fw50bJorKGxYElE8SINB7urTYjUqGC5jfK2cdlKPJmrHj0orDqBBe8GNlb
         7/ugQd+EFRsshCrkh0UCqtQqVwhIuBiKRTmd9zbXx5GvadvJMZMy5Z2M9veKb1gcF5CY
         z4Eg==
X-Gm-Message-State: AOAM5327yKRHcDARy1urjfBTxAnR2A+QtZRSpcbo6cXccGHMmLHWpimS
        MOmthh+3mc/VK7X8Awxkz94=
X-Google-Smtp-Source: ABdhPJxBLUBKYgS4v35da4ZjoDNoq81t0xJsPUkR7RcqehVi1bx196PUdi7GyD8EFLWwPQaAnzglvg==
X-Received: by 2002:a17:907:3e0d:b0:6e8:cccd:de80 with SMTP id hp13-20020a1709073e0d00b006e8cccdde80mr1951964ejc.162.1649853819459;
        Wed, 13 Apr 2022 05:43:39 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id z22-20020a1709063ad600b006e8867caa5dsm4098621ejd.72.2022.04.13.05.43.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 05:43:39 -0700 (PDT)
Message-ID: <d67b8969c8d2097377d9dbb414481f11958a9c9f.camel@gmail.com>
Subject: Re: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
From:   Bean Huo <huobean@gmail.com>
To:     Peter Wang <peter.wang@mediatek.com>,
        Po-Wen Kao <powen.kao@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, stanley.chu@mediatek.com,
        alice.chao@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com, yohan.joung@sk.com, jason.li@sk.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Wed, 13 Apr 2022 14:43:38 +0200
In-Reply-To: <7e979863-21e5-ba63-862a-8ba6a63a8ae4@mediatek.com>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
         <781bfe33efb1e44d22f71e6711da7d15be9d3ab4.camel@gmail.com>
         <7550da4043ae45ffd58399f1ee696238a5689f25.camel@gmail.com>
         <7e979863-21e5-ba63-862a-8ba6a63a8ae4@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Peter,


On Wed, 2022-04-13 at 11:53 +0800, Peter Wang wrote:
> Hi Bean,
>=20
> How about if reset flow not clear hpb mapping?

UFS will go through normal read, because regions are not active in the
device. The responses mabye different among different vendors. for
example, UFS device will raise a response to host to update the region
(in case of host mode) or inactivate it in case of device mode.

The best way is that inactivate the active regions in the host side in
the case the regions are not active in the device.

>=20
> After device is reset by RST_N pin, if the hpb mapping table still
> exist?

no, the regions in the device will be inactivated.

>=20
> BTW, Host seem not clear region mapping table in reset flow.
>=20

Yes, you are right. There will be a performance impact. I will look at
it, then back to you.

By the way, there is one issue in my patch, ignore that patch.


Kind regards,
Bean

