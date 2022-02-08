Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EEAC4AE143
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 19:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384973AbiBHSol (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 13:44:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229738AbiBHSoi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 13:44:38 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35360C06157A;
        Tue,  8 Feb 2022 10:44:37 -0800 (PST)
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 218Gc5sj007554;
        Tue, 8 Feb 2022 18:44:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : content-transfer-encoding : content-type :
 mime-version; s=corp-2021-07-09;
 bh=0t+CNKmw+1VmF0EUlt9pPsiBjWZtUY6GotdpBy/VGqI=;
 b=ljCDQXfMolX+X7etxU0zbzIMgp2IrS4cJRUhVcP/hEBWDfylpgCYp0T3SQuffah1Utjr
 wmppZh24jGtHBlYcUlGwt58JhIliarzbrdI3bO3S+Aumb6eCzWO6+8fdp6H0SfRG4UoB
 Klt3PkPj+Dj8d6hU81wGymWfRCyYCdZtNU5daIoKJ/VyueRW0VKy8s5jSCf4Gz4oFAus
 NeJCd1w0p8EtXFoplBE5g9pCBinItaVebA+ZM7H7hij1dpCv5y372bbBOp1Dn4l957K2
 nbYi8Ynr/xJNc0lHzaqpUdtRpfctT1GFfnOh6om9rJ5ID5x76koXBKKSCwW3GNoKENDj Hw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e368tunhx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:04 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 218IZn3i037347;
        Tue, 8 Feb 2022 18:44:03 GMT
Received: from nam02-dm3-obe.outbound.protection.outlook.com (mail-dm3nam07lp2043.outbound.protection.outlook.com [104.47.56.43])
        by userp3030.oracle.com with ESMTP id 3e1ec0w7dj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 08 Feb 2022 18:44:03 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FkDRLXIrvKEh7OvH87E7w+/WVs/x8r3ShL2LCbv5r0Bm9sJunGUTG6nN4ZINA0E2VUKysXSA6FIAeANT4ovZNiAWUmSb/XamJcE8DKkIyPOAIzHUnNP1KwOVxq3Yo1lC0tAuQrvVPem57JdzpOe7Gf4evWQp7rzSkvP61ymKrxv6NFxuVpvOtGbgtQQaiAhI3WpZ4nCkEfMUMqhk+SuXMLLVGXgpt7YcooYTtDg2RZwDL3OIQtplEdLrz0PHY7CUApaD2xPXmyOVrFUfe0oVOmrklPHq6kwqPkpsPfuPps+fz5l4rXkMy1C5e3xP4LaN6WzJ8yDbkmA2QRRCjNHcqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=0t+CNKmw+1VmF0EUlt9pPsiBjWZtUY6GotdpBy/VGqI=;
 b=chKT8H1QaPCgvOTYdwftqo9UV54Db+AtJC8fbfJFk/gGiFzrQ4ccyfzt/4fuUCxL2qwd2QHmjavhvdcMQe4+ZYdOAWx3QS1xAHzqIPWbkpWBdosZ8IZ8DxuXoHBX9hBtG21lu0G7ZUduqmJNL+ER3ZfIZV+7TLeFDmodEHL24tfnC2tUSvZ+v97rkas5OKR6F1Ts3btLHEFS3jA5a40oqwff8+8Ig1NjpzFpFeZv2SaCBEKhnpjIAdVfDBZSQq7rAZcRnB8ETzw70bFy5qwFwcQVVZ0ZYTVwDQIllNWIJdZxYFpNJ3Fp//k1xNdBMh176kZdTWCJhfsEZ1rqI1isXw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=0t+CNKmw+1VmF0EUlt9pPsiBjWZtUY6GotdpBy/VGqI=;
 b=X3oF9yP6A/f7h6CyWskVhr5GxpyCKpW7IK4jOVjV4m9T1xkkYKi2DPuknbZXXlsu+CyxhNrqTx3/W+fIJDy2TG0pxI29J0S6V6JbVST1pwORWgOeevG+R8NW+hKn0n48Vs8fDTuU2XwjDS2Tt/iQDjGUvvK3gJuMMLDWXN/CkmM=
Received: from SA2PR10MB4715.namprd10.prod.outlook.com (2603:10b6:806:fb::10)
 by SA1PR10MB5781.namprd10.prod.outlook.com (2603:10b6:806:23e::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Tue, 8 Feb
 2022 18:44:01 +0000
Received: from SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de]) by SA2PR10MB4715.namprd10.prod.outlook.com
 ([fe80::644e:5828:a72c:c1de%3]) with mapi id 15.20.4951.019; Tue, 8 Feb 2022
 18:44:01 +0000
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
Subject: [PATCH v8] kallsyms: new /proc/kallmodsyms with builtin modules
Date:   Tue,  8 Feb 2022 18:43:03 +0000
Message-Id: <20220208184309.148192-1-nick.alcock@oracle.com>
X-Mailer: git-send-email 2.35.0.260.gb82b153193.dirty
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: LO2P123CA0088.GBRP123.PROD.OUTLOOK.COM
 (2603:10a6:600:138::21) To SA2PR10MB4715.namprd10.prod.outlook.com
 (2603:10b6:806:fb::10)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2c86663c-62b8-4554-3d7b-08d9eb32f911
X-MS-TrafficTypeDiagnostic: SA1PR10MB5781:EE_
X-Microsoft-Antispam-PRVS: <SA1PR10MB578138E669C4BE151B31F2AC8B2D9@SA1PR10MB5781.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KIdqF3WN//l9waHvvfzeq9CNu+ToykOEX/oo6fDY7LEWEEIssI/bWIvRhza1zP51nWaNtjQxb/6KlxyUatMbRS3EwfOise9jft19LEWBWA6FGF3iAPbE/Eeuk6GX1CbbIkUk7lRkmMmt26tzkNE39yRiS5Hgf6VLXZAn2xwPUKjHF4pGxOCtmMZnWxJHASN/GjP/eoRRAPnppZGokZwr1RdL2FbyQMQaqSi/i3Gi5bpCrl+/4D17pRIQIcSOlja8kuItOFui4fg0y62Z4NpE9hg3UIIrFANGR9OrGkNYcfcky0oQPsq4GKxhYhrv7BgzliF3mh6HcyHV6J9Od7Lw7Jrl2uVAYBY6ZfbYek1WVUA6aOwpSh6B3RwRC1GCuNm0Sb/SLhSOubFQdCvWgMqsLEPR7hB45ArRWu4VAroAry/VwDOiE9xVkimeRDwWN85WwLPyGpdT1qrLip12HBJV9J2YhZ9PPhZsS8fNonX6Csc6n0btO8LOIDGNlN3S4568wKPtyZZHeNNbudj0XXgSm46BAslzvk0lDHu/nvKjirCqlv4wFL/nAKvnEhgeq92eAtU8zDISHq4PkdXceYZBxQSujnk37K3iIOWWBA+cv9Cc4a+jHrnSKTyYJMff/7OCjMa22eNhcg7EvofY74EFArx1nknbO8q7u/XhHoADuIbDAIqTneCY8k6GRfkMVUjRQ0y29ytEJVBcu8/gId9/lIr8r1pyezykBnsVBhD15LvtRREsiU/qv8LbrqEwnJqN2tRGFh5Ia/Gti4j4d9GDPQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:SA2PR10MB4715.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(107886003)(86362001)(6486002)(36756003)(52116002)(5660300002)(966005)(6512007)(1076003)(508600001)(6506007)(7416002)(186003)(8676002)(44832011)(66556008)(316002)(2906002)(8936002)(66476007)(4326008)(2616005)(38100700002)(66946007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?hqitmyprbRd9quc+BC9tMIh8e66TbGk5cSGL/fE3FRjfpFAZCtxITwhQsShD?=
 =?us-ascii?Q?wtdbi7z8nm6oREi7soPoOmdNrBMvA9s4izBnb6JUbOq7fa79VgbFUxF7tYao?=
 =?us-ascii?Q?rzqmLqt47pxxQIbg3v72hfdyI8hAZ7Gtf3felKowT2zD4/gd3D13G3wTV9HB?=
 =?us-ascii?Q?yBUfFZikvlcq4kElen/yqVw/Dvd/m0H58Agt6P57/Xwcshhf64/Z+1A8Cpc1?=
 =?us-ascii?Q?MRpQa1ltmtsORf+wuu5VQonup58sqoaQ87h5G48ixgXS5U4TJStpYybvAnMv?=
 =?us-ascii?Q?MadJzwHtHg5lsEshynF6LAd3+6NUGB0Z7abfs2mZMyFV7K7gOAf2AK+3eB8e?=
 =?us-ascii?Q?HW+ODCCopSqMGpovUEFci+TVlt5GSe8qpzltmGUN7V/vp6XCOyzhWPEUEXwm?=
 =?us-ascii?Q?YTFZQyayaw584kJoj2my0dXn5U0XMBQDHv4ePu6GyywbPhfuGoo22dVTd6tQ?=
 =?us-ascii?Q?eOXT2/X3YYXcuno1zJ13AlPJUbcnblgWWSmqIDUQvVRnfKbCO8MJjZ3wkmel?=
 =?us-ascii?Q?ySQncxd7tjYtJLfnmOAFly5dWNaJclMVkN9EWvnU2P87aNXSlpX8B7r4I919?=
 =?us-ascii?Q?oY9KGGr+Ll4IlHziHjxT5Y7CEnhWc+fqvpdc9lMYH+kzo7nbIern15oF92E6?=
 =?us-ascii?Q?PNckW3PP0Hq13rQTgorBos0XQgdDDpx4w2RrHN0iNovqMa3Vn+f0Raexv5PZ?=
 =?us-ascii?Q?PzN5qKniHM8cQfcU3twtaJ5Di9VRismGApUTX2negolLqKN20KH2LGgEf1DP?=
 =?us-ascii?Q?uTRHTOBQ2DdV1pVoq3sEpFKwTQXd4hsQtnOnwYayzCt8QAOrZeO9TZarJpfO?=
 =?us-ascii?Q?OZSpCSJ68sPt17KnErbC0G1mHM340AZZZHyZZJaIL6iXgbTsb4cbmRDcNdZR?=
 =?us-ascii?Q?6XaPAQku5aTBorqHNt88NWsYXaS1ZGrK90bEtB0cIfpOLkjaJTVnpRob8HR8?=
 =?us-ascii?Q?yoAteQDKVb9ppZ3jplvO3vH2ibHlesitgID1tb+6yoJgHQQVr4atL5mzCrBQ?=
 =?us-ascii?Q?CA30YaS2mlQkANcgC0nJydiULx5n6et/Dnd6d2xN+X89c7fcXTZsFakJbbhn?=
 =?us-ascii?Q?hTCjXj+NVmevEEPlLlHSSEAmQmocOxp/+hW5KM3ezStLBucA74V5ctlz48b7?=
 =?us-ascii?Q?DwwhlNooXLNwcz+sXJkceIez5ASQrGLHWyRgfGNKV/q9TsNIX8q5iJNX07Z5?=
 =?us-ascii?Q?VZy6kuPHXD+OX1UkdRztkqjXLCCdmiaR+Urc1w92Jh1KSnUj0lRsONf13KAf?=
 =?us-ascii?Q?eyOtdpxaH6/pJvWQs6MqVb7bmJ3dzWiMpRIL/ZbPYjt1CEdM5fBawbazknPL?=
 =?us-ascii?Q?prn8UR8ACHEGTK6iovrMjtAcKxi5PQI5VKW3ThgRQDpUl+LoyfFjHe9b+nRB?=
 =?us-ascii?Q?Z0U60UgpuPUnzgjV4W1WaMHdm3/Ff5Z1Az+tJQZ+OtjN/2quXAhgTskzyhtx?=
 =?us-ascii?Q?xgxTSQ0zkz4XZcdaoEefIHJDpFVTpcUx8IYDJ67jAdCAgGzLIKDPkKsgUXoc?=
 =?us-ascii?Q?FroS509mzrAfhw3QzKAdE/T6weFzNaw2P56btXfG2IYeEfLMYS/sAz8ok/8o?=
 =?us-ascii?Q?KBWyR66Tu0oP+YdJ7qsIE2MUSsZExtilzFqPm5A+e2RpBfgXiBgoAq4xRLUn?=
 =?us-ascii?Q?bm1FMAJARyACRMJ3gPjuJml3YdlEzbyYzdYJC2OuZT82?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2c86663c-62b8-4554-3d7b-08d9eb32f911
X-MS-Exchange-CrossTenant-AuthSource: SA2PR10MB4715.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Feb 2022 18:44:01.1371
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 1ojZ1IPxWnD1OIPRSvocAs3317Nu9b7rhiddNhXB0CpK68TUJY+p4DBGDogQPmMaFMQkzfje/KaG23dpv3ct1Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR10MB5781
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10252 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202080109
X-Proofpoint-ORIG-GUID: EiK4lMmouUv-9sn1LtR6bJzWDiyHOWIg
X-Proofpoint-GUID: EiK4lMmouUv-9sn1LtR6bJzWDiyHOWIg
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The kallmodsyms patch series was originally posted in Nov 2019, and the thread
(https://lore.kernel.org/linux-kbuild/20191114223036.9359-1-eugene.loh@oracle.com/t/#u)
shows review comments, questions, and feedback from interested parties.

All review comments have been satisfied, as far as I know: in particular
Yamada's note about translation units that are shared between built-in modules
is satisfied with a better representation which is also much, much smaller.

A kernel tree containing this series alone, atop -rc3:
   https://github.com/oracle/dtrace-linux-kernel kallmodsyms/5.17-rc3

Trees for trying this out, if you want to try this series in conjunction
with its major current user:

 userspace tree for the dtrace tool itself:
   https://github.com/oracle/dtrace-utils.git, dev branch
 kernel tree comprising this series and a few other patches needed by
 dtrace:
   https://github.com/oracle/dtrace-linux-kernel, v2/5.17-rc2 branch

(See the README.md in the latter for dtrace build instructions.  Note the need for a
reasonably recent binutils, a trunk GCC, and a cross-bpf toolchain.)


/proc/kallsyms is very useful for tracers and other tools that need to
map kernel symbols to addresses.

It would be useful if there were a mapping between kernel symbol and module
name that only changed when the kernel source code is changed.  This mapping
should not change simply because a module becomes built into the kernel, so
that it's not broken by changes in user configuration.  (DTrace for Linux
already uses the approach in this patch for this purpose.)

In brief we do this by mapping from address ranges to object files (with
assistance from the linker map file), then mapping from object files to
potential kernel modules. Because the number of object files is much smaller
than the number of symbols, this is a fairly efficient representation, even with
a bit of extra complexity to allow object files to be in more than one module at
once.

The size impact of all of this is minimal: in one of my tests, vmlinux grew by
0.17% (10824 bytes), and the compressed vmlinux only grew by 0.08% (7552 bytes):
though this is very configuration-dependent, it seems likely to scale roughly
with the kernel as a whole.

This is all controlled by a new config parameter CONFIG_KALLMODSYMS, which when
set results in output in /proc/kallmodsyms that looks like this:

ffffffff8b013d20 409 t pt_buffer_setup_aux
ffffffff8b014130 11f T intel_pt_interrupt
ffffffff8b014250 2d T cpu_emergency_stop_pt
ffffffff8b014280 13a t rapl_pmu_event_init      [intel_rapl_perf]
ffffffff8b0143c0 bb t rapl_event_update [intel_rapl_perf]
ffffffff8b014480 10 t rapl_pmu_event_read       [intel_rapl_perf]
ffffffff8b014490 a3 t rapl_cpu_offline  [intel_rapl_perf]
ffffffff8b014540 24 t __rapl_event_show [intel_rapl_perf]
ffffffff8b014570 f2 t rapl_pmu_event_stop       [intel_rapl_perf]

These symbols are notated as [intel_rapl_perf] even if intel_rapl_perf is built
into the kernel.

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

Like /proc/kallsyms, the output is driven by address, so keeps the
curious property of /proc/kallsyms that symbols (like free_netbuf above)
may appear repeatedly with different addresses: but now, unlike in
/proc/kallsyms, we can see that those symbols appear repeatedly because
they are *different symbols* that ultimately belong to different
modules, all of which are built in to the kernel.

Those symbols that come from object files that are genuinely reused and that
appear only once in memory get a /proc/kallmodsyms line with [multiple]
[modules] on it: consumers will have to be ready to handle such lines.

Also, kernel symbols for built-in modules will probably appear interspersed with
other symbols that are part of different modules and non-modular always-built-in
symbols, which, as usual, have no square-bracketed module denotation.

As with /proc/kallsyms, non-root usage produces addresses that are all zero.

I am open to changing the name and/or format of /proc/kallmodsyms, but felt it
best to split it out of /proc/kallsyms to avoid breaking existing kallsyms
parsers.  Another possible syntax might be to use {curly brackets} or something
to denote built-in modules: it might be possible to drop /proc/kallmodsyms and
make /proc/kallsyms emit things in this format.  (Equally, now kallmodsyms data
uses very little space, the CONFIG_KALLMODSYMS config option might be something
people don't want to bother with.)



The commits in this series all have reviewed-by tags: they're all from
internal reviews, so please ignore them.


Differences from v7, December:

 - Adjust for changes in the v5.17 merge window.  Adjust a few commit
   messages and shrink the cover letter.
 - Drop the symbol-size patch, probably better done from userspace.

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

Nick Alcock (6):
  kbuild: bring back tristate.conf
  kbuild: add modules_thick.builtin
  kbuild: generate an address ranges map at vmlinux link time
  kallsyms: introduce sections needed to map symbols to built-in modules
  kallsyms: optimize .kallsyms_modules*
  kallsyms: add /proc/kallmodsyms
