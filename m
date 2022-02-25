Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A7F64C4BE5
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 18:19:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243564AbiBYRTv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 12:19:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240045AbiBYRTt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 12:19:49 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD8A1A805C
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 09:19:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645809556; x=1677345556;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=wDSiBDmCKpLVt2jIUR5PbJ+58L+uDnkoj+dLHErW/94=;
  b=m8gTybAW7c5M9T5gJs8Tkdt4BKht/u5Xne8YkGcuIY8Hmq1HJzkkWjh7
   xKwmKQl8tKn+vTmwYc+cwpCkeyjLj5s4jQy6eVQhWA187Zc4/6svC0PP4
   m3I2HmEK3lbDHDxJVhlQIESdGI7jOiaFGNZaULADS2takjmZycvMvnBwc
   YgKveThkGQDWPi7H8/CjztN9omr8V0/aCm/OR0Dvc1aAHI0DRZkKkXijx
   RqhHkvYSg95SoKDweatpkfLPOXWxfgyQCsTXm6q5op6hE0qLh+v3KsPtx
   m71x9ZBgERGJCzYCzCEAcYMfOH8Iqri0qlsjR+lQ1hBJj31DSVT1vKX+c
   A==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="154924973"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 10:19:15 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 10:19:15 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 25 Feb 2022 10:19:15 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=g87Rl4WqOXc0IKBbEwQoVOZTDfFIdhNG6X2bDIxJYSTUIz5Ilx5/RRd//gK7mSjZqrNFNnt8HJYkDSROlYGCRcklaz1oIOTxKeLDTcYCrkxwiFa5NSGo/mdViLcsdhxWFLztkwDLHtSrC/KWXEJSUNGmnSENV4lxmJu6BSCnDH6BTSOtQqvOAqMZRWJRUhLkZIMH9uvs+cMmw8WiDz+5XY4Q1d9yIGiZdg4BVr8gXLN4a8Oe3iEXDMcXFN3SuuNRPjG58Khtu7NWLMhMh4DKMNH72Jk0SQBx1CAb/Pbh8zrBV3+NojGt5ykHbx0NHI7k8ieHnylP+PYQFWIxTfAIlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=wDSiBDmCKpLVt2jIUR5PbJ+58L+uDnkoj+dLHErW/94=;
 b=M5k77+HMflWurrAZv5VcNe6/adJhsxyTdHvdaTkBz76atgMJfTZbw2CVRDD8nie8gyUBZStkMcVeO0X+GHdHwnbt+XzmlMuIdIim/Yedz+E2Met8lX9waT3mfjop6AHIeXSoDIaf5y1RCWwiA3wm8CbN+oOMiKsVAnOtg0br+N28ANUhGi1i2enfvyw9dCkQegp0SQBqXLA5Ar4x5D59TlVsF4yfNkWvHYsbTSaRCCE2XShyt4HGIF+CHZWa83PjyM8QgvISsclbj8W+48FEqTbsctYluUKe9Q5nRS2qZpX6qJsP57nc1ynYcw85HG4jAYfygiQtY5eTuQuIUAhdjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=wDSiBDmCKpLVt2jIUR5PbJ+58L+uDnkoj+dLHErW/94=;
 b=pYug7r2x+EdB9GUFxpucp74ZPiTY5oqoG1UKTWMNahHqJ9XwPT1xMkULnpSSV7pzTOUDps9u9xbyLxog3TROR7IMudt4pyy73qmJl5yiMLC+htqX1hBF5QuzdBny19RmYrsD5WDCg5RiImbE6Sl/b049pX8gSTmIIOLXDqMjTVw=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BN7PR11MB2643.namprd11.prod.outlook.com (2603:10b6:406:b2::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 25 Feb
 2022 17:19:10 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 17:19:10 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <quic_c_sbhanu@quicinc.com>, <dianders@chromium.org>,
        <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <quic_stummala@quicinc.com>, <quic_vbadigan@quicinc.com>,
        <quic_rampraka@quicinc.com>, <quic_pragalla@quicinc.com>,
        <quic_sartgarg@quicinc.com>
Subject: Re: [PATCH V7] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Thread-Topic: [PATCH V7] mtd: spi-nor: winbond: add support for W25Q512NW-IM
Thread-Index: AQHYKmvNxsxBmNvG6U+9dCklDAOpPA==
Date:   Fri, 25 Feb 2022 17:19:09 +0000
Message-ID: <63301527-46ff-b7ee-93dd-12ce9d79008b@microchip.com>
References: <1644578661-21821-1-git-send-email-quic_c_sbhanu@quicinc.com>
In-Reply-To: <1644578661-21821-1-git-send-email-quic_c_sbhanu@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9841d2a0-bf64-4ea1-8ef2-08d9f882efac
x-ms-traffictypediagnostic: BN7PR11MB2643:EE_
x-microsoft-antispam-prvs: <BN7PR11MB2643980454FE6584D44C1FCEF03E9@BN7PR11MB2643.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ko2Pn77+hTfqGuVIypQCpdcaYO0CQvK/obXLZyZ+wmZK5YYWl64eaHJEvyWhnEVdqVJdqhiEHcen3Jid7hXvcqEfT2k3nNHrxUVeMM+Stb98KDb4/OCLD1wGZKkjCpT67I2qoG33jSCsBVpKOpwyAPuNyTA8fypXfRoMZKgpXRERJ37kCy31wkgvxtc/cEahr3l3hXPPFDJij9M/4ZpYyKfgaljHkik0tO2/QiYUsz3nO3J/IAJrWHTMtgHZLvHTyE2TifuqkXmXHuq0JVSdmIA35G6NCcRSC0TuRT7Wk3HcGNbstYBLnERpT54FMUkQ6FQ5rZHT+f+lSuTSaqxvxGAMmQcNsAw88y2N26OWMF9RomW2B01QL821GEVaZm3crH2PVRRa3XeTG6x+Cc0HfYrny8MvdupcJ6PcGUZmSeKUkNt27fn+O67RrjSkuS6CcosL/0rfHYXflKhMt20JGBWdanmVuQg8etsBQDyEvRzb/Vu8V3txbaWvu5b2UAjtbYgaSiTtv9Zjj2eaEji7DFtKOUwziAHqjkaEUw0jQKLu5+FtYPh7dZ/Q2fFicqJdZ+t81I+v5yQ/V7D9jMCkVvSc2yy1eLovjaqW5dPUzf1t3mm5v9stHjzrlr837mr885y81i2B2P/QrjndMypnOF2uHa7zrU5KyC9GvS2Eab8bmTIRRGaRDZsNQzEFo5NhjIkhyqUrbX9A9IwpylBYbVhhOPiyRAocZHGGuiq+63ZIdmVIH/wztC8El8ZRWath64Hwm2mzCcO/dUvoMzM1geujTM7XRb2oAiCa+4Sq304cBFmV0o8E8Lgh/oJ6QDcpvPkffABDMUUxjHhh1jkn0eX6th1yYmZnwQPkruOAMeY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(8936002)(7416002)(8676002)(6486002)(966005)(4326008)(5660300002)(86362001)(31696002)(316002)(36756003)(31686004)(91956017)(64756008)(508600001)(66446008)(110136005)(66476007)(66556008)(66946007)(76116006)(54906003)(6512007)(6506007)(53546011)(122000001)(38100700002)(83380400001)(71200400001)(186003)(2906002)(2616005)(26005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MVIrMFFNZGQ1QUFHTi9kVFdTNHNZSWFqNVZnY0htemxKUHRWd2wzOVdsejdS?=
 =?utf-8?B?M1dhQ1ZMWFlaUTJ4TVhORzluWW9HbFNvQ3dybFd4dDZUYkwwcDMzenNURjB2?=
 =?utf-8?B?T1BnZHhkUkFDOUpRcGhUeU9jaW53MlJlUkNqVmtURnZxekE3SlBxZmFBVnFZ?=
 =?utf-8?B?Z1JZaWVoNmZQamtNVFR6MW9ibHFjNW9GS1U5c0tza1hnSDRzWHR0RDZDbGlZ?=
 =?utf-8?B?b3VidFFveVBYaExHUmN5aGRscFQ3Rmp5L2VJeVRJQTJWVGRXcWdHMkxXTld6?=
 =?utf-8?B?ZE94Vlg5akZGQmZaV0VnZERad3pSNVFibXVpZHpZb3hiNDAxemxyVGZyM3lD?=
 =?utf-8?B?cVpWWHowcHhEMit3aklPcmRuSjhNQUU5NlVEd3ZWWGwvVWt0MEd2QkhnNlNr?=
 =?utf-8?B?SVN6eUl1SzVRTDAvZlZnR0RNU3pNRHVRY2pqL3RQVzhmdkxTUUxvUlp4QUxu?=
 =?utf-8?B?YzlsR25wV0dERTdONnVteUVBYVRRSjFHYms4QnFQQUhaR2xoY2txbEdsdHRJ?=
 =?utf-8?B?RFVRTGN6OTU5c3lqSkFGeGE2bmVudlZScHBIeVc2Wi9sTmgxTEJ2S1VIcG4x?=
 =?utf-8?B?ZmYzY2FESzBIRjM5c3hQaWdKbVppUjlJdHBVVThpaWZhZ0Vkbk54S2cwNFAr?=
 =?utf-8?B?QTNTN05xU2JnM2dTSXozYVA2Y01MT082dG5NL1B2Ky9lNXNSQWIxdnVCYm8r?=
 =?utf-8?B?aTU5UUh1Y3lNRWVCd1lzUGE5ZU81enVIU0hXTDl3VmZTUmhhZlFwUVo3cFZW?=
 =?utf-8?B?K05YTXU3NzN4OXp0d2pjTXBYV2hkRGJWQ09UT2dlQ3RJV2lQOGVnbEpLSG9h?=
 =?utf-8?B?SWtmVEt2VjNpTm5jeTNLREFiblhmTW5kWXJVOStiREVMcmMzVE5keUh1dDBu?=
 =?utf-8?B?bS9pYW1Td1BmOVhmV2ZFc1FxcnhJRDRKNjBBMWVWcHhCWHhZeHpXN3dhMDg2?=
 =?utf-8?B?UTJ4Z1B1TVJuV2xQMGFvQlRsa1Z3Zy9JcXBlTzUzTmNnVjAveFk3OWJGaFVG?=
 =?utf-8?B?dG9aNk9JOWlWTWVEU1dzT25Hc3lONENtQm9raE9aOHhjZmo4cjBBWENHeG91?=
 =?utf-8?B?T3FYWFdyV0U4RTNoRjBXMkxpb2Faa0lkWkF3MFhMNGpkbm5oUW9IU0lodVYx?=
 =?utf-8?B?NVBmUFd3UnN2VUFXWmNXZ2FQM0RKUkc3UG5ybVJiVVBaMHYxZXBCa2Q3UUk4?=
 =?utf-8?B?QW9wWmVmUVJ6UlVsek5sKzdXV3k3Zm1QOExncWo1cjIzZXpHZHdjMzBGbTQ5?=
 =?utf-8?B?YkR6d0N3T0xLcXBPeHB3TzFSU1hPN09OUGIyV1BKcHB2akxOVDh1VWQ2d2NV?=
 =?utf-8?B?ZGtoOEpIU0VheHNTVkt0d2VZVFc1SnA0TDRKSi9mdUErMXlVcTNzQys0cXFs?=
 =?utf-8?B?TU5vcGZDN1RzSXMvdEFPYU5EV0MrbHNEYWhIVUhON280UGhicDd1VTg4KzBO?=
 =?utf-8?B?N1RQdTJSUGltbytPWkJiTk1mUlozWTJ6RjZqYUFhWjR4SWhUNm54cXZ6dU5w?=
 =?utf-8?B?SjdGaS9PQ0NJT2VaRkt4R3RFWUx3cjczWHl0S2tuUDJ5THh0MTg2R3pYVHVI?=
 =?utf-8?B?dFNPVVl5TmhOZEZzZnJOaU1wakxYZ0NtL0pZdGRmSzN3UjJMZXorQnFXZFJT?=
 =?utf-8?B?Mk9IdHFOODlkeGZMeG8vRTFiRk5Ob25jTDdmZ2Iwdm1pZ2t1MWUvMmJiTE5m?=
 =?utf-8?B?RUZQNXNvc3JTVmN4YzBZNWNUUGNpLzN0Vi9rdjZvNmY5QWRkaGI2WkRGS2Zz?=
 =?utf-8?B?L1YvWWpyU1RjWk5uYzE1bFBzdGFWbDBOdFJSamFtd3lvM2VMQnZXTnJQdEFY?=
 =?utf-8?B?ZUU2R0NNc2d6NkNtVy8rTWZSVEsxclVxQUl3eEZMRk1aaHp4TFdBNnNvcjZ2?=
 =?utf-8?B?OFQvc1M0dEFXTjErMjEzdU5LaVlncTgwUU1iQjZadGRDejNTRm4vRmEwaXlP?=
 =?utf-8?B?STBLcG13aTlCTThvL2R4cmViUnZlOGQ4SEU3SExxTUIxOStudndYallhbUQy?=
 =?utf-8?B?NElCYitZUmZoL3ZXR2RJM1FxTStvbElaTVF5N0M1akZUNmtWQ084SDF0cDcv?=
 =?utf-8?B?YnlwZXZGWVhhRzR6Y1B0VXlXQWFDYTRPNEszQWw3RUtNTnRHOHVhZmZyMnoz?=
 =?utf-8?B?Q20wN0tYTmVzc2krNW1VKzk3RGx2NEI2SFZXc0dtdGtCbnJ6VHNJQTNkZGJ6?=
 =?utf-8?B?N2pHQ1UrVS9sS2lzWlVic1g4dU9oV1JLY2FBSFNLYVlDQVY2eURWSDYvdGpI?=
 =?utf-8?B?Y25YZHNCNzF5VDNpMlUxcWRmc3ZnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <243D939D9A7AA242AA426D03ECD69A74@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9841d2a0-bf64-4ea1-8ef2-08d9f882efac
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 17:19:09.9667
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Ui0REQGw3HsyLlBGEyZyfoQES7nVUHa2kj099h4xShXynF5bShIHdn3zJv8g8Q2s29jqQIdQDpnEZwyxU9sMhFbJK9lsu/ORkhPbvf3XbZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN7PR11MB2643
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCk9uIDIvMTEvMjIgMTM6MjQsIFNoYWlrIFNhamlkYSBCaGFudSB3cm90ZToNCj4gRVhU
RVJOQUwgRU1BSUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVz
cyB5b3Uga25vdyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgc3VwcG9ydCBmb3Igd2lu
Ym9uZCBXMjVRNTEyTlctSU0gY2hpcC4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IFNoYWlrIFNhamlk
YSBCaGFudSA8cXVpY19jX3NiaGFudUBxdWljaW5jLmNvbT4NCj4gUmV2aWV3ZWQtYnk6IERvdWcg
QW5kZXJzb24gPGRpYW5kZXJzQGNocm9taXVtLm9yZz4NCj4gLS0tDQo+IGxvY2FsaG9zdCAvICMg
Y2F0IC9zeXMvYnVzL3BsYXRmb3JtL2RldmljZXMvc29jXEAwLzg4ZGMwMDAuc3BpL3NwaV9tYXN0
ZXIvc3BpMTYvDQo+IHNwaTE2LjAvc3BpLW5vci9qZWRlY19pZA0KPiBlZjgwMjANCj4gDQo+IGxv
Y2FsaG9zdCAvICMgY2F0IC9zeXMvYnVzL3BsYXRmb3JtL2RldmljZXMvc29jXEAwLzg4ZGMwMDAu
c3BpL3NwaV9tYXN0ZXIvc3BpMTYvDQo+IHNwaTE2LjAvc3BpLW5vci9tYW51ZmFjdHVyZXINCj4g
d2luYm9uZA0KPiANCj4gbG9jYWxob3N0IC8gIyBjYXQgL3N5cy9idXMvcGxhdGZvcm0vZGV2aWNl
cy9zb2NcQDAvODhkYzAwMC5zcGkvc3BpX21hc3Rlci9zcGkxNi8NCj4gc3BpMTYuMC9zcGktbm9y
L3BhcnRuYW1lDQo+IHcyNXE1MTJud20NCj4gDQo+IGxvY2FsaG9zdCAvICMgaGV4ZHVtcCAvc3lz
L2J1cy9wbGF0Zm9ybS9kZXZpY2VzL3NvY1xAMC84OGRjMDAwLnNwaS9zcGlfbWFzdGVyL3NwDQo+
IGkxNi9zcGkxNi4wL3NwaS1ub3Ivc2ZkcA0KPiAwMDAwMDAwIDQ2NTMgNTA0NCAwMTA2IGZmMDEg
MDYwMCAxMDAxIDAwODAgZmYwMA0KPiAwMDAwMDEwIDAwODQgMDIwMSAwMGQwIGZmMDAgZmZmZiBm
ZmZmIGZmZmYgZmZmZg0KPiAwMDAwMDIwIDY4MDAgNmM2NSA2ZjZjIDc3MjAgNzI2ZiA2NDZjIGZm
ZmYgZmZmZg0KPiAwMDAwMDMwIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZm
Zg0KPiAqDQo+IDAwMDAwODAgMjBlNSBmZmZiIGZmZmYgMWZmZiBlYjQ0IDZiMDggM2IwOCBiYjQy
DQo+IDAwMDAwOTAgZmZmZSBmZmZmIGZmZmYgMDAwMCBmZmZmIGViNDAgMjAwYyA1MjBmDQo+IDAw
MDAwYTAgZDgxMCAwMDAwIDAyMzMgMDBhNiBlNzgxIGQ5MTQgNjNlOSAzMzc2DQo+IDAwMDAwYjAg
NzU3YSA3NTdhIGJkZjcgNWNkNSBmNzE5IGZmNWQgNzBlOSBhNWY5DQo+IDAwMDAwYzAgZmZmZiBm
ZmZmIGZmZmYgZmZmZiBmZmZmIGZmZmYgZmZmZiBmZmZmDQo+IDAwMDAwZDAgMGFmZiBmZmYwIGZm
MjEgZmZkYw0KPiAwMDAwMGQ4DQo+IA0KPiBsb2NhbGhvc3QgLyAjIG1kNXN1bSAvc3lzL2J1cy9w
bGF0Zm9ybS9kZXZpY2VzL3NvY1xAMC84OGRjMDAwLnNwaS9zcGlfbWFzdGVyL3NwaQ0KPiAxNi9z
cGkxNi4wL3NwaS1ub3Ivc2ZkcA0KPiAxMDZkODlkNmMwNDkxMTBiYzk0YzAxNTE3Y2I0Y2UyNCAv
c3lzL2J1cy9wbGF0Zm9ybS9kZXZpY2VzL3NvY0AwLzg4ZGMwMDAuc3BpLw0KPiBzcGlfbWFzdGVy
L3NwaTE2L3NwaTE2LjAvc3BpLW5vci9zZmRwDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIFYxOg0KPiAg
ICAgICAgIC0gQWRkZWQgc3BhY2UgYmVmb3JlIG5hbWUgb2YgdGhlIGZsYXNoIHBhcnQgYXMgc3Vn
Z2VzdGVkIGJ5IERvdWcuDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIFYyOg0KPiAgICAgICAgIC0gVXBk
YXRlZCBjaGlwIG5hbWUgYXMgdzI1cTUxMm53bSBhcyBzdWdnZXN0ZWQgYnkgRG91Zy4NCj4gDQo+
IENoYW5nZXMgc2luY2UgVjM6DQo+ICAgICAgICAgLSBVcGRhdGVkIGZsYXNoX2luZm8gZmxhZ3Mg
cGFzc2luZyBhY2NvcmRpbmcgdG8gYmVsb3cgcGF0Y2guDQo+IA0KPiBDaGFuZ2VzIHNpbmNlIFY0
Og0KPiAgICAgICAgIC0gQWRkZWQgT1RQIHN1cHBvcnQgZm9yIFNQSSBjYXJkIGFzIHN1Z2dlc3Rl
ZCBieSBNaWNoYWVsIFdhbGxlLg0KPiAgICAgICAgIC0gVXBkYXRlZCBTRkRQIGZsYWdzIHBhc3Np
bmcgYXMgc3VnZ2VzdGVkIGJ5IFByYXR5dXNoIFlhZGF2Lg0KPiANCj4gQ2hhbmdlcyBzaW5jZSBW
NToNCj4gICAgICAgICAtIFJlb3JkZXJlZCBmbGFncyBwYXNzaW5nIGluZm8gZm9yIHNwaSBub3Ig
YXMgc3VnZ2VzdGVkIGJ5DQo+ICAgICAgICAgICBNaWNoYWVsIFdhbGxlLg0KPiAgICAgICAgIC0g
QWRkZWQgU0ZEUCBkdW1wIGluZm8gaW4gY29tbWl0IGFzIHN1Z2dlc3RlZCBieSBNaWNoYWVsIFdh
bGxlLg0KPiANCj4gQ2hhbmdlcyBzaW5jZSBWNjoNCj4gICAgICAgICAtIFVwZGF0ZWQgY29tbWl0
IHN1YmplY3QgYW5kIGFkZGVkIG1kNXN1bSBpbiBjb21taXQgYXMgc3VnZ2VzdGVkDQo+ICAgICAg
ICAgICBieSBNaWNoYWVsIFdhbGxlLg0KPiAgICAgICAgIC0gUmVvcmRlcmVkIGZsYWdzIHBhc3Np
bmcgaW5mbyBmb3Igc3BpIG5vciB3aGljaCBoYXMgbWlzc2VkIGluDQo+ICAgICAgICAgICBWNSBw
YXRjaCBhcyBzdWdnZXN0ZWQgYnkgTWljaGFlbCBXYWxsZS4NCj4gLS0tDQo+ICBkcml2ZXJzL210
ZC9zcGktbm9yL3dpbmJvbmQuYyB8IDQgKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0
aW9ucygrKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbXRkL3NwaS1ub3Ivd2luYm9uZC5j
IGIvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4gaW5kZXggNjc1ZjMyYy4uNmZkZTJh
YyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci93aW5ib25kLmMNCj4gQEAgLTEyNCw2ICsxMjQsMTAgQEAgc3Rh
dGljIGNvbnN0IHN0cnVjdCBmbGFzaF9pbmZvIHdpbmJvbmRfcGFydHNbXSA9IHsNCj4gICAgICAg
ICB7ICJ3MjVtNTEyanYiLCBJTkZPKDB4ZWY3MTE5LCAwLCA2NCAqIDEwMjQsIDEwMjQpDQo+ICAg
ICAgICAgICAgICAgICBOT19TRkRQX0ZMQUdTKFNFQ1RfNEsgfCBTUElfTk9SX1FVQURfUkVBRCB8
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfRFVBTF9SRUFEKSB9LA0K
PiArICAgICAgIHsgIncyNXE1MTJud20iLCBJTkZPKDB4ZWY4MDIwLCAwLCA2NCAqIDEwMjQsIDEw
MjQpDQo+ICsgICAgICAgICAgICAgICBQQVJTRV9TRkRQDQo+ICsgICAgICAgICAgICAgICBGTEFH
UyhTUElfTk9SX0hBU19MT0NLIHwgU1BJX05PUl9IQVNfVEIpDQoNClRoaXMgZmxhc2ggaGFzIDNC
UCBzdXBwb3J0LCB3YXMgbG9ja2luZyB0ZXN0ZWQ/IEkgd291bGQgbGlrZSB5b3UgdG8NCmRlc2Ny
aWJlIGluIHRoZSBjb21taXQgbWVzc2FnZSBob3cgdGhlIGZsYXNoIHdhcyB0ZXN0ZWQsIGFuZCBh
ZGQgaW4NCnRoZSBjb21tZW50IHNlY3Rpb25zIHByb29mcyBvbiBob3cgaXQgd2FzIHRlc3RlZC4N
Cg0KaHR0cHM6Ly93d3cud2luYm9uZC5jb20vcmVzb3VyY2UtZmlsZXMvVzI1UTUxMk5XJTIwUmV2
QiUyMDA3MTkyMDIxLnBkZg0KDQpDaGVlcnMsDQp0YQ0KDQo+ICsgICAgICAgICAgICAgICBPVFBf
SU5GTygyNTYsIDMsIDB4MTAwMCwgMHgxMDAwKSB9LA0KPiAgICAgICAgIHsgIncyNXE1MTJqdnEi
LCBJTkZPKDB4ZWY0MDIwLCAwLCA2NCAqIDEwMjQsIDEwMjQpDQo+ICAgICAgICAgICAgICAgICBO
T19TRkRQX0ZMQUdTKFNFQ1RfNEsgfCBTUElfTk9SX0RVQUxfUkVBRCB8DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIFNQSV9OT1JfUVVBRF9SRUFEKSB9LA0KPiAtLQ0KPiBRVUFMQ09N
TSBJTkRJQSwgb24gYmVoYWxmIG9mIFF1YWxjb21tIElubm92YXRpb24gQ2VudGVyLCBJbmMuIGlz
IGEgbWVtYmVyDQo+IG9mIENvZGUgQXVyb3JhIEZvcnVtLCBob3N0ZWQgYnkgVGhlIExpbnV4IEZv
dW5kYXRpb24NCj4gDQoNCg==
