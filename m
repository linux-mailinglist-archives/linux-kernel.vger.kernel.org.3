Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71D4D55735C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 08:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiFWGxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 02:53:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbiFWGxj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 02:53:39 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DE033B003;
        Wed, 22 Jun 2022 23:53:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1655967215; x=1656572015;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=ythyCRJjMu1c1gVpaSsk+/RrL73NfzS1d5MoENdvEzs=;
  b=nH8C/JTpgsc2rWg09xNSh+4/7a/1RWuDQFH6PVYFZPRGtVVYoWANMCzd
   MZF0SKTEOZeomIHAlm/8dmMuLARh7tdaCLqNESFsxS3n2uFJN1DOvDDos
   p3t2BTnk/FY6QIg9ySEW38mrFNRA5qEaOmuDUj/MClHnmL8RKrosoOF2n
   g=;
Received: from mail-bn1nam07lp2048.outbound.protection.outlook.com (HELO NAM02-BN1-obe.outbound.protection.outlook.com) ([104.47.51.48])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2022 06:53:34 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UU94byOOPl2W+90RP1T+RaIiME7cdqLeQqwzRLzSIUJENCODeb5G80XnVHWw4OvjUl5D/VUbc0A2rC0akDW8IpfYq55mFNgDDOfF+LEjT4WrK3QRMFcQshckQMjTol+/N+1hf77T2RNxZeSOxuGIPr52GLKjBRN30cmUhwAw0uDAZd2aA2oqD9mnJs/Q8YMpglTf5yBH3e+rIm3B6xv5zko4W38+WJ2mqopyq3BEvwmcAfJRUo0+b1w6bKES9ED5zCfIdhdEyPUOYLOI0pzxzu1qWW/HN/RD9512EdqlosIBZUgavSm/2QGiflna2y0IJYZDwpuhPn55MjBvz1lYOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ythyCRJjMu1c1gVpaSsk+/RrL73NfzS1d5MoENdvEzs=;
 b=QN3auRau+oYbh7lxmr7xd+Uq0LgXnY/fgvKtJo1plJvP9o5XCHnA/lfTgrx9GrRMiv1wTBUlSu1VNj1fXMWHjX4KUlxG1bgW7TO3/2VmDEBQiK141LdecB5pRWxNUP+XeFeR+wgi1fAH1/5YWPL3+bE8nB6Ks8sJcAzoeKsc03eNxrrwabp1uFA7LgD3r0tGOeMamHPksqE0RHlvihG42bKajw18ELnC+MDj/9rf4PfBwF1WLcmHWHyP4lMXYH+vZnRVXwHbOX4+ZyLYlI1om0yCg8c11H3Gqe/4XPBpTMPaR9TlJgUgHj2tz7rS/5gk3Y25l6PxAlajaCjY0ZBUGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from SN6PR02MB4205.namprd02.prod.outlook.com (2603:10b6:805:35::17)
 by BL0PR02MB5425.namprd02.prod.outlook.com (2603:10b6:208:87::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5353.14; Thu, 23 Jun
 2022 06:53:31 +0000
Received: from SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::f4c0:89e2:789d:ceb1]) by SN6PR02MB4205.namprd02.prod.outlook.com
 ([fe80::f4c0:89e2:789d:ceb1%7]) with mapi id 15.20.5373.016; Thu, 23 Jun 2022
 06:53:31 +0000
From:   Brian Cain <bcain@quicinc.com>
To:     Jiang Jian <jiangjian@cdjrlc.com>
CC:     "ebiederm@xmission.com" <ebiederm@xmission.com>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "mpe@ellerman.id.au" <mpe@ellerman.id.au>,
        "keescook@chromium.org" <keescook@chromium.org>,
        "wangkefeng.wang@huawei.com" <wangkefeng.wang@huawei.com>,
        "linux-hexagon@vger.kernel.org" <linux-hexagon@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hexagon: drop unexpected word 'a' in comments
Thread-Topic: [PATCH] hexagon: drop unexpected word 'a' in comments
Thread-Index: AQHYhs2sUKu10YQoCkOF3MziV/G87a1cjgyA
Date:   Thu, 23 Jun 2022 06:53:31 +0000
Message-ID: <SN6PR02MB4205512B03E6C2367BCFB5AEB8B59@SN6PR02MB4205.namprd02.prod.outlook.com>
References: <20220623065100.8268-1-jiangjian@cdjrlc.com>
In-Reply-To: <20220623065100.8268-1-jiangjian@cdjrlc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8a118dfc-3780-4332-c459-08da54e515c1
x-ms-traffictypediagnostic: BL0PR02MB5425:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BL0PR02MB5425D8F89EC54CE00979ECCDB8B59@BL0PR02MB5425.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HFx5auakVnGUBgkNXKzl3elZOeKRmwgbT4P+elflRkrnYqn7BiYyAJj9lXx5ZAT7lihiyMFZ9p6PSEqNobz1FhI/ac2e/71UguCxHH/EdG+6XLLHYV7/5WxVCxlKuUP8G7KTEETqnQPd7+LxhsS07qAvdes3rPuKgVXsGK8k5uZzL9I2I8cJ0AyvZJB8JD1Q93EkyNF5fkxmOuXvU0mO7yHgxYCjG7oUy+7Cp6WX3w11v/AI+3qz3hnkM7yFKZrSR+sHNm2ba6drtWI9IjIDMaWavijEu/5lgLJDx0jqtZFuS7gaw4DsWSEu9TgiW0ZNzqJaFE/A8kEpS871hechUR/ZshOnew5FrTCDFJGIivcJTGFf56PrJ96LKWqhLr2i2Ld0FcaK6dZvdnUjgsiEGxqKqnfVTvqY3u8XIbMZWaSI4g0uNRiwnyGsCzc7OOVaIDoal+MRF0il3O0zzb9mqs0ePaQet0DnZk2Yviu6IIMewzxBYUdS1C92LLcwyYyUXuxJ4C1gaHpaiIxcxzt8e3/u/fNEUojc4+G82C9DGQ9fCzJkDfd5d56mgHBNEmbfIaS/VaKt410//7v8EZwpiBdwOERcAo8KcGe0KaKMlCOPncLP0DIjjkuiNTOO2DITix83g6HAsVqEaaYILyk3XscQfWlwUtxHSBzeAAGJ+JgweQRYCO6PYDgtqUsBjoCMZsofRST929fPbNC+s6349Ey+g9luI6RLtr/acARdVoIujes3I1RgOKMwpCtAtVi1qOia81UKRtuEZVBJn5cDBg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR02MB4205.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(396003)(39860400002)(376002)(366004)(136003)(346002)(76116006)(4326008)(8676002)(66476007)(66446008)(54906003)(122000001)(7696005)(66946007)(38100700002)(66556008)(186003)(5660300002)(9686003)(55016003)(71200400001)(64756008)(4744005)(6916009)(83380400001)(6506007)(41300700001)(316002)(478600001)(2906002)(33656002)(8936002)(38070700005)(52536014)(86362001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?KthlTdPkU6Y0xh9lsICu7rMUdSXQ9vqZN6Cia5g1nccWJgeZOv8OkRCFRsG5?=
 =?us-ascii?Q?GEhRK2w20B7DV5jmWTSoX7tO0Q3K7M23SGMKb7KbJh9g7bAaQ03RZN/G+kUh?=
 =?us-ascii?Q?HyBUqPLmvvjBTJ2TtnGF6DpjPngIoSrOtGCugr7F7RMJ/W0pPP/z5EKeeYMu?=
 =?us-ascii?Q?JGEcrFacIQFF8gr8VnCXIGl2xdnAhHOO98Wwnj6Nr/tVWvMlzJrgfBL/IIiB?=
 =?us-ascii?Q?Tdo3qkgmK6wxM2BfIfsO0iYU3Jt+lBwhE9H3MNxslX8D7L76HqZ7p1/xoj8s?=
 =?us-ascii?Q?nnaZvYFQZOcdD8eo56JMNL4/qM1ezgo70/BFTV4mSBHOOE0GIuvRKu56BKIJ?=
 =?us-ascii?Q?1KuPSmfbBPVtEl5Nqbfa03fw5uYyW11rgH7yru254/gEc9J/mu1mIs57EOBU?=
 =?us-ascii?Q?TteTBg89UCBQ8PrdLgw+2Ykvg+Hy1em6GclpBm2p+ZGyEUBAvIrQBmZLhdjk?=
 =?us-ascii?Q?IdUzQfOt2RWDEf2X7ozSgMYH6bX0b5JQXJZ2HIDyWRkuxE0x2ZV2nVPBzHQ8?=
 =?us-ascii?Q?AQ0h/G4/a/uRK7Us4pJygbFAVdtijUl6yg2xyObMAJ2rtywHkFT2OEUEUNQJ?=
 =?us-ascii?Q?U42tdEbu++B8zx1M9AmVwXVpgQRLINWEXwSqRmmhheAc2eNMr06lnQPpmlHP?=
 =?us-ascii?Q?XAb+e+Oymz5i5st8sGTAyQxbWCG3OjHxK0wKHTxMA17ACalZ8ivcAtmnquDo?=
 =?us-ascii?Q?4VgJONV2pYkfJxOB9RgISMC5T8oS8PwOOoN5f9VEgYZkNIKCq7FD/ZpY5NGo?=
 =?us-ascii?Q?DGdyvCuQM6PWgB2QpExrRzgOTSGlX9neMpCyv4DxymX9xJcIMBIsWuRtXfWc?=
 =?us-ascii?Q?ZYTXCRb6faAnOCb3o1a4s6fZpPj+jJNbuV1E+ZwbyHJPIceiY8+aa4WYc5Qd?=
 =?us-ascii?Q?gfAPbpzVsLlpqe78+fCM4SjOupScqB08v1ch1zocD0zDmEh4/h1uQHISpcVn?=
 =?us-ascii?Q?i3DDH2ViBjlhGDZDyxExqrwMZhCuTniKcyVIjxPNGfQ3YtvNNnt1gX02ixVF?=
 =?us-ascii?Q?qbj7VgrHmQTb2oHGqpU/6du+HUvBA1hcJlUGFlncDx8a+uHjqrzF+d8Xq8PU?=
 =?us-ascii?Q?O5K4+HFojtqAoBizUis/1dzSA9PkpP1C6yiza2xhor5rrhlZUjJmDh8WNC7j?=
 =?us-ascii?Q?kDc/+e3ju9j07INgMKXg5IoGlzmWrOszE4KqFavxDgZ9Fd9psAZDZlhOdp4b?=
 =?us-ascii?Q?Kr0wqIvg4FmMzNPnnoqPJXcNz3OnR0RSI5NjiSzHUD75z1P2kWVa6QgF6HgW?=
 =?us-ascii?Q?Xh0Bz/2vUzvuwaWS3ZtP+TX3Gf7PWd57DRZigfCa5r5mz9ZntuZDfY9Rohdi?=
 =?us-ascii?Q?DBQZk60vsWL6VilTSaYpiAI5yd8Je7vF54m7Lv4ZN/NoWA0UkmRQb1e6zmLL?=
 =?us-ascii?Q?yyZAslpmpi33kK06R5fARyirv8ePZ81SS8re/n/Dvcqb8HwdJqKVmp1r6UK4?=
 =?us-ascii?Q?NQ2Qo8ZWdiGvHxkVo+HLh/G0CKrcClTavux5skBnyIeEm7n94pTJHiKG5kd7?=
 =?us-ascii?Q?ahG7sRKywppgeaZHk/H9bDYwtILgDuHSd3cDEQWzxukcjuIuVoFREw+CTdqg?=
 =?us-ascii?Q?j9ROhxiYIElvSxwsmlOpeg6s2jscxFvau2SsWlXo93KIKqDUJBP7Xo3j5KpW?=
 =?us-ascii?Q?f5qfnRB5ojbTy0fHhZnpXREnuGvqN0BXFLT5zWUT4oUOlh8xOsXZwuxDIs8r?=
 =?us-ascii?Q?kUH0wmVqWiX6JfTMjh87SENk30DdhBSQHsWDGxTXXLeQDGRlHrjICk7kB+Vx?=
 =?us-ascii?Q?GhYt3eahe7dLFO3WiVOE/PWqldenLA3RJcibP+AG/P1zzdUy/fiUBWMs7F5k?=
x-ms-exchange-antispam-messagedata-1: m4d2WaR6KTsBZw==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR02MB4205.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8a118dfc-3780-4332-c459-08da54e515c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Jun 2022 06:53:31.5454
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /M12kYZzctm4myUjRN9W37dZ6T+OhaOtPTj2uNHIgSYpPm5jeJFklO+jGCQAJ23odaEXP9pns6RnMjJ45zy1xw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR02MB5425
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
> From: Jiang Jian <jiangjian@cdjrlc.com>
...
>=20
> there is an unexpected word 'a' in the comments that need to be dropped
>=20
> file - arch/hexagon/kernel/traps.c
> line - 262
>=20
> * Precise bus errors may be recoverable with a a retry,
>=20
> changed to:
>=20
> * Precise bus errors may be recoverable with a retry,
>=20
> Signed-off-by: Jiang Jian <jiangjian@cdjrlc.com>
> ---
>  arch/hexagon/kernel/traps.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/arch/hexagon/kernel/traps.c b/arch/hexagon/kernel/traps.c
> index 6447763ce5a9..a1f1085887aa 100644
> --- a/arch/hexagon/kernel/traps.c
> +++ b/arch/hexagon/kernel/traps.c
> @@ -259,7 +259,7 @@ static void illegal_instruction(struct pt_regs *regs)
>  }
>=20
>  /*
> - * Precise bus errors may be recoverable with a a retry,
> + * Precise bus errors may be recoverable with a retry,
>   * but for now, treat them as irrecoverable.
>   */
>  static void precise_bus_error(struct pt_regs *regs)
> --
> 2.17.1

Acked-by: Brian Cain <bcain@quicinc.com>
