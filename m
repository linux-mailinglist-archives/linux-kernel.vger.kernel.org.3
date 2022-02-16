Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC274B81A1
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230159AbiBPHea (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:34:30 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230139AbiBPHe2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:34:28 -0500
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92E2A12AA6;
        Tue, 15 Feb 2022 23:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1644996855; x=1645601655;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=2PBUfrZ9SAuqH80hj/mUdCSR3usd4enZGMdcy+DYL8s=;
  b=rF7LDZDazbifN9Kd9oX+g9cmLc6E5Y79WHYKXMCNpkRBzt3LIBq3HQKN
   3nls6JAoU33QoVp9FiGFFLPXol9w++RJtVK6CINN9nmossDEdBjbR+fmL
   KVi7kiEa7mIrl4Olu0fdYni5zOmiGpCbWFEWHokY/JYsUuYluI6mbynTC
   c=;
Received: from mail-mw2nam10lp2108.outbound.protection.outlook.com (HELO NAM10-MW2-obe.outbound.protection.outlook.com) ([104.47.55.108])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Feb 2022 07:34:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=fOsWcCIcS+XUvkniqQxaDzj/PMNWTCpgzyUaacuauYpD9C2xh4QdiMgIaj+M52OpeFTVKZBC77fyrZniDrQJxqh/HRgzzR3NclEwx+F03fA98sKSHbMCmZpY864nmcCNxfu3A0kWgOcBtrXHWqoxYDz03NMW1gZ1nkUh1y2gIssOZRFkPpD75gXYJOWj5FjMOdDm40St1bPM9u15eTnjInqks6P2mOeWfUWlWugFrdIvyQyCwtRsyka4ToejjGgqzBAPRY0JXqxGVf6CJISqY3wl8v3DaRvlKmWvGxRuqVPd4bkfqYpFQnqr3Iq0vycauHR+Peo1w5cS8ICdEpv31A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=2PBUfrZ9SAuqH80hj/mUdCSR3usd4enZGMdcy+DYL8s=;
 b=OZRW9BkRY55iCRVIfUjrDdn3FCB4Nx3ktanDsTcIAWGdO1H0OfPFUgZ6XLDls3W1bEra/aIblO80rqlguC/hqTNBcyWYtQCZZsh1DTbfr+tM5ARCtv1SqKroO+flj5ehA5GQVyqahpJG02YU704XTNtVZWPlSbNyyxOoDUCsCuRq5PwlKAquAcAHdkPrjjeYKirURLndNqD2ePmr/4HOj36eP00eJPn/2cFAdvanf0JeUoibCJhplBc+O5/3A8dp6+aNoNWSphZAttwV00TnwxHtmZqzK7t9BQRjvvgEz6FiMCI5xDNC6gPy3s3RM6z5NdVeMoAUvkxjwOggqxb0wQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com (2603:10b6:a03:3f5::8)
 by MWHPR02MB2799.namprd02.prod.outlook.com (2603:10b6:300:107::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.17; Wed, 16 Feb
 2022 07:34:11 +0000
Received: from SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7]) by SJ0PR02MB8449.namprd02.prod.outlook.com
 ([fe80::481d:88c5:eab3:21c7%7]) with mapi id 15.20.4995.016; Wed, 16 Feb 2022
 07:34:11 +0000
From:   "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
To:     "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "Sajida Bhanu (Temp) (QUIC)" <quic_c_sbhanu@quicinc.com>
CC:     "adrian.hunter@intel.com" <adrian.hunter@intel.com>,
        "Asutosh Das (QUIC)" <quic_asutoshd@quicinc.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "agross@kernel.org" <agross@kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stummala@codeaurora.org" <stummala@codeaurora.org>,
        "vbadigan@codeaurora.org" <vbadigan@codeaurora.org>,
        "Ram Prakash Gupta (QUIC)" <quic_rampraka@quicinc.com>,
        "Pradeep Pragallapati (QUIC)" <quic_pragalla@quicinc.com>,
        "sartgarg@codeaurora.org" <sartgarg@codeaurora.org>,
        "nitirawa@codeaurora.org" <nitirawa@codeaurora.org>,
        "sayalil@codeaurora.org" <sayalil@codeaurora.org>,
        Liangliang Lu <luliang@codeaurora.org>,
        "Bao D . Nguyen" <nguyenb@codeaurora.org>
Subject: RE: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card errors
Thread-Topic: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card errors
Thread-Index: AQHYDiMD5UGg5mvpCkudYe96kOYBs6yU/m6AgAD0c/A=
Date:   Wed, 16 Feb 2022 07:34:11 +0000
Message-ID: <SJ0PR02MB8449D9BD92EE38A4FEDDEE03CD359@SJ0PR02MB8449.namprd02.prod.outlook.com>
References: <1642699582-14785-1-git-send-email-quic_c_sbhanu@quicinc.com>
 <1642699582-14785-2-git-send-email-quic_c_sbhanu@quicinc.com>
 <Ygvb38vVeafYS4O0@yoga>
In-Reply-To: <Ygvb38vVeafYS4O0@yoga>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: b4fd9888-cf12-45ee-1c8a-08d9f11eb9b7
x-ms-traffictypediagnostic: MWHPR02MB2799:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MWHPR02MB2799B3CAC54A671F9B6183A3B1359@MWHPR02MB2799.namprd02.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1013;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: f5ndO8LfIkUfHpyjgfgiUlC+dJH0WTsn6iToFHuivcXx3Ed5TollkxAelECCrwWEUYiUauEg29lMrJS07+qmrDR3veGqkxuYsFltyj3ymfvcBl8GFUsWlUE2+WvDsP917UI7SDPozWo/kQW8pRjcMmBbDmeuxTj45XcQfnWZnitNLXCM6aGtX5IgdACkj1Ltijn3618aCut9cBQX5scCguVIESLiCD0VoFJwkOlLoPt0iqx04q42rgrEHn65Owi3DzhRurjbPow4hT+AZVEgTwohDZbXy8dmH/1OQqfox1F3bcSR9FLGKHuG0ogtnKH3KL475fzEiBgyq405la2Czs3HaRsFzgDTHF7aLZv1XWl8oAtRDhK7x0ym20Bb7lDy/9NCPbUZARGQHGOLCZy2+QiTuT0/ixmUApvEjteyBTawzEwfuV2I/DQeJ3bzuXy7xB7HOsL+9hE2TeJgSld8J0ujEot79ufsR/gg9cK99UCYJy8qP1PSylfh4F8rqUSiOEYRL3Z4rfoyPRhvSLhbtp2JgcWrW3xbCYSg4ps0vBm5mRbibv3gn8IgG1Bw9HRTJ4mwBXpA5W/L4XoiIc4fRGW2+1URkRgh/SCXVj8WresoRYZUzyrBeNbjaoyugIoAeYyDZZUpis0DYIJAdlK0qQUD5F75HHhzj/X/8pM404riJiJf5N+T9ChiWYWzCVUF08J0DUjjlwIKDuv4wZ9V8Acsdbn0yvKn5k8wFdGXI4n2MlQDaKWc3bzmiyq06kJq6dxpDKGnUsTRYFZqp01/O23wsENGOW2x4qPABUhKVc4=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR02MB8449.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(122000001)(53546011)(7696005)(6506007)(83380400001)(2906002)(26005)(33656002)(508600001)(186003)(55016003)(966005)(38070700005)(8936002)(66446008)(54906003)(64756008)(110136005)(86362001)(8676002)(66946007)(66556008)(71200400001)(52536014)(5660300002)(38100700002)(316002)(66476007)(4326008)(7416002)(76116006);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jorRjlg7pK8hDOZJlztSbN516lQ5rodKZj5woz3ZQuQIkDnWJpMo5Sx/ZBLr?=
 =?us-ascii?Q?1MCE/532u5PtQc6O1JgsdQ5TiusnN5DSLheD8XZqD5smyBfBFBvmWEozXIzB?=
 =?us-ascii?Q?yHmSxahKmTZb5JBJ1L9qSOdPpWH6A0VX4VcFJbhVPcUmT2kee13ulUVY1chA?=
 =?us-ascii?Q?M9ztGbwPCJw0KnfyzD7LgpHrt076dT0CJz6R30Re+lkUy/EDpPdcjLBXT5J1?=
 =?us-ascii?Q?wPRLFHdZsEPbhahQhDw2nlPsmEFHetSOnnsxtjsP6MMO5t8kPaananYpTQDC?=
 =?us-ascii?Q?rjTlYR9uwO3nk6gOlp8mR0fPaTho94Pox7W4diQc2RWLGi0yBvZYzvCF0dMh?=
 =?us-ascii?Q?CWLICl53J5SI5BcybPlSywJj94Vl+51a2xCgD6U3A56kQnzN2VtJYnocSagH?=
 =?us-ascii?Q?d/XD5sPb/JQ+4Ty+hA5vsArbWsFc3PDcSRxZFsBfBMsFXmec0BtbwTZm9883?=
 =?us-ascii?Q?O1snOQgZM6x7rRnChYQ9pRGGwYfEBd3a3JlKDjzs95HDIp3ygrfD6Op2hQ+t?=
 =?us-ascii?Q?kC3PJA5Tigw/6N/tdHRKfSloPj8yywssm/2fYioyt3KhT3egGjzGJIxLTUHn?=
 =?us-ascii?Q?cvo/x6moNOkIJOx6kq0UqLMa2OnjUtrYmqG09yn9YFg2ZUvsMLIi0NSSyYeA?=
 =?us-ascii?Q?MWCOcKFtmImFm77lQX8ggM3AA+0bVqdux/uEgqifTLY03H1c5rRYRSBPCYvA?=
 =?us-ascii?Q?BlT3AXqBY3cgEh6wyqt7LHUGbGeSxYDz+UtjOeXXz6Plyu5I/nA88PRhLITU?=
 =?us-ascii?Q?svh/viEFA66DTXvhiVKeW8Tn5Px0plu1as76lHwq/MdfSd+xbJQOjdIBsyl5?=
 =?us-ascii?Q?z5N4kdaSdAQaqcSEN4dmCgLnvmj6mo6RgZipYzceyhKDFLau5iCjQACqqNG/?=
 =?us-ascii?Q?EDetL/vxKnfCBpbDrToqUv9kYcMOr9gFKCxAaVW6D3myQKOmuJsHI0/F2KSM?=
 =?us-ascii?Q?It0BhuDru02u2TemcEKMPRJeB6HrnKo5deFR5D0YDGmOUbRCOAWeZFCZy+v7?=
 =?us-ascii?Q?gCgAZKl9UWbAOjLuvwKzxtV4zKIwL5BrzlG+B2nnBX+Uoc7tAY7gK5/LS+pG?=
 =?us-ascii?Q?QD/pvw0XYvZZiY2dQuR+ru4SVlJT/qLryT8xi36cNRfeBsHPyf2A3v17v9Op?=
 =?us-ascii?Q?fNET5ORqUJ1vcrZMNbDohDxbwY0Ojg/rrveGSIduyxxVzJUDU5HGQ8PmOgVe?=
 =?us-ascii?Q?Drf5UCaFdlIatX+NniA7uyIByWNLo91h8hLfcP/8Cg0j4lY5B3LKjJyjBgwm?=
 =?us-ascii?Q?oIKMOoe8J+ycBV5Z4S9eOv1nLG6ONbQO0XsZUgDd/oLEQvpmWaGGNAOMYEKF?=
 =?us-ascii?Q?WMERW3xyxZ0cFgn8dEH6XfyqSc4bjvaz2nxMzy1tP0cJuez20PzmDPztxmGM?=
 =?us-ascii?Q?7aSI+pSgPL7LekqxrtsHNxG17uHP65ynBkVffQsOn8wJ+IUspsqnYAbn31U7?=
 =?us-ascii?Q?wcNn+AWntDdEZfXpFO83YVRMljqGwcrgWxv7OFuSzVw8z+NHkNuk3cEqU0nS?=
 =?us-ascii?Q?QIBhRRjA8e0cA/fwUFzMS7KmxG/1VlOmVbJlVQiK/hfPV7ZmS2WQn+Q/2LR0?=
 =?us-ascii?Q?PLP46qKpU2Gs04iNo3cA5N8rd6fHAoru1p6ZeqYuJ0DYybprWW3k/FyQ8gqV?=
 =?us-ascii?Q?3r/v6JZtcZDF2VmMtRwRZGEnLYJaJZ46FYcy6WMwQMtSPAx8wVfrJ0ei7PhJ?=
 =?us-ascii?Q?rTqo9w=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR02MB8449.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: b4fd9888-cf12-45ee-1c8a-08d9f11eb9b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Feb 2022 07:34:11.5483
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: GK54/rbEiWhnTcTansqdrDDrqJgbf1ZoOi/enbIkN2C3/5tnNRjrNI/aa3PTtbbATKidR3hUYy1zFQ0YfaIUekdO+IYgifmXWBfu1RVJG7Q=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR02MB2799
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bjorn,

Thank you.

Sure will address this in patch set.

Thanks,
Sajida
-----Original Message-----
From: Bjorn Andersson <bjorn.andersson@linaro.org>=20
Sent: Tuesday, February 15, 2022 10:29 PM
To: Sajida Bhanu (Temp) (QUIC) <quic_c_sbhanu@quicinc.com>
Cc: adrian.hunter@intel.com; Asutosh Das (QUIC) <quic_asutoshd@quicinc.com>=
; ulf.hansson@linaro.org; agross@kernel.org; linux-mmc@vger.kernel.org; lin=
ux-arm-msm@vger.kernel.org; linux-kernel@vger.kernel.org; stummala@codeauro=
ra.org; vbadigan@codeaurora.org; Ram Prakash Gupta (QUIC) <quic_rampraka@qu=
icinc.com>; Pradeep Pragallapati (QUIC) <quic_pragalla@quicinc.com>; sartga=
rg@codeaurora.org; nitirawa@codeaurora.org; sayalil@codeaurora.org; Liangli=
ang Lu <luliang@codeaurora.org>; Bao D . Nguyen <nguyenb@codeaurora.org>
Subject: Re: [PATCH V3 1/4] mmc: sdhci: Capture eMMC and SD card errors

On Thu 20 Jan 11:26 CST 2022, Shaik Sajida Bhanu wrote:

> Add changes to capture eMMC and SD card errors.
> This is useful for debug and testing.
>=20
> Signed-off-by: Shaik Sajida Bhanu <quic_c_sbhanu@quicinc.com>
> Signed-off-by: Liangliang Lu <luliang@codeaurora.org>
> Signed-off-by: Sayali Lokhande <sayalil@codeaurora.org>
> Signed-off-by: Bao D. Nguyen <nguyenb@codeaurora.org>

Please read
https://docs.kernel.org/process/submitting-patches.html#sign-your-work-the-=
developer-s-certificate-of-origin
and the one section below on what your S-o-b actually means.

In particular this does not say "the four of us authored this patch", it do=
cuments the path the patch took to this point. In which case Bao is the las=
t one stating that he _handled_ the patch - but then somehow it came out of=
 your mailbox.

You're probably looking for Co-developed-by, which is described just below =
that.

Regards,
Bjorn

> ---
>  drivers/mmc/host/sdhci-msm.c |  3 ++
>  drivers/mmc/host/sdhci.c     | 72 ++++++++++++++++++++++++++++++++++++--=
------
>  include/linux/mmc/host.h     | 31 +++++++++++++++++++
>  3 files changed, 94 insertions(+), 12 deletions(-)
>=20
> diff --git a/drivers/mmc/host/sdhci-msm.c=20
> b/drivers/mmc/host/sdhci-msm.c index 50c71e0..309eb7b 100644
> --- a/drivers/mmc/host/sdhci-msm.c
> +++ b/drivers/mmc/host/sdhci-msm.c
> @@ -128,6 +128,8 @@
> =20
>  #define MSM_MMC_AUTOSUSPEND_DELAY_MS	50
> =20
> +#define MSM_MMC_ERR_STATS_ENABLE 1
> +
>  /* Timeout value to avoid infinite waiting for pwr_irq */  #define=20
> MSM_PWR_IRQ_TIMEOUT_MS 5000
> =20
> @@ -2734,6 +2736,7 @@ static int sdhci_msm_probe(struct platform_device *=
pdev)
>  	if (ret)
>  		goto pm_runtime_disable;
> =20
> +	host->mmc->err_stats_enabled =3D MSM_MMC_ERR_STATS_ENABLE;
>  	pm_runtime_mark_last_busy(&pdev->dev);
>  	pm_runtime_put_autosuspend(&pdev->dev);
> =20
> diff --git a/drivers/mmc/host/sdhci.c b/drivers/mmc/host/sdhci.c index=20
> 07c6da1..74b356e 100644
> --- a/drivers/mmc/host/sdhci.c
> +++ b/drivers/mmc/host/sdhci.c
> @@ -113,6 +113,8 @@ void sdhci_dumpregs(struct sdhci_host *host)
>  	if (host->ops->dump_vendor_regs)
>  		host->ops->dump_vendor_regs(host);
> =20
> +	if (host->mmc->err_stats_enabled)
> +		mmc_debugfs_err_stats_enable(host->mmc);
>  	SDHCI_DUMP("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
\n");
>  }
>  EXPORT_SYMBOL_GPL(sdhci_dumpregs);
> @@ -3159,6 +3161,8 @@ static void sdhci_timeout_timer(struct timer_list *=
t)
>  	spin_lock_irqsave(&host->lock, flags);
> =20
>  	if (host->cmd && !sdhci_data_line_cmd(host->cmd)) {
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>  		pr_err("%s: Timeout waiting for hardware cmd interrupt.\n",
>  		       mmc_hostname(host->mmc));
>  		sdhci_dumpregs(host);
> @@ -3181,6 +3185,8 @@ static void sdhci_timeout_data_timer(struct=20
> timer_list *t)
> =20
>  	if (host->data || host->data_cmd ||
>  	    (host->cmd && sdhci_data_line_cmd(host->cmd))) {
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_REQ_TIMEOUT);
>  		pr_err("%s: Timeout waiting for hardware interrupt.\n",
>  		       mmc_hostname(host->mmc));
>  		sdhci_dumpregs(host);
> @@ -3240,11 +3246,18 @@ static void sdhci_cmd_irq(struct sdhci_host=20
> *host, u32 intmask, u32 *intmask_p)
> =20
>  	if (intmask & (SDHCI_INT_TIMEOUT | SDHCI_INT_CRC |
>  		       SDHCI_INT_END_BIT | SDHCI_INT_INDEX)) {
> -		if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_TIMEOUT) {
>  			host->cmd->error =3D -ETIMEDOUT;
> -		else
> +			if (host->mmc && host->mmc->err_stats_enabled)
> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
> +		} else {
>  			host->cmd->error =3D -EILSEQ;
> -
> +			if (host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK_HS200) {
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
> +			}
> +		}
>  		/* Treat data command CRC error the same as data CRC error */
>  		if (host->cmd->data &&
>  		    (intmask & (SDHCI_INT_CRC | SDHCI_INT_TIMEOUT)) =3D=3D @@ -3265,6=
=20
> +3278,8 @@ static void sdhci_cmd_irq(struct sdhci_host *host, u32 intmask=
, u32 *intmask_p)
>  		int err =3D (auto_cmd_status & SDHCI_AUTO_CMD_TIMEOUT) ?
>  			  -ETIMEDOUT :
>  			  -EILSEQ;
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_AUTO_CMD);
> =20
>  		if (sdhci_auto_cmd23(host, mrq)) {
>  			mrq->sbc->error =3D err;
> @@ -3342,6 +3357,8 @@ static void sdhci_data_irq(struct sdhci_host *host,=
 u32 intmask)
>  			if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  				host->data_cmd =3D NULL;
>  				data_cmd->error =3D -ETIMEDOUT;
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
>  				__sdhci_finish_mrq(host, data_cmd->mrq);
>  				return;
>  			}
> @@ -3375,18 +3392,29 @@ static void sdhci_data_irq(struct sdhci_host *hos=
t, u32 intmask)
>  		return;
>  	}
> =20
> -	if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +	if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		host->data->error =3D -ETIMEDOUT;
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
> +	}
>  	else if (intmask & SDHCI_INT_DATA_END_BIT)
>  		host->data->error =3D -EILSEQ;
>  	else if ((intmask & SDHCI_INT_DATA_CRC) &&
>  		SDHCI_GET_CMD(sdhci_readw(host, SDHCI_COMMAND))
> -			!=3D MMC_BUS_TEST_R)
> +			!=3D MMC_BUS_TEST_R) {
>  		host->data->error =3D -EILSEQ;
> +		if (host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK ||
> +				host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK_HS200) {
> +			if (host->mmc && host->mmc->err_stats_enabled)
> +				mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
> +		}
> +	}
>  	else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		pr_err("%s: ADMA error: 0x%08x\n", mmc_hostname(host->mmc),
>  		       intmask);
>  		sdhci_adma_show_error(host);
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
>  		host->data->error =3D -EIO;
>  		if (host->ops->adma_workaround)
>  			host->ops->adma_workaround(host, intmask); @@ -3905,20 +3933,40 @@=20
> bool sdhci_cqe_irq(struct sdhci_host *host, u32 intmask, int *cmd_error,
>  	if (!host->cqe_on)
>  		return false;
> =20
> -	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))
> +	if (intmask & (SDHCI_INT_INDEX | SDHCI_INT_END_BIT | SDHCI_INT_CRC))=20
> +{
>  		*cmd_error =3D -EILSEQ;
> -	else if (intmask & SDHCI_INT_TIMEOUT)
> +		if (intmask & SDHCI_INT_CRC) {
> +			if (host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK_HS200) {
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_CRC);
> +			}
> +		}
> +	} else if (intmask & SDHCI_INT_TIMEOUT) {
>  		*cmd_error =3D -ETIMEDOUT;
> -	else
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_CMD_TIMEOUT);
> +	} else
>  		*cmd_error =3D 0;
> =20
> -	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC))
> +	if (intmask & (SDHCI_INT_DATA_END_BIT | SDHCI_INT_DATA_CRC)) {
>  		*data_error =3D -EILSEQ;
> -	else if (intmask & SDHCI_INT_DATA_TIMEOUT)
> +		if (intmask & SDHCI_INT_DATA_CRC) {
> +			if (host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK ||
> +					host->cmd->opcode !=3D MMC_SEND_TUNING_BLOCK_HS200) {
> +				if (host->mmc && host->mmc->err_stats_enabled)
> +					mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_CRC);
> +			}
> +		}
> +	} else if (intmask & SDHCI_INT_DATA_TIMEOUT) {
>  		*data_error =3D -ETIMEDOUT;
> -	else if (intmask & SDHCI_INT_ADMA_ERROR)
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_DAT_TIMEOUT);
> +	} else if (intmask & SDHCI_INT_ADMA_ERROR) {
>  		*data_error =3D -EIO;
> -	else
> +		if (host->mmc && host->mmc->err_stats_enabled)
> +			mmc_debugfs_err_stats_inc(host->mmc, MMC_ERR_ADMA);
> +	} else
>  		*data_error =3D 0;
> =20
>  	/* Clear selected interrupts. */
> diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h index=20
> 7afb57c..883b50b 100644
> --- a/include/linux/mmc/host.h
> +++ b/include/linux/mmc/host.h
> @@ -93,6 +93,23 @@ struct mmc_clk_phase_map {
> =20
>  struct mmc_host;
> =20
> +enum mmc_err_stat {
> +	MMC_ERR_CMD_TIMEOUT,
> +	MMC_ERR_CMD_CRC,
> +	MMC_ERR_DAT_TIMEOUT,
> +	MMC_ERR_DAT_CRC,
> +	MMC_ERR_AUTO_CMD,
> +	MMC_ERR_ADMA,
> +	MMC_ERR_TUNING,
> +	MMC_ERR_CMDQ_RED,
> +	MMC_ERR_CMDQ_GCE,
> +	MMC_ERR_CMDQ_ICCE,
> +	MMC_ERR_REQ_TIMEOUT,
> +	MMC_ERR_CMDQ_REQ_TIMEOUT,
> +	MMC_ERR_ICE_CFG,
> +	MMC_ERR_MAX,
> +};
> +
>  struct mmc_host_ops {
>  	/*
>  	 * It is optional for the host to implement pre_req and post_req in=20
> @@ -500,6 +517,9 @@ struct mmc_host {
> =20
>  	/* Host Software Queue support */
>  	bool			hsq_enabled;
> +	u32                     err_stats[MMC_ERR_MAX];
> +	bool 			err_stats_enabled;
> +	bool			err_state;
> =20
>  	unsigned long		private[] ____cacheline_aligned;
>  };
> @@ -635,6 +655,17 @@ static inline enum dma_data_direction mmc_get_dma_di=
r(struct mmc_data *data)
>  	return data->flags & MMC_DATA_WRITE ? DMA_TO_DEVICE :=20
> DMA_FROM_DEVICE;  }
> =20
> +static inline void mmc_debugfs_err_stats_enable(struct mmc_host *mmc)=20
> +{
> +	mmc->err_state =3D true;
> +}
> +
> +static inline void mmc_debugfs_err_stats_inc(struct mmc_host *mmc,
> +		enum mmc_err_stat stat) {
> +
> +	mmc->err_stats[stat] +=3D 1;
> +}
> +
>  int mmc_send_tuning(struct mmc_host *host, u32 opcode, int=20
> *cmd_error);  int mmc_send_abort_tuning(struct mmc_host *host, u32=20
> opcode);  int mmc_get_ext_csd(struct mmc_card *card, u8=20
> **new_ext_csd);
> --
> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a=20
> member of Code Aurora Forum, hosted by The Linux Foundation
>=20
