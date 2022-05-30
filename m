Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8CA75378DB
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:07:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234468AbiE3KHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 06:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbiE3KHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 06:07:03 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB81ADA0;
        Mon, 30 May 2022 03:06:58 -0700 (PDT)
Received: from pps.filterd (m0167090.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24U8c4ls019060;
        Mon, 30 May 2022 06:06:47 -0400
Received: from nam02-sn1-obe.outbound.protection.outlook.com (mail-sn1anam02lp2047.outbound.protection.outlook.com [104.47.57.47])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3gbgc739j2-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 30 May 2022 06:06:47 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=APQNKRIDbqaDBh0ZympIs0ng3PHTxPAAfkZc77WNxbWrvt7AvqqnNF2BJznOJWyAxVO/e32uOoWQbECZFVN8jfJ7d9fn16muCTidLpNFo3os1+FTYJ+c7BEFeTGQfwCUbnDoxeIMHw+4ppWS9fTxydkdpshrfhCNTz81yZbHruYg7WYJ+LGQscsr5E0YrkYpVziYYNHbKEMSyODlt2Ha2fD9e47c6tqSlZvOd5aIQ4toYKky66N82WZdeAZYgWO3GhxxDAvb5+5isuEuKuCRJuIBaKdCGQpZ6+OtXM6V1RUqgPQavikJUl1OjzSdQlFSzGynWEWFXw5tYVPe68+l8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZGYONizWieuoBNzYD0ho2kAKdkTcgipcuT2Deb5j4fM=;
 b=XaGFrGlk+KOj2XyruzTLo4EIkHSw/MY5jz8stqD4H/+kvyEuc3iHXkHzLxHPxxOQCB/sD4/l66Y+0Px7WXT5MPMSURZmsK3wMdr9WxfwBdKPFqiMyo2mR6//fErOPD67G7RhHCzw2EefReF/BnevzebPEv9vehlBD5XMoo+bKs51rYcQJjfa+x9U3lphW8ZX5T8uHaiSDy9/1rGASOv9vx06bE4HFgxek4NS1ONbq2LUrvb3xAkwXP4kXhSXKaBfQgCaP6s7HE4d2McCHhWjQdYoKvXKUbHi+gMuDvL+no1ikOAZupBKIKovlzBRlJIISQ9xSq/wddT4r9qCKrZO6w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZGYONizWieuoBNzYD0ho2kAKdkTcgipcuT2Deb5j4fM=;
 b=YZN0ya5zIU3/gJSoysFL488NGq5lvQf4LJHOHiEQLPhQkYCbichNUDAjMbYABbOxY8ySlNCZgt53tbstuYEU9xCkaAixiXQXn4f3fjRrPkYpGNZb2dvmq7JdG/EysP5rzldrXiXXaTEgS42y1lbYFbGah2kAf7e8znK410GVqiQ=
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com (2603:10b6:a03:3b8::19)
 by BN8PR03MB4628.namprd03.prod.outlook.com (2603:10b6:408:6e::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Mon, 30 May
 2022 10:06:45 +0000
Received: from SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39]) by SJ0PR03MB6253.namprd03.prod.outlook.com
 ([fe80::b188:7eab:15fc:aa39%5]) with mapi id 15.20.5293.019; Mon, 30 May 2022
 10:06:44 +0000
From:   "Hennerich, Michael" <Michael.Hennerich@analog.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
CC:     =?iso-8859-1?Q?Uwe_Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        "linux-input@vger.kernel.org" <linux-input@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 1/4] Input: adp5588-keys - drop CONFIG_PM guards
Thread-Topic: [PATCH 1/4] Input: adp5588-keys - drop CONFIG_PM guards
Thread-Index: AQHYck9RL/9Q/ZnE9kWZBWxpT1Z6j603NSkg
Date:   Mon, 30 May 2022 10:06:44 +0000
Message-ID: <SJ0PR03MB62537CAF01121AC08D236F988EDD9@SJ0PR03MB6253.namprd03.prod.outlook.com>
References: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
In-Reply-To: <20220528045631.289821-1-dmitry.torokhov@gmail.com>
Accept-Language: de-DE, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbWhlbm5lcm?=
 =?iso-8859-1?Q?lcYXBwZGF0YVxyb2FtaW5nXDA5ZDg0OWI2LTMyZDMtNGE0MC04NWVlLTZi?=
 =?iso-8859-1?Q?ODRiYTI5ZTM1Ylxtc2dzXG1zZy0zM2Y4YjY5ZS1lMDAwLTExZWMtOTJhMS?=
 =?iso-8859-1?Q?00ODg5ZTc3Y2RkZWZcYW1lLXRlc3RcMzNmOGI2YTAtZTAwMC0xMWVjLTky?=
 =?iso-8859-1?Q?YTEtNDg4OWU3N2NkZGVmYm9keS50eHQiIHN6PSIyNzMyIiB0PSIxMzI5OD?=
 =?iso-8859-1?Q?M3ODgwMjg0MDI2MzEiIGg9InZQYmw3eWFrNnJwMXdsWjRZUnNZd2s4QVlh?=
 =?iso-8859-1?Q?VT0iIGlkPSIiIGJsPSIwIiBibz0iMSIgY2k9ImNBQUFBRVJIVTFSU1JVRk?=
 =?iso-8859-1?Q?5DZ1VBQUVvQ0FBREhtMUgyREhUWUFabHNLTTV0RGVBbG1Xd296bTBONENV?=
 =?iso-8859-1?Q?REFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFIQUFBQURhQVFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFFQUFRQUJBQUFBSnJqSklRQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBSjRBQUFCaEFHUUFhUUJmQUhNQVpRQmpBSFVBY2dCbEFGOEFjQUJ5QU?=
 =?iso-8859-1?Q?c4QWFnQmxBR01BZEFCekFGOEFaZ0JoQUd3QWN3QmxBRjhBWmdCdkFITUFh?=
 =?iso-8859-1?Q?UUIwQUdrQWRnQmxBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUVBQUFBQUFBQUFBZ0FBQUFBQW5nQU?=
 =?iso-8859-1?Q?FBR0VBWkFCcEFGOEFjd0JsQUdNQWRRQnlBR1VBWHdCd0FISUFid0JxQUdV?=
 =?iso-8859-1?Q?QVl3QjBBSE1BWHdCMEFHa0FaUUJ5QURFQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFRQUFBQUFBQUFBQ0FBQUFBQUNlQUFBQVlRQmtB?=
 =?iso-8859-1?Q?R2tBWHdCekFHVUFZd0IxQUhJQVpRQmZBSEFBY2dCdkFHb0FaUUJqQUhRQW?=
 =?iso-8859-1?Q?N3QmZBSFFBYVFCbEFISUFNZ0FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFCQUFBQUFBQUFBQUlBQUFBQUFBPT0iLz48L21ldGE+?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 38a663ce-fd0c-4ec6-3201-08da422419dd
x-ms-traffictypediagnostic: BN8PR03MB4628:EE_
x-microsoft-antispam-prvs: <BN8PR03MB4628868E86ED23E6DEBB3A358EDD9@BN8PR03MB4628.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wSpHFcfXA+VfTl2bci6OTLEQpABfdJr3wMLSzXdiA1IaF6MZZtGeL/Uy9+Z659q4cfqpq5GoInQmTdByKtBrTOwsZ+Lw6CzkBm04GGvbMPsfGAY1ybHT3uRGZrQbAH1e+eLend3hFrQT06WlCTahhrtGEKmM/DhktfBA/D4xOT5SwEOq3L4Yc6/esdAesQ0PKdCNZPm3qFjwCiFfyNmwAQW3c1MwBISCLDCeNvOIfYqhF6qtdHicdvIjvICXqH/SwhdmDpwUqSsp2EBoS3+8y0r29K0fjRVoB9Ld/zYMshbmkpLrGTsG8H+wtzqc2G7Fu1g0pGWwwGNRytK/rEHNLw7rRMtPyjqvait+3rgJSqJ1h2IbjACe7VarEBIClRenVEN0n2tyXovTHreRMElyRLlH/hQIDzXTTWS0Kn+Am+Eg9hGhmHvIk/KvIngLSO1Buyvouhc8ZapmXHphEAcoVf1B9gqu3CdjOt0vyK4IeEKG7cc8ZgUBsPsIB7kYfNGAIcNGBkhGTscuIgMcfPG9c5woDE5GfvNT0iywZ3rPbtz3R7bJ2QHEXui+VLRbGXGDf03dfSJf0uHLWkygy4pqfYvNQZBmnQX2fnT4/DOGswU35zJJGF9NqrU6cAtYZT9RLmWsqomDPz6l5K/FYBps58P7Ljs/2uBl4+ZBODUU9o9s2NO8fK58b395FNO8YyfQIFBDL5+mwuFF8STrOPP64w==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SJ0PR03MB6253.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(9686003)(66556008)(76116006)(55016003)(26005)(8676002)(7696005)(66446008)(53546011)(66946007)(6506007)(66476007)(64756008)(4326008)(52536014)(86362001)(508600001)(33656002)(5660300002)(38100700002)(71200400001)(2906002)(38070700005)(316002)(54906003)(186003)(6916009)(66574015)(122000001)(83380400001)(8936002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?M69VpbJq0rLxaQhicS3Go3RTO3C0g9Tv0X42g+qBDqK/yXPl3++k1NO1U3?=
 =?iso-8859-1?Q?Yk0FjD7GV1pF6Vq9fBbXuxhlk0PwbAFKNmiqZAny0Nk05sfmhqzm1LWJMp?=
 =?iso-8859-1?Q?H1EtFGMkBEZqLb2G/7w9dNeID3k8awENFREeZ9GjaGLcgWx9nFTgev0p5v?=
 =?iso-8859-1?Q?zpKmF5w/HddXO/EbS1QBK61ROfxumKAWRNk0LjNtT3Oi6kpgkTpvY8fT5p?=
 =?iso-8859-1?Q?nQbGeU2YYGsaHTo9MpKDnRnujvTh6iO5f4SGxcjP4al5K7mmjFS2ISrgd/?=
 =?iso-8859-1?Q?m31yRE4DvxcDS4RldPltmjQdeCJ9qqgAliTRTshYVkOhBxLCCzY3ZshImf?=
 =?iso-8859-1?Q?AH9DBf1+TSOPFlOGE4pvvCNTAjWHIZ2zr4DkCMInWXSx1W3d9m4G/nTR1d?=
 =?iso-8859-1?Q?lNE7OMaMSEH7kItcY4N4dWmsZQmHQtFVAHkhaGAR8di6gBGp6iTKipz8Lc?=
 =?iso-8859-1?Q?eGn5B9EAx8FBKsFrEX5xdJgElE1ILWh3cGi8Kl74CvHV7YAC2KRVYifFcD?=
 =?iso-8859-1?Q?vxy/Q8IzLeYUe5maM5kbOirtLoNLFbMvh1ih6pV0QF35HzVEYC4tQFyh5f?=
 =?iso-8859-1?Q?DIF/xvyVnLHVSiOhHC2XZQCN5FtrX6kiePaQmPZokSUp8LIIsM6cEaVrr1?=
 =?iso-8859-1?Q?i+Dd7fLA7DsC6c6r8Foa4IztQ9bND1Qe3rxs+7HkVnebApD/TUbd7vhPTt?=
 =?iso-8859-1?Q?vmPw5ztryhbITvBcrrMpCRqRzA4mq/6bbPpggpYeetP7hYzDPuZjYxsr2u?=
 =?iso-8859-1?Q?2CIhvcMThU30QhFnnB1YIDXaeKxeBjNyy+jl/rX9qZ4vpm8hAchupCcedi?=
 =?iso-8859-1?Q?uI61hJeRrM3UJLMPtvb0c4lSH9fsQT4WqyqTLQjupehW231xkXqPlQNAaa?=
 =?iso-8859-1?Q?N4FcRQ1XYnCZqG9j5zyrlRyXAzRJagISs9gcy8KxDt7ITGSUtYJiTeKXsU?=
 =?iso-8859-1?Q?b7uUuxCrxSuJqOvF5xm8Hgd2e87eARHzhqKMebV/qTL3sumRUvG76yzLRe?=
 =?iso-8859-1?Q?+mjZf7OKjKsN+9M3r5U5+GO9+4r3JjhgJqGXgAp7dlH6LTUvakTcI2yaNr?=
 =?iso-8859-1?Q?VDySYNzeo+rJBDwKw8wBU8jR+9YySTvuy7VsR95ho7Rzbx37MrnjWRG07T?=
 =?iso-8859-1?Q?rlkoy7+XGL96pYHgRDaT/8krgczkmSBIhatHXe3jnKRUdfsoSSnu2GQre/?=
 =?iso-8859-1?Q?K/EDx7ZKnldwresISMY3r9qHEl3/HOERcTCKLIeIla6vab8KJWSkgs3tb6?=
 =?iso-8859-1?Q?koPepoVj8FcPE+VQVfo/tuPLOxIpU96MHlyCj3fnFmyEafCG8HLgDX7MKm?=
 =?iso-8859-1?Q?EGZdEd9X8jGUg7b5ZWaC6J/x0yUMTCCJwvzsdxRqukF4y+Xx0mBTER97IU?=
 =?iso-8859-1?Q?va37dJsykXCqlyheyrNF7DU/YXqqODVHzA+MSXqUeFFAtnU7VUZb2QWq2k?=
 =?iso-8859-1?Q?WUe6YC7Mszs+mZ8Sdq0+U5Uz6xILbjlH5jdMqkt8EaZIP6+w10j65Bnhe9?=
 =?iso-8859-1?Q?ZVzUXmDWz7DR8/yN2aCq7g0v05Eb+uTwFOtfzfpND40xOKlFhm7GPZrvvJ?=
 =?iso-8859-1?Q?5qefdklB1DM1cFhtWAwZqJBwtd/AWvXJUUHvmgRF+Fg/xhM22YQk1+YgCo?=
 =?iso-8859-1?Q?m3WqRazX3CV9TxaAITmp4FxD59aEZyuRopHqYPFjB3UOJRnqeeQ+WbfS4k?=
 =?iso-8859-1?Q?a1+aWgxG4l9fpLH+WV7BRpjVCzpxyHTNTch4qUbSt6FvDrB+Zl53EVG7wS?=
 =?iso-8859-1?Q?d4MM04XAtsG2NiO4dWpnJr+KvOJ7gIHKvza9UTbWRNC4BXLgrdwXLw2/13?=
 =?iso-8859-1?Q?X8Sgkxcrr4Owst2gwGqhbRQG94z0+mU=3D?=
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SJ0PR03MB6253.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 38a663ce-fd0c-4ec6-3201-08da422419dd
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2022 10:06:44.5904
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tjcShqOy2z+tQ5vIK4GeTCt07xzkZy8VDQKeayCRRtfvbHWU7AwnCnZG+WPrqBcASSXib++fQgGxYFt1WGOaLq8DNSpOmX90TlwktP/cR6Y=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR03MB4628
X-Proofpoint-GUID: E2u4kIdguMW1ul3h6UVkJx6l8gfHXbwL
X-Proofpoint-ORIG-GUID: E2u4kIdguMW1ul3h6UVkJx6l8gfHXbwL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-30_03,2022-05-30_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 lowpriorityscore=0
 phishscore=0 clxscore=1011 spamscore=0 malwarescore=0 adultscore=0
 bulkscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205300052
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: Dmitry Torokhov <dmitry.torokhov@gmail.com>
> Sent: Samstag, 28. Mai 2022 06:56
> To: Hennerich, Michael <Michael.Hennerich@analog.com>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>; linux-
> input@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: [PATCH 1/4] Input: adp5588-keys - drop CONFIG_PM guards
>=20
>=20
> To improve compile-time coverage let's drop #ifdef CONFIG_PM guards and
> use SIMPLE_DEV_PM_OPS and __maybe_unused attributes and rely on the
> linker to drop unused code.
>=20
> Signed-off-by: Dmitry Torokhov <dmitry.torokhov@gmail.com>

Acked-by: Michael Hennerich <michael.hennerich@analog.com>

> ---
>=20
> Since we are talking about keeping the driver and switching it away from
> platform data and towards device properties, here are some cleanups.
>=20
> Only compiled, not tested.
>=20
>  drivers/input/keyboard/adp5588-keys.c | 13 +++----------
>  1 file changed, 3 insertions(+), 10 deletions(-)
>=20
> diff --git a/drivers/input/keyboard/adp5588-keys.c
> b/drivers/input/keyboard/adp5588-keys.c
> index 1592da4de336..ea67d0834be1 100644
> --- a/drivers/input/keyboard/adp5588-keys.c
> +++ b/drivers/input/keyboard/adp5588-keys.c
> @@ -612,8 +612,7 @@ static int adp5588_remove(struct i2c_client *client)
>  	return 0;
>  }
>=20
> -#ifdef CONFIG_PM
> -static int adp5588_suspend(struct device *dev)
> +static int __maybe_unused adp5588_suspend(struct device *dev)
>  {
>  	struct adp5588_kpad *kpad =3D dev_get_drvdata(dev);
>  	struct i2c_client *client =3D kpad->client; @@ -627,7 +626,7 @@ static
> int adp5588_suspend(struct device *dev)
>  	return 0;
>  }
>=20
> -static int adp5588_resume(struct device *dev)
> +static int __maybe_unused adp5588_resume(struct device *dev)
>  {
>  	struct adp5588_kpad *kpad =3D dev_get_drvdata(dev);
>  	struct i2c_client *client =3D kpad->client; @@ -640,11 +639,7 @@ static
> int adp5588_resume(struct device *dev)
>  	return 0;
>  }
>=20
> -static const struct dev_pm_ops adp5588_dev_pm_ops =3D {
> -	.suspend =3D adp5588_suspend,
> -	.resume  =3D adp5588_resume,
> -};
> -#endif
> +static SIMPLE_DEV_PM_OPS(adp5588_dev_pm_ops, adp5588_suspend,
> +adp5588_resume);
>=20
>  static const struct i2c_device_id adp5588_id[] =3D {
>  	{ "adp5588-keys", 0 },
> @@ -656,9 +651,7 @@ MODULE_DEVICE_TABLE(i2c, adp5588_id);  static
> struct i2c_driver adp5588_driver =3D {
>  	.driver =3D {
>  		.name =3D KBUILD_MODNAME,
> -#ifdef CONFIG_PM
>  		.pm   =3D &adp5588_dev_pm_ops,
> -#endif
>  	},
>  	.probe    =3D adp5588_probe,
>  	.remove   =3D adp5588_remove,
> --
> 2.36.1.124.g0e6072fb45-goog

