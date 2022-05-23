Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8588531B05
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 22:56:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231972AbiEWUAN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 May 2022 16:00:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbiEWUAL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 May 2022 16:00:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5101D7A451
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 13:00:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1653336007; x=1684872007;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=0pbeHqhfihXDN8h/CfmqN/lUc6gPtDQ1oMdA/5hXXuI=;
  b=vfvgrot1PF19JmEnasFmC3RaDutPSuiYAD6AQH2NQybtGQ+KLAVcQC2z
   3GFZTB/uprB6RW2nhmRC0We94l40Dr95vCrAf9v0HeZBrMeG6oGIptQ1f
   Ddg2/WFp7mPDEuzc+OYNdLNThktws7q/4d/GJrTbW3VZw5wc4V+3mWNcB
   7XhlaG377R8ElXPxA16ego/hjUwxshdNgWZEnsQTMaDqeitR2T9bHuSPJ
   v40Yog53krWyJoSQT0TTve3B/jdHJmCMTxh4IyFFDAMwhd0ROZ4SUZ+P9
   NNN2DAbFJzEzCCmGvTDZlfTvF89DPf3twoqZAQrz4aGn+GibQHaH99NEN
   A==;
X-IronPort-AV: E=Sophos;i="5.91,246,1647327600"; 
   d="scan'208";a="96992770"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 23 May 2022 13:00:06 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Mon, 23 May 2022 13:00:06 -0700
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Mon, 23 May 2022 13:00:05 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=W9EAYAKD1rZNBTP7FQfejQ4jwVjq2LdKzL9j4ktbDW1NYD7Yw8277T/RqDz0PelhMuYmSBb+H1M4Advph2FOOKxkia8LzCZwstynYDOwi0DY/NGiIDXLqpJ0xpuq7KdACeaTpyRH7O76kI+xkGgcammJFvsCEHG+KU4A7g89Q2cYWUVKHaGYeai0x6KneCOIOirPrOhrYQkrA9VmHo+lTxa8OYQZJoeQSmadfriX1q04dxFGxfTXHhcBTRp9IGmPFzKwd/YwVFHNMP2t8ujl4bW4RgUjH3MMzoy3JOLjHQTCHvBGdxvzGzTsW87D1zJmf+wnzgIX3Xsn9iKmBgj5UA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0pbeHqhfihXDN8h/CfmqN/lUc6gPtDQ1oMdA/5hXXuI=;
 b=Bwds+onc59Sicmeiohhn5OYhXHF5QFW8L7fNiSs3S6UhnuZ+hR+Wt6c4RkV7E1go6niUmAfMDBOPPZJsVrd3oUvA3/qltXd907Cll3SW1MtwaUhJNGGsyWSQpSuWmCOlmHrBeWFKptxa34ARGgdo0+MsR2ZE0X8i+mQEOC7KQz03lzIGCQ/hrMIWO+nAEr1iQJY2rhQ8XYw2sVMQS9vMdU8nSHCs1X3iSaIfMGh+9TJWCsXvREVOlzF9v0wZtv2evA+mquF+P+OsABqlETFpCbEWAD0OZAzaJUfQL7dc6dglyBJJ2eLD8+1E9iHzUk0r9Y3d6eWu/y4/fus1RS30Ow==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0pbeHqhfihXDN8h/CfmqN/lUc6gPtDQ1oMdA/5hXXuI=;
 b=PvgdkCFwmiOAUZ/nmdJAzFwVzu0kF5/9gTEkGPoAHF1ANtvFgo5iaxmGQ5hq3DzTJUZY38K0bt483oHaA/AlzjuI5OP6KwlxkmrTUffRJ4ws4XpqA3JJlwjtMhp2iDFcFWTdyb2fCwm4SAyNJFQhhYNCprBuWBBzMw/sljTYCdY=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB3423.namprd11.prod.outlook.com (2603:10b6:805:db::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.17; Mon, 23 May
 2022 20:00:01 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%5]) with mapi id 15.20.5273.023; Mon, 23 May 2022
 20:00:01 +0000
From:   <Conor.Dooley@microchip.com>
To:     <palmer@rivosinc.com>, <arnd@arndb.de>
CC:     <paul.walmsley@sifive.com>, <aou@eecs.berkeley.edu>,
        <linux-kernel@vger.kernel.org>, <linux-riscv@lists.infradead.org>,
        <Daire.McNamara@microchip.com>, <Lewis.Hanly@microchip.com>,
        <Cyril.Jean@microchip.com>
Subject: Re: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Topic: [PATCH v4 1/1] MAINTAINERS: add polarfire rng, pci and clock
 drivers
Thread-Index: AQHYYG7KcHM3Zb8ggE+yYwRhcaPSb60sczEAgACJPICAAAITAA==
Date:   Mon, 23 May 2022 20:00:01 +0000
Message-ID: <d50f506c-92fd-39c2-d5d9-5eb9c60b1de6@microchip.com>
References: <mhng-9bccd0ce-6754-49d4-bf6d-5a83b2226b5d@palmer-mbp2014>
In-Reply-To: <mhng-9bccd0ce-6754-49d4-bf6d-5a83b2226b5d@palmer-mbp2014>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8fd55874-22ff-4409-14e0-08da3cf6d240
x-ms-traffictypediagnostic: SN6PR11MB3423:EE_
x-microsoft-antispam-prvs: <SN6PR11MB3423B95144491FEFA713E94198D49@SN6PR11MB3423.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: gGlNv+GiLFsSjDXh2r1UD7CaqrGIFCh3hnC8CMCqgsn1CpkhfC0yN9U+/8h+BfnqgRIw7tOmBDLqwchWN1iEPd/7/8Gg0Kg4OV71sySo3fx8mxuOcJvdlIbWU+K7DUEcqB7sjJ7ctkEh0zrFLEwugn2zbzFVanSi9Le7UGJLUwGD0fXc2fEMI8/VMziLyDwx1/x7ej+aj+9ZFjUfgBCPdeFZouF4l4BqPfoXcakl7Fq8r10HKZI1/KxPTzS1yFu3sMXrs7AXzPnnd3U2d/FtpkIOC7DgnTtxzAgV38geOM+KPqs6cWE18AO02AHLhovUTZa8ZTs0D70Wq16gnKANCUHVKcriIpxCxZDqGVX00xdT08RyCUEDq+XaVjJRajVBMhNq9yhU+/ZktyGBpZDt6d20oPi3pKmy7abBBMCfgJcz7Kno1ZBjnVo5UJlBI78IxpIiEqvt6bAig82M/Ab8AR5tFpo7ZOYB26enogegc9PG+1X2Da3K62mrRL8Mm7Lrvjc3UZAhOfEA/to2Gg6VLqKCRPmIZcs+l2jd246BDn24TdMQWSR41qWs1PZjlx87DaB8Ps/ahZrcotPoDl3dBhQGzNHU5OfORLeFTR3CskS80dPvaGakGF3bN8Si4t/U7hNAj0lkGCEGvPZpF6BwcGhHgY58vZdEGDSWzNp3baCnslWdEaHb/thFgoeWpQ5isywGVAFtYp5Fw1Kw2qqH7ZdAh3VEZS1lRy21dSyrqR9q/nmhpxGcmAyRw+JQJoHa5/bL3086M6XI1qS+8berZQ==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6512007)(508600001)(26005)(6506007)(53546011)(83380400001)(6486002)(107886003)(2616005)(186003)(31696002)(316002)(76116006)(71200400001)(86362001)(36756003)(31686004)(38070700005)(38100700002)(8676002)(91956017)(2906002)(122000001)(54906003)(66946007)(5660300002)(8936002)(4326008)(66556008)(64756008)(66476007)(66446008)(110136005)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?UzRsN3NDdkh2UUhydWNWQkMxTnh4QkJnTERDQ2c5c3NJU0FBL3BSOWV4amZU?=
 =?utf-8?B?N1JiVXVRY1ZDQ2NzY1ZHNzNNVTI4S0NTRTdaNjMzMlpSUThMYWxJRVRaTHIx?=
 =?utf-8?B?T3ExeVVwQUYybGNqSytpMVhFRFJ4UHNPU2ZyT2twckJhQTRuYVVoSmtHOXVv?=
 =?utf-8?B?aWRZWlJmMjM2VzFGdmFHMmFDTU9lWVQ1YjZheFAzRFpnSVVPelVHR1BYMzYr?=
 =?utf-8?B?a2hTYlRIMVpheTlBU0FWYXA5ZXlyNy9MenZabG5STzVpcUdqWE5yZ1dTTU1S?=
 =?utf-8?B?MHBUYzRNeGdMcXRaYko2YTNON3RLVE50VWliR2pEaHVUSWJhT3ZpNlJyUmNp?=
 =?utf-8?B?eDJtbU1hT2gxOUJ1NGNYL2NjS0dIVmx3ek05Qmh6V25BaFljK2I3em8yUmQz?=
 =?utf-8?B?d3A4VVd2dDBFZEZ6cjd1K0lSMm5jTWovaVAyc0cxT3lDQWRuMThueWYrcEpu?=
 =?utf-8?B?TlU4RUFIYjRQb1VwWUxVZ1dMejBtOWlJbVVUSzNWRVduRCt0MTlSbHJvVTVl?=
 =?utf-8?B?VFVSZC9DZzVvdEtNbGZFdk5FWFVKcFhPTlB0R1o1Nk55ZmI4aWkvcHN6R1ZI?=
 =?utf-8?B?NHh0VUhTeDVPd1MvY05aRlJNazh1QmpPN3Q2NnhCQzBJUUwxbktobHJjRDJo?=
 =?utf-8?B?U25xYnJqbUFDYXB1TnZHSU8yQXd5aDRHQkovSUdVWmYreG1QS0h6cElDdU1T?=
 =?utf-8?B?U1puVXk3QTQ0Q2daV2xkcVg5Z09vQVRWOWFISkNWZWwrU1JLU0grK0tybDZE?=
 =?utf-8?B?RjJ6c0YyT2ZMaTF5V2FDZ2hIRGtlMytySEorREt2MFZHMGRwN0gxRGFOaTdH?=
 =?utf-8?B?UlF4Syt4d1pMVHVDdlFBZlJlTVNCQ2ZGbVRyclJaZENFOS81cHVCSk9uWnhD?=
 =?utf-8?B?S1h6OEJzVm5XQkhVczljUmM3SE5NcEl6MHlkT0dJU1JrZUIwa1UyOXA5aWov?=
 =?utf-8?B?ZVM0VVJjTTZDQWlQazZPMENnS01pSG5nenVNaXNIL0ZBdm9GaEg1N2RSNjFE?=
 =?utf-8?B?b0J5SHAzQVNPRVIzNnFsZ3ZKN1AvcXFwemx1OWR4V2xxZHhEbTFRdjI0bGNx?=
 =?utf-8?B?Q0xwM1F1UEpoSnRxK1JpVG5zcVpvYVgxRjlaeksxb1B4ejdxUmRRWG4wb09K?=
 =?utf-8?B?VzhtOXcwZ1R2SXRsZGlXdFpBYUlVcU1NWUdEdE0yMFNWeDYyNjFKOWZCUDZp?=
 =?utf-8?B?YVA0WjRQVDAycndNMXNnU2thMVROWk9icEhnb0MxZnIxMGp4ZmtNVzJPYU1D?=
 =?utf-8?B?OVhjbFl1eUxyVExqdnh5ZnVNSHV3R1dJcUxhekU3OGltN2xkeERYQWtKRGpT?=
 =?utf-8?B?NFcxamhsZlNiK3k5algwVDRvd2MzZTNoZFN4RWxydFl4Z01rZ2kxVzNMUWsy?=
 =?utf-8?B?enoyK000d2ZQOGRjUzNzczJGaXd1WEhMSzJmUmh4Q2dIdnpZanRmTzZ0cTZ2?=
 =?utf-8?B?cm9SYlg4aXNibUxRZm95dXRkWXFLREphVmJnd0V1TWJRVnBoN0JSbEprMTM3?=
 =?utf-8?B?M240a2Y1RjRpVm0weVA4bTJkaWNGc1hBc1Z1TzRxUTFlSE53YXNyUzFLNUY5?=
 =?utf-8?B?NU5CUCtuQVBvV3QycS9oaS9pdmJSck5XOVQ3bjI5alNNNlpHSjFsMTJvbWt2?=
 =?utf-8?B?LzJOVmFEeWsxRmdPV3BrbXRwN05jUlBKeGR6dG93dldpaFJCaE4wcFp0QjVJ?=
 =?utf-8?B?QnNDejFCY3I0aVhmTVVXaHZMcmZIdURKNHB1M1pvWk5lZHVJL3laZEFnRm5Z?=
 =?utf-8?B?ZTVXZ3Z2SXQ4VjFBT3pzd1owQXRWcllJdDNhei9GUGl4WG4zMnNEVCtDZ3Zv?=
 =?utf-8?B?eTRWT05vWSs4SDNBb2NQZ053SUlyTTk4bzZyajhpMmF5NlF0M0NmT0NTN0dy?=
 =?utf-8?B?bkNYWm02WEh5YU9RNXNFQ2JXRVJJV1duTzZzNTdPQnVZTjVkN2xUcDJnVGFB?=
 =?utf-8?B?a0J5SzZIUXViaVB6M3ZOSnREbmlPRTV2N2tzdEJjS0lLb0tIdkt4ZEFoUC8v?=
 =?utf-8?B?THJmT1BWbmYxcll5ZmpQSlEwN0svWFVneDNDRmt2MGVZRG5YeGtHYm5wRDRF?=
 =?utf-8?B?a3JnV3FSWkFRakt2RDhvbU9ObytqdVhrektWODl1NDBiYkxkeStyWTh5N2xl?=
 =?utf-8?B?S0ZtMkR5a2c4SnhRMTVQbG9EbXVheWoxZ2hxd3hhS3lRZis5UUszSnBQbkxq?=
 =?utf-8?B?bFA1cTZ0enNKaGlRS0p1Vlh1K1MwYjFpUW1hc1A0UmwrSnR1YlFKcWtSVkd6?=
 =?utf-8?B?VlMwakpXdnpxVFprWGFCd2NTSCs4NjJYTENVTjlvU0k5MHFWZ1RmN051cnZN?=
 =?utf-8?B?b2tVYTlkcFNuVmxSbFhGRFkxUjc2anlsRldzbExHTWVOU01uZ3pWQT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2CD340CEC3FE4642A6E987570F6F2C2C@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8fd55874-22ff-4409-14e0-08da3cf6d240
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 May 2022 20:00:01.2914
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: BQRC7hCmKurbHN90E00WHMmfjMQeZWB0k36p88U2pzdpFFTQqNUwwjBjL0hF5XgUHijvKZpXzUgSgsqDZTUimiuvXHsDNDC911yIOKOEyYI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3423
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjMvMDUvMjAyMiAyMDo1MiwgUGFsbWVyIERhYmJlbHQgd3JvdGU6DQo+IEVYVEVSTkFMIEVN
QUlMOiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtu
b3cgdGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gT24gTW9uLCAyMyBNYXkgMjAyMiAwNDo0Mjo1
MyBQRFQgKC0wNzAwKSwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+PiBPbiAw
NS8wNS8yMDIyIDExOjU1LCBDb25vciBEb29sZXkgd3JvdGU6DQo+Pj4gSGFyZHdhcmUgcmFuZG9t
LCBQQ0kgYW5kIGNsb2NrIGRyaXZlcnMgZm9yIHRoZSBQb2xhckZpcmUgU29DIGhhdmUgYmVlbg0K
Pj4+IHVwc3RyZWFtZWQgYnV0IGFyZSBub3QgY292ZXJlZCBieSB0aGUgTUFJTlRBSU5FUlMgZW50
cnksIHNvIGFkZCB0aGVtLg0KPj4+IERhaXJlIGlzIHRoZSBhdXRob3Igb2YgdGhlIGNsb2NrICYg
UENJIGRyaXZlcnMsIHNvIGFkZCBoaW0gYXMgYQ0KPj4+IG1haW50YWluZXIgaW4gcGxhY2Ugb2Yg
TGV3aXMuDQo+Pj4NCj4+PiBTaWduZWQtb2ZmLWJ5OiBDb25vciBEb29sZXkgPGNvbm9yLmRvb2xl
eUBtaWNyb2NoaXAuY29tPg0KPj4NCj4+IEhleSBQYWxtZXIsDQo+PiBJIGtub3cgeW91cmUgYnVz
eSBldGMgYnV0IGp1c3QgYSByZW1pbmRlciA6KQ0KPiANCj4gU29ycnksIEkgZGlkbid0IHJlYWxp
emUgdGhpcyB3YXMgYWltZWQgYXQgdGhlIFJJU0MtViB0cmVlLsKgIEknbSBmaW5lDQo+IHRha2lu
ZyBpdCwgYnV0IGl0IHNlZW1zIGxpa2UgdGhlc2Ugc2hvdWxkIGhhdmUgZ29uZSBpbiBhbG9uZyB3
aXRoIHRoZQ0KPiBkcml2ZXJzLg0KDQpZZWFoLCBzb3JyeS4gSW4gaGluZHNpZ2h0IGl0IHNob3Vs
ZCd2ZSBidXQgdGhhdCBzaGlwIGhhcyBzYWlsZWQuIEkgc2VudA0KdGhlIHJuZyBidW5kbGVkIHRo
aXMgd2F5IGIvYyBJIGRpZG4ndCB3YW50IHRvIGVuZCB1cCBhIGNvbmZsaWN0Lg0KT2J2LiB0aGVy
ZSdzIG5vdCBhIHJ1c2ggc28gSSBjYW4gYWx3YXlzIHNwbGl0IGl0IGJhY2sgb3V0IGlmIG5lZWRz
IGJlLg0KDQo+IA0KPiBBcm5kOiBtYXliZSB0aGlzIGlzIHJlYWxseSBhbiBTT0MgdHJlZSBzb3J0
IG9mIHRoaW5nP8KgIE5vIGJpZyBkZWFsDQo+IGVpdGhlciB3YXkgb24gbXkgZW5kLCBqdXN0IGxl
dCBtZSBrbm93Lg0KPiANCj4+IFRoYW5rcywNCj4+IENvbm9yLg0KPj4NCj4+PiAtLS0NCj4+PiDC
oCBNQUlOVEFJTkVSUyB8IDUgKysrKy0NCj4+PiDCoCAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+Pj4NCj4+PiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMg
Yi9NQUlOVEFJTkVSUw0KPj4+IGluZGV4IGZkNzY4ZDQzZTA0OC4uZDc2MDI2NThiMGE1IDEwMDY0
NA0KPj4+IC0tLSBhL01BSU5UQUlORVJTDQo+Pj4gKysrIGIvTUFJTlRBSU5FUlMNCj4+PiBAQCAt
MTY5MzksMTIgKzE2OTM5LDE1IEBAIE46IHJpc2N2DQo+Pj4gwqAgSzogcmlzY3YNCj4+Pg0KPj4+
IMKgIFJJU0MtVi9NSUNST0NISVAgUE9MQVJGSVJFIFNPQyBTVVBQT1JUDQo+Pj4gLU06wqAgTGV3
aXMgSGFubHkgPGxld2lzLmhhbmx5QG1pY3JvY2hpcC5jb20+DQo+Pj4gwqAgTTogQ29ub3IgRG9v
bGV5IDxjb25vci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+PiArTTrCoCBEYWlyZSBNY05hbWFy
YSA8ZGFpcmUubWNuYW1hcmFAbWljcm9jaGlwLmNvbT4NCj4+PiDCoCBMOiBsaW51eC1yaXNjdkBs
aXN0cy5pbmZyYWRlYWQub3JnDQo+Pj4gwqAgUzogU3VwcG9ydGVkDQo+Pj4gwqAgRjogYXJjaC9y
aXNjdi9ib290L2R0cy9taWNyb2NoaXAvDQo+Pj4gK0Y6wqAgZHJpdmVycy9jaGFyL2h3X3JhbmRv
bS9tcGZzLXJuZy5jDQo+Pj4gK0Y6wqAgZHJpdmVycy9jbGsvbWljcm9jaGlwL2Nsay1tcGZzLmMN
Cj4+PiDCoCBGOiBkcml2ZXJzL21haWxib3gvbWFpbGJveC1tcGZzLmMNCj4+PiArRjrCoCBkcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWljcm9jaGlwLWhvc3QuYw0KPj4+IMKgIEY6IGRyaXZl
cnMvc29jL21pY3JvY2hpcC8NCj4+PiDCoCBGOiBpbmNsdWRlL3NvYy9taWNyb2NoaXAvbXBmcy5o
DQo+Pj4NCj4+DQoNCg==
