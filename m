Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 154E64F7637
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 08:36:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241246AbiDGGip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 02:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241574AbiDGGiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 02:38:11 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE4808EB6E;
        Wed,  6 Apr 2022 23:36:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1649313373; x=1680849373;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Jjyv98cbyCDCJfn3I/hwBRFWhmPuICgYJjuXRSYP3qU=;
  b=mM5R3eiFQMiNcaqZXAAijhnQ1c3Li6fCt2EwDGBlq0QGCoK7+IUpKCBn
   RDEZnoCtAicjB8juKo9phLDsXWcwXhQbllgFlPTGeI2pqKMGQ6Adr+lPq
   Vfe13SZkt2rC0eskIp766i81ue5lST2Tmn/IFrCIP1jMx+mLeWi62rmUe
   IzDpZYL8ij4FXYoAXgBiJJPUvUDlPqXsUXnpJSKbmW8/QMgk+bk2xRS4z
   +wVi6qBmwIWc9iDsDclh5knDZ7+BRWa4bIRXaFX08i9ZxwZ20Nt/Z9ge4
   FxGkCyiUMATia5i/oqW51cvalPBSph3SdAuGAL+FjuxApfbtQou6Mchts
   A==;
X-IronPort-AV: E=Sophos;i="5.90,241,1643698800"; 
   d="scan'208";a="159242579"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 06 Apr 2022 23:36:12 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 6 Apr 2022 23:36:10 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 6 Apr 2022 23:36:10 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Eah8qiK12JYr3tXWuCRSwz2oQhkppx3hzarod27lqtgz5SJzU7Y3BvwwSl8lFxorTqTzBIeqy2YbTE4KuPz3tw8uv7U1iq06a7Pp81BOnbzcplzF2JMSMP3e03BN/ns9QaU92+CxMpln5/0rYK8Hnqg5IDKpw2Gfgh7QU3NPW68bTWqGYL1SF8MKB5ZUS7H7Qm3LfpVfvdYEr09OALMCUJXsi6Q1BAf71Fdx5kHkrf1+VxbgCPjMTzkAVe4T6kuKNSNw4FxtO30gnk7j6y199JC7HT70Io1VosnG0Xbjql5MAKbHbSwk+fPc7yLgAt8N/8yHiayh0pAJyk4ej3Ow8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Jjyv98cbyCDCJfn3I/hwBRFWhmPuICgYJjuXRSYP3qU=;
 b=GH5Vkg8O8dyiJ+tWQ2io4R4YRu5BxsDdNKGoeLWHomMEEstBPyOjmjcTlkZrdzQqs+w6sLAzoMVhYD4Dh9tzRlidXGRHppBGlXczUDkQDHXC6zZQprk89sCLk1QZl2keWUR4ba4vujqEZk4k6H+jLGgB+1jFQgnfQMmnx/7NJRqWF+g18VFjDwpVbryd7TOPwXExfN526LmK+5Lx4mJzqUZDuwD4LCturXQXNxLDkJ8zecLkoMUzdEC1JRGFPkGvuXxJSDeTjCeH0mfpbNQFYuxGb0XhfbyzYZg8vCM30jLskFT+GiYoDxY8qYuT6ajsgdtMGXr7+2wqTy+bnNY1pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Jjyv98cbyCDCJfn3I/hwBRFWhmPuICgYJjuXRSYP3qU=;
 b=iUYyEPeqvObvH/aIOSHTmWxLk/vQmTYUoyTFRdsdBEoEf6aqgYltLqWWsb/zcYqBO0SE7wwt68Lh+RshR+mJa2B7mctd0D3BEPLQbgng8sHHt/Lkpu3Ctn4tORbfg5v4pmvtoRDUKWVoYhO/ugOMp5JFtz7HsA56LaSjUH0Yzic=
Received: from CO1PR11MB4769.namprd11.prod.outlook.com (2603:10b6:303:91::21)
 by MWHPR11MB1342.namprd11.prod.outlook.com (2603:10b6:300:1e::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5144.21; Thu, 7 Apr
 2022 06:36:08 +0000
Received: from CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b]) by CO1PR11MB4769.namprd11.prod.outlook.com
 ([fe80::6d66:3f1d:7b05:660b%7]) with mapi id 15.20.5144.022; Thu, 7 Apr 2022
 06:36:08 +0000
From:   <Claudiu.Beznea@microchip.com>
To:     <robh@kernel.org>, <krzysztof.kozlowski@canonical.com>,
        <Nicolas.Ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <Ludovic.Desroches@microchip.com>, <soc@kernel.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND PATCH] arm: dts: at91: Fix boolean properties with values
Thread-Topic: [RESEND PATCH] arm: dts: at91: Fix boolean properties with
 values
Thread-Index: AQHYSknDMfGn26aYr02utpl+XHeWnQ==
Date:   Thu, 7 Apr 2022 06:36:08 +0000
Message-ID: <938abddc-4d6b-1bae-5107-be4fd439960b@microchip.com>
References: <Yk3leykDEKGBN8rk@robh.at.kernel.org>
In-Reply-To: <Yk3leykDEKGBN8rk@robh.at.kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 3f381732-65c8-4b90-2732-08da1860e67f
x-ms-traffictypediagnostic: MWHPR11MB1342:EE_
x-microsoft-antispam-prvs: <MWHPR11MB1342DAEEBC2C77333858E61387E69@MWHPR11MB1342.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 5TboNpROwnWvN3wHR4ERcdAVm4wW+AWgzuRRHU4KHMHWjNBX+QdKY2i8AU1t3MJhlPEjgsz8AvWxm7RpUPDrq5We31zlq1k5W3NlB28w7GcfPPRgg3J5w7Y/BksdsO4PoT9NWYnvK4NlsxbEEIaFmb5Qyd2rdgx35YYuK/Ik2BJJ1Vel/28UeSLV72G44Qcf8Qsyl1CKnNl/v1wGxPc4Rc3Fi48zjHibLxOib2q8iKLqLRpKDgn8lsvc9eD9rTGqEHYl7ReObCMPZeWf50lmLyKeEKb/vRbe5dOKA456dUH9JeI1euxO8ATalkfccJG9iBcl3gz0Zb4VuMmvX/MGQCqugFeb0q0XRkPNc7DaXS5zlNo12xl/v9fbSlP5APTIXWnTphKe6G8w6X+psPKCn5tT6dapYux01nP3GXwVH2AqTk0XMTx3uGHoUUedZJoyOTwkAXr1aWw6QYP03108p3VxKusHukE7ERlOf31lXTdNalz4H46SHP7PyAHvmlpFv6FOrZUK6AYrASZlNeJLcvdhpYr1NlSDbMubjkPAObbkA03XpvsEPFZnP3gSeBbHuSMYKUZWPAqgUqPxy/SPt4OpV1+jkiJdzaluOwA9z/llaDXXnEAuRL4/Uatf6ldoemyZKbKzcxgiTKuRduMaR6fs2AwlueCTCJg7O9dSsXYrDRg69VzH8ple+7dUEw8pr+8XzMHCuQReZR9uczXvLTro8CwR9/RnXKyMm18plY+hhwmPD+4yPMf5Fsoml/kXcZymHjp7PTTRHoWVruCSTa8ClPsFGmxZHpDLhwYXwu2U7ZeXF+tem4H4wbUHzJSfHY8ncGClfo3184xnmIULZ16lmT01GEAaXkybbl8k/c0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB4769.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(86362001)(4326008)(31686004)(31696002)(8936002)(2906002)(5660300002)(64756008)(66446008)(66476007)(66556008)(36756003)(8676002)(91956017)(66946007)(76116006)(186003)(508600001)(6486002)(966005)(122000001)(26005)(71200400001)(110136005)(54906003)(316002)(38100700002)(38070700005)(2616005)(6512007)(6506007)(53546011)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?MFRVOXVYcVRCNnI3NUdlSVVJQXJaeklFZzhySE9oa0RjbmdDdERFN1BWUE93?=
 =?utf-8?B?TFUzQXFnRUd0MVQ0T1IwTktIUEs2LzMyMHEwY1dXeis1eXI3Rlc4UjBOUjFV?=
 =?utf-8?B?dFhyUXp5TEtDaDNNN2JON05xcCszUUVCNzdBeDZrcW8rUGRBdDBhM0lrellv?=
 =?utf-8?B?VFJHWDVLN3FNQjFrYUFTaE8xUXpiL0dsVG5NOVlVc3VMRS9sWms3MldaSTVI?=
 =?utf-8?B?WXBNK3NiMFl3WVlURkdzN1Y1T3BkZFg4cVdpenpFRXUvWDc0dDNmUGgyNG96?=
 =?utf-8?B?Vy80SXhxZTliU2JtblRnZnl3eEpCTm9QRHM5bzc2QVlYWk1HRThWbzk5ZGRN?=
 =?utf-8?B?VXc4d1djVFRNa2MxMExqdTl1a0hrZlpISkQxNnlYN0k0bHNWbERpVGwrV0F3?=
 =?utf-8?B?R2NlMUFZNi9ac0JqVzFrejhCS2dacWNPYnlRZ0FlL3ZNZVk4SmpMTXNseElq?=
 =?utf-8?B?WHVWMjlJbWVBR1h3SGxnZExudHpVMVYzT1k4MUFBOHQyRzZjd1ZGc0pMcWpV?=
 =?utf-8?B?NmcrZEJLMmQ2MG51K1VuYzRnWXVDMWZ4VFlDd1RjTVVoOGZGd0VKM3ZTUm9D?=
 =?utf-8?B?ZUVjMnJOUDNNM3ZFaEY1UGtCeEE0Mmd6TC9id2haRC85Q0Qwc3RaUGVvaFl2?=
 =?utf-8?B?dWFVYzBBc0xGWldHK0xuUEZKbDlLSnoxLzFEd2JjWWZYaFJ6V1MxR2p0TW85?=
 =?utf-8?B?bE43WFg5WFIzajF2RnZWOFZqMjVmSXNJSnpseENGcWZkVjlRQ09qRUtsSlJY?=
 =?utf-8?B?cE4rYmp4Z0d5T1pVOC9MSVB4YVRMakNnKzdLam9XM1FBR1hBT2VNTHVIb1R0?=
 =?utf-8?B?bEhZdDArMVFGRjdyVXplaHdkcmxMVGJxUUtlRnkyWEllam0reXJSU0VEdmxU?=
 =?utf-8?B?VVI2Zk9FdWZhMXZ6UFFpUk9iVXUwZ2JSVkNHbHBpejJBL2UwcmNGT0VtNkhR?=
 =?utf-8?B?ZEUxc2hhSWNUajIzYU80dTM4dG1nVFRQZGFCRFkxdGQ5LzBoTVErRjNubHEx?=
 =?utf-8?B?SkZjY0NVVDJKb1RDeUc4SkdpZ0E1V3I2MGlpY0RoVFBCU0VjMy9TL0EyL1Iv?=
 =?utf-8?B?d3BGbmJQUGZjMExnc3gyTk1YWEFnYWd3Lzh2ZHcwdmJsYytFdzZEZmJlN1Z4?=
 =?utf-8?B?eFkrUFVmeUo1c0FjUmJyYjRNblpMUFlJbG1reEVJWWQyK2l6K3g0TzdIY1NO?=
 =?utf-8?B?WENiN2g5VEphN1E4S0prSVhoMFNYQXkvang3cWlaZXk3TVg5Q3RFMmh1bVBr?=
 =?utf-8?B?ZERYK2IwR1FpL3VLUUF1Q3NZd3JBVkpNUUpYRFVCSjNUSWNsSHR5V29SY05C?=
 =?utf-8?B?SDFOUlUyU29pZ3IzVzM5V3Erb2k5djgrcWhJZHBYcGpsM1BKaUVBREw0N1Nr?=
 =?utf-8?B?M2JXUjZuQ1BFSWtpZ0lNOVIydmNWdFR0eEoxM016ZGIrcGFPVXVnUS9YanVs?=
 =?utf-8?B?U0xuWkdQNGxxa1NXcGl6VGZiR3V4ZWRnazZZR1NEejRBZVAwODdJK1JDRUVh?=
 =?utf-8?B?UTgwUU5zTk1wNkp0WG1OaWlSWW5MRzZHS09XTFVUbzZhNmlha2M4OWtMdGJk?=
 =?utf-8?B?TzhURFRHWjV1SHdlNG1wNUZFbi9zVmw1YURIaThOcWtyaXRPaXdJa2xkemRa?=
 =?utf-8?B?WEM5UXRGeXRXRnBwVUNDdHJtU3pCU0hVWkN5ZDFnNzlrZHlyWWRVY0lQZHNr?=
 =?utf-8?B?V1VyY1h0a0VzaEliZkw5Nm5BM0Y2TUowTHpxOW1ML1ptTDd2UU5yL1ZseDEz?=
 =?utf-8?B?SjNzSW5MMlNBODZZdlQwSExCRzdTdFo0aGRLVUU0OXhCcnR4cXpMWC9yS1Rt?=
 =?utf-8?B?OEZ1Z3VnalY0VGZxVVFXYVRjVWpuTHdLeExnRnZsMkdCYjVnUFFoR0Nqa3NF?=
 =?utf-8?B?QWlnZWFVQWZwd0NzdGJoaWR0OW0yWnNoQU1jYXhjemdhenNvZ0k2ZmR1bkNs?=
 =?utf-8?B?cFVyU0dCY3F3TFlNcFkxRkV6Skp2TUVtQ1o4dTFNYkZKYng1V09GMlVaZUl1?=
 =?utf-8?B?a2c1eGVxNGlOcTBHbW5XbUh2R09BbEVPTzQ0SnpkZ3F3bWJEVFpRZ0wxdEMx?=
 =?utf-8?B?T00zRVYrOWVZSlVpM1d4aWNRNEtQV05Ibm9wQW5BbzdvSVBWcjBmSWs0NHEr?=
 =?utf-8?B?UFlidnhPWUlRcjd2cVhkc2RWTDFTdXErclpJOHhYT1BtbFhLTkNOaGswNjh3?=
 =?utf-8?B?WkJhR3RIanp3QmoyTjdNdVpHaklBNU1xemZSOFp3dGh5QU1na1pNRTR3bTkw?=
 =?utf-8?B?OTJ5RzE4MUdNTXR0QUN5Ny9OUitpcXFmVXJKQ3FRVHM3akxOQ0xMb1BkSjJj?=
 =?utf-8?B?QzF0NkpSb0dJOFdZQiswc1UraXdCZXhvbCtWNDI4Y2ZlTGZTSDIwSlJKbXJO?=
 =?utf-8?Q?ZHt7fJndZu5kwr7s=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <895E99788E85084D99826A8FEE7EE0AD@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB4769.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3f381732-65c8-4b90-2732-08da1860e67f
X-MS-Exchange-CrossTenant-originalarrivaltime: 07 Apr 2022 06:36:08.8261
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 7qwUKjdD0M9KnbmxTRTp1U+mzxWZ4ZtZpt3IzfwaeLQcF8zu53xT8cT9ZKl4lxpex6L4AjWvgP+YRMbwZD6XCQDLL+uqX0TJJFLt4aVbsZA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR11MB1342
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDYuMDQuMjAyMiAyMjowOSwgUm9iIEhlcnJpbmcgd3JvdGU6DQo+IEVYVEVSTkFMIEVNQUlM
OiBEbyBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cg
dGhlIGNvbnRlbnQgaXMgc2FmZQ0KPiANCj4gQm9vbGVhbiBwcm9wZXJ0aWVzIGluIERUIGFyZSBw
cmVzZW50IG9yIG5vdCBwcmVzZW50IGFuZCBkb24ndCB0YWtlIGEgdmFsdWUuDQo+IEEgcHJvcGVy
dHkgc3VjaCBhcyAnZm9vID0gPDA+OycgZXZhbHVhdGVkIHRvIHRydWUuIElPVywgdGhlIHZhbHVl
IGRvZXNuJ3QNCj4gbWF0dGVyLg0KPiANCj4gSXQgbWF5IGhhdmUgYmVlbiBpbnRlbmRlZCB0aGF0
IDAgdmFsdWVzIGFyZSBmYWxzZSwgYnV0IHRoZXJlIGlzIG5vIGNoYW5nZQ0KPiBpbiBiZWhhdmlv
ciB3aXRoIHRoaXMgcGF0Y2guDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9i
aEBrZXJuZWwub3JnPg0KDQpSZXZpZXdlZC1ieTogQ2xhdWRpdSBCZXpuZWEgPGNsYXVkaXUuYmV6
bmVhQG1pY3JvY2hpcC5jb20+DQoNCg0KPiAtLS0NCj4gQ2FuIHNvbWVvbmUgYXBwbHkgdGhpcyBm
b3IgNS4xOCBwbGVhc2UuDQo+IA0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3gzLWhz
LmR0cyAgICAgIHwgMiArLQ0KPiAgYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpib3gzX2NvbW1v
bi5kdHNpIHwgMiArLQ0KPiAgMiBmaWxlcyBjaGFuZ2VkLCAyIGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5MS1raXpi
b3gzLWhzLmR0cyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEta2l6Ym94My1ocy5kdHMNCj4gaW5k
ZXggMjc5OWIyYTFmNGQyLi5mN2Q5MGNmMWJiNzcgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jv
b3QvZHRzL2F0OTEta2l6Ym94My1ocy5kdHMNCj4gKysrIGIvYXJjaC9hcm0vYm9vdC9kdHMvYXQ5
MS1raXpib3gzLWhzLmR0cw0KPiBAQCAtMjI1LDcgKzIyNSw3IEBAIHBpbmN0cmxfcGlvX3piZV9y
c3Q6IGdwaW9femJlX3JzdCB7DQo+ICAgICAgICAgICAgICAgICBwaW5jdHJsX3Bpb19pb19yZXNl
dDogZ3Bpb19pb19yZXNldCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHBpbm11eCA9IDxQ
SU5fUEIzMF9fR1BJTz47DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIGJpYXMtZGlzYWJsZTsN
Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZHJpdmUtb3Blbi1kcmFpbiA9IDwxPjsNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgZHJpdmUtb3Blbi1kcmFpbjsNCj4gICAgICAgICAgICAgICAg
ICAgICAgICAgb3V0cHV0LWxvdzsNCj4gICAgICAgICAgICAgICAgIH07DQo+ICAgICAgICAgICAg
ICAgICBwaW5jdHJsX3Bpb19pbnB1dDogZ3Bpb19pbnB1dCB7DQo+IGRpZmYgLS1naXQgYS9hcmNo
L2FybS9ib290L2R0cy9hdDkxLWtpemJveDNfY29tbW9uLmR0c2kgYi9hcmNoL2FybS9ib290L2R0
cy9hdDkxLWtpemJveDNfY29tbW9uLmR0c2kNCj4gaW5kZXggYWJlMjdhZGZhNGQ2Li40NjU2NjQ2
Mjg0MTkgMTAwNjQ0DQo+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2F0OTEta2l6Ym94M19jb21t
b24uZHRzaQ0KPiArKysgYi9hcmNoL2FybS9ib290L2R0cy9hdDkxLWtpemJveDNfY29tbW9uLmR0
c2kNCj4gQEAgLTIxMSw3ICsyMTEsNyBAQCBwaW5jdHJsX2ZseDRfZGVmYXVsdDogZmx4NF9pMmM2
X2RlZmF1bHQgew0KPiAgICAgICAgICAgICAgICAgcGlubXV4ID0gPFBJTl9QRDEyX19GTEVYQ09N
NF9JTzA+LCAvL0RBVEENCj4gICAgICAgICAgICAgICAgIDxQSU5fUEQxM19fRkxFWENPTTRfSU8x
PjsgLy9DTEsNCj4gICAgICAgICAgICAgICAgIGJpYXMtZGlzYWJsZTsNCj4gLSAgICAgICAgICAg
ICAgIGRyaXZlLW9wZW4tZHJhaW4gPSA8MT47DQo+ICsgICAgICAgICAgICAgICBkcml2ZS1vcGVu
LWRyYWluOw0KPiAgICAgICAgIH07DQo+IA0KPiAgICAgICAgIHBpbmN0cmxfcHdtMCB7DQo+IC0t
DQo+IDIuMzIuMA0KPiANCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IGxpbnV4LWFybS1rZXJuZWwgbWFpbGluZyBsaXN0DQo+IGxpbnV4LWFy
bS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZw0KPiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL2xpbnV4LWFybS1rZXJuZWwNCg0K
