Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99028542C38
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:00:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235692AbiFHJ7L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 05:59:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235940AbiFHJ6Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 05:58:25 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 706491706B;
        Wed,  8 Jun 2022 02:31:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654680664; x=1686216664;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=HDf0TCU3OY/d8DGrXP7TF3uCIHN/KWHu7cOZALR7hGM=;
  b=LjlvmUWVq0DiIl45bHlkOLLr7kAoWQw+6Ef7byTV6IMNpMeUah1AJUJp
   2TSqYQDfDFvmxq8TtlJE/mLeFpbZu7nONrZDZI6dcpVPmRG2l8NHcB/iS
   n6ekSpa1JqlVxO5BFDCnUqBDsyYL+sO5pe97w/cK8Q2sMMTs6LqF9BtbU
   xiQEZJJzG0zfreyLQ3c0Um8zXFBXqvTwXiU03QRMHB8GOeejn7RO/diZ8
   0eVNazJzfz/JQhB6676JNiqWe2EHpt2Vlat10ZMGWsgVOPspuiOobr4pp
   dGHeOHIguhMFUd1hLaGUJX3qdW9PeGuLVBW/CqoK7muOTpgWj52FMBTX9
   A==;
X-IronPort-AV: E=Sophos;i="5.91,285,1647327600"; 
   d="scan'208";a="177039506"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 Jun 2022 02:31:04 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 8 Jun 2022 02:31:03 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 8 Jun 2022 02:31:03 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hHzUDeiF+uEQJ6l3E/OI3adGXdP34kN3cOfTmDvRWGLAtbRRclc1AblN4XmCL1FtGObEtOUbRagvnuplugTTGGY/Lhtc3nOMLbIWhoSQUP2XUbYO3U57S6tztmIM9pYljndTbgt2stgCn4wkeUnvHRJUJPT1SPgdJ26UHukbVT+Fye2emWxk2EMbrduBKXgO/H9fGfhW+kEiln74suIbC3gl3eKdQEXk/J7OofL2IrkpxcaVOg4NgAVYcT5NVEF0IuwlC927oZ5Cx+35ZOhGI8/LnrQ4DYnp03hVKbBz5mGVqBtZ/9Df+XEZK36qjniQmZ/pLTOpWvAiSXMSt7AGQA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HDf0TCU3OY/d8DGrXP7TF3uCIHN/KWHu7cOZALR7hGM=;
 b=f7df+4Uu7u2IBK8Qt1A/ENh/EYeah0Y5CCzXacFXx2htvma2wVvC4B3F9Wk2z8ExQQhFD4oI/1LxgR8bM5pc14mHyO0FqKmXvqhrSWA5CLEyE98npedl6zRPdtxW4PwnWwIMXAd7ycSBG9MM80Ghdz4exarU08Bnz8gusz6yn1nMEFEjY11fv4Q4chXVOEViQybLhVBdK35KZWquIVKwPcDPM1EspybPHHh5CLsSZ5qWExD3Atkxo3gsl5tmUijL0TsGCJbuK9QZu8Je0u4age6vLVPwE+WOp/vU6E8jBD5xGgjUj1bMQCaDSYpgsZ8SX1TWryXlbJ6M3LixgW2O7w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HDf0TCU3OY/d8DGrXP7TF3uCIHN/KWHu7cOZALR7hGM=;
 b=G9blbTJ4gHPnu8GC8DVBy6vnFHa7aiR8i+N9U54wrIyW5PCrwbUC5uUVsIkbPR5dbvXD6O61PaiaNFTRh+ILAFSZjvo66PX60cCxr2W7gyJ3544ExpteCAKve3K65W2sP2dW0Pjc/8qs/3IbfXsiWXnVJlih57Ki4oZJlxWzFts=
Received: from CO1PR11MB4865.namprd11.prod.outlook.com (2603:10b6:303:9c::9)
 by PH0PR11MB5112.namprd11.prod.outlook.com (2603:10b6:510:3b::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.13; Wed, 8 Jun
 2022 09:31:00 +0000
Received: from CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a]) by CO1PR11MB4865.namprd11.prod.outlook.com
 ([fe80::9cb9:213a:4f98:d9a%7]) with mapi id 15.20.5332.012; Wed, 8 Jun 2022
 09:31:00 +0000
From:   <Kavyasree.Kotagiri@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <Nicolas.Ferre@microchip.com>,
        <alexandre.belloni@bootlin.com>, <Claudiu.Beznea@microchip.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <UNGLinuxDriver@microchip.com>
Subject: RE: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v2 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYen2pp3p8FshMIEipCRWWl5uoqK1FMCyAgAAPIuA=
Date:   Wed, 8 Jun 2022 09:31:00 +0000
Message-ID: <CO1PR11MB4865738B0AFB2F74CD184C5592A49@CO1PR11MB4865.namprd11.prod.outlook.com>
References: <20220607144740.14937-1-kavyasree.kotagiri@microchip.com>
 <20220607144740.14937-2-kavyasree.kotagiri@microchip.com>
 <1345050e-b6a4-64be-1359-8d31d88769ab@linaro.org>
In-Reply-To: <1345050e-b6a4-64be-1359-8d31d88769ab@linaro.org>
Accept-Language: en-IN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c4ad34f1-feb4-449a-5d22-08da49319965
x-ms-traffictypediagnostic: PH0PR11MB5112:EE_
x-microsoft-antispam-prvs: <PH0PR11MB51126388CCE3050C46CCF7E792A49@PH0PR11MB5112.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: TNT6yGY+xe/CUzElwbljK/Hy3pEQX8jzlqCyY1dYFDquiRi1oxzivtNh8JW23DTTiuT0HJcv16zbdZwX64IxC5IezbfXUE0wH99aK1jFf4RkknytRyeU20o+n7qFxsUVGq+RMpMe17EYcwAfkeoW6qGhaMFxOs5xGgWum41F8q5T2p372KO5XJigm3Fl5SxkaJVkmLtRMCzmt2rkowtzLNItP1/meUCx6HyBky7cFWLxFX2V8aIxJGN1KGEigS8Ic+xuVC1LE1nWNdryvoILHrgdKfwmPEK2lv3LW2hPRAS46QGUdb3Y25XenkHdtWWuyx9/edmqbK9MPZYEKy4aOs6DqiLE9ZDOjMUlAyHrLpFtvOOS9SOcaoikJoVMOnXtzv7OWuV8tNG8XXBFkYcXVIK48L9Af9YiXCiRoIQTIcWOZ+V8A3VHBaTrZQzVUahEnIGtkuCTZ+0S/M8UDCQ/n2XIr1c1oW/0S6UGwVbaXagIAaQZ9skNq6RDRE0YQs7Rge/pl3jyS9KhQIqM5W8uQoPI4cnacelZdLWAuwHLoXWA+REoyK9CkdZJbwlTqnThaNL8eiAP2a8kfudopJbdRnoZ0OpC2EcowyzGiiCk9BpqjFr0fak7Bc7/n8u8LR2nZ16gQzIc4owBoGa8HrTQk2Ke1zFiZaZJNg4e2XBc+lZfiM+QHgO/lvv3P4OnsqkTswZl/pOj67FtLZAlokQmgVMfZ7kvBrdZ21r8em0GUuzL//Sumd9yL2GN48ZXQ2PiTrAd6FDtcyROiMz/cZmIXixgnWmB3NN7g7T+ioZLFG1iV4ifbs1rdeT2L4deCHMRMDuou1nxwvtLocOOS8vIgw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4865.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(54906003)(7696005)(6506007)(71200400001)(966005)(66946007)(8936002)(508600001)(52536014)(186003)(5660300002)(66556008)(66446008)(64756008)(110136005)(4326008)(8676002)(76116006)(66476007)(107886003)(38100700002)(55016003)(26005)(122000001)(33656002)(2906002)(6636002)(316002)(83380400001)(86362001)(9686003)(38070700005);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MHR6Q25MVGh1amZFM2FLS0U3THBNSHE0cGJ6Y1JXa0hCMkpSdytyL0xuTitO?=
 =?utf-8?B?em40SW8zZ09oY0NUWnRnNEhLeGNFZUFhc2ZBL2xKWWF6ekgrNzhCNVI4dlEw?=
 =?utf-8?B?TGk4dFF6M2djSkZ1VGQzc2FBMFcrcUN4TDQ5NGNYNE9UeDl1azdKOVpaR0VY?=
 =?utf-8?B?U2U1cXdaMG9GalZoRGE5RHJxZ0ErUXVpRWdkUjBZay8vWEtrUm82eWpKR2k0?=
 =?utf-8?B?empTSzRSK1pOSG9DMWxPRWpZNEVVOHhRNW9pWHhYRG1TVlhBb2JMKzlsQ3da?=
 =?utf-8?B?MXNnaG13U3lZRHFjL2FwdUpFL21oVDdDT1pTa2R3UllsM0s1U1J1WXJRVHFs?=
 =?utf-8?B?VW1qU2hqVllPazlKbjV1SmlzRDB6STQza2crZ2xSSEtJRFV2NlNGYUx0SWp0?=
 =?utf-8?B?WWRMQnpRakYzMW5TS3F4aGJielgxZXFCQk9zc1hnMjk1cnZNYlF3QzV1N3lP?=
 =?utf-8?B?bW5nVEZCYnpzR09zeVJ3bFRhakQvUnVMZGNOQ21DUlBJUm02alZNVGh1THZP?=
 =?utf-8?B?WW9NWDlsTnhmaGZrOEJ2TU1qSXh0eXlxT01ESEJPeUhYMmIyQlZRNTlmSnQ4?=
 =?utf-8?B?UGx6dGhEVDRYMXpRWW9ZVnhYUUptZVVUR2RoT1YyeGkrWmwvNU43dlljVlJp?=
 =?utf-8?B?S1F3eVhaanZCa3BpU01KMm9MeVhUdUpEYXNyQ2lIb2JoaHdXUWJBQmVHWkZa?=
 =?utf-8?B?b01TQlowMFgzbWpRTncyM1N4SEhpUWpxQWhBSzVjMEVVbXZyRDZreXNXMW84?=
 =?utf-8?B?K3QrZkpPeFhSY05QN1JiZWI5VkFaRndhQStlK0FGWktSZVU0QjVvZWxTL3ZP?=
 =?utf-8?B?WHlSYmNudTErOWhkYXRzUGJwdkRZVU52SHJhZCtQbHJvY3ZrT2lDb1UyWnkr?=
 =?utf-8?B?SDNNOEh6OG43ZlVpYWlZV2MxYnRqdjk2Yko1Q1NOeHMyQW42eWp3dlhSMjU1?=
 =?utf-8?B?b29PMW1sUXo0WHpRVTB3clJjdUlLR0JqK2ZDVElSRnk0SEhza3lRZmNTSmVX?=
 =?utf-8?B?akZpbmo2RkM0UHRXMTF0QkZhR2RCbG8xTmFjZDV2TkNvWGJ2VElQbDJIc3Zk?=
 =?utf-8?B?NmVqNjNMd2Njb0tSaTdyRWVtbUVOZUlaK2tnUW5SOTB0aS9xanBNSXpDZVFn?=
 =?utf-8?B?dFQ5MnFEaXR3OTVIQmk5d3BGcmk4eWE0YnlWeU5BVkpMUUx2elV4MzRUQnla?=
 =?utf-8?B?cmNHdG5kYmNTZkhNalppckIxQWsrQjdOalhXdkdlNFMxUE9BSVZaTk5VdVls?=
 =?utf-8?B?Z3NoRzRWdG9MaTFhMmFlUGs0cjA2TTF3WEJyOXdJTDNnSDdEV1k5blFQdWFG?=
 =?utf-8?B?ZEViTG1xUUR5S3BoY05zZE9MYnQ1YmJPaGF1VkZJYk1ZWWpKZ1dUY1JkTkpH?=
 =?utf-8?B?MEpuWEVvZWF4aG5PaE9GNFduVUtZYlhJVHRiZCtHQUsyT1BNUkNpZkt1Nmxt?=
 =?utf-8?B?QlhWZlRJYzhDNE5FRm1LT3Vybm8raXlTUVJqSy9qVmJhZ2NHVTBuRkxHUVRZ?=
 =?utf-8?B?bUVNaTBDS1R3bFoybjQveTFYMnpVZ2dBbGY3SHBwaUhsT0hJb3pmWDl4MDRO?=
 =?utf-8?B?UUlnNzd3TGUzemY3V3hBQldtUlJCNmpOczZQZjVsMEQvc3ROTWlYWEUvc1Er?=
 =?utf-8?B?NW5BRWQvWHR4aVMwVGtYTm9kaGtwM2ZoZ1R0eCt4SDF3cXh3S1lSTmxyVEZ6?=
 =?utf-8?B?b3B1b0tyd0RqM2x1QjQyOWNhRnhSaGI1RXo5eDlOaHVrVE9XY3JrSzdlckVZ?=
 =?utf-8?B?V2lSbDUxbjFEY2hIV29BdmU0aUhQR1hLMU90dmtoN1BKUW5OcVdrTlNpeUpM?=
 =?utf-8?B?QUF3VUNvMWticmF5dktuYk9nTk9VMWFoaUJwNXNqazZIbDdwUXRJVGxNZ0Zv?=
 =?utf-8?B?TGFabVQ0K29wb3QrUGtYb0d5OHZTQWNXZnpQdnM4SUFPaVgzTGdCZjl0Z3Uy?=
 =?utf-8?B?MDdzTFRiaU5SUVRGVFpRUWcwTFN5N3luNCtYam1hUUYwUVh6Kys4NG84b3da?=
 =?utf-8?B?cGxtYVdxTFV4T3NEaDRxWFYxQWRRKzAwSjhTNkJzb1crUm9tYnhsR2dlZDg2?=
 =?utf-8?B?VmFJbVRYWmp2VXVyWmZYVzRsZ3JicWJLc3QwenNKZ1RkTUxzSHVad0dWZVNJ?=
 =?utf-8?B?cXRZWjdSOFdYRENkMUE5RHlGOHQyeEV0NHVNeVRjOEZ3RFcxakVBSWlwbXpU?=
 =?utf-8?B?ei9STjcwditOTnRlaHZycDBBOThaUC9iZ0tFYkI1dWg5TVFlYmpURll3QjN5?=
 =?utf-8?B?RnU2N1YxdHpmUWhNZmRNTGgwL20xT3NSbm55MlJKcnNqTlJCYWFISWl1SU5O?=
 =?utf-8?B?ZHdhcGJGQ3pFak9FY1JTWlBmRFp5emU5SzFyYVJtMEpXZWJrd3pLdEZmT3Ew?=
 =?utf-8?Q?XqyeW8G0+XCDPVL8=3D?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4865.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4ad34f1-feb4-449a-5d22-08da49319965
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Jun 2022 09:31:00.1816
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: QQXDLHYZQPs72WZQUzwzBVnyqKJxdBqlQj4WhadwVjzr5QWwnrmKQ9CNB3zh9BSCdPO2X3yX/z4EBr0XwHkOO5gDeG9EK+KDx6gyDA0Bo/IE+YLo8v1oypNg53IO3qcz
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB5112
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

PiA+IENvbnZlcnQgdGhlIEF0bWVsIGZsZXhjb20gZGV2aWNlIHRyZWUgYmluZGluZ3MgdG8ganNv
biBzY2hlbWEuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBLYXZ5YXNyZWUgS290YWdpcmkgPGth
dnlhc3JlZS5rb3RhZ2lyaUBtaWNyb2NoaXAuY29tPg0KPiA+IC0tLQ0KPiA+IHYxIC0+IHYyOg0K
PiA+ICAtIEZpeCB0aXRsZS4NCj4gPg0KPiA+ICAuLi4vYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhj
b20ueWFtbCAgICAgICAgICAgfCA5NyArKysrKysrKysrKysrKysrKysrDQo+ID4gIC4uLi9kZXZp
Y2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbC1mbGV4Y29tLnR4dCB8IDYzIC0tLS0tLS0tLS0tLQ0K
PiA+ICAyIGZpbGVzIGNoYW5nZWQsIDk3IGluc2VydGlvbnMoKyksIDYzIGRlbGV0aW9ucygtKQ0K
PiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRp
bmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gPiAgZGVsZXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwtDQo+IGZsZXhjb20udHh0DQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21m
ZC9hdG1lbCxmbGV4Y29tLnlhbWwNCj4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGlu
Z3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbA0KPiA+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+ID4g
aW5kZXggMDAwMDAwMDAwMDAwLi4wNWNiNmViYjRiMmENCj4gPiAtLS0gL2Rldi9udWxsDQo+ID4g
KysrIGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29t
LnlhbWwNCj4gPiBAQCAtMCwwICsxLDk3IEBADQo+ID4gKyMgU1BEWC1MaWNlbnNlLUlkZW50aWZp
ZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPiA+ICslWUFNTCAxLjINCj4gPiAr
LS0tDQo+ID4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMvbWZkL2F0bWVsLGZs
ZXhjb20ueWFtbCMNCj4gPiArJHNjaGVtYTogaHR0cDovL2RldmljZXRyZWUub3JnL21ldGEtc2No
ZW1hcy9jb3JlLnlhbWwjDQo+ID4gKw0KPiA+ICt0aXRsZTogQXRtZWwgRmxleGNvbSAoRmxleGli
bGUgU2VyaWFsIENvbW11bmljYXRpb24gVW5pdCkNCj4gPiArDQo+ID4gK21haW50YWluZXJzOg0K
PiA+ICsgIC0gS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlAbWljcm9jaGlw
LmNvbT4NCj4gPiArDQo+ID4gK2Rlc2NyaXB0aW9uOg0KPiA+ICsgIFRoZSBBdG1lbCBGbGV4Y29t
IGlzIGp1c3QgYSB3cmFwcGVyIHdoaWNoIGVtYmVkcyBhIFNQSSBjb250cm9sbGVyLA0KPiA+ICsg
IGFuIEkyQyBjb250cm9sbGVyIGFuZCBhbiBVU0FSVC4gT25seSBvbmUgZnVuY3Rpb24gY2FuIGJl
IHVzZWQgYXQgYQ0KPiA+ICsgIHRpbWUgYW5kIGlzIGNob3NlbiBhdCBib290IHRpbWUgYWNjb3Jk
aW5nIHRvIHRoZSBkZXZpY2UgdHJlZS4NCj4gPiArDQo+ID4gK3Byb3BlcnRpZXM6DQo+ID4gKyAg
Y29tcGF0aWJsZToNCj4gPiArICAgIGNvbnN0OiBhdG1lbCxzYW1hNWQyLWZsZXhjb20NCj4gDQo+
IFNhbWUgY29tbWVudCBhcHBsaWVzIGFzIGJlZm9yZS4uLiBZb3VyIHByZXZpb3VzIHNldCB3YXMg
YmV0dGVyIGhlcmUgYW5kDQo+IGZvciBzb21lIHJlYXNvbiB5b3UgZGVjaWRlZCB0byBjaGFuZ2Ug
aXQuIFRoaXMgc2hvdWxkIGJlIGVudW0gc28geW91DQo+IGF2b2lkIHVzZWxlc3MgY2hhbmdlIG5l
eHQgcGF0Y2guDQo+IA0KVGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLg0KRG8geW91IG1lYW4gdXNl
ICJlbnVtIiBpbnN0ZWFkIG9mICJjb25zdCIgaW4gY3VycmVudCBwYXRjaCBpdHNlbGYgYW5kIGFk
ZCBuZXcgY29tcGF0aWJsZSBpbiAyLzMgcGF0Y2g/DQoNCj4gPiArDQo+ID4gKyAgcmVnOg0KPiA+
ICsgICAgbWF4SXRlbXM6IDENCj4gPiArDQo+ID4gKyAgY2xvY2tzOg0KPiA+ICsgICAgbWF4SXRl
bXM6IDENCj4gPiArDQo+ID4gKyAgIiNhZGRyZXNzLWNlbGxzIjoNCj4gPiArICAgIGNvbnN0OiAx
DQo+ID4gKw0KPiA+ICsgICIjc2l6ZS1jZWxscyI6DQo+ID4gKyAgICBjb25zdDogMQ0KPiA+ICsN
Cj4gPiArICByYW5nZXM6DQo+ID4gKyAgICBkZXNjcmlwdGlvbjoNCj4gPiArICAgICAgT25lIHJh
bmdlIGZvciB0aGUgZnVsbCBJL08gcmVnaXN0ZXIgcmVnaW9uLiAoaW5jbHVkaW5nIFVTQVJULA0K
PiA+ICsgICAgICBUV0kgYW5kIFNQSSByZWdpc3RlcnMpLg0KPiA+ICsgICAgaXRlbXM6DQo+ID4g
KyAgICAgIG1heEl0ZW1zOiAzDQo+ID4gKw0KPiA+ICsgIGF0bWVsLGZsZXhjb20tbW9kZToNCj4g
PiArICAgIGRlc2NyaXB0aW9uOiB8DQo+ID4gKyAgICAgIFNwZWNpZmllcyB0aGUgZmxleGNvbSBt
b2RlIGFzIGZvbGxvd3M6DQo+ID4gKyAgICAgIDE6IFVTQVJUDQo+ID4gKyAgICAgIDI6IFNQSQ0K
PiA+ICsgICAgICAzOiBJMkMuDQo+ID4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzINCj4gPiArICAgIGVudW06IFsxLCAyLCAzXQ0KPiA+ICsNCj4gPiAr
cGF0dGVyblByb3BlcnRpZXM6DQo+ID4gKyAgIl5zZXJpYWxAWzAtOWEtZl0rJCI6DQo+ID4gKyAg
ICBkZXNjcmlwdGlvbjogU2VlIGF0bWVsLXVzYXJ0LnR4dCBmb3IgZGV0YWlscyBvZiBVU0FSVCBi
aW5kaW5ncy4NCj4gPiArICAgIHR5cGU6IG9iamVjdA0KPiA+ICsNCj4gPiArICAiXnNwaUBbMC05
YS1mXSskIjoNCj4gPiArICAgIGRlc2NyaXB0aW9uOiBTZWUgLi4vc3BpL3NwaV9hdG1lbC50eHQg
Zm9yIGRldGFpbHMgb2YgU1BJIGJpbmRpbmdzLg0KPiA+ICsgICAgdHlwZTogb2JqZWN0DQo+ID4g
Kw0KPiA+ICsgICJeaTJjQFswLTlhLWZdKyQiOg0KPiA+ICsgICAgZGVzY3JpcHRpb246IFNlZSAu
Li9pMmMvaTJjLWF0OTEudHh0IGZvciBkZXRhaWxzIG9mIEkyQyBiaW5kaW5ncy4NCj4gPiArICAg
IHR5cGU6IG9iamVjdA0KPiA+ICsNCj4gPiArcmVxdWlyZWQ6DQo+ID4gKyAgLSBjb21wYXRpYmxl
DQo+ID4gKyAgLSByZWcNCj4gPiArICAtIGNsb2Nrcw0KPiA+ICsgIC0gIiNhZGRyZXNzLWNlbGxz
Ig0KPiA+ICsgIC0gIiNzaXplLWNlbGxzIg0KPiA+ICsgIC0gcmFuZ2VzDQo+ID4gKyAgLSBhdG1l
bCxmbGV4Y29tLW1vZGUNCj4gPiArDQo+ID4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVzOiBmYWxzZQ0K
PiA+ICsNCj4gPiArZXhhbXBsZXM6DQo+ID4gKyAgLSB8DQo+ID4gKyAgICBmbHgwOiBmbGV4Y29t
QGY4MDM0MDAwIHsNCj4gPiArICAgICAgICAgIGNvbXBhdGlibGUgPSAiYXRtZWwsc2FtYTVkMi1m
bGV4Y29tIjsNCj4gPiArICAgICAgICAgIHJlZyA9IDwweGY4MDM0MDAwIDB4MjAwPjsNCj4gPiAr
ICAgICAgICAgIGNsb2NrcyA9IDwmZmx4MF9jbGs+Ow0KPiA+ICsgICAgICAgICAgI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47DQo+ID4gKyAgICAgICAgICAjc2l6ZS1jZWxscyA9IDwxPjsNCj4gPiArICAg
ICAgICAgIHJhbmdlcyA9IDwweDAgMHhmODAzNDAwMCAweDgwMD47DQo+ID4gKyAgICAgICAgICBh
dG1lbCxmbGV4Y29tLW1vZGUgPSA8Mj47DQo+ID4gKw0KPiA+ICsgICAgICAgICAgc3BpMDogc3Bp
QDQwMCB7DQo+ID4gKyAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFybTky
MDAtc3BpIjsNCj4gPiArICAgICAgICAgICAgICAgIHJlZyA9IDwweDQwMCAweDIwMD47DQo+ID4g
KyAgICAgICAgICAgICAgICBpbnRlcnJ1cHRzID0gPDE5IDQgNz47DQo+IA0KPiBhcyBwb2ludGVk
IC0gbG9va3MgbGlrZSBhIElSUSBmbGFnDQo+IA0KT2suIEkgd2lsbCBjaGFuZ2UgaXQuDQoNCj4g
PiArICAgICAgICAgICAgICAgIHBpbmN0cmwtbmFtZXMgPSAiZGVmYXVsdCI7DQo+ID4gKyAgICAg
ICAgICAgICAgICBwaW5jdHJsLTAgPSA8JnBpbmN0cmxfZmx4MF9kZWZhdWx0PjsNCj4gPiArICAg
ICAgICAgICAgICAgICNhZGRyZXNzLWNlbGxzID0gPDE+Ow0KPiA+ICsgICAgICAgICAgICAgICAg
I3NpemUtY2VsbHMgPSA8MD47DQo+ID4gKyAgICAgICAgICAgICAgICBjbG9ja3MgPSA8JmZseDBf
Y2xrPjsNCj4gPiArICAgICAgICAgICAgICAgIGNsb2NrLW5hbWVzID0gInNwaV9jbGsiOw0KPiA+
ICsgICAgICAgICAgICAgICAgYXRtZWwsZmlmby1zaXplID0gPDMyPjsNCj4gPiArICAgICAgICAg
IH07DQo+ID4gKyAgICB9Ow0KPiANCj4gDQo+IA0KPiBCZXN0IHJlZ2FyZHMsDQo+IEtyenlzenRv
Zg0K
