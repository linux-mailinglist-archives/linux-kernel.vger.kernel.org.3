Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C492D58AB32
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 15:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240805AbiHENBK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 09:01:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbiHENBI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 09:01:08 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DFB717E2D;
        Fri,  5 Aug 2022 06:01:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1659704467; x=1691240467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cIZMnZX22IW+dhrR96EXPZAu6Av0MM9YUO0WjAdSYsg=;
  b=kQFoz1rmzcq+1EY7pLgiAGa8st+x97CQLaM0ASmvKIYXjGYZfSk9PO/U
   i5yvLXjxyuEbnAJghyPj+m7bvD8ZiNoAt3j3bA9xzok/8MZ0uMq6CO6Oj
   yq/VYXSNOojyYhsn+yfswOO/Ke9pcdZUhI5DhVm9qpHqZXNpLy0zQki+6
   rmpQGnRB08lIhQfRM+fg+x7drDP7djyy1vsB9JzrHbN5BylQ7vUcBc8Bv
   nFjOsBvky6fJlizRA2EXbjmX5nDNEpYXlInmm7QV+DG+ZWh8SuObVWrJ0
   aabYCpPlxbnzjCv4wfsLDIBQthFe/0SYIyrUgf1f8oC3DzA1XRj5BK9k+
   Q==;
X-IronPort-AV: E=Sophos;i="5.93,216,1654585200"; 
   d="scan'208";a="168000466"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 05 Aug 2022 06:01:07 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Fri, 5 Aug 2022 06:01:06 -0700
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Fri, 5 Aug 2022 06:01:06 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=d2NZl73zq6uY8A9IQTqH34rWEAWlvyydQskonpJ2VLspRi4+MLXSx1DpmE5GSTValt5EwMARBfS0AviKrrwOdnlUTyPKsqyKoha/rQfXRPXrCFv98rzCZ34Xm5tBRgklCD501j8ZjP+I3MPHO8MmzaCyYC3AwzuM+u9Mqw/r+oL3yiEVLVHlM6WLHgjvQLm3ffHi9iPjwwuMY9fO4Fen7x6NqGErQ8oMkLSuMtp6S/FhdjnX1otpRzsSpxoKcZNfW13cKSGavno5x0WATOenLPnifXoKOK2w29yy6zYeVa36EbV4G67jirEy1mcY0mnX9FmuLH0tfd5lM3W2CrEIfg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cIZMnZX22IW+dhrR96EXPZAu6Av0MM9YUO0WjAdSYsg=;
 b=avkEI36K4+KnFaf25cR8Gd76TiE/Re93OtaP7dzorY2hDSvrKA8Hhqx1a+qngRHR8o4PtfyAeyAZnJTDoSHaLZU2kL7weunsEpPS9smQXbeVkiH9W9AVFcT7HWuClqSYgHRQbxQ/T72qdMCKrzCzYSF3yEEXxdyu8v0flQ2ngJKpQKLUQMRSuH3u1QIP0xTO+2frnWqtwJGtueXIEb8FqwNVBSVRzDOlZxyLxXovZkNdcEtyI0i/zP9gF5E4Te14JAFKtCbJl2C+KK3Lo2hSVX/BW40lkj+qq3ynaQv666CbfXmq6tUrkRMMLBSAcm9RcberlnHi9XFep4lXVH2Yjg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cIZMnZX22IW+dhrR96EXPZAu6Av0MM9YUO0WjAdSYsg=;
 b=o0SgL6xY5qwoA5XngVWPspV1807VKCKMg7H18f0gLzIHAyngnxPc3KiDcCdzLg5GZS5EfA+LVKBSfIM7NXKMX1RhGY2K8qrbyQLxNepQ3VIdSnKYflA7Hr531YQj3RGJcNHdlLq2U9H7tCpcWdp0fo5jm0D98ISaAzNqyi32FJw=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB2799.namprd11.prod.outlook.com (2603:10b6:805:64::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.16; Fri, 5 Aug
 2022 13:01:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::ac89:75cd:26e0:51c3%8]) with mapi id 15.20.5504.016; Fri, 5 Aug 2022
 13:01:00 +0000
From:   <Conor.Dooley@microchip.com>
To:     <Conor.Dooley@microchip.com>, <jassisinghbrar@gmail.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <Daire.McNamara@microchip.com>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-riscv@lists.infradead.org>
Subject: Re: [PATCH 1/3] dt-bindings: mailbox: fix the mpfs' reg property
Thread-Topic: [PATCH 1/3] dt-bindings: mailbox: fix the mpfs' reg property
Thread-Index: AQHYqMq0EEyz0mkBck+BKUM3RrFs2K2gRWiA
Date:   Fri, 5 Aug 2022 13:01:00 +0000
Message-ID: <04b697b5-d344-0191-f511-c0f8e0c247ef@microchip.com>
References: <20220805125618.733628-1-conor.dooley@microchip.com>
 <20220805125618.733628-2-conor.dooley@microchip.com>
In-Reply-To: <20220805125618.733628-2-conor.dooley@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 21c819eb-1780-4de7-031d-08da76e28be9
x-ms-traffictypediagnostic: SN6PR11MB2799:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8ItRy6yez1FmFhi3ccU90BoN4fwG5MOhxXtmYXAt0OjBhxWD6ImKl1P2NBIz6yO3dPNczpIQSefysTfgwVWafddJvE92Y3tRBujU1CmJhgZOv71CEYxpsnVtweNzXCpWz6ypCT4DtVoabC49Ob6LnAbUMSeDLLyy1Hq7j8VGGEliE0UdG3jZEsbT7uwZBdXwkWjUc3VIoWMXNV1HmmntE2YzYbUis68KL0cK4wu3SqSc0aOQ/74tdwkVPlzTwjDe8ZgF1JDON6JIccWtWE3g5Ac7zKHGhldoPzeOWRuwQmFnXoTD+Bh2dFtn5fOfPh5uMgFFlkbdJWDQOPz8XfznVy2YsR/c2yBbTubNzEtHNPsHahx9hGGBv96lQR2NmrDR7FBieRSeY6CIaGqiLITs5CDLTsFNzSeajKNqn+yBlFOJ2qUMDg5oUFtHCGPN0WlWfeuhVL++Im/dGG8s5AV9jm/Ay+RnPGaH823UWgIIWj1KVfqfFqUeof7iJVl2l3RP1J+/SvrBZxFLaXZ/YEb4WKx5PNza3rmkXAFKZntiWoxerow7RQJlxejpMYWDCOJoA6yqT/LmC+PsFrYFt6xsFrR4Et5jID5LnbFnxvjTO07UgETEhwLC3OfyXn3YaIOO4lK0Akv25wA1j+W9YhvOrtBHkZs2seTIopfbQt2my7BYcCHUsDMaejaRlhPXjJzibIZd1VuDWlk7e34ja/RT7h6f63Z1Rngvdjz1eB+Zoe10ZIb7bn6d31guhm8csPfuDaBOzRS/MryFTRScp+tOeldKNplxGLK+TR5M0OS1jNme0L5oBlIDKWUtFFpFfSwLLrlq7G6kVT2QNDhnlYcW+NWRhZImImrNLWTo7wi1GH+NAEeUU+M/i1CHpTtjeAL0
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(136003)(376002)(346002)(366004)(39860400002)(396003)(186003)(478600001)(2616005)(4326008)(66476007)(66946007)(91956017)(76116006)(8676002)(64756008)(66446008)(316002)(66556008)(54906003)(31686004)(8936002)(86362001)(36756003)(31696002)(41300700001)(5660300002)(15650500001)(53546011)(71200400001)(26005)(6506007)(6512007)(38100700002)(122000001)(2906002)(38070700005)(83380400001)(110136005)(6486002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUZ5T240cEw4WG1BNkRvS3NCSFRwZXV3SjVzQzhJOTB6Q2dBSUhuLy9rb0ZY?=
 =?utf-8?B?Y0x0SmsvMGlxbTlkQzdmdEtaS2ZVWFZ4eGJYbUtlbTVlQzhLOVJ0YWN1bVU1?=
 =?utf-8?B?VmM1a3padlBXcDBwWVBOVkIxKzB0Zm1KMXFRdEVmM1FiNnU3Ykt4TDFOVDFw?=
 =?utf-8?B?TGJ3MlRmNEJhR1dpSTk2eGNMWEY4ZVg3WmRlUjA5UE9NUnY5cUpVZFFBQ2Vv?=
 =?utf-8?B?Q0lJMnBGWVpLYzNvYzB3cmh3b3NlNGo3OHk3UWZPemJRRytpS250alNZNHpO?=
 =?utf-8?B?VkRiT2Z5bUhjbFMweGtQdlFLMnBIRloyMHJySndkcE1ST2RLRGVId3NyUDUr?=
 =?utf-8?B?Ky81dzg0ekpPaFVKdG1xQTFKemlrWm1SKzBreVd2blNFc1JUWkVIWW5vOWU3?=
 =?utf-8?B?VHZSRDdHYkt4NlhLYldRd1NsK2s4K0dqZjYvbmI2WHA5eU1UZkhJdWx4SFhh?=
 =?utf-8?B?UlZDQmZYSUlrbEtBWk15ZU5OcjA1NnY0U1dTRG8xTDM4clRQVDVnQkc1Y1Rr?=
 =?utf-8?B?SUovL0pZbFBiWVUyT3dRN0NUMVFITUptSG4yZ1IzTWNna3RTQ2UxWUsrZHow?=
 =?utf-8?B?V01WTjk1c0lpcVNoQ1B0bUNQV0J2bGs4a0tNOU5oMjZQRUNEeUkxdjVESXZw?=
 =?utf-8?B?TnNxSUVjbEd5Rm96ZjFpaTdUT0VtL283cGhlcnNVVm5lTHdWTUs5WlZqbmNx?=
 =?utf-8?B?NDIrNW9ZaG9Gd05kS0o4NUZ5MzZvRzFIUE1Zd3M5VnI1azlZWmNoOFpVdWpW?=
 =?utf-8?B?TDhkKzlxRCt6UFN2cnEwVVVXMXVDQ3QwRFhRUldQN01QVEgrTlVhU2o4cjV1?=
 =?utf-8?B?WTFENDExOWwwR21wcUtRNkFmUDRETFB3NGtyMDVNdkZEUzBMMFV6bU0rUFM3?=
 =?utf-8?B?LzFuU3l6c3QzenZrdGVzTWFUQ3NCUkNieENvblpFZ0tZajNGY1RhNEFmZzFr?=
 =?utf-8?B?OUkwTXdsQmxCTkF6Z1FpVldlb051ekIyMnBPMllSR3J2LzZ0NkM1MEhYTkZR?=
 =?utf-8?B?UFZNaFd2bUVRMUJ3WElLcWhZUjFQRGVFR0w0K1I2U3IvU2dvVTRXd3JrdzJp?=
 =?utf-8?B?ZitBNXJueHFaZ3B2bmthTFFCVWJROW4xYlAzQUlhUE42TlhTZ1plZ2pjdGJU?=
 =?utf-8?B?dFMwNlUxOXpjWE1xYXFtdkJSRks0WnVwblcyMnI4bHFyc1NUYlRXbjBVM2p3?=
 =?utf-8?B?OUNtOUttRUFveVFCeStmQnFQRjZFOXBxWXM1bXJ1aUpmaW1mT0FmSk90cGpQ?=
 =?utf-8?B?TGh0YVIyTXo3SW1lT2FJMmczVk1TY093c0hOTjR0L05XRExqOUJnTk9ESWZM?=
 =?utf-8?B?SmJ6aGZvRnl2RnFxa21PWi9LRDlQWnlueTdVYnI5UzRXMXhWMVk5U0ZkL1Iw?=
 =?utf-8?B?eHkvWmZGRkNXTVlKMkJJWkVmVVcrOFlEUU1SSmdZVTVKdWFMNkZVQ2NmUnFP?=
 =?utf-8?B?UnluZUhrb2dlWm5TenU1S0lLeVpmZDV4OHpoazJsblpFcUhxZi9vZjJoQis5?=
 =?utf-8?B?ZXNscEozQWhsN2lDUVVZVXBvNEtSUUJwM2ljS0gvYmFwRDFhR0l5TFpkV1lp?=
 =?utf-8?B?SlBYT1kwb3hvamR0aUJHdUxobis2ZCtyeXk0alpnZnlDSnVLSmxKYVRkQUta?=
 =?utf-8?B?L3dQQktaRVBwMXlENEFCcUNMcXh6Z3FMZExRdVAyMTI1Zzc2Tm9BeWd5dkhk?=
 =?utf-8?B?L1JUNDRjM2pibDh5c1NZM3IrZC83ZGZHS1FaYVNTTXhOTFhaNDFjeVMwYkRD?=
 =?utf-8?B?eGNxdE54K2hJSnFpQWhydTd5SlpyZU8xTG5YQTZXUktaUk1MUnFTTXQwRUds?=
 =?utf-8?B?SFFUQVcrVnk0QVIvc05PSm42S3JpQ240RXRCNTJKeXN5QlFuRHorWTBXSW5M?=
 =?utf-8?B?UEdPSXJKbUpMTWw4WldKVnJzc0ZMV3dsU0EzZE15YlFZU3FRaThMejNxUk51?=
 =?utf-8?B?VksweHh3MTZSSzJ4eFh0Y201dVJyU3lQRWNuMTc5a3RNYnlNL2xWaTFmU21v?=
 =?utf-8?B?UElpYUZFREhYNWljUFpmd25ocEVFV2Z4ZEZCZjdtTXpUVkhoMldIbUZUNXFo?=
 =?utf-8?B?cTZSOGkyVDhJUVhwNHhwUDllTlBMejZxb29PMzRCWnRLb3ZXUGdjU1hXTWZD?=
 =?utf-8?Q?6s363yw0EpqSJ6tz4+tzjJRUH?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <F84C846A73488642986AC4281F65A033@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 21c819eb-1780-4de7-031d-08da76e28be9
X-MS-Exchange-CrossTenant-originalarrivaltime: 05 Aug 2022 13:01:00.8180
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BaBFhmhteHjZoPfGDtymBFxKhWWG4vpsKDQsXnSEeQqqBOUoT2T19q1aQ/WcHn4sJw5mrFCW5Dd1hu/vMYlG7se1jwnQj6vyRWGKZpbPefA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB2799
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDUvMDgvMjAyMiAxMzo1NiwgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBUaGUgImRhdGEiIHJl
Z2lvbiBvZiB0aGUgUG9sYXJGaXJlIFNvQydzIHN5c3RlbSBjb250cm9sbGVyIG1haWxib3ggaXMN
Cj4gbm90IG9uZSBjb250aW51b3VzIHJlZ2lzdGVyIHNwYWNlIC0gdGhlIHN5c3RlbSBjb250cm9s
bGVyJ3MgUVNQSSBzaXRzDQo+IGJldHdlZW4gdGhlIGNvbnRyb2wgYW5kIGRhdGEgcmVnaXN0ZXJz
LiBTcGxpdCB0aGUgImRhdGEiIHJlZyBpbnRvIHR3bw0KPiBwYXJ0czogImRhdGEiICYgImNvbnRy
b2wiLg0KPiANCj4gRml4ZXM6IDIxMzU1NjIzNTUyNiAoImR0LWJpbmRpbmdzOiBzb2MvbWljcm9j
aGlwOiB1cGRhdGUgc3lzY29udHJvbGxlciBjb21wYXRpYmxlcyIpDQoNCkkgb21pdHRlZCB0aGUg
c2Vjb25kIGZpeGVzIHRhZzoNCkZpeGVzOiBlZDk1NDNkNmYyYzQgKCJkdC1iaW5kaW5nczogYWRk
IGJpbmRpbmdzIGZvciBwb2xhcmZpcmUgc29jIG1haWxib3giKQ0KDQo+IFNpZ25lZC1vZmYtYnk6
IENvbm9yIERvb2xleSA8Y29ub3IuZG9vbGV5QG1pY3JvY2hpcC5jb20+DQo+IC0tLQ0KPiAgIC4u
Li9iaW5kaW5ncy9tYWlsYm94L21pY3JvY2hpcCxtcGZzLW1haWxib3gueWFtbCAgfCAxNSArKysr
KysrKysrKy0tLS0NCj4gICAxIGZpbGUgY2hhbmdlZCwgMTEgaW5zZXJ0aW9ucygrKSwgNCBkZWxl
dGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmlu
ZGluZ3MvbWFpbGJveC9taWNyb2NoaXAsbXBmcy1tYWlsYm94LnlhbWwgYi9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJveC9taWNyb2NoaXAsbXBmcy1tYWlsYm94LnlhbWwN
Cj4gaW5kZXggMDgyZDM5N2QzZTg5Li45MzU5MzdjNjcxMzMgMTAwNjQ0DQo+IC0tLSBhL0RvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9tYWlsYm94L21pY3JvY2hpcCxtcGZzLW1haWxi
b3gueWFtbA0KPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvbWFpbGJv
eC9taWNyb2NoaXAsbXBmcy1tYWlsYm94LnlhbWwNCj4gQEAgLTE0LDkgKzE0LDE1IEBAIHByb3Bl
cnRpZXM6DQo+ICAgICAgIGNvbnN0OiBtaWNyb2NoaXAsbXBmcy1tYWlsYm94DQo+ICAgDQo+ICAg
ICByZWc6DQo+IC0gICAgaXRlbXM6DQo+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBtYWlsYm94IGRh
dGEgcmVnaXN0ZXJzDQo+IC0gICAgICAtIGRlc2NyaXB0aW9uOiBtYWlsYm94IGludGVycnVwdCBy
ZWdpc3RlcnMNCj4gKyAgICBvbmVPZjoNCj4gKyAgICAgIC0gaXRlbXM6DQo+ICsgICAgICAgICAg
LSBkZXNjcmlwdGlvbjogbWFpbGJveCBjb250cm9sICYgZGF0YSByZWdpc3RlcnMNCj4gKyAgICAg
ICAgICAtIGRlc2NyaXB0aW9uOiBtYWlsYm94IGludGVycnVwdCByZWdpc3RlcnMNCj4gKyAgICAg
ICAgZGVwcmVjYXRlZDogdHJ1ZQ0KPiArICAgICAgLSBpdGVtczoNCj4gKyAgICAgICAgICAtIGRl
c2NyaXB0aW9uOiBtYWlsYm94IGNvbnRyb2wgcmVnaXN0ZXJzDQo+ICsgICAgICAgICAgLSBkZXNj
cmlwdGlvbjogbWFpbGJveCBpbnRlcnJ1cHQgcmVnaXN0ZXJzDQo+ICsgICAgICAgICAgLSBkZXNj
cmlwdGlvbjogbWFpbGJveCBkYXRhIHJlZ2lzdGVycw0KPiAgIA0KPiAgICAgaW50ZXJydXB0czoN
Cj4gICAgICAgbWF4SXRlbXM6IDENCj4gQEAgLTM5LDcgKzQ1LDggQEAgZXhhbXBsZXM6DQo+ICAg
ICAgICAgI3NpemUtY2VsbHMgPSA8Mj47DQo+ICAgICAgICAgbWJveDogbWFpbGJveEAzNzAyMDAw
MCB7DQo+ICAgICAgICAgICBjb21wYXRpYmxlID0gIm1pY3JvY2hpcCxtcGZzLW1haWxib3giOw0K
PiAtICAgICAgICByZWcgPSA8MHgwIDB4MzcwMjAwMDAgMHgwIDB4MTAwMD4sIDwweDAgMHgyMDAw
MzE4YyAweDAgMHg0MD47DQo+ICsgICAgICAgIHJlZyA9IDwweDAgMHgzNzAyMDAwMCAweDAgMHg1
OD4sIDwweDAgMHgyMDAwMzE4QyAweDAgMHg0MD4sDQo+ICsgICAgICAgICAgICAgIDwweDAgMHgz
NzAyMDgwMCAweDAgMHgxMDA+Ow0KPiAgICAgICAgICAgaW50ZXJydXB0LXBhcmVudCA9IDwmTDE+
Ow0KPiAgICAgICAgICAgaW50ZXJydXB0cyA9IDw5Nj47DQo+ICAgICAgICAgICAjbWJveC1jZWxs
cyA9IDwxPjsNCg==
