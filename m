Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04D6D5364D0
	for <lists+linux-kernel@lfdr.de>; Fri, 27 May 2022 17:39:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353652AbiE0Pji (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 11:39:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237983AbiE0Pjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 11:39:33 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D7391078A6;
        Fri, 27 May 2022 08:39:31 -0700 (PDT)
Received: from pps.filterd (m0150241.ppops.net [127.0.0.1])
        by mx0a-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24RDYL7G023269;
        Fri, 27 May 2022 15:39:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=ZP0S2WFLdjoFXCOLK9UCN1p66JhaGjKHRHDLnEJWbmc=;
 b=mSp5iHz7Rjj8BqkCA1O7ZPWd4dzhY2CCKC4/Qt6ST0o6BogimcDnhNQfVsjGp6yBE5n0
 epsFFqXsWUDvC/JFg2jqOXpWQBDB15Z/0ctal0xcZDlYQ4pE7TUs/RRcvZdV6ot1e/dB
 mqHrp0atjA0A/0oxhz3h/FAPlDsgvZyBDbGfuMfCvvGulwl4lvQF/Oq7efwDDS85RfDG
 fdg4MomssbRwvOAL4hTZqEcun1PWBhKPZE0YIUqgDZZWmb8hIdoZLFm9JgCC7tdCaW2u
 LzqXriDm6z2Pi5wssBkaDI85Xov2Oevf8dUzd3r5Auy0/HlOSoGhQ52cBZLu6seqcXhE FA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0a-002e3701.pphosted.com (PPS) with ESMTPS id 3gayn6gvgj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 27 May 2022 15:39:00 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id 3B56013053;
        Fri, 27 May 2022 15:38:58 +0000 (UTC)
Received: from p1wg14928.americas.hpqcorp.net (10.119.18.116) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 27 May 2022 03:38:58 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14928.americas.hpqcorp.net (10.119.18.116) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 27 May 2022 03:38:58 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 27 May 2022 03:38:58 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 27 May 2022 03:38:57 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NzILDqDVYOgeTay77sujVBUO1O0zThPyMwwCGQzwbncCtPoGVKlP3ix5c6RkIb2mTrJxpmppwDCBk1s0HQx8ogbf6OeWNaLZXu4RcYJ8WZtEc4RQr3WnG2IXj8NwIR1/bBwtyKAvqi4R1hoAxGeXYuSdih+ChISXkwmSsayP4+NXRbdoiBwVKeAQjpT1Q2/Wi2KELxEw48GwdmIe573AsWclaiAGhVBcGQCR/nnRrzlD8QBk0LUrSEdtUo0CW5gDQ9K/cbWxci0tomogyLRmGWvvVPjTvt3Cy8bv4FXfCzUr3Slvdh2t24QYCoPJ8yyznOefK3CW3hsFSJ+DOD/KOQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZP0S2WFLdjoFXCOLK9UCN1p66JhaGjKHRHDLnEJWbmc=;
 b=A4+S3x87CvvAWo3H2xzpHmqOCgXbkRct0kPIBZWfN9KBFcV1lDCz4o+eygPh8rl/maeBPjjRVyByoq6j4AGgIiBjZO2qqu+8h9gcp6lTM9jUtpsPFdjlGcX1v6fotXm6ON2cR0rjJvXYWusxQW0rQLPEiP6i2tJOAjY1nWp8oyvZGVTvs5s62K0FpSWvZXZ0t10oUwKGpzrK9aeQxd75QEQLhoLndT7CIHpq7jTkVIaPDLdMXReojKivxWde72cd5F18zJ2tsRJRFwWPXCKFcszmqwBXepCA5pdJ+cir+HHtAXcKOY+c13CiIDlyS6hJ6PfNJ3T5pPvpaGo2kVFBdw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:8:4e::10) by
 PH7PR84MB1679.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:152::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Fri, 27 May
 2022 15:38:56 +0000
Received: from DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43]) by DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::152:caab:fcbf:4e43%3]) with mapi id 15.20.5293.013; Fri, 27 May 2022
 15:38:56 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        ARM <linux-arm-kernel@lists.infradead.org>
CC:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Laurent Vivier <laurent@vivier.eu>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: RE: linux-next: manual merge of the arm-soc tree with Linus' tree
Thread-Topic: linux-next: manual merge of the arm-soc tree with Linus' tree
Thread-Index: AQHYcWJIIPsLGQoQ6ky3ZRDOVp+Oka0y1/FA
Date:   Fri, 27 May 2022 15:38:56 +0000
Message-ID: <DM4PR84MB19271EE54D445DD8F1DB047988D89@DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220527103916.52768f74@canb.auug.org.au>
In-Reply-To: <20220527103916.52768f74@canb.auug.org.au>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 977fcc2a-8504-49d6-9735-08da3ff702c1
x-ms-traffictypediagnostic: PH7PR84MB1679:EE_
x-microsoft-antispam-prvs: <PH7PR84MB1679E4D2EDFB2A0CD130A11A88D89@PH7PR84MB1679.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: p2uoSwDTiwC8PF6Tk/1vj/5qZdJQB8KaE0bE+J54qGc4ccbD6jangxa0GG3htqGmdECpQjy2vEWePx9/1T1MW4YSYl9w24ZbiOLIxCS5UaIK4c1y9xiYm7Sd8749aqi/QEyWm15fNTdhIl2EzqBOo/eeeegwSTo1IAvlW1YyJsli2eTpLjanJN1/owatymfQhhRWboe8erujzMcpDyvfcS4jaJsFlgdrRvItSIPBiyPwr+Z+rsYVqjY8cAo/SSZ84eM+IhTsnrE3u+yNMBtGhlSwuBhuvn7J5ZdhCxOT5TCXwRfuA/b9nzKz/aNNxueCdWK3rPjQn/cTtQfL/2Lc+YRNmdZDcmf+uVWCxiuSxddpYkkqVdTKZ8hEKpMKh/nZjbEe3ChIeVXWxrp8ibi9urr4jiX/hZDJRohv0r3qK+C+l4DncqjWlPed0jeVQemlQS7o9jxKlANUnYcE/yecT0F8lfqwJemV6C1vY7tDJ6/se3xbaMCo6ryW4Py4vN/RNjARz7jqMDZ6qN3KVuCpNchfiCIrjek7RuheqTUmz/HvJcquReW52dBetB0DQkFid+ThRjvG++n6aKY3WKxYUCr5MIl2DUFUDCrtvgKjMd4dnW7cOkrnA+eplCKBPapx7lEy7SlQmYtYQ2OSdfvKEIwaa4Hn3fCiyRz3VheGdzsTDdgNDI5KVZMvn48m/OEhhVTSxn/WBYO9dxNU8qYc8Q==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(2906002)(5660300002)(8936002)(66556008)(9686003)(66476007)(6506007)(122000001)(508600001)(38100700002)(38070700005)(4744005)(7696005)(66446008)(76116006)(82960400001)(55236004)(66946007)(186003)(83380400001)(8676002)(54906003)(55016003)(316002)(4326008)(64756008)(86362001)(71200400001)(110136005)(52536014)(33656002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?ZCtYOy3J71WZSHQmV6V7/lluCFdTWJcEBO30xD/u68o6Hu9mSKAi7OZ1bwct?=
 =?us-ascii?Q?6Ur64VWAUSahNMDGXOpmLMExqYxw4R1PLFQj4oiytzMtU7wli8JukYQ53pj1?=
 =?us-ascii?Q?C3zlPNI/qQdCUqxiRrNRuMyFFg7Xs80E1WdRmeUYMHCstyurA3JOBmmaiszf?=
 =?us-ascii?Q?c4/Z4LbxqFOtOzGbsMovjBLp2hIwoEb3baMz47uNbE+FOYpSarf5QStD4Kik?=
 =?us-ascii?Q?bJZgVoABKcVVJIXa9cJPElzh3lpeAaDvO/JHOe8Lz+x+mvARvG/VF+zgGKqJ?=
 =?us-ascii?Q?SuPrvO5Q4LNqXZemENQg0640Supwoa7WH1odW2SYOeby0P+R+skBGWQEj/IM?=
 =?us-ascii?Q?qG57bdT9s0Uv902GLzXpdoNGM0EnecsWhKUwcBMBD8vZOSvd6vL4O4aIVV5D?=
 =?us-ascii?Q?0fpMA3/znlg//4twFAGcCzeXerl1Dr9OeA/zddVYibCbIAB6G5+vgaEaahYK?=
 =?us-ascii?Q?mN1/40PIMku/QjULmiPq5SABj+Wh446eOqM/2tvNEldBWvTZk1DYfAMNTQ0J?=
 =?us-ascii?Q?N9wIQTsdShkdmnRAJwrOJeS0AoZwnwCV93v8u3UXEH504mJ2zXy3J4l5m7BF?=
 =?us-ascii?Q?4CFcmjjzF91V27aDvVkM2cSTMCmC/OWhtjtHGYvEyu+N1mmfL1ig2JYj6SEp?=
 =?us-ascii?Q?i+3V8KqFWIc2bMjgwjle9WLeI8U5gq50ga28NpTaOPKD5wKUrlcYoC8HpgT+?=
 =?us-ascii?Q?my5fEc4V/hEXMRyfC8DvUSwgJAgKNDfztmRxsnoP3bBC9uI+GicQJwRfpfWr?=
 =?us-ascii?Q?3249qkqGz+WBPXfMmO1YHAVt1YPxEuMQgsWjiOm8RcAGVZocOhOi+xBteKTM?=
 =?us-ascii?Q?9DrIUAPBGC9Y5JcPAcOO0LdYL+1ZbMH/jOyZm5CE1pwhvV2FBa8/ng69ans5?=
 =?us-ascii?Q?qoXrHVM9pY49H08vSdElDjHrUCJHMuqLdvAb9xKOmXJn4mtFE7C1zNVJlnpu?=
 =?us-ascii?Q?HDtxtD2zi9ffbQIPXsbsGCl9RyZW+svj5yvNMkes2AFrSi/RvQZ5fDaVGNDl?=
 =?us-ascii?Q?mWBEie6xd7ax96mgvyYVASTVni6kwBWiaXYQZMXWZMFc+l3ZpjGDRsEL6JV8?=
 =?us-ascii?Q?jYtEQgwovtG30mz2xyxTnqRZxDPXhWMDdvTxJd4I3nFrXq5Nd0xOyd+A2ht+?=
 =?us-ascii?Q?ZiwejQgDAPHTtE15JgF5wDK9Xf90H9lJlBogjeKiixGWTxbN2Z0yXaIzTqih?=
 =?us-ascii?Q?YYix9wjPznq0zNexuXirDct+/T/xmLyIZLXaKtN3QeJFKbyHRFvv1EgvDha7?=
 =?us-ascii?Q?+BC2W2aSC9AFt0iR7e0RODjsyRTt5InT+umt5zhGyWikmNREbXtSHP388p6y?=
 =?us-ascii?Q?+YhKS8tAFZbXpheW9Klt+xSsjJH3+uOldwFBOmuGwm7341b9ge8k68Z8HCRg?=
 =?us-ascii?Q?aa1HAmIFiyNUAtqrzHLIkdTkWHdgej0RLWnt3pn1+bh1CfkYWwJfSCw3O5DQ?=
 =?us-ascii?Q?artcgBFrukRQVcCbfcxsHi5ICp0K/mjyOxvOrAVwsNnvI2kl+jDZAa7NjJka?=
 =?us-ascii?Q?KYUMbseAjf1PmxHaEnaLTewKIR3OcrB58kuvWAVzZLstfVG+OFWwXZDG1lzb?=
 =?us-ascii?Q?2TIgsF933I+baHFlRVpf2kfSERArcWFyTG65Uo7/ViixkzN1UWbN3w0JD3Ov?=
 =?us-ascii?Q?syTxbPucgnomH5PV6cm3gIYG98CJJCIV8LnQ1fpXtu7rnV/EvSD2TwHKOc3Y?=
 =?us-ascii?Q?q5rUJqj/oTJmu5VJZiD0UtTdGFSOA1P6B5ca4ANQvu88GYVGJMmxTRqpeHGQ?=
 =?us-ascii?Q?Zq9L6LRW8g=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM4PR84MB1927.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 977fcc2a-8504-49d6-9735-08da3ff702c1
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 May 2022 15:38:56.1903
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qdx39M4wuBhZS/aFnwUQxsqFVBgDEP51U6SYIk6NoezrbSgD2+9/E9DWLhPn6tAVsH/N3EcWollWdf3eR6IoEQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH7PR84MB1679
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: CX__DvTwi9jeA7YZCtGbWAE1Qgm_GaV8
X-Proofpoint-GUID: CX__DvTwi9jeA7YZCtGbWAE1Qgm_GaV8
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.874,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-27_04,2022-05-27_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 spamscore=0
 phishscore=0 impostorscore=0 bulkscore=0 priorityscore=1501 mlxscore=0
 mlxlogscore=999 malwarescore=0 adultscore=0 suspectscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2204290000 definitions=main-2205270075
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> Today's linux-next merge of the arm-soc tree got a conflict in:

>   drivers/clocksource/Makefile

> between commit:

>   c92e7ef16400 ("clocksource/drivers: Add a goldfish-timer clocksource")

> from Linus' tree and commit:

>   5184f4bf151b ("clocksource/drivers/timer-gxp: Add HPE GXP Timer")

> from the arm-soc tree.

> I fixed it up (see below) and can carry the fix as necessary. This is now=
 fixed as far as linux-next is concerned, but any non trivial conflicts sho=
uld be mentioned to your upstream maintainer when your tree is submitted fo=
r merging.  You may also want to consider cooperating with the maintainer o=
f the conflicting tree to minimise any particularly complex conflicts.

Hi Stephen,

Thank you for resolving the merge issue. I am relatively new to this proces=
s.. Can you provide a link to where you were notified of the merge conflict=
?

-Nick Hawkins
