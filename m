Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E15955004A
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Jun 2022 01:04:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382838AbiFQXEt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Jun 2022 19:04:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382658AbiFQXEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jun 2022 19:04:47 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0E6A53E1A;
        Fri, 17 Jun 2022 16:04:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1655507084; x=1687043084;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=o9mkfflOpAC4FdDkXAHnNb5lMwdmv4i+1O4BhVPG+60=;
  b=Ll6OLllD18lrYxcGSibvM+ynrS9DeGit37pB0Er866+/dWBPiefVb1W/
   sBFTQDana1YBVkmD2yWkke9RRk8B7WaUQ0RxxDmTRCRansBFf4wGKeVCV
   mnqSoGJudnpRFOeYcuqA39D5MfK7PehvPHj97rBG+a8hIUulSYFmpYKyK
   Njy4ojMt3eVihWhLRHtiX+7TWCqSDNS22SnIQU+oi5zjnQY83nhR/No1U
   8YRgC0M41TSl50Tac9gK4rTrMiciH2CCBGiGntq/CjAXejWeZx0kIBsmv
   Nx28BjlIgDunOs7OJEVCFR1AE2Mn0MvHbxEMTVpOuFd8AdWhPuQRiTGVH
   A==;
X-IronPort-AV: E=Sophos;i="5.92,306,1650956400"; 
   d="scan'208";a="100604578"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa6.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 17 Jun 2022 16:04:43 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 17 Jun 2022 16:04:43 -0700
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.151) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Fri, 17 Jun 2022 16:04:43 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=MfhNyQZoIOtNn1Gg0S47UNV9YiwBXHBIsJB59zj0nCkFa8BolnSLhhZf8maHifSAHj0oc4VtBCcZ9xoCi1hCPeCC1wXCKYLEKG7lNPdD5r6HuXvi8VLmE0oIxgOr26bjhMDdzMJakE5s73STDu9wBI0BfvyzLnwMG7C75uvSeOoJ+U6RBiWHxG/06q/84oSPnj3rRQZVnLi6+Xzrc1q7is5T5H0sPAnUFF4KaIc4n+fRDTNj5sN5S7MSpzqzxockbM2SXZD7rj6DihdlWzCvQ1JTAyPioeEXLI7C2LGkTj6UaiMEYNE3nrbkSpywvMUOcfzRXUqeHdQ5HBN2gMugoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=o9mkfflOpAC4FdDkXAHnNb5lMwdmv4i+1O4BhVPG+60=;
 b=HeMsYM0ZWFOHrV1C9DdAoUzBv9qnTOLTvf45S+7Cc3Yf5lBHexS3+GjgVLvvgexHleydk5G33QoS8BTHQ//3YI/Ns5aON1WyzByVAX0pw/DVTcqCpyvXk7utQqdernZ1Dq3VcNHUDc9o+D5lK108Ii0K5wQa3DZP6UbgW4Va+EuCfGCYVxX51Qw0DomkJ8yYMcLHhmEcN1yTVbM+tYtfNhPF+nnOdt1kCxez+8V63UWDaC87Td3a9/7CdKrdweFYdkFs/QL/hLkc/Wv458qYSyLmyi2naYvWzjVEvKnvl8MkvdtmVNBwVLRJuCuBBmEQq7eAL8l8iYB4jdKsBaS6KQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o9mkfflOpAC4FdDkXAHnNb5lMwdmv4i+1O4BhVPG+60=;
 b=XKfHAVJmh1kZ2XPgNcJ/cz+vJw2Y1rEE5/sXpbpGfjG1VWhBJZt1qgKngL6nhhbLFtedVYhPD7txOcRT1KVIMg83/dVYwKLgDxYVwbuhRf84TosiheHTZEKGE5ZEJtDrIDGwffyEb8J6VO15UgDTK9PkjJDB4SYCg0QF/jm+aU0=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by DM6PR11MB4234.namprd11.prod.outlook.com (2603:10b6:5:1dc::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.16; Fri, 17 Jun
 2022 23:04:38 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5332.022; Fri, 17 Jun 2022
 23:04:38 +0000
From:   <Conor.Dooley@microchip.com>
To:     <krzysztof.kozlowski@linaro.org>,
        <Kavyasree.Kotagiri@microchip.com>, <robh+dt@kernel.org>,
        <Nicolas.Ferre@microchip.com>, <Claudiu.Beznea@microchip.com>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <UNGLinuxDriver@microchip.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Topic: [PATCH v4 1/3] dt-bindings: mfd: atmel,flexcom: Convert to
 json-schema
Thread-Index: AQHYgp6eJKcUiKA530uCO9WSfVRv+g==
Date:   Fri, 17 Jun 2022 23:04:38 +0000
Message-ID: <5f679b6c-9561-1b41-d2bb-ec3d0155d2a3@microchip.com>
References: <20220617130729.12072-1-kavyasree.kotagiri@microchip.com>
 <20220617130729.12072-2-kavyasree.kotagiri@microchip.com>
 <1a7fc699-6381-f2db-178f-169bc1ebf064@linaro.org>
In-Reply-To: <1a7fc699-6381-f2db-178f-169bc1ebf064@linaro.org>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d057117f-635e-45e3-6a6d-08da50b5c0ee
x-ms-traffictypediagnostic: DM6PR11MB4234:EE_
x-microsoft-antispam-prvs: <DM6PR11MB4234DF9111DCB9A4E121274298AF9@DM6PR11MB4234.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuhy8ZTKdej0aeuOXNOHnJoPiKNrpIjA4lucLV5UmbtR2VKxgPzlwZaEIgOTL1VdPZ5TTJ8xaOVJSLx20FRcAxVXQu0N6+OLpIUeaLdnxSJ9xs+4ob5OQbJ/KwWJ5r4eO7k/X62pN4T/gt/I795iBzaRa1cab5pkAQtqqcrP+BFPOkSYtpSCuNDj4fyx0yZ4O/9GIPm2dES6Xw/fhPXIhebSsFTiesdjYtguh8W2zJoW+KcHBF0NXLnOd6QmQQGVfBXpepuv0ij+OkfCaf2FVkG1Q22PhzOyAOJp1gxekEo5fO3whgjclVVKZfHeV9ECNaNX0+TVxdfAIuNA2P0ZChz2YPyJo5BrOZotWnVCOhoxvvSAOPLC/YZ95DH3dWB0FBJRWaZN+vJuplWctBu3E/dlZ8JBZfKmXh2m+TR2G1q8VvgqtmkMrM/F0buhMuQBoc5Fmqg4HKG12t9acgfuaRNOa+hXCXXXbRxPKyu4TgDd7Qf81TY44W5jsFWarcJc7mWFuywzjcbHi0p7mwP0BQCYdYmKFwCsWUrkv2iGGUNp6XMBossLqVmiX4PtpKiID8+lVn5Ou2/0rbnZtAu97fsEEU2rDvegP+rQh3VgpAQX9c17zBLIriNmtubWLLjdX+5OEI16nrtBMA8qtHlTMs6sYC0upLfEZqOBOUA6LkBZLFZgsr2tq5/jUuF2xGoMtLEfqdxrhWVGpeeTofINzvqka7d3MC+Mnm+U3ChNmlxs8SXMbPu5lOuX8oAYSL8DwBz6HPrSj26ie9FtJxvegM1aUh+kea0abKg+PkrE7p3KA6Jh5wslJtePZrUVWDdZ8POuZrhcbzN+EAWjVa/R0FVleH0l1sOzSQm0C5v6ojp+3Jo+jDKqk0meg0t8rsYbj/ofPdo9EZBKqDvYsCj/ow==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(366004)(122000001)(8676002)(91956017)(26005)(66446008)(498600001)(6486002)(6512007)(186003)(66946007)(38070700005)(2906002)(966005)(66476007)(4326008)(71200400001)(2616005)(64756008)(8936002)(86362001)(66556008)(110136005)(53546011)(6506007)(31696002)(83380400001)(31686004)(5660300002)(38100700002)(76116006)(316002)(36756003)(54906003)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?SUx1QUJSaTYxU0UvM1FmWDk0SUpGSFNpMjZjRXRUdXQ5bW95YjhiUkh3U0N2?=
 =?utf-8?B?eGx2TVovb05CNFlEb3NndWFlYjBjSVBkR1pYdmQxVFlua2lpcEVJQjlUNHh2?=
 =?utf-8?B?RjdrTnZXMnk1S3NtTWpzYTlxZnlwLzU2QUZJTzRuazRYNVpwMk10dmJ1RXRx?=
 =?utf-8?B?UldDUjU3WWRYbS9QWUQ2NnFZdVg1dHk1NURSUXJSQkNJaHBGNXBZYzY2ckZZ?=
 =?utf-8?B?Y3U2U2lzUjVRMVVmWFZjcGpzZ3JPU2dKMHlyM3RvL3BkZFVucjE0QUZjM2Ro?=
 =?utf-8?B?c1o3ZlVNS2g2c0R5aVVkRzM3ZkVNWGlzcjFYaFJ6NVdMcjNScm91MG5JRXZr?=
 =?utf-8?B?STYrTVp5U0VtM1czTGtjQ0Fhd0U4MElGcXZ2TGhCTkEyZW9Wa2pLRDJuTEpT?=
 =?utf-8?B?S2xhbVl1UEhUMEZBYnEvOGRrYnRTcjRBUWprcjNMZGZ1RmY3RTJtM0RTZjAx?=
 =?utf-8?B?UktmZUF6OUZPMHNLR2lNRDRNbXVVQllQMCtlMGVFNHpNWnNqamNsdGpIbjZM?=
 =?utf-8?B?YXAwZEk1WlpmM09kbFJGS0t1T0p3NGV4U25YL2Fhalgwa1EyUkJJamdNZ2R4?=
 =?utf-8?B?c3BESlhwWjB6VkZ4dDREeko5Y1pGSHpYN094b2ZudWhzTytkRHNJZUcyaFlj?=
 =?utf-8?B?ZWwrYlZmdFYxcFdmQ0VkT1RIcEFHQW5lK3Bwa1JHZWtmVjhPcEZtcTYxY0R4?=
 =?utf-8?B?WDBBRWVMaElBSTZPeks0RnBZemNiNy95YVU3UUNqLyt2Z2tJVWJrNEsvZElY?=
 =?utf-8?B?NFhEYjlvUi9ZNXJEcWdocFVDc3VIUEJmVnRQVitNblZIaFFtM2NDc0tnQ2pU?=
 =?utf-8?B?TzV3Tk5LMmIzakpMWVVHZmRKN3M2MEVidVR3OHpYSjNkLyt0WHBVd0hFbmdt?=
 =?utf-8?B?ZkxUREdNQXlNTTcvdlE3Y0dxNFJYOFYxeHlXZHo5WjQ4OWdub3RmRkJCVFdP?=
 =?utf-8?B?b3dhSXlyQWwzdDFrS2RsUXRzQUlNNUdhRzJ5eWNtOHlRd3k3L3FDckxJWFd5?=
 =?utf-8?B?VjI3NFBERXZLekJjSWR5TVFySml5TmhqTG5GS2J6WGV6VHZOcE5pUmRYSUtB?=
 =?utf-8?B?eFBmYUJ1UzVVVm9hY1ZUV0NhVUZaTXd5aVNyM1pFdDBhbDh0RWlQK0lEbkJ3?=
 =?utf-8?B?aUtvN1REWVVPdWpRTUNHc0g5ajJBeDhrUG8zekZyaDlSTzZNZEdkUGNwVGVx?=
 =?utf-8?B?cHV2dlc3NHpxWE9zc1MwcmJpRzA2WDB4TzAxQmorTERrQlZNZUlOejlYd2dQ?=
 =?utf-8?B?Z3lnNjdpaVk1OVRPTTFoMUhlR3NWNHlpSWtQZFNBNTNEK2hNUHE5aDlYWjRF?=
 =?utf-8?B?azV5WGFuRS8zT3NUYVdLcHk5eENRU2x5ekRSQUsyREo4V2Q4Zmg2bHQ0cWdo?=
 =?utf-8?B?TkhvZ2JQUFNRK1RLZkFhSEx0UFE4S1Qydkl6WThLRVQ5YktNMmk5Znk2QW5B?=
 =?utf-8?B?RTVlWktUM2RUVjJTZWZNcWNnTm1ZMjBmdk5Td00zOGNvN1pPZnJRd2RjMVNF?=
 =?utf-8?B?YW13elE3aHNzdVdLVXdaYUtSVmE1dUR5WUNweko0dEt4SnlSZExqdk03MjdU?=
 =?utf-8?B?eG9QSEhjWVRkb2FheTM3OG9OWG5UTU4vZDdISTFWQlI0ekxBSUhGb2RtK3d2?=
 =?utf-8?B?Vk01dkFQaEIzclNjY0paaWcveTZqSmpJMFBoNlFnZEdzalFNTGRjU2dEamVm?=
 =?utf-8?B?bnRyRnp5dFhIRWRYWUdUWFhxQU9yZnkrRTdTalVzOEpHbDE4cy83WG4zSU1O?=
 =?utf-8?B?NEQ4QkNHbGVkZndhUm0rNGRaelF3cVQ3WjNLS3lDZVZLU3pTTUpUQmNkR0Vy?=
 =?utf-8?B?bndFSk5FV0YwT3lEOFlRSk9yczJwbmdRaWdyeER4TDdRM0N0eFhQV3RGNTdH?=
 =?utf-8?B?YUR5RHgxUHF4VHk3Wmh1Z1cxbDNRSVEvMnVvemFSZ1VXMEM4eXVnejNLdW9u?=
 =?utf-8?B?QTVnaFREbEMxaXRSeFZ6cEFFRnZjWlNJaUVpby9MUEMvSGhBVnY1MWU0c0Rh?=
 =?utf-8?B?R3dlU1JzdFNkZ1F4ZllZamsvdFljc09WZFhrempYQjJpYkJaKzBIakxXRlE1?=
 =?utf-8?B?TU1CQXJGTHFJVU1ERTE2NDZtNkIyZTB5MWFXTWRTS0RIelE2dVMyanY4Z293?=
 =?utf-8?B?RmYzRGU3UnZrN2s0VVRXd3VhejJ6OEloNmtYOGpzbEtMYzd5dzFLQlQ1RHhJ?=
 =?utf-8?B?blczSXc3YkVjRjdQT2JEWVlSNjNBSXlqd3dheDJkTEV2UGRRWDZLY3JhKyty?=
 =?utf-8?B?dFJpSXJiMFlFUnU4Uzk3Wmc3dFNiUDdYdkVGQTlmZ0hBR0w5V1VCRzFlanlH?=
 =?utf-8?B?VXlvMGZkU3kxeVlscG5xTEdMaXhEREI2ajVRL2F4d3NRMUVwUmtwZUJIMnhy?=
 =?utf-8?Q?E6N9t/BZM2s0kt3Y=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <AA310E93E1565E488F7B139FC468066D@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d057117f-635e-45e3-6a6d-08da50b5c0ee
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2022 23:04:38.2343
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: t5hB82vurb9V4E9c8fp2IsIBOIS4X1dx+S3CsFnWNYpC6TPdwgUsHbc+ouW9AUYsncFCfusUw5K0FPhLTeYBHi9BUkjK+g5Or3m5/VIeTgo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4234
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

DQoNCk9uIDE4LzA2LzIwMjIgMDA6MDAsIEtyenlzenRvZiBLb3psb3dza2kgd3JvdGU6DQo+IE9u
IDE3LzA2LzIwMjIgMDY6MDcsIEthdnlhc3JlZSBLb3RhZ2lyaSB3cm90ZToNCj4+IENvbnZlcnQg
dGhlIEF0bWVsIGZsZXhjb20gZGV2aWNlIHRyZWUgYmluZGluZ3MgdG8ganNvbiBzY2hlbWEuDQo+
Pg0KPj4gU2lnbmVkLW9mZi1ieTogS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdp
cmlAbWljcm9jaGlwLmNvbT4NCj4+IC0tLQ0KPj4gdjMgLT4gdjQ6DQo+PiAgLSBDb3JyZWN0ZWQg
Zm9ybWF0IG9mIGVudW0gdXNlZCBmb3IgY29tcGF0aWJsZSBzdHJpbmcuDQo+Pg0KPj4gdjIgLT4g
djM6DQo+PiAgLSB1c2VkIGVudW0gZm9yIGNvbXBhdGlibGUgc3RyaW5nLg0KPj4gIC0gY2hhbmdl
ZCBpcnEgZmxhZyB0byBJUlFfVFlQRV9MRVZFTF9ISUdIIGluIGV4YW1wbGUuDQo+PiAgLSBmaXhl
ZCBkdHNjaGVtYSBlcnJvcnMuDQo+Pg0KPj4gdjEgLT4gdjI6DQo+PiAgLSBGaXggdGl0bGUuDQo+
Pg0KPj4gIC4uLi9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sICAgICAgICAgICB8IDEw
NCArKysrKysrKysrKysrKysrKysNCj4+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRt
ZWwtZmxleGNvbS50eHQgfCAgNjMgLS0tLS0tLS0tLS0NCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDEw
NCBpbnNlcnRpb25zKCspLCA2MyBkZWxldGlvbnMoLSkNCj4+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
RG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL21mZC9hdG1lbCxmbGV4Y29tLnlhbWwN
Cj4+ICBkZWxldGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdz
L21mZC9hdG1lbC1mbGV4Y29tLnR4dA0KPj4NCj4+IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9u
L2RldmljZXRyZWUvYmluZGluZ3MvbWZkL2F0bWVsLGZsZXhjb20ueWFtbCBiL0RvY3VtZW50YXRp
b24vZGV2aWNldHJlZS9iaW5kaW5ncy9tZmQvYXRtZWwsZmxleGNvbS55YW1sDQo+PiBuZXcgZmls
ZSBtb2RlIDEwMDY0NA0KPj4gaW5kZXggMDAwMDAwMDAwMDAwLi5mZGIxNjQ1ZDEyM2YNCj4+IC0t
LSAvZGV2L251bGwNCj4+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9t
ZmQvYXRtZWwsZmxleGNvbS55YW1sDQo+PiBAQCAtMCwwICsxLDEwNCBAQA0KPj4gKyMgU1BEWC1M
aWNlbnNlLUlkZW50aWZpZXI6IChHUEwtMi4wLW9ubHkgT1IgQlNELTItQ2xhdXNlKQ0KPj4gKyVZ
QU1MIDEuMg0KPj4gKy0tLQ0KPj4gKyRpZDogaHR0cDovL2RldmljZXRyZWUub3JnL3NjaGVtYXMv
bWZkL2F0bWVsLGZsZXhjb20ueWFtbCMNCj4+ICskc2NoZW1hOiBodHRwOi8vZGV2aWNldHJlZS5v
cmcvbWV0YS1zY2hlbWFzL2NvcmUueWFtbCMNCj4+ICsNCj4+ICt0aXRsZTogQXRtZWwgRmxleGNv
bSAoRmxleGlibGUgU2VyaWFsIENvbW11bmljYXRpb24gVW5pdCkNCj4+ICsNCj4+ICttYWludGFp
bmVyczoNCj4+ICsgIC0gS2F2eWFzcmVlIEtvdGFnaXJpIDxrYXZ5YXNyZWUua290YWdpcmlAbWlj
cm9jaGlwLmNvbT4NCj4+ICsNCj4+ICtkZXNjcmlwdGlvbjoNCj4+ICsgIFRoZSBBdG1lbCBGbGV4
Y29tIGlzIGp1c3QgYSB3cmFwcGVyIHdoaWNoIGVtYmVkcyBhIFNQSSBjb250cm9sbGVyLA0KPj4g
KyAgYW4gSTJDIGNvbnRyb2xsZXIgYW5kIGFuIFVTQVJULiBPbmx5IG9uZSBmdW5jdGlvbiBjYW4g
YmUgdXNlZCBhdCBhDQo+PiArICB0aW1lIGFuZCBpcyBjaG9zZW4gYXQgYm9vdCB0aW1lIGFjY29y
ZGluZyB0byB0aGUgZGV2aWNlIHRyZWUuDQo+PiArDQo+PiArcHJvcGVydGllczoNCj4+ICsgIGNv
bXBhdGlibGU6DQo+PiArICAgIGVudW06DQo+PiArICAgICAgLSBhdG1lbCxzYW1hNWQyLWZsZXhj
b20NCj4+ICsNCj4+ICsgIHJlZzoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgIGNs
b2NrczoNCj4+ICsgICAgbWF4SXRlbXM6IDENCj4+ICsNCj4+ICsgICIjYWRkcmVzcy1jZWxscyI6
DQo+PiArICAgIGNvbnN0OiAxDQo+PiArDQo+PiArICAiI3NpemUtY2VsbHMiOg0KPj4gKyAgICBj
b25zdDogMQ0KPj4gKw0KPj4gKyAgcmFuZ2VzOg0KPj4gKyAgICBkZXNjcmlwdGlvbjoNCj4+ICsg
ICAgICBPbmUgcmFuZ2UgZm9yIHRoZSBmdWxsIEkvTyByZWdpc3RlciByZWdpb24uIChpbmNsdWRp
bmcgVVNBUlQsDQo+PiArICAgICAgVFdJIGFuZCBTUEkgcmVnaXN0ZXJzKS4NCj4+ICsgICAgaXRl
bXM6DQo+PiArICAgICAgbWF4SXRlbXM6IDMNCj4+ICsNCj4+ICsgIGF0bWVsLGZsZXhjb20tbW9k
ZToNCj4+ICsgICAgZGVzY3JpcHRpb246IHwNCj4+ICsgICAgICBTcGVjaWZpZXMgdGhlIGZsZXhj
b20gbW9kZSBhcyBmb2xsb3dzOg0KPj4gKyAgICAgIDE6IFVTQVJUDQo+PiArICAgICAgMjogU1BJ
DQo+PiArICAgICAgMzogSTJDLg0KPj4gKyAgICAkcmVmOiAvc2NoZW1hcy90eXBlcy55YW1sIy9k
ZWZpbml0aW9ucy91aW50MzINCj4+ICsgICAgZW51bTogWzEsIDIsIDNdDQo+PiArDQo+PiArcGF0
dGVyblByb3BlcnRpZXM6DQo+PiArICAiXnNlcmlhbEBbMC05YS1mXSskIjoNCj4+ICsgICAgZGVz
Y3JpcHRpb246IFNlZSBhdG1lbC11c2FydC50eHQgZm9yIGRldGFpbHMgb2YgVVNBUlQgYmluZGlu
Z3MuDQo+PiArICAgIHR5cGU6IG9iamVjdA0KPj4gKw0KPj4gKyAgIl5zcGlAWzAtOWEtZl0rJCI6
DQo+PiArICAgIGRlc2NyaXB0aW9uOiBTZWUgLi4vc3BpL3NwaV9hdG1lbC50eHQgZm9yIGRldGFp
bHMgb2YgU1BJIGJpbmRpbmdzLg0KPj4gKyAgICB0eXBlOiBvYmplY3QNCj4+ICsNCj4+ICsgICAg
cHJvcGVydGllczoNCj4+ICsgICAgICBjb21wYXRpYmxlOg0KPj4gKyAgICAgICAgY29uc3Q6IGF0
bWVsLGF0OTFybTkyMDAtc3BpDQo+PiArDQo+PiArICAiXmkyY0BbMC05YS1mXSskIjoNCj4+ICsg
ICAgZGVzY3JpcHRpb246IFNlZSAuLi9pMmMvaTJjLWF0OTEudHh0IGZvciBkZXRhaWxzIG9mIEky
QyBiaW5kaW5ncy4NCj4+ICsgICAgdHlwZTogb2JqZWN0DQo+PiArDQo+PiArcmVxdWlyZWQ6DQo+
PiArICAtIGNvbXBhdGlibGUNCj4+ICsgIC0gcmVnDQo+PiArICAtIGNsb2Nrcw0KPj4gKyAgLSAi
I2FkZHJlc3MtY2VsbHMiDQo+PiArICAtICIjc2l6ZS1jZWxscyINCj4+ICsgIC0gcmFuZ2VzDQo+
PiArICAtIGF0bWVsLGZsZXhjb20tbW9kZQ0KPj4gKw0KPj4gK2FkZGl0aW9uYWxQcm9wZXJ0aWVz
OiBmYWxzZQ0KPj4gKw0KPj4gK2V4YW1wbGVzOg0KPj4gKyAgLSB8DQo+PiArICAgICNpbmNsdWRl
IDxkdC1iaW5kaW5ncy9pbnRlcnJ1cHQtY29udHJvbGxlci9hcm0tZ2ljLmg+DQo+PiArDQo+PiAr
ICAgIGZseDA6IGZsZXhjb21AZjgwMzQwMDAgew0KPj4gKyAgICAgICAgICBjb21wYXRpYmxlID0g
ImF0bWVsLHNhbWE1ZDItZmxleGNvbSI7DQo+IA0KPiBUaGUgYmluZGluZ3MgbG9vayBnb29kLCBi
dXQgeW91IGhhdmUgaGVyZSB3ZWlyZCBpbmRlbnRhdGlvbi4gSSBkb24ndA0KPiByZW1lbWJlciBp
ZiBJIHBvaW50ZWQgb3V0IHRoaXMgYWxyZWFkeSwgc28gaW4gYW55IGNhc2Ugc29ycnkgZm9yDQo+
IGJyaW5naW5nIGl0IHVwIHNvIGxhdGUuIFRoZSBpbmRlbnRhdGlvbiBzaG91bGQgYmUgZm91ciBz
cGFjZXMgd2hpY2gNCj4gbmljZWx5IGFsaWducyB3aXRoICIgLSB8Ii4NCj4gDQo+IA0KPiANCj4+
ICsgICAgICAgICAgcmVnID0gPDB4ZjgwMzQwMDAgMHgyMDA+Ow0KPj4gKyAgICAgICAgICBjbG9j
a3MgPSA8JmZseDBfY2xrPjsNCj4+ICsgICAgICAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
PiArICAgICAgICAgICNzaXplLWNlbGxzID0gPDE+Ow0KPj4gKyAgICAgICAgICByYW5nZXMgPSA8
MHgwIDB4ZjgwMzQwMDAgMHg4MDA+Ow0KPj4gKyAgICAgICAgICBhdG1lbCxmbGV4Y29tLW1vZGUg
PSA8Mj47DQo+PiArDQo+PiArICAgICAgICAgIHNwaTA6IHNwaUA0MDAgew0KPj4gKyAgICAgICAg
ICAgICAgICBjb21wYXRpYmxlID0gImF0bWVsLGF0OTFybTkyMDAtc3BpIjsNCj4gDQo+IDQgc3Bh
Y2VzDQo+IA0KPiBSb2IncyBib3QgYWxzbyBjb21wbGFpbmVkIGFib3V0IGNvbXBhdGlibGUuIEFy
ZSB5b3Ugc3VyZSB5b3UgdXNlIGhlcmUNCj4gY29ycmVjdCBjb21wYXRpYmxlPw0KDQpJdCdzIGlu
IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9zcGkvc3BpX2F0bWVsLnR4dA0KU28g
dGhhdCdsbCBleHBsYWluIHRoZSBlcnJvci4uDQoNClRoYW5rcywNCkNvbm9yLg0KDQpDb25vcg0K
