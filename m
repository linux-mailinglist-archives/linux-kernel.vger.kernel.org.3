Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06AAD53B7A9
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 13:16:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234083AbiFBLQv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 07:16:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbiFBLQs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 07:16:48 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1656197F4E;
        Thu,  2 Jun 2022 04:16:47 -0700 (PDT)
Received: from mailhost.synopsys.com (us03-mailhost1.synopsys.com [10.4.17.17])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id F01CD408EC;
        Thu,  2 Jun 2022 11:16:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1654168606; bh=qEg1bFUEZJX9Icj6ItY9LJfLc1Kv5H+pEV5kHYa2CX8=;
        h=From:To:Subject:Date:References:In-Reply-To:From;
        b=RJhPDXzCQ6fQaEcKmvlIBpQRe+uDGn9s5Jhg/PtqkKugPwZiFMaUEGivqxfCaNIrz
         8drtqK7apIbvPeUjycuLFyb5C42bq6Cy9XY/CKOLGOYIbP2CDjNOQmkhTFSHzTp22v
         G8Wef6pXYUZwNKdkO0rDLtsn4JRpKti87V2BI5wh2M5It4xNwDXuB7bxwJfCu09I7D
         1f+aE7LO7wUItbYqUo6KFYjgitpzCiRnyk5aIosqmcTLItX4IqYeU/4kPIIeETp6yq
         efWhlcJ9Y12HfP03FNQHBAm56zw5oUnfgfkCyFXNEXlLz6NXhhEHtZxPvOyACARgCd
         2EJUSU3CMRyhw==
Received: from o365relay-in.synopsys.com (sv2-o365relay1.synopsys.com [10.202.1.137])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 9A1EAA0077;
        Thu,  2 Jun 2022 11:16:44 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 9358B4002C;
        Thu,  2 Jun 2022 11:16:43 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=hminas@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="iKPffhN/";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jLNLgd1BpYodL+MzPApSzES4tuvVEqi7ZOZ2Q/L7mKntYDNn3z/W+/hu1xYadimt9KlwOUPLMMwrqh8Rba5dOCsxYiOnJC6u+6PKXtdb4b8paxgNA4VpDUIAngMFPakt72NJ2uV7NykmcTC3UM47AgdpvaxRG8w71mZlWk19HcKKH9oAd8trNTBbB15R6GS7aYRXsMTIOa6lICcDTVe5iuWPzCO+ZTrDkRQiy48ai3eIA8N5hB/5JEVBIN9fpskF0oR6JCUNjquxffHY2hDMHOUeW1SoN4bHEhSi7GmKyjjo2pgK+qHLitpwSuJLdoLkfK6QthRzDmNm5zSjh/ZIVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qEg1bFUEZJX9Icj6ItY9LJfLc1Kv5H+pEV5kHYa2CX8=;
 b=MbyvvqulY82tVlmwRymE0ek+CpGbj9RM3PsnOrpy6PZdtcB0teuT/xUR3Dub30fAKsqp66Me2ndWfIZi8dffVdi7F+QexT5z/2TUQ8h/Yr1kZ7QmgVODPkDs8Letv3Q6+IJnBJnpJqWVbiRlUXkmbPE2LiJ4ZDZDHQrpinsC2pOzk20NH9qNhYuSnguPK6v2az683LG1FXpqDj3KhsQyCGnFWPmgV0BU+8MUFZH3GMkg9QbCGKcSiQkHBbkBKBTwkoV/TXIX9Ghq4kNA87Zlu84NT4drGATlOlukwRw8HAakzlZAtgNdDmbFEO1p0LGGd5STsG6zn2o+yk04X3gqgw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qEg1bFUEZJX9Icj6ItY9LJfLc1Kv5H+pEV5kHYa2CX8=;
 b=iKPffhN/Pg4C2B2OdlgtSuRHdC3bcrHCKtVVfkOx5HidyI1oKLcb/H/4Ue2KFDhA2iofa56ldrMBqI9lOuzey0xlDlqZ4qres7pXi9qhsAYdFxb680cRUkG93VZV4I0nmVRgT3/iOJUnf6wEU2LDlxYvKzMnSnqPyoU5DF0aoaQ=
Received: from BYAPR12MB3399.namprd12.prod.outlook.com (2603:10b6:a03:ad::22)
 by DM4PR12MB5867.namprd12.prod.outlook.com (2603:10b6:8:66::18) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5314.12; Thu, 2 Jun
 2022 11:16:41 +0000
Received: from BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::d935:48d3:b77b:b291]) by BYAPR12MB3399.namprd12.prod.outlook.com
 ([fe80::d935:48d3:b77b:b291%5]) with mapi id 15.20.5293.017; Thu, 2 Jun 2022
 11:16:41 +0000
X-SNPS-Relay: synopsys.com
From:   Minas Harutyunyan <Minas.Harutyunyan@synopsys.com>
To:     Miaoqian Lin <linmq006@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Yang Yingliang <yangyingliang@huawei.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] usb: dwc2: Fix memory leak in dwc2_hcd_init
Thread-Topic: [PATCH] usb: dwc2: Fix memory leak in dwc2_hcd_init
Thread-Index: AQHYdALfERITYwuZX0SXRQsR/8hyCK07/G4A
Date:   Thu, 2 Jun 2022 11:16:41 +0000
Message-ID: <18dfb131-5d9a-2e8b-2f41-c98889d7edae@synopsys.com>
References: <20220530085413.44068-1-linmq006@gmail.com>
In-Reply-To: <20220530085413.44068-1-linmq006@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e2a4f671-4ca1-4da2-f16b-08da44895e68
x-ms-traffictypediagnostic: DM4PR12MB5867:EE_
x-microsoft-antispam-prvs: <DM4PR12MB58671171DB2BC114A4AD3758A7DE9@DM4PR12MB5867.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: qxqggxhyMwYMPDXe6D9Jluwts1bHx77gnNUa09tJOZ6BnsRv7TO/fEAGeqKEfLcFWrlA3S3oWVNpLF1BjNfsK0la4BpAnLIR3PKZCzWVDFzFv8UAd1F9ZvXFewCBZpEAcgO68ZxSsoEUbCdOjD7x6Bm+HERbsPAX7lNcNUzfg4V87YJh8cc6o85wfOPXiI+VxkVlWl31ffvHF1PcjZaold9oYG4NqXBqPLNBix+fhkJnlJYn+1dDUrGaPJ8YGW1axvWD478HfI24SqVDi8+lnmItLpwRgzpS251A3bqh0SpsZBzCbTNfzThFUXLtLXDmDeuFbR3NHopMgdWZGKospqU8tOMLBWg9yU+7FUxQGsGfZVYtWZUj9SP4kGlnHfecZvwRQ67HQkxxEo3wCVdve6kYzzeeeYjtFBSotEaY8S1zdR1g9WS6mspO7wnqwuzIRTvrnP8k/TkPpIoM6uvPVYJaSBmhvd/mfeaCVWZCqJBKs5k5xlxbn/vlfpaedLSacvtsOlnkcNpGV8KbwnXwdliFqT2lRxdIDe8b0ae7i2MgmvcDwsC/vC6cowhMPvT5tPPKbvvQrygXYF3lXFbBBBkR4pQWc433+i1jpSYXi0TMDSAZB1tjILd/Zid3xW34YuKTZbL79wyBXWSjvTK5nbpDkzddcBiJThTzviCzoeAKFbYaP3rWNATtwB6OdqTLrpMEMzWvBfDt56SnHLpb6+CkqDtl7bRYt3jrdnRRa9qfcQd8w7YNsP8vPNMXXOCsy3WSrt7RKxKSam8D+w8F9A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3399.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(36756003)(53546011)(76116006)(66476007)(66556008)(5660300002)(66946007)(66446008)(64756008)(26005)(110136005)(8676002)(71200400001)(122000001)(31696002)(6486002)(38070700005)(6506007)(86362001)(6512007)(508600001)(8936002)(2906002)(83380400001)(316002)(91956017)(38100700002)(31686004)(2616005)(4744005)(186003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eDhnbndFNnVSUHdHd1M2eG10ZWVUekdnRDU4SWVzVmxrRlNDb25jRnlkQmVE?=
 =?utf-8?B?b3gwSm5WL0cyQ0JldWp3Wjd5T0l3OVAvWGw4dm5qdzFCU001Wk1ZU05icXRm?=
 =?utf-8?B?Z2tXbFBEV0tPMFhuUVYyWmRzRzQyaVF5YmNnbjdIdng4R3JkY2F2bm5MNUJt?=
 =?utf-8?B?QWJENDl6VlNCS0JQSkNSb0o3a1pUNnZ3Rk03UW1DdWpVZWVQaW95a3BZTC9o?=
 =?utf-8?B?OHc0SFcrL2NFUldaenJUUmc3S0QwTDRSclYxd1pBcXc1TldUeFQyNkNETSs4?=
 =?utf-8?B?dkhqU3FkazdjMm9vNmJMOW9mS3I4bGt2UFg3dnMzbVU1Z3RHclZ3OFVmMldJ?=
 =?utf-8?B?SlZjQTFOZ21iT1pra25zK0tRYjNQUGM4Z1R2TURXS3JFUUlmMWVzRDhhK2Rr?=
 =?utf-8?B?UW01UHJ1ZDN4SHRMM3FYK3JLa3ZYRFlhc0p6MmZ4Q21pRDd0bEZRT0tLL3cv?=
 =?utf-8?B?dEJ3RTB6bGl0eTFDc2FzQW1mQjZmR25ab2ozWlNmSyt5dkFCTG1RaG03MHRh?=
 =?utf-8?B?YXQxQXJXbzllVkZMbTE0QndFUGRiOGhqb01KUk9wREd6cndFWlZqSkFOZVZW?=
 =?utf-8?B?OHRyM1d5WHpzbGlBbmRSRE1vK09ud2FUbTZhQk56R3R2NGJYUytpK2dUM1VS?=
 =?utf-8?B?angrNHIwMm5nSmhZWW1wWlFUZk1uOVZLM3cwT1VJMHIxZ1JvRWRwL2ZUa3M5?=
 =?utf-8?B?V1BQQWRjUytCRmRLTE1reHZCL3Bmb2t0SlFOWGJYOE9NVnk0ODZVVEFLV0Y4?=
 =?utf-8?B?dTRtMDdldXQrclVIUVIvQUsxREZrN0lOODd1UExHSENiWlRvNVlyVWYvUnRy?=
 =?utf-8?B?N1dWWURQaVhnVnB5QXlGZHdldjYyWDN6UEhrenVyQkI5eGdONmZZT2pvYWlu?=
 =?utf-8?B?dkF1cEhRU2FuMGxTbi82MnBvMWs4UkVqZFcyWG85ZmpwZlFRYnhGZFI0UGdz?=
 =?utf-8?B?cGZZelpEYzhjVFc0dGxKL1BMT3hRSmswVzVHQmRlQVZxdUgwWnZLWHFKNytu?=
 =?utf-8?B?cmtKRTlwWWlFS2dNeDZiODdMdG45ZXJGb1dsckFIeUdDZVZTa1FpeDdFdURL?=
 =?utf-8?B?dnBia0dzNThKb08vTGlqWUJQV2lBMXRGUkpyU3RhR3hXZHpqR3dBVFpJMEJ4?=
 =?utf-8?B?SDRCd1E0YVJTTm9WYlVBR2Z5SytlZHBncHFPamJvRXVYTVRTelkxTkdhaDlO?=
 =?utf-8?B?WlR4Zk9KalUzRUhFZ1lHQm1XRldPNHZyV1dyeFRERDdQR2NNMnVMY1pYZndZ?=
 =?utf-8?B?WnBhQmJnTmVvWDhHYkM0SlE2M1c3dmo5ZmdlV3JFcDNyQkFzRzBMUGdYWStS?=
 =?utf-8?B?SWU0RDNTOS90OTZMbkFqUWxDNnl2K0loK2dSdkRJc0FIVDBYTTRKMXBFUDYr?=
 =?utf-8?B?dWdrd2ZqeWZhS1ZqMTM2M1pLUFI5S2F2N2R1d29WbElEdlpiYm80TFNSMlFv?=
 =?utf-8?B?T3pwWml5MEl3REh0OXNZMytQUE5tNkRuZmh0YUlGTFV3QWU4YkJTU3l6R3lS?=
 =?utf-8?B?N09haFdjc0EyOERtM3JMMkZwV0ptOFZZS0tBc1JpTTlZVTRKTjZ0WHNsL1c1?=
 =?utf-8?B?cXRwYUVhZlhvdzNjR2p0cGJ1emJpMVUrU000VXROYjRhVFVucytLalJlTFQ3?=
 =?utf-8?B?RFNrb2NRUWVCVTVIT3praE53ZFAyT3dPTDMxaG9kSVEyNENaRDBTdzdoTDEz?=
 =?utf-8?B?UDhpSzNnYzBBSCtIdU14c3gwZlU3T0MvYTdQZXZEd3k2Zm85Q1RrWXo3eVBx?=
 =?utf-8?B?UzdLckxSaFlRWWl3NS9rZjg4MzhDMVR1aElMUEM1a0xjVmFrbHF2b2pzclkx?=
 =?utf-8?B?ajhCdVZHZ0RtdGF5Q0xKUHpyR0FmRW5BS0FSbWlJQVlmR251bm9heW1XWC9G?=
 =?utf-8?B?b0lMdUdtSWxSVWI1N1FmOStjcE9EQzRTRHdKVVpEZXJQSWhUN3h4ZHpzaVhT?=
 =?utf-8?B?UmFPK2V3ckFxYW9yZHlUeDZTcDVJS2tFOWtnaEwvZ2dGcVNhZGw2YlRSTzZt?=
 =?utf-8?B?S1dOUnB2V3VESVVRdnVVMzhTSHA1SzFmQisxRjdDNU15aFk5TnpxT0xteFhD?=
 =?utf-8?B?UDcwbkpKQ1dtUHZoTmNTM0dIUXpLRW5NYlZEVm1RTGhJZitraTBOaGlLWTJ4?=
 =?utf-8?B?L0pPTVI5K3ptUkdVTjMwUFV1R3Z2VVpQUVBvMVZEa3ROZTFpd1FHQkk4cE01?=
 =?utf-8?B?V2JvTEZvNUZnR0dVNFpIYlhXRXRRYkpvVTNNdCs5OFlSVXJzTmZZL0lydjJZ?=
 =?utf-8?B?M0xlYnMxTTBBcVdWZEkvc0dVNlZFNWE3MlRidXJNYWtXSU5nS2l6SzVJQldK?=
 =?utf-8?Q?zTco7BzESBJMP7AhDX?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2E492B88167E3B4EAFC1C1EC19DCD8C9@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3399.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e2a4f671-4ca1-4da2-f16b-08da44895e68
X-MS-Exchange-CrossTenant-originalarrivaltime: 02 Jun 2022 11:16:41.1178
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: WGh2Dtxti1tE1yMtlL6ltJU4cDw01vxcLn5Y1TfeX1Yr5LC5amXHOvl+IEdXk1X0fI/oKzpTnejTDD8234fWJQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5867
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gNS8zMC8yMDIyIDEyOjU0IFBNLCBNaWFvcWlhbiBMaW4gd3JvdGU6DQo+IHVzYl9jcmVhdGVf
aGNkIHdpbGwgYWxsb2MgbWVtb3J5IGZvciBoY2QsIGFuZCB3ZSBzaG91bGQNCj4gY2FsbCB1c2Jf
cHV0X2hjZCB0byBmcmVlIGl0IHdoZW4gcGxhdGZvcm1fZ2V0X3Jlc291cmNlKCkNCj4gZmFpbHMg
dG8gcHJldmVudCBtZW1vcnkgbGVhay4NCj4gZ290byBlcnJvcjIgbGFiZWwgaW5zdGVhZCBlcnJv
cjEgdG8gZml4IHRoaXMuDQo+IA0KPiBGaXhlczogODU2ZTZlOGUwZjkzICgidXNiOiBkd2MyOiBj
aGVjayByZXR1cm4gdmFsdWUgYWZ0ZXIgY2FsbGluZw0KPiBwbGF0Zm9ybV9nZXRfcmVzb3VyY2Uo
KSIpDQo+IFNpZ25lZC1vZmYtYnk6IE1pYW9xaWFuIExpbiA8bGlubXEwMDZAZ21haWwuY29tPg0K
DQpBY2tlZC1ieTogTWluYXMgSGFydXR5dW55YW4gPGhtaW5hc0BzeW5vcHN5cy5jb20+DQoNCj4g
LS0tDQo+ICAgZHJpdmVycy91c2IvZHdjMi9oY2QuYyB8IDIgKy0NCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3VzYi9kd2MyL2hjZC5jIGIvZHJpdmVycy91c2IvZHdjMi9oY2QuYw0KPiBpbmRleCBmNjNh
MjdkMTFmYWMuLjNmMTA3YTA2ODE3ZCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy91c2IvZHdjMi9o
Y2QuYw0KPiArKysgYi9kcml2ZXJzL3VzYi9kd2MyL2hjZC5jDQo+IEBAIC01MTkwLDcgKzUxOTAs
NyBAQCBpbnQgZHdjMl9oY2RfaW5pdChzdHJ1Y3QgZHdjMl9oc290ZyAqaHNvdGcpDQo+ICAgCXJl
cyA9IHBsYXRmb3JtX2dldF9yZXNvdXJjZShwZGV2LCBJT1JFU09VUkNFX01FTSwgMCk7DQo+ICAg
CWlmICghcmVzKSB7DQo+ICAgCQlyZXR2YWwgPSAtRUlOVkFMOw0KPiAtCQlnb3RvIGVycm9yMTsN
Cj4gKwkJZ290byBlcnJvcjI7DQo+ICAgCX0NCj4gICAJaGNkLT5yc3JjX3N0YXJ0ID0gcmVzLT5z
dGFydDsNCj4gICAJaGNkLT5yc3JjX2xlbiA9IHJlc291cmNlX3NpemUocmVzKTsNCg0K
