Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A506F4E5D22
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:20:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347707AbiCXCVi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:21:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241810AbiCXCVf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:21:35 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48C0B93995;
        Wed, 23 Mar 2022 19:20:04 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 9B45FC09BE;
        Thu, 24 Mar 2022 02:20:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1648088403; bh=1bmfyUNpFnJHyzxm+gXU8i0GLTu8taxORZE6m+ZED6I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=fkCsUm6EwycfHF2/AURw1wiShmEyE00QftLrDGFpdx8i096YFWoXNu/Q+wA90KdP6
         iviYk0byG3HPtAEaQxvs4gDs6+alETydqCPrtPQewFGYQOMV1Q2duHRWql6Mw0mppQ
         Moh50d09cQfJzqwu1BqYJGUFPWxmohUgw8/2gHaLt5siMb9lHrtQNaD5I3bzKa7rbE
         m+yWl4VD1OZk8ckza/PyjuaaPDPOkt3vhdNb3ttOcEHR+BMQumvzpH82gTgzfyjCRc
         c4nzA8Z/v3gcdg73CvLSZX7MBG+n0PeO4vyld0KvMJ/Sliy6QdFvTUY+YvmcMwhoRZ
         u460swFFmbs3Q==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 7AFE3A0087;
        Thu, 24 Mar 2022 02:20:02 +0000 (UTC)
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11lp2176.outbound.protection.outlook.com [104.47.56.176])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id DB05D40137;
        Thu, 24 Mar 2022 02:20:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="dLHyRCjB";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JKODNfLV5/vswAYTzIaFW1eo5rERv9wxDIJvVkLzNA4aQnlQrAaHhGm+QfKB2wKc7vi/U7G7vCJ9W+sWNEpAVOkPCg3WkyBt+kut0HI77ZTKmLb+l0rB8scKL+qTGI6Amfg/Wt1QCXJsowDPI6Em1QGHpsQpt/19Fy3kds25Gg4kmOasVrsdzi3eWAbGw3+6ewBuANo/uzZ8IgAW3b+JbCKqDddbp9pxq7UT57pwBoBhgTZAJQj0hNP39kGaQ4HjcpmpyLT1TijtXNqKcrjH0s2M8lcpEduL1iFMyr4wr54v4YZrBYeb5R83tmAQQ9+MEs4D3/FOoY+eEkiEbXHDMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=1bmfyUNpFnJHyzxm+gXU8i0GLTu8taxORZE6m+ZED6I=;
 b=cbyIBEDUEthwq0e9qtPWkIHyWXL+ZXeUmh63RQHGT4EwLcP5T0iAx62GtW4vnKIR7IXqOATqxA3BzuUJjOdhvJjYKzu/iyL+BEieH8XgDovM+96m/xJLKUrr+U2ZHNVpTYqs9dsfODPf1TEOfh47EgtYC52C+CLA54RmCq10AKD1qLBdbwqQmgOk06HikRngv97KfujcDHBDstaQGf3kvxge5A3Dw2ekHP4jryuQiL2OdMSf9hUmK1e/1y2N8DmP4MPoUYfZbvDGAm8GpG2P0isAHrutXF8LkWlgWvoKzqD5ykqYdQ4hpFYTbmKsWkEyLfgKWg87ANxo1TMPpNUYLA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1bmfyUNpFnJHyzxm+gXU8i0GLTu8taxORZE6m+ZED6I=;
 b=dLHyRCjB4LAh7DT5e7f/8gpaqeRFFORmgCB384QqNCSVmmkQm7Y/cCRZ07G8F++HrTKNEECaRtaV5Lm1Eah7WIvyQb8YrJH9tuzTI9/bkrbGbUaR88v1wrNKG1dxozMIfTu1+dCAUDA0agNSF7Zs25ZZe2oL5zofhjamwolCalc=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MN2PR12MB4992.namprd12.prod.outlook.com (2603:10b6:208:3c::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5102.17; Thu, 24 Mar
 2022 02:19:55 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::141:3edf:164a:857b%4]) with mapi id 15.20.5102.018; Thu, 24 Mar 2022
 02:19:55 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        "balbi@kernel.org" <balbi@kernel.org>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
CC:     "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Thread-Topic: [RFC PATCH v2 1/3] usb: dwc3: Flush pending SETUP data during
 stop active xfers
Thread-Index: AQHYIsliuiq4as3hWE6r+TfikYnp1KzL7aoAgAB4EACAAEfMAIABPAiAgAAcKwA=
Date:   Thu, 24 Mar 2022 02:19:55 +0000
Message-ID: <d9b87d05-904f-572a-80db-174a20551c04@synopsys.com>
References: <20220216000835.25400-1-quic_wcheng@quicinc.com>
 <20220216000835.25400-2-quic_wcheng@quicinc.com>
 <eeee97bf-2987-3cfb-217e-42615d8d864b@codeaurora.org>
 <26c82c13-d047-853e-12af-e916596c5c52@synopsys.com>
 <469213d0-526a-e26e-88c2-b34b2aa8dfe7@codeaurora.org>
 <e2a15c5e-f437-3dfb-6c49-a97a094eaaae@synopsys.com>
In-Reply-To: <e2a15c5e-f437-3dfb-6c49-a97a094eaaae@synopsys.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ec00c006-62e5-43f9-240e-08da0d3cc975
x-ms-traffictypediagnostic: MN2PR12MB4992:EE_
x-microsoft-antispam-prvs: <MN2PR12MB4992C3892F891618B6FD20CDAA199@MN2PR12MB4992.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: KPjmO2KCCwieowW2svZJs60SxMVDRjWJwCtYtSaeUqq/DhLyR8AK33H7ihlTJAKn0nK9vwwbfXIrTCcj86xCB06icSY/Cyn3KfEMBN2mQbYckV4zfZ/eGBGGkkBIDMy9tVypSeEFewhSOP1+uymWwAxLoxOUdwahD0ot2WFCQq9n6v5h8QY+kmPCsqgOmZAXD7m4BnMeoQbkQ4+X1DqToLKCaFpYzrpq0WI8CCcnVu1cCLCrngTvs4oWXlYZm0poD0SA6oK6wOh0d18qYS5/O+lmyX5HSPfWt7fQF6xeHCrj/UfmPBV+ohNu2j2pX44vsvGTrxzCJUXg2Zhr5hrnCqQeEI8/fzmawVZEIBm+dWq4Bu4ADSyvBTxScy83ZB7J0OcJf7ntFnvr/3NVV22oHcG9mkR8n6hL/NGT+Mulxyo2uZpxzJJmQgzY59naA2sasuZKtlPxQ01leQdya5k1EZFbxYkkddwrKlb2I2BcPR76OWjJMHvEPPLJwMLXe1Cz+5s7FXCzGeL03nmXoIelRhTBAHuWp5WfalgLgMf39TaquZkGSfCI3M6LPo/1df4kHzjZOc7mlbvMzFtlQg0TGki7U6uB5rIIiaWtzXbUKSabUvjVODfd8CBY6EP8oaJoatclQrCUsRx4U7Y8P0SXHGSNGj11aKvKZJSgrJAtvX8Ws7lJ+7VHzCY2o7VP28BVZL+hIj0bWTE/v1XXMxKbtthKZNwF2hTx4j6fiQ8bQJpg0y5IsdUGe/1eLNToaw+Y0ezqHgyZerkBoAkfEhLnSA==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(76116006)(66556008)(64756008)(122000001)(66446008)(8676002)(66946007)(66476007)(2906002)(4326008)(86362001)(38070700005)(110136005)(71200400001)(54906003)(6486002)(316002)(53546011)(31696002)(6506007)(38100700002)(31686004)(2616005)(5660300002)(83380400001)(36756003)(186003)(26005)(8936002)(6512007)(508600001)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?RjV0TUFsNlZNV2xSbFFmeEZuWiszY0NBdUJKMjBxb3ZONUVtRUtPSm9Ra1B0?=
 =?utf-8?B?KzZaYkFHend4RDhBUk0vc2c3cUJrdm5xZ2l0V3BHWVVUd3dUc0RDWnJoV2FV?=
 =?utf-8?B?dHg4WWtlRkN2eVdtZTFud1JTaWdVV3FIQzlYOU1RcWhzZzByTDdCaEhTSFBO?=
 =?utf-8?B?QVdDcFo3R1dvNHB3RUZNeVRuYmZLU3N2bC9EOXhGUSs2Q3NHMVVxWnZOaDNT?=
 =?utf-8?B?OWhiWjc4SVczRlgrRDd3MElTci9OTm9XRGZUbkdGRDZzWHhXNEFWSEZJRUZJ?=
 =?utf-8?B?RzJXWG0zVENHLzJxVFgzTkRSMVh0eGY2cTQyNFZKbmNWcGFhRmJkOWoreno0?=
 =?utf-8?B?QjBENmhOL0QvM0llNStQcjNtYU9mOTlKY3NiNTFOaHYwVmtJVG5ZSUVOeE96?=
 =?utf-8?B?ZjVCekNVWWI5cU8wOFdtUzBYNUM5ODcyN3kxbHdRY2ZxcXdpeWxScUVwN3li?=
 =?utf-8?B?UHBEYldzNnpoKy9OdktJV3hPMGl5R1VuWEM5YVZmRHRBRkNQWTJwbWVHS1Ra?=
 =?utf-8?B?TWVCeS9CaVNJMEVCekJJUjhLZUtBYzZpWTh4TElTczJTWWVMaXZrR1dLb3Nr?=
 =?utf-8?B?Vyt6MDZValljQ0tNdkQyZzJweDNoaG1pVW4vU2dNNDV6NzJxeTlYUGhqUVVs?=
 =?utf-8?B?WlBuaUNLM0drSXFUSFNweFU3UHB6dEFxb085NEorR2xqazNwODVmQ1VaMnUx?=
 =?utf-8?B?VWNkSVVyeU96c2RlQ0RqRXF6Zlo4Q25ia3BaWlhZUVV0SjVuV1g4ak1LK1Za?=
 =?utf-8?B?RC9vbTdOYnVKamNGaDRWOEtBaFNRS3ZublJPS3lOT0ZTZzYxKzhTR1puTUN4?=
 =?utf-8?B?NVJUczZXdDJqcWVBWGRVVzhzK1I3c2dkU3NERlQ4K1BHV3k2NGhONy9oS2pv?=
 =?utf-8?B?R2s3WFNTT2pLcmtqMnplS0R3TWU0aHE3WjhDTzlZcXJvTkZzY2JLeXZNcGx3?=
 =?utf-8?B?cmhBT0gwUFhnNnFtc1Jma3VoWkRVOXRyd3A3RXZ3TGdYdXJRQzdKd1ZjbWlX?=
 =?utf-8?B?b0htRjlwTmVZeGFuVlUyY2gwRFUrRDErMDNma2dhM3lWUnBFQWpIS2dDcHZp?=
 =?utf-8?B?WmtIMzFNeStZNWZ3ZU80VE9mUHZya1BFNUpaM0phUFFCRkxML1lXQ3NqWnFW?=
 =?utf-8?B?eVpnb3lTMTA5MnBWcXJrbnROV2tMSHgyZFZPaDFFb1JidVBVc0R3WHZHTk5V?=
 =?utf-8?B?UWs4S3FnTXlSWWxZK2RsaFFiZFZHUGY4OHZ2TEM3TTRIRkc1aXMyVGQvbTRJ?=
 =?utf-8?B?cEptVE5MRkFnREdoVTBNeWF0SzJHQVMxUG1Lc3N5TDdDMERaK1BYSHVWU2ZF?=
 =?utf-8?B?Ulk0a01vUndBZk5KTW4xZFN1bGtSRTViaFFoaWlLYVphUG5FVHFZUklvMXBo?=
 =?utf-8?B?Y1hnem1YRE1kK2tsbXRlYXBRT0tkeW14ck1NS3l1V2ZqeDB4WmtoZjlkUTVo?=
 =?utf-8?B?T1IydFhSRzZxN3RZWDNJb2VQQlRFeTRsUGNmTXA5NnRUNGJMWCsyY3NncTI5?=
 =?utf-8?B?aFYycnBwZlozbFR3RzBCVDBzSUlDVXdzK2VaNVl3b0d4NGcxZVZwSGIwN0Jw?=
 =?utf-8?B?MXBhKzl4dUc1WVpjbmdSQ0xGZmd2WVl2L3VQdmhCVitzWnhpMnpQd1NWZlJB?=
 =?utf-8?B?ajlpWjk4VU5nNDd3cjE5aXMweW9yR1ZmdDJtMXIydlN6TThhQWlZNmxaaStu?=
 =?utf-8?B?TDhSZHdZZStGVUxBQ3hlNDJaZVlvL2YzY05pNG5zcFRES2dSZXFvQjMwOUJZ?=
 =?utf-8?B?UzhKc0Z4WXRqa2pVaitHWU5qWmRwenJtdUd4U0t4NkZqTkN4SS9BL1JCT0Np?=
 =?utf-8?B?eDdKNTdRYUF5eTB5QTdTMzdBVjlQV29yWENwOEw4d0M5UlMrTTBxd0RoZVVh?=
 =?utf-8?B?VVAzeTl1Mmk2QkdPdVM3QUM2bXVodDV5aDBZOEZib0dyQk5CbWtpZ25MS3JX?=
 =?utf-8?Q?moJ0L3G/CcoIZyjSsFEibSDHoSY2fJvy?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <B5ABFDE25C41E64C830261C6F16E49B3@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ec00c006-62e5-43f9-240e-08da0d3cc975
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Mar 2022 02:19:55.4817
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: okaRIqVb8mBX9OrlIxJT/nDynlarqXD9KyPrpOnwCMpvdFGudeEygqhFErYk55d7BRArChvx7ShM6MK23ldMeg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4992
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

VGhpbmggTmd1eWVuIHdyb3RlOg0KPiBIaSBXZXNsZXksDQo+IA0KPiBXZXNsZXkgQ2hlbmcgd3Jv
dGU6DQo+PiBIaSBUaGluaCwNCj4+DQo+PiBPbiAzLzIyLzIwMjIgNjozMSBQTSwgVGhpbmggTmd1
eWVuIHdyb3RlOg0KPj4+IEhpIFdlc2xleSwNCj4+Pg0KPj4+IFdlc2xleSBDaGVuZyB3cm90ZToN
Cj4+Pj4gSGkgVGhpbmgsDQo+Pj4+DQo+Pj4+IE9uIDIvMTUvMjAyMiA0OjA4IFBNLCBXZXNsZXkg
Q2hlbmcgd3JvdGU6DQo+Pj4+PiBXaGlsZSBydW5uaW5nIHRoZSBwdWxsdXAgZGlzYWJsZSBzZXF1
ZW5jZSwgaWYgdGhlcmUgYXJlIHBlbmRpbmcgU0VUVVANCj4+Pj4+IHRyYW5zZmVycyBzdG9yZWQg
aW4gdGhlIGNvbnRyb2xsZXIsIHRoZW4gdGhlIEVORFRSQU5TRkVSIGNvbW1hbmRzIG9uIG5vbg0K
Pj4+Pj4gY29udHJvbCBlcHMgd2lsbCBmYWlsIHcvIEVUSU1FRE9VVC4gIEFzIGEgc3VnZ2VzdGlv
biBmcm9tIFNOUFMsIGluIG9yZGVyDQo+Pj4+PiB0byBkcmFpbiBwb3RlbnRpYWxseSBjYWNoZWQg
U0VUVVAgcGFja2V0cywgU1cgbmVlZHMgdG8gaXNzdWUgYQ0KPj4+Pj4gU1RBUlRUUkFOU0ZFUiBj
b21tYW5kLiAgQWZ0ZXIgaXNzdWluZyB0aGUgU1RBUlRUUkFOU0ZFUiwgYW5kIHJldHJ5aW5nIHRo
ZQ0KPj4+Pj4gRU5EVFJBTlNGRVIsIHRoZSBjb21tYW5kIHNob3VsZCBzdWNjZWVkLiAgRWxzZSwg
aWYgdGhlIGVuZHBvaW50cyBhcmUgbm90DQo+Pj4+PiBwcm9wZXJseSBzdG9wcGVkLCB0aGUgY29u
dHJvbGxlciBoYWx0IHNlcXVlbmNlIHdpbGwgZmFpbCBhcyB3ZWxsLg0KPj4+Pj4NCj4+Pj4+IE9u
ZSBsaW1pdGF0aW9uIGlzIHRoYXQgdGhlIGN1cnJlbnQgbG9naWMgd2lsbCBkcm9wIHRoZSBTRVRV
UCBkYXRhDQo+Pj4+PiBiZWluZyByZWNlaXZlZCAoaWUgZHJvcHBpbmcgdGhlIFNFVFVQIHBhY2tl
dCksIGhvd2V2ZXIsIGl0IHNob3VsZCBiZQ0KPj4+Pj4gYWNjZXB0YWJsZSBpbiB0aGUgcHVsbHVw
IGRpc2FibGUgY2FzZSwgYXMgdGhlIGRldmljZSBpcyBldmVudHVhbGx5DQo+Pj4+PiBnb2luZyB0
byBkaXNjb25uZWN0IGZyb20gdGhlIGhvc3QuDQo+Pj4+Pg0KPj4+Pj4gU2lnbmVkLW9mZi1ieTog
V2VzbGV5IENoZW5nIDxxdWljX3djaGVuZ0BxdWljaW5jLmNvbT4NCj4+Pj4+IC0tLQ0KPj4+PiBK
dXN0IHdvbmRlcmluZyBpZiB5b3UgaGFkIGFueSBpbnB1dHMgZm9yIHRoaXMgcGFydGljdWxhciBj
aGFuZ2U/ICBJDQo+Pj4+IHRoaW5rIG9uIHRoZSBkZXF1ZXVlIHBhdGggZGlzY3Vzc2lvbiB5b3Ug
aGFkIHNvbWUgY29uY2VybnMgd2l0aCBwYXJ0cyBvZg0KPj4+PiB0aGlzIGNoYW5nZT8gIEkgdGhp
bmsgdGhlIGRpZmZpY3VsdCBwYXJ0IGZvciB0aGUgcHVsbHVwIGRpc2FibGUgcGF0aCBpcw0KPj4+
PiB0aGF0IHdlIGhhdmUgdGhpcyBBUEkgcnVubmluZyB3LyBpbnRlcnJ1cHRzIGRpc2FibGVkLCBz
byB0aGUgRVAwIHN0YXRlDQo+Pj4+IHdvbid0IGJlIGFibGUgdG8gYWR2YW5jZSBjb21wYXJlZCB0
byB0aGUgZGVxdWV1ZSBjYXNlLg0KPj4+DQo+Pj4gVGhpcyBkb2Vzbid0IHNvdW5kIHJpZ2h0LiBU
aGUgcHVsbHVwIGRpc2FibGUgKG9yIGRldmljZSBpbml0aWF0ZWQNCj4+PiBkaXNjb25uZWN0KSBz
aG91bGQgd2FpdCBmb3IgdGhlIEVQMCBzdGF0ZSB0byBiZSBFUDBfU0VUVVBfUEhBU0UgYmVmb3Jl
DQo+Pj4gcHJvY2VlZGluZywgd2hpY2ggaXQgZG9lcy4NCj4+Pg0KPj4gVGhhdCBpcyBjb3JyZWN0
LCBidXQgZXZlbiB0aG91Z2ggdGhhdCBjaGVjayBpcyBwYXNzZWQsIGl0IGRvZXNuJ3QNCj4+IHBy
ZXZlbnQgdGhlIGhvc3QgZnJvbSBzZW5kaW5nIGFub3RoZXIgU0VUVVAgdG9rZW4gYmV0d2VlbiB0
aGUgcGVuZGluZw0KPj4gc2V0dXAgcGFja2V0IGNoZWNrIGFuZCBydW4vc3RvcCBjbGVhci4NCj4+
DQo+IA0KPiBUaGF0IHNob3VsZCBiZSBmaW5lLCBiZWNhdXNlIHdlIHdvdWxkIGhhdmUgdGhlIFRS
QiByZWFkeSBmb3IgdGhhdCBTRVRVUA0KPiBwYWNrZXQuDQo+IA0KPj4+Pg0KPj4+PiBJZGVhbGx5
LCBpZiB0aGVyZSBpcyBhIHdheSB0byBlbnN1cmUgdGhhdCB3ZSBhdm9pZCByZWFkaW5nIGZ1cnRo
ZXIgc2V0dXANCj4+Pj4gcGFja2V0cywgdGhhdCB3b3VsZCBiZSBuaWNlLCBidXQgZnJvbSBvdXIg
ZGlzY3Vzc2lvbnMgd2l0aCBTeW5vcHN5cywNCj4+Pj4gdGhpcyB3YXMgbm90IHBvc3NpYmxlLiAo
Y29udHJvbGxlciBpcyBhbHdheXMgYXJtZWQgYW5kIHJlYWR5IHRvIEFDSw0KPj4+PiBzZXR1cCB0
b2tlbnMpDQo+Pj4+DQo+Pj4+IEkgZGlkIGV2YWx1YXRlIGtlZXBpbmcgSVJRcyBlbmFibGVkIGFu
ZCBwZXJpb2RpY2FsbHkgcmVsZWFzaW5nL2F0dGFpbmluZw0KPj4+PiB0aGUgbG9jayBiZXR3ZWVu
IHRoZSBzdG9wIGFjdGl2ZSB4ZmVyIGNhbGxzLCBidXQgdGhhdCBvcGVuZWQgYW5vdGhlciBjYW4N
Cj4+Pj4gb2Ygd29ybXMuICBJZiB5b3UgdGhpbmsgdGhpcyBpcyB0aGUgYXBwcm9hY2ggd2Ugc2hv
dWxkIHRha2UsIEkgY2FuIHRha2UNCj4+Pj4gYSBsb29rIGF0IHRoaXMgaW1wbGVtZW50YXRpb24g
ZnVydGhlci4NCj4+Pj4NCj4+Pg0KPj4+IFRoaXMgcGF0Y2ggZG9lc24ndCBsb29rIHJpZ2h0IHRv
IG1lLiBUaGUgY2hhbmdlIEkgc3VnZ2VzdGVkIGJlZm9yZQ0KPj4+IHNob3VsZCBhZGRyZXNzIHRo
aXMgKEkgYmVsaWV2ZSBHcmVnIGFscmVhZHkgcGlja2VkIGl0IHVwKS4gV2hhdCBvdGhlcg0KPj4+
IHByb2JsZW0gZG8geW91IHNlZSwgSSdtIG5vdCBjbGVhciB3aGF0J3MgdGhlIHByb2JsZW0gaGVy
ZS4gT25lIHBvdGVudGlhbA0KPj4+IHByb2JsZW0gdGhhdCBJIGNhbiBzZWUgaXMgdGhhdCBjdXJy
ZW50bHkgZHdjMyBkcml2ZXIgZG9lc24ndCB3YWl0IGZvcg0KPj4+IGFjdGl2ZSBlbmRwb2ludHMg
dG8gY29tcGxldGUvZW5kIGJlZm9yZSBjbGVhcmluZyB0aGUgcnVuX3N0b3AgYml0IG9uDQo+Pj4g
ZGV2aWNlIGluaXRpYXRlZCBkaXNjb25uZWN0LCBidXQgSSdtIG5vdCBzdXJlIGlmIHRoYXQncyB3
aGF0IHlvdSdyZSBzZWVpbmcuDQo+Pj4NCj4+PiBQbGVhc2UgaGVscCBjbGFyaWZ5IGZ1cnRoZXIu
IElmIHRoZXJlJ3MgdHJhY2UgcG9pbnRzIGxvZywgdGhhdCdkIGhlbHAuDQo+Pj4NCj4+IE1haW4g
ZGlmZmVyZW5jZSBiZXR3ZWVuIHRoZSBpc3N1ZSBHcmVnIHJlY2VudGx5IHB1bGxlZCBpbiBhbmQg
dGhpcyBvbmUNCj4+IGlzIHRoYXQgdGhpcyBpcyBvbiB0aGUgcHVsbHVwIGRpc2FibGUgcGF0Y2gg
KG5vIGRlcXVldWUgaW52b2x2ZWQpLiAgSW4NCj4+IHRoaXMgc2l0dWF0aW9uIHdlIHdpbGwgYWxz
byBzdG9wIGFjdGl2ZSB0cmFuc2ZlcnMsIHNvIHRoYXQgdGhlDQo+PiBjb250cm9sbGVyIGNhbiBo
YWx0IHByb3Blcmx5Lg0KPj4NCj4+IEkgYXR0YWNoZWQgYSBmZXcgZmlsZXMsIGFuZCB3aWxsIGdp
dmUgYSBzdW1tYXJ5IG9mIHRoZW0gYmVsb3c6DQo+PiAxLiAgcHVsbHVwX2Rpc2FibGVfdGltZW91
dC50eHQgLSBmdHJhY2Ugb2YgYW4gaW5zdGFuY2Ugb2Ygd2hlbiB3ZSBzZWUNCj4+IHNldmVyYWwg
ZW5keGZlciB0aW1lb3V0cy4gIFJlZmVyIHRvIGxpbmUjMjAxNi4NCj4+DQo+PiAyLiAgbGVjcm95
K2Z0cmFjZV9zbmlwLnBuZyAtIHBpY3R1cmUgc2hvd2luZyBhIG1hdGNoaW5nIGJ1cyBzbmlmZmVy
IGxvZw0KPj4gYW5kIGEgZnRyYWNlIGNvbGxlY3RlZCAoZGlmZmVyZW5jZSBpbnN0YW5jZSB0byAj
MSkNCj4+DQo+PiAjMiB3aWxsIHNob3cgdGhhdCB3ZSBjb21wbGV0ZWQgYSBTRVRVUCB0cmFuc2Zl
ciBiZWZvcmUgZW50ZXJpbmcgaW50bw0KPj4gZHdjM19nYWRnZXRfc3RvcF9hY3RpdmVfdHJhbnNm
ZXJzKCkuICBJbiBoZXJlLCB3ZSB0aGVuIHNlZSBEV0MgQUNLDQo+PiBhbm90aGVyIFNFVFVQIHRv
a2VuLCB3aGljaCBsZWFkcyB0byBlbmR4ZmVyIHRpbWVvdXRzIG9uIGFsbCBzdWJzZXF1ZW50DQo+
PiBlbmRwb2ludHMuDQo+IA0KPiBUaGFua3MgZm9yIHRoZSBjYXB0dXJlcy4gSSB0aGluayB0aGUg
cHJvYmxlbSBoZXJlIGlzIGJlY2F1c2UgdGhlIGR3YzMNCj4gZHJpdmVyIGRpc2FibGVzIHRoZSBj
b250cm9sIGVuZHBvaW50LiBJdCBzaG91bGRuJ3QgZG8gdGhhdC4NCj4gDQo+IENhbiB5b3UgdHJ5
IHRoaXM6DQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy91c2IvZHdjMy9nYWRnZXQuYyBiL2Ry
aXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gaW5kZXggYWI3MjVkMjI2MmQ2Li5mMGI5ZWEzNTM2
MjAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvdXNiL2R3YzMvZ2FkZ2V0LmMNCj4gKysrIGIvZHJp
dmVycy91c2IvZHdjMy9nYWRnZXQuYw0KPiBAQCAtMTAxMCwxMiArMTAxMCwxMiBAQCBzdGF0aWMg
aW50IF9fZHdjM19nYWRnZXRfZXBfZGlzYWJsZShzdHJ1Y3QNCj4gZHdjM19lcCAqZGVwKQ0KPiAg
ICAgICAgIGlmIChkZXAtPmZsYWdzICYgRFdDM19FUF9TVEFMTCkNCj4gICAgICAgICAgICAgICAg
IF9fZHdjM19nYWRnZXRfZXBfc2V0X2hhbHQoZGVwLCAwLCBmYWxzZSk7DQo+IA0KPiAtICAgICAg
IHJlZyA9IGR3YzNfcmVhZGwoZHdjLT5yZWdzLCBEV0MzX0RBTEVQRU5BKTsNCj4gLSAgICAgICBy
ZWcgJj0gfkRXQzNfREFMRVBFTkFfRVAoZGVwLT5udW1iZXIpOw0KPiAtICAgICAgIGR3YzNfd3Jp
dGVsKGR3Yy0+cmVncywgRFdDM19EQUxFUEVOQSwgcmVnKTsNCj4gLQ0KPiAtICAgICAgIC8qIENs
ZWFyIG91dCB0aGUgZXAgZGVzY3JpcHRvcnMgZm9yIG5vbi1lcDAgKi8NCj4gICAgICAgICBpZiAo
ZGVwLT5udW1iZXIgPiAxKSB7DQo+ICsgICAgICAgICAgICAgICByZWcgPSBkd2MzX3JlYWRsKGR3
Yy0+cmVncywgRFdDM19EQUxFUEVOQSk7DQo+ICsgICAgICAgICAgICAgICByZWcgJj0gfkRXQzNf
REFMRVBFTkFfRVAoZGVwLT5udW1iZXIpOw0KPiArICAgICAgICAgICAgICAgZHdjM193cml0ZWwo
ZHdjLT5yZWdzLCBEV0MzX0RBTEVQRU5BLCByZWcpOw0KPiArDQo+ICsgICAgICAgICAgICAgICAv
KiBDbGVhciBvdXQgdGhlIGVwIGRlc2NyaXB0b3JzIGZvciBub24tZXAwICovDQo+ICAgICAgICAg
ICAgICAgICBkZXAtPmVuZHBvaW50LmNvbXBfZGVzYyA9IE5VTEw7DQo+ICAgICAgICAgICAgICAg
ICBkZXAtPmVuZHBvaW50LmRlc2MgPSBOVUxMOw0KPiAgICAgICAgIH0NCj4gDQoNCkFsc28sIGRv
bid0IGlzc3VlIEVuZCBUcmFuc2ZlciBvbiBjb250cm9sIGVuZHBvaW50IGVpdGhlci4NCg0KVGhh
bmtzLA0KVGhpbmgNCg0K
