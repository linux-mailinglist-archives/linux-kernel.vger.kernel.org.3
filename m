Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 418664EED5A
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Apr 2022 14:41:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345930AbiDAMnR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Apr 2022 08:43:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243987AbiDAMnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Apr 2022 08:43:15 -0400
Received: from mx0b-00128a01.pphosted.com (mx0b-00128a01.pphosted.com [148.163.139.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EB571C60D7;
        Fri,  1 Apr 2022 05:41:24 -0700 (PDT)
Received: from pps.filterd (m0167091.ppops.net [127.0.0.1])
        by mx0b-00128a01.pphosted.com (8.16.1.2/8.16.1.2) with ESMTP id 231ATAPY027731;
        Fri, 1 Apr 2022 08:41:02 -0400
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2172.outbound.protection.outlook.com [104.47.59.172])
        by mx0b-00128a01.pphosted.com (PPS) with ESMTPS id 3f5vb2swq1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 01 Apr 2022 08:41:02 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=WoFIeJAbnm3lyLEgQaptUvK4eQOmG9E7QqIT4YCIMql4Nm7zGGcXGTUP7rq7pEjw40fQlzBUXANXl5LrN6WoEJETd7gRoSRJCnfVCuvzmqhpMVVyQnf3njCduo+uk04ZlKtmm9mNlDDXKOFyO/kFQ5dh31oel1mM0v4ECPv1rggMEbLhd1jIsZR4BMie6c5/AhdeJ/3X3ntX3Q84JhhFO9K5f6FoXKLMRYLYOAim6ogvJGgMk97LALJhWtK6DHGouGOmpN9UznLegez6hl35gzTrlW4I0/1jhUVa5jaxTP28Kguoo3lRa02jCNWvC/ImeMpDaXIjb6ipN4AHVPIqXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=BH9RTusepljEf5dHcZ9hy9GT8MStLD0gjKP8e5l1KnQ=;
 b=VorctsOQ27N3K0ncvKDQ2PySBAuQVwCSt0Zk1D6EekVT7V11g1Na9V+joIbP6/dpnoFYe6G/CM67zy0wzGj4Rl4Mmx3il1RpN93a0HDsqJPGe1if67td/BAsHSNvI2f4SFjyFzIw9abdDxfCcKs+joZfZ9vSTGmrqZwpASgekdf/upoAkQEqGWMQXOLhfcU307F7X/nsa1WmH2nJjs/sDjljt25qs5WQpzGxbCsy1UeaIHR5HQksNpuWBTRON0z2kePdsa5fBpsLzm05QRpSP0gl/1rytCiAQZm0+gcRrFk/BE5WEfO8B/rGskJK19+sDFYFWqJiVuBAOwuRzcmtrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=analog.com; dmarc=pass action=none header.from=analog.com;
 dkim=pass header.d=analog.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=analog.onmicrosoft.com; s=selector2-analog-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BH9RTusepljEf5dHcZ9hy9GT8MStLD0gjKP8e5l1KnQ=;
 b=ZVu7g1CP1s37ygTXdyZbrEJDMTL6DcCFKZF2Vf6RAxYua0ZLo6dn4znS8TJo9a77tViOLo04IFkjINQgQug4rY0mE6+bCXnv46BVcgU4yz0PGtxSfVvf1txaDoCtrivHY7OJbDVIwB/qDoHyXf5QQ1rCPBL+cU2vqDN1kmSlBmc=
Received: from PH0PR03MB6786.namprd03.prod.outlook.com (2603:10b6:510:122::7)
 by MW5PR03MB6960.namprd03.prod.outlook.com (2603:10b6:303:1ab::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.19; Fri, 1 Apr
 2022 12:41:00 +0000
Received: from PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae]) by PH0PR03MB6786.namprd03.prod.outlook.com
 ([fe80::a97e:a520:c3a6:d2ae%7]) with mapi id 15.20.5123.026; Fri, 1 Apr 2022
 12:40:59 +0000
From:   "Sa, Nuno" <Nuno.Sa@analog.com>
To:     Jakob Koschel <jakobkoschel@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>
CC:     Lars-Peter Clausen <lars@metafoo.de>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        "Bos, H.J." <h.j.bos@vu.nl>
Subject: RE: [PATCH 1/3] iio: buffer: remove usage of list iterator variable
 for list_for_each_entry_continue_reverse()
Thread-Topic: [PATCH 1/3] iio: buffer: remove usage of list iterator variable
 for list_for_each_entry_continue_reverse()
Thread-Index: AQHYRVQV9kI4j3Bv9UurRvFtBWTQEaza/lWw
Date:   Fri, 1 Apr 2022 12:40:59 +0000
Message-ID: <PH0PR03MB6786326401D38B60141CAC9799E09@PH0PR03MB6786.namprd03.prod.outlook.com>
References: <20220331230632.957634-1-jakobkoschel@gmail.com>
In-Reply-To: <20220331230632.957634-1-jakobkoschel@gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-dg-ref: =?iso-8859-1?Q?PG1ldGE+PGF0IG5tPSJib2R5LnR4dCIgcD0iYzpcdXNlcnNcbnNhXGFwcG?=
 =?iso-8859-1?Q?RhdGFccm9hbWluZ1wwOWQ4NDliNi0zMmQzLTRhNDAtODVlZS02Yjg0YmEy?=
 =?iso-8859-1?Q?OWUzNWJcbXNnc1xtc2ctZjlmYjgwMzgtYjFiOC0xMWVjLThiZDUtZmM3Nz?=
 =?iso-8859-1?Q?c0MjFmY2FlXGFtZS10ZXN0XGY5ZmI4MDM5LWIxYjgtMTFlYy04YmQ1LWZj?=
 =?iso-8859-1?Q?Nzc3NDIxZmNhZWJvZHkudHh0IiBzej0iMzMwMiIgdD0iMTMyOTMyOTA0NT?=
 =?iso-8859-1?Q?gyNDM5ODg4IiBoPSJkMXBSekZkUG1GTjR2K3QyNjBkOHlsZTQvRE09IiBp?=
 =?iso-8859-1?Q?ZD0iIiBibD0iMCIgYm89IjEiIGNpPSJjQUFBQUVSSFUxUlNSVUZOQ2dVQU?=
 =?iso-8859-1?Q?FFb0NBQURRNDVpOHhVWFlBU01XeSt3MTd2ZmFJeGJMN0RYdTk5b0RBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBSEFBQUFEYUFRQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBRUFBUUFCQUFBQVZJRXZvUUFBQUFBQUFBQUFBQUFBQUo0?=
 =?iso-8859-1?Q?QUFBQmhBR1FBYVFCZkFITUFaUUJqQUhVQWNnQmxBRjhBY0FCeUFHOEFhZ0?=
 =?iso-8859-1?Q?JsQUdNQWRBQnpBRjhBWmdCaEFHd0Fjd0JsQUY4QVpnQnZBSE1BYVFCMEFH?=
 =?iso-8859-1?Q?a0FkZ0JsQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFFQUFBQUFBQUFBQWdBQUFBQUFuZ0FBQUdFQV?=
 =?iso-8859-1?Q?pBQnBBRjhBY3dCbEFHTUFkUUJ5QUdVQVh3QndBSElBYndCcUFHVUFZd0Iw?=
 =?iso-8859-1?Q?QUhNQVh3QjBBR2tBWlFCeUFERUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBUUFBQUFBQUFBQUNBQUFBQUFDZUFBQUFZUUJrQUdrQVh3?=
 =?iso-8859-1?Q?QnpBR1VBWXdCMUFISUFaUUJmQUhBQWNnQnZBR29BWlFCakFIUUFjd0JmQU?=
 =?iso-8859-1?Q?hRQWFRQmxBSElBTWdBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQU?=
 =?iso-8859-1?Q?FBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFBQUFB?=
 =?iso-8859-1?Q?QUFBQkFBQUFBQUFBQUFJQUFBQUFBQT09Ii8+PC9tZXRhPg=3D=3D?=
x-dg-rorf: true
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 82714def-b8be-4159-7b98-08da13dcdffd
x-ms-traffictypediagnostic: MW5PR03MB6960:EE_
x-microsoft-antispam-prvs: <MW5PR03MB696071A71F14812C8ACE0D9899E09@MW5PR03MB6960.namprd03.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: g/URb1cqhbJAd51cOqsuUYdkkzdvG3U1LhbgDApdPW8DOEtx4hgzNIcWkV7tgY4qtzyJwNaZbTCdWQmHmQ92AuYZFvQells2Wm5JMFlzWGkul6BajDWPFpKElJTIT1gA2EtXjRHlnKStHXRPRXcjlEfp8Cch3tslNVKmCQgs4pICwDp/QVX8fMQclIv1BeswgLCqg668HBlo8SYx5baKxhjjpj5uPFSpbk6NU0c1Bg1+y2THnJPaLclN7MLDNzpOmFu8qdv93kJxNjSvTmjmGe04oFPIrTpwE+LQ1iz8XGhUJNcIe2rEkqebB8gigC8D9nXYWApPppFKNOwo92+kruPu1NoNR0VREX+nKU4da6ce6xsPCKyAn/birADrx5ybjqjGMRcceNZawc/iF4N/ZslDy1l3hQpg4mmlY2KONupQ86Bw1iPTR/8vA6ljXbyOWK6JEhu4n7UcnnxnIWRcKkcdoa6xxGFMtWNtxvgsFwQQ0KcY0O2HunlxFKq++jaR8eCBQlRKLu9gc2eQito5XUVs9MzDH1JCQdXohPObW35Z7Z8ob7gYqzMkIXz4zKcedGmLz/JG0QvNkk/IKCKLILUBc2K6llWiA3rTFAKlBwjDOs4h1NiMKUMS4gGTJwAZHEr2NJh54W2kfib/8gYOy/IOE/zePbXl5YDfmN5graKJvUKO9sRKGaNZBw7+CUx+HCCeTsXs92mqQJhp8/OEdqJTHYZ9mV4g0QdTm3lljGe6Q/SK0NWEpTQL0P1/rlVrViOpJWTKAQY79fO/cw82HvmHZZbTPUt9dMOhReEqu8A=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:PH0PR03MB6786.namprd03.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(508600001)(8936002)(86362001)(186003)(966005)(83380400001)(316002)(54906003)(110136005)(7416002)(2906002)(52536014)(8676002)(9686003)(64756008)(4326008)(33656002)(66446008)(38100700002)(76116006)(66946007)(66476007)(122000001)(53546011)(38070700005)(7696005)(55016003)(6506007)(71200400001)(66556008);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?iso-8859-1?Q?EdPnRW06KdR+SF1fK3ke/z/5GLoYSIj6xQo0VoGtb21pbdwtTZkM0l1nVO?=
 =?iso-8859-1?Q?XrNMg1mivbRHfQtCZkXjiJvCM8DMfUyCOWA1r0Yvulc7meykNcQpEjmeac?=
 =?iso-8859-1?Q?5r1LtCpAd1b9Em5WgUU58te4Bfat4WUPSfbuIGKuDiIi4oA73Ddu2eQkpU?=
 =?iso-8859-1?Q?tpRe/NroVIpGjDFC0B4LIoSXN1Yt24B88KA5sY6m6dnno9WVM1NJlNZHym?=
 =?iso-8859-1?Q?Fiy9S5PsJrG9Q2lsL6ZWnc96vxQNxzPP+UQKGxNDOA2xuOHiv3/pJDxfjP?=
 =?iso-8859-1?Q?X3uFxb9cs83GF7nsljZ4WFCKaRLctrU5wOO8WuxkLj48LTxfyBTBwu0R/P?=
 =?iso-8859-1?Q?/BpFB0QgI/0N+dQAyZC2fPHw3I5t9hrtZOyo243vmaahoX89iDP37kPcHF?=
 =?iso-8859-1?Q?2VF7ZK/9W0L+T/D6p5WL6cv4XvzfRMqnDoSXdd/qGoRIBCdIGheoaLjOpb?=
 =?iso-8859-1?Q?lJUsWnOOo6mVxCio6vtp6Ap1Q27t7zbNZs+a2S6upp6W2ZqZzfpgihY2so?=
 =?iso-8859-1?Q?sdb8+oAGeCo7edGUCmsuf8wMpwzks7onDt/QGr/wwhPev5W+jL7BI7AeZU?=
 =?iso-8859-1?Q?2g1VDiWo8EKGpV/9Uu5mCnIYjlKxA1xX3gMNSFe0q20c1WKs72jnKzUqTw?=
 =?iso-8859-1?Q?dl+T7DYCEgovy38au+V+q83If7qJA0EQsz6M4lH+cf0wZWb0rU4TSu9xq/?=
 =?iso-8859-1?Q?YBLQIr55aKjqNdK8F9kPw2ldDMiaJjlTyVjTPc10+t7hcweA5ZeyWTmvH1?=
 =?iso-8859-1?Q?/Mhq91ylCu9JzpbSQ9OhyiGeuM2yU183pmXDJbltq4uzSa+b/YB+KwS7rh?=
 =?iso-8859-1?Q?wFtK3VllezQTLTmDvwRpQ6FRCQOTURw0pshTipglFo0OW1U9oyap553Yh7?=
 =?iso-8859-1?Q?dMyYM/U26h5PgTRBQGVDDczmQIa7IFm5IveGyBVzp0H11x47zVTNia9ph+?=
 =?iso-8859-1?Q?XPUWF1/+udvSvW8ix4ALPHzXmO3XwVO4N/Tg27Mjt2S/BIu+J7yk2XjrOb?=
 =?iso-8859-1?Q?m3dNvJWFkdXs8Q6ep0GHFNFvAqpi5b9N8YeSfrSpqP519XdaQ+fYYhPXij?=
 =?iso-8859-1?Q?CdNbr2WOAuA9MXCSgDkpfBU1dfu2BbOZL5I7b7b2amB5O6fp0/28PjX9CH?=
 =?iso-8859-1?Q?fWNuqJJzv65/TZl/nFuLNnG9R1h4Um2k6lkM8ryNKxbdYUg7vJMtrpBPUR?=
 =?iso-8859-1?Q?ekPo8ribkjImuFGMb4GTcuP9MEUGJtDLk69jo+H+HI0E3ZoAMXowwAMkT8?=
 =?iso-8859-1?Q?Bhj10DpDWzsK5jTmMbi3pbc9XLjiyrPyyJENdXJin2dRKnaWSnWD+X0xTd?=
 =?iso-8859-1?Q?iVDbl10msIGb/FwIDjv4OVUhHPB7CN6bfV7JUjCEmm+el67Y8iWu868+9u?=
 =?iso-8859-1?Q?c+ZK9noAU2JSnywOoN//pgf+UnxB9/tQVq6KtZNH0grNyQoohfjEtESXPa?=
 =?iso-8859-1?Q?rEnZnWCZ8/cKdpcjNrqkXP7BPCIIoMscarNMxlLUyp5VIISBwQAVpqhyQZ?=
 =?iso-8859-1?Q?nskwhxCloJqsyBs2mzi6I67esEZXWQvRxs6uUguVCyoZjCtvnpOjZPQFpW?=
 =?iso-8859-1?Q?6nb5+/xsKhqB/8w+m3b2THDeY1I3fa/ZC0E2k24yykIn4apcRERvPKl91T?=
 =?iso-8859-1?Q?dUx0jgoxXR0uIJSSn+CIrhuA6aeBt5QZ0udv4JPqiE0WdG60Zu+AkKhrX2?=
 =?iso-8859-1?Q?nCZZXU1zReoFYIVdzebsr7+NQccpGZcMyg+JRhr9fDUczWnHzKNNHWQhG2?=
 =?iso-8859-1?Q?rEtZFCSHKi4dGAWK2iuGXc5BVY9eyl4iIOX6gnzzCtC8NoiIDzKHgfvPrv?=
 =?iso-8859-1?Q?XSb7ovqrZpWQIb8paBh9YJS/+h1umXp3Q0uH+FedAmQpfgJqbeNcopZqN/?=
 =?iso-8859-1?Q?WJ?=
x-ms-exchange-antispam-messagedata-1: GAzh1qj2+ZQxrA==
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: analog.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: PH0PR03MB6786.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82714def-b8be-4159-7b98-08da13dcdffd
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Apr 2022 12:40:59.6591
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: eaa689b4-8f87-40e0-9c6f-7228de4d754a
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: s+48gm54PrQRR/DH9Ac9+FCe0ruh7nDHG9SSZT+MS83+g9jfplCPgqaneOE17wrkFrPsZ1iIucDwKZZwYHxocg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW5PR03MB6960
X-Proofpoint-GUID: GStpuhScQVxBwzzzzDkJsktWEakTUCcc
X-Proofpoint-ORIG-GUID: GStpuhScQVxBwzzzzDkJsktWEakTUCcc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.850,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-04-01_04,2022-03-31_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1011
 bulkscore=0 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0
 malwarescore=0 adultscore=0 priorityscore=1501 mlxlogscore=999
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2204010058
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jakob,

> -----Original Message-----
> From: Jakob Koschel <jakobkoschel@gmail.com>
> Sent: Friday, April 1, 2022 1:07 AM
> To: Jonathan Cameron <jic23@kernel.org>
> Cc: Lars-Peter Clausen <lars@metafoo.de>; Dan Carpenter
> <dan.carpenter@oracle.com>; Jakob Koschel
> <jakobkoschel@gmail.com>; linux-iio@vger.kernel.org; linux-
> kernel@vger.kernel.org; Mike Rapoport <rppt@kernel.org>; Brian
> Johannesmeyer <bjohannesmeyer@gmail.com>; Cristiano Giuffrida
> <c.giuffrida@vu.nl>; Bos, H.J. <h.j.bos@vu.nl>
> Subject: [PATCH 1/3] iio: buffer: remove usage of list iterator variable
> for list_for_each_entry_continue_reverse()
>=20
> [External]
>=20
> In preparation to limit the scope of the list iterator variable to the
> list traversal loop, use a dedicated pointer to iterate through the
> list [1].
>=20
> Since that variable should not be used past the loop iteration, a
> separate variable is used to 'remember the current location within the
> loop'.
>=20
> To either continue iterating from that position or start a new
> iteration (if the previous iteration was complete) list_prepare_entry()
> is used.
>=20
> Link: https://urldefense.com/v3/__https://lore.kernel.org/all/CAHk-
> =3DwgRr_D8CB-D9Kg-
> c=3DEHreAsk5SqXPwr9Y7k9sA6cWXJ6w@mail.gmail.com/__;!!A3Ni8CS0y
> 2Y!q8llw5UCaMIsAU7tPtPDhwVor0wy032I7FJHv0VxBZksNuRJF04HjWe
> 0XYG7OQ$  [1]
> Signed-off-by: Jakob Koschel <jakobkoschel@gmail.com>
> ---
>  drivers/iio/industrialio-buffer.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio=
-
> buffer.c
> index 208b5193c621..151a77c2affd 100644
> --- a/drivers/iio/industrialio-buffer.c
> +++ b/drivers/iio/industrialio-buffer.c
> @@ -1059,7 +1059,7 @@ static int iio_enable_buffers(struct iio_dev
> *indio_dev,
>  	struct iio_device_config *config)
>  {
>  	struct iio_dev_opaque *iio_dev_opaque =3D
> to_iio_dev_opaque(indio_dev);
> -	struct iio_buffer *buffer;
> +	struct iio_buffer *buffer, *tmp =3D NULL;
>  	int ret;
>=20
>  	indio_dev->active_scan_mask =3D config->scan_mask;
> @@ -1097,8 +1097,10 @@ static int iio_enable_buffers(struct iio_dev
> *indio_dev,
>=20
>  	list_for_each_entry(buffer, &iio_dev_opaque->buffer_list,
> buffer_list) {
>  		ret =3D iio_buffer_enable(buffer, indio_dev);
> -		if (ret)
> +		if (ret) {
> +			tmp =3D buffer;
>  			goto err_disable_buffers;
> +		}
>  	}
>=20
>  	if (indio_dev->currentmode =3D=3D INDIO_BUFFER_TRIGGERED) {
> @@ -1125,6 +1127,7 @@ static int iio_enable_buffers(struct iio_dev
> *indio_dev,
>  					     indio_dev->pollfunc);
>  	}
>  err_disable_buffers:
> +	buffer =3D list_prepare_entry(tmp, &iio_dev_opaque-
> >buffer_list, buffer_list);

Ok, it's Friday so I might be seeing ghosts... But looking at 'list_prepare=
_entry()'...
If tmp !=3D NULL, then all goes well but if tmp =3D=3D NULL, then we get

list_entry(&iio_dev_opaque->buffer_list, struct iio_buffer, buffer_list) wh=
ich
would require 'struct iio_dev_opaque'. It looks like like 'list_prepare_ent=
ry()'
assumes that pos and head are of the same type...=20

Am I missing something?

- Nuno S=E1
