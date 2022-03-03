Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3024CBDD4
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 13:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiCCMco (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 07:32:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbiCCMcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 07:32:42 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49BED17AEDE;
        Thu,  3 Mar 2022 04:31:57 -0800 (PST)
Received: from pps.filterd (m0246632.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 223BqKnB003425;
        Thu, 3 Mar 2022 12:31:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : in-reply-to : mime-version;
 s=corp-2021-07-09; bh=5hpBbvqgAaDhJEzEGYCFfV9FLE1K0ydxG8MEWyU5C+c=;
 b=SnmCXLh6t7MUlt7mMP9TZbj0D8zwNOM9m4u2NbnEfxRIlxIjo8iSwCCST5R2/MyE6cPq
 CCxyOaCNRx03/u64Z+XmD9npcjdDLcX23sidjU5gscWbwtUCfRmzCyWDdTJo1nFQe0gP
 kvNp83HsLWHU/pBi4OAiZD3Tszpmon2B33wmdIaJjg5QW3l5EQMoFfUziCQLV/xgUNbr
 pnH8I6xcXBE5NsNISPOtJ12Q5zOx+9wEbjLVerGm5zhVIX986HSlyHksANHipUjjia6m
 OT/MbQ9MEE8rbao1hbbfus6TZSf5m2Q9LBhfR1bR3yTO3KwaZW0+LW5tSPz9TwCapb2Q Dw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ehh2epjvv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:31:47 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 223CVgFm137784;
        Thu, 3 Mar 2022 12:31:46 GMT
Received: from nam04-dm6-obe.outbound.protection.outlook.com (mail-dm6nam08lp2045.outbound.protection.outlook.com [104.47.73.45])
        by userp3020.oracle.com with ESMTP id 3efdnshkbp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Mar 2022 12:31:46 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=EzWq3t/buLbxSG+839iO5W9MoJFViht56xCNqodgqmQ5Lcp/l6L1HmayaAeTgP1dZoaWVvNYX2buXacrs6kLF/n3VA5zbX614Mmt/RV5lnozenUuueofvSSojCMt2697veW0lDu6vNnbjAufy3pEaxogpn3kUYjANKERIYqFEq4A02tE05GXc03A84WCSycHTB/nb+H+eQHjsr0ThRM0IxdKZz3McUQtB8o+Kj8ayCD9/ZA/k38a4l9FJPX6UzmAHlCYzblOju+xOQKdHt5qIvuwkn7e5Q78oil3AaJcXoJR+oJVGg6f8vnUB+Xa4XDaUk2ekEhBxd89kcEcH6T+sg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5hpBbvqgAaDhJEzEGYCFfV9FLE1K0ydxG8MEWyU5C+c=;
 b=Qeb9IMhi36mvDqGeiZNZhAP5QNADh3roikqDKaTR5yVMxi8YEAz7dJlH17Eo4JcF8+C59FHY9zzioENSoZfNG4tjh77RwgZlsoyfr9SHzruU84RgHvNioW6ZmVABw9yTZUuQD6Ys1yH5I+XU9b5oCywa6k/ASHqdO8VuLVj5MTEr+Fu7IuZ6QmehDgyOtdNkk2yYP/+eNTurH1+KUJ7TdWIh74qNf5i27UhViSv4zx6jvanvCpN55XiN+ba7JvtLKFRuQoThdtdPyHc6PJTAJ40xq5v/9uuJNgqB1KhppqsfRFj6Mo6EUbqf7kChmOCGJyWKz3hIOxlKB4HLtJWmjA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=5hpBbvqgAaDhJEzEGYCFfV9FLE1K0ydxG8MEWyU5C+c=;
 b=ErU2+YgP0tV+9czXqqStZfoOlI3QWIir/GN6OzKseBlLOzXooezYI42w5Xrr5B3RkmMOmTlDDK0vtLjQfFe/PVoTO4qLyKRljd2oHV0mVu6eQHyq49Fye9pks1Ym8adlHYzAewMR5vUkK0ly0fJKECszTNfWtOvTnhyG8g0I1Zc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM6PR10MB4041.namprd10.prod.outlook.com
 (2603:10b6:5:1f9::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5038.14; Thu, 3 Mar
 2022 12:31:44 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.5017.027; Thu, 3 Mar 2022
 12:31:44 +0000
Date:   Thu, 3 Mar 2022 15:31:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Ashish Mhetre <amhetre@nvidia.com>,
        robh+dt@kernel.org, krzysztof.kozlowski@canonical.com,
        thierry.reding@gmail.com, jonathanh@nvidia.com, digetx@gmail.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-tegra@vger.kernel.org
Cc:     lkp@intel.com, kbuild-all@lists.01.org, vdumpa@nvidia.com,
        Snikam@nvidia.com, amhetre@nvidia.com
Subject: Re: [Patch v4 4/4] memory: tegra: Add MC error logging on tegra186
 onward
Message-ID: <202203031247.0bBX70B3-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1646210609-21943-5-git-send-email-amhetre@nvidia.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0048.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:a::36) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 23374864-21e6-4378-d1be-08d9fd11c670
X-MS-TrafficTypeDiagnostic: DM6PR10MB4041:EE_
X-Microsoft-Antispam-PRVS: <DM6PR10MB4041524AB7D6E45BE84BF8AC8E049@DM6PR10MB4041.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: //8qRV4cEynfroW4vLtjsscV8ch51GK/ooNqGZC+Yd16OOqGCEbGnXNP4KsCF7UD00DJR6vb/c0xzgSj8pL/VMdmsd/22sSFv3UNdFHHmRI/3OkrLTSzS1fNwpMtmMB4imC04zjEIDY4KBk7mZxLkEAnJEe5hvQiDCYmXEIYfVnnCo2geIsu+WsOdHLwAdN2gz3oalUdY1V/nQkgEt6Es8rVre1mL+KSkwqHP1TVlZo6Iu0d0p1axsgjnCIQMd0LaJcE07l5DzyzqtobOYSaTgTSKhVQWwCHk9G1EldMV4DpbHPlQD8ik6U2uqBb8Lm2en2bv+3yFmN5u1X7Au4kHxi+drAIoLQU2byZl+y6K6pQNFo2unQ6ajRPjJJCvcUuV8atGEmZtW3FUwVNebTspFsOvQ6a8FjxRm9pojHcBQkqBgKwZ1AYCP06kY9a+TfjZWaBiz7t2NK796GjdJopAnPEEgg1bZ1cX62/BPzIUhnQnfs3Gd3CGhVP/W69b0+t/Hus1j+Y/o4/D97m/7bfusSXnjJnzP8k7q3W4QlCHt6mpGfvKfC0y9ib0KhqSGxbvS5YSzyKi8BQE9qlOFxHqQRf8z+/c0N+ST3EpEbUT8pxj9+2KKS7/7T7VezTGaTVBXOSCZxJSKjZT9EV+ZFYD2AamWkrdHQG4CbeBYY+5n5oKVIPU5csf/TVuh7RlM22m+XT/+/89m/+iig9QI3ps3rvsT9+OpOtR7eJ1IJ2diexKZwAf7VSGu9zIVmlxXUSXoNucXDcXCN6DH/Oes1oURPGHBGzwjQFJtiYTgzampzuliJqzlDY/L704jb9peqdawntBKATl1Ouo/23QqFnSVOW1Gq2pThJ2+OPFrQG84g=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(38350700002)(38100700002)(26005)(921005)(83380400001)(1076003)(6512007)(36756003)(2906002)(9686003)(508600001)(66556008)(66476007)(66946007)(4326008)(8676002)(7416002)(44832011)(186003)(6666004)(5660300002)(6506007)(86362001)(8936002)(966005)(316002)(6486002)(52116002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?nf9gTX2ucFx8UOX0nL4NxIXCK293vQa9i7oSUX4u3lUG80jpndTKyFCZWAy8?=
 =?us-ascii?Q?JNOVHPfG2ssaohfaeB9o2kUv8nQtGaOIep1zKTbMR36hCSgaP2NjUXLrM6ny?=
 =?us-ascii?Q?H/YOTanYyJKbQC7zo+1h0FC24Lld0vL10CubZ7izjcLJKvuI6MqgQYzA0mEi?=
 =?us-ascii?Q?p8btm3rWS+4VYflZHNSfHZ2gG0XL0U4YMHq1H21wZTvy+q2aypeOFcZYI7A5?=
 =?us-ascii?Q?fL24/LW90w/g6SPGTlwX1+4xR3cB9xcwxs4nXMgGK17zZorl968Z1hhL+T6K?=
 =?us-ascii?Q?yNBvKj98iYKYU5G76SaoI+2CDytw2sNvAraMgBYhnW2Xx9f2z/BerjIsJtWX?=
 =?us-ascii?Q?Ht2aDaiFCqsn0TiSYa0IrCoHg8xk+8aLxxY8J/48a3lfWs+12Elu/GPurAFg?=
 =?us-ascii?Q?vqo7pZDR7lTYwXU7r59z+mZdWekC4i9fDwITXSd+Sol6zT/jqdy8uz6HzJIk?=
 =?us-ascii?Q?lMANRMxUglRre+r/5PArhy3NdkS01DJBFNPs7tJ6+p8LutxXaH8rI0bFqDbf?=
 =?us-ascii?Q?z98IhdgrTZmfTA5JUBj+S3SkyOh7e5J3sbNduLJCeFRT5M9ASgj4zyn62qIQ?=
 =?us-ascii?Q?EQIzsO4E+WqrcHWLtXbOEbNR5XFFEN3M8ocX4SIzO+Kde2ny6jHHS9U4SP/h?=
 =?us-ascii?Q?YyeMnCJgmCt8bIG971N2G4mZkrUEE2TmeoykLo1id5/BAF9t4rv7ffj3MWVA?=
 =?us-ascii?Q?wpv45sT20YKHlbjk2I3G9YEjTxZGqMlwM3bLtT1JT8JIbjmvL/ywkSCkiU3k?=
 =?us-ascii?Q?xmews+lMJ1SaSllGGbHlWnN/YwVTpUMg5M3gkdLzQY6IeWil74utFtXeGIWX?=
 =?us-ascii?Q?NsOZhot6InNKt27aIlaYZTu7nULElggI4VQ1/8iufnJXmbxjJM6Jq52qwol7?=
 =?us-ascii?Q?2+7mQRkdolOnSl0pW4xb00AgNUH68xGYjDXuIqWSFSopTf7uOrrkhfpDdloa?=
 =?us-ascii?Q?bb3Gblsg1sKVrOZRAAyg8yFil9jPgbzLlX1wBvJA+d+5vXB5GmSIJSzO5C2v?=
 =?us-ascii?Q?/3r7uQhOTm6ydd9JCuopljc/vikdD+oeikTPbWaHV0Y4wxGvIzUKdK/WCZ9r?=
 =?us-ascii?Q?aipHGG+yru5Z2VG7AICCG++0SzHvx+rxlhJEnjYDP5bBx4MsJYbQRubDdvWa?=
 =?us-ascii?Q?+/EaN31U7FGvkEwi0LL5mU76n4KY6PvZNiEkf8zsuHoYylBBL5VcQwNXYr7a?=
 =?us-ascii?Q?OMj2RxxTPJF+Rg/vPvmcplZgwSF+xD/4kZuW9tNCmau1YQ7nQE3cPnILlCwb?=
 =?us-ascii?Q?+h54kV9GED56Jh4MCdMOc/owJFfIevh0IhxbNDhLPgWZ9TYftZmm6DknWdmZ?=
 =?us-ascii?Q?3djaWmFG+NJgNiwprIYdXysrExoVqymiOPejO4OjNFk8+IrajuRW7nOxhkbu?=
 =?us-ascii?Q?/XFnXHZ+I2kT0AnDWewn3vAqV5FRQqIOMytUP1xXSP+vsFCtWOtrMEvj/FWZ?=
 =?us-ascii?Q?Iq8hphl1IXRNVOBlQHJXC/SKQOGYaSMv8ZpNGb0ZQe26oGzBHp9OjyGlfO+H?=
 =?us-ascii?Q?DFAVahYatIrbcBmkrGyGezYt1mUi9uQ56zd+8kYxbdRliTF6xlaCaRtxse5Q?=
 =?us-ascii?Q?m8WRS1nQmcEbhDsdElTVEEZdJABdMdfRQTbW5lOWifQ5DY4owCMqaZ5amf0e?=
 =?us-ascii?Q?XnyRZ4rwJCpstm4MKfeqWmd1VYHF0cXCwzKilNfxdCDl+YIROT50AuEddRim?=
 =?us-ascii?Q?ytpofw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 23374864-21e6-4378-d1be-08d9fd11c670
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Mar 2022 12:31:43.9720
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: l3L8kYzdNOS0G6Ro8nvMHxKSmf7PlTAcUzzBTMGd+MqbJ33GeSafJaNRBGf4x3bD5wLS8bYgc6Fwt692kD15AZo+hT3lICSx1btyV4xWXC8=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR10MB4041
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10274 signatures=686787
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxlogscore=999 bulkscore=0
 adultscore=0 phishscore=0 spamscore=0 suspectscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2203030060
X-Proofpoint-ORIG-GUID: XZI2UKcOnUKUUrDKxNdCeJt8bDKxzcpB
X-Proofpoint-GUID: XZI2UKcOnUKUUrDKxNdCeJt8bDKxzcpB
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FAKE_REPLY_C,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ashish,

url:    https://github.com/0day-ci/linux/commits/Ashish-Mhetre/memory-tegra-Add-MC-channels-and-error-logging/20220302-164625
base:   https://git.kernel.org/pub/scm/linux/kernel/git/tegra/linux.git for-next
config: openrisc-randconfig-m031-20220302 (https://download.01.org/0day-ci/archive/20220303/202203031247.0bBX70B3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/memory/tegra/mc.c:593 tegra30_mc_handle_irq() error: uninitialized symbol 'channel'.

vim +/channel +593 drivers/memory/tegra/mc.c

cc84c62c96f257 Ashish Mhetre   2022-03-02  516  
cc84c62c96f257 Ashish Mhetre   2022-03-02  517  irqreturn_t tegra30_mc_handle_irq(int irq, void *data)
89184651631713 Thierry Reding  2014-04-16  518  {
89184651631713 Thierry Reding  2014-04-16  519  	struct tegra_mc *mc = data;
1c74d5c0de0c2c Dmitry Osipenko 2018-04-09  520  	unsigned long status;
89184651631713 Thierry Reding  2014-04-16  521  	unsigned int bit;
cc84c62c96f257 Ashish Mhetre   2022-03-02  522  	int channel;
cc84c62c96f257 Ashish Mhetre   2022-03-02  523  
cc84c62c96f257 Ashish Mhetre   2022-03-02  524  	if (mc->soc->num_channels && mc->soc->get_int_channel) {

Let's assume "mc->soc->num_channels" is non-zero but there is no
mc->soc->get_int_channel() function.

cc84c62c96f257 Ashish Mhetre   2022-03-02  525  		int err;
cc84c62c96f257 Ashish Mhetre   2022-03-02  526  
cc84c62c96f257 Ashish Mhetre   2022-03-02  527  		err = mc->soc->get_int_channel(mc, &channel);
cc84c62c96f257 Ashish Mhetre   2022-03-02  528  		if (err < 0)
cc84c62c96f257 Ashish Mhetre   2022-03-02  529  			return IRQ_NONE;
89184651631713 Thierry Reding  2014-04-16  530  
89184651631713 Thierry Reding  2014-04-16  531  		/* mask all interrupts to avoid flooding */
cc84c62c96f257 Ashish Mhetre   2022-03-02  532  		status = mc_ch_readl(mc, channel, MC_INTSTATUS) & mc->soc->intmask;
cc84c62c96f257 Ashish Mhetre   2022-03-02  533  	} else {
1c74d5c0de0c2c Dmitry Osipenko 2018-04-09  534  		status = mc_readl(mc, MC_INTSTATUS) & mc->soc->intmask;
cc84c62c96f257 Ashish Mhetre   2022-03-02  535  	}
cc84c62c96f257 Ashish Mhetre   2022-03-02  536  
bf3fbdfbec947c Dmitry Osipenko 2018-04-09  537  	if (!status)
bf3fbdfbec947c Dmitry Osipenko 2018-04-09  538  		return IRQ_NONE;
89184651631713 Thierry Reding  2014-04-16  539  
89184651631713 Thierry Reding  2014-04-16  540  	for_each_set_bit(bit, &status, 32) {
1079a66bc32ff0 Thierry Reding  2021-06-02  541  		const char *error = tegra_mc_status_names[bit] ?: "unknown";
89184651631713 Thierry Reding  2014-04-16  542  		const char *client = "unknown", *desc;
89184651631713 Thierry Reding  2014-04-16  543  		const char *direction, *secure;
cc84c62c96f257 Ashish Mhetre   2022-03-02  544  		u32 status_reg, addr_reg;
cc84c62c96f257 Ashish Mhetre   2022-03-02  545  		u32 intmask = BIT(bit);
89184651631713 Thierry Reding  2014-04-16  546  		phys_addr_t addr = 0;
cc84c62c96f257 Ashish Mhetre   2022-03-02  547  #ifdef CONFIG_PHYS_ADDR_T_64BIT
cc84c62c96f257 Ashish Mhetre   2022-03-02  548  		u32 addr_hi_reg = 0;
cc84c62c96f257 Ashish Mhetre   2022-03-02  549  #endif
89184651631713 Thierry Reding  2014-04-16  550  		unsigned int i;
89184651631713 Thierry Reding  2014-04-16  551  		char perm[7];
89184651631713 Thierry Reding  2014-04-16  552  		u8 id, type;
89184651631713 Thierry Reding  2014-04-16  553  		u32 value;
89184651631713 Thierry Reding  2014-04-16  554  
cc84c62c96f257 Ashish Mhetre   2022-03-02  555  		switch (intmask) {
cc84c62c96f257 Ashish Mhetre   2022-03-02  556  		case MC_INT_DECERR_VPR:
cc84c62c96f257 Ashish Mhetre   2022-03-02  557  			status_reg = MC_ERR_VPR_STATUS;
cc84c62c96f257 Ashish Mhetre   2022-03-02  558  			addr_reg = MC_ERR_VPR_ADR;
cc84c62c96f257 Ashish Mhetre   2022-03-02  559  			break;
cc84c62c96f257 Ashish Mhetre   2022-03-02  560  
cc84c62c96f257 Ashish Mhetre   2022-03-02  561  		case MC_INT_SECERR_SEC:
cc84c62c96f257 Ashish Mhetre   2022-03-02  562  			status_reg = MC_ERR_SEC_STATUS;
cc84c62c96f257 Ashish Mhetre   2022-03-02  563  			addr_reg = MC_ERR_SEC_ADR;
cc84c62c96f257 Ashish Mhetre   2022-03-02  564  			break;
cc84c62c96f257 Ashish Mhetre   2022-03-02  565  
cc84c62c96f257 Ashish Mhetre   2022-03-02  566  		case MC_INT_DECERR_MTS:
cc84c62c96f257 Ashish Mhetre   2022-03-02  567  			status_reg = MC_ERR_MTS_STATUS;
cc84c62c96f257 Ashish Mhetre   2022-03-02  568  			addr_reg = MC_ERR_MTS_ADR;
cc84c62c96f257 Ashish Mhetre   2022-03-02  569  			break;
cc84c62c96f257 Ashish Mhetre   2022-03-02  570  
cc84c62c96f257 Ashish Mhetre   2022-03-02  571  		case MC_INT_DECERR_GENERALIZED_CARVEOUT:
cc84c62c96f257 Ashish Mhetre   2022-03-02  572  			status_reg = MC_ERR_GENERALIZED_CARVEOUT_STATUS;
cc84c62c96f257 Ashish Mhetre   2022-03-02  573  			addr_reg = MC_ERR_GENERALIZED_CARVEOUT_ADR;
cc84c62c96f257 Ashish Mhetre   2022-03-02  574  			break;
cc84c62c96f257 Ashish Mhetre   2022-03-02  575  
cc84c62c96f257 Ashish Mhetre   2022-03-02  576  		case MC_INT_DECERR_ROUTE_SANITY:
cc84c62c96f257 Ashish Mhetre   2022-03-02  577  			status_reg = MC_ERR_ROUTE_SANITY_STATUS;
cc84c62c96f257 Ashish Mhetre   2022-03-02  578  			addr_reg = MC_ERR_ROUTE_SANITY_ADR;
cc84c62c96f257 Ashish Mhetre   2022-03-02  579  			break;
cc84c62c96f257 Ashish Mhetre   2022-03-02  580  
cc84c62c96f257 Ashish Mhetre   2022-03-02  581  		default:
cc84c62c96f257 Ashish Mhetre   2022-03-02  582  			status_reg = MC_ERR_STATUS;
cc84c62c96f257 Ashish Mhetre   2022-03-02  583  			addr_reg = MC_ERR_ADR;
cc84c62c96f257 Ashish Mhetre   2022-03-02  584  
cc84c62c96f257 Ashish Mhetre   2022-03-02  585  #ifdef CONFIG_PHYS_ADDR_T_64BIT
cc84c62c96f257 Ashish Mhetre   2022-03-02  586  			if (mc->soc->has_addr_hi_reg)
cc84c62c96f257 Ashish Mhetre   2022-03-02  587  				addr_hi_reg = MC_ERR_ADR_HI;
cc84c62c96f257 Ashish Mhetre   2022-03-02  588  #endif
cc84c62c96f257 Ashish Mhetre   2022-03-02  589  			break;
cc84c62c96f257 Ashish Mhetre   2022-03-02  590  		}
cc84c62c96f257 Ashish Mhetre   2022-03-02  591  
cc84c62c96f257 Ashish Mhetre   2022-03-02  592  		if (mc->soc->num_channels)
cc84c62c96f257 Ashish Mhetre   2022-03-02 @593  			value = mc_ch_readl(mc, channel, status_reg);

Then "channel" is uninitialized here.

cc84c62c96f257 Ashish Mhetre   2022-03-02  594  		else
cc84c62c96f257 Ashish Mhetre   2022-03-02  595  			value = mc_readl(mc, status_reg);
89184651631713 Thierry Reding  2014-04-16  596  

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

