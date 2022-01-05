Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06154485002
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 10:28:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233857AbiAEJ2R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 04:28:17 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:59518 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232432AbiAEJ2P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 04:28:15 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2056f2oU008818;
        Wed, 5 Jan 2022 09:28:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=ojCLby2/K/IbZpo7zUMjQRAwWX5WDSDy5KSaYkUouqg=;
 b=YOraIhn2SKYRX+1HyUa4i0LEqIL61LnpBV5v+8cibbrIKp3YarFpMR1Kep6c5cwtrhfj
 h0EiCTubal/q0KFMhwkdSZlctACorFsyMYXsveVfn4Z6vHP8bdw2Fg8MWs4vuCVrobZb
 Hro7TQ09pP+KPGVrx84MA+eepxOIbwIrsbpOxqVOF8F0CTNr5BohK6JjKjskN+ZZUgyM
 +jJrYZhQCmb9PoI7iOCSlIQSezwS8uoxQGzp9HztCeK55oeGrHp0Vk5VLbRZNTrYFWLa
 QM8hd75hDHSasNfpuwewp0ICf8mq8shfDw0kdJYHshMPPMJbMvRDOQLJ2Qzw8gTSzmSs Yw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dc3v4mcp4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 09:28:11 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2059G7cc090781;
        Wed, 5 Jan 2022 09:28:10 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3030.oracle.com with ESMTP id 3dad0eqfew-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 05 Jan 2022 09:28:10 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=L42fwiW56sEdghmN5aEYvOiDdYIGAAFdK0NP76a7s4FZeXuFspXlBrbRRDulLYM24wEjaiJhPw2yTSy45hwfpa5QYd4tHlrWqfB7c7hMXTHrfi3c+AJDo7cC+EfAHFXQmD8yw+sR//lMjMlJyxkkI+qWfYzVf19SkHfrXkU2fWcJk9Bl/+HyFgwLcRGo72cmWawqHYnRd6voYTvjvZXd3BVAvpDnsTOURlZ6LxVaFKghEgXTX24JDp8AlpSfiHoTRXzilVHTh3Zn9cc9W1jr8XOS7ZaoJMOAofqVP3AZQu7+mQQ2P969/24dZp20b4I+jGSGHhyP9Ymbv5ncExF+AQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ojCLby2/K/IbZpo7zUMjQRAwWX5WDSDy5KSaYkUouqg=;
 b=ZOHvBv3SmeVgiofVyU6CIDvlHMd+FvjLDU5qDZzkF5CPt9UZCcvt10Y4/Zg0QLhPsuzQ7LEr+fgCs5EEajx+5oipvW5ZbaW33ixdmXhU2Wxak7DKQwr5+kpymBOn2Gn/ZAw7UiT2yYNnsyf2Xrqd5LtaPG4MUkP9zcv+lVuFWKu4vBgn7FQO/44PdSNnhk7h0KPnNRVjTyUBwrzNIvT/3kW0R4apNTXAQaYLtONDIaPxklVU1oE15DH+xWOgbBsQon+cutz2WuIKPjMhhlpWnU1DvSApVwCrkwHdg89UFmJVhHporsIQRlluDfcbxXjxMp65qFAgZ4HxdVQdpU1IoQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ojCLby2/K/IbZpo7zUMjQRAwWX5WDSDy5KSaYkUouqg=;
 b=rXtQxoXHPVfL7NGPCSch4Nain9hAQBBo/F7tnlf2p14dl7TXThGLLwjRybjLZ5j/+wbr7Ntg6dBexR4fck+v2PpMhIcO03CTIzd2JE5DzaZNK5ueAqYPiCypln68YVoTrX7Tcy6DnagDTEdJVG547VFEGvqh5rtlmM/5P72OuzY=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1295.namprd10.prod.outlook.com
 (2603:10b6:300:1e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4867.7; Wed, 5 Jan
 2022 09:28:07 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::b889:5c86:23c0:82b8%4]) with mapi id 15.20.4844.016; Wed, 5 Jan 2022
 09:28:07 +0000
Date:   Wed, 5 Jan 2022 12:27:47 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Jake Wang <haonan.wang2@amd.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Aric Cyr <Aric.Cyr@amd.com>
Subject: drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1018
 dce110_edp_backlight_control() error: we previously assumed
 'link->panel_cntl' could be null (see line 977)
Message-ID: <202112181037.uydEtc7w-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0025.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::13)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5d18ec73-a3e7-4996-13ff-08d9d02daea8
X-MS-TrafficTypeDiagnostic: MWHPR10MB1295:EE_
X-Microsoft-Antispam-PRVS: <MWHPR10MB1295C0EF1BB7BD4F39D924658E4B9@MWHPR10MB1295.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:62;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8cGASTNbZSRATOH+gDag+SCOJI0gCEGLkmwSmXOFk5CbJDSQn7bhX2xkTknchxoED8nHkHuHFoGZa76y2Xp8wfulHaTNIcMAufuX1wzrYn/G7yVPk9DZag2hacmS/uie9ry0j7EtiJ9CanP++KQ1YUx+DjL/CawVtpOKZXe72S9tzNLBPlS6R9vb0UJrWVXOKk2r/6vnTB1yzl/GdbWJelWrgZaSW2W6sazLmwEpGra56ZpZUR7TQsCLLZ8OsuygdIh6MKT2aWca9erO7MxTnbcjnPg5DqR4/lYIz/1xue2JfHHxsgAH7uibsV924i+blKypHrIT/dAUJ6Lgx1pcoGVdI/ooBoek+qQfhKkemTokjvSvcIr/gExgU456X4Sbt35cuf/tut9ZN3U5plCANRITPpdvMX/THdr7RhOiuXn4ivMxzqNNm3fUvVqnzA3woOy35G1crSckCbwj3oicD3tZvt4C3pRsnRyMZjvGt4nvHNIVCqqJDrATuWnJ+OXhcppVXVLdzke+r0OOmadKlzsu9j8Rt5xGTZp2CFqw5kujoksaUO7kdS+kGoJ6ewsYZ5Hsl+C9TzwvtJrEdAGZWOGOdVe6or8mjzMqa29o1TrYHnUcYlQPw9XSf1H7ll5duzIvFNkLBTOPm98ZlE6g5j1rrKEHNKxYfAcIx5amqcoe2CJOC/ktRu/naF6JxKXUpijvvoXlzfoT4iVDZuQpOqjB6J68KRzRRVtr0QZqC0Z8ON4KIK3d2kxKx0mcJl4UOaDGQpUOkz14xQ9c7ToU/Cvx7WyfO2NJ1eOnZos5Hx8uFgXen2hzXAGj0Bqf2EyX/5wCNwumZOa2KEOZZgy3fQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(6666004)(4326008)(86362001)(54906003)(2906002)(8936002)(38350700002)(316002)(6916009)(38100700002)(6512007)(9686003)(83380400001)(66946007)(66476007)(66556008)(1076003)(52116002)(6486002)(36756003)(44832011)(4001150100001)(508600001)(26005)(186003)(6506007)(966005)(5660300002)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?qv/8CGvPW+vt8rV5GBZdTSuvUY0NiDv8RrgK3kJ4+zMBWKHuAWLn2ujDmplF?=
 =?us-ascii?Q?fMaZUoo6IX6nU+/m3spUNSH8DS/NXM3syG/Wqv+we+z5nFZyOWjdvAxpr3Ow?=
 =?us-ascii?Q?NjNeCadB0eMBjMa+GGBkD2p/SSFfZuS/Pdo6W01YlORmY0oIM4zHIZDr0IKy?=
 =?us-ascii?Q?4xjv2SKun6ShktqkhYdJ+GKud5hOP2oQ9sl2lHDyruKpaOyGKd70CJBZNDAg?=
 =?us-ascii?Q?ppsMnE2leN97Ct78fM5h1kELfnWab6CofzvaaJOCt+VGxMJc1XySMK1MgHtl?=
 =?us-ascii?Q?YK30GdjOGlFi0cMv0ltmwg0gwrKNGgv5sDsRQiB7fVJJ/ATrVRc6Ec/4qZkl?=
 =?us-ascii?Q?MC/22ULbxYgMwY5oHscputKMU8BmqKbxjNwgsgqtBPnnSwCbL6HxNiMjf8Ic?=
 =?us-ascii?Q?kcS25Dh3bcGRWPBqf+GmWjzYpIFqkzDjITDoeGvJF/4GduHPLTgIDrJPcfAu?=
 =?us-ascii?Q?FctNJDj5HOdkOxrK5jriJcgWz9SuEry0jSjpdYaW/1EclOSjpXDxzZ2+j+kx?=
 =?us-ascii?Q?qA566MLQMCJ4wGNzVfCeBYVigizS+ufJ+1aLtTL72H4O9vCivddFT4Q9Ui3o?=
 =?us-ascii?Q?Qh+YgJrX00+jrOEIDn5z2Fq2yEZjuYUDb7y6Yh+kw7k1KcvUMAvXoM9y0qYG?=
 =?us-ascii?Q?Kt68ow4A93oZ9E5uVIjLKvekjUs/hZL2kpNVvG0R9nOIkqbAI86Tfdzk0zgH?=
 =?us-ascii?Q?KJHC8KcMDUOoHmocuIV9phBfRFGsMW60eqvQ4bHf+izOxC7NmRUx9VFfQtix?=
 =?us-ascii?Q?VfcipxqeH+S+rSDdjec/PymjuRmiQNpRbhg7tqH+NXm4zdSXTKJ1NuXE4di3?=
 =?us-ascii?Q?+8y+tJgWKVKNNOeqO45zRsqrMuaaKyZ+bGHJZMuY2uVV/bVOPwNHX/VeBHRs?=
 =?us-ascii?Q?DTnUBW5glyQT6MQlGb2tbZMRM6PPK1phWY9Sc7t0EOqYb7njQdQCc5GWaFSJ?=
 =?us-ascii?Q?5o6a/9vV2faNXORhhGjpaqytotG8fGtM82F1JkrYal0HcjyN8Su3qGx191lW?=
 =?us-ascii?Q?GkEFlkQ1ph+IYEpxjsEyYcDo2WR5qLgKOrbckCRtv0dUtG2hvLmnuTsbu9aE?=
 =?us-ascii?Q?6pwEOkvyMDhSJx90tIURAIgOVWoxhtQ+vv9r8lmUSGb3Mn2ymmdN/NVwqW6v?=
 =?us-ascii?Q?WCCpUodB9Kp6JbGovRjDEO3BeFx7DtFmTx5ogByEU3W71KQK7EAYY6fmvJ3I?=
 =?us-ascii?Q?1UoOT8GU5DU797gR4c9H3wnElzxV63QCiW4tEj5U13kNWpwxSFQ9XRafOPtV?=
 =?us-ascii?Q?RsGJzHMeGOKnYoJlYgxatzIzrdYf1pFsQd+aCfhOn3y6DgJoeUtdZDoBPLru?=
 =?us-ascii?Q?R4EbiE3VQmIb9B2JT9NL3DXUocZrBejjR94+oIK+nysx6Qt6sAC3f8Hjvezd?=
 =?us-ascii?Q?3FwNoPDMfwW+tOmfMOdj+CG4UdTc2espKdC6MYIMtHBkeMXMJzazLzxYl9LE?=
 =?us-ascii?Q?JTKKSMmnihIDx9uoWuQNCQlB0IEb5FECHzdQ7mKzfjQNWzJ3Egp0ff1qkWbk?=
 =?us-ascii?Q?D2BslUlZi9gtF+hjCWcTLPmVh1sw6k97xvKNnnO00obfNQuKMMtnan4r88sS?=
 =?us-ascii?Q?waO0kZ3R/wrsWHDQKKjBIwHDOUDFa0EmAW1kT5haR9r6EkR3smhv8GJelbnc?=
 =?us-ascii?Q?ostBX5B1VRbUuz+SrHuo5QSHIvoXHpF8zx2lLjgLu3lMvPIshUkqhl7kyReX?=
 =?us-ascii?Q?LW01YqcrritO8vhm6t0DqngbD9M=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5d18ec73-a3e7-4996-13ff-08d9d02daea8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Jan 2022 09:28:07.5585
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: vyiTrxP/zrZTmWxLucBLLNh+ryh9hSBLCz4Hftv5VInsbZCMA5dhBzSBIIsdbsHTFOHjn1ouqo0Ai4uD8Fy3d2rj1KezFF28PBjyYRbYfPc=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1295
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10217 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 mlxscore=0 adultscore=0
 bulkscore=0 suspectscore=0 malwarescore=0 spamscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2201050062
X-Proofpoint-GUID: Pe1_36qHMCtSIXyG9VTEvelpFvqgZijT
X-Proofpoint-ORIG-GUID: Pe1_36qHMCtSIXyG9VTEvelpFvqgZijT
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   5d65f6f3df56021ec76761ea6986bc8139f537d2
commit: 06ddcee49a35981835e04910bef462a09f108984 drm/amd/display: Added multi instance support for panel control
config: x86_64-randconfig-m001-20211207 (https://download.01.org/0day-ci/archive/20211218/202112181037.uydEtc7w-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c:1018 dce110_edp_backlight_control() error: we previously assumed 'link->panel_cntl' could be null (see line 977)

vim +1018 drivers/gpu/drm/amd/amdgpu/../display/dc/dce110/dce110_hw_sequencer.c

8a31820b12187c Martin Leung      2019-07-09   963  void dce110_edp_backlight_control(
5eefbc40173644 Yue Hin Lau       2017-09-15   964  		struct dc_link *link,
5eefbc40173644 Yue Hin Lau       2017-09-15   965  		bool enable)
5eefbc40173644 Yue Hin Lau       2017-09-15   966  {
069d418f412ec4 Andrew Jiang      2017-09-26   967  	struct dc_context *ctx = link->ctx;
5eefbc40173644 Yue Hin Lau       2017-09-15   968  	struct bp_transmitter_control cntl = { 0 };
06ddcee49a3598 Jake Wang         2021-02-23   969  	uint8_t panel_instance;
5eefbc40173644 Yue Hin Lau       2017-09-15   970  
069d418f412ec4 Andrew Jiang      2017-09-26   971  	if (dal_graphics_object_id_get_connector_id(link->link_enc->connector)
5eefbc40173644 Yue Hin Lau       2017-09-15   972  		!= CONNECTOR_ID_EDP) {
5eefbc40173644 Yue Hin Lau       2017-09-15   973  		BREAK_TO_DEBUGGER();
5eefbc40173644 Yue Hin Lau       2017-09-15   974  		return;
5eefbc40173644 Yue Hin Lau       2017-09-15   975  	}
5eefbc40173644 Yue Hin Lau       2017-09-15   976  
014427adc5565a Sherry            2020-11-11  @977  	if (link->panel_cntl) {
                                                            ^^^^^^^^^^^^^^^^
Check for NULL

014427adc5565a Sherry            2020-11-11   978  		bool is_backlight_on = link->panel_cntl->funcs->is_panel_backlight_on(link->panel_cntl);
014427adc5565a Sherry            2020-11-11   979  
014427adc5565a Sherry            2020-11-11   980  		if ((enable && is_backlight_on) || (!enable && !is_backlight_on)) {
1296423bf23c7a Bhawanpreet Lakha 2018-02-20   981  			DC_LOG_HW_RESUME_S3(
014427adc5565a Sherry            2020-11-11   982  				"%s: panel already powered up/off. Do nothing.\n",
5eefbc40173644 Yue Hin Lau       2017-09-15   983  				__func__);
5eefbc40173644 Yue Hin Lau       2017-09-15   984  			return;
5eefbc40173644 Yue Hin Lau       2017-09-15   985  		}
014427adc5565a Sherry            2020-11-11   986  	}
5eefbc40173644 Yue Hin Lau       2017-09-15   987  
5eefbc40173644 Yue Hin Lau       2017-09-15   988  	/* Send VBIOS command to control eDP panel backlight */
5eefbc40173644 Yue Hin Lau       2017-09-15   989  
1296423bf23c7a Bhawanpreet Lakha 2018-02-20   990  	DC_LOG_HW_RESUME_S3(
5eefbc40173644 Yue Hin Lau       2017-09-15   991  			"%s: backlight action: %s\n",
5eefbc40173644 Yue Hin Lau       2017-09-15   992  			__func__, (enable ? "On":"Off"));
5eefbc40173644 Yue Hin Lau       2017-09-15   993  
5eefbc40173644 Yue Hin Lau       2017-09-15   994  	cntl.action = enable ?
5eefbc40173644 Yue Hin Lau       2017-09-15   995  		TRANSMITTER_CONTROL_BACKLIGHT_ON :
5eefbc40173644 Yue Hin Lau       2017-09-15   996  		TRANSMITTER_CONTROL_BACKLIGHT_OFF;
8740196935625d Andrew Jiang      2017-09-25   997  
5eefbc40173644 Yue Hin Lau       2017-09-15   998  	/*cntl.engine_id = ctx->engine;*/
5eefbc40173644 Yue Hin Lau       2017-09-15   999  	cntl.transmitter = link->link_enc->transmitter;
5eefbc40173644 Yue Hin Lau       2017-09-15  1000  	cntl.connector_obj_id = link->link_enc->connector;
5eefbc40173644 Yue Hin Lau       2017-09-15  1001  	/*todo: unhardcode*/
5eefbc40173644 Yue Hin Lau       2017-09-15  1002  	cntl.lanes_number = LANE_COUNT_FOUR;
5eefbc40173644 Yue Hin Lau       2017-09-15  1003  	cntl.hpd_sel = link->link_enc->hpd_source;
cf1835f03ffb3b Charlene Liu      2018-01-08  1004  	cntl.signal = SIGNAL_TYPE_EDP;
5eefbc40173644 Yue Hin Lau       2017-09-15  1005  
5eefbc40173644 Yue Hin Lau       2017-09-15  1006  	/* For eDP, the following delays might need to be considered
5eefbc40173644 Yue Hin Lau       2017-09-15  1007  	 * after link training completed:
5eefbc40173644 Yue Hin Lau       2017-09-15  1008  	 * idle period - min. accounts for required BS-Idle pattern,
5eefbc40173644 Yue Hin Lau       2017-09-15  1009  	 * max. allows for source frame synchronization);
5eefbc40173644 Yue Hin Lau       2017-09-15  1010  	 * 50 msec max. delay from valid video data from source
5eefbc40173644 Yue Hin Lau       2017-09-15  1011  	 * to video on dislpay or backlight enable.
5eefbc40173644 Yue Hin Lau       2017-09-15  1012  	 *
5eefbc40173644 Yue Hin Lau       2017-09-15  1013  	 * Disable the delay for now.
5eefbc40173644 Yue Hin Lau       2017-09-15  1014  	 * Enable it in the future if necessary.
5eefbc40173644 Yue Hin Lau       2017-09-15  1015  	 */
5eefbc40173644 Yue Hin Lau       2017-09-15  1016  	/* dc_service_sleep_in_milliseconds(50); */
5180d4a4766d7d Charlene Liu      2018-01-18  1017  		/*edp 1.2*/
06ddcee49a3598 Jake Wang         2021-02-23 @1018  	panel_instance = link->panel_cntl->inst;
                                                                         ^^^^^^^^^^^^^^^^^^
Unchecked dereference.

5180d4a4766d7d Charlene Liu      2018-01-18  1019  	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
5180d4a4766d7d Charlene Liu      2018-01-18  1020  		edp_receiver_ready_T7(link);
8a0e210c048e97 Chris Park        2020-08-05  1021  
8a0e210c048e97 Chris Park        2020-08-05  1022  	if (ctx->dc->ctx->dmub_srv &&
8a0e210c048e97 Chris Park        2020-08-05  1023  			ctx->dc->debug.dmub_command_table) {
8a0e210c048e97 Chris Park        2020-08-05  1024  		if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_ON)
8a0e210c048e97 Chris Park        2020-08-05  1025  			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
06ddcee49a3598 Jake Wang         2021-02-23  1026  					LVTMA_CONTROL_LCD_BLON,
06ddcee49a3598 Jake Wang         2021-02-23  1027  					panel_instance);
8a0e210c048e97 Chris Park        2020-08-05  1028  		else
8a0e210c048e97 Chris Park        2020-08-05  1029  			ctx->dc_bios->funcs->enable_lvtma_control(ctx->dc_bios,
06ddcee49a3598 Jake Wang         2021-02-23  1030  					LVTMA_CONTROL_LCD_BLOFF,
06ddcee49a3598 Jake Wang         2021-02-23  1031  					panel_instance);
8a0e210c048e97 Chris Park        2020-08-05  1032  	}
8a0e210c048e97 Chris Park        2020-08-05  1033  
069d418f412ec4 Andrew Jiang      2017-09-26  1034  	link_transmitter_control(ctx->dc_bios, &cntl);
96577cf82a1331 Hersen Wu         2020-01-14  1035  
96577cf82a1331 Hersen Wu         2020-01-14  1036  	if (enable && link->dpcd_sink_ext_caps.bits.oled)
96577cf82a1331 Hersen Wu         2020-01-14  1037  		msleep(OLED_POST_T7_DELAY);
96577cf82a1331 Hersen Wu         2020-01-14  1038  
96577cf82a1331 Hersen Wu         2020-01-14  1039  	if (link->dpcd_sink_ext_caps.bits.oled ||
96577cf82a1331 Hersen Wu         2020-01-14  1040  		link->dpcd_sink_ext_caps.bits.hdr_aux_backlight_control == 1 ||
96577cf82a1331 Hersen Wu         2020-01-14  1041  		link->dpcd_sink_ext_caps.bits.sdr_aux_backlight_control == 1)
96577cf82a1331 Hersen Wu         2020-01-14  1042  		dc_link_backlight_enable_aux(link, enable);
96577cf82a1331 Hersen Wu         2020-01-14  1043  
69b9723a81e74e Charlene Liu      2018-01-18  1044  	/*edp 1.2*/
5180d4a4766d7d Charlene Liu      2018-01-18  1045  	if (cntl.action == TRANSMITTER_CONTROL_BACKLIGHT_OFF)
3a372bed1e337e Hugo Hu           2020-10-06  1046  		edp_add_delay_for_T9(link);
96577cf82a1331 Hersen Wu         2020-01-14  1047  
96577cf82a1331 Hersen Wu         2020-01-14  1048  	if (!enable && link->dpcd_sink_ext_caps.bits.oled)
96577cf82a1331 Hersen Wu         2020-01-14  1049  		msleep(OLED_PRE_T11_DELAY);
5eefbc40173644 Yue Hin Lau       2017-09-15  1050  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

