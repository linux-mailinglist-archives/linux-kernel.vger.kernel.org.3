Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9BBD6492FFB
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 22:22:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244436AbiARVVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 16:21:43 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:34962 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234934AbiARVVm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 16:21:42 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20IKEZlE013780;
        Tue, 18 Jan 2022 21:20:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=m89tD0IJjAMjwiobMmwMaXYSsvmE1wf/ogn2QxN0SgI=;
 b=Zc+jFVxf3pCXqsCwgaTS0Wd9JiQCbVRY1/z/PSLHFCFtUfRl9HIYDzAHdfA9pnNPG9lZ
 JJpNA5Tb2X3HCGfuMB6V0CyTCCrlBjnJfT4AePMUt2vVyBinFg2NbKunTbM9308RIU7j
 Sx3aaHdw/jZUV3Xbeq17E/RWFq3xI7IcyxHiXRXjZc3HQnMuEDUOZQ1QwCZV9W3hsqiF
 dsx43ZOga3JwJ36wYBFwuWDxUF1v53VazZqqCZYGULYDQOvYH5lxpRuHSDN2GHbaFb6T
 F6zDwStWkepOr/K7YNwdT0cFiqj+INzFne5PojZK66jRegEf753Oucrsn/mQCBUgDh2w 4w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dnc52u7f0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:12 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20IKvCoc160305;
        Tue, 18 Jan 2022 21:20:11 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2176.outbound.protection.outlook.com [104.47.59.176])
        by aserp3030.oracle.com with ESMTP id 3dkmackrwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Jan 2022 21:20:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=AcZvlyAkWOqo6ESAzdrAa7y6A3txaYVpjtfDSUzemprHaf364LuAB242qWkuvKWlLRXdUu4lqiH3kRirBNA8tCmNaxJ6QvNhgc3W055hBdwLa4yX4Q0C+Go3EZhHgz7i2Km9aeaajFPmcdTnISY2nGdXUmxxfoAbbS6PMb7h8rP1xKUTzUSEyCqnVd/eTfq7kWD44TE3WMAEcg4ywouUelG7J5oEHKY8lfIEAQMNdSa2T0CNE/cLFdTz2Aaxehx3iy57fh+ueQyrtrIC8ZZ8IOFKLYiB1OlvAtjd+hgsi2DdAh545Iyun5CqhJ3XWAExavp/teNH9Downg1QL7f/Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m89tD0IJjAMjwiobMmwMaXYSsvmE1wf/ogn2QxN0SgI=;
 b=j738tpEI7e47GnnrO0dPTuqaoNGgvswCEdVE9HgPstxQEmLYX7QPPJFt0J4fCo3SJGgV9fK3ho0sLOxViotxWs20IhSGjgUgz4ViORa3Y3CkhSZO2+P1S5M1oWTEhq6c3Byvlo8NtMAXgIxARVLNzaKbU1XA4BIB8slXzdB/yad6O4MlKFiDlTdAZ4ZdD3sBGX1U+utp6GrdihNjhJyxocGi8+IaL2K0E4wNs+whCaTt/xs192BHUyEnbG2g5jQG/kLYOZU1ddsfO+PNxIiCwJrU+gPfbUXd+gJ9XUqpudu1hLqPVva5kaQ1GzgcnxLTWVivOxEJtFU0yiJnfSAS0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m89tD0IJjAMjwiobMmwMaXYSsvmE1wf/ogn2QxN0SgI=;
 b=VQ6hkjewnleIXtfcTdOFQqqHFZR5r5s6NH3LD6irF9EsPFOxqCh0ioVTDdluFXbfAekZEMePBgCW6LSlRT8NHCw2inOVua6hHMQGJJZ3NOPiTGdxNFq/6HbJyXqJlSBfvwXczfmo8/b0Le5AahieO9qscc2qsYRU9WKJzhc9n9U=
Received: from BN8PR10MB3220.namprd10.prod.outlook.com (2603:10b6:408:c8::18)
 by CH2PR10MB4374.namprd10.prod.outlook.com (2603:10b6:610:af::20) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4888.10; Tue, 18 Jan
 2022 21:20:08 +0000
Received: from BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2]) by BN8PR10MB3220.namprd10.prod.outlook.com
 ([fe80::104f:849b:6a11:c5c2%6]) with mapi id 15.20.4888.014; Tue, 18 Jan 2022
 21:20:08 +0000
From:   Khalid Aziz <khalid.aziz@oracle.com>
To:     akpm@linux-foundation.org, willy@infradead.org,
        longpeng2@huawei.com, arnd@arndb.de, dave.hansen@linux.intel.com,
        david@redhat.com, rppt@kernel.org, surenb@google.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Cc:     Khalid Aziz <khalid.aziz@oracle.com>
Subject: [RFC PATCH 0/6] Add support for shared PTEs across processes
Date:   Tue, 18 Jan 2022 14:19:12 -0700
Message-Id: <cover.1642526745.git.khalid.aziz@oracle.com>
X-Mailer: git-send-email 2.32.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: BYAPR07CA0001.namprd07.prod.outlook.com
 (2603:10b6:a02:bc::14) To BN8PR10MB3220.namprd10.prod.outlook.com
 (2603:10b6:408:c8::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 03ccd3ff-9730-41b4-fab1-08d9dac84ddb
X-MS-TrafficTypeDiagnostic: CH2PR10MB4374:EE_
X-Microsoft-Antispam-PRVS: <CH2PR10MB4374F992BEE28F5D429962C386589@CH2PR10MB4374.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: piDQYpBQyeJKq75tbeawAwdDiXaFWVcHmqnfKvkfFVWWjXZc53FpCkxz/R4YU9tNMV8g12uvJumFLqNwRPR+ChB+jMMmGn303KpP4SLh04MrYMH6zYfVp4lKFtbbEpaxwULme77z8iJJL3m2rbTiXN3oMykwmm34In0ZijEY3RwYG5pV/XtTjBsZ7mpQnSrujLIJivNWRvgJDUT7DWguHUbkonHxUZ5+dbm6/tS5dOeFD58helELEcLK4ucWE2kx/1iHLN2tCNTwAgl0axkCf6hC/oMFhMRuKvMHDkHGZLN5qWGqaiDGw872TfknuxvIy255nuLcUwR11HklztBgG4ynQV4I1lZDm68Jt7cFpy9+fw12yT0I0pwNNwJJaM8QnXvFXLKyuAdSKXMvUKRwihPk4fJCvStI5NZPNJ2/okMljq9QVCLn3xlnDjMzi8u8X1b9a25ONdLkTP6v3BceiI8NJ7o7vpbo8uK4IAeNVG9XSVRzUkMaWkKuKBuLTs5sQaA+2IFN7Yp0IkWyLKz2LiQHkgfUbHY89/epQWq+JPRKcFAyZns42Lv21YStfcu7fJP/tDOblhUE+rOYkZThUtKOwuSy+Z2MoTWGlzFiAm0JuDq7H7y2zE/VUsKRm4QP+dhGICC8VzCab6mUqWV9xP5XeWyyJkZJon0q+YzaeoECxadP7GxSBaBZuQ5V8j3X
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BN8PR10MB3220.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(86362001)(8676002)(2616005)(508600001)(52116002)(4326008)(66476007)(6512007)(5660300002)(7416002)(38100700002)(6666004)(83380400001)(2906002)(6486002)(6506007)(8936002)(186003)(107886003)(921005)(36756003)(316002)(66946007)(66556008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RmERZ74R5lYR29kuCc3KvjAEC4mZULvUESdtlpWFGaZQuHjEs7KeED28gOJC?=
 =?us-ascii?Q?RGPHy2jPqAeAcUyl7qsPXpi3PaMP/8PNSrFO3FH4ahPtV1MrQuDbjoYuiG86?=
 =?us-ascii?Q?hw+qka9uiTj/yPLjV/ShpZhpG9RBDJWLotA9pKQuXczDAzRRBzU8lzxhQaCg?=
 =?us-ascii?Q?2+cSmEjyTTvg1sa3RaWDeu9Y3OWfKDZ+BuP76SwUS7yPQ+hAMcSA2P4wAiId?=
 =?us-ascii?Q?wQV3q2zzHbkLQjZEUSMIFpY8rWkINYZQv5BxmvB9MtyubtwG3aQVv/CqIv7X?=
 =?us-ascii?Q?vntjPNjT5vlSRmhyXZAET5kaiYQ+f1pAUFxdZozlgU1U5GJjTIiYDF2HtSC/?=
 =?us-ascii?Q?PJUp612kwlTpizHvJuBposlRqwzdTpiaXEAZjKh2Zh/SwoMov/mB6LU2o7l0?=
 =?us-ascii?Q?npdzlUn26UFkN+M3miiit8m1RUE/145xtsGv0ryM1f69iV1woG9yVqqoFWbT?=
 =?us-ascii?Q?r9QKTnhOmFRfNiw/1mrOoXYhGOU0t5WD6EI+SepbKykhLtFJrj9abVo8zu0a?=
 =?us-ascii?Q?uYNfOuJLyjWn+P6IJq/UNEK1CYJ1du6HP5t7Fw7K/XtHlEw1RHYgtPZ80otg?=
 =?us-ascii?Q?LcalfBcMmGeBtAZtA4BrDGtfnIVdGCFjkO7dWAIGPIDZjPVcG2jGdNMXbNkw?=
 =?us-ascii?Q?SQr+TY2b3DGNjQOuvz2FzrqjKX46JRrs5muWvYmn9/AYHyeSFUEcJi7f0zE2?=
 =?us-ascii?Q?iTWpkxaOoJfZWyswxFR4n14qiHtDJo25jjPBzrc+giqLtNxHdR9A+2nfE1w3?=
 =?us-ascii?Q?6VpVEPeolWO9frPNk038bZvFXB9+yTB8VffDkTwiBSd4zSx/orXhel9xUTOt?=
 =?us-ascii?Q?ZUw5Vh8z++ezhUjxlflr99a46K67d8J9yOD/SFKPKIt9L1KT0XkIPfT8FZxW?=
 =?us-ascii?Q?7MAzxgnK82DSb31p9BeSoGqQcwq9KwBJFks7l3bp4GnVYTRpV66iSufdGCz5?=
 =?us-ascii?Q?ZuINpzqFbq3ia++pLU6smakSdk+W3sfdEgvZOUrXheGh2nTUTvo4r1ULeEi0?=
 =?us-ascii?Q?ZYCDAphb39yF/gnEU91MY4gQy15u5J80HRnzaZI4vCZcE8w1spfc/HLzXrVG?=
 =?us-ascii?Q?ZbeRltuXlKpN08LZN1Y7Zj5XICFsrc0JkRZRHsbUJHd77gnPHt8omT3PMvp/?=
 =?us-ascii?Q?Yvx7Yp/uejUd7HECwQLT9xLDCgr8mBbaVpQoDmoWgpZGFAkJDtxFAs4oMAAW?=
 =?us-ascii?Q?MIdb0AHXF+M/ymQr6vLJKxHQQV9PnhhCtLobL3vjNC/160sVBICpMmkgIdUy?=
 =?us-ascii?Q?kUWWkBe37IeF3V/ebcrEN0uapdtpqc4l5iQyJggYSt5itr6zic0t6aiFl1Cn?=
 =?us-ascii?Q?Pea7eLGNRTESOHOdQZrrPivOgyYx0TpChrsE2qOU590zgsFjcfoJnuixRSni?=
 =?us-ascii?Q?934n2UIz8jHIs5xSrNFD5xR61UeHeEQnXVmlCt6c+QEkda/uYjUsTyJVYssK?=
 =?us-ascii?Q?m9HqRp1GwwJFU5qghS/VouI5N/RMtTtgqZ8IH5vvOb99luBS6sABNZ02+/mK?=
 =?us-ascii?Q?aij+eqEp/R8FDHv04mX+MyHjZxZstmWbM2HecrPl5zg7d7+sCfvZSPdyvpA/?=
 =?us-ascii?Q?qSOiVaItTWofb/6EFO/u5bniULHNObRCZaoS1fbqV+UreT0l1IDoH3sZ37Mj?=
 =?us-ascii?Q?1rPrhVma8ckQ+pCQfwMmm0iJFc7+gy5NiP1GsY3soojP?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 03ccd3ff-9730-41b4-fab1-08d9dac84ddb
X-MS-Exchange-CrossTenant-AuthSource: BN8PR10MB3220.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jan 2022 21:20:08.7024
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: k81zdzYirt4FqT2wIW/pUSPVU5AYX8Rce55vaMYqBO7SypO5Sjw3YABEfD4s+lbZBiYS+pY6gnDhKAha4jIW6Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR10MB4374
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10231 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxscore=0 suspectscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 spamscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201180121
X-Proofpoint-GUID: J7W0bp3eWKGSeW2HIhot7aVvVNe_vEwA
X-Proofpoint-ORIG-GUID: J7W0bp3eWKGSeW2HIhot7aVvVNe_vEwA
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Page tables in kernel consume some of the memory and as long as
number of mappings being maintained is small enough, this space
consumed by page tables is not objectionable. When very few memory
pages are shared between processes, the number of page table entries
(PTEs) to maintain is mostly constrained by the number of pages of
memory on the system. As the number of shared pages and the number
of times pages are shared goes up, amount of memory consumed by page
tables starts to become significant.

Some of the field deployments commonly see memory pages shared
across 1000s of processes. On x86_64, each page requires a PTE that
is only 8 bytes long which is very small compared to the 4K page
size. When 2000 processes map the same page in their address space,
each one of them requires 8 bytes for its PTE and together that adds
up to 8K of memory just to hold the PTEs for one 4K page. On a
database server with 300GB SGA, a system carsh was seen with
out-of-memory condition when 1500+ clients tried to share this SGA
even though the system had 512GB of memory. On this server, in the
worst case scenario of all 1500 processes mapping every page from
SGA would have required 878GB+ for just the PTEs. If these PTEs
could be shared, amount of memory saved is very significant.

This is a proposal to implement a mechanism in kernel to allow
userspace processes to opt into sharing PTEs. The proposal is to add
a new system call - mshare(), which can be used by a process to
create a region (we will call it mshare'd region) which can be used
by other processes to map same pages using shared PTEs. Other
process(es), assuming they have the right permissions, can then make
the mashare() system call to map the shared pages into their address
space using the shared PTEs.  When a process is done using this
mshare'd region, it makes a mshare_unlink() system call to end its
access. When the last process accessing mshare'd region calls
mshare_unlink(), the mshare'd region is torn down and memory used by
it is freed.


API Proposal
============

The mshare API consists of two system calls - mshare() and mshare_unlink()

--
int mshare(char *name, void *addr, size_t length, int oflags, mode_t mode)

mshare() creates and opens a new, or opens an existing mshare'd
region that will be shared at PTE level. "name" refers to shared object
name that exists under /sys/fs/mshare. "addr" is the starting address
of this shared memory area and length is the size of this area.
oflags can be one of:

- O_RDONLY opens shared memory area for read only access by everyone
- O_RDWR opens shared memory area for read and write access
- O_CREAT creates the named shared memory area if it does not exist
- O_EXCL If O_CREAT was also specified, and a shared memory area
  exists with that name, return an error.

mode represents the creation mode for the shared object under
/sys/fs/mshare.

mshare() returns an error code if it fails, otherwise it returns 0.

PTEs are shared at pgdir level and hence it imposes following
requirements on the address and size given to the mshare():

- Starting address must be aligned to pgdir size (512GB on x86_64)
- Size must be a multiple of pgdir size
- Any mappings created in this address range at any time become
  shared automatically
- Shared address range can have unmapped addresses in it. Any access
  to unmapped address will result in SIGBUS

Mappings within this address range behave as if they were shared
between threads, so a write to a MAP_PRIVATE mapping will create a
page which is shared between all the sharers. The first process that
declares an address range mshare'd can continue to map objects in
the shared area. All other processes that want mshare'd access to
this memory area can do so by calling mshare(). After this call, the
address range given by mshare becomes a shared range in its address
space. Anonymous mappings will be shared and not COWed.

A file under /sys/fs/mshare can be opened and read from. A read from
this file returns two long values - (1) starting address, and (2)
size of the mshare'd region.

--
int mshare_unlink(char *name)

A shared address range created by mshare() can be destroyed using
mshare_unlink() which removes the  shared named object. Once all
processes have unmapped the shared object, the shared address range
references are de-allocated and destroyed.

mshare_unlink() returns 0 on success or -1 on error.


Example Code
============

Snippet of the code that a donor process would run looks like below:

-----------------
        addr = mmap((void *)TB(2), GB(512), PROT_READ | PROT_WRITE,
                        MAP_SHARED | MAP_ANONYMOUS, 0, 0);
        if (addr == MAP_FAILED)
                perror("ERROR: mmap failed");

        err = syscall(MSHARE_SYSCALL, "testregion", (void *)TB(2),
			GB(512), O_CREAT|O_RDWR|O_EXCL, 600);
        if (err < 0) {
                perror("mshare() syscall failed");
                exit(1);
        }

        strncpy(addr, "Some random shared text",
			sizeof("Some random shared text"));
-----------------

Snippet of code that a consumer process would execute looks like:

-----------------
        fd = open("testregion", O_RDONLY);
        if (fd < 0) {
                perror("open failed");
                exit(1);
        }

        if ((count = read(fd, &mshare_info, sizeof(mshare_info)) > 0))
                printf("INFO: %ld bytes shared at addr %lx \n",
				mshare_info[1], mshare_info[0]);
        else
                perror("read failed");

        close(fd);

        addr = (char *)mshare_info[0];
        err = syscall(MSHARE_SYSCALL, "testregion", (void *)mshare_info[0],
			mshare_info[1], O_RDWR, 600);
        if (err < 0) {
                perror("mshare() syscall failed");
                exit(1);
        }

        printf("Guest mmap at %px:\n", addr);
        printf("%s\n", addr);
	printf("\nDone\n");

        err = syscall(MSHARE_UNLINK_SYSCALL, "testregion");
        if (err < 0) {
                perror("mshare_unlink() failed");
                exit(1);
        }
-----------------


RFC Proposal
============

This series of RFC patches is a prototype implementation of these
two system calls. This code is just a prototype with many bugs and
limitations and is incomplete. It works well enough to show how
this concept will work.

Prototype for the two syscalls is:

SYSCALL_DEFINE5(mshare, const char *, name, unsigned long, addr,
		unsigned long, len, int, oflag, mode_t, mode)

SYSCALL_DEFINE1(mshare_unlink, const char *, name)

In oreder to facilitate page table sharing, this implemntation adds
a new in-memory filesystem - msharefs which will be mounted at
/sys/fs/mshare. When a new mshare'd region is
created, a file with the name given by initial mshare() call is
created under this filesystem. Permissions for this file are given
by the "mode" parameter to mshare(). The only operation supported on
this file is read. A read from this file returns two long values -
(1) starting virtual address for the region, and (2) size of
mshare'd region.

A donor process that wants to create an mshare'd region from a
section of its mapped addresses calls mshare() with O_CREAT oflag.
mshare() syscall then creates a new mm_struct which will host the
page tables for the mshare'd region.  vma->vm_mm for the vmas
covering address range for this region are updated to point to this
new mm_struct instead of current->mm.  Existing page tables are
copied over to new mm struct.

A consumer process that wants to map mshare'd region opens
/sys/fs/mshare/<filename> and reads the starting address and size of
mshare'd region. It then calls mshare() with these values to map the
entire region in its address space. Consumer process calls
mshare_unlink() to terminate its access.

I would very much appreciate feedback on - (1) the API and how it
defines the PTE sharing concept, and (2) core of the initial
implementation. The file mm/mshare.c contains a list of current
issues/bugs/holes in the code at this time at the top of the file.
If the general direction of this work looks reasonable, I will
continue working on adding the missing code including much of error
handling and fixing bugs.


Khalid Aziz (6):
  mm: Add new system calls mshare, mshare_unlink
  mm: Add msharefs filesystem
  mm: Add read for msharefs
  mm: implement mshare_unlink syscall
  mm: Add locking to msharefs syscalls
  mm: Add basic page table sharing using mshare

 Documentation/filesystems/msharefs.rst |  19 +
 arch/x86/entry/syscalls/syscall_64.tbl |   2 +
 include/linux/mm.h                     |   8 +
 include/trace/events/mmflags.h         |   3 +-
 include/uapi/asm-generic/unistd.h      |   7 +-
 include/uapi/linux/magic.h             |   1 +
 mm/Makefile                            |   2 +-
 mm/internal.h                          |   7 +
 mm/memory.c                            |  35 +-
 mm/mshare.c                            | 604 +++++++++++++++++++++++++
 10 files changed, 682 insertions(+), 6 deletions(-)
 create mode 100644 Documentation/filesystems/msharefs.rst
 create mode 100644 mm/mshare.c

-- 
2.32.0

