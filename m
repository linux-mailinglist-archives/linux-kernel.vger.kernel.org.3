Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8C384D40D3
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 06:31:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239584AbiCJFcl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 00:32:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239600AbiCJFc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 00:32:29 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40C310529C;
        Wed,  9 Mar 2022 21:31:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1646890286; x=1678426286;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=d/Y6BaDPbH20EuZY8BT4jqENKauVPDiIRdhFn9oDB7g=;
  b=XQ9eLxlg6cD9ZMkZP2KVniC9k2r5DPdM3tkJCSAC2zk+Vgu4vPRxsTNP
   uF7/ZdDEgG7M9WTIwwHyAetxRuSBZS2QUG4YXWW2VYtE0uFE0owv3Trl3
   gZ/60jnWzSlHHyIrr0uO0SVm2xRI3YjugPUKLS6bZyCp5cq1QnuPlQ60r
   sfx3+6aEr9/RwuZ+YJx8fVYZZSUbXJYxGNM3bi2wakMwhnZgmz7Ux7AWe
   el3P5Dap1+/GPQ+6vzjVqR7lhtwf7MUTGQLINrjUEs1lIOX5cWdan/c9c
   r6LYF7xonM6i+EJ3TaoWIyqzNPBuW//H2Lw2ohrOnmmCWo4Hrr1BgG1cr
   w==;
X-IronPort-AV: E=Sophos;i="5.90,169,1643698800"; 
   d="scan'208";a="88463604"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Mar 2022 22:31:24 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 9 Mar 2022 22:31:24 -0700
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 9 Mar 2022 22:31:24 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jQPpwSoDb2N3MdD6W0XPsLX8od4bv+qwtLFbUqiacvphJ7/6NjqCke/a/yNeo9RYLHy3RVTakY7pRL2b3agNT1WccYaQKV/CCaRQw7D4spHr650EXJUVS8WIkm0O03mVub/CFtce03q8vp9mgFXh5QrOxfQULLYCnZWQPoM/qmRGKmfITDErA07Ddz1HSpheJcEoDMyAe5v0VeG+YxUVCMmiRdk6hbyVGCQIvsHV2G+lvHxi9CpTh/C6re20eyfXeCD8xFDavRqMUS+TNdFTHPG3J/KY3kTfvWZYF9KrsYvEgKg4JnZSIEUsGE5raMDtsUAB8uaGEMEOz+6+8ZaFOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=d/Y6BaDPbH20EuZY8BT4jqENKauVPDiIRdhFn9oDB7g=;
 b=lv4aW1GOf2mwfVmj4LMvCI5RMgbgn42mZhdhvkg7/K010pJfN9YGKqbZNZutly1v3Wsl1fMWxzsWazrQ7AU1iOXvy3b8bpNnvpd2lQiKdn8jRm2vigFK5hqw1vtArkDweSpPWrD41t94zxme9s4+YSqbFTU4R8DQyw8aWNbdTS7XeoCw26/dHnek1J0B/DgrCH1wCDb/2uBpFtT0osfDafGT8U2z0eauPdCpDzA6QcFa5EMQdCs5hxUXWq0f9F2jUCzul62O/T4A+j07jtVjsoo0z1Sq9k9ICXhKN2GRVIF42ZpiUjnGujabLf3lZKkckKX+ccMdj1kuijurfruSGQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=d/Y6BaDPbH20EuZY8BT4jqENKauVPDiIRdhFn9oDB7g=;
 b=STJuU6lA9Gv8cJodI6upKRThOziMY7KlQUASE3NDyjO/SvYlSo2+PgzmzAR9R9hb7Byx3Rq7zHMiMeFF5Cb14QuglctZcmlD2YlE1NXMPds4jX7FzfISuuJN0xod+/+sTbmds3GJFS5VxsjXtREVEvv6FC8sk79UCDucbOoDtQI=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by LV2PR11MB6048.namprd11.prod.outlook.com (2603:10b6:408:178::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.17; Thu, 10 Mar
 2022 05:31:20 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%6]) with mapi id 15.20.5038.027; Thu, 10 Mar 2022
 05:31:19 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <p.yadav@ti.com>
CC:     <michael@walle.cc>, <broonie@kernel.org>,
        <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <Nicolas.Ferre@microchip.com>,
        <zhengxunli@mxic.com.tw>, <jaimeliao@mxic.com.tw>
Subject: Re: [PATCH 1/4] spi: spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Topic: [PATCH 1/4] spi: spi-mem: Allow specifying the byte order in DTR
 mode
Thread-Index: AQHYNEARTqKlJy3ddkuP8VF4XCV4dA==
Date:   Thu, 10 Mar 2022 05:31:19 +0000
Message-ID: <f0501c29-ae70-185d-8f40-4a249e49575e@microchip.com>
References: <20220218145900.1440045-1-tudor.ambarus@microchip.com>
 <20220218145900.1440045-2-tudor.ambarus@microchip.com>
 <20220302100255.gseqjbdyxrgmt3zf@ti.com>
In-Reply-To: <20220302100255.gseqjbdyxrgmt3zf@ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 7ced78d1-a960-4fa0-9f33-08da025734b6
x-ms-traffictypediagnostic: LV2PR11MB6048:EE_
x-microsoft-antispam-prvs: <LV2PR11MB6048B636193345E775CDE903F00B9@LV2PR11MB6048.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MHLcIsAAIDzaVwYNb+3ky3gEe7cOdzrJsooED3OZpzdDLVb4oUMJigpy3GpxWHZ1n7L4t99ftpvKlB9aKn0dC6JgtYoZd2fwLpMFMAFB7VwTLRq21SW4COQb1QX060Bmi+OyZv261JuQhi2l5mXpBNGpjt4gXNhOi7bewnO9dfz3Wc31HUBd9sjUJWV2VyPRambmpETBHtCN902H9FkbMvohjSAW3ZUBcDArSzAhs1qAYYtxcevio01GNwj7K3BbKuTkeCXSqOIGjFAMPjEHazJKwFNSw6Ux87cPLz74zRyOxINitpE+pLgR6KBQU+XhDpiqariFpA52wUmRQ2LTRvIcvh8S4wxczeQpVE5219+J8CM+5CiIgzUXM0mwclIcK716YFKYDCHm1vilB/Sb9/kRxm5rdZCuW37GMZfmnI226TljWF1jLBRKIVO+OfIOxW7tVXe5eUGVG2KMNuAEj7m6iLRV/5mY2mFTVB3UZ/szU5ZadXgqvFU9g8i3WppFakyQG1V2UK7DCpQLrbLDl0a/Y8xgdXgDi5NfTfan9wlbaaASeigEymt37kSEgq/mnL6KAitsVnMVaIof5VeTvUBBDaTdTWrt2twEt9EI8r747C89XysKl2loD2QZ8ANLEA1jd2kms1MDERWNlPwfPC1Py8JiU2TYxHA89v8MAlsX3GuN22UXGXyGL6SnvANwXxGPvarad0hCHswxBqIpzHpiJt1m2LNBK2AeJyoBLL3YvGZ4quMN3xOqbxTXHCoGVb3oZcaIh3ZhOjDa2cHyXw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38100700002)(54906003)(53546011)(316002)(5660300002)(86362001)(6916009)(8936002)(7416002)(122000001)(31686004)(38070700005)(6512007)(6506007)(4326008)(91956017)(8676002)(2906002)(36756003)(66556008)(66476007)(83380400001)(26005)(66446008)(2616005)(186003)(71200400001)(66946007)(64756008)(6486002)(508600001)(76116006)(31696002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?ZjBTTWMwWCtHdHJtR2RDUEpTLzRuTisrNkxYek13QmR2M1BFc3NVRXlkYjZO?=
 =?utf-8?B?OTg0T0lPM01ub083NTNyb0JmcEJiSm9QQWhhd1V6OGlXc2dWZWFlQ3BkMjJR?=
 =?utf-8?B?SHlnTU85Z3QrdDUrbkhSVEhKaTNudWxTU2g5Qm5YZHgwQ01uYktmZ2NJSk90?=
 =?utf-8?B?VTJnRWVZaEtUWUlnNE0wT0tkaWZGOGxBbXdMNWw5UWtuR0lyck5JTmI3dGdJ?=
 =?utf-8?B?alZvRmYxUS9kSzRNZThjcEdNMWxOS2ZzYnIxeFZIbmtEOThpZUdVbUV2KzVz?=
 =?utf-8?B?L1FkdjBtYXAyTWNTS0JzRlgxRzJvMTRvNS9HYXQ5YlIxSE0vRmpIYkJLeitU?=
 =?utf-8?B?WThaMWRtL3hvdjNyY0ttMUZPMlJEQVgwVEVBZjlsL25QVmRyVytMNGRaT0d0?=
 =?utf-8?B?ekQvRnFCZ3gzUHpPY2F2YzZFVnluWHJZYTJHdGR3cFdSWndwdnRqUVNwQkpl?=
 =?utf-8?B?dHE0aExrUHhqNGtuYmwxRTIwRWlzOXdUUitxOFc2eXdEVnl1WUIrZkdFdEVD?=
 =?utf-8?B?VDNXSW92VWNwNllESXBDR3lmbXBLenoyT3FhNzdOZ01LNWdFcGY5Q3hFcWp2?=
 =?utf-8?B?M3YvN3BrempwUzRUS3FEeE1FODd6RzNueG1tRWRUcHEyekJPWUZKd3JCZG9h?=
 =?utf-8?B?WW9jNis0dHRnNk5HQnI5QXFXSGtxek1UeHFmR1IwL0lCclh0VURCN2tXemxZ?=
 =?utf-8?B?UzFFSWk1OW1KK0o1YVUwSVIzR3A5WGw1ZE1PZDkwZCtqZGFMUzhVQ2d3bmpC?=
 =?utf-8?B?MkY1Tysydm40OUdWdHpPaHRTYkE0bXpma1FIQUtDWXJzbE12OE9YaFBCVG03?=
 =?utf-8?B?d3ppZkdJSFhlbjJaR3FoQ0xjZ3FURVN3SmZaaE1kUlZzcmV5SVVCaEppVWFh?=
 =?utf-8?B?alh2TGh5TWNpb09PVjRPUXo1ZUw5TytSK0NyaG5EYUtGOWhhVGdDYjRsWDBj?=
 =?utf-8?B?QytLZFJXc3RqZHd2clZFV3N4VE5xcllZc3VTNWtlK1lxSHc5YVNna0dkT1lH?=
 =?utf-8?B?SmUyeUltNG5TZnRuU3NhZmFFN2FQQzhqSzBVYmEzZnhqaHBhV3ZoaFR5a1Vv?=
 =?utf-8?B?YTFHYWN3TEhJSU10d0gxZldwcEZLZzBkQWNHRnNsSzVVaGZxcmE5cmFoUVZ5?=
 =?utf-8?B?RVhPVURvb05jWFZxdEpNME5tQi9IYnJXa0FSYTdjVWdwZTJHZWVoVkwzRlRx?=
 =?utf-8?B?VXNWU3VndVQwTlF5ckpUd3F5TkpxVklZU3R5UFBLbXVyY0I3di82TExYNDE1?=
 =?utf-8?B?RkVTeWNVODVDNHlFTEFPZE9JbVFiVzBYbC9zWU5nREZQVEprcmI2L2ZDem5N?=
 =?utf-8?B?Z2U1V1d3Q1B5OFdpRnpoYUVOSDg4TUxmRlN6b1VvNTh6OVVhaXVPV21mRTg2?=
 =?utf-8?B?U0ZUeVlBNGM0RFZvQmFYSkk2MGFhaStmM3NCMmltZVFqSXNHQlBOVDlzWjVk?=
 =?utf-8?B?UGFnSlRyR2RoajZaQXo2Mm4xWWYwVWF4b055TllhSGdsbnBscHNwK2dycVZC?=
 =?utf-8?B?YXNHbVh0Z3hvWk9KOHZ2Z2RnbURwNHdpbWRvbFM5eTJVbVRYM1d1RkllTjQy?=
 =?utf-8?B?Um1CbERLRVB5c1VLNlJoMGY0cXBDd21KbE5oSEpidEVsRFA0VzBzdGdLamUv?=
 =?utf-8?B?VDN3YWlMZk1rMlZZcEhjOXV6TU42QXRjVlJqMVZBTzVjc1FPRmxDN210ZmRn?=
 =?utf-8?B?Q28vcXVxS28rMHMzSWVlcnZKTk5xUWF6RFl6Zk9BeUtYUnNsb1JMRGRwcHRn?=
 =?utf-8?B?d2Y1emxqeGZaWEx4aGxaeHZBeEc4ODgwY0NHSlBJVGhBUFNTVnJRNG1JSUo2?=
 =?utf-8?B?OGpEdjQ1Z0FoNGZ0SG9mRjJDeWZIdXBUWW9qU21mT2pzMUQwU080bDk5RGhZ?=
 =?utf-8?B?eVlueGsxRGdQUno1NEpoM0UxdG9TakZpYmd6WVVHT3dLVG9kUG1xN0NoQ0t0?=
 =?utf-8?B?ZExsck9vNGpYY2J4U29YY1llSThSSVNWdG9zNW91RkpsN2lHTWNQWk1Xbmpy?=
 =?utf-8?B?VWlvVWdpNGZoTjFTdFhPbVg3Q1UrNHIzcU5ubnZITnAwTzRpLytBdkNyeGRT?=
 =?utf-8?B?OVpTRHh6bzRDclpFN1ZpVExqTHNmVG40dVRMRUNLQnFnOXdlbk10VmpKajd5?=
 =?utf-8?B?MCtvL3B3d1dJL1dRWExpSDFPeXRQRW9ScTQ0dHYwRGRzcXVKVUV1VFpGYlFv?=
 =?utf-8?B?a05OVWczRVNXMW1SMzYxTEVON1B6Tk1HaUdFMTZxOU05b3cxRE45TFM1K08z?=
 =?utf-8?B?U05vQzJjb0c1U2VMNm55aDNyN09nPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <16B0A8C120090B4895199AFA0F874CF6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 7ced78d1-a960-4fa0-9f33-08da025734b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Mar 2022 05:31:19.5190
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: A4pjnrFb2QuCuFg4iWpFy2n4ksiTiCPWNFXokZwxR+MXpedZt8vx7klRk0Hvz9sqCecZ0Hhsw/6N09VI5TaXBs8mZ7MP59tnJergFb281FM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: LV2PR11MB6048
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,
        T_SPF_PERMERROR autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMy8yLzIyIDEyOjAyLCBQcmF0eXVzaCBZYWRhdiB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBIaSBUdWRvciwNCg0KSGksIFByYXR5dXNoLA0KDQo+
IA0KPiBJJ20gcmV2aWV3aW5nIHRoZSBjb2RlIGhlcmUuIEkgc3RpbGwgaGF2ZSBub3QgdGhvdWdo
dCB0aHJvdWdoIHRoZQ0KPiBkaXNjdXNzaW9uIGFib3V0IEtjb25maWcgb3B0aW9uIHlldC4NCj4g
DQo+IE9uIDE4LzAyLzIyIDA0OjU4UE0sIFR1ZG9yIEFtYmFydXMgd3JvdGU6DQo+PiBUaGVyZSBh
cmUgTk9SIGZsYXNoZXMgKE1hY3Jvbml4KSB0aGF0IHN3YXAgdGhlIGJ5dGVzIG9uIGEgMTYtYml0
IGJvdW5kYXJ5DQo+PiB3aGVuIGNvbmZpZ3VyZWQgaW4gRFRSIG1vZGUuIFRoZSBieXRlIG9yZGVy
IG9mIDE2LWJpdCB3b3JkcyBpcyBzd2FwcGVkDQo+IA0KPiBzL0RUUiBtb2RlLyBPY3RhbCBEVFIg
bW9kZS8NCj4gDQo+IEkgZG9uJ3QgdGhpbmsgdGhpcyB3b3VsZCBhcHBseSB0byBhIDRELTRELTRE
IGZsYXNoIHNpbmNlIGl0IHdvdWxkIG9ubHkNCj4gdHJhbnNtaXQgb25lIGJ5dGUgcGVyIGNsb2Nr
IGN5Y2xlLg0KDQpGcm9tIHdoYXQgSSBzZWUsIGZsYXNoZXMgdGhhdCBjbGFpbSAiUVBJIERUUiBz
dXBwb3J0IiB0aGV5IGFjdHVhbGx5IHN1cHBvcnQNCjRTLTRELTRELiBKRVNEMjUxLTEgdGFsa3Mg
YWJvdXQgNFMtNEQtNEQgdG9vLiBTbyBkYXRhIGlzIGxhdGNoZWQgb24gYm90aCByaXNpbmcNCmFu
ZCBmYWxsaW5nIGVkZ2VzIG9mIHRoZSBjbG9jay4gQnV0IEknbSBvayB3aXRoIHlvdXIgcHJvcG9z
YWwgYmVjYXVzZSB3ZSBkb24ndA0KaGF2ZSBhbnkgcHJvb2YgaWYgdGhlcmUgYXJlIGFueSBRUEkg
RFRSIGZsYXNoZXMgdGhhdCBzd2FwIGJ5dGVzIGluIERUUi4NCg0KPiANCj4+IHdoZW4gcmVhZCBv
ciB3cml0dGVuIGluIERvdWJsZSBUcmFuc2ZlciBSYXRlIChEVFIpIG1vZGUgY29tcGFyZWQgdG8N
Cj4+IFNpbmdsZSBUcmFuc2ZlciBSYXRlIChTVFIpIG1vZGUuIElmIG9uZSB3cml0ZXMgRDAgRDEg
RDIgRDMgYnl0ZXMgdXNpbmcNCj4+IDEtMS0xIG1vZGUsIGFuZCB1c2VzIDhELThELThEIFNQSSBt
b2RlIGZvciByZWFkaW5nLCBpdCB3aWxsIHJlYWQgYmFjaw0KPj4gRDEgRDAgRDMgRDIuIFN3YXBw
aW5nIHRoZSBieXRlcyBpcyBhIGJhZCBkZXNpZ24gZGVjaXNpb24gYmVjYXVzZSB0aGlzIG1heQ0K
Pj4gaW50cm9kdWNlIHNvbWUgZW5kaWFubmVzcyBwcm9ibGVtcy4gSXQgY2FuIGFmZmVjdCB0aGUg
Ym9vdCBzZXF1ZW5jZSBpZiB0aGUNCj4+IGVudGlyZSBib290IHNlcXVlbmNlIGlzIG5vdCBoYW5k
bGVkIGluIGVpdGhlciA4RC04RC04RCBtb2RlIG9yIDEtMS0xIG1vZGUuDQo+PiBGb3J0dW5hdGVs
eSB0aGVyZSBhcmUgY29udHJvbGxlcnMgdGhhdCBjYW4gc3dhcCBiYWNrIHRoZSBieXRlcyBhdCBy
dW50aW1lLA0KPj4gZml4aW5nIHRoZSBlbmRpYW5uZXNzZXMuIFByb3ZpZGUgYSB3YXkgZm9yIHRo
ZSB1cHBlciBsYXllcnMgdG8gc3BlY2lmeSB0aGUNCj4+IGJ5dGUgb3JkZXIgaW4gRFRSIG1vZGUu
DQo+Pg0KPj4gU2lnbmVkLW9mZi1ieTogVHVkb3IgQW1iYXJ1cyA8dHVkb3IuYW1iYXJ1c0BtaWNy
b2NoaXAuY29tPg0KPj4gLS0tDQo+PiAgaW5jbHVkZS9saW51eC9zcGkvc3BpLW1lbS5oIHwgMyAr
KysNCj4+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspDQo+Pg0KPj4gZGlmZiAtLWdp
dCBhL2luY2x1ZGUvbGludXgvc3BpL3NwaS1tZW0uaCBiL2luY2x1ZGUvbGludXgvc3BpL3NwaS1t
ZW0uaA0KPj4gaW5kZXggODVlMmZmN2I4NDBkLi5lMTg3ODQxNzQyMGMgMTAwNjQ0DQo+PiAtLS0g
YS9pbmNsdWRlL2xpbnV4L3NwaS9zcGktbWVtLmgNCj4+ICsrKyBiL2luY2x1ZGUvbGludXgvc3Bp
L3NwaS1tZW0uaA0KPj4gQEAgLTg5LDYgKzg5LDggQEAgZW51bSBzcGlfbWVtX2RhdGFfZGlyIHsN
Cj4+ICAgKiBAZHVtbXkuZHRyOiB3aGV0aGVyIHRoZSBkdW1teSBieXRlcyBzaG91bGQgYmUgc2Vu
dCBpbiBEVFIgbW9kZSBvciBub3QNCj4+ICAgKiBAZGF0YS5idXN3aWR0aDogbnVtYmVyIG9mIElP
IGxhbmVzIHVzZWQgdG8gc2VuZC9yZWNlaXZlIHRoZSBkYXRhDQo+PiAgICogQGRhdGEuZHRyOiB3
aGV0aGVyIHRoZSBkYXRhIHNob3VsZCBiZSBzZW50IGluIERUUiBtb2RlIG9yIG5vdA0KPj4gKyAq
IEBkYXRhLmR0cl9ic3dhcDE2OiB3aGV0aGVyIHRoZSBieXRlIG9yZGVyIG9mIDE2LWJpdCB3b3Jk
cyBpcyBzd2FwcGVkIHdoZW4NCj4+ICsgKiAgICAgICAgICAgICAgICAgcmVhZCBvciB3cml0dGVu
IGluIERUUiBtb2RlIGNvbXBhcmVkIHRvIFNUUiBtb2RlLg0KPj4gICAqIEBkYXRhLmRpcjogZGly
ZWN0aW9uIG9mIHRoZSB0cmFuc2Zlcg0KPj4gICAqIEBkYXRhLm5ieXRlczogbnVtYmVyIG9mIGRh
dGEgYnl0ZXMgdG8gc2VuZC9yZWNlaXZlLiBDYW4gYmUgemVybyBpZiB0aGUNCj4+ICAgKiAgICAg
ICAgICAgIG9wZXJhdGlvbiBkb2VzIG5vdCBpbnZvbHZlIHRyYW5zZmVycmluZyBkYXRhDQo+PiBA
QCAtMTE5LDYgKzEyMSw3IEBAIHN0cnVjdCBzcGlfbWVtX29wIHsNCj4+ICAgICAgIHN0cnVjdCB7
DQo+PiAgICAgICAgICAgICAgIHU4IGJ1c3dpZHRoOw0KPj4gICAgICAgICAgICAgICB1OCBkdHIg
OiAxOw0KPj4gKyAgICAgICAgICAgICB1OCBkdHJfYnN3YXAxNiA6IDE7DQoNCmJ1dCBJIHdvdWxk
IGtlZXAgdGhpcyBuYW1lIGhlcmUgYXMgaXQgaXMsIHdpdGhvdXQgcHJlcGVuZGluZyBvY3RhbC4N
Cg0KPiANCj4gWW91IGFsc28gbmVlZCB0byBhZGQgdGhpcyBjYXBhYmlsaXR5IHRvIHNwaV9jb250
cm9sbGVyX21lbV9jYXBzIGFuZA0KPiB1cGRhdGUgc3BpX21lbV9kZWZhdWx0X3N1cHBvcnRzX29w
KCkgdG8gY2hlY2sgZm9yIGl0Lg0KDQpzdXJlLCB3aWxsIGRvLg0KDQpUaGFua3MhDQp0YQ0KPiAN
Cj4+ICAgICAgICAgICAgICAgZW51bSBzcGlfbWVtX2RhdGFfZGlyIGRpcjsNCj4+ICAgICAgICAg
ICAgICAgdW5zaWduZWQgaW50IG5ieXRlczsNCj4+ICAgICAgICAgICAgICAgdW5pb24gew0KPj4g
LS0NCj4+IDIuMjUuMQ0KPj4NCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFByYXR5dXNoIFlhZGF2
DQo+IFRleGFzIEluc3RydW1lbnRzIEluYy4NCg0K
