Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8F3C470FDC
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 02:29:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345551AbhLKBcm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 20:32:42 -0500
Received: from mail-cusazlp17010007.outbound.protection.outlook.com ([40.93.13.7]:24353
        "EHLO na01-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229633AbhLKBcl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 20:32:41 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hO3LE+m3PF1kKWKQFy6OrC92Ydvrzp4gsilgu4bMpfHNXCLteNkRlM3H2MFXL+GzPtB8OyfzXW7yBMeMBMSAEy8P47WhfeS24CmGru4k7X1gnQufnKiw/zmASUI9Jmk+IX+5GfFFHEfM11hBuAB/QP5zDcB2V9WztZBs00MV+zQ7pFMzs4Qa7ECFbHT6z02zzQHHQB6dEhhytZ+yKYCfyAAGRgw5yDNcnmQHtwcqt5/2WN4jFs+ivEaIReSnI+fi4ZGU9BQQDCbvuPw+tR6BtT3VXbxQF2XZeIRCTfRN6BxVBRN2klcDSqvjiWdsEX1vSdj7PDEkSr0tsNfHqMj1vg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9IosKne+5NFsQZn/Elmww+LxlN5ihHNz5GgVjcuG5r0=;
 b=XcecCCMqyv9omn7lYPe0MqbS7prIiX5pZw7chYBT934JJzAztxGrkkaRR+nEI5+Pye0I4HMsBXXe6VBSBj8hXzZWDL6kZijnSZYtd7S8OVTXOjqn744pIMMUUOuoMiN8a9oAAT0ezhNidJ0JLKK/DPfLtbEGbcLvwAdPX47w0EVKrRicUSOGjZFIIVw+HqkyD0ydsz+uXLFCA/DK3+/J2ZNzvkNg0VEQlQM97YmI19wkiX57CwR6bAEVvzg/6NPytg/BcVPMebGIUg5GyE2oIA6O3YLhusH3sPOFzZKCEWnyttr21ypX+9yLLYOZVdrNpou+5sa2mHduPsg/L2Jgrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9IosKne+5NFsQZn/Elmww+LxlN5ihHNz5GgVjcuG5r0=;
 b=AmivFssohlHTUA3MYh6slqeJbMv/OHoYplm2iSKGFjaaSv94gOi9WKA/RopKvVGGHlOw2JRCrmuLWPVIKFmHPVGfPca/UujsyRPzXdDrgFBkh4oSuHKL+gUkYUmo/Ecwxb76bd/Gw6jKR7XMbPKWfsY+b+KxFcHT7bkvRgUO83o=
Received: from BYAPR21MB1270.namprd21.prod.outlook.com (2603:10b6:a03:105::15)
 by BYAPR21MB1608.namprd21.prod.outlook.com (2603:10b6:a02:c8::25) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.10; Sat, 11 Dec
 2021 01:29:02 +0000
Received: from BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83]) by BYAPR21MB1270.namprd21.prod.outlook.com
 ([fe80::9904:180b:e610:fd83%4]) with mapi id 15.20.4755.004; Sat, 11 Dec 2021
 01:29:02 +0000
From:   Dexuan Cui <decui@microsoft.com>
To:     Jens Axboe <axboe@kernel.dk>,
        "'ming.lei@redhat.com'" <ming.lei@redhat.com>,
        'Christoph Hellwig' <hch@lst.de>,
        "'linux-block@vger.kernel.org'" <linux-block@vger.kernel.org>
CC:     Long Li <longli@microsoft.com>,
        "Michael Kelley (LINUX)" <mikelley@microsoft.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Random high CPU utilization in blk-mq with the none scheduler
Thread-Topic: Random high CPU utilization in blk-mq with the none scheduler
Thread-Index: AdftWjJCThl7/4e5TledNcioslhEuwA0I/TA
Date:   Sat, 11 Dec 2021 01:29:02 +0000
Message-ID: <BYAPR21MB1270DCE17A0FE017AF3272F1BF729@BYAPR21MB1270.namprd21.prod.outlook.com>
References: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
In-Reply-To: <BYAPR21MB1270C598ED214C0490F47400BF719@BYAPR21MB1270.namprd21.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=e2a80eee-9657-461a-8970-0fd3dfc0ce87;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-12-10T00:06:26Z;MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
authentication-results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=microsoft.com;
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 99db189e-d3f7-404f-a448-08d9bc459d43
x-ms-traffictypediagnostic: BYAPR21MB1608:EE_
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <BYAPR21MB1608BC48A912848F5F3B2AA9BF729@BYAPR21MB1608.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3631;
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: sJDMcS30Z/hI2yVdseTxyDlgw5rQ2iwfJupkFEEIUCLUz5efnB7T/Hw+zjthXOTIfaKyEb39hDalOIz17jW4qJM+hFDpqpOzeShxmiBsPUN1tPdnR7tXr23PYjiq6488vVdlWZv7U/58hLaqHhMscqUleLAMzjQBzob+pSeyD7RLid21t2uNBG97wlFnXFpCvt06Hd34RcT4rjbvzADuNmq5MjNLW5GWzYPHzDqE4kAa2dyMEVlOYN6tpiErFY+Fh6nA4bPx4IBgfJiIIKzIwUy9sOk9tU/Tqm+xRzvjEyBFemFGa9gUuAeHdl9y0Mb5cxds4oDqVt5vVVPxYUAD5LgQmfqO31Dtgpg68d2LVerJuQntH3u6wUZBKC+J7c/8iVGXWuomRJMgCMy54biV1FoFM1DJnZudD6IupVTS6qYVEwyUZmBTLni294GdH5++mTK3ezyLfUD9gxcKS0Mt2fHOmA+acXII9XA+8hOkqr65OY27rywP99NXOwFp2RPbgyYA3ZTLn5KnXUwobfQqOB7RCR3ijCy/frnisggBlYq+7EYU/4PauHbkazflvZysn+n1Fb/72wv12P8/exygAEe7epphnbpgGQ8KNWZ8FTXvb+NwUCcW3EankXO/EoJkzV5sVrS0mOQE5xhJEf7PISqIU+xLlLP6Eg/kJwL0g+f/4oWifci8zxV+oNR5gm8wOx/iX4SnAlGaY/7v+KF6vRaFrSyG79mp6k0NxP9VLQw+EJqHlhNCc9BvpM7N3+BzEhztV1fU3h+haYesfmrsXHXPv7FX9MnyHXLow76cLxPqmgMBUhOdqwGldYWg7+cAicLcJn2cazkFKpif9P9YFL+PPQ9VRynqMZiBaIsfoOw=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR21MB1270.namprd21.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(966005)(122000001)(82950400001)(82960400001)(66946007)(5660300002)(52536014)(33656002)(71200400001)(86362001)(55016003)(6506007)(38100700002)(4744005)(2906002)(508600001)(8990500004)(9686003)(8936002)(7696005)(4326008)(10290500003)(66556008)(8676002)(38070700005)(66476007)(64756008)(66446008)(186003)(83380400001)(54906003)(110136005)(26005)(316002)(76116006)(491001)(20210929001);DIR:OUT;SFP:1102;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?8Nl7vbR/TvJz9WRd4Z91tIcrkdNjOjpMK41ICzfBp9xEDgqp7StS5OY9uuD3?=
 =?us-ascii?Q?53blc0Fr84EpuuzGGQ0mUzcq/nRpbjuHpMDDyxCczKrHwxd6zcH/MtHMfQJx?=
 =?us-ascii?Q?dkhF5oywlFSxw3S3x5k9kKUO50+A5iNBrGzrMHLT8UA5fGFEo2J6vt2WoFTw?=
 =?us-ascii?Q?97A1G46gKsBbw6AKBVO8RG7p5NMfP6FCDCD0Cbzj/MonlTuFmUAyUwJfkbsg?=
 =?us-ascii?Q?NfH8fZITkXQbkgApnLZNAVTu7hscAWyF82+pewK1XhQmVXamIHTRODOejrxP?=
 =?us-ascii?Q?txVZGArXU7/5VsYU0jxQ9EJ/d2uvgr9hj5u3otcQYB4j051cXdy7oYPYMQcE?=
 =?us-ascii?Q?3hOOyIX9XV43nBpUAtcN1Hl31AMghk7XmhjhLA2eHilFbFgV0Q9CpQzfMX/n?=
 =?us-ascii?Q?GPP55/LBSI8vJZLsrrVWOTf7GMIhctJMHlwuXMjVyrDlE4ArhXIGf25TlpwW?=
 =?us-ascii?Q?t7Dd7s9JQ43oIoSnpjQqgIatqiu7nGVqO9yJXr3h65wttANfZhQ1DLcYhC51?=
 =?us-ascii?Q?Z8VCdgVY/nFr6s5gdjp+ZRvMyedEX9SWBhgfn+xuCfkCyjqVvOAa5zxR18qQ?=
 =?us-ascii?Q?yNrm9L3FA2A2lD5d67hxe5YV9KY9fpi6pmpdIl7CYiNbG8dcLX8D1cGtXgj9?=
 =?us-ascii?Q?VrgXXrgG5kOYQ7OiM20SKwGNItk/ve3D1gGrw4D/AM+4sghYTATsOJEJUBjT?=
 =?us-ascii?Q?rnA9KDZ3liXn1Rd+l5Wgz3wWm/6Mhz0vZ/iCYcpSkypZIiuvRYWzhS40+Jl6?=
 =?us-ascii?Q?ivhWX9k+JdIdOrwFuyv8BiLns0xCn2CBObC+wEWWoBOvKdUEGEGUZK1FGbN8?=
 =?us-ascii?Q?Y6Yg+BgitC3/g5iDXpbAH2kC8avG/bGL6JV+D8tVfbmHlGj8FmkWvsOr8cfn?=
 =?us-ascii?Q?D+RhtIW9G3Rg4Fg1Eiufkg0UFwcUFqyMUToBpOYtxSYq/MdGVJNa5J1K9FwN?=
 =?us-ascii?Q?2hb9wAyS6ee+lyMvmoxGRx+/o0kdCnJzv2jgfMECYXMKux3xa9zFZWYbaQ3n?=
 =?us-ascii?Q?beGW9EVWEuzJLiJEAeUIDhRvPDRMoqlLHFAh6fCNRyO/vuYmA4UqMaBieD7m?=
 =?us-ascii?Q?yQWRoHTA3ESU8jcWFXaogEdQJ/cFjRmJnOZP40qByr9b7UyD1k4Ioir72JzP?=
 =?us-ascii?Q?oOlHcPRts5CTzECfNH2SRbjG+1Wm2wrmSSz7Kh0lfzaN8RuuJ7oddZT2o67n?=
 =?us-ascii?Q?29GfoPfLlm+1C3Ogq7OOu5FAVnBdH4Y6qeKUY6awH+BridPacjP5w/eD+gmZ?=
 =?us-ascii?Q?OmLXjz/sHrZ9CkXvX0ZOHZCPjzNvkP0yqglbuKEk6Yf3a/scLfTXoCrJmbhV?=
 =?us-ascii?Q?3PYpwQSeWzqAaR0JPcgbMHbHyVZHA550Tj4EDw98Sm+++k3HIZtbV3kns2/B?=
 =?us-ascii?Q?WCBVK8dfF0pHR8xfnGJn/WvIpeXjkMExnk5sIa5g4YD7a0B96eEX4sxE6hvu?=
 =?us-ascii?Q?1H+D06QXRGzb1skmsu+9eagU3ZRsn6/BdKSXD4MD83IHq+zq4z6sfJX7hioM?=
 =?us-ascii?Q?bID6JnGdpWbB3Hdy6coy7/XbCM6HxHMesU1oAIsrNVsfHNhNNButW8LwbtID?=
 =?us-ascii?Q?hG2a+skW0R0S3NOIxyGWzi2vIN4uW0Cc5gGQkovgI9XWS8/Weijl2bNdryrB?=
 =?us-ascii?Q?SfEPQiVbG96MxWI3TNAm4FU=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BYAPR21MB1270.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 99db189e-d3f7-404f-a448-08d9bc459d43
X-MS-Exchange-CrossTenant-originalarrivaltime: 11 Dec 2021 01:29:02.5145
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: MusrcILF0Qu8KAREfqEgrGT0RYsADr8VHC7LPYXm/Js+jKIPHnpnO6dqn912lRqwT4WHWWOQDMT/InzwYrPWJw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR21MB1608
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> From: Dexuan Cui
> Sent: Thursday, December 9, 2021 7:30 PM
>=20
> Hi all,
> I found a random high CPU utilization issue with some database benchmark
> program running on a 192-CPU virtual machine (VM). Originally the issue
> was found with RHEL 8.4 and Ubuntu 20.04, and further tests show that the
> issue also reproduces with the latest upstream stable kernel v5.15.7, but
> *not* with v5.16-rc1. It looks like someone resolved the issue in v5.16-r=
c1
> recently?

I did git-bisect on the linux-block tree's for-5.16/block branch and this p=
atch
resolves the random high CPU utilization issue (I'm not sure how):
	dc5fc361d891 ("block: attempt direct issue of plug list")
	https://git.kernel.org/pub/scm/linux/kernel/git/axboe/linux-block.git/comm=
it/?h=3Dfor-5.16/block&id=3Ddc5fc361d891e089dfd9c0a975dc78041036b906

Do you think if it's easy to backport it to earlier versions like 5.10?
It looks like there are a lot of prerequisite patches.

Thanks,
Dexuan
