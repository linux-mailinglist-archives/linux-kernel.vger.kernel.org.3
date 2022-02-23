Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A684C09C5
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 03:59:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237067AbiBWC7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 21:59:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbiBWC7u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 21:59:50 -0500
Received: from smtprelay-out1.synopsys.com (smtprelay-out1.synopsys.com [149.117.87.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C39B053E13;
        Tue, 22 Feb 2022 18:59:22 -0800 (PST)
Received: from mailhost.synopsys.com (sv1-mailhost2.synopsys.com [10.205.2.132])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "mailhost.synopsys.com", Issuer "SNPSica2" (verified OK))
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 8E436C2297;
        Wed, 23 Feb 2022 02:59:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1645585162; bh=KUYGJEEXoLHwSOsAsjKMSzckiLP2JzomW0yc3XYOAaw=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=SkNi1gwH30tjSe3+ioR5PrGKsTi9zMnR28eBUFLHTqudpZw4hdO2St5xUkIrlw0WT
         +0dJ76CwkhNKd503xG7fC0y3GOcbxai0jHnLnCi0r+tGjsXPKYKrHxAl4sxpmakeGY
         MVe1V/kxhan8W/MoWA4XXoRq/46/LYiMeOMbjxi2LRKBB1/3MEjthh8sghZS8dKbOS
         BpgjbzCnqKpmLY5yY+o0Q0SKETHnKon8PWDSjY9VS6zeTNhLckKA+TnzwaQHd/FVHy
         X+Rj9rds+BKA4nWOokjzvETuw74J+6ZlOuSByYtoCw06V9pQWVGssXQYOb26OyF8ho
         bJozH7zVCc2/g==
Received: from o365relay-in.synopsys.com (us03-o365relay3.synopsys.com [10.4.161.139])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (Client CN "o365relay-in.synopsys.com", Issuer "Entrust Certification Authority - L1K" (verified OK))
        by mailhost.synopsys.com (Postfix) with ESMTPS id 1BF09A0070;
        Wed, 23 Feb 2022 02:59:19 +0000 (UTC)
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "mail.protection.outlook.com", Issuer "DigiCert Cloud Services CA-1" (verified OK))
        by o365relay-in.synopsys.com (Postfix) with ESMTPS id 415F58014D;
        Wed, 23 Feb 2022 02:59:17 +0000 (UTC)
Authentication-Results: o365relay-in.synopsys.com; dmarc=pass (p=reject dis=none) header.from=synopsys.com
Authentication-Results: o365relay-in.synopsys.com; spf=pass smtp.mailfrom=thinhn@synopsys.com
Authentication-Results: o365relay-in.synopsys.com;
        dkim=pass (1024-bit key; unprotected) header.d=synopsys.com header.i=@synopsys.com header.b="KY32uMAp";
        dkim-atps=neutral
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=NfE34JL6ifhnTwvH1OyfpkWlT64RGevjSvMgDdof4Z3d31ax8Ba/8ktk/ahFz+++Ie+fDjEmZ3qfVNHc3ipXShwLeZTTj9Sgg11T3C6ZSfxGXYis3ddU+5Lr851jd3Cr9N84Q1xC7i4edNBQA0JZpY1UmbaRUL9tx0UFufnEwpbRtbOVk4PJ51OL7m08ySc8Q3KG0MzLkPd9vCzgJBBdaZapbBlwL69D/KKHKX9Art1j1BM/hnBBm8NdClpzYGHCZbBLsFYnMLj7edAYpq6/5UvfOPy8pXWowfiwO1lO8Zbos2q1P6gxiyoNleWQ7YOHa8ZELVDFdejqmil+GKoGLg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KUYGJEEXoLHwSOsAsjKMSzckiLP2JzomW0yc3XYOAaw=;
 b=VJVvjIlguYlkI9JvmCmrSuxz1q/RjiRRu+dCuyH8NAckYAa0T/pmY/0GyXIdhOAb7dvZspyR98pBvBwcNoOQTa8f9rUPAVRG1qUfcr6HETQDSZuY6bbc1e0EjbIifg0fr5wDgXaA01US442rye2pnWXgn6KMLRKVB4vazpUwpk/gljgdqXLD7X6w04tGRqVbGuzcBlBnC5c/kZD9wfUDFFCUCvo8089vo6BW0roQnAqEh2N6SPeGJG/HUqym8HaNO5qGR0KfdXm+5wU5VF1+Hy4nlFHnbzNvf/dVxBguGr1hrWG9lASslOca8/RxpgNCZoACd1w0Ffgs8zo3WusPUA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=synopsys.com; dmarc=pass action=none header.from=synopsys.com;
 dkim=pass header.d=synopsys.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=synopsys.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KUYGJEEXoLHwSOsAsjKMSzckiLP2JzomW0yc3XYOAaw=;
 b=KY32uMAp6I0/gSlMiQkd+VFVeWkIwmdDf2Wv66kQg3RjXBfrI/4XSHLINeR0xTBRzlwT2OWJO9pIRXe2FWOiEqyB1PHawg/WukoqxYmmjnEBLNm9R/wZt019hyTFa1odFeqHUjBDS92loqWvcqQjhlAmSpCegmQYywef14ae6Fw=
Received: from BYAPR12MB4791.namprd12.prod.outlook.com (2603:10b6:a03:10a::12)
 by BYAPR12MB3509.namprd12.prod.outlook.com (2603:10b6:a03:13b::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.24; Wed, 23 Feb
 2022 02:59:14 +0000
Received: from BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e]) by BYAPR12MB4791.namprd12.prod.outlook.com
 ([fe80::c5f4:5df4:b5bf:b13e%3]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 02:59:14 +0000
X-SNPS-Relay: synopsys.com
From:   Thinh Nguyen <Thinh.Nguyen@synopsys.com>
To:     Wesley Cheng <wcheng@codeaurora.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
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
Thread-Index: AQHYIZOvXlHACGixbUGMAnHCl5PyK6yTYqcAgADHvYCAALGHgIADVGEAgAA82ACAB34VgIAAlEuA
Date:   Wed, 23 Feb 2022 02:59:14 +0000
Message-ID: <894d54ad-b6f9-b942-be99-fe3ad102051b@synopsys.com>
References: <1644836933-141376-1-git-send-email-dh10.jung@samsung.com>
 <CGME20220214111149epcas2p1a1faeda037991885fd6f2f026fa44ec5@epcas2p1.samsung.com>
 <1644836933-141376-2-git-send-email-dh10.jung@samsung.com>
 <ff604504-00df-0c1b-673e-892e42737f7a@synopsys.com>
 <20220215063925.GC144890@ubuntu>
 <63c8c9d1-9b07-a9f2-3639-a38641e19a7a@synopsys.com>
 <6a1322c4-9589-f4de-d42c-d38af2e12e82@quicinc.com>
 <e3332511-82d3-2892-ad72-a0c167273174@synopsys.com>
 <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
In-Reply-To: <01c4d42e-93cd-d293-f4e3-8c136049d87c@codeaurora.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
user-agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=synopsys.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 1113c6e8-29c6-462f-7df3-08d9f67879b4
x-ms-traffictypediagnostic: BYAPR12MB3509:EE_
x-microsoft-antispam-prvs: <BYAPR12MB3509581B6C6B8937B3F6EDE7AA3C9@BYAPR12MB3509.namprd12.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 0GLxk6vim0iuAu4T+2tMS1XznsSwTOCSG7UAOuS9kv/dl4VYuaS63parFKet0kHrX34Q+zHtr5MurzQrpNSgOKVKtGbfubdgNLdaFQFLpBT492d5zGofOiBaH22FV0kVYEMcHxNc08DUanvUVRX3bTMPmrT6qebUSU1So8SDOrBubksoXxJKWG+RasUuJaY9238S7mc8pazvYa+koNn5/V5EizCFylb6IJ0N4qdx61y3Ai39tr1kqHCLE3QNzN7PiBVCf4LDEVjx2ddCz1En84V9ySrBMOphNWBKej/GrzPOJoWJ5uU5QpuaDx9qq7NHiE05kdkmIfyTtgaKkujvXxBj6XnO1s8krj7PJfoh8ay24isEkk9kl7vntCkPoOxCpZNIvp3QjVjBJBqIiL9s3yh06k1+Rd69Cju4DjiWB+YZ+AKoOMG6nw7GyNMhHdhNuUFidY3nMosuxU6Gug67WATmuyUyeHWgDdd4Q467eBjnSLMjBi1tOQA6nm/ZAeZB9vGySYXYB7o4JvSknuvS9fYTjcoaO8tPTE0jUxEOG4kyQPZFI5RRsRNY5sh2R5Q2mUn3AB1mbzwsHyn6KuojTUFlxLe4SgWvPyIIvLGjXZ0gI7OfeQntuQ8RFnd+hYru0TLimGN9KlhOfSsxTpYnfwVX778N8cO2qesAieLPCwJTkKBl7YJyva3YtBnnaiCIgy3JhE8Z7ZHtL1WFVD7wXjXDkNlLdMiCOI0jfAMLv19wcXnTOZ8/AckyLoWxR86e2c1U4AjzPuPfz8Z/f3zpDC3DCwnRo2rlSd+whP/ahmiXkDXwbAYeFa0bdjwnmzaySk8j4APO0WholtiUitwzMRUNiemNfg3KXWlPTrtxBBg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB4791.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(186003)(26005)(66556008)(6512007)(66946007)(76116006)(6506007)(2616005)(53546011)(966005)(6486002)(31696002)(86362001)(54906003)(508600001)(66446008)(316002)(110136005)(64756008)(8676002)(71200400001)(66476007)(122000001)(38070700005)(83380400001)(4326008)(38100700002)(5660300002)(31686004)(2906002)(8936002)(36756003)(45980500001)(43740500002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?eEpMVllsY3FJVXRaZmpMdHVlRXQvQUFGWmxhblpsOVBZK1hTL3poL2lXeS9x?=
 =?utf-8?B?WHhxODI3cjdZZ0pEQXlST3Rqazh5ODc1RXZtV2ZEOFpDN2FnR0JRTHdzSDdq?=
 =?utf-8?B?MkY2WlpsY0ozYjdUQkhUSmYwcE1SMGx3S29yN2lyUFRzaVRnVC9yOWJXVXhu?=
 =?utf-8?B?aEFPSTdMd2FuOTJHa0lYdWpTRkUrd2xRRGxTdklDRGFOYlc3TWZIeElMcHpG?=
 =?utf-8?B?RWFtRy9YNU82RE11dkpNU3lBc3U5bmd0WjgxcXFCUkl4MlQ4NUlxRldGeUdT?=
 =?utf-8?B?UkUrSXpaaThMUW5vTk9kTlo4Z29IQjBNNE5hUllxcm94dFY0alVvUTJaV2RD?=
 =?utf-8?B?Z3J1Tnl3QmpFT3lJUFlWM2xhT3NXSUtGWnZCajRUemhha3RER1d2eVcyeGIy?=
 =?utf-8?B?QnpBRm5LRm5xVW0wemR3NHY2WDhFUTZab2Z2NUNKdERkOGQzaGJ4cEs2cjJq?=
 =?utf-8?B?RE9icDVpczFYYjdTQzVRRHdxS0ViRTB5WGNlMVRVSEJLOUNoL0RHYmZ1cVVI?=
 =?utf-8?B?UVgyUE9FR0ZvQnhFSlU3RllHRVhQdkVsd3NXZmNaYkllSWhOdmNUTG9sYTVl?=
 =?utf-8?B?MzBNdmhwNnBVekVOS29saDY2ZHBLdkJTYW1za0hqeXhnNnJXTmxRQy83Skw4?=
 =?utf-8?B?UmRIRXFMOUl0MDVBeWJ0YUtsWXlZVEI3QnVCK0U4U2JkOTdyZk94dmpMM3Jr?=
 =?utf-8?B?d2djSVV5UDYyWEo1cHcxMmNtTVErYlJ6VG8xcXN6OUdXVEJVZG0ra1I5ZDJR?=
 =?utf-8?B?dUlSK0UrRCtlNDh6RTIya3piN1VFMkd1VXlTV25HZ2tJeVZUWjQxblI1azdh?=
 =?utf-8?B?NVRPRUJvaW5MWUNkMkpoL0FFM0F4S2pUNkF5VGlRSXlaZVpPNXRUc3N0eDdS?=
 =?utf-8?B?dGRRK29yaldmRTV0M2dEd0RjYTBYLzRpWmU0UWJ0SkRiNHM2S3l1MVR0K016?=
 =?utf-8?B?c3k3YUM0WVdYZWJ4cWE2N3d0azg3VnBJZ0VlRW4yNzFMTU83djRST28vckNP?=
 =?utf-8?B?TEVmY3Iyc0RjbmRncmt2NmN6eDJlWHZJUitYbmt3bUw3a0tpVi9FWmYybXZD?=
 =?utf-8?B?OXk2MUtRcVZQTjhYWkhEN3crMlpTOWowUkNzVWNWSkpIZzl6UDJVcUNLaXNr?=
 =?utf-8?B?dTBoTXhyeUhPcmh6TnNkVncrLzJuNDJmZFh1NDI0dEhkMFI0MUFjYWVXNC90?=
 =?utf-8?B?TUhvTnMvaVpmK1RYa05PK2ZpS2hRRkZIaGZydERxSVdRUXJKL3pnVjYwNk0r?=
 =?utf-8?B?Nzk0OXhxWFJYNWpuVzRyRGtTODBmbXZVUXpsZGsvWnNrZm0rWGJ5ZUxZbHc1?=
 =?utf-8?B?OVpwRnF2VUk3Zzh1UEJSdzJrZ1lmK3BrZnphU05KRkZxbkNnM3Qxdk5udVJ6?=
 =?utf-8?B?ZkVTTWgxQURLVDFGYXJEV2pHWTFTekFvSVFPVlpFU2hVazNpZ2dQVTZmb0JT?=
 =?utf-8?B?ZG1rY1VxYzlSbmJrY24zZ1JYMUx0WHZHNURuUFZSUXEvQ1NvbDQ0RnhrL1lI?=
 =?utf-8?B?M3ZGdUdzUTAzUmpOSE9UUExuSldqUkdXRmtZUy9YbHR1Q0dBbS9TMkRaa0Jl?=
 =?utf-8?B?UzdsblFSMUM2S2lWdmVkeHlIam9sUWJhb0laR0xQVTN1Z05OZjVTRzFDayt0?=
 =?utf-8?B?Z1k4UVFhZGJmVUtnSnpBd0RqOUFINnRkYmVhMTFNZ3VNYmVSei9pQ0xDcU5K?=
 =?utf-8?B?MVd0OVJObXhQZXFEUFl1bTVzVVhaUmxYWExuUTEwNDZLN3JCbmFEQ0hJWVRZ?=
 =?utf-8?B?U1ZVcEQ2Ynl0YWlNV0J3bEM5dkl3ZS84Q2VYcnFENmRZT3lXWktiRUlMcWlX?=
 =?utf-8?B?RzhaUEt5SlR0OVFZcHQzV2xKN3cyakE5MmFTWVZmY0hJbzVjL2sxOW1uLzdw?=
 =?utf-8?B?VWJiMHh5MFkvUmJidWdJNlE3N0NlTVVZYkR0dnV2dHpHR2hQOERDMzNPeDRY?=
 =?utf-8?B?Q3o3cWtyem8vbUZQcjhpQVdHR0lRSDlvWFYwWHUzMUxGcDhpZW0ycUJDTm1m?=
 =?utf-8?B?ZGppQldNNU0zSm5sdWdvTnJ2S1hSazAyUm44NHZlclRia2Z1ZWZWK0VXWE91?=
 =?utf-8?B?anEyNFN6SFMwN01IMnJhZ2JNNXlVcTVMbm5ZVC9sT3hURGtLcUVCbHZsaWNr?=
 =?utf-8?B?MXlMam5MNk9DZEVSemZ5MnBURnZSNDRySjR0MVZVTy9pWkxsbk4rb3I3Vk1I?=
 =?utf-8?Q?2qsj0r5Txi+du0zdQ6eWsYs=3D?=
Content-Type: text/plain; charset="utf-8"
Content-ID: <DED5F632E3135A448CAE6ED50827FA4F@namprd12.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: synopsys.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB4791.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1113c6e8-29c6-462f-7df3-08d9f67879b4
X-MS-Exchange-CrossTenant-originalarrivaltime: 23 Feb 2022 02:59:14.4578
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c33c9f88-1eb7-4099-9700-16013fd9e8aa
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: JPHXXT6WGhfe1wN6rupYODqunmgAv8BUABd7iB/9IrEgcDxQM++WoYOpQnQ6SuzkTRzugyyH7nH382Liu2wcWQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3509
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGkgV2VzbGV5LA0KDQpXZXNsZXkgQ2hlbmcgd3JvdGU6DQo+IEhpIFRoaW5oLA0KPiANCj4gT24g
Mi8xNy8yMDIyIDM6NDMgUE0sIFRoaW5oIE5ndXllbiB3cm90ZToNCj4+IFdlc2xleSBDaGVuZyB3
cm90ZToNCj4+PiBIaSBUaGluaCwNCj4+Pg0KPj4+IE9uIDIvMTUvMjAyMiA5OjE0IEFNLCBUaGlu
aCBOZ3V5ZW4gd3JvdGU6DQo+Pj4+IEp1bmcgRGFlaHdhbiB3cm90ZToNCj4+Pj4+IEhpIFRoaW5o
LA0KPj4+Pj4NCj4+Pj4+IE9uIE1vbiwgRmViIDE0LCAyMDIyIGF0IDA2OjQ0OjMzUE0gKzAwMDAs
IFRoaW5oIE5ndXllbiB3cm90ZToNCj4+Pj4+PiBIaSwNCj4+Pj4+Pg0KPj4+Pj4+IERhZWh3YW4g
SnVuZyB3cm90ZToNCj4+Pj4+Pj4gSXQgYWx3YXlzIHNldHMgRFdDM19FUF9FTkRfVFJBTlNGRVJf
UEVORElORyBpbiBkd2MzX3N0b3BfYWN0aXZlX3RyYW5zZmVyDQo+Pj4+Pj4+IGV2ZW4gaWYgZHdj
M19zZW5kX2dhZGdldF9lcF9jbWQgZmFpbHMuIEl0IGNhbiBjYXVzZSBzb21lIHByb2JsZW1zIGxp
a2UNCj4+Pj4+Pg0KPj4+Pj4+IEhvdyBkb2VzIGl0IGZhaWw/IFRpbWVkIG91dD8NCj4+Pj4+DQo+
Pj4+PiBZZXMsIHRpbWVkIG91dC4NCj4+Pj4+Pg0KPj4+Pj4+PiBza2lwcGluZyBjbGVhciBzdGFs
bCBjb21tbWFuZCBvciBnaXZlYmFjayBmcm9tIGRlcXVldWUuIFdlIGZpeCB0byBzZXQgaXQNCj4+
Pj4+Pj4gb25seSB3aGVuIGVwIGNtZCBzdWNjZXNzLiBBZGRpdGlvbmFsbHksIFdlIGNsZWFyIERX
QzNfRVBfVFJBTlNGRVJfU1RBUlRFRA0KPj4+Pj4+PiBmb3IgbmV4dCB0cmIgdG8gc3RhcnQgdHJh
bnNmZXIgbm90IHVwZGF0ZSB0cmFuc2Zlci4NCj4+Pj4+Pg0KPj4+Pj4+IFdlIHNob3VsZG4ndCBk
byB0aGlzLiBUaGluZ3Mgd2lsbCBiZSBvdXQgb2Ygc3luYy4gSXQgbWF5IHdvcmsgZm9yIDENCj4+
Pj4+PiBzY2VuYXJpbywgYnV0IGl0IHdvbid0IHdvcmsgZm9yIG90aGVycy4NCj4+Pj4+Pg0KPj4+
Pj4+IFBsZWFzZSBoZWxwIG1lIHVuZGVyc3RhbmQgYSBmZXcgdGhpbmdzOg0KPj4+Pj4+DQo+Pj4+
Pj4gMSkgV2hhdCBpcyB0aGUgc2NlbmFyaW8gdGhhdCB0cmlnZ2VycyB0aGlzPyBJcyBpdCByYW5k
b20/DQo+Pj4+Pj4NCj4+Pj4+IGVwIGNtZCB0aW1lb3V0IG9jY3VycyBvbiBkZXF1ZXVlIHJlcXVl
c3QgZnJvbSB1c2VyIHNpZGUuIEVuZCBUcmFuc2ZlciBjb21tYW5kDQo+Pj4+PiB3b3VsZCBiZSBz
ZW50IGluIGR3YzNfc3RvcF9hY3RpdmUgdHJhbnNmZXIuDQo+Pj4+DQo+Pj4+IEF0IHRoZSBoaWdo
IGxldmVsLCB3aGF0J3MgdHJpZ2dlcmluZyB0aGUgcmVxdWVzdCBkZXF1ZXVlPyBJcyBpdCBmcm9t
IGENCj4+Pj4gZGlzY29ubmVjdCwgY2hhbmdlIG9mIGludGVyZmFjZSwgb3Igc2ltcGx5IGZ1bmN0
aW9uIGRyaXZlciBwcm90b2NvbCB0aGF0DQo+Pj4+IGNoYW5nZXMgaXQuDQo+Pj4+DQo+Pj4+IFdo
YXQgYXBwbGljYXRpb24gd2FzIHVzZWQgdG8gdHJpZ2dlciB0aGlzPw0KPj4+Pg0KPj4+IFNvcnJ5
IGZvciBqdW1waW5nIGluIGhlcmUsIGJ1dCBsb29rcyBsaWtlIERhZWh3YW4gaXMgcnVubmluZyBp
bnRvIGENCj4+PiBzaW1pbGFyIGlzc3VlIEkgYW0gc2VlaW5nIGFzIHdlbGwuDQo+Pj4NCj4+PiBB
dCBsZWFzdCBpbiBteSBzY2VuYXJpbywgdGhlIGRlcXVldWUgaXMgY29taW5nIGZyb20gYSBmdW5j
dGlvbiBkcml2ZXINCj4+PiB3aGljaCBleHBvc2VzIGEgZGV2aWNlIHRvIHVzZXJzcGFjZS4gIE9u
Y2UgdGhhdCBkZXZpY2UgaXMgY2xvc2VkLCBpdA0KPj4+IHdpbGwgaXNzdWUgYSBkZXF1ZXVlIG9u
IGFsbCBwZW5kaW5nL3N1Ym1pdHRlZCByZXF1ZXN0cy4NCj4+DQo+PiBEZXF1ZXVpbmcgcmVxdWVz
dCBpcyBjb21pbmcgZnJvbSB0aGUgZnVuY3Rpb24gZHJpdmVyLCBidXQgd2hhdCBjYXVzZXMNCj4+
IHRoZSBkZXF1ZXVlLiBGb3IgZXhhbXBsZSwgdGhlIEVuZCBUcmFuc2ZlciBjb21tYW5kIGR1ZSB0
byBhIGRpc2Nvbm5lY3QNCj4+IG1heSBnaXZlIGEgZGlmZmVyZW50IGNsdWVzIHRoYW4gYSBkZXF1
ZXVlIGZyb20gYSBjaGFuZ2Ugb2YgaW50ZXJmYWNlLg0KPj4NCj4gRm9yIHVzLCBvbmNlIHRoZSBh
cHBsaWNhdGlvbiBleGl0cywgdGhlIGNvcnJlc3BvbmRpbmcgdXNlcnNwYWNlDQo+IGRldmljZS9w
b3J0IGlzIGNsb3NlZC4gIFRoaXMgdHJpZ2dlcnMgdGhlIGZ1bmN0aW9uIGRyaXZlciB0byBjbGVh
biB1cA0KPiBhbnkgcGVuZGluZy9xdWV1ZWQgVVNCIHJlcXVlc3RzLiAgSXQgZG9lc24ndCBoYXZl
IGFueSBhc3NvY2lhdGlvbiB3LyBhbnkNCj4gVVNCIGNhYmxlIGRpc2Nvbm5lY3QsIG9yIGludGVy
ZmFjZSBjaGFuZ2UgaW4gdGhpcyBjYXNlLCBpdCBpcyBjb250cm9sbGVkDQo+IHNvbGVseSBvbiB0
aGUgYXBwbGljYXRpb24gZXhpdGluZy9zdG9wcGVkLg0KPj4+DQo+Pj4+Pg0KPj4+Pj4+IDIpIEFy
ZSB0aGVyZSBvdGhlciB0cmFmZmljcyBwZW5kaW5nIHdoaWxlIGlzc3VpbmcgdGhlIEVuZCBUcmFu
c2Zlcg0KPj4+Pj4+IGNvbW1hbmQ/IElmIHNvLCB3aGF0IHRyYW5zZmVyIHR5cGUocyk/DQo+Pj4+
Pj4NCj4+Pj4+IEkgaGF2ZW4ndCBjaGVja2VkIGl0IHlldC4gDQo+Pj4+DQo+Pj4+IENhbiB5b3Ug
Y2hlY2s/DQo+Pj4+DQo+Pj4gRm9yIHRoZSBjYXNlcyB3aGVyZSB3ZSd2ZSBjb2xsZWN0ZWQgYSBj
cmFzaCBsb2csIHdlIGNhbiBzZWUgdGhhdCBkdXJpbmcNCj4+PiB0aGUgRU5EIHRyYW5zZmVyIHRp
bWVvdXRzIHRoZXJlIHdhcyBhbHdheXMgYSBwZW5kaW5nIEVQMCB0cmFuc2FjdGlvbi4NCj4+PiBX
ZSBoYWQgcmVhY2hlZCBvdXQgdG8gb3VyIGludGVybmFsIEhXIGZvbGtzIHRvIGdldCBzb21lIGlu
cHV0cyBvbiB3aGF0DQo+Pj4gY291bGQgYmUgY2F1c2luZyB0aGlzIGtpbmQgb2YgaXNzdWUsIGFu
ZCB3ZSB3ZXJlIGFibGUgdG8gZ2V0IHNvbWUNCj4+PiByZWNvbW1lbmRhdGlvbnMgZnJvbSB0aGVp
ciBTeW5vcHNpcyBQT0NzLg0KPj4NCj4+IEl0J3MgIlN5bm9wc3lzIiA6KQ0KPj4NCj4gU29ycnkh
IDopDQo+Pj4NCj4+PiBJdCB3YXMgbWVudGlvbmVkIHRoYXQgaWYgdGhlcmUgd2FzIGFuIGFjdGl2
ZSBFUDAgdHJhbnNmZXIsIGFuIGVuZA0KPj4+IHRyYW5zZmVyIGNvbW1hbmQgb24gYSBub24tY29u
dHJvbCBFUCBjYW4gZmFpbCB3LyB0aW1lZCBvdXQuDQo+Pj4NCj4+DQo+PiBXaGF0IGNvbnRyb2xs
ZXIgdmVyc2lvbiBhcmUgeW91IHVzaW5nPyBBbmQgd2hhdCB2ZXJzaW9uIGlzIEp1bmcgdXNpbmc/
DQo+PiBEbyB5b3UgaGF2ZSB0aGUgU1RBUiBudW1iZXIgb2YgdGhlIGlzc3VlLiBJZiB5b3UncmUg
dXNpbmcgYSBkaWZmZXJlbnQNCj4+IHZlcnNpb24gdGhhbiBKdW5nJ3MsIHRoZW4gaXQgbWF5IG5v
dCBiZSB0aGUgc2FtZSBpc3N1ZS4NCj4+DQo+IFdlJ3JlIHVzaW5nIDEuOTBhLg0KPiANCj4+Pj4+
DQo+Pj4+Pj4gMykgSGF2ZSB5b3UgdHJpZWQgaW5jcmVhc2luZyB0aGUgdGltZW91dD8NCj4+Pj4+
Pg0KPj4+Pj4gTm8sIEkgaGF2ZW4ndC4NCj4+Pj4NCj4+Pj4gQ2FuIHlvdSB0cnkgdXAgdG8gMTAg
c2Vjb25kcyAoanVzdCBmb3IgZXhwZXJpbWVudCkNCj4+Pj4NCj4+PiBJJ3ZlIHRyaWVkIHRoaXMg
dG9vLCBhbmQgaXQgZGlkIG5vdCBoZWxwLg0KPj4+DQo+Pj4+Pj4gQlIsDQo+Pj4+Pj4gVGhpbmgN
Cj4+Pj4+Pg0KPj4+Pj4NCj4+Pj4+IFRoaXMgaXNzdWUgb2NjdXJzIHZlcnkgcmFyZWx5IG9uIGN1
c3RvbWVyLiBJIG9ubHkgaGF2ZSByZXN0cmljdGVkDQo+Pj4+PiBpbmZvcm1hdGlvbi4gVGhhdCdz
IHdoeSBJJ3ZlIGJlZW4gdHJ5aW5nIHRvIHJlcHJvZHVjZSBpdC4NCj4+Pj4NCj4+Pj4gSG93IGRp
ZCB5b3UgdGVzdCB5b3VyIGZpeCBpZiB5b3UgY2FuJ3QgcmVwcm9kdWNlIGl0Pw0KPj4+Pg0KPj4+
Pj4NCj4+Pj4+IFdlc2xleSBtYXkgaGF2ZSBydW4gaW50byBzYW1lIGlzc3VlIGFuZCB5b3UgY2Fu
IHNlZSB0aGlzIGlzc3VlIGluIGRldGFpbC4NCj4+Pj4+IGh0dHBzOi8vdXJsZGVmZW5zZS5jb20v
djMvX19odHRwczovL3Byb3RlY3QyLmZpcmVleWUuY29tL3YxL3VybD9rPTlkNDIzYjY5LWZjM2Zk
MzJlLTlkNDNiMDI2LTc0ZmU0ODVmZmYzMC03N2EwOTliNTI2NTk0MTBkJnE9MSZlPTIwYjRkOWY1
LTI1OTktNGY1Ny04YjZhLTdjNGVjMTY3ZDIyOCZ1PWh0dHBzKjNBKjJGKjJGbG9yZS5rZXJuZWwu
b3JnKjJGbGludXgtdXNiKjJGMjAyMjAyMDMwODAwMTcuMjczMzktMS1xdWljX3djaGVuZyo0MHF1
aWNpbmMuY29tKjJGX187SlNVbEpTVWxKUSEhQTRGMlI5R19wZyFKV1B6TkxvTzNCRlhfSVpDVnpt
SFB0eHE2ZnJyX1ZGYlNOTmF4U1F5bHVudDFZNEVhdVRPZWZ0aDJMQ0ljVkV1VHg4RSQgDQo+Pj4+
Pg0KPj4+Pg0KPj4+PiBJIGNhbiB0YWtlIGEgbG9vaywgYnV0IHBsZWFzZSBwcm92aWRlIHRoZSB0
cmFjZXBvaW50cyBvZiB0aGUgZmFpbHVyZSBpZg0KPj4+PiB5b3UgY2FuIHJlcHJvZHVjZSBpdC4N
Cj4+Pj4NCj4+PiBMZXQgbWUgc2VlIGlmIEkgaGF2ZSBhbnkgcHJldmlvdXMgdHJhY2VzIEkgY2Fu
IHNoYXJlLiAgSWYgbm90LCBJIGhhdmUgYQ0KPj4+IHByZXR0eSByZWxpYWJsZSByZXBybyBzZXQg
dXAgSSBjYW4gY29sbGVjdCBhIHRyYWNlIGZvciB5b3UuICBGb3Igbm93LCBJDQo+Pj4gd2lsbCBm
b2N1cyBvbiBqdXN0IGdldHRpbmcgdGhlIGVuZHhmZXIgdGltZW91dCBzZWVuIGR1cmluZyBlcCBk
ZXF1ZXVlLg0KPj4+IEFzIG1lbnRpb25lZCBvbiBteSBwYXRjaHNldCwgdGhpcyBjYW4gaGFwcGVu
IGR1cmluZyBkZXZpY2UtaW5pdGlhdGVkDQo+Pj4gZGlzY29ubmVjdCBhcyB3ZWxsLg0KPj4+DQo+
Pg0KPj4gWW91ciBwYXRjaCBzZXQgaXMgc3RpbGwgb24gbXkgdG9kbyBsaXN0LiBJIGhhdmVuJ3Qg
cmV2aWV3ZWQgaXQuIFRoZXJlJ3MNCj4+IHNvbWUgY29uY2VybiBsb29raW5nIGF0IGl0IGZyb20g
YSBmaXJzdCBnbGFuY2UsIEknbGwgY2hlY2sgaXQgb3V0IG1vcmUNCj4+IHRob3JvdWdobHkgbGF0
ZXIuDQo+Pg0KPj4gQ2FuIHlvdSBwcm92aWRlIHRoZSB0cmFjZXBvaW50cz8NCj4+DQo+IEkgY2Fu
IHByb3ZpZGUgdGhlIGZ1bGwgdHJhY2UgaWYgeW91IG5lZWQgaXQsIGp1c3QgbGV0IG1lIGtub3cu
ICBIb3dldmVyDQo+IGhlcmUgaXMgYSBxdWljayBzbmlwcGV0Og0KPiANCj4gWyAxODY1LjA3MDM5
NzY3MCAgICAgICAweDg3MjRlMmYxOF0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMmluOiBjbWQNCj4g
J1VwZGF0ZSBUcmFuc2ZlcicgWzUwMDA3XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAw
MDAgLS0+IHN0YXR1czoNCj4gU3VjY2Vzc2Z1bA0KPiBbIDE4NjUuMDcwNDQ5Mzg5ICAgICAgIDB4
ODcyNGUzMmZhXSAgIGRiZ19lcF9xdWV1ZTogZXAyaW46IHJlcQ0KPiBmZmZmZmY4N2EzNmJkMzAw
IGxlbmd0aCAwLzY1NTM2IHpzSSA9PT4gLTExNQ0KPiBbIDE4NjUuMDcwNDgwMjIyICAgICAgIDB4
ODcyNGUzNTQ5XSAgIGRiZ19zZW5kX2VwX2NtZDogZXAyaW46IGNtZA0KPiAnVXBkYXRlIFRyYW5z
ZmVyJyBbNTAwMDddIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAtLT4gc3RhdHVz
Og0KPiBTdWNjZXNzZnVsDQo+IFsgMTg2NS4wNzA1Mjk5NjIgICAgICAgMHg4NzI0ZTM5MDRdICAg
ZGJnX2VwX3F1ZXVlOiBlcDJpbjogcmVxDQo+IGZmZmZmZjg4NzA4ZGZjMDAgbGVuZ3RoIDAvNjU1
MzYgenNJID09PiAtMTE1DQo+IFsgMTg2NS4wNzA1NTk1NDUgICAgICAgMHg4NzI0ZTNiM2NdICAg
ZGJnX3NlbmRfZXBfY21kOiBlcDJpbjogY21kDQo+ICdVcGRhdGUgVHJhbnNmZXInIFs1MDAwN10g
cGFyYW1zIDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6DQo+IFN1Y2Nlc3Nm
dWwNCj4gWyAxODY1LjA3MDYxMDYzOSAgICAgICAweDg3MjRlM2YxMV0gICBkYmdfZXBfcXVldWU6
IGVwMmluOiByZXENCj4gZmZmZmZmODA0MmE5ODIwMCBsZW5ndGggMC82NTUzNiB6c0kgPT0+IC0x
MTUNCj4gWyAxODY1LjA3MDY0MDY5MSAgICAgICAweDg3MjRlNDE1Ml0gICBkYmdfc2VuZF9lcF9j
bWQ6IGVwMmluOiBjbWQNCj4gJ1VwZGF0ZSBUcmFuc2ZlcicgWzUwMDA3XSBwYXJhbXMgMDAwMDAw
MDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czoNCj4gU3VjY2Vzc2Z1bA0KPiBbIDE4NjUu
MDcwNjkyOTgzICAgICAgIDB4ODcyNGU0NTNlXSAgIGRiZ19lcF9xdWV1ZTogZXAyaW46IHJlcQ0K
PiBmZmZmZmY4MDQyYTk4OTAwIGxlbmd0aCAwLzY1NTM2IHpzSSA9PT4gLTExNQ0KPiBbIDE4NjUu
MDcwNzI4OTcyICAgICAgIDB4ODcyNGU0N2YxXSAgIGRiZ19zZW5kX2VwX2NtZDogZXAyaW46IGNt
ZA0KPiAnVXBkYXRlIFRyYW5zZmVyJyBbNTAwMDddIHBhcmFtcyAwMDAwMDAwMCAwMDAwMDAwMCAw
MDAwMDAwMCAtLT4gc3RhdHVzOg0KPiBTdWNjZXNzZnVsDQo+IA0KPiAvL0VQIGhhbHQgc2V0dXAg
cGFja2V0IGlzIHJlY2VpdmVkIGZyb20gdGhlIFBDDQo+IFsgMTg2NS4xNjY1NzkyMzMgICAgICAg
MHg4NzI2YTVjYjddICAgZGJnX3RyYWNlX2xvZ19jdHJsOiBDbGVhciBFbmRwb2ludA0KPiBGZWF0
dXJlKEhhbHQgZXA2aW4pDQo+IFsgMTg2NS4xNjY3MTY3ODUgICAgICAgMHg4NzI2YTY3MDhdICAg
ZGJnX3NlbmRfZXBfY21kOiBlcDZpbjogY21kICdDbGVhcg0KPiBTdGFsbCcgWzQwNV0gcGFyYW1z
IDAwMDAwMDAwIDAwMDAwMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gDQo+
IC8vVGhpcyBzaG91bGQgYmUgdGhlIEVQMCBzdGF0dXMgcGhhc2UsIGFzIGl0IGlzIG9uIGVwMGlu
DQo+IFsgMTg2NS4xNjY4NDk1OTggICAgICAgMHg4NzI2YTcwZmRdICAgZGJnX3NlbmRfZXBfY21k
OiBlcDBpbjogY21kICdTdGFydA0KPiBUcmFuc2ZlcicgWzQwNl0gcGFyYW1zIDAwMDAwMDAwIGVm
ZmZhMDAwIDAwMDAwMDAwIC0tPiBzdGF0dXM6IFN1Y2Nlc3NmdWwNCj4gWyAxODY1LjE3MzY2ODgx
NyAgICAgICAweDg3MjZjNzA2ZV0gICBkYmdfZXBfZGVxdWV1ZTogZXAyaW46IHJlcQ0KPiBmZmZm
ZmY4ODVmMjkzZjAwIGxlbmd0aCAwLzYyODQ4IHpzSSA9PT4gLTExNQ0KPiANCj4gLy9EZXF1ZXVl
IHRpbWVvdXQgb2NjdXJzIGhlcmUNCj4gWyAxODY1LjE5MjQyMDkwMCAgICAgICAweDg3MjcxZWVk
Nl0gICBkYmdfc2VuZF9lcF9jbWQ6IGVwMmluOiBjbWQgJ0VuZA0KPiBUcmFuc2ZlcicgWzUwZDA4
XSBwYXJhbXMgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgLS0+IHN0YXR1czogVGltZWQgT3V0
DQo+IA0KDQpDYW4geW91IHByb3ZpZGUgYSBmdWxsIHRyYWNlPw0KDQpCdHcsIHdoZW4geW91IGV4
cGVyaW1lbnQgd2l0aCBpbmNyZWFzaW5nIHRoZSB0aW1lb3V0IHRvIDEwIHNlY29uZHMsIGRpZA0K
eW91IHVzZSB0aGUgbWRlbGF5KCkgaW4gZWFjaCBsb29wPyBUaGUgZGVsdGEgdGltZSBmb3IgRW5k
IFRyYW5zZmVyDQp0aW1lb3V0IGhlcmUgc2VlbXMgdmVyeSBzbWFsbC4NCg0KTm90ZTogVGhlIEVu
ZCBUcmFuc2ZlciBjb21tYW5kIHNob3VsZCBfb25seV8gZ2V0cyBzdHVjayBpZiB0aGUgRE1BIGZv
ciBhDQp0aGUgU2V0dXAgcGFja2V0IGlzbuKAmXQgY29tcGxldGVkLCB3aGljaCBzaG91bGQgYmUg
YSBzaG9ydCB0aW1lLiBJdA0KZG9lc24ndCBsb29rIGxpa2UgdGhlIGNhc2UgaGVyZS4gKEhvcGVm
dWxseSB0aGUgZnVsbCBkcml2ZXIgdHJhY2Vwb2ludA0KZ2l2ZSBtb3JlIGNsdWVzKS4NCg0KVGhh
bmtzLA0KVGhpbmgNCg==
