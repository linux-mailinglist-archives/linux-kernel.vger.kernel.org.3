Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D49974AE142
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:45:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385141AbiBHSpW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:45:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385316AbiBHSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:45:07 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A01BDC061579;
        Tue,  8 Feb 2022 10:45:05 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218Gc5sx007554;
        Tue, 8 Feb 2022 18:44:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references :
 content-transfer-encoding : content-type : mime-version;
 s=corp-2021-07-09; bh=zl9h5yFVb16A6YpCHkr2/0ZLlLOzGaX9YEC8I1bEPGU=;
 b=sl7BzRHO3E1FZ7EJYQ7rPXLFYUO61WCjdLoAUbwkoNXV4exNkoRwV/J0se7Lp0ZVpuOs
 dM4mtBP0fZ0kvg5Aa+1qhd96wTavp0zFpruI2cObvApUnukIt7EQLLINaoCEgUTM4MjJ
 iImY7n3sz7Cj56Tvvt5LiJVbzF1Obfwx5i4LZoaEn/aZ3dEhugBq21xDDRhqvMEz6Mz6
 pg/qQI3Sub4RxuShpv7cTRmQ2PgUvLHBEbY/lSmkoTzzv3yG37vfykxeNRSdAmYKlObi
 q/Ep8SQZkxXUmDjDJzHctJgoXWN43IN7mjjSxMRPyHGwX+40P55+sVggQaQvD7AMUsIo uA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368tunkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:36 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218IZnee037383;
        Tue, 8 Feb 2022 18:44:25 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2046.outbound.protection.outlook.com [104.47.56.46])
        by userp3030.oracle.com with ESMTP id 3e1ec0w7q1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:24 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FDh3X4wLz9QDZAM6lCaRg5kPVQjPgI5hE+X3SssM48RpSsnQL3l6hagWbeWX/WYwcWNP59toVWPIe6Hizlv8YXNJg7YtC42bjDYMxyjs2gBTLMxDQ6xNC/IBSDWQGcDF1sXBFd+fFZiyIO7h/HtYvvHYuO1MOJTr5KXHXwAUYb2wjQ5FpzfzbVLcsRHntFXPOYJrOtMja7UMzxafty0iDcYRymqSRjS8bj+BC6paGaFBRvG41tub7NAcGUOIpncK4eSYtAYlsC0GZI+ELZJQb9p0YH9ubdQwPSn4EwEWbQQt62MIJiaDYs2DuTXBwIR8X+bgWEm7vL813N3/zHwPzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl9h5yFVb16A6YpCHkr2/0ZLlLOzGaX9YEC8I1bEPGU=;
 b=oR/n/+NG9LqQysH/zHe+85qErmYdtOP3d32QVs0LEYSHeYHr8z8uc7s7o8BkW4JXar7Otu7iJaw1eZRGO9MKdJ2y01616FE2DE97rMrSi8roFgys1fuYgrJWizmkhw8y14xq8TB14y7anvwP0k18Txn/ftcGIXjUDgXYZV56IHe+6FL9pgbe6brfpWg0kN5qEy/Af7Lb85hpHb6zguIceeMJ21C6nl2CdlO/hyVhqj4IfdiIoXrhUffKml3vWo+0eUhyUzjdILBJKpUYDB1MyBTuTjBk064qapzcP/yfRa+v3zV3/XlE8YOjnOr5rn61U4atxR1CC821oW1gNyOG0g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl9h5yFVb16A6YpCHkr2/0ZLlLOzGaX9YEC8I1bEPGU=;
 b=sWb+biYMNkdksP2Q0Ctnhfd+CVJxW62zuYJkn6oumH/pPASy/g3FmPnVSpg8B/Vjtg51bt97mrCB+C+LmpBGDnEHxhDt+ukT2loZRmT5dEVkc31Tr3RmNTllADszkPHyxxt+MYtazjkxZpHnzvO2mP7RkwUjZEmln1NBOaltdEU=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 8 Feb
 2022 18:44:22 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 18:44:22 +0000
From:   Nick Alcock <nick.alcock@oracle.com>
To:     mcgrof@kernel.org, masahiroy@kernel.org
Cc:     jolsa@kernel.org, rostedt@goodmis.org, bas@baslab.org,
        tglozar@gmail.com, Ast-x64@protonmail.com, viktor.malik@gmail.com,
        dxu@dxuuu.xyz, acme@kernel.org, adrian.hunter@intel.com,
        ak@linux.intel.com, irogers@google.com,
        linux-kbuild@vger.kernel.org, linux-modules@vger.kernel.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de,
        akpm@linux-foundation.org, eugene.loh@oracle.com,
        kris.van.hees@oracle.com
Subject: [PATCH v8 6/6] kallsyms: add /proc/kallmodsyms
Date:   Tue,  8 Feb 2022 18:43:09 +0000
Message-Id: <20220208184309.148192-7-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.35.0.260.gb82b153193.dirty
In-Reply-To: <20220208184309.148192-1-nick.alcock@oracle.com>
References: <20220208184309.148192-1-nick.alcock@oracle.com>
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::21) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 08ee111a-7561-42e4-ff61-08d9eb3305c0
X-MS-TrafficTypeDiagnostic: SA1PR10MB5781:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB57814499F129EBDA17974B3C8B2D9@SA1PR10MB5781.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5516;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KTU94OIXTuDk0Sqv+MOJoVv4HpArkaVyXfNnG+Bq0SQakJFVe1ARMxqiv1uMK7aUpM2EdI45Ek0tm3mA0g+/sBWpOb1TxuvTA8lXjhtCh/B4uviqHX8yvGcWU3zL6ZVCbKSfH8z5Kuxbmlg7KI8jLvR3BRjq2Z206k89CO0sk7ZHTvrUBry6CMNfDRzRhatPcH7wm6eB4nLe8VwcmHA7GGlbETHiTigmTm4XflmvrtOV+Q9KOFu3vo6DcyZ6dgE8rgjXmdeId8HUA/8Q929xFrYcakOG+h2cjIuhTadPw7VKwy09Q58zEBYXU2bBSgQPPWD5RtSrC/UNpVKUktETInr9exfq+E0OXbn0N4OgyU81qm0s1HVJBhAN+vnvElJraOk0LjanzDtuB/n2BW3patb9webLmZlGGXd1KS0IetyWhpzzrtIcWAHbTnclj0VHWjmkVVxPuVFzuK9bve6nNOnKcqBpQsLhrISLwHUofjov2Jtbu4jd8wEtClQsUuplUdANJk9/tFQCAlgdjKNHTnl90fk6vwROhQklXpHS8Yc8O1TGVy+vlGWQy/SxdT21yZVtFwonFPOW1jBIKxn5JVLQIgivdX98Y88sKEMO4jii1wVamny2x5Fl6OMsBwsDj0RqSjyOLkVLLcji0WVNDg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(86362001)(6486002)(36756003)(52116002)(5660300002)(6512007)(30864003)(1076003)(508600001)(6506007)(7416002)(186003)(6666004)(8676002)(44832011)(66556008)(316002)(2906002)(8936002)(66476007)(4326008)(2616005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?bNjbeyDPdaG+XIqhaaulZxE9JFWuOkpoTreftO9bZlWLffxXo+oeg0pCKMOA?=
 =?us-ascii?Q?j/DZ9doe2o+5EyD5qcYRQVwSn8V7mfJ+G7yfQpsrVPVLy+mh6mRGN2HEW6XP?=
 =?us-ascii?Q?48xl70EFp7CurGyMOHov32aJwYTVAhUFUrUgPGFiwl7aU7W+bdrFGho0Qsgf?=
 =?us-ascii?Q?vcOEZ2awPtC/gErKIWw/qrTvTDnnEjlf3JUvrq+uN36w4LP6rFIBbTkHp27i?=
 =?us-ascii?Q?Hh8wME0NMYhfuwTK1gOXZ97/h9DohdKr6yt+o0IDbJmsQ+PJCchbfv9xg53z?=
 =?us-ascii?Q?mIdVB43r2fvky9fcGTb1EtxtJrpF3QRXEqqZGckV3h3K2k/SFSKphKJ46dT0?=
 =?us-ascii?Q?WmVIcyYoNr6nJh1JdYCl1PPbKv0dVex/XNmj+nD5wfsg5IWCye5MN6ACVaRG?=
 =?us-ascii?Q?3+5+jJl2F7KSwlucv/D56z44kqLS5d5A7PWpO3U+REPgb/BdchohV1rSps/Q?=
 =?us-ascii?Q?/9jNmr/uHY+DaAZxbc6LSpl1MtKMeG6IpWk8k5R/BAiypw898eAS2bSNSuF+?=
 =?us-ascii?Q?/Cv0zPEbIPlWl4PpbDvvB7+xAX9HQaGWHalKv1klPtDqTrJYjnlbTz53LmGR?=
 =?us-ascii?Q?Dj6Ll16sH05MmBW4/wPF38wZoTwN6Zs+3sGq2qe0BsIWPqq0FYErEQVToXGT?=
 =?us-ascii?Q?LtWGVPVvEzYZvvhXkaYTuavf1h/sSLWAOgluFj7kXzX6YUWpb8/FqWylPIA5?=
 =?us-ascii?Q?RelqwqUYVXK46kbVlCaVsfGusHjAOyu31iYhR/TNMF27NdHySvi3A6mmuIgH?=
 =?us-ascii?Q?PBV5aPYcLFdcF8TGERCwSFwjfRxjF+LZOziVzzfrpo9l4xIdaLBAWE6GhED9?=
 =?us-ascii?Q?+072xEHENgPXlsFWjEXaDf+ZySt/CUVC5fFl+CVH+fL6fqFZ083Ng6JpXiRt?=
 =?us-ascii?Q?p0rpZTzKE7DKGeyTdaaPESoxlfInUUJJ5TdxFVaZ+hzUsH8MPHz6DHoT2R8H?=
 =?us-ascii?Q?/nsFJHPLxhF6ehl6xSQNyRjdwMlvVsTkDF9JwYms+riZ+bEjMwAN1kV4wzs6?=
 =?us-ascii?Q?Lrq0ZC9brJYglfsFEDIt8RLY2IAHIvfrhmHXme8Q65EohPK35XHHKusheVzx?=
 =?us-ascii?Q?vGj+XkewmkZA8m66xeELk8OfWF64te2upatnuzaZxR3yP8R3mOIiuPxXAKFX?=
 =?us-ascii?Q?0jRdZMGI9CEZNvlI/voJcySs6+yHk07oYXegOIdJr1oUAK765+bPiBCbBtiy?=
 =?us-ascii?Q?5yqcBfBcO53tddSDgIlGQPwrZlmhW4ozRRhtbn97YddCo5/Y4o2cN6gqJxeY?=
 =?us-ascii?Q?9vUysFTkdOhQAc63dzyUcFHaEAdD6kjd1UR6SpQH2/K0W555hY5tcim3m7PK?=
 =?us-ascii?Q?R3VMacmN3MxdUHgRgWcXusX/Yq/hi70R+VIrsu/KyX7stMMJ69Ktok6MYifF?=
 =?us-ascii?Q?CDe/+VQ451PS49qv5NPT38YCNhZ+W/hsfiWzg0QbhpIrLnK07DRzfQ+2BMMK?=
 =?us-ascii?Q?JtcqEX4FQ2WbmOaZ/h6Kk331/2EbBai6k8OQFdnCsZac+MPI8hW/jXjCN0Oz?=
 =?us-ascii?Q?ZKmT8SGYQWaP9zQDw8Kf1Eug2wCFz87DaQ0sEaZwS3C6dzq7AGZWhbZ08piu?=
 =?us-ascii?Q?UTfe7XKgKzB0MvOrGSLpvZ6JORhdwprIWSF4e4hMDPqTvDJSoHOzxyGjsmBd?=
 =?us-ascii?Q?AHWikBIhPrPp1YH3jkytiYKOvZh30WWBM3Sfm3ybYx/4?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 08ee111a-7561-42e4-ff61-08d9eb3305c0
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:44:22.3279
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bL7hXx7i8aoidHI/MvoM8sjeh8YrMWwOU7Owjv4I0JhrpLvytJXpg5zHUPZfO7m3JSexMNtSqPvNtj+B1Us+jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080109
X-Proofpoint-ORIG-GUID: rdLo2xVeQ2yXh-q3l9LYzyahEODQNAuy
X-Proofpoint-GUID: rdLo2xVeQ2yXh-q3l9LYzyahEODQNAuy
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use the tables added in the previous commits to introduce a new
/proc/kallmodsyms, in which [module names] are also given for things
that *could* have been modular had they not been built in to the kernel.
So symbols that are part of, say, ext4 are reported as [ext4] even if
ext4 happens to be buiilt in to the kernel in this configuration.

Symbols that are part of multiple modules at the same time are shown
with [multiple] [module names]: consumers will have to be ready to
handle such lines.  Also, kernel symbols for built-in modules will be
sorted by size, as usual for the core kernel, so will probably appear
interspersed with other symbols that are part of different modules and
non-modular always-built-in symbols, which, as usual, have no
square-bracketed module denotation.  This differs from /proc/kallsyms,
where all symbols associated with a module will always appear in a group
(and randomly ordered).

The result looks like this:

ffffffff8b013d20 t pt_buffer_setup_aux
ffffffff8b014130 T intel_pt_interrupt
ffffffff8b014250 T cpu_emergency_stop_pt
ffffffff8b014280 t rapl_pmu_event_init      [intel_rapl_perf]
ffffffff8b0143c0 t rapl_event_update [intel_rapl_perf]
ffffffff8b014480 t rapl_pmu_event_read       [intel_rapl_perf]
ffffffff8b014490 t rapl_cpu_offline  [intel_rapl_perf]
ffffffff8b014540 t __rapl_event_show [intel_rapl_perf]
ffffffff8b014570 t rapl_pmu_event_stop       [intel_rapl_perf]

This is emitted even if intel_rapl_perf is built into the kernel (but,
obviously, not if it's not in the .config at all, or is in a module that
is not loaded).

Further down, we see what happens when object files are reused by
multiple modules, all of which are built in to the kernel:

ffffffffa22b3aa0 t handle_timestamp  [liquidio]
ffffffffa22b3b50 t free_netbuf       [liquidio]
ffffffffa22b3ba0 t liquidio_ptp_settime      [liquidio]
ffffffffa22b3c30 t liquidio_ptp_adjfreq      [liquidio]
[...]
ffffffffa22b9490 t lio_vf_rep_create        [liquidio]
ffffffffa22b96a0 t lio_vf_rep_destroy       [liquidio]
ffffffffa22b9810 t lio_vf_rep_modinit        [liquidio]
ffffffffa22b9830 t lio_vf_rep_modexit        [liquidio]
ffffffffa22b9850 t lio_ethtool_get_channels   [liquidio] [liquidio_vf]
ffffffffa22b9930 t lio_ethtool_get_ringparam  [liquidio] [liquidio_vf]
ffffffffa22b99d0 t lio_get_msglevel   [liquidio] [liquidio_vf]
ffffffffa22b99f0 t lio_vf_set_msglevel        [liquidio] [liquidio_vf]
ffffffffa22b9a10 t lio_get_pauseparam         [liquidio] [liquidio_vf]
ffffffffa22b9a40 t lio_get_ethtool_stats     [liquidio] [liquidio_vf]
ffffffffa22ba180 t lio_vf_get_ethtool_stats  [liquidio] [liquidio_vf]
ffffffffa22ba4f0 t lio_get_regs_len   [liquidio] [liquidio_vf]
ffffffffa22ba530 t lio_get_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba550 t lio_set_priv_flags         [liquidio] [liquidio_vf]
ffffffffa22ba580 t lio_set_fecparam   [liquidio] [liquidio_vf]
ffffffffa22ba5f0 t lio_get_fecparam   [liquidio] [liquidio_vf]
[...]
ffffffffa22cbd10 t liquidio_set_mac [liquidio_vf]
ffffffffa22cbe90 t handle_timestamp  [liquidio_vf]
ffffffffa22cbf40 t free_netbuf       [liquidio_vf]
ffffffffa22cbf90 t octnet_link_status_change [liquidio_vf]
ffffffffa22cbfc0 t liquidio_vxlan_port_command.constprop.0   [liquidio_vf]

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

As with /proc/kallsyms, non-root usage produces addresses that are
all zero.

I am not wedded to the name or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing
kallsyms parsers.  Another possible syntax might be to use {curly
brackets} or something to denote built-in modules: it might be possible
to drop /proc/kallmodsyms and make /proc/kallsyms emit things in this
format.  (Equally, now kallmodsyms data uses very little space, the
CONFIG_KALLMODSYMS config option might be something people don't want to
bother with.)

Internally, this uses a new kallsyms_builtin_module_address() almost
identical to kallsyms_sym_address() to get the address corresponding to
a given .kallsyms_modules index, and a new get_builtin_module_idx quite
similar to get_symbol_pos to determine the index in the
.kallsyms_modules array that relates to a given address.  Save a little
time by exploiting the fact that all callers will only ever traverse
this list from start to end by allowing them to pass in the previous
index returned from this function as a hint: thus very few bsearches are
actually needed.  (In theory this could change to just walk straight
down kallsyms_module_addresses/offsets and not bother bsearching at all,
but doing it this way is hardly any slower and much more robust.)

We explicitly filter out displaying modules for non-text symbols and
section start/end symbols, because the former appear in distinct ranges
which are not covered by the linker-generated ranges and the latter
appear as text symbols and can share an address with built-in module
symbols, but are not part of those modules.

The display process is complicated a little by the weird format of the
.kallsyms_module_names table: we have to look for multimodule entries
and print them as space-separated lists of module names.

Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
Reviewed-by: Kris Van Hees <kris.van.hees@oracle.com>
---
 kernel/kallsyms.c | 245 +++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 230 insertions(+), 15 deletions(-)

diff --git a/kernel/kallsyms.c b/kernel/kallsyms.c
index 951c93216fc4..31469565967e 100644
--- a/kernel/kallsyms.c
+++ b/kernel/kallsyms.c
@@ -48,8 +48,18 @@ __section(".rodata") __attribute__((weak));
 extern const unsigned long kallsyms_relative_base
 __section(".rodata") __attribute__((weak));
 
+extern const unsigned long kallsyms_num_modules
+__section(".rodata") __attribute__((weak));
+
+extern const unsigned long kallsyms_module_names_len
+__section(".rodata") __attribute__((weak));
+
 extern const char kallsyms_token_table[] __weak;
 extern const u16 kallsyms_token_index[] __weak;
+extern const unsigned long kallsyms_module_addresses[] __weak;
+extern const int kallsyms_module_offsets[] __weak;
+extern const u32 kallsyms_modules[] __weak;
+extern const char kallsyms_module_names[] __weak;
 
 extern const unsigned int kallsyms_markers[] __weak;
 
@@ -205,6 +215,25 @@ static bool cleanup_symbol_name(char *s)
 	return false;
 }
 
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long kallsyms_builtin_module_address(int idx)
+{
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		return kallsyms_module_addresses[idx];
+
+	/* values are unsigned offsets if --absolute-percpu is not in effect */
+	if (!IS_ENABLED(CONFIG_KALLSYMS_ABSOLUTE_PERCPU))
+		return kallsyms_relative_base + (u32)kallsyms_module_offsets[idx];
+
+	/* ...otherwise, positive offsets are absolute values */
+	if (kallsyms_module_offsets[idx] >= 0)
+		return kallsyms_module_offsets[idx];
+
+	/* ...and negative offsets are relative to kallsyms_relative_base - 1 */
+	return kallsyms_relative_base - 1 - kallsyms_module_offsets[idx];
+}
+#endif
+
 /* Lookup the address for this symbol. Returns 0 if not found. */
 unsigned long kallsyms_lookup_name(const char *name)
 {
@@ -309,6 +338,54 @@ static unsigned long get_symbol_pos(unsigned long addr,
 	return low;
 }
 
+/*
+ * The caller passes in an address, and we return an index to the corresponding
+ * builtin module index in .kallsyms_modules, or (unsigned long) -1 if none
+ * match.
+ *
+ * The hint_idx, if set, is a hint as to the possible return value, to handle
+ * the common case in which consecutive runs of addresses relate to the same
+ * index.
+ */
+#ifdef CONFIG_KALLMODSYMS
+static unsigned long get_builtin_module_idx(unsigned long addr, unsigned long hint_idx)
+{
+	unsigned long low, high, mid;
+
+	if (!IS_ENABLED(CONFIG_KALLSYMS_BASE_RELATIVE))
+		BUG_ON(!kallsyms_module_addresses);
+	else
+		BUG_ON(!kallsyms_module_offsets);
+
+	/*
+	 * Do a binary search on the sorted kallsyms_modules array.  The last
+	 * entry in this array indicates the end of the text section, not an
+	 * object file.
+	 */
+	low = 0;
+	high = kallsyms_num_modules - 1;
+
+	if (hint_idx > low && hint_idx < (high - 1) &&
+	    addr >= kallsyms_builtin_module_address(hint_idx) &&
+	    addr < kallsyms_builtin_module_address(hint_idx + 1))
+		return hint_idx;
+
+	if (addr >= kallsyms_builtin_module_address(low)
+	    && addr < kallsyms_builtin_module_address(high)) {
+		while (high - low > 1) {
+			mid = low + (high - low) / 2;
+			if (kallsyms_builtin_module_address(mid) <= addr)
+				low = mid;
+			else
+				high = mid;
+		}
+		return low;
+	}
+
+	return (unsigned long) -1;
+}
+#endif
+
 /*
  * Lookup an address but don't bother to find any names.
  */
@@ -580,6 +657,8 @@ struct kallsym_iter {
 	char type;
 	char name[KSYM_NAME_LEN];
 	char module_name[MODULE_NAME_LEN];
+	const char *builtin_module_names;
+	unsigned long hint_builtin_module_idx;
 	int exported;
 	int show_value;
 };
@@ -610,6 +689,8 @@ static int get_ksymbol_mod(struct kallsym_iter *iter)
 				     &iter->value, &iter->type,
 				     iter->name, iter->module_name,
 				     &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_mod_end = iter->pos;
 		return 0;
@@ -629,6 +710,8 @@ static int get_ksymbol_ftrace_mod(struct kallsym_iter *iter)
 					 &iter->value, &iter->type,
 					 iter->name, iter->module_name,
 					 &iter->exported);
+	iter->builtin_module_names = NULL;
+
 	if (ret < 0) {
 		iter->pos_ftrace_mod_end = iter->pos;
 		return 0;
@@ -643,6 +726,7 @@ static int get_ksymbol_bpf(struct kallsym_iter *iter)
 
 	strlcpy(iter->module_name, "bpf", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	ret = bpf_get_kallsym(iter->pos - iter->pos_ftrace_mod_end,
 			      &iter->value, &iter->type,
 			      iter->name);
@@ -663,23 +747,56 @@ static int get_ksymbol_kprobe(struct kallsym_iter *iter)
 {
 	strlcpy(iter->module_name, "__builtin__kprobes", MODULE_NAME_LEN);
 	iter->exported = 0;
+	iter->builtin_module_names = NULL;
 	return kprobe_get_kallsym(iter->pos - iter->pos_bpf_end,
 				  &iter->value, &iter->type,
 				  iter->name) < 0 ? 0 : 1;
 }
 
 /* Returns space to next name. */
-static unsigned long get_ksymbol_core(struct kallsym_iter *iter)
+static unsigned long get_ksymbol_core(struct kallsym_iter *iter, int kallmodsyms)
 {
 	unsigned off = iter->nameoff;
 
-	iter->module_name[0] = '\0';
+	iter->exported = 0;
 	iter->value = kallsyms_sym_address(iter->pos);
 
 	iter->type = kallsyms_get_symbol_type(off);
 
+	iter->module_name[0] = '\0';
+	iter->builtin_module_names = NULL;
+
 	off = kallsyms_expand_symbol(off, iter->name, ARRAY_SIZE(iter->name));
+#ifdef CONFIG_KALLMODSYMS
+	if (kallmodsyms) {
+		unsigned long mod_idx = (unsigned long) -1;
+
+		if (kallsyms_module_offsets)
+			mod_idx =
+			  get_builtin_module_idx(iter->value,
+						 iter->hint_builtin_module_idx);
 
+		/*
+		 * This is a built-in module iff the tables of built-in modules
+		 * (address->module name mappings) and module names are known,
+		 * and if the address was found there, and if the corresponding
+		 * module index is nonzero, and iff this is a text (or weak)
+		 * symbol.  All other cases mean off the end of the binary or in
+		 * a non-modular range in between one or more modules.  (Also
+		 * guard against a corrupt kallsyms_objfiles array pointing off
+		 * the end of kallsyms_modules.)
+		 */
+		if (kallsyms_modules != NULL && kallsyms_module_names != NULL &&
+		    (iter->type == 't' || iter->type == 'T' ||
+		     iter->type == 'w' || iter->type == 'W') &&
+		    mod_idx != (unsigned long) -1 &&
+		    kallsyms_modules[mod_idx] != 0 &&
+		    kallsyms_modules[mod_idx] < kallsyms_module_names_len)
+			iter->builtin_module_names =
+				&kallsyms_module_names[kallsyms_modules[mod_idx]];
+		iter->hint_builtin_module_idx = mod_idx;
+	}
+#endif
 	return off - iter->nameoff;
 }
 
@@ -725,7 +842,7 @@ static int update_iter_mod(struct kallsym_iter *iter, loff_t pos)
 }
 
 /* Returns false if pos at or past end of file. */
-static int update_iter(struct kallsym_iter *iter, loff_t pos)
+static int update_iter(struct kallsym_iter *iter, loff_t pos, int kallmodsyms)
 {
 	/* Module symbols can be accessed randomly. */
 	if (pos >= kallsyms_num_syms)
@@ -735,7 +852,7 @@ static int update_iter(struct kallsym_iter *iter, loff_t pos)
 	if (pos != iter->pos)
 		reset_iter(iter, pos);
 
-	iter->nameoff += get_ksymbol_core(iter);
+	iter->nameoff += get_ksymbol_core(iter, kallmodsyms);
 	iter->pos++;
 
 	return 1;
@@ -745,14 +862,14 @@ static void *s_next(struct seq_file *m, void *p, loff_t *pos)
 {
 	(*pos)++;
 
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return p;
 }
 
 static void *s_start(struct seq_file *m, loff_t *pos)
 {
-	if (!update_iter(m->private, *pos))
+	if (!update_iter(m->private, *pos, 0))
 		return NULL;
 	return m->private;
 }
@@ -761,7 +878,7 @@ static void s_stop(struct seq_file *m, void *p)
 {
 }
 
-static int s_show(struct seq_file *m, void *p)
+static int s_show_internal(struct seq_file *m, void *p, int kallmodsyms)
 {
 	void *value;
 	struct kallsym_iter *iter = m->private;
@@ -772,23 +889,67 @@ static int s_show(struct seq_file *m, void *p)
 
 	value = iter->show_value ? (void *)iter->value : NULL;
 
-	if (iter->module_name[0]) {
+	/*
+	 * Real module, or built-in module and /proc/kallsyms being shown.
+	 */
+	if (iter->module_name[0] != '\0' ||
+	    (iter->builtin_module_names != NULL && kallmodsyms != 0)) {
 		char type;
 
 		/*
-		 * Label it "global" if it is exported,
-		 * "local" if not exported.
+		 * Label it "global" if it is exported, "local" if not exported.
 		 */
 		type = iter->exported ? toupper(iter->type) :
 					tolower(iter->type);
-		seq_printf(m, "%px %c %s\t[%s]\n", value,
-			   type, iter->name, iter->module_name);
+#ifdef CONFIG_KALLMODSYMS
+		if (kallmodsyms) {
+			/*
+			 * /proc/kallmodsyms, built as a module.
+			 */
+			if (iter->builtin_module_names == NULL)
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->module_name);
+			/*
+			 * /proc/kallmodsyms, single-module symbol.
+			 */
+			else if (*iter->builtin_module_names != '\0')
+				seq_printf(m, "%px %c %s\t[%s]\n", value,
+					   type, iter->name,
+					   iter->builtin_module_names);
+			/*
+			 * /proc/kallmodsyms, multimodule symbol.  Formatted
+			 * as \0MODULE_COUNTmodule-1\0module-2\0, where
+			 * MODULE_COUNT is a single byte, 2 or higher.
+			 */
+			else {
+				size_t i = *(char *)(iter->builtin_module_names + 1);
+				const char *walk = iter->builtin_module_names + 2;
+
+				seq_printf(m, "%px %c %s\t[%s]", value,
+					   type, iter->name, walk);
+
+                                while (--i > 0) {
+					walk += strlen(walk) + 1;
+					seq_printf (m, " [%s]", walk);
+				}
+				seq_printf(m, "\n");
+			}
+		} else				/* !kallmodsyms */
+#endif /* CONFIG_KALLMODSYMS */
+			seq_printf(m, "%px %c %s\t[%s]\n", value,
+				   type, iter->name, iter->module_name);
 	} else
 		seq_printf(m, "%px %c %s\n", value,
 			   iter->type, iter->name);
 	return 0;
 }
 
+static int s_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 0);
+}
+
 static const struct seq_operations kallsyms_op = {
 	.start = s_start,
 	.next = s_next,
@@ -796,6 +957,35 @@ static const struct seq_operations kallsyms_op = {
 	.show = s_show
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static int s_mod_show(struct seq_file *m, void *p)
+{
+	return s_show_internal(m, p, 1);
+}
+static void *s_mod_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	(*pos)++;
+
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return p;
+}
+
+static void *s_mod_start(struct seq_file *m, loff_t *pos)
+{
+	if (!update_iter(m->private, *pos, 1))
+		return NULL;
+	return m->private;
+}
+
+static const struct seq_operations kallmodsyms_op = {
+	.start = s_mod_start,
+	.next = s_mod_next,
+	.stop = s_stop,
+	.show = s_mod_show
+};
+#endif
+
 static inline int kallsyms_for_perf(void)
 {
 #ifdef CONFIG_PERF_EVENTS
@@ -831,7 +1021,8 @@ bool kallsyms_show_value(const struct cred *cred)
 	}
 }
 
-static int kallsyms_open(struct inode *inode, struct file *file)
+static int kallsyms_open_internal(struct inode *inode, struct file *file,
+	const struct seq_operations *ops)
 {
 	/*
 	 * We keep iterator in m->private, since normal case is to
@@ -839,7 +1030,7 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	 * using get_symbol_offset for every symbol.
 	 */
 	struct kallsym_iter *iter;
-	iter = __seq_open_private(file, &kallsyms_op, sizeof(*iter));
+	iter = __seq_open_private(file, ops, sizeof(*iter));
 	if (!iter)
 		return -ENOMEM;
 	reset_iter(iter, 0);
@@ -852,6 +1043,18 @@ static int kallsyms_open(struct inode *inode, struct file *file)
 	return 0;
 }
 
+static int kallsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallsyms_op);
+}
+
+#ifdef CONFIG_KALLMODSYMS
+static int kallmodsyms_open(struct inode *inode, struct file *file)
+{
+	return kallsyms_open_internal(inode, file, &kallmodsyms_op);
+}
+#endif
+
 #ifdef	CONFIG_KGDB_KDB
 const char *kdb_walk_kallsyms(loff_t *pos)
 {
@@ -862,7 +1065,7 @@ const char *kdb_walk_kallsyms(loff_t *pos)
 		reset_iter(&kdb_walk_kallsyms_iter, 0);
 	}
 	while (1) {
-		if (!update_iter(&kdb_walk_kallsyms_iter, *pos))
+		if (!update_iter(&kdb_walk_kallsyms_iter, *pos, 0))
 			return NULL;
 		++*pos;
 		/* Some debugging symbols have no name.  Ignore them. */
@@ -879,9 +1082,21 @@ static const struct proc_ops kallsyms_proc_ops = {
 	.proc_release	= seq_release_private,
 };
 
+#ifdef CONFIG_KALLMODSYMS
+static const struct proc_ops kallmodsyms_proc_ops = {
+	.proc_open	= kallmodsyms_open,
+	.proc_read	= seq_read,
+	.proc_lseek	= seq_lseek,
+	.proc_release	= seq_release_private,
+};
+#endif
+
 static int __init kallsyms_init(void)
 {
 	proc_create("kallsyms", 0444, NULL, &kallsyms_proc_ops);
+#ifdef CONFIG_KALLMODSYMS
+	proc_create("kallmodsyms", 0444, NULL, &kallmodsyms_proc_ops);
+#endif
 	return 0;
 }
 device_initcall(kallsyms_init);
-- 
2.35.0.260.gb82b153193.dirty

