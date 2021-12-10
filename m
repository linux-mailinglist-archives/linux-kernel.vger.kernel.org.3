Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0298546F83E
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 02:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235123AbhLJBLF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 20:11:05 -0500
Received: from m2mda239.as.sphere.ne.jp ([210.136.9.239]:35543 "EHLO
        m2mda239.as.sphere.ne.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235106AbhLJBLE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 20:11:04 -0500
Received: from m2kbo002.p.as.sphere.ne.jp (m2lb000.f.as.sphere.ne.jp [172.16.116.10])
        by m2mx401.p.as.sphere.ne.jp  with ESMTP id 1BA17SjH005427;
        Fri, 10 Dec 2021 10:07:28 +0900
Received: from localhost.localdomain (localhost [127.0.0.1])
        by m2kbo002.p.as.sphere.ne.jp (8.14.4/8.14.4) with ESMTP id 1BA17S2B014735;
        Fri, 10 Dec 2021 10:07:28 +0900
Received: by nttd-mse.com (Postfix, from userid 0)
        id 787C7811D9; Fri, 10 Dec 2021 10:07:27 +0900 (JST)
Received: from m2lb000.f.as.sphere.ne.jp [172.16.116.10] 
         by m2gwa131.p.as.sphere.ne.jp with ESMTP id LAA19952;
         Fri, 10 Dec 2021 10:07:27 +0900
Received: from m2msa401-121.as.sphere.ne.jp ([172.16.116.10])
        by m2vok402.p.as.sphere.ne.jp with ESMTP
        id vUNjmcCzcd5ItvUNjmMl8M; Fri, 10 Dec 2021 10:07:27 +0900
Received: from JPN01-OS0-obe.outbound.protection.outlook.com (mail-os0jpn01lp2109.outbound.protection.outlook.com [104.47.23.109])
        (using TLSv1.2 with cipher AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by m2msa401-121.as.sphere.ne.jp (Postfix) with ESMTPS id 48C21AC0051;
        Fri, 10 Dec 2021 10:07:27 +0900 (JST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dnYKJo3ytHVvyXcDKO5boOXVFPBzhxkxijoHIKqyXU6uxvBIQlIlHdhPxsk3GpEJUiFxtCYXT1PTvm19wQvShHIxbxTXtxGx9/UHKWldzLYLDoSKqNhykN+5Ypwv5np0O/+ItAT+z0B9XLov9NmrjQlRIJVOCN3dGRHJADT+bjhGpw20gUvvs7DXpWxNm3JCpA5MTSx+doP1ooul3prIt0n5QaKmzzKeb2aTwxRSBEUAOcXuEBPchY/9pPE7kIwrNex06gVVv4Lt6E1roUbnNeUpq+Y9CErHiolcdK53G6V+AKxnfS/u1Wl5UIox++lF28S6U/RYo9POHcXoVgDg9g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=jFTJxjP6MMMfRa4ly+aFKxJmtjIjIRRx5lTaFMdNL7o=;
 b=O3PU/ttxCpZN5iU2iPEElw0Rp3uThl6OA4cPxycZQiJE6TaJ5t7dXDESLHoAdwA1I2tKjfRL5vbpi20Ob32saq72tiwQilEz3MRo914THKgWNq8P5dPR4YjxwJiDcSvV92qRSLLKvUHnje8kd3F391ZLC1CKpiJaRQcR+YhbZ5UKnM6TKfaXSqZYNufVgEVon9dFxJFTWNyKknfgla/9CsSQ5VaJSm9mGqP/y/U8kHwKYbblbH07dq3R7v2c11WgNfbIUVejTuUlMz8oC6mgNzaD0j6gLtj0DAfZ8B1rIEJ1jPxJEcOx24QtynDBYtv98vIW9B/BosOWPoALMVqpsQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nttd-mse.com; dmarc=pass action=none header.from=nttd-mse.com;
 dkim=pass header.d=nttd-mse.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nttd-mse.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jFTJxjP6MMMfRa4ly+aFKxJmtjIjIRRx5lTaFMdNL7o=;
 b=Gz2wqBiv7FiU4KZMfngZTJj7f6r3pt4YevTKsflsgLUYceIq1DXoIgS23ApbmJY7UrtpUIedMgFfC3+WOzH1EpNKT5BwWqx2OJefksqprYi9a7iW/c2W9MfX7UQqHb0bo8j6jBGrTYiM8UmP1bMAez9gGsp+rjEPWA6XTeJKPKhnNmw7fAXVGbBwDoTcYa2jX/wRRTqwsnKA5l1IsJmeyInoHB7a3XnXhE5Y1kC29sN2c0g2BZjEZM0XlCqNWtyBFLb8mWgYv7s6cO1Bc/ZJo4dwTsvFtnSJXzIyY8IxgsR6Gr6FVKBYcMrMCwFSu0AY+GgRJm4/R2e0KQHjibz/+w==
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:13e::12)
 by TYCP286MB1490.JPNP286.PROD.OUTLOOK.COM (2603:1096:400:17b::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.20; Fri, 10 Dec
 2021 01:07:26 +0000
Received: from TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb]) by TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
 ([fe80::1034:9079:95bb:fffb%9]) with mapi id 15.20.4755.022; Fri, 10 Dec 2021
 01:07:26 +0000
From:   =?iso-2022-jp?B?GyRCPi5AbiEhPSQwbBsoQg==?= 
        <ogawa.syuuichi@nttd-mse.com>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     =?iso-2022-jp?B?GyRCOzNLXCEhQyM7SxsoQg==?= 
        <yamamoto.tatsushi@nttd-mse.com>,
        "Natsume, Wataru (ADITJ/SWG)" <wnatsume@jp.adit-jv.com>,
        =?iso-2022-jp?B?GyRCPi5AbiEhPSQwbBsoQg==?= 
        <ogawa.syuuichi@nttd-mse.com>
Subject: RE: invalid counter value in request_queue
Thread-Topic: invalid counter value in request_queue
Thread-Index: Adfssg136nOi2cDETFCz0vQyCAj2ZwAq7JVgAAD91uA=
Date:   Fri, 10 Dec 2021 01:07:26 +0000
Message-ID: <TYWP286MB226710E14843B461637C4DC6B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
References: <TYWP286MB226752FFC0E0E33777AB319FB9709@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
 <TYWP286MB226753FF279AA2953028BDA9B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
In-Reply-To: <TYWP286MB226753FF279AA2953028BDA9B9719@TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM>
Accept-Language: ja-JP, en-US
Content-Language: ja-JP
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nttd-mse.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 156a2ec4-167d-4b38-8db2-08d9bb796e15
x-ms-traffictypediagnostic: TYCP286MB1490:EE_
x-microsoft-antispam-prvs: <TYCP286MB1490DB5C535204E637C08F7BB9719@TYCP286MB1490.JPNP286.PROD.OUTLOOK.COM>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: NWwz/TdOLOR4bHv/lG4A5/zQZLgwINddvaV8LVP4SjApTEcEJgA/ho4AxW1mETAuq26UVbciKtJf8JBRRuUNa5BRH4qoRhGmGfoqcd6TASYFIgmTf9Z7sWon8OlQ5wghn8Jp6iQ/cjhVJoUA97VKzAgmjRJ2SXcsvlz2SVdCLQe6QCVByP9yiPnDlk7/uOIfkijVsStVvBhLIYky8OL1TQmY2jCZ+75T8DVfpcTTIewgJSH/BG12LRNqc8FmXT6cPI7TsJhnsMpx9po6zK4xXc1KLjaxLXCR6AYV9w66+FrlzohR71zM180nU4+zP45UAXsF5PxH1rocILvi8QA/hoBJCY6ERYwuay5EGE3YaECV7UNfTL8zsD3abGUkDvfleaWBp6HkCNeu4fiQALfwZJQ356TV/6FEUP3DQZCx1HdVznvLlsHUSmCsLBfwPevuIcHw4WHplvSNKOnTLDAxQI9DOMoWANa+CHSbMRAaResWMrOB4zK1i4a3Va3tHiURuElesagI2PXoqPiAqZcyxbqj+JnhtO/rdde2lSTTLZiO9l+/ppoodFx8T5LsFm5M6wMdTO8/habVhwdt8qpUO6o5vW3NNMEmJGM477IHTGFl+wQ3qOy8XJkVwhJAW5EVpJmf2iz2O9Mlq4+FUljOhS+kbvolSB0SAtgO9e9+SHAmLV4igyoB3RNb3Atte0AeNQk+/tWi2W14pfdMrp89Yg==
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM;PTR:;CAT:NONE;SFS:(366004)(76116006)(82960400001)(83380400001)(71200400001)(8676002)(2906002)(86362001)(122000001)(186003)(54906003)(38070700005)(38100700002)(52536014)(66556008)(66446008)(5660300002)(53546011)(9686003)(6916009)(66946007)(508600001)(85182001)(8936002)(33656002)(26005)(2940100002)(64756008)(4326008)(66476007)(55016003)(107886003)(6506007)(316002)(7696005);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?iso-2022-jp?B?MzcwTWt5enBTWWk0NmxxVis1L2xpbHRqUEF5U3F2QS9YY0E0dWtBQnpX?=
 =?iso-2022-jp?B?WEN0OHMwZGw5c2R6MmIrODlvNUtpQ08vOGlXaWtPcXVtRUh3ODNtbC9v?=
 =?iso-2022-jp?B?elIxeXdTL3lvNTk3MkR2T2Ftbjk2RUJScnBNaEVQdytBdUJHOFZiSTRH?=
 =?iso-2022-jp?B?NVBVR21oQUlxeEo0YmdLM2swRlorZ0dWU1NJSk4zOHhlRktyTHpsUDg5?=
 =?iso-2022-jp?B?bFc4bGJ0Y1E5cXkvZTFCdU4xL1pDQmFuRUR2eEQvbGZWOWE2cThlWFZ1?=
 =?iso-2022-jp?B?WWV4R09VbFJ5WlF4RGxVV3BWbktWT3VPbU1KQnZEQXdpTEYyekI4bTJ0?=
 =?iso-2022-jp?B?aHBWWVltdmhQUmFtelhJMmp6R0lGZlR5azM2OVp0UGNZYkt0aVBWcS9h?=
 =?iso-2022-jp?B?b3F6ZFhFTVNNWWsxdkt2VmRmemFWbTBVV3BGT1pPamZTM29HNTE1Vi8y?=
 =?iso-2022-jp?B?U0gySFJQZ1lJQkdPeTlnOWdEcU1tY1Q2SXd2VDB1VUk3VmQycy8rUkpR?=
 =?iso-2022-jp?B?dHpCWDJESjdlT3dQdk96V0Z1cHhOc1BtVXZmYVFJS1JhMmUrcjhnbHAr?=
 =?iso-2022-jp?B?bXlwL29tTXE0bEs0dVk1WGlpMnZlMUM2OTRUbXJXS1FMZ2pnVlZVMzFW?=
 =?iso-2022-jp?B?L25KOHBhb1pkd1RVYkFHbVo2cWZjcE9VdUxIdGpWNmxONEJ6bXBhYnM2?=
 =?iso-2022-jp?B?U3RYRk1wYXJJRDhnNC9IMkt1NHRMdXFpZnBnZW5oaytpSE1vbkk0REI0?=
 =?iso-2022-jp?B?U25qakVWMU1UTE9tRkEvdm5MVFRBZkd5K0xHeUpyNE9uSlR1VlQ0TnBt?=
 =?iso-2022-jp?B?dkpjMWxaUXZYT3RRR0xvQXNtWTEranF4cXBKNkcyS1pTazI5VWJVVnpI?=
 =?iso-2022-jp?B?aCtGRk1yRnoya2t1ZGxiRUNzeDF3R2NWQXo4cTM1N2M2WTl2dmFDSmZE?=
 =?iso-2022-jp?B?Z3J5NmVWRE5QcDNmZ1JORXRhS1lQb25vQ2tqbFF6MjlUaWsyZTNUNDI2?=
 =?iso-2022-jp?B?RUV5OXJMK1pLejhQVmt2VVRuUmFUZ0pGV3BrYTJiRTNOV2lOdVVYa1Vk?=
 =?iso-2022-jp?B?YW1od3RTY1RKVDJnSjQrV3NNV0FvNDFTcFZzNkpkTW9qR29kbmM5WkMz?=
 =?iso-2022-jp?B?OGtOZW9KSkNnaWNvbEF3YVlTWHQrN1duZFlJS1JmdGN0aUZkOHRVc0JC?=
 =?iso-2022-jp?B?endZb0xqOSs1OWtUVHdvV3htUTdPM2pXeC9qL2hIZFNuR0RxWXFOL3oz?=
 =?iso-2022-jp?B?SktlamFpVU1mT2w5WTE4aDIwR2psNFR5TVVIcnFRa3RXaGFUREZ0UUIv?=
 =?iso-2022-jp?B?Tk4rSVROY3RYWGRiOXNNNFFGUXg4RVN0ZEhUaGFLRS9nUGJyOGhBWnNL?=
 =?iso-2022-jp?B?YTlSYnRVa2Q2RE94QnVoVmpQSDJ6OGVUazMwYkdLUVdmc1ZKc1RKcExC?=
 =?iso-2022-jp?B?c2ZUMHdHbEkyNGQydE4rVVBzZTJqMGVwRlA0UEdVZGs3ZDN5RTNzbEsz?=
 =?iso-2022-jp?B?S3FSU1NpRXZiTGJuSmpsaHpFNVcyNUZhSFJPakV6NldKVWZ2cW9GYzRk?=
 =?iso-2022-jp?B?Sis5TlYvcHlEYitsVjM1WHY5aU1oVmNHbUV1OGNEQzkwYzhLTHpFN0ZU?=
 =?iso-2022-jp?B?YWszZTVRbUtXYVZEaHRrOFVvK0VhNEk5cTBKOVQ0clJQTW9qek5MRERh?=
 =?iso-2022-jp?B?b0Z1ZitiMFVZTnlBaUFvNUdWNlgraGIwUVVwR0c5NkNZTEVGVlM2SG9J?=
 =?iso-2022-jp?B?QVZuVld5NUhWeTVDRmk0ZkJoMmI3aHJRbFZRelFuOGdCQVltUnZwTkJy?=
 =?iso-2022-jp?B?UGpaTVRNN1Rvd3lFTFZIbldIY042akordVQ3NVVWMVBHNEwrMU9zRjJY?=
 =?iso-2022-jp?B?N2ZoU3NkTlZyWlYxMFlndkVOeCtpWlAwZlI5dFdFSEtDQnp6QUdoZTdz?=
 =?iso-2022-jp?B?dU1oY3RlajZkY2VsQVREdjBycG5OSFN1cEZiQTRCRWtSODZmclhMdG1F?=
 =?iso-2022-jp?B?NzZBUEdDS2FEcmNKd1ZRQUp5eFBlZHFSbVpoRzl0THNydVRURGVsTkc1?=
 =?iso-2022-jp?B?V1JpUTdENHhrZDVDa3ZqMmhHMElIMSt0ZS81Qk9aOHBNUTU1cWl6RnRr?=
 =?iso-2022-jp?B?T00yQVJzZ2NwVlUyNDNIb1dhWm9laVZuTHZHR1o4dk5KSkgxQTBWbDky?=
 =?iso-2022-jp?B?WG5pejljb2dYdnJXSzRDOGdtUUN2R2MxWmRyUEhYbzdyWDNVZW9QL0RV?=
 =?iso-2022-jp?B?THdNN1JFZDZiNEx0V0MrWEJXeE1YQ3NqL3VZeVR6eHVkaWpkT2xMR0pw?=
 =?iso-2022-jp?B?Rk82c3pxU2hLTnFlN0JwL2xoQ0l1bDlhK1plb254SVhyaVZsbDFDNGpL?=
 =?iso-2022-jp?B?cldhSTBZZk91d3NiNGNpeFZpWU1hRzdlWFdsay95SVJoeEV5UGpvaVg0?=
 =?iso-2022-jp?B?NldlZjVnPT0=?=
Content-Type: text/plain; charset="iso-2022-jp"
content-transfer-encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: nttd-mse.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: TYWP286MB2267.JPNP286.PROD.OUTLOOK.COM
X-MS-Exchange-CrossTenant-Network-Message-Id: 156a2ec4-167d-4b38-8db2-08d9bb796e15
X-MS-Exchange-CrossTenant-originalarrivaltime: 10 Dec 2021 01:07:26.1092
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 6f1f471a-dbdb-48eb-a905-2d249e046ae5
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: KJxOa4Ge9hRPvWHTVobFQMX7Ept40WeSw4g6Vhag7zlfYp/ZkrCFHJmS56DRfKaRn1nras8BkFu7c4NA7YCTubumdzNGEenfIdZDNRozHRk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: TYCP286MB1490
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I forgot to take care gdb-script about ATOMIC mode in percpu_count_ptr.  =
 I fixed the script then I got:=0D=0A=
=0D=0A=
super_block 0xffff9bb3f8bbcc30 "vdb"=0D=0A=
 q=3D(struct request_queue *) 0xffff9bb3fb53d1c0,q->q_usage_counter.percp=
u_count_ptr=3D(unsigned long *) 0x3a80c000b2b9=0D=0A=
 0:0xffffd634bfc0b2b8,0x0,0=0D=0A=
 1:0xffffd634bfc8b2b8,0x0,0=0D=0A=
 2:0xffffd634bfd0b2b8,0x0,0=0D=0A=
=0D=0A=
Result is as same as previous my e-mail.=0D=0A=
=0D=0A=
-----Original Message-----=0D=0A=
From: =1B$B>.@n!!=3D$0l=1B(B =0D=0A=
Sent: Friday, December 10, 2021 9:54 AM=0D=0A=
To: linux-kernel@vger.kernel.org=0D=0A=
Cc: =1B$B;3K\!!C#;K=1B(B <yamamoto.tatsushi@nttd-mse.com>; Natsume, Watar=
u (ADITJ/SWG) <wnatsume@jp.adit-jv.com>=0D=0A=
Subject: RE: invalid counter value in request_queue=0D=0A=
=0D=0A=
Hi all=0D=0A=
=0D=0A=
I understood the reason why per-cpu couner became negative.=0D=0A=
As I mention previous mail, q_usage_counter should be atomic counter.=0D=0A=
percpu_refcount has not only percpu counter but also ATOMIC counter mode.=
=0D=0A=
=0D=0A=
As fact, blk_alloc_queue_node() initialize request_queue->q_usage_counter=
 as ATOMIC_MODE like this:=0D=0A=
=0D=0A=
        /*=0D=0A=
         * Init percpu_ref in atomic mode so that it's faster to shutdown=
.=0D=0A=
         * See blk_register_queue() for details.=0D=0A=
         */=0D=0A=
        if (percpu_ref_init(&q->q_usage_counter,=0D=0A=
                                blk_queue_usage_counter_release,=0D=0A=
                                PERCPU_REF_INIT_ATOMIC, GFP_KERNEL))=0D=0A=
=0D=0A=
However, q_usage_counter becomes percpu mode at blk_register_queue() .=0D=
=0A=
=0D=0A=
blk_register_queue()=0D=0A=
=0D=0A=
        /*=0D=0A=
         * SCSI probing may synchronously create and destroy a lot of=0D=0A=
         * request_queues for non-existent devices.  Shutting down a full=
y=0D=0A=
         * functional queue takes measureable wallclock time as RCU grace=
=0D=0A=
         * periods are involved.  To avoid excessive latency in these=0D=0A=
         * cases, a request_queue starts out in a degraded mode which is=0D=
=0A=
         * faster to shut down and is made fully functional here as=0D=0A=
         * request_queues for non-existent devices never get registered.=0D=
=0A=
         */=0D=0A=
        if (!blk_queue_init_done(q)) {=0D=0A=
                queue_flag_set_unlocked(QUEUE_FLAG_INIT_DONE, q);=0D=0A=
                percpu_ref_switch_to_percpu(&q->q_usage_counter);=0D=0A=
                blk_queue_bypass_end(q);=0D=0A=
        }=0D=0A=
=0D=0A=
=0D=0A=
When I remove percpu_ref_switch_to_percpu(&q->q_usage_counter) in blk_reg=
ister_queue() ;=0D=0A=
=0D=0A=
- At least percpu counter is no longer used.=0D=0A=
=0D=0A=
super_block 0xffff9bb3f8bbcc30 "vdb"=0D=0A=
 q=3D(struct request_queue *) 0xffff9bb3fb53d1c0,q->q_usage_counter.percp=
u_count_ptr=3D(unsigned long *) 0x3a80c000b2b9=0D=0A=
 0:0xffffd634bfc0b2b9,0x0,0=0D=0A=
 1:0xffffd634bfc8b2b9,0x0,0=0D=0A=
 2:0xffffd634bfd0b2b9,0x0,0=0D=0A=
=0D=0A=
You can find percpu_count_ptr has a bit __PERCPU_REF_ATOMIC=3D0x1 per cpu=
 counter looks not used=0D=0A=
=0D=0A=
- I check again q_usage_counter.=0D=0A=
=0D=0A=
crash> p $q->q_usage_counter=0D=0A=
$1 =3D {=0D=0A=
  count =3D {=0D=0A=
    counter =3D 5=0D=0A=
  },=0D=0A=
  percpu_count_ptr =3D 64324651496121,=0D=0A=
  release =3D 0xffffffff9d44445d,=0D=0A=
  confirm_switch =3D 0x0,=0D=0A=
  force_atomic =3D true,=0D=0A=
  rcu =3D {=0D=0A=
    next =3D 0x0,=0D=0A=
    func =3D 0x0=0D=0A=
  }=0D=0A=
}=0D=0A=
=0D=0A=
atomic_t count is 5.=0D=0A=
5 is OK or NG ? I will check it.=0D=0A=
Other block device which ext4 mount on has counter=3D1=0D=0A=
=0D=0A=
Now question is =0D=0A=
   Why blk_register_queue() turn q_usage_counter to percpu mode ?=0D=0A=
=0D=0A=
I think this code has some reason to turn to percpu mode, though blk-core=
.c treat that counter as atomic counter.=0D=0A=
Does it have some problem ?=0D=0A=
=0D=0A=
Best Regards, shuichi ogawa =0D=0A=
=0D=0A=
-----Original Message-----=0D=0A=
From: =1B$B>.@n!!=3D$0l=1B(B <ogawa.syuuichi@nttd-mse.com>=0D=0A=
Sent: Thursday, December 9, 2021 1:50 PM=0D=0A=
To: linux-kernel@vger.kernel.org=0D=0A=
Cc: =1B$B>.@n!!=3D$0l=1B(B <ogawa.syuuichi@nttd-mse.com>; =1B$B;3K\!!C#;K=
=1B(B <yamamoto.tatsushi@nttd-mse.com>; Natsume, Wataru (ADITJ/SWG) <wnat=
sume@jp.adit-jv.com>=0D=0A=
Subject: invalid counter value in request_queue=0D=0A=
=0D=0A=
Hi, all=0D=0A=
I have first time to post mail, so if you have some matter, please let me=
 know.=0D=0A=
I'm studying Linux kernel, referencing kdump, to clarify system performan=
ce problem.=0D=0A=
Now I found strange value in request_queue->q_usage_counter.percpu_count_=
ptr=0D=0A=
=0D=0A=
Kernel version: 4.9.52, I checked 5.10.80 briefly, and looked similar.=0D=
=0A=
=0D=0A=
super_block 0xffff9a563820e430 "vdb"=0D=0A=
 q=3D(struct request_queue *) 0xffff9a563b948920,q->q_usage_counter.percp=
u_count_ptr=3D(unsigned long *) 0x39dbc000b2b8=0D=0A=
 0:0xffffd431ffc0b2b8,0xffffffffffffdaf1,-9487=0D=0A=
 1:0xffffd431ffc8b2b8,0x0,0=0D=0A=
 2:0xffffd431ffd0b2b8,0x2510,9488=0D=0A=
=0D=0A=
This is output of gdb script in crash commadn. Format is <cpu>:<address>,=
<value in HEX>, <value in signed long DEC>=0D=0A=
=0D=0A=
Values of percpu_counter_ptr, big value or negative value on cpu0, and po=
sitive value on cpu2.=0D=0A=
If sum up all cpus, total=3D1, it means 1 request remain in /dev/vdb at t=
hat kdump.=0D=0A=
=0D=0A=
Easy to estimate, count up cpu and count down cpu are different.=0D=0A=
I think the q_usage_counter doesn't work as reference counter to guard in=
valid disposing request queue, however I don't found to use this counter.=
=0D=0A=
=0D=0A=
System looks no problem. However I wonder that causes any troubles like i=
nvalid disposing resource.=0D=0A=
I ask you that this is really no problem at all.=0D=0A=
=0D=0A=
---=0D=0A=
=0D=0A=
As we know, this counter is reference counter of request queue access, Fo=
r example generic_make_request=0D=0A=
   blk_queue_enter(q, false) -> percpu_ref_tryget_live(&q->q_usage_counte=
r) : count up=0D=0A=
   blk_queue_exit(q) -> percpu_ref_put(&q->q_usage_counter) : count down=0D=
=0A=
=0D=0A=
If count up on cpu2, and count down on cpu0, this counter becomes invalid=
.=0D=0A=
I found 2 cases:=0D=0A=
=0D=0A=
case-1: normal case of counting actual requested I/O=0D=0A=
=0D=0A=
blk_mq_map_request() request bio to block device, then count up in blk_qu=
eue_enter_live(q)=0D=0A=
blk_mq_end_request() called at terminating I/O at IRQ context, then count=
 down in=0D=0A=
  blk_mq_free_request() -> blk_queue_exit(q)=0D=0A=
=0D=0A=
IRQ context is normally run on cpu0 in my system. so If AP requests FILE-=
I/O on cpu2, this problem is reproduced.=0D=0A=
=0D=0A=
case-2: preemption=0D=0A=
=0D=0A=
generic_make_request is not preempt disabled, then cpu may changes betwee=
n blk_queue_enter and blk_queue_exit.=0D=0A=
=0D=0A=
Now I think q_usage_counter should consist of simple atomic_t or kref_t i=
nstead of percpu_ref.=0D=0A=
System looks no problem as of now, I've not yet make any patches to corre=
ct it.=0D=0A=
If I have a chance to make the patch, I will post again.=0D=0A=
=0D=0A=
Best Regards, shuichi ogawa, NTT-Data MSE corporation=0D=0A=
