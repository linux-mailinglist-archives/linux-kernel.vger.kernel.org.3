Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A3384A4EFD
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 19:53:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358621AbiAaSxZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 13:53:25 -0500
Received: from mx0b-002e3701.pphosted.com ([148.163.143.35]:12286 "EHLO
        mx0b-002e3701.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1358863AbiAaSxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 13:53:13 -0500
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 20VIMnJQ007750;
        Mon, 31 Jan 2022 18:52:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type : content-id
 : content-transfer-encoding : mime-version; s=pps0720;
 bh=XDCCkslTHGS7NmLYOVuB3PPIz/wmqUjnca5DgmHjdd0=;
 b=PROwq30Hh+Rur3kLYs+aUg1VBK2wX+J8jQOuQGvG6fWa1vn98azDUzovNL+lOTtLr5z2
 q3+gITC6RadVmeAb/Ipk1Ow4OQuQp9oxGCPUzcDtp1lOfzSHMvwJoiUSS8ciZJvJwTu+
 j27EUw5m6lAUDw69ntB3ZdqxWdV3Acp1TwPDVpFYvWKMu4oVwfam1eTJyZqFwv0tRS/L
 pwiYdB8OGRSPt/VPVczVZlXAhoB47OI7F4pQVvhKB1GCG2sxfsLOeYHmNecZ3UdJA562
 Xd3wDfns7O+jFmK5SdFJZcw1cFdwqOLzvKvzclU3xirbaydRfNHtJqcGxcGOtwOdtTFA bg== 
Received: from g4t3427.houston.hpe.com (g4t3427.houston.hpe.com [15.241.140.73])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3dxdwkv1fr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 31 Jan 2022 18:52:30 +0000
Received: from G4W9120.americas.hpqcorp.net (g4w9120.houston.hp.com [16.210.21.15])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by g4t3427.houston.hpe.com (Postfix) with ESMTPS id 1EBAC74;
        Mon, 31 Jan 2022 18:52:28 +0000 (UTC)
Received: from G9W8456.americas.hpqcorp.net (2002:10d8:a15f::10d8:a15f) by
 G4W9120.americas.hpqcorp.net (2002:10d2:150f::10d2:150f) with Microsoft SMTP
 Server (TLS) id 15.0.1497.23; Mon, 31 Jan 2022 18:52:27 +0000
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (15.241.52.12) by
 G9W8456.americas.hpqcorp.net (16.216.161.95) with Microsoft SMTP Server (TLS)
 id 15.0.1497.23 via Frontend Transport; Mon, 31 Jan 2022 18:52:27 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VkUJ6Ch9Gtcfmg2r4xBG+Li8DtZ+azN5yMrvfn5CwbBASyxWM1d4BoWwdJ1purpUvD4LSP/rqHKdSbsUBGu2BG4AHnp25BxhJ9WeYBF0/0bY3qw936J/VxO2t6C6Kg6Sjjh8D361hnCFkkK9xUPWeCnkgjGJkmt3+BxgreU5q88cejy8TDKF3fR3omhAgGE9Szjozkezu/QRkv1hcXGPR99BGSfvaHAf31epR+Yok3jAAZu+l6Y2iVqr+cHeRWsdt86/GAvlr8p3hgns3k6QjhCH+MttOh2CZppj0fia6tuIZWCpp6iBQ8shfqGWaEP4F1QDPAuayDROueP/zcNH1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=XDCCkslTHGS7NmLYOVuB3PPIz/wmqUjnca5DgmHjdd0=;
 b=D9QRMbn8EkCQ4qb6sGH3Gh1caCQItBYZiBmvtTZwvCnPaEvFla9QiwzDHcCDWXEf+2FdhkgCX4KVXWq0AZo3a2vh2aJPJmZviJs55t1VK48Jgs/CVLfL0svfu4y8smTOQ3C1gM1COShCSk5xibP0wTGVosK5h7lq8XNMloJQyGfw9AyAOO2FL7Tt5Fx4qW6shZE9xPt9jJt54ReWsVXJL1ZAoRc0oCuZjB9pM/6YVxDJLiLpX+hcFWMNyL1xncuGConX+rOUEmW2yhFo4arGqBK5GhG+sC1QOSxe5zyLn0LP1/7bzjXH0kUkth4JETrl8BTO1qNZrwWKCoMZjuHwiA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4f::17) by
 PH0PR84MB1788.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:162::7) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.4930.22; Mon, 31 Jan 2022 18:52:26 +0000
Received: from DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b84a:b07:81c9:881f]) by DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::b84a:b07:81c9:881f%4]) with mapi id 15.20.4930.022; Mon, 31 Jan 2022
 18:52:26 +0000
From:   "Verdun, Jean-Marie" <verdun@hpe.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "Hawkins, Nick" <nick.hawkins@hpe.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanislav Jakubek <stano.jakubek@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Hao Fang <fanghao11@huawei.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
Thread-Topic: [PATCH] Adding architectural support for HPE's GXP BMC. This is
 the first of a series of patches to support HPE's BMC with Linux Kernel.
Thread-Index: AQHYEiSvuzTpDmWmlkCB5qV0n5CxS6x0cU+A//+SGwCAAPlFAIAIAEkA
Date:   Mon, 31 Jan 2022 18:52:25 +0000
Message-ID: <015EB9CD-ADB9-4C12-BD3F-78268E849884@hpe.com>
References: <nick.hawkins@hpe.com>
 <20220125194609.32314-1-nick.hawkins@hpe.com>
 <CAK8P3a0ccoH_sNE9eWxQnWHEWNBPFL6k4k6mku=cHs_fRfnL-w@mail.gmail.com>
 <CA8148A1-578E-4621-9714-45AB391C353A@hpe.com>
 <2f4dd91a-e4ad-2559-f65e-914561de4047@canonical.com>
In-Reply-To: <2f4dd91a-e4ad-2559-f65e-914561de4047@canonical.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2e99681d-c566-45d7-b2bf-08d9e4ead2dc
x-ms-traffictypediagnostic: PH0PR84MB1788:EE_
x-microsoft-antispam-prvs: <PH0PR84MB1788A5F077C05C742B4D9044D6259@PH0PR84MB1788.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:7219;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: hi2vrvR/uVS8M2bH6BEaqvEVri+gxAvmxFy+1cBRBXZA6Tt/5TroLl1TPPajoyNjqMuPivli05lFz9nSEhQuODJFJbLf9LvejiNp+oneX0OmQBaVVk0kR7AzR3abn0YN4vqu3a67XzldnYLMCtVTD6wa4VbB3Q5GbS4fxBRnj6cylQXQ+di/Ma0N2dJflVpXxdvzkG5p6rmRpKqKxI/1jYfuxGqkIDkks5NFqYti3Bbd7k64Pj6JkR/drnPcOQFT0t+VFTx39pvUGjgL223h+2piiNWjxPz4U167hRA3yGj7jW9ohJBLuZI5yFoWGFG4hZR46VaDpcWMRgVn/lZpxYZ+R6tF3caJxOKQEZrHoeXX272YSVfD9Ak91vHZXr609EwsO9HcQ112ge5OEUzUzJ1XjCIm5i6jhgMSxkGnYwlLWD3mzP3svJTzyw1U4osjP4xBrUHB2wTQI//aE4gH52Zj8XZxlEHIgbmZcCJpqiZG6YUpxrMwcAFtfCK0WVGdPC/jeRvnl4cH3t4v3C1yIsj8RQcOSBVa6U6PM8y20OEqItbUIllCDDeG48TTpvCsYvkOE6o4crGo+cneJmz/S+cr1MGxHCU5VG2qBqtHzrfNm2eeX05fpmKZmiGCaWskb6ORrHiQhCyNz7h53uVBzerOUOU8x5Nb+n0lR3D20ik4JOkE98CqXzboeWQvkhXsNDUyPyNrWLlB9EZW+/Lx+golT6FlwVTRutfCFkxs3+al2ibHup6tbZOeSNVen9WosAsgB11Oq4ImdBAnYKkGzTrX5i2knTh02gzNdpaJ5HY2hXZr5EgtARN/J/D+EEvzsF9uKOgycRPQUMpxKKAhsMcqIPyCqoqnuy4w2sYL3xeRgu0XnmgmG5vNR0nG7aHzngoDEEbDzE8D1ZMH+92LrQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(53546011)(186003)(6506007)(38070700005)(6486002)(966005)(76116006)(38100700002)(36756003)(2616005)(66946007)(316002)(64756008)(66556008)(66446008)(66476007)(508600001)(5660300002)(54906003)(110136005)(8936002)(7416002)(8676002)(33656002)(6636002)(2906002)(83380400001)(86362001)(6512007)(122000001)(4326008)(71200400001)(82960400001)(91956017)(49413001)(45980500001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?THM0UTJ3a2diM3Q5OW03anJ3ak1kbS9uRmhZV2Qvc0RSRVk5QWlmK1N2QXBO?=
 =?utf-8?B?bFhSb21OVks1NzdBa3BtejdwZVBCaURML2cxMjM3UFJRdUprbXhrNGpPVmhy?=
 =?utf-8?B?VXh6ZVc5STBzZkdkUTBmZVR2a3RZQUFNL3ZiTVpDVlRGTlVnVmVBUkx3Yi9z?=
 =?utf-8?B?Y2ltN0xFQ1kzN3M1TVlObnBBTXVyNExxaVVFTzdoaWd6RXY3aEV4N1BKRTlU?=
 =?utf-8?B?OHdpa3FhSm8wdVEwc25UOU4yU0tsaEc0T29zRjFsUC9lRDdPVnl4VFo0TU9H?=
 =?utf-8?B?dTBVU3EvZjVPTzE4TGNuQ3EvNndlMlpraG4zanhhb0tXVmgrckhFaHBObXJ0?=
 =?utf-8?B?Mityd3djczA3SUk4a3ZOanE4V1B4UFpXcFVOdDJ1aFEySjBNRXBZWVBMTHNz?=
 =?utf-8?B?UmswYkV6TVlWR0hwT0hqWDZ4MUhMOE1KRlJ5ZTl1OGFyeVhHdjB0bkJSdFVm?=
 =?utf-8?B?V0dVdWVMSVpCSDRpNExibWg4RWYwdys4UXRndS9yMHV1d0YrUFRBSCtPdmk5?=
 =?utf-8?B?MlEvREJ1VDI3bXhtS0dHVzBlb2RRWUxIVmgrYzNOOWsrTi91bmNpRTcyUU9D?=
 =?utf-8?B?U0Q5WURiaTY1eElVdzFtYmUzYVpwWU1YdERhQXJHODlUSjBGdUNPUENnY29R?=
 =?utf-8?B?NnpSWmxGNjg2NzJTaXBkZWRULy9wVlZudXVzMS9ZNEhqTUpIN3dyTmVXTGw4?=
 =?utf-8?B?UCtaRnNqZUZkUnN2U3ZvV1ZXSGgxK3VpNXZlYWhqSVRIcVNaejc5bTZla2Fo?=
 =?utf-8?B?MWY3SFp3RnkyRHdEZFE2STBmTzVINUVndU5GUUpXWjdQbllkajRQNERFZG5S?=
 =?utf-8?B?dmVBUTVTMXNoQThFbGtlazV3NzNyRlN6UTJNM28rUXEyOFdLRnlpM2lNaU9L?=
 =?utf-8?B?b01xSzA2NVZvdWV6WVFhK0tEaXJTYjZDQXlDQUkvT29JaG5PVFh1T2hYdzV2?=
 =?utf-8?B?MFh6R1hjTlBoTW11MUNFS2NZRERDeUJQNzI1YzlYMHZUQVNKc1E0MG5RbURO?=
 =?utf-8?B?K0VvZWNEclhvblVZU3V4Qk5IVUQxN05ESUczU1BuQk93YXhPbUZaaE5rV0wy?=
 =?utf-8?B?SmR3SU5QS3loenREbDU2RGl0SGJ0V1VIaVNuTUQ4MkFYOXU5alNkYXBoWFhU?=
 =?utf-8?B?TEZ6UEFPY28wUFdBNmQ3R3RTU1RCemloZ1ZyOXdPQkVKQkI3UGV1T3JQbjNo?=
 =?utf-8?B?cFBnN24wZWlXSzdTZWJmN0pJLzd3dktDZ0RHTmI2WEZMSUltMXRnenpBallQ?=
 =?utf-8?B?M1dHb3NhZ3dyWHQzcXp1V0xHOHBmbVZtS29TaGFoZUxxU2ZEc2w0bzBHanpq?=
 =?utf-8?B?eGJ4eElQRVhyRUlJMHE4MVRTcFM5bCttQWNxcWNyWTNGL25XM3d3V1czRkx5?=
 =?utf-8?B?WGRoeVJ2eVhwYU9NUXpnQThlb3NibHN4OW8yRVU3T3BIRmxSbGloakl3dDhk?=
 =?utf-8?B?bWdlVkEvaTI1V0RsM3l2amZYSEdlNzJmUFpRL0JNNmFaN0RnSkxLazduVk5k?=
 =?utf-8?B?alMvM0tZbUl2NVZKTkRmTXFUc2lZY2RCMERjTG5ESjFFdS96Ly9kbWRDSEc2?=
 =?utf-8?B?VWRZbVhmclRjdlJqcnNqZ0oyQUFMZ1IrSElnUFJWSVZ1a2FHUHlKQWJiVS9r?=
 =?utf-8?B?Rkx6enByTENZbTczaFVtMzR1U0ZOWk9CYkw0cnpoaWtBRkdwMytnb1M5Vnh5?=
 =?utf-8?B?ZVBqbTZsbnRrZ1VMUGZqeGhpZlpFNnliRWhNSjZ1eUxFZkp1dnk1bDBCOE12?=
 =?utf-8?B?eHVQaUM5N1Fjbm5FeG16RkJyZXdvRFVDNkl1V1FVRHlWY0srUjBENm5sdTZz?=
 =?utf-8?B?Mmk5eTBXNERQNXlwNlJqUk9hQ0RzT25xUXlmZitDWUNZZEVSOWJUWDZRWnhj?=
 =?utf-8?B?VjBxZDZKSkN0ODNsWEQvdkpLdkNGVlVGMVlkcTJObGc4K0Zwa3FuRlE4NWZu?=
 =?utf-8?B?aERjZTBuMTNBVmgweFVtTmZQVEg3Q29IZis3TytXRDJLNTRGc0E2dnpDOFJa?=
 =?utf-8?B?cXVXNTNpTkhuZDgyQ01oblkvbmtKbC92WmJ0VVVoSjlaUW9FcnFJdUwwSFF1?=
 =?utf-8?B?TVVleFNmaVpxQ05hSjBGMkJ6NGNWc3pqRGJUTTRsMTM3R2o4eTFVSFB5L3BL?=
 =?utf-8?B?RENyT1ZZZmdrZzB0c20yTWxDYnRINktmeVRQUU81dGVLdGdxT0JuSEJSbWZ2?=
 =?utf-8?Q?OPWL2zXmEvXoGKjrh/Z+xNs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <45C766BBBAD64646812C3083966DD5C7@NAMPRD84.PROD.OUTLOOK.COM>
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1976.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 2e99681d-c566-45d7-b2bf-08d9e4ead2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 Jan 2022 18:52:26.0013
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Dq+gFCsK5LSqGnq6tGkVZlYMkzVQfO+xBHWk4POyxqfjyP32bjydtNe9tZK3dQkX
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1788
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: 5jB4dvowZy5sPe7tCcz9n4D3lp0x56C_
X-Proofpoint-ORIG-GUID: 5jB4dvowZy5sPe7tCcz9n4D3lp0x56C_
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.62.513
 definitions=2022-01-31_07,2022-01-31_01,2021-12-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 priorityscore=1501 clxscore=1015 adultscore=0 mlxscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201310122
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgS3J6eXN6dG9mDQoNCldlIG1hZGUgc29tZSBwcm9ncmVzcyBkdXJpbmcgdGhlIHdlZWstZW5k
IGFuZCB0b29rIHRoZSBkZWNpc2lvbiB0byBicmVha2Rvd24gdGhlIGR0cyBhcyB5b3UgcmVjb21t
ZW5kZWQgKG9uZSBkdHNpIGZvciB0aGUgU29DLCBhbmQgb25lIGR0cyBwZXIgc3lzdGVtIGJvYXJk
LCB3ZSB3aWxsIHN0YXJ0IHdpdGggdGhlIGRsMzYwIEdlbjEwIHNlcnZlcikuIFdlIHdpbGwgc2Vu
ZCB5b3Ugc29tZSB1cGRhdGVzIGR1cmluZyB0aGUgd2VlaywgYXMgSSBuZWVkIHRvIHZhbGlkYXRl
IGEgZmV3IHRoaW5ncyB3aXRoIHNvbWUgb2YgbXkgY29sbGVhZ3VlcyByZWdhcmRpbmcgdGhlIHBh
cnRpdGlvbiB0YWJsZXMgZGVmaW5pdGlvbiB3aGljaCB3ZSBrZXB0IChmb3IgdGhlIG1vbWVudCkg
aW50byB0aGUgQVNJQyBkZWZpbml0aW9uLCBhcyBhbGwgb3VyIGltcGxlbWVudGF0aW9uIGFyZSB1
c2luZyBjdXJyZW50bHkgdGhlIHNhbWUgcGFydGl0aW9uIHRhYmxlLg0KDQpXZSBhbHNvIHJlbW92
ZWQgbWFueSBvZiB0aGUgd2FybmluZyBnZW5lcmF0ZWQgYnkgdGhlIGR0YyBjb21waWxlci4NCg0K
V2Ugd2lsbCBwcm9iYWJseSBzZW5kIHRoZSBkcml2ZXIgY29kZSBhdCB0aGUgc2FtZSB0aW1lIHRo
YW4gdGhlIGR0cyB1cGRhdGUgKG9yIHRoZSBuZXh0IGRheSkuIFRoZXJlIHdpbGwgYmUgYSBmZXcg
b2YgdGhlbSBpbmNsdWRpbmcNCg0KLSBncGlvDQotIGh3bW9uDQotIHVkYyAvIHVzYiBnYWRnZXQN
Ci0gdW1hYw0KLSBpMmMNCi0gd2F0Y2hkb2cNCi0gZmJkZXYNCi0ga2NzDQotIHZ1YXJ0DQotIHNw
aWZpDQotIGNsb2NrDQoNClNvIGFzIHRvIHNpbXBsaWZ5IHlvdXIgdW5kZXJzdGFuZGluZw0KDQot
IEdYUCBpcyB0aGUgbmFtZSBvZiB0aGUgU29DLiBJdCBoYXMgbXVsdGlwbGUgaW1wbGVtZW50YXRp
b25zLCB3aGljaCBhcmUgY3VycmVudGx5IGNvbXBhdGlibGVzLiBJIGRvbid0IHRoaW5rIGZvciB0
aGUgbW9tZW50IHRoYXQgd2UgbmVlZCB0byBkaXN0aW5ndWlzaGVkIHRoZW0uIFdlIG1pZ2h0IGhh
dmUgYSBHWFAgdjIgY29taW5nIHVwIGJ1dCBub3QgYmVmb3JlIGEgY2VydGFpbiBhbW91bnQgb2Yg
dGltZSB3aGljaCBpcyBmYXIgZW5vdWdoLg0KLSBUaGlzIFNvQyBpcyB1c2VkIHRvIGltcGxlbWVu
dCBCTUMgZmVhdHVyZXMgb2YgSFBFIHNlcnZlcnMgKGFsbCBQcm9MaWFudCwgbWFueSBBcG9sbG8s
IGFuZCBTdXBlcmRvbWUgbWFjaGluZXMpDQoNCkl0IGRvZXMgc3VwcG9ydCBtYW55IGZlYXR1cmVz
IGluY2x1ZGluZzoNCi0gQVJNdjcgYXJjaGl0ZWN0dXJlLCBhbmQgaXQgaXMgYmFzZWQgb24gYSBD
b3J0ZXggQTkgY29yZQ0KLSBVc2UgYW4gQVhJIGJ1cyB0byB3aGljaCANCgktIGEgbWVtb3J5IGNv
bnRyb2xsZXIgaXMgYXR0YWNoZWQsIGFzIHdlbGwgYXMgbXVsdGlwbGUgU1BJIGludGVyZmFjZXMg
dG8gY29ubmVjdCBib290IGZsYXNoLCBhbmQgUk9NIGZsYXNoLCBhIDEwLzEwMC8xMDAwIE1hYyBl
bmdpbmUgd2hpY2ggc3VwcG9ydHMgU0dNSUkgKDIgcG9ydHMpIGFuZCBSTUlJDQoJLSBNdWx0aXBs
ZSBJMkMgZW5naW5lcyB0byBkcml2ZSBjb25uZWN0aXZpdHkgd2l0aCBhIGhvc3QgaW5mcmFzdHJ1
Y3R1cmUNCgktIEEgdmlkZW8gZW5naW5lIHdoaWNoIHN1cHBvcnQgVkdBIGFuZCBEUCwgYXMgd2Vs
bCBhcyBhbiBoYXJkd2FyZSB2aWRlbyBlbmNkZXINCgktIE11bHRpcGxlIFBDSWUgcG9ydHMNCgkJ
LSBBIFBFQ0kgaW50ZXJmYWNlLCBhbmQgTFBDIGVTUEkNCgktIE11bHRpcGxlIFVBUlQgZm9yIGRl
YnVnIHB1cnBvc2UsIGFuZCBWaXJ0dWFsIFVBUlQgZm9yIGhvc3QgY29ubmVjdGl2aXR5DQoJLSBB
IEdQSU8gZW5naW5lDQoNCkhvcGUgdGhpcyBoZWxwLA0KDQp2ZWptYXJpZQ0KDQrvu79PbiAxLzI2
LzIyLCAxMjo0MSBBTSwgIktyenlzenRvZiBLb3psb3dza2kiIDxrcnp5c3p0b2Yua296bG93c2tp
QGNhbm9uaWNhbC5jb20+IHdyb3RlOg0KDQogICAgT24gMjYvMDEvMjAyMiAwMjo0OSwgVmVyZHVu
LCBKZWFuLU1hcmllIHdyb3RlOg0KICAgID4gSGVsbG8gQXJuZCwNCiAgICA+IA0KICAgID4gSSB3
b3JrIHdpdGggTmljayBvbiB1cHN0cmVhbWluZyB0aGUgaW5pdGlhbCBjb2RlIGZvciBvdXIgR1hQ
IGFzaWMuIE1hbnkgdGhhbmtzIGZvciB5b3VyIGZlZWRiYWNrcy4NCiAgICA+IA0KICAgID4gV2Ug
d2lsbCB1cGRhdGUgYWNjb3JkaW5nbHkuIEkgbXVzdCBhZG1pdCB0aGF0IEkgYW0gYSBsaXR0bGUg
Yml0IGxvc3QgcmVnYXJkaW5nIHRoZSBwcm9jZXNzIHdlIHNoYWxsIGZvbGxvdyB0byBpbnRyb2R1
Y2UgYSBuZXcgU29DLiBXZSB0b29rIHRoZSBwYXRoIHRvIHNlbmQgZmlyc3QgdGhlIERUIHNpZGUg
YW5kIHRoZW4gdGhlIGRyaXZlcnMgdGhyb3VnaCBhIHNldCBvZiBwYXRjaCBwZXIgZHJpdmVyLiBB
bmRyZXcsIHNlZW1zIHRvIGd1aWRlIHVzIGludG8gYSBkaXJlY3Rpb24gd2hlcmUgd2Ugc2hhbGwg
aGF2ZSBhIHZlcnkgc21hbGwgRFQgaW5pdGlhbGx5IGFuZCB3ZSB3aWxsIGV4cGFuZCBpdCBpbiBh
IHN0ZXAgYnkgc3RlcCBtYW5uZXIgd2hlbiB3ZSB3aWxsIGdldCBkcml2ZXJzIGFwcHJvdmVkLCB0
aGlzIG1pZ2h0IGxlYWQgdXMgaW50byBhIHByb2Nlc3Mgd2hpY2ggbWlnaHQgYmUgdmVyeSBzZXF1
ZW50aWFsLiBXaGF0IGlzIHRoZSBiZXN0IHJlY29tbWVuZGF0aW9uIHRvIGZvbGxvdyA/IEVpdGhl
ciB3YXkgaXMgb2sgb24gb3VyIHNpZGUsIEkgYW0ganVzdCBsb29raW5nIGF0IHRoZSBlYXNpZXN0
IHNvbHV0aW9uIGZvciB0aGUgY29kZSBNYWludGFpbmVycy4NCg0KICAgIFRoZSBjdXJyZW50IERU
UyBwYXRjaCB3b24ndCBwYXNzIGNoZWNrcGF0Y2ggYmVjYXVzZSB5b3UgaGF2ZSBhcm91bmQgMzAN
CiAgICB1bmRvY3VtZW50ZWQgY29tcGF0aWJsZXMuIFRoZSBwcm9jZXNzIGRvZXMgbm90IGhhdmUg
dG8gYmUgc2VxdWVudGlhbCAtDQogICAgcXVpdGUgY29udHJhcnkgLSByYXRoZXIgcGFyYWxsZWwg
d2l0aCBzZXZlcmFsIHN1Ym1pc3Npb24gaGFwcGVuaW5nIHRoZQ0KICAgIHNhbWUgdGltZS4gVGhl
IHBvaW50IGlzIHRoYXQgd2UgbmVlZCB0byBzZWUgdGhlIGJpbmRpbmdzIGFuZCBjaGVjaw0KICAg
IHdoZXRoZXIgeW91ciBEVFMgY29tcGxpZXMgd2l0aCB0aGVtLiBBY3R1YWxseSB0aGUgY2hlY2sg
c2hvdWxkIGJlIGRvbmUNCiAgICBieSB5b3Ugd2l0aCBkdGJzX2NoZWNrLCBidXQgbGV0J3Mgc2F5
IHdlIGFsc28gbG9vayBhdCBpdC4NCg0KICAgIFlvdXIgcGF0Y2ggd2l0aCBmdWxsLWJsb3duIERU
UyBhbmQgZHJpdmVycyBpcyBhbHNvIGdvb2QgYXBwcm9hY2gsIGV4Y2VwdA0KICAgIHRoZXJlIGFy
ZSBubyBkcml2ZXJzIHNlbnQuIEZvciBleGFtcGxlOg0KICAgIGh0dHBzOi8vbG9yZS5rZXJuZWwu
b3JnLz9xPWhwZSUyQ2d4cC1pMmMNCiAgICBodHRwczovL2xvcmUua2VybmVsLm9yZy8/cT1ocGUl
MkNneHAtd2R0DQogICAgSWYgeW91IHdhbnQgdG8gYXZvaWQgYnVpbGRpbmcgRFRTIHNlcXVlbnRp
YWxseSwgbm8gcHJvYmxlbSwganVzdCBzZW5kDQogICAgdGhlIGJpbmRpbmdzIGFuZCBEVFMuDQoN
CiAgICBBbmRyZXcncyBhcHByb2FjaCBpcyBtdWNoIG1vcmUgZmxleGlibGUgYmVjYXVzZSBpdCBh
bGxvd3MgeW91IHRvIGRpc2N1c3MNCiAgICB0aGUgYmluZGluZ3Mgd2hpbGUgbm90IHBvc3Rwb25p
bmcgdGhlIGNvcmUgcGFydCBvZiBEVFMuDQoNCg0KICAgID4gDQogICAgPiBNb3N0IG9mIHRoaXMg
Y29kZSBpcyBpbnRlbmRlZCB0byBiZSB1c2VkIHdpdGggT3BlbkJNQyBhbmQgdS1ib290LiBXZSBk
aWRuJ3QgaGF2ZSB5ZXQgdXBzdHJlYW0gYW55dGhpbmcgaW50byB0aGUgYm9vdGxvYWRlciwgYW5k
IHdhbnRlZCB0byBmb2xsb3cgYSBzdGVwIGJ5IHN0ZXAgYXBwcm9hY2ggYnkgaW5pdGlhbGx5IHB1
Ymxpc2hpbmcgaW50byB0aGUga2VybmVsICh0aGF0IGV4cGxhaW4gd2h5IHNvbWUgaW5pdCBhbHNv
IGFyZSBzdGlsbCBoYXJkY29kZWQgaW4gdGhlIGNhc2UgdGhlIGJvb3Rsb2FkZXIgZG9lc24ndCBw
cm92aWRlIHRoZSBkYXRhLCB0aGF0IGlzIHN0aWxsIHdvcmsgaW4gcHJvZ3Jlc3MsIGJ1dCB3ZSBj
YW4gaGF2ZSBlbmQgdXNlciB0ZXN0aW5nIHRoZSBpbmZyYXN0cnVjdHVyZSkuIFdlIGhhdmUgYSB2
ZXJ5IHNtYWxsIHVzZXIgc3BhY2UgZW52aXJvbm1lbnQgdG8gdmFsaWRhdGUgdGhhdCB0aGUga2Vy
bmVsIGJvb3QgcHJvcGVybHkgYnkgdXNpbmcgdS1yb290LCBiZWZvcmUgZ2V0dGluZyBPcGVuQk1D
IGZ1bGx5IGxvYWRlZC4gTGFzdCBidXQgbm90IGxlYXN0LCBhcyB0aGlzIGlzIGEgQk1DIGNvZGUs
IHdoaWNoIGlzIG5ldyB0byBvdXIgZW5kIHVzZXJzLCBpdCB3b3VsZCBiZSBqdXN0IGdyZWF0IHRv
IGhhdmUgZGVmYXVsdCBmYWxsIGJhY2sgaWYgdGhlIHUtYm9vdCBlbnZpcm9ubWVudCBpcyBub3Qg
cHJvcGVybHkgc2V0dXAgKHJvdWdobHkgd2UgY291bGQgY29kZSB0aGUgTUFDIGFkZHJlc3MgaW50
byB0aGUgdW1hYyBkcml2ZXIsIG9yIHRoZSBEVCB0byBhZGRyZXNzIHN1Y2ggY2FzZXMpLiBXZSBw
bGFuIHRvIHVwZGF0ZSB1Ym9vdCBpbiB0aGUgbmV4dCBjb3VwbGUgb2YgZGF5cyBieSB0aGUgd2F5
LiANCiAgICA+IA0KICAgID4gV2UgZG8gbm90IHVzZSBkdHNpIGF0IGFsbCBmb3IgdGhlIG1vbWVu
dCwgYXMgd2UgYXJlIGdlbmVyYXRpbmcgYSBkdGIgb3V0IG9mIHRoZSBkdHMgZmlsZSBhbmQgbG9h
ZCBpdCBpbnRvIG91ciBTUEkgaW1hZ2UuIFByb2JhYmx5IG5vdCB0aGUgYmVzdCBhcHByb2FjaCwg
YnV0IHRoaXMgaXMgdGhlIHdheSBpdCBpcyBpbXBsZW1lbnRlZCBjdXJyZW50bHkuIFRoZSBkdGIg
aXMgY29tcGlsZWQgb3V0c2lkZSB0aGUga2VybmVsIHRyZWUgZm9yIHRoZSBtb21lbnQgdXNpbmcg
ZHRjIGNvbXBpbGVyLiBXZSB3aWxsIGFkZCB0aGF0IHN0ZXAgaW50byB0aGUgZHRzIGJvb3QgTWFr
ZWZpbGUsIGl0IG1ha2Ugc2Vuc2UuIERvZXMgdGhlIGR0c2kgaXMgbWFuZGF0b3J5IGZvciBldmVy
eSBTb0MgPyBJIGNhbiBidWlsZCBvbmUgaWYgbmVlZGVkLiBCdXQgYXMgdGhpcyBTb0MgaXMgYSBC
TUMsIHRoZSBjdXJyZW50IGR0cyBpcyBhbiBleGFtcGxlIG9mIHdoYXQgc2hhbGwgYmUgY29uZmln
dXJlZC4gTWFueSBvdGhlciBkYXRhcyByZWxhdGVkIHRvIHRoZSBoYXJkd2FyZSB0YXJnZXQgcGxh
dGZvcm0gYXJlIGRlZmluZWQgaW50byBPcGVuQk1DIGxheWVycyB3aGlsZSB3ZSBidWlsZCBmb3Ig
dmFyaW91cyBQcm9MaWFudCBzZXJ2ZXJzLiBXZSB3YW50ZWQgb3VyIGtlcm5lbCBjb2RlIGJlaW5n
IHJlYWRpbHkgdGVzdGFibGUgdGhhdCBpcyB3aHkgd2UgaGF2ZSB0aGF0IGdlbmVyaWMgZHRzLiAo
R1BJT1MgbWFwcGluZyBpcyBtYWNoaW5lIGRlcGVuZGVudCkNCg0KICAgIFRoZSBjb21taXQgbWlz
c2VzIGRlc2NyaXB0aW9uLCBzbyBJIGFjdHVhbGx5IGRvbid0IGtub3cgaG93IHRoZQ0KICAgIGFy
Y2hpdGVjdHVyZSBsb29rcyBsaWtlLiBGb3IgbW9zdCBvZiBTb0MsIHRoZXJlIGlzIGEgRFRTSSBi
ZWNhdXNlIHRoZQ0KICAgIFNvQyBpcyBiZWluZyBwdXQgb24gZGlmZmVyZW50IGJvYXJkcy9wcm9k
dWN0cy4gSXQgYWxsb3dzIGNsZWFyDQogICAgc2VwYXJhdGlvbiBiZXR3ZWVuIFNvQyAod2hpY2gg
Y291bGQgYmUgcmV1c2VkKSBhbmQgYm9hcmQuIElmIHlvdSBoYXZlDQogICAgb25seSBhIERUUywg
dGhlbjoNCiAgICAxLiBXaGVyZSBpcyB0aGUgU29DIGhlcmU/IEhvdyBpdCBjYW4gYmUgcmUtdXNl
ZCBieSBkaWZmZXJlbnQgYm9hcmQ/DQogICAgMi4gSXMgaXQgb25seSBvbmUgRFRTIHBlciBlbnRp
cmUgc3ViLWFyY2hpdGVjdHVyZT8gTm8gbW9yZSBib2FyZHM/IE9ubHkNCiAgICBvbmUgcHJvZHVj
dD8gTm8gZXZlbiByZXZpc2lvbnMgb3IgaW1wcm92ZWQgdmVyc2lvbnM/DQoNCiAgICBCZXN0IHJl
Z2FyZHMsDQogICAgS3J6eXN6dG9mDQoNCg==
