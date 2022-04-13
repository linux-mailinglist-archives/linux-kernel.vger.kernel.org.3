Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B965500133
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 23:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229801AbiDMVcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 17:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiDMVcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 17:32:19 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9A3B3FD89;
        Wed, 13 Apr 2022 14:29:56 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id d10so4079557edj.0;
        Wed, 13 Apr 2022 14:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=wERzMS/7EQkQ9BLfdKeH9OCJBA9aLhKxzyWlCHTVe9Q=;
        b=qwKjNZTg7Dscjj99nDEhphhwY58RXVp/FiRBLbfu8+Npexyda4WXi9+NjQ+5ZYmgsi
         thJA9K8cPz96GoIijulf06YMjESm0R13eLYzW+yMSnNBU/DHY5D02Xq0dIHe9CrIlgYh
         /rkkg2cjJYaTJO84qp2s/dB/9/iQg1hbRgxJOL04G7dZ86Op/Rqwo8MBHsJO1PptlE4p
         z9nVZFWpMQPNyG7S2EwGt1EPBp+I5QQ25eNXUADspGtOSWdS8lvLs5zfFbA98cq+lPY3
         Y1vXaJ/typYH3CewPetiKsxup2AEe/nFAe1arXVbVgAYKA4E5X5EjMO+XMvdAcT4KjKb
         nzYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=wERzMS/7EQkQ9BLfdKeH9OCJBA9aLhKxzyWlCHTVe9Q=;
        b=R13OVlcmhr+D4NPaTKHAVkkkpfdTNmjtLRiRs6pWxhWwYrZuwkDOPE4BQ+VeADMdKX
         QefF1F8tUbE6BZb2KtfvWcSr98Cv9iKphoyMqGzw5tfjo7S9gKTDxA90Z8jx4BciGRUG
         pqRZOuzdituRnrt2q3CIt/cJJU6TELiqttKdHUDboDUsN8WQlZfT96KKRCgC8EHyJeFu
         /2ho2A23th4id0/2Bki3plpm7QjCM8/O7ry0euNtL1qssYC0qynMbn8l4SQ+cZJsOG0d
         wYzkBE21UEqb/BhkGuklQz743TInbwuU28PA6Qs/sTLGIlcQstEUY5tvd3Cin4t0oluJ
         OKPw==
X-Gm-Message-State: AOAM531mUZI/qioQFnI3Z/VovzOAHl4zdGIdY2W8cSbEpx3+eKA5X3+c
        lITgJDXMGo+WSuFwjJKnmGk=
X-Google-Smtp-Source: ABdhPJxyqY4Vhr7TJaX4LP58Wcgv3ORgMl61v3D7KD0d0KqQflSkvl5TOgG+liX0OTZ1cyX+Ml8VNQ==
X-Received: by 2002:a50:a408:0:b0:41c:cdc7:88bd with SMTP id u8-20020a50a408000000b0041ccdc788bdmr45822582edb.399.1649885395150;
        Wed, 13 Apr 2022 14:29:55 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id kw3-20020a170907770300b006d2a835ac33sm22266ejc.197.2022.04.13.14.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Apr 2022 14:29:54 -0700 (PDT)
Message-ID: <dcd403b025eb28186c3f05d682c383cb06e5b8ee.camel@gmail.com>
Subject: Re: [PATCH 1/1] scsi: ufs: remove redundant HPB unmap
From:   Bean Huo <huobean@gmail.com>
To:     Po-Wen Kao <powen.kao@mediatek.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        chaotian.jing@mediatek.com, jiajie.hao@mediatek.com,
        yohan.joung@sk.com, jason.li@sk.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Date:   Wed, 13 Apr 2022 23:29:53 +0200
In-Reply-To: <20220412073131.10644-1-powen.kao@mediatek.com>
References: <20220412073131.10644-1-powen.kao@mediatek.com>
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

Hi, Po wen and Peter


I must give this patch Ack, because:

1. =E2=80=9CfHPBReset Flag=E2=80=9D can be sent in both host control mode a=
nd device
control mode. =E2=80=9Cbuffer id=3D3 HpbWriteBuffer=E2=80=9D can only be se=
nt in device
control mode.

2. =E2=80=9CfHPBReset Flag=E2=80=9D inactivate all the regions for the whol=
e device.
=E2=80=9Cbuffer id=3D3 HpbWriteBuffer=E2=80=9D can only inactivate all the =
regions for
this LUN. The LUN is written in the UPIU header.

In the ufshpb_init, we have set fHPBReset Flag. here doesn't need to
issue =E2=80=9Cbuffer id=3D3 HpbWriteBuffer=E2=80=9D in the case of device =
mode.

Regarding the reset flow issue we are talking about, I will submit a
fix.


Acked-by: Bean Huo <beanhuo@micron.com>


Bean


