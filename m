Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9611D508E2D
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 19:13:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380980AbiDTRQI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 13:16:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380936AbiDTRQF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 13:16:05 -0400
Received: from mx0a-002e3701.pphosted.com (mx0a-002e3701.pphosted.com [148.163.147.86])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0E1457A6;
        Wed, 20 Apr 2022 10:13:19 -0700 (PDT)
Received: from pps.filterd (m0134422.ppops.net [127.0.0.1])
        by mx0b-002e3701.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 23KFWD28015958;
        Wed, 20 Apr 2022 17:13:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hpe.com; h=from : to : cc : subject
 : date : message-id : references : in-reply-to : content-type :
 content-transfer-encoding : mime-version; s=pps0720;
 bh=VX7De13RZ9wUkXQlwBjWW9g1OYZSEuzcloRpuwXD06c=;
 b=Tjs5tBmWuTCAxjnUohrBNlB1PFTBcFu6o3JV7B60MsZALrtPbR3MYvSC5/ccWkr30JTp
 4eqX3bVe2gmY1WEB9cmnQc0keLfOwAyZdPvyDV8L6zsgKl+ygIqxhJG0Z4O7tXtFcyGk
 rYrTPep9Se5ew6rwXNNwAgUVFuJmur6xxcqaWLToSduXVEeSkmjWK9Poq9GpF8FbmVBP
 UkLbIGE24wCQG/h92cwtavF7/Mt6eqiccp752jjsUxN6Y5TL4wx5/5wJnDphrCw7wsY4
 qoogRjGhTmK+6TyL1VgvddjwwWQc2iXe1MSpEhi/XX3ypanwamL7vfCdwUmi4xdiwges 7w== 
Received: from p1lg14881.it.hpe.com (p1lg14881.it.hpe.com [16.230.97.202])
        by mx0b-002e3701.pphosted.com (PPS) with ESMTPS id 3fjmv3gw79-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 20 Apr 2022 17:13:12 +0000
Received: from p1wg14925.americas.hpqcorp.net (unknown [10.119.18.114])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by p1lg14881.it.hpe.com (Postfix) with ESMTPS id A9FA9805E01;
        Wed, 20 Apr 2022 17:13:10 +0000 (UTC)
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14925.americas.hpqcorp.net (10.119.18.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 05:12:28 -1200
Received: from p1wg14927.americas.hpqcorp.net (10.119.18.117) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 05:12:28 -1200
Received: from P1WG14918.americas.hpqcorp.net (16.230.19.121) by
 p1wg14927.americas.hpqcorp.net (10.119.18.117) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.15
 via Frontend Transport; Wed, 20 Apr 2022 05:12:28 -1200
Received: from NAM04-BN8-obe.outbound.protection.outlook.com (192.58.206.38)
 by edge.it.hpe.com (16.230.19.121) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.15; Wed, 20 Apr 2022 17:12:28 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IIK8q/a7Cw2KrvnlHJLPYkGL+ixOKNhwag9QaTo+9OAkBofO4mzKJuTDaYOi2Pmawyb77uKTsb+NhKt03nCT3IqL2A2+4+v0ZGiDA91cc2+vGMPw/hdz3eDYj4gv1ACyKTefNDUF5AFKeq6MPABvb23X6Fc7f+1VnjBwAIZZA//xHmAYMSF30baOo8N+KMTtqKIjZfhLhXGbPGOGGTS5raLzG2PGhojofN7zLhM7VmtK1AEAylUxdBMZUPILpBwwUtZxcoTnbCIwsxfmcoX33juVey4gakmf9zWfglAr31T6QelC7XqPylK1DTBQ6ZyCgmy3m9HI6QK+zomVq5Ph7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=VX7De13RZ9wUkXQlwBjWW9g1OYZSEuzcloRpuwXD06c=;
 b=oP5Z9+tcyRpwcqns1VTzLM3UkwF2jhHZLlqCH6YnT71H4ob2S9YxwDrVaSQX9VJm/0N2Anf2nmZndQANcbriUSlMDfBGdeSkCOegGHUCZDy/Q0Hdwi1bW1bsfQeKFGC0SDEyUSln7+vZgaUAL9mZoZa/mxnMBVsS3FDdwBnZefXYw4ecfQ+5SEXdHIVHcW3LyYGbmLMvYt+VeAye6NFmYvXr6Y3qMeMS9ElzDuydgMgzrJxujsDbRRdG8jidic9SeuypJAOqO1BeWn7eef8rQHuSeTVT9TXbrIhEhfUsrW0o6PdjaQtJjNcU9rJhuOa+ShSVo2f8Y3ZQqvLEPJCdEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=hpe.com; dmarc=pass action=none header.from=hpe.com; dkim=pass
 header.d=hpe.com; arc=none
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:172::21)
 by PH0PR84MB1672.NAMPRD84.PROD.OUTLOOK.COM (2603:10b6:510:160::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5164.20; Wed, 20 Apr
 2022 17:12:26 +0000
Received: from PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562]) by PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
 ([fe80::6055:1602:5a0a:1562%8]) with mapi id 15.20.5164.025; Wed, 20 Apr 2022
 17:12:26 +0000
From:   "Hawkins, Nick" <nick.hawkins@hpe.com>
To:     Arnd Bergmann <arnd@arndb.de>
CC:     "Verdun, Jean-Marie" <verdun@hpe.com>,
        "Harders, Nick" <nicholas.harders@hpe.com>,
        Joel Stanley <joel@jms.id.au>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        DTML <devicetree@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4 09/11] dt-bindings: usb: generic-ochi: Add HPE GXP ochi
 binding
Thread-Topic: [PATCH v4 09/11] dt-bindings: usb: generic-ochi: Add HPE GXP
 ochi binding
Thread-Index: AQHYVNiMFAKLeqxVUEOutPnlBV05zKz5CZtQ
Date:   Wed, 20 Apr 2022 17:12:26 +0000
Message-ID: <PH0PR84MB1718D862B41866F0992AB23B88F59@PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM>
References: <20220420150156.47405-1-nick.hawkins@hpe.com>
 <20220420150156.47405-9-nick.hawkins@hpe.com>
 <CAK8P3a0CgyM6Mwo0P-Qqej671PNW2qS6oun6dpQh2VHCCy9yJQ@mail.gmail.com>
In-Reply-To: <CAK8P3a0CgyM6Mwo0P-Qqej671PNW2qS6oun6dpQh2VHCCy9yJQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 6feb8cf4-508d-437f-8b38-08da22f0f19f
x-ms-traffictypediagnostic: PH0PR84MB1672:EE_
x-microsoft-antispam-prvs: <PH0PR84MB1672F5B74E14A3D076BE706088F59@PH0PR84MB1672.NAMPRD84.PROD.OUTLOOK.COM>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: B6B+tkPF7WpAipf4m0Thuqb2DlLiUQLEeDZlAtf9gGvh4NWAK4S753mXXCMVftZLjipJFfi7tFw/9JAZJiaLgJ/58W+cmimo/cJ+lP4hnv9VQG30n0XFVkUNCLjDEI4e6lpow9b8AhRZXS9MaunccCsbD3zkBXVtTOM9PoJ3KoybhuUltBuKy7ZGECMAkudZcQ2zz0ea5O94nz94Z3/5nO93V5E8hqw9OI/0W4w3WW7y2gFzsA29nCfXaounz7aUg8mzYqg0wPnv1gJfPCogwpShuouZIK0RFo/uGa6ZDXQufaEl4Gp4+q/0d1Pwp5nABUmpLecCpkvioYCGyQY3S++31xMzXI34fVn5jGzFCjV00VC0g6O6LnikaKgrF0ayNvoDcil2BSDyfmMj5Z/X7aRvZrRuKkM2LXfoRET9nPRMbmELMNXAjxMxpmc+l/BVN/5DLZkhwNEYlpsq3YYFyJuyjVf4JJfsxySFwDmKxAzyY2oKkWyO5N7En2SZV4CcuNq1+wvV+AR+FvexgdANIEMAvMcy3ke457039PJq8wy3GzWlfMi1BFM4TeGwoEFHJWTkSAQQwkAaWg/B7AJ/HbVzBloHXeadU1AQnbDWLNUUjhopouKGZyZ7ak8AhdGsgZeFnlmpfzZzIo6SZNTskUi687eSWsbei/Cr2iB9lXb7EYCGIfRUAIKzVVGqMs5vFDpYI+JNVICycHF3wK1F7Qok3IwfHoWNjO+02zCmjzM=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(8676002)(6916009)(8936002)(54906003)(86362001)(38070700005)(55016003)(53546011)(9686003)(7696005)(316002)(26005)(6506007)(508600001)(82960400001)(2906002)(71200400001)(38100700002)(66476007)(66556008)(52536014)(122000001)(76116006)(33656002)(66446008)(4326008)(5660300002)(83380400001)(66946007)(64756008)(4744005)(41533002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?clV0WWphM0YyYnRPZU9wV2I2S2RZaWUzOWp6dFNhSjI3ZnZYL2Z5ZTlwWFhV?=
 =?utf-8?B?dVlEeHhwWHY0ZWFjNDVWeVYxQkp5dzdqcWNKa3Ixck9LTm1ld0ZSM2RBb01x?=
 =?utf-8?B?aWRoU01FZ1E3cUtNSkRpSGFocWRPVWRXNUJKMzFqaTBReDFLMTAwRTVtQmFS?=
 =?utf-8?B?RmJBRHZiNERJZ3NKUUdBV1JJdTQraWVzV2k5OFJwYXV6bjE3Uy9qUFhCRFcy?=
 =?utf-8?B?c003cnVibnZreFduYjZaU216cGg1UjRhaEowblFBTG40WDNncXpOZUtEQXZK?=
 =?utf-8?B?bS9USnpabXREY3pNQjJZUnVCL2NYYVhCa0hGV2VqaUZKenI2K0FpUUcwOEFu?=
 =?utf-8?B?WmZIQ2JpVmxCUWpldUFlcXU3UDJSaEQwaGJ6YUdFSHU2V1RmS3cybFRBRUhW?=
 =?utf-8?B?NWxtUHAyTFhBbEVmR25DcU4zc0ZWR0owU2diRXpRQS9MM2VxeTVTV0RoUm5U?=
 =?utf-8?B?L0NoTXZnNTJqcHh3NlJrQXVWUHpJL1pvYlF3S0J0L1dRdElwL0dTU2xncDZx?=
 =?utf-8?B?T2NhVWp0Z2dMVjF5RXZIckp4ZTJRZDM3TWlOQ3ZpdC9aaSt4RDNqQWdYVHNj?=
 =?utf-8?B?WTR4RFlTeGhGNWc5cE81ejJWSzhscDRPZHhQb2ROMS9NYjlTaWk2UDZDWTMr?=
 =?utf-8?B?UEVacjR2VithTFdrOXBLTzM5aHVWbEt0Ym1lNWI1QW9oZ25DMndPY1hXWDkx?=
 =?utf-8?B?dFZOV1JzZ2hQK2xsSXZOTW40NlR4Rkl1NnN6SEZsc2NtaTJDUGxhaTNjYkJJ?=
 =?utf-8?B?L1pIOWM2enk3TDBHak9vK3NFRUJrQ01MOVdtSy84cEVaOUkwWVRnaTZxMzRB?=
 =?utf-8?B?TzMreE96OEkxZmhheTVXd3NvYlpERkl5ZFBDL09OdGVsOHlLajhzQ1FaU29F?=
 =?utf-8?B?ZDFScE5PclltajIzNDlWc2ZzdVg5UnlSeG00c054WW9XYjJsNTVaeFVFUHBI?=
 =?utf-8?B?d3pzdS9uVDBBam5uL05lNU41SXZMdUc1WS9ucWZidXp6cnNzVjVDWVlqUmZ5?=
 =?utf-8?B?ZldBL0RucDlrSG54S1ZwQjBUWHFKMTI2dHFtd3Y3bW1iUmNIREFvajBFSDBI?=
 =?utf-8?B?OXZPaDBFeFhTdVlQd0RsTEx3UytCYjRmQmxKckMySk1Ua1ZGbXFLc293Wmlk?=
 =?utf-8?B?aEE3blZrZFlKNlM2LytZVnJVRnRwa3lPcWNoV2RWREViSnRDeHRVd3h5VUJt?=
 =?utf-8?B?a2ZaZEJ4VDVEUEhEeW9pa2oraEhNellNZUIxVWlraXhSc0FzUmZTZUxUT1p4?=
 =?utf-8?B?SGFxZzYxVStEV1dkLzdEbjU1SURBbCsrbG1jM2ZGcmhlaVRlNEJkdXNlUkh0?=
 =?utf-8?B?UW9VcGNLN3d6U0phUnJKaVdONnpyZmZUVjZZNHBWOE4rNlJ1L05PTDhPTThq?=
 =?utf-8?B?THJOcHdINjJnM0orbVVNZWhvTGxZMHg0cE9KMEpLbEFoQllRTER0TmpKM01K?=
 =?utf-8?B?eDFGSWZzTXJsbDBsMThSS3QrK1FZdHdjL2R1RkxxTDhUNUNtanRkeTVkZ3lN?=
 =?utf-8?B?YUxkZkRLWDNxbGlGQUdjM0xrTW1oUjl5ejZSWmZRbkRMc1dPbjVKMUR0di9B?=
 =?utf-8?B?bEtUdy8wclhKejZUc28rWWx3WDEyZzZ4VWNkaXZGdEZsZE12NXFMVWVzZGpD?=
 =?utf-8?B?V2IwTHh1U3JTMDdEZWt6c1hOOUJDNnd2U0ZvNm1BQS94TTc5ejlQditFSlhN?=
 =?utf-8?B?YXpRM1ZuSU03NW9yVTlVWSt5YmNVY1pZZTM0QzBLUVkrbUEwVUJ2clRaVlRw?=
 =?utf-8?B?VDZ2OTFvMWRTVVJmTGpwdjhlVThFeDg0UkN0ajlBbk0vb1pnbXJmOHJrSENW?=
 =?utf-8?B?bFRGbzh5QVlSS3l3MUxFeGxYVjRTWFNnOElnNWVuN3hQSVhidjRlU3JybXdT?=
 =?utf-8?B?Rm1KaUk4VmRUb001anpBaFdCS2lzYWpNYm1UOGZPMEN4RkVrbzBPMS9PejV2?=
 =?utf-8?B?VStBTEo1SW5QcmVISzFZZVZSVjNUUEp1M3hpTXRSMmRPMDJQYVFGWlJXMGVI?=
 =?utf-8?B?NmdaSm5JRFpudDIvVFRheXdkd2dJaTV5bGQ1aEJOb2ovQWNoMDhOSy9XdTdu?=
 =?utf-8?B?SkRFVmoxTHEyeDN2Ylk0b1RzcnZ5T2kwMUhIeE9qTStXTzcyaDA3NnczbW1S?=
 =?utf-8?B?VzdIS0NlWk5HQnJ4aVJ4bHczNzY2N0lVZnJ0YjhZd3JSWGZDaUVDZk9WYkEy?=
 =?utf-8?B?NU02MjhrWTliQkhjUVk2R3hMWi9xay9MUFhoYytUQ2s0SnYzNm9YMTl0cVFZ?=
 =?utf-8?B?MVZ0OENTbksydW11SDNFQVgxSndXUmtwdEJNMHlKMm10aTdOdHNRTDE2WDQ2?=
 =?utf-8?Q?TNfwpTAEHWPfzJvet8?=
Content-Type: text/plain; charset="utf-8"
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR84MB1718.NAMPRD84.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 6feb8cf4-508d-437f-8b38-08da22f0f19f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Apr 2022 17:12:26.6033
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 105b2061-b669-4b31-92ac-24d304d195dc
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: EpkzlVsPNC2uMCnEafVTwkzOe9OL/T/vjBD3Woi3K0QymJet8ls/iReDuO/5E/fqIABjTQipcBa6CPnDdccRHg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR84MB1672
X-OriginatorOrg: hpe.com
X-Proofpoint-GUID: xecTEqTEdd5GTLvzER7uzZRpckWAfXio
X-Proofpoint-ORIG-GUID: xecTEqTEdd5GTLvzER7uzZRpckWAfXio
Content-Transfer-Encoding: base64
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-HPE-SCL: -1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-04-20_05,2022-04-20_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 mlxlogscore=999 mlxscore=0 priorityscore=1501 spamscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 clxscore=1015 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2204200102
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBBcm5kIEJlcmdtYW5uIFttYWls
dG86YXJuZEBhcm5kYi5kZV0gDQpTZW50OiBXZWRuZXNkYXksIEFwcmlsIDIwLCAyMDIyIDEyOjAz
IFBNDQpUbzogSGF3a2lucywgTmljayA8bmljay5oYXdraW5zQGhwZS5jb20+DQpDYzogVmVyZHVu
LCBKZWFuLU1hcmllIDx2ZXJkdW5AaHBlLmNvbT47IEhhcmRlcnMsIE5pY2sgPG5pY2hvbGFzLmhh
cmRlcnNAaHBlLmNvbT47IEpvZWwgU3RhbmxleSA8am9lbEBqbXMuaWQuYXU+OyBBcm5kIEJlcmdt
YW5uIDxhcm5kQGFybmRiLmRlPjsgR3JlZyBLcm9haC1IYXJ0bWFuIDxncmVna2hAbGludXhmb3Vu
ZGF0aW9uLm9yZz47IFJvYiBIZXJyaW5nIDxyb2JoK2R0QGtlcm5lbC5vcmc+OyBVU0IgbGlzdCA8
bGludXgtdXNiQHZnZXIua2VybmVsLm9yZz47IERUTUwgPGRldmljZXRyZWVAdmdlci5rZXJuZWwu
b3JnPjsgTGludXggS2VybmVsIE1haWxpbmcgTGlzdCA8bGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZz4NClN1YmplY3Q6IFJlOiBbUEFUQ0ggdjQgMDkvMTFdIGR0LWJpbmRpbmdzOiB1c2I6IGdl
bmVyaWMtb2NoaTogQWRkIEhQRSBHWFAgb2NoaSBiaW5kaW5nDQoNCk9uIFdlZCwgQXByIDIwLCAy
MDIyIGF0IDU6MDEgUE0gPG5pY2suaGF3a2luc0BocGUuY29tPiB3cm90ZToNCj4gPg0KPiA+IEZy
b206IE5pY2sgSGF3a2lucyA8bmljay5oYXdraW5zQGhwZS5jb20+DQo+ID4NCj4gPiBBZGQgaHBl
LGd4cC1vY2hpIHRvIHRoZSBnZW5lcmljLW9jaGkgbGlzdC4gVGhpcyBpcyB0byBlbmFibGUgdGhl
IA0KPiA+IGRldmljZSB0cmVlIHN1cHBvcnQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBOaWNr
IEhhd2tpbnMgPG5pY2suaGF3a2luc0BocGUuY29tPg0KDQo+IHMvb2NoaS9vaGNpLw0KDQo+IGV2
ZXJ5d2hlcmUNCg0KSSBoYXZlIGNvcnJlY3RlZCB0aGlzLiBJIG5vdGljZWQgdGhhdCBJIGRpZCB0
aGUgc2FtZSB0aGluZyB3aXRoIGVjaGkgLT4gZWhjaSBzbyB0aGF0IGhhcyBiZWVuIGNvcnJlY3Rl
ZCBhcyB3ZWxsLg0KDQpUaGFua3MgZm9yIHRoZSBmZWVkYmFjaywNCg0KLU5pY2sgSGF3a2lucw0K
