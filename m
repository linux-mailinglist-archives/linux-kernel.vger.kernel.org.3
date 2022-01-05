Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D31C485032
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:39:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234213AbiAEJjT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:39:19 -0500
Received: from mx0b-00069f02.pphosted.com ([205.220.177.32]:20628 "EHLO
        mx0b-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234032AbiAEJin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:38:43 -0500
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2056po7j032167;
        Wed, 5 Jan 2022 09:38:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=4b+pF4XQ0lDxUpCx1apYoEUIUdf/rrx3EJIgJFGXH48=;
 b=CIh0a6CEp8KGDfF5m+jwKPoHYBHORnRASRgeAFwr2SHg0hVIsTbnvG2TEQ4XEaz5VIiC
 Wpey3gr42aVol3iOtn+99JDL+tUI+Gj6IkZ6dwmFmIkCn/MoOvlfm0VCN07g1fxZuD4E
 sy+yzB0gk60aqZaY0iOME3mnAD4Qr9WtBpJxBjYKZLuRLzDMCAPM9TSejPYXCx2W31ro
 FqCwuyglP1H6ns1uTTfOzcOy6Mam9XAHPpWTA7vjR90/CBfk/ygja6EpxArFzv8eKIIX
 85DFkhKE02KmV8SDOyVIjnL/aSih/j5AvfVskA5GuNDcduFYRVFwTtzKMWDHDG+KtW2w rQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3st4ejj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 09:38:38 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2059ZlRK116848;
        Wed, 5 Jan 2022 09:38:37 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2101.outbound.protection.outlook.com [104.47.70.101])
        by userp3030.oracle.com with ESMTP id 3dac2y0swk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 09:38:37 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Xk7GV7Siq+jqHsl+2SrjaMGh31yRGWaUWjl+iWzshnLim+wQ+BbvFvvz0PdOWiLAvja1vVvBdLjwyDcyLoFYJdRAl40twvMe/e0/nyZiedqCbp2F+JrxDjL0JsiDzI0oDKnJYzzPtcdwCmuJ6yRKqXDnRixL2oGt179WYdLQN9zRbivSPiZO0QBRudutA4sju1Hs9YAOcmsl8ER9ZrpqvVJhokHQm0+AgFTSaHLqlG8q/nMnINWy3MWc462bn3nCk6zZyZpmXNGmQUGkNcJ0T0xayS2a9mYdIEhSByjQYZXZx0GInUsqop5VSDnTx5jvPrkMdLB3BVGj22xluwUu7A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=4b+pF4XQ0lDxUpCx1apYoEUIUdf/rrx3EJIgJFGXH48=;
 b=TN0tq2mHisO2ac39DdtcHMBgJQ7qSc0ae4vhaZaqOn/6XneN5CwGluyrlWDBZF6BB3yRA5fhArv7+EZM9mxcRWWFM/kKK411CC5OG0noi9qhtqzVeA2lRiMkqDq+HvLuKZsko4F9La92av8+vT8wvHQVbKe1XFB6/SNlOERlOD9PdgcZOahc2adKrDnFsiBCubVFUZtCUVXMJZDyIPUt1c8a273SaBsSZdBMK44nK0FyomJnZaWVJDuSmdW/hOzmvJUkRDMus6WpICajz6hP6LYdiYSAj25Ub+3hm0+huwryYqIm7cgWwIFp5wZbOKLIMOzLRBVhP4jzziNxaRn4cw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=4b+pF4XQ0lDxUpCx1apYoEUIUdf/rrx3EJIgJFGXH48=;
 b=o44s1huN7cqjS7q/SeuIc0k5SbxWLEVWBhDFs0PCLFYDUJ0Oll+Gcbw+z4TMsGtd2Cr8iKrBRuH1vAcQitT3pnK6xUrv41B+3zHY3Nv3OUUeTOzTiAo8g/NRkAyIbVqY+hqNF2Lb+SqC9Hhjw3H8ldCqJIR7kyNvpRGpUv6j0To=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CO1PR10MB4643.namprd10.prod.outlook.com
 (2603:10b6:303:9c::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4844.14; Wed, 5 Jan
 2022 09:38:35 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 09:38:35 +0000
Date:   Wed, 5 Jan 2022 12:38:15 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jake Wang <haonan.wang2@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:222
 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could
 be null (see line 213)
Message-ID: <202112182118.FZN5I3gV-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0030.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::18)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 74d0a727-96b8-444d-4dfd-08d9d02f24fb
X-MS-TrafficTypeDiagnostic: CO1PR10MB4643:EE_
X-Microsoft-Antispam-PRVS: <CO1PR10MB46437239D686683676D864158E4B9@CO1PR10MB4643.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:252;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: lZzOfbHFJWzfEFmLXXbZ1STVmOKV+iguSwIr5jYFJAQpvl6YB96UzBX4ajLUkqW8tm6PabNbI6KuiV7YSbe3SqUPIIXm5bIMEblEj8tHXaPexge0yRXWcPbAox49IC7psELO879zA+qBdi6LRz59M5g5TsmRzQ3JwLSYx02YZU2GcHwvojntsv6UCpHMJnti2ODIKHCrPK5JbyuLaQ3ID42ftEPMKOlgPZ5svHeTC5kR4lxcEi3szBO9BfgVoQU/7onuzvqbdXI7TdKFNhzSTpX/WosdXfW35DGURlhNLo3RoBS6WbWMQaVx28g15RZyroHZox18K4fndpI01nB+lHiJBnLe8JlZWLwZaHDB+3r7S0XXQ8wDc4CJHj2ZgHcNyrC4ALF6pb704p3aKkaE7pb3l+b31mJu4ReDd/V/JbJ9QFtUZD1XZ39Evgb9s1sETUFEcM65bEWIs61tG2Rj0IP2SFamelKaLkgL4HXC9IhBE/z0/n6f3Fca3VHm4VBnf8IXAYq/LJ16AMR2fwWPPfCFJvMkhS9KXOMeAi2Omby8JH8gZbRnfzhXB7g+Go6sEMY1SIyXLe7ExIzYzgUkKUkIoTk7DKqpbbOa+6gUvi/Y07o3O7p2OSDaj+s38QoBJnFUAxaUnXzD8ieKjKXGH+bOW5lfMNYhaj8b9JQhEKUKrwhjp4NjKpsQQlV7nwwv9Wk88gwWAT/Tec1DycxYEboxOGs6MSjHkknbmNABNAVF8usmtS4hMp+jUs/gzjT2i7JpUWbwLLD0z5z5rSYrYlwPGFUiwpKtGLNZ3hPC9aqyeaoi4+X5WNhIrwC0oZg+1USitUYKlnpzPx0XSkhyow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(44832011)(2906002)(9686003)(6512007)(4326008)(6916009)(66556008)(83380400001)(38350700002)(38100700002)(316002)(52116002)(6666004)(5660300002)(86362001)(966005)(508600001)(36756003)(1076003)(6506007)(6486002)(66476007)(8676002)(66946007)(8936002)(186003)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?7QBbf3+PFY90fso8t4Ft3wv48PWgS9o96X0utDPAM430AoItH2Ze5JaKhPgw?=
 =?us-ascii?Q?vBCJPLHp23flFqPDLJLMimecEY46JOEj79/2eRdddNK4kAtNjVFBbVW4GD2E?=
 =?us-ascii?Q?2diFf+P5Q81ogqdNR1NQKUkUSi5xe6/XaaqhvotMOXV1LzRbH+vGGrncurhs?=
 =?us-ascii?Q?2eIO0WbiIWgH+EcsF/oaSBKJDkEhOZqq0x6WRmk+LGHxdFKtqlRJk/15bIbI?=
 =?us-ascii?Q?m1Fx65ifNcsPMNOYkmqLULPRm/Yx+uvnXJKnNJCIv+HMmqVo0VO14dot9MwT?=
 =?us-ascii?Q?gg6a0EDbQdud6VH7l9IcUUGzGV7kKARIAQ4zn5WCqwMLTD5kiItSHB5MHcla?=
 =?us-ascii?Q?d/R+dxhXpS+JD9o4hXDVm2ACvl3cAHXScJILAjAjoM6tBkQfQfj1oiISwzhQ?=
 =?us-ascii?Q?JHQx6aYrTJOtkpKEKwuMRPanLEnUqtQpfLmCqJklLTTFxYJhgMqDLsrw4vlF?=
 =?us-ascii?Q?2Nn0449OD5ViwKizm2aYqKPHqvtB0RyR6NnK3c4paBIKnumxYFjemVFTv8wO?=
 =?us-ascii?Q?gpCpXIXQ41OQrVCOb005casx6zJB8o+iOIF+GtjiSnNyjB4EYMvDv8Gapn6F?=
 =?us-ascii?Q?xRQXBOO3Jtg+JjXtrHk+kdsCnQUTg/5N/AA7w5svaQDnilSV4ZOd/pWbOAoM?=
 =?us-ascii?Q?i8juGtS9Wqm5xWfOwZ8nqh+wydD+33J4VL5EyDmQJYcAeUiXzMbLUVFKRVA2?=
 =?us-ascii?Q?ILh+NjpfzqOl+YW01F6AFAzP8m3uifZ9oGCstGB6iPvbjT5yYgoetQVK1Fm2?=
 =?us-ascii?Q?PGXCRRljN+pGsouCFDOJifS/q+w+7S7YtOdz7PvLIEVtIWF7E1L7iUcQUnfa?=
 =?us-ascii?Q?KT7RFCIaeCiMKjsrUsfjcuNs/u5fu/AgjjJ3510NKfdbcPa+OS4WNwEDOQc/?=
 =?us-ascii?Q?CPxgH5RKQTb8grduO5vv8e+Me0CkgreJU+2RrlW1zZcpnkEgj9rHVWIeD9DP?=
 =?us-ascii?Q?I2Ynx9u40jVhsTuD9TP81/W/pmvHoy6XmA1S+gSl2DmrRKu8wvATJ24KW+5L?=
 =?us-ascii?Q?pM7x0DtefMffWC1UagkIfDB3mXU6gxtHOUUauAlRIdeTzudyOGzGqPGrRLLV?=
 =?us-ascii?Q?N7oHAnviUgaVvlY8+abhGfT6Dqh7biXtB/RbJUPSy4VdpOr4JFrUaYdqtEAY?=
 =?us-ascii?Q?3Rxij8mA5IeAEZPZ2/EdirBumQ71e2sKidKayxJjIfLnAE9hCdV6BQmbSsqQ?=
 =?us-ascii?Q?7egYtzqZgXt/Fq+6zQcm4ubnqyoSi1IeZ2IQ/sKURN8SunYopxshEf1QeS6h?=
 =?us-ascii?Q?mrbeG+2Kt7AkLHQdX6MB86obYwxDSw2webQm5pBGgA22ErWOYj3wPsoVFB4Y?=
 =?us-ascii?Q?27y1mm1Rh4tU63+q1Cg9gFbCzUw1xo4SH9xZujJjJQHVShJ1UESb2wtd0BzM?=
 =?us-ascii?Q?tu1NUj7fHp2EoQZnu6TsTTu3gm+nSGqbQaLxzwwoEuNoaEfvHJQrqpGela+N?=
 =?us-ascii?Q?ToceWCgg1vnNIRP15EPAumwCz/Y3ryWffnbOLf6dMsbdW6tEfUfTT4lieWv0?=
 =?us-ascii?Q?Cu0RhKczXWlPRMNWDhTG/M2P3eGGmitcWnlv9yQGGCUUnFc7/xph4Jr9Mwta?=
 =?us-ascii?Q?wsF8YWDV2lpwugAcUTITz5pyHAskbUzkUZDkb5SYEkNc1bn+e4XtJP6ImgFx?=
 =?us-ascii?Q?BS44MEE6bOXDyHoW5t/Q15S+rArpzF1LE75EYn7loKAayB1CyqHVTdzFm9OR?=
 =?us-ascii?Q?frs23lO45nHnG0kth33RjH8vnls=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 74d0a727-96b8-444d-4dfd-08d9d02f24fb
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 09:38:35.3687
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: gZQjwWtxuvx3GqzhsW7S4PnScSMeNfFjdI/5GGYDYee2XeUNd5ERlwYmFQ1o7K8j2qUnd0SvO8Zyz6TyK6o7Xt2/nNu8f4gV+9PoHiTsm9g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CO1PR10MB4643
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999 mlxscore=0
 suspectscore=0 spamscore=0 phishscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050063
X-Proofpoint-GUID: j_yh_fk7-DFpvLcUZCvKvNHimjwh3qph
X-Proofpoint-ORIG-GUID: j_yh_fk7-DFpvLcUZCvKvNHimjwh3qph
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   9eaa88c7036eda3f6c215f87ca693594cf90559b
commit: e922057b556d37c54f8f88e44f7d7b731d6365b1 drm/amd/display: Added support for multiple eDP BL control
config: x86_64-randconfig-m001-20211207 (https://download.01.org/0day-ci/archive/20211218/202112182118.FZN5I3gV-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c:222 dcn21_set_backlight_level() error: we previously assumed 'panel_cntl' could be null (see line 213)

vim +/panel_cntl +222 drivers/gpu/drm/amd/amdgpu/../display/dc/dcn21/dcn21_hwseq.c

474ac4a875ca6f Yongqiang Sun 2020-04-27  198  bool dcn21_set_backlight_level(struct pipe_ctx *pipe_ctx,
474ac4a875ca6f Yongqiang Sun 2020-04-27  199  		uint32_t backlight_pwm_u16_16,
474ac4a875ca6f Yongqiang Sun 2020-04-27  200  		uint32_t frame_ramp)
474ac4a875ca6f Yongqiang Sun 2020-04-27  201  {
474ac4a875ca6f Yongqiang Sun 2020-04-27  202  	union dmub_rb_cmd cmd;
474ac4a875ca6f Yongqiang Sun 2020-04-27  203  	struct dc_context *dc = pipe_ctx->stream->ctx;
474ac4a875ca6f Yongqiang Sun 2020-04-27  204  	struct abm *abm = pipe_ctx->stream_res.abm;
474ac4a875ca6f Yongqiang Sun 2020-04-27  205  	uint32_t otg_inst = pipe_ctx->stream_res.tg->inst;
474ac4a875ca6f Yongqiang Sun 2020-04-27  206  	struct panel_cntl *panel_cntl = pipe_ctx->stream->link->panel_cntl;
474ac4a875ca6f Yongqiang Sun 2020-04-27  207  
474ac4a875ca6f Yongqiang Sun 2020-04-27  208  	if (dc->dc->res_pool->dmcu) {
474ac4a875ca6f Yongqiang Sun 2020-04-27  209  		dce110_set_backlight_level(pipe_ctx, backlight_pwm_u16_16, frame_ramp);
474ac4a875ca6f Yongqiang Sun 2020-04-27  210  		return true;
474ac4a875ca6f Yongqiang Sun 2020-04-27  211  	}
474ac4a875ca6f Yongqiang Sun 2020-04-27  212  
474ac4a875ca6f Yongqiang Sun 2020-04-27 @213  	if (abm && panel_cntl)
                                                           ^^^^^^^^^^
Check for NULL

474ac4a875ca6f Yongqiang Sun 2020-04-27  214  		dmub_abm_set_pipe(abm, otg_inst, SET_ABM_PIPE_NORMAL, panel_cntl->inst);
474ac4a875ca6f Yongqiang Sun 2020-04-27  215  
148816f93fa0db Wyatt Wood    2021-01-18  216  	memset(&cmd, 0, sizeof(cmd));
474ac4a875ca6f Yongqiang Sun 2020-04-27  217  	cmd.abm_set_backlight.header.type = DMUB_CMD__ABM;
474ac4a875ca6f Yongqiang Sun 2020-04-27  218  	cmd.abm_set_backlight.header.sub_type = DMUB_CMD__ABM_SET_BACKLIGHT;
474ac4a875ca6f Yongqiang Sun 2020-04-27  219  	cmd.abm_set_backlight.abm_set_backlight_data.frame_ramp = frame_ramp;
474ac4a875ca6f Yongqiang Sun 2020-04-27  220  	cmd.abm_set_backlight.abm_set_backlight_data.backlight_user_level = backlight_pwm_u16_16;
e922057b556d37 Jake Wang     2021-04-01  221  	cmd.abm_set_backlight.abm_set_backlight_data.version = DMUB_CMD_ABM_SET_BACKLIGHT_VERSION_1;
e922057b556d37 Jake Wang     2021-04-01 @222  	cmd.abm_set_backlight.abm_set_backlight_data.panel_mask = (0x01 << panel_cntl->inst);
                                                                                                                   ^^^^^^^^^^^^^^^^
Unchecked dereference

474ac4a875ca6f Yongqiang Sun 2020-04-27  223  	cmd.abm_set_backlight.header.payload_bytes = sizeof(struct dmub_cmd_abm_set_backlight_data);
474ac4a875ca6f Yongqiang Sun 2020-04-27  224  
474ac4a875ca6f Yongqiang Sun 2020-04-27  225  	dc_dmub_srv_cmd_queue(dc->dmub_srv, &cmd);
474ac4a875ca6f Yongqiang Sun 2020-04-27  226  	dc_dmub_srv_cmd_execute(dc->dmub_srv);
474ac4a875ca6f Yongqiang Sun 2020-04-27  227  	dc_dmub_srv_wait_idle(dc->dmub_srv);
474ac4a875ca6f Yongqiang Sun 2020-04-27  228  
474ac4a875ca6f Yongqiang Sun 2020-04-27  229  	return true;
474ac4a875ca6f Yongqiang Sun 2020-04-27  230  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

