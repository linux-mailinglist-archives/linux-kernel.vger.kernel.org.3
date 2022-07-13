Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FBD9572B01
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 03:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233707AbiGMBmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 21:42:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiGMBma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 21:42:30 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42E9932EEA;
        Tue, 12 Jul 2022 18:42:29 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id ABDF2466F2;
        Wed, 13 Jul 2022 01:42:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1657676549; bh=Z/4/sOjDwVVCWHVdxQeExZxoMSKk4rs+4gZfTuKKzkk=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=gThQeZH3MtXxSaHFy0XX0BFXPD9Di6AINtV+aDS0zrxFNGYeOJZNIjIS8dogIdop7
         Nm+tibdzzmR8akqbFqiYkiKfxN3OHDa4cIr0zMwG6ouWAX3BhJyhEMIMiL5aVRgGal
         dkB31pYAchZNJylDChLofgX8ZgX6Y/rJiTk+6W71lTX3Kh7mDprZUzWE/KT0Ov3n4e
         nFCu/F3tBAtG2lr7pwWZq7mUVDCzM/iwnhiV2Rh1T1yTxmdk2dVJvErTkkOloTH6Mi
         MMvPwdT0xGIe640hHQ86QYffeZNf16IJCP6sjkycoifi+nxfRQLfV/hqr77G5E14SY
         ry8le9tcTv29w==
Received: from o365relay-in.synopsys.com (us03-o365relay1.synopsys.com [10.4.161.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id F1CA9A006D;
        Wed, 13 Jul 2022 01:42:27 +0000 (UTC)
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam04lp2170.outbound.protection.outlook.com [104.47.73.170])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 74CD5800B4;
        Wed, 13 Jul 2022 01:42:26 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KrZS3/VE";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DmcDGExvlHihMvhaXXn/LGpJeBRo7Mgqc3yhJuLCBGJ7r12soTrTioLjhZj+XTyDWBaVUVlNbZNTVg+ei1MVx4+LC/Tm4jxaC8MxdfOBkQQBtE5wR/djj7NkqTkA1E/JAK5OIs5JB8Bz9w2MLy8ALl6n8/RMwsuqnn74ObSSOZ87XTzPdW5PKZa8oKwFfI5wktPSlc67l1s4kbRpXNla7y6qcQOSYgOyyUZv0/3+mBT9dCbDh68v/nNo3BoCCbrCUzwu0niiCLA6EHvi8JbJbO87okvvLM428Dla2zZoiF0wXdOUDW7JHHr6IvqXVWX92E4nCTJtxZ5HqsYIxasOBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Z/4/sOjDwVVCWHVdxQeExZxoMSKk4rs+4gZfTuKKzkk=;
 b=Zkc3QcVm/GsgiPhw40ghdVpM7gHYeRMSV5yqhFnR3GP7u6wbQdyiEeoUBwdgB5pPdjTFalofNEGZFIzoEOi1tcKZf8lL8FcoKsYLLILBx+khUJl22p4OBbWvzADrg5oQNPZ2/etrWFR6/zZLTkOwROzTfx6K2ov5yQXWDcFSj23JvKJG8yA7vajgwpOr2Dc8bTHhCsfyP5BeRi1rPo//tjjVsFD9qBLCGO2KVsIoGwULA41SnWB7cKMVTqwA5oGaTUXSNQbFjLc99uM9jmbONr6vCaMu5G2aLT8iUYh2tehoWRTv3T2CEtwxXWygF2Kb/w890ATFfrFAw4XKn465aQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Z/4/sOjDwVVCWHVdxQeExZxoMSKk4rs+4gZfTuKKzkk=;
 b=KrZS3/VE5ZJVSCyr8bPdir3FTDwmbvu+v06plpQxfLaRK3bdXfaabplfg+1L/QPPJNdpW0i3UxhJF9m08/ePXyuiW7x3pk7FrkzzXGl8R4yu8f/cq+DrYYpgIr7HKdLG3HiKpGgopC+TY3Z9dOiDXHJ18Kgl6OMYw3ySwdim1BQ=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MWHPR12MB1677.namprd12.prod.outlook.com (2603:10b6:301:11::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5417.25; Wed, 13 Jul
 2022 01:42:23 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::8948:d205:4d47:c54c%7]) with mapi id 15.20.5417.026; Wed, 13 Jul 2022
 01:42:23 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Topic: [PATCH 4/5] usb: dwc3: Allow end transfer commands to be sent
 during soft disconnect
Thread-Index: AQHYkvuyG8yeBB+HgESO8az/W4EWca11SMkAgAYJLICAADuqAA==
Date:   Wed, 13 Jul 2022 01:42:23 +0000
Message-ID: <889ba0fc-4a8c-cb89-ba7c-90119a58b997@synopsys.com>
References: <20220708185007.21743-1-quic_wcheng@quicinc.com>
 <20220708185007.21743-5-quic_wcheng@quicinc.com>
 <06498069-db45-202b-eba6-47bfa6948143@synopsys.com>
 <8029f6bb-4704-0495-00d2-ee78ee684eb3@quicinc.com>
In-Reply-To: <8029f6bb-4704-0495-00d2-ee78ee684eb3@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 158c5761-4434-4ef5-6e5d-08da6470ef06
x-ms-traffictypediagnostic: MWHPR12MB1677:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: GstW/cBUGagUbF36TeMewQvtAhWFo3jHriEE+X9dc2FQU3FIEPMhxFXRyORtFEauW41PNWbkYGo/bXryIAA/aeDUA4RoOjkx9kmC+B/rAuiRCwE/nxZEZEK+Px377SgNz2I34HzIXyv6C3PQHbXbkZckRLsN6u35UO5T+JQaIYWhZgftejWwklAltPTmH7yAMI/foeTzrOzZ8qv6TIg1qQW9vIvTV6bPnzZ9lAuyBI3o5qSIP/qhb1Yl6Dji5wbJ8RktJ7ZgGQTKs0YTzasbKPhzTXF1Sh5eLiyJ6O2pIpT2/qVYvna+rDxUS0IcsDdtddo2+HMkGUoYsq/4ubID3b+MPVX8yH0bGK9JH4zMJoFKQ13/t0BLl7JGOCRxdnYriCOrMkQY0pfzQCyOlljaPZujAL8SaM9sj7iJQkJtuiAay2NwPpNp8PASwpmkFFZI89NG17FB4tM1EiJo1577k0R3AVf7L7/7e875QSgT1zyaXtDeHBykRAxTuVn0ha9/P8KQdatiUGTbelJ6nf1GZo4Ush3TJG+mGZ4qOHEvyRn4OGxKFE90A1wc66Up6YxQUgLYAvyWwMg5xlAoNQKMdITNGXjFAIXn/bvSJTPUnEkPBO34BByQ4uw1IE5Pjdu+2Al28JJBKM5WNFQXJKfV9B2IyoKyEUG+UEb044uLCP3QfqmQfXUj2Oov6ZtODFcjYPlffZPyqX7lc1/xpOPEvw4gtiqRLC2CWQIvZjtrMqVT2VqoXXqYk1wWFKuYEN/XkvML1r9v79PxYPL5oHMHd9nS/byAVUaYCaEuHHkGEKCQvRYJ7wa0Uiv8ej5UQ/ximoqMnIvAXrOFMV77s1A9soY68G4+eNiv4XVwBKhimH8O2jAZyhU1xUOZC517Ra0K
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(136003)(396003)(39860400002)(366004)(346002)(53546011)(4326008)(8676002)(66446008)(316002)(26005)(76116006)(86362001)(6512007)(186003)(66556008)(6506007)(66476007)(64756008)(2616005)(31696002)(110136005)(41300700001)(71200400001)(66946007)(478600001)(38070700005)(31686004)(6486002)(54906003)(122000001)(2906002)(8936002)(5660300002)(36756003)(83380400001)(38100700002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?c204K0luR29sc2d6a0FZS29ub3lQNWFySURUNERJcEdkSlpOT0RVQy9QOWl5?=
 =?utf-8?B?Z2JKVzV1VzFjampjalZVaUhrQ2JLeE1rWUVXZy9DSTk3WGsreVJXd2g1Q1Jy?=
 =?utf-8?B?bEduYzk3ZUZPMUJPUEpiaGxSdit3bEp4R0QyWnJzUkpkMkROcG0xN05OVjVw?=
 =?utf-8?B?WHp6VTl6czQ1YUdyenp0Wm01TXNXcFJNdHE1eldsL0Y5aUZkUVk3NjlTd002?=
 =?utf-8?B?ajlhclZlVTQ1dXNLR08wZE5pcEVmUSthdTE2ZlRjUVF3REtIM1BKLzFhT29I?=
 =?utf-8?B?VFgvaVNOaEpXempsM3B4ZG5YYWxFT1BCTDlueTlSTTlwVVVYOVhxdGY0SzlS?=
 =?utf-8?B?V2xIL3NEUDBwM0ZpSmJFMHFUQlluamtyNldDRm82THp2M3EzcGZSZHF6VGxD?=
 =?utf-8?B?ZG1OSjBZSUFnMVQ3VkFjaTlNOUJ5NXpkbDAzQnNRNmxDNTZveGNPZnZSK3Jm?=
 =?utf-8?B?Z2p1V2NiYytpbXdhY3J5b2RVdVZXYitDOUVJczF3Wkg3bmcvbHJHRXdtN2R1?=
 =?utf-8?B?N2hxYmxiWCtzL2F0b2pTWVorcE1jNGpKdkg4QVV1RmNhM205VXZ5TXBPZ1Jm?=
 =?utf-8?B?YnBKTDdpN0tZOEpheENJemFSNXA5c2Z0cC9MWXcvS21uK2VUblg5WXh6Nmlw?=
 =?utf-8?B?UGk2UitrRWwyTGN5ME9lZ1NMVmMyT0RTRVRSa3dLUmtPbjhCdWIvQmtUWGty?=
 =?utf-8?B?QjNJSU13ME9KTDNicWw0MjUxK01CSlNjSVllNUpOOExUUnk0QnJtd3dUd1JF?=
 =?utf-8?B?dTh0ek5WUVpTc2o0dzc4NFR6Z29RaXlrQ284VzlPTmZZbjZZWHhUeGlSandZ?=
 =?utf-8?B?U1lOMm01V25McjZhRHEzaUU1Qk5OeWMxRVJCMEZQaEpWdWdSY0d5WEhjbUJV?=
 =?utf-8?B?K1M0SFFXZndKdG00ay90TzRIYlFYOCtLTytYUW9NQTByRVJDVVUyVis4M1VC?=
 =?utf-8?B?VGhZT1NVNFNGbkFGNVNFZEhsV2xRL1RNWTdKTE85UjhhWThNNWxESUdZakRI?=
 =?utf-8?B?N3Q0bkNzSm5VdmkvMzVJUVBPN1pCQkJENGRoL0tJcVFyczhPZU82VlJaa3dt?=
 =?utf-8?B?aHhzUzNhNHcwMXBDSUdOaWNPVUxybURvTVBsUnpWNitBMEtId05oMG55bTNx?=
 =?utf-8?B?YWs4eUVVQVErMkk0cXRtMWl5amNsUXdab1VYTlZsU1JqU0pSY3pCWERjSUY0?=
 =?utf-8?B?c3RURVFZNEFHbStCYUVDN0lXWDMzZzBwUWZIU1djOHIxVHVQVXVUOHhWdm92?=
 =?utf-8?B?Yyt6RzgzTUpzbUZ0QlpUSzYvZWttNlcrK0o4TXFHZHF0bDB1NSs4SkNNU2x4?=
 =?utf-8?B?YUpMZkx3QUV1WkI2YWJ2a3o1TTZzK1FWUDJZNnQ1NFlJcWZpb2VjSzF1REpJ?=
 =?utf-8?B?TG9LdERERXA3R2FWdXJUSlp2Rkt5TXV4U1FqbGQrK2ZNekZHNkV6Q3JYQUp4?=
 =?utf-8?B?eEZyRjAycGVsRGk0ZzF6UUJBTUJEanl3SnZKZHBwTmZrUlpVKzczb01FWlpM?=
 =?utf-8?B?NEVSMmRtdkY5N3lnSjlkWXVmVlluVEYrT2huczFBbS8xQUdtNGJjWmY1blph?=
 =?utf-8?B?TnltWlI0L0VzeEp1WkVDeXl3YWZob2VBNHNJbzRoUjBxZmlFZzNMV1YyS3Fk?=
 =?utf-8?B?OURldUc3SUhvY1RRekNJZUNjOVpaZTlMcis0L3RuK3ZxSVRsUE1lcHhsYjJS?=
 =?utf-8?B?R1AyZElQWHZ4WFRGcWdTWEZRbWkyNDZtdnhpb2JSVm1DODkrak5oNVhRdk5W?=
 =?utf-8?B?aUpvUEdwNllsN2F3L3NEV3ZjSnVNdk1uaGgrb3NNdi9yM3BvWE9NYmhsSEJ6?=
 =?utf-8?B?L29ncWwweGlhd1A0bFpJMU1OcFRrSmRQVzhiUGREaXBJMmYrVXlBQWprRzRC?=
 =?utf-8?B?eDN6UmprSkFjOHJNMWlFbG90aUxqbVJmenpISkppQjZjbVlHMnJNaURMbm43?=
 =?utf-8?B?ZjBtVFBjb1FOelhIWjRDVndWVDEyYWxsVDlSaGtNZDFVQStqOEM1M2g4Ynhh?=
 =?utf-8?B?MHhHcmtWYzF0bzZ5c3F0dUk1Wk5VT2xJTFJYY2YxZ1VUbCtLcTZaOG51L3g3?=
 =?utf-8?B?TUlHM0sxdDlUUk1PNE1FTC9KQ1J5c1Jvc2pQckN0TnRKU0psUUx3M1V1bzl2?=
 =?utf-8?Q?Q6AyqA/Nb0teC244By8Wafqfl?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <8C80CDFC116DE847A88B67D9721AE7D0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 158c5761-4434-4ef5-6e5d-08da6470ef06
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Jul 2022 01:42:23.5324
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: R2gsCIrlokdgr0VldwZm+qQEZzFTwXQsHsFXCuXbbKGWbAMnGR3d7PVghKTWIslI5fZXXRx5EXr0Tc2DhM/HoA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1677
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNy8xMi8yMDIyLCBXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPg0KPiBPbiA3
LzgvMjAyMiA2OjU4IFBNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBPbiA3LzgvMjAyMiwgV2Vz
bGV5IENoZW5nIHdyb3RlOg0KPj4+IElmIHNvZnQgZGlzY29ubmVjdCBpcyBpbiBwcm9ncmVzcywg
YWxsb3cgdGhlIGVuZHhmZXIgY29tbWFuZCB0byBiZSANCj4+PiBzZW50LA0KPj4+IHdpdGhvdXQg
dGhpcywgdGhlcmUgaXMgYW4gaXNzdWUgd2hlcmUgdGhlIHN0b3AgYWN0aXZlIHRyYW5zZmVyIGNh
bGwNCj4+PiAoZHVyaW5nIHB1bGx1cCBkaXNhYmxlKSB3b3VsZG4ndCBhY3R1YWxseSBpc3N1ZSB0
aGUgZW5keGZlciBjb21tYW5kLA0KPj4+IHdoaWxlIGNsZWFyaW5nIHRoZSBERVAgZmxhZy4NCj4+
Pg0KPj4+IEluIGFkZGl0aW9uLCBpZiB0aGUgRFdDM19FUF9ERUxBWV9TVE9QIGZsYWcgd2FzIHNl
dCBiZWZvcmUgc29mdCANCj4+PiBkaXNjb25uZWN0DQo+Pj4gc3RhcnRlZCAoaS5lLiBmcm9tIHRo
ZSBkZXF1ZXVlIHBhdGgpLCBlbnN1cmUgdGhhdCB3aGVuIHRoZSBFUDAgDQo+Pj4gdHJhbnNhY3Rp
b24NCj4+PiBjb21wbGV0ZXMgZHVyaW5nIHNvZnQgZGlzY29ubmVjdCwgdG8gaXNzdWUgdGhlIGVu
ZHhmZXIgd2l0aCB0aGUgZm9yY2UNCj4+PiBwYXJhbWV0ZXIgc2V0LCBhcyBpdCBkb2VzIG5vdCBl
eHBlY3QgYSBjb21tYW5kIGNvbXBsZXRlIGV2ZW50Lg0KPj4+DQo+Pj4gU2lnbmVkLW9mZi1ieTog
V2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWljaW5jLmNvbT4NCj4+PiAtLS0NCj4+PiDCoMKg
IGRyaXZlcnMvdXNiL2R3YzMvZXAwLmPCoMKgwqAgfCAzICstLQ0KPj4+IMKgwqAgZHJpdmVycy91
c2IvZHdjMy9nYWRnZXQuYyB8IDUgKysrKy0NCj4+PiDCoMKgIDIgZmlsZXMgY2hhbmdlZCwgNSBp
bnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdXNiL2R3YzMvZXAwLmMgYi9kcml2ZXJzL3VzYi9kd2MzL2VwMC5jDQo+Pj4gaW5kZXggNTA2
ZWY3MTdmZGMwLi41ODUxYjBlOWRiMGEgMTAwNjQ0DQo+Pj4gLS0tIGEvZHJpdmVycy91c2IvZHdj
My9lcDAuYw0KPj4+ICsrKyBiL2RyaXZlcnMvdXNiL2R3YzMvZXAwLmMNCj4+PiBAQCAtMjkwLDgg
KzI5MCw3IEBAIHZvaWQgZHdjM19lcDBfb3V0X3N0YXJ0KHN0cnVjdCBkd2MzICpkd2MpDQo+Pj4g
wqDCoMKgwqDCoMKgwqDCoMKgwqAgaWYgKCEoZHdjM19lcC0+ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZ
X1NUT1ApKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgY29udGludWU7DQo+Pj4g
wqDCoCAtwqDCoMKgwqDCoMKgwqAgZHdjM19lcC0+ZmxhZ3MgJj0gfkRXQzNfRVBfREVMQVlfU1RP
UDsNCj4+PiAtwqDCoMKgwqDCoMKgwqAgZHdjM19zdG9wX2FjdGl2ZV90cmFuc2Zlcihkd2MzX2Vw
LCB0cnVlLCB0cnVlKTsNCj4+PiArwqDCoMKgwqDCoMKgwqAgZHdjM19zdG9wX2FjdGl2ZV90cmFu
c2Zlcihkd2MzX2VwLCB0cnVlLCBkd2MtPmNvbm5lY3RlZCk7DQo+Pj4gwqDCoMKgwqDCoMKgIH0N
Cj4+PiDCoMKgIH0NCj4+PiDCoMKgIGRpZmYgLS1naXQgYS9kcml2ZXJzL3VzYi9kd2MzL2dhZGdl
dC5jIGIvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPj4+IGluZGV4IGJkNDA2MDhiMTlkZi4u
ZmJhMjc5N2FkOWFlIDEwMDY0NA0KPj4+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMN
Cj4+PiArKysgYi9kcml2ZXJzL3VzYi9kd2MzL2dhZGdldC5jDQo+Pj4gQEAgLTM2OTYsOCArMzY5
NiwxMCBAQCB2b2lkIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXIoc3RydWN0IGR3YzNfZXAgDQo+
Pj4gKmRlcCwgYm9vbCBmb3JjZSwNCj4+PiDCoMKgwqDCoMKgwqAgaWYgKGRlcC0+bnVtYmVyIDw9
IDEgJiYgZHdjLT5lcDBzdGF0ZSAhPSBFUDBfREFUQV9QSEFTRSkNCj4+PiDCoMKgwqDCoMKgwqDC
oMKgwqDCoCByZXR1cm47DQo+Pj4gwqDCoCArwqDCoMKgIGlmIChpbnRlcnJ1cHQgJiYgKGRlcC0+
ZmxhZ3MgJiBEV0MzX0VQX0RFTEFZX1NUT1ApKQ0KPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47
DQo+Pj4gKw0KPj4+IMKgwqDCoMKgwqDCoCBpZiAoIShkZXAtPmZsYWdzICYgRFdDM19FUF9UUkFO
U0ZFUl9TVEFSVEVEKSB8fA0KPj4+IC3CoMKgwqDCoMKgwqDCoCAoZGVwLT5mbGFncyAmIERXQzNf
RVBfREVMQVlfU1RPUCkgfHwNCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoCAoZGVwLT5mbGFncyAm
IERXQzNfRVBfRU5EX1RSQU5TRkVSX1BFTkRJTkcpKQ0KPj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKg
IHJldHVybjsNCj4+PiDCoMKgIEBAIC0zNzQ0LDYgKzM3NDYsNyBAQCB2b2lkIGR3YzNfc3RvcF9h
Y3RpdmVfdHJhbnNmZXIoc3RydWN0IA0KPj4+IGR3YzNfZXAgKmRlcCwgYm9vbCBmb3JjZSwNCj4+
PiDCoMKgwqDCoMKgwqAgX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKGRlcCwgZm9yY2UsIGlu
dGVycnVwdCk7DQo+Pj4gwqDCoMKgwqDCoMKgIHNwaW5fbG9jaygmZHdjLT5sb2NrKTsNCj4+PiDC
oMKgICvCoMKgwqAgZGVwLT5mbGFncyAmPSB+RFdDM19FUF9ERUxBWV9TVE9QOw0KPj4NCj4+IENh
biB3ZSBjbGVhciB0aGlzIGZsYWcgaW4gX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKCkuIEl0
IHNob3VsZCBhcHBseQ0KPj4gaWYgRW5kIFRyYW5zZmVyIGNvbW1hbmQgd2FzIHNlbnQuDQo+DQo+
IEkgd2FudGVkIHRvIG1ha2Ugc3VyZSB0aGF0IHdlIHdlcmVuJ3QgbW9kaWZ5aW5nIHRoZSBERVAg
ZmxhZ3Mgb3V0c2lkZSANCj4gb2YgYSBzcGluIGxvY2suwqAgUGF0Y2gjMyBtb2RpZmllcyBpdCB3
aGVyZSB3ZSB1bmxvY2sgYmVmb3JlIGNhbGxpbmcgDQo+IF9fZHdjM19zdG9wX2FjdGl2ZV90cmFu
c2ZlcigpLCBzbyB3ZSBjYW4gYWxsb3cgdGhlIGR3YzMgdGhyZWFkZWQgSVJRIA0KPiBoYW5kbGUg
ZXZlbnRzIHdoaWxlIHRoZSBjbWQgc3RhdHVzIHBvbGxpbmcgaGFwcGVucy4NCj4NCj4gTWF5YmUg
d2UgY2FuIHVubG9jay9sb2NrIHRoZSBkd2MzLT5sb2NrIGluc2lkZSANCj4gX19kd2MzX3N0b3Bf
YWN0aXZlX3RyYW5zZmVyKCkgYW5kIHRoYXQgd2F5IHdlIGNhbiBlbnN1cmUgREVQIGZsYWdzIGFy
ZSANCj4gbW9kaWZpZWQgcHJvcGVybHk/DQoNCkkgZGlkbid0IHJlYWxpemUgdGhhdCB5b3UgdW5s
b2NrL2xvY2sgd2hlbiBjYWxsaW5nIA0KX19kd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyKCkuIFdl
J2QgbmVlZCB0byBiZSBjYXJlZnVsIGlmIHdlIHdhbnQgdG8gDQp1bmxvY2svbG9jayBpdCwgYW5k
IGF2b2lkIGl0IGFsbCB0b2dldGhlciBpZiBwb3NzaWJsZS4gSXQgY2FuIGJlIGVhc2lseSANCm92
ZXJsb29rZWQganVzdCBsaWtlIGR3YzNfZ2FkZ2V0X2dpdmViYWNrKCkuDQoNCldoYXQgaXNzdWUg
ZGlkIHlvdSBzZWUgd2l0aG91dCBkb2luZyB0aGlzPw0KDQpUaGFua3MsDQpUaGluaA0KDQoNCg==
