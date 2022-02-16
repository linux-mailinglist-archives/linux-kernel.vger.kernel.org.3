Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A08B64B8D46
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 17:07:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235970AbiBPQHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 11:07:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:33944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235942AbiBPQHT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 11:07:19 -0500
Received: from alexa-out-sd-01.qualcomm.com (alexa-out-sd-01.qualcomm.com [199.106.114.38])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F0F42DE9
        for <linux-kernel@vger.kernel.org>; Wed, 16 Feb 2022 08:07:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1645027627; x=1676563627;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=Gbm/qLf0bhmHpiUm7cUvEmurhPnWsvc5iBPuaTsL0Do=;
  b=PNYnoeirRyFMQHIcNY0G5ijGbgQlGX6/ErzoH+x+fqgadc2Z+mg52K75
   jMfao0IbVNnMNTDouxRWy/AGNvXr1ggDAjl+jkI+852x8QoSa5DWw7/mj
   YZlcosLtbwEagDyegxhq4BFLbBT7IZnmogGIM0r207yUAjI7wQMsQ385M
   M=;
Received: from unknown (HELO ironmsg05-sd.qualcomm.com) ([10.53.140.145])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 16 Feb 2022 08:07:07 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg05-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 08:07:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 16 Feb 2022 08:07:06 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Wed, 16 Feb 2022 08:07:06 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::a58b:cd8b:e019:f01d]) by
 nalasex01a.na.qualcomm.com ([fe80::a58b:cd8b:e019:f01d%4]) with mapi id
 15.02.0922.019; Wed, 16 Feb 2022 08:07:06 -0800
From:   "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>
To:     Christoph Hellwig <hch@infradead.org>,
        Vidya Sagar <vidyas@nvidia.com>
CC:     Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
Subject: RE: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Thread-Topic: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platform
Thread-Index: AQHYHsBOpLTvLkaTP0STBN0OK3zww6yOaCmAgAfvxCA=
Date:   Wed, 16 Feb 2022 16:07:05 +0000
Message-ID: <9b291987cf914f119788c42b32a08a12@quicinc.com>
References: <1644526408-10834-1-git-send-email-quic_nitirawa@quicinc.com>
 <YgYAs7R/1G2Y2kpz@infradead.org>
In-Reply-To: <YgYAs7R/1G2Y2kpz@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.23.73]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christoph/Keith/Rafael

Since we are giving control to PCIe (NVMe power rails control), it can vary=
 from platform to platform.
More over, PCIe driver doesn't control these power rails directly from PCIe=
 driver, they tie nvme supply with one of the pcie supply and control them =
together.=20
So i think it would be better to either have quirk based on platform or alw=
ays setting simple suspend and platform which needs full suspend can update=
 it through some means.=20

Based on below link, Looks like this can be across platform ...vidya also m=
ention similar concern for tegra platform. =20
https://lore.kernel.org/lkml/20220209202639.GB1616420@dhcp-10-100-145-180.w=
dc.com/T/#md10b0108b3ccbb1254fe0ad8dbb6e98044a8820b

Please let me know your opinions.

Thanks,
Nitin
-----Original Message-----
From: Christoph Hellwig <hch@infradead.org>=20
Sent: Friday, February 11, 2022 11:53 AM
To: Nitin Rawat (QUIC) <quic_nitirawa@quicinc.com>
Cc: Keith Busch <kbusch@kernel.org>; Jens Axboe <axboe@fb.com>; Sagi Grimbe=
rg <sagi@grimberg.me>; linux-nvme@lists.infradead.org; linux-kernel@vger.ke=
rnel.org; Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v3] nvme/pci: Add quick suspend quirk for Sc7280 Platfo=
rm

On Fri, Feb 11, 2022 at 02:23:28AM +0530, Nitin Rawat wrote:
> Enable quick suspend quirks for Sc7280 platform, where power to nvme=20
> device is removed during suspend-resume process. This is done to avoid=20
> the failure dring resume.

You need to sort this out in the PCI and PM layers.  The broken platform wi=
ll also affect all other PCIe drivers and not just nvme.
