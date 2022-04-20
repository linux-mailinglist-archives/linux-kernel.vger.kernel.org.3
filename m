Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB866508921
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 15:21:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378936AbiDTNYd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 09:24:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233144AbiDTNYa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 09:24:30 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77F04427FF;
        Wed, 20 Apr 2022 06:21:43 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id z99so2270594ede.5;
        Wed, 20 Apr 2022 06:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:subject:from:to:cc:date:in-reply-to:references
         :content-transfer-encoding:user-agent:mime-version;
        bh=yTrKoeSx5DVhv4GKSGEZu42X2Dj3HZfus9gjzjDWtLo=;
        b=jZdbFV5860QLbLI4Aa30pkXGVvf+mub3Ozvr8NOYxoqL2q2lY6k1RukB4ekJ9Ge9vE
         5HusUBWHxsYowhC1HNVmkARaR784eKvj8c8Px5UmFTpgoL6Fo+/iaeVOzrkqLwo9teQV
         f23FzTjLkEgi/dZpwJZACmP4vgT46hbuJY8Qo+ZlkdLXo9tdGQEnv8ULNf2sdgELeVVO
         6S/JPmxEcZzYdosOKNEeph3F+ozBkNtZyttgwTpbQekwTLC7Ur7whgHT2bZwEKN0yoXE
         /z3tLz2NHCZ59F4caRfn5BT4fMk7f0vJY3IiSxMp3gs4y2oWPlwk5ng7YlDYtCaWKFUG
         wk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-transfer-encoding:user-agent:mime-version;
        bh=yTrKoeSx5DVhv4GKSGEZu42X2Dj3HZfus9gjzjDWtLo=;
        b=ASAXt+JCyQLCmCl4G3UTOZGj556VPVdJS66IYLdsW7i8/unSx6DCIV6Ja53iJS1mq9
         2hE0sKWzmRYDpccCd8IkSxYkRLFUSePKCBn7lAims+07H+zO4UJBRx/47rUOVK+h4zzh
         XfGEBB/oBSMFJtS5L2UbUnR04px+BPpAzeptaK30puscpsRrrhbRwafY1LRzsqN3lzVO
         qJkjDcDsGBRzrkMlLmWWQh4Vksvzu/ic36QYE5ElnqgoYDwaUzhrF6Xgc9ylttuIj78+
         jQlIoEQToefs0Wf523byGeqvLgELpTc1FdHVemA9XsPH9e/I3aruNn/BDW4/kKAPPvPG
         7ReA==
X-Gm-Message-State: AOAM531CTFy9z8LCqZTBoHrUMagP6yE7+g8Ofw7GysKwjVnellIfrUau
        gbTwp8G0M8cXwvyWQ5EelFE=
X-Google-Smtp-Source: ABdhPJzcEcvHPxV6MF5NXWWou4veSt8SMjyDNTprQ4qC/0zHlveZsQAso1FXieKDqSDP6jt5ZtjyEg==
X-Received: by 2002:a05:6402:3592:b0:423:d71e:41dc with SMTP id y18-20020a056402359200b00423d71e41dcmr20806464edc.402.1650460902000;
        Wed, 20 Apr 2022 06:21:42 -0700 (PDT)
Received: from [192.168.3.2] (p5dd1ed70.dip0.t-ipconnect.de. [93.209.237.112])
        by smtp.googlemail.com with ESMTPSA id g24-20020a056402321800b00423e43ebb60sm4827837eda.61.2022.04.20.06.21.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 06:21:41 -0700 (PDT)
Message-ID: <d26393a3323dc646df88fb09ee47d712c80eafc9.camel@gmail.com>
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
Date:   Wed, 20 Apr 2022 15:21:41 +0200
In-Reply-To: <1381713434.41650433982422.JavaMail.epsvc@epcpadp4>
References: <20220419183044.789065-5-huobean@gmail.com>
         <20220419183044.789065-1-huobean@gmail.com>
         <CGME20220419183934epcas2p28272bfd9167253c2d9136c60f9050c5f@epcms2p7>
         <1381713434.41650433982422.JavaMail.epsvc@epcpadp4>
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

On Wed, 2022-04-20 at 14:31 +0900, Keoseong Park wrote:
> > +/**
> > + *ufshpb_submit_region_inactive() - submit a region to be
> > inactivated later
> > + *@hpb: per-LU HPB instance
> > + *@region_index: the index associated with the region that will be
> > inactivated later
> > + */
> > +static void ufshpb_submit_region_inactive(struct ufshpb_lu *hpb,
> > int region_index)
> > +{
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 int subregion_index;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ufshpb_region *rgn;
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 struct ufshpb_subregion *sr=
gn;
> > +
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * Remove this region =
from active region list and add it
> > to inactive list
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 */
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 spin_lock(&hpb->rsp_list_lo=
ck);
> > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 ufshpb_update_inactive_info=
(hpb, region_index);
> How about separating the "hpb->stats.rb_inactive_cnt++" code from
> ufshpb_update_inactive_info()?
> Because I think this code should only be used in
> ufshpb_rsp_req_region_update().


based on Documentation/ABI/testing/sysfs-driver-ufs:

"What:       /sys/class/scsi_device/*/device/hpb_stats/rb_inactive_cnt
Date:       June 2021
Contact:    Daejun Park <daejun7.park@samsung.com>
Description:    This entry shows the number of inactive regions
recommended by  response UPIUs."


This parameter should be increased only when recieving inactive
recommended.

I will change it in the next version, thanks.


Kind regards,
Bean
