Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F9F0523310
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 14:24:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242301AbiEKMYo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 08:24:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239244AbiEKMYd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 08:24:33 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65DCF1C5FB7
        for <linux-kernel@vger.kernel.org>; Wed, 11 May 2022 05:24:32 -0700 (PDT)
Received: from pps.filterd (m0150245.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 24BBIBoE028675;
        Wed, 11 May 2022 12:24:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=LXXBDWUhc/R2q99bmIN6CyMgnpAHR8nywQNi5nq0WcM=;
 b=I/xzY6knvkqLwqiUxdngpq70kTIAEZVLKSMh1CnqQwlvkUiRhksq0o12euXMwc2wLr+f
 dyIvk0noB5npKTc0slaLvsk/0avPVaScLw0XAnAk+slUS/hvn25BBrwcefJJN6lhO10T
 Fvo7DApOAqEjLrjVodCX3bhODzv9Fo5Fq4wsLQf8Yp7ORTC7DO8l+hhOHmWXps/a/OEO
 axzCWRPfgCZuu+MKLrTU/8RjIXw9h62hYZH2BwnTfXPpzE8QMTmrbDmVqcHDtPEHioMe
 +lapCJ/E3lP46RQt09vDR2Rlqw0imnhOer/B3jRrseoizAkyDI7KB+vF2Rz/zm2bkE1I BA== 
Received: from p1lg14879.it.hpe.com (p1lg14879.it.hpe.com [16.230.97.200])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fyxj06ybp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 11 May 2022 12:24:10 +0000
Received: from p1wg14923.americas.hpqcorp.net (unknown [10.119.18.111])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14879.it.hpe.com (Postfix) with ESMTPS id B1807130A9;
        Wed, 11 May 2022 12:24:08 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14923.americas.hpqcorp.net (10.119.18.111) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 11 May 2022 00:23:59 -1200
Received: from p1wg14920.americas.hpqcorp.net (16.230.19.123) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 11 May 2022 00:23:59 -1200
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.123) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 11 May 2022 00:23:59 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=k7NY1o7UvjffR9uU3Z4ky7PmNOFAjwuvt0BPzdaKrhHtR+JB2ADbS/nh4c+SbSlWS9VnPc1Wf0T93yBYG1om/cHRYn1D3w2cRyxrZi00Pyg3ElwAOVI89FhTpaAi7nHDGXUVrIhu4xrITts0Uq0JsqKk1ZwaYRPppUEapX0w7D3VdYBPjAyztDJhgqsn8VKY4F6noc8Agxg/N6gfpazna5Pzz6rdhUDdm0nvu4lc+8vdRAg56VV6KmuaSSZoQZgup7ybbRi/MoVWDDfkpVtiBZ+u7YfiS0HRYjxQd64S7AcC51cAhzOXl9PbPAAVVhdpTI8YRjrHoY9XY/SWxbqbKA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LXXBDWUhc/R2q99bmIN6CyMgnpAHR8nywQNi5nq0WcM=;
 b=d/Ait2h9a+WFDr/bV9eUJSX5FUoDkFqzXs127HJPkooRtfRDpELIIJZUOTjvAoz9lK3tk5OBZtH4plw+KzkiVy3iSHgaEkQoDzeJEQy1aXArIuUd62fEBTUBvWE8KcszOV162rG8m0TNEWVPyoCTWv62LBswfA8K4okDiQ7xafuxQ9Gzo0ksOSpTCPPX/xT50IN+9XPUlSd/S2D6EY96sOgk/I2nB1hXAyfBpc9/uaqruMEatZ+sJuGVYbKsLjhzHw2J5nmERnG3KXIdLo0ASk/rPu0cduJMJUZIJ6tNmx/9b0knRja+xCYtGL1OS0Sc8PgmhF8SdNLla5olpYJYbw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH0PR84MB1720.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Wed, 11 May
 2022 12:23:58 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%7]) with mapi id 15.20.5250.013; Wed, 11 May 2022
 12:23:58 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Russell King - ARM Linux <linux@armlinux.org.uk>,
        Mark Rutland <mark.rutland@arm.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
Subject: RE: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Thread-Topic: [PATCH v1] ARM: A9: Add ARM ERRATA 764319 workaround
Thread-Index: AQHYYX9/lEqShxGKek6V2FmsHnxQM60XuXoAgABMyYCAABLbAIAAE4wAgADBDEA=
Date:   Wed, 11 May 2022 12:23:57 +0000
Message-ID: <PH0PR84MB171830414ADC0DD69BD4116788C89@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220506192957.24889-1-nick.hawkins@hpe.com>
 <CAK8P3a045Di_zRomezeah0ZoSGPw0Z6YoYkZtoxx1qOXAtKbbw@mail.gmail.com>
 <7C103AEB-3111-4AE6-9645-CF590388A879@hpe.com>
 <CAK8P3a0OS+4XTG9VmfPwbuQoT+_G5-fSatbJ0g8Y7Y+O6-3YLQ@mail.gmail.com>
 <20220510141124.GB28104@willie-the-truck>
In-Reply-To: <20220510141124.GB28104@willie-the-truck>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7017f1e8-23a5-42e4-2974-08da33491f75
x-ms-traffictypediagnostic: PH0PR84MB1720:EE_
x-microsoft-antispam-prvs: <PH0PR84MB1720E72A17070E5F80EEBF0B88C89@PH0PR84MB1720.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: skEHTf7CrcfSUaQOhWH7c71Z0rXY6WF0fcaBwkJl7pBNstnar9IguoSh8FrfzF17FHUBJsMFF51QN3MLEzGc+fr9treYzLtFQzQil8k11pYpenNoQ4UdCaxiueW/Xn2LjbUinfTmgpBZcDZQVJIQR8Fuj1nCpjNPJq1BytNloLuBR00IMkJsnHa82dnykXR38EE/T3F1S2OXz+1NN/MRq9QENTmIdXbJpoMuAvVfLcFzxnwCmF6UNLcG3iAF7wAXltEsLc73PvHhpCyHelMvM+uElCxidfg6CNAVXh378RNtxcPKk7oh2whchg3B0kdFRd1/MbhGmmrldOezXhaOBbKSOm8+dMqImgPvVNjRWpQthg4G9J4VSAZIyYsdtroC2NjXEkG27nz9UHAgCEsPQBJLVJfSWIw2ZPHQDcycR8qrgHlv3lHDdZbg6163MYvhfjKadxJPq/j9A/efk4Zd23DFWjcdmQ/N+QYwqiaB5jZUO2livPhi616WqLInLCJfTNrrkHPUafZeqaJ2ZCovnxNx+CQCAHLw4WR/EJub+kpWHtwQDl0eaW+NLytANLYpTXx4MPF24GT5O1HVMTcY03X4FfAvpn1Uo4Hm75gya7KMNZv72A7Z94RIdNyqr80PHUFiajDSemDpb3MVGSaCFfrm52HhtvZNEXKf93e/dI5G6fXc0JLOjIaO91Hx6VG5KKsHu+4h1yyO0A/tNg2ecQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(38100700002)(83380400001)(6506007)(82960400001)(55236004)(53546011)(122000001)(110136005)(186003)(54906003)(7696005)(52536014)(8936002)(5660300002)(26005)(66556008)(66946007)(76116006)(2906002)(66476007)(9686003)(316002)(66446008)(64756008)(8676002)(4326008)(33656002)(55016003)(86362001)(508600001)(71200400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jHMkdc/l4HpzmB16tgvjBmimb37xYTOaMba/yoNhq3q6zMrmr+ZZN0FLAx9c?=
 =?us-ascii?Q?fq26ysXZ7kYu6APGK9F7daxueVap1ncMJt9zkGE5A8OTjt0Hrh3mEWSQDFYk?=
 =?us-ascii?Q?ZU8tM3SM10p9/XuF/5UK955BR+BTbKG0IKN5hBP8HNvOV/YDQ9hy8He2js0u?=
 =?us-ascii?Q?dnObz5fmlC3uX+fk5MwD5WJrKk7htAm+PLmoWBqWvGfOoY6U0+mbM4q53NUE?=
 =?us-ascii?Q?kg9YwiHNgpddueotgsb96eLLs4UICfRQ6PPkVLhI51vKr7bXed2jJMTqa8uA?=
 =?us-ascii?Q?AgJf9ic1Wsk5MlwNw/oe30XlXJTileEpCBX+IHo88r78vaWKKSp/iZGrxVQM?=
 =?us-ascii?Q?GAw/JupJG1nV8nP8KQlZUywx+eOfeWkDeEv8D3zQ5tvYtZ0d+JW9XVSsic0D?=
 =?us-ascii?Q?WpHFbJ+QhF/TL8p83ZTPCkkkfYeeYlDZQFmn+57SUX7nNy3Ikum80UWa7Vwj?=
 =?us-ascii?Q?gzy4EmEj5QF6+jJg5smpzN8Cq2FirAJyrZrOuaSzupI+/BhENP/nkbpmMvGi?=
 =?us-ascii?Q?o3aMm4fJWc8RlzHpelMflkWAgLE1lBE391CnXIgaGvjHMSSVmQltbeLIUJSr?=
 =?us-ascii?Q?xpS9TQlkgHe0YdNF97GkUfzaYQ7fWVuYC4Fgqs65JCJUuPE6iNGQ1i7RoDCQ?=
 =?us-ascii?Q?EX8x5NxfdQx7zH4tR+jV5zJvpLWf84Ti/6VPqdc89YZziDRK8r+D3pXSbRQp?=
 =?us-ascii?Q?t3T+aeq6hJi36BfRc4rZN+EIBJpvIteM92mAQ56Wb4hmieGyLOcGlBjFcn5H?=
 =?us-ascii?Q?3eEVAT4IEUtTf1310LErUVaCsletpbhZRXL6SK2VTe3ZxkpmxSzz1fdcDL6O?=
 =?us-ascii?Q?6CYzXzcjCy+olQaqgk32z9MiZbYHRYqxBNQY6yy2RSPXVa8Uo1X7/ChKFOyG?=
 =?us-ascii?Q?XuwXulfYK6D/Ga53WiBh2a8RotHYIywiPuFsM7GFDyLXXWm14hUn4mgm2uXh?=
 =?us-ascii?Q?vMzc82XLDlUof1mneNltaZNy8gwofrLwwYNjiooh2l7UjLlpWdmG9vSmuElk?=
 =?us-ascii?Q?OYOyA9G8C8bvscLkSK/xeMMdT6azyUZUt4ketowo1nEHBxdm/xcffmR3URNi?=
 =?us-ascii?Q?ECoaRcWohdq/xorRVG41CzaUtvE71f7vmoKfC1Gu5cZpg29L835LHTm+NNAo?=
 =?us-ascii?Q?8+e00Sdym8deXZKGwjFUYxff1OEV4n5+mI2ZpdMrYMfiT3hO4E/w1aqv0HIR?=
 =?us-ascii?Q?980yqguqUuxBUPOl9oz8+eRcE2j1ScsMJ8xYcOG1XzzTlhepCUmOkcWzxKmm?=
 =?us-ascii?Q?IT5vyWhs1ZJIOOXFTNZyTpKXV3tI+ZunQFjKVtHEzuE3CNU8ZWeB7rkGeR72?=
 =?us-ascii?Q?GJ3mJjOHyCGzkZt/HGTfi+Den2YkMN0TRGNs7c5LusKb+pxlzpwr8lBjtlOF?=
 =?us-ascii?Q?b8RaOobR6OjutkK3GL5k+5WwXpkj5+fnlg/7PoRi70Qt72G1heMTmsb4nAj4?=
 =?us-ascii?Q?Dy/g930dayoVlfET+G+GwxiutqXEDlu4jfJsM9eu70pQzIkSZOeC3ry9DCGK?=
 =?us-ascii?Q?z75hZ4SJbpb4Xap1vkKKfwLhdZ2D94//hBQZweiGRariR0kBCqCRZHrS1ryM?=
 =?us-ascii?Q?ue43oXo8ZQj0AfW21lePckfd0mXs7TIz3O6KZOu3cKaWwLAojHYK4w2Hc86B?=
 =?us-ascii?Q?YVNjVITcAIC9jWs3ZAcUppxdx9vPepeQGfCWZ9lkb4c3rV8gih6kbaBlZIuW?=
 =?us-ascii?Q?W/SoxjlkHDMSyZlvHTHWq4Y+fLNoGmOL4flw7Xjrw48saeQmKiV6qf+fP5MA?=
 =?us-ascii?Q?nQPpF+wCQw=3D=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 7017f1e8-23a5-42e4-2974-08da33491f75
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 May 2022 12:23:57.9123
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sZir2iRD18CtQ+Fb5eZSP3IbUFqVpA4QVoirStLol/H99IHJNojnXh/RxW6WsFw3QVRMip837cdcB3UPhyK0Vw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1720
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: KZs8ToWric66CRe6IQAWPcBvsTqL-MIm
X-Proofpoint-ORIG-GUID: KZs8ToWric66CRe6IQAWPcBvsTqL-MIm
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-11_03,2022-05-11_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 adultscore=0
 priorityscore=1501 suspectscore=0 mlxlogscore=900 phishscore=0 bulkscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2205110057
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 03:01:26PM +0200, Arnd Bergmann wrote:
> > On Tue, May 10, 2022 at 1:53 PM Verdun, Jean-Marie <verdun@hpe.com> wro=
te:
> > >
> > > Hi Arnd,
> > >
> > > >    Hi Nick,
> > >
> > > >    This seems a bit more complex than necessary. Can't you just use=
 a custom
> > > >    inline asm with an ex_table entry to catch the fault? Have a loo=
k at
> > > >    __get_user_asm() for an example.
> > > >
> > > >           Arnd
> > >
> > > We got inspired from debug_reg_hook within the same source file (=20
> > >./arch/arm/kernel/hw_breakpoint.c ). We chose that path to keep=20
> > >coherency  within the source code. We can implement the same fix by=20
> > >using an ex_table  entry, but this will create two different ways at=20
> > >catching unknown instruction  within the same source file. Will that b=
e ok ?
> >=20
> > I got a little lost trying to find where the breakpoint instruction=20
> > comes from that gets trapped here, but I would guess that they had to=20
> > do this using an undef_hook because the ex_table approach does not=20
> > work there for some reason.
> >=20
> > I would still pick the ex_table method here if that works.

> IIRC, the ex_table handlers are called only for data aborts and are inten=
ded to be used to handle cases where we take a fault on a memory access (e.=
g.
translation fault). In this case, we're taking an undefined instruction exc=
eption on a cp14 access and so the undef_hook is the right thing to use.

Hello Arnd,

Given Will's input would you like me to still use the ex_table method?

Thanks,

-Nick Hawkins
