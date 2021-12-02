Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C82A7465C72
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 04:09:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344683AbhLBDMc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 22:12:32 -0500
Received: from mx0b-00268f01.pphosted.com ([148.163.159.192]:3638 "EHLO
        mx0b-00268f01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231847AbhLBDMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 22:12:30 -0500
X-Greylist: delayed 4320 seconds by postgrey-1.27 at vger.kernel.org; Wed, 01 Dec 2021 22:12:29 EST
Received: from pps.filterd (m0165120.ppops.net [127.0.0.1])
        by mx0b-00268f01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 1B1J6bNp016114;
        Thu, 2 Dec 2021 01:54:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=equinix.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pps202002;
 bh=hviwN8qUbtMd1vM9KDlv92Z6gNjVcChT2w0rOWTSTZ4=;
 b=MHUQzojpcUA2W0hpchav8ao7jexqaYhRNXCKlwhijZwawhs4Mik1LLB7rGxOP6zngE54
 LB2jfCf6+aSst02VfdWIIDjMxrTJ7VQQqbrnEoKYLfc9Gfenj6mok7hvP44PnAR8eom5
 Gril45d7xfOrgXoK9UAsXwJveXG1JKE8u8GGjt3Dh+inkKnFzxEKUq3hi0Wbo3ZhXGQU
 KHWsVxRbhg18GH36hE0lAqZhWED1bucG+xZ4jQ9O8M1XZOPLTYSbMi0PBkzuEWkO1TyL
 0G+rMSu/o1JH2N/AL6Yj0MyznqAP1TlZH85EGXHL+yuypS7bEO5zJzWcnC/px8Jbbc8h 8g== 
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2171.outbound.protection.outlook.com [104.47.55.171])
        by mx0b-00268f01.pphosted.com (PPS) with ESMTPS id 3cpeww0x32-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 02 Dec 2021 01:54:58 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=lZajjkz5Js9xAfHWe+ThAvlMJQG6P7u5lWiL0o+TC3x737o+oK7XyjywsYEJ2lJmrfJ/tB0s9wOXkHWLB0jC596GSuIVHDfKTJbvfnlSDTzxvfNQNKTuZnht8micgecZEAZUbrZHLTVHbRoSiaMl3s7aQs+UMHlneywIT5414HF+Igj+B7ZCksvrCLIg2g2OKAdxqZxqeVeZHKzhaqOQwiIYrxNzBXyz26XyqaTXnhcvfDYS8VykUjCE8hHOxu9meD0WmsHWOTS/5+lcgqkBy2EZ5PRfJWj5HOK4y80/zKNN/PXTtzENQ3XoQ8hi4yAFVxe2VFpcKeJG1tcN9VBr+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hviwN8qUbtMd1vM9KDlv92Z6gNjVcChT2w0rOWTSTZ4=;
 b=L79wCDcoC+ZjkbNBS8Z5468czZjoq16XHAeFkSnLfBukTcjJdz3vIuP2RdwOWo8+PtuWsuVkcPovyeK9Y4BgEX1ZA9Rif43PMPLbWFouY5/c1UPqDUMcMiYBe+0vECdpg6ldwNiC7ThjxNvFIGS7BKCHrJ5ZAGFtAZHZRPgSg0o/npuCz0lg+2FjG5osz0KN1H+QaUuvrbzEmoKkuLbvGHx2/zvwcUDoRJbW9WWJu68FJMfpnP/J4PtCUOuN2yaofC0NCVDLigPpyOEEqehqFQYoTqHIkWhffigKj5jPrerr3kEWvdPAiA65Kv37VwiATH9/88Yjj71OHWHOqsrIrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=equinix.com; dmarc=pass action=none header.from=equinix.com;
 dkim=pass header.d=equinix.com; arc=none
Received: from DM8PR04MB8007.namprd04.prod.outlook.com (2603:10b6:5:314::20)
 by DM8PR04MB8087.namprd04.prod.outlook.com (2603:10b6:8:2::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4734.23; Thu, 2 Dec 2021 01:54:56 +0000
Received: from DM8PR04MB8007.namprd04.prod.outlook.com
 ([fe80::61fc:37a:892f:c6b9]) by DM8PR04MB8007.namprd04.prod.outlook.com
 ([fe80::61fc:37a:892f:c6b9%9]) with mapi id 15.20.4734.024; Thu, 2 Dec 2021
 01:54:56 +0000
From:   Zev Weiss <zweiss@equinix.com>
To:     Billy Tsai <billy_tsai@aspeedtech.com>
CC:     Iwona Winiarska <iwona.winiarska@intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        Dave Hansen <dave.hansen@intel.com>,
        Rob Herring <robh@kernel.org>,
        Jae Hyun Yoo <jae.hyun.yoo@linux.intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Jean Delvare <jdelvare@suse.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Rob Herring <robh+dt@kernel.org>,
        Borislav Petkov <bp@alien8.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-hwmon@vger.kernel.org" <linux-hwmon@vger.kernel.org>,
        Tony Luck <tony.luck@intel.com>,
        Andrew Jeffery <andrew@aj.id.au>,
        Randy Dunlap <rdunlap@infradead.org>,
        Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH v4 02/13] dt-bindings: Add bindings for peci-aspeed
Thread-Topic: [PATCH v4 02/13] dt-bindings: Add bindings for peci-aspeed
Thread-Index: AQHX5p+P62em8bYgd0e1yu+07efK7qwecfWA
Date:   Thu, 2 Dec 2021 01:54:56 +0000
Message-ID: <20211202015455.GB25091@packtop>
References: <20211123140706.2945700-1-iwona.winiarska@intel.com>
 <20211123140706.2945700-3-iwona.winiarska@intel.com>
 <DDB2E224-472B-41CC-A5C6-BEADB4BF2041@aspeedtech.com>
In-Reply-To: <DDB2E224-472B-41CC-A5C6-BEADB4BF2041@aspeedtech.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c1912db3-f9e9-46bf-5035-08d9b536bdd4
x-ms-traffictypediagnostic: DM8PR04MB8087:
x-microsoft-antispam-prvs: <DM8PR04MB808715801125B9369457FC84C3699@DM8PR04MB8087.namprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8qeoaB0QpQmIoQysRAyj4ouAuU2XVX7P2OGB2jKCGHKoMi5EAwkIggfT0AiGjw0x2aSUJssgQ4IHBzWmTv1PMZITmW9K4JRfqMh2Hdi0Vm77VUKNKFYYaEBHu+Ova9Ru5X8XZNmLOegQaeUgKMnDFsDh3sLp9soTi9H6vvB3l2+2yCwXd/eJS26HPRbk/WPd2+C7O7s5fao1jTdm3UlClB7zr+RieOyKVnqBvqEkIpDuhD++On50DtWrPSJkYnquoluLxDquaqsMRYO8cIF58iddaa5HAsYS0taAZ89RMeDpCPi2f6lVfRNoSoitqP5nWin37G0rHuYrkoBEbl14VZfzTfaLnwGOLQuV/Y2lNZ4B1NA5krZB993IH2fJWTQt3TaH/6hsTGlhy4FfU7A4XV7FcqNNr7PMsgo7WuRZ9v9ZSe5Y9Wb3IFHd9Gi8LRsCO+tTBXgUfDVVH2wfxJxh7cXCDsbS7fbQB6rnqWDdBOA4hraDJFT3KLx2Pl/KlwuTdU5JjCUCQfRhbH/wXDQ3FnU+riwOX2M2tKsf4d5LW2rIY8pZDwcH1ygWj4QNak9KAoz1Adh+1W3y3hr2J7gw1DI1cX4fsCKWzls3GfOtAqOlVqQUgn4Rl+aju1xUqqzjgxxfH8RtR2Xc2iQKdpbgluIeVDmOldExJ8L16HWPvGJlAZ7632lUMUkgSrux7iyV5KXanCeB8X3Yvaos8vfHNw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR04MB8007.namprd04.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(7916004)(366004)(6916009)(1076003)(8936002)(6506007)(7416002)(8676002)(4326008)(66446008)(2906002)(76116006)(54906003)(33656002)(71200400001)(83380400001)(508600001)(38070700005)(6512007)(9686003)(33716001)(66556008)(186003)(316002)(6486002)(5660300002)(64756008)(66476007)(86362001)(26005)(38100700002)(91956017)(122000001)(66946007);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?Cp9SQyUFjJIAhUmdeOQT/CUt/FUxnYvtnnIk+gpsXCZZBmCxoymvhNQuxtg4?=
 =?us-ascii?Q?2FXwjEHsaRw2Mo8D8YOJkhr7iJbX9HIGZaYk+eXubUNPQNXK44I5bMukfKOD?=
 =?us-ascii?Q?SwidVbGGUq4n8NFpHq54yqNkL7oI4Rtsg4hi/CFWwl7CYdcMwwEDSScuhyUC?=
 =?us-ascii?Q?RlqBLevcLlEoq1QxTVo4YRWMnd1I+K0Xv0TPcIpTJyWAL5l0HOpZqJKVfsLr?=
 =?us-ascii?Q?5KCOAzWHP/4jloUVpedoFT4KjEXVFxiHBs0YpNZKpt1sbmSNH8DnF6DNHI8t?=
 =?us-ascii?Q?EfPm1wldwGfKmQ/Sn64ySPq/UdJKB2dQvf6NqBHhV2cRPYu3BqJ06NmDlZ5Y?=
 =?us-ascii?Q?iJimPQKHQwvtrpFnLfWFILZVorfuYA1qe35cpE4JuFdIUv6vWyainaS1tdLH?=
 =?us-ascii?Q?W71+H/bH2iq0537RBQcWMpAQ+xYgr/zkQoITqhq/YicqXzKMmaAqG0ecqLKk?=
 =?us-ascii?Q?hukgZbIRuLtLvg6zVZMHSft7uTSIv7yfvlMz1krNNqkE4Sj4BqylEkaDwgUq?=
 =?us-ascii?Q?9nrD38i9Z+dAlU7IVvw2mHYRVuGvP2v34Al/U6AP5if/CDGx+AFhcYQf/y5Q?=
 =?us-ascii?Q?kVRcMWrqfYrIk1kcO5CsDKXkDVY4S+fmQKu8DqnVRBGQyivJKqVue1luWdIe?=
 =?us-ascii?Q?JLh63RhWTZBZVh4IibEGRyZe+5Tkosput8ld7C7hXcyhKLbiSW2ugV8+d7jt?=
 =?us-ascii?Q?qjiSmamrMHcKdCVm4WhFbEstVDEw5G1TZn8+4nAGkAkkmi8RBn2BT9qcP9xs?=
 =?us-ascii?Q?94sItePCPMvwZ232lObl4+HCOrpTBXx4ShYjB0IbyAN7zWFriKSxFLm7U+0F?=
 =?us-ascii?Q?wSTHWJPSV7YND78rL9WEfY0vYifxiSKEEGDHO3sZ4iDA/kxH/0feEffrKVhS?=
 =?us-ascii?Q?SEXC8BZYEOIrxQX2yKC+hFZcYjcOovwlqK0N/KDSvNcxlhxC9gAKZOQqnHoR?=
 =?us-ascii?Q?920Tl2Om22r9hIQfPa2YWxvp4haFIjk14uu9e0cpf8feAYkMMauq77PuP+LW?=
 =?us-ascii?Q?cudjjO4A5oBeVHzBgYo+9RW3GmfI4uFx8PyLkukIn1h5CQNoBleS77Dvi9dC?=
 =?us-ascii?Q?e55U3DfN8PwhdzepNXR8/Yldg5beIY3PIVVoLCzq8+mPnrYa+77+OfiXI0wk?=
 =?us-ascii?Q?/Nxd7Rba7fq3aIznRgwkkJxKmRWAUlIi7FCdp1sjJYCp40N5sF0wD8sfeZP8?=
 =?us-ascii?Q?oss2OvEO/8G0nXURQWwcwac2zCSTk0l5yhxzMmEYM2t+N/kpiOh4ibMfvkyF?=
 =?us-ascii?Q?7tUsVYe/YhrkxC6pyjwBFwRXCsXqsvH2AI3scYsnQeURku9czc7ZOOwjlLjt?=
 =?us-ascii?Q?Fvaq//jddwYsN38Mb7SAKh2WHb7eep/yIt18X7Ltx4S+5Sd+fSLgyoorpfxk?=
 =?us-ascii?Q?qJSAav0NTuFTfZ4/cUIjRGPRemw2MwQBU8RbmMBoLmjMO5d5qGLWBDzdh8E1?=
 =?us-ascii?Q?YBRHsIbPUeDnGayJx9hJlqGv0/E5SajgjXOtVV44yErAk++wdKOEsFgpjHXM?=
 =?us-ascii?Q?d7NOH/8J7J9ivOBZKr8PG/cLGdMV5qUj1DwwCg1/q0hA82CjLQgV/NMjh649?=
 =?us-ascii?Q?KZYBEPoiNAL8/D6WLWLk840DowC5zOjDGtG0DT+j8aHx/hE7CRmw8k3hsGie?=
 =?us-ascii?Q?UPi6P0uVIXdFYoD7p+N9siw=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E4636955DCFD3E4CBC45635FB4179E07@namprd04.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: equinix.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM8PR04MB8007.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c1912db3-f9e9-46bf-5035-08d9b536bdd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Dec 2021 01:54:56.6000
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72adb271-2fc7-4afe-a5ee-9de6a59f6bfb
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: L/tXYWgGivVXW7R4brJcQePToO9Fn6+9Kx6UjJbqndSlO8Hzf/Upc4EDftwLaQFxwMj5u4oXtkCI47faSIpN0Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM8PR04MB8087
X-Proofpoint-GUID: Ax80BdjYaQj671GBHEZzMyc32x61MaKT
X-Proofpoint-ORIG-GUID: Ax80BdjYaQj671GBHEZzMyc32x61MaKT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.790,Hydra:6.0.425,FMLib:17.0.607.475
 definitions=2021-11-30_10,2021-12-01_01,2020-04-07_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 adultscore=0 phishscore=0 mlxlogscore=875 spamscore=0 priorityscore=1501
 clxscore=1011 mlxscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112020006
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 01, 2021 at 02:38:04AM PST, Billy Tsai wrote:
>Hi,
>
>On 2021/11/23, 10:10 PM, "openbmc on behalf of Iwona Winiarska" <openbmc-b=
ounces+billy_tsai=3Daspeedtech.com@lists.ozlabs.org on behalf of iwona.wini=
arska@intel.com> wrote:
>
>    Add device tree bindings for the peci-aspeed controller driver.
>
>    >   +  aspeed,clock-divider:
>    >   +    description:
>    >   +      This value determines PECI controller internal clock dividi=
ng
>    >   +      rate. The divider will be calculated as 2 raised to the pow=
er of
>    >   +      the given value.
>    >   +    $ref: /schemas/types.yaml#/definitions/uint32
>    >   +    minimum: 0
>    >   +    maximum: 7
>    >   +    default: 0
>    >   +
>    >   +  aspeed,msg-timing:
>    >   +    description:
>    >   +      Message timing negotiation period. This value will determin=
e the period
>    >   +      of message timing negotiation to be issued by PECI controll=
er. The unit
>    >   +      of the programmed value is four times of PECI clock period.
>    >   +    $ref: /schemas/types.yaml#/definitions/uint32
>    >   +    minimum: 0
>    >   +    maximum: 255
>    >   +    default: 1
>    >   +
>    >   +  aspeed,addr-timing:
>    >   +    description:
>    >   +      Address timing negotiation period. This value will determin=
e the period
>    >   +      of address timing negotiation to be issued by PECI controll=
er. The unit
>    >   +      of the programmed value is four times of PECI clock period.
>    >   +    $ref: /schemas/types.yaml#/definitions/uint32
>    >   +    minimum: 0
>    >   +    maximum: 255
>    >   +    default: 1
>I suggest deleting these three properties and replacing them with the foll=
owing
>
>aspeed,peci-bit-time:
>        description:
>          The bit time driven by PECI controller. The unit of the value is=
 Hz.
>    minimum: 2000
>    maximum: 1000000
>
>And the driver should use this property to caculate the appropriate clock-=
divider,
>msg-timing and addr-timing, instead of exposing hardware registers to dts.
>

Or perhaps just 'bus-frequency' a la i2c-aspeed, gpio-aspeed-sgpio, etc?


Zev
