Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80890582779
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:16:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233723AbiG0NQ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:16:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232254AbiG0NQZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:16:25 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D00319029;
        Wed, 27 Jul 2022 06:16:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id m8so21328606edd.9;
        Wed, 27 Jul 2022 06:16:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=Eulazy/cIqbEQxNLHQla1/EWCHbecZL1aHMX/om153g=;
        b=paXhMUpgg56VAxh+FdkVlBufIqTLxf3o2PP75i5CHx47cB2/taRA4sxOJeOEpdb7D2
         eoMVk8PwmBzPLNCco3G5L6QjPBRJu9n2eYp3lqnhVgyWNNG4shAsjZ+r9f15a61uHkhQ
         YoqJ+FmydWS2Q+JgoZxMZOW+9qfl/WJGfFWKuxvE4cWgnfnxEKgCnu0E+ahN6fz7F/JR
         ogEdDLYTyY6ZzrhCSFc62c8HKtqASw/Yjo/ou4qPhllw/AedNWMYCZxgIW/MXcrBEuKY
         LL3/d6YwFlDUjSORh29Z2LejwV9yxps4fl/DVccIPlp2AVT9UPYQli8y+Cz6+i9v2pHs
         CA8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=Eulazy/cIqbEQxNLHQla1/EWCHbecZL1aHMX/om153g=;
        b=IuiwAVeZkfMp7HZwLI6YhDo1F4z+Pj2meTzlSTY0RdLAcIx9FeqHbN/nR4nhkOL0jN
         rHOneLRuMRM56QypW37zcEX/rQ0b8AiBn2qURdgaC84d9slwj8v8y3lgmqqhYEGYCtGr
         AHhssvTWSl6fV+5Ge2s/BbhK5PL+tJR64zQZW1MHj/2bu3ZMBaeBH3Ephojqu/TVDo3m
         /1sauGEEAXGIdxs+pDJk4OzZ35SpuqqVUvpSGKfJKVreIku/A8IK7XePVc8/UF0JBM5/
         oObiIcLCZUDbqFci1/n/i3Wg7agZMH+MHwiEks7oIEZenio2XPHnHpiAjBFfvZFgy0GT
         txpQ==
X-Gm-Message-State: AJIora81lXJb2w50K3ll/B202pFHjITYEg+6g3daxYsJW9nSnOlTvtpk
        +bnGm/u6nLROGmvyDmmcbgo=
X-Google-Smtp-Source: AGRyM1u3tOjqoga5WV9J/xKER/XhQHozhuDCpetK1VnYFeOj16wuVfHG/AN0b6NcbK+vaJjtwneizQ==
X-Received: by 2002:a05:6402:1914:b0:43a:d548:8adc with SMTP id e20-20020a056402191400b0043ad5488adcmr23112758edz.214.1658927779926;
        Wed, 27 Jul 2022 06:16:19 -0700 (PDT)
Received: from [10.176.234.249] ([137.201.254.41])
        by smtp.googlemail.com with ESMTPSA id kv11-20020a17090778cb00b0072eddc468absm7623776ejc.134.2022.07.27.06.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 06:16:19 -0700 (PDT)
Message-ID: <dfcd22985fde6fe8a8a00bfb2a9c8ee43f92e34b.camel@gmail.com>
Subject: Re: [PATCH v4 1/7] scsi: ufs: wb: Move ufshcd_is_wb_allowed() to
 callee
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
Date:   Wed, 27 Jul 2022 15:16:18 +0200
In-Reply-To: <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
References: <20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p6>
         <CGME20220727065904epcms2p60a7a56101785ddefa55c82b3cc25116d@epcms2p5>
         <20220727070410epcms2p5206785e4d960b32dcbb6729710dab535@epcms2p5>
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

On Wed, 2022-07-27 at 16:04 +0900, Jinyoung CHOI wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 8f11f118c30e..a3bdf9986511 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -5722,6 +5722,9 @@ static int __ufshcd_wb_toggle(struct ufs_hba
> *hba, bool set, enum flag_idn idn)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0enum query_opcode opcode =
=3D set ? UPIU_QUERY_OPCODE_SET_FLAG :
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 UPIU_QUERY_OPCODE=
_CLEAR_FLAG;
> =C2=A0
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0if (!ufshcd_is_wb_allowed(hba)=
)
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0return -EPERM;
> +
Hi J-young,

here you should change its return, Otherwise, there will be an fake
error printing:

        dev_err(hba->dev, "%s Write Booster %s failed %d\n",         =20
                        __func__, enable ? "enable" : "disable", ret);


Kind regards,
Bean
