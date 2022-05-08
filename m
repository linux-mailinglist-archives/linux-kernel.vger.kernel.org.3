Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A7151EAA6
	for <lists+linux-kernel@lfdr.de>; Sun,  8 May 2022 02:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbiEHAFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 20:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbiEHAFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 20:05:38 -0400
Received: from mx0b-0016f401.pphosted.com (mx0a-0016f401.pphosted.com [67.231.148.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9ED06B0D;
        Sat,  7 May 2022 17:01:49 -0700 (PDT)
Received: from pps.filterd (m0045849.ppops.net [127.0.0.1])
        by mx0a-0016f401.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 247NcdoE007131;
        Sat, 7 May 2022 17:01:27 -0700
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fwp4psdrm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 May 2022 17:01:26 -0700
Received: from m0045849.ppops.net (m0045849.ppops.net [127.0.0.1])
        by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 24800rQa024261;
        Sat, 7 May 2022 17:01:26 -0700
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2105.outbound.protection.outlook.com [104.47.70.105])
        by mx0a-0016f401.pphosted.com (PPS) with ESMTPS id 3fwp4psdrf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Sat, 07 May 2022 17:01:26 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L/WztWfsPoicUF4nztYFtK3sesZI2AEny8EoYFMlKlhEDyEwsWU3/HRHmt6trI7kj5Tdh/549+j2TMy76KLr9jA6DSH8ZrNVrU3tr2RCqPzgeR+4pUvhtXfvnPGd6nors0N77jjcyCzrJTc/6OEQCO59AqIOuKH35pBTku3bwTzmDxvhvHOBpbTY90K8tyPuyjMtAYGE+JymJZpVBm87mzLWQyvCsxNPBnzOEiSneXdKwliavbS4sBHmsbd9iKE90FF4Y7C5VQNR5TuJqtKDbmVi19Ll5+iFHVxC4z9zH+tmeFLKRWeOTtlW9BM2U/RX5PJRDIqMsBlrujlImAjzxA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x1l52Q3i5OwKnGwaT7SK89243mEkCvW3nDBqQ3+EHa0=;
 b=JLUfgChNEGvg5Fxel4EWe72h3JfV1eUqUUtlUhUEBVR1xUP/exwXBujtLvUHPbTZplfmJMXehhbK+ILsotAB3hxpUVS+otgDGfoHO9VgFz+Nvai8833jgNuTa1SFHgqsAxhL2LH6QfIq/uGMhI12jyjddgJRbLkoVYxespAVdm8c2mva9IJCK0XEQk1FZ7nb3WLw0D0YcAl9Tc6ODenJed4Iv2xuTLQOV/+qvmCi4ZSBIplHJcL2pNz26l0pczCZf6+UMQ2QPiY/N7syqEKf0qI9xYwIWuw69LstH9Rfcj3y3Uy9NKQEm5lihGrRJB8/jMAPBRnketb90EmTFg4yoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=marvell.com; dmarc=pass action=none header.from=marvell.com;
 dkim=pass header.d=marvell.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector1-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x1l52Q3i5OwKnGwaT7SK89243mEkCvW3nDBqQ3+EHa0=;
 b=MztTg/Gop+rBFEf2TQICUOyKI+FXWNlgUlDHRWh7T1SS+A7vO6maLpwcwG9CK/FnpNu2Wc4004yAjf/wtdesMgu5bhsX8XABvIHvfZBNukczaPSJ8JpT9HE4iLOcvhUcC6lsrDv09Y8RimPWDRfVt0hX/cZSIa9+dW7r7a1K0og=
Received: from CO1PR18MB4538.namprd18.prod.outlook.com (2603:10b6:303:fd::22)
 by BL0PR18MB3746.namprd18.prod.outlook.com (2603:10b6:208:37::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Sun, 8 May
 2022 00:01:22 +0000
Received: from CO1PR18MB4538.namprd18.prod.outlook.com
 ([fe80::94d7:da1d:51a8:ca0b]) by CO1PR18MB4538.namprd18.prod.outlook.com
 ([fe80::94d7:da1d:51a8:ca0b%6]) with mapi id 15.20.5227.022; Sun, 8 May 2022
 00:01:21 +0000
From:   Xiaoming Zhou <xzhou@marvell.com>
To:     "kbusch@kernel.org" <kbusch@kernel.org>
CC:     "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "axboe@kernel.dk" <axboe@kernel.dk>, "hch@lst.de" <hch@lst.de>,
        "martin.petersen@oracle.com" <martin.petersen@oracle.com>,
        "colyli@suse.de" <colyli@suse.de>
Subject: [PATCHv3 06/10]crypto: add rocksoft 64b crc framework
Thread-Topic: [PATCHv3 06/10]crypto: add rocksoft 64b crc framework
Thread-Index: AdhibcBRiq8Mz+RYTlqaQoqjC5ZFDg==
Date:   Sun, 8 May 2022 00:01:21 +0000
Message-ID: <CO1PR18MB4538FAB1C3EC9DC4EF036C8BA8C79@CO1PR18MB4538.namprd18.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 8d17560f-4e75-45a0-09b8-08da3085e290
x-ms-traffictypediagnostic: BL0PR18MB3746:EE_
x-microsoft-antispam-prvs: <BL0PR18MB37468A184C997225424CD692A8C79@BL0PR18MB3746.namprd18.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OtYBD0yG4WvcF34Bk6YBH3SvZIJwUdn6pVc7QjVf4G81wBVC9PccNt0V9dqZz6S5gh/uUBCmhd7PcIq0D4DN8sZ68BOrvuYnp5l2I3qceS+RQ+mFh7U0BbdNSQ5m7Zzaf1cloa8/GBcfs3vHeAvWvbAXHLl1v6ztfVJ2Irgkyfco9lPnqrkZ1eB9wW0vXLZMdvckBBwrI2K8TXVTrubQqz9827H4vAuqefFpWShDv7xq5yOlGMeI2AhnMbdQFgDfatMFHquhAbyJBaFyFXjmr+ZHcHMqK3mv0078dR++BqdJcQK235Atj+s2o6AnsFL1SC/MjA8Ci0n5UDqbyqjHOPIl4NcpXQMStYxE4+5S+GBDqH5xxkWLJocFPSM46FKj4pHLAgHFBGdf3eIsNWX0yN6sJztuVaYOT2Pl9iaL3XrHdNsrD4ZXiVLn1in7zZgTlhoHuo3fESFtvRrI0pTJMW0plsIx81BpGArxEh2nReyN0btWc6JRJnwcTsNYdVNqEl5tav8tR4TSNZE9wCYaN8S4NnwrPhA/L1WSQi1SAlvQzkXjM8F1KRO3nbStnKCqMtmIoD7TRG+gdYnmX/b7JUxQpMcsB8xDvjdR/UyxkYkOuBVewOpOKqkSrtWKfOR3xluyf26C2sq4E45iaKAypTOhWIwvLkfpgsyiH+8G5VsbzM4Q2rNIEQkIVvvq4BLpba/RSOOIHtzc+vIgxE5A5DSg/i57NCvbxJoMShrq70VGCzPZOIBQBb9Vi+ul2gOZH/Ip8WEQjL95HH2qilXTk6MatS9YdnvGOvG4ASPw51M=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO1PR18MB4538.namprd18.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2906002)(508600001)(38100700002)(38070700005)(966005)(5660300002)(186003)(30864003)(55016003)(33656002)(7416002)(83380400001)(66556008)(76116006)(66946007)(66446008)(66476007)(4326008)(316002)(64756008)(52536014)(54906003)(8936002)(6916009)(86362001)(8676002)(7696005)(71200400001)(122000001)(9686003)(53546011)(6506007);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 2
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?9TgADOvTN5UI+mL4szv5+hypwcmRuX08UB3s5KmKhKpNfTy4mlE8CVz/CVTW?=
 =?us-ascii?Q?E3TXunE+/qQNXxXagK4EQCPB7w4Igc16wgQ6F/xMJM9ra0dxVDsL3wUvc0DG?=
 =?us-ascii?Q?Jyrp2Oj6Ow5pNL1VWv2HXnLdXjQe+Z2FjKK8BVuUDIkk7OEEFeNqK1r1Qdjg?=
 =?us-ascii?Q?WG45fAYQaOoyixx5jwYqNrxm5GrV6t3j1Br9YRrEkhgeT32auqbjvJFpV4vA?=
 =?us-ascii?Q?jGVTAAJe4Zc7Y6X9o5gQw/yd35g9+/ycbV80iP8BpwmfLjSW29TCNTiDfOdS?=
 =?us-ascii?Q?AWS1Q8VHFRzrtfFRFev2kKbnyeTyiCX1vLvgg6i8w1g+v574zOuZZbAK0E4K?=
 =?us-ascii?Q?+ZsCAAs7IX8eYyLTovO4mKMMXI/soXsqNEQRPCfki380tnehS7/YkvCtOyJm?=
 =?us-ascii?Q?IWqXj9MKQA8eWMA24oeVjk5CFR7+Nr6Gy62DLqMpKOVyFSrl3bCj3RRi8k2L?=
 =?us-ascii?Q?Q9ZOOUhPKUdfCyfmScxdGpUVyO/mZax12eZSGcujGfX2HZBO2wSOjQmpHmqV?=
 =?us-ascii?Q?1ooLVoP7eQJeJP+8hS5exQ1erJiGgQxO7uOzM9nMDoapPkcfWv6Npn8EnQmb?=
 =?us-ascii?Q?uxvmN3UPOTBLIbfvcsfYeynOl+OMxn3RvfXCwj98lp6lorWkRI9TNUnHgj07?=
 =?us-ascii?Q?1o6rGleUmGh+k52QMOghW3ZxQXXWrGrQVrj4EzkWryl5zXM1ng8Y/4dpLVvW?=
 =?us-ascii?Q?SSkzqIdpVlMlqlFcGiwNFypZ01ksVw363Ge67RLtcw9ffSFXxXy/vm6c5SmY?=
 =?us-ascii?Q?f8hFSvXEUTiVYMF4RdNnmKXvARMyF9cgR8Qi2DUlGr/NvWG+WpMcg/KORowL?=
 =?us-ascii?Q?wgTXuVxrq7fQeaNXaJz5ThKbApJaCy7oEq+ObMZlegr2zTnsEVs0/L7o7XST?=
 =?us-ascii?Q?zWEmsCBbtEWIVVGVnPt2iKybTcdsZUEpNLDD/9Nybp4V9EgzX5e/6bqhyyye?=
 =?us-ascii?Q?Cda4MWA0UgmYCAlKcfRYs6AzHCEmasDGLO4V/XGixPpV0MwIGgG08mqnyjhz?=
 =?us-ascii?Q?PG3gKptAXoq88NZHASFge927ko7m4tCElGrM9LBSYbaF7jBHme3ftxCkmTGx?=
 =?us-ascii?Q?iKB8E9zF5PscvcFQly40s/w0qwQLnVkhb/FamSt2T7A1XBHBvr9fitj3hSex?=
 =?us-ascii?Q?dtiPenk/wrmGnBfEUoMKabjrp0S3GgabDw7H8T8600yyg1MgmI1cA7j8RatP?=
 =?us-ascii?Q?kInaZXuLIIKU4jWn62UuuSZA31YX38djPrS2jUymW7OdtgNy/DMtDeX0PUoc?=
 =?us-ascii?Q?Txx+l73lEbyo41YdhaPeaBG3U+PzXeymeYsmNJt0xbFFr4v/lqA8X82a5Z24?=
 =?us-ascii?Q?onv98dkMZTWBoRhgR4kwblZ/Kf06tDL0SYGQsRLMYc+SM6WyQfGAcwAwZjoQ?=
 =?us-ascii?Q?3QZjnHM5AMcoIqKrPgw5aV6Hv3Jx26UXFiZNn8pHffhYUNu6nT+LmvJPVnfU?=
 =?us-ascii?Q?tc0TIfwSiOKlh5D7nAA5VNQ+T/dhztmJoxQEfnb9EDhboxok8z+KBFKr2OLn?=
 =?us-ascii?Q?Z+9VvRtxySOI0yNMyy9yFUhIo6JxFy4qjRMisKlwYusKxQZ9Fy7U3xn6b/ss?=
 =?us-ascii?Q?FVoFzHNNYYfRfi5OvxpdvgtantOYyStJLXqHLOi+DMTT7N4U4tV++O7m/eyI?=
 =?us-ascii?Q?GQmndYwwEYr05UAJQMTzcc+ddWnsyLMQ6vCaSPwnVvaV6mttLlIZfSy8pjq0?=
 =?us-ascii?Q?mf4sjKBArkbufdv624t/0USnPvybqr8gLXX5ylbYWXszG6nLhgCaPpqL/vCH?=
 =?us-ascii?Q?P4hp9Mx07CcZGosOsO7+x1hb0fkagB4nLoLjyk7kUR8+OU2IjtaYdzwxQZgB?=
x-ms-exchange-antispam-messagedata-1: BpNZzvQBHmtFbQ==
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: marvell.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: CO1PR18MB4538.namprd18.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8d17560f-4e75-45a0-09b8-08da3085e290
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 May 2022 00:01:21.5595
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: iUF5GnFupFeXGYiEdBnmaK+meP2bb6I9ytjlwMRjKcVQIVtp6HPVmsuZ5s+HvGx1YlhMWZ59yGD5FUEg4x1nsw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR18MB3746
X-Proofpoint-ORIG-GUID: cvtqX5TktIEMMNDMlpNJedysisMwPvpr
X-Proofpoint-GUID: FL4D2Lmb-WC3hlbSM8CoXkGuhNG8dvom
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.858,Hydra:6.0.486,FMLib:17.11.64.514
 definitions=2022-05-07_08,2022-05-06_01,2022-02-23_01
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Keith,
For the polynomial you used in this path is 0x9A6C9329AC4BC9B5ULL,  why it =
is different than the 0xAD93D23594C93659ULL defined in NVMe command set spe=
c 5.2.1.3.4 ? Though the crc66 implemented in this patch can pass with test=
 cases defined in Figure 121: 64b CRC Test Cases for 4KiB Logical Block wit=
h no Metadata.  Could you explain the discrepancy between the spec and the =
patch?=20

Thanks,
Xiaoming

-----Original Message-----
From: Linux-nvme <linux-nvme-bounces@lists.infradead.org> On Behalf Of linu=
x-nvme-request@lists.infradead.org
Sent: Tuesday, February 22, 2022 12:00 PM
To: linux-nvme@lists.infradead.org
Subject: [EXT] Linux-nvme Digest, Vol 95, Issue 129

External Email

----------------------------------------------------------------------
Send Linux-nvme mailing list submissions to
	linux-nvme@lists.infradead.org

To subscribe or unsubscribe via the World Wide Web, visit
	https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org_=
mailman_listinfo_linux-2Dnvme&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Di2Q=
EdWf3G3LCjxQ2FY9geCmDX5uXEL6k-yI1XpluRMU&m=3DaO_Z5Vo-ZK5JNnkryiz1SPDNY97daT=
4vk4ofnRS3deDGItjh6hmpsmYhvngO8oj7&s=3Dflu55Dn1W8d8Kpb07ZIOf9EiWvJEacADVUk_=
k10Fj8w&e=3D
or, via email, send a message with subject or body 'help' to
	linux-nvme-request@lists.infradead.org

You can reach the person managing the list at
	linux-nvme-owner@lists.infradead.org

When replying, please edit your Subject line so it is more specific than "R=
e: Contents of Linux-nvme digest..."


Today's Topics:

   1. Re: [GIT PULL] nvme fixes for Linux 5.17 (Christoph Hellwig)
   2. Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits
      macro (Joe Perches)
   3. Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
      (Eric Biggers)
   4. Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
      (Eric Biggers)
   5. Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
      (Eric Biggers)


----------------------------------------------------------------------

Message: 1
Date: Tue, 22 Feb 2022 09:29:34 -0800
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Christoph Hellwig <hch@infradead.org>, Keith Busch
	<kbusch@kernel.org>, linux-block@vger.kernel.org, Sagi Grimberg
	<sagi@grimberg.me>, linux-nvme@lists.infradead.org
Subject: Re: [GIT PULL] nvme fixes for Linux 5.17
Message-ID: <YhUdfqXy0wCDQywm@infradead.org>
Content-Type: text/plain; charset=3Dus-ascii

On Tue, Feb 22, 2022 at 10:26:16AM -0700, Jens Axboe wrote:
> Hmm?
>=20
> https://urldefense.proofpoint.com/v2/url?u=3Dhttps-3A__git.kernel.dk_cgi
> t_linux-2Dblock_commit_-3Fh-3Dblock-2D5.17-26id-3D93e2c52d71a6067d08ee
> 927e2682e9781cb911ef&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Di2QEdWf3G3=
LCj
> xQ2FY9geCmDX5uXEL6k-yI1XpluRMU&m=3DaO_Z5Vo-ZK5JNnkryiz1SPDNY97daT4vk4ofn
> RS3deDGItjh6hmpsmYhvngO8oj7&s=3DvE-IaGHIXqznhuUOWrva610L8_iwmV2_3jo301Ps
> eEY&e=3D

Indeed.  I somehow had a stale block-5.17 branch locally.



------------------------------

Message: 2
Date: Tue, 22 Feb 2022 10:43:21 -0800
From: Joe Perches <joe@perches.com>
To: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk,
	martin.petersen@oracle.com, colyli@suse.de, Bart Van Assche
	<bvanassche@acm.org>
Subject: Re: [PATCHv3 04/10] linux/kernel: introduce lower_48_bits
	macro
Message-ID:
	<603f9243bb9e1c4c50aaec83a527266b48ab9e20.camel@perches.com>
Content-Type: text/plain; charset=3D"ISO-8859-1"

On Tue, 2022-02-22 at 08:56 -0800, Keith Busch wrote:
> On Tue, Feb 22, 2022 at 05:50:45PM +0100, Christoph Hellwig wrote:
> > On Tue, Feb 22, 2022 at 08:45:53AM -0800, Joe Perches wrote:
> > > On Tue, 2022-02-22 at 08:31 -0800, Keith Busch wrote:
> > > > +/ *
> > > > + * lower_48_bits - return bits 0-47 of a number
> > > > + * @n: the number we're accessing  */ #define lower_48_bits(n)=20
> > > > +((u64)((n) & 0xffffffffffffull))
> > >=20
> > > why not make this a static inline function?
> >=20
> > Agreed.
>=20
> Sure, that sounds good to me. I only did it this way to match the=20
> existing local convention, but I personally prefer the inline function=20
> too.

The existing convention is used there to allow the compiler to avoid warnin=
gs and unnecessary conversions of a u32 to a u64 when shifting by 32 or mor=
e bits.

If it's possible to be used with an architecture dependent typedef like dma=
_addr_t, then perhaps it's reasonable to do something like:

#define lower_48_bits(val)					\
({								\
	typeof(val) high =3D lower_16_bits(upper_32_bits(val));	\
	typeof(val) low =3D lower_32_bits(val);			\
								\
	(high << 16 << 16) | low;				\
})

and have the compiler have the return value be an appropriate type.





------------------------------

Message: 3
Date: Tue, 22 Feb 2022 11:50:42 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhU+kuMhueXVQvxe@sol.localdomain>
Content-Type: text/plain; charset=3Dus-ascii

On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> +config CRYPTO_CRC64_ROCKSOFT
> +	tristate "Rocksoft Model CRC64 algorithm"
> +	depends on CRC64
> +	select CRYPTO_HASH
> +	help
> +	  Rocksoft Model CRC64 computation is being cast as a crypto
> +	  transform. This allows for faster crc64 transforms to be used
> +	  if they are available.

The first sentence of this help text doesn't make sense.

> diff --git a/crypto/crc64_rocksoft_generic.c=20
> b/crypto/crc64_rocksoft_generic.c new file mode 100644 index=20
> 000000000000..55bad1939614
> --- /dev/null
> +++ b/crypto/crc64_rocksoft_generic.c
> @@ -0,0 +1,104 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Cryptographic API.

The "Cryptographic API" line doesn't provide any helpful information.

> +static int chksum_final(struct shash_desc *desc, u8 *out) {
> +	struct chksum_desc_ctx *ctx =3D shash_desc_ctx(desc);
> +
> +	*(u64 *)out =3D ctx->crc;
> +	return 0;
> +}
> +
> +static int __chksum_finup(u64 crc, const u8 *data, unsigned int len,=20
> +u8 *out) {
> +	*(u64 *)out =3D crc64_rocksoft_generic(crc, data, len);
> +	return 0;
> +}

These 64-bit writes violate alignment rules and will give the wrong result =
on big endian CPUs.  They need to use put_unaligned_le64().

> +static int __init crc64_rocksoft_x86_mod_init(void) {
> +	return crypto_register_shash(&alg);
> +}
> +
> +static void __exit crc64_rocksoft_x86_mod_fini(void) {
> +	crypto_unregister_shash(&alg);
> +}

This has nothing to do with x86.

> +config CRC64_ROCKSOFT
> +	tristate "CRC calculation for the Rocksoft^TM model CRC64"

I'm sure what the rules for trademarks are, but kernel source code usually =
doesn't have the trademark symbol/abbreviation scattered everywhere.

> +	select CRYPTO
> +	select CRYPTO_CRC64_ROCKSOFT
> +	help
> +	  This option is only needed if a module that's not in the
> +	  kernel tree needs to calculate CRC checks for use with the
> +	  rocksoft model parameters.

Out-of-tree modules can't be the reason to have a kconfig option.  What is =
the real reason?

> +u64 crc64_rocksoft(const unsigned char *buffer, size_t len) {
> +	return crc64_rocksoft_update(~0ULL, buffer, len); }=20
> +EXPORT_SYMBOL(crc64_rocksoft);

Isn't this missing the bitwise inversion at the end?

> +MODULE_AUTHOR("Keith Busch <kbusch@kernel.org>");=20
> +MODULE_DESCRIPTION("Rocksoft model CRC64 calculation (library API)");=20
> +MODULE_LICENSE("GPL");
> +MODULE_SOFTDEP("pre: crc64");

Shouldn't the MODULE_SOFTDEP be on crc64-rocksoft?

- Eric



------------------------------

Message: 4
Date: Tue, 22 Feb 2022 11:54:31 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhU/d6wn55/GWPxm@sol.localdomain>
Content-Type: text/plain; charset=3Dus-ascii

On Tue, Feb 22, 2022 at 11:50:44AM -0800, Eric Biggers wrote:
> > +config CRC64_ROCKSOFT
> > +	tristate "CRC calculation for the Rocksoft^TM model CRC64"
>=20
> I'm sure what the rules for trademarks are, but kernel source code=20
> usually doesn't have the trademark symbol/abbreviation scattered everywhe=
re.
>=20
> > +	select CRYPTO
> > +	select CRYPTO_CRC64_ROCKSOFT
> > +	help
> > +	  This option is only needed if a module that's not in the
> > +	  kernel tree needs to calculate CRC checks for use with the
> > +	  rocksoft model parameters.
>=20
> Out-of-tree modules can't be the reason to have a kconfig option. =20
> What is the real reason?

Also this option can be enabled without the CONFIG_CRC64 it depends on, whi=
ch is broken.

- Eric



------------------------------

Message: 5
Date: Tue, 22 Feb 2022 11:56:59 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Keith Busch <kbusch@kernel.org>
Cc: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
	linux-crypto@vger.kernel.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, axboe@kernel.dk, hch@lst.de,
	martin.petersen@oracle.com, colyli@suse.de
Subject: Re: [PATCHv3 06/10] crypto: add rocksoft 64b crc framework
Message-ID: <YhVACzTEylUg5LJx@sol.localdomain>
Content-Type: text/plain; charset=3Dus-ascii

On Tue, Feb 22, 2022 at 08:31:40AM -0800, Keith Busch wrote:
> Hardware specific features may be able to calculate a crc64, so=20
> provide a framework for drivers to register their implementation. If=20
> nothing is registered, fallback to the generic table lookup=20
> implementation. The implementation is modeled after the crct10dif equival=
ent.
>=20
> Signed-off-by: Keith Busch <kbusch@kernel.org>
> ---
>  crypto/Kconfig                  |   9 +++
>  crypto/Makefile                 |   1 +
>  crypto/crc64_rocksoft_generic.c | 104 +++++++++++++++++++++++++
>  include/linux/crc64.h           |   5 ++
>  lib/Kconfig                     |   9 +++
>  lib/Makefile                    |   1 +
>  lib/crc64-rocksoft.c            | 129 ++++++++++++++++++++++++++++++++
>  7 files changed, 258 insertions(+)
>  create mode 100644 crypto/crc64_rocksoft_generic.c  create mode=20
> 100644 lib/crc64-rocksoft.c

I tried testing this, but I can't because it is missing a self-test:

[    0.736340] alg: No test for crc64-rocksoft (crc64-rocksoft-generic)
[    5.440398] alg: No test for crc64-rocksoft (crc64-rocksoft-pclmul)

All algorithms registered with the crypto API need to have a self-test (in =
crypto/testmgr.c).

- Eric



------------------------------

Subject: Digest Footer

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
https://urldefense.proofpoint.com/v2/url?u=3Dhttp-3A__lists.infradead.org_m=
ailman_listinfo_linux-2Dnvme&d=3DDwICAg&c=3DnKjWec2b6R0mOyPaz7xtfQ&r=3Di2QE=
dWf3G3LCjxQ2FY9geCmDX5uXEL6k-yI1XpluRMU&m=3DaO_Z5Vo-ZK5JNnkryiz1SPDNY97daT4=
vk4ofnRS3deDGItjh6hmpsmYhvngO8oj7&s=3Dflu55Dn1W8d8Kpb07ZIOf9EiWvJEacADVUk_k=
10Fj8w&e=3D=20


------------------------------

End of Linux-nvme Digest, Vol 95, Issue 129
*******************************************
