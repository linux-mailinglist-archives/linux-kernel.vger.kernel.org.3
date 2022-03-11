Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD94A4D68D7
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 20:00:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351007AbiCKTBE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 14:01:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242878AbiCKTBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 14:01:02 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BADD1B371B
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:59:59 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22BIWAkY021518;
        Fri, 11 Mar 2022 18:59:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ePEmbqoyV9euEsWGLZ6Ks9naCl69FEYsJHSSPuYvg18=;
 b=I1Cxw/diIj4E6Ydj9hsLAvCKkKI9dWID6uXLg70KjCHc1S41gviZ7QYzBen4zn9Fxh5k
 lUSAXkEjPsGAUu2ZflxNJ28K1qtMAIdbBjegpT4m0ic88L6P/LEPaonIlfaDjkc/fnvu
 TW4rBrd2b6lA/knyG3U6HVEhWNHTlbzygZ2FzhuTkpFm9fbgzUhbY7JknqaqsGz3hEZQ
 q5vmi6W4EORmQJJJg+cOOaJ6o+YOsn6erGn/3nJskeVBZFvxHkYig7LmLFBrkW/AvA+T
 +h8LYPANJwsii3v09MzMQgB2iwTZEn7+t6YYWZguv5eWMJ/VPPXD35o7RmXoVEsGwMpD 7w== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3em0du9x9m-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 18:59:43 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22BItmxF017697;
        Fri, 11 Mar 2022 18:59:42 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2045.outbound.protection.outlook.com [104.47.66.45])
        by aserp3030.oracle.com with ESMTP id 3ekwwe8uyx-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Mar 2022 18:59:42 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=hYtUDfPbY39bbHbl66JAnkF0icO7wXrJ/+lRQJRj1Z1sBpcDxLk8rFycz/q+2x4UUZAR8N/QrqXvprQbTxwzPP7aFxzQpOsJv51YBmpgOxUpM0aF3GVzOO/hMNKOQtBki6QGaoOrB+rmbsg+IQOnR/T4ezGgJhscyI8eIeeGKfnhlFLPHnukCeqNV6c/PFXpIR3dKBxZ8Di/nJEr91ymTnie2w6ljJq6qTwXy8m0QYzACuMoIAVtzUJ/XyfkX/qu8oi3n95zLPnRGOvS0B71UMjTAFlI3mq7u+lSG0jKRD4a0wzZJtcJjLxv8RmI02H98gwKtVBU7z05eXw7YYvdiw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ePEmbqoyV9euEsWGLZ6Ks9naCl69FEYsJHSSPuYvg18=;
 b=NGz3CdxuXWyuk53hL2o+Oek04qt1h4pLQUqFuTdkKhtOW5zBhxHvuOdw76RWZlcZ65PcluILeZuBqpRMPDjNoGyvALZJ2voBCb2ADf9sM85gNCQy4E9lC4EIfnbEqJlRyccHX6Xqbf/DkjwPwSgEVwzH3G0BYHO8qXU0dozKrbmk0Pilg91BlrbqpYmra3DOjXsN2Fi4pP6P26NvRK7flHB3LQCy4Ah88R5XUoRT6hXPQLimLulopZoSFg4Xo+eS+/Shd/JIxyEdaXasuSii8zH9Z4Yno2J+TdooeEVyBIaMF4CC5cQJ9qI/cu60EAq4o0RMgME+2hVs4aVJeLHr4w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ePEmbqoyV9euEsWGLZ6Ks9naCl69FEYsJHSSPuYvg18=;
 b=UjZCtczd5UJEvFQN5rIKqIwsgurjTagRYIJigJvYPapn9jXFxRnEG/OkXFmNkjuy+WXNTlMKL0jvuadjafcmXoRWEdhCvQhs25zMCy/thbDS1PaDEUae/R7EWbUD1VRaI9HulhjydyVy2defj748xS5Qsn+Cn/VTGt5zyEXC44A=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN0PR10MB5175.namprd10.prod.outlook.com
 (2603:10b6:408:115::6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.22; Fri, 11 Mar
 2022 18:59:40 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5061.022; Fri, 11 Mar 2022
 18:59:40 +0000
Date:   Fri, 11 Mar 2022 21:59:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Daniel Baluta <daniel.baluta@nxp.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@vger.gnuweeb.org>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [ammarfaizi2-block:broonie/sound/for-5.18 33/171]
 sound/soc/sof/compress.c:54 snd_sof_compr_fragment_elapsed() warn: variable
 dereferenced before check 'cstream' (see line 48)
Message-ID: <202203120019.KjXsD7LN-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0021.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4d::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c661d40e-30bd-4953-785d-08da03914b8e
X-MS-TrafficTypeDiagnostic: BN0PR10MB5175:EE_
X-Microsoft-Antispam-PRVS: <BN0PR10MB5175F6A3CE33939C99A431678E0C9@BN0PR10MB5175.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 38KaGSETDbpwNWVgYn5xlk+LYGeULdYvl8+M7aSDOr6vxEpvICB5UJJ8dIMCI9y72L17jArnx3MpQoRn7vs+qpcskbNixdcTpfnDP7E1eGsDO8dG0+PhEFgrxTBbsJpiDHAxpSrTt+F04sZ9b+IdmmtEPPH6o5n7o1nWKm5h4WRwJqQ6rCZvaVhS/iK9pwGc0gG0TDsBnsha2aP3qgLSyX8Y9JfVQn8SbR65A2FxVG7RovP/wN5ReptoAB8DAmMkphVBF9h3jC70Z1poQz/BJRYLDJbGzNmJP3xN1CoS/F4JE73xdC7zpnCy7LJjUhZfPzV0mjrh2WvA8wN2Tlw2QdTn41nNY5gz8lmcVdsNR6YR9Ti5U3qNKeLfvgz7yy5HniMiktG/shAkWLY3UH4PUrMNMxfQ42EDBGKFIVHabCwYAkAp+tqdJhPqweltLDPVPz+AvHUsncOqQdHLXAlzMRzED7RgvQw2HicCFXdBpvGfyEDFEzHpEn1lIuZ62NYTbEpAF6qhcbfGeaPN2WjVgDhD/pDFvEE0K/nQacsoZ8zGsyl3Zb9zyJPcNpheE+XrZEOBp1cMUqza/IZLmbRHPV9fq/4nQmB8Thy28xAFd8BbgAOhNfB5HMIqXmxj8aKgjOhxSVZl2TLp9gSV+IZuZQx4kdSn8Pa6ycTjGhtlkktszf7DtELv3l6tNogMTHMSduxxdri4UDsy5ZwIjQ8Xy3c+GtSEXIfLj+a7SdKz/TiwR0WNeFfRpNmZQ61ZrIpyxCzZ/BciHocNv8wFaG4kefPBLh5JwOzIe+EuBIwrhh9pGc9a0JYlFVuEZs9BWzYz07KjO3Hl+/4wpb8jb2b3QA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(66946007)(508600001)(6486002)(966005)(6666004)(66476007)(66556008)(86362001)(4326008)(8676002)(54906003)(6916009)(316002)(1076003)(26005)(186003)(6506007)(6512007)(9686003)(38100700002)(38350700002)(52116002)(83380400001)(2906002)(36756003)(5660300002)(44832011)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?RDeWvR8ObWXahvNSNRPCnzVqIb0qXJTKdmidg+epGXyZvgfGMpJ/LbEMj8NW?=
 =?us-ascii?Q?GWkjmL0sxDxCVd7hJDg0QheptrcZEZGa/y+LXirANcZOZ51ORr8GtucVg56o?=
 =?us-ascii?Q?asLc4cT+sQmxzv0o6vsTYIZUiZ53AFHu6sYbXqP9tYBy7S24vPT3B3GCfBOG?=
 =?us-ascii?Q?8Lb/hohxTXclt3wK1Kfsyri34LA8MvEiRPXZ3Q0K5ZQ2QW6Pk/JhrtuEmfgl?=
 =?us-ascii?Q?CqkXJqFMtRWIUgzxFaAdqtmwFOY+AHwEZMv79ROPpUmfAnzeFgMlG+q9i21S?=
 =?us-ascii?Q?kVntIRgkC0QRtVR1fuPdStyJh2gR3we0Cif6hhKvkLwOexyRDJRA188DaE7A?=
 =?us-ascii?Q?Qj/SSIY17t1ApypNHkyy0VFffIcj9KOz6gV0dEnEu4z/jufGgKhQLu/5fn9O?=
 =?us-ascii?Q?P/cn4sSsF+NkzbY2sLWbfJCyJRksw+AE+YINyY2lon1zGqrYmbsytScT8rGQ?=
 =?us-ascii?Q?V0L92R7e9mW1Z0bC5Y5MRGDr+TexXNrfIBTaugbd/E7BNVXNVbh4aZh1O4JD?=
 =?us-ascii?Q?MW+9TQ+SHg/m0dUQbEPPlBVUAis3E/xnXF5biSuDSQElQueP7eqTy5VNEbSz?=
 =?us-ascii?Q?A01ZHOkExds+ZHzkf7pkTe8/BfGa0uKLfcw47TVt00hU+4qO/0Z9mRt4KsUc?=
 =?us-ascii?Q?edwt61V9AGq7WOA1FflxR3/3y5+JU0BueTyK66XbOEitJVzKiVy+ziiznmBU?=
 =?us-ascii?Q?tZEyRFspj0/BHn7AOxCcQdofipP7ec58joT+ui9kDVyCKrwA7qm/IwyiykFD?=
 =?us-ascii?Q?B7yid8XQilUeTzryah2Y4wFkZfKHjkiRCHPjplXp76fQrzgxwWkhqFGPgFyh?=
 =?us-ascii?Q?JGCR7hOvqD387uVuo+DlC+b0HoyzW3UCE/tN0EHAGklBWiQVmcTM4lmUq3JJ?=
 =?us-ascii?Q?D5lYTF68SZYoaEREDeOv56v+WJOaXtgM3b9/59VAh++FeDzIYKFAUwUsGB/5?=
 =?us-ascii?Q?dYaO/Hgj7XQVXLdy9iPq19XSNUtv9YAyECWcymP9gUMkXvRl54bcxNT89ku0?=
 =?us-ascii?Q?Y4WjnDkwE9IzGBuxSVFD99v3ODbzwdwhDBCFH6dAyXD+v4SN2Mt5Gg+EgFmQ?=
 =?us-ascii?Q?dFrbE7lrFJI2NRt4cmWpEFRZBso0pqUtBlWCQqftI0OBNR6gXLcbNYYOgYs8?=
 =?us-ascii?Q?3vmCenmYCJo1DRiIzdCkNe2kCcyBs/bra4URBLrBlT1lPsUqw1CtSHU0UhpS?=
 =?us-ascii?Q?gwGb+wsS8D8cmnvjkvmBSzuc04oMoQRKGOqj+AbZcnnn5JUGHzKsH3K/hxd3?=
 =?us-ascii?Q?10unWPo0poFTguFa+9oLnK6JgjYGwefKfPFIvu51T5EaISOm+wbwSrqwNCq1?=
 =?us-ascii?Q?wgq3CfA/nMRQ9vBxA4E/u3zIadhAh1l94ztgMKJLlNdIl0X6nuU9ROvn9TYa?=
 =?us-ascii?Q?HLtnqVH9T2kqjV7EXUy/cqq5lZ44QNz9vy2NuAB6GjX82PQeYauHnv/sEEZl?=
 =?us-ascii?Q?w1/YJWE4BGDTworEAtGjBr8aGqMPfICs+31QG/d5KivvqIZcus3/PQ=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c661d40e-30bd-4953-785d-08da03914b8e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Mar 2022 18:59:40.0678
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: UaN4LNGFomigH/K4N23sLt2B+gtKWNlLAYIZR2yBZlTQLlB9vW6YsWdNdVtNGsjI2Kz0npW7vBvq6B6x901mOM+sM+HGBwK8vT1FC481sC4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN0PR10MB5175
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10283 signatures=693140
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 spamscore=0
 phishscore=0 bulkscore=0 adultscore=0 malwarescore=0 suspectscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203110094
X-Proofpoint-ORIG-GUID: r93KinfoTeJfn6GjlTtJD3_jxZ7jxO2o
X-Proofpoint-GUID: r93KinfoTeJfn6GjlTtJD3_jxZ7jxO2o
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block broonie/sound/for-5.18
head:   6b6bb5e26222021abe1c5360f43b4c2ff1dd012f
commit: 6324cf901e14c6662be508f30485e0f09c54694d [33/171] ASoC: SOF: compr: Add compress ops implementation
config: microblaze-randconfig-m031-20220310 (https://download.01.org/0day-ci/archive/20220312/202203120019.KjXsD7LN-lkp@intel.com/config)
compiler: microblaze-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
sound/soc/sof/compress.c:54 snd_sof_compr_fragment_elapsed() warn: variable dereferenced before check 'cstream' (see line 48)

vim +/cstream +54 sound/soc/sof/compress.c

858f7a5c45cacb Daniel Baluta 2021-10-04  46  void snd_sof_compr_fragment_elapsed(struct snd_compr_stream *cstream)
858f7a5c45cacb Daniel Baluta 2021-10-04  47  {
6324cf901e14c6 Daniel Baluta 2022-01-20 @48  	struct snd_soc_pcm_runtime *rtd = cstream->private_data;
                                                                                  ^^^^^^^^^^^^^^^^^^^^^^
6324cf901e14c6 Daniel Baluta 2022-01-20  49  	struct snd_compr_runtime *crtd = cstream->runtime;
                                                                                 ^^^^^^^^^^^^^^^^^
Dereference

858f7a5c45cacb Daniel Baluta 2021-10-04  50  	struct snd_soc_component *component;
6324cf901e14c6 Daniel Baluta 2022-01-20  51  	struct snd_compr_tstamp *tstamp;
858f7a5c45cacb Daniel Baluta 2021-10-04  52  	struct snd_sof_pcm *spcm;
858f7a5c45cacb Daniel Baluta 2021-10-04  53  
858f7a5c45cacb Daniel Baluta 2021-10-04 @54  	if (!cstream)
                                                    ^^^^^^^^
Checked too late

858f7a5c45cacb Daniel Baluta 2021-10-04  55  		return;
858f7a5c45cacb Daniel Baluta 2021-10-04  56  
6324cf901e14c6 Daniel Baluta 2022-01-20  57  	tstamp = crtd->private_data;
858f7a5c45cacb Daniel Baluta 2021-10-04  58  	component = snd_soc_rtdcom_lookup(rtd, SOF_AUDIO_PCM_DRV_NAME);
858f7a5c45cacb Daniel Baluta 2021-10-04  59  
858f7a5c45cacb Daniel Baluta 2021-10-04  60  	spcm = snd_sof_find_spcm_dai(component, rtd);
858f7a5c45cacb Daniel Baluta 2021-10-04  61  	if (!spcm) {
858f7a5c45cacb Daniel Baluta 2021-10-04  62  		dev_err(component->dev,
858f7a5c45cacb Daniel Baluta 2021-10-04  63  			"fragment elapsed called for unknown stream!\n");
858f7a5c45cacb Daniel Baluta 2021-10-04  64  		return;
858f7a5c45cacb Daniel Baluta 2021-10-04  65  	}
858f7a5c45cacb Daniel Baluta 2021-10-04  66  
6324cf901e14c6 Daniel Baluta 2022-01-20  67  	sof_set_transferred_bytes(tstamp, spcm->stream[cstream->direction].posn.host_posn,
6324cf901e14c6 Daniel Baluta 2022-01-20  68  				  crtd->buffer_size);
6324cf901e14c6 Daniel Baluta 2022-01-20  69  
858f7a5c45cacb Daniel Baluta 2021-10-04  70  	/* use the same workqueue-based solution as for PCM, cf. snd_sof_pcm_elapsed */
858f7a5c45cacb Daniel Baluta 2021-10-04  71  	schedule_work(&spcm->stream[cstream->direction].period_elapsed_work);
858f7a5c45cacb Daniel Baluta 2021-10-04  72  }

---
0-DAY CI Kernel Test Service
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

