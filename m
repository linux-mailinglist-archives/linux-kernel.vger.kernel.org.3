Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8895E544594
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 10:23:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231273AbiFIIXf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 04:23:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232212AbiFIIX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 04:23:28 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C74263C;
        Thu,  9 Jun 2022 01:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1654763005; x=1686299005;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=AxIbfZrZx8qDwM1fIVPgtapHCKTTeX/3VmCGqtg+Nyw=;
  b=oIbcF3i8B/uGvxl9g1tD53na7YAW3POHz7i78K8hh7iRDeco/vvzgNgv
   I2CIbM/iwCpIq2MgsqohIdHMQnQQo8UXr/eAj8LtWUHPL+xJoOW6rVEzx
   LhhBaKC8xLozBJEKAM6njwIKWg9pD+hou8OtlOnt6FlHd8BZZrgNiXV6W
   U8hVIak+sCVxFNI+Im/MkC7Vvcc385w52bIwZsOXhTb6/wfUfcQCUhPEx
   vAwHLn/2UFdzoN+avhoqZTizH/xzqayeTz4cYAmw73DezrxfsFrlT4OMv
   BEWkPxgfQLuMQCnE1EDtjuPiLYRMviYviD7M5sRXw4cGK6PmcRzLjinAS
   A==;
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="159540881"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Jun 2022 01:23:22 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Thu, 9 Jun 2022 01:23:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17 via Frontend Transport; Thu, 9 Jun 2022 01:23:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Wh9Ze5a1jX/TnVBTKs+2PzH1G9nl8WrGvrjgzF1EHjG8CuFyZ0zzrXoxE7dP4McKyIK+UK3m0KUfxf48/qt+it5dHS7WHrD4xiqIZDIGX0q6TGvparXBeYNqCRn71M20HMq4spGZuBYFwDVs4Wpbe3k/BvY+9pOK3amZJqspPqq9cYklMwE7nLOHDu6ztuNMq1g2Bl18mn6++1ViA34Xwd8Tvi2KdSF3twBnVbA5i04raMvq5I/Y/8WzwChD/JEcguNJNdwuiY7B9lOubsi8tvKJ/o/lHS2jyfyqTWwa6AdXXgaoeWMrGhDxPIoQFkWHuG2pEcUWfWtjSeenjOVMKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AxIbfZrZx8qDwM1fIVPgtapHCKTTeX/3VmCGqtg+Nyw=;
 b=hLuAFy124lNHdo1SSuLt7c0YAnS452WHrtBO5nQESVMXxjpxoCsif7ByzZqqVTDf/9LUrMA1sX1kI8dk7hcmvcPC9DqRE8Z2xVS7xQY3L1/8ATFTfMqeSK7X6YWFtWRNtgjdVAQNEK+IuzK6Qqh8PDGW/GHcAubUrEHBP1f2CzWtnILXTEA9oIfKW5gkAyXkxCMKRGzf1g66PypzZPvghGZwc5f9s0HUFDYNdBerqromYfPKSQOwQd/voRS/WM5zmR+lP1COs6E+BZ0JD00Xs/QFV9vsU/mG7if02B7SeuPr52Ia+BR4zbILIEyY4Nx1BaaVnZNOxIJrwibOIy3xgg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AxIbfZrZx8qDwM1fIVPgtapHCKTTeX/3VmCGqtg+Nyw=;
 b=VeTJX3DiHitvWvXtBZbpTi0tavb/ehXXR9pHQiftCdAEfZB6DTAptP2FLJMBv4SLaCpcMON+R5aORA/mzm5/3kkoFOlybJs4tGuojYLIjtZSIUe5xTxHscwS1zllG0Wge65vaFejhfQaQJCdi19uxwoG+04Mqq3n7XGvMu1zZdg=
Received: from CO1PR11MB5154.namprd11.prod.outlook.com (2603:10b6:303:99::15)
 by SN6PR11MB3151.namprd11.prod.outlook.com (2603:10b6:805:d2::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5332.12; Thu, 9 Jun
 2022 08:23:16 +0000
Received: from CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa]) by CO1PR11MB5154.namprd11.prod.outlook.com
 ([fe80::699b:5c23:de4f:2bfa%4]) with mapi id 15.20.5314.019; Thu, 9 Jun 2022
 08:23:15 +0000
From:   <Conor.Dooley@microchip.com>
To:     <heinrich.schuchardt@canonical.com>
CC:     <Daire.McNamara@microchip.com>,
        <Valentina.FernandezAlanis@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-usb@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <gregkh@linuxfoundation.org>,
        <b-liu@ti.com>
Subject: Re: [PATCH 3/3] riscv: dts: microchip: fix icicle kit's dr_mode
Thread-Topic: [PATCH 3/3] riscv: dts: microchip: fix icicle kit's dr_mode
Thread-Index: AQHYenID/JCqnhUo2k6UHJwb6MNxwK1Fb7YAgAAHPwCAAUgPAA==
Date:   Thu, 9 Jun 2022 08:23:15 +0000
Message-ID: <fc809cbe-82c7-e085-885e-54655915ddc6@microchip.com>
References: <20220607132204.746180-1-conor.dooley@microchip.com>
 <20220607132204.746180-4-conor.dooley@microchip.com>
 <244df608-ef96-d3f2-2463-1cc82728e70f@canonical.com>
 <9ec92e13-2af1-e65a-b24f-7acf895a40ee@microchip.com>
In-Reply-To: <9ec92e13-2af1-e65a-b24f-7acf895a40ee@microchip.com>
Accept-Language: en-IE, en-US
Content-Language: en-IE
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 538b4019-9829-49f9-2550-08da49f14d23
x-ms-traffictypediagnostic: SN6PR11MB3151:EE_
x-microsoft-antispam-prvs: <SN6PR11MB31519A6DBDCEF327779B053E98A79@SN6PR11MB3151.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: cLxPyIW/sg4T5LTveC3TuDnLaUzSoELHQbZyvrnf1WaPvdHtStMXDYVV0QukLFklzC1OVkM4P+cc7Exr29Zdtj9f++CubsSIKFloJx49QDjffPMIV1vPcOXVXWlzKYssIIn1cMzxrfqtoHpnS4JDnP/svXrXdq1/DBdVFwxJBn4lW14XTmjwMXzUjTT0G24YrezImefNPQ5KKFTtZEzINH5DtNcRAL1h44kZrpp+HxB4zxP/bWbTNjR50GySbTS5cmRVCmR0yWIL/XwGoYeiIlRABpqNVCpVb41AdmjSoancRIqLBA9K/w1DwoKCfmTGrJtUnTmC8eAMjbjRmFyGHu4Cont0ZPXGK5MKylcG0bogYOr0mX0fES52AJd773ZnvtzBa58alw4QigshukLySq2CcyVHm8UUswK5Vqedk47YQ+Rjtp7Nq+Nog5mz1Z+Cy+/6AABbPWZLYpcqOkDrlD7kpABgPKRVX8FbcCJM7HutCn/24op58ZsKQWNg9dh8MSt692XniyXVZ10TLunc2qtxW/aiNYLAvX7GBJKBXZLtxV68yFBcRSorZSs6iK+P+gG2rC5gRaHU1b55az8depygDKLARfwi0H9rgKlGOjfMXyci7FKUM2jooiBJf7poSfT5/39A/PEpEjjRgR5sNkUZzCf5nf6TRGgqk+z7AbWArfyrMgYzut9Jd2jnuKN3mXFLEOPFpfhVPZWBndX7LFCSSB3alkhgXA+muAH0pOQOGQd0L9BOsmJVQ43RBoI62RVJQXqj458JuSBU8EavMSMNNyozMP5trb6aV0GVb780lOyKu+sn5184a0Gdj3xVuV0tHQi8nqSnDhIiYHLjNOrs8v4psvbaIzirkKn66Wg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR11MB5154.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(71200400001)(86362001)(31696002)(186003)(122000001)(38100700002)(38070700005)(66446008)(66556008)(64756008)(8676002)(4326008)(6506007)(66946007)(53546011)(2906002)(91956017)(316002)(66476007)(36756003)(8936002)(5660300002)(2616005)(6512007)(26005)(6916009)(31686004)(54906003)(508600001)(966005)(6486002)(76116006)(43740500002)(45980500001);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?WHU2OGJFZm5PYXBzWFV5a3k4ODE5SE9peVFldFA5UVEyUzRmQ3V0OEhqSGw3?=
 =?utf-8?B?Q0w1NTBvcVRPSlUvYUcyS0NTOWdJbHBjS0hVUDRqcHFOVHgvaHR0Mm5VWkEy?=
 =?utf-8?B?Q2hZdEk1VXl5ZUVVblIxWmNCWXRRZU5HdjRITy96VHMwMyt3ZUFEWEJCUk9T?=
 =?utf-8?B?eGVuQldVanIwaC9QMkEvZmpweUhsR3FTcnhnMG1SZ25VbXdxK1QxR2w3aU9V?=
 =?utf-8?B?cVFmaUpTdmk1NHZoeDBRaXE2RDFKWFdUdy9QOUthS1YxcFhjUTRDMFc5MnNG?=
 =?utf-8?B?MzdsMjdqODV2ZlhUbHJYM3oycjBVcmlxOS95UDY3TFdRMjR2QlJFRXNoakRB?=
 =?utf-8?B?TC9ZQnVJWktkYXp4UFM4UjJxZVVwN3gvQkw2UnFmSVhMWG4rdklkdGpMbTEv?=
 =?utf-8?B?QVlzT1pNTlpaUW9rVFlZRHBEdHhROXhsV1JDNW43cHpEand2SmdOZHdQRXpZ?=
 =?utf-8?B?UjAvRFcvZGpvaHRIQXl1UFd0SFFxQ3FhUlJPcTFFVnhxSU43UXZQZTQ2K2RY?=
 =?utf-8?B?VEl4dEZQZTllZXd3T3ZYK0prckYwN1NPbmxleHljNUtkVTRpWkJ6Q1NJNzJS?=
 =?utf-8?B?emRZMUxjeHRWSDhBemg3Vmppbi81bVFDVEk3c21oK0hHaVFFcVRKTEVSSnpT?=
 =?utf-8?B?cjAzWU01cUtVTjhBR1pDOGVsM0ZzWmQwVVd0bWpnMk1LOEp3TmlKQy9wTzNL?=
 =?utf-8?B?eWRtUHc3TFg4WG9naWx3Y2dxbHlVaW14MVp4a0thSXRFSnE3QTRtOStES25r?=
 =?utf-8?B?azhQUDU1bk9xd0piRjdMRWpXcTM1bElVMk0rN1FuY2pLYmtCOTluNHFOL3pt?=
 =?utf-8?B?MWt5c1I0V0xVTkRoL3BZWFZOcmZJQkpLeG5UdXd3MGlUWUpCZUNPMXJnWkhM?=
 =?utf-8?B?VkVTdnN1K0tEQ1d5ZHJ0NTVIMVFpTG9leVhpMXBBTWxzWGgxaWxneEw4TXBJ?=
 =?utf-8?B?WGEvRldsUE11Nnl4RVk2Ym9KdXlXL3Z1elJGN1RoektrSnhGL09sb1ZmcXZr?=
 =?utf-8?B?bzJ4bnJ3ZGVHOThLaHFYZk5aNCtEOTdyNkpKNXlVd0xPczd2c2UycnRBazFE?=
 =?utf-8?B?aGtRc3JMalZKVHlIKzRBTkRVa2ZrZWdkcVRpYmgxa1NOYkhudXJEMmFuTVB2?=
 =?utf-8?B?VTJMU1k3NExtMjArelhFQm9aOS9XVldkbjVMS1QwbVFMN0o4MEd1Qmx0bHIx?=
 =?utf-8?B?eDU5dGZic1VxVUU2dDA4b05GS3c1MXlyejdnSU9iZ2RJL1dWU2M2SXdDQnBQ?=
 =?utf-8?B?cUFHNzMwL284M1hKQ29iVWxmTTVxam5RV2VVZEZNbjBvWjJPVFVoYm9CbVhu?=
 =?utf-8?B?TWZQOGJWeHZRclNsOTNGaDRVRzdnQ29rL0FZakdhTlNDRzhHVlRLMUprancw?=
 =?utf-8?B?UEdqSUxIbVZVSTRyVUp4anBJUVRBYjQ3N2V5U0ZhbG8rTTBVRitGd1ZGbXgy?=
 =?utf-8?B?c0MvNUtFYkZLRVYrbWMzVC9iYU4zVVRMcmdWUnN0SjIxUDMvWkxBcThvUCs5?=
 =?utf-8?B?UFpBSnFvZ0Z3VFFBSk81cFV5NkQrRUxZa1FVYU5LL1lQQ21OZkRETFBnK1RL?=
 =?utf-8?B?RUJoRHNTdVg0RG1HbFdJdVFHQTA5c0tpRWhRcFlZREJEa2VZcEVOMW1hT0dt?=
 =?utf-8?B?QWZuR0ljU0Y2UStIQVBldkRDV0ZBZmJURWlKNmluTUlKNnFSdWo0ZWdzK250?=
 =?utf-8?B?QXk5MDFrYjhXdGt4aStLdHc2UWdNZCsxaTdVS3YzT2hPR0hsVFQwaHZxKzZm?=
 =?utf-8?B?dFRVVFdYTEFqYmNkazNnRStvUmNBVkRMOWQ3NUppdkw3L3lFRmNqV1NHek5l?=
 =?utf-8?B?ZXlVeElKNWxXclBFUm05WWFBSWpyTzA0c2Y1NkF3V2ZqelVwTXFoTVFhT0li?=
 =?utf-8?B?TGhNeHJRRFVPRHpPdTNYcFVpc201bTIrVEU0d2R2dXM5QmF4bzYxL0swdGhO?=
 =?utf-8?B?YUY1OFcxVXluL0dOLys3V2ttNkxBNXZXZm9nTHptMGhsdzFUaytycFJ3KzRV?=
 =?utf-8?B?RGZXazRQazJxSnZqVWdqczNrdzdzUjZzSm83OVN1MXdTK0RTQnVjOWYvZnM5?=
 =?utf-8?B?d0lyODBxVjZueGYxOUxyTnpncnlBU0Y3RHBndyttMSs0cGZDdzdWd2N2bStO?=
 =?utf-8?B?Z1prcURmejVkaS9HbGIrbzRYVVR5Uy9tZThRTEFXd1Z2d2owRzlqSUV5Ym5h?=
 =?utf-8?B?eHVFN2Qxd0l3YmpiVzZHdkhMV3k1elFqNGx2aGpmaVFCRTh6VTNXbW4xWGJZ?=
 =?utf-8?B?ay9UaXk4QTlKRWRDODVYaUJNNXh1K0FzbE1HTUhRbTJDR20yam5xOVg0ak5u?=
 =?utf-8?B?NUJyY2dCRHBMMkM5NHN2QnNMUmVrZ1h5dy9SVmtqL3VhYW5qSzhoUT09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E60CA00D87BA14498A31872BC3ECCB6@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR11MB5154.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 538b4019-9829-49f9-2550-08da49f14d23
X-MS-Exchange-CrossTenant-originalarrivaltime: 09 Jun 2022 08:23:15.5802
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sfEyOYZ0edGhqN/N2S+1SIFbaWRFSr52f1MD55TWCg8Vq+P0rySpt5Nt5GiKgoiF7eAfCCJvLQIKndF86LXL/ihU+F3YErqy5uTASsXlkU4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR11MB3151
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMDgvMDYvMjAyMiAxMzo0NywgQ29ub3IgRG9vbGV5IHdyb3RlOg0KPiBPbiAwOC8wNi8yMDIy
IDEzOjIxLCBIZWlucmljaCBTY2h1Y2hhcmR0IHdyb3RlOg0KPj4gRVhURVJOQUwgRU1BSUw6IERv
IG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0aGUg
Y29udGVudCBpcyBzYWZlDQo+Pg0KPj4gT24gNi83LzIyIDE1OjIyLCBDb25vciBEb29sZXkgd3Jv
dGU6DQo+Pj4gVGhlIHVzYiBvbiBpY2ljbGUga2l0IGlzIGFjdHVhbGx5IGNvbmZpZ3VyZWQgZm9y
IG90Zywgbm90IGhvc3QgbW9kZS4NCj4+PiBTd2FwIGl0IG92ZXIuDQo+Pg0KPj4gVG8gbXkgdW5k
ZXJzdGFuZGluZyBib3RoIGhvc3QgbW9kZSBhbmQgT1RHIG1vZGUgY291bGTCoCBiZSBzdXBwb3J0
ZWQgYnkNCj4+IHRoZSBoYXJkd2FyZS4NCj4+DQo+PiBKdW1wZXIgSjE3IG9uDQo+PiBodHRwczov
L3d3dy5taWNyb3NlbWkuY29tL2ltYWdlcy8xMC9NaWNyb3NvZnRUZWFtcy1pbWFnZSUyMDEucG5n
Lg0KPj4gVVNCIGRldmljZSBtb2RlIHNlbGVjdGlvbiAtIE9wZW46IFVTQiBjbGllbnQuIENsb3Nl
ZDogVVNCIGhvc3QNCj4+DQo+PiBJcyBPVEcgcmVhbGx5IHRoZSBtb3N0IGltcG9ydGFudCBzY2Vu
YXJpbyBmb3IgcnVubmluZyB0aGUgYm9hcmQ/IEkNCj4+IHBlcnNvbmFsbHkgd291bGQgcHJlZmVy
IHRvIHJ1biBpdCBpbiBob3N0IG1vZGUgdG8gYWRkIG1vcmUgcGVyaXBoZXJhbHMuDQo+PiBXaGF0
IGlzIG1pc3Npbmcgb24gdGhlIGRyaXZlciBzaWRlIHRvIGVuYWJsZSBob3N0IG1vZGU/DQo+IA0K
PiBOb3RoaW5nLiBJJ2xsIGRyb3AgdGhlIHRoZSBwYXRjaCBmb3IgdjIgOikNCj4gDQo+PiBDYW4g
d2UgZGV0ZWN0IHRoZSA1IFZvbHQganVtcGVyIHNldHRpbmcgdmlhIEdQSU8/DQo+IA0KPiBJIGhh
dmUgdG8gY2hlY2sgaWYgYSBHUElPIGNhbiBiZSByb3V0ZWQgdGhhdCB3YXkgJiBJJ2xsIGdldCBi
YWNrIHRvIHlvdS4NCg0KVW5mb3J0dW5hdGVseSBub3QsIHRoYXQganVtcGVyIGNhbid0IGJlIGNv
bm5lY3RlZCB0byBhIEdQSU8uDQoNCj4gVGhhbmtzLA0KPiBDb25vci4NCj4gDQo+Pg0KPj4gQmVz
dCByZWdhcmRzDQo+Pg0KPj4gSGVpbnJpY2gNCj4+DQo+Pj4NCj4+PiBGaXhlczogNTI4YTViMWYy
NTU2ICgicmlzY3Y6IGR0czogbWljcm9jaGlwOiBhZGQgbmV3IHBlcmlwaGVyYWxzIHRvIGljaWNs
ZSBraXQgZGV2aWNlIHRyZWUiKQ0KPj4+IFNpZ25lZC1vZmYtYnk6IENvbm9yIERvb2xleTxjb25v
ci5kb29sZXlAbWljcm9jaGlwLmNvbT4NCj4+PiAtLS0NCj4+PiDCoCBhcmNoL3Jpc2N2L2Jvb3Qv
ZHRzL21pY3JvY2hpcC9tcGZzLWljaWNsZS1raXQuZHRzIHwgMiArLQ0KPj4+IMKgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPj4+DQo+Pj4gZGlmZiAtLWdp
dCBhL2FyY2gvcmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC5kdHMgYi9h
cmNoL3Jpc2N2L2Jvb3QvZHRzL21pY3JvY2hpcC9tcGZzLWljaWNsZS1raXQuZHRzDQo+Pj4gaW5k
ZXggMDQ0OTgyYTExZGY1Li4xMjFiMDFjODc4NGYgMTAwNjQ0DQo+Pj4gLS0tIGEvYXJjaC9yaXNj
di9ib290L2R0cy9taWNyb2NoaXAvbXBmcy1pY2ljbGUta2l0LmR0cw0KPj4+ICsrKyBiL2FyY2gv
cmlzY3YvYm9vdC9kdHMvbWljcm9jaGlwL21wZnMtaWNpY2xlLWtpdC5kdHMNCj4+PiBAQCAtMTU4
LDUgKzE1OCw1IEBAICZzeXNjb250cm9sbGVyIHsNCj4+Pg0KPj4+IMKgICZ1c2Igew0KPj4+IMKg
wqDCoMKgwqAgc3RhdHVzID0gIm9rYXkiOw0KPj4+IC3CoMKgwqDCoCBkcl9tb2RlID0gImhvc3Qi
Ow0KPj4+ICvCoMKgwqDCoCBkcl9tb2RlID0gIm90ZyI7DQo+Pj4gwqAgfTsNCj4+PiAtLSAyLjM2
LjENCj4+DQo+IA0KDQo=
