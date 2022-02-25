Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20EDE4C4713
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 15:07:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236075AbiBYOIT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 09:08:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbiBYOIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 09:08:16 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6849413CA05
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 06:07:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1645798062; x=1677334062;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=hyVpcm3dDJ6EyJRTse4rcFCMN/hhxCb3ghiS7mXnGMo=;
  b=mwPlZDiXU08/Fygiv5L0vUPw/vnIxg+u/WKX19hiVGrwSly4PqoAqHwh
   LhqxxHXVOjaK877w4VCSXbjJBuDkv8k0G++RpM01TUT+UzCkoLTfHeZ2h
   gR0ruqtgTaH5asEIUW/RV5sNvsNWgAah3dGnVCad6Du7SmJPIj2r+HJvF
   PEhWMq9/v7Q4JkysZn7NXeS6wqxLnofd4YNJwWO+KkGpRiLg0YawsxNOG
   SRSQBLVVmIhPdQ19MW9c5Gw0wsgzRoW6VYKKIvp496PajTWdThEuLLD/R
   3V8zhBV1J838F44+vV6nRAv+69XBkmA8ahYzfh5gziSqsa59CVEQxVzQ1
   g==;
X-IronPort-AV: E=Sophos;i="5.90,136,1643698800"; 
   d="scan'208";a="163651011"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 25 Feb 2022 07:07:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Fri, 25 Feb 2022 07:07:41 -0700
Received: from NAM12-BN8-obe.outbound.protection.outlook.com (10.10.215.89) by
 email.microchip.com (10.10.87.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.17 via Frontend
 Transport; Fri, 25 Feb 2022 07:07:41 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nUtysg4eXb5nfHGCNUNngj8dkJkklwFcJYOHYA7MPzLvKFf7LNKvxoELFHy9ZUvnp60FqI2uC3f63fFLuBP3HD98JtLBJLpBnHfpg+qzP+AXsUz8/iM2aT0kEveG1hzRxbeL7DzBXX1oOdRWnMB18h4hpHycEn1SAr4hencVUEHwmlhQ3H0MOCxMpHlhCtHBdstog7VsOUcqqoKZTAytCMxzLRyWf+nMGXniC+6DCJxYpkwdjr0nVlsOfbLB2PCxlfNHbYyI6csudW4h/DPXF4Q+RQwv4FoXf2QP0z4dLJhH29ARc7nwux4RhdWXwhIaoIdbnf4pdL7/Sn6X6fbM9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=hyVpcm3dDJ6EyJRTse4rcFCMN/hhxCb3ghiS7mXnGMo=;
 b=L0iPok0+goccVEbtCXsU6dW/eV5v1EzxzPaxmYU/SHFoXvzs0WMrtA0SuZVbna02gGOcyj59iaUbbWFqRoxXcEpXhDfjPHeOqBM3FnrXUCYdgjMIOzzmI4EjedidlvZeRJ+0g1id+ZvwYc0DNCY0UdHax2pSnixfLgs8V7bBIg3j/Dwb/pwlYVTyNrHD8HYq6TO2rrhTwYmAH0l2RqdQdO9gCcI6iG7dNGQMfoJux4t1DuQUmHqSVSv5RQfvR7dnCXBzWlaw773vr9lTV66Ftv6cJevGC3W1V/lmJIMjUOUvSmPLQ1EqG78deG8Qkl/8RxFkGqfJTIfNsNYtsppZzg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microchip.com; dmarc=pass action=none
 header.from=microchip.com; dkim=pass header.d=microchip.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=microchiptechnology.onmicrosoft.com;
 s=selector2-microchiptechnology-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=hyVpcm3dDJ6EyJRTse4rcFCMN/hhxCb3ghiS7mXnGMo=;
 b=bcz0UOioAXh02yKmG1oZvvgx+Bpl/pn1zad1kN8IschxV/AUq0sUQxTstg2vPazWT6QUFkNxcYzpqmP7A1MKnKqyYFOTNF96iBRIm4EK+1+CGCEndGBlFDiMKO/eOPvPMQl2tPaTX5XUJVjflNLNd1F7vwKQAHswVjEQyPbAp9Y=
Received: from SA2PR11MB4874.namprd11.prod.outlook.com (2603:10b6:806:f9::23)
 by BYAPR11MB3782.namprd11.prod.outlook.com (2603:10b6:a03:fd::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Fri, 25 Feb
 2022 14:07:35 +0000
Received: from SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9]) by SA2PR11MB4874.namprd11.prod.outlook.com
 ([fe80::dc94:3c7c:8ef8:21b9%5]) with mapi id 15.20.5017.026; Fri, 25 Feb 2022
 14:07:35 +0000
From:   <Tudor.Ambarus@microchip.com>
To:     <michael@walle.cc>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <p.yadav@ti.com>, <miquel.raynal@bootlin.com>, <richard@nod.at>,
        <vigneshr@ti.com>, <yaliang.wang@windriver.com>
Subject: Re: [PATCH v5 30/32] mtd: spi-nor: spansion: rename vendor specific
 functions and defines
Thread-Topic: [PATCH v5 30/32] mtd: spi-nor: spansion: rename vendor specific
 functions and defines
Thread-Index: AQHYKlEJaVIau/QtW0C1Rg7eo7auoQ==
Date:   Fri, 25 Feb 2022 14:07:35 +0000
Message-ID: <70832b80-65a6-8a39-97b5-b69881f4a439@microchip.com>
References: <20220223134358.1914798-1-michael@walle.cc>
 <20220223134358.1914798-31-michael@walle.cc>
In-Reply-To: <20220223134358.1914798-31-michael@walle.cc>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microchip.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c80dec2f-731b-48a3-49c9-08d9f8682c89
x-ms-traffictypediagnostic: BYAPR11MB3782:EE_
x-microsoft-antispam-prvs: <BYAPR11MB3782C4E3D49CCC2560092421F03E9@BYAPR11MB3782.namprd11.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0N53plikUODi72IvpJU5N1wC1HCMBeq66xpWg/q82+wnaQfHojtDyh3qsAnQcX+ti2hTzlPlZqWGbn0Ry/RFIAmH5Ev/qnsj6RTUNtb2lYirHwnfJQJAIXxRy8WZc6jatSXoUq4muEfoqwbzR7xzB+7ESL8ZKQIyFAXxR/UuOF4H16u6vjyUMAkZA6aiIsLXbRh9T9q/cQe7AYl0NQj7gtTunwamDGIEAmlv12WHPN+ppvsIKbVr/cWv6ILKWdDWbN9GVkX0ujQP3vpF/UOH6O3pnGictPDGgok2go7MstQ2iyEWHQ+WLEqVALBrhIVWUOuzfoVPBOJryECAGF8LXSRwfg3NGKpjRoEuLx31H7KqblaossuV8nPDfGPluI752ixfNhyLlLQ2TFnBW290k6yw+Ax4HSk6eCFQasVADAumSaUWwLEckmz4iJKAzJysbX+WhG76HwkfFZVZdp9CUxLdpfRBf4KIjVJApW1/wFi/NIhaBHiZt1oC6r+ZHqdZiTgkE1cPX+TLB/YGejMt4hkBZBcA3mK4k13AxFqsTEX/Vw5btdB+wpeb/mrOWLD2kS3ehs3/tQnveFdaLtuAdZ7xfmLKnJ+Ut5rmbPdYdO29RsvXpLtMRN5QNin/5oIupxsU/UX4Kjdy3ncSAYtQz7oLBnz7sRUvt0YFCfMwcEbf7R00yGGno5WCfQM1+qkYqZ3HVagQ/CPxqnucE/IPPUbTTsQq0V89HzEKSvmQaPPQ6is3vHsOnJLBgIyLCoQ4bEX/ZX/Tc+Y+5vqV9kuN3A==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR11MB4874.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(4326008)(83380400001)(186003)(76116006)(91956017)(66476007)(66556008)(66446008)(66946007)(8676002)(86362001)(64756008)(31696002)(38100700002)(122000001)(4744005)(5660300002)(26005)(38070700005)(2906002)(8936002)(6506007)(6512007)(2616005)(6486002)(53546011)(508600001)(36756003)(31686004)(316002)(54906003)(71200400001)(110136005)(45980500001)(43740500002);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?U3FSTXhZZVBUMjBBUENPZDhTVW5OTUhHTUphN3NKWmVUcklzc1pMZW9MVmQx?=
 =?utf-8?B?dWdtQWhpRXlFZ0VzaDJZWWpxdTZ6QlhSdEVZemsrWHFCeHZpN01Oa1Jzd2Vq?=
 =?utf-8?B?a01CVXBXTVJ6TmdVME5nTGNPckY4RVJvSElvdnpwZGE3WWVKa3ZwVUMwYWR4?=
 =?utf-8?B?V3UwYllDYm56NHl6aUJteVlhMFpmeVBib294OHg4T3k2bU5UWURNOGpPZytX?=
 =?utf-8?B?c2wvaDV6ME5vMmRDODZ5bDNjQnMyTUdzY213aFpWVllxWDFrMURRQ3UrbEYw?=
 =?utf-8?B?Q2t3cDlnaXRCK3VUL2d4TWc4bXowWlFoNUt4WjQyRXpmSm1GRzNxSGkvb25z?=
 =?utf-8?B?c3Y5enpiSGwxb0hmMnUybU94aFNjYjI1dDZXYTlsanlySE1iYjJwV3J1b3pw?=
 =?utf-8?B?MHlsTHdoaEJ6YmMvd3kybURFUGJlOUlGTG8xWTJMc09xTFZNR3d6YXJlb21J?=
 =?utf-8?B?Y1RvVWpZaTRzZTdkOEhiYlRHQStMdUh5MjREWkJwOUdBNWpmVVlaMVI5Umpq?=
 =?utf-8?B?azZtODJsWG9jcEdDVDAzMnVGeVByOTVNNkRXTSs3ajUzV1lBeDY3cTJaTjZ1?=
 =?utf-8?B?UVphTmdYSGFhZGYxVUNRQnEwc0RweVh2OXY0eWNQelQ3MERjVmZHa0JqdTlV?=
 =?utf-8?B?OTJLN015SCt6RDNNdzhGNkJDNmw1d0ZwSDdjMkxrQzF6dXVoeGJGR0dpV2Rz?=
 =?utf-8?B?Q3BhRXY4ay93RmttQzJWMXR5cVo0dkFxT0duSGQwbU5DS0d3MmdHTmtrT3h5?=
 =?utf-8?B?SW1raW1ZTlhJNEh3SkJ0aStFN29sUGFpQ3lVM29WNElYTjJzNmtuYnRhNmJC?=
 =?utf-8?B?bXZQTE0vTGZxZjJMUFFGUW5KcnQ1ay9SUlhST05UcFhYUHBqWnFjZE5sZ0VZ?=
 =?utf-8?B?eEZkdkRBSFBnK0Z5a0ZPeFZ6dXZYVmVoa1FGN1lDY2hmWjNveS9ybW1aMUYy?=
 =?utf-8?B?aEdIazJtb0x5WG5DWENiZGV5blhrK1JjKzVIekxjdEZZMndIQnYrV2E0cVhJ?=
 =?utf-8?B?SEdJWnlZVEJVcFd1UDExU0lSK3dEaXdnL0tDVWN4M2RvV0sraHU2UzM3R3dv?=
 =?utf-8?B?OEkvZXowUGtJd01qQzdLcDlsSmxyamlLMTArMTVPa2VCQjllYTR2dzVPc3BP?=
 =?utf-8?B?cGdPSUI2MjN6dStrK2ZXNzZOcFBXQWVCNXNWU3NKSHBESDRRK2RxVjBlM3Ay?=
 =?utf-8?B?MGI4dmovVGM4aWxKcGZnNXdMdkgrbmpRNFZXQ2Y3aEJWd0U4N2hHc0NXeXhG?=
 =?utf-8?B?b21mL2R5WE9YVFYvd0t5bHZjS2gyaytEbHROOE9yV0dVN21NMmJKNXpXUlgw?=
 =?utf-8?B?U1pNbE12bFdrSFBpelB4U0NRdDdXZE9oTjhGQ2NUVnZ3Um5uTFUwYnZiQ3hR?=
 =?utf-8?B?bjVDN1U0dE0zY2pSM2NUSzlteWRSNkZSdmZJd3daY2JTSld0NUxUOWcrSFhK?=
 =?utf-8?B?YzJTTExPUlA2eElqRUxQd3VhWjB4OVd2QlZLQXRZOVI1QjVlTXRnUzlZeGJt?=
 =?utf-8?B?SDZOcERLNkJ5MGF1SmVGNjlHazRITGMxUExEUHdnTUxtV2QzVXNsMmJZUjhh?=
 =?utf-8?B?cjRGOC9VeVZpK05CTDM4WGRTSmpuODBEN1gxVFdyQXlmcCtTQkpOSnhWQjQy?=
 =?utf-8?B?VjczNitxdDVEYVc1bmhwelRpRjdrRFNpRGZ0eXFVOXdTY3MvZXNrR1BpVHFl?=
 =?utf-8?B?MnNEc09lcisrTkRhclpVTFFkSEl1RTUxYWphNHFBdFpzcjkwNzlsaWNKSDV2?=
 =?utf-8?B?amJjeExhTmZRU0hiQjI5ZlIvQmlNblJkdEZlRW04VXF1bC9sVUdkTjJ6eno1?=
 =?utf-8?B?b3c0K3FYb2VXLzhUcUhRQjF1NkIybkZnSlU5czhEQXJjbzh4a0p2REJ1clFE?=
 =?utf-8?B?NkVkRGg1dlhSa0xDWWthbzVPS1ltVW1LbUZldlRZQlR0LzEyL2Y2d2xnZDFF?=
 =?utf-8?B?RVVxTll1alNrZGlRdmxkdmI3M1hudDhXQlVOSTJpU3RzRmxmVUUzU2Nia3dC?=
 =?utf-8?B?Mzdpc01NNnVEMnlhemJwK25YTUUyNm5TSlJwY0I4MERDUlViZERaczk5d1Yz?=
 =?utf-8?B?NDdVd1ZjRXZUY2p1YUJTYU9NL0xGY1VzNno2MEYvUUNxbDFKeW92cmhBVjZM?=
 =?utf-8?B?ZURqdHhMWkhaSTVpR0hjcVU4MTFWZ1FXU0VqT1Z3V3lzOVNQdnpxUldzY3Z2?=
 =?utf-8?B?ZTRwMG5rb0dWNnBCR1JuMHVINVJxR2lDS1BrWVp1d1Zmd3RHSmpORE15Y0tE?=
 =?utf-8?B?Y0MyNkdZRlI4cDUwMlpCVmFjWENBPT0=?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <457FD7D1C8159C4BA57F61B89BCECE58@namprd11.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SA2PR11MB4874.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c80dec2f-731b-48a3-49c9-08d9f8682c89
X-MS-Exchange-CrossTenant-originalarrivaltime: 25 Feb 2022 14:07:35.6024
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 3f4057f3-b418-4d4e-ba84-d55b4e897d88
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: lPUJRwLOTxcC03nmlAGeN4ZIGYj3VBlHogYscdjvw3EXnPFEIxJaj2TLsCzzyunalnQ9uUUM+lbBNhadcGSE74Xr/OPPp7KznNh6+NXT4cw=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR11MB3782
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

T24gMi8yMy8yMiAxNTo0MywgTWljaGFlbCBXYWxsZSB3cm90ZToNCj4gRVhURVJOQUwgRU1BSUw6
IERvIG5vdCBjbGljayBsaW5rcyBvciBvcGVuIGF0dGFjaG1lbnRzIHVubGVzcyB5b3Uga25vdyB0
aGUgY29udGVudCBpcyBzYWZlDQo+IA0KPiBEcm9wIHRoZSBnZW5lcmljIHNwaV9ub3IgcHJlZml4
IGZvciBhbGwgdGhlIHNwYW5zaW9uIGZ1bmN0aW9ucy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IE1p
Y2hhZWwgV2FsbGUgPG1pY2hhZWxAd2FsbGUuY2M+DQo+IFJldmlld2VkLWJ5OiBQcmF0eXVzaCBZ
YWRhdiA8cC55YWRhdkB0aS5jb20+DQo+IFRlc3RlZC1ieTogUHJhdHl1c2ggWWFkYXYgPHAueWFk
YXZAdGkuY29tPiAjIG9uIG10MzV4dTUxMmFiYSwgczI4aHM1MTJ0DQo+IC0tLQ0KPiAgZHJpdmVy
cy9tdGQvc3BpLW5vci9zcGFuc2lvbi5jIHwgMTQgKysrKysrKy0tLS0tLS0NCj4gIDEgZmlsZSBj
aGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9tdGQvc3BpLW5vci9zcGFuc2lvbi5jIGIvZHJpdmVycy9tdGQvc3BpLW5vci9z
cGFuc2lvbi5jDQo+IGluZGV4IDMyZDMzMDFjZTM4NS4uZjI0ZTU0NmUwNGE1IDEwMDY0NA0KPiAt
LS0gYS9kcml2ZXJzL210ZC9zcGktbm9yL3NwYW5zaW9uLmMNCj4gKysrIGIvZHJpdmVycy9tdGQv
c3BpLW5vci9zcGFuc2lvbi5jDQoNCnlvdSBmb3Jnb3QgdG8gcmVuYW1lIHRoZSBkZWZpbmVzDQo=
