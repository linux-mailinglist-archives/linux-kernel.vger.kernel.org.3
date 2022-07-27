Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B46D58327B
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 20:54:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232657AbiG0SyA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 14:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235595AbiG0Sxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 14:53:38 -0400
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 855DB43E49;
        Wed, 27 Jul 2022 10:50:58 -0700 (PDT)
Received: by mail-ej1-x62f.google.com with SMTP id l23so32904150ejr.5;
        Wed, 27 Jul 2022 10:50:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=WSx0gfRjsg3xRpvKbX9jGCtpeGwAnxtFBDRN8ACR4hA=;
        b=DTWME+8U9y+rzGdF2Calq/d9Su/47Jgtr3oEPP+ZwPm4+hS9p7rDOKhluy5AUOtISF
         f1zB8IDe3pO/jxHnN4GSEnY+Z0OXwbvNLMKIhGydI9w2s3tzeLgpSNCfKlXR8N6UUunM
         yDa/Sluo0kf9XmvAUx3kmV4OX39gkEdSekfNI1TotOwFSLa8HkaY9bfkk7/FiMDxBaB8
         Z9LJnZV00l+MoO08hlBABqZY4CFchbnvujIETUw0Zp7BeTqAQy6inZH0Oi2ZB1uObBC0
         wyWeje4wp3SR0MHPh+NAv8Oi+8qa/zUUnBw9tKtuLMvXDEY6LkTkTt3x18nSEx8uSBzK
         WY8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=WSx0gfRjsg3xRpvKbX9jGCtpeGwAnxtFBDRN8ACR4hA=;
        b=3AwJzXXXFve23To1qkCpJn21nHZMROPXmb6twbJNtjDxZwrTCRQaeWDqMOXJSfi9b8
         MrHfhmwHTzUAAxWbmkdB/Joto4DRPgqe7lyYjDLWu6gNdxvtLWLyi8mAFQh8shkX8Hi2
         TFUbbk69lXOIbSe7FL3CXy3qAv/zyRnTu4voyg3pZH5QEC2JpKUHjB9loTeNZfW6mDQl
         ItibGx1oMaeQ8kO2xEbWjualFBcUq/LeIZoXen6bBKnI4XBaOF4xmSvRSiypai7UF/u8
         ssMf1bRPO32n6t3XuDIOCzLvrv7eJ23HVBsmNQPOXwhcTbl0w/nWCkdVQSwxlRu/9ZiQ
         G5Zw==
X-Gm-Message-State: AJIora/KqGc9uk5ZKmMo73rTGhGrjKvTeBvMzDUICrdfwf4g6Ofx+NOG
        SomI7Le9PmshRB6e505NXsk=
X-Google-Smtp-Source: AGRyM1trwwVk6ZAK+kkjUNTanLpjpJhGYZ6RNdvzirvqiG8G6bsQwQSCUlT2bT6P9TLqRZENrxdg4g==
X-Received: by 2002:a17:907:7208:b0:72f:368f:2eb4 with SMTP id dr8-20020a170907720800b0072f368f2eb4mr18559262ejc.457.1658944257035;
        Wed, 27 Jul 2022 10:50:57 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id ga2-20020a170906b84200b00724261b592esm7871509ejb.186.2022.07.27.10.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 10:50:56 -0700 (PDT)
Message-ID: <bf6b650792bb2f24e78d751c68201e1f305400da.camel@gmail.com>
Subject: Re: [PATCH v4 5/7] scsi: ufs: wb: Add
 ufshcd_is_wb_buf_flush_allowed()
From:   Bean Huo <huobean@gmail.com>
To:     j-young.choi@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 27 Jul 2022 19:50:55 +0200
In-Reply-To: <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
References: <20220727070841epcms2p5e212d617dd0f985555fa052f099013f0@epcms2p5>
         <20220727070724epcms2p8e449d0c89b52f03a9d3dc254df0ec547@epcms2p8>
         <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
         <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
         <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p7>
         <20220727071024epcms2p70366b54ac8eca3758b7cf4336e0d457c@epcms2p7>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-07-27 at 16:10 +0900, Jinyoung CHOI wrote:
> The explicit flushing should check the following.
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- UFSHCD_CAP_WB_EN
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0- UFSHCI_QUIRK_SKIP_MANUA=
L_WB_FLUSH_CTRL
>=20
> Changed to improve readability.
>=20
> Reviewed-by: Avri Altman <avri.altman@wdc.com>
> Signed-off-by: Jinyoung Choi <j-young.choi@samsung.com>
Acked-by: Bean Huo <beanhuo@micron.com>

