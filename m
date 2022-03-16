Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 052D34DA6DC
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 01:28:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352797AbiCPA3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 20:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242769AbiCPA3m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 20:29:42 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26DA01D0D0;
        Tue, 15 Mar 2022 17:28:25 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id E9F57C0C8C;
        Wed, 16 Mar 2022 00:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1647390505; bh=6F9fN6RpO3eR9JzsWOW7MKuIPGoyiaQGpiFyBkX+59w=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=C7VSkIzD/9bDc6EHv5HOo5VzKsrK0mmWOUl5BKp8SQGhq6ZH5WnUFmPnBtRP1FRAH
         VxqsJdpGvFeD+Q3FjIsHiPxdH1O787W+1IPpeFFU9h7WaqzpZmj56tjxRr4yRh40GB
         /Dw1acs/Z5MLf2pIhaqdYdSgXFo1f2tF4vxSKp4s7oNCGExfv3bAJTrvR8VZosdlsk
         e7LAVb2iasPfcfnjKtg3TCrG3lyeGlmDGvSad1HzKi2a2Z0tt/+MG4wmFethRWbP3R
         DHjMGo9TiweinacrTHROYtMzey4kUyqPRgsZ1EQgoadH/tREJdZ+ot8320hdckasUr
         17Qbd0D8Ln/XQ==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id C4608A024C;
        Wed, 16 Mar 2022 00:28:23 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2168.outbound.protection.outlook.com [104.47.59.168])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 6FBE24013D;
        Wed, 16 Mar 2022 00:28:22 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="XFZZ5n+W";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Tepwh7PlLC5vaUPB8QaulgSNGmTEgArdIvEsuTYIq9Nebj/SZLbeO9zPlWTJDdm67K9/15PG48WhBpWP8U+Q3ed9bKKfEQ1uQkqGan+uc0rTS5666Ntx3dNwDrvOfO8JICv1rw3YWNWv5Xi4DYr8Cd87zkqh2iIrhpCdEWCTcw7LRxP6fFNvdcSyx7dQVe4mGzSbsr8pgOqo4drziavR/Nb4CkjC9J2EKPm/JMXl3Uv07PA6KHl1Hu/tI3WB+YQAhFfnYg2QWi/9Ym2xx6MavoDK0hq1sAOB/r/T1PSwsWXW/4McE7u0ntPaM/I83WffzOcdP7aAFKGjSkc3B/pIlQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6F9fN6RpO3eR9JzsWOW7MKuIPGoyiaQGpiFyBkX+59w=;
 b=ieonh0MnoeSYzYYAQf5tbiKlSfq0iUq71pRkpNH3q4q8Lq5863+DUxkztlD1zyidjWzC5qJO2/H+hU6/EKpH0ek4z6+r7tJcB9M1ZlBpM6EHz9/+APKaUokVBOmAP4CqDsME8oghbyHht+4evHii3GqqI7i57k9tzNpunT6LJb89IdUxVlyTBvxvQJqc6an+PrjTPSevjEnnm6xv996f+eSRaCmqBOtM0dKOMALtiY31dzsSygYbxoUevHzPLtsDj89xIxjJZ7H9QOPMYEvAwIql02Ghn2lzztvHog9M9UBtV/d9OIamnNunvTY7kDI0Otoe4gC6wpXOK8o7pdilfg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6F9fN6RpO3eR9JzsWOW7MKuIPGoyiaQGpiFyBkX+59w=;
 b=XFZZ5n+Wql1DzaC20Ne/0ZbKKZhop9UL0AeLakvYIY1a45gkCG3cY4U95+LTCkEelv08op25wxF2vVcDLoRiNQFk8UozJUC7t5LTCQ7Et1xVwq4N8HF6CisxBEUdZoSdg0pPWZaqtlAPmW5gdQTitHETdYGNmhrUm+H0mwqgEUM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MWHPR12MB1503.namprd12.prod.outlook.com (2603:10b6:301:b::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.26; Wed, 16 Mar
 2022 00:28:15 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5081.014; Wed, 16 Mar 2022
 00:28:15 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v3] usb: dwc3: Issue core soft reset before enabling
 run/stop
Thread-Topic: [PATCH v3] usb: dwc3: Issue core soft reset before enabling
 run/stop
Thread-Index: AQHYOA4WcFY/mr//1UKcd2wlDYJOR6zBKVYA
Date:   Wed, 16 Mar 2022 00:28:14 +0000
Message-ID: <1e2ae095-4933-b268-ffa6-2899d49bffa2@synopsys.com>
References: <20220315014317.14265-1-quic_wcheng@quicinc.com>
In-Reply-To: <20220315014317.14265-1-quic_wcheng@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: fe1bc6ba-00e2-4613-0db1-08da06e3dc6f
x-ms-traffictypediagnostic: MWHPR12MB1503:EE_
x-microsoft-antispam-prvs: <MWHPR12MB1503459254A3B90A1E32FD8CAA119@MWHPR12MB1503.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IQUqKRt5ns2pZUYsOUbCsyLpsTIgi/tkvh4U78612stqdkV96BKECQCnlnV+UxjMyl2V2/WjkvmhgzHVwZO2GjXMEQ8mTKye1w2TizAAanVhjwj+xTeOj+E3OfisUUMKfCve1iizWpmMQTWZt7a6H9aZ7o/+Dn8WZ0Ecx+XJIIzgqDakZqLD+mRDlxYxWChy3yn/FhECgTNXGzTZTiL8ecNujRzDzJu+pN4r5wvPYN65tU4l+kkrNNJQJlu6tEdT7QswcGzHy061rTF86SUqkyeot8/R3aRh2u5I0tBn4nSICoKeu1m0jOVc8xu8MOjMV9FTemMMTMkzqJllpW6xH9zWCobIbrFX4SxDEub+QAhEFpvKkypl4qA8GkMiWsDBY453Wb5sJ+lZWPNPNW+aNHRzQw4WehEL5MCz4KGBbWwUS7C8HiGKD50PS1gRRVBrMATUhkN54jkRoOdZfy8Rx6kDBClSHELw9h+xzyxP1OxLq6YySCXQ7o1ZzRJQsuFz3IkSB1oCG5jPt1Qveywi/Q2vIBvZWtcDiTXCZ4EcgJfZI91bbviqSM7OyO+rFO7mgcjmEBQ9INYF571Nf9dTIIY3au3fF3IkgsThCBjZxI9CE/nGKQBT+SnMCJ70EhLs/RWjMJdZVlWJWe8Nunm7Mbtf9Da+bDZwlUZpgB2+m2MYDfFDHwqqcJh6gD+fOYp6++4NUNr562ZF3dM4BSjyOJpoDvaoIpUi0ZP1QS/nJUC18zBEH7DGGiIigzfSLmzVxZCc08en8mrAtoYQ9jYBY4SyjjKQc0i9ysiJi1O91DUgeoTcqi8f3r9H2zLSnh2P7IIGvcGs3QIl1So6IQU8G8Y7ocSRcx4qoWteFV4zcsY=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(508600001)(38070700005)(122000001)(8936002)(86362001)(6486002)(31696002)(966005)(5660300002)(110136005)(71200400001)(4326008)(54906003)(66946007)(64756008)(66446008)(66476007)(76116006)(8676002)(26005)(186003)(66556008)(36756003)(2616005)(31686004)(83380400001)(2906002)(6512007)(6506007)(316002)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?bG1MT3dqdE5MT0ZMOUJSRzdiRVZDSkc2N3hqV3dJZU93SkpINEVPVG9pTTNi?=
 =?utf-8?B?SThRR2laYjg2YlZXQ2x3d0xvejVObTRBMGM3Q3JTUlcxUXBrM1NmUklnS3hF?=
 =?utf-8?B?eEsxZzNYdWdvWjViY0dlN3M4MXdEVVM4dk5pc29KWmJSbFgyTWlySnUxNmFn?=
 =?utf-8?B?dDYvRzh2R0lyLzNUckxhYk1JSE40Q0tMWVBWRGk5S0p1UDk2VE80VGQ0ckRD?=
 =?utf-8?B?NzVqS0p6MERoRVppeVZnaWlGWVdYQUI5S3kzOEFKQmR5Q2Rwd0puUW5pekth?=
 =?utf-8?B?UUVOR3hZNVVOUFpuS3htQlhyenAzcStURGF3VEI0M2pKRDhQR1FUMlNBODl0?=
 =?utf-8?B?RFp0SXMyd2lEbHVNVkdpOEh4RVVLeEJkU2FBOXlMTEpOL3o4TFcxVzNhbEhS?=
 =?utf-8?B?c1NlYTNRWlhydE9ObGo5eHBmV0R2VzkxVEtrSlFBMWh3aElGcnRDMFV5VXpw?=
 =?utf-8?B?MUpYQ2x6SHV5TXd2NTY3Q1AxN0dXcDZkbjN2SG91TGtTOXdCQ05RNUNKbUl5?=
 =?utf-8?B?dWNxVnJpakowRGt6S0ZoVS82MjRYOURXY2laT0IzdXZpdUNWUDNOdlRFalhY?=
 =?utf-8?B?SkdDZjd3SjRybTFxbW5sRFRtM0s3S1N0dXc0cEh0aFRJN2p0K2V6TmVtT0ZL?=
 =?utf-8?B?KzR5V0ZTVDZFVHU2N1Yxb1phU3ZyaEMvOUNDUURFbGdzaDduTGhmR2tlTUNu?=
 =?utf-8?B?OFBwazRrQjlGcURldmthVHVNTis2eHFGSWpsUFhqeE5FOVBLeVRVd2h2TkJy?=
 =?utf-8?B?eElMZXE3dlpRSkxxWU9wRjVNY3orcjZtUWRZam5MQ0UzdWp0QXRCbE5MTyt6?=
 =?utf-8?B?Ri8yTDFvWFF6eHU2aHRFOE56azQ2SGFrN2ZaOXJuS3UrNFh2eTFtK0pXd042?=
 =?utf-8?B?aEI4a3dWUTVUZ0p2TldxNWxpNnRZSE9lREpKY21NRnNIcnVFRUR5WmF2TWJC?=
 =?utf-8?B?dDJ6a1cvV0NGR1FORjlxZStFTExCMHhTMmtNVkF1NDdOZUtGTFl6d0RsR3lX?=
 =?utf-8?B?bFhvWW5uMFo4Y1QydE81eS91UFRKbXdNOGp0MXhxWEhibC9GOFcvaHdUNkJh?=
 =?utf-8?B?Qm0zR01Va1VxM0RzNzFkQlQ0NVhZa2hsbDhteTBjdEVuai9UME9HZFFLc3ZK?=
 =?utf-8?B?YVc5YTlPOFczT0RvNndyZXQrYXRadkhraUd5SHlhZ3lKdXpQWitXd3JCbTJl?=
 =?utf-8?B?NVcwQmhHTUY5SDhEOW1xdjJNS3llKzBLdGRza2RUWWpwT2xQMlhlMDZqclpx?=
 =?utf-8?B?UThJeWV1YzZXd3NTbVZvMjBXYnpWQlFpeU8zSGoxaFF3ZUFXbS91cE5nZkdH?=
 =?utf-8?B?NDlUb2lxZFkxYjhhbFFSOUduMDJDTFQvaVZ1UnFYdWpFTm1MNkZ0M2M3ZEdY?=
 =?utf-8?B?VEZyRUYyazRqOFZBV0hSVGlKRGRNaTJpY0txaFkyN3EyL0JPbFcrMDVlUlFs?=
 =?utf-8?B?NGpDZUwxZVg1dldpZnNqSU81ZjgxaDdvbW1wL0JOUFVGdzQybDV6SGVSNFhM?=
 =?utf-8?B?Q1NSNy9ORGkvNGhob0tjV2dtR0c1cHhQOHRuN1hrWkVXT20yR2xpb1dwMmZm?=
 =?utf-8?B?S3FIMmlRRm1qQm5IdDNsV2NpTWUxckRoc0lMUGR6YzVaWllaNzNOMXpEM2dP?=
 =?utf-8?B?cmRkWkhaNFN4MEV4WVhEU2psZTR6UzNnTlRTYXREQ1NZZWhDeHpaVDFMemg0?=
 =?utf-8?B?NGphQ0M1NmFVUFd1Tnk1cjBwbHRhS3NubW4zWDkyVmN1aFBxWDlJNUdQejJh?=
 =?utf-8?B?M3FuY0JnaThZQXRrdjJrdGI2R0ErVUZYYThNTWl1clNYYVNLVWpOWm1XM1pS?=
 =?utf-8?B?Qy9YbCtJMHZYaW9JSWVNUnZxUjUxWnR3TXF4M0lEajdxWDNLZEJscHFJaXh0?=
 =?utf-8?B?UnZJOC9TSWNVSmlrZFdweXVLbzc4a3hOR1ZHMEdtYmhNam01ZnhMK0w2anNQ?=
 =?utf-8?Q?pNlSY4/r6S+iKNiHuE5w3ZIhVlfaA70j?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <0B9212DB657D6D4CB4B902450E65CEB0@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: fe1bc6ba-00e2-4613-0db1-08da06e3dc6f
X-MS-Exchange-CrossTenant-originalarrivaltime: 16 Mar 2022 00:28:14.8517
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KEP8itVvxo9sJEwx1bVaNfKRI24XBlSJzAgcggzh7Geri89csNHvEwY7OMEbk66gCfI+o0/lXBEdPiEEKSWEvA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1503
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBJdCBpcyByZWNvbW1lbmRlZCBieSB0aGUgU3lub3BzaXMg
ZGF0YWJvb2sgdG8gaXNzdWUgYSBEQ1RMLkNTZnRSZXNldA0KPiB3aGVuIHJlY29ubmVjdGluZyBm
cm9tIGEgZGV2aWNlLWluaXRpYXRlZCBkaXNjb25uZWN0IHJvdXRpbmUuICBUaGlzDQo+IHJlc29s
dmVzIGlzc3VlcyB3aXRoIGVudW1lcmF0aW9uIGR1cmluZyBmYXN0IGNvbXBvc2l0aW9uIHN3aXRj
aGluZw0KPiBjYXNlcywgd2hpY2ggcmVzdWx0IGluIGFuIHVua25vd24gZGV2aWNlIG9uIHRoZSBo
b3N0Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogV2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWlj
aW5jLmNvbT4NCj4gLS0tDQo+ICBDaGFuZ2VzIGluIHYzOg0KPiAgICAtIFJlbW92ZWQgY2hhbmdl
IGZyb20gUkZDIHNlcmllcyBhbmQgcGxhY2VkIGludG8gaXRzIG93biBwYXRjaC4NCj4gDQo+ICBQ
cmV2aW91cyBwYXRjaGVzOg0KPiAgIGh0dHBzOi8vdXJsZGVmZW5zZS5jb20vdjMvX19odHRwczov
L2xvcmUua2VybmVsLm9yZy9saW51eC11c2IvMjAyMjAyMDMwODAwMTcuMjczMzktMS1xdWljX3dj
aGVuZ0BxdWljaW5jLmNvbS9fXzshIUE0RjJSOUdfcGchT2pOdmlMZ1lTVXZYcFVXcGVURGlJNk9W
dXdqVzJralFwQUNBWVlvNU1kSTA5R0NsblVITEdGanVvTXJ0cXVGOFFlOVgkIA0KPiANCj4gIGRy
aXZlcnMvdXNiL2R3YzMvY29yZS5jICAgfCAgNCArLS0tDQo+ICBkcml2ZXJzL3VzYi9kd2MzL2Nv
cmUuaCAgIHwgIDIgKysNCj4gIGRyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMgfCAxMSArKysrKysr
KysrKw0KPiAgMyBmaWxlcyBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspLCAzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jIGIvZHJpdmVycy91
c2IvZHdjMy9jb3JlLmMNCj4gaW5kZXggMThhZGRkZmJhM2RhLi4wMmQxMGUxY2I3NzQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvY29yZS5jDQo+ICsrKyBiL2RyaXZlcnMvdXNiL2R3
YzMvY29yZS5jDQo+IEBAIC0xMTUsOCArMTE1LDYgQEAgdm9pZCBkd2MzX3NldF9wcnRjYXAoc3Ry
dWN0IGR3YzMgKmR3YywgdTMyIG1vZGUpDQo+ICAJZHdjLT5jdXJyZW50X2RyX3JvbGUgPSBtb2Rl
Ow0KPiAgfQ0KPiAgDQo+IC1zdGF0aWMgaW50IGR3YzNfY29yZV9zb2Z0X3Jlc2V0KHN0cnVjdCBk
d2MzICpkd2MpOw0KPiAtDQo+ICBzdGF0aWMgdm9pZCBfX2R3YzNfc2V0X21vZGUoc3RydWN0IHdv
cmtfc3RydWN0ICp3b3JrKQ0KPiAgew0KPiAgCXN0cnVjdCBkd2MzICpkd2MgPSB3b3JrX3RvX2R3
Yyh3b3JrKTsNCj4gQEAgLTI2MSw3ICsyNTksNyBAQCB1MzIgZHdjM19jb3JlX2ZpZm9fc3BhY2Uo
c3RydWN0IGR3YzNfZXAgKmRlcCwgdTggdHlwZSkNCj4gICAqIGR3YzNfY29yZV9zb2Z0X3Jlc2V0
IC0gSXNzdWVzIGNvcmUgc29mdCByZXNldCBhbmQgUEhZIHJlc2V0DQo+ICAgKiBAZHdjOiBwb2lu
dGVyIHRvIG91ciBjb250ZXh0IHN0cnVjdHVyZQ0KPiAgICovDQo+IC1zdGF0aWMgaW50IGR3YzNf
Y29yZV9zb2Z0X3Jlc2V0KHN0cnVjdCBkd2MzICpkd2MpDQo+ICtpbnQgZHdjM19jb3JlX3NvZnRf
cmVzZXQoc3RydWN0IGR3YzMgKmR3YykNCj4gIHsNCj4gIAl1MzIJCXJlZzsNCj4gIAlpbnQJCXJl
dHJpZXMgPSAxMDAwOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmggYi9k
cml2ZXJzL3VzYi9kd2MzL2NvcmUuaA0KPiBpbmRleCBlYjljMWVmY2VkMDUuLjg2ZTI3YWZlZjZj
NSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMy9jb3JlLmgNCj4gKysrIGIvZHJpdmVy
cy91c2IvZHdjMy9jb3JlLmgNCj4gQEAgLTE1MzAsNiArMTUzMCw4IEBAIGJvb2wgZHdjM19oYXNf
aW1vZChzdHJ1Y3QgZHdjMyAqZHdjKTsNCj4gIGludCBkd2MzX2V2ZW50X2J1ZmZlcnNfc2V0dXAo
c3RydWN0IGR3YzMgKmR3Yyk7DQo+ICB2b2lkIGR3YzNfZXZlbnRfYnVmZmVyc19jbGVhbnVwKHN0
cnVjdCBkd2MzICpkd2MpOw0KPiAgDQo+ICtpbnQgZHdjM19jb3JlX3NvZnRfcmVzZXQoc3RydWN0
IGR3YzMgKmR3Yyk7DQo+ICsNCj4gICNpZiBJU19FTkFCTEVEKENPTkZJR19VU0JfRFdDM19IT1NU
KSB8fCBJU19FTkFCTEVEKENPTkZJR19VU0JfRFdDM19EVUFMX1JPTEUpDQo+ICBpbnQgZHdjM19o
b3N0X2luaXQoc3RydWN0IGR3YzMgKmR3Yyk7DQo+ICB2b2lkIGR3YzNfaG9zdF9leGl0KHN0cnVj
dCBkd2MzICpkd2MpOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBi
L2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggYTBjODgzZjE5YTQxLi40NDhmZjZj
YjljMjIgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIv
ZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMjU0NCw2ICsyNTQ0LDE3IEBAIHN0YXRp
YyBpbnQgZHdjM19nYWRnZXRfcHVsbHVwKHN0cnVjdCB1c2JfZ2FkZ2V0ICpnLCBpbnQgaXNfb24p
DQo+ICAJCQkJCQlkd2MtPmV2X2J1Zi0+bGVuZ3RoOw0KPiAgCQl9DQo+ICAJfSBlbHNlIHsNCj4g
KwkJLyoNCj4gKwkJICogSW4gdGhlIFN5bm9wc2lzIERlc2lnbldhcmUgQ29yZXMgVVNCMyBEYXRh
Ym9vayBSZXYuIDEuOTBhDQoNCkl0J3MgIlN5bm9wc3lzIi4gVmVyc2lvbiAxLjkwYSBpcyBmb3Ig
RFdDX3VzYjMxIGNvbnRyb2xsZXIuDQoNCj4gKwkJICogU2VjdGlvbiA0LjEuOSwgaXQgc3BlY2lm
aWVzIHRoYXQgZm9yIGEgcmVjb25uZWN0IGFmdGVyIGENCj4gKwkJICogZGV2aWNlLWluaXRpYXRl
ZCBkaXNjb25uZWN0IHJlcXVpcmVzIGEgY29yZSBzb2Z0IHJlc2V0DQo+ICsJCSAqIChEQ1RMLkNT
ZnRSc3QpIGJlZm9yZSBlbmFibGluZyB0aGUgcnVuL3N0b3AgYml0Lg0KDQpKdXN0IHdhbnQgdG8g
bm90ZSB0aGF0IHdlJ3JlIHNraXBwaW5nIHNvbWUgY29udHJvbGxlciBpbml0aWFsaXphdGlvbiBv
bg0Kc29mdC1yZXNldCBoZXJlLiBCdXQgaXQncyBwcm9iYWJseSBmaW5lIGJlY2F1c2UgdGhlIGds
b2JhbCByZWdpc3RlcnMNCmRvbid0IGdldCByZXNldCBvbiBzb2Z0IHJlc2V0LiBKdXN0IG5lZWQg
dG8gbWFrZSBzdXJlIHRoYXQgdGhlIHJlZ2lzdGVycw0KdGhhdCBkbyBnZXQgcmVzZXQgZ2V0IHJl
aW5pdGlhbGl6ZWQgb24gX19kd2MzX2dhZGdldF9zdGFydCgpLg0KDQo+ICsJCSAqLw0KPiArCQlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZkd2MtPmxvY2ssIGZsYWdzKTsNCj4gKwkJZHdjM19jb3Jl
X3NvZnRfcmVzZXQoZHdjKTsNCj4gKwkJc3Bpbl9sb2NrX2lycXNhdmUoJmR3Yy0+bG9jaywgZmxh
Z3MpOw0KPiArDQo+ICsJCWR3YzNfZXZlbnRfYnVmZmVyc19zZXR1cChkd2MpOw0KPiAgCQlfX2R3
YzNfZ2FkZ2V0X3N0YXJ0KGR3Yyk7DQo+ICAJfQ0KPiAgDQoNCkl0J3MgYSBsaXR0bGUgYXdrd2Fy
ZCBiZWNhdXNlIGR3YzMgYWxzbyBpc3N1ZXMgc29mdC1yZXNldCBkdXJpbmcgZHJpdmVyDQpwcm9i
ZS4gUHVsbHVwKCkgaXMgY2FsbGVkIGR1cmluZyBkcml2ZXIgYmluZGluZ3MuIFNvIHNvZnQtcmVz
ZXQgaXMNCmNhbGxlZCBtdWx0aXBsZSB0aW1lcy4gSSBkb24ndCBoYXZlIGEgYmV0dGVyIHNvbHV0
aW9uIGF0IHRoZSBtb21lbnQsIGJ1dA0KSSBkb24ndCBzZWUgYSBwcm9ibGVtIHdpdGggaXQgZWl0
aGVyLg0KDQpBZnRlciBmaXhpbmcgdGhlIHR5cG9zLA0KDQpSZXZpZXdlZC1ieTogVGhpbmggTmd1
eWVuIDxUaGluaC5OZ3V5ZW5Ac3lub3BzeXMuY29tPg0KDQpUaGFua3MsDQpUaGluaA0K
