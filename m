Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 031F95954DC
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:19:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232630AbiHPITg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:19:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbiHPISv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:18:51 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam02on2065.outbound.protection.outlook.com [40.107.95.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 797C5E81;
        Mon, 15 Aug 2022 23:06:53 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1EGaILiimfTfiPlClVyNj7ew05v9kWwCL2cz8JNVGZOxf3QbFcuHHeYxfjdm24YG/lB0+5Li7r7Ngweg1h592u5yApHz5FuQ3TIsJQOvfPHlNSSUyDATnw2thLaH2OlHyiKJh/32P4Jwmo+PbprzTe0JGN5yvBKhf1oggiz5MSSGWdm7Ua2UVkab+U3xii/qTDIDa+VULp1nuE3h8lyHx5uDtE7iNTX4CvB0mCrCewBnO42OTZoGkMqBtCkakfaIxgd62LALlWvBTLVf/qCJ+2gafToeiNGPKstx5mFIDb6dYEBJh7FqLk/Wzu9lNsFdNVmvUvAgv3K1ligC0R6AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MTZHFnZOvA7+4j5gAMQja4Mc0YTuNoOtwrxGtaHX5Gs=;
 b=cXsnx4lWbNkTZb+z3s7V6Y/4tn5OdQJpnov6fXC4M9Jq3/Cnt8rN91c0YHS6STNi6P8QLQuzZttzTTCyTlUi8ieNUQfzf9WfFEGc1OtqT3bOEfDk2o+wLthFGoWmM6theB8x/c4YyLPlPGxqeoCaL74CdwTGl9rigDRprTrH/2mTiRgXRA0nPFPHiH5V/nYCmISEIfmco0a59DrdUN7lwOVDJc/cRm1EBohY6D6sAEX716dAq4Pd9QgCLxnAvUMwrTS63WqUOYPp/BhqPfkaSI99K0mmv0s5uueWJ8BRwwqMwvKQ0kLl0R+i2kr3k/jRtP2q091AntAWd4q5mZWQdg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MTZHFnZOvA7+4j5gAMQja4Mc0YTuNoOtwrxGtaHX5Gs=;
 b=klzCXtOOvhRSrCUDsMwSsW+VOEYvCuT1jc6F6aDdDRqjuOhry7J7anWs1oe1b/SwO6mxbm5+yvCa82xV13hNYxD/JVjp9e4xjrbboXq7DJEHrrR41oN6D3gFU6laMeIAQB/zzPiJm7p1I8c4+zqcJWEiG0w3ewuyBRrubOcA9ure+suX/1191OOeLDzG0J718SGKJ4zNCyzNlJ0pCE7ulX68rsxyFaUISzoUdmkGK5VuUKZWXJ2w0q6NDu3niJVzZyyF5uCXjtYD0M5gpJgJIy7u5072Vg4Ty2U9k3Ddqwe2bGaPgqp+4tby52HFxHzg5pWUBxlngg/EWnxdT79kjQ==
Received: from DM5PR12MB4663.namprd12.prod.outlook.com (2603:10b6:4:a9::26) by
 MWHPR1201MB0143.namprd12.prod.outlook.com (2603:10b6:301:54::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5504.15; Tue, 16 Aug
 2022 06:06:51 +0000
Received: from DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051]) by DM5PR12MB4663.namprd12.prod.outlook.com
 ([fe80::b4ab:4d63:1cdd:b051%4]) with mapi id 15.20.5504.025; Tue, 16 Aug 2022
 06:06:50 +0000
From:   Chaitanya Kulkarni <chaitanyak@nvidia.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "michael.christie@oracle.com" <michael.christie@oracle.com>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "target-devel@vger.kernel.org" <target-devel@vger.kernel.org>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH v2] scsi: target: Save a few cycles in
 transport_lookup_[cmd|tmr]_lun()
Thread-Topic: [PATCH v2] scsi: target: Save a few cycles in
 transport_lookup_[cmd|tmr]_lun()
Thread-Index: AQHYsS180iavOQZ500+RL+n6yaTQEa2xCmQA
Date:   Tue, 16 Aug 2022 06:06:50 +0000
Message-ID: <757f1326-bc70-aa93-b2d3-dfd91698406e@nvidia.com>
References: <03705222390bfa3b48ad7658f693fc0fc030b3ae.1660596679.git.christophe.jaillet@wanadoo.fr>
In-Reply-To: <03705222390bfa3b48ad7658f693fc0fc030b3ae.1660596679.git.christophe.jaillet@wanadoo.fr>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 47a063fb-26a9-474d-68c5-08da7f4d82ba
x-ms-traffictypediagnostic: MWHPR1201MB0143:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wmxM7whPoDGPXIh2N2nIj3i9wWYXgQqosn/701sLnT/xBPl6A1xpH4qr3E+P7bymqgffmr26bdJqsRuLRMY+TVqkn3B0MPVNnjOLo4xKRiSiJImQF7/crzTVFhMXqG/U4TcB7KJmlKagwnXD05DRnhi5Ol3BB+Dj+i91iGvE8HBHJg4L/97/Rh85/9avRezFC0+36CV/qUfDXYNliQqVSjBX/IX6T33NL2vb9np4ZjFn20hrQcWUFe6j5YM9Um8UCtOFzX0mOJqh3rEcmKGRLGmbJaCI20NoHX4y1GieucCB1f2BICvuPXUbfM9MNXGEqHrD0vXpOIPOs1fwuVSf3ST+vHcCD0IHyIzw6Yp14QlGg6HmJBf8e+uZWT+oALOB1KcQsJ3J/PfBTknySt6gEFBlmNqw1OYFRPPNT0E//nIB3xLWNTuU3RSNDImfnC3hCjY9w7/kr7LHGXghg1yyCptRJV5OF4Cvwaz2Ni7MLF6wYDyT638hCP5+uZdl3NLkAHa1u9sthJkzhA4yVF7I3Q8bvkf8Yw/8ltz8PoflChYe1fiUNQrKa+N/KWjSUvmOgb38+8WYympYs7JnWO8dovD5fUnqDQuWkmkykAv2ldwmezqFuF5ZycUTmECO9DvzKg+xbCBpeHkydzC/ihbo8e4wwZYT/e4bbjw9D0b9G1iuuCYiEQIlaCQ9W7Vq4HDLW/hI7nB8CxoxMGPUYakb2RQ9/aJ5DXaxbj81unoOWLQD8dTb9UIDVGmqHzrM06R9khKVpELo860DZBgLYhCBJ7fEEM9IYx8zFMQpH8TruvH7pUqUCIPDXJm52F9cnuihxgJ0Tll/IvEGRd08s94cBWz/n9nkpRv2s9+GeIFJxzsKz+MmEdaILVju62AM/rIW
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM5PR12MB4663.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(39860400002)(376002)(346002)(396003)(366004)(136003)(4326008)(31686004)(41300700001)(66446008)(66946007)(83380400001)(66476007)(66556008)(8676002)(91956017)(76116006)(64756008)(2906002)(54906003)(186003)(2616005)(36756003)(6916009)(316002)(38100700002)(122000001)(6512007)(86362001)(6506007)(31696002)(5660300002)(8936002)(478600001)(38070700005)(4744005)(53546011)(6486002)(71200400001)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?TzQyTG43ZTVkUXg3QzlPZHBFSmdvdmlvb0Yvd3E3VzdXKzB0eVpnUk5zd3dx?=
 =?utf-8?B?Rm9EMHduN0l1dkRCRm4wZldMV3lNemJyOFpET04rZ21RQi9jeE5IMFF3TmRt?=
 =?utf-8?B?ZFdJZXJpU1puV1ZkSWdWTzJGek5lb1NQbDdRMWo1bkUySlhxT2gzUkZxYUhq?=
 =?utf-8?B?ME11dFlZM0lDMFVlSE91MFdBOVNVMU42M3ZBRkRPdmhqRndsWWFhbC9nRlo4?=
 =?utf-8?B?TXViMTAzMUsyUzFVQjd0MUZrdGFvTWFmaWZPd2pFRUJmMjAvdU03T3huTFFm?=
 =?utf-8?B?ZVA0VFVRNTRQdUtzdGpDZTQzL1dhR0c0WVhXK3QvVm9sdFZEZzBDSFFIKzRT?=
 =?utf-8?B?aHVzQ1o4K1NGYlZpUWJFMlRhVDRPY2RYMktMNklvdW5ZbS8xMWFxeE9xOFYv?=
 =?utf-8?B?VWhDM0RKUE5tV3RubVpyTWpsSXc5TmVGMGUyblNRMzJRVzdXdFZ6RmRrZmN5?=
 =?utf-8?B?dmFPT1hiQ3RrZXVWeEwvQisvTmZ0Q2NrbXZ0QmJVQzhJOWRtdTRPaGUvWHgy?=
 =?utf-8?B?TDU0WE4rbXBMc3BabEU4dW5QOGlTS3pweEg0dGRBWHRNeGhFVUZPY043S2lU?=
 =?utf-8?B?amx2WEJOTTFKbXpYZzZydWhHdEhiMVE3am9WRWdnRU9VeWJEYitPa0xUT3dl?=
 =?utf-8?B?a2Nza1ZLSlRtR2JsZmFNT0gwL1NubmJ5NmRnem1hUW9TKzhZUC81d1NwRlNK?=
 =?utf-8?B?aW03TUw3QzBFMi92OTJZYmFwYnZ0NlFLYmpxTGRTWUYyTGUrcFNPQ0IwNkt2?=
 =?utf-8?B?bHZUV3BveVlnajZmT3ZxWFpaL0J6bzNKT1VQazR0N3V1cFR3REdTUFVDMGZn?=
 =?utf-8?B?ZWo3RE1ybk5VaFJwU0VaL0xka0crSkxKSFZJZithYktaNkRRaVA4VzRZM291?=
 =?utf-8?B?V2F0ZFdmbmk1c255d0pIYlNFM0xpaXZkbVZ4Sm9BdUJ0V2FhL0RvaHQrY2c1?=
 =?utf-8?B?ZXpVdDFLTWxtTm9kR2lRRHh4SDBXejlUekZ4TTlTREhyU25hSHRqTlB0ZDBx?=
 =?utf-8?B?QytHRktBK3ZLRS85UDU5VTVVSzl0TlJvRnU2NFJ0V2lSelVOWFo3VzN3ZjNp?=
 =?utf-8?B?cTZPbFFUSC9iTUp0RGVSdVdhb0c4Yk5yUDBBVktmaHFrbkVnbG1BT2wzNzRI?=
 =?utf-8?B?SlA2dExUQjhYS2Y3Q0F1NzhqNnlmd3AxUllkNlRBYjBsRTFIckdiWjJTbDl3?=
 =?utf-8?B?Wnk3K2tveGNzUEJPY251QVc0SnhlVjFlNVpDcjVqV2tLa0FDVkdOWi8wb2Fv?=
 =?utf-8?B?aHk3bmNuVDNhR2k0UHl6MXpCL0w5anFFWUVXUkhjZFFYcExmU0xHbmtOcHJB?=
 =?utf-8?B?dStoMHpheG5OQnplTTVoc1VqN2tTSSt1VDNPWXVHcUY4LzNrNHJSd1lvTm9h?=
 =?utf-8?B?cVdrTG9qaEJCSk9ucDE3OGI3RWR6dVNBbUlRSmhTekxra0I3UUltSmZvTlMy?=
 =?utf-8?B?ODVQN05TN1hnc1JNUjhjUVQ4alRreHhsOWZiazY0NitYa2hrL1pjRVlESjRV?=
 =?utf-8?B?ZnhzTjNKNm1nYzFDd2pZa0NsbVBpTEtsTm9EbTZPZ29PRGhFQXpGbUNEWGxN?=
 =?utf-8?B?cDFKQUQzQnIwTWRLZTlDUXFRYlVjK3IrZFVvSjFQTXJRTHYzV1NWQzlUTGpR?=
 =?utf-8?B?OGxiR1gwV1RmVi84MFpFTmxwWDBnOEZXSVZhNWp3K2R3S3ZzYlowMUlCSFZw?=
 =?utf-8?B?YzVuaDdNakZMSnZ6aUpRNXdtaXVBM3A1U1hiV0JoZXJ2UnF4RXpkcnlIMHFT?=
 =?utf-8?B?V2VUVEQzbXV6c0NTSGlJcjV3OHRBTHN6V3lvVnZ4RUFsTE5rczlNS201SUhD?=
 =?utf-8?B?cVFFd0FueDVMNWNUa0FjendmWTVDa0wvMWFQRjRqalBKUmwvUUNKeDd1Rkdo?=
 =?utf-8?B?NE1UcEhuMFBlUzloMmpYQTFxT0FIcnFEdG14OU1WTGxTbDQvcnk0TFlCc2Fu?=
 =?utf-8?B?NjB5MkhvdTJlTWtGTDRITm5zYktMeFMwcVFNYVRnOXlVcGp5SXAzWUo2UkMx?=
 =?utf-8?B?c2pWeXh3bjVTYXV5dGdHOWtWcmVyd3MxWDE4dVVVWVdMdENhcWRwTHNxK0ZC?=
 =?utf-8?B?bHRHNEg1TjhLMUpiWHNJMFFwblZzUDdiSGJCK3FpT3pyS3o4QmgyZkhqUGVB?=
 =?utf-8?B?YjBLU3JobUFsUDhQcjJXSjRkMDF6M3ppNW82TWNkVEg4RHc0dmZMS2Z2SlFI?=
 =?utf-8?B?OEE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B4791193A7FED2428714E7828749AA27@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: DM5PR12MB4663.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 47a063fb-26a9-474d-68c5-08da7f4d82ba
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Aug 2022 06:06:50.8185
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iICRVWn+3CDE17yAerV1ILeZhVPzsMlfI7tNzN6jGuGrQobMaMjv33jsgwMmNpKSreQGEEaebCO+bgQvZIvPLA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR1201MB0143
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gOC8xNS8yMiAxMzo1MiwgQ2hyaXN0b3BoZSBKQUlMTEVUIHdyb3RlOg0KPiBVc2UgcGVyY3B1
X3JlZl90cnlnZXRfbGl2ZV9yY3UoKSBpbnN0ZWFkIG9mIHBlcmNwdV9yZWZfdHJ5Z2V0X2xpdmUo
KSB0bw0KPiBzYXZlIGEgZmV3IGN5Y2xlcyB3aGVuIGl0IGlzIGtub3duIHRoYXQgdGhlIHJjdSBs
b2NrIGlzIGFscmVhZHkNCj4gdGFrZW4vcmVsZWFzZWQuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBD
aHJpc3RvcGhlIEpBSUxMRVQgPGNocmlzdG9waGUuamFpbGxldEB3YW5hZG9vLmZyPg0KPiAtLS0N
Cg0KZG8geW91IGhhdmUgYSBxdWFudGl0YXRpdmUgZGF0YSB0aGF0IHNob3dzIGFjdHVhbCBzYXZp
bmdzIG9mIGN5Y2xlcz8NCg0KLWNrDQoNCg0K
