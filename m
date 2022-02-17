Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EF6D4BAD6C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 00:52:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbiBQXuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 18:50:05 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:44806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229527AbiBQXuE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 18:50:04 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5570D656D;
        Thu, 17 Feb 2022 15:49:48 -0800 (PST)
Received: from mailhost.synopsys.com (us03-mailhost2.synopsys.com [10.4.17.18])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 919AB42247;
        Thu, 17 Feb 2022 23:43:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1645141409; bh=EH6Hed2nAaVnyU/428iUUpizOUUK1EAqCt3oOZK+Y8Y=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=S6zyocV7HBJ/54ivhT1vjMJAfhgwdCHlygPqEzwelV+ZAMjE3lbCTyFBTN2EYtlGo
         5wZZwzzPUkmLTfqJT7Sa/hr9hrk9suYmtOmxVcSoALhRnvdrT34wOJS/gHwyzhi5JR
         Sxcz6QlAr781EL9Wafng5iYbhJ1YIYkO0v7U33unnuLMFKy8pwqZfcB+pqTcLli45t
         9aqI8vNxB6q6W7g2dxYmJFoLzbxQIKQzyp2cZ+K8acB6gGMW2Z/FNX4BuigdIac8fc
         gX9erN7jIJe65rtIFRGmvT9acDx/lyNCXArmaBAuAK0A7jbKYahMl/Z+E4vlLxZJzF
         1PFnHoo8KiOhg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id F40A2A0081;
        Thu, 17 Feb 2022 23:43:26 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2175.outbound.protection.outlook.com [104.47.59.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 8C5948014D;
        Thu, 17 Feb 2022 23:43:25 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="vPmRE9bB";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KbN5f4d9sLwUJiWER2bzZAHOkoTzVG++tcnX9tNpOsXFT6ypYvYykwaOBT64+MMZxQb6bPJexFWXNvbggWwQp2yaTqiH4X1NIqD9oJTfVDtxLAvHp1qgdE3GBJlkJVgsITpcxkj+EHUQkUCheFXA2lKEjKpeYzH3jYFcB5RyBzrZS28cwwmM2Jm/vDBof3GgFrebCtS7p7BeDPDBL5wjyaWBZOby5s9BOrm1kOfFHbKIgxTlWH0cN5mXeZnHMgrdmRrTrQx6gZspHB2/r82uUhMkcFbva/h2ykeV3BB62U1LGh4Flrwz0cCeSwL0WWfJUdVH1wUdXYNBcPh/USNLdA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EH6Hed2nAaVnyU/428iUUpizOUUK1EAqCt3oOZK+Y8Y=;
 b=Q6PC5AGEg16t1MpsOYluZAiqrkYa2PioL0VqEkNU/VvwsR4Jx1bFDfPNkOiY9Qam6bWymjr0F+tUj6K14yDm9tGxqqVAjPiFOpguq1YXUUYI/UlhI2rWK6PYj3SaYA1SzsbuSb6Q1GfWPEYvA+hTyIlet3Afao2mN1E9qA743w6m4OFwM3gypeD3QwoJxMb0IxxW+dQpK4PLQWFja6F5fEWRR7UCQZ/kAdSCX+Wycb+WwNxrBiC0kZcBHOTyIubLowKtgjTV8JbgRxvx5Gi/2EXw5wyumOAJ2X8FyXLkcPz8x+pLQ12mQp//eKKlLURrVZ4rkBp/Ohu5jYglQwrVbg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EH6Hed2nAaVnyU/428iUUpizOUUK1EAqCt3oOZK+Y8Y=;
 b=vPmRE9bBHAhbgER9RHWrFJrhiUWyrN/3lmtJcq1ytx6/imbADJvsQZBilsUIE1yLWdYWX3zR9xE3gsnER4KIphOtQPzVseIHZB/yKE/Ta8LbVBb34nSfvhFHh18gWltC3OxOH31g0JFg1Zp8Mk58c94SPl5ij3qCktksiG0eIWI=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by MW3PR12MB4507.namprd12.prod.outlook.com (2603:10b6:303:2c::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Thu, 17 Feb
 2022 23:43:22 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4975.017; Thu, 17 Feb 2022
 23:43:22 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <quic_wcheng@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Jung Daehwan <dh10.jung@samsung.com>
CC:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "quic_jackp@quicinc.com" <quic_jackp@quicinc.com>
Subject: Re: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING in
 ep cmd fails
Thread-Topic: [PATCH v2 1/2] usb: dwc3: Not set DWC3_EP_END_TRANSFER_PENDING
 in ep cmd fails
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIADVGEAgAA82AA=
Date:   Thu, 17 Feb 2022 23:43:22 +0000
Message-ID: <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
In-Reply-To: <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 0e5b5570-dc69-41cf-371a-08d9f26f48ee
x-ms-traffictypediagnostic: MW3PR12MB4507:EE_
x-microsoft-antispam-prvs: <MW3PR12MB45071A10A51E168CCC6AE8DDAA369@MW3PR12MB4507.namprd12.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: M4ZNgQMW6DJasOe+1cg7LSTFuV7Ti6el/ZtKuAnwaIKH7sm6iCysqKncvKop0OdDsNDeTwec5APY9BmmyHuCbaxR7YoFt0yRYM50/q5KnmXEHGbc/aElAY5d8LmRacUY3kDcPpZeOeDQ5RTK1ril2DtKwhViHlKI2xYYKOX+SQ4Te0AUfneMAxV0ayKuUtVTuc4FcQDipwEFrgEkkFFTsYAYibpdfBmCQS25iue8psv+T6n9WYU+U82oNBFH97u5bY62M5Nl18VMdL2lh78DwKKdCZ0J/j2wDyLlTFGzYzUYTNapQHRW7T4w+6CKVlkG30Qhf0Fw8blZgBpV0eC6SAf7YitMBGPQ+l/xoBHUPYDctD89kUhXESd8F5G86kFP61Xpc1KJ8CB94cgT6suAb1DCsCU34jYUuiuOKcRu20YWOXP2DI0JPAuV+JRp5GLd6OsRodg6Q1jsB9NlTbW7EaWNaiz/e62SVUOrtTdRliKXQqzaRPxFLFEWKIciFaaBT4fOnJXrEgowEV4jngVzRyV7KZtTeLo2peKiF0wsjarnC+HmKMkwL1XRpARwNdaCJRMzfSwxVzB7HaaCs5nx+BePT5afjdy4xyVuqA7Ncg2dCV2uxYirG5HTc5t7L6d6g5rP5cFYNjfBKf2yRpzRg8dlAZ/9cqihQ/FQRZ4S3Bszv6xCf67VtKdlNLj8YKhILar58htxcuXdQSkqP8S7hG/+5oGTYFcFJSBhWFUg+ozd/Xhl26GsTcuyrtJQMK8/KBBSIJ6IZa03oDoTMRNUrPl+MuibR3CkSAw3AQW2ML4qYaMbvGnkTh2Tx0+pHY6IH/FjGLf4WC0E9BURTBbP0h+Y97RDGa+HtSPPGNgsZ/M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38070700005)(86362001)(83380400001)(110136005)(2616005)(8676002)(186003)(26005)(31686004)(2906002)(36756003)(316002)(508600001)(966005)(6486002)(91956017)(31696002)(71200400001)(4326008)(38100700002)(8936002)(53546011)(5660300002)(6506007)(6512007)(66446008)(66946007)(76116006)(66556008)(66476007)(64756008)(122000001)(54906003)(43740500002)(45980500001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?YVlvRTY3MzVuaFJKTWp6T2R3MGxyTVRCM2RIdlk2Mld3dEg2b2x3K1pxaHdP?=
 =?utf-8?B?V1lyYVhjTFFXZmFRT3JFc1FaVkg1YzhRTVNxUS9Pdzhsb0tjQlBhNTNuTTZi?=
 =?utf-8?B?VHZwM3dXWXBSc1cyVXQrdzRJWVhyWFllc2ludkZEWlpodlQzNmlHRzlVRHhL?=
 =?utf-8?B?aUZXOCsvb3RqS2Q4NStkUGlIVHhlTGtQYitRMmgwVFNoVnl3WHoxZ3R4NXBi?=
 =?utf-8?B?V2NPK0pRVnhhY1V2czM4bjdMV0dwM3hFaUU5cDA1T01NajhSTmVUMUdSZlFV?=
 =?utf-8?B?UE9uNkI2V0NvZDZUMldEaSsrV2RxakdtQWtBbCtaL1cyUG1EeGhIMFRQeHoy?=
 =?utf-8?B?S0J1Q2tYZWZYdXluZVNNcEI1Zk5XaEpWQXNYemtiaUZ3KzlJWG4ycjRWKzZu?=
 =?utf-8?B?SHkyUGlDRk5zSzlBMVVCQkpCU0JEZHpYaHV4bWtUQytlam0xd0Jheno3UDNH?=
 =?utf-8?B?TVRnVUlJU1ArYjU3TnpyaWI0cWl4RG1pc3BvSVB6T1c4cVd6YXhnSm5iVG5r?=
 =?utf-8?B?OFFOWDVrMEtuVXJPSDBDWWV5bld1YS85cmhubFVCM1BuQlRqTVJDWWN6c1N2?=
 =?utf-8?B?K0FjQnc3YjFOVG1Cb3l4K1hqRkREWFlpUmJtUzZYU3ZyU2U5UUxFOFpDamdZ?=
 =?utf-8?B?V3AxQXJldmlmWnJDTFRVZGhvMHg5U3FMM3VqNEIvODVacUlCbitMcy9XV0Q3?=
 =?utf-8?B?RkUzNEd5b0tad0lrcG9VMXVuR3RZVGNXVW9zTjUrdFF1K0FBSDF5MVFPREpW?=
 =?utf-8?B?TXoyaHhxbDBPOCtzNmxtUFlaWUxpYk1rRXc3NG81QVQ2ZnhPUHdpKzdYU01m?=
 =?utf-8?B?eUp0b0tNTnFsc29QbHU5V2dHOHBWc01GUWlyeDlnUEQ2VUVJMnAyVVJ3TzBH?=
 =?utf-8?B?NlBtcU1kRHBEZWpnQkhCbnlsNWxmMVRVUEI0citHVHU1QTArUW5lTnZLWHd3?=
 =?utf-8?B?STdNUWg4ODFYRm90cGNTUG5DNjRyckJybkhOSEsreGZVK0hDUk9zK3ppVXR5?=
 =?utf-8?B?akJSYzAxTnY4NE9HNnMvSU9HanprekUvRDc5ZFlxVk5nQ0hKcXBYNCtVYkc4?=
 =?utf-8?B?ZlNzM1FrMGdMM1hyVnRLVkx5QzI3c2k3aVY5ZkdUQUdWZ09BVmN4VWlEc2RS?=
 =?utf-8?B?T1VZRUYxUWkwYVZrSkJsek1YclM5Rm1hWGNjeS9Zc0hqdTFKcnBZVGJTQW1j?=
 =?utf-8?B?OVhsK3p4Y0cvQ1BjQjl6VmtoaTBraG80QjgxTGR2ZDBjSUNPS1BBL1A2RzVU?=
 =?utf-8?B?RVgvY3hGOEJzNm9jaXdxTEg3aUxCKzdSOCtDMjdydFNHWTVhb29nSEhORnRq?=
 =?utf-8?B?QThDSXdqdFdyZ25DekRzZVh3WTZ1dEFjVDZOb1dKYldoOWlqNEpBUDFUUDZs?=
 =?utf-8?B?RXgxRlFiRmpkVVNnTS9nNVVJVjN0YzVWMEJOeE81cnc2dDRwV0FhT25GU1BY?=
 =?utf-8?B?RmNGek1wUU5QbEt1bTJSbTVkb21jK0YvVnNmNnRHcTIzUy9ZdkJoNkNCVWQ4?=
 =?utf-8?B?OHBpY0IzWUtwM3k1V3ZkSUhJZE5BT3hxV3g4anBWaVk2eHBsUy9GcU5TSFh2?=
 =?utf-8?B?UC9jV0ZKS1NsbWZ5NE83MlFqcVdzclptcGRKSVBtSU1rRm5rSmdKU2tmbW55?=
 =?utf-8?B?cjY3TmFFMmgxcHpJYTMvekRHZ01HK3l1bWdJSnpMQk8va0tUcElqc2hLUU1p?=
 =?utf-8?B?TGUvdkNLRTYrZjlxUXM5dUh2M0plcmtGNnZEcG5LUE5PRWdiaEVZZjlIWkk5?=
 =?utf-8?B?eXl3MHl4cGZtY1hGYUZQTjRONUo5K3hwOVVMemV6SHM4aTJGa2k3UGsvTEpL?=
 =?utf-8?B?VVdNWHFuU3lqcjN0b3lhTXh0Ni9xUkFhcHdVS1RLL0ZSeTNIdnZkUlRvNHRz?=
 =?utf-8?B?dGFscEQ3N2FEajQvaDlyU29pKzZ6b3VpcGU4RkFPb1FiNnNMYk53Tmt6U3l6?=
 =?utf-8?B?Q0laMG9CMnd4YWZsZFZ1clZqWFplNUNwTGFmK1VpVmtxbWY2ZFh3UVNZUzdz?=
 =?utf-8?B?QTdHQ2pYSnUvUjdabytIRW1OSUN1bkV1T2NWYUNsZ0FvUzBDYVlXdmlMZ3d2?=
 =?utf-8?B?LzY1dm1lQWRZS1A0Q2hrVUUvbmJENklSeTNQa2x1M1pCdkZQWnVCWi94NTB0?=
 =?utf-8?B?RFFTUXBTc2RnOU1rd2dSNXVkR2VYNFdpOTZ3bnpPSmdOVWUvQUJlbjFKY2pr?=
 =?utf-8?B?WVE9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6A3F3BD5563CD14C9CC75487C575AE8B@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0e5b5570-dc69-41cf-371a-08d9f26f48ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Feb 2022 23:43:22.5217
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MYvcypQ4t/9z9u2/h1KvHAyYdeX2W73R5qiybWu2aqXtHx4RJtciu/PK539/ej/UnOYsVoFyY1+paAYq8oRA/g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4507
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

V2VzbGV5IENoZW5nIHdyb3RlOg0KPiBIaSBUaGluaCwNCj4gDQo+IE9uIDIvMTUvMjAyMiA5OjE0
IEFNLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBKdW5nIERhZWh3YW4gd3JvdGU6DQo+Pj4gSGkg
VGhpbmgsDQo+Pj4NCj4+PiBPbiBNb24sIEZlYiAxNCwgMjAyMiBhdCAwNjo0NDozM1BNICswMDAw
LCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+IEhpLA0KPj4+Pg0KPj4+PiBEYWVod2FuIEp1bmcg
d3JvdGU6DQo+Pj4+PiBJdCBhbHdheXMgc2V0cyBEV0MzX0VQX0VORF9UUkFOU0ZFUl9QRU5ESU5H
IGluIGR3YzNfc3RvcF9hY3RpdmVfdHJhbnNmZXINCj4+Pj4+IGV2ZW4gaWYgZHdjM19zZW5kX2dh
ZGdldF9lcF9jbWQgZmFpbHMuIEl0IGNhbiBjYXVzZSBzb21lIHByb2JsZW1zIGxpa2UNCj4+Pj4N
Cj4+Pj4gSG93IGRvZXMgaXQgZmFpbD8gVGltZWQgb3V0Pw0KPj4+DQo+Pj4gWWVzLCB0aW1lZCBv
dXQuDQo+Pj4+DQo+Pj4+PiBza2lwcGluZyBjbGVhciBzdGFsbCBjb21tbWFuZCBvciBnaXZlYmFj
ayBmcm9tIGRlcXVldWUuIFdlIGZpeCB0byBzZXQgaXQNCj4+Pj4+IG9ubHkgd2hlbiBlcCBjbWQg
c3VjY2Vzcy4gQWRkaXRpb25hbGx5LCBXZSBjbGVhciBEV0MzX0VQX1RSQU5TRkVSX1NUQVJURUQN
Cj4+Pj4+IGZvciBuZXh0IHRyYiB0byBzdGFydCB0cmFuc2ZlciBub3QgdXBkYXRlIHRyYW5zZmVy
Lg0KPj4+Pg0KPj4+PiBXZSBzaG91bGRuJ3QgZG8gdGhpcy4gVGhpbmdzIHdpbGwgYmUgb3V0IG9m
IHN5bmMuIEl0IG1heSB3b3JrIGZvciAxDQo+Pj4+IHNjZW5hcmlvLCBidXQgaXQgd29uJ3Qgd29y
ayBmb3Igb3RoZXJzLg0KPj4+Pg0KPj4+PiBQbGVhc2UgaGVscCBtZSB1bmRlcnN0YW5kIGEgZmV3
IHRoaW5nczoNCj4+Pj4NCj4+Pj4gMSkgV2hhdCBpcyB0aGUgc2NlbmFyaW8gdGhhdCB0cmlnZ2Vy
cyB0aGlzPyBJcyBpdCByYW5kb20/DQo+Pj4+DQo+Pj4gZXAgY21kIHRpbWVvdXQgb2NjdXJzIG9u
IGRlcXVldWUgcmVxdWVzdCBmcm9tIHVzZXIgc2lkZS4gRW5kIFRyYW5zZmVyIGNvbW1hbmQNCj4+
PiB3b3VsZCBiZSBzZW50IGluIGR3YzNfc3RvcF9hY3RpdmUgdHJhbnNmZXIuDQo+Pg0KPj4gQXQg
dGhlIGhpZ2ggbGV2ZWwsIHdoYXQncyB0cmlnZ2VyaW5nIHRoZSByZXF1ZXN0IGRlcXVldWU/IElz
IGl0IGZyb20gYQ0KPj4gZGlzY29ubmVjdCwgY2hhbmdlIG9mIGludGVyZmFjZSwgb3Igc2ltcGx5
IGZ1bmN0aW9uIGRyaXZlciBwcm90b2NvbCB0aGF0DQo+PiBjaGFuZ2VzIGl0Lg0KPj4NCj4+IFdo
YXQgYXBwbGljYXRpb24gd2FzIHVzZWQgdG8gdHJpZ2dlciB0aGlzPw0KPj4NCj4gU29ycnkgZm9y
IGp1bXBpbmcgaW4gaGVyZSwgYnV0IGxvb2tzIGxpa2UgRGFlaHdhbiBpcyBydW5uaW5nIGludG8g
YQ0KPiBzaW1pbGFyIGlzc3VlIEkgYW0gc2VlaW5nIGFzIHdlbGwuDQo+IA0KPiBBdCBsZWFzdCBp
biBteSBzY2VuYXJpbywgdGhlIGRlcXVldWUgaXMgY29taW5nIGZyb20gYSBmdW5jdGlvbiBkcml2
ZXINCj4gd2hpY2ggZXhwb3NlcyBhIGRldmljZSB0byB1c2Vyc3BhY2UuICBPbmNlIHRoYXQgZGV2
aWNlIGlzIGNsb3NlZCwgaXQNCj4gd2lsbCBpc3N1ZSBhIGRlcXVldWUgb24gYWxsIHBlbmRpbmcv
c3VibWl0dGVkIHJlcXVlc3RzLg0KDQpEZXF1ZXVpbmcgcmVxdWVzdCBpcyBjb21pbmcgZnJvbSB0
aGUgZnVuY3Rpb24gZHJpdmVyLCBidXQgd2hhdCBjYXVzZXMNCnRoZSBkZXF1ZXVlLiBGb3IgZXhh
bXBsZSwgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIGR1ZSB0byBhIGRpc2Nvbm5lY3QNCm1heSBn
aXZlIGEgZGlmZmVyZW50IGNsdWVzIHRoYW4gYSBkZXF1ZXVlIGZyb20gYSBjaGFuZ2Ugb2YgaW50
ZXJmYWNlLg0KDQo+IA0KPj4+DQo+Pj4+IDIpIEFyZSB0aGVyZSBvdGhlciB0cmFmZmljcyBwZW5k
aW5nIHdoaWxlIGlzc3VpbmcgdGhlIEVuZCBUcmFuc2Zlcg0KPj4+PiBjb21tYW5kPyBJZiBzbywg
d2hhdCB0cmFuc2ZlciB0eXBlKHMpPw0KPj4+Pg0KPj4+IEkgaGF2ZW4ndCBjaGVja2VkIGl0IHll
dC4gDQo+Pg0KPj4gQ2FuIHlvdSBjaGVjaz8NCj4+DQo+IEZvciB0aGUgY2FzZXMgd2hlcmUgd2Un
dmUgY29sbGVjdGVkIGEgY3Jhc2ggbG9nLCB3ZSBjYW4gc2VlIHRoYXQgZHVyaW5nDQo+IHRoZSBF
TkQgdHJhbnNmZXIgdGltZW91dHMgdGhlcmUgd2FzIGFsd2F5cyBhIHBlbmRpbmcgRVAwIHRyYW5z
YWN0aW9uLg0KPiBXZSBoYWQgcmVhY2hlZCBvdXQgdG8gb3VyIGludGVybmFsIEhXIGZvbGtzIHRv
IGdldCBzb21lIGlucHV0cyBvbiB3aGF0DQo+IGNvdWxkIGJlIGNhdXNpbmcgdGhpcyBraW5kIG9m
IGlzc3VlLCBhbmQgd2Ugd2VyZSBhYmxlIHRvIGdldCBzb21lDQo+IHJlY29tbWVuZGF0aW9ucyBm
cm9tIHRoZWlyIFN5bm9wc2lzIFBPQ3MuDQoNCkl0J3MgIlN5bm9wc3lzIiA6KQ0KDQo+IA0KPiBJ
dCB3YXMgbWVudGlvbmVkIHRoYXQgaWYgdGhlcmUgd2FzIGFuIGFjdGl2ZSBFUDAgdHJhbnNmZXIs
IGFuIGVuZA0KPiB0cmFuc2ZlciBjb21tYW5kIG9uIGEgbm9uLWNvbnRyb2wgRVAgY2FuIGZhaWwg
dy8gdGltZWQgb3V0Lg0KPiANCg0KV2hhdCBjb250cm9sbGVyIHZlcnNpb24gYXJlIHlvdSB1c2lu
Zz8gQW5kIHdoYXQgdmVyc2lvbiBpcyBKdW5nIHVzaW5nPw0KRG8geW91IGhhdmUgdGhlIFNUQVIg
bnVtYmVyIG9mIHRoZSBpc3N1ZS4gSWYgeW91J3JlIHVzaW5nIGEgZGlmZmVyZW50DQp2ZXJzaW9u
IHRoYW4gSnVuZydzLCB0aGVuIGl0IG1heSBub3QgYmUgdGhlIHNhbWUgaXNzdWUuDQoNCj4+Pg0K
Pj4+PiAzKSBIYXZlIHlvdSB0cmllZCBpbmNyZWFzaW5nIHRoZSB0aW1lb3V0Pw0KPj4+Pg0KPj4+
IE5vLCBJIGhhdmVuJ3QuDQo+Pg0KPj4gQ2FuIHlvdSB0cnkgdXAgdG8gMTAgc2Vjb25kcyAoanVz
dCBmb3IgZXhwZXJpbWVudCkNCj4+DQo+IEkndmUgdHJpZWQgdGhpcyB0b28sIGFuZCBpdCBkaWQg
bm90IGhlbHAuDQo+IA0KPj4+PiBCUiwNCj4+Pj4gVGhpbmgNCj4+Pj4NCj4+Pg0KPj4+IFRoaXMg
aXNzdWUgb2NjdXJzIHZlcnkgcmFyZWx5IG9uIGN1c3RvbWVyLiBJIG9ubHkgaGF2ZSByZXN0cmlj
dGVkDQo+Pj4gaW5mb3JtYXRpb24uIFRoYXQncyB3aHkgSSd2ZSBiZWVuIHRyeWluZyB0byByZXBy
b2R1Y2UgaXQuDQo+Pg0KPj4gSG93IGRpZCB5b3UgdGVzdCB5b3VyIGZpeCBpZiB5b3UgY2FuJ3Qg
cmVwcm9kdWNlIGl0Pw0KPj4NCj4+Pg0KPj4+IFdlc2xleSBtYXkgaGF2ZSBydW4gaW50byBzYW1l
IGlzc3VlIGFuZCB5b3UgY2FuIHNlZSB0aGlzIGlzc3VlIGluIGRldGFpbC4NCj4+PiBodHRwczov
L3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wcm90ZWN0Mi5maXJlZXllLmNvbS92MS91cmw/
az05ZDQyM2I2OS1mYzNmZDMyZS05ZDQzYjAyNi03NGZlNDg1ZmZmMzAtNzdhMDk5YjUyNjU5NDEw
ZCZxPTEmZT0yMGI0ZDlmNS0yNTk5LTRmNTctOGI2YS03YzRlYzE2N2QyMjgmdT1odHRwcyozQSoy
RioyRmxvcmUua2VybmVsLm9yZyoyRmxpbnV4LXVzYioyRjIwMjIwMjAzMDgwMDE3LjI3MzM5LTEt
cXVpY193Y2hlbmcqNDBxdWljaW5jLmNvbSoyRl9fO0pTVWxKU1VsSlEhIUE0RjJSOUdfcGchSldQ
ek5Mb08zQkZYX0laQ1Z6bUhQdHhxNmZycl9WRmJTTk5heFNReWx1bnQxWTRFYXVUT2VmdGgyTENJ
Y1ZFdVR4OEUkIA0KPj4+DQo+Pg0KPj4gSSBjYW4gdGFrZSBhIGxvb2ssIGJ1dCBwbGVhc2UgcHJv
dmlkZSB0aGUgdHJhY2Vwb2ludHMgb2YgdGhlIGZhaWx1cmUgaWYNCj4+IHlvdSBjYW4gcmVwcm9k
dWNlIGl0Lg0KPj4NCj4gTGV0IG1lIHNlZSBpZiBJIGhhdmUgYW55IHByZXZpb3VzIHRyYWNlcyBJ
IGNhbiBzaGFyZS4gIElmIG5vdCwgSSBoYXZlIGENCj4gcHJldHR5IHJlbGlhYmxlIHJlcHJvIHNl
dCB1cCBJIGNhbiBjb2xsZWN0IGEgdHJhY2UgZm9yIHlvdS4gIEZvciBub3csIEkNCj4gd2lsbCBm
b2N1cyBvbiBqdXN0IGdldHRpbmcgdGhlIGVuZHhmZXIgdGltZW91dCBzZWVuIGR1cmluZyBlcCBk
ZXF1ZXVlLg0KPiBBcyBtZW50aW9uZWQgb24gbXkgcGF0Y2hzZXQsIHRoaXMgY2FuIGhhcHBlbiBk
dXJpbmcgZGV2aWNlLWluaXRpYXRlZA0KPiBkaXNjb25uZWN0IGFzIHdlbGwuDQo+IA0KDQpZb3Vy
IHBhdGNoIHNldCBpcyBzdGlsbCBvbiBteSB0b2RvIGxpc3QuIEkgaGF2ZW4ndCByZXZpZXdlZCBp
dC4gVGhlcmUncw0Kc29tZSBjb25jZXJuIGxvb2tpbmcgYXQgaXQgZnJvbSBhIGZpcnN0IGdsYW5j
ZSwgSSdsbCBjaGVjayBpdCBvdXQgbW9yZQ0KdGhvcm91Z2hseSBsYXRlci4NCg0KQ2FuIHlvdSBw
cm92aWRlIHRoZSB0cmFjZXBvaW50cz8NCg0KVGhhbmtzLA0KVGhpbmgNCg==
