Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13F6D51F82E
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237030AbiEIJdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235162AbiEIJ1D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:27:03 -0400
Received: from APC01-SG2-obe.outbound.protection.outlook.com (mail-sgaapc01on2088.outbound.protection.outlook.com [40.107.215.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CBAF18DAC2
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:23:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=edgancLSVwh8l5pO9DFhmSLfkojuSJdOF/BhMGdqwSOLMB6iH9CajRecDBBvW6Hr87VJVN12+NS1ziYXsIkl5bZv9+OLVft5Iem0bRdTdhxi9W26cLdMki8Skpi+wGE5X/tbTxZYk80PZ0qxaPo97/4aA8Cb/eyMwzuARcYH45wPVj5+1mAaiQup4Hg4OjZy7wRo4MJxTSlV+t7VLyC2eM6NEB6sVYwEt5JE6h6CHEjT1SkBQV0IIu7bITrC3Ko95sc6DReNBusCqy7wlXrdxqwH8gC8DhshcOWyuOhS3gnzLFfJWx5dO4KlVEJb2DPLxeHCGTHyveNik/yCv4C3SA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=oHtOLonNxX2QL9dgtRQPdlkoWFBqu1jOk/RlhZrzZc4=;
 b=MbXBb4knJlnUrPkbDQfYCMbh6bc/TCCiMEiR3phseyQ+Q+1J9MmQAtbY+Bww1ma4OpfH9gWwUK+yi+cx4i/jPUukF+BKqLvkXjyqXhw7aNLgOSLdUt98qfCZuN6iDVKAVbEFfs3OlcXtnjmpgjjO28tJYfJLPgTvXEVBZC3N2l4waSaxscm1WYTcWM8MNsMReAcqjZ/MaJ+AmaRxOOMArkMrxo+pfQpxS+usFAN9yF7i/x3KnqZ3th2YTKD7RvirUF56Fyfrc3nHBFz9x8BbIByI87K7u2G9HPfjlb0JX/qG0Lu9h45wjCmLdgqIlDDOINGL7Av+qZqDvQ49Ld9H9g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oppo.com; dmarc=pass action=none header.from=oppo.com;
 dkim=pass header.d=oppo.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oppo.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=oHtOLonNxX2QL9dgtRQPdlkoWFBqu1jOk/RlhZrzZc4=;
 b=KNIQoZPcOH4jn4vb1qgn/1f4OwiK70bx1LpA1ap8kJLitx31fEKo9Cl4R2sT7rngc6WUyG7Yqc6YD4tc9x5syjqJ9UwAlOzTZoZuGpZU+VhExGti1h3xYFpVgMkRR/B/lzXlxSzDJEIeArKbXwCJ6Pp1ldZzOHFXMQ0lrzLXiS0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=oppo.com;
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13) by HK2PR02MB4033.apcprd02.prod.outlook.com
 (2603:1096:202:3e::11) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.23; Mon, 9 May
 2022 09:23:04 +0000
Received: from TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998]) by TY2PR02MB4431.apcprd02.prod.outlook.com
 ([fe80::8179:176f:a62e:c998%7]) with mapi id 15.20.5227.023; Mon, 9 May 2022
 09:23:04 +0000
Date:   Mon, 9 May 2022 17:23:02 +0800
From:   "lipeifeng@oppo.com" <lipeifeng@oppo.com>
To:     akpm <akpm@linux-foundation.org>
Cc:     michel <michel@lespinasse.org>, hughd <hughd@google.com>,
        linux-mm <linux-mm@kvack.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        "Barry Song" <21cnbao@gmail.com>,
        zhangshiming <zhangshiming@oppo.com>,
        peifengl55 <peifengl55@gmail.com>
Subject: Re: Re: [PATCH] mm: fix align-error when get_addr in unmapped_area_topdown
References: <20220412081014.399-1-lipeifeng@oppo.com>, 
        <20220412142238.93e36cc4095e4e0b362db348@linux-foundation.org>, 
        <2022041310411426044561@oppo.com>, 
        <2022050110235766139218@oppo.com>, 
        <20220501181041.6d53cb9ed54bf697840e36cc@linux-foundation.org>, 
        <2022050211305415626916@oppo.com>, 
        <20220507145937.6dbfc036f99addf9342bc5ce@linux-foundation.org>
X-GUID: E9DF6782-859E-4634-84EC-E6BACFE6139F
X-Has-Attach: no
X-Mailer: Foxmail 7.2.16.188[cn]
Message-ID: <2022050917212835925916@oppo.com>
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: base64
X-ClientProxiedBy: SG2PR02CA0093.apcprd02.prod.outlook.com
 (2603:1096:4:90::33) To TY2PR02MB4431.apcprd02.prod.outlook.com
 (2603:1096:404:8003::13)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3de1f1fb-0b06-4102-6ba0-08da319d8526
X-MS-TrafficTypeDiagnostic: HK2PR02MB4033:EE_
X-Microsoft-Antispam-PRVS: <HK2PR02MB40339C37BECF611E909FBB72C6C69@HK2PR02MB4033.apcprd02.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: GGKiwZxtgFXcJat1XJ0aGBbekntN1oX1kHOWtnChvi5TNJx2EO2xzxg5M4yTu70pe3TaxLlsVok1UAskEF/CIyJOstANAndwgMVMc7fbtEVETDDE73XNn5f+8jH+z9BHiZadodDVcRPcaZEfWRvpuW82bMD0JwSh0ruXN5v8YCl5KjWBdpvkfoz9F1+nCcvZw6CHnDEKGiBvy924CHs5r3ME1Oqpp//PVM7g5xLAw4oGp16WOFHUmZ4Q12CCRBgXo8OjHSKVWIzHUwYCubgatxSfRAgKleW4Z7uHnm7roxaFnwG1ljrHL1UoFHTC7WqfRjMmJVflcdP+AvaqGoQxv1TTXJgS0bLisznq1LMAy8x5Dh0GDuJra/V6mcVwZ64lWx+gteWeB0SEQnbedQ00XhPgKjGRjXYSJxu+TeStFgGIcOxxVfPSCZvVKK9y5k1AJJf4JG9SWVGuKWU7SVkKZpKh/b3NfZA522PQdsqD6QPzAlJNc0zWQR9TrsJ6x/5dpyOvJN/LKFbgdKx+ZGp4dfAjqli9hxTogsiS9SeMZI4ZQR/U9aqlMo8w82ucuqYZiJnYakXjfavlg8SyAB80YzuMKRvbf3AEO/mw+KJzjOzxb2aNkqI4itprAY+ipp16uj6Q+Gmb2OML7KauvdFcVPm7C6ZDW1BBCTn90WKR1MkhkNMa+O5psYAcBV9MxHqSElZhp1tdYCHvQ4QvPfirFDepN+mv+29tYI9fOlpC1ICNfbgEQUhnAGS7T10ey1Rul6WVfhTFu/fMzzyPoLKkYC14CCEYPYdWYqkqUNtVBew=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TY2PR02MB4431.apcprd02.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(37786003)(5660300002)(1076003)(186003)(6512007)(86362001)(38350700002)(26005)(2616005)(8936002)(38100700002)(66946007)(66476007)(66556008)(2906002)(8676002)(4326008)(6916009)(6486002)(98106002)(58226001)(6506007)(966005)(52116002)(508600001)(53546011)(54906003)(36756003)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?OEdTTzlRYXpIUU5XQjQ3Zmxtcm1xYW50YVJIYyt1c1FTU3BBZUE5SDVhVUt3?=
 =?utf-8?B?M21mK0M0MitCR3ZLUTg3U3J5S1FVZjRIZ3Z6VFdzbVdFNmprYUUvSUthU0k1?=
 =?utf-8?B?bDJYMy90c1VjZ2RCOWh1TXB4bHUwVmxoVDlWZUIzdlFCbDVzZjBxaXpLVU55?=
 =?utf-8?B?WlFWSndRS09HZjAyb0NMZDN0R1RzK1V1cnVEYjVKZHZJQjZ6NjZqeHJ0MXY2?=
 =?utf-8?B?c3BKSWpBYmljVGNYVVRSYjFTdnpTYmVKZDVUOWN6U3V3d243am5FTUhFT1pX?=
 =?utf-8?B?Qjk0V3BqdEQ5Y1B1NHBUV1c4TGdudmoyeWp6eEFTVlVLRlNRSGZHKzkydjE0?=
 =?utf-8?B?TFd3SGROMFBpM2xoVUVNeE9ZMEtmWVVWc2FiWXE5RXVGSVRXVnN3RmQ1OEk3?=
 =?utf-8?B?c3pGRUNjVnRLQ0JHQkhjTWRIQmZ0a2dibU9FMTlRZ0FVNHI1TUhpbzdZdytn?=
 =?utf-8?B?SXVwb0c4Q0gzTXBURVlzRzV1SWFHZ0pRd2ZsKy9aaGNpRG9WUHZvUk5NQXlM?=
 =?utf-8?B?U0hjUlZTT2IyMmgwQWo3bythdGlFMi93VUIzSEdVWmFMR3JscjVzMWpNbk0v?=
 =?utf-8?B?aUxkNnpPYXllRS9jTEdEa1RqMkJEdGdEU09zdkM2SDlXdDRNRnZUSEVUUXNj?=
 =?utf-8?B?ekxsWHdsRUc4YnpEY0w3aUZnSHNIZWxCQ1VVU1dXWVlZVEtTTDduSXlQOWRT?=
 =?utf-8?B?K1ZjZE84bzJxSHF4b0l6UzZXN0xmMU5nZDlXM0xLd3dwMTBBMUxUbEZ0bDdL?=
 =?utf-8?B?RVZ0V2IrZ1kwa0NUSWVZRUp5ejl3c1FvclhzQnQ1T1h5K3dHTGZYY0U3Mmxw?=
 =?utf-8?B?SWJ3Z0oxTll6ZEJYbEtEY0hYbmRXUWs5aG91MHMwWFByUnlFdFpEOGhHTHZy?=
 =?utf-8?B?azBzNTQ1MVcrSGhIRzFrS0Y2NjZmUDNYRGVDRDZUc0ZvbGJ6ckQvYUpZd253?=
 =?utf-8?B?K1p3QVI5cUIwNGFKdXhhcy9mT2tqc3FlMmZCOXpKSDhxOFdzRDdHSnlkeThZ?=
 =?utf-8?B?Y0VnRmNGcERQMUtPUUdPYUZQU0R1cXZKMmVoMHNiU0FRV2c2T0xNQXFxdmpS?=
 =?utf-8?B?SDFobGhWakYzM0lhbS9uOEJKR1Y2V1YvNGVnZGM4YnFZRFlYNjBzcFFlL3VX?=
 =?utf-8?B?aE8yclBHc2xyMm1kUXJFdXJkYWhwODk2bldvMitFeHpXSHRjSnZGYWFTaHI5?=
 =?utf-8?B?VmdFbW0vd1R5dDlzanV4MGlNYlRZSmdsNGhBOUNWdjQ2VkZmdDhhd05RSEVj?=
 =?utf-8?B?VForSkFISnBEZHBWRnZzMW9CZ0lnRmdrd2duWjBpYzFBZk5wUmVRaVBuNG9w?=
 =?utf-8?B?NGtuREQxRVRTUXZBL2pKKzlFQndoTWdaNDJ1eFNMWTB3SUhEMkdqZnZjM2lV?=
 =?utf-8?B?N3dHRS93aXdzZmtNMGxXSUNHUFBYd0ZINVd5KzhwL21FMXh5VWtNTVZyd2tC?=
 =?utf-8?B?aXY2bkYyWTg4dHFkWW1YV09RRDZoQWx3T2lFeWYwdERVR3pVZXdXbnM5N1dB?=
 =?utf-8?B?alNsQ3lVRXRQZGJFa2ZkVTBvNzB0d0FROHBQd1hrSHkzcmVEeXdhWXNHZmNa?=
 =?utf-8?B?a0ZYdi9BbXJ5ZGhxQ0ZLdDBoVmJ5T29xTlltNXlIVXlSMWxySFo5MERRcVU1?=
 =?utf-8?B?T1M0VGhvWTVMWDd1a240L2Z1K0taQnJNQlJMdWVWNEpvdVNDMEZsV3RQaXcr?=
 =?utf-8?B?Y3d4cUpubXpJUU5oWkJjVExpdndaNkM1enZIcCt1dWo2QjVibXBJZy9NNXNj?=
 =?utf-8?B?MnlpUVRLa09NMTJQaW8rVjlmTTR4bGhxSG5JakYxQUpjRHJWL3ExYjVoNmoy?=
 =?utf-8?B?N1c5S0x2UzE2c3BSTjI5ZE9GOXBLRitCZy9vMTNvOGJKbTgvN3R1TndMdmpT?=
 =?utf-8?B?TFd2MERGL28vdzhZQ0ZOU0ZJMW94ODd1OEFLQ3dJZXhpOUJDOUV3ZHNZZEhG?=
 =?utf-8?B?aHRLTERsUUMydjZLc1dPdWNLUkpJYVpTVUtwVFVqWTZaSDVTR3c1eWFRRWh5?=
 =?utf-8?B?aGtDR1V0UStlVVlGa1g3WG5LNE45TVlrVStzdXNJWTlvelVka2ZKMnB3ZDhB?=
 =?utf-8?B?YWwwclEwZzNTTjQxOG9PeHVvZXR5SlJ1RWVvVVJoN0R3eTFPeGpVZFdiYXJD?=
 =?utf-8?B?UFI5cFZFYTdRV28xTWsyWDZ3bXFKRC9iVHgvd09ZRWYvOGExcC9Qc3Y3RmI1?=
 =?utf-8?B?eVVLVllpZWtkdFFkZEU1SWFsQlpWZDRlck1ZZzdGTjRXY2xmWlJ5dnFTc2lS?=
 =?utf-8?B?a0d5SU02OFRUa1hZR04vYUQyUlU3OE1tRjZtMjVIL2Y3anZLWEsydGdqSGNF?=
 =?utf-8?B?N2dUSHVoK2wwWUdTbWxlVkRKOTd5eVZPY0RjdHBNa2JaZDNuUTNESXlXck5P?=
 =?utf-8?Q?uTTm8yRsQodnwcZI=3D?=
X-OriginatorOrg: oppo.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 3de1f1fb-0b06-4102-6ba0-08da319d8526
X-MS-Exchange-CrossTenant-AuthSource: TY2PR02MB4431.apcprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 May 2022 09:23:04.3141
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: f1905eb1-c353-41c5-9516-62b4a54b5ee6
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 4WBw+KzdnFV+6pxby+2xvk9ZeJf4/zFviPABlG1JjLa9c/8s3LTPfpN2DN5/JakwYrJ/eppcSUxi7sPQ1Kt+ig==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2PR02MB4033
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SGnCoEFuZHJld++8mgoKVGhhbmsgeW91IGZvciB5b3VyIHJlc3BvbnNlLgoKPiA+ID4gVGhleSBj
YXVzZWQgbWUgc29tZSBtZXJnZSBpc3N1ZXMgYWdhaW5zdCBtYXBsZXRyZWUsIHdoaWNoIEkgaGFk
Cj4gPiA+IHJlc29sdmVkLiDCoE1hcGxldHJlZSBpcyBkcm9wcGVkIGF0IHByZXNlbnQgc28gSSBz
ZXQgdGhlc2UgcGF0Y2hlcyBhc2lkZQo+PiA+IHVudGlsIHRoZSBuZXh0IHZlcnNpb24gb2YgdGhl
IG1hcGxldHJlZSBwYXRjaGVzIGFyZSBhdmFpbGFibGUuCj4+Cj4+IERvIHdlIGhhdmUgYSBkZWZp
bml0ZSB0aW1lIGZvciB0aGUgbmV4dCBhdmFpbGFibGUgdmVyc2lvbiBvZiB0aGUgbWFwbGV0cmVl
IHBhdGNoZXM/CsKgCj4gSSBtZXJnZWQgdjIgYSBjb3VwbGUgb2YgZGF5cyBhZ28uIMKgSXQgc2hv
dWxkIGJlIGluIG1tLXVuc3RhYmxlIHRoZW4KPiBsaW51eC1uZXh0IGVhcmx5IG5leHQgd2Vlay4K
Ck9rLCBpcyAidjIgbWVyZ2VkIiB0aGUgcGF0Y2ggZnJvbSBtZT8KMS4gbW0tbW9kaWZ5LXRoZS1t
ZXRob2QtdG8tc2VhcmNoLWFkZHItaW4tdW5tYXBwZWRfYXJlYV90b3Bkb3duLnBhdGNoIGFkZGVk
IHRvIC1tbSB0cmVlClRoaXMgcGF0Y2ggc2hvdWxkIHNvb24gYXBwZWFyIGF0Cmh0dHBzOi8vb3ps
YWJzLm9yZy9+YWtwbS9tbW90cy9icm9rZW4tb3V0L21tLW1vZGlmeS10aGUtbWV0aG9kLXRvLXNl
YXJjaC1hZGRyLWluLXVubWFwcGVkX2FyZWFfdG9wZG93bi5wYXRjaAphbmQgbGF0ZXIgYXQKaHR0
cHM6Ly9vemxhYnMub3JnL35ha3BtL21tb3RtL2Jyb2tlbi1vdXQvbW0tbW9kaWZ5LXRoZS1tZXRo
b2QtdG8tc2VhcmNoLWFkZHItaW4tdW5tYXBwZWRfYXJlYV90b3Bkb3duLnBhdGNoCgoKMi4gbW0t
Zml4LWFsaWduLWVycm9yLXdoZW4tZ2V0X2FkZHItaW4tdW5tYXBwZWRfYXJlYV90b3Bkb3duLnBh
dGNoIGFkZGVkIHRvIC1tbSB0cmVlClRoaXMgcGF0Y2ggc2hvdWxkIHNvb24gYXBwZWFyIGF0Cmh0
dHBzOi8vb3psYWJzLm9yZy9+YWtwbS9tbW90cy9icm9rZW4tb3V0L21tLWZpeC1hbGlnbi1lcnJv
ci13aGVuLWdldF9hZGRyLWluLXVubWFwcGVkX2FyZWFfdG9wZG93bi5wYXRjaAphbmQgbGF0ZXIg
YXQKaHR0cHM6Ly9vemxhYnMub3JnL35ha3BtL21tb3RtL2Jyb2tlbi1vdXQvbW0tZml4LWFsaWdu
LWVycm9yLXdoZW4tZ2V0X2FkZHItaW4tdW5tYXBwZWRfYXJlYV90b3Bkb3duLnBhdGNoCgoKPiA+
IEV4Y3VzZSBtZSwgaXMgaXQgcG9zc2libGUgZm9yIG91ciBwYXRjaCB0byBiZSBpbmRlcGVuZGVu
dCBvZiBtYXBsZXRyZWUgYW5kIGJyb3VnaHQgaW4gc2VwYXJhdGVseT8KwqAKPiBXZWxsLCB0aGUg
Y2hhbmdlbG9nIHdhcyByYXRoZXIgdW5jbGVhciBvbiB0aGUgcmVhbC13b3JsZCBlbmQtdXNlcgo+
IHZpc2libGUgZWZmZWN0cyBvZiB0aGUgZGVmZWN0LiDCoFdoZW4gdGhlc2UgcHJpb3JpdGl6YXRp
b24gZGVjaXNpb25zIGFyZQo+IHRvIGJlIG1hZGUsIGl0IHJlYWxseSBoZWxwcyB0byBoYXZlIGEg
Y2xlYXIgdmlldyBvZiB0aGUgaW1wYWN0IHRvIG91cgo+IHVzZXJzLgoKV2VsbCwgd2UgaGFkIGZv
dW5kIHRoYXQgc29tZSBhcHBzLWNyYXNoKFRJRl8zMkJJVCkgZHVlIHRvICJPdXQgb2YgbWVtb3J5
IiwgwqB3aGljaCB0aGUgc2luZ2xlIGxhcmdlc3QgcmVtYWluaW5nCmZyZWUtYWRkci1zcGFjZSBp
cyAxMk1ieXRlcyBpbiBzb21lIGNhc2UsIHdlIGZvdW5kIHRoYXQgdGhlIHByb2Nlc3NlcyB3b3Vu
ZCBmYWlsIHRvIGFsbG9jCmEgMTJNYnl0ZXMoYWxpZ24gMU0pIGluIHRoZSBvbGQgbWV0aG9kcyBz
byB0aGF0IE91dC1vZi1NZW1vcnkuCnN1Y2ggYXMgV2VjaGF0IGFuZCBvdGhlcnMgQW5kcm9pZCBh
cHBzLgoKPiA+Cj4gPiA+IEkndmUgYmVlbiBob2xkaW5nIHlvdXIgcGF0Y2hlcyB1bnRpbCBNaWNo
ZWwgTGVzcGluYXNzZSBoYXMgaGFkIHRpbWUgdG8KPiA+ID4gcmV2aWV3IHRoZW0gKGFuZCBob3Bl
ZnVsbHkgZXhwbGFpbiB0aGVtIHRvIG1lIDspKS4gwqBQbGVhc2UgcmV2aWV3Cj4gPiA+IGVhcmxp
ZXIgY29tbWVudHMgd2hpY2ggTWljaGVsIGhhcyBwcm92aWRlZCBhbmQgZW5zdXJlIHRoYXQgdGhv
c2UKPiA+ID4gY29tbWVudHMgaGF2ZSBiZWVuIGZ1bGx5IGFkZHJlc3NlZCBzbyB3ZSBjYW4gaG9w
ZWZ1bGx5IG1vdmUgZm9yd2FyZCBvbgo+ID4gPiB0aGlzLgo+ID4KPiA+IFdlIHdpbGwgcmVwbHkg
c29vbiBpZiBNci5MZXNwaW5hc3NlIHByb3ZpZGVkcyBhbnkgYWR2aWNlcyBvciBxdWVzdGlvbi4K
PiA+IEFuZCBJIGhhdmVuJ3QgcmVjZWl2ZWQgYW55IHJlcGx5IGZyb20gTXIuTGVzcGluYXNzZSB5
ZXQsIHBscyBsZXQgbWUga25vdwo+ID4gaWYgaSBtaXNzZWQgdGhlIHJlcGx5Lgo+Cj4gVGhlcmUg
d2FzIGEgYmlnIGNvbmZlcmVuY2UgbGFzdCB3ZWVrLgoKSSBtaXNzZWQgaXQgYW5kIGlmIHRoZXJl
IGFueSBwcm9ibGVtcyBhYm91dCB0aGUgcGF0Y2hlcyB3aGljaCBuZWVkIG1lIHRvIGFuc3dlciwK
cGxzIGxldCBtZSBrbm93IGFuZCBpIGhvcGUgaSBjYW4gZ2l2ZSBhIGNsZWFyIHJlcGx5LgoKVGhh
bmsgeW91IHZlcnkgbXVjaCBpbmRlZWQuCgpsaXBlaWZlbmdAb3Bwby5jb20KwqAKRnJvbTrCoEFu
ZHJldyBNb3J0b24KRGF0ZTrCoDIwMjItMDUtMDjCoDA1OjU5ClRvOsKgbGlwZWlmZW5nQG9wcG8u
Y29tCkNDOsKgbWljaGVsOyBodWdoZDsgbGludXgtbW07IGxpbnV4LWtlcm5lbDsgQmFycnkgU29u
ZzsgemhhbmdzaGltaW5nOyBwZWlmZW5nbDU1ClN1YmplY3Q6wqBSZTogW1BBVENIXSBtbTogZml4
IGFsaWduLWVycm9yIHdoZW4gZ2V0X2FkZHIgaW4gdW5tYXBwZWRfYXJlYV90b3Bkb3duCk9uIE1v
biwgMiBNYXkgMjAyMiAxMTozMzoxOCArMDgwMCAibGlwZWlmZW5nQG9wcG8uY29tIiA8bGlwZWlm
ZW5nQG9wcG8uY29tPiB3cm90ZToKwqAKPiBIacKgQW5kcmV377yaCj4KPiBUaGFua3MgZm9yIHlv
dXIgcXVpY2sgcmVzcG9uc2UuCj4KPiA+IFRoZXkgY2F1c2VkIG1lIHNvbWUgbWVyZ2UgaXNzdWVz
IGFnYWluc3QgbWFwbGV0cmVlLCB3aGljaCBJIGhhZAo+ID4gcmVzb2x2ZWQuIMKgTWFwbGV0cmVl
IGlzIGRyb3BwZWQgYXQgcHJlc2VudCBzbyBJIHNldCB0aGVzZSBwYXRjaGVzIGFzaWRlCj4gPiB1
bnRpbCB0aGUgbmV4dCB2ZXJzaW9uIG9mIHRoZSBtYXBsZXRyZWUgcGF0Y2hlcyBhcmUgYXZhaWxh
YmxlLgo+Cj4gRG8gd2UgaGF2ZSBhIGRlZmluaXRlIHRpbWUgZm9ywqB0aGUgbmV4dCBhdmFpbGFi
bGUgdmVyc2lvbiBvZiB0aGUgbWFwbGV0cmVlIHBhdGNoZXM/CsKgCkkgbWVyZ2VkIHYyIGEgY291
cGxlIG9mIGRheXMgYWdvLsKgIEl0IHNob3VsZCBiZSBpbiBtbS11bnN0YWJsZSB0aGVuCmxpbnV4
LW5leHQgZWFybHkgbmV4dCB3ZWVrLgrCoAo+IEV4Y3VzZSBtZSwgaXMgaXQgcG9zc2libGUgZm9y
IG91ciBwYXRjaCB0byBiZSBpbmRlcGVuZGVudCBvZiBtYXBsZXRyZWUgYW5kIGJyb3VnaHQgaW4g
c2VwYXJhdGVseT8KwqAKV2VsbCwgdGhlIGNoYW5nZWxvZyB3YXMgcmF0aGVyIHVuY2xlYXIgb24g
dGhlIHJlYWwtd29ybGQgZW5kLXVzZXIKdmlzaWJsZSBlZmZlY3RzIG9mIHRoZSBkZWZlY3QuwqAg
V2hlbiB0aGVzZSBwcmlvcml0aXphdGlvbiBkZWNpc2lvbnMgYXJlCnRvIGJlIG1hZGUsIGl0IHJl
YWxseSBoZWxwcyB0byBoYXZlIGEgY2xlYXIgdmlldyBvZiB0aGUgaW1wYWN0IHRvIG91cgp1c2Vy
cy4KwqAKPgo+ID4gSSd2ZSBiZWVuIGhvbGRpbmcgeW91ciBwYXRjaGVzIHVudGlsIE1pY2hlbCBM
ZXNwaW5hc3NlIGhhcyBoYWQgdGltZSB0bwo+ID4gcmV2aWV3IHRoZW0gKGFuZCBob3BlZnVsbHkg
ZXhwbGFpbiB0aGVtIHRvIG1lIDspKS4gwqBQbGVhc2UgcmV2aWV3Cj4gPiBlYXJsaWVyIGNvbW1l
bnRzIHdoaWNoIE1pY2hlbCBoYXMgcHJvdmlkZWQgYW5kIGVuc3VyZSB0aGF0IHRob3NlCj4gPiBj
b21tZW50cyBoYXZlIGJlZW4gZnVsbHkgYWRkcmVzc2VkIHNvIHdlIGNhbiBob3BlZnVsbHkgbW92
ZSBmb3J3YXJkIG9uCj4gPiB0aGlzLgo+Cj4gV2Ugd2lsbCByZXBseSBzb29uIGlmIE1yLkxlc3Bp
bmFzc2UgcHJvdmlkZWRzIGFueSBhZHZpY2VzIG9yIHF1ZXN0aW9uLgo+IEFuZCBJIGhhdmVuJ3Qg
cmVjZWl2ZWQgYW55IHJlcGx5IGZyb20gTXIuTGVzcGluYXNzZSB5ZXQsIHBscyBsZXQgbWUga25v
dwo+IGlmIGnCoG1pc3NlZCB0aGUgcmVwbHkuCsKgClRoZXJlIHdhcyBhIGJpZyBjb25mZXJlbmNl
IGxhc3Qgd2Vlay4=
