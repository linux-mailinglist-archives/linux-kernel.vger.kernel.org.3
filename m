Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE8DC4CCEF1
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235378AbiCDHQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:16:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbiCDHQc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:16:32 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 707C51903D9
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:14:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646378091; x=1677914091;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9IG6jhAZirHune+OrkR4glFVjKcrldoM6YWSGiQKUfI=;
  b=ffrOkMYgfFEOJp3SQu/BAGw+gbRoFD9LM34wCxv37NCnMf+FsYGxhYi4
   6Y2D2W64mo8x02Na2yq7N597+2MwwatyZaMA8EoIWBfr2tW8o3CVYE+A1
   PaGOhDRWgbyoe4mC62ej6YK6lJAztobkS9TYgnqT2Fp3N+6fHZxsVR5cL
   n9K42MCjUYrUQmJM5hrJUCeLUkvsoFdEIpID2VdcDxWHUM3Aq6OpjaVHz
   3dsmcMBnmhaiB1lT7e4I+qRtUNuWsml05StsQHuWz3Iy3ZkEyn695BYK+
   r0C4gWFkFoJkWv/S33W3xH2BLqAdMtJkdlV/Ta4VPAOlit0a9ECJ/QogT
   g==;
X-IronPort-AV: E=Sophos;i="5.90,154,1643698800"; 
   d="scan'208";a="148065389"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 04 Mar 2022 00:14:50 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 4 Mar 2022 00:14:48 -0700
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 4 Mar 2022 00:14:48 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=XZM6bKm4YCKL5fdMA3+/ly0u3fnq1cNmXD6wC2CpuTYuT8vGGJNlByPxvtFpHR+/VOIoBDxzWWICte0cvQuW6+IQ1gsdQGrO8Iy6PRAGB6Bso+QcCmXgDTgsaUckcahZf1po267PMJnn9Qf2SOdOpy8y1fvTORoI3wC/DSGlvUyUWhG6+jAcYzdl9ZOXDMmsBa3aLdD9TWl139xB0axNOIbk0sZJMxkBN3yJ0vHAuF7qi+WKOFWB9iWsBNLDwNSiaFh12Oj7oGqD65YxNVI2iJfIGmFrwGT1vp4yldIW9vm1RkncCzhFxr1XB+dHkV5CqUwunYOkmUSEloZ+yO2/wA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IG6jhAZirHune+OrkR4glFVjKcrldoM6YWSGiQKUfI=;
 b=G/pHt7jlaWO5wJ9t7w26XPiTbjLjVnOvV37SoXonxteCNMgBbJSiZ21uAG9s4VM3bfMADUsrV15r0sfwwoh9XR054+w/4yHIrdBHKXkJZ8XT7gYMjGIaLeg8XczI9/D8Gbs5U+SGyji7L2g6wphREkF+VPXtGTA16Dj0FAzX7NXkryFsmj6vPw6YOm211sKCZEFvwyY+CUEdx5MuKsI5MyI/VKwgd3R+F9gtjhKhp4miR/r+D3Fo1xsN+StkWw4txZqd9K/CDgwjp4gsNOh85Qa1mwMYJqnwIYwOx7VYD4baUbJ+iEeE5fqcYEI8lI16IVp6lJTVHaC89LuiLy8roQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IG6jhAZirHune+OrkR4glFVjKcrldoM6YWSGiQKUfI=;
 b=O1+Pt4EcfhL1/vRualGk4Ds4fF5sB0KwFFdGsr26IWn+xJ8hkVNntK12Pt7FLsfWGvF3LtrM3ajzzZhf2W5nk+M1MsVXzu+763FJ9EYBkH9vxZNoekZMysS6pJ6uXzI4YmIN3rLOOp53PnveGPtHMCbtZMjQbmE0duJpr4NmZig=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by CY4PR11MB1703.namprd11.prod.outlook.com (2603:10b6:903:28::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.26; Fri, 4 Mar
 2022 07:14:34 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.016; Fri, 4 Mar 2022
 07:14:34 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <p.yadav@ti.com>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <heiko.thiery@gmail.com>
Subject: Re: [PATCH RFC] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Topic: [PATCH RFC] mtd: spi-nor: unset quad_enable if SFDP doesn't
 specify it
Thread-Index: AQHYL5d/jpcpB1/rxkG/T2FcgyF9AQ==
Date:   Fri, 4 Mar 2022 07:14:34 +0000
Message-ID: <0d0e69dd-480f-4f15-2339-9cb71f0c698f@microchip.com>
References: <20220301124935.2893622-1-michael@walle.cc>
In-Reply-To: <20220301124935.2893622-1-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 96ea0461-c3aa-46f3-ef2b-08d9fdaea2dc
x-ms-traffictypediagnostic: CY4PR11MB1703:EE_
x-microsoft-antispam-prvs: <CY4PR11MB1703E47903E92F838A18C708F0059@CY4PR11MB1703.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9qP6T768D10i0DCtjXRLeiref035PDIunpaowovpWVF0sU5X9Qppm0dZI8h6FllcT8IIFfgeV0rqk7YRUDD8zy3gA6AdFb8EE1ZLTRz90IVJp1Dsa7R8DiLRtPhAIbA1KqeJMJmcIHR5+ccJgWFJ04jyFC/OIA0+ohMcdQDWQHfkkZQHX8350H8N8VSTTc8J+CwB+tNU5CmNhPotdbnDic5OoPWyirFzyhgqR4GYJR+ioH4NkygCpS6ZMbJVCvT2t233zbafqhWJ/q3pA6RsHV2qXV7eF0bqJXzi43K2hxekeLkpTLTwAUw5ysoxwwl9xDfIuHartDpT7Bpma231/RQ7qR9IwDu1MHKP22LoioZkAckSV1JoA6tsrfzVM4uARt6rftE+2/wJetgkZ+xloUjj2uAZ9R051PXv3wU+vdCaRdXi2XpSl8sIRQhOGeqV+zgGwxrqPrI0fdyF5HcERduUIaZ1nweJurj1YjkVvZwv7RfoEdNhj5MKoLg9l08N5T7L7DNtEGToX/aLNCaq+ymUCYbIxU40TPLS6A7Vd0prE3fPam0z7ckaOIufL39+PjZYeeeDh1AD8Ydga5KsfH3ZwdqlqK3HGMEV+hA3IYE2XdSdxXalxdX9hkbhqHMoc3QbwqEffNwh7Gu2eq2ezlag4Rbm1/Ox08ZYmQCEN9zbvuZDjaqSnY3iNF9e9PMy09puyB5r3TuOQF0GLfe760TUe3nltTGAsJMIrO1PuXMjKwQJU4/TKoASvNQdXVn/GhAyhjxUoS+bcCiBaijQ9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(8936002)(64756008)(83380400001)(6512007)(4326008)(76116006)(66556008)(66946007)(66446008)(66476007)(2616005)(2906002)(86362001)(26005)(5660300002)(186003)(31686004)(38070700005)(31696002)(8676002)(36756003)(71200400001)(6486002)(508600001)(316002)(110136005)(54906003)(91956017)(122000001)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?V2ZBR2RtbWQzTEkrazJ1VFZUYldVWncwQmtHa05uNWZNZFN3U3BMSFk2UzRL?=
 =?utf-8?B?bDUyVW5rSmowWTIxWHloZnhnU1pONlNweFVZdVNaeVFDVFFkZ1lnTEZTVnhs?=
 =?utf-8?B?bzFqY0JuZE44ZlpnVTF6NCsrbzFCZk1TTFlHQUI5dFUwSERaYzVFU0s2UHZt?=
 =?utf-8?B?WlZhYXkxWkZ1dFQ4WXl5dnN1R0ZlWW90eWcvQUtoK1ZhZmFSUW5CRE9XMmhZ?=
 =?utf-8?B?UzExeHJxejhYVDBneGJ0L0ZaN2crRktINDZURGVqc0J4NWY3YncwTFo5NDFV?=
 =?utf-8?B?eXlTbkZUQ2RHazE1YUJZSGZBOGlCZHI5WUZVVWhGd3F2czVCc0xqL1ZxVWNh?=
 =?utf-8?B?Y0RGdVNiazc3OEcrZlJ2UzZQZGN3UW8yMjdET3hOSytWejZDbkx2NEdBOG9K?=
 =?utf-8?B?SEJUcm80bEhRallkZ04wb0JzVWRRZ2lnSU5pSXNxWUdpajRxemM2REhISHV6?=
 =?utf-8?B?eGVoRGJNeDF6aG54enFSVXpGUG91WHkxTVA1aUpjOFZDbWozaER5MG1HNWdM?=
 =?utf-8?B?RGhZMktvSWhVaXlqNnppRjFEdVZtYzNnRDlFdVdGSXpPZU0vWmU2MTBvRGEw?=
 =?utf-8?B?MGM5QVlpbThQdnVIQll1dWV4Szl3MzBoeEtobERFMWFUaHhWNzQ1dnJBaVZy?=
 =?utf-8?B?OWVvNDlqNXR5Rk9WUFRabHprU2hXY1lNSG9wZHY1cXlod2dmWnhua1ZLKzdm?=
 =?utf-8?B?M0pSZkZNSnNOZ0pNa29iZHNiMGowN3pmMUlJZ0hSYjlvT2pwOVlNV29FejhS?=
 =?utf-8?B?dG1KaUVROVRYNGJ0ejdoSjRIcUJVdzZibmNkNTMrMU9XOVhPNkhycDQwL0VC?=
 =?utf-8?B?ZFRRZVRTUTM4a2VxTFN2M3h6U0NvcUlCOTFNUHZrUG90cU03M05LYUN6T04r?=
 =?utf-8?B?UURNdys2WnBQSW5lS0FlcjdwTHRUQStvUzlzVTRib3piWklwTVFBU0RMRVk2?=
 =?utf-8?B?MGpDTjJoVW1UWndnNGFlWUdOcEZHYjFVc29Lb3J5WFhMdlVWaXpFMGFSQzE4?=
 =?utf-8?B?N05vaW92MEMvQmFrL2xhMFRNQlJKdFB5RVdFNHBYbDVQTlBxTVloRGpEVUpw?=
 =?utf-8?B?dkxQU2dRKytBajZZcEpNRzd4eEpXZ1haRHFDaE5sTlJ6bmlNQ0VNSElLWDNG?=
 =?utf-8?B?OWdRUlYzSzFXNi9PdW5ZaU9pSHdxLzhVOTdqYTFucUMzeSszRzJZcnR3Um42?=
 =?utf-8?B?T3ZPaVdwRG1zUysrUzJUS2IwRkZJMVJQay9tTGl5bnprTUZ0UkFyYWlHU05L?=
 =?utf-8?B?WG1HUE41TGJ3V0JFTC9FZXFFaU9zdlplTEttRmdSODhaWEg1bHk3aFRORVZH?=
 =?utf-8?B?KzEveTA2WkFVQWpKY09mSjNFcW5RRTFGR2crYTZJRFQxSXpRQnh2UGZjZHdX?=
 =?utf-8?B?V0QzYmRHb1RBTDk0Q0hpMERPWHJrc3NoRGRkK1czVHIyOEFjYjNWc1FFN1BI?=
 =?utf-8?B?enpaLzUxTWo0eThodEtyR0I3c3ZzRVpidXJieDFxeXNCdWVQMDhLMFMzbGpY?=
 =?utf-8?B?WjluUEZ2Zk81c3lscjRhYUUxbDZmMXdoeGhROHNzZmp3L2kxVWowV0xrc0d5?=
 =?utf-8?B?SEFTcERYSlVDUGNrZFJ0cHhsTHZTU3M5aHp5Zm9zODFhbWRIdzdmN29FSTV4?=
 =?utf-8?B?Nml2REFnSzBsd2xSRThuaUlrc1hKNXgrTzNIWEJPOTljRyt5TWNRa1dtZUlC?=
 =?utf-8?B?c0RsUUh3dTZxbUtlRlVVS0RXYkVTWHArNXB3Y05SdStaL2diWUJjZ3Y3TTVW?=
 =?utf-8?B?amUvV21PQUdWOUE1cHFJcHk4eWhIY04rVWE0bVpIWXRDSmhJcFd6N0l5WGsz?=
 =?utf-8?B?Y0kxS2NvdTNnNGYySDcyNy9YQjBlTUNLaW5OZHpLNHcvY0pjQjczOXVheE1r?=
 =?utf-8?B?VGFBbndSY3RmUzAzTVBLTUJDZGJNWFVEbDd0VGY3UVROald3SEorOENDOHJH?=
 =?utf-8?B?Sjg0VDVVdGlDSHZpcjlBUVpSdzJHeTNBS0xPMHZ1WVFxL29BSkc4NFhQV1VI?=
 =?utf-8?B?OWdHV3BXMnRMZ1Q0QWlhZFF3WWtYWkVMdUFPUCttSUdyeDd3TmUyNFpCM1Zo?=
 =?utf-8?B?dUZkZXFhbGF1T2drUWx1SU5aaEwrM0tGdnlNYmJyenI1WDNSeVl6akZpZmNC?=
 =?utf-8?B?T3dkdmZlc2RaMmFzNGYzQ3pHZjYxL05zakNtYWFVRFFWRGdYbGtLd05lU0xE?=
 =?utf-8?B?SGJ1azU4YjJ2YUViN2JvLzhXM1hscTBLQzU3Zjl0a1RjMDljdVFWTTQ1NjRU?=
 =?utf-8?B?aXcyaVBZYmtOdC9KbFJNcE41YzVnPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <349EF893ED4E9A48AD66336EABFED80E@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 96ea0461-c3aa-46f3-ef2b-08d9fdaea2dc
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Mar 2022 07:14:34.7535
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: DprROySMYqUVOkE0oqaTDgT3yx1k/rQcR+JRviqCezV3vmXmh6pAOrVTt0mB5qRgwM/0ieGfgf8JtEm5F7OgWzCWI4+yvDigS/qfjXTOiEM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1703
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8xLzIyIDE0OjQ5LCBNaWNoYWVsIFdhbGxlIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJTDog
RG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93IHRo
ZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IEZvciBmbGFzaGVzIHdoaWNoIHVzZSB0aGUgZmlyc3Qg
SkVTRDIxNiByZXZpc2lvbiwgd2UgZG9uJ3Qga25vdw0KPiB3aGljaCBlbmFibGUgbWV0aG9kIGZv
ciBxdWFkIG1vZGUgd2UgY2FuIHVzZS4gVGhlIGRlZmF1bHQgb25lIGluDQo+IHNwaV9ub3JfaW5p
dF9kZWZhdWx0X3BhcmFtcygpIGlzIHdyb25nIGZvciBhdCBsZWFzdCB0aGUgTWFjcm9uaXgNCj4g
TVgyNUwxMjgzNUYsIHRodXMgY2xlYXIgdGhlIGVuYWJsZSBtZXRob2QuIEZsYXNoZXMgd2l0aCBz
dWNoIGFuDQo+IFNGRFAgcmV2aXNpb24gd2lsbCBoYXZlIHRvIHVzZSBhIGZsYXNoIChhbmQgU0ZE
UCByZXZpc2lvbikNCj4gc3BlY2lmaWMgZml4dXAuDQoNCkkgZXhwZWN0IHRoaXMgdG8gYnJlYWsg
c3VwcG9ydCBmb3IgZmxhc2hlcyB0aGF0IHVzZSB0aGUgcXVhZF9lbmFibGUNCm1ldGhvZCBzZWxl
Y3RlZCBpbiBzcGlfbm9yX2luaXRfZGVmYXVsdF9wYXJhbXMoKSBhbmQgZGVmaW5lIHRoZSBmaXJz
dA0KSkVTRDIxNiByZXZpc2lvbiwgYnV0IHdlIHNob3VsZCBmaXggYWxsIHNvb25lciBvciBsYXRl
ci4gSSB2b3RlIHRvIHF1ZXVlDQp0aGlzIGluLiBNYXliZSB5b3UgY2FuIHVwZGF0ZSB0aGUgY29t
bWl0IG1lc3NhZ2UgYW5kIGV4cGxhaW4gd2h5IHdvdWxkIHNvbWUNCmZsYXNoZXMgZmFpbCB0byBl
bmFibGUgcXVhZCBtb2RlLCBzaW1pbGFyIHRvIHdoYXQgSSBkaWQuDQoNCkNoZWVycywNCnRhDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFdhbGxlIDxtaWNoYWVsQHdhbGxlLmNjPg0KPiAt
LS0NCj4gUGxlYXNlIG5vdGUsIGNvbXBsZXRlbHksIHVudGVzdGVkLiBIZWlrbywgY291bGQgeW91
IHRlc3QgdGhpcyB3aXRob3V0DQo+IGhhdmluZyB0aGUgc2Vjb25kIHNlcmllcyBmcm9tIFR1ZG9y
IGFwcGxpZWQ/IFRoZW4geW91IHNob3VsZCBoYXZlIGF0DQo+IGxlYXN0IGEgd29ya2luZyBmbGFz
aCB3aXRob3V0IHF1YWQgbW9kZS4NCj4gDQo+ICBkcml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYyB8
IDkgKysrKysrKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMgYi9k
cml2ZXJzL210ZC9zcGktbm9yL3NmZHAuYw0KPiBpbmRleCBhNTIxMTU0M2QzMGQuLmMyM2U4NTI3
NGZmMiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gKysrIGIv
ZHJpdmVycy9tdGQvc3BpLW5vci9zZmRwLmMNCj4gQEAgLTU0OSw2ICs1NDksMTQgQEAgc3RhdGlj
IGludCBzcGlfbm9yX3BhcnNlX2JmcHQoc3RydWN0IHNwaV9ub3IgKm5vciwNCj4gICAgICAgICBt
YXAtPnVuaWZvcm1fZXJhc2VfdHlwZSA9IG1hcC0+dW5pZm9ybV9yZWdpb24ub2Zmc2V0ICYNCj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFNOT1JfRVJBU0VfVFlQRV9NQVNLOw0K
PiANCj4gKyAgICAgICAvKg0KPiArICAgICAgICAqIFRoZSBmaXJzdCBKRVNEMjE2IHJldmlzaW9u
IGRvZXNuJ3Qgc3BlY2lmeSBhIG1ldGhvZCB0byBlbmFibGUNCj4gKyAgICAgICAgKiBxdWFkIG1v
ZGUuIHNwaV9ub3JfaW5pdF9kZWZhdWx0X3BhcmFtcygpIHdpbGwgc2V0IGEgbGVnYWN5DQo+ICsg
ICAgICAgICogZGVmYXVsdCBtZXRob2QgdG8gZW5hYmxlIHF1YWQgbW9kZS4gV2UgaGF2ZSB0byBk
aXNhYmxlIGl0DQo+ICsgICAgICAgICogYWdhaW4uDQoNCmFuZCBoZXJlIHRvIHVwZGF0ZSB0aGUg
Y29tbWVudCBhbmQgZXhwbGFpbiB0aGF0IHlvdSBleHBlY3QgdGhlc2UgZmxhc2hlcyB0bw0Kc2V0
IHRoZSBxdWFkIGVuYWJsZSBtZXRob2QgaW4gYSBwb3N0X2JmcHQgaG9vay4NCg0KPiArICAgICAg
ICAqLw0KPiArICAgICAgIHBhcmFtcy0+cXVhZF9lbmFibGUgPSBOVUxMOw0KPiArDQo+ICAgICAg
ICAgLyogU3RvcCBoZXJlIGlmIG5vdCBKRVNEMjE2IHJldiBBIG9yIGxhdGVyLiAqLw0KPiAgICAg
ICAgIGlmIChiZnB0X2hlYWRlci0+bGVuZ3RoID09IEJGUFRfRFdPUkRfTUFYX0pFU0QyMTYpDQo+
ICAgICAgICAgICAgICAgICByZXR1cm4gc3BpX25vcl9wb3N0X2JmcHRfZml4dXBzKG5vciwgYmZw
dF9oZWFkZXIsICZiZnB0KTsNCj4gQEAgLTU2Miw3ICs1NzAsNiBAQCBzdGF0aWMgaW50IHNwaV9u
b3JfcGFyc2VfYmZwdChzdHJ1Y3Qgc3BpX25vciAqbm9yLA0KPiAgICAgICAgIC8qIFF1YWQgRW5h
YmxlIFJlcXVpcmVtZW50cy4gKi8NCj4gICAgICAgICBzd2l0Y2ggKGJmcHQuZHdvcmRzW0JGUFRf
RFdPUkQoMTUpXSAmIEJGUFRfRFdPUkQxNV9RRVJfTUFTSykgew0KPiAgICAgICAgIGNhc2UgQkZQ
VF9EV09SRDE1X1FFUl9OT05FOg0KPiAtICAgICAgICAgICAgICAgcGFyYW1zLT5xdWFkX2VuYWJs
ZSA9IE5VTEw7DQo+ICAgICAgICAgICAgICAgICBicmVhazsNCj4gDQo+ICAgICAgICAgY2FzZSBC
RlBUX0RXT1JEMTVfUUVSX1NSMl9CSVQxX0JVR0dZOg0KPiAtLQ0KPiAyLjMwLjINCj4gDQoNCg==
