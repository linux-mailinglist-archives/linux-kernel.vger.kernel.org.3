Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DEC515439
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 21:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380219AbiD2TOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 15:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237181AbiD2TO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 15:14:28 -0400
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.73.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DEA5565D0B;
        Fri, 29 Apr 2022 12:11:05 -0700 (PDT)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 4A1F74108E;
        Fri, 29 Apr 2022 19:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1651259465; bh=qmOWliNpguN7F4MgmQxUEH3ZSIXakJCU7aEGtAeXft8=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=Lxe7U3ZLcOc9bXy8rgeOFiv2ahjzYvMYpRcsi29C5pma8pqFMFXqd7IVHaGO5fHxs
         he5e42XTWpgCkNs4opFdWbqUQE7J3wVv4+6XhZUbe7b+/7CtdQGovc4xS4/nOCOTst
         OFawcGRu4Cx4TXeL6AEjzxGMEV2i8VVgRX3IvI3q1L59hzCT4er57KdyqI6dpQQY0X
         D0deTOwO3hrDvqbC/1aL4wEiAxgzbx2iLV/qzqG2X12gat/Z16ovXzordxFLhTul3r
         We9HY+vNgfT2QWdv+B/KoTUoRA1rsE7GLtmyBkgyzoM6Dhv4ryiNO9b/z9/u0Csks2
         OMqowt6v6/xLg==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 96305A006F;
        Fri, 29 Apr 2022 19:11:02 +0000 (UTC)
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 21F6080168;
        Fri, 29 Apr 2022 19:11:00 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="gCN7XtMD";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EhOIN7qSkA9+ZZYPLgkbGbU14eWS41H9dButV/FkZEt4Rw+UshNO7JdDfjAsN/uhHf/RWbGmL4ZYKi/x/zy0+uoMbWDYkQAj3TORX6Ht4zX3vc3WN3pYUqRwJoP8pe0eN7ya3weTd8opAdnmj9juYbb5rcbPX9kK/Drt/+XdCrfzohC4aABEAQjnhIMrFdORz8+Jfx9HjFN/zUDyxGfzBKvsvPpdEBiY3jvdyLBaoO72MUimdEs6TPdHZpHMy+XOD1Evcy4zaWj5Q57eY5efo/jDvTz4wRC1DZAS6+exT7KC/09218bBV0JPHtV9FzEkknjeQRDQeFqyjERXeR8V1w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qmOWliNpguN7F4MgmQxUEH3ZSIXakJCU7aEGtAeXft8=;
 b=frYulim7T1IQm0JmntUHX+BniiQIgOwGD6xogaDYWGKfj5cga80tJ0kYJHWLJdE6uXQIVq5i9bBekp8N0sSEx4SgnYwkr3C3RLUpxsq7y5X7TSURwjXJGUH92K1oCZkucsI5cATm5LwAaJ1cu8zCCANJA4kmjiMpAtxNlCWjQjrskedKZg+vIF7Kyk5Kkcl+gbRpcZC9uRkTsMeIGTwz4qmF3Vtrc7IdbPlxc5rc2/K4swgESKqlU7m/gLxHasNAJh6XK7Cp/G6rcdyAo7fLwV+2JofYaNkbcDQH4gZPXEQp/C0d/g+3e3qlzCbAUPGaJd+ifW7dcObqoLKJiomDsg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qmOWliNpguN7F4MgmQxUEH3ZSIXakJCU7aEGtAeXft8=;
 b=gCN7XtMD8S9Bml5ujy6/Et0w31ItYS4FcRieFQaDA37aRC+cc8P+yfwyd1Kkjn+vPnZNeeOt9fRt5T36TcxRyJnq6yep9G9YPYX1LFOTI+HueT/kwgw4sf/nH4Wo2rSADAcLj6kyDL5iim9R5TQEzTRmUBW1AdndUi5lL2M23tM=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BN6PR1201MB0065.namprd12.prod.outlook.com (2603:10b6:405:4e::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.14; Fri, 29 Apr
 2022 19:10:56 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d7:f2c8:c731:bdba]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::d7:f2c8:c731:bdba%5]) with mapi id 15.20.5186.021; Fri, 29 Apr 2022
 19:10:56 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Pavan Kondeti <quic_pkondeti@quicinc.com>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>
CC:     Sandeep Maheswaram <quic_c_sanm@quicinc.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "quic_ppratap@quicinc.com" <quic_ppratap@quicinc.com>,
        "quic_kriskura@quicinc.com" <quic_kriskura@quicinc.com>,
        "quic_vpulyala@quicinc.com" <quic_vpulyala@quicinc.com>
Subject: Re: [PATCH v4 0/3] Skip phy initialization for DWC3 USB Controllers
Thread-Topic: [PATCH v4 0/3] Skip phy initialization for DWC3 USB Controllers
Thread-Index: AQHYVTzp+nheqTmOxEObuTjVewbkqaz/84sAgAF3UoCABNaxAIABDaoA
Date:   Fri, 29 Apr 2022 19:10:56 +0000
Message-ID: <3c52770a-5a04-99b3-0875-d902142a336c@synopsys.com>
References: <1650517255-4871-1-git-send-email-quic_c_sanm@quicinc.com>
 <20220425024858.GA7052@hu-pkondeti-hyd.qualcomm.com>
 <1287c649-de62-c7d8-1c1d-a30ede7505c9@synopsys.com>
 <20220429030544.GC16319@hu-pkondeti-hyd.qualcomm.com>
In-Reply-To: <20220429030544.GC16319@hu-pkondeti-hyd.qualcomm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 5275f3a3-c90b-4271-54bf-08da2a13fcd4
x-ms-traffictypediagnostic: BN6PR1201MB0065:EE_
x-microsoft-antispam-prvs: <BN6PR1201MB0065E732A2586C7141ECF3B1AAFC9@BN6PR1201MB0065.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: r2FY1idcdhboMq81nOKd3ACTei3Gn8a5LWDXrkfJEy/Cio8WX57p4ou1sKTIpajO4sAwoNmJGtN8KKLWP3Z6FknvPxD2yHbuIoDOnKtJj8sIPdwCt/X5iM7i1A7fzb6Qyo5WAbPxLycbZxlYJsSGJCcW2qh893Ge5ckz7qtYDrKI+s7c30LYj0s2BAgDm35tVRvTjjNhc/hXN1My5qqyst8PMXCt+norHoCMwy6+K9t8CFp347YTBrtVAQ2qGGLwIfDFhgkTwp+OToGy47vb2wRrvfB0ySLE45JYBSPTor/LYPK/qtyYMDK68PlkWKmIOtej61J0SudMLyKvNLCeeW4Kq3NG8w55d23cjjW4Fhluaj6/1L0cGjzBtxxwQl24tceiHOucr/HQbRKv2SKR42HudC9emIp8eZO2fWjUB1qwwiOvzs9eC5Sp+xNLzUgkoAYV5M0PyFEKiC1NjYybd1MoRLfadqhPbLOoSqsSxKH0Q5NMpNzGS/r1pskkrgftPcGrvvpOoVGdXZwS8MDHoFbzVA0eHUGktJBzkARmYcOPnn3TyZnjDGQhO7YCIZOgR8spEiU4StG/OSkOpmTy/dRzPpf2z+zxjmu5WgS0wW8NTxVl5rwl1alm9rqGYky52WgolzB+krdNtMX5Dim77uZgZPNFrVxgxMgM3XSg/QwTfCiUuIRdtBw60hMqpY99sQ7aqjcWVWJi8zJXPxGzHcYMcF9I0NJmgeDpyaGTxyAsfp5cW3KeQYpmK2ilavqQeCSvf5kmZQ/Ipcye44GYMSdinSF5xvErk3VfZh9gI4l1BpoqThiUagfryxZeujssGjksygxhi8TewVqMMx8Cv68UQyIXrccFZ3lmojEPfi0=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(508600001)(8676002)(2906002)(6506007)(110136005)(66946007)(66446008)(64756008)(2616005)(66476007)(66556008)(31686004)(4326008)(36756003)(6512007)(26005)(76116006)(38100700002)(122000001)(38070700005)(7416002)(5660300002)(54906003)(966005)(83380400001)(71200400001)(6486002)(31696002)(86362001)(186003)(8936002)(316002)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?VU1ERnRuelBTZ1U0UC9GRUNGN0p6ZUE0dHhydWp3ZEI3N2VSV2lENXVxbjdy?=
 =?utf-8?B?UnJpOVVneU43RCs4SlMyR1VaQ2l0emgvVnRSRmFEUllFNmlKTzhaTE9GV1k1?=
 =?utf-8?B?dk5zWnFRYkhOVVE0WVdralcyamwvanVJL3VMMTl4VXgralg2b2szTThZWmtM?=
 =?utf-8?B?Y0wvcnNnYndCeGhjTGJDUEx4dDYzakVjZ3o1aElYU1ZTTDFveW9jTDdUQ2po?=
 =?utf-8?B?VUhiSkdmZlBLMDJ4THA2cDgvRnZUbWxDYzJLNkpRNHdjVWtxQ1BSMnptVmxQ?=
 =?utf-8?B?OHczTFN2WmJaL3BJejBDWWwrQzY3T3Z4YTlwTnBGSWdIaWpUSmlBcWx5Zld4?=
 =?utf-8?B?Ri85ajFUUzdFWDBhTmJNZ2hOQ1RZN25RNHJlVTJIVnZkS2ZGSURiQTI0emRY?=
 =?utf-8?B?cDJPUGlOcEhCRmtZV0FNbVB6aEczVkFCZGZWYTNJbkVFSkwwd1BONWhiKzdY?=
 =?utf-8?B?ejQzYmEvWXp6ZjM5WklCUEhIVU1oVllvaWY1S2U2Sy9ZYkJJYS8zUEpyL2dC?=
 =?utf-8?B?VXptYzA3a0F1WTB0NkhwMm50bTc3cnkvOGNZVks3S3BGcmFrU291bThsb3FV?=
 =?utf-8?B?OTB0V2Rxb1dlZ0pZNXNVM0NhTVhkQ0tKak5LY0hORlkwWDRZeFBtVEU0MGpY?=
 =?utf-8?B?bWZ6TFkyUGFjVjF1VThKempCU29uYTE2TmNacmNVV3l6L0hlK053aXdCZG14?=
 =?utf-8?B?cDRtSlcvQVp6aWI0RTdHQ3FXdVJUL1hXcXRxYS9OQ0tJWVNrM2owbzRwM0d3?=
 =?utf-8?B?dDVhUHhKTGh5MGlRUXlGSmdUak9oUmJnNXc2azhGSjFOb05lbjFKc2E3cG50?=
 =?utf-8?B?Q21BQVZiTUlSUVhNeU1uaE45RDhPS3V0aXordklwbTZmTjliK1ZwMlNzZWdw?=
 =?utf-8?B?NDVQR2krSzNzUEIwSGd6dThieDZ6dUxBQVY5Znlxc09TSEtGWm5ZeXJyMnk4?=
 =?utf-8?B?aE95cTZ2NWlYc1BrZG5Fb1lKUkdEUCtwVklqcFArWXhHNDRGSnRXOFRxYlVO?=
 =?utf-8?B?ei9IUURqcE1TUUM0TkxGQklSL0NhZFBNVmhJSjBuNDhZRUQ0d0xQOXFMQ1V3?=
 =?utf-8?B?dGx0RUVtVityQURzWm1xVFZXckMxdHJ0aDJ3Ymg1bXlRZFBObS9ramcvNnI2?=
 =?utf-8?B?KzBSMEltdWo5RnIrNlhNYlh0U3V6bmpaSnU0SlFSbXYwYWxTcmVxMTdSQWhm?=
 =?utf-8?B?dFAvbGlHZjdmaVlYY2gzZklmQWJuUzlQcjRXZ3NHbTQrYUJ1eFdhY1I0bndk?=
 =?utf-8?B?aEJLVnhrS2JRQU5YdTVzaXYyV1lNNUdvdExQVExNdlhnR1I1Q24wVVhOQW4x?=
 =?utf-8?B?QytIdXplVkhHRlVnVWpVK2JKUXgwaSttVE1BY0RLK0hNQksxS3BZQWxYa1BH?=
 =?utf-8?B?MVlNNEkvWExuMmw2ai9hMFhCLzdEajJKem1ON1lmRkNrQWQ1OEFnbjZHWTR3?=
 =?utf-8?B?NlNPWDlXVWdpY2l3Ky8rWEIwOHAycjRhcEp3NHdOZUNsWGtLQzlBNUROMFZT?=
 =?utf-8?B?UUsycDF4NUZEZFpkM3R4WGNxNVRQc1VNa0ZMKzNoUlhoeW9TTjRsaVF4Ym9v?=
 =?utf-8?B?OWVUeExHY3hvV2xRQ01pek5rNE9OY2JKQ3dHUTNWeVRjSTB5SnhRREgwUWNy?=
 =?utf-8?B?WWJpelo0U1l0dnY4Q1R3b1JsY2ZOdnNSQjFzeWJYUXhkbldMdWR5a05qWXlr?=
 =?utf-8?B?SUZ2RzdzRnlXQVpqOHhDbjlhK1BpT2Vjcm56MTVkWnd0eVhIY1ZZVGFzNUxm?=
 =?utf-8?B?eWRGMFhFTWdYbWQ3Q1BTKzc1aExxN1ZYR1RZaGl0bW82U0hHSWVWd2N6Rm5G?=
 =?utf-8?B?N3pBQ29UN0hIMnlwSjVJanh0RGhQeUp1R3UvQkRuaUp1Q3I1SlRvSnhSN2pt?=
 =?utf-8?B?N08vaW5OM3dtQ0h3TU5LQUUrSFFIbTNFTm5JL2xtTXRMNDlrSnBuRjNrZ1V2?=
 =?utf-8?B?ZkMvREFoUCtTNU1LK0thVUQ1Z3N5TEd3eXg2c3BMRVBvMDJqU3d3OEd1NENT?=
 =?utf-8?B?SmhFRGZNZldrMzQyazJscXFIOUVQcmd5bm5SZFh1MjFhUWZibTNJT2ZCSy9V?=
 =?utf-8?B?a3FEcWRwWlZRcU9RZ091WllTZzJGRU5kVmxVbTR5ekdwazdsa1pTcU11K3dr?=
 =?utf-8?B?YlRWUXJDZGlodUp6aStUZDJUNEVnbUtZbnlMOG1pTWs3aERjaWZIR3l4ajQv?=
 =?utf-8?B?RXhDVkc2eHFYd1NSQ2ZQa0NuUEF5SzEvWEtDbTZReTNUTjhhTEN5N0Zydjh1?=
 =?utf-8?B?NTRONDJFRDBTVEJ3TUNVa0xzMWZIK2hMM2RKS08yV3VGazJDMGxMS05FVUVB?=
 =?utf-8?B?cnAwcVFzTGdvVHMwYmRlSDR6aGFrWTNNU2U1OEUxa3Y5ZU93Vnhwdz09?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <CF72231FEADFF64787217C15D4BB1E41@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5275f3a3-c90b-4271-54bf-08da2a13fcd4
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Apr 2022 19:10:56.0396
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: FNyqbuWB/txkZm4dHNuoaGLMvChxKB+c4fahVRAJ6xWLws9C8YvZx7gkfUp5wkTzLaIGS0lnlFZbDOcg8qB5JA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1201MB0065
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

UGF2YW4gS29uZGV0aSB3cm90ZToNCj4gSGkgVGhpbmgsDQo+IA0KPiBPbiBUdWUsIEFwciAyNiwg
MjAyMiBhdCAwMToxMjoxN0FNICswMDAwLCBUaGluaCBOZ3V5ZW4gd3JvdGU6DQo+PiBIaSwNCj4+
DQo+PiBQYXZhbiBLb25kZXRpIHdyb3RlOg0KPj4+IEhpIE1hdGhpYXMsDQo+Pj4NCj4+PiBPbiBU
aHUsIEFwciAyMSwgMjAyMiBhdCAxMDozMDo1MkFNICswNTMwLCBTYW5kZWVwIE1haGVzd2FyYW0g
d3JvdGU6DQo+Pj4+IFJ1bnRpbWUgc3VzcGVuZCBvZiBwaHkgZHJpdmVycyB3YXMgZmFpbGluZyBm
cm9tIERXQzMgZHJpdmVyIGFzDQo+Pj4+IHJ1bnRpbWUgdXNhZ2UgdmFsdWUgaXMgMiBiZWNhdXNl
IHRoZSBwaHkgaXMgaW5pdGlhbGl6ZWQgZnJvbQ0KPj4+PiBEV0MzIGNvcmUgYW5kIEhDRCBjb3Jl
Lg0KPj4+PiBTb21lIGNvbnRyb2xsZXJzIGxpa2UgRFdDMyBhbmQgQ0ROUzMgbWFuYWdlIHBoeSBp
biB0aGVpciBjb3JlIGRyaXZlcnMuDQo+Pj4+IFRoaXMgcHJvcGVydHkgY2FuIGJlIHNldCB0byBh
dm9pZCBwaHkgaW5pdGlhbGl6YXRpb24gaW4gSENEIGNvcmUuDQo+Pj4+DQo+Pj4+IHY0Og0KPj4+
PiBBZGRlZCB0aGUgZGV2aWNlIHRyZWUgYmluZGluZyBwYXRjaCBpbiB0aGUgc2VyaWVzLg0KPj4+
Pg0KPj4+PiB2MzoNCj4+Pj4gQ29taW5nIGJhY2sgdG8gdGhpcyBzZXJpZXMgYmFzZWQgb24gZGlz
Y3Vzc2lvbiBhdCBiZWxvdyB0aHJlYWQNCj4+Pj4gaHR0cHM6Ly91cmxkZWZlbnNlLmNvbS92My9f
X2h0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9saW51eC1hcm0tbXNtL3BhdGNo
LzE2NDgxMDM4MzEtMTIzNDctNC1naXQtc2VuZC1lbWFpbC1xdWljX2Nfc2FubUBxdWljaW5jLmNv
bS9fXzshIUE0RjJSOUdfcGchZnlrVE5UQnVLazljaTZ6S2RjdVFOYnVaUWRWaV9IZWtVM2pldHp1
ZC1QUVZoYlJhVmhoWkhLejBrX0xmRzBjZ3dhWDRiUU01YkxJMGVwNnRZeWlrZ3ZZSzdiNVNkQSQg
DQo+Pj4+IERyb3BwZWQgdGhlIGR0IGJpbmRpbmdzIFBBVENIIDEvMyBpbiB2Mg0KPj4+PiBodHRw
czovL3VybGRlZmVuc2UuY29tL3YzL19faHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9wcm9q
ZWN0L2xpbnV4LWFybS1tc20vY292ZXIvMTYzNjM1MzcxMC0yNTU4Mi0xLWdpdC1zZW5kLWVtYWls
LXF1aWNfY19zYW5tQHF1aWNpbmMuY29tL19fOyEhQTRGMlI5R19wZyFmeWtUTlRCdUtrOWNpNnpL
ZGN1UU5idVpRZFZpX0hla1UzamV0enVkLVBRVmhiUmFWaGhaSEt6MGtfTGZHMGNnd2FYNGJRTTVi
TEkwZXA2dFl5aWtndmEyVlhhaE9RJCAgDQo+Pj4+DQo+Pj4+IHYyOg0KPj4+PiBVcGRhdGVkIHRo
ZSBjb21taXQgZGVzY3JpcHRpb25zLg0KPj4+PiBDaGFuZ2VkIHN1YmplY3QgcHJlZml4IGZyb20g
ZHdjIHRvIGR3YzMuDQo+Pj4+IEluY3JlYXNlZCBwcm9wcyBhcnJheSBzaXplLg0KPj4+Pg0KPj4+
Pg0KPj4+PiBTYW5kZWVwIE1haGVzd2FyYW0gKDMpOg0KPj4+PiAgIGR0LWJpbmRpbmdzOiB1c2I6
IHVzYi14aGNpOiBBZGQgYmluZGluZ3MgZm9yIHVzYi1za2lwLXBoeS1pbml0DQo+Pj4+ICAgICBw
cm9wZXJ0eQ0KPj4+PiAgIHVzYjogaG9zdDogeGhjaS1wbGF0OiBBZGQgZGV2aWNlIHByb3BlcnR5
IHRvIHNldCBYSENJX1NLSVBfUEhZX0lOSVQNCj4+Pj4gICAgIHF1aXJrDQo+Pj4+ICAgdXNiOiBk
d2MzOiBob3N0OiBTZXQgdGhlIHByb3BlcnR5IHVzYi1za2lwLXBoeS1pbml0DQo+Pj4+DQo+Pj4+
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvdXNiL3VzYi14aGNpLnlhbWwgfCA0
ICsrKysNCj4+Pj4gIGRyaXZlcnMvdXNiL2R3YzMvaG9zdC5jICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB8IDQgKysrLQ0KPj4+PiAgZHJpdmVycy91c2IvaG9zdC94aGNpLXBsYXQuYyAgICAg
ICAgICAgICAgICAgICAgICAgIHwgMyArKysNCj4+Pj4gIDMgZmlsZXMgY2hhbmdlZCwgMTAgaW5z
ZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KPj4+Pg0KPj4+DQo+Pj4gVGhpcyBpcyB0aGUgbGF0
ZXN0IHNlcmllcyB3aXRoIGJpbmRpbmdzIGFkZGVkIGFzIHBlciBHcmVnJ3MgY29tbWVudC4gQ2Fu
IHlvdQ0KPj4+IHBsZWFzZSBwaWNrIHVwIHRoaXMgc2VyaWVzIGlmIHlvdSBkb24ndCBoYXZlIGFu
eSBmdXJ0aGVyIGNvbW1lbnRzLg0KPj4+DQo+Pg0KPj4gV2UndmUgaGFkIHRoaXMgY29udmVyc2F0
aW9uIGdvaW5nIG9uIGZvciBhIHdoaWxlLiBTZWVtcyB0aGVyZSdzIG5vIGdvb2QNCj4+IG9uZSBz
b2x1dGlvbiB3aXRoIGV2ZXJ5b25lIGZ1bGx5IGdldHRpbmcgb24tYm9hcmQuDQo+Pg0KPj4gSSd2
ZSB0cmllZCB0byBnZXQgc29tZSBvZiB0aGUgcXVpcmtzIG91dCBiZWZvcmUgYWxzbywgYnV0IHJh
biBpbnRvIHRoZQ0KPj4gc2FtZSBwcm9ibGVtLiBbMV0NCj4+DQo+PiBBcyBNYXRoaWFzIG5vdGVk
IFsyXSBiZWZvcmUsIG1heWJlIHdlIGNhbiBjcmVhdGUgYSBuZXcgeGhjaS1zbnBzDQo+PiBwbGF0
Zm9ybSBnbHVlIGRyaXZlci4NCj4+DQo+PiBUaGUgcHJvYmxlbSB3aXRoIHRoZSBjdXJyZW50IGlt
cGxlbWVudGF0aW9uIGlzIHBhc3NpbmcgZHdjMydzIHJlbGF0ZWQNCj4+IGluZm8gdG8geGhjaS1w
bGF0IGdlbmVyaWMgZHJpdmVyIGlzIHZlcnkgY2x1bmt5LiBXZSBjYW4gdGVhY2ggdGhlIG5ldw0K
Pj4gZ2x1ZSBkcml2ZXIgd2l0aCBhbGwgdGhlIGluZm8gbmVjZXNzYXJ5IHRvIGRyaXZlIHRoZSBj
b250cm9sbGVyLg0KPj4NCj4+IFdlIGNhbiBqdXN0IHBhc3MgdGhlIGNvbnRyb2xsZXIncyB2ZXJz
aW9uIChhbmQgc3VidmVyc2lvbikgYXMgYSBwcm9wZXJ0eQ0KPj4gZm9yIHBsYXRmb3JtIGRldmlj
ZS4gVGhpcyB3YXksIHdlIGNhbjoNCj4+DQo+PiAxKSBTZXBhcmF0ZSB0aGUgcXVpcmtzIGZyb20g
eGhjaS1wbGF0IGdsdWUuIE1vc3QgY29tbW9uIHF1aXJrcyBjYW4gYmUNCj4+IGRldGVjdGVkIGp1
c3QgYmFzZSBvbiB0aGUgY29udHJvbGxlcidzIHZlcnNpb24NCj4+DQo+PiAyKSBBdm9pZCBoYXZp
bmcgdG8gY3JlYXRlIGR1cGxpY2F0ZSAic25wcywqIiBwcm9wZXJ0aWVzDQo+Pg0KPj4gMykgR2V0
IGFjY2VzcyB0byB0aGUgY29tbW9uIHhoY2kgcXVpcmsgZmxhZ3Mgd2hpbGUgbWFpbnRhaW4gYWJz
dHJhY3Rpb24NCj4+DQo+PiA0KSBQb3RlbnRpYWxseSBhZGQgY29tcGF0aWJpbGl0eSBzdHJpbmcg
YXMgcGFydCBvZiB0aGUgY29udHJvbGxlcidzDQo+PiB2ZXJzaW9uIGFuZCBsZXQgdGhlIGdsdWUg
ZHJpdmVyIGhhbmRsZSB0aGUgcmVzdA0KPj4NCj4+IDUpIFJlZHVjZSBpbnRyb2R1Y2luZyBuZXcg
InF1aXJrcyIgaW4gdGhlIGZ1dHVyZQ0KPj4NCj4+IEkgY2FuIGdldCBzdGFydGVkIHdpdGggdGhp
cy4gTGV0IG1lIGtub3cgaWYgeW91IGhhdmUgYW55IGNvbW1lbnQuDQo+IA0KPiBTb3JyeSwgY291
bGQgbm90IHJlcGx5IGVhcmxpZXIuIFRoZSBwcm9wb3NhbCBzb3VuZHMgZ29vZCB0byBtZS4NCj4g
DQo+IFRoZSB4aGNpLXBsYXQgaXMgYSB0aGluIHdyYXBwZXIsIHNvIGhhdmluZyBhIHNlcGFyYXRl
IHdyYXBwZXIgZm9yIFNOUFMNCj4gY29udHJvbGxlciBpcyBkZWZpbml0ZWx5IG5vdCBhbiBvdmVy
a2lsbCBhbmQgZ2l2ZXMgbG90IG9mIGZsZXhpYmlsaXR5DQo+IGluIGFic3RyYWN0aW5nIGR3YzMg
c3BlY2lmaWNzLiBBbHNvIGR3YzMvaG9zdC5jIGJlY29tZXMganVzdCBhIHBsYXRmb3JtDQo+IGRl
dmljZSBjcmVhdGlvbiB3cmFwcGVyIGFuZCB4SEMgc3BlY2lmaWNzIGFyZSBjb21wbGV0ZWx5IHRh
a2VuIG91dC4NCj4gDQoNClN1cmUuIEknbGwgYmUgYXdheSBmb3IgYSBmZXcgd2Vla3MgYW5kIGNv
bWUgYmFjayBieSB0aGUgZW5kIG9mIE1heS4gSQ0KY2FuIGRvIHRoYXQgdGhlbi4NCg0KVGhhbmtz
LA0KVGhpbmgNCg==
