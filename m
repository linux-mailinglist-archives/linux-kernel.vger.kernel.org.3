Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ACCE560B14
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Jun 2022 22:32:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230144AbiF2Ucm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 16:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbiF2Uck (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 16:32:40 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 180FA313BD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 13:32:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1656534760; x=1688070760;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=cjfgNEtCDYJD3MGhCWFu/vXTTWxDOrGXazf96ioDnjw=;
  b=CacHHcQTt8Clvpl4OeK1dNvOZhJmQawkh9ILEgnhp48W4btr7cnXjRU3
   Mnx8d+VIxwWGnF+B1EllOivINtQBADWGzWK/O3cftB5/VlVjK8u+TxyXx
   7vHg8VFbFQJhWlYHTr0CJ4jEp8GiVyFzOT151sHORDdWQuw93xu2XRuPo
   +MZx9VZii8trWkFxgh+wTA5qx5776FB/88HanToXStPbytJKRuFUmmx1v
   7K92Gy2dL3UoDkTXei/cJ/mTfKySsyAlrWmffNKcgsBV5Exn3x1tNixYD
   kP5eeEoO8F6OvmsPocOo2tPXf7JVDF5BVcIOwYt2eFQeRCK3KIzVeoQmc
   A==;
X-IronPort-AV: E=Sophos;i="5.92,231,1650956400"; 
   d="scan'208";a="170154056"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Jun 2022 13:32:39 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Wed, 29 Jun 2022 13:32:38 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Wed, 29 Jun 2022 13:32:38 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QABhiy+Fdcmx4JcaGVWk9tZ6x8JZ1WKPUU+9KAan/MaqKN6G6Qr6vopydF0/8O+Lf5uxqLr/lVguNs5c5tKe4etwshK9jizlI5xjkA7awHjGr2BaBNT/OiE6cgiVVX88R2NfAhWnBqdDTL2U3Tl3Oa29rwpiuvDjy4s6uV4rdfFQL+FihL6YWDuP3bG3o81hYvqkvAd44CJ6D7sm1sLKNO9s8Ep4DivscHYowoNhSHRbDVNko71hWi/3eYkiwZUq+9zgujRbBZB1PQGm+dpwU+m2NB787XcAWCvKzr+Cer/FthXih89aBYnxXOc1iB233Xqt3Z4zN9wCKl+wJ9Yilg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=cjfgNEtCDYJD3MGhCWFu/vXTTWxDOrGXazf96ioDnjw=;
 b=I4qGG+jWMTPfKvq/EIddPpmX8D0zniuPXmBLjLLvzDKSXk8eaFaWWvJFX6IuQMl/zhr0CVBE9UWsTPp+2a7ZqAmOlUwHZWQmk2M2bRt9cuvQ1iB0XOhtW0hBG/SSNksGalTp0SkAbfc8qEgJou8HlPlHU6DrzMXq55EwLwgi6bVgvM6NLZnD0zqSUJLXJF8n9ta1kNiu29V6ER0dLKJkx38Wo0KrYHDQulwiXOTho0OGEVegwE096wnSbZaC1IiPC4XwnL0oLb5hkFFfuwjRUt4Qlh7EO2oSzlQ5Wk9DdQSNyQhhrt+PT7HIQIyVKbPNMtgEtvKSx+pYZ7AYa7WVgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=cjfgNEtCDYJD3MGhCWFu/vXTTWxDOrGXazf96ioDnjw=;
 b=LLAAn2XZIjjdsZtFg73ABrV9khK2VokpEJBApvxiFFlV+Get5Sdcf1taxatJNIKzf54sIWPIxkUayHN/81hK533BYNDWqOc9BPLJUnaKrrhhWKWMNSc+v8feJj8MyJZ8O7ssB2GJ1x517yGWSVeWyUtCs12L5YmMriLVoPKVmgc=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by CH0PR11MB5380.namprd11.prod.outlook.com (2603:10b6:610:bb::5) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5395.14; Wed, 29 Jun
 2022 20:32:36 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5373.022; Wed, 29 Jun 2022
 20:32:36 +0000
From:   <Conor.Dooley@microchip.com>
To:     <sudeep.holla@arm.com>
CC:     <linux-kernel@vger.kernel.org>, <gregkh@linuxfoundation.org>,
        <atishp@atishpatra.org>, <atishp@rivosinc.com>,
        <vincent.guittot@linaro.org>, <dietmar.eggemann@arm.com>,
        <wangqing@vivo.com>, <robh+dt@kernel.org>, <rafael@kernel.org>,
        <ionela.voinescu@arm.com>, <pierre.gondois@arm.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <gshan@redhat.com>,
        <Valentina.FernandezAlanis@microchip.com>
Subject: Re: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Topic: [PATCH v5 09/19] arch_topology: Use the last level cache
 information from the cacheinfo
Thread-Index: AQHYikaSsliGXUqkU0W62iFZL9A2pK1mrJEAgAAIIICAAAargIAAEAyAgAAEPgCAAAqJAA==
Date:   Wed, 29 Jun 2022 20:32:36 +0000
Message-ID: <03433f57-04ed-44a9-a2f6-5577df94f11e@microchip.com>
References: <20220627165047.336669-1-sudeep.holla@arm.com>
 <20220627165047.336669-10-sudeep.holla@arm.com>
 <bb124e47-f866-e39e-0f76-dc468ce384c6@microchip.com>
 <3656a067-cc3f-fd5b-e339-5925a856cce1@microchip.com>
 <20220629184217.krzt6l7qadymbj6h@bogus>
 <f1f4a30e-7a84-30e2-197c-4153b3e66b64@microchip.com>
 <20220629195454.vbsjvcadmukiunt7@bogus>
In-Reply-To: <20220629195454.vbsjvcadmukiunt7@bogus>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 9a6e2fb9-8d25-45ea-0c4c-08da5a0e8101
x-ms-traffictypediagnostic: CH0PR11MB5380:EE_
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: HM8yOpQuFwoKZCY3YdThIhPgmwmRnFEl/US8lO09i23JoLVZdDpY9oLb+2HYWer/1Mk9B9q773WPi4yRVBFJTCtPIi6LkEaKMXJll/3xjl5g9fu8iYWUPN4rZe9cBdDUbN31qTBlc3H51bFoV1vAViSO/ghQZafGCPreqNnb9STOj/gvv12Ni7/Zc7vNmE2fsLD9GTxTenMB9oeXH6xdz4ZgSG+vfMNPQnxUUHRaYHynpcEiyVr5jBZFUFSyklI3oRjlM772zWRB1eIET9/ZCOhIaPUAM2SFUrqJv8qtJi9r/a3heNZHMoWdutMH1YGoGaBVW7+qS9kAN0BepQ7JxFvcZcAEXbceHPH3uFUv/Im3i9TxuOpYkvH2z2gkzYXaxzLS6RaGzqQKU6l7UiGzcxpSIKEqh8YloA0Uh8xst6E6XvVMcRPUOQA7O5nsiU9kntkZLa31viSQ5maSd0y9TZq1C9bI2mpRU0mtLQJsgILzWnwSX71vP9EJqKmcr8qIu8ZRstsoypBVRIeN2C6EIEd/zHqXVtobeuKMs7js8/fqi9qOwdGnjeDfA5r95oNaD0kUXb71kAC/V/GImpP/Ov8j4ol0pf6g5ekywIaf7ZwllCFnGyl7BuhcW2wIkvvQL1EadQHCvOvEDACiJca7wMetsjMfY5QgcOr+VhyMeHL0CZQ81XUqaRin7mgsZDGkAmTW7S0kUAkJ4xJbHlYL1tmzXPtKZVxg504H2B07s3uA6l7UV13Yu8fnh/RfPYN6nZPGF8TT0J8qxgmz1Vkj8zBBnDE2NvrZSNkEGHv7duRPRcaiRTHFpDGZK2dOgaAU2tV94nBsXsJTLMPY/54BQBWctMzMUNkhy/UyFcLUmZo=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(346002)(376002)(136003)(39860400002)(396003)(366004)(7416002)(71200400001)(31686004)(8936002)(478600001)(122000001)(5660300002)(186003)(83380400001)(2616005)(41300700001)(6506007)(6486002)(38070700005)(2906002)(53546011)(86362001)(31696002)(36756003)(6512007)(26005)(6916009)(54906003)(316002)(8676002)(66556008)(76116006)(64756008)(66446008)(91956017)(107886003)(66946007)(38100700002)(66476007)(4326008)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dklGTzdLUmd6K0tEeG9hL2JoSVVqWFFLKy9pbnpmaU9FN2U0V0x0RlVqUldZ?=
 =?utf-8?B?elJQajVITzB4WEs4K1kvTkFETk4rUEdQWjR5b1NmZUI2bkRnU01JbEVZYklY?=
 =?utf-8?B?TW94aW01SXIvMjBDc09PQldwZnEyMVF3TitkcG1qVzlUcWZRWllDbktPNkRV?=
 =?utf-8?B?VzZDQUFUMkpjWHZpWmdLd0lWTmxIaGVyTFFRK3RmK2lYcGh3OEw2NThhc1c1?=
 =?utf-8?B?NUJqbjhZVUdERUgwNWcwLzd1a2ROOUNlcUc3SThsUlAreDhGdGJPMFRyS3hR?=
 =?utf-8?B?TThRS3NWZG82VjZLNFdyOGthNS9UYSt3YmdvRFBRbVJpaThlKzMxUFI0dmQy?=
 =?utf-8?B?bURiN09QWDdBeEtJcjBEc2dkbkFKemFZbTNoNmNxa3AxWU50cTUrc1NnSDlp?=
 =?utf-8?B?WEh4dWpYRDlIbFhFeVVqTmNLZFZjaEJWaGttOENNNUQzT2hHUUtudUZZY0ZJ?=
 =?utf-8?B?YnFnZXNXT2xRRG9EK0hHYkgwWjcwVW56WVMydkpETm5obzhzZkNBMVBaNEUw?=
 =?utf-8?B?b29TM3o1anJ1ckJuZy9OZUdBOXpzc1BWOUthYkJaRE1CMEF5c0VWakNrTHdK?=
 =?utf-8?B?aU5Hai80RGx6QkN2L3NuS1Yra1JHbDJWdnVmOXhDbVR1T0tYQnpSL3N0cHFt?=
 =?utf-8?B?Zkxza3lVZDYraFEvN0t6L2ZKb2hsZ2R2VkVzZjZENTBLU0NBWUk5TWE3ODM5?=
 =?utf-8?B?eTZsc1NPUXlzQXdmRXVYQXd2VHRDY3VmYWRWNU9YelFWQmhraElVc1I0WklH?=
 =?utf-8?B?WFR6VThISk5pdGFBdkhmRUpkTUp4aHZ1Z1B2aU1DNkpJL0phODFidXRNSE5H?=
 =?utf-8?B?QlVmRmwxMFN1RG9MQ0NEVzV4U1VLMGJWQy9JL2ZzREZlNjd2dERMdmg2enBx?=
 =?utf-8?B?eTBHSFIybUticXovSkRnWUhjbE9tb0RtQUhhMUt2b3dSeWJpS0xkNUgxOXZ0?=
 =?utf-8?B?T29YWUFtQlQ4MzNuenM2bEl1eUZKbUFVRzFJNGlmZ21Pb2p0cm1Ha01MOGpk?=
 =?utf-8?B?dUoxbTh2c0FkTGgyY1VEUUNsVi9mQ0UrMzVFOEZxZjg0WCtSSHpTbGFxWmNo?=
 =?utf-8?B?bVhJZFVLZGRwWTZXMXVxdFlQYVc1Y08wTXJyanBtMnhDVzFTdkl2WE5xS3gw?=
 =?utf-8?B?dGIzU0JOeWpJRG5ReGZqR3ZCbFEzdFpnaU1hdzloazEzNUFNaitjVVllNEFr?=
 =?utf-8?B?VmtySldidFZKS3ZmZ29FbWIvSWNZMkh3NFBYSDFyd3I0NWo4N2VFU3lnSzVY?=
 =?utf-8?B?bTJHeittVnZYYU5KdHJueWZ0djVIQng5OXgzMERPZkt6TUJsTXFqM3hPTU45?=
 =?utf-8?B?eDdtelpMV0ZBeXJER2FJbE5iVEhnMldTRmxPUzdodGR1akdFZlYvZGJOQ2NV?=
 =?utf-8?B?cU5xNDVKWGZXcHBzbFQyaXcrY1o3bjZpN3NFZjlhZ1pNVWtYL3F6d3grT1Bx?=
 =?utf-8?B?cjdjLzVmZXJ6VzBxM2ZIbmNmSzVxTzZHQWU0ckR3bW12OGM2Vzd2T0FWeS9H?=
 =?utf-8?B?QmMzY2IvV24wSWR6cUdlV0RINWxTMFFIeFRwdlpQSG1ITjdBdkRXa2pkSno1?=
 =?utf-8?B?VFB0ZDM1VjJmWDM1UXpBeUZ4ZDZKUVZqTURPRGFiVEhDNlFKdWV5U2tlZzE2?=
 =?utf-8?B?WFdUQnBWZTdsMTNsMlJlNU0xTXIwTVgxcFVxa2Vvcjl2UlIrZ0l4SkFJVzN0?=
 =?utf-8?B?ZXl5UXJ2OXlqbERrTjZxNm5NS1hkSnRpeUxTTnJERzh4WG40UmdVUDhHMDdD?=
 =?utf-8?B?S254NEsvam01cjYvMU1FRFo2eEJUaDU2UklwTjlRZzBSYW1QNEVaU3VqeVRG?=
 =?utf-8?B?UXlxc2RlY0VoZ09YQ1ZsdkxsTjhSWTFhNVRDOUNURFMvckR0SGtnSFRKOTJB?=
 =?utf-8?B?SUl6Z2U5QWd0M3VFNTNRMVNCQlBzMFpOZ01wOTdxQkUwZmF2bUYvQlhGdWhi?=
 =?utf-8?B?Q3lHbWFGWHpBUDRESnNhUGRTdFBOUys5cE9UZERtMEt3bXNaODQ4bndZZzZh?=
 =?utf-8?B?djBVRlVhSHc2UnN1RlNnaVl5WkdQcFJTZUlwT0orRDJFaVNYZERNM21zdC9u?=
 =?utf-8?B?elM4eTZVamNkMFkzSFFWMmxGY3c1ZjFkWUhCWVpPMEdUaFc5dTdLUzB4Yy80?=
 =?utf-8?B?SDFSME04OFVWTlk5dnUwYUQvYkMxdGZ4Z3p0eGZDVXBqOVZHSVZha3oxMTNX?=
 =?utf-8?B?Z1E9PQ==?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <2F9FADCD21B1AA4B9FB3D50F0C0D6BAB@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9a6e2fb9-8d25-45ea-0c4c-08da5a0e8101
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Jun 2022 20:32:36.6093
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: kE+gGBrnyh5mkdl7hPngY0ovhEt/8SyfOLb369LmHQP1KP/Q5tVjBRwxEr7vzW4rgDN+KcqD+UvIF35FMdTq0EtWLmY+Eanb5RdE9L+50bw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR11MB5380
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMjkvMDYvMjAyMiAyMDo1NCwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPiBFWFRFUk5BTCBFTUFJ
TDogRG8gbm90IGNsaWNrIGxpbmtzIG9yIG9wZW4gYXR0YWNobWVudHMgdW5sZXNzIHlvdSBrbm93
IHRoZSBjb250ZW50IGlzIHNhZmUNCj4gDQo+IE9uIFdlZCwgSnVuIDI5LCAyMDIyIGF0IDA3OjM5
OjQzUE0gKzAwMDAsIENvbm9yLkRvb2xleUBtaWNyb2NoaXAuY29tIHdyb3RlOg0KPj4gT24gMjkv
MDYvMjAyMiAxOTo0MiwgU3VkZWVwIEhvbGxhIHdyb3RlOg0KPj4+IEVYVEVSTkFMIEVNQUlMOiBE
byBub3QgY2xpY2sgbGlua3Mgb3Igb3BlbiBhdHRhY2htZW50cyB1bmxlc3MgeW91IGtub3cgdGhl
IGNvbnRlbnQgaXMgc2FmZQ0KPj4+DQo+Pj4gT24gV2VkLCBKdW4gMjksIDIwMjIgYXQgMDY6MTg6
MjVQTSArMDAwMCwgQ29ub3IuRG9vbGV5QG1pY3JvY2hpcC5jb20gd3JvdGU6DQo+Pj4+DQo+Pj4+
IE5vLCBubyBpdCBkb2Vzbid0LiBOb3Qgc3VyZSB3aGF0IEkgd2FzIHRoaW5raW5nIHRoZXJlLg0K
Pj4+PiBQcm9iIHRlc3RlZCB0aGF0IG9uIHRoZSB0aGUgbGFzdCBjb21taXQgdGhhdCBiaXNlY3Qg
dGVzdGVkDQo+Pj4+IHJhdGhlciB0aGFuIHRoZSBvbmUgaXQgcG9pbnRlZCBvdXQgdGhlIHByb2Js
ZW0gd2FzIHdpdGguDQo+Pj4+DQo+Pj4+IEVpdGhlciB3YXksIGJvb3QgaXMgYnJva2VuIGluIC1u
ZXh0Lg0KPj4+Pg0KPj4+DQo+Pj4gQ2FuIHlvdSBjaGVjayBpZiB0aGUgYmVsb3cgZml4ZXMgdGhl
IGlzc3VlPw0KPj4NCj4+IFVuZm9ydHVuYXRlbHksIG5vIGpveS4NCj4+IEFwcGxpZWQgdG8gYSBI
RUFEIG9mIDNiMjNiYjI1NzNlNiAoImFyY2hfdG9wb2xvZ3k6IFVzZSB0aGUNCj4+IGxhc3QgbGV2
ZWwgY2FjaGUgaW5mb3JtYXRpb24gZnJvbSB0aGUgY2FjaGVpbmZvIikuDQo+IA0KPiBUaGF0J3Mg
YmFkLiBEb2VzIHRoZSBzeXN0ZW0gYm9vdCB3aXRoDQo+IENvbW1pdCAyZjdiNzU3ZWI2OWQgKCJh
cmNoX3RvcG9sb2d5OiBBZGQgc3VwcG9ydCB0byBwYXJzZSBhbmQgZGV0ZWN0IGNhY2hlDQo+IGF0
dHJpYnV0ZXMiKSA/DQoNCkl0IGRvZXMuDQoNCj4gDQo+IC0tDQo+IFJlZ2FyZHMsDQo+IFN1ZGVl
cA0KDQo=
