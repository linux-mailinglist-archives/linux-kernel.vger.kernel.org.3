Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040D14C0698
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 02:03:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236543AbiBWBD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 20:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234184AbiBWBDz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 20:03:55 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 793E836B77;
        Tue, 22 Feb 2022 17:03:29 -0800 (PST)
Received: from mailhost.synopsys.com (sv1-mailhost1.synopsys.com [10.205.2.131])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 170A342244;
        Wed, 23 Feb 2022 01:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1645578209; bh=79eoGZdJr0YGuk883D7CBppEIa8RmyCvIAxQ6m2pIus=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=hT5Kzx7hnEP6ZovjjZiWo820JK9tueHo5LmYz5KZcdDoFvz1YKIFsX1p1bRdcB5gl
         oGmXKz2aPbhOU98QT5mGxZNvlQ8IYD8yPMOpnoVpPCw8kb/dum2BwSFOno4q966D9o
         4EGKgC2l20kTsHmURuhIbah/QO21k/QFRQeLclfMOqadRhq9O1JHXvfB4ZnZer7vVO
         +ymedlcOL0gVrVphmZZMWT7barUroFA48eGBDHg5qcAwO4IUqIgS/hNNzhoOGAjU20
         SxBxjFy3BI1TcrzFewz97z7F97tPABr24PjZ7v98HnjbYVIBuw3UIvzBQ7+j+OoSfa
         fgMorhSNP+nrA==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 625FFA0067;
        Wed, 23 Feb 2022 01:03:28 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2109.outbound.protection.outlook.com [104.47.70.109])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 19EAD801EE;
        Wed, 23 Feb 2022 01:03:27 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="BxxZaEq1";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NNw4xjNIWnHxr2VgjfCOjkY4zbpWNNHT/ebOhKtCB8ODE7jJeY3pm94SaWz4lofHOtwF5925QVdcizbGkxu83VvijpkMi9avweNcyDFTCtzgWEX1bKfWnEz+55KGVL1F0qa/CxaQOqa2ZtMSY6IqPC/wKzBiQ3UwdXn6xasLmTEnRrjl32nr6VZxpUFAnRoprzKyKbBPwmteRp019apyB45xgmQbjUYI7nhpXtMw+3aY3Dh7Jl6Jf3lflIDOI0/sRSLvv3Whvn4EnBcOJEJV5157KIZPb/lFJdWnLySBO1wNDXklQTAbPzgL9Yszgw9316lAYB3hmJKXCtQeGKZohg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=79eoGZdJr0YGuk883D7CBppEIa8RmyCvIAxQ6m2pIus=;
 b=Ow3RhUHUOW16JSiWX+Hdc9EHnC0tJhUDZOmbBGU/K2l24dUEmIKkDvGN4vb8SPj8cVcoJdNxvMDXRh+MY3qC0nVnfgxW6rg9LTebntn+FD9Tjyypy/U4d/WEhTk58H1YvUzE5gr1qRCHs5rJ8uOjvc0i7TVkK+0/lDSk7Ud4dP/C9xLbhCz2JBkOXA/c4p6O6mXmX/5qU3vjdAh3ftTdkYc7XBwQIxofN45pzrbxW6Fg9JCbNuV47Njq0oKqbO/oJDzvkSbCq3TwGTVKFJeuW4puotDxg9gdPWMnkBUPjzkPpNrwSgGl0QpnBmrWBHp7NVKmKyyJAD1D0rTFqL1vfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=79eoGZdJr0YGuk883D7CBppEIa8RmyCvIAxQ6m2pIus=;
 b=BxxZaEq1fVLm4XvydfvLh0w7cq8tDtvBaRDZWgSLKrDRNejjVogKKveUl/saxXW7s79DrffRhJndmFEhE9ryZoeckvPFerU8d62M4tlGOvFOBLyUyPAlpAhCRIFmFquWbs5zdUJ0wyQELj1HKLozXZyM2NRvDv3v9k5CwVTI2cg=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BY5PR12MB4917.namprd12.prod.outlook.com (2603:10b6:a03:1d1::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Wed, 23 Feb
 2022 01:03:24 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 01:03:24 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Aswath Govindraju <a-govindraju@ti.com>
CC:     Kishon Vijay Abraham I <kishon@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrey Smirnov <andrew.smirnov@gmail.com>
Subject: Re: [PATCH] usb: dwc3: drd: Add support for extcon drd notifier even
 with usb role switch config enabled
Thread-Topic: [PATCH] usb: dwc3: drd: Add support for extcon drd notifier even
 with usb role switch config enabled
Thread-Index: AQHYKBhgkWaB2ckYxkma14eIm2iyqKygUh8A
Date:   Wed, 23 Feb 2022 01:03:24 +0000
Message-ID: <273c9e6d-4fa3-52d9-e978-8f2be81dd6f6@synopsys.com>
References: <20220218093348.1098-1-a-govindraju@ti.com>
In-Reply-To: <20220218093348.1098-1-a-govindraju@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: aeb5da8f-5b6c-4980-6663-08d9f6684b0e
x-ms-traffictypediagnostic: BY5PR12MB4917:EE_
x-microsoft-antispam-prvs: <BY5PR12MB4917D3DC4F61F05513A80BBEAA3C9@BY5PR12MB4917.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: eLw5c7h1tedQPKp9rUmgv4VGxuxzmcZSD2bfVLu+9KfIAJRxvHnWHZXYfTjN34dBQZzFbsoPlIw92NDHSNot7O/TbYXta/dklKc8W5Fy0Y9ZzcnEX8+YTtODdTc9KSznhBMZK3qcgBctRdRdrJmXLjd9mGlxAlia0e0xZNGRO1OZ7T0N6dC7lZ0ukvTSJdTBRiDh4/5HDaJuvfrJ+YPGjJl63Zx+kBOpL2lCRBUFEj4UisglQSNXCyTS2Kn4CI7SyyzJSp9EnLq4naMV5ovL/pgopglmRd80x2gBRtjYOgucYTyveEv5NIcyQvUMKh4ueg1ivFU7J2W9WS2PKuXjlpVr1Xun84b7TXWvxcvLdVkZaqUqfB5na33Xdi5BGVBExS7YXns+kaLou0+jWHQSfXqY+2nITMDEf11pxVbZ4sq06Ix/c28hpyxaZQ0kHPyXJpBgcI4cou2CKTcfUTL5G9Ms6jMM3lGSNisAIBbOkkCNSrmVXTrlKMmVcEvfpqvgaeKyFzR4GN3JWXUO7meraX9ji3jDVnCj/YL/PlPBgI22yRjcWXq1xV+2EKOTCsHto+mizPXBAteB7lnnl+WW65sR7mr2HwXYKqr1M+GSOOBJ7pjKC8oxP6OGZd8EmSRP2uFbk1KgbukFwTUyz9bLBCcMHTdvXYKEN9/jzcAGWSz6LzgF4TYRGyXjwkLmVuXxxVCCLEbTL1zv1I3HRdd9YN24Zea4JWWZfjDBQrWq6da6EbNH6iGSndeL1hQmAlLmerUwE/hLLj6GtvZwq/TZISdf5Rh4QCtRFiLxRbsrP52E5B/2O7JJuldaoU32iNkPUK4Ljkt3/Y+9+D0VImyWAKyow9XZhVn3at9gEhdgAHA=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(316002)(8676002)(4326008)(54906003)(6916009)(2616005)(64756008)(8936002)(66446008)(83380400001)(38070700005)(66476007)(86362001)(76116006)(6512007)(66556008)(186003)(66946007)(6486002)(966005)(122000001)(31696002)(31686004)(38100700002)(71200400001)(36756003)(508600001)(5660300002)(2906002)(6506007)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UWtwSSszZHNJZytoa1h1MTlGQ0dyQVRZMTJ1eE1wUFRGNit6cW05OTVQNFdJ?=
 =?utf-8?B?cXl0TjMvdHU4MWpDR1o5VTdsYWFmYkU2TGRWSGdGOFpRMW9tVnNQN0c2WXBy?=
 =?utf-8?B?TzFraVpGY2VLSmRSZ0hVYlEydE4wdW9jSHVjL0xYZS9PM1QyQm5nQ2pEQW9I?=
 =?utf-8?B?RHp6bktMbjBuT1ZiQytjSVYyZHJxa1B4TmZ6NURFY3ZjNDJrbHdJWllOYVA2?=
 =?utf-8?B?R0EvbGxBT2x6RzA2dk9yQVdMSkorTXFpQnpleE9WaHdSUCt6cXlqL2g1M3F1?=
 =?utf-8?B?RnZ4UEQ2bmVPZW5la2VuUDZtVHg3eCttVTJxQ1hNYlowZjhtWDkzVjUvQnVY?=
 =?utf-8?B?blJHd015cXpyUWZQYTY3amp4NlVaUFdxejdOL1JrK2pGZkpQVWlLVU10Z1BW?=
 =?utf-8?B?RENHOXFwZDNFME9HamRVWXBPMUtRMFFxelViUjdxQ1dJNldNaGdHYVR6VmRu?=
 =?utf-8?B?UGxGbmlMUDVZYlVGSnVKT0Q4Zm1jWWxNUUgwNFV4UVFvZDZyazBCcjYrRmY3?=
 =?utf-8?B?NnlSUjh3T0VGTXptSTRaL0FtYnh2Y2xGMzNoekdEajVxMURzN0ZwSFQ1bG1t?=
 =?utf-8?B?Sk1TUzBCOUhDM0p0TU96enlmQWJiU2xSOWpaVjduekVaVXpObVBqQ2xET1Uv?=
 =?utf-8?B?cGJUcmoxeXRqbm5DVUhPeXpQQVl1bGhTdi9zeHFFWVdnUWpPMmxnRWNYVWEr?=
 =?utf-8?B?WWR0eHlBai8yQmRqYk5UOE5Dd0lEQkxjOWNBNm9LbVBaN0UxRkV6OHV3MmhN?=
 =?utf-8?B?TTJOR0pwdm56emRLTEhuaVlDR1pGdGl0SEdBa1JKTE5oeXpDWFNGaE1yblF6?=
 =?utf-8?B?Y3hGbzkwM1J5TGh6c29BaWJZbHhFUzd6UnNkY2l1VGd1NlFWQTNqYXczN2pz?=
 =?utf-8?B?bFBBL1hwT09Ea2dmaHdIbG5Ja0pPQmVaV3lkL0h1MVlMVUtYMWRBSWtTZmda?=
 =?utf-8?B?dU9iak9PYmdDRGhodHRBTFB2TGpjdkFDeFRCR3FRQWVnaGdPb1hMdjA3aVl3?=
 =?utf-8?B?SGRTRWF3Y3luUGdEOTVqUDRiQ3FROWNSUXdweVVHTmVrTnozMVZSU2xCdVY2?=
 =?utf-8?B?ZHg4T3JSOHgyYU5WbXhVUjBSUEZyaFZGQkxiTFh4emVNSm85UE9oSW9UdzBB?=
 =?utf-8?B?aEIyd0VSRWx6Y1lKYXBZQk4xeHdFdjFyN3J4S2pCa3FBUGpoOGdaUE0wVHJZ?=
 =?utf-8?B?RHBBcDJFK2R5NmN1bThiZTE0SURhOFJJaVY2MGI1Wm4xZkZSWVNsTVROTkQx?=
 =?utf-8?B?MlQ0VVlCV3pzOTYrdytxZlE1cDkwRER6M1JIMVFqUVJnK1pWMmFnbldIbFdT?=
 =?utf-8?B?Njc0aGg1bmY4ZHZlRzNFWWJHcHVlb3JmRzE2YU1wNjBTTktJZ0tJcU5jc2lB?=
 =?utf-8?B?MlFqUVM1SWFWNkdlYnZBV0NpKy9Gbjc5TzNCRGs0VTZ1NVFQRitJSmhYc0tT?=
 =?utf-8?B?U0VlNUs0QWpTWk9OZ3FnNm80TXUxWkQ2eVpUcHBJN094NnQ0dHVKNWdLZkZI?=
 =?utf-8?B?RFZwUFJnRTZrejgrL2JyR0VIL0lkcVdGdnRPVFM0aHMzOUZ3QjVLYXVxSXY2?=
 =?utf-8?B?V3N6cHEwL1NneUZ2SVBYVEd4c3NCc0t5UTRFYllVaFFPNFRLVHpycCtTNW1i?=
 =?utf-8?B?MGMwWSsrcDRIYmpPUVVCN3oxNmhoNGxXUytaQlAvb1ErYm43ZU45ZUNhUVR3?=
 =?utf-8?B?a1lPdUEvLzdVeER3NVNXZHBESFg5ODBoaHBVOG1oTXRmSWlxbTJMOUd4SmxS?=
 =?utf-8?B?ZldGYVVra3daSDJWdjQwRUEzT05RcVBqOHZxUkI3YjBSekV0ZHpkMVpSd1lw?=
 =?utf-8?B?WDlhb1RnRnd1aDgwbThDTG9ITkRJaEpWR1JYTFpmMlRaK3hoTk9KdDRCYnY2?=
 =?utf-8?B?WkFzczJkc2hoU295Q3BwS2pyTXhCa3BDemt1NWdGSndUeG1jdnpqZTVPVVBh?=
 =?utf-8?B?RUY1NDRLRlVIeSs1WEcyMUJlQjBmT2NkQzBBME9mSjdmVGdQemNyWUxGVUl4?=
 =?utf-8?B?WHZFK01XTWQzTjkwejRVV3lXQUZJN0wrTTlQQXhON3ZRWkd0YXJyUk5PdTB2?=
 =?utf-8?B?ZDZPby9JV1lqbjZ5cU5DVTlXUWsxR1Blb2QwRVIxODRSWU42NlJOYkp6Ump3?=
 =?utf-8?B?QTRnSVR3MGVMVk5ocjRVWTFEQUxqd0h1T3RPVzRNUXBPTE5WdkdZN0VHOVU2?=
 =?utf-8?Q?HVLvdP4QHogrlbPRGV9r5R0=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <C87F278EFE93E64EB3FD462FE736FC2E@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aeb5da8f-5b6c-4980-6663-08d9f6684b0e
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 01:03:24.5277
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sprGNZNMdv/06nw9y/VzjDpyMar+AwUmOROJY7nZsqOhvvGWFUQlpA7TjRcmnCtNBDwuen7H6u1WJSxuzorPzw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB4917
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGksDQoNCkFzd2F0aCBHb3ZpbmRyYWp1IHdyb3RlOg0KPiBJbiBBTTYyeCBTb0MsIHRoZSBVU0Ig
Y29udHJvbGxlciBzdXBwb3J0cyBVU0Igcm9sZSBzd2l0Y2hpbmcgYnkgdXNpbmcgdGhlDQo+IGV4
dGNvbiBkcmQgbm90aWZpZXJzLiBUaGUgY3VycmVudCBpbXBsZW1lbnRhdGlvbiBkb2VzIG5vdCBh
Y2NvbW1vZGF0ZSB0aGlzLg0KPiBJZiB1c2Igcm9sZSBzd2l0Y2hpbmcgaXMgZW5hYmxlZCB0aGVu
IGRyZCBub3RpZmllcnMgYXJlIG5vdCBhZGRlZC4gSWYgdXNiDQo+IHJvbGUgc3dpdGNoaW5nIGlz
IG5vdCBlbmFibGVkIHRoZW4gdGhlIGRyX21vZGUgaXMgZm9yY2VkIHRvIHBlcmlwaGVyYWwNCj4g
KGR3YzNfZ2V0X2RyX21vZGUpIGFuZCByb2xlIHN3aXRjaGluZyB3aWxsIG5vdCBiZSBwb3NzaWJs
ZShkd2MzX3NldF9tb2RlKS4NCj4gDQo+IFRoZXJlZm9yZSwgcmVhcnJhbmdlIHRoZSAiaWYgZWxz
ZSIgbG9naWMgc3VjaCB0aGF0IGV4dGNvbiBkcmQgbm90aWZpZXJzIGNhbg0KPiBiZSBhZGRlZCBl
dmVuIHdpdGggdXNiIHJvbGUgc3dpdGNoaW5nIGVuYWJsZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5
OiBBc3dhdGggR292aW5kcmFqdSA8YS1nb3ZpbmRyYWp1QHRpLmNvbT4NCj4gLS0tDQo+ICBkcml2
ZXJzL3VzYi9kd2MzL2RyZC5jIHwgMTYgKysrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5n
ZWQsIDkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3VzYi9kd2MzL2RyZC5jIGIvZHJpdmVycy91c2IvZHdjMy9kcmQuYw0KPiBpbmRleCBi
OTE5ZWEzZDg3ZjIuLjBlODZiMWQ4YjUwYyAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9kcmQuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2RyZC5jDQo+IEBAIC01ODMsMTIgKzU4
Myw3IEBAIGludCBkd2MzX2RyZF9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJaWYgKElTX0VS
Uihkd2MtPmVkZXYpKQ0KPiAgCQlyZXR1cm4gUFRSX0VSUihkd2MtPmVkZXYpOw0KPiAgDQo+IC0J
aWYgKFJPTEVfU1dJVENIICYmDQo+IC0JICAgIGRldmljZV9wcm9wZXJ0eV9yZWFkX2Jvb2woZHdj
LT5kZXYsICJ1c2Itcm9sZS1zd2l0Y2giKSkgew0KPiAtCQlyZXQgPSBkd2MzX3NldHVwX3JvbGVf
c3dpdGNoKGR3Yyk7DQo+IC0JCWlmIChyZXQgPCAwKQ0KPiAtCQkJcmV0dXJuIHJldDsNCj4gLQl9
IGVsc2UgaWYgKGR3Yy0+ZWRldikgew0KPiArCWlmIChkd2MtPmVkZXYpIHsNCj4gIAkJZHdjLT5l
ZGV2X25iLm5vdGlmaWVyX2NhbGwgPSBkd2MzX2RyZF9ub3RpZmllcjsNCj4gIAkJcmV0ID0gZXh0
Y29uX3JlZ2lzdGVyX25vdGlmaWVyKGR3Yy0+ZWRldiwgRVhUQ09OX1VTQl9IT1NULA0KPiAgCQkJ
CQkgICAgICAgJmR3Yy0+ZWRldl9uYik7DQo+IEBAIC01OTgsNyArNTkzLDE0IEBAIGludCBkd2Mz
X2RyZF9pbml0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICAJCX0NCj4gIA0KPiAgCQlkd2MzX2RyZF91
cGRhdGUoZHdjKTsNCj4gLQl9IGVsc2Ugew0KPiArCX0NCj4gKw0KPiArCWlmIChST0xFX1NXSVRD
SCAmJg0KPiArCSAgICBkZXZpY2VfcHJvcGVydHlfcmVhZF9ib29sKGR3Yy0+ZGV2LCAidXNiLXJv
bGUtc3dpdGNoIikpIHsNCj4gKwkJcmV0ID0gZHdjM19zZXR1cF9yb2xlX3N3aXRjaChkd2MpOw0K
PiArCQlpZiAocmV0IDwgMCkNCj4gKwkJCXJldHVybiByZXQ7DQo+ICsJfSBlbHNlIGlmICghZHdj
LT5lZGV2KSB7DQo+ICAJCWR3YzNfc2V0X3BydGNhcChkd2MsIERXQzNfR0NUTF9QUlRDQVBfT1RH
KTsNCj4gIA0KPiAgCQkvKiB1c2UgT1RHIGJsb2NrIHRvIGdldCBJRCBldmVudCAqLw0KDQoNClBs
ZWFzZSBjaGVjayB0aGUgcGF0Y2ggYnkgQW5kcmV5IFNtaXJub3YgYW5kIHNlZSBpZiBpdCB3b3Jr
cyBmb3IgeW91Og0KaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtdXNiLzIwMjIwMjIxMTky
MDIwLjM0NjYyMi0xLWFuZHJldy5zbWlybm92QGdtYWlsLmNvbS8NCg0KVGhhbmtzLA0KVGhpbmgN
Cg==
