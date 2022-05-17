Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E1E529E85
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 11:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244743AbiEQJyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 05:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230185AbiEQJyI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 05:54:08 -0400
Received: from esa17.fujitsucc.c3s2.iphmx.com (esa17.fujitsucc.c3s2.iphmx.com [216.71.158.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42F473388D;
        Tue, 17 May 2022 02:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=fujitsu.com; i=@fujitsu.com; q=dns/txt; s=fj1;
  t=1652781246; x=1684317246;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=NSRX2Nlm9Y3LY15tyVTXm4JKBIANLNd5Dm/XFLreW/o=;
  b=QIHDsMtfTLswYHtHDuc4qfL5P6Nf8HIKgInsEStaEg/v7p/ZmVeWzoyB
   MkKnvtDNjtrkeS0HzbL5CrgFOs6jSloElXCvj5xai2FeJOIVTrWyQ10Sb
   P7aDJRhog7gneqAkr5xkSGNbYuXND8Jn8wBKHG4I5/1xkwkX+Q6C24a41
   0FDzo7SkklVCMdRi+rS376Rf1DKZz5vEUlo67DxYgfwXu9qeNLEOcryHu
   CZHBKjArfvQStFB8JIlhIpllwpU1LztAfH+kIBdv2dLE+YaK5DMlta+BB
   pSxkRCuwRbk5N9Rgg2fBXsbvn2YWGdD/fDNIZ0BQEjbf8tcWmxL2BB+X9
   Q==;
X-IronPort-AV: E=McAfee;i="6400,9594,10349"; a="55967371"
X-IronPort-AV: E=Sophos;i="5.91,232,1647270000"; 
   d="scan'208";a="55967371"
Received: from mail-tycjpn01lp2173.outbound.protection.outlook.com (HELO JPN01-TYC-obe.outbound.protection.outlook.com) ([104.47.23.173])
  by ob1.fujitsucc.c3s2.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2022 18:54:00 +0900
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iyoiQ+ZVMFW7u9GkpktbhACGKD1lrhhd+iz+8wdH53sZ48jiiK/N3t+OwwmRlhoPu6Z9bUnz5EFjBs2NMVyGIwRNKBHBTjoM/FUcOTUm6GnXfck3Xs9drDoR7dIEO5NbALv5A7T0jhqbxFoUucHyVY0wsMBeGW7AycnD3o8ipX+TB0sgIvHtnHH2jTHOfuNYdaoabEsWjDnFrHHb9ZUGdehkyenRM0Uiazo/NPOT7HW68VA8rvW76Em7zBXT7RyTi1jMmDCPS1llenuwgsfQqws6ACACRRQdfcjZuLXVQcba4YsRevcnGGHebsbRtIoddb5eZEa1Pin9x2fmHvl1qQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=3wQ0iOb9KN37dHLS8uQLqvgQEnfuAqCaKWoF5LAT9JM=;
 b=UBHfKNc0y0q1Pgtvx74B3bjZkJh9pCOqeoHVPZtmru4YOPJW/X/HEsbVilfxx3lp/J0DH4Znh8az+HeVlC+zGyhVD2QuwvSbyTR4OvNcEoXdKnUuI8Ll9Pp+vc/BbCZN1pbEOc5qmnUVdVc9F8idTrwTT7j/Wj3e+bVf8A6g/7pX2ozure5+DVs2stk3BMaBSszhAl2Es6pveapjI/94oaoC7RTRJ6n/LXv7Ejmzs9DGGlGEYHqpSPBB8zNp4LCXK29z0UzJbbyT5dormfTi2bBGver+tDzZMeq+ni2uykjjzT55K0n7ggQWeRJwuLDnWeQOhoSbJ/NoF4lAHn7SUg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=fujitsu.com; dmarc=pass action=none header.from=fujitsu.com;
 dkim=pass header.d=fujitsu.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=fujitsu.onmicrosoft.com; s=selector2-fujitsu-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=3wQ0iOb9KN37dHLS8uQLqvgQEnfuAqCaKWoF5LAT9JM=;
 b=YmMa4/f+lc4SUQaz3MGGhEr5Z5eNrDi/arwryGbugx2wR2Ddga4GAStlmFUDpy8bNHAUNPSpSzlR8ieXayRJ/36ooll/vGgKfu6ynUgW4L6IfHyCLtXmjqqbdNhDWlOniZ9gyJlGpfuxbFRAopstYABTOf6mOFBxUxXhdwJgP6w=
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com (2603:1096:604:13e::5)
 by TYCPR01MB10246.jpnprd01.prod.outlook.com (2603:1096:400:1ef::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5250.13; Tue, 17 May
 2022 09:53:57 +0000
Received: from OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::9d45:c509:9a59:4892]) by OSZPR01MB7050.jpnprd01.prod.outlook.com
 ([fe80::9d45:c509:9a59:4892%8]) with mapi id 15.20.5250.018; Tue, 17 May 2022
 09:53:57 +0000
From:   "hasegawa-hitomi@fujitsu.com" <hasegawa-hitomi@fujitsu.com>
To:     Jiri Slaby <jirislaby@kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>, "olof@lixom.net" <olof@lixom.net>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will@kernel.org" <will@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "jason.wessel@windriver.com" <jason.wessel@windriver.com>,
        "daniel.thompson@linaro.org" <daniel.thompson@linaro.org>,
        "dianders@chromium.org" <dianders@chromium.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kgdb-bugreport@lists.sourceforge.net" 
        <kgdb-bugreport@lists.sourceforge.net>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "sumit.garg@linaro.org" <sumit.garg@linaro.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "soc@kernel.org" <soc@kernel.org>
Subject: Re: [PATCH v4 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Topic: [PATCH v4 1/1] soc: fujitsu: Add A64FX diagnostic interrupt
 driver
Thread-Index: AQHYZP9hMqXNlfDlg0S66tEsssG4aK0ZPBEAgAmesoU=
Date:   Tue, 17 May 2022 09:53:57 +0000
Message-ID: <OSZPR01MB7050C926426AF82B7ADE86B8EBCE9@OSZPR01MB7050.jpnprd01.prod.outlook.com>
References: <20220511062113.2645747-1-hasegawa-hitomi@fujitsu.com>
 <20220511062113.2645747-2-hasegawa-hitomi@fujitsu.com>
 <48cfa0b3-0424-81bd-ac6a-d631184b71b7@kernel.org>
In-Reply-To: <48cfa0b3-0424-81bd-ac6a-d631184b71b7@kernel.org>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Enabled=True;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SiteId=a19f121d-81e1-4858-a9d8-736e267fd4c7;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_SetDate=2022-05-17T09:53:57.183Z;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Name=FUJITSU-RESTRICTED;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_ContentBits=0;MSIP_Label_a7295cc1-d279-42ac-ab4d-3b0f4fece050_Method=Standard;
suggested_attachment_session_id: 331c61bf-92aa-0400-1afe-86b46ec5a034
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=fujitsu.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a8d69f60-664c-4ccd-b76a-08da37eb294c
x-ms-traffictypediagnostic: TYCPR01MB10246:EE_
x-microsoft-antispam-prvs: <TYCPR01MB1024602B65761DCDB1257B924EBCE9@TYCPR01MB10246.jpnprd01.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3X+nf0TkFeDYB+rbP6lcpf4VUK7EopKqd0QodoSObXOoUv814i/WKEfIHmnnsQldK4+cYIVU+LDzH+rk4W05Z3CvE5dgZhUl462y56wgYZwgwJiIFPeZ6OsRKwiXWC3L/z1p/efYMzIgKKOH3dtK6veo++Fi6le/HLhsG34SK0l5tcfNmvNXqXvIIZL4t6QXRu7yeWBhdUNrV/ZFX6bvSdCuR4cjwIlS/hd7fcD4f+XlXgfIcf5Zim5D3o+QOeX0smMHVzUHb7tDRFymx1yN0SFzU7b7+wTHlfJ4UX1BbdQJnWxg1x85ktbP7OIr6NIhTNNh/qWzOexCtSzi3luDj8Xt2zP2NDeFYhlFY+g6egxwVGc9MdPF1+4nycoFvmGC4abJbxKU2dHUbyIghpMwDHjdGjs9iwI8VYUdKUAzBmnpZjc7TcoRegjy6OZe7BSmNalPPw1MRhUaBTJ6W2kWwR2n2PF9XJYBhn3wS5miiGKjuqwfGyWLM6l4k9aKl9FLP2QO+offs1FkEFgsnkXVMSusIWCm4kg1FsWvjJBBkfO8rvAT4LYqxtf0ct8jOCF+6kKfkIt5YyQwM0xiegifdXzssmnViewGX+LK0dVSNdUToJrZBfMxh48i2UgO+3t/VEZoW0rZOIEsY8s330nBM2FGG8qB+qlqTbcNbC4Fl/Hbe6V/c7L45WJ8pFMvRnfIsg7616prCqfinxGHHMLWTA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:OSZPR01MB7050.jpnprd01.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(4326008)(76116006)(86362001)(71200400001)(38100700002)(5660300002)(7696005)(66476007)(508600001)(66446008)(66556008)(66946007)(38070700005)(64756008)(55016003)(82960400001)(8676002)(83380400001)(316002)(85182001)(52536014)(54906003)(8936002)(186003)(6916009)(122000001)(6506007)(9686003)(33656002)(7416002)(2906002)(26005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?aVBDLzF4T2c3TTByUG44TFVMeDdOZDNqTmVLaEVFOFNWbHJqaWk4TzE2?=
 =?iso-2022-jp?B?K2l4KzVqVHFGQ0trblVmMU04MCttRStYYVR5MWhYMkRpOVkreUU1Z2Vq?=
 =?iso-2022-jp?B?ZndQRXBPYVN3OWRPM3ZPSGtrV2VVaGp0R2FxYVM4ZHVXRDFPaDNXVCtC?=
 =?iso-2022-jp?B?Wk94UTNoMTFISFcwTkJ5OWVaV29Ic2wzMS9ERGVZTUhpeC93Y1VWY1pn?=
 =?iso-2022-jp?B?aC84aVhhWjduR3pPOERGMmR4NktBL1gvRXFaR1hDbjVkTFRRalkxRmdm?=
 =?iso-2022-jp?B?M3NkSjVwY2dadU9KTXA0NzhFcDZUM2x2OUFUVERHenI4NDdBNWdSVDl0?=
 =?iso-2022-jp?B?alFvQ0pjNzQ2UDEvT3NQZzVPNHhzZGQ5U2ZiT1UvRU5OV2NVbzdpN0di?=
 =?iso-2022-jp?B?U1pLbGFlS2VFZDhDRUhKN2t2dmNkTUViN3M4RGwveDVHeHVUeGxpYTR6?=
 =?iso-2022-jp?B?Y2dhVWNhUFJGNSs1M0d5UUFVbHdobjh0d0IwTzNTdDF1NGhyQnlWOGd3?=
 =?iso-2022-jp?B?OW0wLzRIVm05M2xpTEhyYWZsUUwzRVZEbVg5RnpSRlRWQjlMSXBvYThS?=
 =?iso-2022-jp?B?WkZRS0k5MDlIRktETXJVaHN0b2I4L3JTa044SEFZdWpGZmpuUVdiSkd2?=
 =?iso-2022-jp?B?ZWU4d1lpMm1SVWZTY1NHZlJOcktZZjFCL01oVm1pOWVySWRJUSthclNp?=
 =?iso-2022-jp?B?NDRVTVF1bmlrR2FLelF1Ti9wbWY4MlQ5ZTBBb3hsR3ZPVkttcDMrNjI0?=
 =?iso-2022-jp?B?c3V0OUxIZTY5d1FnaXdPM2NkQ2xZeDhoYzdveWY5S0FGSEFtaE8ycE9B?=
 =?iso-2022-jp?B?UjV0N2gxdCtDZTJuSytOSE03cWQ1WXB1WUQ2eDMvY2crUk9KQTBIUzNC?=
 =?iso-2022-jp?B?eHZ1SGt6QkhuSkpJSFVpMmVNaVBmRy92Zms5cVJoQ1ErSHBvQWtBY09r?=
 =?iso-2022-jp?B?TVQ5akYvaVgyanJPaGZuWTdFVEVwQmhFKzF0M1NmNFJqQm9MVGk2emYw?=
 =?iso-2022-jp?B?YlRIak5kNnhNbHZLOXdXL1lwUS9Yc1BoMXpZNWZyajdlODVZVk5WSEsv?=
 =?iso-2022-jp?B?YnIxRmpkdjA3WWlUR2ZTejYrWHlYSU9qOERrN2ErUUtjNTJ4bENDTmQ5?=
 =?iso-2022-jp?B?MWlqMGR6NkloOG8rRXI2N1FWdDJoL3d4ektUZVRqYzZhVmxWcUlvS1JB?=
 =?iso-2022-jp?B?L1NIT002SVV4R1QzN2U0UUdUa2k4bU10OGx0akwwVVEzNjJOSE9NOWJX?=
 =?iso-2022-jp?B?Vzd2b3cxZzE3OE0zQmNyaGJUMTZQRUhybFI5aElibVFRNEQ4czBERkNO?=
 =?iso-2022-jp?B?bmYzT3E5dE85SmoyQW12WVNlWHdqWE9FbmZZU3VCeFBTbXJPSG9tandY?=
 =?iso-2022-jp?B?ays3RFBrVi9yeEdEaWsrUC9lMTFqaDVjS3NpRnM3ZHBnTzczQlkxdjl6?=
 =?iso-2022-jp?B?UCtQQjJ4QmppVlNWUTFoY3BLbFZNUlI3SWY4eWpZbmhFL2ozMUpiTWlt?=
 =?iso-2022-jp?B?QjR5aklndkdEUnZjMTh0Vm83bDRsSHpiUWFRanBpNEZBb2FyQ3I1NTRE?=
 =?iso-2022-jp?B?amN0UHFSTytvQ010Z1hEUGowbUNKSVNyaWJwY3VtTlFZYzJ4b0NNSEtl?=
 =?iso-2022-jp?B?R0xSenBOMjNJMXdCSU1hZnVsdFQvSVk0NTdXSVVMRlp0eU9SaTllWVgy?=
 =?iso-2022-jp?B?N2NTNytOaTdyOURPdXkySDFrc3FWYzhQRzdnYzhjWHNIRlN3b2x0WUNz?=
 =?iso-2022-jp?B?UDAzMEVNcjc1NWZzRHhWV3hudVlCeGM2YmMwejA2c2dPODRaamNBeS85?=
 =?iso-2022-jp?B?VmpmR3RzMW5PLzhNdTRlVkk5RGo5cUtSblczd25pUzAvZ1J4UjMvRkJD?=
 =?iso-2022-jp?B?VjR2anpqcXlpNmNiUGR4S29vWmpEdVA1bWdaekNoYnBkWG1UWG0yZ255?=
 =?iso-2022-jp?B?K0s2NDFvVlVzUHphTWF1NkxxU1E5SE90RnA0QVlVc2ptUHR4bzRYejR2?=
 =?iso-2022-jp?B?eG81WWZhV3NINnc3cUVTOFl3NHYrUTBTNWQyZlZnMmdLdzVXWUs2YjhF?=
 =?iso-2022-jp?B?ZjN0ZTJxR2dzTktwbkNrQkZxdkNqazBwaVZyOTFMTWx6dzZ3Mys4Nzg1?=
 =?iso-2022-jp?B?amVORzVsRkRrVE5YeDZ1Um5vTjhFSTc1RTVNVUlHWjdyL3JlcUhrZFhm?=
 =?iso-2022-jp?B?WW9RK24vcVN5Yi9XcDBaNk5LU2dBV09BZzNJeXF6OHYyUHNjSTJONjlK?=
 =?iso-2022-jp?B?LzFYZldCTnc0eWVJeWswS0VxeGdNY3lFRFdJQ2piTXdIeHRZeG5ydmFz?=
 =?iso-2022-jp?B?OFUxR3JnekZ1K0VQWVYvbHVCYjliZnJCMmtLVXNGQXpKbmxmZVpZcHkx?=
 =?iso-2022-jp?B?UFRaQTRUTWNPRU8rdS9na1BhT0NJRXhZOWN3WGhselhXSDRUS1ZUc2RH?=
 =?iso-2022-jp?B?ZVVQcnhJSDI1VDN2alRpTmZUTlZ6NDNLOTJwLzM4QmswNHJvMktzM25U?=
 =?iso-2022-jp?B?czR5ZitVaE94dkRQZkhBS2tuOUtJZVFzMXRqSVFkR3lPbTN1b3I4MWtv?=
 =?iso-2022-jp?B?azc0WVRVQT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: fujitsu.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: OSZPR01MB7050.jpnprd01.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a8d69f60-664c-4ccd-b76a-08da37eb294c
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 May 2022 09:53:57.5613
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: a19f121d-81e1-4858-a9d8-736e267fd4c7
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qTTfKPupicAHTrqaipZppurlJvzpUSx/uz5VEpbutU71jMphz8BBL2GVmUz9AznyDRubUz3jJX/LRZTDTcEKnF8VGaftNgMcPc500fLzL6o=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCPR01MB10246
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiri,=0A=
=0A=
=0A=
> I'm not sure why you cc linux-serial, but anyway, comments below :).=0A=
=0A=
I used sysrq until the last version, so I still included kernel-serial in=
=0A=
the destination. I am not planning to use sysrq now, so I will remove it=0A=
from the destination from the next version.=0A=
Thank you for your comment.=0A=
=0A=
=0A=
> > +struct a64fx_diag_priv {=0A=
> > +	int irq;=0A=
> > +	void __iomem *mmsc_reg_base;=0A=
> > +	bool has_nmi;=0A=
> =0A=
> There are unnecessary holes in the struct. If you reorder it, you drop so=
me=0A=
> alignment. Like: pointer, int, bool.=0A=
=0A=
> > +	u32 mmsc;=0A=
> > +	void __iomem *diag_status_reg_addr;=0A=
> =0A=
> I'm not sure what soc/ maintainers prefer, but inverted xmas tree would l=
ook/read=0A=
> better.=0A=
=0A=
> > +	priv =3D devm_kzalloc(dev, sizeof(struct a64fx_diag_priv),=0A=
> > +GFP_KERNEL);=0A=
> =0A=
> Don't we prefer sizeof(*priv)?=0A=
=0A=
> > +		ret =3D request_irq(priv->irq, &a64fx_diag_handler_irq,=0A=
> > +				irq_flags, "a64fx_diag_irq", NULL);=0A=
> > +		if (ret) {=0A=
> > +			dev_err(dev, "cannot register IRQ %d\n", ret);=0A=
> =0A=
> No a64fx_diag_interrupt_disable()?=0A=
=0A=
> > +		priv->has_nmi =3D false;=0A=
> =0A=
> No need to set zeroed priv member to zero.=0A=
=0A=
I understand. I will fix it as per your comment. Thank you.=0A=
=0A=
=0A=
> > +		enable_nmi(priv->irq);=0A=
> =0A=
> Provided the above, I don't immediatelly see, what's the purpose of=0A=
> IRQF_NO_AUTOEN then?=0A=
=0A=
It seems that request_nmi() requires IRQF_NO_AUTOEN.=0A=
=0A=
=0A=
> > +static int __exit a64fx_diag_remove(struct platform_device *pdev)=0A=
> =0A=
> Is __exit appropriate here at all -- I doubt that.=0A=
=0A=
I will remove __exit as it seems unnecessary as you suggested.=0A=
=0A=
Also, I will correct BMC_DIAG_INTERRUPT_STATUS_OFFSET=0A=
and BMC_DIAG_INTERRUPT_ENABLE_OFFSET.=0A=
=0A=
=0A=
Thank you.=0A=
Hitomi Hasegawa =
