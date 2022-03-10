Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D420E4D3F32
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 03:14:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234834AbiCJCPD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 21:15:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230492AbiCJCPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 21:15:01 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA74B1029D0;
        Wed,  9 Mar 2022 18:14:01 -0800 (PST)
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 2BCAF402F7;
        Thu, 10 Mar 2022 02:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646878441; bh=BVilViCLIHXOX50wS72ZQryNeZH9cbeoV4xA5CmQLZ4=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=itg54VDiQb166APi+d6w9GFSKYlyICh3PkWlDR2VVAeBxQM9xbf2T7+JKhugf0gJh
         ltJv0xq6NVsx6zziXrbaGBkURgT9bCqtbjS1qHr7GtD7f1JMr881bdyJsxdW7mNeeG
         FMS8ltNwxAIEy6inDW7kFR4US/2Rcql+nOno8jVFWQ8vVmNum4+uSLhd1M/u6IWORA
         1NgtRSnIef0BEg9nkcTdG3WhO1UeOpSekL7IdJ8EmYaST+VFzvg5lTKN9Jg4d8/JYV
         MpUTfiW3ta9n437E/kmjz9I5FLdu61VKQZNPk1FBdUZjHxOVvJ6NZDZ5EhDjZ8Ljwn
         q+1pQD2QE8yvg==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id EB667A008F;
        Thu, 10 Mar 2022 02:13:59 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2174.outbound.protection.outlook.com [104.47.73.174])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 2FA44400CD;
        Thu, 10 Mar 2022 02:13:58 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="ErCEYj9R";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EVkOxoMdtQ96l8gZKnXB+c9fck/bimSStSKV7TliY9TwKoQ+tGKPZ4WP7eHm3o8qY4vqR2FPnpYpjh68aurvN4Pi2JrN2PXjOtA6S4MRC54816Vj4wdJMaV+DPu9/aS7rQG1v0Agno7AI/DtKOjM4WAEn3ckSxqNtiKixUg2CRXVXG3bPME6wXDoVvb1fTRpe5mTs3D9YhoRTE4wRfM24yxVVsxcr9xxQQRcnQh1EKuqHTBrFerHh+r6TEC7yT/2Us/gfF3MbSnK5HgbZeFNJ3canQ82ejszEBhjbilnz3nbwSLwQirWblVJgiJ6YQhK7S1RAjYW343iJHZHgLBniw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BVilViCLIHXOX50wS72ZQryNeZH9cbeoV4xA5CmQLZ4=;
 b=i6zmkONnDQwzZPkIvfeTKMpCTVvh6qKvva6Ntp7CKbEy+MqmSBFjVSWGWxNKRTLNIZYipYEqjC60o9UTuXAjeUTNLBJQU/q+aKBRwq4w4PVMGZF8lcBNtwUxfgXATu40lwGjXtTd7Zbvf+W+OjuHTSdCN9zQq+cf2E8M5lxpGADJ1+5pM+mDlBQXOZGGyZHAQYq36PhQUb1JEHXcmmDL3DHpsxXOl5WJWU9FNrqR/WQJZUI+fZkgiUc57aS/WPOTKCFNVLFt1OAjh+1NAXUewdwJoN2PyK68339GfcupSbWAEHKffrMTwkA1YCR+bFWzMzd2hhn5wpKk2tSqtJ7WBQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BVilViCLIHXOX50wS72ZQryNeZH9cbeoV4xA5CmQLZ4=;
 b=ErCEYj9RNsGRSPtHh5O5OvgYr3BT4Wo9gN8xuFboQA+x+Uns51F4KOjKDEup/mgNhfmzjz8xC8QgiRozxObuQQViQ4cFggBcy6AYfRhc1rvvsxfZiV8eMjryzGxINAatt2+gcQLmMJggAANOZTSBNCyODgMDgcTz3FszapWoKP4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN6PR12MB1748.namprd12.prod.outlook.com (2603:10b6:404:105::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.29; Thu, 10 Mar
 2022 02:13:53 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.026; Thu, 10 Mar 2022
 02:13:53 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     JaeHun Jung <jh0801.jung@samsung.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
CC:     "open list:USB XHCI DRIVER" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        Seungchull Suh <sc.suh@samsung.com>,
        Daehwan Jung <dh10.jung@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Topic: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Index: AQHYMePmBfflf4nAkkGdLNAaNOlrkay35TEA
Date:   Thu, 10 Mar 2022 02:13:53 +0000
Message-ID: <99eabe6c-8782-1bc6-e1d7-09b019cee65b@synopsys.com>
References: <CGME20220307052605epcas2p2b84f6db2642863ed61373070f508e200@epcas2p2.samsung.com>
 <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
In-Reply-To: <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3c275ec8-2dcc-469a-a977-08da023ba004
x-ms-traffictypediagnostic: BN6PR12MB1748:EE_
x-microsoft-antispam-prvs: <BN6PR12MB1748D893E423A51449643B43AA0B9@BN6PR12MB1748.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: aH4j1rN238/gQvopNBOPgIp0QOnPse7k1sfnWg80qZKK++mCkQWO2KqHfFTMYhcuB3Aua06TcICAr7kIX7MpUUf9GBtHIeEpSxchi1QUpHF/zEOaSVE8yM9ffxe3WPMlaTWe7gr/i2J2LxaKkGgaUYhBft2FBCU6uPHK9RyALJFG09pPcCyqZiQHyq3SXyfR4zWzbqJOoCaLVG2iXARyrWUG5hV7JH1FlfpgeedHq3kay6Sjk8OK0omXHRuJh+InmRpj//5HRL3+LbxwOx4clfvFkkcP5pY4/XOxr422DNXU1VFxzBQ30sP5In24wCiP2c78soJBdGdXkPksb5vUi6fvaJpwHn4/xyGlBdHfQ03XBtpPlmSt2McZVbRVcRGQTZFX8qGcWA3HnKn/xRymFKfwlZ60jm5uBp5sXDSESlkNURh5nmAKoMmNpJpzO3QNLglwYk5lGErl8RIxiHSM0YLwiMBZ7v3fMiIdUEeFARFYd0x8bzqtr4WJTbFEWwjTL8xbEQ1Br3zzvo3nNaqb8Zc610EpSGvswrV1cZUR9V3T5KH1UANBrjRd3v/hog6iDTFdZuRpC7ZnXsiDqddjHfNfbM2zkboVhkijGAVGSle4D1kyMJczg6wH8wDkTcE6dlQgeU+l+57IpjuG7vysHVNO2mt5qPoffZNAsNAQGbQlghOeqKdPdR159O+54ADcpFqsRtlsxvkqlxy7iFL0ovzoi3tYUYqoU+IGoi6aGVL5OT3ZATtD+XWJMAy6IdU2XzrjB96e/UwwggTg72PSTg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(6486002)(31686004)(110136005)(54906003)(71200400001)(316002)(38100700002)(38070700005)(66946007)(8676002)(66476007)(64756008)(76116006)(66556008)(66446008)(122000001)(4326008)(6506007)(31696002)(5660300002)(2616005)(186003)(26005)(83380400001)(6512007)(36756003)(86362001)(2906002)(8936002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?LzJ4N0NRdHdadnBJQ0VaTUpGNUFGSDFPWFkzekc3RkZ6ZGNlY2I2OUljS0Zy?=
 =?utf-8?B?d05GM2dDWWZaOUJXRE9UUXBIZnkvOFNTWXhBeXZodWxROTN4U3lkbHdoYlIx?=
 =?utf-8?B?UXhkRkUwZVRzMFdyRzVGUmxRZ2dRb0lRNTVQYXNGdW50Sm5JRCtjZ1FLdW5Q?=
 =?utf-8?B?clRiaG1QcXA0S1B1Y0QwdGx3d1lUNmQ0RXIxSFdBbkVZZXlsN2pXUG84eDNK?=
 =?utf-8?B?eXFNenlpK0gxN2QxQmZ2a1FZZDlCMElpcFF1Ny94dzMwU0VwYi9TR3FiQUl3?=
 =?utf-8?B?NWNvV3ZjMUsxZ1VyZnYwV2FOZE43Qk9ON3NXb1UxRmw2L3FnMHlxV3pNVzRl?=
 =?utf-8?B?QTc0Y2UyQTNGRUNrcFd3REppWmh1K1F3Z0hHTG5sYU1YQ2ZsVlduSnNNcjVm?=
 =?utf-8?B?bHg3ZjhRMzN4WllSL2cyQzA3WVpqM0dMbzhqeE0yYzJiUnRkK3N4SE9wYVRN?=
 =?utf-8?B?NXBlL3h4eXU1SnpkM0FoN0NHRFdyOThSTTRBeFVUWFlFOTF5NEtRRkFFMHdh?=
 =?utf-8?B?Yll0eElnZkFXcEI1Qkh0U09kU25Lb3Nucm5ROHZvemlVVHlSTm1vZTMxZFVp?=
 =?utf-8?B?eXdWdWdhdjFTS1FNSDdFRTcvc0hpekJFNEllZS9Dc3hSd3N0Wld5Sno4SjZ2?=
 =?utf-8?B?K2pTc3JyWmV4anZ0YmhPSnMxenhiRGt2dFMySkg3bTBlclNkZnFkUUZ0Z3ZF?=
 =?utf-8?B?RlVTV1hRK2dxWWJHVk5VYTVuTXVGeldQRGdaTUkrTFZKaXZtV0dSVkNLRkdV?=
 =?utf-8?B?ZUdmRkl4ZFQ5NjVaSGtWUnRqTCtRWngxM215bmlpdnl6eC9JL21OMmtMTnJw?=
 =?utf-8?B?YURhelJsTzh6RVFBSjFGQXVZZk9OTjZoYzVhRkJSM1VpM2RqTUxQZkQ2dXlV?=
 =?utf-8?B?TDFLc1BjWkJwUUVJdStEQXFNcEY0R1JFRXMyMkd6NjdjSFRyZThkZ0RFcjht?=
 =?utf-8?B?RWoySUFzNXNLaVZ0RC8yTWFXejJsQjdkUkEyUWlreEpZcWdEN2tJS0l0NFQy?=
 =?utf-8?B?ak0wZTBiY1lydUVGTGd4Z0tjblNpeFBaRDdxL3pLcnZnM3BuQ05ieCs0ekw2?=
 =?utf-8?B?WUFJYWFYZ28rQUJWbDY2a0V6RStXcWFZQjRqV2VwbGFRcklOdVkwWWR3RU9x?=
 =?utf-8?B?WVRQZlFmcWcxYjRRek04WUVtQ1l1ZERPSnFlUHJ6a1p1MHJQRkE4cFpJaTAz?=
 =?utf-8?B?T3VCR0hHSi92Tm51OUx0T05DR0tXVDk5cytZdUk2TXMwZlNpUUdRekRndTg0?=
 =?utf-8?B?cFdQNlNRYlgrazZiZi9lekpOMHZFd2EzVnlmMmU3KzJuSlpTNm1nQXl5ZXhZ?=
 =?utf-8?B?aVFMZHgxWFU0NUE0T21NSVA2dnJWdGM5NCtnSFZDY3JXcFZYSnZmbG5FOWRE?=
 =?utf-8?B?alg1WjNhYnk1T0JEY29CcUl2djdEOEF3N3dsQkJlSXpZTjBFUWZPRmxoWWVQ?=
 =?utf-8?B?NUdlVzF5ZzFMYVgzK3hLTXAxSTZ3V1FpaEV6N2dVckFhVUh3ODh4YmFkZHYx?=
 =?utf-8?B?MU5ocGtodWhMMDBjdWVWTlQxQTAwVHlHS0p0S1VFR2ViaGJVNG9CWVdwYm90?=
 =?utf-8?B?Z2xDbmVuOW5sRVpQZ21pL2dGdVFkTlByQ3RnNGxLeTdSejZseTBsZ0tORGFQ?=
 =?utf-8?B?ZlRJSCsrWXFUTTdFcEtrMW9LNnRRL21QR0tIbVMzMFBDcHIrdFdnZVgwVlRr?=
 =?utf-8?B?V2ZTd0M3Y2Rva2M0azFjK1Z3QW9UZys2Y2ZLOGxlUkc4bW1lUjdwRGpJK3NJ?=
 =?utf-8?B?eGxOQWJiems1M1VkOHFNMXB0bDZSc2xYdTJLUnlVNTczb29VNFhnd3J2Y0d1?=
 =?utf-8?B?eXljUXRXWGFBanVkSmRRZkNCK3JmeUNraXIvZnpkTWpTS1kxNmxraUFZQ1Vp?=
 =?utf-8?B?SDhvREp5N1ZNYUNJYisvakg2NkNEYUIvVHZqdnBrNEZJMTlqTElLMlJIbTdJ?=
 =?utf-8?B?ekZVNmJ3TUl0WGZyQWxXZFN3VVB2L1NqQTZ3TTR0OWNIYVJwUW5IWEFwd2xG?=
 =?utf-8?B?UmtRalhOMGdiTlAzK0NOcWhMRXh2UW9WSFpuVE5LdnJMcm1tMlVKYXV3NDlT?=
 =?utf-8?B?YUQxM1lwL1I3aWIxMytJSEprSm02TXNvRmJsbFB3QXEyZmFJWUN4QWFzVVYw?=
 =?utf-8?B?dzZPY0hYYU5kc1VZMkhqV2lZVzNab0Y5SHhaN0k3VE9IRWM5bS9xTC82YmY0?=
 =?utf-8?B?Y3c9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <5D3352916AA38049BF8CB5988D2FD177@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3c275ec8-2dcc-469a-a977-08da023ba004
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 02:13:53.3114
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: mr6D/bTpwXa9Zkey+1o4K2XKzBwmZu+rYPMSmZ6Ajoa+pWboipf3z5hjyIziJWdJjhMPBhcxVfvrtoGb6eshjw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR12MB1748
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkphZUh1biBKdW5nIHdyb3RlOg0KPiBJbnRlcnJ1cHQgU3Rvcm1pbmcgb2NjdXJyZWQg
d2l0aCBhIHZlcnkgbG93IHByb2JhYmlsaXR5IG9mIG9jY3VycmVuY2UuDQo+IFRoZSBvY2N1cnJl
bmNlIG9mIHRoZSBwcm9ibGVtIGlzIGVzdGltYXRlZCB0byBiZSBjYXVzZWQgYnkgYSByYWNlIGNv
bmRpdGlvbg0KPiBiZXR3ZWVuIHRoZSB0b3AgaGFsZiBhbmQgYm90dG9tIGhhbGYgb2YgdGhlIGlu
dGVycnVwdCBzZXJ2aWNlIHJvdXRpbmUuDQo+IEl0IHdhcyBjb25maXJtZWQgdGhhdCB2YXJpYWJs
ZXMgaGF2ZSB2YWx1ZXMgdGhhdCBjYW5ub3QgYmUgaGVsZA0KPiB3aGVuIElTUiBvY2N1cnMgdGhy
b3VnaCBub3JtYWwgSCAvIFcgaXJxLg0KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0NCj4gKHN0cnVjdCBkd2MzX2V2
ZW50X2J1ZmZlciAqKSBldl9idWYgPSAweEZGRkZGRjg4REU2QTAzODAgKA0KPiAJKHZvaWQgKikg
YnVmID0gMHhGRkZGRkZDMDE1OTRFMDAwLA0KPiAJKHZvaWQgKikgY2FjaGUgPSAweEZGRkZGRjg4
RERDMTQwODAsDQo+IAkodW5zaWduZWQgaW50KSBsZW5ndGggPSA0MDk2LA0KPiAJKHVuc2lnbmVk
IGludCkgbHBvcyA9IDAsDQo+IAkodW5zaWduZWQgaW50KSBjb3VudCA9IDAsIDw8DQo+IAkodW5z
aWduZWQgaW50KSBmbGFncyA9IDEsIDw8DQo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQ0KPiAiZXZ0LT5jb3VudD0w
IiBhbmQgImV2dC0+ZmxhZ3M9RFdDM19FVkVOVF9QRU5ESU5HIiBjYW5ub3QgYmUgc2V0DQo+IGF0
IHRoZSBzYW1lIHRpbWUuDQo+IA0KPiBXZSBlc3RpbWF0ZSB0aGF0IGEgcmFjZSBjb25kaXRpb24g
b2NjdXJyZWQNCj4gYmV0d2VlbiBkd2MzX2ludGVycnVwdCgpIGFuZCBkd2MzX3Byb2Nlc3NfZXZl
bnRfYnVmKCkNCj4gY2FsbGVkIGJ5IGR3YzNfZ2FkZ2V0X3Byb2Nlc3NfcGVuZGluZ19ldmVudHMo
KS4NCj4gU28gSSB0cnkgdG8gYmxvY2sgdGhlIHJhY2UgY29uZGl0aW9uIHRocm91Z2ggc3Bpbl9s
b2NrLg0KDQpUaGlzIGxvb2tzIGxpa2UgaXQgbmVlZHMgYSBtZW1vcnkgYmFycmllci4gV291bGQg
dGhpcyB3b3JrIGZvciB5b3U/DQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KaW5kZXggYzAyZTIzOTk3OGUwLi5hOTZj
MzQ0YjlmMTcgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQorKysgYi9k
cml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQpAQCAtNTM0MCw2ICs1MzQwLDkgQEAgc3RhdGljIGly
cXJldHVybl90IGR3YzNfY2hlY2tfZXZlbnRfYnVmKHN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZlciAq
ZXZ0KQ0KICAgICAgICAgICAgICAgIHJldHVybiBJUlFfSEFORExFRDsNCiAgICAgICAgfQ0KIA0K
KyAgICAgICAvKiBNYWtlIHN1cmUgdGhlIGV2ZW50IGZsYWdzIGlzIHVwZGF0ZWQgKi8NCisgICAg
ICAgd21iKCk7DQorDQogICAgICAgIC8qDQogICAgICAgICAqIFdpdGggUENJZSBsZWdhY3kgaW50
ZXJydXB0LCB0ZXN0IHNob3dzIHRoYXQgdG9wLWhhbGYgaXJxIGhhbmRsZXIgY2FuDQogICAgICAg
ICAqIGJlIGNhbGxlZCBhZ2FpbiBhZnRlciBIVyBpbnRlcnJ1cHQgZGVhc3NlcnRpb24uIENoZWNr
IGlmIGJvdHRvbS1oYWxmDQoNCg0KVGhhbmtzLA0KVGhpbmgNCg==
