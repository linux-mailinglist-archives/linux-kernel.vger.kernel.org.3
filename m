Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 654AF50689D
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 12:18:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350616AbiDSKUn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 06:20:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245179AbiDSKUj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 06:20:39 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E28915FD7;
        Tue, 19 Apr 2022 03:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1650363477; x=1650968277;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=cLkW2rnSBUftR1iJq3eIAkRqkKpCm/vd+NTBaLFzKXU=;
  b=MLvdKGMyC8v6N/znWEh3Q0MR3oam98wygId1PyGbgX9aUdHtNuCJtUPB
   Ux0x/GFJDYjmh5jKVx4VKeJwHCKTsU7BMeWO65bBMwCxxlGv9sunaU3AS
   UDmMyBmKbtYUfspvDb7eR+OL3NOKhWeCsJKTYzA3REGW1jyq/7CIb6z+N
   0=;
Received: from mail-mw2nam12lp2042.outbound.protection.outlook.com (HELO NAM12-MW2-obe.outbound.protection.outlook.com) ([104.47.66.42])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Apr 2022 10:17:56 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jD78MAlMpUj2zcz0N3YKDLHXUwIQG4FRhthnrNBIhLfGja+Up4ohaA+ogNBzwKkRPtEeL8MpuY3XuzF6lNgtA7dwjsbcNOeUFuXvsZYAwoMiMLbDOrgEMxYRnVw7IlIGOGhYtb2RTB1x3RCkB4MqrmeksHSkvYMesvCLcFKSBdC3WGCxroznmjomDtztYqcgVY2/PJ+ieGISoWXLi64o5KhDiqVH8S50cPxGx5PI4FqGfAr9QIhf1TJdPeH9Hu/LJWxhYMjmjmwtiqINLYoWkLfEasjFTpqTol6dtrp0J9d77Xv4OrQgftc/cZce4Ps5PaEdul2EnPTCOxI9GX2vqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cLkW2rnSBUftR1iJq3eIAkRqkKpCm/vd+NTBaLFzKXU=;
 b=MdwMAToxITScNSJoKsJuLZO94U1ED51Lw7NDZhbNFImZh03xDxdi9D5e1CScTM5W+IS03LMhcBzQgTVQGnETBtql30U8NIAuJob6bwju2lD3/1SVYf0M8GSr8XCNfGUt5/xNGTPeBnvZnDva6YyesdnaWCuaEqIOzWtiw96JuuOa9rNJ4yonDpy1iJ421kBnFkOE1rXiAlaAb/uC0C4nGKjdnM+ubMgTo5kf8pkiHGwgmbk3L4BTcnz0xDQgrwHhVoCmRqCCVlOTN3Upi6j1TTSrll5DXvEJ49ZZri2kr4Q2xF0nVqX0vrLlerYWjQPh4BZ5n9B8axPytUKFpv7KeA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from DM6PR02MB4857.namprd02.prod.outlook.com (2603:10b6:5:fe::12) by
 MN2PR02MB5806.namprd02.prod.outlook.com (2603:10b6:208:111::26) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.18; Tue, 19 Apr
 2022 10:17:54 +0000
Received: from DM6PR02MB4857.namprd02.prod.outlook.com
 ([fe80::981a:7055:321a:b3b8]) by DM6PR02MB4857.namprd02.prod.outlook.com
 ([fe80::981a:7055:321a:b3b8%4]) with mapi id 15.20.5164.025; Tue, 19 Apr 2022
 10:17:53 +0000
From:   "Sandeep Maheswaram (Temp) (QUIC)" <quic_c_sanm@quicinc.com>
To:     "Sandeep Maheswaram (Temp) (QUIC)" <quic_c_sanm@quicinc.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>
CC:     "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Pavan Kumar Kondeti (QUIC)" <quic_pkondeti@quicinc.com>,
        "Pratham Pratap (QUIC)" <quic_ppratap@quicinc.com>,
        "Krishna Kurapati PSSNV (QUIC)" <quic_kriskura@quicinc.com>,
        "Vidya Sagar Pulyala (Temp) (QUIC)" <quic_vpulyala@quicinc.com>
Subject: RE: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers 
Thread-Topic: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers 
Thread-Index: AQHYSmJOJDsfF5O5Dk6Bg2MRoGNGV6z3F9gg
Date:   Tue, 19 Apr 2022 10:17:53 +0000
Message-ID: <DM6PR02MB4857A0ADCDA1558DE58E103ADFF29@DM6PR02MB4857.namprd02.prod.outlook.com>
References: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
In-Reply-To: <1649323888-12420-1-git-send-email-quic_c_sanm@quicinc.com>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8f581936-5f80-431e-f872-08da21edddd2
x-ms-traffictypediagnostic: MN2PR02MB5806:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <MN2PR02MB5806A66C4C62B04878CEC444A3F29@MN2PR02MB5806.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kRPzlEfQQRvok5LoAppbODyhOVlfBnmhv3SaRjVBq2yvUAJCXPK0XKpY0+o7at2RAqfuOpRvhPLHvodXluq3AqYp4TD8lKF5DgEJjAlLba0Cdyo4JD41XFuxsCWMkZTzIxHraxu1etGM4BGx176X9qEwVv/rHt50Lzfra5QQWdUSS5z7IzPKIEh2U93m8yOHR+GgX3wzYiocsdRlulLW+i4T3F+200mYMvjmTUGwz6541K4J9153Ih5F2JRa0seEJb8fbAlvn/GMf5QESwhoCvcyhyhOim1PY6u42GuXnYMoG05nZxu8r2d7rQnzkzFBYZ4vFxm0hBTHN1ktFlD/muFhc3jGD8bLB0gDsLiWgm8GQWU2HEf9dwaP/edAw105UaLB3fCRyPfi7jcD99BrJerf7gtftyhYcFZiRLALfmR+mN4oyg37LFDZR4fcRVE7YSJWy5SXdFrhXZrr2yDVXjWHheQIm/CZaYQXHX3mfpENubJ7+qqM2o3fICrWWc6MRGevP+7pur/Z/CrIh3zX/S+VXHTxVNQGNZQlw0kjq0UWa3EJsJnWNA6Sv3FcwCG71EyXm78PgWDAuVWaQKxqSbtrjqZozd4AzfIPox8LvKoxsMpLXcYBkmPoMQEwMSyAcRTXHfA9MuktciQzHoGIsSCTSQ7Hxz1kUo0aGHpkAfO6yta7yNs/QCZQcXwVJcUC9h2FKiBU7p1mDRw5ePAxO/3j4g/8IItIwaRQqfzT9TtQgShSFxaqalJAs62HWeV66YWsNg+Q6GI/LQps262Xc2ILQFg8rdw39Igs115cEti5STt8vgEci8K8QEiJqBzGSjpqyidINsx/hfpJh6R/3g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM6PR02MB4857.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(186003)(26005)(4743002)(53546011)(6506007)(7696005)(9686003)(110136005)(71200400001)(76116006)(2906002)(8936002)(5660300002)(33656002)(52536014)(107886003)(83380400001)(55016003)(966005)(64756008)(66946007)(66446008)(66476007)(508600001)(66556008)(8676002)(54906003)(316002)(4326008)(122000001)(38100700002)(38070700005)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?oYjNDkUMrMCYn9HkYQQPQ2WRhyBWhuqukz6M1kE2M9jV5FNH6xfr3ka5Id1x?=
 =?us-ascii?Q?C8YMEwP/NBI9QXm9o3n6F7aJdvMIWb5RSMBkO+ZgMnoijqbBlOylmvacDVXC?=
 =?us-ascii?Q?qXGfoMJrlSOwq9go6FcguVJ1rPOYksp5+HfriEXiI0uFfaobgUZSHZO4nZqc?=
 =?us-ascii?Q?uJoaKgy0rqEBNHnhEQTZLqKMAgBZeBO+XRrKLJ3nDsIzdfMYbHrA6PWtZ6c+?=
 =?us-ascii?Q?cMUcLLign91b3tBe5fS20YxlTP31TVn6f6lr2DlfInqx9G+Y8nFsC7M4X7Mw?=
 =?us-ascii?Q?KLS6FCGO+eIbnL5lB9Apax9kYxeanzkLQ6gcLraRuvF7U1RM9F6AEIZd0YTu?=
 =?us-ascii?Q?Bg7K4ogrqfK10S9R3LdTHmMnxAfy5y7IBiFVmyIwbVHTyX9CjROJ7uTXt5SH?=
 =?us-ascii?Q?aU7iNytF0bZYilrAWR80krMYSkh6dAHeX+BVJjIr0bSdnZR5c3RypNDUxMKD?=
 =?us-ascii?Q?nh6iRu3akBEH4FVBdleDObLbd6Z2YKGvshxcGGyZ3giyCaBkAXq1AS6nTS+a?=
 =?us-ascii?Q?1QYL9NwkSSNJv3Fq8C1GYneW+CN/f3avIaVUFMFi78hBFVjPYVTvt6zC2QYR?=
 =?us-ascii?Q?pJlrIQvwg2OP2YRU+Hj2RM+re/nR8Ee2nHl1uX8+BNgdVUJs2+eTY2ijNg9M?=
 =?us-ascii?Q?Zi1nZK73+1xMsbYwUCqrfd1dfY8sG2vMC2RE+BFKwBYO5pAi50WcWrjiIFWF?=
 =?us-ascii?Q?NaYf7zQDzAlKkpu79ODdgy3VoZHl5/GT8naTSyMk6atsRTXnoKGUGc/TKWf7?=
 =?us-ascii?Q?CQ/Gr9n5HNJhcuYFoh2KfkpmDlbQXLNTJxzkBSPjIRAG7/swNviI1rlouqSS?=
 =?us-ascii?Q?loUKKvx6TIzd/GH0r28KNm0QPI7kSJqSjYgXFjUnre8eme4EbAto1ENa/kBj?=
 =?us-ascii?Q?KfbM4c/P5Ku+mJbM1/3IGza60suhCqQTZxZjAT1QBJkk411ZcOFWCxObT18d?=
 =?us-ascii?Q?5T3CujWpbfeSnMKlRZcDJO3DCeV0Xd9PpdfaUY7VN1wHaVWqxvjNGhEJClLI?=
 =?us-ascii?Q?bcvFRgXq0wfPlvZCxK2jwRMDHcHc4Ugk75tPJSR1Qt7dobmQEI2or5pNX8EW?=
 =?us-ascii?Q?OLi8AKzP7HqqueZqxcMC2PxA9fLfG6tpug/ykoByxluVrgr3r1qM3bokDP0X?=
 =?us-ascii?Q?5grMLrQmYennJsYDMehyGRW2X86p8ULOReCO7PbUomDz3ZowwRSMVK7UXQg5?=
 =?us-ascii?Q?UkbYmg/vMTI77JfwC2ZdSer2rjX5nTK+aGR1lqxCWsALTTEIbO9fmbpw1SVM?=
 =?us-ascii?Q?y/LwlqoK0ooEWnKMnb9bMweRtv/hXJHVGStfWU4qJjpZyfJ8fiyw80WysghU?=
 =?us-ascii?Q?/HfzZpEDNQXLH+qomiQfA+qYcN1EeW3DDdpUUzriUpYaxsku7BsEeTdr4N3p?=
 =?us-ascii?Q?V0pXIYb38xsQcWH1WLRCrXAAPWhHHt0Zx8hXd4JKhMBTbf64gCnBKVJ+y1WC?=
 =?us-ascii?Q?VX7HL97AQ3WCIGQzf9qccrN2S/NdtLhJAhqctdGlG2hBf3vyTqhzNvUy1Sc/?=
 =?us-ascii?Q?uz/1XD0ZaSCePri3ZbucPrZjuzUYG9kWOuEi8Ok4fC8Koyf294PP/CdHejBt?=
 =?us-ascii?Q?gGzbi9wBdCBpBaOJ5uCWuBkIwRBkQuMrsPWVOebFKlo7WY3vuGo4lekBil5O?=
 =?us-ascii?Q?fg95SpeDJznanGw63Pr0lgTsmGHykgZC2m2HbAYeLog3ylpNrSrq6vYsPiqo?=
 =?us-ascii?Q?o1n6LwQQtPkSr+1w+O/qhY+nvn1a77/ruH+kn0GYrOs9hPXsB93y4ipST0j8?=
 =?us-ascii?Q?yRMIsUOyWA=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM6PR02MB4857.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f581936-5f80-431e-f872-08da21edddd2
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Apr 2022 10:17:53.7653
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: CzrNnkhpCleRK+TuUOltJeSMLHtai6AwNLBY3y8OGrtQ39M/B3E3gvPQ4zigDWcIy1c9kjkEd0U+cIjIxmmBWg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR02MB5806
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathias, Felipe,

> -----Original Message-----
> From: Sandeep Maheswaram (Temp) (QUIC) <quic_c_sanm@quicinc.com>
> Sent: Thursday, April 7, 2022 3:01 PM
> To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>; Felipe Balbi
> <balbi@kernel.org>; Stephen Boyd <swboyd@chromium.org>; Doug
> Anderson <dianders@chromium.org>; Matthias Kaehlcke
> <mka@chromium.org>; Mathias Nyman <mathias.nyman@intel.com>
> Cc: linux-arm-msm@vger.kernel.org; linux-usb@vger.kernel.org; linux-
> kernel@vger.kernel.org; Pavan Kumar Kondeti (QUIC)
> <quic_pkondeti@quicinc.com>; Pratham Pratap (QUIC)
> <quic_ppratap@quicinc.com>; Krishna Kurapati PSSNV (QUIC)
> <quic_kriskura@quicinc.com>; Vidya Sagar Pulyala (Temp) (QUIC)
> <quic_vpulyala@quicinc.com>; Sandeep Maheswaram (Temp) (QUIC)
> <quic_c_sanm@quicinc.com>
> Subject: [PATCH v3 0/2] Skip phy initialization for DWC3 USB Controllers
>=20
> Runtime suspend of phy drivers was failing from DWC3 driver as runtime
> usage value is 2 because the phy is initialized from
> DWC3 core and HCD core.
> Some controllers like DWC3 and CDNS3 manage phy in their core drivers.
> This property can be set to avoid phy initialization in HCD core.
>=20
> v3:
> Coming back to this series based on discussion at below thread
> https://patchwork.kernel.org/project/linux-arm-msm/patch/1648103831-
> 12347-4-git-send-email-quic_c_sanm@quicinc.com/
> Dropped the dt bindings PATCH 1/3 in v2
> https://patchwork.kernel.org/project/linux-arm-msm/cover/1636353710-
> 25582-1-git-send-email-quic_c_sanm@quicinc.com/
>=20
> v2:
> Updated the commit descriptions.
> Changed subject prefix from dwc to dwc3.
> Increased props array size.
>=20
> Sandeep Maheswaram (2):
>   usb: host: xhci-plat: Add device property to set XHCI_SKIP_PHY_INIT
>     quirk
>   usb: dwc3: host: Set the property usb-skip-phy-init
>=20
>  drivers/usb/dwc3/host.c      | 4 +++-
>  drivers/usb/host/xhci-plat.c | 3 +++
>  2 files changed, 6 insertions(+), 1 deletion(-)
>=20
> --
> 2.7.4

Please let me know your opinion about this series.

Regards
Sandeep
