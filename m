Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEB374B13B4
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Feb 2022 17:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244951AbiBJQ62 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Feb 2022 11:58:28 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:41500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244504AbiBJQ60 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Feb 2022 11:58:26 -0500
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDBF6B8A
        for <linux-kernel@vger.kernel.org>; Thu, 10 Feb 2022 08:58:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1644512308; x=1676048308;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=GYGzyzkgR/rYPrMVbdP7rjEVKe0/Bk0Twcm4LdpnhDI=;
  b=gMhaOV6Bm1FoQeJDv2Wqz0PKSAgnLDbJw98xambM8igzN4QFL2rU5wBz
   uc4fDIObVcyGgHcW/9s/4TXjOupSWLr33VtBHhCh20X/QOsIUQ0C8beQT
   /YTbhh+9I624I4JVgTzXeZQ0LGI+LEctQ1JY1KR0mKDb8JTdLI0zWJRaL
   8=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 10 Feb 2022 08:58:27 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Feb 2022 08:58:27 -0800
Received: from nalasex01b.na.qualcomm.com (10.47.209.197) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 08:58:27 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Thu, 10 Feb 2022 08:58:26 -0800
Received: from nalasex01a.na.qualcomm.com ([fe80::bc64:9e8c:e944:8704]) by
 nalasex01a.na.qualcomm.com ([fe80::bc64:9e8c:e944:8704%4]) with mapi id
 15.02.0922.019; Thu, 10 Feb 2022 08:58:26 -0800
From:   "Nitin Rawat (QUIC)" <quic_nitirawa@quicinc.com>
To:     Keith Busch <kbusch@kernel.org>
CC:     Jens Axboe <axboe@fb.com>, Sagi Grimberg <sagi@grimberg.me>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
Subject: RE: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Thread-Topic: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive.
Thread-Index: AQHYHni/VohKdx1dg06GCWGFwibsxqyNZ0MA//+aLKA=
Date:   Thu, 10 Feb 2022 16:58:26 +0000
Message-ID: <eb186ce5e5f84bf193bc3fef0860b92b@quicinc.com>
References: <1644495676-8124-1-git-send-email-quic_nitirawa@quicinc.com>
 <20220210150114.GB1617879@dhcp-10-100-145-180.wdc.com>
In-Reply-To: <20220210150114.GB1617879@dhcp-10-100-145-180.wdc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.216.37.205]
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

Thanks keith for review.
Yes moved the condition check outside vendor/device check in Patchset 2.

-----Original Message-----
From: Keith Busch <kbusch@kernel.org>=20
Sent: Thursday, February 10, 2022 8:31 PM
To: Nitin Rawat (QUIC) <quic_nitirawa@quicinc.com>
Cc: Jens Axboe <axboe@fb.com>; Sagi Grimberg <sagi@grimberg.me>; linux-nvme=
@lists.infradead.org; linux-kernel@vger.kernel.org; Sajida Bhanu (Temp) (QU=
IC) <quic_c_sbhanu@quicinc.com>
Subject: Re: [PATCH v1] nvme/pci: Add quick suspend quirk for Toshiba drive=
.

On Thu, Feb 10, 2022 at 05:51:16PM +0530, Nitin Rawat wrote:
> The Toshiba KBG40ZPZ256G SSD is having resume issues on SC7280 platform.
> Hence enabling quick suspend quirks for Toshiba KBG40ZPZ256G on sc7280=20
> platform so that nvme device is taken through shutdown path during=20
> resume.
>=20
> No issue is seen after enabling this quirks.
>=20
> Signed-off-by: Nitin Rawat <quic_nitirawa@quicinc.com>
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> ---
>  drivers/nvme/host/pci.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
>=20
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c index=20
> 6a99ed6..04c5954 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -3032,6 +3032,15 @@ static unsigned long check_vendor_combination_bug(=
struct pci_dev *pdev)
>  		if ((dmi_match(DMI_BOARD_VENDOR, "LENOVO")) &&
>  		     dmi_match(DMI_BOARD_NAME, "LNVNB161216"))
>  			return NVME_QUIRK_SIMPLE_SUSPEND;
> +
> +		/*
> +		 * Toshiba KBG40ZPZ256G on Sc7280 platform is having NVMe
> +		 * Resume issue. Appending quick suspend quirks for sc7280
> +		 * platforms so that full NVMe device shutdown path is
> +		 * executed during resume.
> +		 */
> +		if (of_machine_is_compatible("qcom,sc7280"))
> +			return NVME_QUIRK_SIMPLE_SUSPEND;

Shouldn't this check be moved outside the vendor/device check? It doesn't s=
eem like this behavior for this platform is specific to any particular cont=
roller, right?

Otherwise, looks fine.
