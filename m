Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72941477D53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 21:20:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241355AbhLPUUW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 15:20:22 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:32856 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241309AbhLPUUE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 15:20:04 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1BGIneKF005124;
        Thu, 16 Dec 2021 20:19:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=86Vkf+S0G49l4Yf6tvaDhr/WaBZmMpAS1bpWFBKg2GY=;
 b=WwDlWFVucq8Dxu2lCWAYnjrRJx0w2MprCK3yp3DEkL0jFFoIwfGfTfOvqlPDE10Psu97
 XV+ZN3yqnma2EQEjbQFIVfTsIpv5+OwpyaevYITw7/rJUCLEbkY0p7R3oRtNoCVNu1rg
 44zomA4puoLBnM2Ty5JrQVp6+Pocnw3GP+NTheHlLAd0Escx3V2X1pHGN4k+7czSfPOC
 Iro4X3YX5HlGWy9t36y9m6hxy+GhOtojsp0inm0tpzpi32jSduAdC4DlZ75ac6Y5isMQ
 L9SyUxX/Tq5apkGudkAE4KDDgUfJP73lJa7Nu87KGHYkWBHdDzjgeoyhap/Lz3l/Klwg yA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cyknrkvas-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:51 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1BGKGD95123962;
        Thu, 16 Dec 2021 20:19:50 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2106.outbound.protection.outlook.com [104.47.70.106])
        by aserp3030.oracle.com with ESMTP id 3cyjuae09p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Dec 2021 20:19:49 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SLcSZW439eKbO6y0qxhPVTSuEWWvy8YR+DwFJVeG0WEzOSYopEgdxCxBFM3s5/mH72RDz9Kq+yhDdFhxFqw2yyjNDL+KR6SsUPgRY2KtjKlInf2FMbDJmvWsvIZiEDb+jAd0pOPHLNoByYlQ/p5+/6FOIBB61L+bHc3twJTRI/k1WFXWrgSPqUFm+ijlHE6lBbmhlAcekKCZrdlchw3YrNTwQMHaSFCBrybjdPoNb7/fcD16jMC4FXkad5siGqUd2kfmQ8uYkRqYu8VC0wjuQ9x/eLTRNeW01ndPSI/ALIWNZqYIRJ/iQWnxNwFVvWL5bVA2ZNSaeZRuqCnuJIA/xA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=86Vkf+S0G49l4Yf6tvaDhr/WaBZmMpAS1bpWFBKg2GY=;
 b=UeMBv/f9ERk01jHoM+dQZxst1o9dgq+XnUUNqUpkQZVDfHcB9QNQFxKwHIHk3bJfFhb8aphpNcb4w1xIf5fFKAHswcKrs1JZj7uHooCphJHKtCXdpRig4J9kXf+QBblLa9a01rQGxlVb3HrPCFD9QoYQmObznemtChyji99IjaX9/VnULRL1CHgQGq1eOe6U0gcSmwj2eG+APg08Q/MqnfyUxN/hVOGZnRZjFyz52jjxrn8fMoP4uCPgfdw/K2+oc5JUPYDbpuD6FnHBvyXVsATOo8kpLlVHvH1In4STjX4fJdJ81MmC5nZA3hsDqhBGSpGTcC2bNjB0r++jhwgrQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=86Vkf+S0G49l4Yf6tvaDhr/WaBZmMpAS1bpWFBKg2GY=;
 b=WB1pgRbZDJgNbBIlifo2Z16OMkV+rz5xIqdj07vWuhbQmeu3/hYXplGzfOAIpROipZPC3eHLPHbcqyzSy+TXtpOC3ZILaypQwjcp2QFYIgv+JFxZPssl6PD+lSlcjuNm5kpMSiSDfzYii07I29iPr/fjTrWOk61rAt8trZxXyI0=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SN6PR10MB2541.namprd10.prod.outlook.com (2603:10b6:805:44::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Thu, 16 Dec
 2021 20:19:47 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::c873:a8b4:278e:939e%7]) with mapi id 15.20.4801.015; Thu, 16 Dec 2021
 20:19:47 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     jeyu@kernel.org, masahiroy@kernel.org
Cc:     linux-modules@vger.kernel.org, linux-kernel@vger.kernel.org,
        arnd@arndb.de, akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PING PATCH v7] kallsyms: new /proc/kallmodsyms with builtin modules
Date:   Thu, 16 Dec 2021 20:19:12 +0000
Message-Id: <20211216201919.234994-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.34.0.258.gc900572c39
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO4P123CA0095.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:191::10) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 6869f345-4186-4796-7b1b-08d9c0d167ba
X-MS-TrafficTypeDiagnostic: SN6PR10MB2541:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2541DB1C64A7A05D2ACA6A678B779@SN6PR10MB2541.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: +tFtnR42XiKoxtC2CccM+HQUCsJ+6U1KDtJHYhvyPgxQVQcFl66bpkzjltIsaGdZdmvOgu4eHyIwrDc7VGvkdJRcps+KsiD82DWMxNsM4RTLwuXhAQfixAIsTMZ5gCfB1TNap3rhb0ivNnOWa6UFEg2jLB0PRqLsG5d+Y0Rhx4B6BlwZRaxjj74tcfrNy/XUJ0J7YwGprWgpC95qogJV7YzodFEgy4d8HVADHWLVl0iM115mWghJX0gcvsPDRK0mgzuOW/CgUiyVLWxBcMi8TjIzfd3HR3qRSBWX6LdnghMw6TlI0AAigXj7YLDns4MSfml4pTYxYHgVfWttGcpKvcxy7lpcUhDAchvyQ03urIlarLf2C4YtQXeZBylNkOBPd8HrMRONBZwvthbu434e4hyNbyKQk8oIZLmZ/WL/nB04m+QD8ilqqCyQKS2Zf/z/LXpTIWkbWlfE+LVBE6Y0JJ2Kws7jIJ0cl79n2sd/UoF14N7PFvpwCqyWPzecSDNwBOD9lMvS4YuhykwyRX4Iery3mpEltINdAZIXR5Bt7Aal3gxQVf/1qGAxalelKuEuuAn4QzejqIC0Z+mg/8tHHVHhk83rFAkpgifpXf4bNpWh7YSGzIC5RZhFAIYvE1vieJ35hlbYjlmweoL1YrLEXA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(30864003)(83380400001)(52116002)(38100700002)(86362001)(44832011)(36756003)(5660300002)(1076003)(2616005)(6506007)(508600001)(6666004)(66946007)(66556008)(66476007)(186003)(8676002)(316002)(107886003)(6486002)(2906002)(8936002)(4326008)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?8LQLKILHjO1LkFhCa3dYMw8bDb1uKwi+OdWTedgTsVsLezRnexjwfjfWdI3q?=
 =?us-ascii?Q?0qWiPtETi6h78+VRfA5YHJkZhGpUDIUYo9ZsUHVK3cBuweQ8aYu2OQkdRcFZ?=
 =?us-ascii?Q?hjrMgnnN4KUXSbRN4rDxCvgvpe4nhsUl7NzAaEybjI9sy8eycW13rCIUNB02?=
 =?us-ascii?Q?sD/5Jke44WZDX8pIZ+mjZX9vNgzdDZTecmqTTv10sbegWc+9mqYfotna3H1c?=
 =?us-ascii?Q?jPMKrk4r8sr6dRGN51GhP74EuZ8WdckSth+l+ttLfzG2bZoHcgkf9Xs6S7IM?=
 =?us-ascii?Q?WHRlxdEFHXo9PNfPOredNWwCT76TUV4eVgJGPpYUS6CuilODuGlbVoyK74Ye?=
 =?us-ascii?Q?DyXIV1ObgGWU+i2zbKMbilyNwZIQkYEFfP67gzGsoaQ53ds7obsEA1YjoQf2?=
 =?us-ascii?Q?kubq6sJOKKm+a6onLs8mIbq0Q5RM/xd8SrFZVoWbtollwIhaSxj/zqVeH6SE?=
 =?us-ascii?Q?VIzklk8RsUd4Ow9tKA/S/b9q7CM5ZQIrCrDv/9xUyt5THF1kMbh8dMafNND2?=
 =?us-ascii?Q?dknUtYbov2fIY7pPZ3gvM9S+/MFICGE2Z8bYme6uBnPkdwrsFf9zDF20862H?=
 =?us-ascii?Q?3q5vI4LnBBw4T5u3PPfHaejG/HotesX7vxcjHVw3XJg0vAEGn32wzMnMBxHq?=
 =?us-ascii?Q?toZBVOAb9fjZrveJIoFrYDra4rkC4nMnn9WpTMdr9kz1zLapebTlqvLlF4QV?=
 =?us-ascii?Q?sydPGxLROwWWSU6O/9xJOGG/h9WsBA3NunJOzUcLr/Yp6jzzvxC9P3LX7jYM?=
 =?us-ascii?Q?p1IaZF5jspj18G6QiSCCegWAbGywD8hPNu2CjkmO7j+qzqtkIMmFIKN8exct?=
 =?us-ascii?Q?RAIRf9HiyXYywc2GXBNYEIFEHrtclfMSszQQcFAM/nDHMPYd4DvbYOvGGqHM?=
 =?us-ascii?Q?V46Uu2e+eFggD7+vzVbxflA1RMvIysvP8PzLEja3J92xwqABM4608+flRKCY?=
 =?us-ascii?Q?09gtQ/Yc+RfB7t2zcBLYLD1Dp8HGIsBgQVphwO3oIF4uj23/CWlIEmJxIyA9?=
 =?us-ascii?Q?U+Mi6fQ3qdu9ieXnTlclmcOuHgrf607J95C3xkhasn8d3fOMlzqTmlJ3U3ui?=
 =?us-ascii?Q?qvXSU1VQEEvBOM6EAaXJwE5aw0+8VAVpl7em7oRtZ2JRRT3Yv8DdFsUTaAM6?=
 =?us-ascii?Q?xtycKoompP4molvucCMA9MemPZXRa/FsJMsAoiCfMmFMMr6QbZ7qBlMg4Ba2?=
 =?us-ascii?Q?oP3fKNEnjmndf8CXD0CJPeyFJH5msoJsZqDAowQHz2fn6mYlF17bh/grOpiz?=
 =?us-ascii?Q?6BDGEpYp7Ek6nqHGtEg55RcnDo6Fy3Q8cEST2YKl9bhrVD5ezflWrlOdJ5Cp?=
 =?us-ascii?Q?i0IYFooZ5AjsLMgykAAyfJ4F5uWPoUapyau4/GQlCAa14+9/cfUe+k6tuPHK?=
 =?us-ascii?Q?q8AjuBSvqLw7dVYnp7nFwoCDcSY8yDjoHEMXvRjPfdaIJG4ZY5eNUDeo2lxZ?=
 =?us-ascii?Q?klBZ3NzbYFmmNRuR2IpRm56Wa74wYZTcxcszYBYowWSm0jhBECOW1v7g5UEh?=
 =?us-ascii?Q?+zsV0PXijMekVC8aOXRqhSbzcfTU8X4rqqmuMyBid6UnYyRecJPu7xxY13HU?=
 =?us-ascii?Q?IWVcU7B8OQkdddFQs+nBC9hHUphhvd7x/kFwMzCg6gb26K/4ez3MEIz6WjYg?=
 =?us-ascii?Q?z+DNrqf42vTCT5pCXw/I78rf5FUAOauQMggjRFDpWtAL?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 6869f345-4186-4796-7b1b-08d9c0d167ba
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Dec 2021 20:19:47.2650
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zUVFhKRcU9NmCzMkHXmW+AkbvtU9tp2Joe7Pp4LUlh9BVVPz+Ug5VqneHErzaPI/MUEMm7NN2XegTTT9Ra0riQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2541
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10200 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 phishscore=0
 spamscore=0 mlxscore=0 adultscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2110150000 definitions=main-2112160110
X-Proofpoint-ORIG-GUID: kLEfeXDOHXpXq6ONlCRyl_Atn400M47b
X-Proofpoint-GUID: kLEfeXDOHXpXq6ONlCRyl_Atn400M47b
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

/proc/kallsyms is very useful for tracers and other tools that need to
map kernel symbols to addresses.

It would be useful if there were a mapping between kernel symbol and module
name that only changed when the kernel source code is changed.  This mapping
should not change simply because a module becomes built into the kernel, so
that it's not broken by changes in user configuration.  (DTrace for Linux
already uses the approach in this patch for this purpose.)

It might also be useful if there were reliable symbol size information to
determine whether an address is within a symbol or outside it, especially
given that there could be huge gaps between symbols.

Fix this by introducing a new config parameter CONFIG_KALLMODSYMS, which
when set results in output in /proc/kallmodsyms that looks like this:

ffffffff8b013d20 409 t pt_buffer_setup_aux
ffffffff8b014130 11f T intel_pt_interrupt
ffffffff8b014250 2d T cpu_emergency_stop_pt
ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]

This is emitted even if intel_rapl_perf is built into the kernel.

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 ab t handle_timestamp  [liquidio]
ffffffffa22b3b50 4a t free_netbuf       [liquidio]
ffffffffa22b3ba0 8d t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 b3 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 203 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 16b t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 1f t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 1f t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 d2 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 9c t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 11 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 11 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 2b t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 738 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 368 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 37 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 18 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 2e t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 69 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 92 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 175 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 ab t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 4a t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 2b t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 7e t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Much more detail and information on the (nearly nonexistent) memory usage
impact below.


We have to do several things to make this work, to figure out which
object files are in which modules, then which address ranges correspond
to these object files, then turn this into per-symbol output.

First, generate a file "modules_thick.builtin" that maps from the thin
archives that make up built-in modules to their constituent object files.
(This reintroduces the machinery that used to be used to generate
modules.builtin.  I am not wedded to this mechanism: if someone can figure
out a mechanism that does not require recursing over the entire build tree,
I'm happy to use it, but I suspect that no such mechanism exists, since the
only place the mapping from object file to module exists is in the makefiles
themselves.  Regardless, this is fairly cheap, adding less than a second to
a typical hot-cache build of a large enterprise kernel.  This is true even
though it needs to be run unconditionally whenever the .config changes.)

Generate a linker map ".tmp_vmlinux.map", converting it into a new file
".tmp_vmlinux.ranges", mapping address ranges to object files.

Have scripts/kallsyms read these two new files to map symbol addresses
to built-in-module names and then write a mapping from object file
address to module name to the *.s output file.

The mapping consists of three new symbols:

 - kallsyms_module_addresses/kallsyms_module_offsets encodes the
   address/offset of each object file (derived from the linker map), in
   exactly the same way as kallsyms_addresses/kallsyms_offsets does
   for symbols.  There is no size: instead, the object files are
   assumed to tile the address space.  (This is slightly more
   space-efficient than using a size).  Non-text-section addresses are
   skipped: for now, all the users of this interface only need
   module/non-module information for instruction pointer addresses, not
   absolute-addressed symbols and the like.  This restriction can
   easily be lifted in future.  (For why this isn't called
   kallsyms_objfiles, see two entries below.)

 - kallsyms_module_names encodes the name of each module in a modified
   form of strtab: notably, if an object file appears in *multiple*
   modules, all of which are built in, this is encoded via a zero byte,
   a one-byte module count, then a series of that many null-terminated
   strings.  Object files which appear in only one module in such a
   multi-module list are redirected to point inside that list, so that
   modules which contain some object files shared with other modules
   and some object files exclusive to them do not double up the module
   name.  (There might still be some duplication between multiple
   multi-module lists, but this is an extremely marginal size effect,
   and resolving it would require an extra layer of lookup tables which
   would be even more complex, and incompressible to boot).  As a
   special case, the table starts with a single zero byte which does
   *not* represent the start of a multi-module list.

 - kallsyms_modules connects the two, encoding a table associated 1:1
   with kallsyms_module_addresses / kallsyms_module_offsets, pointing
   at an offset in kallsyms_module_names describing which module (or
   modules, for a multi-module list) the code occupying this address
   range is part of.  If an address range is part of no module (always
   built-in) it points at 0 (the null byte at the start of the
   kallsyms_module_names list).  Entries in this list that would
   contain the same value are fused together, along with their
   corresponding kallsyms_module_addresses/offsets entries.  Due to
   this fusion process, and because object files can be split apart into
   multiple parts by the linker for hot/cold partitioning and the like,
   entries in here do not really correspond to an object file, but more
   to some contiguous range of addresses which are guaranteed to belong
   to a single built-in module: so it seems best to call the symbols
   kallsyms_modules*.  (The generator has a data structure that does
   correspond more closely to object files, from which kallsyms_modules
   is generated, and that does use 'objfiles' terminology.)

Emit a new /proc/kallmodsyms file akin to /proc/kallsyms but with built-in
module names, using a new kallsyms_builtin_module_address() almost identical
to kallsyms_sym_address() to get the address corresponding to a given
.kallsyms_modules index, and a new get_builtin_module_idx quite similar to
get_symbol_pos to determine the index in the .kallsyms_modules array that
relates to a given address.  Save a little time by exploiting the fact that
all callers will only ever traverse this list from start to end by allowing
them to pass in the previous index returned from this function as a hint:
thus very few bsearches are actually needed.  (In theory this could change
to just walk straight down kallsyms_module_addresses/offsets and not bother
bsearching at all, but doing it this way is hardly any slower and much more
robust.)

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

Those symbols that come from object files that are genuinely reused and
that appear only once in meory get a /proc/kallmodsyms line with
[multiple] [modules] on it: consumers will have to be ready to handle
such lines.

Also, kernel symbols for built-in modules will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am open to changing the name and/or format of /proc/kallmodsyms, but felt
it best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.  Another possible syntax might be to use {curly brackets}
or something to denote built-in modules: it might be possible to drop
/proc/kallmodsyms and make /proc/kallsyms emit things in this format.
(Equally, now kallmodsyms data uses very little space, the
CONFIG_KALLMODSYMS config option might be something people don't want to
bother with.)


The size impact of all of this is minimal: for the case above, the
kallsyms2.S file went from 14107772 to 14137245 bytes, a gain of 29743
bytes, or 0.16%: vmlinux gained 10824 bytes, a gain of .017%, and the
compressed vmlinux only 7552 bytes, a gain of .08%: though the latter two
values are very configuration-dependent, they seem likely to scale roughly
with the kernel they are part of.


The last patch is an RFC to see if the idea is considered to be worth
spending more time optimizing the representation, which adds a new
kallsyms_sizes section that gives the size of each symbol, and uses this
info to report reliable symbol sizes to in-kernel users, and (via a new
column in /proc/kallmodsyms) to out-of-kernel users too.  Having reliable
size info lets us identify inter-symbol gaps and sort symbols so that
start/end-marker and overlapping symbols are consistently ordered with
respect to the symbols they overlap.  This certainly uses too much space
right now, 200KiB--1MiB: a better representation is certainly needed.  One
that springs to mind is making the table sparse (pairs of symbol
index/size), and recording explicit sizes only for those symbols that
are not immediately followed by a subsequent symbol.

Differences from v6, November:

 - Adjust for rewrite of confdata machinery in v5.16 (tristate.conf
   handling is now more of a rewrite than a reversion)

Differences from v5, October:

 - Fix generation of mapfiles under UML

Differences from v4, September:

 - Fix building of tristate.conf if missing (usually concealed by the
   syncconfig being run for other reasons, but not always: the kernel
   test robot spotted it).
 - Forward-port atop v5.15-rc3.

Differences from v3, August:

 - Fix a kernel test robot warning in get_ksymbol_core (possible
   use of uninitialized variable if kallmodsyms was wanted but
   kallsyms_module_offsets was not present, which is most unlikely).

Differences from v2, June:

 - Split the series up.  In particular, the size impact of the table
   optimizer is now quantified, and the symbol-size patch is split out and
   turned into an RFC patch, with the /proc/kallmodsyms format before that
   patch lacking a size column.  Some speculation on how to make the symbol
   sizes less space-wasteful is added (but not yet implemented).

 - Drop a couple of unnecessary #includes, one unnecessarily exported
   symbol, and a needless de-staticing.

Differences from v1, a year or so back:

 - Move from a straight symbol->module name mapping to a mapping from
   address-range to TU to module name list, bringing major space savings
   over the previous approach and support for object files used by many
   built-in modules at the same time, at the cost of a slightly more complex
   approach (unavoidably so, I think, given that we have to merge three data
   sources together: the link map in .tmp_vmlinux.ranges, the nm output on
   stdin, and the mapping from TU name to module names in
   modules_thick.builtin).

   We do opportunistic merging of TUs if they cite the same modules and
   reuse module names where doing so is simple: see optimize_obj2mod
   below. I considered more extensive searches for mergeable entries and
   more intricate encodings of the module name list allowing TUs that are
   used by overlapping sets of modules to share their names, but such
   modules are rare enough (and such overlapping sharings are vanishingly
   rare) that it seemed likely to save only a few bytes at the cost of much
   more hard-to-test code. This is doubly true now that the tables needed
   are only a few kilobytes in length.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Signed-off-by: Eugene Loh <eugene.loh@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>

Nick Alcock (7):
  kbuild: bring back tristate.conf
  kbuild: add modules_thick.builtin
  kbuild: generate an address ranges map at vmlinux link time
  kallsyms: introduce sections needed to map symbols to built-in modules
  kallsyms: optimize .kallsyms_modules*
  kallsyms: add /proc/kallmodsyms
  kallsyms: add reliable symbol size info

 .gitignore                       |   1 +
 Documentation/dontdiff           |   1 +
 Documentation/kbuild/kconfig.rst |   5 +
 Makefile                         |  23 +-
 include/linux/module.h           |   7 +-
 init/Kconfig                     |   8 +
 kernel/kallsyms.c                | 304 ++++++++++++---
 kernel/module.c                  |   4 +-
 scripts/Kbuild.include           |   6 +
 scripts/Makefile                 |   6 +
 scripts/Makefile.modbuiltin      |  56 +++
 scripts/kallsyms.c               | 642 ++++++++++++++++++++++++++++++-
 scripts/kconfig/confdata.c       |  36 +-
 scripts/link-vmlinux.sh          |  22 +-
 scripts/modules_thick.c          | 200 ++++++++++
 scripts/modules_thick.h          |  48 +++
 16 files changed, 1298 insertions(+), 71 deletions(-)
 create mode 100644 scripts/Makefile.modbuiltin
 create mode 100644 scripts/modules_thick.c
 create mode 100644 scripts/modules_thick.h

-- 
2.34.0.258.gc900572c39

