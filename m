Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8017F53960E
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 20:17:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346921AbiEaSRt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 14:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237811AbiEaSRr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 14:17:47 -0400
Received: from esa.hc3962-90.iphmx.com (esa.hc3962-90.iphmx.com [216.71.142.165])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EE438CB3D;
        Tue, 31 May 2022 11:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qccesdkim1;
  t=1654021065; x=1654625865;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-transfer-encoding:mime-version;
  bh=D7x+vKwYLkN/qb07mkyR7hwMZG1ClpqM7N0uy/FUl6k=;
  b=gYbJxlqPi0XhIOgUfG5Pwt859eSuHKHnTIVKCmofzM9Lh7yXZ/CVNo7a
   A4g6GW3Y9gPjXPKl8TBrdC7CIoRyzmlRWV2XutBdejTge4f20KZb5MxaB
   CkhOge6s8obIxiKcSzdOkoxwtwl8GGhN1MW7O4D6qZ6TZfNiZvVQjXNg9
   k=;
Received: from mail-dm6nam11lp2168.outbound.protection.outlook.com (HELO NAM11-DM6-obe.outbound.protection.outlook.com) ([104.47.57.168])
  by ob1.hc3962-90.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2022 18:17:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bh8+25+ZrvSK1rMrIyi/YZPBznky4kPbJ1HqUzatvRf67msYAjqNtNzjGcv0kyz+6upFqb2BBkB4qtC0Q9JzE5e7rfN9IzeAV2ic7PAiwzd3fON1tKVAkRPc2BLQ0lSRE1W5VPZwc0QrxEsAP++aX+JzmDjJbALT4UffV21xBb1p6vPbHnPXNJ3ShIwM57b1/1j6043H3+YnH9AZIcYwQt6aPT4JVGtnN1Gg/8p0I8AcxgAIdh0i9W3ckoR60bVPvzvx7Sm7evyLFhSZkh4Wt7Gj3qZZVsXn4r+rbIqFh89Hxcm7rHIW+PrmLNVQeBLHRHuWhMH/0PTmxM0jntd8Sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=D7x+vKwYLkN/qb07mkyR7hwMZG1ClpqM7N0uy/FUl6k=;
 b=Mp7KxbqRoswOZ5OhaeTQUnAOq3hiwAwV8VmAE/uzJookZnclC/PHe/d+yMzByL+IcS8dzCmZoz1lPt9dnZnQA2jXvvU1GlOOt4Q/VqLF/G1z0Xqzf21EDOO8KtFIM/vP57nKDgSabbBQ++l2sHApjDctDYt0Ou19Cj5gw/wQPB1ex1moe3jipq3PEEbOHs2msKdcYcfLae7klr35lhyNufESgLA+JLGAVHYhq2TlAVAdB7kxKv9Ykz1WJDIRFF0GL/xRjf65azPHP47aO7B/R9HV2vpkMY1vfcn+x0nihMT+dnnSkXJGy44lbsejgTJ4bFJamKuRviRPGsNBmz3rng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=quicinc.com; dmarc=pass action=none header.from=quicinc.com;
 dkim=pass header.d=quicinc.com; arc=none
Received: from BL0PR02MB4564.namprd02.prod.outlook.com (2603:10b6:208:4d::13)
 by BN6PR02MB2290.namprd02.prod.outlook.com (2603:10b6:404:29::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5293.13; Tue, 31 May
 2022 18:17:41 +0000
Received: from BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::508d:2d15:ef0f:4f60]) by BL0PR02MB4564.namprd02.prod.outlook.com
 ([fe80::508d:2d15:ef0f:4f60%7]) with mapi id 15.20.5293.019; Tue, 31 May 2022
 18:17:40 +0000
From:   "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>
To:     "Vijaya Krishna Nivarthi (Temp) (QUIC)" <quic_vnivarth@quicinc.com>,
        Doug Anderson <dianders@chromium.org>
CC:     Andy Gross <agross@kernel.org>,
        "bjorn.andersson@linaro.org" <bjorn.andersson@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        "linux-serial@vger.kernel.org" <linux-serial@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Mukesh Savaliya (QUIC)" <quic_msavaliy@quicinc.com>,
        Matthias Kaehlcke <mka@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        "Satya Priya Kakitapalli (Temp) (QUIC)" <quic_c_skakit@quicinc.com>
Subject: RE: [V2] tty: serial: qcom-geni-serial: Remove uart frequency table.
 Instead, find suitable frequency with call to clk_round_rate.
Thread-Topic: [V2] tty: serial: qcom-geni-serial: Remove uart frequency table.
 Instead, find suitable frequency with call to clk_round_rate.
Thread-Index: AQHYaREoIOR30NQ8REizIRGY5mvudq0xdBCAgAFNHICABqFBgA==
Date:   Tue, 31 May 2022 18:17:40 +0000
Message-ID: <BL0PR02MB45645D04D0EFCAC7CF0CF4A1FADC9@BL0PR02MB4564.namprd02.prod.outlook.com>
References: <1652697510-30543-1-git-send-email-quic_vnivarth@quicinc.com>
 <CAD=FV=WZQLpYAsdU4yTCGZCGp5+t+rJiadbSeppBaX0b6ZuUxg@mail.gmail.com>
 <BL0PR02MB456404910AB2D32D0A6A9CCAFAD89@BL0PR02MB4564.namprd02.prod.outlook.com>
In-Reply-To: <BL0PR02MB456404910AB2D32D0A6A9CCAFAD89@BL0PR02MB4564.namprd02.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=quicinc.com;
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 4b38a445-5a47-4176-de44-08da4331d97d
x-ms-traffictypediagnostic: BN6PR02MB2290:EE_
x-ld-processed: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d,ExtAddr
x-microsoft-antispam-prvs: <BN6PR02MB22905228D9F5E8CC56B24A8D86DC9@BN6PR02MB2290.namprd02.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: ODgy3InBG8CeYizTjPrBXqb2Do2t6nEk69/xRxj5jBtULI4RfnjBmDg0655g7IX1NfZhEBD2I7hoG8MRpSzd/w/thnLaIgkMFHwnmObSw847WwUQXsozvAJbz8Xlgkqx6Or2Hk2PGW35DXe2ozJp4vkG5FC+bAjySxHprkKZQEV0bZTo9xowfXFK61Gri/2vem/ypQCDQBECfwKG8tI71rRo9FkeBPKlgaQzoUSsR6EAU3swtKxbeaHZQKdaJ6164G0mvatTcwk6Z+isIiOU1pU1roV4CwuJ+V40e6xWj0v51rrWsVv56ywl8SKCk8MDbb1q7jzvcyXj1oSSY387gQDdiDnYSiWYteXDqOVVG9SM/RcOQLRitjKHoVlWd7h92TWySAgODRCPPljO5+eOO1KKsMq+wEkd1hVBH918st1Slay0Pl/BD4LHVYDksOO9dug7USFQnSZRK2qdal9FXvyWPn5eYV3ZuVmYTX8joEwZW2oP3k9fNE1tQgfDq55LySKMEo/DvJ1VK0tTpAwgJs1MNdolJNfAgA0sWnszPDyEgro7u+SIWCVXJh0inscx562Hf30zRH44xlCrZ+hFOYefYGd0yDvKVdrt/3HX26tkCXq1R98jnIJxO0A+9OmqI8+Y3Zd5P+PMyWrZwyf4Z2bNr+A/b5wxjYFr3s3WXJFNcr8WF8ngLHmK8bAaayNADr5bZITZqRUXsiNaKJrBTw==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR02MB4564.namprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(55016003)(107886003)(186003)(38100700002)(4326008)(54906003)(110136005)(316002)(8676002)(66476007)(64756008)(76116006)(66446008)(83380400001)(38070700005)(71200400001)(8936002)(66946007)(508600001)(66556008)(7696005)(6506007)(86362001)(52536014)(53546011)(7416002)(33656002)(5660300002)(122000001)(9686003)(26005)(2906002);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?utf-8?B?dkdXMk9jazRaR3dqakE3elBjeVJSTFlBbEhHblZXZWYyYnJ0Z3dDQ3RERlZE?=
 =?utf-8?B?WW5iTzFIZkpaUDBBdW9tMGJpTjI5dDNSS0hwcExPb2pKRzM5RG12dzZneVFB?=
 =?utf-8?B?QkpQNGorSTIrZmhyYzNTTDFBUkpnUmxmKy85bnhCOG5uQy9WV2w4T2NXSHZv?=
 =?utf-8?B?RmQ2Q3RrYnRxM3l1bGhoZEF1aXRXeTBPOEprM3owYmVMZFkrL1JYYW5TOE44?=
 =?utf-8?B?KzliVk1EUGN0MXIvRDhISXc4Wkw4V2tNTml3VjVoWlBFVng1Vk1FREw0YXVj?=
 =?utf-8?B?Rkt3VmFSaUt6RW9qalRZK3Q2MnhhMUUxQWxaN2kzNzVEUVpnRzBmZzVkSW9s?=
 =?utf-8?B?YndmdG4yOUNkczVsMkY0U2diZ1RXZXJabUVtZUxVdWRjQ01XUklRY2JCQjkr?=
 =?utf-8?B?ZUkzOXFzYThvTkZvaFh6UHRMb2dOb1UvaGxmYWIxdXFUa25ZcVVXVDdiemd3?=
 =?utf-8?B?dzU4MTFNaURzWUtTQzBOVzIxeW42UDFlOVQ5ZmRtcWtaL3k2N2VvMHA2ck5D?=
 =?utf-8?B?ZTNmMzMrUC8wSEVmZGhlZVZ5UlVoTE1iNk1KQ0ZtQ1Fwc29TbzlHSGZGbUlU?=
 =?utf-8?B?Rzk4aWR4aENJenlvbWE2OS9KQ2JoYWx6bWpEWjh2MDVTSGMrQkU0bnBpcURY?=
 =?utf-8?B?a05ESmhSUGttNUNmU093bHV1Z1h2YndQMmFrS2JDbHduSXB5TVFXSlFFa1Bq?=
 =?utf-8?B?TTVKTy9odFgrcTFzSjdTMUFPWlYvdjNrdUVlMWdBUHRxQWdoZ0ZkVEZoU0hY?=
 =?utf-8?B?MWxyZzlzWVhvaFB0WC8rbzJZSlVVbjdIVHVhWDU2cHZMbVFVZEJVWXozUkln?=
 =?utf-8?B?MVVuYmJiYVIwVWJOLysxMkRvRld0eU9nOXF1Ly81UkRpN2lyR2NxaDFsQzFn?=
 =?utf-8?B?VjQ4M01aNVBtWHNza241T3BkRnJaVElyek1IbkQrNm9QeHV1VW45UW11T3BG?=
 =?utf-8?B?dkovT24zS2hySXBmWUxtaHBSdG83OVN5Y1dZTnF2Z3VFOWFEUEhlNzhWeFVl?=
 =?utf-8?B?UlByR1BPMVZ6clo1TVhIaTNJV2NnVEhHcVM0Y01aaXVoMno5QWVxQVBrbmdw?=
 =?utf-8?B?bWVIVmhaQWo0eXNnSGRmbkxPR2lRa3pFY0JJR2xBSlZKZXo4UHR2Q1M5b1oz?=
 =?utf-8?B?MTNXVkNlbkJ3K1YrTWVXa1o5MURvUDkwNXQxM014aWljZ3VBbUxoY1Z2aEtv?=
 =?utf-8?B?aVRxTWlucGZ3OWlYeklUUjRkREU3MFZGZ2kySlFkaWpWNlRxUjdqWUJPSnBQ?=
 =?utf-8?B?azR3NHRxZWU2dmNYNXhGTXkyckN4dHIyazFORjR0U1U5WURXcVJxV0tsWGRQ?=
 =?utf-8?B?ZUdySkkycW10RWp1NDZHQWlDZHIwcFk4RGh5ZTNEemV6dDFVS1U0NUcwSW9a?=
 =?utf-8?B?dTFzZzZVREhsRU81djMrT05wWEVnZ2gyN0pjL1VpbE1tb3JjZHIwNUJKZkVz?=
 =?utf-8?B?eU1hdlk0Zld3MEhhcmI1eERua0sxb2N1MVlBWDk4a2VlUkxHMGJ1ZkV5cllW?=
 =?utf-8?B?UWNER0p1ZjlncDNNdU9PNG90NE1Qb2FCUkZHVGZHTFVSUWN5aVRFMW1TVEV3?=
 =?utf-8?B?TmRoQlhKK3RLMzc0WUh0MlRvMEVBU1I3cm5iUHQ3clpDVFR5MEg2TGtoeTZT?=
 =?utf-8?B?NFQveEdmZlZSZXBDZ3FnaDVZaEFxUkxEVFUyV2s3ejI5QTNmQ00xRkVkMDlk?=
 =?utf-8?B?N2hpSFEweUlrOGRKOTk2YU5yZFhaYW5hbi9ReG5GdEtJTXRDQlJPd3N2dmdw?=
 =?utf-8?B?c2pnNFlTc01SaERHeHJ0eDNJQVBzYzI2TlB2TTM0REE3NTZ2UkR6cWxwa0RY?=
 =?utf-8?B?MFQ4dTdZUXhLQXVMaUl5d0FWbTZ0aUVGTnZnQmdvTU9aM0NYVjZQM0RVb0hS?=
 =?utf-8?B?Q3ZPNjZHZ2JPZW5MZ0tRS3BKV3ZPUlQ1b29SUUtDVEJyQVl5Rit1YTZUWVZx?=
 =?utf-8?B?aCtDT2djK3pWRUNEZzUrdXJEUmtscnF0bnVGbmZMRWoyZDJFV3pMaGdqZUZw?=
 =?utf-8?B?cVlBUzZUUVpoUExTRDYyZE1TMTNJbDhQSVI4RlYweW00c0Z1Mi9oQmUxWmZS?=
 =?utf-8?B?blppeXdMODByU2EyTm1KKzNYcU04eno5aGoycGozaHI0KzZ5NzVnMThOVFBX?=
 =?utf-8?B?azhqZENCQUVOQnJnNWgvSTZCdTZoK0c1TVowK0tQdHJTRGRNZUpkZ1F1MUxh?=
 =?utf-8?B?T1F2dGJRY01XQUt6aVhnMXk3anh1ZXMzTGdLVzdFcXhSZDUrZmdTcW5DK3Bk?=
 =?utf-8?B?bVc4S01ENDhCZUU5Ny9hYTJKVDhjZzYxS1lQd0xsR3JKSGtqY1dBbUlmai9P?=
 =?utf-8?B?MzBhdkZiZWhkaWNpejZXVzFxajVTOFo0bmdMMDRmN3o5MWNtdkVpQT09?=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: quicinc.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR02MB4564.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 4b38a445-5a47-4176-de44-08da4331d97d
X-MS-Exchange-CrossTenant-originalarrivaltime: 31 May 2022 18:17:40.7241
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 98e9ba89-e1a1-4e38-9007-8bdabc25de1d
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5MWSni+sL3JqLZzZGrJ55pZ7/eLT1f1zeYdFhIM0PsTYihAbNEowkOIeLvediZOsWA7w1t7AAjqzN+Uinn+lxz7V3+jxsedJlsX5qVsHiMo=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR02MB2290
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rm9yIHNha2Ugb2Ygc21vb3RoZXIgdXBzdHJlYW1pbmcsIEkgd2lsbCBiZSBpbXBsZW1lbnRpbmcg
ZmVlZGJhY2sgaW4gaW5jcmVtZW50YWwgcGF0Y2hlcy4NClVwbG9hZGluZyBmaXJzdCBvbmUgdG9k
YXkuDQpUaGFuayB5b3UuDQoNCg0KLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCkZyb206IFZp
amF5YSBLcmlzaG5hIE5pdmFydGhpIChUZW1wKSAoUVVJQykgDQpTZW50OiBGcmlkYXksIE1heSAy
NywgMjAyMiA2OjM2IFBNDQpUbzogRG91ZyBBbmRlcnNvbiA8ZGlhbmRlcnNAY2hyb21pdW0ub3Jn
PjsgVmlqYXlhIEtyaXNobmEgTml2YXJ0aGkgKFRlbXApIChRVUlDKSA8cXVpY192bml2YXJ0aEBx
dWljaW5jLmNvbT4NCkNjOiBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9yZz47IGJqb3JuLmFu
ZGVyc3NvbkBsaW5hcm8ub3JnOyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBsaW51eGZvdW5k
YXRpb24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBsaW51eC1hcm0t
bXNtIDxsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXNlcmlhbEB2Z2VyLmtl
cm5lbC5vcmc7IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBNdWtlc2ggU2F2
YWxpeWEgKFFVSUMpIDxxdWljX21zYXZhbGl5QHF1aWNpbmMuY29tPjsgTWF0dGhpYXMgS2FlaGxj
a2UgPG1rYUBjaHJvbWl1bS5vcmc+OyBTdGVwaGVuIEJveWQgPHN3Ym95ZEBjaHJvbWl1bS5vcmc+
OyBTYXR5YSBQcml5YSBLYWtpdGFwYWxsaSAoVGVtcCkgKFFVSUMpIDxxdWljX2Nfc2tha2l0QHF1
aWNpbmMuY29tPg0KU3ViamVjdDogUkU6IFtWMl0gdHR5OiBzZXJpYWw6IHFjb20tZ2VuaS1zZXJp
YWw6IFJlbW92ZSB1YXJ0IGZyZXF1ZW5jeSB0YWJsZS4gSW5zdGVhZCwgZmluZCBzdWl0YWJsZSBm
cmVxdWVuY3kgd2l0aCBjYWxsIHRvIGNsa19yb3VuZF9yYXRlLg0KDQpUaGFua3MgYSBsb3QgZm9y
IHZlcnkgdXNlZnVsIGZlZWRiYWNrLg0KSSBzZWUgdGhhdCB0aGUgcGF0Y2ggaGFzIGxhbmRlZCwg
d2lsbCB1cGxvYWQgYW5vdGhlciBpbmNvcnBvcmF0aW5nIHRoZXNlIHN1Z2dlc3Rpb25zLg0KLVZp
amF5Lw0KDQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBEb3VnIEFuZGVyc29u
IDxkaWFuZGVyc0BjaHJvbWl1bS5vcmc+DQpTZW50OiBUaHVyc2RheSwgTWF5IDI2LCAyMDIyIDEw
OjM4IFBNDQpUbzogVmlqYXlhIEtyaXNobmEgTml2YXJ0aGkgKFRlbXApIChRVUlDKSA8cXVpY192
bml2YXJ0aEBxdWljaW5jLmNvbT4NCkNjOiBBbmR5IEdyb3NzIDxhZ3Jvc3NAa2VybmVsLm9yZz47
IGJqb3JuLmFuZGVyc3NvbkBsaW5hcm8ub3JnOyBHcmVnIEtyb2FoLUhhcnRtYW4gPGdyZWdraEBs
aW51eGZvdW5kYXRpb24ub3JnPjsgSmlyaSBTbGFieSA8amlyaXNsYWJ5QGtlcm5lbC5vcmc+OyBs
aW51eC1hcm0tbXNtIDxsaW51eC1hcm0tbXNtQHZnZXIua2VybmVsLm9yZz47IGxpbnV4LXNlcmlh
bEB2Z2VyLmtlcm5lbC5vcmc7IExLTUwgPGxpbnV4LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc+OyBN
dWtlc2ggU2F2YWxpeWEgKFFVSUMpIDxxdWljX21zYXZhbGl5QHF1aWNpbmMuY29tPjsgTWF0dGhp
YXMgS2FlaGxja2UgPG1rYUBjaHJvbWl1bS5vcmc+OyBTdGVwaGVuIEJveWQgPHN3Ym95ZEBjaHJv
bWl1bS5vcmc+OyBTYXR5YSBQcml5YSBLYWtpdGFwYWxsaSAoVGVtcCkgKFFVSUMpIDxxdWljX2Nf
c2tha2l0QHF1aWNpbmMuY29tPg0KU3ViamVjdDogUmU6IFtWMl0gdHR5OiBzZXJpYWw6IHFjb20t
Z2VuaS1zZXJpYWw6IFJlbW92ZSB1YXJ0IGZyZXF1ZW5jeSB0YWJsZS4gSW5zdGVhZCwgZmluZCBz
dWl0YWJsZSBmcmVxdWVuY3kgd2l0aCBjYWxsIHRvIGNsa19yb3VuZF9yYXRlLg0KDQpXQVJOSU5H
OiBUaGlzIGVtYWlsIG9yaWdpbmF0ZWQgZnJvbSBvdXRzaWRlIG9mIFF1YWxjb21tLiBQbGVhc2Ug
YmUgd2FyeSBvZiBhbnkgbGlua3Mgb3IgYXR0YWNobWVudHMsIGFuZCBkbyBub3QgZW5hYmxlIG1h
Y3Jvcy4NCg0KSGksDQoNCk9uIE1vbiwgTWF5IDE2LCAyMDIyIGF0IDM6MzggQU0gVmlqYXlhIEty
aXNobmEgTml2YXJ0aGkgPHF1aWNfdm5pdmFydGhAcXVpY2luYy5jb20+IHdyb3RlOg0KPg0KPiBS
ZXBsYWNlIHRoZSBVQVJUIGZyZXF1ZW5jeSB0YWJsZSAncm9vdF9mcmVxW10nIHdpdGggbG9naWMg
YXJvdW5kDQo+IGNsa19yb3VuZF9yYXRlKCkgc28gdGhhdCBTb0MgZGV0YWlscyBsaWtlIHRoZSBh
dmFpbGFibGUgY2xrIA0KPiBmcmVxdWVuY2llcyBjYW4gY2hhbmdlIGFuZCB0aGlzIGRyaXZlciBz
dGlsbCB3b3Jrcy4gVGhpcyByZWR1Y2VzIHRpZ2h0IA0KPiBjb3VwbGluZyBiZXR3ZWVuIHRoaXMg
VUFSVCBkcml2ZXIgYW5kIHRoZSBTb0MgY2xrIGRyaXZlciBiZWNhdXNlIHdlIG5vIA0KPiBsb25n
ZXIgaGF2ZSB0byB1cGRhdGUgdGhlICdyb290X2ZyZXFbXScgYXJyYXkgZm9yIG5ldyBTb0NzLiBJ
bnN0ZWFkIA0KPiB0aGUgZHJpdmVyIGRldGVybWluZXMgdGhlIGF2YWlsYWJsZSBmcmVxdWVuY2ll
cyBhdCBydW50aW1lLg0KPg0KPiBTaWduZWQtb2ZmLWJ5OiBWaWpheWEgS3Jpc2huYSBOaXZhcnRo
aSA8cXVpY192bml2YXJ0aEBxdWljaW5jLmNvbT4NCj4gLS0tDQo+IHYyOiBsb29wcyB0aHJvdWdo
IGNsayBkaXZpZGVycyB0byB6ZXJvLWluIHF1aWNrbHkNCj4gdjE6IGludGlhbCBwYXRjaCBsb29w
ZWQgdGhyb3VnaCBhdmFpbGFibGUgY2xrIGZyZXF1ZW5jaWVzDQo+IC0tLQ0KPiAgZHJpdmVycy90
dHkvc2VyaWFsL3Fjb21fZ2VuaV9zZXJpYWwuYyB8IDU2DQo+ICsrKysrKysrKysrKysrKysrKysr
KystLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMjAg
ZGVsZXRpb25zKC0pDQo+DQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3R0eS9zZXJpYWwvcWNvbV9n
ZW5pX3NlcmlhbC5jDQo+IGIvZHJpdmVycy90dHkvc2VyaWFsL3Fjb21fZ2VuaV9zZXJpYWwuYw0K
PiBpbmRleCBmNDk2MTAyLi40NzMzYTIzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL3R0eS9zZXJp
YWwvcWNvbV9nZW5pX3NlcmlhbC5jDQo+ICsrKyBiL2RyaXZlcnMvdHR5L3NlcmlhbC9xY29tX2dl
bmlfc2VyaWFsLmMNCj4gQEAgLTE0OSwxMiArMTQ5LDYgQEAgc3RhdGljIHVuc2lnbmVkIGludCAN
Cj4gcWNvbV9nZW5pX3NlcmlhbF90eF9lbXB0eShzdHJ1Y3QgdWFydF9wb3J0ICpwb3J0KTsgIHN0
YXRpYyB2b2lkIA0KPiBxY29tX2dlbmlfc2VyaWFsX3N0b3Bfcngoc3RydWN0IHVhcnRfcG9ydCAq
dXBvcnQpOyAgc3RhdGljIHZvaWQgDQo+IHFjb21fZ2VuaV9zZXJpYWxfaGFuZGxlX3J4KHN0cnVj
dCB1YXJ0X3BvcnQgKnVwb3J0LCBib29sIGRyb3ApOw0KPg0KPiAtc3RhdGljIGNvbnN0IHVuc2ln
bmVkIGxvbmcgcm9vdF9mcmVxW10gPSB7NzM3MjgwMCwgMTQ3NDU2MDAsIDE5MjAwMDAwLCAyOTQ5
MTIwMCwNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDMyMDAwMDAw
LCA0ODAwMDAwMCwgNTEyMDAwMDAsIDY0MDAwMDAwLA0KPiAtICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgODAwMDAwMDAsIDk2MDAwMDAwLCAxMDAwMDAwMDAsDQo+IC0gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAxMDI0MDAwMDAsIDExMjAwMDAwMCwg
MTIwMDAwMDAwLA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTI4
MDAwMDAwfTsNCj4gLQ0KPiAgI2RlZmluZSB0b19kZXZfcG9ydChwdHIsIG1lbWJlcikgXA0KPiAg
ICAgICAgICAgICAgICAgY29udGFpbmVyX29mKHB0ciwgc3RydWN0IHFjb21fZ2VuaV9zZXJpYWxf
cG9ydCwNCj4gbWVtYmVyKQ0KPg0KPiBAQCAtOTQ2LDI1ICs5NDAsNDMgQEAgc3RhdGljIGludCBx
Y29tX2dlbmlfc2VyaWFsX3N0YXJ0dXAoc3RydWN0IHVhcnRfcG9ydCAqdXBvcnQpDQo+ICAgICAg
ICAgcmV0dXJuIDA7DQo+ICB9DQo+DQo+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBnZXRfY2xrX2Nm
Zyh1bnNpZ25lZCBsb25nIGNsa19mcmVxKSAtew0KPiAtICAgICAgIGludCBpOw0KPiAtDQo+IC0g
ICAgICAgZm9yIChpID0gMDsgaSA8IEFSUkFZX1NJWkUocm9vdF9mcmVxKTsgaSsrKSB7DQo+IC0g
ICAgICAgICAgICAgICBpZiAoIShyb290X2ZyZXFbaV0gJSBjbGtfZnJlcSkpDQo+IC0gICAgICAg
ICAgICAgICAgICAgICAgIHJldHVybiByb290X2ZyZXFbaV07DQo+IC0gICAgICAgfQ0KPiAtICAg
ICAgIHJldHVybiAwOw0KPiAtfQ0KPiAtDQo+IC1zdGF0aWMgdW5zaWduZWQgbG9uZyBnZXRfY2xr
X2Rpdl9yYXRlKHVuc2lnbmVkIGludCBiYXVkLA0KPiArc3RhdGljIHVuc2lnbmVkIGxvbmcgZ2V0
X2Nsa19kaXZfcmF0ZShzdHJ1Y3QgY2xrICpjbGssIHVuc2lnbmVkIGludCANCj4gK2JhdWQsDQo+
ICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGludCBzYW1wbGluZ19yYXRlLCB1bnNp
Z25lZCBpbnQNCj4gKmNsa19kaXYpICB7DQo+ICAgICAgICAgdW5zaWduZWQgbG9uZyBzZXJfY2xr
Ow0KPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgZGVzaXJlZF9jbGs7DQo+ICsgICAgICAgdW5zaWdu
ZWQgbG9uZyBmcmVxLCBwcmV2Ow0KPiArICAgICAgIHVuc2lnbmVkIGxvbmcgZGl2LCBtYXhkaXY7
DQo+ICsgICAgICAgaW50NjRfdCBtdWx0Ow0KDQpXaHkgaXMgIm11bHQiIHNpZ25lZD8gU2hvdWxk
bid0IGl0IGJlIHR5cGUgInU2NCIgb3Igc29tZXRoaW5nPw0KDQo=
