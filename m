Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4F3B4D2EBA
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 13:08:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232675AbiCIMIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 07:08:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232660AbiCIMIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 07:08:39 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 632561DA55;
        Wed,  9 Mar 2022 04:07:37 -0800 (PST)
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 229BO1Im010464;
        Wed, 9 Mar 2022 12:07:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=nYnfIa+quUKp6C57h7AEwMQvPhbqYIMaN0P/ZfGERkw=;
 b=H2sTAm/34Oo/ur5BFR1DC66C/V1oTtHLRIJ5VJbHoXzgI0p+ecTWzx3wF2ij4cN+ePl3
 Yq8TO9HjDr72Peimw6j51WXgzLojnzdsnB5aX7Wt7dMlq+lQ4nbhsLTEvvsLotcQklkg
 uxMAjvWRUZl+maN9+2T1lZipHcO8Kl6yIUXT6k+FreVuA2IqVMIgN0wGw7U9nqd5sdiC
 6uCL6aRm3dnsygrnevnsyYXiGade8Pa1JGg6bQAWklzD5/dQ5P1F5tSPHuVDBtSonDsU
 kr+rwlNNN5F9Y6S+dMu/5tDffsLaCoaBTZlEn3quBziSqp+f5FFRd9BEjRUIDz6c4X98 Nw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ekxf0sw1f-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 12:07:15 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 229C6VZg061808;
        Wed, 9 Mar 2022 12:07:14 GMT
Received: from nam11-bn8-obe.outbound.protection.outlook.com (mail-bn8nam11lp2168.outbound.protection.outlook.com [104.47.58.168])
        by userp3020.oracle.com with ESMTP id 3envvmeh30-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Mar 2022 12:07:14 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FerKAgnzhky37KBQko7XNq4Si7ALOxbZrigE5tKZUSUHS24qb3phJUN3yqO5y1U3ZPW+Xt3b1yEvDT4htXEOTv8I1bieg0rrbbU8mIBVRryqNH5U3+zkQ85oKhRTcDq5bDoRLF5BdtsZ7msx4YQAjFWvlBHLxxXI80XYzJ9k/XYpYL4uzPUJMFhUeQDMsh2F92EZkZI92YuPATZiZj2o6APxVxcIs0qpqAHg7lLP8C5S6U+U9Z39U0ixiA5H5/fLwQYRwvlC+x5/cvBzNXG2Q9cHSJu48Spc59Y6k9Yrv860ZEePcUhve3F9iDhtUp1LPPwOckYM60es2rEZgNqMzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=nYnfIa+quUKp6C57h7AEwMQvPhbqYIMaN0P/ZfGERkw=;
 b=b6E6f5iQBpM8UzbbBJ7nnU5x8PVZ4b8BBXoIELYISRoOkTyGzTFR0v+7C7a6l6X/DUH0MQqFcM6ej/fo7gxa2bGtj5rD8zFtDGIImFf5a2KCwZqpJp02kAJySBns7qU3u4S3J/QkWcG2QFpDZLmy9q1W2YyRz/DOyndlc3DU+AtAnQnYDIEnSJ1G0JMNeiqWoeHgXRT3UwWSIJ75v0wywIwGYJcqGw+5gRYmPqyNOBWO6tcz4tyWex8pHKfpQoCw2Zoj4ntIvPcyJIPIqS1Pe+bXS9wV0yXPb6pKNQydKQmIA1haYkpEeOEP1hWTgaZQbjyJrSK3jXa3oLQU4N1fTQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=nYnfIa+quUKp6C57h7AEwMQvPhbqYIMaN0P/ZfGERkw=;
 b=rQ7mNyqsDjaDpmKtnjkhVfo77iCBZ6jVwY0DwEYioaSoEfTld6tddEe7yJszxnKQBB9IlKImf3m93DneQpoB25In/6Kkx+jUeXEBCpNLPWwflKWNAG8taNBsmwRdU3Pj1sa0vCFcw0vzAaBvo13satCgv0TM6BCr8cQ6W+SGCuU=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BY5PR10MB4067.namprd10.prod.outlook.com
 (2603:10b6:a03:1b4::25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5061.21; Wed, 9 Mar
 2022 12:07:11 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5038.026; Wed, 9 Mar 2022
 12:07:11 +0000
Date:   Wed, 9 Mar 2022 15:06:54 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Ming Qian <ming.qian@nxp.com>
Cc:     mchehab@kernel.org, shawnguo@kernel.org, robh+dt@kernel.org,
        s.hauer@pengutronix.de, hverkuil-cisco@xs4all.nl,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        aisheng.dong@nxp.com, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v18 04/15] media: amphion: add vpu core driver
Message-ID: <20220309120654.GC2592@kili>
References: <cover.1645670589.git.ming.qian@nxp.com>
 <4d2fb002750d21804dddd89de3a5e6f3462123e6.1645670589.git.ming.qian@nxp.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4d2fb002750d21804dddd89de3a5e6f3462123e6.1645670589.git.ming.qian@nxp.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-ClientProxiedBy: ZR0P278CA0195.CHEP278.PROD.OUTLOOK.COM
 (2603:10a6:910:44::11) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d0cef66b-4cc7-4f6b-95c9-08da01c5578e
X-MS-TrafficTypeDiagnostic: BY5PR10MB4067:EE_
X-Microsoft-Antispam-PRVS: <BY5PR10MB4067F9FBC19A3F182603ECBD8E0A9@BY5PR10MB4067.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JTWknOP5MwzZg5Ze+ncZ9rut0HNeu6FtCZvNME84ZnPqEbPXo/pr9hBHZcru6pSb1PqSuAO8FAJF/BNxYIsr66zrZ+8MxAij4o3y7kl9pX+LzyEVDYD4+BLQtsT7aolrX23/qf8bgVRaecPxR5hnfxqm24y/8HeVLZWd5ayM/uvwzRuEa4WKpT654WRcn70I0ZvVpgrH9OPu+esPgNmQvlVpU42lufuCNCxCYA02hd+pEQfYp84pM5GOpN55D8D2rlu++rAe7TmXurFE4Zc1q+4Q6p785LhlQJ5SLz4qcjSjOsM4t9nbMFoFR6NN1au+UhJkqBp/rB4FiNjKqgAhuRKD/0sO7JNoNPAt5dvvnCyuBjxtdgOt+UALROHOtrM/qUrsLXRhU2lmVb/L2TIegEOm3qqS4f5rBFCw2zkTEIEhsbcAEgtDUDbuqlhG2iYsxeB5yV3n+rBCrd9MX/FqInGV2iF72ssc9S/pABb/n2mct8lzyU2WYEwn99/Yrukl8Ma4m+divT78wQBeZai3BI0PSFR80XiUn81Vbdv9Dy7dhQnx1w9VOkhA7Xkj5t1Bc+aIA94POOP9Dl2uFCYs0qcY1dFqJurH13Jo8/z+sC6f/2K0F9Jb7tB8u5aqU72jA4ond5yeL12CAb3lHVDLhSRlZQGwrrprF0we/vm9Tcfkhi0wNqi3SjIWE+wRxZKyDhcp5NuT6EZQNmlp4jWTA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(1076003)(186003)(26005)(6486002)(33656002)(316002)(6916009)(6512007)(6666004)(33716001)(6506007)(52116002)(9686003)(508600001)(38350700002)(38100700002)(86362001)(83380400001)(44832011)(66946007)(66556008)(66476007)(2906002)(7416002)(8936002)(5660300002)(4326008)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?CGbCPGPDdRF6YmRdL4LUNpXLd9JnICuXFOyNr81fDPytPWD4uF1poqPUQOyx?=
 =?us-ascii?Q?/1vxKg9T+FW/ajiybyq4QcDvrkrnqJpOBL0lMlOEwmFF29n2unpV3zrq0xF7?=
 =?us-ascii?Q?3TQXvQxSzJjdlpgvO/dcDNO5xc7QJ9pEPPqfp4jcse8iWnVEIcmcER73oSp+?=
 =?us-ascii?Q?DAXpkbb5kQdR3vUlNuCH0dIHdqKj29hSPON3k1HCxdwUZwPTZvQnVirrbFbN?=
 =?us-ascii?Q?9jPKJ7uvyWea0oApnXVjMJdK7aFIXMZN1EweVEKX10Mj3tSbxcrYDyGB6bFc?=
 =?us-ascii?Q?mlTtVcPWgFUAjQ1iEbaeFqoT5KUTsvyRahK2Sbuj3mg/oexSg9g5ggzAd2yO?=
 =?us-ascii?Q?umneZWEZoClTbwhGx9/1hjScc9SY77smiXBKGa6fuvi21+cV0gRjCmfwlDLn?=
 =?us-ascii?Q?MLGLkQ0eakJ3GrPNnVTG/y3raxvlIk6oBDKX8VF/SgUoxn3Q3DZAIVEEMZZl?=
 =?us-ascii?Q?bhTU3Y6R9Xw3J69t9mbB+hsYRJd09qASgQO5pGiDyv7xUvNcwEGDjvnUwXjH?=
 =?us-ascii?Q?Aw3Xcf7bINq9kGQZORElH+7OIYt1Ndb+xp1yeU6cL9VD2V3ygWrEOFqXRejf?=
 =?us-ascii?Q?doSMJinSvU60E5ODj+6VjzBiH5+f/E91HWDNZqsL3nElCD1QVhrtpT5zXIMb?=
 =?us-ascii?Q?tD2imv3BZ/JLVpIDQo4fxgDQWaclMHEsIjiRg/1XWL9YXK46Wfw0hd/yYFSd?=
 =?us-ascii?Q?XlsROuWxe556pizF+GptY04k4Tze/zr57e/iAPMyohq9aZnu1EOZZ8sm3yX3?=
 =?us-ascii?Q?/wmaUOK5748E1qw53L+FF7sUf712lADequjrIcY6G9EINDfGYfbkzyYUrl1y?=
 =?us-ascii?Q?tBS/h0VMnw2euiSkpf/Zy0xcT/y9VEax6ny7+1AL2DE9fUme4TRTrJiXUM4Q?=
 =?us-ascii?Q?3XuFzjkp1bL54rXwNlkrFWiz0SExqFkYAOnvBFEeTC678VXzJZFteZ9n4fci?=
 =?us-ascii?Q?+TRQxrurcor0RHkv71aMzUS38aQTt+8rE0Qx6qZ3vRuiotwytecLzDQWx3eq?=
 =?us-ascii?Q?zFMXelfSAjFGuCyCfdrFb8iBXtITAHCz+nuiOpKk2uZDqByw31PJx8rmemz2?=
 =?us-ascii?Q?MzXZZ0YEYVKK8X4x1jcqAFHymnW3BZR9wP4oEF1YL2eQrEK+tRI1D2/Bq6ar?=
 =?us-ascii?Q?fzFLt56miBHBzPDixz30D6HEwAm9WvDYxHMca2vPnj/0kXLHFzXhI4bncEfB?=
 =?us-ascii?Q?tAAGVVyCN6nKCBzhq6TnWiujwmMvRGp17yjgBc+J2CDud4WW6XMgBKmG2PLW?=
 =?us-ascii?Q?oAZHAkMidquPvZyLV9wXCX5YnsuHNqSPA6MJPDLLXZToNZQGFA25rc1cv/OM?=
 =?us-ascii?Q?gujgqKBIWIAfIN64gNHsVZCg3JDfAuTmRJr8z8FFVVvlREiQqgD0neyg19CF?=
 =?us-ascii?Q?jRLciXaV0WQScWUecYHJoEFM9l/+v8Yrq6lQsPm9eKIkHoMnX21PpXbU33Mw?=
 =?us-ascii?Q?gtyyoedLer/1v3gES1h0G3WWqh4In9jhSjpz8m0BXxIlZ6PTbghCdg=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d0cef66b-4cc7-4f6b-95c9-08da01c5578e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Mar 2022 12:07:11.7368
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tgUvicgjVF7tWvU8gUFpmW8P/gdvDJ0ePPbeV8TGZ1Z/xvpP8n3WF2v5VhmYm1EdQlLq6mhRkuhxVlsUsDEWM4undMsapKeWw77lPWosXv4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR10MB4067
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10280 signatures=690848
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 suspectscore=0 mlxscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2202240000
 definitions=main-2203090067
X-Proofpoint-ORIG-GUID: Ffv81NIVrIKXVfGAinr9c5nQY9IOPxKL
X-Proofpoint-GUID: Ffv81NIVrIKXVfGAinr9c5nQY9IOPxKL
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 24, 2022 at 11:10:02AM +0800, Ming Qian wrote:
> +struct vpu_inst *vpu_core_find_instance(struct vpu_core *core, u32 index)
> +{
> +	struct vpu_inst *inst = NULL;
> +	struct vpu_inst *tmp;
> +
> +	mutex_lock(&core->lock);
> +	if (!test_bit(index, &core->instance_mask))

The "index" value comes from vpu_handle_msg() so I think it's untrusted
and this test_bit() can read way out of bounds.  It needs to be:

	if (index < BITS_PER_LONG && !test_bit(index, &core->instance_mask))


> +		goto exit;
> +	list_for_each_entry(tmp, &core->instances, list) {
> +		if (tmp->id == index) {
> +			inst = vpu_inst_get(tmp);
> +			break;
> +		}
> +	}
> +exit:
> +	mutex_unlock(&core->lock);
> +
> +	return inst;
> +}

[ snip ]

> +static int vpu_rpc_send_cmd_buf(struct vpu_shared_addr *shared, struct vpu_rpc_event *cmd)
> +{
> +	struct vpu_rpc_buffer_desc *desc;
> +	u32 space = 0;
> +	u32 *data;
> +	u32 wptr;
> +	u32 i;
> +
> +	desc = shared->cmd_desc;
> +	space = vpu_rpc_check_buffer_space(desc, true);
> +	if (space < (((cmd->hdr.num + 1) << 2) + 16))

In the current code the math here cannot overflow.  But it seems like
we could easly add a check:

	if (cmd->hdr.num > 0xff)
		return -EINVAL;

> +		return -EINVAL;
> +	wptr = desc->wptr;
> +	data = (u32 *)(shared->cmd_mem_vir + desc->wptr - desc->start);
> +	*data = 0;
> +	*data |= ((cmd->hdr.index & 0xff) << 24);
> +	*data |= ((cmd->hdr.num & 0xff) << 16);
> +	*data |= (cmd->hdr.id & 0x3fff);
> +	wptr += 4;
> +	data++;
> +	if (wptr >= desc->end) {
> +		wptr = desc->start;
> +		data = shared->cmd_mem_vir;
> +	}
> +
> +	for (i = 0; i < cmd->hdr.num; i++) {
> +		*data = cmd->data[i];
> +		wptr += 4;
> +		data++;
> +		if (wptr >= desc->end) {
> +			wptr = desc->start;
> +			data = shared->cmd_mem_vir;
> +		}
> +	}
> +
> +	/*update wptr after data is written*/
> +	mb();
> +	desc->wptr = wptr;
> +
> +	return 0;
> +}
> +
> +static bool vpu_rpc_check_msg(struct vpu_shared_addr *shared)
> +{
> +	struct vpu_rpc_buffer_desc *desc;
> +	u32 space = 0;
> +	u32 msgword;
> +	u32 msgnum;
> +
> +	desc = shared->msg_desc;
> +	space = vpu_rpc_check_buffer_space(desc, 0);
> +	space = (space >> 2);
> +
> +	if (space) {

It would be nicer if this condition were:

	if (space >= sizeof(u32)) {

> +		msgword = *(u32 *)(shared->msg_mem_vir + desc->rptr - desc->start);
> +		msgnum = (msgword & 0xff0000) >> 16;
> +		if (msgnum <= space)
> +			return true;
> +	}
> +
> +	return false;
> +}
> +

regards,
dan carpenter
