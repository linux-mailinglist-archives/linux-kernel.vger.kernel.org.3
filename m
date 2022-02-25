Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96AE4C400D
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:25:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238481AbiBYI0R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:26:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238472AbiBYI0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:26:13 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0994720239F
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:25:40 -0800 (PST)
Received: from pps.filterd (m0246631.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21P4g1Vc006284;
        Fri, 25 Feb 2022 08:25:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=JOfaePDjdMIfs4tfwwh3khpFLSV8ik5wrqXEnI8x7hQ=;
 b=TZHVVKYctbAkAv048nyIYsMOWLEDfsJkFvJtfdwe35HazE213GARcGcF2jVZw/9vtstG
 amVDuzj5ZTnD4wPar0KWF7p5IDU0lhoIQV5GhI/OkZqzFIHZxyNeJSA3u1mDQIzBZFg9
 y25q1iFbhAG8qQB1UU8MBQA72qXtItY9estmF+JAYlbxpNlpYfhhasHT+KyNii5T3D0i
 Vu5y5//JLbe9l6G7IhrWeWbi2zHL7U+PNghGvhTS065MnDrYf9+uaVeaRvpHgLlZgwaO
 OFCo8HGpGRMTxRe8gLHqmOM0HWdydY6fk1UOIxOPFO3+uVoYhWBijNgT48xT8+bV0Huk wQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3ecv6f1fbh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 08:25:36 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21P8Gcc3102881;
        Fri, 25 Feb 2022 08:25:36 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2172.outbound.protection.outlook.com [104.47.55.172])
        by aserp3020.oracle.com with ESMTP id 3eb484hwqc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 25 Feb 2022 08:25:35 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mgLkUKi6gD7wzv0eYw4tvqZv+udy1haaG6rEbxpmUpo7j2oKBHf8G0VHuMoANDimkZtFyK4Xiq/LXUyvxxYX7rbAKzJ3wHXLWgkoy9t3aivBey2nNINN8GHXj6dl3HibzweGarybRayUX7/XmjwsXBAUMP1BPEkGR0s/elF6MzncyI/6klWGEZe3785evdqhd2FExRGd2OoviGFLeqpthT0789L44zwpma5S4UtK8+TnH+236qnMlUORyc9w+z7gWNRdRgZuWPY8nh+YiZq10KSKFf64t73fdPJoJge7Ez8rgXHyOCdzg852FV5wgxUeLERszDRju73MwMrj6CkC6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JOfaePDjdMIfs4tfwwh3khpFLSV8ik5wrqXEnI8x7hQ=;
 b=NmLI1mijkWJbr9X8tTRzjXtHoL0r9ipWP9T1hv0hbA5NjYHdlGpj+9p7eVaFTZFlYHtA7bGH2g+BYSgW0JaOLEqWvjPSfgeqHgozPB12A7Z0f5aYQitt4ouO4YuOQultUuqocvovr9FyTIoPMPm4gxnfC+uiFAAnujYes+H7JZy0h9tW1KKvgqo2rOL76psWvIKndxDvSiyxF+xF388JEpnEMj2ZKlsJqBI/ZOhvKOP4aKg74R1wHxwJu4YZleHsXfo/W5pVxR8lspUj1LeJHgxzLfvgz9pCiltLYmZwMf7CR7a7AVpdSEAIzXCWRLzUzJ1ICzDtTrJ/08lB4RqORw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=oracle.com; dmarc=pass action=none header.from=oracle.com;
 dkim=pass header.d=oracle.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JOfaePDjdMIfs4tfwwh3khpFLSV8ik5wrqXEnI8x7hQ=;
 b=te/2ax823l52QtfxqPHxyxlQdrwmm+UVDB4BQV85FCTrgHhodMdB5cqURDHSSFn1ibFnatYMUza0649D28NkcPgknyfmb+PviQPTnfhbOz8uudXiW1beTfLQeOUx2rRGENLEnVdoe7xtQH/h5LkVorHF0OgYvhLCTDTdsQVK6ts=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN8PR10MB3683.namprd10.prod.outlook.com
 (2603:10b6:408:b8::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.21; Fri, 25 Feb
 2022 08:25:33 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::2c3d:92b5:42b3:c1c5%4]) with mapi id 15.20.4995.029; Fri, 25 Feb 2022
 08:25:33 +0000
Date:   Fri, 25 Feb 2022 11:25:17 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Luca Coelho <luciano.coelho@intel.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org
Subject: drivers/net/wireless/intel/iwlwifi/fw/pnvm.c:332 iwl_pnvm_load()
 error: uninitialized symbol 'len'.
Message-ID: <202202250921.59KWuV9B-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: CT2P275CA0043.ZAFP275.PROD.OUTLOOK.COM
 (2603:1086:100:a::31) To MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 55a4958d-8248-443a-1104-08d9f838643f
X-MS-TrafficTypeDiagnostic: BN8PR10MB3683:EE_
X-Microsoft-Antispam-PRVS: <BN8PR10MB368386E47984580E637724FF8E3E9@BN8PR10MB3683.namprd10.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: X825gNB8JK4BV3i1nzhXz3adE2RvikJ/iJGptc9tyYKd/KrDrDrunevxFNnfxGiYlPx6YIS4MwQCQIlpjiyaKTS2Qip2dGRxECprF+IQ047qSeHsZln9WLGQg/9RKEns7WudVrP4LBtEiD+0/mZRuL26goqHrgkFEzUaCc0eSAfAyELaUbUZiI4ZWqMcbiAz8J1I6QFzm1X4M7cIuefqrgWzNthOjtcFJq0KwXAp4NT1UklTqgN0XIoTJeNCR/d4vaob1w9VBi8cAnFTBZ4xmXm+l7wrP7j8tier9RQoXvICpdjkSo+6DxmkejqYs0Mm+npD2Fv1FCc6sDsBdN5U1kjI6ZhGY+GE/p/naiadK/ez90h4dpZjowuw+EiMM1qrYVkyy8IV/DjrL19BexusEQIG/O5X1QH/tazya1/Vmkf5Oyx1H4JZoUvRaKglru6dT6geanSNaFy4Ru4pqDDs1uGuT+Y9J4fN5gAAXJnIjqUcWiDB5x+gk5jz/VQHm4JiCaYZMK36J/g3W92ZY5vgVV6YSuz3CftGGQ8CXGPNlg9VHCGxfuhfiQX7OmterRp1KE3DLk3e3/fhsWGQ/Awx8ESUd+MJISqftoQDBsMDizSrKpKXq3RUa39edRaJ52IUiAJpy8MfWRwAO80CIbR3g7GpYeOaxNhHeTY8tfdSuOuy33wKt2dh8Gw7ZlccLL8vTb/14n4nGVmubwShKIQKKrRHXID+ttSMfqLakTJdXdfXP1TouCLtSf3r0jPV0eSPCtFab37pT/HIYPOZhI6cv/Vj1qJnDKWDGw2R+zuMhs9x4dUgeEsZRbwtHhMiTktqasuRglp+EN5Gn9oZIBIv6Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(83380400001)(26005)(186003)(6486002)(36756003)(44832011)(1076003)(8936002)(966005)(6506007)(2906002)(86362001)(66556008)(5660300002)(66946007)(38100700002)(38350700002)(6916009)(316002)(4326008)(37006003)(8676002)(508600001)(52116002)(6666004)(9686003)(66476007)(6512007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?051PTOZwgPf/H5e7C+LbmyCXH24wRXdyR0yprIiVH6tX4krhubJUcfrG9sjG?=
 =?us-ascii?Q?AJZ/iVtArSf6CDcc9DO+JFuUna8ygUpLZkjEqlINGNxQ2eHyHbKzZBUBvHAM?=
 =?us-ascii?Q?lM6JdRRkc4YNspEBjRM51nswpRSLH4z2AfnGMy4weAlVy3PemZ1YgNn1h0tJ?=
 =?us-ascii?Q?ta8qfXvGUPEfF7AX/omSfo9j6HfSk7CgovkbsV8u+Iw9gXF4+h6zZ7Om5x1F?=
 =?us-ascii?Q?8cnVmDzq/YCiQ302sYGNKHL0AO/Bj4ghDKT23CJ3anmmib/AG86/t3e2LUyI?=
 =?us-ascii?Q?16AdGdwWzEPKRB6BZzVxp6E7k21CE0Jq3nguKIes66QKzF/H8abCg5W2HdX2?=
 =?us-ascii?Q?RA912yCISvO14JmtONg2uGzXSfBShfeBv9tb1SXA0UdxSo7RkpKEByMpQozW?=
 =?us-ascii?Q?y//DdFC+xnGVo1ka/RIDbiWOy/KkgLJ3RbdILSsODg1XaZEFfPDuL0bJIWft?=
 =?us-ascii?Q?tAKrVWERN8y/0ChZdqYi6onmMo7idvYdEsuNVzhra9n7EEcqc/0m5/AdUcpK?=
 =?us-ascii?Q?p5ghJwipoLO7gCox8QUU9ZXjl41UYcQMztT+xol3fg2r6to11KVulu4xc6+M?=
 =?us-ascii?Q?MxVnDCfnJ21dTpBUDZrPqonWrvYWwOoWAR3bsHEhLHRmNg1mmBnmXc3CAUBe?=
 =?us-ascii?Q?gX8Xa/yaVCGxmU8nH2t5ag+ZY/DAonW32CemONSH2xf4/Tn91z3rLc2lF2xd?=
 =?us-ascii?Q?CZpfQqYWhmdBgCTnEEotCB6xv57ft6kbmQ3Kgdv7cl9stKN2MucTB6hTUk5u?=
 =?us-ascii?Q?eHneKZKM1AH9dnDpo5kc2RmcbzXOs9hYPSV03HZi6/LIF2PL5JvTKIstkEY0?=
 =?us-ascii?Q?SY9dq39wFJIdPAFyR6GbJ/VQndqIznd8XC3wJBsNvDjlB8nfCWjmWIfBz0CP?=
 =?us-ascii?Q?XBShn2UZ1AQybPuFxf0yqifr6dbKX7pnWDEk03ZXp/HbNcEExFs4fNwTD1GK?=
 =?us-ascii?Q?ak1IKrqJ+GFSBALBNZn+OoGDsbp4j4ii6ClUXd2TFA/HzY/I8UNAY/ZNGp82?=
 =?us-ascii?Q?K6WyXpuQD3UQA5b1LReNB+RfWVwdn1DT6GKsui2aPEaz2FWyoCu67p9Hn1Qt?=
 =?us-ascii?Q?1aXOT+FMo+znWvhHdPD8SvKudV2zZxQE6ICecA5puajUouvIwb2MNbBhCTgm?=
 =?us-ascii?Q?q0Np/BTjTDQLR+BrugpL9kam2zQ3gv4Dx8DSlV7Y685+TLG1d6cDaMolJoFG?=
 =?us-ascii?Q?Mth5rYBZGCFelRmyKgxJHyRrC/gs8v0da7vVb7Bo8vy2g1WDf9bNrK/A1zw2?=
 =?us-ascii?Q?vnQX4lNSUcXBtoKtBLmj+KbKQxsJwILROfrB5ny4WYK574Gy8Q+MhsEYOvnG?=
 =?us-ascii?Q?e/drc0/mS2ECze8ocXWT25+YfN5T2H6tJvIawsSzsNXA4idZlRRCeAYOY7ny?=
 =?us-ascii?Q?fP3gl8MPU6CxtGK4nzsqVS/eapokp5NETiw1JP4pssPOQ/ZOgb9GUOlZeL4C?=
 =?us-ascii?Q?d79w7KaU8QcUmMvy0szF/MUrreF6IHqo2t4s9T1mG72d2BWeotKrMfwyxRzM?=
 =?us-ascii?Q?aCAT9JCFvrDcdThTLLLsRyhUCOVK2/jYIap21XdjOP8VNzm36ekzxkyc6Kky?=
 =?us-ascii?Q?uWvor9Ln5uY71gsj1PMJV2XTAuUclgmg71rSnBAj2n2z3t4/JuQ/Th2rlAbe?=
 =?us-ascii?Q?kY5JHTJbL+o34o+vhoN9be2BP5Kxb3LN6nZ1yvxt22WbTva+dByd+QyOC6ms?=
 =?us-ascii?Q?k2D3Hw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 55a4958d-8248-443a-1104-08d9f838643f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Feb 2022 08:25:33.5222
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Nnvx97KSGim1zR5aPOM8Sut6GuTbywP5MVW2QLxTFxZgtlnZe/rayYhk7eDUh7Co2FpLfGpvgjgKcv7WfyBTqRnyaImj4+FhaVg8ldO7lVQ=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN8PR10MB3683
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10268 signatures=684655
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 malwarescore=0
 mlxlogscore=999 adultscore=0 bulkscore=0 phishscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2202250042
X-Proofpoint-GUID: 6kdoMeZNnqIYELXlQ9GW25rL1PYR_Vq6
X-Proofpoint-ORIG-GUID: 6kdoMeZNnqIYELXlQ9GW25rL1PYR_Vq6
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d8152cfe2f21d6930c680311b03b169899c8d2a0
commit: 9dad325f9d57508b154f0bebbc341a8528e5729c iwlwifi: support loading the reduced power table from UEFI
config: ia64-randconfig-m031-20220220 (https://download.01.org/0day-ci/archive/20220225/202202250921.59KWuV9B-lkp@intel.com/config)
compiler: ia64-linux-gcc (GCC) 11.2.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/net/wireless/intel/iwlwifi/fw/pnvm.c:332 iwl_pnvm_load() error: uninitialized symbol 'len'.

vim +/len +332 drivers/net/wireless/intel/iwlwifi/fw/pnvm.c

cdda18fbbefafc Luca Coelho   2021-02-10  256  int iwl_pnvm_load(struct iwl_trans *trans,
cdda18fbbefafc Luca Coelho   2021-02-10  257  		  struct iwl_notif_wait_data *notif_wait)
cdda18fbbefafc Luca Coelho   2021-02-10  258  {
cdda18fbbefafc Luca Coelho   2021-02-10  259  	u8 *data;
cdda18fbbefafc Luca Coelho   2021-02-10  260  	size_t len;
84c3c9952afbf7 Luca Coelho   2021-06-21  261  	struct pnvm_sku_package *package;
cdda18fbbefafc Luca Coelho   2021-02-10  262  	struct iwl_notification_wait pnvm_wait;
cdda18fbbefafc Luca Coelho   2021-02-10  263  	static const u16 ntf_cmds[] = { WIDE_ID(REGULATORY_AND_NVM_GROUP,
cdda18fbbefafc Luca Coelho   2021-02-10  264  						PNVM_INIT_COMPLETE_NTFY) };
cdda18fbbefafc Luca Coelho   2021-02-10  265  	int ret;
cdda18fbbefafc Luca Coelho   2021-02-10  266  
cdda18fbbefafc Luca Coelho   2021-02-10  267  	/* if the SKU_ID is empty, there's nothing to do */
cdda18fbbefafc Luca Coelho   2021-02-10  268  	if (!trans->sku_id[0] && !trans->sku_id[1] && !trans->sku_id[2])
cdda18fbbefafc Luca Coelho   2021-02-10  269  		return 0;
cdda18fbbefafc Luca Coelho   2021-02-10  270  
cdda18fbbefafc Luca Coelho   2021-02-10  271  	/*
cdda18fbbefafc Luca Coelho   2021-02-10  272  	 * If we already loaded (or tried to load) it before, we just
cdda18fbbefafc Luca Coelho   2021-02-10  273  	 * need to set it again.
cdda18fbbefafc Luca Coelho   2021-02-10  274  	 */
cdda18fbbefafc Luca Coelho   2021-02-10  275  	if (trans->pnvm_loaded) {
cdda18fbbefafc Luca Coelho   2021-02-10  276  		ret = iwl_trans_set_pnvm(trans, NULL, 0);
cdda18fbbefafc Luca Coelho   2021-02-10  277  		if (ret)
cdda18fbbefafc Luca Coelho   2021-02-10  278  			return ret;
cdda18fbbefafc Luca Coelho   2021-02-10  279  		goto skip_parse;

"len" is not set on this path

cdda18fbbefafc Luca Coelho   2021-02-10  280  	}
cdda18fbbefafc Luca Coelho   2021-02-10  281  
a1a6a4cf49eceb Luca Coelho   2021-02-11  282  	/* First attempt to get the PNVM from BIOS */
84c3c9952afbf7 Luca Coelho   2021-06-21  283  	package = iwl_uefi_get_pnvm(trans, &len);
84c3c9952afbf7 Luca Coelho   2021-06-21  284  	if (!IS_ERR_OR_NULL(package)) {
84c3c9952afbf7 Luca Coelho   2021-06-21  285  		data = kmemdup(package->data, len, GFP_KERNEL);
84c3c9952afbf7 Luca Coelho   2021-06-21  286  
84c3c9952afbf7 Luca Coelho   2021-06-21  287  		/* free package regardless of whether kmemdup succeeded */
84c3c9952afbf7 Luca Coelho   2021-06-21  288  		kfree(package);
84c3c9952afbf7 Luca Coelho   2021-06-21  289  
84c3c9952afbf7 Luca Coelho   2021-06-21  290  		if (data) {
84c3c9952afbf7 Luca Coelho   2021-06-21  291  			/* we need only the data size */
84c3c9952afbf7 Luca Coelho   2021-06-21  292  			len -= sizeof(*package);
a1a6a4cf49eceb Luca Coelho   2021-02-11  293  			goto parse;
84c3c9952afbf7 Luca Coelho   2021-06-21  294  		}
84c3c9952afbf7 Luca Coelho   2021-06-21  295  	}
a1a6a4cf49eceb Luca Coelho   2021-02-11  296  
a1a6a4cf49eceb Luca Coelho   2021-02-11  297  	/* If it's not available, try from the filesystem */
cdda18fbbefafc Luca Coelho   2021-02-10  298  	ret = iwl_pnvm_get_from_fs(trans, &data, &len);
cdda18fbbefafc Luca Coelho   2021-02-10  299  	if (ret) {
82a08d0cd7b503 Johannes Berg 2021-01-15  300  		/*
82a08d0cd7b503 Johannes Berg 2021-01-15  301  		 * Pretend we've loaded it - at least we've tried and
82a08d0cd7b503 Johannes Berg 2021-01-15  302  		 * couldn't load it at all, so there's no point in
82a08d0cd7b503 Johannes Berg 2021-01-15  303  		 * trying again over and over.
82a08d0cd7b503 Johannes Berg 2021-01-15  304  		 */
82a08d0cd7b503 Johannes Berg 2021-01-15  305  		trans->pnvm_loaded = true;
6972592850c00e Luca Coelho   2020-10-08  306  
cdda18fbbefafc Luca Coelho   2021-02-10  307  		goto skip_parse;
1c58bed4b7f755 Johannes Berg 2021-01-15  308  	}
b3e4c0f34c1752 Luca Coelho   2020-10-08  309  
a1a6a4cf49eceb Luca Coelho   2021-02-11  310  parse:
cdda18fbbefafc Luca Coelho   2021-02-10  311  	iwl_pnvm_parse(trans, data, len);
cdda18fbbefafc Luca Coelho   2021-02-10  312  
cdda18fbbefafc Luca Coelho   2021-02-10  313  	kfree(data);
cdda18fbbefafc Luca Coelho   2021-02-10  314  
cdda18fbbefafc Luca Coelho   2021-02-10  315  skip_parse:
9dad325f9d5750 Luca Coelho   2021-06-21  316  	data = NULL;
9dad325f9d5750 Luca Coelho   2021-06-21  317  	/* now try to get the reduce power table, if not loaded yet */
9dad325f9d5750 Luca Coelho   2021-06-21  318  	if (!trans->reduce_power_loaded) {

Can trans->reduce_power_loaded be false when trans->pnvm_loaded is true?

9dad325f9d5750 Luca Coelho   2021-06-21  319  		data = iwl_uefi_get_reduced_power(trans, &len);
9dad325f9d5750 Luca Coelho   2021-06-21  320  		if (IS_ERR_OR_NULL(data)) {
9dad325f9d5750 Luca Coelho   2021-06-21  321  			/*
9dad325f9d5750 Luca Coelho   2021-06-21  322  			 * Pretend we've loaded it - at least we've tried and
9dad325f9d5750 Luca Coelho   2021-06-21  323  			 * couldn't load it at all, so there's no point in
9dad325f9d5750 Luca Coelho   2021-06-21  324  			 * trying again over and over.
9dad325f9d5750 Luca Coelho   2021-06-21  325  			 */
9dad325f9d5750 Luca Coelho   2021-06-21  326  			trans->reduce_power_loaded = true;
9dad325f9d5750 Luca Coelho   2021-06-21  327  
9dad325f9d5750 Luca Coelho   2021-06-21  328  			goto skip_reduce_power;
9dad325f9d5750 Luca Coelho   2021-06-21  329  		}
9dad325f9d5750 Luca Coelho   2021-06-21  330  	}
9dad325f9d5750 Luca Coelho   2021-06-21  331  
9dad325f9d5750 Luca Coelho   2021-06-21 @332  	ret = iwl_trans_set_reduce_power(trans, data, len);
                                                                                              ^^^
This is the warning if those conditions are possible


---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

