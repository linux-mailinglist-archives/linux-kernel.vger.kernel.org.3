Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EC2B4EABEC
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 13:07:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiC2LJA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 07:09:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231437AbiC2LIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 07:08:55 -0400
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FED924F32
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 04:07:12 -0700 (PDT)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22T8oeuG004680;
        Tue, 29 Mar 2022 11:06:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=WdyqEoQptrOXfL1FFc+yDUIvmLOqMUcmlV5LWTGaIMM=;
 b=EOmuDFl6l3mqd0c7IH0aotmGK0sP944VQ8H6ev7Au4QjJaGxT2hpeSHL3CS8kHtHOt/X
 PSgl5lL3o3ONMLD5bnahc0Dl3dA2vkwxYleYFd3egwrgmCzXk6aKuVYW3GI25CgdQkcx
 VsHxXExxHVAtd6UKTCAihLX0G/ISwiIkPVZ3nLkrah37yixpYq3izDAs5QBMTS+IH9My
 Z5vxSIWd25JcMrWHQSaRawgFxZcAAUgD5J3A7nInaaSB/fqfl3qOym6CSFBPvtbjfD43
 mLjqYROzHpbgM3hsVAMOpsxMligB1SADu/kDJn99KhTmYCRb7nS9jfUYHj/OdasPcllI OQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3f1sm2e9jj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:06:13 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 22TB3mWc148655;
        Tue, 29 Mar 2022 11:06:12 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2048.outbound.protection.outlook.com [104.47.66.48])
        by userp3020.oracle.com with ESMTP id 3f1v9ffvtn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 29 Mar 2022 11:06:12 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=F36Jt9SWpqZruePQ+6pAb79ptZD7MxUcEF8x8gxJ79bBYaM/HaA81TAE4SSnT5fI6+pxgVxCLh0PEffKq1+Sv2MgH0Y9lu1Amb/luKeEYYKyJve9ABcd81YX6Mas7AWVlTZ6YKcezlkmCOq6KCItAxApTPOy91Na7n1uTN/GTQHy1SarRhUIIRk8MVSa2DxlfUlmBBM54zVQKd/Q8l7lGIRfu4UpK/mWOCY2/CI+GQn+sUCZL3A43dzDRzvgFPxFoRLwqMoSWP2ialjLI6iS6toqr8rV9lssZOuoIcF2haxPnwJox03uoMOaBngBQN/hAStxbQC9urxdRXsuRZmUMQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WdyqEoQptrOXfL1FFc+yDUIvmLOqMUcmlV5LWTGaIMM=;
 b=I+47fwzez7upcp3JRZJnbzAopgCaKIsMJz7c1B3atPRh3AE3f2qpkLrXVbsEGDjRDEb9XMXY4lgQ+XDJ3D31NTqCAXGpOC9/rRvbRAboqf8fLfqKvWnzlSeCUPP9D5d1K9IkdDsjhiDEo/MDv8XaEr17/vr6akzYj82uChcppzsi6M4SvVFhgkHr2JlPrr+JTcj99rOargOGr2UigrOnkRtAvfA+hcZ+4x2AUXBTBlvebDVjkRfAGCZ4mWDJWIpRxwIBaxOhAk+bQm6WLRfQTu6TsM3JUhOyLlvQx7Fb0BKHSDbiwBCZJEaC6243jDEc4QZceKsNaCvp6LGYG2U71w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WdyqEoQptrOXfL1FFc+yDUIvmLOqMUcmlV5LWTGaIMM=;
 b=y7oXvZEGFafigM95XmYe3oH0kvW/YrVxfTV8TIsUhXyKXhUKP/kBzqBA5X4koFwrxkkO2Hlq5Xeb9EMUalcQwRSUOm1WKNDK8X6PBB5M0cCFrAClfeiu6JJBDLXj66fz7Ge/M+5W8L8/Z4SmtF/cvfZuHVXyqmi3Dp0m4eCG7wQ=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DS7PR10MB5200.namprd10.prod.outlook.com
 (2603:10b6:5:3a6::18) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Tue, 29 Mar
 2022 11:06:08 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::d4e7:ee60:f060:e20c%7]) with mapi id 15.20.5081.025; Tue, 29 Mar 2022
 11:06:08 +0000
Date:   Tue, 29 Mar 2022 14:05:53 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Kai-Heng Feng <kai.heng.feng@canonical.com>,
        tiwai@suse.com
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Kai-Heng Feng <kai.heng.feng@canonical.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Jeremy Szu <jeremy.szu@canonical.com>,
        Werner Sembach <wse@tuxedocomputers.com>,
        Hui Wang <hui.wang@canonical.com>,
        Lucas Tanure <tanureal@opensource.cirrus.com>,
        Cameron Berkenpas <cam@neo-zeon.de>,
        Kailang Yang <kailang@realtek.com>, Sami Loone <sami@loone.fi>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ALSA: hda/realtek: Fix audio regression on Mi Notebook
 Pro 2020
Message-ID: <202203291807.UCLuP6Fi-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220329001845.776776-1-kai.heng.feng@canonical.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: MR2P264CA0089.FRAP264.PROD.OUTLOOK.COM
 (2603:10a6:500:32::29) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0d09110c-84fc-4356-d23e-08da11742053
X-MS-TrafficTypeDiagnostic: DS7PR10MB5200:EE_
X-Microsoft-Antispam-PRVS: <DS7PR10MB52001B05E0EF13CE85F4FE9D8E1E9@DS7PR10MB5200.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 1VGzvQVqRfkVyFTmMc9azwzY/f0Wd49mKZXJtXyDAk6FOhfjxZ/o7fNCth9cvk3QAWKDieDDLNo0h1RtRlWwpfdnetYjL+ab8jykGSAFZJ4+jMwotoQjpE+Q9R4dQ3++Axvavk7VnKdlM5SB9nrv8e7JewtTIQQH5en6YeVYC2fToLJcLE5+gXrAH9m9P5sZJvsJ2yVAM1UML7gKx3ezQVqoaXtPdCNrTlSVljGJrpMeTH7mAPlrEue+wdirnl/XhR1WJCj/tzmxt81u2d8Yxj0cMwQ5qXhw9M9c8jnT+XLrSUmElGIJu9AJHy5mwlQ3m5IBoidR++5h/ogFgeJc+f7jdFHr9k+Szb4wyEEInEEuMLCNlcCOzk56Q6CEQt1tiJRMbOFwk4wzIQ/GAu86piFYZPBEQ3H8XDSvZkHXu5DLusBUq0N7SjbVFtFBC1pwTrDjVrUmcWBt1ZsMgVqxvd6g7Yg+KUuAur0vbys2uqvxFYKJIAVJFhXAofkxnw9HB9VcQOdPFMlGwizDMK3WMZgnDbPuYylrRpFtBcw33G/HQAtb01I2iJ0J95qM6qb0QtIHanBD9yZBeLzp1JRcOev4YTJFppMg+pw7kXtD0eW5ZSNXvZAdjwzIK77Li2xH9UHWPzlcARkEJMJSfdu1SzSKMd+jWrjMJ16hy8gRYL3UcI4EzBzOw1UD5v5DItUoj7w7RjBNB+Qw2bxBdJeN3/tk8KzxH5sYQh+TIEZENyrRPRIPZM1LT59LmG1AFuiZOs9Exe6g+rbKplhwUyj7Tq3jj6hap9oTQWk/1kvOyQAp/AQnp1azKjOppHPoInFUG9WNpb83+QubWIAc2XA9AQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(26005)(8936002)(1076003)(36756003)(52116002)(66946007)(508600001)(83380400001)(4326008)(66556008)(66476007)(7416002)(6486002)(966005)(8676002)(186003)(316002)(6506007)(5660300002)(6512007)(6666004)(38100700002)(38350700002)(2906002)(44832011)(54906003)(9686003)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?UPk7tZBoCM4jI42OEMLkHwamrwGujHqTSUaUJABpYO+Z+J2mltf8K9qVFF5g?=
 =?us-ascii?Q?DDhKosdt1wfTHARauTT9r4Jk5U+fLTmtOnbuilsMZbFPmDrFonp6ziUMaPTl?=
 =?us-ascii?Q?YXIRAvMesxPjESz4gmMTy16jkVQCktbicmNyQweMHJ+W5RlDNyw6HfCczyi6?=
 =?us-ascii?Q?Gp6mKNPPpcPIsCTK8pvpqqDhal2UHlK4oA9MJXZK0ZDNMV+NkKPA+apRTscE?=
 =?us-ascii?Q?tp/RNI9pubxcCoXUAC0KdRACxgf5sfevq4VW5VqPqlx7MDE9Og5mexAsl/St?=
 =?us-ascii?Q?IN+oQ6o6Cmb9aqOkQ8xmdn/wBwsHkRr+miTxDOivdqWM4EYyy67R2sJYKvKG?=
 =?us-ascii?Q?2r7681AxeYCfj7j+CCG6wSm5RR58WVSkRkJlKnRWtRCAic6YwxtNJ8Tigsuq?=
 =?us-ascii?Q?PU1A6jaGeeguOtPZEwWCNjFpgKb83sLuGlMmglfYVf/OM8G+WQr8Nc3OYzLI?=
 =?us-ascii?Q?iA+8LL+J+BudlQtJY17gXFpj/Z9lU7GPY/7hXOBbKOBXSmpCW4oOIwmAPE8k?=
 =?us-ascii?Q?Yb71cCmb6gshilBugswWbaEnw+X3AHf8oPz67kv/vQm5FRgSsmWVkDXfuIl3?=
 =?us-ascii?Q?TWFaBWKpKDydHCGLrporB/JR/IMJHYJUWd0ezHcs5ktZFxXu79hDhK+/OvyU?=
 =?us-ascii?Q?iIOvJ8f5r1C/NmixBHWH7FXRC04H5CKB7qaudH1zyp21hIfcOTKDSqS8sXRH?=
 =?us-ascii?Q?5vjEOGGDqCN4JsfclG6J7DYA36TNLby/pJCTSZgT7EWw5uH5Wfjvwyyt1MB+?=
 =?us-ascii?Q?nEeVPp6bZXlrzteIBKZGzvryoOQCLMdbxLOBwfW5Djug72qVGB9BDhnKpYPh?=
 =?us-ascii?Q?KK3fbJkOu8VZeGmMADUZA+6BJu2LJ6TTDNs6xoORsnouWQELk7TFQ9mLnDpg?=
 =?us-ascii?Q?Y/2pR8qGrMYKlRZJ3eM0SsOVGtLoEyG0kbOoeaogEGzmpo4wWRR5Jvo67MfB?=
 =?us-ascii?Q?QUiJwV8/avq3CIHbb43ICAaVY0dOuOFl1KDb4wt3qLYURStxHPND4fd3YhYx?=
 =?us-ascii?Q?JkaJ2vgPMprE2GrUtjY2qC4BjfH8O7MHgQOsVkBlxgpEjb6D0YMcBTQ9izHA?=
 =?us-ascii?Q?BOIXDPpSZgTUR9G1EQ9MHI99hmZ6VwIo1a6u+bYJPCAozE8oOnSlOQ6L3Hcz?=
 =?us-ascii?Q?K92P2AyN7msiDqjmIcX/ixJf3a2fz1tIz1DOK62PbHqE1YS0ipxfI4evg9aZ?=
 =?us-ascii?Q?l2wsEhjx7OZO31ieb8ogS1QE6x3Jh5q3lCPX6X3PYtGJf7YSwgvDCCefRoo1?=
 =?us-ascii?Q?3i6kuJCWeMMwxy2ot8Qblw7h+GLrlvs7/Hy3YIrsLzoxMm/dpWxyrDT4w/AO?=
 =?us-ascii?Q?lUJ82iCuoDz5DGcMqBEtd9zMaHzBI4BfYE1xDNandvGGR7jUSBLSqyQ39e/F?=
 =?us-ascii?Q?eSYsiIsMrsnYux/hDKVQrSQOdBBlenlL3PiAVkvDRUN+uCWoGmnPoqR8N521?=
 =?us-ascii?Q?XasQBEUeSacAwkr670Ee/h8dYi8u3Z34ly/tpidngvAsVL0/zcaE8J6rLAqx?=
 =?us-ascii?Q?SUIIII2f8zA54dcUpJYf+ReYaO9dUuxkKlujA/shTbhziHUIjV5rNHWIUB34?=
 =?us-ascii?Q?h0CDcBe9BKc62yQoCErbGk45W/OJGQI76VWt4uoJMjMQZt2VnuTiMAOeGJxn?=
 =?us-ascii?Q?o1M8MdbtiWvDIi/UYLpdIKn4H926oIfLeigS7HFmNoU9zvKGj536B1MnvhW7?=
 =?us-ascii?Q?JqKI0MGvsNri6jlC275Ku9QUaX9fJMmaaPH0xsk8jNg63brc9x7hGSRQMVFf?=
 =?us-ascii?Q?K+qFki2iWeILMVGbhh+c8qpkDj36t8U=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0d09110c-84fc-4356-d23e-08da11742053
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Mar 2022 11:06:08.6807
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 61ycW8Kf25dLrfBPQsawq3XVRrBFIvuskoYi/neaUq95EGc9TJQkURqXrledsetEyX3mj8e/fc5cyADH6U989eJTbZk16HivEkAVTJceePM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS7PR10MB5200
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10300 signatures=694973
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0 spamscore=0
 adultscore=0 mlxlogscore=999 phishscore=0 suspectscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203290067
X-Proofpoint-ORIG-GUID: Faqebafvca7mkcZIeEWhj-lXJaLMX9tO
X-Proofpoint-GUID: Faqebafvca7mkcZIeEWhj-lXJaLMX9tO
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kai-Heng,

url:    https://github.com/intel-lab-lkp/linux/commits/Kai-Heng-Feng/ALSA-hda-realtek-Fix-audio-regression-on-Mi-Notebook-Pro-2020/20220329-082021
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tiwai/sound.git for-next
config: xtensa-randconfig-m031-20220327 (https://download.01.org/0day-ci/archive/20220329/202203291807.UCLuP6Fi-lkp@intel.com/config)
compiler: xtensa-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/pci/hda/patch_realtek.c:3620 alc256_shutup() warn: was && intended here instead of ||?

vim +3620 sound/pci/hda/patch_realtek.c

4a219ef8f37071 Kailang Yang  2017-06-16  3595  static void alc256_shutup(struct hda_codec *codec)
4a219ef8f37071 Kailang Yang  2017-06-16  3596  {
4a219ef8f37071 Kailang Yang  2017-06-16  3597  	struct alc_spec *spec = codec->spec;
35a39f98567d8d Takashi Iwai  2019-02-01  3598  	hda_nid_t hp_pin = alc_get_hp_pin(spec);
4a219ef8f37071 Kailang Yang  2017-06-16  3599  	bool hp_pin_sense;
4a219ef8f37071 Kailang Yang  2017-06-16  3600  
6447c962bc47a5 Kailang Yang  2019-05-08  3601  	if (!hp_pin)
6447c962bc47a5 Kailang Yang  2019-05-08  3602  		hp_pin = 0x21;
4a219ef8f37071 Kailang Yang  2017-06-16  3603  
4a219ef8f37071 Kailang Yang  2017-06-16  3604  	hp_pin_sense = snd_hda_jack_detect(codec, hp_pin);
4a219ef8f37071 Kailang Yang  2017-06-16  3605  
4a219ef8f37071 Kailang Yang  2017-06-16  3606  	if (hp_pin_sense)
4a219ef8f37071 Kailang Yang  2017-06-16  3607  		msleep(2);
4a219ef8f37071 Kailang Yang  2017-06-16  3608  
4a219ef8f37071 Kailang Yang  2017-06-16  3609  	snd_hda_codec_write(codec, hp_pin, 0,
4a219ef8f37071 Kailang Yang  2017-06-16  3610  			    AC_VERB_SET_AMP_GAIN_MUTE, AMP_OUT_MUTE);
4a219ef8f37071 Kailang Yang  2017-06-16  3611  
6447c962bc47a5 Kailang Yang  2019-05-08  3612  	if (hp_pin_sense || spec->ultra_low_power)
4a219ef8f37071 Kailang Yang  2017-06-16  3613  		msleep(85);
4a219ef8f37071 Kailang Yang  2017-06-16  3614  
1c9609e3a8cf59 Takashi Iwai  2018-01-19  3615  	/* 3k pull low control for Headset jack. */
1c9609e3a8cf59 Takashi Iwai  2018-01-19  3616  	/* NOTE: call this before clearing the pin, otherwise codec stalls */
3f74249057827c Hui Wang      2020-09-14  3617  	/* If disable 3k pulldown control for alc257, the Mic detection will not work correctly
3f74249057827c Hui Wang      2020-09-14  3618  	 * when booting with headset plugged. So skip setting it for the codec alc257
3f74249057827c Hui Wang      2020-09-14  3619  	 */
b86b7ea348ec9b Kai-Heng Feng 2022-03-29 @3620  	if (codec->core.vendor_id != 0x10ec0236 ||

This should be && instead of ||

b86b7ea348ec9b Kai-Heng Feng 2022-03-29  3621  	    codec->core.vendor_id != 0x10ec0257)
1c9609e3a8cf59 Takashi Iwai  2018-01-19  3622  		alc_update_coef_idx(codec, 0x46, 0, 3 << 12);
1c9609e3a8cf59 Takashi Iwai  2018-01-19  3623  
c0ca5eced22215 Takashi Iwai  2019-02-20  3624  	if (!spec->no_shutup_pins)
4a219ef8f37071 Kailang Yang  2017-06-16  3625  		snd_hda_codec_write(codec, hp_pin, 0,
4a219ef8f37071 Kailang Yang  2017-06-16  3626  				    AC_VERB_SET_PIN_WIDGET_CONTROL, 0x0);
4a219ef8f37071 Kailang Yang  2017-06-16  3627  
6447c962bc47a5 Kailang Yang  2019-05-08  3628  	if (hp_pin_sense || spec->ultra_low_power)
4a219ef8f37071 Kailang Yang  2017-06-16  3629  		msleep(100);
4a219ef8f37071 Kailang Yang  2017-06-16  3630  
4a219ef8f37071 Kailang Yang  2017-06-16  3631  	alc_auto_setup_eapd(codec, false);
c0ca5eced22215 Takashi Iwai  2019-02-20  3632  	alc_shutup_pins(codec);
6447c962bc47a5 Kailang Yang  2019-05-08  3633  	if (spec->ultra_low_power) {
6447c962bc47a5 Kailang Yang  2019-05-08  3634  		msleep(50);
6447c962bc47a5 Kailang Yang  2019-05-08  3635  		alc_update_coef_idx(codec, 0x03, 1<<1, 0);
6447c962bc47a5 Kailang Yang  2019-05-08  3636  		alc_update_coef_idx(codec, 0x08, 7<<4, 7<<4);
6447c962bc47a5 Kailang Yang  2019-05-08  3637  		alc_update_coef_idx(codec, 0x08, 3<<2, 0);
6447c962bc47a5 Kailang Yang  2019-05-08  3638  		alc_update_coef_idx(codec, 0x3b, 1<<15, 1<<15);
6447c962bc47a5 Kailang Yang  2019-05-08  3639  		alc_update_coef_idx(codec, 0x0e, 7<<6, 0);
6447c962bc47a5 Kailang Yang  2019-05-08  3640  		msleep(30);
6447c962bc47a5 Kailang Yang  2019-05-08  3641  	}
4a219ef8f37071 Kailang Yang  2017-06-16  3642  }

-- 
0-DAY CI Kernel Test Service
https://01.org/lkp

