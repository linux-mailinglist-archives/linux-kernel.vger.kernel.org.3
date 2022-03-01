Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD7A84C9752
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 21:52:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237830AbiCAUxE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 15:53:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233113AbiCAUw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 15:52:58 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB26A31927
        for <linux-kernel@vger.kernel.org>; Tue,  1 Mar 2022 12:52:14 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 221IflDO032613;
        Tue, 1 Mar 2022 20:52:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=corp-2021-07-09;
 bh=aVYS1CVcOAdlVzPTuXBQ94kSlwzFaRIuU0/9n/ws7ZY=;
 b=bDxCNDKixQK/G/6vwLZfV+Ap4tR/yFexKshjcgGPBRmzoI4udSujEXgkyfp7+GOOT1ot
 YcPiD9uecmklWmh5G+JY1eulPrsbbha479Y/A+gVVQH4IcrhqUzkPTOpYNTYmrqMywnr
 9zb8JvfV0AUTiMu0ojXx28nLBHjZczOR+sFuJcL67pXS7a4UgQNCfVEd55UrPiPfUSYs
 u2UNL8NZETC6gk5ICnkOiWYQ4gefykGLHhthQgNWRPFbczAY4ZA0AqdniZEkMdbvgy/H
 v9dOreNFSQ0TzQTmg05t9tY2EMluXq43HPCyASInyKCUzj41DSDbKMdxN7Gcr/whiyVI /A== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2ehsuc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:52:07 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 221KpHMQ079176;
        Tue, 1 Mar 2022 20:52:06 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2109.outbound.protection.outlook.com [104.47.58.109])
        by aserp3030.oracle.com with ESMTP id 3efa8erbpq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Mar 2022 20:52:05 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dwghm6qdJYuTppKgTp48pYFAWbaIDZDhWtQx9+XvbLiLgZR/qWeTg8idlQn7cF/K9JBQ7QWs4hCL2JaCRPMvHfZbpTBoLKptFCe11iJWJ/cwJpQ7arIdJf/x2POigxZYX7oJaOVUnRhdXn35PW22xtelGKeg1zvXDYI9FBqldvY7kFatErV8e4bF7jHFSdfLU+sSZ6Rd/xdEP2wze9D7chOPZBAzkMkSd8EEFLFgUT/1kW1kHTvKMPku2VI74lEHtlAGmhnL/MunufvSp0YHbDuE5sutybwmEJCTsYi/61CCHXBxzAkRO7lC8TvjhN1MsAa+de/QgJXjTpQUgh+lEA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aVYS1CVcOAdlVzPTuXBQ94kSlwzFaRIuU0/9n/ws7ZY=;
 b=CXegGDsDubl9HvWAbAbktaCEIj3QEZ73E6bIntgs0C3v0kJKu2t1tmSQYnX2HJArTR2q2u2xKoNlY6nQfnGAcuidwroN3kWybUeQBukrNIe4PV6QFPDuV0TdfK/3ZFiuNutm7pbkyq5Z7Anv+fWAkQRPvls/evm8qA7wcKKmnRV2DpPpHs5eD0BVmNH+vxWBd819yXZViDH16z3V/UTtfXAKFS1wlPev295X7BlfiDERjaj7w2ho76O/vnVOEi+H5GPb8Y559Ec/pvF/dtm6yQZCLjWnye+1XrFrdMCdWdeA6oeasxJy/Ju9YI3y7IV7/+HCchStLqB90B8kfHunEw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aVYS1CVcOAdlVzPTuXBQ94kSlwzFaRIuU0/9n/ws7ZY=;
 b=THjYLJB1dy0FApdaFfBdTlzoy9qKZT4cupXryWyLRMiNP7W4adGipArtUIYaLjinWwSBJgjs1p+KdL4NwtGUWByu5tSL0cvd6FKC+RZckQl5Vr35IXTqony+b2DXKAP5VAm2AOBzlxO1T5iEL+BM8S2X7Oh0m5DVO9/vs0lSjS0=
Received: from SN6PR10MB3022.namprd10.prod.outlook.com (2603:10b6:805:d8::25)
 by SJ0PR10MB5890.namprd10.prod.outlook.com (2603:10b6:a03:3ef::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.25; Tue, 1 Mar
 2022 20:51:58 +0000
Received: from SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a]) by SN6PR10MB3022.namprd10.prod.outlook.com
 ([fe80::8df4:1db9:57f2:a96a%3]) with mapi id 15.20.5017.027; Tue, 1 Mar 2022
 20:51:58 +0000
From:   Liam Howlett <liam.howlett@oracle.com>
To:     kernel test robot <oliver.sang@intel.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        "lkp@lists.01.org" <lkp@lists.01.org>,
        "lkp@intel.com" <lkp@intel.com>
Subject: Re: [mm]  82e080f318: BUG:KASAN:use-after-free_in_move_vma
Thread-Topic: [mm]  82e080f318: BUG:KASAN:use-after-free_in_move_vma
Thread-Index: AQHYLLizgfaquIXk0U2Rz5R+xSdZ8qyrAuiA
Date:   Tue, 1 Mar 2022 20:51:58 +0000
Message-ID: <20220301205151.qowrapudk2uquore@revolver>
References: <20220228153426.GE1643@xsang-OptiPlex-9020>
In-Reply-To: <20220228153426.GE1643@xsang-OptiPlex-9020>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: ddc60924-f775-4c90-c2a4-08d9fbc55402
x-ms-traffictypediagnostic: SJ0PR10MB5890:EE_
x-microsoft-antispam-prvs: <SJ0PR10MB5890A409426BD76A558051F0FD029@SJ0PR10MB5890.namprd10.prod.outlook.com>
x-ms-exchange-senderadcheck: 1
x-ms-exchange-antispam-relay: 0
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: Ot0cvm6V3TaZM+pg1eNU2ZGucPMSW6o18NJGGhYyGnfXxu3Jt9Xy/5fUuuBYuHc/7jsJnuKIB/Ogy2YZL7h2d6+yOoqP9342a4W5i+6L/LB6IIy+GwexQHtyr+b8Qi+QOen1cmtAgAbDWPJr9cwjAbBrdkM18HFongmLfpbDzEC5j3ysBkEMOjKYm78dP4IC77GoQY52hvB+ddOIiH+wgNYRIRyOMUmGvAUn3TnTSu5sco7Zh3VbPX09YEoxbGbmwO+a+xChUj1tcr5TVjTJCf+DnkakLlBqToiuaZYtq6Bc4rGIjlrmTlV54scyvvQlinGQR4ykb0J5jNBp7NAIOyfYAMF3qJnbsZLH2okFdfk2/lOhZiLVE3Ge3APVAwWn+uUcSin3zz/Xj3YaYduho66yl0d7LKC4J9Dvok7z8yfJN0RWJcJ/6P6Fy6h/vfg8t3v9gWzLdSWv3zV7ormvtqdnb0xVX7fPTYJebcKq0SnPXAWQWnjsp72q7fqoVSHvh2nTOXS5PM4xFll4LMJGcwaw75FnlBT8kPSyQ61544u4iWqouyOLqDzPSYvOyNJlM7R4o2b6ERhPUjwjHROgksFnHF797OUYXHGlOpUc0v2m2/ftgmCvxV4TiKPrO50wRXEseJMo7gwARKtavoxjVwHY6+auWLg6iMXe1kPacbZgcsWHWR283+7Cy9YdH4+yp6Vuauct/XyVauR8p6/zr3DirdOQEFtFmFn033Ebm4CjhAmBBzKlUSOBuZ4+sG2ADSMsU7boS6LzmlA6AaxFTLpM3oJH26vdJGkX4H4Lm6XHQoR/nCHKWn9mwj8kiYq3xTD2ssTefqEiNeOJTr4VyErieQY7wRWl7G4zN8Yv+9Q=
x-forefront-antispam-report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SN6PR10MB3022.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38070700005)(6486002)(91956017)(186003)(26005)(83380400001)(4326008)(66574015)(8936002)(86362001)(38100700002)(30864003)(122000001)(66946007)(64756008)(66556008)(66476007)(66446008)(76116006)(5660300002)(316002)(33716001)(44832011)(2906002)(6916009)(54906003)(6506007)(45080400002)(71200400001)(508600001)(1076003)(8676002)(9686003)(6512007)(966005)(579004)(559001)(357404004);DIR:OUT;SFP:1101;
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: =?us-ascii?Q?jTjzwGSxju1+jik58Afk9mVoZB0aZdsRsu7Fhv0Oxfec3j1Wbkb/aGDB5vNI?=
 =?us-ascii?Q?kTDDYolfRFwUs1vqaILvzrTAmWKap2XZLlnsT0MNFQvvRBc+j2cMPAuwf8wg?=
 =?us-ascii?Q?OhTBEf17s21rFL+c+g7bxgeM0pePOvwpw27KBqQP6X3CltdXw1IToN/y7FId?=
 =?us-ascii?Q?8dUr17KGhIElwSKC+K4/r0AqRuP56zewuQOAIviSRX5pAlG33iauS2eGOg5J?=
 =?us-ascii?Q?UfbfRAC2WwPOXTU291zX5OcCHvJNKPPtyI82Jvb1HwvzrxbQklaQNxT1cUBg?=
 =?us-ascii?Q?t2nOZVDceLJoal6gQH3eMrEfIfgw2djI0MNqcDXpNvhScsV0YLkieod7eR3r?=
 =?us-ascii?Q?w2eEvH1V8dhE+WWya3KCIrfBwiPqI9nYvb/tceV5Vpd5R+wAzKhDxjqOzNly?=
 =?us-ascii?Q?44SdR+kUXOnOlhjfxgKDF2SWt3U6G7bqSAJEOMrdb2bhsMBRU8TjLrUu9o8T?=
 =?us-ascii?Q?w7VxC5SupCPvTqFxgQGDzbeQ1KIQK07PS5MgkgUDMLQYpQjm72PJ2ec9UWli?=
 =?us-ascii?Q?OdRpuMS0+5EnL3yHw66W3JIU7nqLXob36oBJTPqqzJ0I9nytqTJxyddpJzUb?=
 =?us-ascii?Q?wCO4d9/wYhGl7HRIscTBpE4fAdBLMDLKMx42jh50yMaLkORsgX/Prb2EWqqW?=
 =?us-ascii?Q?XbeiDlSXkcPCg8JqNL2yKJf6QzvqLUGUpa3t39dBRkUhXj7UNHjKFMMxS1fu?=
 =?us-ascii?Q?8E7Ko3m8X+aMG+JSca4JSkLuW0o8M7tCyziRR+SmgtXD4PdjHuBbVC0E/3Ki?=
 =?us-ascii?Q?SAPpwCHcpXwyxTDTulgAMmdP30sf0LI2ylNNN0nHepkC3IC7ZxGyr90nLKz0?=
 =?us-ascii?Q?IYa5HVDiqOKsXmBIuAUxfAcDbvluaIh4EmwQwmUgWoCvtPMhY/4VIvaOMKUM?=
 =?us-ascii?Q?ZP8vfNIZd7G5j0TZAuIk7/NQXZ7wwx0TVnjkoxQrCgvFQD5vcGI+G8ef0m8F?=
 =?us-ascii?Q?87ttzffOmET6Y+wLvvxdlBLTjHOII2LXScZ/mlq0oBaVBuSWITSbdQHXL3Iq?=
 =?us-ascii?Q?crclV2sYfqaOycaFEKO9MiVC4XDIwFQ8Xs82ucV+inx+2prNkLj1h0z7SbNU?=
 =?us-ascii?Q?QRBT0UX4snbn2KtA5HVrTGawncKQG9nYq+z78ZhIbtsyMvetvVeZL8L8/I5g?=
 =?us-ascii?Q?dInhgv6K70pJaalcS9xaCRNWXtcbLJawJhxaWDQmNbUYsB70i9ChLQTLwCQg?=
 =?us-ascii?Q?fvABEnfgwwXo0Rrux4lPugySwnEikSnOuW1aJpEyc+ArUEKEblwjh0anJk18?=
 =?us-ascii?Q?619SuDJ/zDiwmeRPqDHlf1E//M2MriDyyR6d6z1Sc5hAS2CNpkPir1/IxxdV?=
 =?us-ascii?Q?UsSc9jrZN9nyl5uj17mxsrmrNU3P8/D4xr5b8SzuHnT0TnQeorZMjKqNAhBP?=
 =?us-ascii?Q?3hGm4cdEKa6gqBs6FwuzcdLkTTMgq9AuPnThAG9JccnmUX9JeeV1ODFS41DW?=
 =?us-ascii?Q?iafLa+cu9pyWOexeuHtMB3lgj2wHCWj8dx8wsX0XgRm6ND9Cwd683xmrQC5c?=
 =?us-ascii?Q?UhdAyKxnqsCD4yPmLLNS5atq1MSjAGfwNjLTsYW+E90ykmLpcxGgkmrhQoE2?=
 =?us-ascii?Q?6dtv8oDL+z8SkHGX3lFQjeO2G0mp+hk0ScUGzh/nQly0yZdSLlcMCWUj7GYT?=
 =?us-ascii?Q?geqGHkTBKs6qoSfHbg04RP4=3D?=
Content-Type: text/plain; charset="us-ascii"
Content-ID: <E800983F96B78A4EBC336104797D1320@namprd10.prod.outlook.com>
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: SN6PR10MB3022.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ddc60924-f775-4c90-c2a4-08d9fbc55402
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Mar 2022 20:51:58.3888
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: q6pE+kgyyo3jge3rSg3dDuw8s0DhbLBmjyoxVBR4ymxPnYejrTak9PEmNCVaTM03Qb1PV5KmhJWcNU6sIuPA0A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ0PR10MB5890
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10273 signatures=685966
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 mlxscore=0 suspectscore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2203010105
X-Proofpoint-ORIG-GUID: bCdsXfKU7UHJQwMv_N_GRsI056eisjyH
X-Proofpoint-GUID: bCdsXfKU7UHJQwMv_N_GRsI056eisjyH
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,UPPERCASE_50_75 autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thank you for the report.  This is a duplicate of what Hugh discovered
[1] and has been fixed.

[1] https://lore.kernel.org/all/5f8f4f-ad63-eb-fd73-d48748af8a76@google.com=
/#r

Regards,
Liam

* kernel test robot <oliver.sang@intel.com> [220228 10:34]:
>=20
>=20
> Greeting,
>=20
> FYI, we noticed the following commit (built with gcc-9):
>=20
> commit: 82e080f31808330f67ded631246798ec3ea37cff ("mm: Remove the vma lin=
ked list")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
>=20
> in testcase: blktests
> version: blktests-x86_64-bd6b882-1_20220226
> with following parameters:
>=20
> 	disk: 1HDD
> 	test: block-group-09
> 	ucode: 0xec
>=20
>=20
>=20
> on test machine: 4 threads Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz with 3=
2G memory
>=20
> caused below changes (please refer to attached dmesg/kmsg for entire log/=
backtrace):
>=20
>=20
>=20
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <oliver.sang@intel.com>
>=20
>=20
> [ 29.418341][ T743] BUG: KASAN: use-after-free in move_vma (mm/mremap.c:7=
14)=20
> [   29.424842][  T743] Read of size 8 at addr ffff888805c9e2a8 by task py=
thon3.7/743
> [   29.432285][  T743]
> [   29.434458][  T743] CPU: 3 PID: 743 Comm: python3.7 Not tainted 5.17.0=
-rc4-00070-g82e080f31808 #1
> [   29.443284][  T743] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIO=
S 1.8.1 12/05/2017
> [   29.451329][  T743] Call Trace:
> [   29.454452][  T743]  <TASK>
> [ 29.457230][ T743] dump_stack_lvl (lib/dump_stack.c:107)=20
> [ 29.461564][ T743] print_address_description+0x21/0x180=20
> [ 29.467971][ T743] ? move_vma (mm/mremap.c:714)=20
> [ 29.472132][ T743] kasan_report.cold (mm/kasan/report.c:443 mm/kasan/rep=
ort.c:459)=20
> [ 29.476812][ T743] ? move_vma (mm/mremap.c:714)=20
> [ 29.480972][ T743] move_vma (mm/mremap.c:714)=20
> [ 29.484962][ T743] ? move_page_tables (mm/mremap.c:571)=20
> [ 29.489985][ T743] ? security_mmap_addr (security/security.c:1594 (discr=
iminator 13))=20
> [   29.492284][  T301] LKP: stdout: 284: Kernel tests: Boot OK!
> [ 29.494838][ T743] __do_sys_mremap (mm/mremap.c:1063)=20
> [ 29.494842][ T743] ? move_vma (mm/mremap.c:893)=20
> [   29.500476][  T301]
> [ 29.505145][ T743] ? cap_capget (security/commoncap.c:1443)=20
> [ 29.505148][ T743] ? handle_mm_fault (mm/memory.c:4818)=20
> [ 29.505150][ T743] ? up_read (arch/x86/include/asm/atomic64_64.h:160 inc=
lude/linux/atomic/atomic-long.h:71 include/linux/atomic/atomic-instrumented=
.h:1318 kernel/locking/rwsem.c:1293 kernel/locking/rwsem.c:1557)=20
> [ 29.524470][ T743] ? do_user_addr_fault (arch/x86/mm/fault.c:1422)=20
> [ 29.529494][ T743] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/en=
try/common.c:80)=20
> [ 29.533740][ T743] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_=
64.S:113)=20
> [   29.539454][  T743] RIP: 0033:0x7fd0b9a9201a
> [ 29.543699][ T743] Code: 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48=
 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19 00 00 00 0f=
 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 46 0e 0c 00 f7 d8 64 89 01 48
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	73 01                	jae    0x3
>    2:	c3                   	retq  =20
>    3:	48 8b 0d 76 0e 0c 00 	mov    0xc0e76(%rip),%rcx        # 0xc0e80
>    a:	f7 d8                	neg    %eax
>    c:	64 89 01             	mov    %eax,%fs:(%rcx)
>    f:	48 83 c8 ff          	or     $0xffffffffffffffff,%rax
>   13:	c3                   	retq  =20
>   14:	66 2e 0f 1f 84 00 00 	nopw   %cs:0x0(%rax,%rax,1)
>   1b:	00 00 00=20
>   1e:	66 90                	xchg   %ax,%ax
>   20:	49 89 ca             	mov    %rcx,%r10
>   23:	b8 19 00 00 00       	mov    $0x19,%eax
>   28:	0f 05                	syscall=20
>   2a:*	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax		<-- trappin=
g instruction
>   30:	73 01                	jae    0x33
>   32:	c3                   	retq  =20
>   33:	48 8b 0d 46 0e 0c 00 	mov    0xc0e46(%rip),%rcx        # 0xc0e80
>   3a:	f7 d8                	neg    %eax
>   3c:	64 89 01             	mov    %eax,%fs:(%rcx)
>   3f:	48                   	rex.W
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	48 3d 01 f0 ff ff    	cmp    $0xfffffffffffff001,%rax
>    6:	73 01                	jae    0x9
>    8:	c3                   	retq  =20
>    9:	48 8b 0d 46 0e 0c 00 	mov    0xc0e46(%rip),%rcx        # 0xc0e56
>   10:	f7 d8                	neg    %eax
>   12:	64 89 01             	mov    %eax,%fs:(%rcx)
>   15:	48                   	rex.W
> [   29.563052][  T743] RSP: 002b:00007ffd9c276ca8 EFLAGS: 00000246 ORIG_R=
AX: 0000000000000019
> [   29.571272][  T743] RAX: ffffffffffffffda RBX: 00000000000a1000 RCX: 0=
0007fd0b9a9201a
> [   29.579055][  T743] RDX: 00000000000a1000 RSI: 0000000000051000 RDI: 0=
0007fd0b93eb000
> [   29.586838][  T743] RBP: 0000000000051000 R08: 0000000000000000 R09: 0=
0007fd0b93eb000
> [   29.594633][  T743] R10: 0000000000000001 R11: 0000000000000246 R12: 0=
000000000000000
> [   29.602431][  T743] R13: 00007fd0b95802d8 R14: 00000000000a0010 R15: 0=
000000000051000
> [   29.610214][  T743]  </TASK>
> [   29.613076][  T743]
> [   29.615247][  T743] Allocated by task 743:
> [ 29.619318][ T743] kasan_save_stack (mm/kasan/common.c:39)=20
> [ 29.623824][ T743] __kasan_slab_alloc (mm/kasan/common.c:45 mm/kasan/com=
mon.c:436 mm/kasan/common.c:469)=20
> [ 29.628502][ T743] kmem_cache_alloc (mm/slab.h:733 mm/slub.c:3230 mm/slu=
b.c:3238 mm/slub.c:3243)=20
> [ 29.633180][ T743] vm_area_dup (kernel/fork.c:358)=20
> [ 29.637348][ T743] __split_vma (mm/mmap.c:2255)=20
> [ 29.641511][ T743] do_mas_align_munmap (mm/mmap.c:2390)=20
> [ 29.646456][ T743] do_mas_munmap (mm/mmap.c:2508)=20
> [ 29.650881][ T743] __vm_munmap (mm/mmap.c:2764)=20
> [ 29.655133][ T743] __x64_sys_munmap (mm/mmap.c:2786)=20
> [ 29.659660][ T743] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/en=
try/common.c:80)=20
> [ 29.663919][ T743] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_=
64.S:113)=20
> [   29.669633][  T743]
> [   29.671805][  T743] Freed by task 743:
> [ 29.675531][ T743] kasan_save_stack (mm/kasan/common.c:39)=20
> [ 29.680034][ T743] kasan_set_track (mm/kasan/common.c:45)=20
> [ 29.684456][ T743] kasan_set_free_info (mm/kasan/generic.c:372)=20
> [ 29.689218][ T743] __kasan_slab_free (mm/kasan/common.c:368 mm/kasan/com=
mon.c:328 mm/kasan/common.c:374)=20
> [ 29.693898][ T743] kmem_cache_free (mm/slub.c:1754 mm/slub.c:3509 mm/slu=
b.c:3526)=20
> [ 29.698402][ T743] do_mas_align_munmap (mm/mmap.c:2205 mm/mmap.c:2463)=20
> [ 29.703341][ T743] do_mas_munmap (mm/mmap.c:2508)=20
> [ 29.707759][ T743] do_munmap (mm/mmap.c:2519)=20
> [ 29.711747][ T743] move_vma (mm/mremap.c:698)=20
> [ 29.715734][ T743] __do_sys_mremap (mm/mremap.c:1063)=20
> [ 29.720410][ T743] do_syscall_64 (arch/x86/entry/common.c:50 arch/x86/en=
try/common.c:80)=20
> [ 29.724661][ T743] entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_=
64.S:113)=20
> [   29.730386][  T743]
> [   29.732559][  T743] The buggy address belongs to the object at ffff888=
805c9e288
> [   29.732559][  T743]  which belongs to the cache vm_area_struct of size=
 152
> [   29.746661][  T743] The buggy address is located 32 bytes inside of
> [   29.746661][  T743]  152-byte region [ffff888805c9e288, ffff888805c9e3=
20)
> [   29.759656][  T743] The buggy address belongs to the page:
> [   29.765109][  T743] page:0000000051b8737b refcount:1 mapcount:0 mappin=
g:0000000000000000 index:0x0 pfn:0x805c9e
> [   29.775143][  T743] memcg:ffff8887f5a57401
> [   29.779214][  T743] flags: 0x17ffffc0000200(slab|node=3D0|zone=3D2|las=
tcpupid=3D0x1fffff)
> [   29.786830][  T743] raw: 0017ffffc0000200 0000000000000000 dead0000000=
00122 ffff88810021edc0
> [   29.795223][  T743] raw: 0000000000000000 0000000080120012 00000001fff=
fffff ffff8887f5a57401
> [   29.803632][  T743] page dumped because: kasan: bad access detected
> [   29.809864][  T743]
> [   29.812037][  T743] Memory state around the buggy address:
> [   29.817491][  T743]  ffff888805c9e180: fc fc fc fc fc fc fa fb fb fb f=
b fb fb fb fb fb
> [   29.825364][  T743]  ffff888805c9e200: fb fb fb fb fb fb fb fb fb fc f=
c fc fc fc fc fc
> [   29.833238][  T743] >ffff888805c9e280: fc fa fb fb fb fb fb fb fb fb f=
b fb fb fb fb fb
> [   29.841107][  T743]                                   ^
> [   29.846300][  T743]  ffff888805c9e300: fb fb fb fb fc fc fc fc fc fc f=
c fc fa fb fb fb
> [   29.854169][  T743]  ffff888805c9e380: fb fb fb fb fb fb fb fb fb fb f=
b fb fb fb fb fc
> [   29.862040][  T743] =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> [   29.869911][  T743] Disabling lock debugging due to kernel taint
> [   29.875935][  T743] general protection fault, probably for non-canonic=
al address 0xdffffc0000000004: 0000 [#1] SMP KASAN PTI
> [   29.887123][  T743] KASAN: null-ptr-deref in range [0x0000000000000020=
-0x0000000000000027]
> [   29.895356][  T743] CPU: 3 PID: 743 Comm: python3.7 Tainted: G    B   =
          5.17.0-rc4-00070-g82e080f31808 #1
> [   29.905567][  T743] Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIO=
S 1.8.1 12/05/2017
> [ 29.913630][ T743] RIP: 0010:move_vma (mm/mremap.c:716)=20
> [ 29.918398][ T743] Code: 3c 02 00 0f 85 88 06 00 00 48 8b 73 08 4c 89 e7=
 e8 d6 6c fe ff 48 ba 00 00 00 00 00 fc ff df 48 8d 78 20 48 89 f9 48 c1 e9=
 03 <80> 3c 11 00 0f 85 4b 06 00 00 48 81 48 20 00 00 10 00 eb 03 4c 63
> All code
> =3D=3D=3D=3D=3D=3D=3D=3D
>    0:	3c 02                	cmp    $0x2,%al
>    2:	00 0f                	add    %cl,(%rdi)
>    4:	85 88 06 00 00 48    	test   %ecx,0x48000006(%rax)
>    a:	8b 73 08             	mov    0x8(%rbx),%esi
>    d:	4c 89 e7             	mov    %r12,%rdi
>   10:	e8 d6 6c fe ff       	callq  0xfffffffffffe6ceb
>   15:	48 ba 00 00 00 00 00 	movabs $0xdffffc0000000000,%rdx
>   1c:	fc ff df=20
>   1f:	48 8d 78 20          	lea    0x20(%rax),%rdi
>   23:	48 89 f9             	mov    %rdi,%rcx
>   26:	48 c1 e9 03          	shr    $0x3,%rcx
>   2a:*	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)		<-- trapping inst=
ruction
>   2e:	0f 85 4b 06 00 00    	jne    0x67f
>   34:	48 81 48 20 00 00 10 	orq    $0x100000,0x20(%rax)
>   3b:	00=20
>   3c:	eb 03                	jmp    0x41
>   3e:	4c                   	rex.WR
>   3f:	63                   	.byte 0x63
>=20
> Code starting with the faulting instruction
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>    0:	80 3c 11 00          	cmpb   $0x0,(%rcx,%rdx,1)
>    4:	0f 85 4b 06 00 00    	jne    0x655
>    a:	48 81 48 20 00 00 10 	orq    $0x100000,0x20(%rax)
>   11:	00=20
>   12:	eb 03                	jmp    0x17
>   14:	4c                   	rex.WR
>   15:	63                   	.byte 0x63
>=20
>=20
> To reproduce:
>=20
>         git clone https://github.com/intel/lkp-tests.git
>         cd lkp-tests
>         sudo bin/lkp install job.yaml           # job file is attached in=
 this email
>         bin/lkp split-job --compatible job.yaml # generate the yaml file =
for lkp run
>         sudo bin/lkp run generated-yaml-file
>=20
>         # if come across any failure that blocks the test,
>         # please remove ~/.lkp and /lkp dir to run from a clean state.
>=20
>=20
>=20
> ---
> 0DAY/LKP+ Test Infrastructure                   Open Source Technology Ce=
nter
> https://lists.01.org/hyperkitty/list/lkp@lists.01.org       Intel Corpora=
tion
>=20
> Thanks,
> Oliver Sang
>=20

> #
> # Automatically generated file; DO NOT EDIT.
> # Linux/x86_64 5.17.0-rc4 Kernel Configuration
> #
> CONFIG_CC_VERSION_TEXT=3D"gcc-9 (Debian 9.3.0-22) 9.3.0"
> CONFIG_CC_IS_GCC=3Dy
> CONFIG_GCC_VERSION=3D90300
> CONFIG_CLANG_VERSION=3D0
> CONFIG_AS_IS_GNU=3Dy
> CONFIG_AS_VERSION=3D23502
> CONFIG_LD_IS_BFD=3Dy
> CONFIG_LD_VERSION=3D23502
> CONFIG_LLD_VERSION=3D0
> CONFIG_CC_CAN_LINK=3Dy
> CONFIG_CC_CAN_LINK_STATIC=3Dy
> CONFIG_CC_HAS_ASM_GOTO=3Dy
> CONFIG_CC_HAS_ASM_INLINE=3Dy
> CONFIG_CC_HAS_NO_PROFILE_FN_ATTR=3Dy
> CONFIG_CONSTRUCTORS=3Dy
> CONFIG_IRQ_WORK=3Dy
> CONFIG_BUILDTIME_TABLE_SORT=3Dy
> CONFIG_THREAD_INFO_IN_TASK=3Dy
>=20
> #
> # General setup
> #
> CONFIG_INIT_ENV_ARG_LIMIT=3D32
> # CONFIG_COMPILE_TEST is not set
> # CONFIG_WERROR is not set
> CONFIG_LOCALVERSION=3D""
> CONFIG_LOCALVERSION_AUTO=3Dy
> CONFIG_BUILD_SALT=3D""
> CONFIG_HAVE_KERNEL_GZIP=3Dy
> CONFIG_HAVE_KERNEL_BZIP2=3Dy
> CONFIG_HAVE_KERNEL_LZMA=3Dy
> CONFIG_HAVE_KERNEL_XZ=3Dy
> CONFIG_HAVE_KERNEL_LZO=3Dy
> CONFIG_HAVE_KERNEL_LZ4=3Dy
> CONFIG_HAVE_KERNEL_ZSTD=3Dy
> CONFIG_KERNEL_GZIP=3Dy
> # CONFIG_KERNEL_BZIP2 is not set
> # CONFIG_KERNEL_LZMA is not set
> # CONFIG_KERNEL_XZ is not set
> # CONFIG_KERNEL_LZO is not set
> # CONFIG_KERNEL_LZ4 is not set
> # CONFIG_KERNEL_ZSTD is not set
> CONFIG_DEFAULT_INIT=3D""
> CONFIG_DEFAULT_HOSTNAME=3D"(none)"
> CONFIG_SWAP=3Dy
> CONFIG_SYSVIPC=3Dy
> CONFIG_SYSVIPC_SYSCTL=3Dy
> CONFIG_POSIX_MQUEUE=3Dy
> CONFIG_POSIX_MQUEUE_SYSCTL=3Dy
> # CONFIG_WATCH_QUEUE is not set
> CONFIG_CROSS_MEMORY_ATTACH=3Dy
> # CONFIG_USELIB is not set
> CONFIG_AUDIT=3Dy
> CONFIG_HAVE_ARCH_AUDITSYSCALL=3Dy
> CONFIG_AUDITSYSCALL=3Dy
>=20
> #
> # IRQ subsystem
> #
> CONFIG_GENERIC_IRQ_PROBE=3Dy
> CONFIG_GENERIC_IRQ_SHOW=3Dy
> CONFIG_GENERIC_IRQ_EFFECTIVE_AFF_MASK=3Dy
> CONFIG_GENERIC_PENDING_IRQ=3Dy
> CONFIG_GENERIC_IRQ_MIGRATION=3Dy
> CONFIG_GENERIC_IRQ_INJECTION=3Dy
> CONFIG_HARDIRQS_SW_RESEND=3Dy
> CONFIG_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_DOMAIN_HIERARCHY=3Dy
> CONFIG_GENERIC_MSI_IRQ=3Dy
> CONFIG_GENERIC_MSI_IRQ_DOMAIN=3Dy
> CONFIG_IRQ_MSI_IOMMU=3Dy
> CONFIG_GENERIC_IRQ_MATRIX_ALLOCATOR=3Dy
> CONFIG_GENERIC_IRQ_RESERVATION_MODE=3Dy
> CONFIG_IRQ_FORCED_THREADING=3Dy
> CONFIG_SPARSE_IRQ=3Dy
> # CONFIG_GENERIC_IRQ_DEBUGFS is not set
> # end of IRQ subsystem
>=20
> CONFIG_CLOCKSOURCE_WATCHDOG=3Dy
> CONFIG_ARCH_CLOCKSOURCE_INIT=3Dy
> CONFIG_CLOCKSOURCE_VALIDATE_LAST_CYCLE=3Dy
> CONFIG_GENERIC_TIME_VSYSCALL=3Dy
> CONFIG_GENERIC_CLOCKEVENTS=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_BROADCAST=3Dy
> CONFIG_GENERIC_CLOCKEVENTS_MIN_ADJUST=3Dy
> CONFIG_GENERIC_CMOS_UPDATE=3Dy
> CONFIG_HAVE_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_POSIX_CPU_TIMERS_TASK_WORK=3Dy
> CONFIG_TIME_KUNIT_TEST=3Dm
>=20
> #
> # Timers subsystem
> #
> CONFIG_TICK_ONESHOT=3Dy
> CONFIG_NO_HZ_COMMON=3Dy
> # CONFIG_HZ_PERIODIC is not set
> # CONFIG_NO_HZ_IDLE is not set
> CONFIG_NO_HZ_FULL=3Dy
> CONFIG_CONTEXT_TRACKING=3Dy
> # CONFIG_CONTEXT_TRACKING_FORCE is not set
> CONFIG_NO_HZ=3Dy
> CONFIG_HIGH_RES_TIMERS=3Dy
> # end of Timers subsystem
>=20
> CONFIG_BPF=3Dy
> CONFIG_HAVE_EBPF_JIT=3Dy
> CONFIG_ARCH_WANT_DEFAULT_BPF_JIT=3Dy
>=20
> #
> # BPF subsystem
> #
> CONFIG_BPF_SYSCALL=3Dy
> CONFIG_BPF_JIT=3Dy
> CONFIG_BPF_JIT_ALWAYS_ON=3Dy
> CONFIG_BPF_JIT_DEFAULT_ON=3Dy
> CONFIG_BPF_UNPRIV_DEFAULT_OFF=3Dy
> # CONFIG_BPF_PRELOAD is not set
> # CONFIG_BPF_LSM is not set
> # end of BPF subsystem
>=20
> CONFIG_PREEMPT_VOLUNTARY_BUILD=3Dy
> # CONFIG_PREEMPT_NONE is not set
> CONFIG_PREEMPT_VOLUNTARY=3Dy
> # CONFIG_PREEMPT is not set
> CONFIG_PREEMPT_COUNT=3Dy
> # CONFIG_PREEMPT_DYNAMIC is not set
> # CONFIG_SCHED_CORE is not set
>=20
> #
> # CPU/Task time and stats accounting
> #
> CONFIG_VIRT_CPU_ACCOUNTING=3Dy
> CONFIG_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_SCHED_AVG_IRQ=3Dy
> CONFIG_BSD_PROCESS_ACCT=3Dy
> CONFIG_BSD_PROCESS_ACCT_V3=3Dy
> CONFIG_TASKSTATS=3Dy
> CONFIG_TASK_DELAY_ACCT=3Dy
> CONFIG_TASK_XACCT=3Dy
> CONFIG_TASK_IO_ACCOUNTING=3Dy
> # CONFIG_PSI is not set
> # end of CPU/Task time and stats accounting
>=20
> CONFIG_CPU_ISOLATION=3Dy
>=20
> #
> # RCU Subsystem
> #
> CONFIG_TREE_RCU=3Dy
> # CONFIG_RCU_EXPERT is not set
> CONFIG_SRCU=3Dy
> CONFIG_TREE_SRCU=3Dy
> CONFIG_TASKS_RCU_GENERIC=3Dy
> CONFIG_TASKS_RCU=3Dy
> CONFIG_TASKS_RUDE_RCU=3Dy
> CONFIG_TASKS_TRACE_RCU=3Dy
> CONFIG_RCU_STALL_COMMON=3Dy
> CONFIG_RCU_NEED_SEGCBLIST=3Dy
> CONFIG_RCU_NOCB_CPU=3Dy
> # end of RCU Subsystem
>=20
> CONFIG_BUILD_BIN2C=3Dy
> CONFIG_IKCONFIG=3Dy
> CONFIG_IKCONFIG_PROC=3Dy
> # CONFIG_IKHEADERS is not set
> CONFIG_LOG_BUF_SHIFT=3D20
> CONFIG_LOG_CPU_MAX_BUF_SHIFT=3D12
> CONFIG_PRINTK_SAFE_LOG_BUF_SHIFT=3D13
> # CONFIG_PRINTK_INDEX is not set
> CONFIG_HAVE_UNSTABLE_SCHED_CLOCK=3Dy
>=20
> #
> # Scheduler features
> #
> # CONFIG_UCLAMP_TASK is not set
> # end of Scheduler features
>=20
> CONFIG_ARCH_SUPPORTS_NUMA_BALANCING=3Dy
> CONFIG_ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH=3Dy
> CONFIG_CC_HAS_INT128=3Dy
> CONFIG_CC_IMPLICIT_FALLTHROUGH=3D"-Wimplicit-fallthrough=3D5"
> CONFIG_ARCH_SUPPORTS_INT128=3Dy
> CONFIG_NUMA_BALANCING=3Dy
> CONFIG_NUMA_BALANCING_DEFAULT_ENABLED=3Dy
> CONFIG_CGROUPS=3Dy
> CONFIG_PAGE_COUNTER=3Dy
> CONFIG_MEMCG=3Dy
> CONFIG_MEMCG_SWAP=3Dy
> CONFIG_MEMCG_KMEM=3Dy
> CONFIG_BLK_CGROUP=3Dy
> CONFIG_CGROUP_WRITEBACK=3Dy
> CONFIG_CGROUP_SCHED=3Dy
> CONFIG_FAIR_GROUP_SCHED=3Dy
> CONFIG_CFS_BANDWIDTH=3Dy
> CONFIG_RT_GROUP_SCHED=3Dy
> CONFIG_CGROUP_PIDS=3Dy
> CONFIG_CGROUP_RDMA=3Dy
> CONFIG_CGROUP_FREEZER=3Dy
> CONFIG_CGROUP_HUGETLB=3Dy
> CONFIG_CPUSETS=3Dy
> CONFIG_PROC_PID_CPUSET=3Dy
> CONFIG_CGROUP_DEVICE=3Dy
> CONFIG_CGROUP_CPUACCT=3Dy
> CONFIG_CGROUP_PERF=3Dy
> CONFIG_CGROUP_BPF=3Dy
> # CONFIG_CGROUP_MISC is not set
> # CONFIG_CGROUP_DEBUG is not set
> CONFIG_SOCK_CGROUP_DATA=3Dy
> CONFIG_NAMESPACES=3Dy
> CONFIG_UTS_NS=3Dy
> CONFIG_TIME_NS=3Dy
> CONFIG_IPC_NS=3Dy
> CONFIG_USER_NS=3Dy
> CONFIG_PID_NS=3Dy
> CONFIG_NET_NS=3Dy
> CONFIG_CHECKPOINT_RESTORE=3Dy
> CONFIG_SCHED_AUTOGROUP=3Dy
> # CONFIG_SYSFS_DEPRECATED is not set
> CONFIG_RELAY=3Dy
> CONFIG_BLK_DEV_INITRD=3Dy
> CONFIG_INITRAMFS_SOURCE=3D""
> CONFIG_RD_GZIP=3Dy
> CONFIG_RD_BZIP2=3Dy
> CONFIG_RD_LZMA=3Dy
> CONFIG_RD_XZ=3Dy
> CONFIG_RD_LZO=3Dy
> CONFIG_RD_LZ4=3Dy
> CONFIG_RD_ZSTD=3Dy
> # CONFIG_BOOT_CONFIG is not set
> CONFIG_CC_OPTIMIZE_FOR_PERFORMANCE=3Dy
> # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
> CONFIG_LD_ORPHAN_WARN=3Dy
> CONFIG_SYSCTL=3Dy
> CONFIG_HAVE_UID16=3Dy
> CONFIG_SYSCTL_EXCEPTION_TRACE=3Dy
> CONFIG_HAVE_PCSPKR_PLATFORM=3Dy
> # CONFIG_EXPERT is not set
> CONFIG_UID16=3Dy
> CONFIG_MULTIUSER=3Dy
> CONFIG_SGETMASK_SYSCALL=3Dy
> CONFIG_SYSFS_SYSCALL=3Dy
> CONFIG_FHANDLE=3Dy
> CONFIG_POSIX_TIMERS=3Dy
> CONFIG_PRINTK=3Dy
> CONFIG_BUG=3Dy
> CONFIG_ELF_CORE=3Dy
> CONFIG_PCSPKR_PLATFORM=3Dy
> CONFIG_BASE_FULL=3Dy
> CONFIG_FUTEX=3Dy
> CONFIG_FUTEX_PI=3Dy
> CONFIG_EPOLL=3Dy
> CONFIG_SIGNALFD=3Dy
> CONFIG_TIMERFD=3Dy
> CONFIG_EVENTFD=3Dy
> CONFIG_SHMEM=3Dy
> CONFIG_AIO=3Dy
> CONFIG_IO_URING=3Dy
> CONFIG_ADVISE_SYSCALLS=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_WP=3Dy
> CONFIG_HAVE_ARCH_USERFAULTFD_MINOR=3Dy
> CONFIG_MEMBARRIER=3Dy
> CONFIG_KALLSYMS=3Dy
> CONFIG_KALLSYMS_ALL=3Dy
> CONFIG_KALLSYMS_ABSOLUTE_PERCPU=3Dy
> CONFIG_KALLSYMS_BASE_RELATIVE=3Dy
> CONFIG_USERFAULTFD=3Dy
> CONFIG_ARCH_HAS_MEMBARRIER_SYNC_CORE=3Dy
> CONFIG_KCMP=3Dy
> CONFIG_RSEQ=3Dy
> # CONFIG_EMBEDDED is not set
> CONFIG_HAVE_PERF_EVENTS=3Dy
> CONFIG_GUEST_PERF_EVENTS=3Dy
>=20
> #
> # Kernel Performance Events And Counters
> #
> CONFIG_PERF_EVENTS=3Dy
> # CONFIG_DEBUG_PERF_USE_VMALLOC is not set
> # end of Kernel Performance Events And Counters
>=20
> CONFIG_VM_EVENT_COUNTERS=3Dy
> CONFIG_SLUB_DEBUG=3Dy
> # CONFIG_COMPAT_BRK is not set
> # CONFIG_SLAB is not set
> CONFIG_SLUB=3Dy
> CONFIG_SLAB_MERGE_DEFAULT=3Dy
> CONFIG_SLAB_FREELIST_RANDOM=3Dy
> # CONFIG_SLAB_FREELIST_HARDENED is not set
> CONFIG_SHUFFLE_PAGE_ALLOCATOR=3Dy
> CONFIG_SLUB_CPU_PARTIAL=3Dy
> CONFIG_SYSTEM_DATA_VERIFICATION=3Dy
> CONFIG_PROFILING=3Dy
> CONFIG_TRACEPOINTS=3Dy
> # end of General setup
>=20
> CONFIG_64BIT=3Dy
> CONFIG_X86_64=3Dy
> CONFIG_X86=3Dy
> CONFIG_INSTRUCTION_DECODER=3Dy
> CONFIG_OUTPUT_FORMAT=3D"elf64-x86-64"
> CONFIG_LOCKDEP_SUPPORT=3Dy
> CONFIG_STACKTRACE_SUPPORT=3Dy
> CONFIG_MMU=3Dy
> CONFIG_ARCH_MMAP_RND_BITS_MIN=3D28
> CONFIG_ARCH_MMAP_RND_BITS_MAX=3D32
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MIN=3D8
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS_MAX=3D16
> CONFIG_GENERIC_ISA_DMA=3Dy
> CONFIG_GENERIC_BUG=3Dy
> CONFIG_GENERIC_BUG_RELATIVE_POINTERS=3Dy
> CONFIG_ARCH_MAY_HAVE_PC_FDC=3Dy
> CONFIG_GENERIC_CALIBRATE_DELAY=3Dy
> CONFIG_ARCH_HAS_CPU_RELAX=3Dy
> CONFIG_ARCH_HAS_FILTER_PGPROT=3Dy
> CONFIG_ARCH_HIBERNATION_POSSIBLE=3Dy
> CONFIG_ARCH_NR_GPIO=3D1024
> CONFIG_ARCH_SUSPEND_POSSIBLE=3Dy
> CONFIG_ARCH_WANT_GENERAL_HUGETLB=3Dy
> CONFIG_AUDIT_ARCH=3Dy
> CONFIG_KASAN_SHADOW_OFFSET=3D0xdffffc0000000000
> CONFIG_HAVE_INTEL_TXT=3Dy
> CONFIG_X86_64_SMP=3Dy
> CONFIG_ARCH_SUPPORTS_UPROBES=3Dy
> CONFIG_FIX_EARLYCON_MEM=3Dy
> CONFIG_PGTABLE_LEVELS=3D5
> CONFIG_CC_HAS_SANE_STACKPROTECTOR=3Dy
>=20
> #
> # Processor type and features
> #
> CONFIG_SMP=3Dy
> CONFIG_X86_FEATURE_NAMES=3Dy
> CONFIG_X86_X2APIC=3Dy
> CONFIG_X86_MPPARSE=3Dy
> # CONFIG_GOLDFISH is not set
> CONFIG_RETPOLINE=3Dy
> # CONFIG_X86_CPU_RESCTRL is not set
> CONFIG_X86_EXTENDED_PLATFORM=3Dy
> # CONFIG_X86_NUMACHIP is not set
> # CONFIG_X86_VSMP is not set
> CONFIG_X86_UV=3Dy
> # CONFIG_X86_GOLDFISH is not set
> # CONFIG_X86_INTEL_MID is not set
> CONFIG_X86_INTEL_LPSS=3Dy
> # CONFIG_X86_AMD_PLATFORM_DEVICE is not set
> CONFIG_IOSF_MBI=3Dy
> # CONFIG_IOSF_MBI_DEBUG is not set
> CONFIG_X86_SUPPORTS_MEMORY_FAILURE=3Dy
> # CONFIG_SCHED_OMIT_FRAME_POINTER is not set
> CONFIG_HYPERVISOR_GUEST=3Dy
> CONFIG_PARAVIRT=3Dy
> # CONFIG_PARAVIRT_DEBUG is not set
> CONFIG_PARAVIRT_SPINLOCKS=3Dy
> CONFIG_X86_HV_CALLBACK_VECTOR=3Dy
> # CONFIG_XEN is not set
> CONFIG_KVM_GUEST=3Dy
> CONFIG_ARCH_CPUIDLE_HALTPOLL=3Dy
> # CONFIG_PVH is not set
> CONFIG_PARAVIRT_TIME_ACCOUNTING=3Dy
> CONFIG_PARAVIRT_CLOCK=3Dy
> # CONFIG_JAILHOUSE_GUEST is not set
> # CONFIG_ACRN_GUEST is not set
> # CONFIG_MK8 is not set
> # CONFIG_MPSC is not set
> # CONFIG_MCORE2 is not set
> # CONFIG_MATOM is not set
> CONFIG_GENERIC_CPU=3Dy
> CONFIG_X86_INTERNODE_CACHE_SHIFT=3D6
> CONFIG_X86_L1_CACHE_SHIFT=3D6
> CONFIG_X86_TSC=3Dy
> CONFIG_X86_CMPXCHG64=3Dy
> CONFIG_X86_CMOV=3Dy
> CONFIG_X86_MINIMUM_CPU_FAMILY=3D64
> CONFIG_X86_DEBUGCTLMSR=3Dy
> CONFIG_IA32_FEAT_CTL=3Dy
> CONFIG_X86_VMX_FEATURE_NAMES=3Dy
> CONFIG_CPU_SUP_INTEL=3Dy
> CONFIG_CPU_SUP_AMD=3Dy
> CONFIG_CPU_SUP_HYGON=3Dy
> CONFIG_CPU_SUP_CENTAUR=3Dy
> CONFIG_CPU_SUP_ZHAOXIN=3Dy
> CONFIG_HPET_TIMER=3Dy
> CONFIG_HPET_EMULATE_RTC=3Dy
> CONFIG_DMI=3Dy
> # CONFIG_GART_IOMMU is not set
> CONFIG_MAXSMP=3Dy
> CONFIG_NR_CPUS_RANGE_BEGIN=3D8192
> CONFIG_NR_CPUS_RANGE_END=3D8192
> CONFIG_NR_CPUS_DEFAULT=3D8192
> CONFIG_NR_CPUS=3D8192
> CONFIG_SCHED_CLUSTER=3Dy
> CONFIG_SCHED_SMT=3Dy
> CONFIG_SCHED_MC=3Dy
> CONFIG_SCHED_MC_PRIO=3Dy
> CONFIG_X86_LOCAL_APIC=3Dy
> CONFIG_X86_IO_APIC=3Dy
> CONFIG_X86_REROUTE_FOR_BROKEN_BOOT_IRQS=3Dy
> CONFIG_X86_MCE=3Dy
> CONFIG_X86_MCELOG_LEGACY=3Dy
> CONFIG_X86_MCE_INTEL=3Dy
> # CONFIG_X86_MCE_AMD is not set
> CONFIG_X86_MCE_THRESHOLD=3Dy
> CONFIG_X86_MCE_INJECT=3Dm
>=20
> #
> # Performance monitoring
> #
> CONFIG_PERF_EVENTS_INTEL_UNCORE=3Dm
> CONFIG_PERF_EVENTS_INTEL_RAPL=3Dm
> CONFIG_PERF_EVENTS_INTEL_CSTATE=3Dm
> # CONFIG_PERF_EVENTS_AMD_POWER is not set
> CONFIG_PERF_EVENTS_AMD_UNCORE=3Dy
> # end of Performance monitoring
>=20
> CONFIG_X86_16BIT=3Dy
> CONFIG_X86_ESPFIX64=3Dy
> CONFIG_X86_VSYSCALL_EMULATION=3Dy
> CONFIG_X86_IOPL_IOPERM=3Dy
> CONFIG_I8K=3Dm
> CONFIG_MICROCODE=3Dy
> CONFIG_MICROCODE_INTEL=3Dy
> # CONFIG_MICROCODE_AMD is not set
> CONFIG_MICROCODE_OLD_INTERFACE=3Dy
> CONFIG_X86_MSR=3Dy
> CONFIG_X86_CPUID=3Dy
> CONFIG_X86_5LEVEL=3Dy
> CONFIG_X86_DIRECT_GBPAGES=3Dy
> # CONFIG_X86_CPA_STATISTICS is not set
> # CONFIG_AMD_MEM_ENCRYPT is not set
> CONFIG_NUMA=3Dy
> # CONFIG_AMD_NUMA is not set
> CONFIG_X86_64_ACPI_NUMA=3Dy
> CONFIG_NUMA_EMU=3Dy
> CONFIG_NODES_SHIFT=3D10
> CONFIG_ARCH_SPARSEMEM_ENABLE=3Dy
> CONFIG_ARCH_SPARSEMEM_DEFAULT=3Dy
> CONFIG_ARCH_SELECT_MEMORY_MODEL=3Dy
> # CONFIG_ARCH_MEMORY_PROBE is not set
> CONFIG_ARCH_PROC_KCORE_TEXT=3Dy
> CONFIG_ILLEGAL_POINTER_VALUE=3D0xdead000000000000
> CONFIG_X86_PMEM_LEGACY_DEVICE=3Dy
> CONFIG_X86_PMEM_LEGACY=3Dm
> CONFIG_X86_CHECK_BIOS_CORRUPTION=3Dy
> # CONFIG_X86_BOOTPARAM_MEMORY_CORRUPTION_CHECK is not set
> CONFIG_MTRR=3Dy
> CONFIG_MTRR_SANITIZER=3Dy
> CONFIG_MTRR_SANITIZER_ENABLE_DEFAULT=3D1
> CONFIG_MTRR_SANITIZER_SPARE_REG_NR_DEFAULT=3D1
> CONFIG_X86_PAT=3Dy
> CONFIG_ARCH_USES_PG_UNCACHED=3Dy
> CONFIG_ARCH_RANDOM=3Dy
> CONFIG_X86_SMAP=3Dy
> CONFIG_X86_UMIP=3Dy
> CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS=3Dy
> CONFIG_X86_INTEL_TSX_MODE_OFF=3Dy
> # CONFIG_X86_INTEL_TSX_MODE_ON is not set
> # CONFIG_X86_INTEL_TSX_MODE_AUTO is not set
> # CONFIG_X86_SGX is not set
> CONFIG_EFI=3Dy
> CONFIG_EFI_STUB=3Dy
> CONFIG_EFI_MIXED=3Dy
> # CONFIG_HZ_100 is not set
> # CONFIG_HZ_250 is not set
> # CONFIG_HZ_300 is not set
> CONFIG_HZ_1000=3Dy
> CONFIG_HZ=3D1000
> CONFIG_SCHED_HRTICK=3Dy
> CONFIG_KEXEC=3Dy
> CONFIG_KEXEC_FILE=3Dy
> CONFIG_ARCH_HAS_KEXEC_PURGATORY=3Dy
> # CONFIG_KEXEC_SIG is not set
> CONFIG_CRASH_DUMP=3Dy
> CONFIG_KEXEC_JUMP=3Dy
> CONFIG_PHYSICAL_START=3D0x1000000
> CONFIG_RELOCATABLE=3Dy
> CONFIG_RANDOMIZE_BASE=3Dy
> CONFIG_X86_NEED_RELOCS=3Dy
> CONFIG_PHYSICAL_ALIGN=3D0x200000
> CONFIG_DYNAMIC_MEMORY_LAYOUT=3Dy
> CONFIG_RANDOMIZE_MEMORY=3Dy
> CONFIG_RANDOMIZE_MEMORY_PHYSICAL_PADDING=3D0xa
> CONFIG_HOTPLUG_CPU=3Dy
> CONFIG_BOOTPARAM_HOTPLUG_CPU0=3Dy
> # CONFIG_DEBUG_HOTPLUG_CPU0 is not set
> # CONFIG_COMPAT_VDSO is not set
> CONFIG_LEGACY_VSYSCALL_EMULATE=3Dy
> # CONFIG_LEGACY_VSYSCALL_XONLY is not set
> # CONFIG_LEGACY_VSYSCALL_NONE is not set
> # CONFIG_CMDLINE_BOOL is not set
> CONFIG_MODIFY_LDT_SYSCALL=3Dy
> # CONFIG_STRICT_SIGALTSTACK_SIZE is not set
> CONFIG_HAVE_LIVEPATCH=3Dy
> CONFIG_LIVEPATCH=3Dy
> # end of Processor type and features
>=20
> CONFIG_ARCH_HAS_ADD_PAGES=3Dy
> CONFIG_ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE=3Dy
>=20
> #
> # Power management and ACPI options
> #
> CONFIG_ARCH_HIBERNATION_HEADER=3Dy
> CONFIG_SUSPEND=3Dy
> CONFIG_SUSPEND_FREEZER=3Dy
> CONFIG_HIBERNATE_CALLBACKS=3Dy
> CONFIG_HIBERNATION=3Dy
> CONFIG_HIBERNATION_SNAPSHOT_DEV=3Dy
> CONFIG_PM_STD_PARTITION=3D""
> CONFIG_PM_SLEEP=3Dy
> CONFIG_PM_SLEEP_SMP=3Dy
> # CONFIG_PM_AUTOSLEEP is not set
> # CONFIG_PM_WAKELOCKS is not set
> CONFIG_PM=3Dy
> CONFIG_PM_DEBUG=3Dy
> # CONFIG_PM_ADVANCED_DEBUG is not set
> # CONFIG_PM_TEST_SUSPEND is not set
> CONFIG_PM_SLEEP_DEBUG=3Dy
> # CONFIG_PM_TRACE_RTC is not set
> CONFIG_PM_CLK=3Dy
> # CONFIG_WQ_POWER_EFFICIENT_DEFAULT is not set
> # CONFIG_ENERGY_MODEL is not set
> CONFIG_ARCH_SUPPORTS_ACPI=3Dy
> CONFIG_ACPI=3Dy
> CONFIG_ACPI_LEGACY_TABLES_LOOKUP=3Dy
> CONFIG_ARCH_MIGHT_HAVE_ACPI_PDC=3Dy
> CONFIG_ACPI_SYSTEM_POWER_STATES_SUPPORT=3Dy
> # CONFIG_ACPI_DEBUGGER is not set
> CONFIG_ACPI_SPCR_TABLE=3Dy
> # CONFIG_ACPI_FPDT is not set
> CONFIG_ACPI_LPIT=3Dy
> CONFIG_ACPI_SLEEP=3Dy
> CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=3Dy
> CONFIG_ACPI_EC_DEBUGFS=3Dm
> CONFIG_ACPI_AC=3Dy
> CONFIG_ACPI_BATTERY=3Dy
> CONFIG_ACPI_BUTTON=3Dy
> CONFIG_ACPI_VIDEO=3Dm
> CONFIG_ACPI_FAN=3Dy
> CONFIG_ACPI_TAD=3Dm
> CONFIG_ACPI_DOCK=3Dy
> CONFIG_ACPI_CPU_FREQ_PSS=3Dy
> CONFIG_ACPI_PROCESSOR_CSTATE=3Dy
> CONFIG_ACPI_PROCESSOR_IDLE=3Dy
> CONFIG_ACPI_CPPC_LIB=3Dy
> CONFIG_ACPI_PROCESSOR=3Dy
> CONFIG_ACPI_IPMI=3Dm
> CONFIG_ACPI_HOTPLUG_CPU=3Dy
> CONFIG_ACPI_PROCESSOR_AGGREGATOR=3Dm
> CONFIG_ACPI_THERMAL=3Dy
> CONFIG_ACPI_PLATFORM_PROFILE=3Dm
> CONFIG_ARCH_HAS_ACPI_TABLE_UPGRADE=3Dy
> CONFIG_ACPI_TABLE_UPGRADE=3Dy
> # CONFIG_ACPI_DEBUG is not set
> CONFIG_ACPI_PCI_SLOT=3Dy
> CONFIG_ACPI_CONTAINER=3Dy
> CONFIG_ACPI_HOTPLUG_MEMORY=3Dy
> CONFIG_ACPI_HOTPLUG_IOAPIC=3Dy
> CONFIG_ACPI_SBS=3Dm
> CONFIG_ACPI_HED=3Dy
> # CONFIG_ACPI_CUSTOM_METHOD is not set
> CONFIG_ACPI_BGRT=3Dy
> CONFIG_ACPI_NFIT=3Dm
> # CONFIG_NFIT_SECURITY_DEBUG is not set
> CONFIG_ACPI_NUMA=3Dy
> # CONFIG_ACPI_HMAT is not set
> CONFIG_HAVE_ACPI_APEI=3Dy
> CONFIG_HAVE_ACPI_APEI_NMI=3Dy
> CONFIG_ACPI_APEI=3Dy
> CONFIG_ACPI_APEI_GHES=3Dy
> CONFIG_ACPI_APEI_PCIEAER=3Dy
> CONFIG_ACPI_APEI_MEMORY_FAILURE=3Dy
> CONFIG_ACPI_APEI_EINJ=3Dm
> # CONFIG_ACPI_APEI_ERST_DEBUG is not set
> # CONFIG_ACPI_DPTF is not set
> CONFIG_ACPI_WATCHDOG=3Dy
> CONFIG_ACPI_EXTLOG=3Dm
> CONFIG_ACPI_ADXL=3Dy
> # CONFIG_ACPI_CONFIGFS is not set
> # CONFIG_ACPI_PFRUT is not set
> CONFIG_ACPI_PCC=3Dy
> CONFIG_PMIC_OPREGION=3Dy
> CONFIG_X86_PM_TIMER=3Dy
> CONFIG_ACPI_PRMT=3Dy
>=20
> #
> # CPU Frequency scaling
> #
> CONFIG_CPU_FREQ=3Dy
> CONFIG_CPU_FREQ_GOV_ATTR_SET=3Dy
> CONFIG_CPU_FREQ_GOV_COMMON=3Dy
> CONFIG_CPU_FREQ_STAT=3Dy
> CONFIG_CPU_FREQ_DEFAULT_GOV_PERFORMANCE=3Dy
> # CONFIG_CPU_FREQ_DEFAULT_GOV_POWERSAVE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_USERSPACE is not set
> # CONFIG_CPU_FREQ_DEFAULT_GOV_SCHEDUTIL is not set
> CONFIG_CPU_FREQ_GOV_PERFORMANCE=3Dy
> CONFIG_CPU_FREQ_GOV_POWERSAVE=3Dy
> CONFIG_CPU_FREQ_GOV_USERSPACE=3Dy
> CONFIG_CPU_FREQ_GOV_ONDEMAND=3Dy
> CONFIG_CPU_FREQ_GOV_CONSERVATIVE=3Dy
> CONFIG_CPU_FREQ_GOV_SCHEDUTIL=3Dy
>=20
> #
> # CPU frequency scaling drivers
> #
> CONFIG_X86_INTEL_PSTATE=3Dy
> # CONFIG_X86_PCC_CPUFREQ is not set
> # CONFIG_X86_AMD_PSTATE is not set
> CONFIG_X86_ACPI_CPUFREQ=3Dm
> CONFIG_X86_ACPI_CPUFREQ_CPB=3Dy
> CONFIG_X86_POWERNOW_K8=3Dm
> # CONFIG_X86_AMD_FREQ_SENSITIVITY is not set
> # CONFIG_X86_SPEEDSTEP_CENTRINO is not set
> CONFIG_X86_P4_CLOCKMOD=3Dm
>=20
> #
> # shared options
> #
> CONFIG_X86_SPEEDSTEP_LIB=3Dm
> # end of CPU Frequency scaling
>=20
> #
> # CPU Idle
> #
> CONFIG_CPU_IDLE=3Dy
> # CONFIG_CPU_IDLE_GOV_LADDER is not set
> CONFIG_CPU_IDLE_GOV_MENU=3Dy
> # CONFIG_CPU_IDLE_GOV_TEO is not set
> # CONFIG_CPU_IDLE_GOV_HALTPOLL is not set
> CONFIG_HALTPOLL_CPUIDLE=3Dy
> # end of CPU Idle
>=20
> CONFIG_INTEL_IDLE=3Dy
> # end of Power management and ACPI options
>=20
> #
> # Bus options (PCI etc.)
> #
> CONFIG_PCI_DIRECT=3Dy
> CONFIG_PCI_MMCONFIG=3Dy
> CONFIG_MMCONF_FAM10H=3Dy
> CONFIG_ISA_DMA_API=3Dy
> CONFIG_AMD_NB=3Dy
> # end of Bus options (PCI etc.)
>=20
> #
> # Binary Emulations
> #
> CONFIG_IA32_EMULATION=3Dy
> # CONFIG_X86_X32 is not set
> CONFIG_COMPAT_32=3Dy
> CONFIG_COMPAT=3Dy
> CONFIG_COMPAT_FOR_U64_ALIGNMENT=3Dy
> CONFIG_SYSVIPC_COMPAT=3Dy
> # end of Binary Emulations
>=20
> CONFIG_HAVE_KVM=3Dy
> CONFIG_HAVE_KVM_PFNCACHE=3Dy
> CONFIG_HAVE_KVM_IRQCHIP=3Dy
> CONFIG_HAVE_KVM_IRQFD=3Dy
> CONFIG_HAVE_KVM_IRQ_ROUTING=3Dy
> CONFIG_HAVE_KVM_DIRTY_RING=3Dy
> CONFIG_HAVE_KVM_EVENTFD=3Dy
> CONFIG_KVM_MMIO=3Dy
> CONFIG_KVM_ASYNC_PF=3Dy
> CONFIG_HAVE_KVM_MSI=3Dy
> CONFIG_HAVE_KVM_CPU_RELAX_INTERCEPT=3Dy
> CONFIG_KVM_VFIO=3Dy
> CONFIG_KVM_GENERIC_DIRTYLOG_READ_PROTECT=3Dy
> CONFIG_KVM_COMPAT=3Dy
> CONFIG_HAVE_KVM_IRQ_BYPASS=3Dy
> CONFIG_HAVE_KVM_NO_POLL=3Dy
> CONFIG_KVM_XFER_TO_GUEST_WORK=3Dy
> CONFIG_HAVE_KVM_PM_NOTIFIER=3Dy
> CONFIG_VIRTUALIZATION=3Dy
> CONFIG_KVM=3Dm
> CONFIG_KVM_INTEL=3Dm
> # CONFIG_KVM_AMD is not set
> # CONFIG_KVM_XEN is not set
> CONFIG_KVM_MMU_AUDIT=3Dy
> CONFIG_AS_AVX512=3Dy
> CONFIG_AS_SHA1_NI=3Dy
> CONFIG_AS_SHA256_NI=3Dy
> CONFIG_AS_TPAUSE=3Dy
>=20
> #
> # General architecture-dependent options
> #
> CONFIG_CRASH_CORE=3Dy
> CONFIG_KEXEC_CORE=3Dy
> CONFIG_HOTPLUG_SMT=3Dy
> CONFIG_GENERIC_ENTRY=3Dy
> CONFIG_KPROBES=3Dy
> CONFIG_JUMP_LABEL=3Dy
> # CONFIG_STATIC_KEYS_SELFTEST is not set
> # CONFIG_STATIC_CALL_SELFTEST is not set
> CONFIG_OPTPROBES=3Dy
> CONFIG_KPROBES_ON_FTRACE=3Dy
> CONFIG_UPROBES=3Dy
> CONFIG_HAVE_EFFICIENT_UNALIGNED_ACCESS=3Dy
> CONFIG_ARCH_USE_BUILTIN_BSWAP=3Dy
> CONFIG_KRETPROBES=3Dy
> CONFIG_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_IOREMAP_PROT=3Dy
> CONFIG_HAVE_KPROBES=3Dy
> CONFIG_HAVE_KRETPROBES=3Dy
> CONFIG_HAVE_OPTPROBES=3Dy
> CONFIG_HAVE_KPROBES_ON_FTRACE=3Dy
> CONFIG_ARCH_CORRECT_STACKTRACE_ON_KRETPROBE=3Dy
> CONFIG_HAVE_FUNCTION_ERROR_INJECTION=3Dy
> CONFIG_HAVE_NMI=3Dy
> CONFIG_TRACE_IRQFLAGS_SUPPORT=3Dy
> CONFIG_HAVE_ARCH_TRACEHOOK=3Dy
> CONFIG_HAVE_DMA_CONTIGUOUS=3Dy
> CONFIG_GENERIC_SMP_IDLE_THREAD=3Dy
> CONFIG_ARCH_HAS_FORTIFY_SOURCE=3Dy
> CONFIG_ARCH_HAS_SET_MEMORY=3Dy
> CONFIG_ARCH_HAS_SET_DIRECT_MAP=3Dy
> CONFIG_HAVE_ARCH_THREAD_STRUCT_WHITELIST=3Dy
> CONFIG_ARCH_WANTS_DYNAMIC_TASK_STRUCT=3Dy
> CONFIG_ARCH_WANTS_NO_INSTR=3Dy
> CONFIG_HAVE_ASM_MODVERSIONS=3Dy
> CONFIG_HAVE_REGS_AND_STACK_ACCESS_API=3Dy
> CONFIG_HAVE_RSEQ=3Dy
> CONFIG_HAVE_FUNCTION_ARG_ACCESS_API=3Dy
> CONFIG_HAVE_HW_BREAKPOINT=3Dy
> CONFIG_HAVE_MIXED_BREAKPOINTS_REGS=3Dy
> CONFIG_HAVE_USER_RETURN_NOTIFIER=3Dy
> CONFIG_HAVE_PERF_EVENTS_NMI=3Dy
> CONFIG_HAVE_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_HAVE_PERF_REGS=3Dy
> CONFIG_HAVE_PERF_USER_STACK_DUMP=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL=3Dy
> CONFIG_HAVE_ARCH_JUMP_LABEL_RELATIVE=3Dy
> CONFIG_MMU_GATHER_TABLE_FREE=3Dy
> CONFIG_MMU_GATHER_RCU_TABLE_FREE=3Dy
> CONFIG_ARCH_HAVE_NMI_SAFE_CMPXCHG=3Dy
> CONFIG_HAVE_ALIGNED_STRUCT_PAGE=3Dy
> CONFIG_HAVE_CMPXCHG_LOCAL=3Dy
> CONFIG_HAVE_CMPXCHG_DOUBLE=3Dy
> CONFIG_ARCH_WANT_COMPAT_IPC_PARSE_VERSION=3Dy
> CONFIG_ARCH_WANT_OLD_COMPAT_IPC=3Dy
> CONFIG_HAVE_ARCH_SECCOMP=3Dy
> CONFIG_HAVE_ARCH_SECCOMP_FILTER=3Dy
> CONFIG_SECCOMP=3Dy
> CONFIG_SECCOMP_FILTER=3Dy
> # CONFIG_SECCOMP_CACHE_DEBUG is not set
> CONFIG_HAVE_ARCH_STACKLEAK=3Dy
> CONFIG_HAVE_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR=3Dy
> CONFIG_STACKPROTECTOR_STRONG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG=3Dy
> CONFIG_ARCH_SUPPORTS_LTO_CLANG_THIN=3Dy
> CONFIG_LTO_NONE=3Dy
> CONFIG_HAVE_ARCH_WITHIN_STACK_FRAMES=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING=3Dy
> CONFIG_HAVE_CONTEXT_TRACKING_OFFSTACK=3Dy
> CONFIG_HAVE_VIRT_CPU_ACCOUNTING_GEN=3Dy
> CONFIG_HAVE_IRQ_TIME_ACCOUNTING=3Dy
> CONFIG_HAVE_MOVE_PUD=3Dy
> CONFIG_HAVE_MOVE_PMD=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD=3Dy
> CONFIG_HAVE_ARCH_HUGE_VMAP=3Dy
> CONFIG_ARCH_WANT_HUGE_PMD_SHARE=3Dy
> CONFIG_HAVE_ARCH_SOFT_DIRTY=3Dy
> CONFIG_HAVE_MOD_ARCH_SPECIFIC=3Dy
> CONFIG_MODULES_USE_ELF_RELA=3Dy
> CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK=3Dy
> CONFIG_HAVE_SOFTIRQ_ON_OWN_STACK=3Dy
> CONFIG_ARCH_HAS_ELF_RANDOMIZE=3Dy
> CONFIG_HAVE_ARCH_MMAP_RND_BITS=3Dy
> CONFIG_HAVE_EXIT_THREAD=3Dy
> CONFIG_ARCH_MMAP_RND_BITS=3D28
> CONFIG_HAVE_ARCH_MMAP_RND_COMPAT_BITS=3Dy
> CONFIG_ARCH_MMAP_RND_COMPAT_BITS=3D8
> CONFIG_HAVE_ARCH_COMPAT_MMAP_BASES=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_64KB=3Dy
> CONFIG_PAGE_SIZE_LESS_THAN_256KB=3Dy
> CONFIG_HAVE_STACK_VALIDATION=3Dy
> CONFIG_HAVE_RELIABLE_STACKTRACE=3Dy
> CONFIG_OLD_SIGSUSPEND3=3Dy
> CONFIG_COMPAT_OLD_SIGACTION=3Dy
> CONFIG_COMPAT_32BIT_TIME=3Dy
> CONFIG_HAVE_ARCH_VMAP_STACK=3Dy
> CONFIG_VMAP_STACK=3Dy
> CONFIG_HAVE_ARCH_RANDOMIZE_KSTACK_OFFSET=3Dy
> # CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT is not set
> CONFIG_ARCH_HAS_STRICT_KERNEL_RWX=3Dy
> CONFIG_STRICT_KERNEL_RWX=3Dy
> CONFIG_ARCH_HAS_STRICT_MODULE_RWX=3Dy
> CONFIG_STRICT_MODULE_RWX=3Dy
> CONFIG_HAVE_ARCH_PREL32_RELOCATIONS=3Dy
> CONFIG_ARCH_USE_MEMREMAP_PROT=3Dy
> # CONFIG_LOCK_EVENT_COUNTS is not set
> CONFIG_ARCH_HAS_MEM_ENCRYPT=3Dy
> CONFIG_HAVE_STATIC_CALL=3Dy
> CONFIG_HAVE_STATIC_CALL_INLINE=3Dy
> CONFIG_HAVE_PREEMPT_DYNAMIC=3Dy
> CONFIG_ARCH_WANT_LD_ORPHAN_WARN=3Dy
> CONFIG_ARCH_SUPPORTS_DEBUG_PAGEALLOC=3Dy
> CONFIG_ARCH_SUPPORTS_PAGE_TABLE_CHECK=3Dy
> CONFIG_ARCH_HAS_ELFCORE_COMPAT=3Dy
> CONFIG_ARCH_HAS_PARANOID_L1D_FLUSH=3Dy
> CONFIG_DYNAMIC_SIGFRAME=3Dy
>=20
> #
> # GCOV-based kernel profiling
> #
> # CONFIG_GCOV_KERNEL is not set
> CONFIG_ARCH_HAS_GCOV_PROFILE_ALL=3Dy
> # end of GCOV-based kernel profiling
>=20
> CONFIG_HAVE_GCC_PLUGINS=3Dy
> # end of General architecture-dependent options
>=20
> CONFIG_RT_MUTEXES=3Dy
> CONFIG_BASE_SMALL=3D0
> CONFIG_MODULE_SIG_FORMAT=3Dy
> CONFIG_MODULES=3Dy
> CONFIG_MODULE_FORCE_LOAD=3Dy
> CONFIG_MODULE_UNLOAD=3Dy
> # CONFIG_MODULE_FORCE_UNLOAD is not set
> # CONFIG_MODVERSIONS is not set
> # CONFIG_MODULE_SRCVERSION_ALL is not set
> CONFIG_MODULE_SIG=3Dy
> # CONFIG_MODULE_SIG_FORCE is not set
> CONFIG_MODULE_SIG_ALL=3Dy
> # CONFIG_MODULE_SIG_SHA1 is not set
> # CONFIG_MODULE_SIG_SHA224 is not set
> CONFIG_MODULE_SIG_SHA256=3Dy
> # CONFIG_MODULE_SIG_SHA384 is not set
> # CONFIG_MODULE_SIG_SHA512 is not set
> CONFIG_MODULE_SIG_HASH=3D"sha256"
> CONFIG_MODULE_COMPRESS_NONE=3Dy
> # CONFIG_MODULE_COMPRESS_GZIP is not set
> # CONFIG_MODULE_COMPRESS_XZ is not set
> # CONFIG_MODULE_COMPRESS_ZSTD is not set
> # CONFIG_MODULE_ALLOW_MISSING_NAMESPACE_IMPORTS is not set
> CONFIG_MODPROBE_PATH=3D"/sbin/modprobe"
> CONFIG_MODULES_TREE_LOOKUP=3Dy
> CONFIG_BLOCK=3Dy
> CONFIG_BLK_CGROUP_RWSTAT=3Dy
> CONFIG_BLK_DEV_BSG_COMMON=3Dy
> CONFIG_BLK_ICQ=3Dy
> CONFIG_BLK_DEV_BSGLIB=3Dy
> CONFIG_BLK_DEV_INTEGRITY=3Dy
> CONFIG_BLK_DEV_INTEGRITY_T10=3Dm
> CONFIG_BLK_DEV_ZONED=3Dy
> CONFIG_BLK_DEV_THROTTLING=3Dy
> # CONFIG_BLK_DEV_THROTTLING_LOW is not set
> CONFIG_BLK_WBT=3Dy
> CONFIG_BLK_WBT_MQ=3Dy
> # CONFIG_BLK_CGROUP_IOLATENCY is not set
> # CONFIG_BLK_CGROUP_FC_APPID is not set
> # CONFIG_BLK_CGROUP_IOCOST is not set
> # CONFIG_BLK_CGROUP_IOPRIO is not set
> CONFIG_BLK_DEBUG_FS=3Dy
> CONFIG_BLK_DEBUG_FS_ZONED=3Dy
> # CONFIG_BLK_SED_OPAL is not set
> # CONFIG_BLK_INLINE_ENCRYPTION is not set
>=20
> #
> # Partition Types
> #
> # CONFIG_PARTITION_ADVANCED is not set
> CONFIG_MSDOS_PARTITION=3Dy
> CONFIG_EFI_PARTITION=3Dy
> # end of Partition Types
>=20
> CONFIG_BLOCK_COMPAT=3Dy
> CONFIG_BLK_MQ_PCI=3Dy
> CONFIG_BLK_MQ_VIRTIO=3Dy
> CONFIG_BLK_MQ_RDMA=3Dy
> CONFIG_BLK_PM=3Dy
> CONFIG_BLOCK_HOLDER_DEPRECATED=3Dy
>=20
> #
> # IO Schedulers
> #
> CONFIG_MQ_IOSCHED_DEADLINE=3Dy
> CONFIG_MQ_IOSCHED_KYBER=3Dy
> CONFIG_IOSCHED_BFQ=3Dy
> CONFIG_BFQ_GROUP_IOSCHED=3Dy
> # CONFIG_BFQ_CGROUP_DEBUG is not set
> # end of IO Schedulers
>=20
> CONFIG_PREEMPT_NOTIFIERS=3Dy
> CONFIG_PADATA=3Dy
> CONFIG_ASN1=3Dy
> CONFIG_INLINE_SPIN_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_READ_UNLOCK=3Dy
> CONFIG_INLINE_READ_UNLOCK_IRQ=3Dy
> CONFIG_INLINE_WRITE_UNLOCK=3Dy
> CONFIG_INLINE_WRITE_UNLOCK_IRQ=3Dy
> CONFIG_ARCH_SUPPORTS_ATOMIC_RMW=3Dy
> CONFIG_MUTEX_SPIN_ON_OWNER=3Dy
> CONFIG_RWSEM_SPIN_ON_OWNER=3Dy
> CONFIG_LOCK_SPIN_ON_OWNER=3Dy
> CONFIG_ARCH_USE_QUEUED_SPINLOCKS=3Dy
> CONFIG_QUEUED_SPINLOCKS=3Dy
> CONFIG_ARCH_USE_QUEUED_RWLOCKS=3Dy
> CONFIG_QUEUED_RWLOCKS=3Dy
> CONFIG_ARCH_HAS_NON_OVERLAPPING_ADDRESS_SPACE=3Dy
> CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE=3Dy
> CONFIG_ARCH_HAS_SYSCALL_WRAPPER=3Dy
> CONFIG_FREEZER=3Dy
>=20
> #
> # Executable file formats
> #
> CONFIG_BINFMT_ELF=3Dy
> CONFIG_COMPAT_BINFMT_ELF=3Dy
> CONFIG_ELFCORE=3Dy
> CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=3Dy
> CONFIG_BINFMT_SCRIPT=3Dy
> CONFIG_BINFMT_MISC=3Dm
> CONFIG_COREDUMP=3Dy
> # end of Executable file formats
>=20
> #
> # Memory Management options
> #
> CONFIG_SELECT_MEMORY_MODEL=3Dy
> CONFIG_SPARSEMEM_MANUAL=3Dy
> CONFIG_SPARSEMEM=3Dy
> CONFIG_SPARSEMEM_EXTREME=3Dy
> CONFIG_SPARSEMEM_VMEMMAP_ENABLE=3Dy
> CONFIG_SPARSEMEM_VMEMMAP=3Dy
> CONFIG_HAVE_FAST_GUP=3Dy
> CONFIG_NUMA_KEEP_MEMINFO=3Dy
> CONFIG_MEMORY_ISOLATION=3Dy
> CONFIG_EXCLUSIVE_SYSTEM_RAM=3Dy
> CONFIG_HAVE_BOOTMEM_INFO_NODE=3Dy
> CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=3Dy
> CONFIG_MEMORY_HOTPLUG=3Dy
> # CONFIG_MEMORY_HOTPLUG_DEFAULT_ONLINE is not set
> CONFIG_ARCH_ENABLE_MEMORY_HOTREMOVE=3Dy
> CONFIG_MEMORY_HOTREMOVE=3Dy
> CONFIG_MHP_MEMMAP_ON_MEMORY=3Dy
> CONFIG_SPLIT_PTLOCK_CPUS=3D4
> CONFIG_ARCH_ENABLE_SPLIT_PMD_PTLOCK=3Dy
> CONFIG_MEMORY_BALLOON=3Dy
> CONFIG_BALLOON_COMPACTION=3Dy
> CONFIG_COMPACTION=3Dy
> CONFIG_PAGE_REPORTING=3Dy
> CONFIG_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_HUGEPAGE_MIGRATION=3Dy
> CONFIG_ARCH_ENABLE_THP_MIGRATION=3Dy
> CONFIG_CONTIG_ALLOC=3Dy
> CONFIG_PHYS_ADDR_T_64BIT=3Dy
> CONFIG_VIRT_TO_BUS=3Dy
> CONFIG_MMU_NOTIFIER=3Dy
> CONFIG_KSM=3Dy
> CONFIG_DEFAULT_MMAP_MIN_ADDR=3D4096
> CONFIG_ARCH_SUPPORTS_MEMORY_FAILURE=3Dy
> CONFIG_MEMORY_FAILURE=3Dy
> CONFIG_HWPOISON_INJECT=3Dm
> CONFIG_TRANSPARENT_HUGEPAGE=3Dy
> CONFIG_TRANSPARENT_HUGEPAGE_ALWAYS=3Dy
> # CONFIG_TRANSPARENT_HUGEPAGE_MADVISE is not set
> CONFIG_ARCH_WANTS_THP_SWAP=3Dy
> CONFIG_THP_SWAP=3Dy
> CONFIG_NEED_PER_CPU_EMBED_FIRST_CHUNK=3Dy
> CONFIG_NEED_PER_CPU_PAGE_FIRST_CHUNK=3Dy
> CONFIG_USE_PERCPU_NUMA_NODE_ID=3Dy
> CONFIG_HAVE_SETUP_PER_CPU_AREA=3Dy
> CONFIG_FRONTSWAP=3Dy
> CONFIG_CMA=3Dy
> # CONFIG_CMA_DEBUG is not set
> # CONFIG_CMA_DEBUGFS is not set
> # CONFIG_CMA_SYSFS is not set
> CONFIG_CMA_AREAS=3D19
> # CONFIG_MEM_SOFT_DIRTY is not set
> CONFIG_ZSWAP=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_DEFLATE is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZO=3Dy
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_842 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4 is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_LZ4HC is not set
> # CONFIG_ZSWAP_COMPRESSOR_DEFAULT_ZSTD is not set
> CONFIG_ZSWAP_COMPRESSOR_DEFAULT=3D"lzo"
> CONFIG_ZSWAP_ZPOOL_DEFAULT_ZBUD=3Dy
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_Z3FOLD is not set
> # CONFIG_ZSWAP_ZPOOL_DEFAULT_ZSMALLOC is not set
> CONFIG_ZSWAP_ZPOOL_DEFAULT=3D"zbud"
> # CONFIG_ZSWAP_DEFAULT_ON is not set
> CONFIG_ZPOOL=3Dy
> CONFIG_ZBUD=3Dy
> # CONFIG_Z3FOLD is not set
> CONFIG_ZSMALLOC=3Dy
> CONFIG_ZSMALLOC_STAT=3Dy
> CONFIG_GENERIC_EARLY_IOREMAP=3Dy
> CONFIG_DEFERRED_STRUCT_PAGE_INIT=3Dy
> CONFIG_PAGE_IDLE_FLAG=3Dy
> CONFIG_IDLE_PAGE_TRACKING=3Dy
> CONFIG_ARCH_HAS_CACHE_LINE_SIZE=3Dy
> CONFIG_ARCH_HAS_PTE_DEVMAP=3Dy
> CONFIG_ZONE_DMA=3Dy
> CONFIG_ZONE_DMA32=3Dy
> CONFIG_ZONE_DEVICE=3Dy
> CONFIG_DEV_PAGEMAP_OPS=3Dy
> CONFIG_HMM_MIRROR=3Dy
> CONFIG_DEVICE_PRIVATE=3Dy
> CONFIG_VMAP_PFN=3Dy
> CONFIG_ARCH_USES_HIGH_VMA_FLAGS=3Dy
> CONFIG_ARCH_HAS_PKEYS=3Dy
> # CONFIG_PERCPU_STATS is not set
> # CONFIG_GUP_TEST is not set
> # CONFIG_READ_ONLY_THP_FOR_FS is not set
> CONFIG_ARCH_HAS_PTE_SPECIAL=3Dy
> CONFIG_SECRETMEM=3Dy
> # CONFIG_ANON_VMA_NAME is not set
>=20
> #
> # Data Access Monitoring
> #
> # CONFIG_DAMON is not set
> # end of Data Access Monitoring
> # end of Memory Management options
>=20
> CONFIG_NET=3Dy
> CONFIG_COMPAT_NETLINK_MESSAGES=3Dy
> CONFIG_NET_INGRESS=3Dy
> CONFIG_NET_EGRESS=3Dy
> CONFIG_SKB_EXTENSIONS=3Dy
>=20
> #
> # Networking options
> #
> CONFIG_PACKET=3Dy
> CONFIG_PACKET_DIAG=3Dm
> CONFIG_UNIX=3Dy
> CONFIG_UNIX_SCM=3Dy
> CONFIG_AF_UNIX_OOB=3Dy
> CONFIG_UNIX_DIAG=3Dm
> CONFIG_TLS=3Dm
> CONFIG_TLS_DEVICE=3Dy
> # CONFIG_TLS_TOE is not set
> CONFIG_XFRM=3Dy
> CONFIG_XFRM_OFFLOAD=3Dy
> CONFIG_XFRM_ALGO=3Dy
> CONFIG_XFRM_USER=3Dy
> # CONFIG_XFRM_USER_COMPAT is not set
> # CONFIG_XFRM_INTERFACE is not set
> CONFIG_XFRM_SUB_POLICY=3Dy
> CONFIG_XFRM_MIGRATE=3Dy
> CONFIG_XFRM_STATISTICS=3Dy
> CONFIG_XFRM_AH=3Dm
> CONFIG_XFRM_ESP=3Dm
> CONFIG_XFRM_IPCOMP=3Dm
> CONFIG_NET_KEY=3Dm
> CONFIG_NET_KEY_MIGRATE=3Dy
> # CONFIG_SMC is not set
> CONFIG_XDP_SOCKETS=3Dy
> # CONFIG_XDP_SOCKETS_DIAG is not set
> CONFIG_INET=3Dy
> CONFIG_IP_MULTICAST=3Dy
> CONFIG_IP_ADVANCED_ROUTER=3Dy
> CONFIG_IP_FIB_TRIE_STATS=3Dy
> CONFIG_IP_MULTIPLE_TABLES=3Dy
> CONFIG_IP_ROUTE_MULTIPATH=3Dy
> CONFIG_IP_ROUTE_VERBOSE=3Dy
> CONFIG_IP_ROUTE_CLASSID=3Dy
> CONFIG_IP_PNP=3Dy
> CONFIG_IP_PNP_DHCP=3Dy
> # CONFIG_IP_PNP_BOOTP is not set
> # CONFIG_IP_PNP_RARP is not set
> CONFIG_NET_IPIP=3Dm
> CONFIG_NET_IPGRE_DEMUX=3Dm
> CONFIG_NET_IP_TUNNEL=3Dm
> CONFIG_NET_IPGRE=3Dm
> CONFIG_NET_IPGRE_BROADCAST=3Dy
> CONFIG_IP_MROUTE_COMMON=3Dy
> CONFIG_IP_MROUTE=3Dy
> CONFIG_IP_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IP_PIMSM_V1=3Dy
> CONFIG_IP_PIMSM_V2=3Dy
> CONFIG_SYN_COOKIES=3Dy
> CONFIG_NET_IPVTI=3Dm
> CONFIG_NET_UDP_TUNNEL=3Dm
> # CONFIG_NET_FOU is not set
> # CONFIG_NET_FOU_IP_TUNNELS is not set
> CONFIG_INET_AH=3Dm
> CONFIG_INET_ESP=3Dm
> CONFIG_INET_ESP_OFFLOAD=3Dm
> # CONFIG_INET_ESPINTCP is not set
> CONFIG_INET_IPCOMP=3Dm
> CONFIG_INET_XFRM_TUNNEL=3Dm
> CONFIG_INET_TUNNEL=3Dm
> CONFIG_INET_DIAG=3Dm
> CONFIG_INET_TCP_DIAG=3Dm
> CONFIG_INET_UDP_DIAG=3Dm
> CONFIG_INET_RAW_DIAG=3Dm
> # CONFIG_INET_DIAG_DESTROY is not set
> CONFIG_TCP_CONG_ADVANCED=3Dy
> CONFIG_TCP_CONG_BIC=3Dm
> CONFIG_TCP_CONG_CUBIC=3Dy
> CONFIG_TCP_CONG_WESTWOOD=3Dm
> CONFIG_TCP_CONG_HTCP=3Dm
> CONFIG_TCP_CONG_HSTCP=3Dm
> CONFIG_TCP_CONG_HYBLA=3Dm
> CONFIG_TCP_CONG_VEGAS=3Dm
> CONFIG_TCP_CONG_NV=3Dm
> CONFIG_TCP_CONG_SCALABLE=3Dm
> CONFIG_TCP_CONG_LP=3Dm
> CONFIG_TCP_CONG_VENO=3Dm
> CONFIG_TCP_CONG_YEAH=3Dm
> CONFIG_TCP_CONG_ILLINOIS=3Dm
> CONFIG_TCP_CONG_DCTCP=3Dm
> # CONFIG_TCP_CONG_CDG is not set
> CONFIG_TCP_CONG_BBR=3Dm
> CONFIG_DEFAULT_CUBIC=3Dy
> # CONFIG_DEFAULT_RENO is not set
> CONFIG_DEFAULT_TCP_CONG=3D"cubic"
> CONFIG_TCP_MD5SIG=3Dy
> CONFIG_IPV6=3Dy
> CONFIG_IPV6_ROUTER_PREF=3Dy
> CONFIG_IPV6_ROUTE_INFO=3Dy
> CONFIG_IPV6_OPTIMISTIC_DAD=3Dy
> CONFIG_INET6_AH=3Dm
> CONFIG_INET6_ESP=3Dm
> CONFIG_INET6_ESP_OFFLOAD=3Dm
> # CONFIG_INET6_ESPINTCP is not set
> CONFIG_INET6_IPCOMP=3Dm
> CONFIG_IPV6_MIP6=3Dm
> # CONFIG_IPV6_ILA is not set
> CONFIG_INET6_XFRM_TUNNEL=3Dm
> CONFIG_INET6_TUNNEL=3Dm
> CONFIG_IPV6_VTI=3Dm
> CONFIG_IPV6_SIT=3Dm
> CONFIG_IPV6_SIT_6RD=3Dy
> CONFIG_IPV6_NDISC_NODETYPE=3Dy
> CONFIG_IPV6_TUNNEL=3Dm
> CONFIG_IPV6_GRE=3Dm
> CONFIG_IPV6_MULTIPLE_TABLES=3Dy
> # CONFIG_IPV6_SUBTREES is not set
> CONFIG_IPV6_MROUTE=3Dy
> CONFIG_IPV6_MROUTE_MULTIPLE_TABLES=3Dy
> CONFIG_IPV6_PIMSM_V2=3Dy
> # CONFIG_IPV6_SEG6_LWTUNNEL is not set
> # CONFIG_IPV6_SEG6_HMAC is not set
> # CONFIG_IPV6_RPL_LWTUNNEL is not set
> # CONFIG_IPV6_IOAM6_LWTUNNEL is not set
> CONFIG_NETLABEL=3Dy
> CONFIG_MPTCP=3Dy
> CONFIG_INET_MPTCP_DIAG=3Dm
> CONFIG_MPTCP_IPV6=3Dy
> CONFIG_MPTCP_KUNIT_TEST=3Dm
> CONFIG_NETWORK_SECMARK=3Dy
> CONFIG_NET_PTP_CLASSIFY=3Dy
> CONFIG_NETWORK_PHY_TIMESTAMPING=3Dy
> CONFIG_NETFILTER=3Dy
> CONFIG_NETFILTER_ADVANCED=3Dy
> CONFIG_BRIDGE_NETFILTER=3Dm
>=20
> #
> # Core Netfilter Configuration
> #
> CONFIG_NETFILTER_INGRESS=3Dy
> CONFIG_NETFILTER_EGRESS=3Dy
> CONFIG_NETFILTER_SKIP_EGRESS=3Dy
> CONFIG_NETFILTER_NETLINK=3Dm
> CONFIG_NETFILTER_FAMILY_BRIDGE=3Dy
> CONFIG_NETFILTER_FAMILY_ARP=3Dy
> # CONFIG_NETFILTER_NETLINK_HOOK is not set
> # CONFIG_NETFILTER_NETLINK_ACCT is not set
> CONFIG_NETFILTER_NETLINK_QUEUE=3Dm
> CONFIG_NETFILTER_NETLINK_LOG=3Dm
> CONFIG_NETFILTER_NETLINK_OSF=3Dm
> CONFIG_NF_CONNTRACK=3Dm
> CONFIG_NF_LOG_SYSLOG=3Dm
> CONFIG_NETFILTER_CONNCOUNT=3Dm
> CONFIG_NF_CONNTRACK_MARK=3Dy
> CONFIG_NF_CONNTRACK_SECMARK=3Dy
> CONFIG_NF_CONNTRACK_ZONES=3Dy
> CONFIG_NF_CONNTRACK_PROCFS=3Dy
> CONFIG_NF_CONNTRACK_EVENTS=3Dy
> CONFIG_NF_CONNTRACK_TIMEOUT=3Dy
> CONFIG_NF_CONNTRACK_TIMESTAMP=3Dy
> CONFIG_NF_CONNTRACK_LABELS=3Dy
> CONFIG_NF_CT_PROTO_DCCP=3Dy
> CONFIG_NF_CT_PROTO_GRE=3Dy
> CONFIG_NF_CT_PROTO_SCTP=3Dy
> CONFIG_NF_CT_PROTO_UDPLITE=3Dy
> CONFIG_NF_CONNTRACK_AMANDA=3Dm
> CONFIG_NF_CONNTRACK_FTP=3Dm
> CONFIG_NF_CONNTRACK_H323=3Dm
> CONFIG_NF_CONNTRACK_IRC=3Dm
> CONFIG_NF_CONNTRACK_BROADCAST=3Dm
> CONFIG_NF_CONNTRACK_NETBIOS_NS=3Dm
> CONFIG_NF_CONNTRACK_SNMP=3Dm
> CONFIG_NF_CONNTRACK_PPTP=3Dm
> CONFIG_NF_CONNTRACK_SANE=3Dm
> CONFIG_NF_CONNTRACK_SIP=3Dm
> CONFIG_NF_CONNTRACK_TFTP=3Dm
> CONFIG_NF_CT_NETLINK=3Dm
> CONFIG_NF_CT_NETLINK_TIMEOUT=3Dm
> CONFIG_NF_CT_NETLINK_HELPER=3Dm
> CONFIG_NETFILTER_NETLINK_GLUE_CT=3Dy
> CONFIG_NF_NAT=3Dm
> CONFIG_NF_NAT_AMANDA=3Dm
> CONFIG_NF_NAT_FTP=3Dm
> CONFIG_NF_NAT_IRC=3Dm
> CONFIG_NF_NAT_SIP=3Dm
> CONFIG_NF_NAT_TFTP=3Dm
> CONFIG_NF_NAT_REDIRECT=3Dy
> CONFIG_NF_NAT_MASQUERADE=3Dy
> CONFIG_NETFILTER_SYNPROXY=3Dm
> CONFIG_NF_TABLES=3Dm
> CONFIG_NF_TABLES_INET=3Dy
> CONFIG_NF_TABLES_NETDEV=3Dy
> CONFIG_NFT_NUMGEN=3Dm
> CONFIG_NFT_CT=3Dm
> CONFIG_NFT_CONNLIMIT=3Dm
> CONFIG_NFT_LOG=3Dm
> CONFIG_NFT_LIMIT=3Dm
> CONFIG_NFT_MASQ=3Dm
> CONFIG_NFT_REDIR=3Dm
> CONFIG_NFT_NAT=3Dm
> # CONFIG_NFT_TUNNEL is not set
> CONFIG_NFT_OBJREF=3Dm
> CONFIG_NFT_QUEUE=3Dm
> CONFIG_NFT_QUOTA=3Dm
> CONFIG_NFT_REJECT=3Dm
> CONFIG_NFT_REJECT_INET=3Dm
> CONFIG_NFT_COMPAT=3Dm
> CONFIG_NFT_HASH=3Dm
> CONFIG_NFT_FIB=3Dm
> CONFIG_NFT_FIB_INET=3Dm
> # CONFIG_NFT_XFRM is not set
> CONFIG_NFT_SOCKET=3Dm
> # CONFIG_NFT_OSF is not set
> # CONFIG_NFT_TPROXY is not set
> # CONFIG_NFT_SYNPROXY is not set
> CONFIG_NF_DUP_NETDEV=3Dm
> CONFIG_NFT_DUP_NETDEV=3Dm
> CONFIG_NFT_FWD_NETDEV=3Dm
> CONFIG_NFT_FIB_NETDEV=3Dm
> # CONFIG_NFT_REJECT_NETDEV is not set
> # CONFIG_NF_FLOW_TABLE is not set
> CONFIG_NETFILTER_XTABLES=3Dy
> CONFIG_NETFILTER_XTABLES_COMPAT=3Dy
>=20
> #
> # Xtables combined modules
> #
> CONFIG_NETFILTER_XT_MARK=3Dm
> CONFIG_NETFILTER_XT_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_SET=3Dm
>=20
> #
> # Xtables targets
> #
> CONFIG_NETFILTER_XT_TARGET_AUDIT=3Dm
> CONFIG_NETFILTER_XT_TARGET_CHECKSUM=3Dm
> CONFIG_NETFILTER_XT_TARGET_CLASSIFY=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_CT=3Dm
> CONFIG_NETFILTER_XT_TARGET_DSCP=3Dm
> CONFIG_NETFILTER_XT_TARGET_HL=3Dm
> CONFIG_NETFILTER_XT_TARGET_HMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_IDLETIMER=3Dm
> # CONFIG_NETFILTER_XT_TARGET_LED is not set
> CONFIG_NETFILTER_XT_TARGET_LOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_MARK=3Dm
> CONFIG_NETFILTER_XT_NAT=3Dm
> CONFIG_NETFILTER_XT_TARGET_NETMAP=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFLOG=3Dm
> CONFIG_NETFILTER_XT_TARGET_NFQUEUE=3Dm
> CONFIG_NETFILTER_XT_TARGET_NOTRACK=3Dm
> CONFIG_NETFILTER_XT_TARGET_RATEEST=3Dm
> CONFIG_NETFILTER_XT_TARGET_REDIRECT=3Dm
> CONFIG_NETFILTER_XT_TARGET_MASQUERADE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TEE=3Dm
> CONFIG_NETFILTER_XT_TARGET_TPROXY=3Dm
> CONFIG_NETFILTER_XT_TARGET_TRACE=3Dm
> CONFIG_NETFILTER_XT_TARGET_SECMARK=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPMSS=3Dm
> CONFIG_NETFILTER_XT_TARGET_TCPOPTSTRIP=3Dm
>=20
> #
> # Xtables matches
> #
> CONFIG_NETFILTER_XT_MATCH_ADDRTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_BPF=3Dm
> CONFIG_NETFILTER_XT_MATCH_CGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_CLUSTER=3Dm
> CONFIG_NETFILTER_XT_MATCH_COMMENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNBYTES=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLABEL=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNMARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CONNTRACK=3Dm
> CONFIG_NETFILTER_XT_MATCH_CPU=3Dm
> CONFIG_NETFILTER_XT_MATCH_DCCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DEVGROUP=3Dm
> CONFIG_NETFILTER_XT_MATCH_DSCP=3Dm
> CONFIG_NETFILTER_XT_MATCH_ECN=3Dm
> CONFIG_NETFILTER_XT_MATCH_ESP=3Dm
> CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_HELPER=3Dm
> CONFIG_NETFILTER_XT_MATCH_HL=3Dm
> # CONFIG_NETFILTER_XT_MATCH_IPCOMP is not set
> CONFIG_NETFILTER_XT_MATCH_IPRANGE=3Dm
> CONFIG_NETFILTER_XT_MATCH_IPVS=3Dm
> # CONFIG_NETFILTER_XT_MATCH_L2TP is not set
> CONFIG_NETFILTER_XT_MATCH_LENGTH=3Dm
> CONFIG_NETFILTER_XT_MATCH_LIMIT=3Dm
> CONFIG_NETFILTER_XT_MATCH_MAC=3Dm
> CONFIG_NETFILTER_XT_MATCH_MARK=3Dm
> CONFIG_NETFILTER_XT_MATCH_MULTIPORT=3Dm
> # CONFIG_NETFILTER_XT_MATCH_NFACCT is not set
> CONFIG_NETFILTER_XT_MATCH_OSF=3Dm
> CONFIG_NETFILTER_XT_MATCH_OWNER=3Dm
> CONFIG_NETFILTER_XT_MATCH_POLICY=3Dm
> CONFIG_NETFILTER_XT_MATCH_PHYSDEV=3Dm
> CONFIG_NETFILTER_XT_MATCH_PKTTYPE=3Dm
> CONFIG_NETFILTER_XT_MATCH_QUOTA=3Dm
> CONFIG_NETFILTER_XT_MATCH_RATEEST=3Dm
> CONFIG_NETFILTER_XT_MATCH_REALM=3Dm
> CONFIG_NETFILTER_XT_MATCH_RECENT=3Dm
> CONFIG_NETFILTER_XT_MATCH_SCTP=3Dm
> CONFIG_NETFILTER_XT_MATCH_SOCKET=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATE=3Dm
> CONFIG_NETFILTER_XT_MATCH_STATISTIC=3Dm
> CONFIG_NETFILTER_XT_MATCH_STRING=3Dm
> CONFIG_NETFILTER_XT_MATCH_TCPMSS=3Dm
> # CONFIG_NETFILTER_XT_MATCH_TIME is not set
> # CONFIG_NETFILTER_XT_MATCH_U32 is not set
> # end of Core Netfilter Configuration
>=20
> CONFIG_IP_SET=3Dm
> CONFIG_IP_SET_MAX=3D256
> CONFIG_IP_SET_BITMAP_IP=3Dm
> CONFIG_IP_SET_BITMAP_IPMAC=3Dm
> CONFIG_IP_SET_BITMAP_PORT=3Dm
> CONFIG_IP_SET_HASH_IP=3Dm
> CONFIG_IP_SET_HASH_IPMARK=3Dm
> CONFIG_IP_SET_HASH_IPPORT=3Dm
> CONFIG_IP_SET_HASH_IPPORTIP=3Dm
> CONFIG_IP_SET_HASH_IPPORTNET=3Dm
> CONFIG_IP_SET_HASH_IPMAC=3Dm
> CONFIG_IP_SET_HASH_MAC=3Dm
> CONFIG_IP_SET_HASH_NETPORTNET=3Dm
> CONFIG_IP_SET_HASH_NET=3Dm
> CONFIG_IP_SET_HASH_NETNET=3Dm
> CONFIG_IP_SET_HASH_NETPORT=3Dm
> CONFIG_IP_SET_HASH_NETIFACE=3Dm
> CONFIG_IP_SET_LIST_SET=3Dm
> CONFIG_IP_VS=3Dm
> CONFIG_IP_VS_IPV6=3Dy
> # CONFIG_IP_VS_DEBUG is not set
> CONFIG_IP_VS_TAB_BITS=3D12
>=20
> #
> # IPVS transport protocol load balancing support
> #
> CONFIG_IP_VS_PROTO_TCP=3Dy
> CONFIG_IP_VS_PROTO_UDP=3Dy
> CONFIG_IP_VS_PROTO_AH_ESP=3Dy
> CONFIG_IP_VS_PROTO_ESP=3Dy
> CONFIG_IP_VS_PROTO_AH=3Dy
> CONFIG_IP_VS_PROTO_SCTP=3Dy
>=20
> #
> # IPVS scheduler
> #
> CONFIG_IP_VS_RR=3Dm
> CONFIG_IP_VS_WRR=3Dm
> CONFIG_IP_VS_LC=3Dm
> CONFIG_IP_VS_WLC=3Dm
> CONFIG_IP_VS_FO=3Dm
> CONFIG_IP_VS_OVF=3Dm
> CONFIG_IP_VS_LBLC=3Dm
> CONFIG_IP_VS_LBLCR=3Dm
> CONFIG_IP_VS_DH=3Dm
> CONFIG_IP_VS_SH=3Dm
> # CONFIG_IP_VS_MH is not set
> CONFIG_IP_VS_SED=3Dm
> CONFIG_IP_VS_NQ=3Dm
> # CONFIG_IP_VS_TWOS is not set
>=20
> #
> # IPVS SH scheduler
> #
> CONFIG_IP_VS_SH_TAB_BITS=3D8
>=20
> #
> # IPVS MH scheduler
> #
> CONFIG_IP_VS_MH_TAB_INDEX=3D12
>=20
> #
> # IPVS application helper
> #
> CONFIG_IP_VS_FTP=3Dm
> CONFIG_IP_VS_NFCT=3Dy
> CONFIG_IP_VS_PE_SIP=3Dm
>=20
> #
> # IP: Netfilter Configuration
> #
> CONFIG_NF_DEFRAG_IPV4=3Dm
> CONFIG_NF_SOCKET_IPV4=3Dm
> CONFIG_NF_TPROXY_IPV4=3Dm
> CONFIG_NF_TABLES_IPV4=3Dy
> CONFIG_NFT_REJECT_IPV4=3Dm
> CONFIG_NFT_DUP_IPV4=3Dm
> CONFIG_NFT_FIB_IPV4=3Dm
> CONFIG_NF_TABLES_ARP=3Dy
> CONFIG_NF_DUP_IPV4=3Dm
> CONFIG_NF_LOG_ARP=3Dm
> CONFIG_NF_LOG_IPV4=3Dm
> CONFIG_NF_REJECT_IPV4=3Dm
> CONFIG_NF_NAT_SNMP_BASIC=3Dm
> CONFIG_NF_NAT_PPTP=3Dm
> CONFIG_NF_NAT_H323=3Dm
> CONFIG_IP_NF_IPTABLES=3Dm
> CONFIG_IP_NF_MATCH_AH=3Dm
> CONFIG_IP_NF_MATCH_ECN=3Dm
> CONFIG_IP_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP_NF_MATCH_TTL=3Dm
> CONFIG_IP_NF_FILTER=3Dm
> CONFIG_IP_NF_TARGET_REJECT=3Dm
> CONFIG_IP_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP_NF_NAT=3Dm
> CONFIG_IP_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP_NF_TARGET_NETMAP=3Dm
> CONFIG_IP_NF_TARGET_REDIRECT=3Dm
> CONFIG_IP_NF_MANGLE=3Dm
> # CONFIG_IP_NF_TARGET_CLUSTERIP is not set
> CONFIG_IP_NF_TARGET_ECN=3Dm
> CONFIG_IP_NF_TARGET_TTL=3Dm
> CONFIG_IP_NF_RAW=3Dm
> CONFIG_IP_NF_SECURITY=3Dm
> CONFIG_IP_NF_ARPTABLES=3Dm
> CONFIG_IP_NF_ARPFILTER=3Dm
> CONFIG_IP_NF_ARP_MANGLE=3Dm
> # end of IP: Netfilter Configuration
>=20
> #
> # IPv6: Netfilter Configuration
> #
> CONFIG_NF_SOCKET_IPV6=3Dm
> CONFIG_NF_TPROXY_IPV6=3Dm
> CONFIG_NF_TABLES_IPV6=3Dy
> CONFIG_NFT_REJECT_IPV6=3Dm
> CONFIG_NFT_DUP_IPV6=3Dm
> CONFIG_NFT_FIB_IPV6=3Dm
> CONFIG_NF_DUP_IPV6=3Dm
> CONFIG_NF_REJECT_IPV6=3Dm
> CONFIG_NF_LOG_IPV6=3Dm
> CONFIG_IP6_NF_IPTABLES=3Dm
> CONFIG_IP6_NF_MATCH_AH=3Dm
> CONFIG_IP6_NF_MATCH_EUI64=3Dm
> CONFIG_IP6_NF_MATCH_FRAG=3Dm
> CONFIG_IP6_NF_MATCH_OPTS=3Dm
> CONFIG_IP6_NF_MATCH_HL=3Dm
> CONFIG_IP6_NF_MATCH_IPV6HEADER=3Dm
> CONFIG_IP6_NF_MATCH_MH=3Dm
> CONFIG_IP6_NF_MATCH_RPFILTER=3Dm
> CONFIG_IP6_NF_MATCH_RT=3Dm
> # CONFIG_IP6_NF_MATCH_SRH is not set
> # CONFIG_IP6_NF_TARGET_HL is not set
> CONFIG_IP6_NF_FILTER=3Dm
> CONFIG_IP6_NF_TARGET_REJECT=3Dm
> CONFIG_IP6_NF_TARGET_SYNPROXY=3Dm
> CONFIG_IP6_NF_MANGLE=3Dm
> CONFIG_IP6_NF_RAW=3Dm
> CONFIG_IP6_NF_SECURITY=3Dm
> CONFIG_IP6_NF_NAT=3Dm
> CONFIG_IP6_NF_TARGET_MASQUERADE=3Dm
> CONFIG_IP6_NF_TARGET_NPT=3Dm
> # end of IPv6: Netfilter Configuration
>=20
> CONFIG_NF_DEFRAG_IPV6=3Dm
> CONFIG_NF_TABLES_BRIDGE=3Dm
> # CONFIG_NFT_BRIDGE_META is not set
> CONFIG_NFT_BRIDGE_REJECT=3Dm
> # CONFIG_NF_CONNTRACK_BRIDGE is not set
> CONFIG_BRIDGE_NF_EBTABLES=3Dm
> CONFIG_BRIDGE_EBT_BROUTE=3Dm
> CONFIG_BRIDGE_EBT_T_FILTER=3Dm
> CONFIG_BRIDGE_EBT_T_NAT=3Dm
> CONFIG_BRIDGE_EBT_802_3=3Dm
> CONFIG_BRIDGE_EBT_AMONG=3Dm
> CONFIG_BRIDGE_EBT_ARP=3Dm
> CONFIG_BRIDGE_EBT_IP=3Dm
> CONFIG_BRIDGE_EBT_IP6=3Dm
> CONFIG_BRIDGE_EBT_LIMIT=3Dm
> CONFIG_BRIDGE_EBT_MARK=3Dm
> CONFIG_BRIDGE_EBT_PKTTYPE=3Dm
> CONFIG_BRIDGE_EBT_STP=3Dm
> CONFIG_BRIDGE_EBT_VLAN=3Dm
> CONFIG_BRIDGE_EBT_ARPREPLY=3Dm
> CONFIG_BRIDGE_EBT_DNAT=3Dm
> CONFIG_BRIDGE_EBT_MARK_T=3Dm
> CONFIG_BRIDGE_EBT_REDIRECT=3Dm
> CONFIG_BRIDGE_EBT_SNAT=3Dm
> CONFIG_BRIDGE_EBT_LOG=3Dm
> CONFIG_BRIDGE_EBT_NFLOG=3Dm
> # CONFIG_BPFILTER is not set
> # CONFIG_IP_DCCP is not set
> CONFIG_IP_SCTP=3Dm
> # CONFIG_SCTP_DBG_OBJCNT is not set
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_MD5 is not set
> CONFIG_SCTP_DEFAULT_COOKIE_HMAC_SHA1=3Dy
> # CONFIG_SCTP_DEFAULT_COOKIE_HMAC_NONE is not set
> CONFIG_SCTP_COOKIE_HMAC_MD5=3Dy
> CONFIG_SCTP_COOKIE_HMAC_SHA1=3Dy
> CONFIG_INET_SCTP_DIAG=3Dm
> # CONFIG_RDS is not set
> CONFIG_TIPC=3Dm
> # CONFIG_TIPC_MEDIA_IB is not set
> CONFIG_TIPC_MEDIA_UDP=3Dy
> CONFIG_TIPC_CRYPTO=3Dy
> CONFIG_TIPC_DIAG=3Dm
> CONFIG_ATM=3Dm
> CONFIG_ATM_CLIP=3Dm
> # CONFIG_ATM_CLIP_NO_ICMP is not set
> CONFIG_ATM_LANE=3Dm
> # CONFIG_ATM_MPOA is not set
> CONFIG_ATM_BR2684=3Dm
> # CONFIG_ATM_BR2684_IPFILTER is not set
> CONFIG_L2TP=3Dm
> CONFIG_L2TP_DEBUGFS=3Dm
> CONFIG_L2TP_V3=3Dy
> CONFIG_L2TP_IP=3Dm
> CONFIG_L2TP_ETH=3Dm
> CONFIG_STP=3Dm
> CONFIG_GARP=3Dm
> CONFIG_MRP=3Dm
> CONFIG_BRIDGE=3Dm
> CONFIG_BRIDGE_IGMP_SNOOPING=3Dy
> CONFIG_BRIDGE_VLAN_FILTERING=3Dy
> # CONFIG_BRIDGE_MRP is not set
> # CONFIG_BRIDGE_CFM is not set
> # CONFIG_NET_DSA is not set
> CONFIG_VLAN_8021Q=3Dm
> CONFIG_VLAN_8021Q_GVRP=3Dy
> CONFIG_VLAN_8021Q_MVRP=3Dy
> # CONFIG_DECNET is not set
> CONFIG_LLC=3Dm
> # CONFIG_LLC2 is not set
> # CONFIG_ATALK is not set
> # CONFIG_X25 is not set
> # CONFIG_LAPB is not set
> # CONFIG_PHONET is not set
> CONFIG_6LOWPAN=3Dm
> # CONFIG_6LOWPAN_DEBUGFS is not set
> # CONFIG_6LOWPAN_NHC is not set
> CONFIG_IEEE802154=3Dm
> # CONFIG_IEEE802154_NL802154_EXPERIMENTAL is not set
> CONFIG_IEEE802154_SOCKET=3Dm
> CONFIG_IEEE802154_6LOWPAN=3Dm
> CONFIG_MAC802154=3Dm
> CONFIG_NET_SCHED=3Dy
>=20
> #
> # Queueing/Scheduling
> #
> CONFIG_NET_SCH_CBQ=3Dm
> CONFIG_NET_SCH_HTB=3Dm
> CONFIG_NET_SCH_HFSC=3Dm
> CONFIG_NET_SCH_ATM=3Dm
> CONFIG_NET_SCH_PRIO=3Dm
> CONFIG_NET_SCH_MULTIQ=3Dm
> CONFIG_NET_SCH_RED=3Dm
> CONFIG_NET_SCH_SFB=3Dm
> CONFIG_NET_SCH_SFQ=3Dm
> CONFIG_NET_SCH_TEQL=3Dm
> CONFIG_NET_SCH_TBF=3Dm
> # CONFIG_NET_SCH_CBS is not set
> # CONFIG_NET_SCH_ETF is not set
> # CONFIG_NET_SCH_TAPRIO is not set
> CONFIG_NET_SCH_GRED=3Dm
> CONFIG_NET_SCH_DSMARK=3Dm
> CONFIG_NET_SCH_NETEM=3Dm
> CONFIG_NET_SCH_DRR=3Dm
> CONFIG_NET_SCH_MQPRIO=3Dm
> # CONFIG_NET_SCH_SKBPRIO is not set
> CONFIG_NET_SCH_CHOKE=3Dm
> CONFIG_NET_SCH_QFQ=3Dm
> CONFIG_NET_SCH_CODEL=3Dm
> CONFIG_NET_SCH_FQ_CODEL=3Dy
> # CONFIG_NET_SCH_CAKE is not set
> CONFIG_NET_SCH_FQ=3Dm
> CONFIG_NET_SCH_HHF=3Dm
> CONFIG_NET_SCH_PIE=3Dm
> # CONFIG_NET_SCH_FQ_PIE is not set
> CONFIG_NET_SCH_INGRESS=3Dm
> CONFIG_NET_SCH_PLUG=3Dm
> # CONFIG_NET_SCH_ETS is not set
> CONFIG_NET_SCH_DEFAULT=3Dy
> # CONFIG_DEFAULT_FQ is not set
> # CONFIG_DEFAULT_CODEL is not set
> CONFIG_DEFAULT_FQ_CODEL=3Dy
> # CONFIG_DEFAULT_SFQ is not set
> # CONFIG_DEFAULT_PFIFO_FAST is not set
> CONFIG_DEFAULT_NET_SCH=3D"fq_codel"
>=20
> #
> # Classification
> #
> CONFIG_NET_CLS=3Dy
> CONFIG_NET_CLS_BASIC=3Dm
> CONFIG_NET_CLS_TCINDEX=3Dm
> CONFIG_NET_CLS_ROUTE4=3Dm
> CONFIG_NET_CLS_FW=3Dm
> CONFIG_NET_CLS_U32=3Dm
> CONFIG_CLS_U32_PERF=3Dy
> CONFIG_CLS_U32_MARK=3Dy
> CONFIG_NET_CLS_RSVP=3Dm
> CONFIG_NET_CLS_RSVP6=3Dm
> CONFIG_NET_CLS_FLOW=3Dm
> CONFIG_NET_CLS_CGROUP=3Dy
> CONFIG_NET_CLS_BPF=3Dm
> CONFIG_NET_CLS_FLOWER=3Dm
> CONFIG_NET_CLS_MATCHALL=3Dm
> CONFIG_NET_EMATCH=3Dy
> CONFIG_NET_EMATCH_STACK=3D32
> CONFIG_NET_EMATCH_CMP=3Dm
> CONFIG_NET_EMATCH_NBYTE=3Dm
> CONFIG_NET_EMATCH_U32=3Dm
> CONFIG_NET_EMATCH_META=3Dm
> CONFIG_NET_EMATCH_TEXT=3Dm
> # CONFIG_NET_EMATCH_CANID is not set
> CONFIG_NET_EMATCH_IPSET=3Dm
> # CONFIG_NET_EMATCH_IPT is not set
> CONFIG_NET_CLS_ACT=3Dy
> CONFIG_NET_ACT_POLICE=3Dm
> CONFIG_NET_ACT_GACT=3Dm
> CONFIG_GACT_PROB=3Dy
> CONFIG_NET_ACT_MIRRED=3Dm
> CONFIG_NET_ACT_SAMPLE=3Dm
> # CONFIG_NET_ACT_IPT is not set
> CONFIG_NET_ACT_NAT=3Dm
> CONFIG_NET_ACT_PEDIT=3Dm
> CONFIG_NET_ACT_SIMP=3Dm
> CONFIG_NET_ACT_SKBEDIT=3Dm
> CONFIG_NET_ACT_CSUM=3Dm
> # CONFIG_NET_ACT_MPLS is not set
> CONFIG_NET_ACT_VLAN=3Dm
> CONFIG_NET_ACT_BPF=3Dm
> # CONFIG_NET_ACT_CONNMARK is not set
> # CONFIG_NET_ACT_CTINFO is not set
> CONFIG_NET_ACT_SKBMOD=3Dm
> # CONFIG_NET_ACT_IFE is not set
> CONFIG_NET_ACT_TUNNEL_KEY=3Dm
> # CONFIG_NET_ACT_GATE is not set
> # CONFIG_NET_TC_SKB_EXT is not set
> CONFIG_NET_SCH_FIFO=3Dy
> CONFIG_DCB=3Dy
> CONFIG_DNS_RESOLVER=3Dm
> # CONFIG_BATMAN_ADV is not set
> CONFIG_OPENVSWITCH=3Dm
> CONFIG_OPENVSWITCH_GRE=3Dm
> CONFIG_VSOCKETS=3Dm
> CONFIG_VSOCKETS_DIAG=3Dm
> CONFIG_VSOCKETS_LOOPBACK=3Dm
> CONFIG_VMWARE_VMCI_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS=3Dm
> CONFIG_VIRTIO_VSOCKETS_COMMON=3Dm
> CONFIG_NETLINK_DIAG=3Dm
> CONFIG_MPLS=3Dy
> CONFIG_NET_MPLS_GSO=3Dy
> CONFIG_MPLS_ROUTING=3Dm
> CONFIG_MPLS_IPTUNNEL=3Dm
> CONFIG_NET_NSH=3Dy
> # CONFIG_HSR is not set
> CONFIG_NET_SWITCHDEV=3Dy
> CONFIG_NET_L3_MASTER_DEV=3Dy
> # CONFIG_QRTR is not set
> # CONFIG_NET_NCSI is not set
> CONFIG_PCPU_DEV_REFCNT=3Dy
> CONFIG_RPS=3Dy
> CONFIG_RFS_ACCEL=3Dy
> CONFIG_SOCK_RX_QUEUE_MAPPING=3Dy
> CONFIG_XPS=3Dy
> CONFIG_CGROUP_NET_PRIO=3Dy
> CONFIG_CGROUP_NET_CLASSID=3Dy
> CONFIG_NET_RX_BUSY_POLL=3Dy
> CONFIG_BQL=3Dy
> CONFIG_BPF_STREAM_PARSER=3Dy
> CONFIG_NET_FLOW_LIMIT=3Dy
>=20
> #
> # Network testing
> #
> CONFIG_NET_PKTGEN=3Dm
> CONFIG_NET_DROP_MONITOR=3Dy
> # end of Network testing
> # end of Networking options
>=20
> # CONFIG_HAMRADIO is not set
> CONFIG_CAN=3Dm
> CONFIG_CAN_RAW=3Dm
> CONFIG_CAN_BCM=3Dm
> CONFIG_CAN_GW=3Dm
> # CONFIG_CAN_J1939 is not set
> # CONFIG_CAN_ISOTP is not set
>=20
> #
> # CAN Device Drivers
> #
> CONFIG_CAN_VCAN=3Dm
> # CONFIG_CAN_VXCAN is not set
> CONFIG_CAN_SLCAN=3Dm
> CONFIG_CAN_DEV=3Dm
> CONFIG_CAN_CALC_BITTIMING=3Dy
> # CONFIG_CAN_KVASER_PCIEFD is not set
> CONFIG_CAN_C_CAN=3Dm
> CONFIG_CAN_C_CAN_PLATFORM=3Dm
> CONFIG_CAN_C_CAN_PCI=3Dm
> CONFIG_CAN_CC770=3Dm
> # CONFIG_CAN_CC770_ISA is not set
> CONFIG_CAN_CC770_PLATFORM=3Dm
> # CONFIG_CAN_IFI_CANFD is not set
> # CONFIG_CAN_M_CAN is not set
> # CONFIG_CAN_PEAK_PCIEFD is not set
> CONFIG_CAN_SJA1000=3Dm
> CONFIG_CAN_EMS_PCI=3Dm
> # CONFIG_CAN_F81601 is not set
> CONFIG_CAN_KVASER_PCI=3Dm
> CONFIG_CAN_PEAK_PCI=3Dm
> CONFIG_CAN_PEAK_PCIEC=3Dy
> CONFIG_CAN_PLX_PCI=3Dm
> # CONFIG_CAN_SJA1000_ISA is not set
> CONFIG_CAN_SJA1000_PLATFORM=3Dm
> CONFIG_CAN_SOFTING=3Dm
>=20
> #
> # CAN SPI interfaces
> #
> # CONFIG_CAN_HI311X is not set
> # CONFIG_CAN_MCP251X is not set
> # CONFIG_CAN_MCP251XFD is not set
> # end of CAN SPI interfaces
>=20
> #
> # CAN USB interfaces
> #
> # CONFIG_CAN_8DEV_USB is not set
> # CONFIG_CAN_EMS_USB is not set
> # CONFIG_CAN_ESD_USB2 is not set
> # CONFIG_CAN_ETAS_ES58X is not set
> # CONFIG_CAN_GS_USB is not set
> # CONFIG_CAN_KVASER_USB is not set
> # CONFIG_CAN_MCBA_USB is not set
> # CONFIG_CAN_PEAK_USB is not set
> # CONFIG_CAN_UCAN is not set
> # end of CAN USB interfaces
>=20
> # CONFIG_CAN_DEBUG_DEVICES is not set
> # end of CAN Device Drivers
>=20
> # CONFIG_BT is not set
> # CONFIG_AF_RXRPC is not set
> # CONFIG_AF_KCM is not set
> CONFIG_STREAM_PARSER=3Dy
> # CONFIG_MCTP is not set
> CONFIG_FIB_RULES=3Dy
> CONFIG_WIRELESS=3Dy
> CONFIG_WEXT_CORE=3Dy
> CONFIG_WEXT_PROC=3Dy
> CONFIG_CFG80211=3Dm
> # CONFIG_NL80211_TESTMODE is not set
> # CONFIG_CFG80211_DEVELOPER_WARNINGS is not set
> CONFIG_CFG80211_REQUIRE_SIGNED_REGDB=3Dy
> CONFIG_CFG80211_USE_KERNEL_REGDB_KEYS=3Dy
> CONFIG_CFG80211_DEFAULT_PS=3Dy
> # CONFIG_CFG80211_DEBUGFS is not set
> CONFIG_CFG80211_CRDA_SUPPORT=3Dy
> CONFIG_CFG80211_WEXT=3Dy
> CONFIG_MAC80211=3Dm
> CONFIG_MAC80211_HAS_RC=3Dy
> CONFIG_MAC80211_RC_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT_MINSTREL=3Dy
> CONFIG_MAC80211_RC_DEFAULT=3D"minstrel_ht"
> CONFIG_MAC80211_MESH=3Dy
> CONFIG_MAC80211_LEDS=3Dy
> CONFIG_MAC80211_DEBUGFS=3Dy
> # CONFIG_MAC80211_MESSAGE_TRACING is not set
> # CONFIG_MAC80211_DEBUG_MENU is not set
> CONFIG_MAC80211_STA_HASH_MAX_SIZE=3D0
> CONFIG_RFKILL=3Dm
> CONFIG_RFKILL_LEDS=3Dy
> CONFIG_RFKILL_INPUT=3Dy
> # CONFIG_RFKILL_GPIO is not set
> CONFIG_NET_9P=3Dy
> CONFIG_NET_9P_FD=3Dy
> CONFIG_NET_9P_VIRTIO=3Dy
> # CONFIG_NET_9P_RDMA is not set
> # CONFIG_NET_9P_DEBUG is not set
> # CONFIG_CAIF is not set
> CONFIG_CEPH_LIB=3Dm
> # CONFIG_CEPH_LIB_PRETTYDEBUG is not set
> CONFIG_CEPH_LIB_USE_DNS_RESOLVER=3Dy
> # CONFIG_NFC is not set
> CONFIG_PSAMPLE=3Dm
> # CONFIG_NET_IFE is not set
> CONFIG_LWTUNNEL=3Dy
> CONFIG_LWTUNNEL_BPF=3Dy
> CONFIG_DST_CACHE=3Dy
> CONFIG_GRO_CELLS=3Dy
> CONFIG_SOCK_VALIDATE_XMIT=3Dy
> CONFIG_NET_SELFTESTS=3Dy
> CONFIG_NET_SOCK_MSG=3Dy
> CONFIG_FAILOVER=3Dm
> CONFIG_ETHTOOL_NETLINK=3Dy
> CONFIG_NETDEV_ADDR_LIST_TEST=3Dm
>=20
> #
> # Device Drivers
> #
> CONFIG_HAVE_EISA=3Dy
> # CONFIG_EISA is not set
> CONFIG_HAVE_PCI=3Dy
> CONFIG_PCI=3Dy
> CONFIG_PCI_DOMAINS=3Dy
> CONFIG_PCIEPORTBUS=3Dy
> CONFIG_HOTPLUG_PCI_PCIE=3Dy
> CONFIG_PCIEAER=3Dy
> CONFIG_PCIEAER_INJECT=3Dm
> CONFIG_PCIE_ECRC=3Dy
> CONFIG_PCIEASPM=3Dy
> CONFIG_PCIEASPM_DEFAULT=3Dy
> # CONFIG_PCIEASPM_POWERSAVE is not set
> # CONFIG_PCIEASPM_POWER_SUPERSAVE is not set
> # CONFIG_PCIEASPM_PERFORMANCE is not set
> CONFIG_PCIE_PME=3Dy
> CONFIG_PCIE_DPC=3Dy
> # CONFIG_PCIE_PTM is not set
> # CONFIG_PCIE_EDR is not set
> CONFIG_PCI_MSI=3Dy
> CONFIG_PCI_MSI_IRQ_DOMAIN=3Dy
> CONFIG_PCI_QUIRKS=3Dy
> # CONFIG_PCI_DEBUG is not set
> # CONFIG_PCI_REALLOC_ENABLE_AUTO is not set
> CONFIG_PCI_STUB=3Dy
> CONFIG_PCI_PF_STUB=3Dm
> CONFIG_PCI_ATS=3Dy
> CONFIG_PCI_LOCKLESS_CONFIG=3Dy
> CONFIG_PCI_IOV=3Dy
> CONFIG_PCI_PRI=3Dy
> CONFIG_PCI_PASID=3Dy
> # CONFIG_PCI_P2PDMA is not set
> CONFIG_PCI_LABEL=3Dy
> CONFIG_HOTPLUG_PCI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI=3Dy
> CONFIG_HOTPLUG_PCI_ACPI_IBM=3Dm
> # CONFIG_HOTPLUG_PCI_CPCI is not set
> CONFIG_HOTPLUG_PCI_SHPC=3Dy
>=20
> #
> # PCI controller drivers
> #
> CONFIG_VMD=3Dy
>=20
> #
> # DesignWare PCI Core Support
> #
> # CONFIG_PCIE_DW_PLAT_HOST is not set
> # CONFIG_PCI_MESON is not set
> # end of DesignWare PCI Core Support
>=20
> #
> # Mobiveil PCIe Core Support
> #
> # end of Mobiveil PCIe Core Support
>=20
> #
> # Cadence PCIe controllers support
> #
> # end of Cadence PCIe controllers support
> # end of PCI controller drivers
>=20
> #
> # PCI Endpoint
> #
> # CONFIG_PCI_ENDPOINT is not set
> # end of PCI Endpoint
>=20
> #
> # PCI switch controller drivers
> #
> # CONFIG_PCI_SW_SWITCHTEC is not set
> # end of PCI switch controller drivers
>=20
> # CONFIG_CXL_BUS is not set
> # CONFIG_PCCARD is not set
> # CONFIG_RAPIDIO is not set
>=20
> #
> # Generic Driver Options
> #
> CONFIG_AUXILIARY_BUS=3Dy
> # CONFIG_UEVENT_HELPER is not set
> CONFIG_DEVTMPFS=3Dy
> CONFIG_DEVTMPFS_MOUNT=3Dy
> # CONFIG_DEVTMPFS_SAFE is not set
> CONFIG_STANDALONE=3Dy
> CONFIG_PREVENT_FIRMWARE_BUILD=3Dy
>=20
> #
> # Firmware loader
> #
> CONFIG_FW_LOADER=3Dy
> CONFIG_FW_LOADER_PAGED_BUF=3Dy
> CONFIG_EXTRA_FIRMWARE=3D""
> CONFIG_FW_LOADER_USER_HELPER=3Dy
> # CONFIG_FW_LOADER_USER_HELPER_FALLBACK is not set
> # CONFIG_FW_LOADER_COMPRESS is not set
> CONFIG_FW_CACHE=3Dy
> # end of Firmware loader
>=20
> CONFIG_ALLOW_DEV_COREDUMP=3Dy
> # CONFIG_DEBUG_DRIVER is not set
> # CONFIG_DEBUG_DEVRES is not set
> # CONFIG_DEBUG_TEST_DRIVER_REMOVE is not set
> # CONFIG_TEST_ASYNC_DRIVER_PROBE is not set
> CONFIG_GENERIC_CPU_AUTOPROBE=3Dy
> CONFIG_GENERIC_CPU_VULNERABILITIES=3Dy
> CONFIG_REGMAP=3Dy
> CONFIG_REGMAP_I2C=3Dm
> CONFIG_REGMAP_SPI=3Dm
> CONFIG_DMA_SHARED_BUFFER=3Dy
> # CONFIG_DMA_FENCE_TRACE is not set
> # end of Generic Driver Options
>=20
> #
> # Bus devices
> #
> # CONFIG_MHI_BUS is not set
> # end of Bus devices
>=20
> CONFIG_CONNECTOR=3Dy
> CONFIG_PROC_EVENTS=3Dy
>=20
> #
> # Firmware Drivers
> #
>=20
> #
> # ARM System Control and Management Interface Protocol
> #
> # end of ARM System Control and Management Interface Protocol
>=20
> CONFIG_EDD=3Dm
> # CONFIG_EDD_OFF is not set
> CONFIG_FIRMWARE_MEMMAP=3Dy
> CONFIG_DMIID=3Dy
> CONFIG_DMI_SYSFS=3Dy
> CONFIG_DMI_SCAN_MACHINE_NON_EFI_FALLBACK=3Dy
> # CONFIG_ISCSI_IBFT is not set
> CONFIG_FW_CFG_SYSFS=3Dy
> # CONFIG_FW_CFG_SYSFS_CMDLINE is not set
> CONFIG_SYSFB=3Dy
> # CONFIG_SYSFB_SIMPLEFB is not set
> # CONFIG_GOOGLE_FIRMWARE is not set
>=20
> #
> # EFI (Extensible Firmware Interface) Support
> #
> CONFIG_EFI_VARS=3Dy
> CONFIG_EFI_ESRT=3Dy
> CONFIG_EFI_VARS_PSTORE=3Dy
> CONFIG_EFI_VARS_PSTORE_DEFAULT_DISABLE=3Dy
> CONFIG_EFI_RUNTIME_MAP=3Dy
> # CONFIG_EFI_FAKE_MEMMAP is not set
> CONFIG_EFI_RUNTIME_WRAPPERS=3Dy
> CONFIG_EFI_GENERIC_STUB_INITRD_CMDLINE_LOADER=3Dy
> # CONFIG_EFI_BOOTLOADER_CONTROL is not set
> # CONFIG_EFI_CAPSULE_LOADER is not set
> # CONFIG_EFI_TEST is not set
> # CONFIG_APPLE_PROPERTIES is not set
> # CONFIG_RESET_ATTACK_MITIGATION is not set
> # CONFIG_EFI_RCI2_TABLE is not set
> # CONFIG_EFI_DISABLE_PCI_DMA is not set
> # end of EFI (Extensible Firmware Interface) Support
>=20
> CONFIG_UEFI_CPER=3Dy
> CONFIG_UEFI_CPER_X86=3Dy
> CONFIG_EFI_EARLYCON=3Dy
> CONFIG_EFI_CUSTOM_SSDT_OVERLAYS=3Dy
>=20
> #
> # Tegra firmware driver
> #
> # end of Tegra firmware driver
> # end of Firmware Drivers
>=20
> # CONFIG_GNSS is not set
> # CONFIG_MTD is not set
> # CONFIG_OF is not set
> CONFIG_ARCH_MIGHT_HAVE_PC_PARPORT=3Dy
> CONFIG_PARPORT=3Dm
> CONFIG_PARPORT_PC=3Dm
> CONFIG_PARPORT_SERIAL=3Dm
> # CONFIG_PARPORT_PC_FIFO is not set
> # CONFIG_PARPORT_PC_SUPERIO is not set
> # CONFIG_PARPORT_AX88796 is not set
> CONFIG_PARPORT_1284=3Dy
> CONFIG_PNP=3Dy
> # CONFIG_PNP_DEBUG_MESSAGES is not set
>=20
> #
> # Protocols
> #
> CONFIG_PNPACPI=3Dy
> CONFIG_BLK_DEV=3Dy
> CONFIG_BLK_DEV_NULL_BLK=3Dm
> CONFIG_BLK_DEV_NULL_BLK_FAULT_INJECTION=3Dy
> # CONFIG_BLK_DEV_FD is not set
> CONFIG_CDROM=3Dm
> # CONFIG_PARIDE is not set
> # CONFIG_BLK_DEV_PCIESSD_MTIP32XX is not set
> CONFIG_ZRAM=3Dm
> CONFIG_ZRAM_DEF_COMP_LZORLE=3Dy
> # CONFIG_ZRAM_DEF_COMP_LZO is not set
> CONFIG_ZRAM_DEF_COMP=3D"lzo-rle"
> CONFIG_ZRAM_WRITEBACK=3Dy
> # CONFIG_ZRAM_MEMORY_TRACKING is not set
> CONFIG_BLK_DEV_LOOP=3Dm
> CONFIG_BLK_DEV_LOOP_MIN_COUNT=3D0
> # CONFIG_BLK_DEV_DRBD is not set
> CONFIG_BLK_DEV_NBD=3Dm
> # CONFIG_BLK_DEV_SX8 is not set
> CONFIG_BLK_DEV_RAM=3Dm
> CONFIG_BLK_DEV_RAM_COUNT=3D16
> CONFIG_BLK_DEV_RAM_SIZE=3D16384
> CONFIG_CDROM_PKTCDVD=3Dm
> CONFIG_CDROM_PKTCDVD_BUFFERS=3D8
> # CONFIG_CDROM_PKTCDVD_WCACHE is not set
> # CONFIG_ATA_OVER_ETH is not set
> CONFIG_VIRTIO_BLK=3Dm
> CONFIG_BLK_DEV_RBD=3Dm
>=20
> #
> # NVME Support
> #
> CONFIG_NVME_CORE=3Dm
> CONFIG_BLK_DEV_NVME=3Dm
> CONFIG_NVME_MULTIPATH=3Dy
> # CONFIG_NVME_HWMON is not set
> CONFIG_NVME_FABRICS=3Dm
> # CONFIG_NVME_RDMA is not set
> CONFIG_NVME_FC=3Dm
> # CONFIG_NVME_TCP is not set
> CONFIG_NVME_TARGET=3Dm
> # CONFIG_NVME_TARGET_PASSTHRU is not set
> CONFIG_NVME_TARGET_LOOP=3Dm
> # CONFIG_NVME_TARGET_RDMA is not set
> CONFIG_NVME_TARGET_FC=3Dm
> CONFIG_NVME_TARGET_FCLOOP=3Dm
> # CONFIG_NVME_TARGET_TCP is not set
> # end of NVME Support
>=20
> #
> # Misc devices
> #
> CONFIG_SENSORS_LIS3LV02D=3Dm
> # CONFIG_AD525X_DPOT is not set
> # CONFIG_DUMMY_IRQ is not set
> # CONFIG_IBM_ASM is not set
> # CONFIG_PHANTOM is not set
> CONFIG_TIFM_CORE=3Dm
> CONFIG_TIFM_7XX1=3Dm
> # CONFIG_ICS932S401 is not set
> CONFIG_ENCLOSURE_SERVICES=3Dm
> CONFIG_SGI_XP=3Dm
> CONFIG_HP_ILO=3Dm
> CONFIG_SGI_GRU=3Dm
> # CONFIG_SGI_GRU_DEBUG is not set
> CONFIG_APDS9802ALS=3Dm
> CONFIG_ISL29003=3Dm
> CONFIG_ISL29020=3Dm
> CONFIG_SENSORS_TSL2550=3Dm
> CONFIG_SENSORS_BH1770=3Dm
> CONFIG_SENSORS_APDS990X=3Dm
> # CONFIG_HMC6352 is not set
> # CONFIG_DS1682 is not set
> CONFIG_VMWARE_BALLOON=3Dm
> # CONFIG_LATTICE_ECP3_CONFIG is not set
> # CONFIG_SRAM is not set
> # CONFIG_DW_XDATA_PCIE is not set
> # CONFIG_PCI_ENDPOINT_TEST is not set
> # CONFIG_XILINX_SDFEC is not set
> CONFIG_MISC_RTSX=3Dm
> # CONFIG_C2PORT is not set
>=20
> #
> # EEPROM support
> #
> # CONFIG_EEPROM_AT24 is not set
> # CONFIG_EEPROM_AT25 is not set
> CONFIG_EEPROM_LEGACY=3Dm
> CONFIG_EEPROM_MAX6875=3Dm
> CONFIG_EEPROM_93CX6=3Dm
> # CONFIG_EEPROM_93XX46 is not set
> # CONFIG_EEPROM_IDT_89HPESX is not set
> # CONFIG_EEPROM_EE1004 is not set
> # end of EEPROM support
>=20
> CONFIG_CB710_CORE=3Dm
> # CONFIG_CB710_DEBUG is not set
> CONFIG_CB710_DEBUG_ASSUMPTIONS=3Dy
>=20
> #
> # Texas Instruments shared transport line discipline
> #
> # CONFIG_TI_ST is not set
> # end of Texas Instruments shared transport line discipline
>=20
> CONFIG_SENSORS_LIS3_I2C=3Dm
> CONFIG_ALTERA_STAPL=3Dm
> CONFIG_INTEL_MEI=3Dm
> CONFIG_INTEL_MEI_ME=3Dm
> # CONFIG_INTEL_MEI_TXE is not set
> # CONFIG_INTEL_MEI_HDCP is not set
> # CONFIG_INTEL_MEI_PXP is not set
> CONFIG_VMWARE_VMCI=3Dm
> # CONFIG_GENWQE is not set
> # CONFIG_ECHO is not set
> # CONFIG_BCM_VK is not set
> # CONFIG_MISC_ALCOR_PCI is not set
> CONFIG_MISC_RTSX_PCI=3Dm
> # CONFIG_MISC_RTSX_USB is not set
> # CONFIG_HABANA_AI is not set
> # CONFIG_UACCE is not set
> CONFIG_PVPANIC=3Dy
> # CONFIG_PVPANIC_MMIO is not set
> # CONFIG_PVPANIC_PCI is not set
> # end of Misc devices
>=20
> #
> # SCSI device support
> #
> CONFIG_SCSI_MOD=3Dy
> CONFIG_RAID_ATTRS=3Dm
> CONFIG_SCSI_COMMON=3Dy
> CONFIG_SCSI=3Dy
> CONFIG_SCSI_DMA=3Dy
> CONFIG_SCSI_NETLINK=3Dy
> CONFIG_SCSI_PROC_FS=3Dy
>=20
> #
> # SCSI support type (disk, tape, CD-ROM)
> #
> CONFIG_BLK_DEV_SD=3Dm
> CONFIG_CHR_DEV_ST=3Dm
> CONFIG_BLK_DEV_SR=3Dm
> CONFIG_CHR_DEV_SG=3Dm
> CONFIG_BLK_DEV_BSG=3Dy
> CONFIG_CHR_DEV_SCH=3Dm
> CONFIG_SCSI_ENCLOSURE=3Dm
> CONFIG_SCSI_CONSTANTS=3Dy
> CONFIG_SCSI_LOGGING=3Dy
> CONFIG_SCSI_SCAN_ASYNC=3Dy
>=20
> #
> # SCSI Transports
> #
> CONFIG_SCSI_SPI_ATTRS=3Dm
> CONFIG_SCSI_FC_ATTRS=3Dm
> CONFIG_SCSI_ISCSI_ATTRS=3Dm
> CONFIG_SCSI_SAS_ATTRS=3Dm
> CONFIG_SCSI_SAS_LIBSAS=3Dm
> CONFIG_SCSI_SAS_ATA=3Dy
> CONFIG_SCSI_SAS_HOST_SMP=3Dy
> CONFIG_SCSI_SRP_ATTRS=3Dm
> # end of SCSI Transports
>=20
> CONFIG_SCSI_LOWLEVEL=3Dy
> # CONFIG_ISCSI_TCP is not set
> # CONFIG_ISCSI_BOOT_SYSFS is not set
> # CONFIG_SCSI_CXGB3_ISCSI is not set
> # CONFIG_SCSI_CXGB4_ISCSI is not set
> # CONFIG_SCSI_BNX2_ISCSI is not set
> # CONFIG_BE2ISCSI is not set
> # CONFIG_BLK_DEV_3W_XXXX_RAID is not set
> # CONFIG_SCSI_HPSA is not set
> # CONFIG_SCSI_3W_9XXX is not set
> # CONFIG_SCSI_3W_SAS is not set
> # CONFIG_SCSI_ACARD is not set
> # CONFIG_SCSI_AACRAID is not set
> # CONFIG_SCSI_AIC7XXX is not set
> # CONFIG_SCSI_AIC79XX is not set
> # CONFIG_SCSI_AIC94XX is not set
> # CONFIG_SCSI_MVSAS is not set
> # CONFIG_SCSI_MVUMI is not set
> # CONFIG_SCSI_DPT_I2O is not set
> # CONFIG_SCSI_ADVANSYS is not set
> # CONFIG_SCSI_ARCMSR is not set
> # CONFIG_SCSI_ESAS2R is not set
> # CONFIG_MEGARAID_NEWGEN is not set
> # CONFIG_MEGARAID_LEGACY is not set
> # CONFIG_MEGARAID_SAS is not set
> CONFIG_SCSI_MPT3SAS=3Dm
> CONFIG_SCSI_MPT2SAS_MAX_SGE=3D128
> CONFIG_SCSI_MPT3SAS_MAX_SGE=3D128
> # CONFIG_SCSI_MPT2SAS is not set
> # CONFIG_SCSI_MPI3MR is not set
> # CONFIG_SCSI_SMARTPQI is not set
> # CONFIG_SCSI_UFSHCD is not set
> # CONFIG_SCSI_HPTIOP is not set
> # CONFIG_SCSI_BUSLOGIC is not set
> # CONFIG_SCSI_MYRB is not set
> # CONFIG_SCSI_MYRS is not set
> # CONFIG_VMWARE_PVSCSI is not set
> # CONFIG_LIBFC is not set
> # CONFIG_SCSI_SNIC is not set
> # CONFIG_SCSI_DMX3191D is not set
> # CONFIG_SCSI_FDOMAIN_PCI is not set
> CONFIG_SCSI_ISCI=3Dm
> # CONFIG_SCSI_IPS is not set
> # CONFIG_SCSI_INITIO is not set
> # CONFIG_SCSI_INIA100 is not set
> # CONFIG_SCSI_PPA is not set
> # CONFIG_SCSI_IMM is not set
> # CONFIG_SCSI_STEX is not set
> # CONFIG_SCSI_SYM53C8XX_2 is not set
> # CONFIG_SCSI_IPR is not set
> # CONFIG_SCSI_QLOGIC_1280 is not set
> # CONFIG_SCSI_QLA_FC is not set
> # CONFIG_SCSI_QLA_ISCSI is not set
> # CONFIG_SCSI_LPFC is not set
> # CONFIG_SCSI_EFCT is not set
> # CONFIG_SCSI_DC395x is not set
> # CONFIG_SCSI_AM53C974 is not set
> # CONFIG_SCSI_WD719X is not set
> CONFIG_SCSI_DEBUG=3Dm
> # CONFIG_SCSI_PMCRAID is not set
> # CONFIG_SCSI_PM8001 is not set
> # CONFIG_SCSI_BFA_FC is not set
> # CONFIG_SCSI_VIRTIO is not set
> # CONFIG_SCSI_CHELSIO_FCOE is not set
> CONFIG_SCSI_DH=3Dy
> CONFIG_SCSI_DH_RDAC=3Dy
> CONFIG_SCSI_DH_HP_SW=3Dy
> CONFIG_SCSI_DH_EMC=3Dy
> CONFIG_SCSI_DH_ALUA=3Dy
> # end of SCSI device support
>=20
> CONFIG_ATA=3Dm
> CONFIG_SATA_HOST=3Dy
> CONFIG_PATA_TIMINGS=3Dy
> CONFIG_ATA_VERBOSE_ERROR=3Dy
> CONFIG_ATA_FORCE=3Dy
> CONFIG_ATA_ACPI=3Dy
> # CONFIG_SATA_ZPODD is not set
> CONFIG_SATA_PMP=3Dy
>=20
> #
> # Controllers with non-SFF native interface
> #
> CONFIG_SATA_AHCI=3Dm
> CONFIG_SATA_MOBILE_LPM_POLICY=3D0
> CONFIG_SATA_AHCI_PLATFORM=3Dm
> # CONFIG_SATA_INIC162X is not set
> # CONFIG_SATA_ACARD_AHCI is not set
> # CONFIG_SATA_SIL24 is not set
> CONFIG_ATA_SFF=3Dy
>=20
> #
> # SFF controllers with custom DMA interface
> #
> # CONFIG_PDC_ADMA is not set
> # CONFIG_SATA_QSTOR is not set
> # CONFIG_SATA_SX4 is not set
> CONFIG_ATA_BMDMA=3Dy
>=20
> #
> # SATA SFF controllers with BMDMA
> #
> CONFIG_ATA_PIIX=3Dm
> # CONFIG_SATA_DWC is not set
> # CONFIG_SATA_MV is not set
> # CONFIG_SATA_NV is not set
> # CONFIG_SATA_PROMISE is not set
> # CONFIG_SATA_SIL is not set
> # CONFIG_SATA_SIS is not set
> # CONFIG_SATA_SVW is not set
> # CONFIG_SATA_ULI is not set
> # CONFIG_SATA_VIA is not set
> # CONFIG_SATA_VITESSE is not set
>=20
> #
> # PATA SFF controllers with BMDMA
> #
> # CONFIG_PATA_ALI is not set
> # CONFIG_PATA_AMD is not set
> # CONFIG_PATA_ARTOP is not set
> # CONFIG_PATA_ATIIXP is not set
> # CONFIG_PATA_ATP867X is not set
> # CONFIG_PATA_CMD64X is not set
> # CONFIG_PATA_CYPRESS is not set
> # CONFIG_PATA_EFAR is not set
> # CONFIG_PATA_HPT366 is not set
> # CONFIG_PATA_HPT37X is not set
> # CONFIG_PATA_HPT3X2N is not set
> # CONFIG_PATA_HPT3X3 is not set
> # CONFIG_PATA_IT8213 is not set
> # CONFIG_PATA_IT821X is not set
> # CONFIG_PATA_JMICRON is not set
> # CONFIG_PATA_MARVELL is not set
> # CONFIG_PATA_NETCELL is not set
> # CONFIG_PATA_NINJA32 is not set
> # CONFIG_PATA_NS87415 is not set
> # CONFIG_PATA_OLDPIIX is not set
> # CONFIG_PATA_OPTIDMA is not set
> # CONFIG_PATA_PDC2027X is not set
> # CONFIG_PATA_PDC_OLD is not set
> # CONFIG_PATA_RADISYS is not set
> # CONFIG_PATA_RDC is not set
> # CONFIG_PATA_SCH is not set
> # CONFIG_PATA_SERVERWORKS is not set
> # CONFIG_PATA_SIL680 is not set
> # CONFIG_PATA_SIS is not set
> # CONFIG_PATA_TOSHIBA is not set
> # CONFIG_PATA_TRIFLEX is not set
> # CONFIG_PATA_VIA is not set
> # CONFIG_PATA_WINBOND is not set
>=20
> #
> # PIO-only SFF controllers
> #
> # CONFIG_PATA_CMD640_PCI is not set
> # CONFIG_PATA_MPIIX is not set
> # CONFIG_PATA_NS87410 is not set
> # CONFIG_PATA_OPTI is not set
> # CONFIG_PATA_RZ1000 is not set
>=20
> #
> # Generic fallback / legacy drivers
> #
> # CONFIG_PATA_ACPI is not set
> CONFIG_ATA_GENERIC=3Dm
> # CONFIG_PATA_LEGACY is not set
> CONFIG_MD=3Dy
> CONFIG_BLK_DEV_MD=3Dy
> CONFIG_MD_AUTODETECT=3Dy
> CONFIG_MD_LINEAR=3Dm
> CONFIG_MD_RAID0=3Dm
> CONFIG_MD_RAID1=3Dm
> CONFIG_MD_RAID10=3Dm
> CONFIG_MD_RAID456=3Dm
> CONFIG_MD_MULTIPATH=3Dm
> CONFIG_MD_FAULTY=3Dm
> CONFIG_MD_CLUSTER=3Dm
> # CONFIG_BCACHE is not set
> CONFIG_BLK_DEV_DM_BUILTIN=3Dy
> CONFIG_BLK_DEV_DM=3Dm
> CONFIG_DM_DEBUG=3Dy
> CONFIG_DM_BUFIO=3Dm
> # CONFIG_DM_DEBUG_BLOCK_MANAGER_LOCKING is not set
> CONFIG_DM_BIO_PRISON=3Dm
> CONFIG_DM_PERSISTENT_DATA=3Dm
> # CONFIG_DM_UNSTRIPED is not set
> CONFIG_DM_CRYPT=3Dm
> CONFIG_DM_SNAPSHOT=3Dm
> CONFIG_DM_THIN_PROVISIONING=3Dm
> CONFIG_DM_CACHE=3Dm
> CONFIG_DM_CACHE_SMQ=3Dm
> CONFIG_DM_WRITECACHE=3Dm
> # CONFIG_DM_EBS is not set
> CONFIG_DM_ERA=3Dm
> # CONFIG_DM_CLONE is not set
> CONFIG_DM_MIRROR=3Dm
> CONFIG_DM_LOG_USERSPACE=3Dm
> CONFIG_DM_RAID=3Dm
> CONFIG_DM_ZERO=3Dm
> CONFIG_DM_MULTIPATH=3Dm
> CONFIG_DM_MULTIPATH_QL=3Dm
> CONFIG_DM_MULTIPATH_ST=3Dm
> # CONFIG_DM_MULTIPATH_HST is not set
> # CONFIG_DM_MULTIPATH_IOA is not set
> CONFIG_DM_DELAY=3Dm
> # CONFIG_DM_DUST is not set
> CONFIG_DM_UEVENT=3Dy
> CONFIG_DM_FLAKEY=3Dm
> CONFIG_DM_VERITY=3Dm
> # CONFIG_DM_VERITY_VERIFY_ROOTHASH_SIG is not set
> # CONFIG_DM_VERITY_FEC is not set
> CONFIG_DM_SWITCH=3Dm
> CONFIG_DM_LOG_WRITES=3Dm
> CONFIG_DM_INTEGRITY=3Dm
> # CONFIG_DM_ZONED is not set
> CONFIG_DM_AUDIT=3Dy
> CONFIG_TARGET_CORE=3Dm
> CONFIG_TCM_IBLOCK=3Dm
> CONFIG_TCM_FILEIO=3Dm
> CONFIG_TCM_PSCSI=3Dm
> CONFIG_TCM_USER2=3Dm
> CONFIG_LOOPBACK_TARGET=3Dm
> CONFIG_ISCSI_TARGET=3Dm
> # CONFIG_SBP_TARGET is not set
> # CONFIG_FUSION is not set
>=20
> #
> # IEEE 1394 (FireWire) support
> #
> CONFIG_FIREWIRE=3Dm
> CONFIG_FIREWIRE_OHCI=3Dm
> CONFIG_FIREWIRE_SBP2=3Dm
> CONFIG_FIREWIRE_NET=3Dm
> # CONFIG_FIREWIRE_NOSY is not set
> # end of IEEE 1394 (FireWire) support
>=20
> CONFIG_MACINTOSH_DRIVERS=3Dy
> CONFIG_MAC_EMUMOUSEBTN=3Dy
> CONFIG_NETDEVICES=3Dy
> CONFIG_MII=3Dy
> CONFIG_NET_CORE=3Dy
> # CONFIG_BONDING is not set
> CONFIG_DUMMY=3Dm
> # CONFIG_WIREGUARD is not set
> # CONFIG_EQUALIZER is not set
> # CONFIG_NET_FC is not set
> # CONFIG_IFB is not set
> # CONFIG_NET_TEAM is not set
> # CONFIG_MACVLAN is not set
> # CONFIG_IPVLAN is not set
> # CONFIG_VXLAN is not set
> # CONFIG_GENEVE is not set
> # CONFIG_BAREUDP is not set
> # CONFIG_GTP is not set
> # CONFIG_AMT is not set
> # CONFIG_MACSEC is not set
> CONFIG_NETCONSOLE=3Dm
> CONFIG_NETCONSOLE_DYNAMIC=3Dy
> CONFIG_NETPOLL=3Dy
> CONFIG_NET_POLL_CONTROLLER=3Dy
> CONFIG_TUN=3Dm
> # CONFIG_TUN_VNET_CROSS_LE is not set
> CONFIG_VETH=3Dm
> CONFIG_VIRTIO_NET=3Dm
> # CONFIG_NLMON is not set
> # CONFIG_NET_VRF is not set
> # CONFIG_VSOCKMON is not set
> # CONFIG_ARCNET is not set
> CONFIG_ATM_DRIVERS=3Dy
> # CONFIG_ATM_DUMMY is not set
> # CONFIG_ATM_TCP is not set
> # CONFIG_ATM_LANAI is not set
> # CONFIG_ATM_ENI is not set
> # CONFIG_ATM_FIRESTREAM is not set
> # CONFIG_ATM_ZATM is not set
> # CONFIG_ATM_NICSTAR is not set
> # CONFIG_ATM_IDT77252 is not set
> # CONFIG_ATM_AMBASSADOR is not set
> # CONFIG_ATM_HORIZON is not set
> # CONFIG_ATM_IA is not set
> # CONFIG_ATM_FORE200E is not set
> # CONFIG_ATM_HE is not set
> # CONFIG_ATM_SOLOS is not set
> CONFIG_ETHERNET=3Dy
> CONFIG_MDIO=3Dy
> # CONFIG_NET_VENDOR_3COM is not set
> CONFIG_NET_VENDOR_ADAPTEC=3Dy
> # CONFIG_ADAPTEC_STARFIRE is not set
> CONFIG_NET_VENDOR_AGERE=3Dy
> # CONFIG_ET131X is not set
> CONFIG_NET_VENDOR_ALACRITECH=3Dy
> # CONFIG_SLICOSS is not set
> CONFIG_NET_VENDOR_ALTEON=3Dy
> # CONFIG_ACENIC is not set
> # CONFIG_ALTERA_TSE is not set
> CONFIG_NET_VENDOR_AMAZON=3Dy
> # CONFIG_ENA_ETHERNET is not set
> # CONFIG_NET_VENDOR_AMD is not set
> CONFIG_NET_VENDOR_AQUANTIA=3Dy
> # CONFIG_AQTION is not set
> CONFIG_NET_VENDOR_ARC=3Dy
> CONFIG_NET_VENDOR_ASIX=3Dy
> # CONFIG_SPI_AX88796C is not set
> CONFIG_NET_VENDOR_ATHEROS=3Dy
> # CONFIG_ATL2 is not set
> # CONFIG_ATL1 is not set
> # CONFIG_ATL1E is not set
> # CONFIG_ATL1C is not set
> # CONFIG_ALX is not set
> CONFIG_NET_VENDOR_BROADCOM=3Dy
> # CONFIG_B44 is not set
> # CONFIG_BCMGENET is not set
> # CONFIG_BNX2 is not set
> # CONFIG_CNIC is not set
> # CONFIG_TIGON3 is not set
> # CONFIG_BNX2X is not set
> # CONFIG_SYSTEMPORT is not set
> # CONFIG_BNXT is not set
> CONFIG_NET_VENDOR_BROCADE=3Dy
> # CONFIG_BNA is not set
> CONFIG_NET_VENDOR_CADENCE=3Dy
> # CONFIG_MACB is not set
> CONFIG_NET_VENDOR_CAVIUM=3Dy
> # CONFIG_THUNDER_NIC_PF is not set
> # CONFIG_THUNDER_NIC_VF is not set
> # CONFIG_THUNDER_NIC_BGX is not set
> # CONFIG_THUNDER_NIC_RGX is not set
> CONFIG_CAVIUM_PTP=3Dy
> # CONFIG_LIQUIDIO is not set
> # CONFIG_LIQUIDIO_VF is not set
> CONFIG_NET_VENDOR_CHELSIO=3Dy
> # CONFIG_CHELSIO_T1 is not set
> # CONFIG_CHELSIO_T3 is not set
> # CONFIG_CHELSIO_T4 is not set
> # CONFIG_CHELSIO_T4VF is not set
> CONFIG_NET_VENDOR_CISCO=3Dy
> # CONFIG_ENIC is not set
> CONFIG_NET_VENDOR_CORTINA=3Dy
> # CONFIG_CX_ECAT is not set
> # CONFIG_DNET is not set
> CONFIG_NET_VENDOR_DEC=3Dy
> # CONFIG_NET_TULIP is not set
> CONFIG_NET_VENDOR_DLINK=3Dy
> # CONFIG_DL2K is not set
> # CONFIG_SUNDANCE is not set
> CONFIG_NET_VENDOR_EMULEX=3Dy
> # CONFIG_BE2NET is not set
> CONFIG_NET_VENDOR_ENGLEDER=3Dy
> # CONFIG_TSNEP is not set
> CONFIG_NET_VENDOR_EZCHIP=3Dy
> CONFIG_NET_VENDOR_GOOGLE=3Dy
> # CONFIG_GVE is not set
> CONFIG_NET_VENDOR_HUAWEI=3Dy
> # CONFIG_HINIC is not set
> CONFIG_NET_VENDOR_I825XX=3Dy
> CONFIG_NET_VENDOR_INTEL=3Dy
> # CONFIG_E100 is not set
> CONFIG_E1000=3Dy
> CONFIG_E1000E=3Dy
> CONFIG_E1000E_HWTS=3Dy
> CONFIG_IGB=3Dy
> CONFIG_IGB_HWMON=3Dy
> # CONFIG_IGBVF is not set
> # CONFIG_IXGB is not set
> CONFIG_IXGBE=3Dy
> CONFIG_IXGBE_HWMON=3Dy
> # CONFIG_IXGBE_DCB is not set
> CONFIG_IXGBE_IPSEC=3Dy
> # CONFIG_IXGBEVF is not set
> CONFIG_I40E=3Dy
> # CONFIG_I40E_DCB is not set
> # CONFIG_I40EVF is not set
> # CONFIG_ICE is not set
> # CONFIG_FM10K is not set
> CONFIG_IGC=3Dy
> CONFIG_NET_VENDOR_MICROSOFT=3Dy
> # CONFIG_JME is not set
> CONFIG_NET_VENDOR_LITEX=3Dy
> CONFIG_NET_VENDOR_MARVELL=3Dy
> # CONFIG_MVMDIO is not set
> # CONFIG_SKGE is not set
> # CONFIG_SKY2 is not set
> # CONFIG_PRESTERA is not set
> CONFIG_NET_VENDOR_MELLANOX=3Dy
> # CONFIG_MLX4_EN is not set
> # CONFIG_MLX5_CORE is not set
> # CONFIG_MLXSW_CORE is not set
> # CONFIG_MLXFW is not set
> CONFIG_NET_VENDOR_MICREL=3Dy
> # CONFIG_KS8842 is not set
> # CONFIG_KS8851 is not set
> # CONFIG_KS8851_MLL is not set
> # CONFIG_KSZ884X_PCI is not set
> CONFIG_NET_VENDOR_MICROCHIP=3Dy
> # CONFIG_ENC28J60 is not set
> # CONFIG_ENCX24J600 is not set
> # CONFIG_LAN743X is not set
> CONFIG_NET_VENDOR_MICROSEMI=3Dy
> CONFIG_NET_VENDOR_MYRI=3Dy
> # CONFIG_MYRI10GE is not set
> # CONFIG_FEALNX is not set
> CONFIG_NET_VENDOR_NATSEMI=3Dy
> # CONFIG_NATSEMI is not set
> # CONFIG_NS83820 is not set
> CONFIG_NET_VENDOR_NETERION=3Dy
> # CONFIG_S2IO is not set
> # CONFIG_VXGE is not set
> CONFIG_NET_VENDOR_NETRONOME=3Dy
> # CONFIG_NFP is not set
> CONFIG_NET_VENDOR_NI=3Dy
> # CONFIG_NI_XGE_MANAGEMENT_ENET is not set
> CONFIG_NET_VENDOR_8390=3Dy
> # CONFIG_NE2K_PCI is not set
> CONFIG_NET_VENDOR_NVIDIA=3Dy
> # CONFIG_FORCEDETH is not set
> CONFIG_NET_VENDOR_OKI=3Dy
> # CONFIG_ETHOC is not set
> CONFIG_NET_VENDOR_PACKET_ENGINES=3Dy
> # CONFIG_HAMACHI is not set
> # CONFIG_YELLOWFIN is not set
> CONFIG_NET_VENDOR_PENSANDO=3Dy
> # CONFIG_IONIC is not set
> CONFIG_NET_VENDOR_QLOGIC=3Dy
> # CONFIG_QLA3XXX is not set
> # CONFIG_QLCNIC is not set
> # CONFIG_NETXEN_NIC is not set
> # CONFIG_QED is not set
> CONFIG_NET_VENDOR_QUALCOMM=3Dy
> # CONFIG_QCOM_EMAC is not set
> # CONFIG_RMNET is not set
> CONFIG_NET_VENDOR_RDC=3Dy
> # CONFIG_R6040 is not set
> CONFIG_NET_VENDOR_REALTEK=3Dy
> # CONFIG_ATP is not set
> # CONFIG_8139CP is not set
> # CONFIG_8139TOO is not set
> CONFIG_R8169=3Dy
> CONFIG_NET_VENDOR_RENESAS=3Dy
> CONFIG_NET_VENDOR_ROCKER=3Dy
> # CONFIG_ROCKER is not set
> CONFIG_NET_VENDOR_SAMSUNG=3Dy
> # CONFIG_SXGBE_ETH is not set
> CONFIG_NET_VENDOR_SEEQ=3Dy
> CONFIG_NET_VENDOR_SOLARFLARE=3Dy
> # CONFIG_SFC is not set
> # CONFIG_SFC_FALCON is not set
> CONFIG_NET_VENDOR_SILAN=3Dy
> # CONFIG_SC92031 is not set
> CONFIG_NET_VENDOR_SIS=3Dy
> # CONFIG_SIS900 is not set
> # CONFIG_SIS190 is not set
> CONFIG_NET_VENDOR_SMSC=3Dy
> # CONFIG_EPIC100 is not set
> # CONFIG_SMSC911X is not set
> # CONFIG_SMSC9420 is not set
> CONFIG_NET_VENDOR_SOCIONEXT=3Dy
> CONFIG_NET_VENDOR_STMICRO=3Dy
> # CONFIG_STMMAC_ETH is not set
> CONFIG_NET_VENDOR_SUN=3Dy
> # CONFIG_HAPPYMEAL is not set
> # CONFIG_SUNGEM is not set
> # CONFIG_CASSINI is not set
> # CONFIG_NIU is not set
> CONFIG_NET_VENDOR_SYNOPSYS=3Dy
> # CONFIG_DWC_XLGMAC is not set
> CONFIG_NET_VENDOR_TEHUTI=3Dy
> # CONFIG_TEHUTI is not set
> CONFIG_NET_VENDOR_TI=3Dy
> # CONFIG_TI_CPSW_PHY_SEL is not set
> # CONFIG_TLAN is not set
> CONFIG_NET_VENDOR_VERTEXCOM=3Dy
> # CONFIG_MSE102X is not set
> CONFIG_NET_VENDOR_VIA=3Dy
> # CONFIG_VIA_RHINE is not set
> # CONFIG_VIA_VELOCITY is not set
> CONFIG_NET_VENDOR_WIZNET=3Dy
> # CONFIG_WIZNET_W5100 is not set
> # CONFIG_WIZNET_W5300 is not set
> CONFIG_NET_VENDOR_XILINX=3Dy
> # CONFIG_XILINX_EMACLITE is not set
> # CONFIG_XILINX_AXI_EMAC is not set
> # CONFIG_XILINX_LL_TEMAC is not set
> # CONFIG_FDDI is not set
> # CONFIG_HIPPI is not set
> # CONFIG_NET_SB1000 is not set
> CONFIG_PHYLIB=3Dy
> CONFIG_SWPHY=3Dy
> # CONFIG_LED_TRIGGER_PHY is not set
> CONFIG_FIXED_PHY=3Dy
>=20
> #
> # MII PHY device drivers
> #
> # CONFIG_AMD_PHY is not set
> # CONFIG_ADIN_PHY is not set
> # CONFIG_AQUANTIA_PHY is not set
> CONFIG_AX88796B_PHY=3Dy
> # CONFIG_BROADCOM_PHY is not set
> # CONFIG_BCM54140_PHY is not set
> # CONFIG_BCM7XXX_PHY is not set
> # CONFIG_BCM84881_PHY is not set
> # CONFIG_BCM87XX_PHY is not set
> # CONFIG_CICADA_PHY is not set
> # CONFIG_CORTINA_PHY is not set
> # CONFIG_DAVICOM_PHY is not set
> # CONFIG_ICPLUS_PHY is not set
> # CONFIG_LXT_PHY is not set
> # CONFIG_INTEL_XWAY_PHY is not set
> # CONFIG_LSI_ET1011C_PHY is not set
> # CONFIG_MARVELL_PHY is not set
> # CONFIG_MARVELL_10G_PHY is not set
> # CONFIG_MARVELL_88X2222_PHY is not set
> # CONFIG_MAXLINEAR_GPHY is not set
> # CONFIG_MEDIATEK_GE_PHY is not set
> # CONFIG_MICREL_PHY is not set
> # CONFIG_MICROCHIP_PHY is not set
> # CONFIG_MICROCHIP_T1_PHY is not set
> # CONFIG_MICROSEMI_PHY is not set
> # CONFIG_MOTORCOMM_PHY is not set
> # CONFIG_NATIONAL_PHY is not set
> # CONFIG_NXP_C45_TJA11XX_PHY is not set
> # CONFIG_NXP_TJA11XX_PHY is not set
> # CONFIG_QSEMI_PHY is not set
> CONFIG_REALTEK_PHY=3Dy
> # CONFIG_RENESAS_PHY is not set
> # CONFIG_ROCKCHIP_PHY is not set
> # CONFIG_SMSC_PHY is not set
> # CONFIG_STE10XP is not set
> # CONFIG_TERANETICS_PHY is not set
> # CONFIG_DP83822_PHY is not set
> # CONFIG_DP83TC811_PHY is not set
> # CONFIG_DP83848_PHY is not set
> # CONFIG_DP83867_PHY is not set
> # CONFIG_DP83869_PHY is not set
> # CONFIG_VITESSE_PHY is not set
> # CONFIG_XILINX_GMII2RGMII is not set
> # CONFIG_MICREL_KS8995MA is not set
> CONFIG_MDIO_DEVICE=3Dy
> CONFIG_MDIO_BUS=3Dy
> CONFIG_FWNODE_MDIO=3Dy
> CONFIG_ACPI_MDIO=3Dy
> CONFIG_MDIO_DEVRES=3Dy
> # CONFIG_MDIO_BITBANG is not set
> # CONFIG_MDIO_BCM_UNIMAC is not set
> # CONFIG_MDIO_MVUSB is not set
> # CONFIG_MDIO_THUNDER is not set
>=20
> #
> # MDIO Multiplexers
> #
>=20
> #
> # PCS device drivers
> #
> # CONFIG_PCS_XPCS is not set
> # end of PCS device drivers
>=20
> # CONFIG_PLIP is not set
> # CONFIG_PPP is not set
> # CONFIG_SLIP is not set
> CONFIG_USB_NET_DRIVERS=3Dy
> # CONFIG_USB_CATC is not set
> # CONFIG_USB_KAWETH is not set
> # CONFIG_USB_PEGASUS is not set
> # CONFIG_USB_RTL8150 is not set
> CONFIG_USB_RTL8152=3Dy
> # CONFIG_USB_LAN78XX is not set
> CONFIG_USB_USBNET=3Dy
> CONFIG_USB_NET_AX8817X=3Dy
> CONFIG_USB_NET_AX88179_178A=3Dy
> # CONFIG_USB_NET_CDCETHER is not set
> # CONFIG_USB_NET_CDC_EEM is not set
> # CONFIG_USB_NET_CDC_NCM is not set
> # CONFIG_USB_NET_HUAWEI_CDC_NCM is not set
> # CONFIG_USB_NET_CDC_MBIM is not set
> # CONFIG_USB_NET_DM9601 is not set
> # CONFIG_USB_NET_SR9700 is not set
> # CONFIG_USB_NET_SR9800 is not set
> # CONFIG_USB_NET_SMSC75XX is not set
> # CONFIG_USB_NET_SMSC95XX is not set
> # CONFIG_USB_NET_GL620A is not set
> # CONFIG_USB_NET_NET1080 is not set
> # CONFIG_USB_NET_PLUSB is not set
> # CONFIG_USB_NET_MCS7830 is not set
> # CONFIG_USB_NET_RNDIS_HOST is not set
> # CONFIG_USB_NET_CDC_SUBSET is not set
> # CONFIG_USB_NET_ZAURUS is not set
> # CONFIG_USB_NET_CX82310_ETH is not set
> # CONFIG_USB_NET_KALMIA is not set
> # CONFIG_USB_NET_QMI_WWAN is not set
> # CONFIG_USB_HSO is not set
> # CONFIG_USB_NET_INT51X1 is not set
> # CONFIG_USB_IPHETH is not set
> # CONFIG_USB_SIERRA_NET is not set
> # CONFIG_USB_NET_CH9200 is not set
> # CONFIG_USB_NET_AQC111 is not set
> CONFIG_WLAN=3Dy
> CONFIG_WLAN_VENDOR_ADMTEK=3Dy
> # CONFIG_ADM8211 is not set
> CONFIG_WLAN_VENDOR_ATH=3Dy
> # CONFIG_ATH_DEBUG is not set
> # CONFIG_ATH5K is not set
> # CONFIG_ATH5K_PCI is not set
> # CONFIG_ATH9K is not set
> # CONFIG_ATH9K_HTC is not set
> # CONFIG_CARL9170 is not set
> # CONFIG_ATH6KL is not set
> # CONFIG_AR5523 is not set
> # CONFIG_WIL6210 is not set
> # CONFIG_ATH10K is not set
> # CONFIG_WCN36XX is not set
> # CONFIG_ATH11K is not set
> CONFIG_WLAN_VENDOR_ATMEL=3Dy
> # CONFIG_ATMEL is not set
> # CONFIG_AT76C50X_USB is not set
> CONFIG_WLAN_VENDOR_BROADCOM=3Dy
> # CONFIG_B43 is not set
> # CONFIG_B43LEGACY is not set
> # CONFIG_BRCMSMAC is not set
> # CONFIG_BRCMFMAC is not set
> CONFIG_WLAN_VENDOR_CISCO=3Dy
> # CONFIG_AIRO is not set
> CONFIG_WLAN_VENDOR_INTEL=3Dy
> # CONFIG_IPW2100 is not set
> # CONFIG_IPW2200 is not set
> # CONFIG_IWL4965 is not set
> # CONFIG_IWL3945 is not set
> # CONFIG_IWLWIFI is not set
> # CONFIG_IWLMEI is not set
> CONFIG_WLAN_VENDOR_INTERSIL=3Dy
> # CONFIG_HOSTAP is not set
> # CONFIG_HERMES is not set
> # CONFIG_P54_COMMON is not set
> CONFIG_WLAN_VENDOR_MARVELL=3Dy
> # CONFIG_LIBERTAS is not set
> # CONFIG_LIBERTAS_THINFIRM is not set
> # CONFIG_MWIFIEX is not set
> # CONFIG_MWL8K is not set
> # CONFIG_WLAN_VENDOR_MEDIATEK is not set
> CONFIG_WLAN_VENDOR_MICROCHIP=3Dy
> # CONFIG_WILC1000_SDIO is not set
> # CONFIG_WILC1000_SPI is not set
> CONFIG_WLAN_VENDOR_RALINK=3Dy
> # CONFIG_RT2X00 is not set
> CONFIG_WLAN_VENDOR_REALTEK=3Dy
> # CONFIG_RTL8180 is not set
> # CONFIG_RTL8187 is not set
> CONFIG_RTL_CARDS=3Dm
> # CONFIG_RTL8192CE is not set
> # CONFIG_RTL8192SE is not set
> # CONFIG_RTL8192DE is not set
> # CONFIG_RTL8723AE is not set
> # CONFIG_RTL8723BE is not set
> # CONFIG_RTL8188EE is not set
> # CONFIG_RTL8192EE is not set
> # CONFIG_RTL8821AE is not set
> # CONFIG_RTL8192CU is not set
> # CONFIG_RTL8XXXU is not set
> # CONFIG_RTW88 is not set
> # CONFIG_RTW89 is not set
> CONFIG_WLAN_VENDOR_RSI=3Dy
> # CONFIG_RSI_91X is not set
> CONFIG_WLAN_VENDOR_ST=3Dy
> # CONFIG_CW1200 is not set
> CONFIG_WLAN_VENDOR_TI=3Dy
> # CONFIG_WL1251 is not set
> # CONFIG_WL12XX is not set
> # CONFIG_WL18XX is not set
> # CONFIG_WLCORE is not set
> CONFIG_WLAN_VENDOR_ZYDAS=3Dy
> # CONFIG_USB_ZD1201 is not set
> # CONFIG_ZD1211RW is not set
> CONFIG_WLAN_VENDOR_QUANTENNA=3Dy
> # CONFIG_QTNFMAC_PCIE is not set
> CONFIG_MAC80211_HWSIM=3Dm
> # CONFIG_USB_NET_RNDIS_WLAN is not set
> # CONFIG_VIRT_WIFI is not set
> # CONFIG_WAN is not set
> CONFIG_IEEE802154_DRIVERS=3Dm
> # CONFIG_IEEE802154_FAKELB is not set
> # CONFIG_IEEE802154_AT86RF230 is not set
> # CONFIG_IEEE802154_MRF24J40 is not set
> # CONFIG_IEEE802154_CC2520 is not set
> # CONFIG_IEEE802154_ATUSB is not set
> # CONFIG_IEEE802154_ADF7242 is not set
> # CONFIG_IEEE802154_CA8210 is not set
> # CONFIG_IEEE802154_MCR20A is not set
> # CONFIG_IEEE802154_HWSIM is not set
>=20
> #
> # Wireless WAN
> #
> # CONFIG_WWAN is not set
> # end of Wireless WAN
>=20
> # CONFIG_VMXNET3 is not set
> # CONFIG_FUJITSU_ES is not set
> # CONFIG_NETDEVSIM is not set
> CONFIG_NET_FAILOVER=3Dm
> # CONFIG_ISDN is not set
>=20
> #
> # Input device support
> #
> CONFIG_INPUT=3Dy
> CONFIG_INPUT_LEDS=3Dy
> CONFIG_INPUT_FF_MEMLESS=3Dm
> CONFIG_INPUT_SPARSEKMAP=3Dm
> # CONFIG_INPUT_MATRIXKMAP is not set
>=20
> #
> # Userland interfaces
> #
> CONFIG_INPUT_MOUSEDEV=3Dy
> # CONFIG_INPUT_MOUSEDEV_PSAUX is not set
> CONFIG_INPUT_MOUSEDEV_SCREEN_X=3D1024
> CONFIG_INPUT_MOUSEDEV_SCREEN_Y=3D768
> CONFIG_INPUT_JOYDEV=3Dm
> CONFIG_INPUT_EVDEV=3Dy
> # CONFIG_INPUT_EVBUG is not set
>=20
> #
> # Input Device Drivers
> #
> CONFIG_INPUT_KEYBOARD=3Dy
> # CONFIG_KEYBOARD_ADP5588 is not set
> # CONFIG_KEYBOARD_ADP5589 is not set
> # CONFIG_KEYBOARD_APPLESPI is not set
> CONFIG_KEYBOARD_ATKBD=3Dy
> # CONFIG_KEYBOARD_QT1050 is not set
> # CONFIG_KEYBOARD_QT1070 is not set
> # CONFIG_KEYBOARD_QT2160 is not set
> # CONFIG_KEYBOARD_DLINK_DIR685 is not set
> # CONFIG_KEYBOARD_LKKBD is not set
> # CONFIG_KEYBOARD_GPIO is not set
> # CONFIG_KEYBOARD_GPIO_POLLED is not set
> # CONFIG_KEYBOARD_TCA6416 is not set
> # CONFIG_KEYBOARD_TCA8418 is not set
> # CONFIG_KEYBOARD_MATRIX is not set
> # CONFIG_KEYBOARD_LM8323 is not set
> # CONFIG_KEYBOARD_LM8333 is not set
> # CONFIG_KEYBOARD_MAX7359 is not set
> # CONFIG_KEYBOARD_MCS is not set
> # CONFIG_KEYBOARD_MPR121 is not set
> # CONFIG_KEYBOARD_NEWTON is not set
> # CONFIG_KEYBOARD_OPENCORES is not set
> # CONFIG_KEYBOARD_SAMSUNG is not set
> # CONFIG_KEYBOARD_STOWAWAY is not set
> # CONFIG_KEYBOARD_SUNKBD is not set
> # CONFIG_KEYBOARD_TM2_TOUCHKEY is not set
> # CONFIG_KEYBOARD_XTKBD is not set
> # CONFIG_KEYBOARD_CYPRESS_SF is not set
> CONFIG_INPUT_MOUSE=3Dy
> CONFIG_MOUSE_PS2=3Dy
> CONFIG_MOUSE_PS2_ALPS=3Dy
> CONFIG_MOUSE_PS2_BYD=3Dy
> CONFIG_MOUSE_PS2_LOGIPS2PP=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS=3Dy
> CONFIG_MOUSE_PS2_SYNAPTICS_SMBUS=3Dy
> CONFIG_MOUSE_PS2_CYPRESS=3Dy
> CONFIG_MOUSE_PS2_LIFEBOOK=3Dy
> CONFIG_MOUSE_PS2_TRACKPOINT=3Dy
> CONFIG_MOUSE_PS2_ELANTECH=3Dy
> CONFIG_MOUSE_PS2_ELANTECH_SMBUS=3Dy
> CONFIG_MOUSE_PS2_SENTELIC=3Dy
> # CONFIG_MOUSE_PS2_TOUCHKIT is not set
> CONFIG_MOUSE_PS2_FOCALTECH=3Dy
> CONFIG_MOUSE_PS2_VMMOUSE=3Dy
> CONFIG_MOUSE_PS2_SMBUS=3Dy
> CONFIG_MOUSE_SERIAL=3Dm
> # CONFIG_MOUSE_APPLETOUCH is not set
> # CONFIG_MOUSE_BCM5974 is not set
> CONFIG_MOUSE_CYAPA=3Dm
> CONFIG_MOUSE_ELAN_I2C=3Dm
> CONFIG_MOUSE_ELAN_I2C_I2C=3Dy
> CONFIG_MOUSE_ELAN_I2C_SMBUS=3Dy
> CONFIG_MOUSE_VSXXXAA=3Dm
> # CONFIG_MOUSE_GPIO is not set
> CONFIG_MOUSE_SYNAPTICS_I2C=3Dm
> # CONFIG_MOUSE_SYNAPTICS_USB is not set
> # CONFIG_INPUT_JOYSTICK is not set
> # CONFIG_INPUT_TABLET is not set
> # CONFIG_INPUT_TOUCHSCREEN is not set
> CONFIG_INPUT_MISC=3Dy
> # CONFIG_INPUT_AD714X is not set
> # CONFIG_INPUT_BMA150 is not set
> # CONFIG_INPUT_E3X0_BUTTON is not set
> # CONFIG_INPUT_PCSPKR is not set
> # CONFIG_INPUT_MMA8450 is not set
> # CONFIG_INPUT_APANEL is not set
> # CONFIG_INPUT_GPIO_BEEPER is not set
> # CONFIG_INPUT_GPIO_DECODER is not set
> # CONFIG_INPUT_GPIO_VIBRA is not set
> # CONFIG_INPUT_ATLAS_BTNS is not set
> # CONFIG_INPUT_ATI_REMOTE2 is not set
> # CONFIG_INPUT_KEYSPAN_REMOTE is not set
> # CONFIG_INPUT_KXTJ9 is not set
> # CONFIG_INPUT_POWERMATE is not set
> # CONFIG_INPUT_YEALINK is not set
> # CONFIG_INPUT_CM109 is not set
> CONFIG_INPUT_UINPUT=3Dy
> # CONFIG_INPUT_PCF8574 is not set
> # CONFIG_INPUT_PWM_BEEPER is not set
> # CONFIG_INPUT_PWM_VIBRA is not set
> # CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
> # CONFIG_INPUT_DA7280_HAPTICS is not set
> # CONFIG_INPUT_ADXL34X is not set
> # CONFIG_INPUT_IMS_PCU is not set
> # CONFIG_INPUT_IQS269A is not set
> # CONFIG_INPUT_IQS626A is not set
> # CONFIG_INPUT_CMA3000 is not set
> # CONFIG_INPUT_IDEAPAD_SLIDEBAR is not set
> # CONFIG_INPUT_DRV260X_HAPTICS is not set
> # CONFIG_INPUT_DRV2665_HAPTICS is not set
> # CONFIG_INPUT_DRV2667_HAPTICS is not set
> CONFIG_RMI4_CORE=3Dm
> CONFIG_RMI4_I2C=3Dm
> CONFIG_RMI4_SPI=3Dm
> CONFIG_RMI4_SMB=3Dm
> CONFIG_RMI4_F03=3Dy
> CONFIG_RMI4_F03_SERIO=3Dm
> CONFIG_RMI4_2D_SENSOR=3Dy
> CONFIG_RMI4_F11=3Dy
> CONFIG_RMI4_F12=3Dy
> CONFIG_RMI4_F30=3Dy
> CONFIG_RMI4_F34=3Dy
> # CONFIG_RMI4_F3A is not set
> CONFIG_RMI4_F55=3Dy
>=20
> #
> # Hardware I/O ports
> #
> CONFIG_SERIO=3Dy
> CONFIG_ARCH_MIGHT_HAVE_PC_SERIO=3Dy
> CONFIG_SERIO_I8042=3Dy
> CONFIG_SERIO_SERPORT=3Dy
> # CONFIG_SERIO_CT82C710 is not set
> # CONFIG_SERIO_PARKBD is not set
> # CONFIG_SERIO_PCIPS2 is not set
> CONFIG_SERIO_LIBPS2=3Dy
> CONFIG_SERIO_RAW=3Dm
> CONFIG_SERIO_ALTERA_PS2=3Dm
> # CONFIG_SERIO_PS2MULT is not set
> CONFIG_SERIO_ARC_PS2=3Dm
> # CONFIG_SERIO_GPIO_PS2 is not set
> # CONFIG_USERIO is not set
> # CONFIG_GAMEPORT is not set
> # end of Hardware I/O ports
> # end of Input device support
>=20
> #
> # Character devices
> #
> CONFIG_TTY=3Dy
> CONFIG_VT=3Dy
> CONFIG_CONSOLE_TRANSLATIONS=3Dy
> CONFIG_VT_CONSOLE=3Dy
> CONFIG_VT_CONSOLE_SLEEP=3Dy
> CONFIG_HW_CONSOLE=3Dy
> CONFIG_VT_HW_CONSOLE_BINDING=3Dy
> CONFIG_UNIX98_PTYS=3Dy
> # CONFIG_LEGACY_PTYS is not set
> CONFIG_LDISC_AUTOLOAD=3Dy
>=20
> #
> # Serial drivers
> #
> CONFIG_SERIAL_EARLYCON=3Dy
> CONFIG_SERIAL_8250=3Dy
> # CONFIG_SERIAL_8250_DEPRECATED_OPTIONS is not set
> CONFIG_SERIAL_8250_PNP=3Dy
> # CONFIG_SERIAL_8250_16550A_VARIANTS is not set
> # CONFIG_SERIAL_8250_FINTEK is not set
> CONFIG_SERIAL_8250_CONSOLE=3Dy
> CONFIG_SERIAL_8250_DMA=3Dy
> CONFIG_SERIAL_8250_PCI=3Dy
> CONFIG_SERIAL_8250_EXAR=3Dy
> CONFIG_SERIAL_8250_NR_UARTS=3D64
> CONFIG_SERIAL_8250_RUNTIME_UARTS=3D4
> CONFIG_SERIAL_8250_EXTENDED=3Dy
> CONFIG_SERIAL_8250_MANY_PORTS=3Dy
> CONFIG_SERIAL_8250_SHARE_IRQ=3Dy
> # CONFIG_SERIAL_8250_DETECT_IRQ is not set
> CONFIG_SERIAL_8250_RSA=3Dy
> CONFIG_SERIAL_8250_DWLIB=3Dy
> CONFIG_SERIAL_8250_DW=3Dy
> # CONFIG_SERIAL_8250_RT288X is not set
> CONFIG_SERIAL_8250_LPSS=3Dy
> CONFIG_SERIAL_8250_MID=3Dy
> CONFIG_SERIAL_8250_PERICOM=3Dy
>=20
> #
> # Non-8250 serial port support
> #
> # CONFIG_SERIAL_MAX3100 is not set
> # CONFIG_SERIAL_MAX310X is not set
> # CONFIG_SERIAL_UARTLITE is not set
> CONFIG_SERIAL_CORE=3Dy
> CONFIG_SERIAL_CORE_CONSOLE=3Dy
> CONFIG_SERIAL_JSM=3Dm
> # CONFIG_SERIAL_LANTIQ is not set
> # CONFIG_SERIAL_SCCNXP is not set
> # CONFIG_SERIAL_SC16IS7XX is not set
> # CONFIG_SERIAL_BCM63XX is not set
> # CONFIG_SERIAL_ALTERA_JTAGUART is not set
> # CONFIG_SERIAL_ALTERA_UART is not set
> CONFIG_SERIAL_ARC=3Dm
> CONFIG_SERIAL_ARC_NR_PORTS=3D1
> # CONFIG_SERIAL_RP2 is not set
> # CONFIG_SERIAL_FSL_LPUART is not set
> # CONFIG_SERIAL_FSL_LINFLEXUART is not set
> # CONFIG_SERIAL_SPRD is not set
> # end of Serial drivers
>=20
> CONFIG_SERIAL_MCTRL_GPIO=3Dy
> CONFIG_SERIAL_NONSTANDARD=3Dy
> # CONFIG_MOXA_INTELLIO is not set
> # CONFIG_MOXA_SMARTIO is not set
> CONFIG_SYNCLINK_GT=3Dm
> CONFIG_N_HDLC=3Dm
> CONFIG_N_GSM=3Dm
> CONFIG_NOZOMI=3Dm
> # CONFIG_NULL_TTY is not set
> CONFIG_HVC_DRIVER=3Dy
> # CONFIG_SERIAL_DEV_BUS is not set
> CONFIG_PRINTER=3Dm
> # CONFIG_LP_CONSOLE is not set
> CONFIG_PPDEV=3Dm
> CONFIG_VIRTIO_CONSOLE=3Dm
> CONFIG_IPMI_HANDLER=3Dm
> CONFIG_IPMI_DMI_DECODE=3Dy
> CONFIG_IPMI_PLAT_DATA=3Dy
> CONFIG_IPMI_PANIC_EVENT=3Dy
> CONFIG_IPMI_PANIC_STRING=3Dy
> CONFIG_IPMI_DEVICE_INTERFACE=3Dm
> CONFIG_IPMI_SI=3Dm
> CONFIG_IPMI_SSIF=3Dm
> CONFIG_IPMI_WATCHDOG=3Dm
> CONFIG_IPMI_POWEROFF=3Dm
> CONFIG_HW_RANDOM=3Dy
> CONFIG_HW_RANDOM_TIMERIOMEM=3Dm
> CONFIG_HW_RANDOM_INTEL=3Dm
> # CONFIG_HW_RANDOM_AMD is not set
> # CONFIG_HW_RANDOM_BA431 is not set
> CONFIG_HW_RANDOM_VIA=3Dm
> CONFIG_HW_RANDOM_VIRTIO=3Dy
> # CONFIG_HW_RANDOM_XIPHERA is not set
> # CONFIG_APPLICOM is not set
> # CONFIG_MWAVE is not set
> CONFIG_DEVMEM=3Dy
> CONFIG_NVRAM=3Dy
> CONFIG_DEVPORT=3Dy
> CONFIG_HPET=3Dy
> CONFIG_HPET_MMAP=3Dy
> # CONFIG_HPET_MMAP_DEFAULT is not set
> CONFIG_HANGCHECK_TIMER=3Dm
> CONFIG_UV_MMTIMER=3Dm
> CONFIG_TCG_TPM=3Dy
> CONFIG_HW_RANDOM_TPM=3Dy
> CONFIG_TCG_TIS_CORE=3Dy
> CONFIG_TCG_TIS=3Dy
> # CONFIG_TCG_TIS_SPI is not set
> # CONFIG_TCG_TIS_I2C_CR50 is not set
> CONFIG_TCG_TIS_I2C_ATMEL=3Dm
> CONFIG_TCG_TIS_I2C_INFINEON=3Dm
> CONFIG_TCG_TIS_I2C_NUVOTON=3Dm
> CONFIG_TCG_NSC=3Dm
> CONFIG_TCG_ATMEL=3Dm
> CONFIG_TCG_INFINEON=3Dm
> CONFIG_TCG_CRB=3Dy
> # CONFIG_TCG_VTPM_PROXY is not set
> CONFIG_TCG_TIS_ST33ZP24=3Dm
> CONFIG_TCG_TIS_ST33ZP24_I2C=3Dm
> # CONFIG_TCG_TIS_ST33ZP24_SPI is not set
> CONFIG_TELCLOCK=3Dm
> # CONFIG_XILLYBUS is not set
> # CONFIG_XILLYUSB is not set
> # CONFIG_RANDOM_TRUST_CPU is not set
> # CONFIG_RANDOM_TRUST_BOOTLOADER is not set
> # end of Character devices
>=20
> #
> # I2C support
> #
> CONFIG_I2C=3Dy
> CONFIG_ACPI_I2C_OPREGION=3Dy
> CONFIG_I2C_BOARDINFO=3Dy
> CONFIG_I2C_COMPAT=3Dy
> CONFIG_I2C_CHARDEV=3Dm
> CONFIG_I2C_MUX=3Dm
>=20
> #
> # Multiplexer I2C Chip support
> #
> # CONFIG_I2C_MUX_GPIO is not set
> # CONFIG_I2C_MUX_LTC4306 is not set
> # CONFIG_I2C_MUX_PCA9541 is not set
> # CONFIG_I2C_MUX_PCA954x is not set
> # CONFIG_I2C_MUX_REG is not set
> CONFIG_I2C_MUX_MLXCPLD=3Dm
> # end of Multiplexer I2C Chip support
>=20
> CONFIG_I2C_HELPER_AUTO=3Dy
> CONFIG_I2C_SMBUS=3Dy
> CONFIG_I2C_ALGOBIT=3Dy
> CONFIG_I2C_ALGOPCA=3Dm
>=20
> #
> # I2C Hardware Bus support
> #
>=20
> #
> # PC SMBus host controller drivers
> #
> # CONFIG_I2C_ALI1535 is not set
> # CONFIG_I2C_ALI1563 is not set
> # CONFIG_I2C_ALI15X3 is not set
> # CONFIG_I2C_AMD756 is not set
> # CONFIG_I2C_AMD8111 is not set
> # CONFIG_I2C_AMD_MP2 is not set
> CONFIG_I2C_I801=3Dy
> CONFIG_I2C_ISCH=3Dm
> CONFIG_I2C_ISMT=3Dm
> CONFIG_I2C_PIIX4=3Dm
> CONFIG_I2C_NFORCE2=3Dm
> CONFIG_I2C_NFORCE2_S4985=3Dm
> # CONFIG_I2C_NVIDIA_GPU is not set
> # CONFIG_I2C_SIS5595 is not set
> # CONFIG_I2C_SIS630 is not set
> CONFIG_I2C_SIS96X=3Dm
> CONFIG_I2C_VIA=3Dm
> CONFIG_I2C_VIAPRO=3Dm
>=20
> #
> # ACPI drivers
> #
> CONFIG_I2C_SCMI=3Dm
>=20
> #
> # I2C system bus drivers (mostly embedded / system-on-chip)
> #
> # CONFIG_I2C_CBUS_GPIO is not set
> CONFIG_I2C_DESIGNWARE_CORE=3Dm
> # CONFIG_I2C_DESIGNWARE_SLAVE is not set
> CONFIG_I2C_DESIGNWARE_PLATFORM=3Dm
> CONFIG_I2C_DESIGNWARE_BAYTRAIL=3Dy
> # CONFIG_I2C_DESIGNWARE_PCI is not set
> # CONFIG_I2C_EMEV2 is not set
> # CONFIG_I2C_GPIO is not set
> # CONFIG_I2C_OCORES is not set
> CONFIG_I2C_PCA_PLATFORM=3Dm
> CONFIG_I2C_SIMTEC=3Dm
> # CONFIG_I2C_XILINX is not set
>=20
> #
> # External I2C/SMBus adapter drivers
> #
> # CONFIG_I2C_DIOLAN_U2C is not set
> # CONFIG_I2C_CP2615 is not set
> CONFIG_I2C_PARPORT=3Dm
> # CONFIG_I2C_ROBOTFUZZ_OSIF is not set
> # CONFIG_I2C_TAOS_EVM is not set
> # CONFIG_I2C_TINY_USB is not set
>=20
> #
> # Other I2C/SMBus bus drivers
> #
> CONFIG_I2C_MLXCPLD=3Dm
> # CONFIG_I2C_VIRTIO is not set
> # end of I2C Hardware Bus support
>=20
> CONFIG_I2C_STUB=3Dm
> # CONFIG_I2C_SLAVE is not set
> # CONFIG_I2C_DEBUG_CORE is not set
> # CONFIG_I2C_DEBUG_ALGO is not set
> # CONFIG_I2C_DEBUG_BUS is not set
> # end of I2C support
>=20
> # CONFIG_I3C is not set
> CONFIG_SPI=3Dy
> # CONFIG_SPI_DEBUG is not set
> CONFIG_SPI_MASTER=3Dy
> # CONFIG_SPI_MEM is not set
>=20
> #
> # SPI Master Controller Drivers
> #
> # CONFIG_SPI_ALTERA is not set
> # CONFIG_SPI_AXI_SPI_ENGINE is not set
> # CONFIG_SPI_BITBANG is not set
> # CONFIG_SPI_BUTTERFLY is not set
> # CONFIG_SPI_CADENCE is not set
> # CONFIG_SPI_DESIGNWARE is not set
> # CONFIG_SPI_NXP_FLEXSPI is not set
> # CONFIG_SPI_GPIO is not set
> # CONFIG_SPI_LM70_LLP is not set
> # CONFIG_SPI_LANTIQ_SSC is not set
> # CONFIG_SPI_OC_TINY is not set
> # CONFIG_SPI_PXA2XX is not set
> # CONFIG_SPI_ROCKCHIP is not set
> # CONFIG_SPI_SC18IS602 is not set
> # CONFIG_SPI_SIFIVE is not set
> # CONFIG_SPI_MXIC is not set
> # CONFIG_SPI_XCOMM is not set
> # CONFIG_SPI_XILINX is not set
> # CONFIG_SPI_ZYNQMP_GQSPI is not set
> # CONFIG_SPI_AMD is not set
>=20
> #
> # SPI Multiplexer support
> #
> # CONFIG_SPI_MUX is not set
>=20
> #
> # SPI Protocol Masters
> #
> # CONFIG_SPI_SPIDEV is not set
> # CONFIG_SPI_LOOPBACK_TEST is not set
> # CONFIG_SPI_TLE62X0 is not set
> # CONFIG_SPI_SLAVE is not set
> CONFIG_SPI_DYNAMIC=3Dy
> # CONFIG_SPMI is not set
> # CONFIG_HSI is not set
> CONFIG_PPS=3Dy
> # CONFIG_PPS_DEBUG is not set
>=20
> #
> # PPS clients support
> #
> # CONFIG_PPS_CLIENT_KTIMER is not set
> CONFIG_PPS_CLIENT_LDISC=3Dm
> CONFIG_PPS_CLIENT_PARPORT=3Dm
> CONFIG_PPS_CLIENT_GPIO=3Dm
>=20
> #
> # PPS generators support
> #
>=20
> #
> # PTP clock support
> #
> CONFIG_PTP_1588_CLOCK=3Dy
> CONFIG_PTP_1588_CLOCK_OPTIONAL=3Dy
> # CONFIG_DP83640_PHY is not set
> # CONFIG_PTP_1588_CLOCK_INES is not set
> CONFIG_PTP_1588_CLOCK_KVM=3Dm
> # CONFIG_PTP_1588_CLOCK_IDT82P33 is not set
> # CONFIG_PTP_1588_CLOCK_IDTCM is not set
> # CONFIG_PTP_1588_CLOCK_VMW is not set
> # end of PTP clock support
>=20
> CONFIG_PINCTRL=3Dy
> CONFIG_PINMUX=3Dy
> CONFIG_PINCONF=3Dy
> CONFIG_GENERIC_PINCONF=3Dy
> # CONFIG_DEBUG_PINCTRL is not set
> # CONFIG_PINCTRL_AMD is not set
> # CONFIG_PINCTRL_MCP23S08 is not set
> # CONFIG_PINCTRL_SX150X is not set
>=20
> #
> # Intel pinctrl drivers
> #
> CONFIG_PINCTRL_BAYTRAIL=3Dy
> # CONFIG_PINCTRL_CHERRYVIEW is not set
> # CONFIG_PINCTRL_LYNXPOINT is not set
> CONFIG_PINCTRL_INTEL=3Dy
> # CONFIG_PINCTRL_ALDERLAKE is not set
> CONFIG_PINCTRL_BROXTON=3Dm
> CONFIG_PINCTRL_CANNONLAKE=3Dm
> CONFIG_PINCTRL_CEDARFORK=3Dm
> CONFIG_PINCTRL_DENVERTON=3Dm
> # CONFIG_PINCTRL_ELKHARTLAKE is not set
> # CONFIG_PINCTRL_EMMITSBURG is not set
> CONFIG_PINCTRL_GEMINILAKE=3Dm
> # CONFIG_PINCTRL_ICELAKE is not set
> # CONFIG_PINCTRL_JASPERLAKE is not set
> # CONFIG_PINCTRL_LAKEFIELD is not set
> CONFIG_PINCTRL_LEWISBURG=3Dm
> CONFIG_PINCTRL_SUNRISEPOINT=3Dm
> # CONFIG_PINCTRL_TIGERLAKE is not set
> # end of Intel pinctrl drivers
>=20
> #
> # Renesas pinctrl drivers
> #
> # end of Renesas pinctrl drivers
>=20
> CONFIG_GPIOLIB=3Dy
> CONFIG_GPIOLIB_FASTPATH_LIMIT=3D512
> CONFIG_GPIO_ACPI=3Dy
> CONFIG_GPIOLIB_IRQCHIP=3Dy
> # CONFIG_DEBUG_GPIO is not set
> CONFIG_GPIO_CDEV=3Dy
> CONFIG_GPIO_CDEV_V1=3Dy
>=20
> #
> # Memory mapped GPIO drivers
> #
> # CONFIG_GPIO_AMDPT is not set
> # CONFIG_GPIO_DWAPB is not set
> # CONFIG_GPIO_EXAR is not set
> # CONFIG_GPIO_GENERIC_PLATFORM is not set
> CONFIG_GPIO_ICH=3Dm
> # CONFIG_GPIO_MB86S7X is not set
> # CONFIG_GPIO_VX855 is not set
> # CONFIG_GPIO_AMD_FCH is not set
> # end of Memory mapped GPIO drivers
>=20
> #
> # Port-mapped I/O GPIO drivers
> #
> # CONFIG_GPIO_F7188X is not set
> # CONFIG_GPIO_IT87 is not set
> # CONFIG_GPIO_SCH is not set
> # CONFIG_GPIO_SCH311X is not set
> # CONFIG_GPIO_WINBOND is not set
> # CONFIG_GPIO_WS16C48 is not set
> # end of Port-mapped I/O GPIO drivers
>=20
> #
> # I2C GPIO expanders
> #
> # CONFIG_GPIO_ADP5588 is not set
> # CONFIG_GPIO_MAX7300 is not set
> # CONFIG_GPIO_MAX732X is not set
> # CONFIG_GPIO_PCA953X is not set
> # CONFIG_GPIO_PCA9570 is not set
> # CONFIG_GPIO_PCF857X is not set
> # CONFIG_GPIO_TPIC2810 is not set
> # end of I2C GPIO expanders
>=20
> #
> # MFD GPIO expanders
> #
> # end of MFD GPIO expanders
>=20
> #
> # PCI GPIO expanders
> #
> # CONFIG_GPIO_AMD8111 is not set
> # CONFIG_GPIO_BT8XX is not set
> # CONFIG_GPIO_ML_IOH is not set
> # CONFIG_GPIO_PCI_IDIO_16 is not set
> # CONFIG_GPIO_PCIE_IDIO_24 is not set
> # CONFIG_GPIO_RDC321X is not set
> # end of PCI GPIO expanders
>=20
> #
> # SPI GPIO expanders
> #
> # CONFIG_GPIO_MAX3191X is not set
> # CONFIG_GPIO_MAX7301 is not set
> # CONFIG_GPIO_MC33880 is not set
> # CONFIG_GPIO_PISOSR is not set
> # CONFIG_GPIO_XRA1403 is not set
> # end of SPI GPIO expanders
>=20
> #
> # USB GPIO expanders
> #
> # end of USB GPIO expanders
>=20
> #
> # Virtual GPIO drivers
> #
> # CONFIG_GPIO_AGGREGATOR is not set
> # CONFIG_GPIO_MOCKUP is not set
> # CONFIG_GPIO_VIRTIO is not set
> # CONFIG_GPIO_SIM is not set
> # end of Virtual GPIO drivers
>=20
> # CONFIG_W1 is not set
> CONFIG_POWER_RESET=3Dy
> # CONFIG_POWER_RESET_RESTART is not set
> CONFIG_POWER_SUPPLY=3Dy
> # CONFIG_POWER_SUPPLY_DEBUG is not set
> CONFIG_POWER_SUPPLY_HWMON=3Dy
> # CONFIG_PDA_POWER is not set
> # CONFIG_TEST_POWER is not set
> # CONFIG_CHARGER_ADP5061 is not set
> # CONFIG_BATTERY_CW2015 is not set
> # CONFIG_BATTERY_DS2780 is not set
> # CONFIG_BATTERY_DS2781 is not set
> # CONFIG_BATTERY_DS2782 is not set
> # CONFIG_BATTERY_SBS is not set
> # CONFIG_CHARGER_SBS is not set
> # CONFIG_MANAGER_SBS is not set
> # CONFIG_BATTERY_BQ27XXX is not set
> # CONFIG_BATTERY_MAX17040 is not set
> # CONFIG_BATTERY_MAX17042 is not set
> # CONFIG_CHARGER_MAX8903 is not set
> # CONFIG_CHARGER_LP8727 is not set
> # CONFIG_CHARGER_GPIO is not set
> # CONFIG_CHARGER_LT3651 is not set
> # CONFIG_CHARGER_LTC4162L is not set
> # CONFIG_CHARGER_MAX77976 is not set
> # CONFIG_CHARGER_BQ2415X is not set
> # CONFIG_CHARGER_BQ24257 is not set
> # CONFIG_CHARGER_BQ24735 is not set
> # CONFIG_CHARGER_BQ2515X is not set
> # CONFIG_CHARGER_BQ25890 is not set
> # CONFIG_CHARGER_BQ25980 is not set
> # CONFIG_CHARGER_BQ256XX is not set
> # CONFIG_BATTERY_GAUGE_LTC2941 is not set
> # CONFIG_BATTERY_GOLDFISH is not set
> # CONFIG_BATTERY_RT5033 is not set
> # CONFIG_CHARGER_RT9455 is not set
> # CONFIG_CHARGER_BD99954 is not set
> CONFIG_HWMON=3Dy
> CONFIG_HWMON_VID=3Dm
> # CONFIG_HWMON_DEBUG_CHIP is not set
>=20
> #
> # Native drivers
> #
> CONFIG_SENSORS_ABITUGURU=3Dm
> CONFIG_SENSORS_ABITUGURU3=3Dm
> # CONFIG_SENSORS_AD7314 is not set
> CONFIG_SENSORS_AD7414=3Dm
> CONFIG_SENSORS_AD7418=3Dm
> CONFIG_SENSORS_ADM1021=3Dm
> CONFIG_SENSORS_ADM1025=3Dm
> CONFIG_SENSORS_ADM1026=3Dm
> CONFIG_SENSORS_ADM1029=3Dm
> CONFIG_SENSORS_ADM1031=3Dm
> # CONFIG_SENSORS_ADM1177 is not set
> CONFIG_SENSORS_ADM9240=3Dm
> CONFIG_SENSORS_ADT7X10=3Dm
> # CONFIG_SENSORS_ADT7310 is not set
> CONFIG_SENSORS_ADT7410=3Dm
> CONFIG_SENSORS_ADT7411=3Dm
> CONFIG_SENSORS_ADT7462=3Dm
> CONFIG_SENSORS_ADT7470=3Dm
> CONFIG_SENSORS_ADT7475=3Dm
> # CONFIG_SENSORS_AHT10 is not set
> # CONFIG_SENSORS_AQUACOMPUTER_D5NEXT is not set
> # CONFIG_SENSORS_AS370 is not set
> CONFIG_SENSORS_ASC7621=3Dm
> # CONFIG_SENSORS_AXI_FAN_CONTROL is not set
> CONFIG_SENSORS_K8TEMP=3Dm
> CONFIG_SENSORS_K10TEMP=3Dm
> CONFIG_SENSORS_FAM15H_POWER=3Dm
> CONFIG_SENSORS_APPLESMC=3Dm
> CONFIG_SENSORS_ASB100=3Dm
> # CONFIG_SENSORS_ASPEED is not set
> CONFIG_SENSORS_ATXP1=3Dm
> # CONFIG_SENSORS_CORSAIR_CPRO is not set
> # CONFIG_SENSORS_CORSAIR_PSU is not set
> # CONFIG_SENSORS_DRIVETEMP is not set
> CONFIG_SENSORS_DS620=3Dm
> CONFIG_SENSORS_DS1621=3Dm
> CONFIG_SENSORS_DELL_SMM=3Dm
> CONFIG_SENSORS_I5K_AMB=3Dm
> CONFIG_SENSORS_F71805F=3Dm
> CONFIG_SENSORS_F71882FG=3Dm
> CONFIG_SENSORS_F75375S=3Dm
> CONFIG_SENSORS_FSCHMD=3Dm
> # CONFIG_SENSORS_FTSTEUTATES is not set
> CONFIG_SENSORS_GL518SM=3Dm
> CONFIG_SENSORS_GL520SM=3Dm
> CONFIG_SENSORS_G760A=3Dm
> # CONFIG_SENSORS_G762 is not set
> # CONFIG_SENSORS_HIH6130 is not set
> CONFIG_SENSORS_IBMAEM=3Dm
> CONFIG_SENSORS_IBMPEX=3Dm
> CONFIG_SENSORS_I5500=3Dm
> CONFIG_SENSORS_CORETEMP=3Dm
> CONFIG_SENSORS_IT87=3Dm
> CONFIG_SENSORS_JC42=3Dm
> # CONFIG_SENSORS_POWR1220 is not set
> CONFIG_SENSORS_LINEAGE=3Dm
> # CONFIG_SENSORS_LTC2945 is not set
> # CONFIG_SENSORS_LTC2947_I2C is not set
> # CONFIG_SENSORS_LTC2947_SPI is not set
> # CONFIG_SENSORS_LTC2990 is not set
> # CONFIG_SENSORS_LTC2992 is not set
> CONFIG_SENSORS_LTC4151=3Dm
> CONFIG_SENSORS_LTC4215=3Dm
> # CONFIG_SENSORS_LTC4222 is not set
> CONFIG_SENSORS_LTC4245=3Dm
> # CONFIG_SENSORS_LTC4260 is not set
> CONFIG_SENSORS_LTC4261=3Dm
> # CONFIG_SENSORS_MAX1111 is not set
> # CONFIG_SENSORS_MAX127 is not set
> CONFIG_SENSORS_MAX16065=3Dm
> CONFIG_SENSORS_MAX1619=3Dm
> CONFIG_SENSORS_MAX1668=3Dm
> CONFIG_SENSORS_MAX197=3Dm
> # CONFIG_SENSORS_MAX31722 is not set
> # CONFIG_SENSORS_MAX31730 is not set
> # CONFIG_SENSORS_MAX6620 is not set
> # CONFIG_SENSORS_MAX6621 is not set
> CONFIG_SENSORS_MAX6639=3Dm
> CONFIG_SENSORS_MAX6642=3Dm
> CONFIG_SENSORS_MAX6650=3Dm
> CONFIG_SENSORS_MAX6697=3Dm
> # CONFIG_SENSORS_MAX31790 is not set
> CONFIG_SENSORS_MCP3021=3Dm
> # CONFIG_SENSORS_MLXREG_FAN is not set
> # CONFIG_SENSORS_TC654 is not set
> # CONFIG_SENSORS_TPS23861 is not set
> # CONFIG_SENSORS_MR75203 is not set
> # CONFIG_SENSORS_ADCXX is not set
> CONFIG_SENSORS_LM63=3Dm
> # CONFIG_SENSORS_LM70 is not set
> CONFIG_SENSORS_LM73=3Dm
> CONFIG_SENSORS_LM75=3Dm
> CONFIG_SENSORS_LM77=3Dm
> CONFIG_SENSORS_LM78=3Dm
> CONFIG_SENSORS_LM80=3Dm
> CONFIG_SENSORS_LM83=3Dm
> CONFIG_SENSORS_LM85=3Dm
> CONFIG_SENSORS_LM87=3Dm
> CONFIG_SENSORS_LM90=3Dm
> CONFIG_SENSORS_LM92=3Dm
> CONFIG_SENSORS_LM93=3Dm
> CONFIG_SENSORS_LM95234=3Dm
> CONFIG_SENSORS_LM95241=3Dm
> CONFIG_SENSORS_LM95245=3Dm
> CONFIG_SENSORS_PC87360=3Dm
> CONFIG_SENSORS_PC87427=3Dm
> # CONFIG_SENSORS_NCT6683 is not set
> CONFIG_SENSORS_NCT6775=3Dm
> # CONFIG_SENSORS_NCT7802 is not set
> # CONFIG_SENSORS_NCT7904 is not set
> # CONFIG_SENSORS_NPCM7XX is not set
> # CONFIG_SENSORS_NZXT_KRAKEN2 is not set
> # CONFIG_SENSORS_NZXT_SMART2 is not set
> CONFIG_SENSORS_PCF8591=3Dm
> CONFIG_PMBUS=3Dm
> CONFIG_SENSORS_PMBUS=3Dm
> # CONFIG_SENSORS_ADM1266 is not set
> CONFIG_SENSORS_ADM1275=3Dm
> # CONFIG_SENSORS_BEL_PFE is not set
> # CONFIG_SENSORS_BPA_RS600 is not set
> # CONFIG_SENSORS_DELTA_AHE50DC_FAN is not set
> # CONFIG_SENSORS_FSP_3Y is not set
> # CONFIG_SENSORS_IBM_CFFPS is not set
> # CONFIG_SENSORS_DPS920AB is not set
> # CONFIG_SENSORS_INSPUR_IPSPS is not set
> # CONFIG_SENSORS_IR35221 is not set
> # CONFIG_SENSORS_IR36021 is not set
> # CONFIG_SENSORS_IR38064 is not set
> # CONFIG_SENSORS_IRPS5401 is not set
> # CONFIG_SENSORS_ISL68137 is not set
> CONFIG_SENSORS_LM25066=3Dm
> CONFIG_SENSORS_LTC2978=3Dm
> # CONFIG_SENSORS_LTC3815 is not set
> # CONFIG_SENSORS_MAX15301 is not set
> CONFIG_SENSORS_MAX16064=3Dm
> # CONFIG_SENSORS_MAX16601 is not set
> # CONFIG_SENSORS_MAX20730 is not set
> # CONFIG_SENSORS_MAX20751 is not set
> # CONFIG_SENSORS_MAX31785 is not set
> CONFIG_SENSORS_MAX34440=3Dm
> CONFIG_SENSORS_MAX8688=3Dm
> # CONFIG_SENSORS_MP2888 is not set
> # CONFIG_SENSORS_MP2975 is not set
> # CONFIG_SENSORS_MP5023 is not set
> # CONFIG_SENSORS_PIM4328 is not set
> # CONFIG_SENSORS_PM6764TR is not set
> # CONFIG_SENSORS_PXE1610 is not set
> # CONFIG_SENSORS_Q54SJ108A2 is not set
> # CONFIG_SENSORS_STPDDC60 is not set
> # CONFIG_SENSORS_TPS40422 is not set
> # CONFIG_SENSORS_TPS53679 is not set
> CONFIG_SENSORS_UCD9000=3Dm
> CONFIG_SENSORS_UCD9200=3Dm
> # CONFIG_SENSORS_XDPE122 is not set
> CONFIG_SENSORS_ZL6100=3Dm
> # CONFIG_SENSORS_SBTSI is not set
> # CONFIG_SENSORS_SBRMI is not set
> CONFIG_SENSORS_SHT15=3Dm
> CONFIG_SENSORS_SHT21=3Dm
> # CONFIG_SENSORS_SHT3x is not set
> # CONFIG_SENSORS_SHT4x is not set
> # CONFIG_SENSORS_SHTC1 is not set
> CONFIG_SENSORS_SIS5595=3Dm
> CONFIG_SENSORS_DME1737=3Dm
> CONFIG_SENSORS_EMC1403=3Dm
> # CONFIG_SENSORS_EMC2103 is not set
> CONFIG_SENSORS_EMC6W201=3Dm
> CONFIG_SENSORS_SMSC47M1=3Dm
> CONFIG_SENSORS_SMSC47M192=3Dm
> CONFIG_SENSORS_SMSC47B397=3Dm
> CONFIG_SENSORS_SCH56XX_COMMON=3Dm
> CONFIG_SENSORS_SCH5627=3Dm
> CONFIG_SENSORS_SCH5636=3Dm
> # CONFIG_SENSORS_STTS751 is not set
> # CONFIG_SENSORS_SMM665 is not set
> # CONFIG_SENSORS_ADC128D818 is not set
> CONFIG_SENSORS_ADS7828=3Dm
> # CONFIG_SENSORS_ADS7871 is not set
> CONFIG_SENSORS_AMC6821=3Dm
> CONFIG_SENSORS_INA209=3Dm
> CONFIG_SENSORS_INA2XX=3Dm
> # CONFIG_SENSORS_INA238 is not set
> # CONFIG_SENSORS_INA3221 is not set
> # CONFIG_SENSORS_TC74 is not set
> CONFIG_SENSORS_THMC50=3Dm
> CONFIG_SENSORS_TMP102=3Dm
> # CONFIG_SENSORS_TMP103 is not set
> # CONFIG_SENSORS_TMP108 is not set
> CONFIG_SENSORS_TMP401=3Dm
> CONFIG_SENSORS_TMP421=3Dm
> # CONFIG_SENSORS_TMP513 is not set
> CONFIG_SENSORS_VIA_CPUTEMP=3Dm
> CONFIG_SENSORS_VIA686A=3Dm
> CONFIG_SENSORS_VT1211=3Dm
> CONFIG_SENSORS_VT8231=3Dm
> # CONFIG_SENSORS_W83773G is not set
> CONFIG_SENSORS_W83781D=3Dm
> CONFIG_SENSORS_W83791D=3Dm
> CONFIG_SENSORS_W83792D=3Dm
> CONFIG_SENSORS_W83793=3Dm
> CONFIG_SENSORS_W83795=3Dm
> # CONFIG_SENSORS_W83795_FANCTRL is not set
> CONFIG_SENSORS_W83L785TS=3Dm
> CONFIG_SENSORS_W83L786NG=3Dm
> CONFIG_SENSORS_W83627HF=3Dm
> CONFIG_SENSORS_W83627EHF=3Dm
> # CONFIG_SENSORS_XGENE is not set
>=20
> #
> # ACPI drivers
> #
> CONFIG_SENSORS_ACPI_POWER=3Dm
> CONFIG_SENSORS_ATK0110=3Dm
> # CONFIG_SENSORS_ASUS_WMI is not set
> # CONFIG_SENSORS_ASUS_WMI_EC is not set
> CONFIG_THERMAL=3Dy
> # CONFIG_THERMAL_NETLINK is not set
> # CONFIG_THERMAL_STATISTICS is not set
> CONFIG_THERMAL_EMERGENCY_POWEROFF_DELAY_MS=3D0
> CONFIG_THERMAL_HWMON=3Dy
> CONFIG_THERMAL_WRITABLE_TRIPS=3Dy
> CONFIG_THERMAL_DEFAULT_GOV_STEP_WISE=3Dy
> # CONFIG_THERMAL_DEFAULT_GOV_FAIR_SHARE is not set
> # CONFIG_THERMAL_DEFAULT_GOV_USER_SPACE is not set
> CONFIG_THERMAL_GOV_FAIR_SHARE=3Dy
> CONFIG_THERMAL_GOV_STEP_WISE=3Dy
> CONFIG_THERMAL_GOV_BANG_BANG=3Dy
> CONFIG_THERMAL_GOV_USER_SPACE=3Dy
> # CONFIG_THERMAL_EMULATION is not set
>=20
> #
> # Intel thermal drivers
> #
> CONFIG_INTEL_POWERCLAMP=3Dm
> CONFIG_X86_THERMAL_VECTOR=3Dy
> CONFIG_X86_PKG_TEMP_THERMAL=3Dm
> # CONFIG_INTEL_SOC_DTS_THERMAL is not set
>=20
> #
> # ACPI INT340X thermal drivers
> #
> # CONFIG_INT340X_THERMAL is not set
> # end of ACPI INT340X thermal drivers
>=20
> CONFIG_INTEL_PCH_THERMAL=3Dm
> # CONFIG_INTEL_TCC_COOLING is not set
> # CONFIG_INTEL_MENLOW is not set
> # end of Intel thermal drivers
>=20
> CONFIG_WATCHDOG=3Dy
> CONFIG_WATCHDOG_CORE=3Dy
> # CONFIG_WATCHDOG_NOWAYOUT is not set
> CONFIG_WATCHDOG_HANDLE_BOOT_ENABLED=3Dy
> CONFIG_WATCHDOG_OPEN_TIMEOUT=3D0
> CONFIG_WATCHDOG_SYSFS=3Dy
> # CONFIG_WATCHDOG_HRTIMER_PRETIMEOUT is not set
>=20
> #
> # Watchdog Pretimeout Governors
> #
> # CONFIG_WATCHDOG_PRETIMEOUT_GOV is not set
>=20
> #
> # Watchdog Device Drivers
> #
> CONFIG_SOFT_WATCHDOG=3Dm
> CONFIG_WDAT_WDT=3Dm
> # CONFIG_XILINX_WATCHDOG is not set
> # CONFIG_ZIIRAVE_WATCHDOG is not set
> # CONFIG_MLX_WDT is not set
> # CONFIG_CADENCE_WATCHDOG is not set
> # CONFIG_DW_WATCHDOG is not set
> # CONFIG_MAX63XX_WATCHDOG is not set
> # CONFIG_ACQUIRE_WDT is not set
> # CONFIG_ADVANTECH_WDT is not set
> CONFIG_ALIM1535_WDT=3Dm
> CONFIG_ALIM7101_WDT=3Dm
> # CONFIG_EBC_C384_WDT is not set
> CONFIG_F71808E_WDT=3Dm
> # CONFIG_SP5100_TCO is not set
> CONFIG_SBC_FITPC2_WATCHDOG=3Dm
> # CONFIG_EUROTECH_WDT is not set
> CONFIG_IB700_WDT=3Dm
> CONFIG_IBMASR=3Dm
> # CONFIG_WAFER_WDT is not set
> CONFIG_I6300ESB_WDT=3Dy
> CONFIG_IE6XX_WDT=3Dm
> CONFIG_ITCO_WDT=3Dy
> CONFIG_ITCO_VENDOR_SUPPORT=3Dy
> CONFIG_IT8712F_WDT=3Dm
> CONFIG_IT87_WDT=3Dm
> CONFIG_HP_WATCHDOG=3Dm
> CONFIG_HPWDT_NMI_DECODING=3Dy
> # CONFIG_SC1200_WDT is not set
> # CONFIG_PC87413_WDT is not set
> CONFIG_NV_TCO=3Dm
> # CONFIG_60XX_WDT is not set
> # CONFIG_CPU5_WDT is not set
> CONFIG_SMSC_SCH311X_WDT=3Dm
> # CONFIG_SMSC37B787_WDT is not set
> # CONFIG_TQMX86_WDT is not set
> CONFIG_VIA_WDT=3Dm
> CONFIG_W83627HF_WDT=3Dm
> CONFIG_W83877F_WDT=3Dm
> CONFIG_W83977F_WDT=3Dm
> CONFIG_MACHZ_WDT=3Dm
> # CONFIG_SBC_EPX_C3_WATCHDOG is not set
> CONFIG_INTEL_MEI_WDT=3Dm
> # CONFIG_NI903X_WDT is not set
> # CONFIG_NIC7018_WDT is not set
> # CONFIG_MEN_A21_WDT is not set
>=20
> #
> # PCI-based Watchdog Cards
> #
> CONFIG_PCIPCWATCHDOG=3Dm
> CONFIG_WDTPCI=3Dm
>=20
> #
> # USB-based Watchdog Cards
> #
> # CONFIG_USBPCWATCHDOG is not set
> CONFIG_SSB_POSSIBLE=3Dy
> # CONFIG_SSB is not set
> CONFIG_BCMA_POSSIBLE=3Dy
> CONFIG_BCMA=3Dm
> CONFIG_BCMA_HOST_PCI_POSSIBLE=3Dy
> CONFIG_BCMA_HOST_PCI=3Dy
> # CONFIG_BCMA_HOST_SOC is not set
> CONFIG_BCMA_DRIVER_PCI=3Dy
> CONFIG_BCMA_DRIVER_GMAC_CMN=3Dy
> CONFIG_BCMA_DRIVER_GPIO=3Dy
> # CONFIG_BCMA_DEBUG is not set
>=20
> #
> # Multifunction device drivers
> #
> CONFIG_MFD_CORE=3Dy
> # CONFIG_MFD_AS3711 is not set
> # CONFIG_PMIC_ADP5520 is not set
> # CONFIG_MFD_AAT2870_CORE is not set
> # CONFIG_MFD_BCM590XX is not set
> # CONFIG_MFD_BD9571MWV is not set
> # CONFIG_MFD_AXP20X_I2C is not set
> # CONFIG_MFD_MADERA is not set
> # CONFIG_PMIC_DA903X is not set
> # CONFIG_MFD_DA9052_SPI is not set
> # CONFIG_MFD_DA9052_I2C is not set
> # CONFIG_MFD_DA9055 is not set
> # CONFIG_MFD_DA9062 is not set
> # CONFIG_MFD_DA9063 is not set
> # CONFIG_MFD_DA9150 is not set
> # CONFIG_MFD_DLN2 is not set
> # CONFIG_MFD_MC13XXX_SPI is not set
> # CONFIG_MFD_MC13XXX_I2C is not set
> # CONFIG_MFD_MP2629 is not set
> # CONFIG_HTC_PASIC3 is not set
> # CONFIG_HTC_I2CPLD is not set
> # CONFIG_MFD_INTEL_QUARK_I2C_GPIO is not set
> CONFIG_LPC_ICH=3Dy
> CONFIG_LPC_SCH=3Dm
> CONFIG_MFD_INTEL_LPSS=3Dy
> CONFIG_MFD_INTEL_LPSS_ACPI=3Dy
> CONFIG_MFD_INTEL_LPSS_PCI=3Dy
> # CONFIG_MFD_INTEL_PMC_BXT is not set
> # CONFIG_MFD_IQS62X is not set
> # CONFIG_MFD_JANZ_CMODIO is not set
> # CONFIG_MFD_KEMPLD is not set
> # CONFIG_MFD_88PM800 is not set
> # CONFIG_MFD_88PM805 is not set
> # CONFIG_MFD_88PM860X is not set
> # CONFIG_MFD_MAX14577 is not set
> # CONFIG_MFD_MAX77693 is not set
> # CONFIG_MFD_MAX77843 is not set
> # CONFIG_MFD_MAX8907 is not set
> # CONFIG_MFD_MAX8925 is not set
> # CONFIG_MFD_MAX8997 is not set
> # CONFIG_MFD_MAX8998 is not set
> # CONFIG_MFD_MT6360 is not set
> # CONFIG_MFD_MT6397 is not set
> # CONFIG_MFD_MENF21BMC is not set
> # CONFIG_EZX_PCAP is not set
> # CONFIG_MFD_VIPERBOARD is not set
> # CONFIG_MFD_RETU is not set
> # CONFIG_MFD_PCF50633 is not set
> # CONFIG_MFD_RDC321X is not set
> # CONFIG_MFD_RT4831 is not set
> # CONFIG_MFD_RT5033 is not set
> # CONFIG_MFD_RC5T583 is not set
> # CONFIG_MFD_SI476X_CORE is not set
> CONFIG_MFD_SM501=3Dm
> CONFIG_MFD_SM501_GPIO=3Dy
> # CONFIG_MFD_SKY81452 is not set
> # CONFIG_MFD_SYSCON is not set
> # CONFIG_MFD_TI_AM335X_TSCADC is not set
> # CONFIG_MFD_LP3943 is not set
> # CONFIG_MFD_LP8788 is not set
> # CONFIG_MFD_TI_LMU is not set
> # CONFIG_MFD_PALMAS is not set
> # CONFIG_TPS6105X is not set
> # CONFIG_TPS65010 is not set
> # CONFIG_TPS6507X is not set
> # CONFIG_MFD_TPS65086 is not set
> # CONFIG_MFD_TPS65090 is not set
> # CONFIG_MFD_TI_LP873X is not set
> # CONFIG_MFD_TPS6586X is not set
> # CONFIG_MFD_TPS65910 is not set
> # CONFIG_MFD_TPS65912_I2C is not set
> # CONFIG_MFD_TPS65912_SPI is not set
> # CONFIG_TWL4030_CORE is not set
> # CONFIG_TWL6040_CORE is not set
> # CONFIG_MFD_WL1273_CORE is not set
> # CONFIG_MFD_LM3533 is not set
> # CONFIG_MFD_TQMX86 is not set
> CONFIG_MFD_VX855=3Dm
> # CONFIG_MFD_ARIZONA_I2C is not set
> # CONFIG_MFD_ARIZONA_SPI is not set
> # CONFIG_MFD_WM8400 is not set
> # CONFIG_MFD_WM831X_I2C is not set
> # CONFIG_MFD_WM831X_SPI is not set
> # CONFIG_MFD_WM8350_I2C is not set
> # CONFIG_MFD_WM8994 is not set
> # CONFIG_MFD_ATC260X_I2C is not set
> # CONFIG_MFD_INTEL_M10_BMC is not set
> # end of Multifunction device drivers
>=20
> # CONFIG_REGULATOR is not set
> CONFIG_RC_CORE=3Dm
> CONFIG_RC_MAP=3Dm
> CONFIG_LIRC=3Dy
> CONFIG_RC_DECODERS=3Dy
> CONFIG_IR_NEC_DECODER=3Dm
> CONFIG_IR_RC5_DECODER=3Dm
> CONFIG_IR_RC6_DECODER=3Dm
> CONFIG_IR_JVC_DECODER=3Dm
> CONFIG_IR_SONY_DECODER=3Dm
> CONFIG_IR_SANYO_DECODER=3Dm
> # CONFIG_IR_SHARP_DECODER is not set
> CONFIG_IR_MCE_KBD_DECODER=3Dm
> # CONFIG_IR_XMP_DECODER is not set
> CONFIG_IR_IMON_DECODER=3Dm
> # CONFIG_IR_RCMM_DECODER is not set
> CONFIG_RC_DEVICES=3Dy
> # CONFIG_RC_ATI_REMOTE is not set
> CONFIG_IR_ENE=3Dm
> # CONFIG_IR_IMON is not set
> # CONFIG_IR_IMON_RAW is not set
> # CONFIG_IR_MCEUSB is not set
> CONFIG_IR_ITE_CIR=3Dm
> CONFIG_IR_FINTEK=3Dm
> CONFIG_IR_NUVOTON=3Dm
> # CONFIG_IR_REDRAT3 is not set
> # CONFIG_IR_STREAMZAP is not set
> CONFIG_IR_WINBOND_CIR=3Dm
> # CONFIG_IR_IGORPLUGUSB is not set
> # CONFIG_IR_IGUANA is not set
> # CONFIG_IR_TTUSBIR is not set
> # CONFIG_RC_LOOPBACK is not set
> CONFIG_IR_SERIAL=3Dm
> CONFIG_IR_SERIAL_TRANSMITTER=3Dy
> # CONFIG_RC_XBOX_DVD is not set
> # CONFIG_IR_TOY is not set
>=20
> #
> # CEC support
> #
> # CONFIG_MEDIA_CEC_SUPPORT is not set
> # end of CEC support
>=20
> CONFIG_MEDIA_SUPPORT=3Dm
> CONFIG_MEDIA_SUPPORT_FILTER=3Dy
> CONFIG_MEDIA_SUBDRV_AUTOSELECT=3Dy
>=20
> #
> # Media device types
> #
> # CONFIG_MEDIA_CAMERA_SUPPORT is not set
> # CONFIG_MEDIA_ANALOG_TV_SUPPORT is not set
> # CONFIG_MEDIA_DIGITAL_TV_SUPPORT is not set
> # CONFIG_MEDIA_RADIO_SUPPORT is not set
> # CONFIG_MEDIA_SDR_SUPPORT is not set
> # CONFIG_MEDIA_PLATFORM_SUPPORT is not set
> # CONFIG_MEDIA_TEST_SUPPORT is not set
> # end of Media device types
>=20
> #
> # Media drivers
> #
>=20
> #
> # Drivers filtered as selected at 'Filter media drivers'
> #
> # CONFIG_MEDIA_USB_SUPPORT is not set
> # CONFIG_MEDIA_PCI_SUPPORT is not set
> # end of Media drivers
>=20
> CONFIG_MEDIA_HIDE_ANCILLARY_SUBDRV=3Dy
>=20
> #
> # Media ancillary drivers
> #
>=20
> #
> # Media SPI Adapters
> #
> # end of Media SPI Adapters
> # end of Media ancillary drivers
>=20
> #
> # Graphics support
> #
> # CONFIG_AGP is not set
> CONFIG_INTEL_GTT=3Dm
> CONFIG_VGA_ARB=3Dy
> CONFIG_VGA_ARB_MAX_GPUS=3D64
> CONFIG_VGA_SWITCHEROO=3Dy
> CONFIG_DRM=3Dm
> CONFIG_DRM_MIPI_DSI=3Dy
> CONFIG_DRM_DP_AUX_CHARDEV=3Dy
> # CONFIG_DRM_DEBUG_SELFTEST is not set
> CONFIG_DRM_KMS_HELPER=3Dm
> CONFIG_DRM_FBDEV_EMULATION=3Dy
> CONFIG_DRM_FBDEV_OVERALLOC=3D100
> CONFIG_DRM_LOAD_EDID_FIRMWARE=3Dy
> # CONFIG_DRM_DP_CEC is not set
> CONFIG_DRM_TTM=3Dm
> CONFIG_DRM_VRAM_HELPER=3Dm
> CONFIG_DRM_TTM_HELPER=3Dm
> CONFIG_DRM_GEM_SHMEM_HELPER=3Dm
>=20
> #
> # I2C encoder or helper chips
> #
> CONFIG_DRM_I2C_CH7006=3Dm
> CONFIG_DRM_I2C_SIL164=3Dm
> # CONFIG_DRM_I2C_NXP_TDA998X is not set
> # CONFIG_DRM_I2C_NXP_TDA9950 is not set
> # end of I2C encoder or helper chips
>=20
> #
> # ARM devices
> #
> # end of ARM devices
>=20
> # CONFIG_DRM_RADEON is not set
> # CONFIG_DRM_AMDGPU is not set
> # CONFIG_DRM_NOUVEAU is not set
> CONFIG_DRM_I915=3Dm
> CONFIG_DRM_I915_FORCE_PROBE=3D""
> CONFIG_DRM_I915_CAPTURE_ERROR=3Dy
> CONFIG_DRM_I915_COMPRESS_ERROR=3Dy
> CONFIG_DRM_I915_USERPTR=3Dy
> CONFIG_DRM_I915_GVT=3Dy
> # CONFIG_DRM_I915_GVT_KVMGT is not set
> CONFIG_DRM_I915_REQUEST_TIMEOUT=3D20000
> CONFIG_DRM_I915_FENCE_TIMEOUT=3D10000
> CONFIG_DRM_I915_USERFAULT_AUTOSUSPEND=3D250
> CONFIG_DRM_I915_HEARTBEAT_INTERVAL=3D2500
> CONFIG_DRM_I915_PREEMPT_TIMEOUT=3D640
> CONFIG_DRM_I915_MAX_REQUEST_BUSYWAIT=3D8000
> CONFIG_DRM_I915_STOP_TIMEOUT=3D100
> CONFIG_DRM_I915_TIMESLICE_DURATION=3D1
> # CONFIG_DRM_VGEM is not set
> # CONFIG_DRM_VKMS is not set
> # CONFIG_DRM_VMWGFX is not set
> CONFIG_DRM_GMA500=3Dm
> # CONFIG_DRM_UDL is not set
> CONFIG_DRM_AST=3Dm
> CONFIG_DRM_MGAG200=3Dm
> CONFIG_DRM_QXL=3Dm
> CONFIG_DRM_VIRTIO_GPU=3Dm
> CONFIG_DRM_PANEL=3Dy
>=20
> #
> # Display Panels
> #
> # CONFIG_DRM_PANEL_RASPBERRYPI_TOUCHSCREEN is not set
> # CONFIG_DRM_PANEL_WIDECHIPS_WS2401 is not set
> # end of Display Panels
>=20
> CONFIG_DRM_BRIDGE=3Dy
> CONFIG_DRM_PANEL_BRIDGE=3Dy
>=20
> #
> # Display Interface Bridges
> #
> # CONFIG_DRM_ANALOGIX_ANX78XX is not set
> # end of Display Interface Bridges
>=20
> # CONFIG_DRM_ETNAVIV is not set
> CONFIG_DRM_BOCHS=3Dm
> CONFIG_DRM_CIRRUS_QEMU=3Dm
> # CONFIG_DRM_GM12U320 is not set
> # CONFIG_DRM_SIMPLEDRM is not set
> # CONFIG_TINYDRM_HX8357D is not set
> # CONFIG_TINYDRM_ILI9163 is not set
> # CONFIG_TINYDRM_ILI9225 is not set
> # CONFIG_TINYDRM_ILI9341 is not set
> # CONFIG_TINYDRM_ILI9486 is not set
> # CONFIG_TINYDRM_MI0283QT is not set
> # CONFIG_TINYDRM_REPAPER is not set
> # CONFIG_TINYDRM_ST7586 is not set
> # CONFIG_TINYDRM_ST7735R is not set
> # CONFIG_DRM_VBOXVIDEO is not set
> # CONFIG_DRM_GUD is not set
> # CONFIG_DRM_LEGACY is not set
> CONFIG_DRM_PANEL_ORIENTATION_QUIRKS=3Dy
> CONFIG_DRM_NOMODESET=3Dy
> CONFIG_DRM_PRIVACY_SCREEN=3Dy
>=20
> #
> # Frame buffer Devices
> #
> CONFIG_FB_CMDLINE=3Dy
> CONFIG_FB_NOTIFY=3Dy
> CONFIG_FB=3Dy
> # CONFIG_FIRMWARE_EDID is not set
> CONFIG_FB_BOOT_VESA_SUPPORT=3Dy
> CONFIG_FB_CFB_FILLRECT=3Dy
> CONFIG_FB_CFB_COPYAREA=3Dy
> CONFIG_FB_CFB_IMAGEBLIT=3Dy
> CONFIG_FB_SYS_FILLRECT=3Dm
> CONFIG_FB_SYS_COPYAREA=3Dm
> CONFIG_FB_SYS_IMAGEBLIT=3Dm
> # CONFIG_FB_FOREIGN_ENDIAN is not set
> CONFIG_FB_SYS_FOPS=3Dm
> CONFIG_FB_DEFERRED_IO=3Dy
> # CONFIG_FB_MODE_HELPERS is not set
> CONFIG_FB_TILEBLITTING=3Dy
>=20
> #
> # Frame buffer hardware drivers
> #
> # CONFIG_FB_CIRRUS is not set
> # CONFIG_FB_PM2 is not set
> # CONFIG_FB_CYBER2000 is not set
> # CONFIG_FB_ARC is not set
> # CONFIG_FB_ASILIANT is not set
> # CONFIG_FB_IMSTT is not set
> # CONFIG_FB_VGA16 is not set
> # CONFIG_FB_UVESA is not set
> CONFIG_FB_VESA=3Dy
> CONFIG_FB_EFI=3Dy
> # CONFIG_FB_N411 is not set
> # CONFIG_FB_HGA is not set
> # CONFIG_FB_OPENCORES is not set
> # CONFIG_FB_S1D13XXX is not set
> # CONFIG_FB_NVIDIA is not set
> # CONFIG_FB_RIVA is not set
> # CONFIG_FB_I740 is not set
> # CONFIG_FB_LE80578 is not set
> # CONFIG_FB_MATROX is not set
> # CONFIG_FB_RADEON is not set
> # CONFIG_FB_ATY128 is not set
> # CONFIG_FB_ATY is not set
> # CONFIG_FB_S3 is not set
> # CONFIG_FB_SAVAGE is not set
> # CONFIG_FB_SIS is not set
> # CONFIG_FB_VIA is not set
> # CONFIG_FB_NEOMAGIC is not set
> # CONFIG_FB_KYRO is not set
> # CONFIG_FB_3DFX is not set
> # CONFIG_FB_VOODOO1 is not set
> # CONFIG_FB_VT8623 is not set
> # CONFIG_FB_TRIDENT is not set
> # CONFIG_FB_ARK is not set
> # CONFIG_FB_PM3 is not set
> # CONFIG_FB_CARMINE is not set
> # CONFIG_FB_SM501 is not set
> # CONFIG_FB_SMSCUFX is not set
> # CONFIG_FB_UDL is not set
> # CONFIG_FB_IBM_GXT4500 is not set
> # CONFIG_FB_VIRTUAL is not set
> # CONFIG_FB_METRONOME is not set
> # CONFIG_FB_MB862XX is not set
> # CONFIG_FB_SIMPLE is not set
> # CONFIG_FB_SSD1307 is not set
> # CONFIG_FB_SM712 is not set
> # end of Frame buffer Devices
>=20
> #
> # Backlight & LCD device support
> #
> CONFIG_LCD_CLASS_DEVICE=3Dm
> # CONFIG_LCD_L4F00242T03 is not set
> # CONFIG_LCD_LMS283GF05 is not set
> # CONFIG_LCD_LTV350QV is not set
> # CONFIG_LCD_ILI922X is not set
> # CONFIG_LCD_ILI9320 is not set
> # CONFIG_LCD_TDO24M is not set
> # CONFIG_LCD_VGG2432A4 is not set
> CONFIG_LCD_PLATFORM=3Dm
> # CONFIG_LCD_AMS369FG06 is not set
> # CONFIG_LCD_LMS501KF03 is not set
> # CONFIG_LCD_HX8357 is not set
> # CONFIG_LCD_OTM3225A is not set
> CONFIG_BACKLIGHT_CLASS_DEVICE=3Dy
> # CONFIG_BACKLIGHT_KTD253 is not set
> # CONFIG_BACKLIGHT_PWM is not set
> CONFIG_BACKLIGHT_APPLE=3Dm
> # CONFIG_BACKLIGHT_QCOM_WLED is not set
> # CONFIG_BACKLIGHT_SAHARA is not set
> # CONFIG_BACKLIGHT_ADP8860 is not set
> # CONFIG_BACKLIGHT_ADP8870 is not set
> # CONFIG_BACKLIGHT_LM3630A is not set
> # CONFIG_BACKLIGHT_LM3639 is not set
> CONFIG_BACKLIGHT_LP855X=3Dm
> # CONFIG_BACKLIGHT_GPIO is not set
> # CONFIG_BACKLIGHT_LV5207LP is not set
> # CONFIG_BACKLIGHT_BD6107 is not set
> # CONFIG_BACKLIGHT_ARCXCNN is not set
> # end of Backlight & LCD device support
>=20
> CONFIG_HDMI=3Dy
>=20
> #
> # Console display driver support
> #
> CONFIG_VGA_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE=3Dy
> CONFIG_DUMMY_CONSOLE_COLUMNS=3D80
> CONFIG_DUMMY_CONSOLE_ROWS=3D25
> CONFIG_FRAMEBUFFER_CONSOLE=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_LEGACY_ACCELERATION is not set
> CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY=3Dy
> CONFIG_FRAMEBUFFER_CONSOLE_ROTATION=3Dy
> # CONFIG_FRAMEBUFFER_CONSOLE_DEFERRED_TAKEOVER is not set
> # end of Console display driver support
>=20
> CONFIG_LOGO=3Dy
> # CONFIG_LOGO_LINUX_MONO is not set
> # CONFIG_LOGO_LINUX_VGA16 is not set
> CONFIG_LOGO_LINUX_CLUT224=3Dy
> # end of Graphics support
>=20
> # CONFIG_SOUND is not set
>=20
> #
> # HID support
> #
> CONFIG_HID=3Dy
> CONFIG_HID_BATTERY_STRENGTH=3Dy
> CONFIG_HIDRAW=3Dy
> CONFIG_UHID=3Dm
> CONFIG_HID_GENERIC=3Dy
>=20
> #
> # Special HID drivers
> #
> CONFIG_HID_A4TECH=3Dm
> # CONFIG_HID_ACCUTOUCH is not set
> CONFIG_HID_ACRUX=3Dm
> # CONFIG_HID_ACRUX_FF is not set
> CONFIG_HID_APPLE=3Dm
> # CONFIG_HID_APPLEIR is not set
> CONFIG_HID_ASUS=3Dm
> CONFIG_HID_AUREAL=3Dm
> CONFIG_HID_BELKIN=3Dm
> # CONFIG_HID_BETOP_FF is not set
> # CONFIG_HID_BIGBEN_FF is not set
> CONFIG_HID_CHERRY=3Dm
> # CONFIG_HID_CHICONY is not set
> # CONFIG_HID_CORSAIR is not set
> # CONFIG_HID_COUGAR is not set
> # CONFIG_HID_MACALLY is not set
> CONFIG_HID_CMEDIA=3Dm
> # CONFIG_HID_CP2112 is not set
> # CONFIG_HID_CREATIVE_SB0540 is not set
> CONFIG_HID_CYPRESS=3Dm
> CONFIG_HID_DRAGONRISE=3Dm
> # CONFIG_DRAGONRISE_FF is not set
> # CONFIG_HID_EMS_FF is not set
> # CONFIG_HID_ELAN is not set
> CONFIG_HID_ELECOM=3Dm
> # CONFIG_HID_ELO is not set
> CONFIG_HID_EZKEY=3Dm
> # CONFIG_HID_FT260 is not set
> CONFIG_HID_GEMBIRD=3Dm
> CONFIG_HID_GFRM=3Dm
> # CONFIG_HID_GLORIOUS is not set
> # CONFIG_HID_HOLTEK is not set
> # CONFIG_HID_VIVALDI is not set
> # CONFIG_HID_GT683R is not set
> CONFIG_HID_KEYTOUCH=3Dm
> CONFIG_HID_KYE=3Dm
> # CONFIG_HID_UCLOGIC is not set
> CONFIG_HID_WALTOP=3Dm
> # CONFIG_HID_VIEWSONIC is not set
> # CONFIG_HID_XIAOMI is not set
> CONFIG_HID_GYRATION=3Dm
> CONFIG_HID_ICADE=3Dm
> CONFIG_HID_ITE=3Dm
> CONFIG_HID_JABRA=3Dm
> CONFIG_HID_TWINHAN=3Dm
> CONFIG_HID_KENSINGTON=3Dm
> CONFIG_HID_LCPOWER=3Dm
> CONFIG_HID_LED=3Dm
> CONFIG_HID_LENOVO=3Dm
> # CONFIG_HID_LETSKETCH is not set
> CONFIG_HID_LOGITECH=3Dm
> CONFIG_HID_LOGITECH_DJ=3Dm
> CONFIG_HID_LOGITECH_HIDPP=3Dm
> # CONFIG_LOGITECH_FF is not set
> # CONFIG_LOGIRUMBLEPAD2_FF is not set
> # CONFIG_LOGIG940_FF is not set
> # CONFIG_LOGIWHEELS_FF is not set
> CONFIG_HID_MAGICMOUSE=3Dy
> # CONFIG_HID_MALTRON is not set
> # CONFIG_HID_MAYFLASH is not set
> # CONFIG_HID_REDRAGON is not set
> CONFIG_HID_MICROSOFT=3Dm
> CONFIG_HID_MONTEREY=3Dm
> CONFIG_HID_MULTITOUCH=3Dm
> # CONFIG_HID_NINTENDO is not set
> CONFIG_HID_NTI=3Dm
> # CONFIG_HID_NTRIG is not set
> CONFIG_HID_ORTEK=3Dm
> CONFIG_HID_PANTHERLORD=3Dm
> # CONFIG_PANTHERLORD_FF is not set
> # CONFIG_HID_PENMOUNT is not set
> CONFIG_HID_PETALYNX=3Dm
> CONFIG_HID_PICOLCD=3Dm
> CONFIG_HID_PICOLCD_FB=3Dy
> CONFIG_HID_PICOLCD_BACKLIGHT=3Dy
> CONFIG_HID_PICOLCD_LCD=3Dy
> CONFIG_HID_PICOLCD_LEDS=3Dy
> CONFIG_HID_PICOLCD_CIR=3Dy
> CONFIG_HID_PLANTRONICS=3Dm
> CONFIG_HID_PRIMAX=3Dm
> # CONFIG_HID_RETRODE is not set
> # CONFIG_HID_ROCCAT is not set
> CONFIG_HID_SAITEK=3Dm
> CONFIG_HID_SAMSUNG=3Dm
> # CONFIG_HID_SEMITEK is not set
> # CONFIG_HID_SONY is not set
> CONFIG_HID_SPEEDLINK=3Dm
> # CONFIG_HID_STEAM is not set
> CONFIG_HID_STEELSERIES=3Dm
> CONFIG_HID_SUNPLUS=3Dm
> CONFIG_HID_RMI=3Dm
> CONFIG_HID_GREENASIA=3Dm
> # CONFIG_GREENASIA_FF is not set
> CONFIG_HID_SMARTJOYPLUS=3Dm
> # CONFIG_SMARTJOYPLUS_FF is not set
> CONFIG_HID_TIVO=3Dm
> CONFIG_HID_TOPSEED=3Dm
> CONFIG_HID_THINGM=3Dm
> CONFIG_HID_THRUSTMASTER=3Dm
> # CONFIG_THRUSTMASTER_FF is not set
> # CONFIG_HID_UDRAW_PS3 is not set
> # CONFIG_HID_U2FZERO is not set
> # CONFIG_HID_WACOM is not set
> CONFIG_HID_WIIMOTE=3Dm
> CONFIG_HID_XINMO=3Dm
> CONFIG_HID_ZEROPLUS=3Dm
> # CONFIG_ZEROPLUS_FF is not set
> CONFIG_HID_ZYDACRON=3Dm
> CONFIG_HID_SENSOR_HUB=3Dy
> CONFIG_HID_SENSOR_CUSTOM_SENSOR=3Dm
> CONFIG_HID_ALPS=3Dm
> # CONFIG_HID_MCP2221 is not set
> # end of Special HID drivers
>=20
> #
> # USB HID support
> #
> CONFIG_USB_HID=3Dy
> # CONFIG_HID_PID is not set
> # CONFIG_USB_HIDDEV is not set
> # end of USB HID support
>=20
> #
> # I2C HID support
> #
> # CONFIG_I2C_HID_ACPI is not set
> # end of I2C HID support
>=20
> #
> # Intel ISH HID support
> #
> CONFIG_INTEL_ISH_HID=3Dm
> # CONFIG_INTEL_ISH_FIRMWARE_DOWNLOADER is not set
> # end of Intel ISH HID support
>=20
> #
> # AMD SFH HID Support
> #
> # CONFIG_AMD_SFH_HID is not set
> # end of AMD SFH HID Support
> # end of HID support
>=20
> CONFIG_USB_OHCI_LITTLE_ENDIAN=3Dy
> CONFIG_USB_SUPPORT=3Dy
> CONFIG_USB_COMMON=3Dy
> # CONFIG_USB_LED_TRIG is not set
> # CONFIG_USB_ULPI_BUS is not set
> # CONFIG_USB_CONN_GPIO is not set
> CONFIG_USB_ARCH_HAS_HCD=3Dy
> CONFIG_USB=3Dy
> CONFIG_USB_PCI=3Dy
> CONFIG_USB_ANNOUNCE_NEW_DEVICES=3Dy
>=20
> #
> # Miscellaneous USB options
> #
> CONFIG_USB_DEFAULT_PERSIST=3Dy
> # CONFIG_USB_FEW_INIT_RETRIES is not set
> # CONFIG_USB_DYNAMIC_MINORS is not set
> # CONFIG_USB_OTG is not set
> # CONFIG_USB_OTG_PRODUCTLIST is not set
> CONFIG_USB_LEDS_TRIGGER_USBPORT=3Dy
> CONFIG_USB_AUTOSUSPEND_DELAY=3D2
> CONFIG_USB_MON=3Dy
>=20
> #
> # USB Host Controller Drivers
> #
> # CONFIG_USB_C67X00_HCD is not set
> CONFIG_USB_XHCI_HCD=3Dy
> # CONFIG_USB_XHCI_DBGCAP is not set
> CONFIG_USB_XHCI_PCI=3Dy
> # CONFIG_USB_XHCI_PCI_RENESAS is not set
> # CONFIG_USB_XHCI_PLATFORM is not set
> CONFIG_USB_EHCI_HCD=3Dy
> CONFIG_USB_EHCI_ROOT_HUB_TT=3Dy
> CONFIG_USB_EHCI_TT_NEWSCHED=3Dy
> CONFIG_USB_EHCI_PCI=3Dy
> # CONFIG_USB_EHCI_FSL is not set
> # CONFIG_USB_EHCI_HCD_PLATFORM is not set
> # CONFIG_USB_OXU210HP_HCD is not set
> # CONFIG_USB_ISP116X_HCD is not set
> # CONFIG_USB_FOTG210_HCD is not set
> # CONFIG_USB_MAX3421_HCD is not set
> CONFIG_USB_OHCI_HCD=3Dy
> CONFIG_USB_OHCI_HCD_PCI=3Dy
> # CONFIG_USB_OHCI_HCD_PLATFORM is not set
> CONFIG_USB_UHCI_HCD=3Dy
> # CONFIG_USB_SL811_HCD is not set
> # CONFIG_USB_R8A66597_HCD is not set
> # CONFIG_USB_HCD_BCMA is not set
> # CONFIG_USB_HCD_TEST_MODE is not set
>=20
> #
> # USB Device Class drivers
> #
> # CONFIG_USB_ACM is not set
> # CONFIG_USB_PRINTER is not set
> # CONFIG_USB_WDM is not set
> # CONFIG_USB_TMC is not set
>=20
> #
> # NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
> #
>=20
> #
> # also be needed; see USB_STORAGE Help for more info
> #
> CONFIG_USB_STORAGE=3Dm
> # CONFIG_USB_STORAGE_DEBUG is not set
> # CONFIG_USB_STORAGE_REALTEK is not set
> # CONFIG_USB_STORAGE_DATAFAB is not set
> # CONFIG_USB_STORAGE_FREECOM is not set
> # CONFIG_USB_STORAGE_ISD200 is not set
> # CONFIG_USB_STORAGE_USBAT is not set
> # CONFIG_USB_STORAGE_SDDR09 is not set
> # CONFIG_USB_STORAGE_SDDR55 is not set
> # CONFIG_USB_STORAGE_JUMPSHOT is not set
> # CONFIG_USB_STORAGE_ALAUDA is not set
> # CONFIG_USB_STORAGE_ONETOUCH is not set
> # CONFIG_USB_STORAGE_KARMA is not set
> # CONFIG_USB_STORAGE_CYPRESS_ATACB is not set
> # CONFIG_USB_STORAGE_ENE_UB6250 is not set
> # CONFIG_USB_UAS is not set
>=20
> #
> # USB Imaging devices
> #
> # CONFIG_USB_MDC800 is not set
> # CONFIG_USB_MICROTEK is not set
> # CONFIG_USBIP_CORE is not set
> # CONFIG_USB_CDNS_SUPPORT is not set
> # CONFIG_USB_MUSB_HDRC is not set
> # CONFIG_USB_DWC3 is not set
> # CONFIG_USB_DWC2 is not set
> # CONFIG_USB_CHIPIDEA is not set
> # CONFIG_USB_ISP1760 is not set
>=20
> #
> # USB port drivers
> #
> # CONFIG_USB_USS720 is not set
> CONFIG_USB_SERIAL=3Dm
> CONFIG_USB_SERIAL_GENERIC=3Dy
> # CONFIG_USB_SERIAL_SIMPLE is not set
> # CONFIG_USB_SERIAL_AIRCABLE is not set
> # CONFIG_USB_SERIAL_ARK3116 is not set
> # CONFIG_USB_SERIAL_BELKIN is not set
> # CONFIG_USB_SERIAL_CH341 is not set
> # CONFIG_USB_SERIAL_WHITEHEAT is not set
> # CONFIG_USB_SERIAL_DIGI_ACCELEPORT is not set
> # CONFIG_USB_SERIAL_CP210X is not set
> # CONFIG_USB_SERIAL_CYPRESS_M8 is not set
> # CONFIG_USB_SERIAL_EMPEG is not set
> # CONFIG_USB_SERIAL_FTDI_SIO is not set
> # CONFIG_USB_SERIAL_VISOR is not set
> # CONFIG_USB_SERIAL_IPAQ is not set
> # CONFIG_USB_SERIAL_IR is not set
> # CONFIG_USB_SERIAL_EDGEPORT is not set
> # CONFIG_USB_SERIAL_EDGEPORT_TI is not set
> # CONFIG_USB_SERIAL_F81232 is not set
> # CONFIG_USB_SERIAL_F8153X is not set
> # CONFIG_USB_SERIAL_GARMIN is not set
> # CONFIG_USB_SERIAL_IPW is not set
> # CONFIG_USB_SERIAL_IUU is not set
> # CONFIG_USB_SERIAL_KEYSPAN_PDA is not set
> # CONFIG_USB_SERIAL_KEYSPAN is not set
> # CONFIG_USB_SERIAL_KLSI is not set
> # CONFIG_USB_SERIAL_KOBIL_SCT is not set
> # CONFIG_USB_SERIAL_MCT_U232 is not set
> # CONFIG_USB_SERIAL_METRO is not set
> # CONFIG_USB_SERIAL_MOS7720 is not set
> # CONFIG_USB_SERIAL_MOS7840 is not set
> # CONFIG_USB_SERIAL_MXUPORT is not set
> # CONFIG_USB_SERIAL_NAVMAN is not set
> # CONFIG_USB_SERIAL_PL2303 is not set
> # CONFIG_USB_SERIAL_OTI6858 is not set
> # CONFIG_USB_SERIAL_QCAUX is not set
> # CONFIG_USB_SERIAL_QUALCOMM is not set
> # CONFIG_USB_SERIAL_SPCP8X5 is not set
> # CONFIG_USB_SERIAL_SAFE is not set
> # CONFIG_USB_SERIAL_SIERRAWIRELESS is not set
> # CONFIG_USB_SERIAL_SYMBOL is not set
> # CONFIG_USB_SERIAL_TI is not set
> # CONFIG_USB_SERIAL_CYBERJACK is not set
> # CONFIG_USB_SERIAL_OPTION is not set
> # CONFIG_USB_SERIAL_OMNINET is not set
> # CONFIG_USB_SERIAL_OPTICON is not set
> # CONFIG_USB_SERIAL_XSENS_MT is not set
> # CONFIG_USB_SERIAL_WISHBONE is not set
> # CONFIG_USB_SERIAL_SSU100 is not set
> # CONFIG_USB_SERIAL_QT2 is not set
> # CONFIG_USB_SERIAL_UPD78F0730 is not set
> # CONFIG_USB_SERIAL_XR is not set
> CONFIG_USB_SERIAL_DEBUG=3Dm
>=20
> #
> # USB Miscellaneous drivers
> #
> # CONFIG_USB_EMI62 is not set
> # CONFIG_USB_EMI26 is not set
> # CONFIG_USB_ADUTUX is not set
> # CONFIG_USB_SEVSEG is not set
> # CONFIG_USB_LEGOTOWER is not set
> # CONFIG_USB_LCD is not set
> # CONFIG_USB_CYPRESS_CY7C63 is not set
> # CONFIG_USB_CYTHERM is not set
> # CONFIG_USB_IDMOUSE is not set
> # CONFIG_USB_FTDI_ELAN is not set
> # CONFIG_USB_APPLEDISPLAY is not set
> # CONFIG_APPLE_MFI_FASTCHARGE is not set
> # CONFIG_USB_SISUSBVGA is not set
> # CONFIG_USB_LD is not set
> # CONFIG_USB_TRANCEVIBRATOR is not set
> # CONFIG_USB_IOWARRIOR is not set
> # CONFIG_USB_TEST is not set
> # CONFIG_USB_EHSET_TEST_FIXTURE is not set
> # CONFIG_USB_ISIGHTFW is not set
> # CONFIG_USB_YUREX is not set
> # CONFIG_USB_EZUSB_FX2 is not set
> # CONFIG_USB_HUB_USB251XB is not set
> # CONFIG_USB_HSIC_USB3503 is not set
> # CONFIG_USB_HSIC_USB4604 is not set
> # CONFIG_USB_LINK_LAYER_TEST is not set
> # CONFIG_USB_CHAOSKEY is not set
> # CONFIG_USB_ATM is not set
>=20
> #
> # USB Physical Layer drivers
> #
> # CONFIG_NOP_USB_XCEIV is not set
> # CONFIG_USB_GPIO_VBUS is not set
> # CONFIG_USB_ISP1301 is not set
> # end of USB Physical Layer drivers
>=20
> # CONFIG_USB_GADGET is not set
> CONFIG_TYPEC=3Dy
> # CONFIG_TYPEC_TCPM is not set
> CONFIG_TYPEC_UCSI=3Dy
> # CONFIG_UCSI_CCG is not set
> CONFIG_UCSI_ACPI=3Dy
> # CONFIG_TYPEC_TPS6598X is not set
> # CONFIG_TYPEC_STUSB160X is not set
>=20
> #
> # USB Type-C Multiplexer/DeMultiplexer Switch support
> #
> # CONFIG_TYPEC_MUX_PI3USB30532 is not set
> # end of USB Type-C Multiplexer/DeMultiplexer Switch support
>=20
> #
> # USB Type-C Alternate Mode drivers
> #
> # CONFIG_TYPEC_DP_ALTMODE is not set
> # end of USB Type-C Alternate Mode drivers
>=20
> # CONFIG_USB_ROLE_SWITCH is not set
> CONFIG_MMC=3Dm
> CONFIG_MMC_BLOCK=3Dm
> CONFIG_MMC_BLOCK_MINORS=3D8
> CONFIG_SDIO_UART=3Dm
> # CONFIG_MMC_TEST is not set
>=20
> #
> # MMC/SD/SDIO Host Controller Drivers
> #
> # CONFIG_MMC_DEBUG is not set
> CONFIG_MMC_SDHCI=3Dm
> CONFIG_MMC_SDHCI_IO_ACCESSORS=3Dy
> CONFIG_MMC_SDHCI_PCI=3Dm
> CONFIG_MMC_RICOH_MMC=3Dy
> CONFIG_MMC_SDHCI_ACPI=3Dm
> CONFIG_MMC_SDHCI_PLTFM=3Dm
> # CONFIG_MMC_SDHCI_F_SDH30 is not set
> # CONFIG_MMC_WBSD is not set
> # CONFIG_MMC_TIFM_SD is not set
> # CONFIG_MMC_SPI is not set
> # CONFIG_MMC_CB710 is not set
> # CONFIG_MMC_VIA_SDMMC is not set
> # CONFIG_MMC_VUB300 is not set
> # CONFIG_MMC_USHC is not set
> # CONFIG_MMC_USDHI6ROL0 is not set
> # CONFIG_MMC_REALTEK_PCI is not set
> CONFIG_MMC_CQHCI=3Dm
> # CONFIG_MMC_HSQ is not set
> # CONFIG_MMC_TOSHIBA_PCI is not set
> # CONFIG_MMC_MTK is not set
> # CONFIG_MMC_SDHCI_XENON is not set
> # CONFIG_MEMSTICK is not set
> CONFIG_NEW_LEDS=3Dy
> CONFIG_LEDS_CLASS=3Dy
> # CONFIG_LEDS_CLASS_FLASH is not set
> # CONFIG_LEDS_CLASS_MULTICOLOR is not set
> # CONFIG_LEDS_BRIGHTNESS_HW_CHANGED is not set
>=20
> #
> # LED drivers
> #
> # CONFIG_LEDS_APU is not set
> CONFIG_LEDS_LM3530=3Dm
> # CONFIG_LEDS_LM3532 is not set
> # CONFIG_LEDS_LM3642 is not set
> # CONFIG_LEDS_PCA9532 is not set
> # CONFIG_LEDS_GPIO is not set
> CONFIG_LEDS_LP3944=3Dm
> # CONFIG_LEDS_LP3952 is not set
> # CONFIG_LEDS_LP50XX is not set
> CONFIG_LEDS_CLEVO_MAIL=3Dm
> # CONFIG_LEDS_PCA955X is not set
> # CONFIG_LEDS_PCA963X is not set
> # CONFIG_LEDS_DAC124S085 is not set
> # CONFIG_LEDS_PWM is not set
> # CONFIG_LEDS_BD2802 is not set
> CONFIG_LEDS_INTEL_SS4200=3Dm
> CONFIG_LEDS_LT3593=3Dm
> # CONFIG_LEDS_TCA6507 is not set
> # CONFIG_LEDS_TLC591XX is not set
> # CONFIG_LEDS_LM355x is not set
>=20
> #
> # LED driver for blink(1) USB RGB LED is under Special HID drivers (HID_T=
HINGM)
> #
> CONFIG_LEDS_BLINKM=3Dm
> CONFIG_LEDS_MLXCPLD=3Dm
> # CONFIG_LEDS_MLXREG is not set
> # CONFIG_LEDS_USER is not set
> # CONFIG_LEDS_NIC78BX is not set
> # CONFIG_LEDS_TI_LMU_COMMON is not set
>=20
> #
> # Flash and Torch LED drivers
> #
>=20
> #
> # LED Triggers
> #
> CONFIG_LEDS_TRIGGERS=3Dy
> CONFIG_LEDS_TRIGGER_TIMER=3Dm
> CONFIG_LEDS_TRIGGER_ONESHOT=3Dm
> # CONFIG_LEDS_TRIGGER_DISK is not set
> CONFIG_LEDS_TRIGGER_HEARTBEAT=3Dm
> CONFIG_LEDS_TRIGGER_BACKLIGHT=3Dm
> # CONFIG_LEDS_TRIGGER_CPU is not set
> # CONFIG_LEDS_TRIGGER_ACTIVITY is not set
> CONFIG_LEDS_TRIGGER_GPIO=3Dm
> CONFIG_LEDS_TRIGGER_DEFAULT_ON=3Dm
>=20
> #
> # iptables trigger is under Netfilter config (LED target)
> #
> CONFIG_LEDS_TRIGGER_TRANSIENT=3Dm
> CONFIG_LEDS_TRIGGER_CAMERA=3Dm
> # CONFIG_LEDS_TRIGGER_PANIC is not set
> # CONFIG_LEDS_TRIGGER_NETDEV is not set
> # CONFIG_LEDS_TRIGGER_PATTERN is not set
> CONFIG_LEDS_TRIGGER_AUDIO=3Dm
> # CONFIG_LEDS_TRIGGER_TTY is not set
>=20
> #
> # Simple LED drivers
> #
> # CONFIG_ACCESSIBILITY is not set
> CONFIG_INFINIBAND=3Dm
> CONFIG_INFINIBAND_USER_MAD=3Dm
> CONFIG_INFINIBAND_USER_ACCESS=3Dm
> CONFIG_INFINIBAND_USER_MEM=3Dy
> CONFIG_INFINIBAND_ON_DEMAND_PAGING=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS=3Dy
> CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=3Dy
> CONFIG_INFINIBAND_VIRT_DMA=3Dy
> # CONFIG_INFINIBAND_MTHCA is not set
> # CONFIG_INFINIBAND_EFA is not set
> # CONFIG_MLX4_INFINIBAND is not set
> # CONFIG_INFINIBAND_OCRDMA is not set
> # CONFIG_INFINIBAND_USNIC is not set
> # CONFIG_INFINIBAND_RDMAVT is not set
> CONFIG_RDMA_RXE=3Dm
> CONFIG_RDMA_SIW=3Dm
> CONFIG_INFINIBAND_IPOIB=3Dm
> # CONFIG_INFINIBAND_IPOIB_CM is not set
> CONFIG_INFINIBAND_IPOIB_DEBUG=3Dy
> # CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
> CONFIG_INFINIBAND_SRP=3Dm
> CONFIG_INFINIBAND_SRPT=3Dm
> # CONFIG_INFINIBAND_ISER is not set
> # CONFIG_INFINIBAND_ISERT is not set
> # CONFIG_INFINIBAND_RTRS_CLIENT is not set
> # CONFIG_INFINIBAND_RTRS_SERVER is not set
> # CONFIG_INFINIBAND_OPA_VNIC is not set
> CONFIG_EDAC_ATOMIC_SCRUB=3Dy
> CONFIG_EDAC_SUPPORT=3Dy
> CONFIG_EDAC=3Dy
> CONFIG_EDAC_LEGACY_SYSFS=3Dy
> # CONFIG_EDAC_DEBUG is not set
> CONFIG_EDAC_GHES=3Dy
> CONFIG_EDAC_E752X=3Dm
> CONFIG_EDAC_I82975X=3Dm
> CONFIG_EDAC_I3000=3Dm
> CONFIG_EDAC_I3200=3Dm
> CONFIG_EDAC_IE31200=3Dm
> CONFIG_EDAC_X38=3Dm
> CONFIG_EDAC_I5400=3Dm
> CONFIG_EDAC_I7CORE=3Dm
> CONFIG_EDAC_I5000=3Dm
> CONFIG_EDAC_I5100=3Dm
> CONFIG_EDAC_I7300=3Dm
> CONFIG_EDAC_SBRIDGE=3Dm
> CONFIG_EDAC_SKX=3Dm
> # CONFIG_EDAC_I10NM is not set
> CONFIG_EDAC_PND2=3Dm
> # CONFIG_EDAC_IGEN6 is not set
> CONFIG_RTC_LIB=3Dy
> CONFIG_RTC_MC146818_LIB=3Dy
> CONFIG_RTC_CLASS=3Dy
> CONFIG_RTC_HCTOSYS=3Dy
> CONFIG_RTC_HCTOSYS_DEVICE=3D"rtc0"
> # CONFIG_RTC_SYSTOHC is not set
> # CONFIG_RTC_DEBUG is not set
> CONFIG_RTC_LIB_KUNIT_TEST=3Dm
> CONFIG_RTC_NVMEM=3Dy
>=20
> #
> # RTC interfaces
> #
> CONFIG_RTC_INTF_SYSFS=3Dy
> CONFIG_RTC_INTF_PROC=3Dy
> CONFIG_RTC_INTF_DEV=3Dy
> # CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
> # CONFIG_RTC_DRV_TEST is not set
>=20
> #
> # I2C RTC drivers
> #
> # CONFIG_RTC_DRV_ABB5ZES3 is not set
> # CONFIG_RTC_DRV_ABEOZ9 is not set
> # CONFIG_RTC_DRV_ABX80X is not set
> CONFIG_RTC_DRV_DS1307=3Dm
> # CONFIG_RTC_DRV_DS1307_CENTURY is not set
> CONFIG_RTC_DRV_DS1374=3Dm
> # CONFIG_RTC_DRV_DS1374_WDT is not set
> CONFIG_RTC_DRV_DS1672=3Dm
> CONFIG_RTC_DRV_MAX6900=3Dm
> CONFIG_RTC_DRV_RS5C372=3Dm
> CONFIG_RTC_DRV_ISL1208=3Dm
> CONFIG_RTC_DRV_ISL12022=3Dm
> CONFIG_RTC_DRV_X1205=3Dm
> CONFIG_RTC_DRV_PCF8523=3Dm
> # CONFIG_RTC_DRV_PCF85063 is not set
> # CONFIG_RTC_DRV_PCF85363 is not set
> CONFIG_RTC_DRV_PCF8563=3Dm
> CONFIG_RTC_DRV_PCF8583=3Dm
> CONFIG_RTC_DRV_M41T80=3Dm
> CONFIG_RTC_DRV_M41T80_WDT=3Dy
> CONFIG_RTC_DRV_BQ32K=3Dm
> # CONFIG_RTC_DRV_S35390A is not set
> CONFIG_RTC_DRV_FM3130=3Dm
> # CONFIG_RTC_DRV_RX8010 is not set
> CONFIG_RTC_DRV_RX8581=3Dm
> CONFIG_RTC_DRV_RX8025=3Dm
> CONFIG_RTC_DRV_EM3027=3Dm
> # CONFIG_RTC_DRV_RV3028 is not set
> # CONFIG_RTC_DRV_RV3032 is not set
> # CONFIG_RTC_DRV_RV8803 is not set
> # CONFIG_RTC_DRV_SD3078 is not set
>=20
> #
> # SPI RTC drivers
> #
> # CONFIG_RTC_DRV_M41T93 is not set
> # CONFIG_RTC_DRV_M41T94 is not set
> # CONFIG_RTC_DRV_DS1302 is not set
> # CONFIG_RTC_DRV_DS1305 is not set
> # CONFIG_RTC_DRV_DS1343 is not set
> # CONFIG_RTC_DRV_DS1347 is not set
> # CONFIG_RTC_DRV_DS1390 is not set
> # CONFIG_RTC_DRV_MAX6916 is not set
> # CONFIG_RTC_DRV_R9701 is not set
> CONFIG_RTC_DRV_RX4581=3Dm
> # CONFIG_RTC_DRV_RS5C348 is not set
> # CONFIG_RTC_DRV_MAX6902 is not set
> # CONFIG_RTC_DRV_PCF2123 is not set
> # CONFIG_RTC_DRV_MCP795 is not set
> CONFIG_RTC_I2C_AND_SPI=3Dy
>=20
> #
> # SPI and I2C RTC drivers
> #
> CONFIG_RTC_DRV_DS3232=3Dm
> CONFIG_RTC_DRV_DS3232_HWMON=3Dy
> # CONFIG_RTC_DRV_PCF2127 is not set
> CONFIG_RTC_DRV_RV3029C2=3Dm
> # CONFIG_RTC_DRV_RV3029_HWMON is not set
> # CONFIG_RTC_DRV_RX6110 is not set
>=20
> #
> # Platform RTC drivers
> #
> CONFIG_RTC_DRV_CMOS=3Dy
> CONFIG_RTC_DRV_DS1286=3Dm
> CONFIG_RTC_DRV_DS1511=3Dm
> CONFIG_RTC_DRV_DS1553=3Dm
> # CONFIG_RTC_DRV_DS1685_FAMILY is not set
> CONFIG_RTC_DRV_DS1742=3Dm
> CONFIG_RTC_DRV_DS2404=3Dm
> CONFIG_RTC_DRV_STK17TA8=3Dm
> # CONFIG_RTC_DRV_M48T86 is not set
> CONFIG_RTC_DRV_M48T35=3Dm
> CONFIG_RTC_DRV_M48T59=3Dm
> CONFIG_RTC_DRV_MSM6242=3Dm
> CONFIG_RTC_DRV_BQ4802=3Dm
> CONFIG_RTC_DRV_RP5C01=3Dm
> CONFIG_RTC_DRV_V3020=3Dm
>=20
> #
> # on-CPU RTC drivers
> #
> # CONFIG_RTC_DRV_FTRTC010 is not set
>=20
> #
> # HID Sensor RTC drivers
> #
> # CONFIG_RTC_DRV_GOLDFISH is not set
> CONFIG_DMADEVICES=3Dy
> # CONFIG_DMADEVICES_DEBUG is not set
>=20
> #
> # DMA Devices
> #
> CONFIG_DMA_ENGINE=3Dy
> CONFIG_DMA_VIRTUAL_CHANNELS=3Dy
> CONFIG_DMA_ACPI=3Dy
> # CONFIG_ALTERA_MSGDMA is not set
> CONFIG_INTEL_IDMA64=3Dm
> # CONFIG_INTEL_IDXD is not set
> # CONFIG_INTEL_IDXD_COMPAT is not set
> CONFIG_INTEL_IOATDMA=3Dm
> # CONFIG_PLX_DMA is not set
> # CONFIG_AMD_PTDMA is not set
> # CONFIG_QCOM_HIDMA_MGMT is not set
> # CONFIG_QCOM_HIDMA is not set
> CONFIG_DW_DMAC_CORE=3Dy
> CONFIG_DW_DMAC=3Dm
> CONFIG_DW_DMAC_PCI=3Dy
> # CONFIG_DW_EDMA is not set
> # CONFIG_DW_EDMA_PCIE is not set
> CONFIG_HSU_DMA=3Dy
> # CONFIG_SF_PDMA is not set
> # CONFIG_INTEL_LDMA is not set
>=20
> #
> # DMA Clients
> #
> CONFIG_ASYNC_TX_DMA=3Dy
> CONFIG_DMATEST=3Dm
> CONFIG_DMA_ENGINE_RAID=3Dy
>=20
> #
> # DMABUF options
> #
> CONFIG_SYNC_FILE=3Dy
> # CONFIG_SW_SYNC is not set
> # CONFIG_UDMABUF is not set
> # CONFIG_DMABUF_MOVE_NOTIFY is not set
> # CONFIG_DMABUF_DEBUG is not set
> # CONFIG_DMABUF_SELFTESTS is not set
> # CONFIG_DMABUF_HEAPS is not set
> # CONFIG_DMABUF_SYSFS_STATS is not set
> # end of DMABUF options
>=20
> CONFIG_DCA=3Dm
> # CONFIG_AUXDISPLAY is not set
> # CONFIG_PANEL is not set
> CONFIG_UIO=3Dm
> CONFIG_UIO_CIF=3Dm
> CONFIG_UIO_PDRV_GENIRQ=3Dm
> # CONFIG_UIO_DMEM_GENIRQ is not set
> CONFIG_UIO_AEC=3Dm
> CONFIG_UIO_SERCOS3=3Dm
> CONFIG_UIO_PCI_GENERIC=3Dm
> # CONFIG_UIO_NETX is not set
> # CONFIG_UIO_PRUSS is not set
> # CONFIG_UIO_MF624 is not set
> CONFIG_VFIO=3Dm
> CONFIG_VFIO_IOMMU_TYPE1=3Dm
> CONFIG_VFIO_VIRQFD=3Dm
> CONFIG_VFIO_NOIOMMU=3Dy
> CONFIG_VFIO_PCI_CORE=3Dm
> CONFIG_VFIO_PCI_MMAP=3Dy
> CONFIG_VFIO_PCI_INTX=3Dy
> CONFIG_VFIO_PCI=3Dm
> # CONFIG_VFIO_PCI_VGA is not set
> # CONFIG_VFIO_PCI_IGD is not set
> CONFIG_VFIO_MDEV=3Dm
> CONFIG_IRQ_BYPASS_MANAGER=3Dm
> # CONFIG_VIRT_DRIVERS is not set
> CONFIG_VIRTIO=3Dy
> CONFIG_VIRTIO_PCI_LIB=3Dy
> CONFIG_VIRTIO_PCI_LIB_LEGACY=3Dy
> CONFIG_VIRTIO_MENU=3Dy
> CONFIG_VIRTIO_PCI=3Dy
> CONFIG_VIRTIO_PCI_LEGACY=3Dy
> # CONFIG_VIRTIO_PMEM is not set
> CONFIG_VIRTIO_BALLOON=3Dm
> CONFIG_VIRTIO_MEM=3Dm
> CONFIG_VIRTIO_INPUT=3Dm
> # CONFIG_VIRTIO_MMIO is not set
> CONFIG_VIRTIO_DMA_SHARED_BUFFER=3Dm
> # CONFIG_VDPA is not set
> CONFIG_VHOST_IOTLB=3Dm
> CONFIG_VHOST=3Dm
> CONFIG_VHOST_MENU=3Dy
> CONFIG_VHOST_NET=3Dm
> # CONFIG_VHOST_SCSI is not set
> CONFIG_VHOST_VSOCK=3Dm
> # CONFIG_VHOST_CROSS_ENDIAN_LEGACY is not set
>=20
> #
> # Microsoft Hyper-V guest support
> #
> # CONFIG_HYPERV is not set
> # end of Microsoft Hyper-V guest support
>=20
> # CONFIG_GREYBUS is not set
> # CONFIG_COMEDI is not set
> # CONFIG_STAGING is not set
> CONFIG_X86_PLATFORM_DEVICES=3Dy
> CONFIG_ACPI_WMI=3Dm
> CONFIG_WMI_BMOF=3Dm
> # CONFIG_HUAWEI_WMI is not set
> # CONFIG_UV_SYSFS is not set
> CONFIG_MXM_WMI=3Dm
> # CONFIG_PEAQ_WMI is not set
> # CONFIG_NVIDIA_WMI_EC_BACKLIGHT is not set
> # CONFIG_XIAOMI_WMI is not set
> # CONFIG_GIGABYTE_WMI is not set
> # CONFIG_YOGABOOK_WMI is not set
> CONFIG_ACERHDF=3Dm
> # CONFIG_ACER_WIRELESS is not set
> CONFIG_ACER_WMI=3Dm
> # CONFIG_AMD_PMC is not set
> # CONFIG_ADV_SWBUTTON is not set
> CONFIG_APPLE_GMUX=3Dm
> CONFIG_ASUS_LAPTOP=3Dm
> # CONFIG_ASUS_WIRELESS is not set
> CONFIG_ASUS_WMI=3Dm
> CONFIG_ASUS_NB_WMI=3Dm
> # CONFIG_ASUS_TF103C_DOCK is not set
> # CONFIG_MERAKI_MX100 is not set
> CONFIG_EEEPC_LAPTOP=3Dm
> CONFIG_EEEPC_WMI=3Dm
> # CONFIG_X86_PLATFORM_DRIVERS_DELL is not set
> CONFIG_AMILO_RFKILL=3Dm
> CONFIG_FUJITSU_LAPTOP=3Dm
> CONFIG_FUJITSU_TABLET=3Dm
> # CONFIG_GPD_POCKET_FAN is not set
> CONFIG_HP_ACCEL=3Dm
> # CONFIG_WIRELESS_HOTKEY is not set
> CONFIG_HP_WMI=3Dm
> # CONFIG_IBM_RTL is not set
> CONFIG_IDEAPAD_LAPTOP=3Dm
> CONFIG_SENSORS_HDAPS=3Dm
> CONFIG_THINKPAD_ACPI=3Dm
> # CONFIG_THINKPAD_ACPI_DEBUGFACILITIES is not set
> # CONFIG_THINKPAD_ACPI_DEBUG is not set
> # CONFIG_THINKPAD_ACPI_UNSAFE_LEDS is not set
> CONFIG_THINKPAD_ACPI_VIDEO=3Dy
> CONFIG_THINKPAD_ACPI_HOTKEY_POLL=3Dy
> # CONFIG_THINKPAD_LMI is not set
> # CONFIG_INTEL_ATOMISP2_PM is not set
> # CONFIG_INTEL_SAR_INT1092 is not set
> CONFIG_INTEL_PMC_CORE=3Dm
>=20
> #
> # Intel Speed Select Technology interface support
> #
> # CONFIG_INTEL_SPEED_SELECT_INTERFACE is not set
> # end of Intel Speed Select Technology interface support
>=20
> CONFIG_INTEL_WMI=3Dy
> # CONFIG_INTEL_WMI_SBL_FW_UPDATE is not set
> CONFIG_INTEL_WMI_THUNDERBOLT=3Dm
> CONFIG_INTEL_HID_EVENT=3Dm
> CONFIG_INTEL_VBTN=3Dm
> # CONFIG_INTEL_INT0002_VGPIO is not set
> CONFIG_INTEL_OAKTRAIL=3Dm
> # CONFIG_INTEL_ISHTP_ECLITE is not set
> # CONFIG_INTEL_PUNIT_IPC is not set
> CONFIG_INTEL_RST=3Dm
> # CONFIG_INTEL_SMARTCONNECT is not set
> CONFIG_INTEL_TURBO_MAX_3=3Dy
> # CONFIG_INTEL_UNCORE_FREQ_CONTROL is not set
> # CONFIG_INTEL_VSEC is not set
> CONFIG_MSI_LAPTOP=3Dm
> CONFIG_MSI_WMI=3Dm
> # CONFIG_PCENGINES_APU2 is not set
> # CONFIG_BARCO_P50_GPIO is not set
> CONFIG_SAMSUNG_LAPTOP=3Dm
> CONFIG_SAMSUNG_Q10=3Dm
> CONFIG_TOSHIBA_BT_RFKILL=3Dm
> # CONFIG_TOSHIBA_HAPS is not set
> # CONFIG_TOSHIBA_WMI is not set
> CONFIG_ACPI_CMPC=3Dm
> CONFIG_COMPAL_LAPTOP=3Dm
> # CONFIG_LG_LAPTOP is not set
> CONFIG_PANASONIC_LAPTOP=3Dm
> CONFIG_SONY_LAPTOP=3Dm
> CONFIG_SONYPI_COMPAT=3Dy
> # CONFIG_SYSTEM76_ACPI is not set
> CONFIG_TOPSTAR_LAPTOP=3Dm
> # CONFIG_I2C_MULTI_INSTANTIATE is not set
> CONFIG_MLX_PLATFORM=3Dm
> CONFIG_INTEL_IPS=3Dm
> # CONFIG_INTEL_SCU_PCI is not set
> # CONFIG_INTEL_SCU_PLATFORM is not set
> # CONFIG_SIEMENS_SIMATIC_IPC is not set
> CONFIG_PMC_ATOM=3Dy
> # CONFIG_CHROME_PLATFORMS is not set
> CONFIG_MELLANOX_PLATFORM=3Dy
> CONFIG_MLXREG_HOTPLUG=3Dm
> # CONFIG_MLXREG_IO is not set
> # CONFIG_MLXREG_LC is not set
> CONFIG_SURFACE_PLATFORMS=3Dy
> # CONFIG_SURFACE3_WMI is not set
> # CONFIG_SURFACE_3_POWER_OPREGION is not set
> # CONFIG_SURFACE_GPE is not set
> # CONFIG_SURFACE_HOTPLUG is not set
> # CONFIG_SURFACE_PRO3_BUTTON is not set
> CONFIG_HAVE_CLK=3Dy
> CONFIG_HAVE_CLK_PREPARE=3Dy
> CONFIG_COMMON_CLK=3Dy
> # CONFIG_LMK04832 is not set
> # CONFIG_COMMON_CLK_MAX9485 is not set
> # CONFIG_COMMON_CLK_SI5341 is not set
> # CONFIG_COMMON_CLK_SI5351 is not set
> # CONFIG_COMMON_CLK_SI544 is not set
> # CONFIG_COMMON_CLK_CDCE706 is not set
> # CONFIG_COMMON_CLK_CS2000_CP is not set
> # CONFIG_COMMON_CLK_LAN966X is not set
> # CONFIG_COMMON_CLK_PWM is not set
> # CONFIG_XILINX_VCU is not set
> CONFIG_HWSPINLOCK=3Dy
>=20
> #
> # Clock Source drivers
> #
> CONFIG_CLKEVT_I8253=3Dy
> CONFIG_I8253_LOCK=3Dy
> CONFIG_CLKBLD_I8253=3Dy
> # end of Clock Source drivers
>=20
> CONFIG_MAILBOX=3Dy
> CONFIG_PCC=3Dy
> # CONFIG_ALTERA_MBOX is not set
> CONFIG_IOMMU_IOVA=3Dy
> CONFIG_IOASID=3Dy
> CONFIG_IOMMU_API=3Dy
> CONFIG_IOMMU_SUPPORT=3Dy
>=20
> #
> # Generic IOMMU Pagetable Support
> #
> # end of Generic IOMMU Pagetable Support
>=20
> # CONFIG_IOMMU_DEBUGFS is not set
> # CONFIG_IOMMU_DEFAULT_DMA_STRICT is not set
> CONFIG_IOMMU_DEFAULT_DMA_LAZY=3Dy
> # CONFIG_IOMMU_DEFAULT_PASSTHROUGH is not set
> CONFIG_IOMMU_DMA=3Dy
> # CONFIG_AMD_IOMMU is not set
> CONFIG_DMAR_TABLE=3Dy
> CONFIG_INTEL_IOMMU=3Dy
> # CONFIG_INTEL_IOMMU_SVM is not set
> # CONFIG_INTEL_IOMMU_DEFAULT_ON is not set
> CONFIG_INTEL_IOMMU_FLOPPY_WA=3Dy
> CONFIG_INTEL_IOMMU_SCALABLE_MODE_DEFAULT_ON=3Dy
> CONFIG_IRQ_REMAP=3Dy
> # CONFIG_VIRTIO_IOMMU is not set
>=20
> #
> # Remoteproc drivers
> #
> # CONFIG_REMOTEPROC is not set
> # end of Remoteproc drivers
>=20
> #
> # Rpmsg drivers
> #
> # CONFIG_RPMSG_QCOM_GLINK_RPM is not set
> # CONFIG_RPMSG_VIRTIO is not set
> # end of Rpmsg drivers
>=20
> # CONFIG_SOUNDWIRE is not set
>=20
> #
> # SOC (System On Chip) specific Drivers
> #
>=20
> #
> # Amlogic SoC drivers
> #
> # end of Amlogic SoC drivers
>=20
> #
> # Broadcom SoC drivers
> #
> # end of Broadcom SoC drivers
>=20
> #
> # NXP/Freescale QorIQ SoC drivers
> #
> # end of NXP/Freescale QorIQ SoC drivers
>=20
> #
> # i.MX SoC drivers
> #
> # end of i.MX SoC drivers
>=20
> #
> # Enable LiteX SoC Builder specific drivers
> #
> # end of Enable LiteX SoC Builder specific drivers
>=20
> #
> # Qualcomm SoC drivers
> #
> # end of Qualcomm SoC drivers
>=20
> # CONFIG_SOC_TI is not set
>=20
> #
> # Xilinx SoC drivers
> #
> # end of Xilinx SoC drivers
> # end of SOC (System On Chip) specific Drivers
>=20
> # CONFIG_PM_DEVFREQ is not set
> # CONFIG_EXTCON is not set
> # CONFIG_MEMORY is not set
> # CONFIG_IIO is not set
> CONFIG_NTB=3Dm
> # CONFIG_NTB_MSI is not set
> # CONFIG_NTB_AMD is not set
> # CONFIG_NTB_IDT is not set
> # CONFIG_NTB_INTEL is not set
> # CONFIG_NTB_EPF is not set
> # CONFIG_NTB_SWITCHTEC is not set
> # CONFIG_NTB_PINGPONG is not set
> # CONFIG_NTB_TOOL is not set
> # CONFIG_NTB_PERF is not set
> # CONFIG_NTB_TRANSPORT is not set
> # CONFIG_VME_BUS is not set
> CONFIG_PWM=3Dy
> CONFIG_PWM_SYSFS=3Dy
> # CONFIG_PWM_DEBUG is not set
> # CONFIG_PWM_DWC is not set
> CONFIG_PWM_LPSS=3Dm
> CONFIG_PWM_LPSS_PCI=3Dm
> CONFIG_PWM_LPSS_PLATFORM=3Dm
> # CONFIG_PWM_PCA9685 is not set
>=20
> #
> # IRQ chip support
> #
> # end of IRQ chip support
>=20
> # CONFIG_IPACK_BUS is not set
> # CONFIG_RESET_CONTROLLER is not set
>=20
> #
> # PHY Subsystem
> #
> # CONFIG_GENERIC_PHY is not set
> # CONFIG_USB_LGM_PHY is not set
> # CONFIG_PHY_CAN_TRANSCEIVER is not set
>=20
> #
> # PHY drivers for Broadcom platforms
> #
> # CONFIG_BCM_KONA_USB2_PHY is not set
> # end of PHY drivers for Broadcom platforms
>=20
> # CONFIG_PHY_PXA_28NM_HSIC is not set
> # CONFIG_PHY_PXA_28NM_USB2 is not set
> # CONFIG_PHY_INTEL_LGM_EMMC is not set
> # end of PHY Subsystem
>=20
> CONFIG_POWERCAP=3Dy
> CONFIG_INTEL_RAPL_CORE=3Dm
> CONFIG_INTEL_RAPL=3Dm
> # CONFIG_IDLE_INJECT is not set
> # CONFIG_DTPM is not set
> # CONFIG_MCB is not set
>=20
> #
> # Performance monitor support
> #
> # end of Performance monitor support
>=20
> CONFIG_RAS=3Dy
> # CONFIG_RAS_CEC is not set
> # CONFIG_USB4 is not set
>=20
> #
> # Android
> #
> # CONFIG_ANDROID is not set
> # end of Android
>=20
> CONFIG_LIBNVDIMM=3Dm
> CONFIG_BLK_DEV_PMEM=3Dm
> CONFIG_ND_BLK=3Dm
> CONFIG_ND_CLAIM=3Dy
> CONFIG_ND_BTT=3Dm
> CONFIG_BTT=3Dy
> CONFIG_ND_PFN=3Dm
> CONFIG_NVDIMM_PFN=3Dy
> CONFIG_NVDIMM_DAX=3Dy
> CONFIG_NVDIMM_KEYS=3Dy
> CONFIG_DAX=3Dy
> CONFIG_DEV_DAX=3Dm
> CONFIG_DEV_DAX_PMEM=3Dm
> CONFIG_DEV_DAX_KMEM=3Dm
> CONFIG_NVMEM=3Dy
> CONFIG_NVMEM_SYSFS=3Dy
> # CONFIG_NVMEM_RMEM is not set
>=20
> #
> # HW tracing support
> #
> CONFIG_STM=3Dm
> # CONFIG_STM_PROTO_BASIC is not set
> # CONFIG_STM_PROTO_SYS_T is not set
> CONFIG_STM_DUMMY=3Dm
> CONFIG_STM_SOURCE_CONSOLE=3Dm
> CONFIG_STM_SOURCE_HEARTBEAT=3Dm
> CONFIG_STM_SOURCE_FTRACE=3Dm
> CONFIG_INTEL_TH=3Dm
> CONFIG_INTEL_TH_PCI=3Dm
> CONFIG_INTEL_TH_ACPI=3Dm
> CONFIG_INTEL_TH_GTH=3Dm
> CONFIG_INTEL_TH_STH=3Dm
> CONFIG_INTEL_TH_MSU=3Dm
> CONFIG_INTEL_TH_PTI=3Dm
> # CONFIG_INTEL_TH_DEBUG is not set
> # end of HW tracing support
>=20
> # CONFIG_FPGA is not set
> # CONFIG_TEE is not set
> # CONFIG_UNISYS_VISORBUS is not set
> # CONFIG_SIOX is not set
> # CONFIG_SLIMBUS is not set
> # CONFIG_INTERCONNECT is not set
> # CONFIG_COUNTER is not set
> # CONFIG_MOST is not set
> # end of Device Drivers
>=20
> #
> # File systems
> #
> CONFIG_DCACHE_WORD_ACCESS=3Dy
> # CONFIG_VALIDATE_FS_PARSER is not set
> CONFIG_FS_IOMAP=3Dy
> CONFIG_EXT2_FS=3Dm
> CONFIG_EXT2_FS_XATTR=3Dy
> CONFIG_EXT2_FS_POSIX_ACL=3Dy
> CONFIG_EXT2_FS_SECURITY=3Dy
> # CONFIG_EXT3_FS is not set
> CONFIG_EXT4_FS=3Dy
> CONFIG_EXT4_FS_POSIX_ACL=3Dy
> CONFIG_EXT4_FS_SECURITY=3Dy
> # CONFIG_EXT4_DEBUG is not set
> CONFIG_EXT4_KUNIT_TESTS=3Dm
> CONFIG_JBD2=3Dy
> # CONFIG_JBD2_DEBUG is not set
> CONFIG_FS_MBCACHE=3Dy
> # CONFIG_REISERFS_FS is not set
> # CONFIG_JFS_FS is not set
> CONFIG_XFS_FS=3Dm
> CONFIG_XFS_SUPPORT_V4=3Dy
> CONFIG_XFS_QUOTA=3Dy
> CONFIG_XFS_POSIX_ACL=3Dy
> CONFIG_XFS_RT=3Dy
> CONFIG_XFS_ONLINE_SCRUB=3Dy
> CONFIG_XFS_ONLINE_REPAIR=3Dy
> CONFIG_XFS_DEBUG=3Dy
> CONFIG_XFS_ASSERT_FATAL=3Dy
> CONFIG_GFS2_FS=3Dm
> CONFIG_GFS2_FS_LOCKING_DLM=3Dy
> CONFIG_OCFS2_FS=3Dm
> CONFIG_OCFS2_FS_O2CB=3Dm
> CONFIG_OCFS2_FS_USERSPACE_CLUSTER=3Dm
> CONFIG_OCFS2_FS_STATS=3Dy
> CONFIG_OCFS2_DEBUG_MASKLOG=3Dy
> # CONFIG_OCFS2_DEBUG_FS is not set
> CONFIG_BTRFS_FS=3Dm
> CONFIG_BTRFS_FS_POSIX_ACL=3Dy
> # CONFIG_BTRFS_FS_CHECK_INTEGRITY is not set
> # CONFIG_BTRFS_FS_RUN_SANITY_TESTS is not set
> # CONFIG_BTRFS_DEBUG is not set
> # CONFIG_BTRFS_ASSERT is not set
> # CONFIG_BTRFS_FS_REF_VERIFY is not set
> # CONFIG_NILFS2_FS is not set
> CONFIG_F2FS_FS=3Dm
> CONFIG_F2FS_STAT_FS=3Dy
> CONFIG_F2FS_FS_XATTR=3Dy
> CONFIG_F2FS_FS_POSIX_ACL=3Dy
> CONFIG_F2FS_FS_SECURITY=3Dy
> # CONFIG_F2FS_CHECK_FS is not set
> # CONFIG_F2FS_FAULT_INJECTION is not set
> # CONFIG_F2FS_FS_COMPRESSION is not set
> CONFIG_F2FS_IOSTAT=3Dy
> # CONFIG_ZONEFS_FS is not set
> CONFIG_FS_DAX=3Dy
> CONFIG_FS_DAX_PMD=3Dy
> CONFIG_FS_POSIX_ACL=3Dy
> CONFIG_EXPORTFS=3Dy
> CONFIG_EXPORTFS_BLOCK_OPS=3Dy
> CONFIG_FILE_LOCKING=3Dy
> CONFIG_FS_ENCRYPTION=3Dy
> CONFIG_FS_ENCRYPTION_ALGS=3Dy
> # CONFIG_FS_VERITY is not set
> CONFIG_FSNOTIFY=3Dy
> CONFIG_DNOTIFY=3Dy
> CONFIG_INOTIFY_USER=3Dy
> CONFIG_FANOTIFY=3Dy
> CONFIG_FANOTIFY_ACCESS_PERMISSIONS=3Dy
> CONFIG_QUOTA=3Dy
> CONFIG_QUOTA_NETLINK_INTERFACE=3Dy
> CONFIG_PRINT_QUOTA_WARNING=3Dy
> # CONFIG_QUOTA_DEBUG is not set
> CONFIG_QUOTA_TREE=3Dy
> # CONFIG_QFMT_V1 is not set
> CONFIG_QFMT_V2=3Dy
> CONFIG_QUOTACTL=3Dy
> CONFIG_AUTOFS4_FS=3Dy
> CONFIG_AUTOFS_FS=3Dy
> CONFIG_FUSE_FS=3Dm
> CONFIG_CUSE=3Dm
> # CONFIG_VIRTIO_FS is not set
> CONFIG_OVERLAY_FS=3Dm
> # CONFIG_OVERLAY_FS_REDIRECT_DIR is not set
> # CONFIG_OVERLAY_FS_REDIRECT_ALWAYS_FOLLOW is not set
> # CONFIG_OVERLAY_FS_INDEX is not set
> # CONFIG_OVERLAY_FS_XINO_AUTO is not set
> # CONFIG_OVERLAY_FS_METACOPY is not set
>=20
> #
> # Caches
> #
> CONFIG_NETFS_SUPPORT=3Dy
> CONFIG_NETFS_STATS=3Dy
> CONFIG_FSCACHE=3Dm
> CONFIG_FSCACHE_STATS=3Dy
> # CONFIG_FSCACHE_DEBUG is not set
> CONFIG_CACHEFILES=3Dm
> # CONFIG_CACHEFILES_DEBUG is not set
> # CONFIG_CACHEFILES_ERROR_INJECTION is not set
> # end of Caches
>=20
> #
> # CD-ROM/DVD Filesystems
> #
> CONFIG_ISO9660_FS=3Dm
> CONFIG_JOLIET=3Dy
> CONFIG_ZISOFS=3Dy
> CONFIG_UDF_FS=3Dm
> # end of CD-ROM/DVD Filesystems
>=20
> #
> # DOS/FAT/EXFAT/NT Filesystems
> #
> CONFIG_FAT_FS=3Dm
> CONFIG_MSDOS_FS=3Dm
> CONFIG_VFAT_FS=3Dm
> CONFIG_FAT_DEFAULT_CODEPAGE=3D437
> CONFIG_FAT_DEFAULT_IOCHARSET=3D"ascii"
> # CONFIG_FAT_DEFAULT_UTF8 is not set
> CONFIG_FAT_KUNIT_TEST=3Dm
> # CONFIG_EXFAT_FS is not set
> # CONFIG_NTFS_FS is not set
> # CONFIG_NTFS3_FS is not set
> # end of DOS/FAT/EXFAT/NT Filesystems
>=20
> #
> # Pseudo filesystems
> #
> CONFIG_PROC_FS=3Dy
> CONFIG_PROC_KCORE=3Dy
> CONFIG_PROC_VMCORE=3Dy
> CONFIG_PROC_VMCORE_DEVICE_DUMP=3Dy
> CONFIG_PROC_SYSCTL=3Dy
> CONFIG_PROC_PAGE_MONITOR=3Dy
> CONFIG_PROC_CHILDREN=3Dy
> CONFIG_PROC_PID_ARCH_STATUS=3Dy
> CONFIG_KERNFS=3Dy
> CONFIG_SYSFS=3Dy
> CONFIG_TMPFS=3Dy
> CONFIG_TMPFS_POSIX_ACL=3Dy
> CONFIG_TMPFS_XATTR=3Dy
> # CONFIG_TMPFS_INODE64 is not set
> CONFIG_HUGETLBFS=3Dy
> CONFIG_HUGETLB_PAGE=3Dy
> CONFIG_HUGETLB_PAGE_FREE_VMEMMAP=3Dy
> # CONFIG_HUGETLB_PAGE_FREE_VMEMMAP_DEFAULT_ON is not set
> CONFIG_MEMFD_CREATE=3Dy
> CONFIG_ARCH_HAS_GIGANTIC_PAGE=3Dy
> CONFIG_CONFIGFS_FS=3Dy
> CONFIG_EFIVAR_FS=3Dy
> # end of Pseudo filesystems
>=20
> CONFIG_MISC_FILESYSTEMS=3Dy
> # CONFIG_ORANGEFS_FS is not set
> # CONFIG_ADFS_FS is not set
> # CONFIG_AFFS_FS is not set
> # CONFIG_ECRYPT_FS is not set
> # CONFIG_HFS_FS is not set
> # CONFIG_HFSPLUS_FS is not set
> # CONFIG_BEFS_FS is not set
> # CONFIG_BFS_FS is not set
> # CONFIG_EFS_FS is not set
> CONFIG_CRAMFS=3Dm
> CONFIG_CRAMFS_BLOCKDEV=3Dy
> CONFIG_SQUASHFS=3Dm
> # CONFIG_SQUASHFS_FILE_CACHE is not set
> CONFIG_SQUASHFS_FILE_DIRECT=3Dy
> # CONFIG_SQUASHFS_DECOMP_SINGLE is not set
> # CONFIG_SQUASHFS_DECOMP_MULTI is not set
> CONFIG_SQUASHFS_DECOMP_MULTI_PERCPU=3Dy
> CONFIG_SQUASHFS_XATTR=3Dy
> CONFIG_SQUASHFS_ZLIB=3Dy
> # CONFIG_SQUASHFS_LZ4 is not set
> CONFIG_SQUASHFS_LZO=3Dy
> CONFIG_SQUASHFS_XZ=3Dy
> # CONFIG_SQUASHFS_ZSTD is not set
> # CONFIG_SQUASHFS_4K_DEVBLK_SIZE is not set
> # CONFIG_SQUASHFS_EMBEDDED is not set
> CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3D3
> # CONFIG_VXFS_FS is not set
> CONFIG_MINIX_FS=3Dm
> # CONFIG_OMFS_FS is not set
> # CONFIG_HPFS_FS is not set
> # CONFIG_QNX4FS_FS is not set
> # CONFIG_QNX6FS_FS is not set
> # CONFIG_ROMFS_FS is not set
> CONFIG_PSTORE=3Dy
> CONFIG_PSTORE_DEFAULT_KMSG_BYTES=3D10240
> CONFIG_PSTORE_DEFLATE_COMPRESS=3Dy
> # CONFIG_PSTORE_LZO_COMPRESS is not set
> # CONFIG_PSTORE_LZ4_COMPRESS is not set
> # CONFIG_PSTORE_LZ4HC_COMPRESS is not set
> # CONFIG_PSTORE_842_COMPRESS is not set
> # CONFIG_PSTORE_ZSTD_COMPRESS is not set
> CONFIG_PSTORE_COMPRESS=3Dy
> CONFIG_PSTORE_DEFLATE_COMPRESS_DEFAULT=3Dy
> CONFIG_PSTORE_COMPRESS_DEFAULT=3D"deflate"
> # CONFIG_PSTORE_CONSOLE is not set
> # CONFIG_PSTORE_PMSG is not set
> # CONFIG_PSTORE_FTRACE is not set
> CONFIG_PSTORE_RAM=3Dm
> # CONFIG_PSTORE_BLK is not set
> # CONFIG_SYSV_FS is not set
> # CONFIG_UFS_FS is not set
> # CONFIG_EROFS_FS is not set
> CONFIG_NETWORK_FILESYSTEMS=3Dy
> CONFIG_NFS_FS=3Dy
> # CONFIG_NFS_V2 is not set
> CONFIG_NFS_V3=3Dy
> CONFIG_NFS_V3_ACL=3Dy
> CONFIG_NFS_V4=3Dm
> # CONFIG_NFS_SWAP is not set
> CONFIG_NFS_V4_1=3Dy
> CONFIG_NFS_V4_2=3Dy
> CONFIG_PNFS_FILE_LAYOUT=3Dm
> CONFIG_PNFS_BLOCK=3Dm
> CONFIG_PNFS_FLEXFILE_LAYOUT=3Dm
> CONFIG_NFS_V4_1_IMPLEMENTATION_ID_DOMAIN=3D"kernel.org"
> # CONFIG_NFS_V4_1_MIGRATION is not set
> CONFIG_NFS_V4_SECURITY_LABEL=3Dy
> CONFIG_ROOT_NFS=3Dy
> # CONFIG_NFS_USE_LEGACY_DNS is not set
> CONFIG_NFS_USE_KERNEL_DNS=3Dy
> CONFIG_NFS_DEBUG=3Dy
> CONFIG_NFS_DISABLE_UDP_SUPPORT=3Dy
> # CONFIG_NFS_V4_2_READ_PLUS is not set
> CONFIG_NFSD=3Dm
> CONFIG_NFSD_V2_ACL=3Dy
> CONFIG_NFSD_V3=3Dy
> CONFIG_NFSD_V3_ACL=3Dy
> CONFIG_NFSD_V4=3Dy
> CONFIG_NFSD_PNFS=3Dy
> # CONFIG_NFSD_BLOCKLAYOUT is not set
> CONFIG_NFSD_SCSILAYOUT=3Dy
> # CONFIG_NFSD_FLEXFILELAYOUT is not set
> # CONFIG_NFSD_V4_2_INTER_SSC is not set
> CONFIG_NFSD_V4_SECURITY_LABEL=3Dy
> CONFIG_GRACE_PERIOD=3Dy
> CONFIG_LOCKD=3Dy
> CONFIG_LOCKD_V4=3Dy
> CONFIG_NFS_ACL_SUPPORT=3Dy
> CONFIG_NFS_COMMON=3Dy
> CONFIG_NFS_V4_2_SSC_HELPER=3Dy
> CONFIG_SUNRPC=3Dy
> CONFIG_SUNRPC_GSS=3Dm
> CONFIG_SUNRPC_BACKCHANNEL=3Dy
> CONFIG_RPCSEC_GSS_KRB5=3Dm
> # CONFIG_SUNRPC_DISABLE_INSECURE_ENCTYPES is not set
> CONFIG_SUNRPC_DEBUG=3Dy
> CONFIG_SUNRPC_XPRT_RDMA=3Dm
> CONFIG_CEPH_FS=3Dm
> # CONFIG_CEPH_FSCACHE is not set
> CONFIG_CEPH_FS_POSIX_ACL=3Dy
> # CONFIG_CEPH_FS_SECURITY_LABEL is not set
> CONFIG_CIFS=3Dm
> CONFIG_CIFS_STATS2=3Dy
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY=3Dy
> CONFIG_CIFS_UPCALL=3Dy
> CONFIG_CIFS_XATTR=3Dy
> CONFIG_CIFS_POSIX=3Dy
> CONFIG_CIFS_DEBUG=3Dy
> # CONFIG_CIFS_DEBUG2 is not set
> # CONFIG_CIFS_DEBUG_DUMP_KEYS is not set
> CONFIG_CIFS_DFS_UPCALL=3Dy
> # CONFIG_CIFS_SWN_UPCALL is not set
> # CONFIG_CIFS_SMB_DIRECT is not set
> # CONFIG_CIFS_FSCACHE is not set
> # CONFIG_SMB_SERVER is not set
> CONFIG_SMBFS_COMMON=3Dm
> # CONFIG_CODA_FS is not set
> # CONFIG_AFS_FS is not set
> CONFIG_9P_FS=3Dy
> CONFIG_9P_FS_POSIX_ACL=3Dy
> # CONFIG_9P_FS_SECURITY is not set
> CONFIG_NLS=3Dy
> CONFIG_NLS_DEFAULT=3D"utf8"
> CONFIG_NLS_CODEPAGE_437=3Dy
> CONFIG_NLS_CODEPAGE_737=3Dm
> CONFIG_NLS_CODEPAGE_775=3Dm
> CONFIG_NLS_CODEPAGE_850=3Dm
> CONFIG_NLS_CODEPAGE_852=3Dm
> CONFIG_NLS_CODEPAGE_855=3Dm
> CONFIG_NLS_CODEPAGE_857=3Dm
> CONFIG_NLS_CODEPAGE_860=3Dm
> CONFIG_NLS_CODEPAGE_861=3Dm
> CONFIG_NLS_CODEPAGE_862=3Dm
> CONFIG_NLS_CODEPAGE_863=3Dm
> CONFIG_NLS_CODEPAGE_864=3Dm
> CONFIG_NLS_CODEPAGE_865=3Dm
> CONFIG_NLS_CODEPAGE_866=3Dm
> CONFIG_NLS_CODEPAGE_869=3Dm
> CONFIG_NLS_CODEPAGE_936=3Dm
> CONFIG_NLS_CODEPAGE_950=3Dm
> CONFIG_NLS_CODEPAGE_932=3Dm
> CONFIG_NLS_CODEPAGE_949=3Dm
> CONFIG_NLS_CODEPAGE_874=3Dm
> CONFIG_NLS_ISO8859_8=3Dm
> CONFIG_NLS_CODEPAGE_1250=3Dm
> CONFIG_NLS_CODEPAGE_1251=3Dm
> CONFIG_NLS_ASCII=3Dy
> CONFIG_NLS_ISO8859_1=3Dm
> CONFIG_NLS_ISO8859_2=3Dm
> CONFIG_NLS_ISO8859_3=3Dm
> CONFIG_NLS_ISO8859_4=3Dm
> CONFIG_NLS_ISO8859_5=3Dm
> CONFIG_NLS_ISO8859_6=3Dm
> CONFIG_NLS_ISO8859_7=3Dm
> CONFIG_NLS_ISO8859_9=3Dm
> CONFIG_NLS_ISO8859_13=3Dm
> CONFIG_NLS_ISO8859_14=3Dm
> CONFIG_NLS_ISO8859_15=3Dm
> CONFIG_NLS_KOI8_R=3Dm
> CONFIG_NLS_KOI8_U=3Dm
> CONFIG_NLS_MAC_ROMAN=3Dm
> CONFIG_NLS_MAC_CELTIC=3Dm
> CONFIG_NLS_MAC_CENTEURO=3Dm
> CONFIG_NLS_MAC_CROATIAN=3Dm
> CONFIG_NLS_MAC_CYRILLIC=3Dm
> CONFIG_NLS_MAC_GAELIC=3Dm
> CONFIG_NLS_MAC_GREEK=3Dm
> CONFIG_NLS_MAC_ICELAND=3Dm
> CONFIG_NLS_MAC_INUIT=3Dm
> CONFIG_NLS_MAC_ROMANIAN=3Dm
> CONFIG_NLS_MAC_TURKISH=3Dm
> CONFIG_NLS_UTF8=3Dm
> CONFIG_DLM=3Dm
> CONFIG_DLM_DEBUG=3Dy
> # CONFIG_UNICODE is not set
> CONFIG_IO_WQ=3Dy
> # end of File systems
>=20
> #
> # Security options
> #
> CONFIG_KEYS=3Dy
> # CONFIG_KEYS_REQUEST_CACHE is not set
> CONFIG_PERSISTENT_KEYRINGS=3Dy
> CONFIG_TRUSTED_KEYS=3Dy
> CONFIG_ENCRYPTED_KEYS=3Dy
> # CONFIG_KEY_DH_OPERATIONS is not set
> # CONFIG_SECURITY_DMESG_RESTRICT is not set
> CONFIG_SECURITY=3Dy
> CONFIG_SECURITY_WRITABLE_HOOKS=3Dy
> CONFIG_SECURITYFS=3Dy
> CONFIG_SECURITY_NETWORK=3Dy
> CONFIG_PAGE_TABLE_ISOLATION=3Dy
> # CONFIG_SECURITY_INFINIBAND is not set
> CONFIG_SECURITY_NETWORK_XFRM=3Dy
> # CONFIG_SECURITY_PATH is not set
> CONFIG_INTEL_TXT=3Dy
> CONFIG_LSM_MMAP_MIN_ADDR=3D65535
> CONFIG_HAVE_HARDENED_USERCOPY_ALLOCATOR=3Dy
> CONFIG_HARDENED_USERCOPY=3Dy
> CONFIG_FORTIFY_SOURCE=3Dy
> # CONFIG_STATIC_USERMODEHELPER is not set
> CONFIG_SECURITY_SELINUX=3Dy
> CONFIG_SECURITY_SELINUX_BOOTPARAM=3Dy
> CONFIG_SECURITY_SELINUX_DISABLE=3Dy
> CONFIG_SECURITY_SELINUX_DEVELOP=3Dy
> CONFIG_SECURITY_SELINUX_AVC_STATS=3Dy
> CONFIG_SECURITY_SELINUX_CHECKREQPROT_VALUE=3D1
> CONFIG_SECURITY_SELINUX_SIDTAB_HASH_BITS=3D9
> CONFIG_SECURITY_SELINUX_SID2STR_CACHE_SIZE=3D256
> # CONFIG_SECURITY_SMACK is not set
> # CONFIG_SECURITY_TOMOYO is not set
> # CONFIG_SECURITY_APPARMOR is not set
> # CONFIG_SECURITY_LOADPIN is not set
> CONFIG_SECURITY_YAMA=3Dy
> # CONFIG_SECURITY_SAFESETID is not set
> # CONFIG_SECURITY_LOCKDOWN_LSM is not set
> # CONFIG_SECURITY_LANDLOCK is not set
> CONFIG_INTEGRITY=3Dy
> CONFIG_INTEGRITY_SIGNATURE=3Dy
> CONFIG_INTEGRITY_ASYMMETRIC_KEYS=3Dy
> CONFIG_INTEGRITY_TRUSTED_KEYRING=3Dy
> # CONFIG_INTEGRITY_PLATFORM_KEYRING is not set
> CONFIG_INTEGRITY_AUDIT=3Dy
> CONFIG_IMA=3Dy
> CONFIG_IMA_MEASURE_PCR_IDX=3D10
> CONFIG_IMA_LSM_RULES=3Dy
> # CONFIG_IMA_TEMPLATE is not set
> CONFIG_IMA_NG_TEMPLATE=3Dy
> # CONFIG_IMA_SIG_TEMPLATE is not set
> CONFIG_IMA_DEFAULT_TEMPLATE=3D"ima-ng"
> CONFIG_IMA_DEFAULT_HASH_SHA1=3Dy
> # CONFIG_IMA_DEFAULT_HASH_SHA256 is not set
> # CONFIG_IMA_DEFAULT_HASH_SHA512 is not set
> CONFIG_IMA_DEFAULT_HASH=3D"sha1"
> CONFIG_IMA_WRITE_POLICY=3Dy
> # CONFIG_IMA_READ_POLICY is not set
> CONFIG_IMA_APPRAISE=3Dy
> # CONFIG_IMA_ARCH_POLICY is not set
> # CONFIG_IMA_APPRAISE_BUILD_POLICY is not set
> CONFIG_IMA_APPRAISE_BOOTPARAM=3Dy
> # CONFIG_IMA_APPRAISE_MODSIG is not set
> CONFIG_IMA_TRUSTED_KEYRING=3Dy
> # CONFIG_IMA_BLACKLIST_KEYRING is not set
> # CONFIG_IMA_LOAD_X509 is not set
> CONFIG_IMA_MEASURE_ASYMMETRIC_KEYS=3Dy
> CONFIG_IMA_QUEUE_EARLY_BOOT_KEYS=3Dy
> # CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT is not set
> # CONFIG_IMA_DISABLE_HTABLE is not set
> CONFIG_EVM=3Dy
> CONFIG_EVM_ATTR_FSUUID=3Dy
> # CONFIG_EVM_ADD_XATTRS is not set
> # CONFIG_EVM_LOAD_X509 is not set
> CONFIG_DEFAULT_SECURITY_SELINUX=3Dy
> # CONFIG_DEFAULT_SECURITY_DAC is not set
> CONFIG_LSM=3D"landlock,lockdown,yama,loadpin,safesetid,integrity,selinux,=
smack,tomoyo,apparmor,bpf"
>=20
> #
> # Kernel hardening options
> #
>=20
> #
> # Memory initialization
> #
> CONFIG_INIT_STACK_NONE=3Dy
> # CONFIG_INIT_ON_ALLOC_DEFAULT_ON is not set
> # CONFIG_INIT_ON_FREE_DEFAULT_ON is not set
> # end of Memory initialization
> # end of Kernel hardening options
> # end of Security options
>=20
> CONFIG_XOR_BLOCKS=3Dm
> CONFIG_ASYNC_CORE=3Dm
> CONFIG_ASYNC_MEMCPY=3Dm
> CONFIG_ASYNC_XOR=3Dm
> CONFIG_ASYNC_PQ=3Dm
> CONFIG_ASYNC_RAID6_RECOV=3Dm
> CONFIG_CRYPTO=3Dy
>=20
> #
> # Crypto core or helper
> #
> CONFIG_CRYPTO_ALGAPI=3Dy
> CONFIG_CRYPTO_ALGAPI2=3Dy
> CONFIG_CRYPTO_AEAD=3Dy
> CONFIG_CRYPTO_AEAD2=3Dy
> CONFIG_CRYPTO_SKCIPHER=3Dy
> CONFIG_CRYPTO_SKCIPHER2=3Dy
> CONFIG_CRYPTO_HASH=3Dy
> CONFIG_CRYPTO_HASH2=3Dy
> CONFIG_CRYPTO_RNG=3Dy
> CONFIG_CRYPTO_RNG2=3Dy
> CONFIG_CRYPTO_RNG_DEFAULT=3Dy
> CONFIG_CRYPTO_AKCIPHER2=3Dy
> CONFIG_CRYPTO_AKCIPHER=3Dy
> CONFIG_CRYPTO_KPP2=3Dy
> CONFIG_CRYPTO_KPP=3Dm
> CONFIG_CRYPTO_ACOMP2=3Dy
> CONFIG_CRYPTO_MANAGER=3Dy
> CONFIG_CRYPTO_MANAGER2=3Dy
> CONFIG_CRYPTO_USER=3Dm
> CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=3Dy
> CONFIG_CRYPTO_GF128MUL=3Dy
> CONFIG_CRYPTO_NULL=3Dy
> CONFIG_CRYPTO_NULL2=3Dy
> CONFIG_CRYPTO_PCRYPT=3Dm
> CONFIG_CRYPTO_CRYPTD=3Dy
> CONFIG_CRYPTO_AUTHENC=3Dm
> CONFIG_CRYPTO_TEST=3Dm
> CONFIG_CRYPTO_SIMD=3Dy
>=20
> #
> # Public-key cryptography
> #
> CONFIG_CRYPTO_RSA=3Dy
> CONFIG_CRYPTO_DH=3Dm
> CONFIG_CRYPTO_ECC=3Dm
> CONFIG_CRYPTO_ECDH=3Dm
> # CONFIG_CRYPTO_ECDSA is not set
> # CONFIG_CRYPTO_ECRDSA is not set
> # CONFIG_CRYPTO_SM2 is not set
> # CONFIG_CRYPTO_CURVE25519 is not set
> # CONFIG_CRYPTO_CURVE25519_X86 is not set
>=20
> #
> # Authenticated Encryption with Associated Data
> #
> CONFIG_CRYPTO_CCM=3Dm
> CONFIG_CRYPTO_GCM=3Dy
> CONFIG_CRYPTO_CHACHA20POLY1305=3Dm
> # CONFIG_CRYPTO_AEGIS128 is not set
> # CONFIG_CRYPTO_AEGIS128_AESNI_SSE2 is not set
> CONFIG_CRYPTO_SEQIV=3Dy
> CONFIG_CRYPTO_ECHAINIV=3Dm
>=20
> #
> # Block modes
> #
> CONFIG_CRYPTO_CBC=3Dy
> CONFIG_CRYPTO_CFB=3Dy
> CONFIG_CRYPTO_CTR=3Dy
> CONFIG_CRYPTO_CTS=3Dm
> CONFIG_CRYPTO_ECB=3Dy
> CONFIG_CRYPTO_LRW=3Dm
> # CONFIG_CRYPTO_OFB is not set
> CONFIG_CRYPTO_PCBC=3Dm
> CONFIG_CRYPTO_XTS=3Dm
> # CONFIG_CRYPTO_KEYWRAP is not set
> # CONFIG_CRYPTO_NHPOLY1305_SSE2 is not set
> # CONFIG_CRYPTO_NHPOLY1305_AVX2 is not set
> # CONFIG_CRYPTO_ADIANTUM is not set
> CONFIG_CRYPTO_ESSIV=3Dm
>=20
> #
> # Hash modes
> #
> CONFIG_CRYPTO_CMAC=3Dm
> CONFIG_CRYPTO_HMAC=3Dy
> CONFIG_CRYPTO_XCBC=3Dm
> CONFIG_CRYPTO_VMAC=3Dm
>=20
> #
> # Digest
> #
> CONFIG_CRYPTO_CRC32C=3Dy
> CONFIG_CRYPTO_CRC32C_INTEL=3Dm
> CONFIG_CRYPTO_CRC32=3Dm
> CONFIG_CRYPTO_CRC32_PCLMUL=3Dm
> CONFIG_CRYPTO_XXHASH=3Dm
> CONFIG_CRYPTO_BLAKE2B=3Dm
> # CONFIG_CRYPTO_BLAKE2S is not set
> # CONFIG_CRYPTO_BLAKE2S_X86 is not set
> CONFIG_CRYPTO_CRCT10DIF=3Dy
> CONFIG_CRYPTO_CRCT10DIF_PCLMUL=3Dm
> CONFIG_CRYPTO_GHASH=3Dy
> CONFIG_CRYPTO_POLY1305=3Dm
> CONFIG_CRYPTO_POLY1305_X86_64=3Dm
> CONFIG_CRYPTO_MD4=3Dm
> CONFIG_CRYPTO_MD5=3Dy
> CONFIG_CRYPTO_MICHAEL_MIC=3Dm
> CONFIG_CRYPTO_RMD160=3Dm
> CONFIG_CRYPTO_SHA1=3Dy
> CONFIG_CRYPTO_SHA1_SSSE3=3Dy
> CONFIG_CRYPTO_SHA256_SSSE3=3Dy
> CONFIG_CRYPTO_SHA512_SSSE3=3Dm
> CONFIG_CRYPTO_SHA256=3Dy
> CONFIG_CRYPTO_SHA512=3Dy
> CONFIG_CRYPTO_SHA3=3Dm
> # CONFIG_CRYPTO_SM3 is not set
> # CONFIG_CRYPTO_STREEBOG is not set
> CONFIG_CRYPTO_WP512=3Dm
> CONFIG_CRYPTO_GHASH_CLMUL_NI_INTEL=3Dm
>=20
> #
> # Ciphers
> #
> CONFIG_CRYPTO_AES=3Dy
> # CONFIG_CRYPTO_AES_TI is not set
> CONFIG_CRYPTO_AES_NI_INTEL=3Dy
> CONFIG_CRYPTO_ANUBIS=3Dm
> CONFIG_CRYPTO_ARC4=3Dm
> CONFIG_CRYPTO_BLOWFISH=3Dm
> CONFIG_CRYPTO_BLOWFISH_COMMON=3Dm
> CONFIG_CRYPTO_BLOWFISH_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA=3Dm
> CONFIG_CRYPTO_CAMELLIA_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAMELLIA_AESNI_AVX2_X86_64=3Dm
> CONFIG_CRYPTO_CAST_COMMON=3Dm
> CONFIG_CRYPTO_CAST5=3Dm
> CONFIG_CRYPTO_CAST5_AVX_X86_64=3Dm
> CONFIG_CRYPTO_CAST6=3Dm
> CONFIG_CRYPTO_CAST6_AVX_X86_64=3Dm
> CONFIG_CRYPTO_DES=3Dm
> # CONFIG_CRYPTO_DES3_EDE_X86_64 is not set
> CONFIG_CRYPTO_FCRYPT=3Dm
> CONFIG_CRYPTO_KHAZAD=3Dm
> CONFIG_CRYPTO_CHACHA20=3Dm
> CONFIG_CRYPTO_CHACHA20_X86_64=3Dm
> CONFIG_CRYPTO_SEED=3Dm
> CONFIG_CRYPTO_SERPENT=3Dm
> CONFIG_CRYPTO_SERPENT_SSE2_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX_X86_64=3Dm
> CONFIG_CRYPTO_SERPENT_AVX2_X86_64=3Dm
> # CONFIG_CRYPTO_SM4 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX_X86_64 is not set
> # CONFIG_CRYPTO_SM4_AESNI_AVX2_X86_64 is not set
> CONFIG_CRYPTO_TEA=3Dm
> CONFIG_CRYPTO_TWOFISH=3Dm
> CONFIG_CRYPTO_TWOFISH_COMMON=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64=3Dm
> CONFIG_CRYPTO_TWOFISH_X86_64_3WAY=3Dm
> CONFIG_CRYPTO_TWOFISH_AVX_X86_64=3Dm
>=20
> #
> # Compression
> #
> CONFIG_CRYPTO_DEFLATE=3Dy
> CONFIG_CRYPTO_LZO=3Dy
> # CONFIG_CRYPTO_842 is not set
> # CONFIG_CRYPTO_LZ4 is not set
> # CONFIG_CRYPTO_LZ4HC is not set
> # CONFIG_CRYPTO_ZSTD is not set
>=20
> #
> # Random Number Generation
> #
> CONFIG_CRYPTO_ANSI_CPRNG=3Dm
> CONFIG_CRYPTO_DRBG_MENU=3Dy
> CONFIG_CRYPTO_DRBG_HMAC=3Dy
> CONFIG_CRYPTO_DRBG_HASH=3Dy
> CONFIG_CRYPTO_DRBG_CTR=3Dy
> CONFIG_CRYPTO_DRBG=3Dy
> CONFIG_CRYPTO_JITTERENTROPY=3Dy
> CONFIG_CRYPTO_USER_API=3Dy
> CONFIG_CRYPTO_USER_API_HASH=3Dy
> CONFIG_CRYPTO_USER_API_SKCIPHER=3Dy
> CONFIG_CRYPTO_USER_API_RNG=3Dy
> # CONFIG_CRYPTO_USER_API_RNG_CAVP is not set
> CONFIG_CRYPTO_USER_API_AEAD=3Dy
> CONFIG_CRYPTO_USER_API_ENABLE_OBSOLETE=3Dy
> # CONFIG_CRYPTO_STATS is not set
> CONFIG_CRYPTO_HASH_INFO=3Dy
> CONFIG_CRYPTO_HW=3Dy
> CONFIG_CRYPTO_DEV_PADLOCK=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_AES=3Dm
> CONFIG_CRYPTO_DEV_PADLOCK_SHA=3Dm
> # CONFIG_CRYPTO_DEV_ATMEL_ECC is not set
> # CONFIG_CRYPTO_DEV_ATMEL_SHA204A is not set
> CONFIG_CRYPTO_DEV_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_DD=3Dm
> CONFIG_CRYPTO_DEV_SP_CCP=3Dy
> CONFIG_CRYPTO_DEV_CCP_CRYPTO=3Dm
> CONFIG_CRYPTO_DEV_SP_PSP=3Dy
> # CONFIG_CRYPTO_DEV_CCP_DEBUGFS is not set
> CONFIG_CRYPTO_DEV_QAT=3Dm
> CONFIG_CRYPTO_DEV_QAT_DH895xCC=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXX=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62X=3Dm
> # CONFIG_CRYPTO_DEV_QAT_4XXX is not set
> CONFIG_CRYPTO_DEV_QAT_DH895xCCVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C3XXXVF=3Dm
> CONFIG_CRYPTO_DEV_QAT_C62XVF=3Dm
> CONFIG_CRYPTO_DEV_NITROX=3Dm
> CONFIG_CRYPTO_DEV_NITROX_CNN55XX=3Dm
> # CONFIG_CRYPTO_DEV_VIRTIO is not set
> # CONFIG_CRYPTO_DEV_SAFEXCEL is not set
> # CONFIG_CRYPTO_DEV_AMLOGIC_GXL is not set
> CONFIG_ASYMMETRIC_KEY_TYPE=3Dy
> CONFIG_ASYMMETRIC_PUBLIC_KEY_SUBTYPE=3Dy
> # CONFIG_ASYMMETRIC_TPM_KEY_SUBTYPE is not set
> CONFIG_X509_CERTIFICATE_PARSER=3Dy
> # CONFIG_PKCS8_PRIVATE_KEY_PARSER is not set
> CONFIG_PKCS7_MESSAGE_PARSER=3Dy
> # CONFIG_PKCS7_TEST_KEY is not set
> CONFIG_SIGNED_PE_FILE_VERIFICATION=3Dy
>=20
> #
> # Certificates for signature checking
> #
> CONFIG_MODULE_SIG_KEY=3D"certs/signing_key.pem"
> CONFIG_MODULE_SIG_KEY_TYPE_RSA=3Dy
> # CONFIG_MODULE_SIG_KEY_TYPE_ECDSA is not set
> CONFIG_SYSTEM_TRUSTED_KEYRING=3Dy
> CONFIG_SYSTEM_TRUSTED_KEYS=3D""
> # CONFIG_SYSTEM_EXTRA_CERTIFICATE is not set
> # CONFIG_SECONDARY_TRUSTED_KEYRING is not set
> CONFIG_SYSTEM_BLACKLIST_KEYRING=3Dy
> CONFIG_SYSTEM_BLACKLIST_HASH_LIST=3D""
> # CONFIG_SYSTEM_REVOCATION_LIST is not set
> # end of Certificates for signature checking
>=20
> CONFIG_BINARY_PRINTF=3Dy
>=20
> #
> # Library routines
> #
> CONFIG_RAID6_PQ=3Dm
> CONFIG_RAID6_PQ_BENCHMARK=3Dy
> CONFIG_LINEAR_RANGES=3Dm
> # CONFIG_PACKING is not set
> CONFIG_BITREVERSE=3Dy
> CONFIG_GENERIC_STRNCPY_FROM_USER=3Dy
> CONFIG_GENERIC_STRNLEN_USER=3Dy
> CONFIG_GENERIC_NET_UTILS=3Dy
> CONFIG_CORDIC=3Dm
> # CONFIG_PRIME_NUMBERS is not set
> CONFIG_RATIONAL=3Dy
> CONFIG_GENERIC_PCI_IOMAP=3Dy
> CONFIG_GENERIC_IOMAP=3Dy
> CONFIG_ARCH_USE_CMPXCHG_LOCKREF=3Dy
> CONFIG_ARCH_HAS_FAST_MULTIPLIER=3Dy
> CONFIG_ARCH_USE_SYM_ANNOTATIONS=3Dy
>=20
> #
> # Crypto library routines
> #
> CONFIG_CRYPTO_LIB_AES=3Dy
> CONFIG_CRYPTO_LIB_ARC4=3Dm
> CONFIG_CRYPTO_LIB_BLAKE2S_GENERIC=3Dy
> CONFIG_CRYPTO_ARCH_HAVE_LIB_CHACHA=3Dm
> CONFIG_CRYPTO_LIB_CHACHA_GENERIC=3Dm
> # CONFIG_CRYPTO_LIB_CHACHA is not set
> # CONFIG_CRYPTO_LIB_CURVE25519 is not set
> CONFIG_CRYPTO_LIB_DES=3Dm
> CONFIG_CRYPTO_LIB_POLY1305_RSIZE=3D11
> CONFIG_CRYPTO_ARCH_HAVE_LIB_POLY1305=3Dm
> CONFIG_CRYPTO_LIB_POLY1305_GENERIC=3Dm
> # CONFIG_CRYPTO_LIB_POLY1305 is not set
> # CONFIG_CRYPTO_LIB_CHACHA20POLY1305 is not set
> CONFIG_CRYPTO_LIB_SHA256=3Dy
> # end of Crypto library routines
>=20
> CONFIG_CRC_CCITT=3Dy
> CONFIG_CRC16=3Dy
> CONFIG_CRC_T10DIF=3Dy
> CONFIG_CRC_ITU_T=3Dm
> CONFIG_CRC32=3Dy
> # CONFIG_CRC32_SELFTEST is not set
> CONFIG_CRC32_SLICEBY8=3Dy
> # CONFIG_CRC32_SLICEBY4 is not set
> # CONFIG_CRC32_SARWATE is not set
> # CONFIG_CRC32_BIT is not set
> # CONFIG_CRC64 is not set
> # CONFIG_CRC4 is not set
> CONFIG_CRC7=3Dm
> CONFIG_LIBCRC32C=3Dm
> CONFIG_CRC8=3Dm
> CONFIG_XXHASH=3Dy
> # CONFIG_RANDOM32_SELFTEST is not set
> CONFIG_ZLIB_INFLATE=3Dy
> CONFIG_ZLIB_DEFLATE=3Dy
> CONFIG_LZO_COMPRESS=3Dy
> CONFIG_LZO_DECOMPRESS=3Dy
> CONFIG_LZ4_DECOMPRESS=3Dy
> CONFIG_ZSTD_COMPRESS=3Dm
> CONFIG_ZSTD_DECOMPRESS=3Dy
> CONFIG_XZ_DEC=3Dy
> CONFIG_XZ_DEC_X86=3Dy
> CONFIG_XZ_DEC_POWERPC=3Dy
> CONFIG_XZ_DEC_IA64=3Dy
> CONFIG_XZ_DEC_ARM=3Dy
> CONFIG_XZ_DEC_ARMTHUMB=3Dy
> CONFIG_XZ_DEC_SPARC=3Dy
> # CONFIG_XZ_DEC_MICROLZMA is not set
> CONFIG_XZ_DEC_BCJ=3Dy
> # CONFIG_XZ_DEC_TEST is not set
> CONFIG_DECOMPRESS_GZIP=3Dy
> CONFIG_DECOMPRESS_BZIP2=3Dy
> CONFIG_DECOMPRESS_LZMA=3Dy
> CONFIG_DECOMPRESS_XZ=3Dy
> CONFIG_DECOMPRESS_LZO=3Dy
> CONFIG_DECOMPRESS_LZ4=3Dy
> CONFIG_DECOMPRESS_ZSTD=3Dy
> CONFIG_GENERIC_ALLOCATOR=3Dy
> CONFIG_REED_SOLOMON=3Dm
> CONFIG_REED_SOLOMON_ENC8=3Dy
> CONFIG_REED_SOLOMON_DEC8=3Dy
> CONFIG_TEXTSEARCH=3Dy
> CONFIG_TEXTSEARCH_KMP=3Dm
> CONFIG_TEXTSEARCH_BM=3Dm
> CONFIG_TEXTSEARCH_FSM=3Dm
> CONFIG_INTERVAL_TREE=3Dy
> CONFIG_XARRAY_MULTI=3Dy
> CONFIG_ASSOCIATIVE_ARRAY=3Dy
> CONFIG_HAS_IOMEM=3Dy
> CONFIG_HAS_IOPORT_MAP=3Dy
> CONFIG_HAS_DMA=3Dy
> CONFIG_DMA_OPS=3Dy
> CONFIG_NEED_SG_DMA_LENGTH=3Dy
> CONFIG_NEED_DMA_MAP_STATE=3Dy
> CONFIG_ARCH_DMA_ADDR_T_64BIT=3Dy
> CONFIG_SWIOTLB=3Dy
> CONFIG_DMA_CMA=3Dy
> # CONFIG_DMA_PERNUMA_CMA is not set
>=20
> #
> # Default contiguous memory area size:
> #
> CONFIG_CMA_SIZE_MBYTES=3D0
> CONFIG_CMA_SIZE_SEL_MBYTES=3Dy
> # CONFIG_CMA_SIZE_SEL_PERCENTAGE is not set
> # CONFIG_CMA_SIZE_SEL_MIN is not set
> # CONFIG_CMA_SIZE_SEL_MAX is not set
> CONFIG_CMA_ALIGNMENT=3D8
> # CONFIG_DMA_API_DEBUG is not set
> # CONFIG_DMA_MAP_BENCHMARK is not set
> CONFIG_SGL_ALLOC=3Dy
> CONFIG_CHECK_SIGNATURE=3Dy
> CONFIG_CPUMASK_OFFSTACK=3Dy
> CONFIG_CPU_RMAP=3Dy
> CONFIG_DQL=3Dy
> CONFIG_GLOB=3Dy
> # CONFIG_GLOB_SELFTEST is not set
> CONFIG_NLATTR=3Dy
> CONFIG_CLZ_TAB=3Dy
> CONFIG_IRQ_POLL=3Dy
> CONFIG_MPILIB=3Dy
> CONFIG_SIGNATURE=3Dy
> CONFIG_DIMLIB=3Dy
> CONFIG_OID_REGISTRY=3Dy
> CONFIG_UCS2_STRING=3Dy
> CONFIG_HAVE_GENERIC_VDSO=3Dy
> CONFIG_GENERIC_GETTIMEOFDAY=3Dy
> CONFIG_GENERIC_VDSO_TIME_NS=3Dy
> CONFIG_FONT_SUPPORT=3Dy
> # CONFIG_FONTS is not set
> CONFIG_FONT_8x8=3Dy
> CONFIG_FONT_8x16=3Dy
> CONFIG_SG_POOL=3Dy
> CONFIG_ARCH_HAS_PMEM_API=3Dy
> CONFIG_MEMREGION=3Dy
> CONFIG_ARCH_HAS_UACCESS_FLUSHCACHE=3Dy
> CONFIG_ARCH_HAS_COPY_MC=3Dy
> CONFIG_ARCH_STACKWALK=3Dy
> CONFIG_STACKDEPOT=3Dy
> CONFIG_STACKDEPOT_ALWAYS_INIT=3Dy
> CONFIG_STACK_HASH_ORDER=3D20
> CONFIG_SBITMAP=3Dy
> # end of Library routines
>=20
> CONFIG_ASN1_ENCODER=3Dy
>=20
> #
> # Kernel hacking
> #
>=20
> #
> # printk and dmesg options
> #
> CONFIG_PRINTK_TIME=3Dy
> CONFIG_PRINTK_CALLER=3Dy
> # CONFIG_STACKTRACE_BUILD_ID is not set
> CONFIG_CONSOLE_LOGLEVEL_DEFAULT=3D7
> CONFIG_CONSOLE_LOGLEVEL_QUIET=3D4
> CONFIG_MESSAGE_LOGLEVEL_DEFAULT=3D4
> CONFIG_BOOT_PRINTK_DELAY=3Dy
> CONFIG_DYNAMIC_DEBUG=3Dy
> CONFIG_DYNAMIC_DEBUG_CORE=3Dy
> CONFIG_SYMBOLIC_ERRNAME=3Dy
> CONFIG_DEBUG_BUGVERBOSE=3Dy
> # end of printk and dmesg options
>=20
> #
> # Compile-time checks and compiler options
> #
> CONFIG_DEBUG_INFO=3Dy
> CONFIG_DEBUG_INFO_REDUCED=3Dy
> # CONFIG_DEBUG_INFO_COMPRESSED is not set
> # CONFIG_DEBUG_INFO_SPLIT is not set
> # CONFIG_DEBUG_INFO_DWARF_TOOLCHAIN_DEFAULT is not set
> CONFIG_DEBUG_INFO_DWARF4=3Dy
> # CONFIG_DEBUG_INFO_DWARF5 is not set
> CONFIG_PAHOLE_HAS_SPLIT_BTF=3Dy
> # CONFIG_GDB_SCRIPTS is not set
> CONFIG_FRAME_WARN=3D8192
> CONFIG_STRIP_ASM_SYMS=3Dy
> # CONFIG_READABLE_ASM is not set
> # CONFIG_HEADERS_INSTALL is not set
> CONFIG_DEBUG_SECTION_MISMATCH=3Dy
> CONFIG_SECTION_MISMATCH_WARN_ONLY=3Dy
> CONFIG_STACK_VALIDATION=3Dy
> # CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
> # end of Compile-time checks and compiler options
>=20
> #
> # Generic Kernel Debugging Instruments
> #
> CONFIG_MAGIC_SYSRQ=3Dy
> CONFIG_MAGIC_SYSRQ_DEFAULT_ENABLE=3D0x1
> CONFIG_MAGIC_SYSRQ_SERIAL=3Dy
> CONFIG_MAGIC_SYSRQ_SERIAL_SEQUENCE=3D""
> CONFIG_DEBUG_FS=3Dy
> CONFIG_DEBUG_FS_ALLOW_ALL=3Dy
> # CONFIG_DEBUG_FS_DISALLOW_MOUNT is not set
> # CONFIG_DEBUG_FS_ALLOW_NONE is not set
> CONFIG_HAVE_ARCH_KGDB=3Dy
> # CONFIG_KGDB is not set
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=3Dy
> CONFIG_UBSAN=3Dy
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=3Dy
> CONFIG_UBSAN_BOUNDS=3Dy
> CONFIG_UBSAN_ONLY_BOUNDS=3Dy
> CONFIG_UBSAN_SHIFT=3Dy
> # CONFIG_UBSAN_DIV_ZERO is not set
> # CONFIG_UBSAN_BOOL is not set
> # CONFIG_UBSAN_ENUM is not set
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=3Dy
> # CONFIG_TEST_UBSAN is not set
> CONFIG_HAVE_ARCH_KCSAN=3Dy
> # end of Generic Kernel Debugging Instruments
>=20
> CONFIG_DEBUG_KERNEL=3Dy
> CONFIG_DEBUG_MISC=3Dy
>=20
> #
> # Networking Debugging
> #
> # CONFIG_NET_DEV_REFCNT_TRACKER is not set
> # CONFIG_NET_NS_REFCNT_TRACKER is not set
> # end of Networking Debugging
>=20
> #
> # Memory Debugging
> #
> CONFIG_PAGE_EXTENSION=3Dy
> # CONFIG_DEBUG_PAGEALLOC is not set
> CONFIG_PAGE_OWNER=3Dy
> # CONFIG_PAGE_TABLE_CHECK is not set
> # CONFIG_PAGE_POISONING is not set
> # CONFIG_DEBUG_PAGE_REF is not set
> # CONFIG_DEBUG_RODATA_TEST is not set
> CONFIG_ARCH_HAS_DEBUG_WX=3Dy
> # CONFIG_DEBUG_WX is not set
> CONFIG_GENERIC_PTDUMP=3Dy
> # CONFIG_PTDUMP_DEBUGFS is not set
> # CONFIG_DEBUG_OBJECTS is not set
> # CONFIG_SLUB_DEBUG_ON is not set
> # CONFIG_SLUB_STATS is not set
> CONFIG_HAVE_DEBUG_KMEMLEAK=3Dy
> # CONFIG_DEBUG_KMEMLEAK is not set
> # CONFIG_DEBUG_STACK_USAGE is not set
> # CONFIG_SCHED_STACK_END_CHECK is not set
> CONFIG_ARCH_HAS_DEBUG_VM_PGTABLE=3Dy
> # CONFIG_DEBUG_VM is not set
> # CONFIG_DEBUG_VM_PGTABLE is not set
> CONFIG_ARCH_HAS_DEBUG_VIRTUAL=3Dy
> # CONFIG_DEBUG_VIRTUAL is not set
> CONFIG_DEBUG_MEMORY_INIT=3Dy
> # CONFIG_DEBUG_PER_CPU_MAPS is not set
> CONFIG_HAVE_ARCH_KASAN=3Dy
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=3Dy
> CONFIG_CC_HAS_KASAN_GENERIC=3Dy
> CONFIG_CC_HAS_WORKING_NOSANITIZE_ADDRESS=3Dy
> CONFIG_KASAN=3Dy
> CONFIG_KASAN_GENERIC=3Dy
> # CONFIG_KASAN_OUTLINE is not set
> CONFIG_KASAN_INLINE=3Dy
> CONFIG_KASAN_STACK=3Dy
> CONFIG_KASAN_VMALLOC=3Dy
> # CONFIG_KASAN_KUNIT_TEST is not set
> # CONFIG_KASAN_MODULE_TEST is not set
> CONFIG_HAVE_ARCH_KFENCE=3Dy
> # CONFIG_KFENCE is not set
> # end of Memory Debugging
>=20
> CONFIG_DEBUG_SHIRQ=3Dy
>=20
> #
> # Debug Oops, Lockups and Hangs
> #
> CONFIG_PANIC_ON_OOPS=3Dy
> CONFIG_PANIC_ON_OOPS_VALUE=3D1
> CONFIG_PANIC_TIMEOUT=3D0
> CONFIG_LOCKUP_DETECTOR=3Dy
> CONFIG_SOFTLOCKUP_DETECTOR=3Dy
> # CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC is not set
> CONFIG_BOOTPARAM_SOFTLOCKUP_PANIC_VALUE=3D0
> CONFIG_HARDLOCKUP_DETECTOR_PERF=3Dy
> CONFIG_HARDLOCKUP_CHECK_TIMESTAMP=3Dy
> CONFIG_HARDLOCKUP_DETECTOR=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC=3Dy
> CONFIG_BOOTPARAM_HARDLOCKUP_PANIC_VALUE=3D1
> CONFIG_DETECT_HUNG_TASK=3Dy
> CONFIG_DEFAULT_HUNG_TASK_TIMEOUT=3D480
> # CONFIG_BOOTPARAM_HUNG_TASK_PANIC is not set
> CONFIG_BOOTPARAM_HUNG_TASK_PANIC_VALUE=3D0
> CONFIG_WQ_WATCHDOG=3Dy
> # CONFIG_TEST_LOCKUP is not set
> # end of Debug Oops, Lockups and Hangs
>=20
> #
> # Scheduler Debugging
> #
> CONFIG_SCHED_DEBUG=3Dy
> CONFIG_SCHED_INFO=3Dy
> CONFIG_SCHEDSTATS=3Dy
> # end of Scheduler Debugging
>=20
> # CONFIG_DEBUG_TIMEKEEPING is not set
>=20
> #
> # Lock Debugging (spinlocks, mutexes, etc...)
> #
> CONFIG_LOCK_DEBUGGING_SUPPORT=3Dy
> # CONFIG_PROVE_LOCKING is not set
> # CONFIG_LOCK_STAT is not set
> # CONFIG_DEBUG_RT_MUTEXES is not set
> # CONFIG_DEBUG_SPINLOCK is not set
> # CONFIG_DEBUG_MUTEXES is not set
> # CONFIG_DEBUG_WW_MUTEX_SLOWPATH is not set
> # CONFIG_DEBUG_RWSEMS is not set
> # CONFIG_DEBUG_LOCK_ALLOC is not set
> CONFIG_DEBUG_ATOMIC_SLEEP=3Dy
> # CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
> # CONFIG_LOCK_TORTURE_TEST is not set
> # CONFIG_WW_MUTEX_SELFTEST is not set
> # CONFIG_SCF_TORTURE_TEST is not set
> # CONFIG_CSD_LOCK_WAIT_DEBUG is not set
> # end of Lock Debugging (spinlocks, mutexes, etc...)
>=20
> # CONFIG_DEBUG_IRQFLAGS is not set
> CONFIG_STACKTRACE=3Dy
> # CONFIG_WARN_ALL_UNSEEDED_RANDOM is not set
> # CONFIG_DEBUG_KOBJECT is not set
>=20
> #
> # Debug kernel data structures
> #
> CONFIG_DEBUG_LIST=3Dy
> # CONFIG_DEBUG_PLIST is not set
> # CONFIG_DEBUG_SG is not set
> # CONFIG_DEBUG_NOTIFIERS is not set
> CONFIG_BUG_ON_DATA_CORRUPTION=3Dy
> # CONFIG_DEBUG_MAPLE_TREE is not set
> # end of Debug kernel data structures
>=20
> # CONFIG_DEBUG_CREDENTIALS is not set
>=20
> #
> # RCU Debugging
> #
> CONFIG_TORTURE_TEST=3Dm
> # CONFIG_RCU_SCALE_TEST is not set
> # CONFIG_RCU_TORTURE_TEST is not set
> CONFIG_RCU_REF_SCALE_TEST=3Dm
> CONFIG_RCU_CPU_STALL_TIMEOUT=3D60
> # CONFIG_RCU_TRACE is not set
> # CONFIG_RCU_EQS_DEBUG is not set
> # end of RCU Debugging
>=20
> # CONFIG_DEBUG_WQ_FORCE_RR_CPU is not set
> # CONFIG_CPU_HOTPLUG_STATE_CONTROL is not set
> CONFIG_LATENCYTOP=3Dy
> CONFIG_USER_STACKTRACE_SUPPORT=3Dy
> CONFIG_NOP_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_TRACER=3Dy
> CONFIG_HAVE_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_HAVE_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_HAVE_SYSCALL_TRACEPOINTS=3Dy
> CONFIG_HAVE_FENTRY=3Dy
> CONFIG_HAVE_OBJTOOL_MCOUNT=3Dy
> CONFIG_HAVE_C_RECORDMCOUNT=3Dy
> CONFIG_HAVE_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_BUILDTIME_MCOUNT_SORT=3Dy
> CONFIG_TRACER_MAX_TRACE=3Dy
> CONFIG_TRACE_CLOCK=3Dy
> CONFIG_RING_BUFFER=3Dy
> CONFIG_EVENT_TRACING=3Dy
> CONFIG_CONTEXT_SWITCH_TRACER=3Dy
> CONFIG_TRACING=3Dy
> CONFIG_GENERIC_TRACER=3Dy
> CONFIG_TRACING_SUPPORT=3Dy
> CONFIG_FTRACE=3Dy
> # CONFIG_BOOTTIME_TRACING is not set
> CONFIG_FUNCTION_TRACER=3Dy
> CONFIG_FUNCTION_GRAPH_TRACER=3Dy
> CONFIG_DYNAMIC_FTRACE=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_REGS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS=3Dy
> CONFIG_DYNAMIC_FTRACE_WITH_ARGS=3Dy
> CONFIG_FUNCTION_PROFILER=3Dy
> CONFIG_STACK_TRACER=3Dy
> # CONFIG_IRQSOFF_TRACER is not set
> CONFIG_SCHED_TRACER=3Dy
> CONFIG_HWLAT_TRACER=3Dy
> # CONFIG_OSNOISE_TRACER is not set
> # CONFIG_TIMERLAT_TRACER is not set
> # CONFIG_MMIOTRACE is not set
> CONFIG_FTRACE_SYSCALLS=3Dy
> CONFIG_TRACER_SNAPSHOT=3Dy
> # CONFIG_TRACER_SNAPSHOT_PER_CPU_SWAP is not set
> CONFIG_BRANCH_PROFILE_NONE=3Dy
> # CONFIG_PROFILE_ANNOTATED_BRANCHES is not set
> CONFIG_BLK_DEV_IO_TRACE=3Dy
> CONFIG_KPROBE_EVENTS=3Dy
> # CONFIG_KPROBE_EVENTS_ON_NOTRACE is not set
> CONFIG_UPROBE_EVENTS=3Dy
> CONFIG_BPF_EVENTS=3Dy
> CONFIG_DYNAMIC_EVENTS=3Dy
> CONFIG_PROBE_EVENTS=3Dy
> # CONFIG_BPF_KPROBE_OVERRIDE is not set
> CONFIG_FTRACE_MCOUNT_RECORD=3Dy
> CONFIG_FTRACE_MCOUNT_USE_CC=3Dy
> CONFIG_TRACING_MAP=3Dy
> CONFIG_SYNTH_EVENTS=3Dy
> CONFIG_HIST_TRIGGERS=3Dy
> # CONFIG_TRACE_EVENT_INJECT is not set
> # CONFIG_TRACEPOINT_BENCHMARK is not set
> CONFIG_RING_BUFFER_BENCHMARK=3Dm
> # CONFIG_TRACE_EVAL_MAP_FILE is not set
> # CONFIG_FTRACE_RECORD_RECURSION is not set
> # CONFIG_FTRACE_STARTUP_TEST is not set
> # CONFIG_FTRACE_SORT_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_STARTUP_TEST is not set
> # CONFIG_RING_BUFFER_VALIDATE_TIME_DELTAS is not set
> # CONFIG_PREEMPTIRQ_DELAY_TEST is not set
> # CONFIG_SYNTH_EVENT_GEN_TEST is not set
> # CONFIG_KPROBE_EVENT_GEN_TEST is not set
> # CONFIG_HIST_TRIGGERS_DEBUG is not set
> CONFIG_PROVIDE_OHCI1394_DMA_INIT=3Dy
> # CONFIG_SAMPLES is not set
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT=3Dy
> CONFIG_HAVE_SAMPLE_FTRACE_DIRECT_MULTI=3Dy
> CONFIG_ARCH_HAS_DEVMEM_IS_ALLOWED=3Dy
> CONFIG_STRICT_DEVMEM=3Dy
> # CONFIG_IO_STRICT_DEVMEM is not set
>=20
> #
> # x86 Debugging
> #
> CONFIG_TRACE_IRQFLAGS_NMI_SUPPORT=3Dy
> CONFIG_EARLY_PRINTK_USB=3Dy
> CONFIG_X86_VERBOSE_BOOTUP=3Dy
> CONFIG_EARLY_PRINTK=3Dy
> CONFIG_EARLY_PRINTK_DBGP=3Dy
> CONFIG_EARLY_PRINTK_USB_XDBC=3Dy
> # CONFIG_EFI_PGT_DUMP is not set
> # CONFIG_DEBUG_TLBFLUSH is not set
> CONFIG_HAVE_MMIOTRACE_SUPPORT=3Dy
> CONFIG_X86_DECODER_SELFTEST=3Dy
> CONFIG_IO_DELAY_0X80=3Dy
> # CONFIG_IO_DELAY_0XED is not set
> # CONFIG_IO_DELAY_UDELAY is not set
> # CONFIG_IO_DELAY_NONE is not set
> CONFIG_DEBUG_BOOT_PARAMS=3Dy
> # CONFIG_CPA_DEBUG is not set
> # CONFIG_DEBUG_ENTRY is not set
> # CONFIG_DEBUG_NMI_SELFTEST is not set
> # CONFIG_X86_DEBUG_FPU is not set
> # CONFIG_PUNIT_ATOM_DEBUG is not set
> CONFIG_UNWINDER_ORC=3Dy
> # CONFIG_UNWINDER_FRAME_POINTER is not set
> # end of x86 Debugging
>=20
> #
> # Kernel Testing and Coverage
> #
> CONFIG_KUNIT=3Dm
> CONFIG_KUNIT_DEBUGFS=3Dy
> # CONFIG_KUNIT_TEST is not set
> # CONFIG_KUNIT_EXAMPLE_TEST is not set
> CONFIG_KUNIT_ALL_TESTS=3Dm
> # CONFIG_NOTIFIER_ERROR_INJECTION is not set
> CONFIG_FUNCTION_ERROR_INJECTION=3Dy
> CONFIG_FAULT_INJECTION=3Dy
> # CONFIG_FAILSLAB is not set
> # CONFIG_FAIL_PAGE_ALLOC is not set
> # CONFIG_FAULT_INJECTION_USERCOPY is not set
> CONFIG_FAIL_MAKE_REQUEST=3Dy
> # CONFIG_FAIL_IO_TIMEOUT is not set
> # CONFIG_FAIL_FUTEX is not set
> CONFIG_FAULT_INJECTION_DEBUG_FS=3Dy
> # CONFIG_FAIL_FUNCTION is not set
> # CONFIG_FAIL_MMC_REQUEST is not set
> # CONFIG_FAIL_SUNRPC is not set
> CONFIG_ARCH_HAS_KCOV=3Dy
> CONFIG_CC_HAS_SANCOV_TRACE_PC=3Dy
> # CONFIG_KCOV is not set
> CONFIG_RUNTIME_TESTING_MENU=3Dy
> # CONFIG_LKDTM is not set
> # CONFIG_TEST_LIST_SORT is not set
> # CONFIG_TEST_MIN_HEAP is not set
> # CONFIG_TEST_SORT is not set
> # CONFIG_TEST_DIV64 is not set
> # CONFIG_KPROBES_SANITY_TEST is not set
> # CONFIG_BACKTRACE_SELF_TEST is not set
> # CONFIG_TEST_REF_TRACKER is not set
> # CONFIG_RBTREE_TEST is not set
> # CONFIG_REED_SOLOMON_TEST is not set
> # CONFIG_INTERVAL_TREE_TEST is not set
> # CONFIG_PERCPU_TEST is not set
> CONFIG_ATOMIC64_SELFTEST=3Dy
> # CONFIG_ASYNC_RAID6_TEST is not set
> # CONFIG_TEST_HEXDUMP is not set
> # CONFIG_STRING_SELFTEST is not set
> # CONFIG_TEST_STRING_HELPERS is not set
> # CONFIG_TEST_STRSCPY is not set
> # CONFIG_TEST_KSTRTOX is not set
> # CONFIG_TEST_PRINTF is not set
> # CONFIG_TEST_SCANF is not set
> # CONFIG_TEST_BITMAP is not set
> # CONFIG_TEST_UUID is not set
> # CONFIG_TEST_XARRAY is not set
> # CONFIG_TEST_OVERFLOW is not set
> # CONFIG_TEST_RHASHTABLE is not set
> # CONFIG_TEST_SIPHASH is not set
> # CONFIG_TEST_IDA is not set
> # CONFIG_TEST_LKM is not set
> # CONFIG_TEST_BITOPS is not set
> # CONFIG_TEST_VMALLOC is not set
> # CONFIG_TEST_USER_COPY is not set
> CONFIG_TEST_BPF=3Dm
> # CONFIG_TEST_BLACKHOLE_DEV is not set
> # CONFIG_FIND_BIT_BENCHMARK is not set
> # CONFIG_TEST_FIRMWARE is not set
> # CONFIG_TEST_SYSCTL is not set
> CONFIG_BITFIELD_KUNIT=3Dm
> CONFIG_HASH_KUNIT_TEST=3Dm
> CONFIG_RESOURCE_KUNIT_TEST=3Dm
> CONFIG_SYSCTL_KUNIT_TEST=3Dm
> CONFIG_LIST_KUNIT_TEST=3Dm
> CONFIG_LINEAR_RANGES_TEST=3Dm
> CONFIG_CMDLINE_KUNIT_TEST=3Dm
> CONFIG_BITS_TEST=3Dm
> CONFIG_SLUB_KUNIT_TEST=3Dm
> CONFIG_RATIONAL_KUNIT_TEST=3Dm
> CONFIG_MEMCPY_KUNIT_TEST=3Dm
> # CONFIG_TEST_UDELAY is not set
> # CONFIG_TEST_STATIC_KEYS is not set
> # CONFIG_TEST_KMOD is not set
> # CONFIG_TEST_MEMCAT_P is not set
> # CONFIG_TEST_LIVEPATCH is not set
> # CONFIG_TEST_STACKINIT is not set
> # CONFIG_TEST_MEMINIT is not set
> # CONFIG_TEST_HMM is not set
> # CONFIG_TEST_FREE_PAGES is not set
> # CONFIG_TEST_FPU is not set
> # CONFIG_TEST_CLOCKSOURCE_WATCHDOG is not set
> CONFIG_ARCH_USE_MEMTEST=3Dy
> # CONFIG_MEMTEST is not set
> # end of Kernel Testing and Coverage
> # end of Kernel hacking

> #!/bin/sh
>=20
> export_top_env()
> {
> 	export suite=3D'blktests'
> 	export testcase=3D'blktests'
> 	export category=3D'functional'
> 	export need_memory=3D'3G'
> 	export job_origin=3D'blktests-block.yaml'
> 	export queue_cmdline_keys=3D'branch
> commit'
> 	export queue=3D'validate'
> 	export testbox=3D'lkp-skl-d05'
> 	export tbox_group=3D'lkp-skl-d05'
> 	export kconfig=3D'x86_64-rhel-8.3-func'
> 	export submit_id=3D'621ae7c76de7a4cc586b9d9e'
> 	export job_file=3D'/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-block-g=
roup-09-ucode=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f67ded6=
31246798ec3ea37cff-20220227-52312-qtoaze-2.yaml'
> 	export id=3D'9244419f26cfb1a0cd7988e6634a87be953caffe'
> 	export queuer_version=3D'/lkp-src'
> 	export model=3D'Skylake'
> 	export nr_cpu=3D4
> 	export memory=3D'32G'
> 	export nr_ssd_partitions=3D1
> 	export nr_hdd_partitions=3D4
> 	export hdd_partitions=3D'/dev/disk/by-id/wwn-0x5000c50091e544de-part*'
> 	export ssd_partitions=3D'/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2'
> 	export rootfs_partition=3D'/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1'
> 	export brand=3D'Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz'
> 	export commit=3D'82e080f31808330f67ded631246798ec3ea37cff'
> 	export need_kconfig_hw=3D'{"E1000E"=3D>"y"}
> SATA_AHCI
> DRM_I915'
> 	export ucode=3D'0xec'
> 	export bisect_dmesg=3Dtrue
> 	export need_kconfig=3D'BLK_DEV_SD
> SCSI
> {"BLOCK"=3D>"y"}
> SATA_AHCI
> SATA_AHCI_PLATFORM
> ATA
> {"PCI"=3D>"y"}
> {"BLK_DEV_NULL_BLK_FAULT_INJECTION"=3D>"y"}
> {"RDMA_RXE"=3D>"m, v4.8-rc1"}
> {"RDMA_SIW"=3D>"m, v5.3-rc1"}
> {"BTRFS_FS"=3D>"m"}
> {"BTRFS_FS_POSIX_ACL"=3D>"y"}'
> 	export enqueue_time=3D'2022-02-27 10:53:59 +0800'
> 	export _id=3D'621ae7e06de7a4cc586b9d9f'
> 	export _rt=3D'/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-=
d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f31808=
330f67ded631246798ec3ea37cff'
> 	export user=3D'lkp'
> 	export compiler=3D'gcc-9'
> 	export LKP_SERVER=3D'internal-lkp-server'
> 	export head_commit=3D'9fbb495315a38e8812d0c05eacdc2662046963ea'
> 	export base_commit=3D'cfb92440ee71adcc2105b0890bb01ac3cddb8507'
> 	export branch=3D'linux-next/master'
> 	export rootfs=3D'debian-10.4-x86_64-20200603.cgz'
> 	export result_root=3D'/result/blktests/1HDD-block-group-09-ucode=3D0xec/=
lkp-skl-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e0=
80f31808330f67ded631246798ec3ea37cff/3'
> 	export scheduler_version=3D'/lkp/lkp/.src-20220225-152656'
> 	export arch=3D'x86_64'
> 	export max_uptime=3D2100
> 	export initrd=3D'/osimage/debian/debian-10.4-x86_64-20200603.cgz'
> 	export bootloader_append=3D'root=3D/dev/ram0
> RESULT_ROOT=3D/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-d=
05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f318083=
30f67ded631246798ec3ea37cff/3
> BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded6=
31246798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f31808
> branch=3Dlinux-next/master
> job=3D/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-block-group-09-ucode=
=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f67ded631246798ec3ea=
37cff-20220227-52312-qtoaze-2.yaml
> user=3Dlkp
> ARCH=3Dx86_64
> kconfig=3Dx86_64-rhel-8.3-func
> commit=3D82e080f31808330f67ded631246798ec3ea37cff
> max_uptime=3D2100
> LKP_SERVER=3Dinternal-lkp-server
> nokaslr
> selinux=3D0
> debug
> apic=3Ddebug
> sysrq_always_enabled
> rcupdate.rcu_cpu_stall_timeout=3D100
> net.ifnames=3D0
> printk.devkmsg=3Don
> panic=3D-1
> softlockup_panic=3D1
> nmi_watchdog=3Dpanic
> oops=3Dpanic
> load_ramdisk=3D2
> prompt_ramdisk=3D0
> drbd.minor_count=3D8
> systemd.log_level=3Derr
> ignore_loglevel
> console=3Dtty0
> earlyprintk=3DttyS0,115200
> console=3DttyS0,115200
> vga=3Dnormal
> rw'
> 	export modules_initrd=3D'/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31=
808330f67ded631246798ec3ea37cff/modules.cgz'
> 	export bm_initrd=3D'/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ip=
config_20200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220=
105.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608=
.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/blktests_20211123.cgz,/o=
simage/pkg/debian-10.4-x86_64-20200603.cgz/blktests-x86_64-bd6b882-1_202202=
26.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz'
> 	export ucode_initrd=3D'/osimage/ucode/intel-ucode-20220216.cgz'
> 	export lkp_initrd=3D'/osimage/user/lkp/lkp-x86_64.cgz'
> 	export site=3D'inn'
> 	export LKP_CGI_PORT=3D80
> 	export LKP_CIFS_PORT=3D139
> 	export last_kernel=3D'4.20.0'
> 	export repeat_to=3D6
> 	export schedule_notify_address=3D
> 	export kernel=3D'/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f6=
7ded631246798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f31808'
> 	export dequeue_time=3D'2022-02-27 11:03:42 +0800'
> 	export job_initrd=3D'/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-block=
-group-09-ucode=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f67de=
d631246798ec3ea37cff-20220227-52312-qtoaze-2.cgz'
>=20
> 	[ -n "$LKP_SRC" ] ||
> 	export LKP_SRC=3D/lkp/${user:-lkp}/src
> }
>=20
> run_job()
> {
> 	echo $$ > $TMP/run-job.pid
>=20
> 	. $LKP_SRC/lib/http.sh
> 	. $LKP_SRC/lib/job.sh
> 	. $LKP_SRC/lib/env.sh
>=20
> 	export_top_env
>=20
> 	run_setup nr_hdd=3D1 $LKP_SRC/setup/disk
>=20
> 	run_monitor $LKP_SRC/monitors/wrapper kmsg
> 	run_monitor $LKP_SRC/monitors/wrapper heartbeat
> 	run_monitor $LKP_SRC/monitors/wrapper meminfo
> 	run_monitor $LKP_SRC/monitors/wrapper oom-killer
> 	run_monitor $LKP_SRC/monitors/plain/watchdog
>=20
> 	run_test test=3D'block-group-09' $LKP_SRC/tests/wrapper blktests
> }
>=20
> extract_stats()
> {
> 	export stats_part_begin=3D
> 	export stats_part_end=3D
>=20
> 	env test=3D'block-group-09' $LKP_SRC/stats/wrapper blktests
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper meminfo
>=20
> 	$LKP_SRC/stats/wrapper time blktests.time
> 	$LKP_SRC/stats/wrapper dmesg
> 	$LKP_SRC/stats/wrapper kmsg
> 	$LKP_SRC/stats/wrapper last_state
> 	$LKP_SRC/stats/wrapper stderr
> 	$LKP_SRC/stats/wrapper time
> }
>=20
> "$@"


> Decompressing Linux... Parsing ELF... No relocation needed... done.
> Booting the kernel.
> Linux version 5.17.0-rc4-00070-g82e080f31808 (kbuild@1fffe6cb63ae) (gcc-9=
 (Debian 9.3.0-22) 9.3.0, GNU ld (GNU Binutils for Debian) 2.35.2) #1 SMP S=
un Feb 27 10:15:03 CST 2022
> Command line:  ip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 RESULT_ROOT=3D=
/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-d05/debian-10.4-x=
86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded63124679=
8ec3ea37cff/3 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f318=
08330f67ded631246798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f31808 branc=
h=3Dlinux-next/master job=3D/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-b=
lock-group-09-ucode=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f=
67ded631246798ec3ea37cff-20220227-52312-qtoaze-2.yaml user=3Dlkp ARCH=3Dx86=
_64 kconfig=3Dx86_64-rhel-8.3-func commit=3D82e080f31808330f67ded631246798e=
c3ea37cff max_uptime=3D2100 LKP_SERVER=3Dinternal-lkp-server nokaslr selinu=
x=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall_timeou=
t=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_panic=3D1=
 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=3D0 drbd=
.minor_count=3D8 systemd.log_level=3Derr ignore_loglev
> x86/fpu: Supporting XSAVE feature 0x001: 'x87 floating point registers'
> x86/fpu: Supporting XSAVE feature 0x002: 'SSE registers'
> x86/fpu: Supporting XSAVE feature 0x004: 'AVX registers'
> x86/fpu: Supporting XSAVE feature 0x008: 'MPX bounds registers'
> x86/fpu: Supporting XSAVE feature 0x010: 'MPX CSR'
> x86/fpu: xstate_offset[2]:  576, xstate_sizes[2]:  256
> x86/fpu: xstate_offset[3]:  832, xstate_sizes[3]:   64
> x86/fpu: xstate_offset[4]:  896, xstate_sizes[4]:   64
> x86/fpu: Enabled xstate features 0x1f, context size is 960 bytes, using '=
compacted' format.
> signal: max sigframe size: 2032
> BIOS-provided physical RAM map:
> BIOS-e820: [mem 0x0000000000000100-0x00000000000903ff] usable
> BIOS-e820: [mem 0x0000000000090400-0x000000000009ffff] reserved
> BIOS-e820: [mem 0x00000000000e0000-0x00000000000fffff] reserved
> BIOS-e820: [mem 0x0000000000100000-0x00000000cb11ffff] usable
> BIOS-e820: [mem 0x00000000cb120000-0x00000000cb120fff] ACPI NVS
> BIOS-e820: [mem 0x00000000cb121000-0x00000000cb14afff] reserved
> BIOS-e820: [mem 0x00000000cb14b000-0x00000000cb1a1fff] usable
> BIOS-e820: [mem 0x00000000cb1a2000-0x00000000cb9a2fff] reserved
> BIOS-e820: [mem 0x00000000cb9a3000-0x00000000db514fff] usable
> BIOS-e820: [mem 0x00000000db515000-0x00000000db738fff] reserved
> BIOS-e820: [mem 0x00000000db739000-0x00000000db772fff] ACPI data
> BIOS-e820: [mem 0x00000000db773000-0x00000000dbf25fff] ACPI NVS
> BIOS-e820: [mem 0x00000000dbf26000-0x00000000dc4fefff] reserved
> BIOS-e820: [mem 0x00000000dc4ff000-0x00000000dc4fffff] usable
> BIOS-e820: [mem 0x00000000dc500000-0x00000000dfffffff] reserved
> BIOS-e820: [mem 0x00000000f8000000-0x00000000fbffffff] reserved
> BIOS-e820: [mem 0x00000000fe000000-0x00000000fe010fff] reserved
> BIOS-e820: [mem 0x00000000fec00000-0x00000000fec00fff] reserved
> BIOS-e820: [mem 0x00000000fee00000-0x00000000fee00fff] reserved
> BIOS-e820: [mem 0x00000000ff000000-0x00000000ffffffff] reserved
> BIOS-e820: [mem 0x0000000100000000-0x000000081dffffff] usable
> printk: debug: ignoring loglevel setting.
> printk: bootconsole [earlyser0] enabled
> NX (Execute Disable) protection: active
> SMBIOS 3.0.0 present.
> DMI: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> tsc: Detected 3200.000 MHz processor
> tsc: Detected 3199.980 MHz TSC
> e820: update [mem 0x00000000-0x00000fff] usable =3D=3D> reserved
> e820: remove [mem 0x000a0000-0x000fffff] usable
> last_pfn =3D 0x81e000 max_arch_pfn =3D 0x400000000
> x86/PAT: Configuration [0-7]: WB  WC  UC- UC  WB  WP  UC- WT =20
> x2apic: enabled by BIOS, switching to x2apic ops
> last_pfn =3D 0xdc500 max_arch_pfn =3D 0x400000000
> Scan for SMP in [mem 0x00000000-0x000003ff]
> Scan for SMP in [mem 0x0009fc00-0x0009ffff]
> Scan for SMP in [mem 0x000f0000-0x000fffff]
> found SMP MP-table at [mem 0x000fcdd0-0x000fcddf]
> mpc: fcba0-fcd54
> Using GB pages for direct mapping
> RAMDISK: [mem 0x7f5955000-0x8189fffff]
> ACPI: Early table checksum verification disabled
> ACPI: RSDP 0x00000000000F05B0 000024 (v02 DELL  )
> ACPI: XSDT 0x00000000DB7450A0 0000C4 (v01 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: FACP 0x00000000DB767A50 00010C (v05 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: DSDT 0x00000000DB7451F8 022857 (v02 DELL   CBX3     01072009 INTL 2=
0120913)
> ACPI: FACS 0x00000000DBF25D80 000040
> ACPI: APIC 0x00000000DB767B60 000084 (v03 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: FPDT 0x00000000DB767BE8 000044 (v01 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: MCFG 0x00000000DB767C30 00003C (v01 DELL   CBX3     01072009 MSFT 0=
0000097)
> ACPI: HPET 0x00000000DB767C70 000038 (v01 DELL   CBX3     01072009 AMI. 0=
005000B)
> ACPI: WSMT 0x00000000DB767CA8 000028 (v01 DELL   CBX3     01072009 AMI  0=
0010013)
> ACPI: SSDT 0x00000000DB767CD0 00546C (v02 SaSsdt SaSsdt   00003000 INTL 2=
0120913)
> ACPI: UEFI 0x00000000DB76D140 000042 (v01                 00000000      0=
0000000)
> ACPI: LPIT 0x00000000DB76D188 000094 (v01 INTEL  SKL      00000000 MSFT 0=
000005F)
> ACPI: SSDT 0x00000000DB76D220 000248 (v02 INTEL  sensrhub 00000000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB76D468 002BAE (v02 INTEL  PtidDevc 00001000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB770018 000BE3 (v02 INTEL  Ther_Rvp 00001000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB770C00 0004A3 (v02 INTEL  zpodd    00001000 INTL 2=
0120913)
> ACPI: DBGP 0x00000000DB7710A8 000034 (v01 INTEL           00000000 MSFT 0=
000005F)
> ACPI: DBG2 0x00000000DB7710E0 000054 (v00 INTEL           00000000 MSFT 0=
000005F)
> ACPI: SSDT 0x00000000DB771138 000613 (v02 INTEL  DELL__MT 00000000 INTL 2=
0120913)
> ACPI: SSDT 0x00000000DB771750 000E73 (v02 CpuRef CpuSsdt  00003000 INTL 2=
0120913)
> ACPI: SLIC 0x00000000DB7725C8 000176 (v03 DELL   CBX3     01072009 MSFT 0=
0010013)
> ACPI: ASF! 0x00000000DB772740 0000A5 (v32 INTEL   HCG     00000001 TFSM 0=
00F4240)
> ACPI: DMAR 0x00000000DB7727E8 0000C8 (v01 INTEL  SKL      00000001 INTL 0=
0000001)
> ACPI: Reserving FACP table memory at [mem 0xdb767a50-0xdb767b5b]
> ACPI: Reserving DSDT table memory at [mem 0xdb7451f8-0xdb767a4e]
> ACPI: Reserving FACS table memory at [mem 0xdbf25d80-0xdbf25dbf]
> ACPI: Reserving APIC table memory at [mem 0xdb767b60-0xdb767be3]
> ACPI: Reserving FPDT table memory at [mem 0xdb767be8-0xdb767c2b]
> ACPI: Reserving MCFG table memory at [mem 0xdb767c30-0xdb767c6b]
> ACPI: Reserving HPET table memory at [mem 0xdb767c70-0xdb767ca7]
> ACPI: Reserving WSMT table memory at [mem 0xdb767ca8-0xdb767ccf]
> ACPI: Reserving SSDT table memory at [mem 0xdb767cd0-0xdb76d13b]
> ACPI: Reserving UEFI table memory at [mem 0xdb76d140-0xdb76d181]
> ACPI: Reserving LPIT table memory at [mem 0xdb76d188-0xdb76d21b]
> ACPI: Reserving SSDT table memory at [mem 0xdb76d220-0xdb76d467]
> ACPI: Reserving SSDT table memory at [mem 0xdb76d468-0xdb770015]
> ACPI: Reserving SSDT table memory at [mem 0xdb770018-0xdb770bfa]
> ACPI: Reserving SSDT table memory at [mem 0xdb770c00-0xdb7710a2]
> ACPI: Reserving DBGP table memory at [mem 0xdb7710a8-0xdb7710db]
> ACPI: Reserving DBG2 table memory at [mem 0xdb7710e0-0xdb771133]
> ACPI: Reserving SSDT table memory at [mem 0xdb771138-0xdb77174a]
> ACPI: Reserving SSDT table memory at [mem 0xdb771750-0xdb7725c2]
> ACPI: Reserving SLIC table memory at [mem 0xdb7725c8-0xdb77273d]
> ACPI: Reserving ASF! table memory at [mem 0xdb772740-0xdb7727e4]
> ACPI: Reserving DMAR table memory at [mem 0xdb7727e8-0xdb7728af]
> Setting APIC routing to cluster x2apic.
> ACPI: CEDT not present
> No NUMA configuration found
> Faking a node at [mem 0x0000000000000000-0x000000081dffffff]
> NODE_DATA(0) allocated [mem 0x81dfd5000-0x81dffffff]
> Zone ranges:
> DMA      [mem 0x0000000000001000-0x0000000000ffffff]
> DMA32    [mem 0x0000000001000000-0x00000000ffffffff]
> Normal   [mem 0x0000000100000000-0x000000081dffffff]
> Device   empty
> Movable zone start for each node
> Early memory node ranges
> node   0: [mem 0x0000000000001000-0x000000000008ffff]
> node   0: [mem 0x0000000000100000-0x00000000cb11ffff]
> node   0: [mem 0x00000000cb14b000-0x00000000cb1a1fff]
> node   0: [mem 0x00000000cb9a3000-0x00000000db514fff]
> node   0: [mem 0x00000000dc4ff000-0x00000000dc4fffff]
> node   0: [mem 0x0000000100000000-0x000000081dffffff]
> Initmem setup node 0 [mem 0x0000000000001000-0x000000081dffffff]
> On node 0, zone DMA: 1 pages in unavailable ranges
> On node 0, zone DMA: 112 pages in unavailable ranges
> On node 0, zone DMA32: 43 pages in unavailable ranges
> On node 0, zone DMA32: 2049 pages in unavailable ranges
> On node 0, zone DMA32: 4074 pages in unavailable ranges
> On node 0, zone Normal: 15104 pages in unavailable ranges
> On node 0, zone Normal: 8192 pages in unavailable ranges
> kasan: KernelAddressSanitizer initialized
> Reserving Intel graphics memory at [mem 0xde000000-0xdfffffff]
> ACPI: PM-Timer IO Port: 0x1808
> ACPI: LAPIC_NMI (acpi_id[0x01] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x02] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x03] high edge lint[0x1])
> ACPI: LAPIC_NMI (acpi_id[0x04] high edge lint[0x1])
> IOAPIC[0]: apic_id 2, version 32, address 0xfec00000, GSI 0-119
> ACPI: INT_SRC_OVR (bus 0 bus_irq 0 global_irq 2 dfl dfl)
> Int: type 0, pol 0, trig 0, bus 00, IRQ 00, APIC ID 2, APIC INT 02
> ACPI: INT_SRC_OVR (bus 0 bus_irq 9 global_irq 9 high level)
> Int: type 0, pol 1, trig 3, bus 00, IRQ 09, APIC ID 2, APIC INT 09
> Int: type 0, pol 0, trig 0, bus 00, IRQ 01, APIC ID 2, APIC INT 01
> Int: type 0, pol 0, trig 0, bus 00, IRQ 03, APIC ID 2, APIC INT 03
> Int: type 0, pol 0, trig 0, bus 00, IRQ 04, APIC ID 2, APIC INT 04
> Int: type 0, pol 0, trig 0, bus 00, IRQ 05, APIC ID 2, APIC INT 05
> Int: type 0, pol 0, trig 0, bus 00, IRQ 06, APIC ID 2, APIC INT 06
> Int: type 0, pol 0, trig 0, bus 00, IRQ 07, APIC ID 2, APIC INT 07
> Int: type 0, pol 0, trig 0, bus 00, IRQ 08, APIC ID 2, APIC INT 08
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0a, APIC ID 2, APIC INT 0a
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0b, APIC ID 2, APIC INT 0b
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0c, APIC ID 2, APIC INT 0c
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0d, APIC ID 2, APIC INT 0d
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0e, APIC ID 2, APIC INT 0e
> Int: type 0, pol 0, trig 0, bus 00, IRQ 0f, APIC ID 2, APIC INT 0f
> ACPI: Using ACPI (MADT) for SMP configuration information
> ACPI: HPET id: 0x8086a701 base: 0xfed00000
> TSC deadline timer available
> smpboot: Allowing 4 CPUs, 0 hotplug CPUs
> mapped IOAPIC to ffffffffff5fb000 (fec00000)
> PM: hibernation: Registered nosave memory: [mem 0x00000000-0x00000fff]
> PM: hibernation: Registered nosave memory: [mem 0x00090000-0x00090fff]
> PM: hibernation: Registered nosave memory: [mem 0x00091000-0x0009ffff]
> PM: hibernation: Registered nosave memory: [mem 0x000a0000-0x000dffff]
> PM: hibernation: Registered nosave memory: [mem 0x000e0000-0x000fffff]
> PM: hibernation: Registered nosave memory: [mem 0xcb120000-0xcb120fff]
> PM: hibernation: Registered nosave memory: [mem 0xcb121000-0xcb14afff]
> PM: hibernation: Registered nosave memory: [mem 0xcb1a2000-0xcb9a2fff]
> PM: hibernation: Registered nosave memory: [mem 0xdb515000-0xdb738fff]
> PM: hibernation: Registered nosave memory: [mem 0xdb739000-0xdb772fff]
> PM: hibernation: Registered nosave memory: [mem 0xdb773000-0xdbf25fff]
> PM: hibernation: Registered nosave memory: [mem 0xdbf26000-0xdc4fefff]
> PM: hibernation: Registered nosave memory: [mem 0xdc500000-0xdfffffff]
> PM: hibernation: Registered nosave memory: [mem 0xe0000000-0xf7ffffff]
> PM: hibernation: Registered nosave memory: [mem 0xf8000000-0xfbffffff]
> PM: hibernation: Registered nosave memory: [mem 0xfc000000-0xfdffffff]
> PM: hibernation: Registered nosave memory: [mem 0xfe000000-0xfe010fff]
> PM: hibernation: Registered nosave memory: [mem 0xfe011000-0xfebfffff]
> PM: hibernation: Registered nosave memory: [mem 0xfec00000-0xfec00fff]
> PM: hibernation: Registered nosave memory: [mem 0xfec01000-0xfedfffff]
> PM: hibernation: Registered nosave memory: [mem 0xfee00000-0xfee00fff]
> PM: hibernation: Registered nosave memory: [mem 0xfee01000-0xfeffffff]
> PM: hibernation: Registered nosave memory: [mem 0xff000000-0xffffffff]
> [mem 0xe0000000-0xf7ffffff] available for PCI devices
> Booting paravirtualized kernel on bare hardware
> clocksource: refined-jiffies: mask: 0xffffffff max_cycles: 0xffffffff, ma=
x_idle_ns: 1910969940391419 ns
> setup_percpu: NR_CPUS:8192 nr_cpumask_bits:4 nr_cpu_ids:4 nr_node_ids:1
> percpu: Embedded 67 pages/cpu s233752 r8192 d32488 u524288
> pcpu-alloc: s233752 r8192 d32488 u524288 alloc=3D1*2097152
> pcpu-alloc: [0] 0 1 2 3=20
> Fallback order for Node 0: 0=20
> Built 1 zonelists, mobility grouping on.  Total pages: 8228278
> Policy zone: Normal
> Kernel command line:  ip=3D::::lkp-skl-d05::dhcp root=3D/dev/ram0 RESULT_=
ROOT=3D/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-d05/debian=
-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded6=
31246798ec3ea37cff/3 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e=
080f31808330f67ded631246798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f3180=
8 branch=3Dlinux-next/master job=3D/lkp/jobs/scheduled/lkp-skl-d05/blktests=
-1HDD-block-group-09-ucode=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31=
808330f67ded631246798ec3ea37cff-20220227-52312-qtoaze-2.yaml user=3Dlkp ARC=
H=3Dx86_64 kconfig=3Dx86_64-rhel-8.3-func commit=3D82e080f31808330f67ded631=
246798ec3ea37cff max_uptime=3D2100 LKP_SERVER=3Dinternal-lkp-server nokaslr=
 selinux=3D0 debug apic=3Ddebug sysrq_always_enabled rcupdate.rcu_cpu_stall=
_timeout=3D100 net.ifnames=3D0 printk.devkmsg=3Don panic=3D-1 softlockup_pa=
nic=3D1 nmi_watchdog=3Dpanic oops=3Dpanic load_ramdisk=3D2 prompt_ramdisk=
=3D0 drbd.minor_count=3D8 systemd.log_level=3Derr ignore
> sysrq: sysrq always enabled.
> ignoring the deprecated load_ramdisk=3D option
> Unknown kernel command line parameters "nokaslr RESULT_ROOT=3D/result/blk=
tests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-d05/debian-10.4-x86_64-20200=
603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded631246798ec3ea37cff=
/3 BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded=
631246798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f31808 branch=3Dlinux-n=
ext/master job=3D/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-block-group-=
09-ucode=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f67ded631246=
798ec3ea37cff-20220227-52312-qtoaze-2.yaml user=3Dlkp ARCH=3Dx86_64 kconfig=
=3Dx86_64-rhel-8.3-func commit=3D82e080f31808330f67ded631246798ec3ea37cff m=
ax_uptime=3D2100 LKP_SERVER=3Dinternal-lkp-server softlockup_panic=3D1 prom=
pt_ramdisk=3D0 vga=3Dnormal", will be passed to user space.
> Dentry cache hash table entries: 4194304 (order: 13, 33554432 bytes, line=
ar)
> Inode-cache hash table entries: 2097152 (order: 12, 16777216 bytes, linea=
r)
> mem auto-init: stack:off, heap alloc:off, heap free:off
> Stack Depot allocating hash table with memblock_alloc
> Memory: 3649192K/33436132K available (43017K kernel code, 14147K rwdata, =
8696K rodata, 3288K init, 4052K bss, 5789008K reserved, 0K cma-reserved)
> random: get_random_u64 called from cache_random_seq_create+0x80/0x180 wit=
h crng_init=3D0
> SLUB: HWalign=3D64, Order=3D0-3, MinObjects=3D0, CPUs=3D4, Nodes=3D1
> Kernel/User page tables isolation: enabled
> ftrace: allocating 46442 entries in 182 pages
> ftrace: allocated 182 pages with 5 groups
> rcu: Hierarchical RCU implementation.
> rcu: 	RCU restricting CPUs from NR_CPUS=3D8192 to nr_cpu_ids=3D4.
> 	RCU CPU stall warnings timeout set to 100 (rcu_cpu_stall_timeout).
> 	Trampoline variant of Tasks RCU enabled.
> 	Rude variant of Tasks RCU enabled.
> 	Tracing variant of Tasks RCU enabled.
> rcu: RCU calculated value of scheduler-enlistment delay is 100 jiffies.
> rcu: Adjusting geometry for rcu_fanout_leaf=3D16, nr_cpu_ids=3D4
> NR_IRQS: 524544, nr_irqs: 1024, preallocated irqs: 16
> Console: colour VGA+ 80x25
> printk: console [tty0] enabled
> printk: console [ttyS0] enabled
> printk: console [ttyS0] enabled
> printk: bootconsole [earlyser0] disabled
> printk: bootconsole [earlyser0] disabled
> ACPI: Core revision 20211217
> clocksource: hpet: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_ns: =
79635855245 ns
> APIC: Switch to symmetric I/O mode setup
> DMAR: Host address width 39
> DMAR: DRHD base: 0x000000fed90000 flags: 0x0
> DMAR: dmar0: reg_base_addr fed90000 ver 1:0 cap 1c0000c40660462 ecap 7e3f=
f0505e
> DMAR: DRHD base: 0x000000fed91000 flags: 0x1
> DMAR: dmar1: reg_base_addr fed91000 ver 1:0 cap d2008c40660462 ecap f050d=
a
> DMAR: RMRR base: 0x000000db5db000 end: 0x000000db5fafff
> DMAR: RMRR base: 0x000000dc024000 end: 0x000000dc26dfff
> DMAR: RMRR base: 0x000000dd800000 end: 0x000000dfffffff
> DMAR-IR: IOAPIC id 2 under DRHD base  0xfed91000 IOMMU 1
> DMAR-IR: HPET id 0 under DRHD base 0xfed91000
> DMAR-IR: Queued invalidation will be enabled to support x2apic and Intr-r=
emapping.
> DMAR-IR: IRQ remapping was enabled on dmar0 but we are not in kdump mode
> DMAR-IR: IRQ remapping was enabled on dmar1 but we are not in kdump mode
> DMAR-IR: Enabled IRQ remapping in x2apic mode
> masked ExtINT on CPU#0
> ENABLING IO-APIC IRQs
> init IO_APIC IRQs
> apic 2 pin 0 not connected
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-1 -> IRQ 1 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:30 Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-2 -> IRQ 0 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-3 -> IRQ 3 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-4 -> IRQ 4 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-5 -> IRQ 5 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-6 -> IRQ 6 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-7 -> IRQ 7 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-8 -> IRQ 8 Level:0 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-9 -> IRQ 9 Level:1 ActiveLow:0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-10 -> IRQ 10 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-11 -> IRQ 11 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-12 -> IRQ 12 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-13 -> IRQ 13 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-14 -> IRQ 14 Level:0 ActiveLow:=
0)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-15 -> IRQ 15 Level:0 ActiveLow:=
0)
> apic 2 pin 16 not connected
> apic 2 pin 17 not connected
> apic 2 pin 18 not connected
> apic 2 pin 19 not connected
> apic 2 pin 20 not connected
> apic 2 pin 21 not connected
> apic 2 pin 22 not connected
> apic 2 pin 23 not connected
> apic 2 pin 24 not connected
> apic 2 pin 25 not connected
> apic 2 pin 26 not connected
> apic 2 pin 27 not connected
> apic 2 pin 28 not connected
> apic 2 pin 29 not connected
> apic 2 pin 30 not connected
> apic 2 pin 31 not connected
> apic 2 pin 32 not connected
> apic 2 pin 33 not connected
> apic 2 pin 34 not connected
> apic 2 pin 35 not connected
> apic 2 pin 36 not connected
> apic 2 pin 37 not connected
> apic 2 pin 38 not connected
> apic 2 pin 39 not connected
> apic 2 pin 40 not connected
> apic 2 pin 41 not connected
> apic 2 pin 42 not connected
> apic 2 pin 43 not connected
> apic 2 pin 44 not connected
> apic 2 pin 45 not connected
> apic 2 pin 46 not connected
> apic 2 pin 47 not connected
> apic 2 pin 48 not connected
> apic 2 pin 49 not connected
> apic 2 pin 50 not connected
> apic 2 pin 51 not connected
> apic 2 pin 52 not connected
> apic 2 pin 53 not connected
> apic 2 pin 54 not connected
> apic 2 pin 55 not connected
> apic 2 pin 56 not connected
> apic 2 pin 57 not connected
> apic 2 pin 58 not connected
> apic 2 pin 59 not connected
> apic 2 pin 60 not connected
> apic 2 pin 61 not connected
> apic 2 pin 62 not connected
> apic 2 pin 63 not connected
> apic 2 pin 64 not connected
> apic 2 pin 65 not connected
> apic 2 pin 66 not connected
> apic 2 pin 67 not connected
> apic 2 pin 68 not connected
> apic 2 pin 69 not connected
> apic 2 pin 70 not connected
> apic 2 pin 71 not connected
> apic 2 pin 72 not connected
> apic 2 pin 73 not connected
> apic 2 pin 74 not connected
> apic 2 pin 75 not connected
> apic 2 pin 76 not connected
> apic 2 pin 77 not connected
> apic 2 pin 78 not connected
> apic 2 pin 79 not connected
> apic 2 pin 80 not connected
> apic 2 pin 81 not connected
> apic 2 pin 82 not connected
> apic 2 pin 83 not connected
> apic 2 pin 84 not connected
> apic 2 pin 85 not connected
> apic 2 pin 86 not connected
> apic 2 pin 87 not connected
> apic 2 pin 88 not connected
> apic 2 pin 89 not connected
> apic 2 pin 90 not connected
> apic 2 pin 91 not connected
> apic 2 pin 92 not connected
> apic 2 pin 93 not connected
> apic 2 pin 94 not connected
> apic 2 pin 95 not connected
> apic 2 pin 96 not connected
> apic 2 pin 97 not connected
> apic 2 pin 98 not connected
> apic 2 pin 99 not connected
> apic 2 pin 100 not connected
> apic 2 pin 101 not connected
> apic 2 pin 102 not connected
> apic 2 pin 103 not connected
> apic 2 pin 104 not connected
> apic 2 pin 105 not connected
> apic 2 pin 106 not connected
> apic 2 pin 107 not connected
> apic 2 pin 108 not connected
> apic 2 pin 109 not connected
> apic 2 pin 110 not connected
> apic 2 pin 111 not connected
> apic 2 pin 112 not connected
> apic 2 pin 113 not connected
> apic 2 pin 114 not connected
> apic 2 pin 115 not connected
> apic 2 pin 116 not connected
> apic 2 pin 117 not connected
> apic 2 pin 118 not connected
> apic 2 pin 119 not connected
> ..TIMER: vector=3D0x30 apic1=3D0 pin1=3D2 apic2=3D-1 pin2=3D-1
> clocksource: tsc-early: mask: 0xffffffffffffffff max_cycles: 0x2e2036ff8d=
5, max_idle_ns: 440795275316 ns
> Calibrating delay loop (skipped), value calculated using timer frequency.=
. 6399.96 BogoMIPS (lpj=3D3199980)
> pid_max: default: 32768 minimum: 301
> LSM: Security Framework initializing
> Yama: becoming mindful.
> Mount-cache hash table entries: 65536 (order: 7, 524288 bytes, linear)
> Mountpoint-cache hash table entries: 65536 (order: 7, 524288 bytes, linea=
r)
> Poking KASLR using RDRAND RDTSC...
> CPU0: Thermal monitoring enabled (TM1)
> process: using mwait in idle threads
> Last level iTLB entries: 4KB 128, 2MB 8, 4MB 8
> Last level dTLB entries: 4KB 64, 2MB 0, 4MB 0, 1GB 4
> Spectre V1 : Mitigation: usercopy/swapgs barriers and __user pointer sani=
tization
> Spectre V2 : Mitigation: Full generic retpoline
> Spectre V2 : Spectre v2 / SpectreRSB mitigation: Filling RSB on context s=
witch
> Spectre V2 : Enabling Restricted Speculation for firmware calls
> Spectre V2 : mitigation: Enabling conditional Indirect Branch Prediction =
Barrier
> Speculative Store Bypass: Vulnerable
> TAA: Vulnerable: Clear CPU buffers attempted, no microcode
> SRBDS: Vulnerable: No microcode
> MDS: Vulnerable: Clear CPU buffers attempted, no microcode
> Freeing SMP alternatives memory: 40K
> smpboot: Estimated ratio of average max frequency by base frequency (time=
s 1024): 1056
> smpboot: CPU0: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz (family: 0x6, mode=
l: 0x5e, stepping: 0x3)
> cblist_init_generic: Setting adjustable number of callback queues.
> cblist_init_generic: Setting shift to 2 and lim to 1.
> cblist_init_generic: Setting shift to 2 and lim to 1.
> cblist_init_generic: Setting shift to 2 and lim to 1.
> Performance Events: PEBS fmt3+, Skylake events, 32-deep LBR, full-width c=
ounters, Intel PMU driver.
> ... version:                4
> ... bit width:              48
> ... generic registers:      8
> ... value mask:             0000ffffffffffff
> ... max period:             00007fffffffffff
> ... fixed-purpose events:   3
> ... event mask:             00000007000000ff
> rcu: Hierarchical SRCU implementation.
> NMI watchdog: Enabled. Permanently consumes one hw-PMU counter.
> smp: Bringing up secondary CPUs ...
> x86: Booting SMP configuration:
> .... node  #0, CPUs:      #1
> masked ExtINT on CPU#1
> #2
> masked ExtINT on CPU#2
> #3
> masked ExtINT on CPU#3
> smp: Brought up 1 node, 4 CPUs
> smpboot: Max logical packages: 1
> smpboot: Total of 4 processors activated (25599.84 BogoMIPS)
> node 0 deferred pages initialised in 82ms
> devtmpfs: initialized
> x86/mm: Memory block size: 128MB
> ACPI: PM: Registering ACPI NVS region [mem 0xcb120000-0xcb120fff] (4096 b=
ytes)
> ACPI: PM: Registering ACPI NVS region [mem 0xdb773000-0xdbf25fff] (807321=
6 bytes)
> clocksource: jiffies: mask: 0xffffffff max_cycles: 0xffffffff, max_idle_n=
s: 1911260446275000 ns
> futex hash table entries: 1024 (order: 4, 65536 bytes, linear)
> pinctrl core: initialized pinctrl subsystem
> NET: Registered PF_NETLINK/PF_ROUTE protocol family
> audit: initializing netlink subsys (disabled)
> audit: type=3D2000 audit(1512600505.215:1): state=3Dinitialized audit_ena=
bled=3D0 res=3D1
> thermal_sys: Registered thermal governor 'fair_share'
> thermal_sys: Registered thermal governor 'bang_bang'
> thermal_sys: Registered thermal governor 'step_wise'
> thermal_sys: Registered thermal governor 'user_space'
> cpuidle: using governor menu
> ACPI FADT declares the system doesn't support PCIe ASPM, so disable it
> acpiphp: ACPI Hot Plug PCI Controller Driver version: 0.5
> PCI: MMCONFIG for domain 0000 [bus 00-3f] at [mem 0xf8000000-0xfbffffff] =
(base 0xf8000000)
> PCI: MMCONFIG at [mem 0xf8000000-0xfbffffff] reserved in E820
> PCI: Using configuration type 1 for base access
> kprobes: kprobe jump-optimization is enabled. All kprobes are optimized i=
f possible.
> HugeTLB registered 1.00 GiB page size, pre-allocated 0 pages
> HugeTLB registered 2.00 MiB page size, pre-allocated 0 pages
> cryptd: max_cpu_qlen set to 1000
> ACPI: Added _OSI(Module Device)
> ACPI: Added _OSI(Processor Device)
> ACPI: Added _OSI(3.0 _SCP Extensions)
> ACPI: Added _OSI(Processor Aggregator Device)
> ACPI: Added _OSI(Linux-Dell-Video)
> ACPI: Added _OSI(Linux-Lenovo-NV-HDMI-Audio)
> ACPI: Added _OSI(Linux-HPI-Hybrid-Graphics)
> ACPI: 8 ACPI AML tables successfully acquired and loaded
> ACPI: [Firmware Bug]: BIOS _OSI(Linux) query ignored
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF888102AA0000 0006A2 (v02 PmRef  Cpu0Ist  00003000 INTL 2=
0120913)
> ACPI: \_PR_.CPU0: _OSC native thermal LVT Acked
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF888101D08800 00037F (v02 PmRef  Cpu0Cst  00003001 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF88810206CB00 00008E (v02 PmRef  Cpu0Hwp  00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF88810121D400 000130 (v02 PmRef  HwpLvt   00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF888102AEC000 0005AA (v02 PmRef  ApIst    00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF88810121C400 000119 (v02 PmRef  ApHwp    00003000 INTL 2=
0120913)
> ACPI: Dynamic OEM Table Load:
> ACPI: SSDT 0xFFFF88810121E400 000119 (v02 PmRef  ApCst    00003000 INTL 2=
0120913)
> ACPI: Interpreter enabled
> ACPI: PM: (supports S0 S3 S4 S5)
> ACPI: Using IOAPIC for interrupt routing
> PCI: Using host bridge windows from ACPI; if necessary, use "pci=3Dnocrs"=
 and report a bug
> ACPI: Enabled 7 GPEs in block 00 to 7F
> ACPI: PM: Power Resource [PG00]
> ACPI: PM: Power Resource [PG01]
> ACPI: PM: Power Resource [PG02]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [WRST]
> ACPI: PM: Power Resource [FN00]
> ACPI: PM: Power Resource [FN01]
> ACPI: PM: Power Resource [FN02]
> ACPI: PM: Power Resource [FN03]
> ACPI: PM: Power Resource [FN04]
> ACPI: PCI Root Bridge [PCI0] (domain 0000 [bus 00-3e])
> acpi PNP0A08:00: _OSC: OS supports [ExtendedConfig ASPM ClockPM Segments =
MSI HPX-Type3]
> acpi PNP0A08:00: _OSC: OS requested [PCIeHotplug SHPCHotplug PME AER PCIe=
Capability LTR]
> acpi PNP0A08:00: _OSC: platform willing to grant [PCIeHotplug SHPCHotplug=
 PME AER PCIeCapability LTR]
> acpi PNP0A08:00: _OSC: platform retains control of PCIe features (AE_ERRO=
R)
> PCI host bridge to bus 0000:00
> pci_bus 0000:00: root bus resource [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: root bus resource [io  0x0d00-0xffff window]
> pci_bus 0000:00: root bus resource [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: root bus resource [mem 0xe0000000-0xf7ffffff window]
> pci_bus 0000:00: root bus resource [mem 0xfd000000-0xfe7fffff window]
> pci_bus 0000:00: root bus resource [bus 00-3e]
> pci 0000:00:00.0: [8086:191f] type 00 class 0x060000
> pci 0000:00:01.0: [8086:1901] type 01 class 0x060400
> pci 0000:00:01.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:02.0: [8086:1912] type 00 class 0x030000
> pci 0000:00:02.0: reg 0x10: [mem 0xf6000000-0xf6ffffff 64bit]
> pci 0000:00:02.0: reg 0x18: [mem 0xe0000000-0xefffffff 64bit pref]
> pci 0000:00:02.0: reg 0x20: [io  0xf000-0xf03f]
> pci 0000:00:02.0: Video device with shadowed ROM at [mem 0x000c0000-0x000=
dffff]
> pci 0000:00:14.0: [8086:a12f] type 00 class 0x0c0330
> pci 0000:00:14.0: reg 0x10: [mem 0xf7030000-0xf703ffff 64bit]
> pci 0000:00:14.0: PME# supported from D3hot D3cold
> pci 0000:00:14.2: [8086:a131] type 00 class 0x118000
> pci 0000:00:14.2: reg 0x10: [mem 0xf704e000-0xf704efff 64bit]
> pci 0000:00:16.0: [8086:a13a] type 00 class 0x078000
> pci 0000:00:16.0: reg 0x10: [mem 0xf704d000-0xf704dfff 64bit]
> pci 0000:00:16.0: PME# supported from D3hot
> pci 0000:00:17.0: [8086:2822] type 00 class 0x010400
> pci 0000:00:17.0: reg 0x10: [mem 0xf7048000-0xf7049fff]
> pci 0000:00:17.0: reg 0x14: [mem 0xf704c000-0xf704c0ff]
> pci 0000:00:17.0: reg 0x18: [io  0xf090-0xf097]
> pci 0000:00:17.0: reg 0x1c: [io  0xf080-0xf083]
> pci 0000:00:17.0: reg 0x20: [io  0xf060-0xf07f]
> pci 0000:00:17.0: reg 0x24: [mem 0xf704b000-0xf704b7ff]
> pci 0000:00:17.0: PME# supported from D3hot
> pci 0000:00:1c.0: [8086:a110] type 01 class 0x060400
> pci 0000:00:1c.0: PME# supported from D0 D3hot D3cold
> pci 0000:00:1f.0: [8086:a146] type 00 class 0x060100
> pci 0000:00:1f.2: [8086:a121] type 00 class 0x058000
> pci 0000:00:1f.2: reg 0x10: [mem 0xf7044000-0xf7047fff]
> pci 0000:00:1f.3: [8086:a170] type 00 class 0x040300
> pci 0000:00:1f.3: reg 0x10: [mem 0xf7040000-0xf7043fff 64bit]
> pci 0000:00:1f.3: reg 0x20: [mem 0xf7020000-0xf702ffff 64bit]
> pci 0000:00:1f.3: PME# supported from D3hot D3cold
> pci 0000:00:1f.4: [8086:a123] type 00 class 0x0c0500
> pci 0000:00:1f.4: reg 0x10: [mem 0xf704a000-0xf704a0ff 64bit]
> pci 0000:00:1f.4: reg 0x20: [io  0xf040-0xf05f]
> pci 0000:00:1f.6: [8086:15b7] type 00 class 0x020000
> pci 0000:00:1f.6: reg 0x10: [mem 0xf7000000-0xf701ffff]
> pci 0000:00:1f.6: PME# supported from D0 D3hot D3cold
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:02:00.0: [104c:8240] type 01 class 0x060400
> pci 0000:02:00.0: supports D1 D2
> pci 0000:00:1c.0: PCI bridge to [bus 02-03]
> pci_bus 0000:03: extended config space not accessible
> pci 0000:02:00.0: PCI bridge to [bus 03]
> ACPI: PCI: Interrupt link LNKA configured for IRQ 7
> ACPI: PCI: Interrupt link LNKA disabled
> ACPI: PCI: Interrupt link LNKB configured for IRQ 10
> ACPI: PCI: Interrupt link LNKB disabled
> ACPI: PCI: Interrupt link LNKC configured for IRQ 5
> ACPI: PCI: Interrupt link LNKC disabled
> ACPI: PCI: Interrupt link LNKD configured for IRQ 11
> ACPI: PCI: Interrupt link LNKD disabled
> ACPI: PCI: Interrupt link LNKE configured for IRQ 7
> ACPI: PCI: Interrupt link LNKE disabled
> ACPI: PCI: Interrupt link LNKF configured for IRQ 3
> ACPI: PCI: Interrupt link LNKF disabled
> ACPI: PCI: Interrupt link LNKG configured for IRQ 4
> ACPI: PCI: Interrupt link LNKG disabled
> ACPI: PCI: Interrupt link LNKH configured for IRQ 11
> ACPI: PCI: Interrupt link LNKH disabled
> iommu: Default domain type: Translated=20
> iommu: DMA domain TLB invalidation policy: lazy mode=20
> pci 0000:00:02.0: vgaarb: setting as boot VGA device
> pci 0000:00:02.0: vgaarb: VGA device added: decodes=3Dio+mem,owns=3Dio+me=
m,locks=3Dnone
> pci 0000:00:02.0: vgaarb: bridge control possible
> vgaarb: loaded
> SCSI subsystem initialized
> ACPI: bus type USB registered
> usbcore: registered new interface driver usbfs
> usbcore: registered new interface driver hub
> usbcore: registered new device driver usb
> pps_core: LinuxPPS API ver. 1 registered
> pps_core: Software ver. 5.3.6 - Copyright 2005-2007 Rodolfo Giometti <gio=
metti@linux.it>
> PTP clock support registered
> EDAC MC: Ver: 3.0.0
> NetLabel: Initializing
> NetLabel:  domain hash size =3D 128
> NetLabel:  protocols =3D UNLABELED CIPSOv4 CALIPSO
> NetLabel:  unlabeled traffic allowed by default
> PCI: Using ACPI for IRQ routing
> PCI: pci_cache_line_size set to 64 bytes
> e820: reserve RAM buffer [mem 0x00090400-0x0009ffff]
> e820: reserve RAM buffer [mem 0xcb120000-0xcbffffff]
> e820: reserve RAM buffer [mem 0xcb1a2000-0xcbffffff]
> e820: reserve RAM buffer [mem 0xdb515000-0xdbffffff]
> e820: reserve RAM buffer [mem 0xdc500000-0xdfffffff]
> e820: reserve RAM buffer [mem 0x81e000000-0x81fffffff]
> hpet0: at MMIO 0xfed00000, IRQs 2, 8, 0, 0, 0, 0, 0, 0
> hpet0: 8 comparators, 64-bit 24.000000 MHz counter
> clocksource: Switched to clocksource tsc-early
> VFS: Disk quotas dquot_6.6.0
> VFS: Dquot-cache hash table entries: 512 (order 0, 4096 bytes)
> pnp: PnP ACPI init
> system 00:00: [io  0x0a00-0x0a3f] has been reserved
> system 00:00: [io  0x0a40-0x0a7f] has been reserved
> pnp 00:01: [dma 0 disabled]
> system 00:02: [io  0x0680-0x069f] has been reserved
> system 00:02: [io  0xffff] has been reserved
> system 00:02: [io  0xffff] has been reserved
> system 00:02: [io  0xffff] has been reserved
> system 00:02: [io  0x1800-0x18fe] has been reserved
> system 00:02: [io  0x164e-0x164f] has been reserved
> system 00:03: [io  0x0800-0x087f] has been reserved
> system 00:05: [io  0x1854-0x1857] has been reserved
> system 00:06: [mem 0xfed10000-0xfed17fff] has been reserved
> system 00:06: [mem 0xfed18000-0xfed18fff] has been reserved
> system 00:06: [mem 0xfed19000-0xfed19fff] has been reserved
> system 00:06: [mem 0xf8000000-0xfbffffff] has been reserved
> system 00:06: [mem 0xfed20000-0xfed3ffff] has been reserved
> system 00:06: [mem 0xfed90000-0xfed93fff] could not be reserved
> system 00:06: [mem 0xfed45000-0xfed8ffff] has been reserved
> system 00:06: [mem 0xff000000-0xffffffff] has been reserved
> system 00:06: [mem 0xfee00000-0xfeefffff] could not be reserved
> system 00:06: [mem 0xf7fe0000-0xf7ffffff] has been reserved
> system 00:07: [mem 0xfd000000-0xfdabffff] has been reserved
> system 00:07: [mem 0xfdad0000-0xfdadffff] has been reserved
> system 00:07: [mem 0xfdb00000-0xfdffffff] has been reserved
> system 00:07: [mem 0xfe000000-0xfe01ffff] could not be reserved
> system 00:07: [mem 0xfe036000-0xfe03bfff] has been reserved
> system 00:07: [mem 0xfe03d000-0xfe3fffff] has been reserved
> system 00:07: [mem 0xfe410000-0xfe7fffff] has been reserved
> system 00:08: [io  0xff00-0xfffe] has been reserved
> system 00:09: [mem 0xfdaf0000-0xfdafffff] has been reserved
> system 00:09: [mem 0xfdae0000-0xfdaeffff] has been reserved
> system 00:09: [mem 0xfdac0000-0xfdacffff] has been reserved
> pnp: PnP ACPI: found 10 devices
> clocksource: acpi_pm: mask: 0xffffff max_cycles: 0xffffff, max_idle_ns: 2=
085701024 ns
> NET: Registered PF_INET protocol family
> IP idents hash table entries: 262144 (order: 9, 2097152 bytes, linear)
> tcp_listen_portaddr_hash hash table entries: 16384 (order: 6, 262144 byte=
s, linear)
> TCP established hash table entries: 262144 (order: 9, 2097152 bytes, line=
ar)
> TCP bind hash table entries: 65536 (order: 8, 1048576 bytes, linear)
> TCP: Hash tables configured (established 262144 bind 65536)
> MPTCP token hash table entries: 32768 (order: 7, 786432 bytes, linear)
> UDP hash table entries: 16384 (order: 7, 524288 bytes, linear)
> UDP-Lite hash table entries: 16384 (order: 7, 524288 bytes, linear)
> NET: Registered PF_UNIX/PF_LOCAL protocol family
> RPC: Registered named UNIX socket transport module.
> RPC: Registered udp transport module.
> RPC: Registered tcp transport module.
> RPC: Registered tcp NFSv4.1 backchannel transport module.
> NET: Registered PF_XDP protocol family
> pci 0000:00:01.0: PCI bridge to [bus 01]
> pci 0000:02:00.0: PCI bridge to [bus 03]
> pci 0000:00:1c.0: PCI bridge to [bus 02-03]
> pci_bus 0000:00: resource 4 [io  0x0000-0x0cf7 window]
> pci_bus 0000:00: resource 5 [io  0x0d00-0xffff window]
> pci_bus 0000:00: resource 6 [mem 0x000a0000-0x000bffff window]
> pci_bus 0000:00: resource 7 [mem 0xe0000000-0xf7ffffff window]
> pci_bus 0000:00: resource 8 [mem 0xfd000000-0xfe7fffff window]
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:=
1)
> pci 0000:00:14.0: quirk_usb_early_handoff+0x0/0xa80 took 25068 usecs
> PCI: CLS 0 bytes, default 64
> Trying to unpack rootfs image as initramfs...
> PCI-DMA: Using software bounce buffering for IO (SWIOTLB)
> software IO TLB: mapped [mem 0x00000000d7515000-0x00000000db515000] (64MB=
)
> Initialise system trusted keyrings
> Key type blacklist registered
> workingset: timestamp_bits=3D36 max_order=3D23 bucket_order=3D0
> zbud: loaded
> 9p: Installing v9fs 9p2000 file system support
> NET: Registered PF_ALG protocol family
> Key type asymmetric registered
> Asymmetric key parser 'x509' registered
> Block layer SCSI generic (bsg) driver version 0.4 loaded (major 247)
> io scheduler mq-deadline registered
> io scheduler kyber registered
> io scheduler bfq registered
> atomic64_test: passed for x86-64 platform with CX8 and with SSE
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-16 -> IRQ 16 Level:1 ActiveLow:=
1)
> shpchp: Standard Hot Plug PCI Controller Driver version: 0.4
> input: Sleep Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0E:00/input/=
input0
> ACPI: button: Sleep Button [SLPB]
> input: Power Button as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0C0C:00/input/=
input1
> ACPI: button: Power Button [PWRB]
> input: Power Button as /devices/LNXSYSTM:00/LNXPWRBN:00/input/input2
> ACPI: button: Power Button [PWRF]
> smpboot: Estimated ratio of average max frequency by base frequency (time=
s 1024): 1056
> thermal LNXTHERM:00: registered as thermal_zone0
> ACPI: thermal: Thermal Zone [TZ00] (28 C)
> thermal LNXTHERM:01: registered as thermal_zone1
> ACPI: thermal: Thermal Zone [TZ01] (30 C)
> Serial: 8250/16550 driver, 4 ports, IRQ sharing enabled
> 00:01: ttyS0 at I/O 0x3f8 (irq =3D 4, base_baud =3D 115200) is a 16550A
> Non-volatile memory driver v1.3
> rdac: device handler registered
> hp_sw: device handler registered
> emc: device handler registered
> alua: device handler registered
> e1000: Intel(R) PRO/1000 Network Driver
> e1000: Copyright (c) 1999-2006 Intel Corporation.
> e1000e: Intel(R) PRO/1000 Network Driver
> e1000e: Copyright(c) 1999 - 2015 Intel Corporation.
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-19 -> IRQ 19 Level:1 ActiveLow:=
1)
> e1000e 0000:00:1f.6: Interrupt Throttling Rate (ints/sec) set to dynamic =
conservative mode
> e1000e 0000:00:1f.6 0000:00:1f.6 (uninitialized): registered PHC clock
> e1000e 0000:00:1f.6 eth0: (PCI Express:2.5GT/s:Width x1) 64:00:6a:30:91:4=
8
> e1000e 0000:00:1f.6 eth0: Intel(R) PRO/1000 Network Connection
> e1000e 0000:00:1f.6 eth0: MAC: 12, PHY: 12, PBA No: FFFFFF-0FF
> igb: Intel(R) Gigabit Ethernet Network Driver
> igb: Copyright (c) 2007-2014 Intel Corporation.
> Intel(R) 2.5G Ethernet Linux Driver
> Copyright(c) 2018 Intel Corporation.
> ixgbe: Intel(R) 10 Gigabit PCI Express Network Driver
> ixgbe: Copyright (c) 1999-2016 Intel Corporation.
> i40e: Intel(R) Ethernet Connection XL710 Network Driver
> i40e: Copyright (c) 2013 - 2019 Intel Corporation.
> usbcore: registered new interface driver r8152
> usbcore: registered new interface driver asix
> usbcore: registered new interface driver ax88179_178a
> ehci_hcd: USB 2.0 'Enhanced' Host Controller (EHCI) Driver
> ehci-pci: EHCI PCI platform driver
> ohci_hcd: USB 1.1 'Open' Host Controller (OHCI) Driver
> ohci-pci: OHCI PCI platform driver
> uhci_hcd: USB Universal Host Controller Interface driver
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 1
> xhci_hcd 0000:00:14.0: hcc params 0x200077c1 hci version 0x100 quirks 0x0=
000000001109810
> usb usb1: New USB device found, idVendor=3D1d6b, idProduct=3D0002, bcdDev=
ice=3D 5.17
> usb usb1: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb1: Product: xHCI Host Controller
> usb usb1: Manufacturer: Linux 5.17.0-rc4-00070-g82e080f31808 xhci-hcd
> usb usb1: SerialNumber: 0000:00:14.0
> hub 1-0:1.0: USB hub found
> hub 1-0:1.0: 16 ports detected
> xhci_hcd 0000:00:14.0: xHCI Host Controller
> xhci_hcd 0000:00:14.0: new USB bus registered, assigned bus number 2
> xhci_hcd 0000:00:14.0: Host supports USB 3.0 SuperSpeed
> usb usb2: New USB device found, idVendor=3D1d6b, idProduct=3D0003, bcdDev=
ice=3D 5.17
> usb usb2: New USB device strings: Mfr=3D3, Product=3D2, SerialNumber=3D1
> usb usb2: Product: xHCI Host Controller
> usb usb2: Manufacturer: Linux 5.17.0-rc4-00070-g82e080f31808 xhci-hcd
> usb usb2: SerialNumber: 0000:00:14.0
> hub 2-0:1.0: USB hub found
> hub 2-0:1.0: 10 ports detected
> usb: port power management may be unreliable
> i8042: PNP: No PS/2 controller found.
> mousedev: PS/2 mouse device common for all mice
> rtc_cmos 00:04: RTC can wake from S4
> tsc: Refined TSC clocksource calibration: 3191.988 MHz
> rtc_cmos 00:04: registered as rtc0
> clocksource: tsc: mask: 0xffffffffffffffff max_cycles: 0x2e02b942467, max=
_idle_ns: 440795270039 ns
> rtc_cmos 00:04: setting system clock to 2017-12-06T22:48:31 UTC (15126005=
11)
> clocksource: Switched to clocksource tsc
> rtc_cmos 00:04: alarms up to one month, y3k, 242 bytes nvram, hpet irqs
> i801_smbus 0000:00:1f.4: SPD Write Disable is set
> i801_smbus 0000:00:1f.4: SMBus using PCI interrupt
> i2c i2c-0: 4/4 memory slots populated (from DMI)
> i2c i2c-0: Successfully instantiated SPD at 0x50
> i2c i2c-0: Successfully instantiated SPD at 0x51
> i2c i2c-0: Successfully instantiated SPD at 0x52
> i2c i2c-0: Successfully instantiated SPD at 0x53
> iTCO_wdt iTCO_wdt: Found a Intel PCH TCO device (Version=3D4, TCOBASE=3D0=
x0400)
> iTCO_wdt iTCO_wdt: initialized. heartbeat=3D30 sec (nowayout=3D0)
> iTCO_vendor_support: vendor-support=3D0
> intel_pstate: HWP enabled by BIOS
> intel_pstate: Intel P-state driver initializing
> intel_pstate: HWP enabled
> hid: raw HID events driver (C) Jiri Kosina
> usbcore: registered new interface driver usbhid
> usbhid: USB HID core driver
> drop_monitor: Initializing network drop monitor service
> Initializing XFRM netlink socket
> NET: Registered PF_INET6 protocol family
> Segment Routing with IPv6
> In-situ OAM (IOAM) with IPv6
> NET: Registered PF_PACKET protocol family
> 9pnet: Installing 9P2000 support
> mpls_gso: MPLS GSO support
> microcode: sig=3D0x506e3, pf=3D0x2, revision=3D0xc2
> microcode: Microcode Update Driver: v2.2.
> IPI shorthand broadcast: enabled
> ... APIC ID:      00000000 (0)
> ... APIC VERSION: 01060015
> 0000000000000000000000000000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000000000000000000000000000
> 0000000000000000000000000000000000000000000000000000000000001000
>=20
> number of MP IRQ sources: 15.
> number of IO-APIC #2 registers: 120.
> testing the IO APIC.......................
> IO APIC #2......
> .... register #00: 02000000
> .......    : physical APIC id: 02
> .......    : Delivery Type: 0
> .......    : LTS          : 0
> .... register #01: 00770020
> .......     : max redirection entries: 77
> .......     : PRQ implemented: 0
> .......     : IO APIC version: 20
> .... register #02: 00000000
> .......     : arbitration: 00
> .... IRQ redirection table:
> IOAPIC 0:
> pin00, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin01, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin02, enabled , edge , high, V(00), IRR(0), S(0), remapped, I(0001),  Z(=
0)
> pin03, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin04, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin05, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin06, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin07, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin08, enabled , edge , high, V(00), IRR(0), S(0), remapped, I(0007),  Z(=
0)
> pin09, enabled , level, high, V(00), IRR(0), S(0), remapped, I(0008),  Z(=
0)
> pin0a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin0b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin0c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin0d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin0e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin0f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin10, enabled , level, low , V(00), IRR(0), S(0), remapped, I(000F),  Z(=
0)
> pin11, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin12, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin13, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin14, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin15, disabled, edge , high, V(00), IRR(0), S(0), logical , D(4880), M(2=
)
> pin16, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin17, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin18, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin19, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin1a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin1b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin1c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin1d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin1e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin1f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin20, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin21, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin22, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin23, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin24, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin25, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin26, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin27, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin28, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin29, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin2a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin2b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin2c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin2d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin2e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin2f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin30, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin31, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin32, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin33, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin34, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin35, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin36, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin37, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin38, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin39, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin3a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin3b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin3c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin3d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin3e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin3f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin40, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin41, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin42, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin43, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin44, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin45, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin46, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin47, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin48, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin49, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin4a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin4b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin4c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin4d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin4e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin4f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin50, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin51, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin52, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin53, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin54, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin55, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin56, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin57, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin58, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin59, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin5a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin5b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin5c, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin5d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin5e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin5f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin60, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin61, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin62, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin63, disabled, edge , high, V(08), IRR(0), S(0), physical, D(4800), M(2=
)
> pin64, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin65, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin66, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin67, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin68, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin69, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin6a, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin6b, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin6c, disabled, edge , high, V(10), IRR(0), S(0), physical, D(1064), M(2=
)
> pin6d, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin6e, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin6f, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin70, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin71, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin72, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin73, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin74, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin75, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> pin76, disabled, edge , high, V(08), IRR(0), S(0), logical , D(0022), M(2=
)
> pin77, disabled, edge , high, V(00), IRR(0), S(0), physical, D(0000), M(0=
)
> IRQ to pin mappings:
> IRQ0 -> 0:2
> IRQ1 -> 0:1
> IRQ3 -> 0:3
> IRQ4 -> 0:4
> IRQ5 -> 0:5
> IRQ6 -> 0:6
> IRQ7 -> 0:7
> IRQ8 -> 0:8
> IRQ9 -> 0:9
> IRQ10 -> 0:10
> IRQ11 -> 0:11
> IRQ12 -> 0:12
> IRQ13 -> 0:13
> IRQ14 -> 0:14
> IRQ15 -> 0:15
> IRQ16 -> 0:16
> IRQ19 -> 0:19
> .................................... done.
> AVX2 version of gcm_enc/dec engaged.
> AES CTR mode by8 optimization enabled
> sched_clock: Marking stable (6551833403, 1037417273)->(8879439474, -12901=
88798)
> registered taskstats version 1
> Loading compiled-in X.509 certificates
> Loaded X.509 cert 'Build time autogenerated kernel key: 9056866813b9aacf7=
5f604821b002f861cb72f55'
> zswap: loaded using pool lzo/zbud
> page_owner is disabled
> Key type ._fscrypt registered
> Key type .fscrypt registered
> Key type fscrypt-provisioning registered
> Freeing initrd memory: 574124K
> Key type encrypted registered
> ima: No TPM chip found, activating TPM-bypass!
> ima: Allocated hash algorithm: sha1
> ima: No architecture policies found
> evm: Initialising EVM extended attributes:
> evm: security.selinux
> evm: security.SMACK64 (disabled)
> evm: security.SMACK64EXEC (disabled)
> evm: security.SMACK64TRANSMUTE (disabled)
> evm: security.SMACK64MMAP (disabled)
> evm: security.apparmor (disabled)
> evm: security.ima
> evm: security.capability
> evm: HMAC attrs: 0x1
> e1000e 0000:00:1f.6 eth0: NIC Link is Up 1000 Mbps Full Duplex, Flow Cont=
rol: None
> IPv6: ADDRCONF(NETDEV_CHANGE): eth0: link becomes ready
> Sending DHCP requests ..., OK
> IP-Config: Got DHCP answer from 192.168.3.2, my address is 192.168.3.99
> IP-Config: Complete:
> device=3Deth0, hwaddr=3D64:00:6a:30:91:48, ipaddr=3D192.168.3.99, mask=3D=
255.255.255.0, gw=3D192.168.3.200
> host=3Dlkp-skl-d05, domain=3Dlkp.intel.com, nis-domain=3D(none)
> bootserver=3D192.168.3.200, rootserver=3D192.168.3.200, rootpath=3D
> nameserver0=3D192.168.3.200
> Freeing unused kernel image (initmem) memory: 3288K
> Write protecting the kernel read-only data: 55296k
> Freeing unused kernel image (text/rodata gap) memory: 2036K
> Freeing unused kernel image (rodata/data gap) memory: 1544K
> Run /init as init process
> with arguments:
> /init
> nokaslr
> with environment:
> HOME=3D/
> TERM=3Dlinux
> RESULT_ROOT=3D/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-d=
05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f318083=
30f67ded631246798ec3ea37cff/3
> BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded6=
31246798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f31808
> branch=3Dlinux-next/master
> job=3D/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-block-group-09-ucode=
=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f67ded631246798ec3ea=
37cff-20220227-52312-qtoaze-2.yaml
> user=3Dlkp
> ARCH=3Dx86_64
> kconfig=3Dx86_64-rhel-8.3-func
> commit=3D82e080f31808330f67ded631246798ec3ea37cff
> max_uptime=3D2100
> LKP_SERVER=3Dinternal-lkp-server
> softlockup_panic=3D1
> prompt_ramdisk=3D0
> vga=3Dnormal
> systemd[1]: RTC configured in localtime, applying delta of 0 minutes to s=
ystem time.
> systemd[1]: System time before build time, advancing clock.
>=20
>=20
> intel_pmc_core INT33A1:00:  initialized
> m.
> mei_me 0000:00:16.0: enabling device (0000 -> 0002)
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-18 -> IRQ 18 Level:1 ActiveLow:=
1)
> ACPI: bus type drm_connector registered
> libata version 3.00 loaded.
> ahci 0000:00:17.0: version 3.0
> IOAPIC[2]: Set IRTE entry (P:1 FPD:0 Dst_Mode:1 Redir_hint:1 Trig_Mode:0 =
Dlvry_Mode:0 Avail:0 Vector:EF Dest:00000001 SID:F0F8 SQ:0 SVT:1)
> IOAPIC[0]: Preconfigured routing entry (2-17 -> IRQ 17 Level:1 ActiveLow:=
1)
> ahci 0000:00:17.0: controller can't do SNTF, turning off CAP_SNTF
> Startin[   23.248274][  T220] RAPL PMU: API unit is 2^-32 Joules, 4 fixed=
 counters, 655360 ms ovfl timer
> ind portmap serv[   23.264965][  T220] RAPL PMU: hw unit of domain packag=
e 2^-14 Joules
> RAPL PMU: hw unit of domain dram 2^-14 Joules
> ahci 0000:00:17.0: AHCI 0001.0301 32 slots 4 ports 6 Gbps 0xf impl RAID m=
ode
> RAPL PMU: hw unit of domain pp1-gpu 2^-14 Joules
> ahci 0000:00:17.0: flags: 64bit ncq pm led clo only pio slum part ems des=
o sadm sds apst=20
> m.
> scsi host3: ahci
> 1;39mNetwork Tim[   23.365063][  T222] ata3: SATA max UDMA/133 abar m2048=
@0xf704b000 port 0xf704b200 irq 127
> e Synchronizatio[   23.374587][  T222] ata4: SATA max UDMA/133 abar m2048=
@0xf704b000 port 0xf704b280 irq 127
> microcode: updated to revision 0xec, date =3D 2021-04-29
> x86/CPU: CPU features have changed after loading microcode, but might not=
 take effect.
> x86/CPU: Please consider either early loading through initrd/built-in or =
a potential BIOS update.
> microcode: Reload completed, microcode revision: 0xec
> random: ln: uninitialized urandom read (6 bytes read)
> File exists
> LKP: ttyS0: 284: Kernel tests: Boot OK!
> LKP: ttyS0: 284: HOSTNAME lkp-skl-d05, MAC 64:00:6a:30:91:48, kernel 5.17=
.0-rc4-00070-g82e080f31808 1
> ata2: SATA link up 6.0 Gbps (SStatus 133 SControl 300)
> ata4: SATA link down (SStatus 4 SControl 300)
> ata3: SATA link down (SStatus 4 SControl 300)
> ata2.00: ATA-10: INTEL SSDSC2KG960G8, XCV10120, max UDMA/133
> 1;39mSystem Logg[   23.739454][  T268] ata2.00: configured for UDMA/133
>=20
> ata1.00: 5860533168 sectors, multi 16: LBA48 NCQ (depth 32), AA
> 1;39mPermit User[   23.781573][   T33] scsi 0:0:0:0: Direct-Access     AT=
A      ST3000VX000-1ES1 CV27 PQ: 0 ANSI: 5
> scsi 1:0:0:0: Direct-Access     ATA      INTEL SSDSC2KG96 0120 PQ: 0 ANSI=
: 5
> sd 0:0:0:0: [sda] 5860533168 512-byte logical blocks: (3.00 TB/2.73 TiB)
> sd 0:0:0:0: Attached scsi generic sg0 type 0
> sd 0:0:0:0: [sda] 4096-byte physical blocks
> scsi 1:0:0:0: Attached scsi generic sg1 type 0
> Startin[   23.863654][   T34] sd 0:0:0:0: [sda] Write Protect is off
> Load kernel imag[   23.877238][   T35] ata2.00: Enabling discard_zeroes_d=
ata
> ...
> sd 1:0:0:0: [sdb] 1875385008 512-byte logical blocks: (960 GB/894 GiB)
> sd 1:0:0:0: [sdb] 4096-byte physical blocks
> 1;39mLogin Servi[   23.923145][   T35] sd 1:0:0:0: [sdb] Mode Sense: 00 3=
a 00 00
> sd 1:0:0:0: [sdb] Write cache: enabled, read cache: enabled, doesn't supp=
ort DPO or FUA
> ata2.00: Enabling discard_zeroes_data
> sdb: sdb1 sdb2
> ata2.00: Enabling discard_zeroes_data
> sda: sda1 sda2 sda3 sda4
> i915 0000:00:02.0: vgaarb: deactivate vga console
> Console: switching to colour dummy device 80x25
> sd 0:0:0:0: [sda] Attached SCSI disk
> sd 1:0:0:0: [sdb] Attached SCSI disk
> ipmi device interface
> i915 0000:00:02.0: vgaarb: changed VGA decodes: olddecodes=3Dio+mem,decod=
es=3Dio+mem:owns=3Dio+mem
> i915 0000:00:02.0: Direct firmware load for i915/skl_dmc_ver1_27.bin fail=
ed with error -2
> i915 0000:00:02.0: [drm] Failed to load DMC firmware i915/skl_dmc_ver1_27=
.bin. Disabling runtime power management.
> ipmi_si: IPMI System Interface driver
> i915 0000:00:02.0: [drm] DMC firmware homepage: https://git.kernel.org/pu=
b/scm/linux/kernel/git/firmware/linux-firmware.git/tree/i915
> ipmi_si: Unable to find any System Interface(s)
> [drm] Initialized i915 1.6.0 20201103 for 0000:00:02.0 on minor 0
> intel_rapl_common: Found RAPL domain package
> intel_rapl_common: Found RAPL domain core
> intel_rapl_common: Found RAPL domain uncore
> intel_rapl_common: Found RAPL domain dram
> See 'systemctl status openipmi.service' for details.
> ACPI: video: Video Device [GFX0] (multi-head: yes  rom: no  post: no)
> input: Video Bus as /devices/LNXSYSTM:00/LNXSYBUS:00/PNP0A08:00/LNXVIDEO:=
00/input/input3
> raid6: avx2x4   gen() 31057 MB/s
> raid6: avx2x2   gen() 25375 MB/s
> i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
> raid6: avx2x1   gen() 22857 MB/s
> raid6: using algorithm avx2x4 gen() 31057 MB/s
> raid6: .... xor() 12939 MB/s, rmw enabled
> raid6: using avx2x2 recovery algorithm
> i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
> xor: automatically using best checksumming function   avx      =20
> i915 0000:00:02.0: [drm] Cannot find any crtc or sizes
> Btrfs loaded, crc32c=3Dcrc32c-intel, zoned=3Dyes, fsverity=3Dno
> BTRFS: device fsid e0425c4d-d223-4e8f-b1dd-4d2d95817751 devid 1 transid 4=
016 /dev/sdb1 scanned by systemd-udevd (219)
> random: crng init done
> random: 2 urandom warning(s) missed due to ratelimiting
> device-mapper: core: CONFIG_IMA_DISABLE_HTABLE is disabled. Duplicate IMA=
 measurements will not be recorded in the IMA log.
> device-mapper: uevent: version 1.0.3
> device-mapper: ioctl: 4.45.0-ioctl (2021-03-22) initialised: dm-devel@red=
hat.com
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> BUG: KASAN: use-after-free in move_vma+0xc69/0xe00
> Read of size 8 at addr ffff888805c9e2a8 by task python3.7/743
>=20
> CPU: 3 PID: 743 Comm: python3.7 Not tainted 5.17.0-rc4-00070-g82e080f3180=
8 #1
> Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> Call Trace:
> <TASK>
> dump_stack_lvl+0x34/0x44
> print_address_description+0x21/0x180
> ? move_vma+0xc69/0xe00
> kasan_report.cold+0x7f/0x11b
> ? move_vma+0xc69/0xe00
> move_vma+0xc69/0xe00
> ? move_page_tables+0x1c80/0x1c80
> ? security_mmap_addr+0x3f/0x80
> LKP: stdout: 284: Kernel tests: Boot OK!
> __do_sys_mremap+0x569/0x11c0
> ? move_vma+0xe00/0xe00
>=20
> ? cap_capget+0x2c0/0x2c0
> ? handle_mm_fault+0x1be/0x6c0
> ? up_read+0x15/0xc0
> ? do_user_addr_fault+0x320/0xd80
> do_syscall_64+0x3b/0xc0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fd0b9a9201a
> Code: 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d 46 0e 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd9c276ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> RAX: ffffffffffffffda RBX: 00000000000a1000 RCX: 00007fd0b9a9201a
> RDX: 00000000000a1000 RSI: 0000000000051000 RDI: 00007fd0b93eb000
> RBP: 0000000000051000 R08: 0000000000000000 R09: 00007fd0b93eb000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fd0b95802d8 R14: 00000000000a0010 R15: 0000000000051000
> </TASK>
>=20
> Allocated by task 743:
> kasan_save_stack+0x1e/0x40
> __kasan_slab_alloc+0x66/0x80
> kmem_cache_alloc+0x123/0x480
> vm_area_dup+0x80/0x240
> __split_vma+0x8a/0x480
> do_mas_align_munmap+0x34d/0xbc0
> do_mas_munmap+0x163/0x240
> __vm_munmap+0x131/0x240
> __x64_sys_munmap+0x55/0x80
> do_syscall_64+0x3b/0xc0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
> Freed by task 743:
> kasan_save_stack+0x1e/0x40
> kasan_set_track+0x21/0x40
> kasan_set_free_info+0x20/0x40
> __kasan_slab_free+0xf9/0x140
> kmem_cache_free+0xa1/0x400
> do_mas_align_munmap+0x6aa/0xbc0
> do_mas_munmap+0x163/0x240
> do_munmap+0xb2/0x100
> move_vma+0x523/0xe00
> __do_sys_mremap+0x569/0x11c0
> do_syscall_64+0x3b/0xc0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
>=20
> The buggy address belongs to the object at ffff888805c9e288
> which belongs to the cache vm_area_struct of size 152
> The buggy address is located 32 bytes inside of
> 152-byte region [ffff888805c9e288, ffff888805c9e320)
> The buggy address belongs to the page:
> page:0000000051b8737b refcount:1 mapcount:0 mapping:0000000000000000 inde=
x:0x0 pfn:0x805c9e
> memcg:ffff8887f5a57401
> flags: 0x17ffffc0000200(slab|node=3D0|zone=3D2|lastcpupid=3D0x1fffff)
> raw: 0017ffffc0000200 0000000000000000 dead000000000122 ffff88810021edc0
> raw: 0000000000000000 0000000080120012 00000001ffffffff ffff8887f5a57401
> page dumped because: kasan: bad access detected
>=20
> Memory state around the buggy address:
> ffff888805c9e180: fc fc fc fc fc fc fa fb fb fb fb fb fb fb fb fb
> ffff888805c9e200: fb fb fb fb fb fb fb fb fb fc fc fc fc fc fc fc
> >ffff888805c9e280: fc fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb
> ^
> ffff888805c9e300: fb fb fb fb fc fc fc fc fc fc fc fc fa fb fb fb
> ffff888805c9e380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fc
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> Disabling lock debugging due to kernel taint
> general protection fault, probably for non-canonical address 0xdffffc0000=
000004: 0000 [#1] SMP KASAN PTI
> KASAN: null-ptr-deref in range [0x0000000000000020-0x0000000000000027]
> CPU: 3 PID: 743 Comm: python3.7 Tainted: G    B             5.17.0-rc4-00=
070-g82e080f31808 #1
> Hardware name: Dell Inc. OptiPlex 7040/0Y7WYT, BIOS 1.8.1 12/05/2017
> RIP: 0010:move_vma+0x63f/0xe00
> Code: 3c 02 00 0f 85 88 06 00 00 48 8b 73 08 4c 89 e7 e8 d6 6c fe ff 48 b=
a 00 00 00 00 00 fc ff df 48 8d 78 20 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f=
 85 4b 06 00 00 48 81 48 20 00 00 10 00 eb 03 4c 63
> RSP: 0018:ffffc90000907c50 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff888805c9e288 RCX: 0000000000000004
> RDX: dffffc0000000000 RSI: ffff88880d2f7400 RDI: 0000000000000020
> RBP: 00007fd0b93eb000 R08: dffffc0000000000 R09: ffff88880d2f740c
> R10: ffffc90000907b28 R11: 000000000000000f R12: ffff8882007384c0
> R13: ffff888200738570 R14: 00000000002c9000 R15: 00007fd0b91a4000
> FS:  00007fd0b9995740(0000) GS:ffff888784180000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd0b943b000 CR3: 000000080d2f0006 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
> <TASK>
> ? move_page_tables+0x1c80/0x1c80
> ? security_mmap_addr+0x3f/0x80
> __do_sys_mremap+0x569/0x11c0
> ? move_vma+0xe00/0xe00
> ? cap_capget+0x2c0/0x2c0
> ? handle_mm_fault+0x1be/0x6c0
> ? up_read+0x15/0xc0
> ? do_user_addr_fault+0x320/0xd80
> do_syscall_64+0x3b/0xc0
> entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x7fd0b9a9201a
> Code: 73 01 c3 48 8b 0d 76 0e 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0=
f 1f 84 00 00 00 00 00 66 90 49 89 ca b8 19 00 00 00 0f 05 <48> 3d 01 f0 ff=
 ff 73 01 c3 48 8b 0d 46 0e 0c 00 f7 d8 64 89 01 48
> RSP: 002b:00007ffd9c276ca8 EFLAGS: 00000246 ORIG_RAX: 0000000000000019
> RAX: ffffffffffffffda RBX: 00000000000a1000 RCX: 00007fd0b9a9201a
> RDX: 00000000000a1000 RSI: 0000000000051000 RDI: 00007fd0b93eb000
> RBP: 0000000000051000 R08: 0000000000000000 R09: 00007fd0b93eb000
> R10: 0000000000000001 R11: 0000000000000246 R12: 0000000000000000
> R13: 00007fd0b95802d8 R14: 00000000000a0010 R15: 0000000000051000
> </TASK>
> Modules linked in: dm_multipath dm_mod btrfs blake2b_generic xor raid6_pq=
 zstd_compress libcrc32c intel_rapl_msr intel_rapl_common x86_pkg_temp_ther=
mal ipmi_devintf intel_powerclamp i915 ipmi_msghandler sd_mod t10_pi sg int=
el_gtt coretemp kvm_intel kvm irqbypass ttm crct10dif_pclmul crc32_pclmul m=
ei_wdt crc32c_intel ghash_clmulni_intel drm_kms_helper wmi_bmof syscopyarea=
 sysfillrect sysimgblt fb_sys_fops ahci rapl libahci intel_cstate drm libat=
a intel_pch_thermal mei_me mei intel_uncore wmi video intel_pmc_core acpi_p=
ad ip_tables
> ---[ end trace 0000000000000000 ]---
> RIP: 0010:move_vma+0x63f/0xe00
> Code: 3c 02 00 0f 85 88 06 00 00 48 8b 73 08 4c 89 e7 e8 d6 6c fe ff 48 b=
a 00 00 00 00 00 fc ff df 48 8d 78 20 48 89 f9 48 c1 e9 03 <80> 3c 11 00 0f=
 85 4b 06 00 00 48 81 48 20 00 00 10 00 eb 03 4c 63
> RSP: 0018:ffffc90000907c50 EFLAGS: 00010202
> RAX: 0000000000000000 RBX: ffff888805c9e288 RCX: 0000000000000004
> RDX: dffffc0000000000 RSI: ffff88880d2f7400 RDI: 0000000000000020
> RBP: 00007fd0b93eb000 R08: dffffc0000000000 R09: ffff88880d2f740c
> R10: ffffc90000907b28 R11: 000000000000000f R12: ffff8882007384c0
> R13: ffff888200738570 R14: 00000000002c9000 R15: 00007fd0b91a4000
> FS:  00007fd0b9995740(0000) GS:ffff888784180000(0000) knlGS:0000000000000=
000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 00007fd0b943b000 CR3: 000000080d2f0006 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Kernel panic - not syncing: Fatal exception
> Kernel Offset: disabled

> ---
> :#! jobs/blktests-block.yaml:
> suite: blktests
> testcase: blktests
> category: functional
> need_memory: 3G
> disk: 1HDD
> blktests:
>   test: block-group-09
> job_origin: blktests-block.yaml
> :#! queue options:
> queue_cmdline_keys:
> - branch
> - commit
> queue: bisect
> testbox: lkp-skl-d05
> tbox_group: lkp-skl-d05
> kconfig: x86_64-rhel-8.3-func
> submit_id: 621addbd6de7a4b224df71bf
> job_file: "/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-block-group-09-u=
code=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f67ded631246798e=
c3ea37cff-20220227-45604-1jhhji0-0.yaml"
> id: d2676d23626418e4885a5b7bb7446c2f9ce3dd33
> queuer_version: "/lkp-src"
> :#! hosts/lkp-skl-d05:
> model: Skylake
> nr_cpu: 4
> memory: 32G
> nr_ssd_partitions: 1
> nr_hdd_partitions: 4
> hdd_partitions: "/dev/disk/by-id/wwn-0x5000c50091e544de-part*"
> ssd_partitions: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part2"
> rootfs_partition: "/dev/disk/by-id/wwn-0x55cd2e4151977e28-part1"
> brand: Intel(R) Core(TM) i5-6500 CPU @ 3.20GHz
> :#! include/category/functional:
> kmsg:
> heartbeat:
> meminfo:
> :#! include/queue/cyclic:
> commit: 82e080f31808330f67ded631246798ec3ea37cff
> :#! include/testbox/lkp-skl-d05:
> need_kconfig_hw:
> - E1000E: y
> - SATA_AHCI
> - DRM_I915
> ucode: '0xec'
> bisect_dmesg: true
> :#! include/disk/nr_hdd:
> need_kconfig:
> - BLK_DEV_SD
> - SCSI
> - BLOCK: y
> - SATA_AHCI
> - SATA_AHCI_PLATFORM
> - ATA
> - PCI: y
> - BLK_DEV_NULL_BLK_FAULT_INJECTION: y
> - RDMA_RXE: m, v4.8-rc1
> - RDMA_SIW: m, v5.3-rc1
> - BTRFS_FS: m
> - BTRFS_FS_POSIX_ACL: y
> :#! include/blktests:
> enqueue_time: 2022-02-27 10:11:09.885745824 +08:00
> _id: 621addbd6de7a4b224df71bf
> _rt: "/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-d05/debia=
n-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded=
631246798ec3ea37cff"
> :#! schedule options:
> user: lkp
> compiler: gcc-9
> LKP_SERVER: internal-lkp-server
> head_commit: 9fbb495315a38e8812d0c05eacdc2662046963ea
> base_commit: cfb92440ee71adcc2105b0890bb01ac3cddb8507
> branch: linux-next/master
> rootfs: debian-10.4-x86_64-20200603.cgz
> result_root: "/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl-d=
05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f318083=
30f67ded631246798ec3ea37cff/0"
> scheduler_version: "/lkp/lkp/.src-20220225-152656"
> arch: x86_64
> max_uptime: 2100
> initrd: "/osimage/debian/debian-10.4-x86_64-20200603.cgz"
> bootloader_append:
> - root=3D/dev/ram0
> - RESULT_ROOT=3D/result/blktests/1HDD-block-group-09-ucode=3D0xec/lkp-skl=
-d05/debian-10.4-x86_64-20200603.cgz/x86_64-rhel-8.3-func/gcc-9/82e080f3180=
8330f67ded631246798ec3ea37cff/0
> - BOOT_IMAGE=3D/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67de=
d631246798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f31808
> - branch=3Dlinux-next/master
> - job=3D/lkp/jobs/scheduled/lkp-skl-d05/blktests-1HDD-block-group-09-ucod=
e=3D0xec-debian-10.4-x86_64-20200603.cgz-82e080f31808330f67ded631246798ec3e=
a37cff-20220227-45604-1jhhji0-0.yaml
> - user=3Dlkp
> - ARCH=3Dx86_64
> - kconfig=3Dx86_64-rhel-8.3-func
> - commit=3D82e080f31808330f67ded631246798ec3ea37cff
> - max_uptime=3D2100
> - LKP_SERVER=3Dinternal-lkp-server
> - nokaslr
> - selinux=3D0
> - debug
> - apic=3Ddebug
> - sysrq_always_enabled
> - rcupdate.rcu_cpu_stall_timeout=3D100
> - net.ifnames=3D0
> - printk.devkmsg=3Don
> - panic=3D-1
> - softlockup_panic=3D1
> - nmi_watchdog=3Dpanic
> - oops=3Dpanic
> - load_ramdisk=3D2
> - prompt_ramdisk=3D0
> - drbd.minor_count=3D8
> - systemd.log_level=3Derr
> - ignore_loglevel
> - console=3Dtty0
> - earlyprintk=3DttyS0,115200
> - console=3DttyS0,115200
> - vga=3Dnormal
> - rw
> modules_initrd: "/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67=
ded631246798ec3ea37cff/modules.cgz"
> bm_initrd: "/osimage/deps/debian-10.4-x86_64-20200603.cgz/run-ipconfig_20=
200608.cgz,/osimage/deps/debian-10.4-x86_64-20200603.cgz/lkp_20220105.cgz,/=
osimage/deps/debian-10.4-x86_64-20200603.cgz/rsync-rootfs_20200608.cgz,/osi=
mage/deps/debian-10.4-x86_64-20200603.cgz/blktests_20211123.cgz,/osimage/pk=
g/debian-10.4-x86_64-20200603.cgz/blktests-x86_64-bd6b882-1_20220226.cgz,/o=
simage/deps/debian-10.4-x86_64-20200603.cgz/hw_20200715.cgz"
> ucode_initrd: "/osimage/ucode/intel-ucode-20220216.cgz"
> lkp_initrd: "/osimage/user/lkp/lkp-x86_64.cgz"
> site: inn
> :#! /cephfs/db/releases/20220225094351/lkp-src/include/site/inn:
> LKP_CGI_PORT: 80
> LKP_CIFS_PORT: 139
> oom-killer:
> watchdog:
> :#! runtime status:
> last_kernel: 5.17.0-rc5-06023-ga5ef57f6fe12
> schedule_notify_address:
> :#! user overrides:
> kernel: "/pkg/linux/x86_64-rhel-8.3-func/gcc-9/82e080f31808330f67ded63124=
6798ec3ea37cff/vmlinuz-5.17.0-rc4-00070-g82e080f31808"
> dequeue_time: 2022-02-27 10:48:56.267159401 +08:00
> job_state: booting
