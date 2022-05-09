Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D1551F4C2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 08:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiEIGkV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 02:40:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229586AbiEIGb3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 02:31:29 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F8791649A2;
        Sun,  8 May 2022 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1652077653; x=1683613653;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=yfvG10XrnhwGAAePgBqghr3WRqOoC3+fKCu2vwjHMT4=;
  b=SGQqoMu9YJg9hhpDoRrJwzw/4YtyqSxwi+WfY6oGXm1FE6xjPwH0UGV9
   /GlN0PtHVFi1JFkHPYNsvEtYGvQeXgVCfsl+caT4C2fR9wJYzpLyj0rxv
   GHWSdym7yiWw0H066e4VTUJMw5jGx7m2Zp1TvwKFmBH36zPCwgs9ap4pX
   pqh4i5gULmZWoI+cVzDCnwifrjEf2WEiA4veMPhdDLt9ZFooVwn2+IwiV
   FsOoNSobYj4+Gqv7AIM72rX41G+7KiMCB3tUsiDFZJatf9AJT+2FYUBE9
   nr72WZcfPYZVEwHk6ZRTKR7s/DIt6WVFvtVeWmPrk4O2b6H8/16l9uneY
   A==;
X-IronPort-AV: E=Sophos;i="5.91,210,1647327600"; 
   d="scan'208";a="172456599"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 08 May 2022 23:26:52 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sun, 8 May 2022 23:26:52 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Sun, 8 May 2022 23:26:52 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AxgOnZRLZORyYTEVJohyatWa9CHBbvRP8cAeSTQ+NSGFObbX1X8YCfSXkPQRjg7pp/k//A3qdw5CQuaLFGzEPMS51Xvq/eCXi385TkZsCfs8QSnx4AQh6Wgj8DDZplgZeGajzaql0OEbkefnUs9Z1ZVxLN/JeR/48GhYzlL0jJifAN7O1faAyyFbt38T5EgvcJREaMFnnqh+bbNx3Nwzn1iHXReL4o4DuQWZ784hfbBZ+qkrO6o4X+FfEPs/07klkfulNrZ67YYpjTee7aZxz5Qq2Q8pt+ouzLnVAViAdBiCHZgA31ZoONJbV2Pe0oPTh3uG2rg7wWBHppCFjq/d1g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yfvG10XrnhwGAAePgBqghr3WRqOoC3+fKCu2vwjHMT4=;
 b=beSvJQ3LcEMLQCXmimZBsCIkxumLjYagRWBfyrV9f2rfT1VrjQfJXmOd/BxQ+/4g4OIRvRqfd8fUwPK27ZKHZPVe7Db+KOrmtMTchNztJqJs55+BBKQpyeVqDskLm40uP4JVWbOmcvPgoRIlxOBzO5535TgA0IGjZiQWHR07aOM7CCBgExIPAINyysi+fI5WwWLj4n5qZE92M9i9FZahF/jE3XdXdWwRCQ3JqXDfEGRxCU6tl1bum9h08zyxY5qvpgcrXFX6eeHBNaR3/UvCwFtkqOCX2MGCDUPIB95McnC/F470outL6/3gIIw26XFRfJr2o4rZ/dtVzsA/yYRwiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yfvG10XrnhwGAAePgBqghr3WRqOoC3+fKCu2vwjHMT4=;
 b=LYRHXJiQEKmgxDPWqwvXqSrnsl5C7YpuqTCnA/h2arHt3zFki7PyLcs7+hHd0Sh55WCozAw2kpAmW6CG20OYAHFzmWrTXAEHN8KXPYQutUtN8NrmjK0CzBQkxmN1dTnQD5L7WI3sZRUfmU/fWa3cvedLYpUdwzKdWEYkua+Ks80=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:95::10)
 by DM6PR11MB4121.namprd11.prod.outlook.com (2603:10b6:5:199::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.21; Mon, 9 May
 2022 06:26:48 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::e906:3e8d:4741:c0f0%6]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 06:26:48 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <michael@walle.cc>, <Kavyasree.Kotagiri@microchip.com>,
        <Nicolas.Ferre@microchip.com>
CC:     <arnd@arndb.de>, <olof@lixom.net>, <soc@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <alexandre.belloni@bootlin.com>, <Tudor.Ambarus@microchip.com>,
        <Horatiu.Vultur@microchip.com>
Subject: Re: [PATCH v4 11/13] ARM: dts: lan966x: add serdes node
Thread-Topic: [PATCH v4 11/13] ARM: dts: lan966x: add serdes node
Thread-Index: AQHYY23CripvQdzo80if9kXNEcHuxg==
Date:   Mon, 9 May 2022 06:26:47 +0000
Message-ID: <743c06e8-a53b-4546-cad7-27e7a3ef77b6@microchip.com>
References: <20220502224127.2604333-1-michael@walle.cc>
 <20220502224127.2604333-12-michael@walle.cc>
In-Reply-To: <20220502224127.2604333-12-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 733d6ebc-b8a2-4a42-a8fd-08da3184e549
x-ms-traffictypediagnostic: DM6PR11MB4121:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4121CFEE9C8604B9353B897687C69@DM6PR11MB4121.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: L8rsB+YhakeVus+hyU/kXBDasnLwdouMJAdiA3rc64m9BmxOsTEqEx4eNjaqxA1YTqL+erC+C5G17XCfCJfjKW57Bryg5fncxnguxFekCAq4L6LghpGHc4cMjovy5raswRqeR2gzMJKii6Lv2q3PqKpnhXWFiqFLWBu1GdQSamMNiu77dRjLwDGqf+sGpSKb1Xu3ih8kj95McigbVOzhdhtce4D6IixPoX6xU7bKYepMuaBSEwrc9pXeLAvTbS9sMBCgXuJp6iSG2zvPdMGnRD6ZzXq72cM5DGHo6V0ohIyrQjO9EUgCrGm9+VXdCrd35I5XVSQvdYlkvdtH3W6LXeQvqCSXJ7UMR9adlMQl8TPVy0tWLQ288vpRw+q8qmhxOk5avnnops4ml7lIcJNANJnrJixHyAQX+91QbX3Nl6RbRxHCUjceX9/hF32SCOGJgWliIJsoZMRoQVYmnMDiI7o1qAFqJxwW6CCv6fNg+Rm52AvK09tT2ew1rg3EuYzW4LGJOrl8vlYRHnfff+HUF9l713y9gSndtuHvdUruo4GsByez7RD6c2gv74QHt6KVigseZGiRaA0yS5ELyV2XMX3W2UuKftK5B+Ma/ebBEF2ddj8rkkt5gBodhTstuBKLhLtXldrXOyeopFFbC4L55UmapVracddiVUhOagJfne6dcDKwYB4XlQTy+pbgf2hDR9Gt0rFDzcCm2tCKjO9FXuCp9+pdy6uUF9CvE2bIyZT2rCLkE8xFK4RZpcfQvwOQoi+qkent8zbRlECNQMrm5g==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(7416002)(36756003)(2616005)(107886003)(5660300002)(110136005)(4326008)(6506007)(186003)(53546011)(26005)(31686004)(66446008)(66476007)(6636002)(66946007)(76116006)(8676002)(54906003)(64756008)(2906002)(66556008)(91956017)(38070700005)(71200400001)(122000001)(8936002)(83380400001)(6486002)(38100700002)(31696002)(86362001)(316002)(508600001)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?OUVBOFRkOGhBTzNBeXp6aSs2SHJSOG5ic2NXVjA2NFVNWkNFZ1EwbFNwd0s5?=
 =?utf-8?B?bzJKeVBPWFhzbk1mR1hNTER4ckRpa1ZIcWlVRVQrdkpGaERtUU1RVkRpNWtW?=
 =?utf-8?B?cWEyMTI1emxod3FJQTBsRnFWNEVZOGUxbTQ3RXN1cVJpdTFlbk80ZTBSUDhW?=
 =?utf-8?B?ZlNtMEEvRHVDS2VWREdWdjZrbWF4TFU0UjRWaGZldGJIOFQ5elZtcWU4WWNS?=
 =?utf-8?B?TkVtZlkrMVpYcm0wK1BPZTJjOUtpS2Q2aXc1RGY0NEM0UGVZNW9XdGNyOW5m?=
 =?utf-8?B?YUZwb1RqQm16TEZ0Wi9GYnpGUlVGVFVRTmRXTXFHbm9sWEdTWHhTTnI0UW9p?=
 =?utf-8?B?SnpFQkw0SkZKb1pwWU1nN2d0aytNVkNkcEZ4UkI0UEJacVg0Sno2YW83V1ZC?=
 =?utf-8?B?K002R2YzdmFQdzNTdVRUWEhDZUJoeXlPYkZWWWNJQUFvWE5DNnFzTk9Xek1y?=
 =?utf-8?B?NWUyQ1FqV3lvK1djYTlUSVlHS0kyVjFrQ0ZjNldCZnFlalFnT1RWRTJ3Z2Zs?=
 =?utf-8?B?RTkxTEwxVncyY1R0aER3UFA1aDFkdUN2Vzd4bjBJaFNyZFdiR3VmajJrd1J3?=
 =?utf-8?B?T0dTZDNiTmNyUXpBZ3pMSWN3d2QvZi9QSGpXcU9vZ295QVB2bWNKZ0NMWGJL?=
 =?utf-8?B?YWFOT1Z6UkkvcUVmb08ydTJHcE5WVWNDN2xXdjNLZTlZV292UGdZUzhLUDVL?=
 =?utf-8?B?SWxtRTF3alIxMFZvZlZPbGJLMS9VaDNudVI5MWt4amFPVk1WMDFiTVpqbkMv?=
 =?utf-8?B?ZEhmTm9CbVZqMUpoZ2J5ZjRVSlAya0R3L2c1NUo2YmxkZ0tFRmV1VmEzd1d6?=
 =?utf-8?B?TjkzcFBUK01mdzl4YUExMlJiR3lwaEExY0hEaHBpYVMzV01nWTBDbUxVYWtz?=
 =?utf-8?B?T2YyNzV3c1hVcG5TYzhVYVM1TFVhaHpsL0xZQzcrZytVdmlIY1RrcllIK2FO?=
 =?utf-8?B?aENnZnkrT2JmZDhhQVJla3g5Wlgwb1VLblFhYzRtT2loU1kwMFNlL2llYk1C?=
 =?utf-8?B?d0c3Q051RGdqTjVnSTZzaW9lcWZMMG80NkRlcDFjSERtVWltcmJ6MThOYkZi?=
 =?utf-8?B?ZTRTNjRicDVneGQ0US9GOXpaZ3NpdE9MdmRHaDVNcXdxUzNOS29yZCtsQTgz?=
 =?utf-8?B?ZzRKMTUvQ2FWcHZOTHF6OHh1WEd1TTRZUncwSHZsR01aUU9MM1dwWWdhVHFy?=
 =?utf-8?B?U3FqWDkxeWx6ZUgzYlRZRC9oR25mZ1RaUHJBRzN2bDllRWQ0cy9PZXlrSy9U?=
 =?utf-8?B?RDJtdm1IZFNhRWpBQkJ3WU9HN2t4cVBMSitubXJjZG1SZFFtdVhxQ0dacGtw?=
 =?utf-8?B?RDZSVmR5V2M4RjV6L1VMcWhUTU1jRlltMFR6S29IakhBbEJsSjBYLzkrbDk5?=
 =?utf-8?B?SzlPTEhxRkhYcTF0MVJia1NtendOVjJLK3dtUkZNN0ZGTUNqZU9vcHNxOVls?=
 =?utf-8?B?c3dwY3B6Rk9ESzZhOWRpaVM3MGNOQzFsUlIwcE9WU1IxTEJTeHJoMWx4a0Jp?=
 =?utf-8?B?eW1FK0ZxVUJzOXZGaFFJVEZIYTVvY1RVbmdZekRDS0lNc1JkVklWaUw1M2Mw?=
 =?utf-8?B?ZzgrQUl5V3Q4ZmFlSkRPRDNzQlVyNDh5ZEFUeVlnOEhYNDRCTy8zZUd5ZFg2?=
 =?utf-8?B?RWZxcFV4MjBMVy9qNE1zZmhUTllnenJ1MW1vbjFXcStCQ1N6NWZPQ3lUUmJ0?=
 =?utf-8?B?SEpDZkx2Z20rd0RVSU1ySXJ5eGNIa0FEbXFrb1IwaCtkWHQ4ZGZhSDZGaGhP?=
 =?utf-8?B?SEFUTHZldXFWOGlFdlZrSEVyREZBU2Y0WGgzdHdhY2pxNnd4cGZHdGZJNGIr?=
 =?utf-8?B?b2tDa1JCVk92M05Oa01zZGdTWGwraUxHNzk1Z2svSXBLcG5NRGFHVlgzSHpx?=
 =?utf-8?B?Q0Q5Lzd1ZXFhWkdzQlIyS3pOWUhldG45YWZyUkFJbk5Bc1Y1RjJveEF1VTJq?=
 =?utf-8?B?Q0tZcXBlaVRwQlJPZkFtZVc5TjBob1MrOU13MG1QSXljNnhMQzVCRzlCMFRS?=
 =?utf-8?B?ZW9NdGVWMThVZzJ1a2RXclYwZ2NMWUYzWUVYT2FiSTRWZlEzeFcxa2VRVnJx?=
 =?utf-8?B?K1QvUVJrMzI4K1E3WWo4RGhzaWxlbDB0VDBZQmVQblFUcGZ2NmQzVHF2bG5m?=
 =?utf-8?B?dU1waG1NZEpIc0NTR1lJMFNXeklTQjgvQ2kyUklRSzBRTlNvcGE2VjJyeVVK?=
 =?utf-8?B?RkhLckE1QTY2WXBSRXFvQzNuL2hRenJPKytHTkRKS3ZsbjhHd1laWCtPdWpJ?=
 =?utf-8?B?cVNKTlJiWkNSakUxNWlaTzJYZ0JvNGtpd25BNGVpei9oc24zMWJ3VFQ1VzJj?=
 =?utf-8?B?bEhZZW5TNXVnaVJvTWtHb29XazRWbTVLTEx0cDJIdDczR2U1cHdqZDBxQU9R?=
 =?utf-8?Q?JZfQUxmnf2Ks/FPA=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <E1DBA549D32AA146926F1FF91F9436F6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 733d6ebc-b8a2-4a42-a8fd-08da3184e549
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 May 2022 06:26:47.7975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lghEbiPwUgkGOENuRsTR1d8DHOj24Juqy54lTxasjSrIeHXSyktnNEt/IN/ajfwwM4BoI2ZMHGScg22tRfFMnKzmxIYWnv2aZ0Gb6/XF8I0=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4121
X-Spam-Status: No, score=-5.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDMuMDUuMjAyMiAwMTo0MSwgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1B
SUw6IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25v
dyB0aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBBZGQgdGhlIFNlckRlcyBub2RlLiBPbiB0aGUg
TEFOOTY2eCBTb0MgdGhlc2UgU2VyRGVzIGFyZSB1c2VkIHRvIGNvbm5lY3QNCj4gbmV0d29yayBQ
SFlzLg0KPiANCj4gQnkgZGVmYXVsdCwgdGhhdCBub2RlIGlzIGRpc2FibGVkLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogTWljaGFlbCBXYWxsZSA8bWljaGFlbEB3YWxsZS5jYz4NCg0KUmV2aWV3ZWQt
Ynk6IENsYXVkaXUgQmV6bmVhIDxjbGF1ZGl1LmJlem5lYUBtaWNyb2NoaXAuY29tPg0KDQoNCj4g
LS0tDQo+ICBhcmNoL2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kgfCA4ICsrKysrKysrDQo+ICAx
IGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9h
cm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNpIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFuOTY2eC5kdHNp
DQo+IGluZGV4IDcwMjBiMzEzMjJkOC4uZDgxODVmNWM3YmZjIDEwMDY0NA0KPiAtLS0gYS9hcmNo
L2FybS9ib290L2R0cy9sYW45NjZ4LmR0c2kNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvbGFu
OTY2eC5kdHNpDQo+IEBAIC01MDAsNiArNTAwLDE0IEBAIGh3bW9uOiBod21vbkBlMjAxMDE4MCB7
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGNsb2NrcyA9IDwmc3lzX2Nsaz47DQo+ICAgICAg
ICAgICAgICAgICB9Ow0KPiANCj4gKyAgICAgICAgICAgICAgIHNlcmRlczogc2VyZGVzQGUyMDJj
MDAwIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgY29tcGF0aWJsZSA9ICJtaWNyb2NoaXAs
bGFuOTY2eC1zZXJkZXMiOw0KPiArICAgICAgICAgICAgICAgICAgICAgICByZWcgPSA8MHhlMjAy
YzAwMCAweDljPiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgPDB4ZTIwMDQwMTAg
MHg0PjsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgI3BoeS1jZWxscyA9IDwyPjsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgc3RhdHVzID0gImRpc2FibGVkIjsNCj4gKyAgICAgICAgICAg
ICAgIH07DQo+ICsNCj4gICAgICAgICAgICAgICAgIGdpYzogaW50ZXJydXB0LWNvbnRyb2xsZXJA
ZThjMTEwMDAgew0KPiAgICAgICAgICAgICAgICAgICAgICAgICBjb21wYXRpYmxlID0gImFybSxn
aWMtNDAwIiwgImFybSxjb3J0ZXgtYTctZ2ljIjsNCj4gICAgICAgICAgICAgICAgICAgICAgICAg
I2ludGVycnVwdC1jZWxscyA9IDwzPjsNCj4gLS0NCj4gMi4zMC4yDQo+IA0KDQo=
