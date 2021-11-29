Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 537764613B6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Nov 2021 12:16:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238306AbhK2LTY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Nov 2021 06:19:24 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:5774 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235539AbhK2LQI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Nov 2021 06:16:08 -0500
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 1AT9s8Ws020335;
        Mon, 29 Nov 2021 11:12:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sMUhZ+afhEsQuzQVXzXgNERhI2OM+P/5ws6NSBhlt24=;
 b=VQKW+MPjYjwvoU3Dmc3T5tNBTY3F5I19JwIJGgmtfT75Jr3tp4/F4XI7OCNQYayToUF9
 fDxBbFEtKO3b6uqwimTuULar9tMl51iUrYkuiW8LcjbuWlyoBScs8ew9HULppDaDKbRU
 tObOdvqywSZqxrP9c5xgWRWZURk+T8ra5fk59k7eCUmhIZMT64H6UbMdW8z6Kp9hz61T
 w7vkDbB5OYMhzzqKVbLVw8trmOcukQvV/spGjeJU+2UydcFe7wknrhqY4Ohzn+eUtui7
 vPsWLwuLLya1rvUTnGCbp1VJ9vlDVCK1KvkbiVCuMTWXYwpP93PCvX80u/QWVZFWWqcV PQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3cmvmwgbnk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:12:46 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 1ATB5hL9163972;
        Mon, 29 Nov 2021 11:12:45 GMT
Received: from nam04-mw2-obe.outbound.protection.outlook.com (mail-mw2nam08lp2172.outbound.protection.outlook.com [104.47.73.172])
        by aserp3020.oracle.com with ESMTP id 3cmmumvt2r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Nov 2021 11:12:45 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jVqwLruWefUsg/pP8Jl3Rj++04XfdHD1zPjHSQlH3gx3vPnHWatkAIwfmEGjOYDZr09teQbliHgvXgnsb/hF2LidoFK3BxZWt7BnrBxJiac7wD51wEFsh5if6XLb6gQqWDen2FrpKNgn9vI0ZGjLZMCqUaWw07X3EHYFEz3yjmgZd7xQmsK3NMnRmBtkF9VwAzJceM7ptVcJ61vx/EWKsmqA1fhC5JgzHw2rCsjJeJFouqEL7Am91+qGwFyyQW64sxAsYlECci763BDkkfRGgPiUXYxs/k9K+yHlz0wXUJ7Q4al/yX5DK4wZ/4c6w3iuVcdd70F1lbPgDIDayyvm0w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sMUhZ+afhEsQuzQVXzXgNERhI2OM+P/5ws6NSBhlt24=;
 b=ChdFlXstFWeVQneJiHZu1gaZd4Yw7f8in3NMo60okLMuk+294VaLtwyxZs/OOYVvruJ8IyosPV2lwC2zWuR8O9+vKJICTO560hdPGLxhZxk5u1G8JTRUAMniPSsqv5/877zCYLCSQclr7v9HdztMNH4aCBWwvtry62coeEXvhqK8kICO2Bm1qejbdIoO4t9hc047WJTTwYOZ9QtafT5Sf48Qy/U1qusWwB1ocfhPwMc/UtjPncpXsEq3bC4LFhKz83iVpo6b591j+dth2yNl+ICPu36QxwO41TrzSVhmMLGLnyKq9bRgU1tamF8LLdoMp1gYfC6c3nuJBwHizDkt5w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sMUhZ+afhEsQuzQVXzXgNERhI2OM+P/5ws6NSBhlt24=;
 b=b1pezeU1iuhQQVJgpIKi3pj+VH6semqOT2WFUROVH6kO/sWmhyLPM7E8M1Zeswi0VYYHzLAM5LRm7BAEY5gL0QvlRSBl/wDz5ebu0kl+HyiDWLtwNjoyBAl9LfVORn+5Nxc+ZcE8r47t4cWBmqSGJAvXQqDHf7Fh88g9sQcpq1k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by MWHPR10MB1295.namprd10.prod.outlook.com
 (2603:10b6:300:1e::9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Mon, 29 Nov
 2021 11:12:43 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::7194:c377:36cc:d9f0%6]) with mapi id 15.20.4734.024; Mon, 29 Nov 2021
 11:12:43 +0000
Date:   Mon, 29 Nov 2021 14:12:22 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Charles Keepax <ckeepax@opensource.cirrus.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: [broonie-sound:for-next 26/50] drivers/firmware/cirrus/cs_dsp.c:761
 cs_dsp_coeff_write_ctrl() warn: variable dereferenced before check 'ctl'
 (see line 759)
Message-ID: <202111260147.g6ZphXY3-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::32)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
Received: from kadam (102.222.70.114) by JNXP275CA0020.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:19::32) with Microsoft SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.22 via Frontend Transport; Mon, 29 Nov 2021 11:12:36 +0000
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 84ea47f2-0d0d-4558-fee4-08d9b32929c4
X-MS-TrafficTypeDiagnostic: MWHPR10MB1295:
X-Microsoft-Antispam-PRVS: <MWHPR10MB1295EE481EF41EDAEDC95CE48E669@MWHPR10MB1295.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: KYThGL3JiXuSvHRu4WEv/SaRWLcMRWpkQzbrPXDR/4gjB2tGUGM43lt6r4xW43T5Ynee+8kgmBAW/lzdmyBzi1VjO3nLD0GERIMHp3Mdxm96xJ6WqrmUeSJcGVYNwwuBg45c8JS7Hsbp+jkrkDzIqvCwECZ+trAfAKCVTvBhm6q2Ueqr/KfAMh/1X7/k1F+KeqWhFs4XygydaewavndzqJuGQOaNRFUttBFFpOFj/n29c/y7SxrGVBESEzXAoD2+lMcOq0hdiQeIAuaJX/9yw1oPi5m6wN/fpVycBpJiZZp0y++zldHsFZJxp7dzkKpYGEfXEvM/cP5iZ8LR0/VOMNmqS/sPGHgM+0W+7XAXh2R0Q7tthirBle7lKlMjhljHGBZYMKrj8EqnTZYPberLdP+dTExOGOY4R02b5ZBKlHAPteV6qnOq0CjEZbD3bPFY+OceSktc2zLDxBNMVLR4ZZmG3gAbWpGKK1KSyakt0iVOI/Ob2Fb2hWSdrQdd07YtsBdNTzwRAYZ57hRIgOR4XgSnFv/EAMCXqZakZFhVN6usRv7eQgVtGBnOP/+BmDEbZnETo7KoUlnW/QX2Z0jIgLvUQIlS1G3fTuMAwW9DbO5k5WA2OxKKtctvFT616xWs/YKD9C6bxYDlEgaOYqGtN1fTp0aNOkS11X8HrdyTnEEbLZVbvEpHLjE+GYKGar18AlfrgW9iHRcCEhRt013cH24gYFoJCPFnLflvz8pKayKCNttwa5wbdoPvl8EqcKVV0XNA+5/nXBxIfd5z3PKb7LOubuV3DVbUHC7Ez5ZPkx31YBQynyr9ZJ0KhwPejagIn1kywSj0WJ9/iRpRNHuzSQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(366004)(66476007)(66556008)(9686003)(508600001)(316002)(186003)(8676002)(956004)(66946007)(6486002)(8936002)(2906002)(6666004)(4326008)(86362001)(36756003)(6916009)(44832011)(6496006)(5660300002)(83380400001)(1076003)(26005)(4001150100001)(52116002)(38100700002)(38350700002)(966005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Up+NtA3sFA4dS2JGZeBoqMM2jCoOGknxappBFkcqjhF7DPQIEkzQzwUfhmQE?=
 =?us-ascii?Q?75VpYtbAJRhtuChQ6UFrVGTA4aAOn0AAVSeRQ4S9dCGG8fL1HFHKRayeIHcX?=
 =?us-ascii?Q?4xc6q2hBAZhEuj3pqWxj1Bv1RWYiLEVemxa+aIYC3uTrPmuNtaslBFTx4MMJ?=
 =?us-ascii?Q?jefkP7frAb97P54X8s4ucewHYET9PdQ+pMynSHyfXAXa6hMioKkoU91sTw5o?=
 =?us-ascii?Q?hIA6ySL1++mBUqOISAjaWHuoyn1bd8fB9LnuOKM+9llg5wRjGA3Usaut5/Xd?=
 =?us-ascii?Q?ei9K4zN7mmCv0RjvgIpnQ6YZAnFJT2XbpZLzDTFaZ9lrg/irM3m+2bZBFRx0?=
 =?us-ascii?Q?+r3LSft0jelCR5tTnNtI1wkY1TnFQzo8EB5F4fPfB7Y8kuUF25h6/4e2RvO/?=
 =?us-ascii?Q?3l90bDBqtuK3sKxbiuvbO8kV5WdoiR5rwPR3wywQN1fenjJFV09+DgXLHkDg?=
 =?us-ascii?Q?NH6l4V9pa3DbSxIZEoXKUr0QuRhfDNuhuPRDqFIi0Pqj33zAeWbFld6hMg9A?=
 =?us-ascii?Q?Z34IU16DKsW5isFFRjzxhw+mixD4KrNzQVxeKj5tW1GrmYA9NpA4tWkJ/uCN?=
 =?us-ascii?Q?CQ117UnffOQqNMIXrZLyljtuFvqECo8utnS3i+2CsC4FNuDf9V0y6geZgE7T?=
 =?us-ascii?Q?tRT1MlLf4feJAxet9DhoRqU4tzAb/vRGcNiEj8imviIbdAlBmQlSwMvnr9+L?=
 =?us-ascii?Q?uioxzm8DqJU9+wHAz615Xa6QOy9nQR2vSuFbhraKOukdgtnV6jIPmbS6hvkv?=
 =?us-ascii?Q?f3bn18o1OkrU0/CzBjN9wn4zKcJV6kIFvMVZH7m4p+TlXApP5GwCQD7z7GXO?=
 =?us-ascii?Q?TypmpHdYaLyAhAFtdLCRi4gYd5NYwUtzNW1PBKUlmdrkXokUK3W+kj0zOmKH?=
 =?us-ascii?Q?chur5m+yiECsrLSKrizfBBWCb1TR4v2M9gezrIzAfwO0dSACQGJjEInRT349?=
 =?us-ascii?Q?n6RAt0hiiyFA0S/JNS/fnZIhYCCFsY6Ol95GWc/360zLoYITXtiKJmuACdUg?=
 =?us-ascii?Q?4oWlOJgcMG2cM09FSvJPCC12LHAHiPuxWYJK22Txvv8KFdpU79gbX3vNRmRZ?=
 =?us-ascii?Q?9L8QZi7rxgum1YTS1vXsMuZ/kuLR/KPLI5naI3RFSHMoBrC/6r7TU6GDSt3L?=
 =?us-ascii?Q?7d06+WAn2iNOL64FjsraTvwBc6IlCEQkpNY5BNnQqtF3ChazwavpodeTseEZ?=
 =?us-ascii?Q?Rc4RLX/RyFfqdT+RCWEWeknYSHXqYZpUh7bLI/9VEy5qLYgL4kSoyDbWsF6J?=
 =?us-ascii?Q?ej+zd6GFRBwbsi+GIm1sZeVLoK9mTHFnL7FZiAbqLqwyNTq3gQ73eKatbZSR?=
 =?us-ascii?Q?qWXgJ+P5uShpVT8ERbOqGU89zVw+RTRLl4T6ruqvG5BwEaxUl+jNvTbCjEtp?=
 =?us-ascii?Q?3/jsKYVcm92QJ5mnm4dexHOq3Mzr/qzkP714xXLHzhBAFa9iwRIXNUuMMtVI?=
 =?us-ascii?Q?ldavGbQDGaUWb6LwxkqaO9RaufACdaNZ17XuHZGqh/w3anBAJILnci8E6F8f?=
 =?us-ascii?Q?zVSYhdCU67bcQ2H0D5g1+/60zjT6f3d9wkBteq/lTAdIMjJhVY4gGF50U/uf?=
 =?us-ascii?Q?+C+3EZmOLcOsm3EB22sRMI11ppiupGge2hEJOhuI8e448QwIxi9lGvYu4ZLJ?=
 =?us-ascii?Q?cN0+tDRcfiu+/Ji+CGrxDgDQREVu6ZHjp3b4c8fPpl8O2+7qm5uxfrJiZgDk?=
 =?us-ascii?Q?o7nEn0qqZ949LrZn1/0AE9uPeC4=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 84ea47f2-0d0d-4558-fee4-08d9b32929c4
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Nov 2021 11:12:42.9640
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: pKB1viZrVG9ChB0LPO2+FfyflEHXhPnysY0hPkHXfheUTlpiITI3MfUSb+kVuJbNwBJbXpOjZyzDjx0g8Nc8XgvJIM7seIqyHqzFXJAYrg4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR10MB1295
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10182 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxscore=0 adultscore=0
 suspectscore=0 mlxlogscore=999 malwarescore=0 phishscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2110150000
 definitions=main-2111290056
X-Proofpoint-ORIG-GUID: ocvTcF_7jKHjt5JyrG4HR0cAjTYvcjUB
X-Proofpoint-GUID: ocvTcF_7jKHjt5JyrG4HR0cAjTYvcjUB
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-next
head:   2b9c8d2b3c89708d53b6124dc49c212dc5341840
commit: 86c6080407740937ed2ba0ccd181e947f77e2154 [26/50] firmware: cs_dsp: Perform NULL check in cs_dsp_coeff_write/read_ctrl
config: openrisc-randconfig-m031-20211122 (https://download.01.org/0day-ci/archive/20211126/202111260147.g6ZphXY3-lkp@intel.com/config)
compiler: or1k-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

New smatch warnings:
drivers/firmware/cirrus/cs_dsp.c:761 cs_dsp_coeff_write_ctrl() warn: variable dereferenced before check 'ctl' (see line 759)
drivers/firmware/cirrus/cs_dsp.c:823 cs_dsp_coeff_read_ctrl() warn: variable dereferenced before check 'ctl' (see line 821)

vim +/ctl +761 drivers/firmware/cirrus/cs_dsp.c

f6bc909e7673c30 Simon Trimmer  2021-09-13  755  int cs_dsp_coeff_write_ctrl(struct cs_dsp_coeff_ctl *ctl, const void *buf, size_t len)
f6bc909e7673c30 Simon Trimmer  2021-09-13  756  {
f6bc909e7673c30 Simon Trimmer  2021-09-13  757  	int ret = 0;
f6bc909e7673c30 Simon Trimmer  2021-09-13  758  
5065cfabec21a4a Charles Keepax 2021-11-17 @759  	lockdep_assert_held(&ctl->dsp->pwr_lock);
                                                                             ^^^^^^^^^^^^^^^^^^
Dereference

5065cfabec21a4a Charles Keepax 2021-11-17  760  
86c608040774093 Charles Keepax 2021-11-17 @761  	if (!ctl)
                                                             ^^^
Checked too late

86c608040774093 Charles Keepax 2021-11-17  762  		return -ENOENT;
86c608040774093 Charles Keepax 2021-11-17  763  
f6bc909e7673c30 Simon Trimmer  2021-09-13  764  	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE)
f6bc909e7673c30 Simon Trimmer  2021-09-13  765  		ret = -EPERM;
f6bc909e7673c30 Simon Trimmer  2021-09-13  766  	else if (buf != ctl->cache)
f6bc909e7673c30 Simon Trimmer  2021-09-13  767  		memcpy(ctl->cache, buf, len);
f6bc909e7673c30 Simon Trimmer  2021-09-13  768  
f6bc909e7673c30 Simon Trimmer  2021-09-13  769  	ctl->set = 1;
f6bc909e7673c30 Simon Trimmer  2021-09-13  770  	if (ctl->enabled && ctl->dsp->running)
f6bc909e7673c30 Simon Trimmer  2021-09-13  771  		ret = cs_dsp_coeff_write_ctrl_raw(ctl, buf, len);
f6bc909e7673c30 Simon Trimmer  2021-09-13  772  
f6bc909e7673c30 Simon Trimmer  2021-09-13  773  	return ret;
f6bc909e7673c30 Simon Trimmer  2021-09-13  774  }

[ snip ]

f6bc909e7673c30 Simon Trimmer  2021-09-13  817  int cs_dsp_coeff_read_ctrl(struct cs_dsp_coeff_ctl *ctl, void *buf, size_t len)
f6bc909e7673c30 Simon Trimmer  2021-09-13  818  {
f6bc909e7673c30 Simon Trimmer  2021-09-13  819  	int ret = 0;
f6bc909e7673c30 Simon Trimmer  2021-09-13  820  
5065cfabec21a4a Charles Keepax 2021-11-17 @821  	lockdep_assert_held(&ctl->dsp->pwr_lock);
                                                                            ^^^^^^^^^^^^^^^^^^^

5065cfabec21a4a Charles Keepax 2021-11-17  822  
86c608040774093 Charles Keepax 2021-11-17 @823  	if (!ctl)
                                                            ^^^^

86c608040774093 Charles Keepax 2021-11-17  824  		return -ENOENT;
86c608040774093 Charles Keepax 2021-11-17  825  
f6bc909e7673c30 Simon Trimmer  2021-09-13  826  	if (ctl->flags & WMFW_CTL_FLAG_VOLATILE) {
f6bc909e7673c30 Simon Trimmer  2021-09-13  827  		if (ctl->enabled && ctl->dsp->running)
f6bc909e7673c30 Simon Trimmer  2021-09-13  828  			return cs_dsp_coeff_read_ctrl_raw(ctl, buf, len);
f6bc909e7673c30 Simon Trimmer  2021-09-13  829  		else
f6bc909e7673c30 Simon Trimmer  2021-09-13  830  			return -EPERM;
f6bc909e7673c30 Simon Trimmer  2021-09-13  831  	} else {
f6bc909e7673c30 Simon Trimmer  2021-09-13  832  		if (!ctl->flags && ctl->enabled && ctl->dsp->running)
f6bc909e7673c30 Simon Trimmer  2021-09-13  833  			ret = cs_dsp_coeff_read_ctrl_raw(ctl, ctl->cache, ctl->len);
f6bc909e7673c30 Simon Trimmer  2021-09-13  834  
f6bc909e7673c30 Simon Trimmer  2021-09-13  835  		if (buf != ctl->cache)
f6bc909e7673c30 Simon Trimmer  2021-09-13  836  			memcpy(buf, ctl->cache, len);
f6bc909e7673c30 Simon Trimmer  2021-09-13  837  	}
f6bc909e7673c30 Simon Trimmer  2021-09-13  838  
f6bc909e7673c30 Simon Trimmer  2021-09-13  839  	return ret;
f6bc909e7673c30 Simon Trimmer  2021-09-13  840  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

