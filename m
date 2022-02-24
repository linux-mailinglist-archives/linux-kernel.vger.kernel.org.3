Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0364B4C2173
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 03:02:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiBXCBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 21:01:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58628 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229898AbiBXCBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 21:01:44 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E17114FDF;
        Wed, 23 Feb 2022 18:01:15 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21NNwv28017844;
        Thu, 24 Feb 2022 02:00:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=dHKkmcjZEjmctrQoqThEBvkuxUp88GdHdf0lRaQO1JE=;
 b=MUnNf1zKCrOfzW6Zt3YFAO5LB/Wea/74RwfssXKwOuwOTOhciI/PxISeNgaDDeMoTx8P
 K6gaucEtCOgGhpcszYS7Ssaar6/Li13XnHDeafLnErYJHscH2ePEf3kNiHiylSwyqnf/
 G3YmrwXXG/30KiBZ3GiuCRgFYpRKFkqqMBRN843M0JrfqNtGBtacSrI4FrAU7ma8crDD
 uayEmvaYZFHzMNAI7NbzmUvf36WaKHrAxCHGzuFU5KBiFURmt8fiSU5Mc+Kds/k4KiIj
 wcy+0L1hocLCA/OtK+r5GPiCWMNN+Pd3A53cR34iV2fHSf4B1QeCe8ktnqP1r9YCHObi cA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ectsx6320-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 02:00:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21O1tghS033478;
        Thu, 24 Feb 2022 02:00:40 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by userp3030.oracle.com with ESMTP id 3eannwqber-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 24 Feb 2022 02:00:40 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kLtGjJOtKO8CPzWLig6a4xY6S31bCqWCuI0EDMXdeJWE8Y2dcBg1LeZGgd9OF0I9IL9wHTgGWs7+G1hDcCKl/2kNXhvkEskOM/MrhCeWdEkO8KWWW5Py1fcmdL6ikTBqnjI7YVMNYYV/lHpx9EcvjjMzE70cOFwsb67lNspf78N4ewXKywQFBU+TKEFu8vnDWdlZptYNLvqStR/bsDp8quPKbmMHeD5KalRQ9qcils9bt3Vf8CFJFzJsCBVcabe6rx4P+HbkwtPq4oLB3c82Dd5wP6G8N7JJBoeU4wdpYUsLdGRpCO+xNY9uObqc2PYHaPPGsnAKIlk5+PCKvCTm6w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dHKkmcjZEjmctrQoqThEBvkuxUp88GdHdf0lRaQO1JE=;
 b=A/3uW4dQLbV9lHG46Ybs2S+j5ryS4GOLeL7oz6VWcys2iELhNNuGkgmzxH40WzqvcF7pP42k7JcCHpAWXsEnAqyR1AaurobTopZ/1gHkyBIvjwIRb/te1kWcW0TcnBHiqJZGn1IYfFHBV2kZdoYFhd63bz7hugl0mmB+1VCMXTULo3Y8p6V7fricdxZl4PVTqj5UBtaLaUhmCMXMOqceZNHoWWJhKa/JfVmABBMHLLpIgHhCw0S5X8pQe96w9fRqpNMzubL6wPlGUvNj+VY332ZbtG0QkmyBJPN82chzITgF68sf7HfKF7yBw4DH5nRw42NTy0WM8o2RkJFyZQesIQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dHKkmcjZEjmctrQoqThEBvkuxUp88GdHdf0lRaQO1JE=;
 b=ELfsTrg9lP//ToBAeuKZbWhyKN0KKUxGZBwIbd+B+R+a7pKHetv9aZP6YLjq4COg0G6qGdMsHlF7th6jqJmF0YuL7k9LD3J6zEB1966AT3W7N1A+tkb5Qr3izZIcFzsbUlFaxW5GqsqgdwfFIF4yOXfcjQhS/1eP5GdDSFhs2fQ=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by CY4PR10MB1973.namprd10.prod.outlook.com (2603:10b6:903:126::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Thu, 24 Feb
 2022 02:00:37 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::899e:951a:8129:8ef1%4]) with mapi id 15.20.4995.028; Thu, 24 Feb 2022
 02:00:37 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     Catalin Marinas <catalin.marinas@arm.com>
CC:     Will Deacon <will@kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Topic: [PATCH] arm64: Change elfcore for_each_mte_vma() to use VMA
 iterator
Thread-Index: AQHYJHBq9S9Lf3gga0WdWNWpZs6RLKyeUrcAgAFUnoCAAB/xAIAAEoeAgAAYlQCAARgvgIAAKx2AgADGBIA=
Date:   Thu, 24 Feb 2022 02:00:37 +0000
Message-ID: <20220224020025.tdq4blhiqrlalhpa@revolver>
References: <20220218014642.lop2ohx4ov6fekyl@revolver>
 <20220218023650.672072-1-Liam.Howlett@oracle.com> <YhPUuu+6TPMKjhwk@arm.com>
 <20220222142557.6oykxjz3j7fq4mrn@revolver>
 <20220222162016.GA16436@willie-the-truck> <YhUcywqIhmHvX6dG@arm.com>
 <20220222185401.jntcd4g62pamfxvr@revolver> <YhYcc+CGWuO0tUG+@arm.com>
 <20220223140851.m6bmaozqb5xfydqt@revolver>
In-Reply-To: <20220223140851.m6bmaozqb5xfydqt@revolver>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 35edf01d-fbd6-466b-8987-08d9f73973bc
x-ms-traffictypediagnostic: CY4PR10MB1973:EE_
x-microsoft-antispam-prvs: <CY4PR10MB19739EB4AC4576320F1EE1D2FD3D9@CY4PR10MB1973.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: uuUSVUxyaGlxmwhexfDgSHAr1SoVioqgYkuBgGjUAc7/Txtbux37KhOAAQzf8hkDXv+kypAfu/heU4Vb5jYMiIiu1ECOldZSjtLqZFSZ3RL7mrlYLoSPQhbeVzHwfM20T/yZkajbv552tiuGoM6M0S4d8KHTZ/+RmPi6+Avke9G10zpD6idnwOqrz4gtjUW7BJJPAx/5lJiOaqJdrRv/yVW/yd/P5PMzFGzebklsrMeSYD53NeP7iy+FxGhkuMtZ0ufDekLJWvP7KRQoSF2eGkthmaWpO8xK8KcV0C21ogW4xlSrZhx56Dj5/TCaPwyt1kVF0zNigeTMXy34pwUNsu4B3TP7sY3X6Lobmlj0GwS7GsT+KR9L0smFXAU7h0RpkeQzzuULgUSPvJYD5blnENarER+Lkvvy/geEm/khIh27RVqButFmAR2x9qdsDBlvXenuvUrWldqAl96ZyGVp9wjsSAZ9Gvsdxnx+mL0sUCbd12Cz36T/HKCrIOmmmlrT7T2cgV/1HjfEj05HtlOQL3D17vKjLXZxj6RRJSVO/K3xJXZkPjdIG/lrd0IAtBvK5qWX/2d1JO3LrmA9hVxE38ylrcwejXGwVOqeVXoNtVU4IB8k+WpKsNrU39AbQOfZGNtYQxZg5OvkoZwDCuRdIldvgFtRnaK38+Z0hGoqzICJC7I05wY5UhkeVgWu8j/gAcTb5tzcxrtIP/8QAUDq8tVwv3wPOOen3Xp3elovBHdjncY3Opq5Sl3gHr4d2zif8SIIsEZLuKNJYCQRMJ7dGmd2lLuOcDgggOaBhzErPdg=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(5660300002)(44832011)(122000001)(91956017)(26005)(186003)(38100700002)(45080400002)(6506007)(66556008)(66476007)(66446008)(64756008)(76116006)(66946007)(316002)(2906002)(4326008)(6916009)(83380400001)(54906003)(6486002)(8936002)(86362001)(38070700005)(508600001)(33716001)(9686003)(6512007)(8676002)(71200400001)(1076003);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?yuPwWchEqjbgZE2yMXmL4iAX3t337t6coDsRz+GULdpDwFbpBn5HUbPnCiU+?=
 =?us-ascii?Q?fDVARRXsEXOTFkcPQIMzeMAx6e2qPUoKRorhrswd+Zzd4wKW7VmzuGhG2QeN?=
 =?us-ascii?Q?RhjihYlGBMHCISr/9F8uYQ2vy3c/kvZVUJ5zZMnZ1J6P4HZ0G2O+Ds5gorW7?=
 =?us-ascii?Q?8q/YwRT5B0UC8jVUICep9QsNN6hZDU6chZTourGrpO/rtx7G/EAKA+uZUJqQ?=
 =?us-ascii?Q?YGQC7uTXeXg88AWz7kmrjkmIJxEBmPDzzd2MtYPuKBj2nw7Vp21wTCdL446d?=
 =?us-ascii?Q?Iiy+P/SsSVVAZf8lk+CxmM0H+sxqyDVhzuDyC3wy39T/PQk7+rUt1nBeuNYP?=
 =?us-ascii?Q?oSW/QRS7yqC9o5Jwi9k8zZURG6smYTFs7iQT7GS/D9cf0v7Eb/Qi2iu+Z3rM?=
 =?us-ascii?Q?uMmx4coS0TGJV1UnH3n+c+C/RbTWeydGXABDAZPpyuOGtoZafudf1qAVXgZT?=
 =?us-ascii?Q?yJK1JtIsbyCSn3pIeIW97yrHqFoHiF+O42WCemlTtilK22GhrvTQe7W/XiBi?=
 =?us-ascii?Q?GkyLcqn//ozJ959nqzuvwykxdcU3T5V4HFjR41h4vY17n2/V10nP6zKnqUhm?=
 =?us-ascii?Q?hcEYNIGQne4w0cUztVzKmnINtxIHrVyZ7a2DTAyGAID8fPSlcaPt5UfssAlM?=
 =?us-ascii?Q?3WQxc0UIKZr1r4pZ6lxH9rNQooazKqNkcC1Z3N6D0zheV7Q3lhE27dM6+IGO?=
 =?us-ascii?Q?lxlocatEbNMql3JBk+VsemThHEYdkZ+V6tyS9kohvklgoBHK65bJ9StOqtR4?=
 =?us-ascii?Q?7d6BdzHUQFPmrhN4Fy6KTr+3nUJjHryExhvR0Cs7FMtguVsU1Fiq9dloBH25?=
 =?us-ascii?Q?N5uKkn6K3FX1PUlsFvbcHRpWZiSPV7kYVwF5Z7PGnTLga9u1rGhoHa+w4kce?=
 =?us-ascii?Q?M/Vw6VREQUNMMfZvjFmlWKl4p7nfni5HZ7jkwwDvtWelfj764WtR6OwnEMrN?=
 =?us-ascii?Q?t5865jN6CvCSbr1f8pVjPuxBh5I8WHY32HY7yenStTOdPSq/QZVYgGtsGUK5?=
 =?us-ascii?Q?6Q0irXUVWW4DUxHubIi0Y4QizrnIWz8sBUEphUNxy3RJ4FBUQNM7CglZlTlt?=
 =?us-ascii?Q?HoEhJsnKGeEm++St8kTyYAeZb+l/Xx76vujgpt3qJ6hYpLjGBcuNLErUcSDQ?=
 =?us-ascii?Q?Uh3Z0h/HErHN74sv9A/4PkCRmXNrJhXYzKQqdtkWeb0ri1gtSwiij0bhIvQI?=
 =?us-ascii?Q?BOiKUKEJcBj5Yq0njzU2qsdmh9eT+ts8zSVBMfnK0LOF30COx+Ga5Ie98EDg?=
 =?us-ascii?Q?tKTyw4qASWScwEqb+bq8dvPBSqd3to1opKwP5IbwHJIq2b0JpIg4adpenxbJ?=
 =?us-ascii?Q?+fSr4P2zN7uOjj4kpnYS/4fLbBLWLeidkE3mDzMuAeEtFC04JDj57EEhM2Il?=
 =?us-ascii?Q?8QGNJsI+6vdw4oxyx5KAz6px+QfLysgpvhmWvsLBEscQBIPPf/OnGceBptIO?=
 =?us-ascii?Q?tsqDISdlszGnR0y/+JJvsz/gji+K38WSXSpVJfbDW6KyRAI3yN3GxznC3kaV?=
 =?us-ascii?Q?4l1s1nxhyTJ/7J4OoYI/qs7zboGyFGLZ/qEyfKguuaPbCjE0ec5RZcwks5v5?=
 =?us-ascii?Q?Dr1xAK99n2c0krA8OAWxqgoJaa0RgNdIHF4CGFtxI5PS7TfS3cu2QZREXLGn?=
 =?us-ascii?Q?blWETGINU2kyThkmhPwfPP4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <296E14AB2A1C6B488EA6A6F7F7FFFD1C@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 35edf01d-fbd6-466b-8987-08d9f73973bc
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2022 02:00:37.6099
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 83Ys24YxDMIHacrZ1xYPcRsh2LkhprLMGa2nuRIeuFuKbw89/Un+7RNB3wuHl4ex0Z2NOU+iZTxxWtejV14H1w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR10MB1973
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10267 signatures=681306
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 malwarescore=0 phishscore=0 mlxlogscore=793 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202240007
X-Proofpoint-ORIG-GUID: HkuUJ5Q6vrCyM6VDl8ZNZ9F1iNeJ3FlO
X-Proofpoint-GUID: HkuUJ5Q6vrCyM6VDl8ZNZ9F1iNeJ3FlO
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Liam R. Howlett <Liam.Howlett@Oracle.com> [220223 09:11]:
> * Catalin Marinas <catalin.marinas@arm.com> [220223 06:37]:
> > On Tue, Feb 22, 2022 at 06:54:38PM +0000, Liam Howlett wrote:
> > > Once the maple tree is upstream, then you can take the patch I posted=
.
> >=20
> > BTW, on the maple tree branch alone
> > (https://github.com/oracle/linux-uek.git maple/mainline), I get the
> > warning below and no core file generated. It's not MTE related as it
> > doesn't have my patches.
> >=20
> > [   67.887638] WARNING: CPU: 1 PID: 528 at fs/coredump.c:1116 dump_vma_=
snapshot+0x98/0x18c
> > [   67.888594] Modules linked in: crct10dif_ce sm3_ce sm3_generic sha3_=
ce sha3_generic sha512_ce sha512_arm64 drm fuse ip_tables x_tables ipv6
> > [   67.890017] CPU: 1 PID: 528 Comm: mte-coredump Not tainted 5.17.0-rc=
4-00071-gc8cf067d6a99 #1
> > [   67.890494] Hardware name: QEMU QEMU Virtual Machine, BIOS 0.0.0 02/=
06/2015
> > [   67.891054] pstate: 60400005 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BT=
YPE=3D--)
> > [   67.891469] pc : dump_vma_snapshot+0x98/0x18c
> > [   67.891787] lr : dump_vma_snapshot+0x74/0x18c
> > [   67.892071] sp : ffff80000839b8f0
> > [   67.892278] x29: ffff80000839b8f0 x28: ffffd4a81d76255c x27: 0000000=
000000000
> > [   67.892894] x26: ffffd4a81da308e0 x25: 0000000000000000 x24: ffff800=
00839bc78
> > [   67.893436] x23: ffff00000557cf00 x22: ffff00000557cf60 x21: ffff800=
00839b9e0
> > [   67.893922] x20: ffff80000839b9e8 x19: ffff80000839b9dc x18: 0000000=
000000000
> > [   67.894497] x17: 0000000000000000 x16: 0000ffff9e8effff x15: 0000000=
000000000
> > [   67.895061] x14: 0000000000000000 x13: ffff0000025f9000 x12: ffff000=
001a2eb94
> > [   67.895590] x11: ffff80000839b100 x10: ffff80000839b108 x9 : 0000000=
000000000
> > [   67.896057] x8 : ffff80000839bb68 x7 : 0000000000000000 x6 : 0000000=
000896101
> > [   67.896537] x5 : ffff0000016bf000 x4 : ffff80000839b8b0 x3 : 0000000=
000000001
> > [   67.896961] x2 : 0000000000000000 x1 : 0000000000000001 x0 : 0000000=
000000011
> > [   67.897493] Call trace:
> > [   67.897679]  dump_vma_snapshot+0x98/0x18c
> > [   67.898034]  elf_core_dump+0x50/0xcf0
> > [   67.898274]  do_coredump+0xbdc/0xfc4
> > [   67.898553]  get_signal+0x524/0x7f0
> > [   67.898775]  do_notify_resume+0x224/0x1330
> > [   67.899046]  el0_da+0x50/0x60
> > [   67.899431]  el0t_64_sync_handler+0xec/0x130
> > [   67.899726]  el0t_64_sync+0x1a0/0x1a4
> >=20
>=20
> Thank you.  I will look into this immediately.  Was this with default
> config for arm64?  Was it with a vm or real hardware?


I was able to reproduce it and have a fix for tomorrow.

Thanks,
Liam=
