Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 29A0F49FB4B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:06:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345119AbiA1OGM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:06:12 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:42940 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1344330AbiA1OGK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:06:10 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20SCx9FI015926;
        Fri, 28 Jan 2022 14:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=YtXlfZUTOj071foNGQcbYHZRVOyZdcZ20OxobC8ehDw=;
 b=bfipxae4PIhncZWtUe7CI/bQjlBIFilai3igq2NAAsVAhytNOIn1KpxeETx3G4Hq1oKW
 flGcqUnnIx5kJeI/OM7PPL/WLVCesG11Y302xINEYyro6tLH8JGxPiPczqREXfNpEZba
 y72kKFZu4tNPd657OCZPL+0ZVqOUbtqaj3Csxbv3u7bQM9095JYE6FXpxSmDzjkiNp7R
 Is+6RLNREsYfbT7EHJTpE9k8hgsvmFHFjMMJ+7TQP1q3ePyke410pROHLefmuQrpsU9r
 NZTOzZDDTXTw+p2Cq30AasoL4oKC5Zyi4rrrQg4ijBOjZgD4L77fmtc2REoS0L+6Fnc9 Hg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3duxnp2w1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:05:50 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20SE5Arj168632;
        Fri, 28 Jan 2022 14:05:49 GMT
Received: from nam10-dm6-obe.outbound.protection.outlook.com (mail-dm6nam10lp2100.outbound.protection.outlook.com [104.47.58.100])
        by userp3030.oracle.com with ESMTP id 3dr725qvma-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 28 Jan 2022 14:05:48 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mKp4YOUz3YpBjESrGh1NyDfdE6PZdZSXoK0vL91HuH1YLD3tZ3H/AUBC7S9EhSwttdRoCclaKax4/EmgFoItYRBdbc5dYPMHvGGrjtJW06FGD1MFh6e16uiyLkjRvJRceFoe7xcZh1Zmw2BIRrM3lNmtiSTDT3syciG3xcbYAaOjL41E7Uy3r0C2WVYvpvgYqyDYBeb8I3P9YLNsgJS9XCBNeyb8i/4V7TU8QalTW7bjycqUWur7+/V7A5gQKBwhGulNhFjpajggrI8c8IYuDE9lq7RPdv2MLBGkb8appwqxqwUdJDzbRhMwSQaHWfmrp1Z6v2vACyoCAji/M0M6hw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=YtXlfZUTOj071foNGQcbYHZRVOyZdcZ20OxobC8ehDw=;
 b=VIoXZ6/LWtychX/+owV1u0aOi7gn29V943VY3i6A7aQiXZj/tRhVE90Rm7ZkOeXN13wv/35ZOrnV3Z0NbiyJRDhtcLv6KABssWOWH8oeVllPW5nBpnxK7TFxiUY6yLW9PcH5X9ZJoK2DheiKiMP1cFmVomoIkZyO+oLxeI77adkxWyKIlGhxRN83v/DuEGngt/6acApb8tN0nWwzTe9Zqh94hfDSiFPclDbwdYTp7RTKvoaEvwEv7gv7m/81Jf+jILJ0mhUAXlDBIorCNgati81V81heDXUjQNuVamU8loEGPawQ2zKR+p6PTKkSSpKmPAjgM1d7cIsAPJdBorBK7Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=YtXlfZUTOj071foNGQcbYHZRVOyZdcZ20OxobC8ehDw=;
 b=WJusDyowVlbZyucBp/Q6uSy3fwuJN44jURctVX903tswK6ivpMaD9hmL8a0QsBZq8wI2AWuE9FWLDvzAnS5mkLHkNDmGU+xydlpBlmX4XrWBOGBoFtSJx6mOyUUPmVg2nlz7XWqK77iA6ZSW0nUPF36Of7bwnNoKo73n25eBRSw=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by CH0PR10MB4939.namprd10.prod.outlook.com
 (2603:10b6:610:c0::14) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.17; Fri, 28 Jan
 2022 14:05:46 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.019; Fri, 28 Jan 2022
 14:05:46 +0000
Date:   Fri, 28 Jan 2022 17:05:27 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Mark Brown <broonie@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 1/2] ASoC: ops: fix signedness bug in snd_soc_put_volsw()
Message-ID: <20220128140527.GM1978@kadam>
References: <20220128112007.GA24806@kili>
 <YfPknO6si9CpotgS@sirena.org.uk>
 <20220128133147.GL1978@kadam>
 <YfP0PGbyFVDOevIH@sirena.org.uk>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfP0PGbyFVDOevIH@sirena.org.uk>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0040.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::28)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ab4d378c-b1f7-4846-d676-08d9e26747f8
X-MS-TrafficTypeDiagnostic: CH0PR10MB4939:EE_
X-Microsoft-Antispam-PRVS: <CH0PR10MB4939DBE1CB5B2F8792B66E8C8E229@CH0PR10MB4939.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AOcIhlzWh3z0lytIX5mCEF7JFnkTlJ/GnpW0QQCGMYRFhxLZPWyuZWSH2Yf1AyJ/U/noctLfzu01Kfmf9rHNk6mtCl4Mzft+0gTtwP8uiG5gyJei5+U8iwremImWMHm63Hn3zh6yYtYvx9/sha86KvPLWH83Y/+prxvmTofKffH52wExpjmjoYgTBZhp+h6mxqkev9pq9o9vA9NKPc5qaCAx6ByEPBbmmb9GWCQSsYRwl4vPRwNdwurFmaDK+bC0rTetpJKnvtX2H4IBM7X2tt1uv/LVTFq4oc73Ao5NQ0d+F7cjeQx2W6RFAPtX6wSWPwz3RXxOg/rTc8OGZqkXgt7kzbckWebhCRLQJi/+/m47XQHM/a+/IDnxs03Y1VL5OBeWqg8MKzAJUscOlOEyS8uYYCnPg82owajB81rvL3fsVIkVsjjK6aJZUbQEfqT4em/MmHPYwfkiKjHfoIRPIU4iIqvFSIeqzYu5KmJt/1bqFX8EQ65/5i7X6fsKkBoHxwOJz8ZOcpRp7f9oF9y+KUscw7CUTBNg8HY4PiCehV5m7a3MatAwbjZb+Anb8oMSAnewFgtl1iXeaymHqtagTc5TzURjbFTPHYVixEZN8IwP2mLcaJ4EiE+nL68DJ8xWwKjrWeim8rQRpTkwaQ2san/M1RWZDsMngPXVBXwglT2RMTTEBVyDT7Un3PHWb52UHjulKaBBiHV9czREDDTDHg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(6666004)(6916009)(33656002)(8936002)(54906003)(4326008)(86362001)(38350700002)(38100700002)(66946007)(8676002)(66556008)(66476007)(508600001)(1076003)(6486002)(316002)(186003)(9686003)(6512007)(4744005)(33716001)(5660300002)(44832011)(6506007)(83380400001)(26005)(2906002)(52116002)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?eC/Hwc5wvCwDcTmNdFULIffLX93ASHh/atWRUFvkCWWw1PoZ8HkqSNDVZ+tt?=
 =?us-ascii?Q?7SmS3U2cVxuT5FKAfOv98OI2TfKIuear1nm8DFJfg2vikpuUZxZGuK1ZY5C2?=
 =?us-ascii?Q?XArah1Vr8H4IFJePddwnqkJSLNCGe/2WIbC6YVMstdExk6/NSo4amKZCH62x?=
 =?us-ascii?Q?gqOPeJlW/BIiMyAz+rOyr6PEZ6MAn5rXSCZ1nuUplY8g8FmgSIABwKNmXyIL?=
 =?us-ascii?Q?OHEKL9++A+V1Or1ZFwwTo2IeX03KBVdX8UyhjZuux5co72DtQRIX8Lvhm+K7?=
 =?us-ascii?Q?dlcGIqIbhNE6wANvF4s5LCYdtdx5FCs+59Xah0ATPgii0czZext0xv5qS8SQ?=
 =?us-ascii?Q?1fDJZBNBoeP5vKJhpmJooKSxnGZiaR3d7zwbnfLbJGdMaB7/0TfyQ6rUo15j?=
 =?us-ascii?Q?TReQbL2W9DSuPAhsvd8te42i1TV1hgKFoh3hKpbn5lXkaExZNMUJ99kL6a+b?=
 =?us-ascii?Q?WM5v1/2F84gOumqhcTmqBdEALI5sSS4cJm+e+WhYXyDH05okUdLpVm96l9oA?=
 =?us-ascii?Q?sCyf7seYHS2PdsPU6SNSuht/J5KvN1hEnmcqXhrscw1HJNLKATB8cALAtS8+?=
 =?us-ascii?Q?biwFdi5hEVSLxLZ+DpVFUhUS5cBlHTF13paL3rhRz2hH8ZuHIAGgV38Bdk2v?=
 =?us-ascii?Q?uK6bJM3FkpKIu7mFN1SZvUyxnKcDlADZ1uywIeUoJinSfZdckNxrZDhKam0V?=
 =?us-ascii?Q?uOiT8kz+wvHEMiuvaevzPdCSNcTyHxIT9myY+KCxNjIJNlktRALyIH1sdF2f?=
 =?us-ascii?Q?NPZKnJfVtfI9l0O6zJbaGDLgNh22Wad3fcrj3Im2HyDcEWpt3GQO8hGN//64?=
 =?us-ascii?Q?Rl9XhXsooNf5VjM51z3Pmw8i4z/h60pVAQmrqUbj63TDB0Jkbgpni0fzRY8f?=
 =?us-ascii?Q?cLVfZwGQgeVEPicHBv4oPFCh0nEtt4KKOaHW0wThNfZjF+ig0CF3ldOKyaLb?=
 =?us-ascii?Q?FP9rWboSs/wAXRju7oZ5kAEtfYez93tCWwgMmyDe2YewO4KH37Z3SDi5dCOK?=
 =?us-ascii?Q?JBjMIXp/AOtaGOib02YJJoCPgoAo8KrO53eIy9JTO7l6loh1qNL7E3in6zfi?=
 =?us-ascii?Q?tzQjHLS6+UZtngik+M6OC2NjtzlcoLJAAur5a2aPjt39Tej0u0k4dToAYLvC?=
 =?us-ascii?Q?cec9l6+XkdOTl+hxSaCModVW6DZaNNvNoKa2wZVbL3b1yXoyFvTXFUGljzRt?=
 =?us-ascii?Q?ZphrlN2tkNhbRSiH7HCuwQKfXmllzSQp7g5piZ7ZmehXfTENJMouW9CFA0Zp?=
 =?us-ascii?Q?kODT5J7Ucogd1dv3c5IOIzyEotRA+r/fV/OL6DsxOM+ijkZjOk8IeGQjiEcp?=
 =?us-ascii?Q?+NNu4Ctc3zBHrqTyVl8D/K6ZuphshKV0Q9UQKINe72ejXLtlEH5TF/1eCT6D?=
 =?us-ascii?Q?Ryavt7Ey74/FOH/KjBjJew0CajorHx7QEl+2IAvt91ZpktoOp3A/VQdBT5XZ?=
 =?us-ascii?Q?7v584u/Vb9HSpv8MwCgxvsD2aMghE1nKKtF6TF+pV+u42WCwKdU5v4JnhnHR?=
 =?us-ascii?Q?s0YcwaoO0whPVgbnHAzwMkJxbSivQk1zSqHCLU4hF8R4Z7LhbRoyHcSkuUuO?=
 =?us-ascii?Q?h/PRhS9lLVdQJGQUnRe7O5iQFCqtIXWxAxeGmfNA0qHhAJDGplQPePsX1Uo6?=
 =?us-ascii?Q?8Pdq5g8XsPVNY7qLQI354LLZH2cy03de7UdneXmLoJTIcBUDh8CYdhYgAk9D?=
 =?us-ascii?Q?O5jEM0Q6lbugKHCVFQvfnkgaQx0=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ab4d378c-b1f7-4846-d676-08d9e26747f8
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 28 Jan 2022 14:05:46.7884
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 2e9/h6/ZKZORuOhmKurqg1YT93taca6qS+34w0GDwtA4wOwzc45Z0ory04UYIY7mREwjJb57Bh8iPv5VIMiWjJvSxRtNuWvOCwcnCN+7gZU=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH0PR10MB4939
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10240 signatures=669575
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 mlxlogscore=999
 adultscore=0 spamscore=0 bulkscore=0 mlxscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2201110000 definitions=main-2201280090
X-Proofpoint-GUID: 7CZFm7prRQ_j1sBFkthEmeJpGpdk9DyJ
X-Proofpoint-ORIG-GUID: 7CZFm7prRQ_j1sBFkthEmeJpGpdk9DyJ
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 01:48:44PM +0000, Mark Brown wrote:
> On Fri, Jan 28, 2022 at 04:31:47PM +0300, Dan Carpenter wrote:
> > On Fri, Jan 28, 2022 at 12:42:04PM +0000, Mark Brown wrote:
> 
> > > This means that the helpers won't support controls that use the top bit
> > > of a 32 bit register.
> 
> > Fine, I can delete the checks for negative instead (I'm surprised you
> > haven't already received a dozen bot emails about this).
> 
> No, we need the checks for negatives since userspace supplies a signed
> value.  The check needs to be done on the value in the input structure
> before we pull it out for mangling.  I probably got bot emails but
> frankly these days almost all of them are some combination of barely
> legible and misdirected and there's plenty of people who like to fix
> these things if they're real.
> 

That's a bit trickier than I initially imagined so I'm going to leave
this for smarter people than me...

regards,
dan carpenter

