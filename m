Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B96750D5A2
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 00:16:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239759AbiDXWTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 18:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiDXWTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 18:19:09 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19ACB644F2;
        Sun, 24 Apr 2022 15:16:08 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id d6so11335914ede.8;
        Sun, 24 Apr 2022 15:16:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=ULkvU6lbJY7Ze1LSiFl/YjCHBSBAU9f03/gS7iw6lwQ=;
        b=dsS9eJdRiPXgWB/2NTFf3hwTlRUFyiP9fNV45yTC5m9TgB9OJneWaVN54u3pXIKvnJ
         NaWm201kEHqCoxrOiYeZvgcn54cEtPGoUPdLSnqH2bqotH/IWiI3piwHRb0zDpZkFT7T
         8XYFDFSaRFHAgqAPtHm2F1s6L2dYEayWePRVkpJRM0YMu7aiz4smhlrzGHmusxXKZmf+
         BUTd9qB9rMqIGAmdXK+TsbyraFokmr092K9hW7257ktcTqn9a+wi2Ap8SuiHFxp9635K
         dehJ1aJ2KUawlmrvbtmdibiNIl6dr3UQ9QmzgBSJa6xopVJEGutPzdAmuQ0kK1gIXDlq
         yazw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=ULkvU6lbJY7Ze1LSiFl/YjCHBSBAU9f03/gS7iw6lwQ=;
        b=Fb45GPffTMfE1pRKEs1zFZ1Mf/gQeLw0o3XJXpY6rFGkCmnbIuyyAO19CE2W/OevK+
         MbZtJIukx0gezJjk6iTyYNoQNBsPc6x7FSaxenRg7fBelAlpfMYL8OV3gwffmsFygK0w
         3lzuQqmqIYMltDGiMbjzBX7iyNXgK5HXN7DeYTaw5ZLmLEPVH7t6aFp1lwey0X9eTM6J
         xe/uYzMaOwv2RG9MA+eyDgXnSed/ut3mlETGiBjGQBbT+mPRciSLgdD+5mdDEjCTXy//
         ck/LQ/GHXH/qW+3A1N/JoE2qVAvdWm/Hs+Gvb4jcyKXzB9F16+8DjHXhno03cpfAtdLk
         hlxg==
X-Gm-Message-State: AOAM533zcUViyBJAxG0SLV8/uZgoDIIm3ZCPnhVJQlhOgPMQW1RJWM4E
        YqRKiNnnr00nc9FrsNLB59w=
X-Google-Smtp-Source: ABdhPJwkWKvSq3br5cpOWavb+QAOLfxc91zdwDh5O2BPebCXIgxa5CP6h1zdoH4IKSGTa36GGAWjvw==
X-Received: by 2002:a05:6402:1148:b0:416:a4fb:3c2e with SMTP id g8-20020a056402114800b00416a4fb3c2emr16054403edw.182.1650838566749;
        Sun, 24 Apr 2022 15:16:06 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id n25-20020aa7db59000000b00415965e9727sm3748272edt.18.2022.04.24.15.16.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 24 Apr 2022 15:16:06 -0700 (PDT)
Message-ID: <cab6041960b6a11627ae0deece24a49263d13366.camel@gmail.com>
Subject: Re: [PATCH v2 4/5] scsi: ufshpb: Add handing of device reset HPB
 regions Infos in HPB device mode
From:   Bean Huo <huobean@gmail.com>
To:     keosung.park@samsung.com, ALIM AKHTAR <alim.akhtar@samsung.com>,
        "avri.altman@wdc.com" <avri.altman@wdc.com>,
        "asutoshd@codeaurora.org" <asutoshd@codeaurora.org>,
        "jejb@linux.ibm.com" <jejb@linux.ibm.com>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "stanley.chu@mediatek.com" <stanley.chu@mediatek.com>,
        "beanhuo@micron.com" <beanhuo@micron.com>,
        "bvanassche@acm.org" <bvanassche@acm.org>,
        "tomas.winkler@intel.com" <tomas.winkler@intel.com>,
        "cang@codeaurora.org" <cang@codeaurora.org>,
        Daejun Park <daejun7.park@samsung.com>,
        "powen.kao@mediatek.com" <powen.kao@mediatek.com>,
        "peter.wang@mediatek.com" <peter.wang@mediatek.com>,
        cpgsproxy3 <cpgsproxy3@samsung.com>
Cc:     "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Mon, 25 Apr 2022 00:16:05 +0200
In-Reply-To: <d26393a3323dc646df88fb09ee47d712c80eafc9.camel@gmail.com>
References: <20220419183044.789065-5-huobean@gmail.com>
         <20220419183044.789065-1-huobean@gmail.com>
         <CGME20220419183934epcas2p28272bfd9167253c2d9136c60f9050c5f@epcms2p7>
         <1381713434.41650433982422.JavaMail.epsvc@epcpadp4>
         <d26393a3323dc646df88fb09ee47d712c80eafc9.camel@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.0-1 
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

> On Wed, 2022-04-20 at 14:31 +0900, Keoseong Park wrote:
> > >=20
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Remove this regio=
n from active region list and add it
> > > to inactive list
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&hpb->rsp_list_=
lock);
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ufshpb_update_inactive_in=
fo(hpb, region_index);
> > How about separating the "hpb->stats.rb_inactive_cnt++" code from
> > ufshpb_update_inactive_info()?
> > Because I think this code should only be used in
> > ufshpb_rsp_req_region_update().

Hi Keoseong Park,

I didn't take this hpb->stats.rb_inactive_cnt++ out, since I think if
the host receives HPB operation:02h, which means the device recommends
the host to de-activate all active regions on the host side. we need to
add these de-activations to this parameter because the device has
inactivated all active regions. Otherwise, we will find an inconsistent
inactivation and activation counter. Please have a look a review the
v3.=20

Kind regards,
Bean

