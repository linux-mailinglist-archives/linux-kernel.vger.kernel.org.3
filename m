Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3889562120
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 19:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236039AbiF3RTQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 13:19:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232479AbiF3RTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 13:19:13 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.140.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FA01C13C;
        Thu, 30 Jun 2022 10:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1656609552; x=1657214352;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=wIrfRBQvcWRlSO8qEvQoCs0F7srwRo75xrLC4posI5M=;
  b=hcrnGfdCI8BYCTJx2erP2fLUap5jEszpyc4Gqmbs1bDj3+N7CBJkD7aV
   bISpA9tlyIt83dFZR1ftJpF6DjEFH9VYBKArQzWJsvtJ7j95A33aW07qV
   TPTXWtRUhg5mewwZ6Ool3tDgPGlJeNRNU9hf6ZCCNiqEXDeySfVqd1SBd
   8=;
Received: from mail-sn1anam02lp2044.outbound.protection.outlook.com (HELO NAM02-SN1-obe.outbound.protection.outlook.com) ([104.47.57.44])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jun 2022 17:19:11 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Zr9sJX7T+/9i1tquUTupwMBRXHbLrLWrF1jGLK8O+aQ5uYVZdzrIs5TfpOmSW9NsW1tCXkKfovv3lddO8+cvy5m4Nmx2Dr/AFBiJEhTS2KES//wBecPxMtzDSaZ+oSVld8i3TLPQwaU/vKS5NyloeNOePzc1sVKg8PASqtCyt3AFNALcUgwbWT/bAXdBrUAdKUjK+dwuwSa8qY8HG73SDKJAOozOR7xsBrOXm2sS8SQlA+Zg00CJIZeUTilfIT5L8ZtSlKIKSX1A02lOpt3gAd+qLn+x+tPF2DYIYyG2dj2WeW9E101s6tAVzhtz+mmnSXVywikIn2qql1rsD7RCXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wIrfRBQvcWRlSO8qEvQoCs0F7srwRo75xrLC4posI5M=;
 b=KoMIvXUgzTxYvWGJ21UTdvlEOlbGgNXD+7cm1H5WKEdEzd4Va26V/L8FloKjqAWPUP7Bgbh85xc1cW9t3BZaEXWXNz2k0vTcudBorrBkNge30P/+eJaMr3zc18rDC9RWu4JzVP2CvB8476BcOTAhMiSjBhz5ljjQhPKEHad4azhlBKscG3gPcNfAtj5wlkq844IO0bThElIynM16o15CVJqBubaTG4oA8WyRTLA/U5L1QIrYZmJZwqLLpzTiB6PQ/RXcsOdruqw9UNo8/brnqyabLH8ftBNUJPMklw1NL0COXtaL45eHDEyMJr7Io2DUEzPv49/j7+7GpwjYVGwqjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by SN6PR02MB5518.namprd02.prod.outlook.com (2603:10b6:805:eb::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.15; Thu, 30 Jun
 2022 17:19:09 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::e861:e6a:b148:865b]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::e861:e6a:b148:865b%3]) with mapi id 15.20.5395.015; Thu, 30 Jun 2022
 17:19:09 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     Greg KH <gregkh@linuxfoundation.org>,
        "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
CC:     "agross@kernel.org" <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        "konrad.dybcio@somainline.org" <konrad.dybcio@somainline.org>,
        "jirislaby@kernel.org" <jirislaby@kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "mka@chromium.org" <mka@chromium.org>,
        "swboyd@chromium.org" <swboyd@chromium.org>
Subject: RE: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Thread-Topic: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() which
 otherwise could return a sub-optimal clock rate.
Thread-Index: AQHYi58pVIc+cNioKEmeVrCYMiTPqq1oDR+AgAAlBxA=
Date:   Thu, 30 Jun 2022 17:19:09 +0000
Message-ID: <BL0PR02MB45646DE7D61E648321E9FBB5FABA9@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1656496841-5853-1-git-send-email-quic_vnivarth@quicinc.com>
 <Yr26oSKOhIBMaKsS@kroah.com>
In-Reply-To: <Yr26oSKOhIBMaKsS@kroah.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: cf8814e0-630c-43bd-f805-08da5abca4f8
x-ms-traffictypediagnostic: SN6PR02MB5518:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 59W4dAhUzUAkjj0aKvokjgoeilVFgdCXYRi+I/1ZA7at6A+26kFNyZy/+F9Wjap/Wt8fMeQqJB/9epNV+n9ach7LGEgfwFXiW9LXM+LeVLYvJx56F0OJSubYBqamlk2WiZXl7SIajqfWkcsLiorh6mXO92vEIOrjQSzyJZSl7g6q2LzTXVFp2oG5Jk+2c/vMapyjPVJexfN7edPyRBaiF2zuWcM/LtHwKZeiCVoZwRvHcIxkDkFLygChltKw/Pk73nOq8HJ3Y/7e9RRpJdNGZShYjZt54VJlS3A/8Yl+5lvDZgbjqlB7TT494gAM3G9N2Zpad3EQf7v3mr+g7EoNTKpeTRk9ZOSBlwKAO3dFOr1313Xj5WVbPQ7SWddUFlRIwU8LJVtpP9ia7nn+BBsM3nf1TKLgwtm6OtM5UdjETxbBEuLesdKYAxDTpD7DzVo+a8Db6gaUeX8UR2vQiXqKW43eiNownXVAHDFY6H0db2P+TAGrHWmN/2dtKSr+osBv4LUtxMy78+pqwD5HRWwulBc+F8yRxJqL0TgyB1mPY19O6F3+oFcF0A45gmq8eouc7l3FXOl1IblYWYW6aN67i01R4OuduOSqOAMyEPiMBsnbE1b49CW61UCDbQmly1aLmsgxCTiptFmv5XtuIVYxGkKYJ7gvecopiue73RK50NiPvSLxyfVDsEJ/8WMP9z+eYQCgMCrhC8KuMZbCaK26un2t5hFTKvUFIC107OFYdO/NpZqwBUmgunpw3xbRSNzLLkbwZAhqoTu42eHFVABdq2t6sUNZyiDCJQeacgPrBtpnHihENE/YwaJGszStr0ol
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(376002)(39860400002)(366004)(136003)(346002)(71200400001)(55016003)(76116006)(66946007)(66556008)(8676002)(5660300002)(66446008)(53546011)(7696005)(38070700005)(64756008)(186003)(6506007)(86362001)(4326008)(33656002)(8936002)(478600001)(52536014)(2906002)(122000001)(7416002)(41300700001)(66476007)(9686003)(54906003)(26005)(316002)(38100700002)(83380400001)(110136005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?g1qHCO3Ci1WEWPD4gxavUjdcrlVqFRFaf3bNcV1PSBZ8J7TYZSxuQm4ruN9o?=
 =?us-ascii?Q?zfvcPBRhXWx3oBopYPM52yfVGCsFyncB4sWVrGmeWmbBvSWXoqYdVaB2/HNL?=
 =?us-ascii?Q?TicYx4xU6QC7ArtNm4V3J3cHuzXazHkiCRli/4JwUJhIOQ6qScuYLLmQG8xJ?=
 =?us-ascii?Q?hhq6+L3dKh/cIMtlh98vtVGmshBu4gelft7zdJJVpuPJ+UL4NNWfXsbpHeIA?=
 =?us-ascii?Q?zjSB9+WNJwLFmViFslDy/yR4fbKcVhL6L8E4Gq9SXrKGrMJIDX7/KFEqeoFE?=
 =?us-ascii?Q?K9xAmWzHfk88FuF436WHK2pV+ohqwYK14mXIeDwPUojXgnLvE+Nj4tHrEbAQ?=
 =?us-ascii?Q?qiVW9/rP0emaSomHe6aYGD3c50zMke11SxE+KQp0YcPRUgSO+T2G7sy0zBG+?=
 =?us-ascii?Q?K6U8wP/boAR+yZV0xSF+O52LxMCZPm79Y/kO0oMyB74S9tbF25WqPtxObnxG?=
 =?us-ascii?Q?pEWDt29fbEWXyb7xQ+G1ZrjOAXQAbNG5pZzWI75bj4bcItF6qtsQSrFzuj4e?=
 =?us-ascii?Q?Z9ia1Jp+qYa/MBWKvbJynjlajzA0w5zfRkwf61E74PraAP59DIAeuOyvsyka?=
 =?us-ascii?Q?LofeV0S057M01w9ExMvW0i8iBrdaHgeXrE0g1nu3Rdf6TelpKQTnWD84nDCP?=
 =?us-ascii?Q?+pOAyjl+7tXKvV+6vfuD0HGfSX8Y/4aLc53yjDrqfjExdcZ3W9BzG1HtOe6+?=
 =?us-ascii?Q?imRsjWROXPE6aHbrGMg9XsajJ/7cYJ7y7ljHWxUqVrJtPno+3aNnsEKHS3ZC?=
 =?us-ascii?Q?2xEH0FzlGtZMjpkqJl8i+vwuOBEUGl4znfkegZONgr+tTeFZi2z5SUVUbMet?=
 =?us-ascii?Q?Gk5GYN8NhzXKWlQY+DF4+A4hjhcKf0uoaMifFILU2HgXVtj1umMWv2/yLCTB?=
 =?us-ascii?Q?j1c9kAyeN+BxRyVjjhOq8gyaL24NcubsXMwlcTqD4mxShTPEZZf/X31cD3hh?=
 =?us-ascii?Q?0oAcwBRXc2QsdFyRi8JwIC35zQdPDNczsWhCJwdzaBbbuoLwD6v8iDUzevUB?=
 =?us-ascii?Q?yPeJvz26CmaaUg1dQk1hPy9+2g8r6JwPWR26f1+MIw45QjBMQjyR4FY+8mFG?=
 =?us-ascii?Q?9Sjr5i9b9xIzSvqDoLKbL4wpQBLjI/wZFWwuAg/3ZkO7yco6uqO0iJi9d9xw?=
 =?us-ascii?Q?x14KO0mVr/I/eA6Z3loOFAgDfsv80VKfMiTczhlPwfcGEYnLR2vivDIl5UAC?=
 =?us-ascii?Q?NDNuoKpKkQVnORhNoVY/FuXKv8m/if1ma9Vb2xCjIPPakCQAQxBb1lQS67p+?=
 =?us-ascii?Q?TL8guj+rbkvePgKSMtBsYrlLd6Kx03w86zpWt6R9l777Z5mUSjXqOceOIDoE?=
 =?us-ascii?Q?BOtgnowBYvzQnVFc39xVXfV70X5+KGSCvdbACgjrRonHwp6FBGGRJ4MN/t+n?=
 =?us-ascii?Q?qiktHa3XDdxtHZITC/olOeo7I0F8Y67zh315nOtZ2Bpsf/qNB1FfMaqX8aHL?=
 =?us-ascii?Q?56fwgdJyg2M2RHNSxVC/9RmFjllaHD2lx/kjCMV5CG7E7dSeRVOxFpa1NgXH?=
 =?us-ascii?Q?F75EXpgWQkKB+eDMD4Rmkgl4DScvzmensqWEBXbESuYdqHNFAxH1uqFmQu7m?=
 =?us-ascii?Q?mMg/gRhW+Z8KA39xiRIpK18OAwA/wVYzQWqlszxl?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: cf8814e0-630c-43bd-f805-08da5abca4f8
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Jun 2022 17:19:09.3852
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: j98nO2s6iUy9MvGn3l6G//CWmB2Gfm7BIk1yq+a2pMV41wbhJ7GysqfekRAzWfWLUhh4L42GX5BnCifbP+OhNewNd36vO+HTTBvvhPrJtHs=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR02MB5518
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Greg KH <gregkh@linuxfoundation.org>
> Sent: Thursday, June 30, 2022 8:31 PM
> To: Vijaya Krishna Nivarthi (Temp) (QUIC) <quic_vnivarth@quicinc.com>
> Cc: agross@kernel.org; bjorn.andersson@linaro.org;
> konrad.dybcio@somainline.org; jirislaby@kernel.org; linux-arm-
> msm@vger.kernel.org; linux-serial@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mukesh Savaliya (QUIC)
> <quic_msavaliy@quicinc.com>; dianders@chromium.org;
> mka@chromium.org; swboyd@chromium.org
> Subject: Re: [V2] tty: serial: qcom-geni-serial: Fix get_clk_div_rate() w=
hich
> otherwise could return a sub-optimal clock rate.
>=20
> WARNING: This email originated from outside of Qualcomm. Please be wary
> of any links or attachments, and do not enable macros.
>=20
> On Wed, Jun 29, 2022 at 03:30:41PM +0530, Vijaya Krishna Nivarthi wrote:
> > In the logic around call to clk_round_rate(), for some corner
> > conditions,
> > get_clk_div_rate() could return an sub-optimal clock rate. Also, if an
> > exact clock rate was not found lowest clock was being returned.
> >
> > Search for suitable clock rate in 2 steps
> > a) exact match or within 2% tolerance
> > b) within 5% tolerance
> > This also takes care of corner conditions.
> >
> > Reported-by: kernel test robot <lkp@intel.com>
>=20
> Did the test robot really report the original issue, or just the v2 chang=
e?
>=20
> thanks,
>=20
> greg k-h

Test robot raised error for v1 patch and (I think) it got addressed in v2 w=
ith call to div_u64.
V2 doesn't have this error but other warnings which I am addressing along w=
ith other feedback.
Below is the error raised for v1.
Thank you,
Vijay/


All errors (new ones prefixed by >>):

   arm-linux-gnueabi-ld: arm-linux-gnueabi-ld: DWARF error: could not find =
abbrev number 121
   drivers/tty/serial/qcom_geni_serial.o: in function `find_clk_rate_in_tol=
':
>> qcom_geni_serial.c:(.text+0x764): undefined reference to `__aeabi_uldivm=
od'
