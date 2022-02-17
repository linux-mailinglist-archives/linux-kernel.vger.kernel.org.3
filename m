Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5EF4BA0D4
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:17:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240786AbiBQNQX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:16:23 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBQNQW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:16:22 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DEC2AE2AD;
        Thu, 17 Feb 2022 05:16:06 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21HCrki3027723;
        Thu, 17 Feb 2022 13:15:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=ZrInU4hItlZjOkBPHqlTEQwgyIIJtR/yr2S9Qvtns0g=;
 b=njoJwE3XsiK6DMNoqRSHknFJscIQCyEtZZpsuLGPO6qQg0p1cVgySHVwrIiLRe+4DgmO
 L2edUTffpPp77MzInzOUFpTz2E6Q8DRbBJo9Y23jfksIyeR0r/wtH2lnQesgP/zAzY4r
 wF4z4q8tOol2nQWnQWkjKxdLO9CzXqN8gfkLsiCCCfMT1varkGIT4iJb5V5i7QK5qHLe
 wjXKFtGu3knG4RZ/lr/HId8OJ3QqVtH15Xozy/0UNcpic+ymgFP5RmUyBsfX2Ck1hoPt
 jeN80F+fpcJRv+dLNzoYDbLIITwSB6SH7Ovf5lc9KImJcKptuc2d8YmutgEkevt4daV8 Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e8nr95wmu-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:15:01 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21HDAdPg185744;
        Thu, 17 Feb 2022 13:15:00 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2044.outbound.protection.outlook.com [104.47.66.44])
        by aserp3030.oracle.com with ESMTP id 3e9brccs9a-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 17 Feb 2022 13:14:59 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=eubhKq8vssKwTHpZsGdOQ+DFKzpyfr9RUhebxg4OJp6rRgSjzX/j4HhKUuTRyDgqE+waRhtG8Zyz+BlX9SmaZBfbLL0qTPUubcJWIZtA9gc1Z+rjfwPCHndhy7Yi1omeWKhXNKJ7GICPX1WL483wb96b3bgX3hO+oF1woc9u5mC+zm7Gn71YEXCt0cdV/2rEk7SGJJNtQzcnwOwBqY6G1dSIuj57rjhQP3xOBPpuh2czE8wBAxllUSPoYA7rZSUqVAn3iBWlrIxidkOUTEHKW+LgndBg5hjAd8RlruUL7+p5WuBrFZ+7yAu99g/hPjr74hpcT7mCiH1UJUNZec5PWA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ZrInU4hItlZjOkBPHqlTEQwgyIIJtR/yr2S9Qvtns0g=;
 b=UeQ1dfGZIKlht9KnJgfE+v8nYI+NfwUmuAyktJO7GTRyILIleT2KyP4vbQAarkpO7m1MzwfhmvXCjH1cGNhglUYpdJcR4vEMDobg7BP/RkUdXQvAjIVaaLxBDCTt1iYJY2I8S1GOE/0vlgFE9oS7I1e9BFMb8O1LR39tNYbvGzMJ1ElCvWCfrkFU2dP1QzZAN/JWYY4ncmDcqGXaw2uRVJY4WQdb6EW88f/ije7ymRa8ylF/rGxkr1FmKltC+nmifIX0G4Sx/86K7ql/7fRo/8pK+f9jxq4zLfeHED+rGuescw2PW18ZHAFoIYQYeFStxtHUAadza7DJzH1UhPYGHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ZrInU4hItlZjOkBPHqlTEQwgyIIJtR/yr2S9Qvtns0g=;
 b=mbkqBlwh1v63dVAFdJ8quXdWA/TyqY0d5+nQWY57QzVQysxGydh3LjJYke8oSHi1c16nQDalWd/Xjv6/bOrStnCjOcTa076MIvXj3fC6bVUYQNSfNCr75k1rc/i+TBwG5UX7mWmxcAIQRYd1KnZprbJOC5pSCGWA1iwyQwIeFr8=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB5337.namprd10.prod.outlook.com
 (2603:10b6:610:d8::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.16; Thu, 17 Feb
 2022 13:14:57 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%3]) with mapi id 15.20.4975.019; Thu, 17 Feb 2022
 13:14:57 +0000
Date:   Thu, 17 Feb 2022 16:14:23 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        agross@kernel.org, bjorn.andersson@linaro.org, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, quic_plai@quicinc.com,
        bgoswami@codeaurora.org, perex@perex.cz, tiwai@suse.com,
        srinivas.kandagatla@linaro.org, rohitkr@codeaurora.org,
        linux-arm-msm@vger.kernel.org, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        swboyd@chromium.org, judyhsiao@chromium.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        Venkata Prasad Potturu <quic_potturu@quicinc.com>
Subject: Re: [RESEND v13 07/10] ASoC: qcom: Add support for codec dma driver
Message-ID: <202202151059.hEuYfkLa-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1644850708-11099-8-git-send-email-quic_srivasam@quicinc.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0049.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4e::12)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 58b05a58-593c-4edc-1864-08d9f2177e76
X-MS-TrafficTypeDiagnostic: CH0PR10MB5337:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB53376DDB62DE8EA82DC362EC8E369@CH0PR10MB5337.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:6430;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: WQXrakzkuHXRMlSTWTheJ0aTTISaIwYe1abQvOO53w6eGkzmedvsUDvKey08BlNCam/trWRJqzghM69f+rFi7Li2C1RUfdwI+zasLMJ76UQBUfgA2Gn3Q+WiXB9pnjNj21Ulaqizy9jBDDZIRr88rBZGPk/2t6pQ3euFY26bVrZ3rv2+1XFXE+bh3dkuwy57k6nZy7deXnHavql/6JxkMdYg+iuqq9qfgh8eCYp9UDEcafrF9D81JBf5z8INC/AZm2kGDaI3CfnU51c5fifSJtXeQoY0B2KBcm2SRAuv6akEdHvEK0/P3emTegUGdH3Wu66+TV38lgAfBcVSzru/tfkhBh5T3Fv+o7jNTjFEkQEHuP6GvPespqWnpGrjuxATHhWE88Ec8c+1L6N/r35iwZEGD+0bKOOtmhqEziwltYbGl7+3MFbwVwzIHiAp14xhZTVvqoq74u72Z7W3OfbQkHA36JNMNICJjG1hpSMqq/XNu4T6y9Q7YFAE/g2zdwPl+6Sg6M2ERmR9RZlwSE3eAnNeol2jqwJhzN51mmyH1UT+cjcbAm5fErMv9ZML8Zm4WOqV0MqjTHcZ4WSa3s1daspqNukETD3lSmjfLgxRLHQrvX1O/BYt9RFLqv8fgRpqDXhIEcOGvaQvP/B9AR9yFxSONJkRLr9IhvUh+MWgjUUqBqtX/AXrUCtQVS+DRKeLlGdCaOofpDgka16KEQ6ZPxXMWiSe945dF+IwCDMmaD8JRvonzkT5FCtvkBeD83zCQumR8/1YQm54zgf7sgfUrTtOkR0o7jXx1bupbEY8/M3b8N4qG3c0S9tu8I6c6CU9DhuGEBm3JqhqZNv+Ghezr7H2ow2vo/Q1yHPhBlfKn/4=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(2906002)(66946007)(66556008)(4326008)(8676002)(66476007)(921005)(508600001)(38100700002)(6666004)(966005)(6486002)(83380400001)(7416002)(26005)(186003)(44832011)(54906003)(316002)(1076003)(6512007)(9686003)(8936002)(52116002)(36756003)(5660300002)(86362001)(38350700002)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nAwtlvVmxXfPiRNZRrBOeZDK8kYPpvrCjk4lK3hHsk2FbkQyBXswHqwlqGL/?=
 =?us-ascii?Q?my02pQO8lwvRodPgWFcM8nXn53LULy9U0uE8l7y23PjIBkQRC+331qxk+pd8?=
 =?us-ascii?Q?mpzshDp+Q85YzPx/yXeNGeYMdeo3C6tul8vtyABAEC37des/+Ob27K8FD7v3?=
 =?us-ascii?Q?gh11URduZwvoTKWO1SkxqQMYCnTl+fL3MwUPoZMLMbW43/DJ+k9epZ+SHbzq?=
 =?us-ascii?Q?iVDT9dAIxQCm4nR0/sBDydDphRfsW1rqVTddgEjelZA8fp759rp8pyHCB0Sp?=
 =?us-ascii?Q?SBIpGUjslBTpnOXFea8zyGYoJ7xoQHBRRNhAwtUqQBjBWihHz73lxVXAm1yk?=
 =?us-ascii?Q?viTq1lKE3uhJhz0qqovfuUbq4nGkCW0w18PpLzkslLrdyINbVt2bb32EANVa?=
 =?us-ascii?Q?sZb8fiAZ5H84XvLhN9wkG4b602QlfV5FGyUpKd4lMX0/OaI6QfmjRH34hj3s?=
 =?us-ascii?Q?IECJV1d9tjuCqf8OUi+vLEMoD3QVs1tP5Rmgt+PTJhAbXsv70n7w9t7kA7Zl?=
 =?us-ascii?Q?3GB8U+KJ46WPArtx/NI4uGlAbyPIWRawMgk7wzfzZdmiPkNXt6unXEvfqgoh?=
 =?us-ascii?Q?JJ4SbOHbwChxvyC3vXlJ4k20LuWEzWbIJyQAfMcN9k1aALAp11IFj1+toi4Y?=
 =?us-ascii?Q?M+iHjgmRr/279Pn2t09xt+4chjN5BnnGImgK/EjsXEHCrGzzL+Vz/P23stCD?=
 =?us-ascii?Q?DdHFU1GrAcBKvV9EfMCHZdDGkO5OfACRn+q0OyvJIM4zNhsr3jMf0k69RPzH?=
 =?us-ascii?Q?/dohWcCw8gis4WXJtHKPBEpCznC5XJfSpIxczpLMNzlbWDMFe+xJOljHDD1a?=
 =?us-ascii?Q?HthcItt7j8WXe9VyB7c3wmH7PkeX8PUnI2cRj/vVGci2sEI6VfRqQGPO9tZH?=
 =?us-ascii?Q?No2VsRkgPlv9OJlhSsopnv3akWDKZUnefZmeRwqY62T7SRUaYqNjA8JFQQjv?=
 =?us-ascii?Q?lzDRWKYrHXgkPr89jhEIpcQXqmJHx4ur4V86WsDI1pW2OYTlIHRVOJ+ORrZQ?=
 =?us-ascii?Q?wwRdfWCjurFTQJjnUVTkyDRoIBx3UHijW39wjX78AdWDdZ/H7DfUUU5YOWfo?=
 =?us-ascii?Q?SVsUo/Y4MYow1W3pKp0E/5K7GU2c6ZIEWRJ9TiGdRX5QYSm3XOgzCd7CeEdN?=
 =?us-ascii?Q?C3LKHRvaWLp8gPx9JLzNlAF0T2xFJio2DsJGdZGAlgNsBGsNpLuIPJcGwqXB?=
 =?us-ascii?Q?etCtCIqBV5n/0pt2wDRhAw9c8uk/F8+D1wHEbtjHkHX269Vd56LNEMM+gdFZ?=
 =?us-ascii?Q?l9hsMeAX2zb/NJHeNPX//AuYcYZ9m8Rk9NGAq1Z815LmHje0TkXBIa37Ap1n?=
 =?us-ascii?Q?5Zv9ClnG4p4h3FrOZd4UN9gturzl6tljPVUb0Fy6iImA2Cp0BSCcDuC5AgP7?=
 =?us-ascii?Q?Brg3BIXyhaXR2qTrK5Mqz5XFnz+uz1emN2dh3U0TgkgRSbVYZzfmoSPexqmH?=
 =?us-ascii?Q?EgHd80xLsxk07uTgb0k9501odxsr0lmSIuSdJZTUPCue9hgaZpCKLVeFxrXd?=
 =?us-ascii?Q?ycdw2A5tHYTUN+UHTqvWYeifkIrHkjR5/zMajS9ngzePiQpNwI/f+NzToNyu?=
 =?us-ascii?Q?JFcLQfmVCUH83f7o2OQD/z6Q7q4txOCB+9Djlk9Gx2U8Eq57xFLYdrdUqaon?=
 =?us-ascii?Q?jut9QDvCLGsnnJCPXfr5S9lTuNGDNG4yQWqru9PSIGayoiG+u2RVjXkcwbmX?=
 =?us-ascii?Q?CemFUw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 58b05a58-593c-4edc-1864-08d9f2177e76
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Feb 2022 13:14:57.1973
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yPXjENbq6KIb6uDdKJb2GwB3yIFtMLT7uvUf0YhRaOuAc2UqDbYmsHiBPvZ2o4Jb31sYDfkVFd+xwDSdzQSlukxGzUYbXEd0vjOtSvxmpKA=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB5337
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10260 signatures=675971
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 suspectscore=0 mlxscore=0 mlxlogscore=999 malwarescore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202170060
X-Proofpoint-GUID: 3Nk1RqjrH0O0B4q0KhsN-AS6C9PdgzSB
X-Proofpoint-ORIG-GUID: 3Nk1RqjrH0O0B4q0KhsN-AS6C9PdgzSB
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,HEXHASH_WORD,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivasa,

url:    https://github.com/0day-ci/linux/commits/Srinivasa-Rao-Mandadapu/Add-support-for-audio-on-SC7280-based-targets/20220214-230256
base:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
config: m68k-randconfig-m031-20220214 (https://download.01.org/0day-ci/archive/20220215/202202151059.hEuYfkLa-lkp@intel.com/config)
compiler: m68k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
sound/soc/qcom/lpass-platform.c:1233 lpass_platform_copy() warn: maybe return -EFAULT instead of the bytes remaining?

vim +1233 sound/soc/qcom/lpass-platform.c

e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1210  static int lpass_platform_copy(struct snd_soc_component *component,
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1211  			       struct snd_pcm_substream *substream, int channel,
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1212  			       unsigned long pos, void __user *buf, unsigned long bytes)
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1213  {
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1214  	struct snd_pcm_runtime *rt = substream->runtime;
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1215  	unsigned int dai_id = component->id;
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1216  	int ret = 0;
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1217  
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1218  	void __iomem *dma_buf = rt->dma_area + pos +
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1219  				channel * (rt->dma_bytes / rt->channels);
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1220  
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1221  	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1222  		if (is_cdc_dma_port(dai_id))
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1223  			ret = copy_from_user_toio(dma_buf, buf, bytes);
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1224  		else
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1225  			ret = copy_from_user((void __force *)dma_buf, buf, bytes);
                                                                                      ^^^^^^^^^^^^^^
Positives are treated as success in _soc_component_ret()

e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1226  	} else if (substream->stream == SNDRV_PCM_STREAM_CAPTURE) {
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1227  		if (is_cdc_dma_port(dai_id))
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1228  			ret = copy_to_user_fromio(buf, dma_buf, bytes);
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1229  		else
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1230  			ret = copy_to_user(buf, (void __force *)dma_buf, bytes);

Same

e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1231  	}
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1232  
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14 @1233  	return ret;
e81c7e5d842d2b Srinivasa Rao Mandadapu 2022-02-14  1234  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

