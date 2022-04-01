Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34F394EF7FF
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 18:32:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231842AbiDAQe2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 12:34:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350410AbiDAQdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 12:33:36 -0400
Received: from mx0b-002e3701.pphosted.com (mx0b-002e3701.pphosted.com [148.163.143.35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A66F1DD3F3;
        Fri,  1 Apr 2022 09:06:32 -0700 (PDT)
Received: from pps.filterd (m0134424.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231G57Zg011078;
        Fri, 1 Apr 2022 16:05:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=fThyDFb+b2ERfCQ9pvQKhPqGHGIaH0hBICL3n9sMBDI=;
 b=PCAJ6ZMHtIPTTH1n6h00c4vR1aUX/PRutwNSTXw3JNsLrupxWN/9jS0QUOyTq9bjiZ4H
 YwHUBZfRro2yccUwggycNNnXaRt7TgYQjwLCNouti7tww2Vjl0GF5KMw6Zu9q8qNW755
 ZMLotD5uU4O1fbslPzpHqj/J2xSLN/JLea9pD06hXlPbNPrO4HUBAmbaUgTKONU3ph+X
 6AkH+AOlTHj7BAGG+rM7aaLoT88QW7SiIPIAqsaQ0nJ4V6j4c6Ffj/3/ot8yq5twnUmp
 F6MxJroGWzvTcwHAauZhUzVmi6nyzNPGevH+UC7cwKt0naxlmWBJ+XQv9AzJTP+sqgGN Fw== 
Received: from p1lg14880.it.hpe.com (p1lg14880.it.hpe.com [16.230.97.201])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3f63fd0nf4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 16:05:28 +0000
Received: from p1wg14926.americas.hpqcorp.net (unknown [10.119.18.115])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14880.it.hpe.com (Postfix) with ESMTPS id 980CF8003A1;
        Fri,  1 Apr 2022 16:05:27 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14926.americas.hpqcorp.net (10.119.18.115) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 1 Apr 2022 04:05:27 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 1 Apr 2022 04:05:26 -1200
Received: from p1wg14921.americas.hpqcorp.net (16.230.19.124) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Fri, 1 Apr 2022 04:05:26 -1200
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.124) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Fri, 1 Apr 2022 04:05:26 -1200
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkD69UNJdo4pEEVEdaMrBlBqi6vORNfx8ggvSQ4cRkL2rJoJ0HC6EaoxgBGUWTpghD1eR7a6vfijqDnm5bkueIXK/xyEegfmMN6RIMR+h2eQGGtqgcxXaqb7BstUSEDHjJ5BpdQGYiXjjSt+7Y06pBv5MJAzpOtL82FkVvSSSXwEER6SbpLTlkrqeEOHf0XzlWIx+LJ2GIV8KS5yJgd4oR1LTkTjGynO2xkyH9Ix5NyYON0nhVxLODXAvVNau4+grO3mNEeJTUM/gYPe3kBUAD42gIHec1WrYCGyh80Y92zSdQ5qmuHfI38NzQ6k6n7X3L4a77MUC0r6RQ0SISYIHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fThyDFb+b2ERfCQ9pvQKhPqGHGIaH0hBICL3n9sMBDI=;
 b=G1ZEwpDe2ksR4NZva21ZXcnwymSdbs86FDF2H+RI5B119lIXmPd2llZ/vNf5XfxyWD7QgaM9D0zAecj4wWqp6lzeg4Fi2gUryaoeKomkSQwFuB1xm0AkyezeYCelqo1wdOT1FEpC9RXRvUlRXPHOR9WDHY0Bw43Dlg2JDeZgwpApJw5DTaIEekqeW/CyJYYUqEZxqdDkCMNMxYDSrLe4CiIbK1QThjOATSfTm2DIuRu3UCZYpnRMZlnfu8Av/YDNAVsdWfSOUXCH6PDxH6Z7LpQr23wALoMC7D1qgJbjSFS6W3OVX8lMUsGwUykcDcgMB0M87vvLr6GvLPdC1rKx3A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by MW5PR84MB1425.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:303:1ab::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.21; Fri, 1 Apr
 2022 16:05:25 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::bd27:815e:7c03:d1e4%7]) with mapi id 15.20.5102.022; Fri, 1 Apr 2022
 16:05:25 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        Olof Johansson <olof@lixom.net>,
        "soc@kernel.org" <soc@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Topic: [PATCH v3 09/10] arch: arm: boot: dts: Introduce HPE GXP Device
 tree
Thread-Index: AQHYNLgx692NqDgvU0iOWKp+QCe0Uqy5/HOAgAgo3qCAAAx5AIAAD3gwgAEJmYCAE5R/wIAAGtkAgAAFszCAAZ7G8IAAu8qAgAC9QRCAABI1gIABMDvg
Date:   Fri, 1 Apr 2022 16:05:25 +0000
Message-ID: <PH0PR84MB17182115D57EF6032782659C88E09@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220310195229.109477-1-nick.hawkins@hpe.com>
 <20220310195229.109477-9-nick.hawkins@hpe.com>
 <eb66cc83-2da9-8e19-db69-633e34fef946@canonical.com>
 <PH0PR84MB1718C31DB71AA2A67FEC5F6E88119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <b1cc2566-cd78-7cb4-f8a5-d6fc8065fe6e@canonical.com>
 <PH0PR84MB1718292B1C11F4FE83326A5388119@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <fb4def96-4b20-604f-d15d-fef87eb2232d@canonical.com>
 <PH0PR84MB1718A2CFBFC90C9C0CAA5515881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a0fCE_NM=z68d1m9BTfuKixh1pKLw3gn+Sr7SxKb6UJAg@mail.gmail.com>
 <PH0PR84MB17181C316E55073EBC28C386881E9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <PH0PR84MB17185ADBA824F9CC9EB3E022881F9@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a1080yz9jggOrwz2iQ1sAB2Xe2Emh22uCuqRok60BQSiA@mail.gmail.com>
 <PH0PR84MB17186189F5025374AA39584D88E19@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
 <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
In-Reply-To: <CAK8P3a2b+ESAAkc=_2hqx0kOxwYVS6mNjMGBKhhipaSj_5jV9g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f380fd1f-ea47-465c-9e30-08da13f96eb8
x-ms-traffictypediagnostic: MW5PR84MB1425:EE_
x-microsoft-antispam-prvs: <MW5PR84MB1425E5703C585801CD937BD688E09@MW5PR84MB1425.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: mSaOGXHWhcVfRcowjYmZLtpXWlZ/mCDO16ipEPTtvYuMpURTbDxw9wejI2Of8dwn7jLZEQbkRgj1O8eOsy7jXy3DaiDQQ+qMKMzgIJ6HPcE2tBDHhHkX3PDhHfcSclrcPbvyqCCK8M8kCD46gMPRZG99cs2+rQdYzKMoo9CBeN9A3pTvz+lrSvVlIOWmJLRqHXyx8JZfEfQw1ssPJLE3njvbEB5C029eWJSo2BT1fbElsBpo+Q4Nz8TaCAty4axskf1fH2VoYINicFJ9QbksmZIPAcaBCQBlmkPNlGYdOrXCAtLOnj7XfKLEGhK5+8zR1HLuCqmmCrDgpVGZHG9D12ltHlZiXAtKHxELE1OqBFf4iTNZIMdsQqN5Lzkrfy1u+8bsQCsBGsCxDJVztLR4Crjc/8Sm50RHc15aTVGXz8D04ns/00qcA/e4VFejWJI0iikdHKEIeiajhB8DQnDeS/N682+VDWwbqF/7EZnbdUd6vjy3AxtuHvFDAd9Sr+CapLiGWqhWKutqyQq1qu6HHrUjRMnB+suHEEigKt9+itTpeJ0e+y8bCLG075dg6TVtF+T4GAoScMZOR5amMBE4UnXd66/gN9ptACEi+k34PcoWcy2BGhj4pq5nwS7Oie5L+md4spCtbbrasgmDraQpMNUbcG6ipob1BtHrDtVpNwdW+0oG3m5OFsF1/Nf/Ft0JLt4OW+n4biDWxTZsZRgLgQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(186003)(26005)(508600001)(2906002)(8936002)(55016003)(71200400001)(52536014)(54906003)(6916009)(38070700005)(122000001)(66946007)(66556008)(38100700002)(66476007)(76116006)(82960400001)(33656002)(53546011)(86362001)(6506007)(8676002)(9686003)(55236004)(316002)(66446008)(4326008)(64756008)(7696005)(83380400001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?aDZOZ25rS1EycklYL0pZMnVWb3Q3M1lCdlFrV0NVVE9oKzBuWUpiTko1WXdy?=
 =?utf-8?B?bVFsN09JWEpEMmtXVUk0WFBObVhzek5yUTRlOW1pa2NEWWdCTk1oWkZnL04v?=
 =?utf-8?B?cHNnQ08wRUZkUjlnMEl4bTRySktzcS9uM1dMWFViMlh6ZEZJdVlaWFZ2Vm1R?=
 =?utf-8?B?akJYSnh1emUreDliSzhUWFpUNG9Cd0RqRG8wVDNianVFa0xsRXBaNGtDOTJT?=
 =?utf-8?B?cHh1Qlo3VzBIamdNNXRlbXRiNVlDL0tKOCtXNDk0NnNNbzhCZmFZcnArL0pv?=
 =?utf-8?B?OHlVeGZTQVE4aFdLU2g1UnlhVWZhSXJmcXp2bjRWKzhqTDhyYW9nTDk1NTZZ?=
 =?utf-8?B?RmdDM3JRUHVPcVlUNnNPeWlpSWZVZnRnU3ZlSDFCTUtHZnlybWVRMnU5NG05?=
 =?utf-8?B?bDRxTEY2bCtOUVZzbkMvZFhRSnEySkQ0U3RqOUt3eUJGai8zUVlkK2t2Q3lj?=
 =?utf-8?B?dm5XbTZUaUZYTzdtZVAzR0VWUHc1QUJEdmxHWmRUYnRJdVdVZW5kRGlJN0FD?=
 =?utf-8?B?VnJJc2RmRmJWYzd0TEY5bmJaUzZoTmxVZFdXbXZCVGk0aGhmKzNwMnVtSlFs?=
 =?utf-8?B?M0dRZGloOHJtMzc1VElOU3ZiTXlMcDJQdVJkZXAzR2ZRVUtzUzArWGJaVHM2?=
 =?utf-8?B?OFM1N05taC9ubGNZYzhSVSsrdlFGSDRhVGtvWEhZVjRDRzFQanhBQW9DeXhp?=
 =?utf-8?B?dDJtTkRSQjFaS3NpYllGRm5UbnBHM21SVDBSWWd4blNtM3lwV0ZRRndna3hW?=
 =?utf-8?B?dW9VaUhBZm9CUmlwS1BncnJEV01kVUJDdHFaOUFpb0hOVHdUT2EvNWcyNVNt?=
 =?utf-8?B?MDV6NTV0OWYzR0xDLzNidFpSczM4M2VKbDAxbFRWMlJ4L0N3Y3hsUlJSNm5r?=
 =?utf-8?B?Sy9OMDNmMnVEZ3Q0L2dDVG9FeFBSNlZjbmVqMk52dFlhZkp2OW1JTnR1ZlRq?=
 =?utf-8?B?M01lWDlhRzh6K3lMeEVPem1KdEErU3JEUCtFSmVlcUxRY2cvajBHd0VXZXlI?=
 =?utf-8?B?WWRyUElwek93ZzRiU1BYWGdOM2lWZzFmaGhnem1GT3Q0TUsrNnA1WGU5RFBB?=
 =?utf-8?B?Y1JOZHRtSFVjZTlPQm95aXB2aHZLU0w2c0Nhblk4cGxlQVBRVG95QzZCYkRD?=
 =?utf-8?B?ajFVbG02R0FiV21sMnJhRnRsY0lGTmpZUkg3bjcwV3RNNkdobHFHeFIzSWdD?=
 =?utf-8?B?N3h0NXQ2TXB3UG1Tck1oRjQ0TGJUeWl1VHdvRm9hR1F1YXBEajNFY3F3ZnY5?=
 =?utf-8?B?NmhDR3grVitGRkxHRitrMmlSUkVVeXk1dm9WbnZ0WGZocEdmOTFpV3FMNHNu?=
 =?utf-8?B?SkQzUXdwTmFUTnZmbDNnYWQvWURmVWVGV2VuTHRmbjJveWFrWmpvOU5mOUNn?=
 =?utf-8?B?UWI0M3NCU1ZFQnFpUTVPNmppQW1GL3ZhYjJZNENsaW9QZ0lRczVacHFzT2x4?=
 =?utf-8?B?bVhlM2JQRGFRc3VMYWpGV0JHdXRsNVBRVjNrZHN6WkVpeFlMZURCbzlXZ3Zz?=
 =?utf-8?B?MklsTEJjMVErQVQ3M3h1VHVaVUFXbzdFd0VDUjBVOVBad2xxTnFvYjVGa0VW?=
 =?utf-8?B?WThQMnRiRk90QlVkUnpZRVhrOHVHWVZhQkVYdjVJMjYxdVA3bzgxRXNnQ1lN?=
 =?utf-8?B?UnVUcVZqRFp4emRuZUNnWnlZaVhNc3lJaVhnUFNjQzZxaVJOMlUxNzFHT1hE?=
 =?utf-8?B?cjVwcHNqdFpqOXFYajBmdUNZbE9TaGM1ZlllZzVwL2EvcUZQRnhDSTZuQ1l4?=
 =?utf-8?B?cU1TeHI1YVBjeXgwcWk2WTFCWWFEU01TOTczNnJjT2hIMGhKenE0OFpnS3Z6?=
 =?utf-8?B?VUhpY2ZySkMxVzA3N2NJYVJqSFVwTEo0M2toZFI4VFg1SUxvUTdoczBVaVVO?=
 =?utf-8?B?VHB4eURDTUdOQXhoVE5FQVp4WUFzd0NOYnplLzZvMEFKdGRGMXU2R2dwbDN6?=
 =?utf-8?B?VE9kRWRGZDRYYVFNZTdWbEh4TWtPaE5CNGdMckl5NWQ4L09ObFFNcVZNblFY?=
 =?utf-8?B?SHcrS3RPM1lFRk5sMzdYKzhyRTVXV3BwT3ZIaVBSOEg4c1lETTZlYzVlZGlK?=
 =?utf-8?B?cHF1dzFxMm02a1dDdzNhN2FEOUpLNm94RDFma2lTR25SNm54SC8zclZCYUZj?=
 =?utf-8?B?UEc5Rk1HOXA4dFFKLzBwdi9VNjJCYWNYQitCTGR5YVRTbzY5a1IrZnRrelVu?=
 =?utf-8?B?a3h3RURZdzlqRnJ2RHFDSXpMWC8xekxoNWpmRmlodThJUTNhN0hIU0puSG5I?=
 =?utf-8?B?THlJL0FkSTlZSXdUS1IvdVpSUW9EeldvajVQR0tFcEowMFpmVFRIaVNuYnR4?=
 =?utf-8?B?SXhDUUhGd0M3MHhXYlhVVDAxMi9HUE1UZDZQVStzQlVCUUhuNDYwUT09?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: f380fd1f-ea47-465c-9e30-08da13f96eb8
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 16:05:25.1098
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 6xEY/SibrmAT4W9tEIJPSXE9QHBgy6lkIDQE2WfaZZEhlkJXCtznh44WN34VTm++j8a/MlQJpZUrHhx87Rn5fw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR84MB1425
X-OriginatorOrg: hpe.com
X-Proofpoint-ORIG-GUID: uZwbuXvoagRTRxMgVhZgGmyGcMuK7Iwu
X-Proofpoint-GUID: uZwbuXvoagRTRxMgVhZgGmyGcMuK7Iwu
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_05,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 suspectscore=0
 spamscore=0 impostorscore=0 lowpriorityscore=0 malwarescore=0
 mlxlogscore=883 bulkscore=0 adultscore=0 phishscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010078
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWls
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBUaHVyc2RheSwgTWFyY2ggMzEsIDIwMjIgNDo1MyBQ
TQ0KVG86IEhhd2tpbnMsIE5pY2sgPG5pY2suaGF3a2luc0BocGUuY29tPg0KQ2M6IEFybmQgQmVy
Z21hbm4gPGFybmRAYXJuZGIuZGU+OyBWZXJkdW4sIEplYW4tTWFyaWUgPHZlcmR1bkBocGUuY29t
PjsgT2xvZiBKb2hhbnNzb24gPG9sb2ZAbGl4b20ubmV0Pjsgc29jQGtlcm5lbC5vcmc7IFJvYiBI
ZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJh
ZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIHYzIDA5LzEwXSBhcmNoOiBhcm06IGJvb3Q6
IGR0czogSW50cm9kdWNlIEhQRSBHWFAgRGV2aWNlIHRyZWUNCg0KDQo+IEkgZG9uJ3QgdGhpbmsg
eW91IGNhbiBkbyB0aGlzLCBpZiB5b3UgYXJlIHVzaW5nIHRoZSBzeXNjb24gcmVnbWFwLCB5b3Ug
Z28gdGhyb3VnaCB0aGUgcmVnbWFwIGluZGlyZWN0aW9uIHJhdGhlciB0aGFuIGFjY2Vzc2luZyB0
aGUgbW1pbyByZWdpc3RlciBieSB2aXJ0dWFsIGFkZHJlc3MsIGFuZCB0aGlzIG1heSByZXN1bHQg
aW4gc29tZSBleHRyYSBjb2RlIGluIHlvdXIgZHJpdmVyLCBhbmQgYSBsaXR0bGUgcnVudGltZSBv
dmVyaGVhZC4NCg0KPiBJZiB5b3UgcHJlZmVyIHRvIGF2b2lkIHRoYXQsIHlvdSBjYW4gZ28gYmFj
ayB0byBoYXZpbmcgdGhlIHRpbWVyIG5vZGUgYXMgdGhlIHBhcmVudCwgYnV0IHdpdGhvdXQgYmVp
bmcgYSBzeXNjb24uIEluIHRoaXMgY2FzZSwgdGhlIHdhdGNoZG9nIHdvdWxkIGJlIGhhbmRsZWQg
aW4gb25lIG9mIHRoZXNlIHdheXM6DQoNCj4gYSkgYSBjaGlsZCBkZXZpY2UgZ2V0cyBjcmVhdGVk
IGZyb20gdGhlIGNsb2Nrc291cmNlIGRyaXZlciBhbmQgYm91bmQgdG8gdGhlDQogICAgd2F0Y2hk
b2cgZHJpdmVyLCB3aGljaCB0aGVuIHVzZXMgYSBwcml2YXRlIGludGVyZmFjZSBiZXR3ZWVuIHRo
ZSBjbG9ja3NvdXJjZQ0KICAgIGFuZCB0aGUgd2F0Y2hkb2cgdG8gYWNjZXNzIHRoZSByZWdpc3Rl
cnMNCg0KPiBiKSB0aGUgY2xvY2tzb3VyY2UgZHJpdmVyIGl0c2VsZiByZWdpc3RlcnMgYXMgYSB3
YXRjaGRvZyBkcml2ZXIsIHdpdGhvdXQNCiAgICBoYXZpbmcgYSBzZXBhcmF0ZSBkcml2ZXIgbW9k
dWxlDQoNCj4gT25lIHRoaW5nIHRvIGNvbnNpZGVyIGlzIHdoZXRoZXIgdGhlIHJlZ2lzdGVyIHJh
bmdlIGhlcmUgY29udGFpbnMgYW55IHJlZ2lzdGVycyB0aGF0IG1heSBiZSB1c2VkIGluIGFub3Ro
ZXIgZHJpdmVyLCBlLmcuIGEgc2Vjb25kIHRpbWVyLCBhIFBXTSwgb3IgYSBjbGsgY29udHJvbGxl
ci4gSWYgbm90LCB5b3UgYXJlIGZhaXJseSBmcmVlIHRvIHBpY2sgYW55IG9mIHRoZXNlIGFwcHJv
YWNoZXMuDQoNCkkgd2lsbCB0cnkgdG8gdXNlIHRoZSBiKSBhcHByb2FjaCBldmVyeXRoaW5nIGlu
IHRoYXQgcmFuZ2UgaXMgdGltZXIgb3Igd2F0Y2hkb2cgcmVsYXRlZC4gVGhlcmUgaXMgYSBzZWNv
bmQgdGltZXIgaG93ZXZlciB0aGVyZSBhcmUgbm8gcGxhbnMgb24gdXNpbmcgdGhhdC4gU2hvdWxk
IHRoZSBjb21iaW5lZCBjb2RlIHN0aWxsIGxpdmUgaW5zaWRlIHRoZSBkcml2ZXIvdGltZXIgZGly
ZWN0b3J5IG9yIHNob3VsZCBpdCBiZSBtb3ZlZCB0byBtZmQ/DQoNClRoYW5rcywNCg0KLU5pY2sN
Cg==
