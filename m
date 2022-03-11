Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F18D74D5944
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 04:51:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345998AbiCKDwP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 22:52:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233213AbiCKDwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 22:52:13 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E973182DBA;
        Thu, 10 Mar 2022 19:51:10 -0800 (PST)
Received: from mailhost.synopsys.com (sv2-mailhost2.synopsys.com [10.205.2.134])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id B420DC19C1;
        Fri, 11 Mar 2022 03:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1646970670; bh=YTePwn+4d1OI3pxntVV0NvXSkZo2ZqD1JcC8EYRaT3g=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=ABuYJTWl0q0ngMkZIvTtP43BrrJyoK30o28xi/2ESHGN0NhSQRHFXnxzve0S7UhLW
         wN+YqN96+BL80ZBm3/SMpB2xnsROyDyYxutKoojznMw37tk5h1qrhgRPrt4LTxl9lG
         6so/Qokn1oNKz8M6NA/QtUoUPLOmIBY5sUWOmaHiNZOLZCq9YX5ioRxR+M2l8/SkHu
         ljAQgad0J1dbveAwlsdMDFWW6G+I1P/M8w/BkLrZNjGppWulc+xRtHdAvDrZlZ+6P8
         L46Wgg58WEJ9AW3pNhXL591ITUXxaNbGn11I1W8Y3qP/5BYYJhH/DAyt8p6OzLiN0/
         IPb7g7C56pc6A==
Received: from o365relay-in.synopsys.com (sv2-o365relay3.synopsys.com [10.202.1.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 77BC2A00A3;
        Fri, 11 Mar 2022 03:51:08 +0000 (UTC)
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2168.outbound.protection.outlook.com [104.47.55.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 168C64006B;
        Fri, 11 Mar 2022 03:51:07 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dzNrtJMi";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W/ccU1wiCkhX2wujBo6nbJ0bzhq5bCNl30iU5BBOyIVgT3/k9uAFm5LLJqZhAfMdczuLkKU+KOWZcS/uiYtg9GXUZsZYVHSrJR4tBjqGKglEW1uwwzEbwUpdP7XHkyt26JBcgNHF8/5EFN8lPwYBoau6vxvgnz+5HPGBmAPNUNA2vwpPZL5GbZ2WEEP75OxARppvpzRUV6jxpq7PW9QbT1b7QhN/71XGf8TPhDK2TaUZ6vesTVPw3mPcVURDYLZ/w/gkeQ72KRGfVp0Q/xWTWzmUFaJclSHu33Qdn4QoVaCNn+96BvwmcxtvRYoRb1rgZZFzeX1FOyn6g66pCv8Ucw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YTePwn+4d1OI3pxntVV0NvXSkZo2ZqD1JcC8EYRaT3g=;
 b=EkMKRDSB1EklF5p2dcWfe/ryPlLPKMKrKvi8PgUyNN2Rkm6AZfwYeWTdpLwIObceXQ3i2IVS5IJ1AolBwspFIyoJTxaSu2OHT3o6ar93c/kZeT/hw+vEMu+rJMR8eqpcEsvqwZtHzrzVyUo0IbDC+ISEfF0ufYSrqGBF+xIos32YoZvT++/RUrBfEGpL2f+dQsq9aA2zjVDueVyHvxp8fwuilr9cLhOyRcCm0vYEl8MZL44BAP/T3ZN7AlHLnqEFa+Nerky5i79f7FYfrWpqqcOOYn22mnPigw4wia4SrK9xz9M3UjgvnsDf+ksWMnwPiXzZn5B0HOnzz39GlY3Ttg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YTePwn+4d1OI3pxntVV0NvXSkZo2ZqD1JcC8EYRaT3g=;
 b=dzNrtJMisjVJI0VrcwDGJF2tNY94L+84ut8JfaExbbyQrt554fHZJTKqIT4e9hYNqeyLzQg2Jz83uiiJblGLE35+XiICF9NPZiKhj+P3OHjDDyJ8InrvIS+aqxQNNedqQDyOh7jtgwRFG6EN6JF4dJ+6/O+CZCnJakxqijUVyp4=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by PH0PR12MB5607.namprd12.prod.outlook.com (2603:10b6:510:142::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.15; Fri, 11 Mar
 2022 03:51:04 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5038.026; Fri, 11 Mar 2022
 03:51:03 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     =?utf-8?B?7KCV7J6s7ZuI?= <jh0801.jung@samsung.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        'Felipe Balbi' <balbi@kernel.org>,
        'Greg Kroah-Hartman' <gregkh@linuxfoundation.org>
CC:     "'open list:USB XHCI DRIVER'" <linux-usb@vger.kernel.org>,
        'open list' <linux-kernel@vger.kernel.org>,
        'Seungchull Suh' <sc.suh@samsung.com>,
        'Daehwan Jung' <dh10.jung@samsung.com>,
        "cpgs@samsung.com" <cpgs@samsung.com>,
        "cpgsproxy5@samsung.com" <cpgsproxy5@samsung.com>
Subject: Re: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Topic: [PATCH] usb: dwc3: Add dwc3 lock for blocking interrupt storming
Thread-Index: AQHYMePmBfflf4nAkkGdLNAaNOlrkay35TEAgAGF7ICAAAeXgIAADPuAgAAS/oA=
Date:   Fri, 11 Mar 2022 03:51:03 +0000
Message-ID: <0ae388d8-0809-f09a-55a8-b682c9dc42c5@synopsys.com>
References: <CGME20220307052605epcas2p2b84f6db2642863ed61373070f508e200@epcas2p2.samsung.com>
 <1646630679-121585-1-git-send-email-jh0801.jung@samsung.com>
 <99eabe6c-8782-1bc6-e1d7-09b019cee65b@synopsys.com>
 <016a01d834e7$72b11fd0$58135f70$@samsung.com>
 <559b00b6-8b3d-9422-6a25-674f719ad237@synopsys.com>
 <017f01d834f1$bc3a9c30$34afd490$@samsung.com>
In-Reply-To: <017f01d834f1$bc3a9c30$34afd490$@samsung.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fa2e3152-e5a4-4e67-d6df-08da03125d7c
x-ms-traffictypediagnostic: PH0PR12MB5607:EE_
x-microsoft-antispam-prvs: <PH0PR12MB56075D7611AF7A12065684D6AA0C9@PH0PR12MB5607.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ZFnUGnZXw1aF1swbwdhvmGTsHYJdHeNLTgI1twAqVVOCzXr62q0oviBkNDItk3kZioo+HlCzpWGy24qi8X/bc5G3LBy2ZyRYkwem644Y/3AVO8kWj4Yo3dHNjMs1bFSEg2vnRp2Gd4WALj3v5DW7LMxjuBt3Ovo9525zfz4jCbEOk5u7pCYLswPbTuBc1QvjSVgzsTmzIhLJjbJr0yUI2KkgbpPDLVrbyQrzj9HbRGqZlQktP+1jADfnDr4Sq2G8FVgUV4wIcBdfWn5O5Ej3wAvgfZ3ruUF0t0KJZQPW3iK+Y/Xol9Eu07AC7nqhc8hR3Hzp3vbPgOPEdIwkouDnnxe1m0MifbdG9xJoA9Xau6R3GO6LCud/+6hKi7RNbCprhBCsEFIWI5M/UDnMsxp8eZpMoO7FHdC91tKv9cn63vKgnJAOaRiavPiQoUzB+ZUmrwfmcLLgXujbnErE9PcjlVSOst9VYbycowl0MiaYLtPrU+8jl7PzXRGPltDib9+xTEMxZvpzR8+mOXd2vRXBTP0p3r73SJ1/RV9OSUiuQuoJVOoD5my3r2AVBifeksGasQR1EFHOC0+suN/UFrUTTREhsMQ/RbheXBEwRzauctJpVg1rIpcy3BQo12Io9hWBbN+I8E9qb6r9NBhiWCm7Ya5T0PuAIvKG0m40amAIE0IF4gC7L9jXE9XDNq4my+M7DpABP4FZV+e9/0DlfiYoNpZuXt3RCzTxGIgUwPt7c/VjlIZm8QtWd+p5JayC8LfGDii0kEgwVEwAij5nLyleAQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(71200400001)(316002)(6486002)(38070700005)(2906002)(76116006)(31696002)(86362001)(53546011)(6506007)(66946007)(6512007)(110136005)(54906003)(66556008)(66476007)(66446008)(64756008)(31686004)(8936002)(5660300002)(508600001)(36756003)(4326008)(2616005)(122000001)(83380400001)(38100700002)(186003)(26005)(8676002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YkN3cmMxd1pEd1RuU0xKNkZKVDNTSk5EekhtMnVHWUZuT2hnbHoyenRiVWtP?=
 =?utf-8?B?VG5ValErZ1NadmF2ekZ4Rm9YUG5ZVjlxdUtHSkxQNnB4cW5lanhURjhEZEw2?=
 =?utf-8?B?aE5TaTBEbmptRlNhaUhpc0hidFNVRzBNb1Z5b0RuaVUyYmYreXEzdU1FS3BZ?=
 =?utf-8?B?NEo0VjQzTUlSUGN6UzVpQm8xUmN3eWFEdWJnd3pQeWVXLzdlakh0Z3hjRUg1?=
 =?utf-8?B?WkkwMi9Uc0N2MFNFOFJXNXJ1aUdoekZTbjRyWjUzUlhaSlgvbFlFQzFxRTFv?=
 =?utf-8?B?cWJXd0lEOC9oL1ZLSFBjOGFJVm5iby8wdFRPbFBtUkc2TmlSWjZEby9GaVBi?=
 =?utf-8?B?M0JxYVdlYmNvZDR6c1pzbGFxWDZnQkdmRkJMZjBQVWxSTVR2YkZSNUFVQ2Rw?=
 =?utf-8?B?cWtVWjZsSVpueUxIUWU4QjNleDFPYUNJT2pwZ3V4cTRDdWw0QUplZTl0dkhL?=
 =?utf-8?B?Wmp4L3YzaHNMSEFhR2pWemU1dUEydWhUMnNvMVVicno2TFoyUTgwYU5QeHpJ?=
 =?utf-8?B?ZnQrZ0U4L3FCSGpqRTZUUG91cDFYRkkrYXVaUXQ0QU9ub0xHWXZVNUNFbU9t?=
 =?utf-8?B?NU5wUEhSc1lpL2x1OHcySG91N21LQ1hxa0sxb1YvSlBuSTVUeGFkYWRBSHJs?=
 =?utf-8?B?Q09RQWZGc29VOXhXK1NVU3lBT21SaGJVQTRSenVDRW4rN0hVTXQ3dlhJcGxm?=
 =?utf-8?B?MTVneGJoTjFzUmE4d1FXVXN0dWhNVzFFUDhKR2Z6a3RoZW9GQWlqNENCUU1y?=
 =?utf-8?B?ZG91TkFUV05jQUtxMytzUUNwZ0RYNExiU2NLWFJmTVFrU3ZYU3lzSDJrUGx0?=
 =?utf-8?B?bkhRcmRvVi94L1ZjaElJS1grTUpqUzhrMzBycWx0YzZNUGIxajNKeWlnazRl?=
 =?utf-8?B?SDZtNllIOGs2OVlTRndydVdrTDJyakNrTzhaaFVSWDJ4emRjdGpadGI1Yjl6?=
 =?utf-8?B?Y09GQjdVaTV0eHU5ZWhxcnhHNEVvN0FheHk4K1hUWUtqRUl1R2V4a0NERksy?=
 =?utf-8?B?S1ZGbmVuRS9UNlBRV2lDYWF3YzdWMmV1VGtuZGdidWpOREhpR05mWmpPUTJO?=
 =?utf-8?B?RFNOTllPWW5zUFZHaWNLdGN5TXVYYkViQmZGb00xOE9EcHhIbmVrT2ttS2FB?=
 =?utf-8?B?STJjTWQ5MWRhSXV2TjlxQTRKRzRLVlFWWDB0cVc2aUJFR3dJeWFxQWp6MnJV?=
 =?utf-8?B?TXRaOTk2R200RWZoYitlMWMyRVVWQ1B3SzVFdVJCVHNnZ3lOTGQxa0V4Z2o5?=
 =?utf-8?B?dFl0cW9qTzd5dGhEcWUwTU5NTkIwNW5JV3Yxano4ZHU5QitzV3NNVzhzM2hJ?=
 =?utf-8?B?eFZ5dTExRHQ3Qy83dmNNaUNYMWtJTlcxKzhLa1VMYkd1TDJEZGxTUnpjclJm?=
 =?utf-8?B?Wk55SUV4NlhZSHZ3dzVLSFRqVW1JZHowN1BmZWN2SzAzMjdTbTdGRSt3OW50?=
 =?utf-8?B?VVlIZVVrcE1uVGw5Sk8xL0dDUEQ2TVJYSVBwbDE1UmVybUIzZlc3UkhoaDkr?=
 =?utf-8?B?V1ROOVRLcURRU09FNmtLc2hDOE9PU2pKMllMdlN3eVZTUzNvOEJwOEhoUU53?=
 =?utf-8?B?NFVidVRKRzFYOU9NTWZPYlNwa3MzdkxxYjdCNjVGVTJMY1ovV090R0E2ZSs3?=
 =?utf-8?B?d1dNT3JSdDVycWJzTkgwaXJxRnJWSWZXR0NOY3NtZEtzQzVWLzhkUmM3VVBQ?=
 =?utf-8?B?N0UrMC8yRHh6QnY0YUlJbUxhZUliYy81Q2k3dFZaaTVmbnRiVGdsMGJqeVNo?=
 =?utf-8?B?VkN5b1JVeDNGKzFtTnlJdjhxRzFjZTJCVzg0VnpOY0tmMG5xUG9Lb3d6WDZx?=
 =?utf-8?B?a28yZnJXd3kwdWx5eGxDaWNFanhuT0tmNkRsUXl4MGw5VEZJa0xuazFCTnNM?=
 =?utf-8?B?ODlVSEZYSW1oeThoQmZnL29EbzVzNkhZeEYxT2xvbjNKaEhmVlE3N3FRNzhR?=
 =?utf-8?B?UTE1RWJEWHVydXdNb0ZwaXljalprayt4bldEdWRxWXlqbU54M21QRUt1cWRO?=
 =?utf-8?B?dEdYQU9vN3E5aDNVaTVQRXR6WmtlR05rUGdVZE9hUWVoYTA5MHcxc0FKWFF3?=
 =?utf-8?B?dUc3cjFoMHc3MGZiNlZOQUxMWkdodThWUmNYbTVtU1E5YTJGN1dVc29GZzc2?=
 =?utf-8?B?eTlFVjREazY5b0ZXQnZ3NDlhSHdjNUpNb2l2eFJEMFQ1YWZKRWpFM3NDT3do?=
 =?utf-8?Q?IRp43YCtTBO9YhOGzT+Ee8A=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2D60A766BC402448048F3B6E9C43DA1@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fa2e3152-e5a4-4e67-d6df-08da03125d7c
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Mar 2022 03:51:03.6447
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: dqUtFHEuETgeLA4Retd2lTPD9/FeWBDlWuOs4XW7UHS7woB92PcGo4Id/S9fiW3JerZq6VBGeM9N2ciDqcn6kQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR12MB5607
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

7KCV7J6s7ZuIIHdyb3RlOg0KPj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4+IEZyb206
IFRoaW5oIE5ndXllbiBbbWFpbHRvOlRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb21dDQo+PiBTZW50
OiBGcmlkYXksIE1hcmNoIDExLCAyMDIyIDEwOjU3IEFNDQo+PiBUbzog7KCV7J6s7ZuIOyBUaGlu
aCBOZ3V5ZW47ICdGZWxpcGUgQmFsYmknOyAnR3JlZyBLcm9haC1IYXJ0bWFuJw0KPj4gQ2M6ICdv
cGVuIGxpc3Q6VVNCIFhIQ0kgRFJJVkVSJzsgJ29wZW4gbGlzdCc7ICdTZXVuZ2NodWxsIFN1aCc7
ICdEYWVod2FuDQo+PiBKdW5nJzsgY3Bnc0BzYW1zdW5nLmNvbTsgY3Bnc3Byb3h5NUBzYW1zdW5n
LmNvbQ0KPj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBBZGQgZHdjMyBsb2NrIGZv
ciBibG9ja2luZyBpbnRlcnJ1cHQNCj4+IHN0b3JtaW5nDQo+Pg0KPj4g7KCV7J6s7ZuIIHdyb3Rl
Og0KPj4+IEhpLg0KPj4+DQo+Pj4+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+Pj4+IEZy
b206IFRoaW5oIE5ndXllbiBbbWFpbHRvOlRoaW5oLk5ndXllbkBzeW5vcHN5cy5jb21dDQo+Pj4+
IFNlbnQ6IFRodXJzZGF5LCBNYXJjaCAxMCwgMjAyMiAxMToxNCBBTQ0KPj4+PiBUbzogSmFlSHVu
IEp1bmc7IEZlbGlwZSBCYWxiaTsgR3JlZyBLcm9haC1IYXJ0bWFuDQo+Pj4+IENjOiBvcGVuIGxp
c3Q6VVNCIFhIQ0kgRFJJVkVSOyBvcGVuIGxpc3Q7IFNldW5nY2h1bGwgU3VoOyBEYWVod2FuDQo+
Pj4+IEp1bmcNCj4+Pj4gU3ViamVjdDogUmU6IFtQQVRDSF0gdXNiOiBkd2MzOiBBZGQgZHdjMyBs
b2NrIGZvciBibG9ja2luZyBpbnRlcnJ1cHQNCj4+Pj4gc3Rvcm1pbmcNCj4+Pj4NCj4+Pj4gSGks
DQo+Pj4+DQo+Pj4+IEphZUh1biBKdW5nIHdyb3RlOg0KPj4+Pj4gSW50ZXJydXB0IFN0b3JtaW5n
IG9jY3VycmVkIHdpdGggYSB2ZXJ5IGxvdyBwcm9iYWJpbGl0eSBvZiBvY2N1cnJlbmNlLg0KPj4+
Pj4gVGhlIG9jY3VycmVuY2Ugb2YgdGhlIHByb2JsZW0gaXMgZXN0aW1hdGVkIHRvIGJlIGNhdXNl
ZCBieSBhIHJhY2UNCj4+Pj4+IGNvbmRpdGlvbiBiZXR3ZWVuIHRoZSB0b3AgaGFsZiBhbmQgYm90
dG9tIGhhbGYgb2YgdGhlIGludGVycnVwdA0KPj4+Pj4gc2VydmljZQ0KPj4+PiByb3V0aW5lLg0K
Pj4+Pj4gSXQgd2FzIGNvbmZpcm1lZCB0aGF0IHZhcmlhYmxlcyBoYXZlIHZhbHVlcyB0aGF0IGNh
bm5vdCBiZSBoZWxkIHdoZW4NCj4+Pj4+IElTUiBvY2N1cnMgdGhyb3VnaCBub3JtYWwgSCAvIFcg
aXJxLg0KPj4+Pj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0NCj4+Pj4+ID0gKHN0cnVjdCBkd2MzX2V2ZW50X2J1ZmZl
ciAqKSBldl9idWYgPSAweEZGRkZGRjg4REU2QTAzODAgKA0KPj4+Pj4gCSh2b2lkICopIGJ1ZiA9
IDB4RkZGRkZGQzAxNTk0RTAwMCwNCj4+Pj4+IAkodm9pZCAqKSBjYWNoZSA9IDB4RkZGRkZGODhE
REMxNDA4MCwNCj4+Pj4+IAkodW5zaWduZWQgaW50KSBsZW5ndGggPSA0MDk2LA0KPj4+Pj4gCSh1
bnNpZ25lZCBpbnQpIGxwb3MgPSAwLA0KPj4+Pj4gCSh1bnNpZ25lZCBpbnQpIGNvdW50ID0gMCwg
PDwNCj4+Pj4+IAkodW5zaWduZWQgaW50KSBmbGFncyA9IDEsIDw8DQo+Pj4+PiA9PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PQ0KPj4+Pj4gPSAiZXZ0LT5jb3VudD0wIiBhbmQgImV2dC0+ZmxhZ3M9RFdDM19FVkVOVF9QRU5E
SU5HIiBjYW5ub3QgYmUgc2V0DQo+Pj4+PiBhdCB0aGUgc2FtZSB0aW1lLg0KPj4+Pj4NCj4+Pj4+
IFdlIGVzdGltYXRlIHRoYXQgYSByYWNlIGNvbmRpdGlvbiBvY2N1cnJlZCBiZXR3ZWVuIGR3YzNf
aW50ZXJydXB0KCkNCj4+Pj4+IGFuZCBkd2MzX3Byb2Nlc3NfZXZlbnRfYnVmKCkgY2FsbGVkIGJ5
DQo+Pj4+PiBkd2MzX2dhZGdldF9wcm9jZXNzX3BlbmRpbmdfZXZlbnRzKCkuDQo+Pj4+PiBTbyBJ
IHRyeSB0byBibG9jayB0aGUgcmFjZSBjb25kaXRpb24gdGhyb3VnaCBzcGluX2xvY2suDQo+Pj4+
DQo+Pj4+IFRoaXMgbG9va3MgbGlrZSBpdCBuZWVkcyBhIG1lbW9yeSBiYXJyaWVyLiBXb3VsZCB0
aGlzIHdvcmsgZm9yIHlvdT8NCj4+PiBNYXliZSBpdCBjb3VsZCBiZS4gQnV0ICJldnQtPmNvdW50
ID0gMDsiIGlzIHVwZGF0ZWQgb24NCj4+IGR3YzNfcHJvY2Vzc19ldmVudF9idWYoKS4NCj4+PiBT
bywgSSB0aGluayBzcGluX2xvY2sgaXMgbW9yZSBjbGVhciByb3V0aW5lIGZvciB0aGlzIGlzc3Vl
Lg0KPj4+DQo+Pg0KPj4gTm90IHJlYWxseS4gSWYgcHJvYmxlbSBpcyBkdWUgdG8gdGhlIGV2dC0+
ZmxhZ3Mgbm90IHVwZGF0ZWQgaW4gdGltZSwgdGhlbg0KPj4gdGhlIHNvbHV0aW9uIHNob3VsZCBi
ZSB1c2luZyB0aGUgbWVtb3J5IGJhcnJpZXIuIFRoZSBzcGluX2xvY2sgd291bGQNCj4+IG9iZnVz
Y2F0ZSB0aGUgaXNzdWUuIEFuZCB3ZSBzaG91bGQgYXZvaWQgdXNpbmcgc3Bpbl9sb2NrIGluIHRo
ZSB0b3AtaGFsZi4NCj4gDQo+IFRoaXMgaXNzdWUgd2FzIG9jY3VycmVkIGJ5IHdhdGNoZG9nLiBU
aGUgaW50ZXJydXB0IG9jY3VycmVkIGluIHVuaXRzIG9mIDQgdG8gNXVzIGFuZCBjYW5ub3QgYmUg
cmVsZWFzZWQgdW50aWwgdGhlIGJvdHRvbSBpcyBleGVjdXRlZC4NCj4gSWYgaXQgaXMgYSBwcm9i
bGVtIHdpdGggdGhlIG1lbW9yeSBiYXJyaWVyLCB0aGUgdmFsdWUgc2hvdWxkIGJlIHVwZGF0ZWQg
YWZ0ZXIgYSBmZXcgY2xvY2tzIGFuZCB0aGUgVE9QIHNob3VsZCBydW4gbm9ybWFsbHkuIElzbid0
IGl0Pw0KDQpDYW4geW91IGd1YXJhbnRlZSB0aGF0IGEgdmFsdWUgaXMgc3RvcmVkIGFmdGVyIFgg
YW1vdW50IG9mIHRpbWUsIGV2ZXJ5IHRpbWU/DQoNCj4gQW5kIENvdWxkIHlvdSBleHBsYWluIG1l
IHdoeSB3ZSBzaG91bGQgYXZvaWQgdXNpbmcgc3Bpbl9sb2NrIGluIHRoZSB0b3AtaGFsZi4NCj4g
DQoNClRoZSB0b3AtaGFsZiBhbmQgYm90dG9tLWhhbGYgYXJlIHNlcmlhbGl6ZWQuIFdoaWxlIHRo
ZSBib3R0b20taGFsZg0KaGFuZGxlciBpcyBydW5uaW5nLCB0aGUgaW50ZXJydXB0IHNob3VsZCBi
ZSBtYXNrZWQuIElmIHRoZSB0b3AtaGFsZiBnb3QNCmNhbGxlZCBpbiB0aGUgbWlkZGxlIG9mIHRo
ZSBib3R0b20taGFsZiBoYW5kbGVyLCBzb21ldGhpbmcgZWxzZSBpcw0Kd3JvbmcuIFRoZXJlIHNo
b3VsZCBub3QgYmUgYSByYWNlIHRoYXQgcmVxdWlyZXMgYSBzcGluX2xvY2sgZm9yIHRoaXMNCnBh
cnRpY3VsYXIgY3JpdGljYWwgc2VjdGlvbi4NCg0KVGhlIHByb2JsZW0geW91J3JlIHNlZWluZyBp
cyBwb2ludGluZyB0b3dhcmQgYSBtZW1vcnkgYmFycmllciBpc3N1ZS4NCg0KQWxzbyB5b3Ugbm90
ZWQgdGhhdCB0aGVyZSdzIGFuICJpbnRlcnJ1cHQgc3Rvcm0iLCB3aGljaCBkb2Vzbid0IGluZGlj
YXRlDQp0byBtZSB0aGF0IGl0J3MgZHVlIHRvIFBDSWUgbGVnYWN5IGludGVycnVwdCBkZS1hc3Nl
cnRpb24gZGVsYXkgcmVzcG9uc2UNCmVpdGhlci4NCg0KQ2FuIHlvdSB0ZXN0IGl0IG91dCBhbmQg
d2UgY2FuIHRha2UgYSBsb29rIGZ1cnRoZXI/DQoNCkJSLA0KVGhpbmgNCg0KDQo=
