Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2317C4A4076
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 11:48:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233361AbiAaKsy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 05:48:54 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:57492 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229973AbiAaKsx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 05:48:53 -0500
Received: from pps.filterd (m0246627.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20VAToFA030666;
        Mon, 31 Jan 2022 10:48:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : content-transfer-encoding :
 mime-version; s=corp-2021-07-09;
 bh=0jqhmKJAgU1GU9lvb1h9xbmaCA8NmHclhbSYUyl1yqU=;
 b=iLe6IaxZPZFWKUPzkgRv7/LGpDuLftSwNxGCblZ3BiPgkKJdOvPXUz+v6FY5gIIJeZG5
 S0CSBav/0VogpTEGKgLzCQfizRTz23WUbssE6BiFSpRqTLmSxhc3eU2vM3tbOtPZhUVO
 lr7ytkXkewbJp0K2k0ZUKDOZmZFEYCe4vmW56k+xs6Uc+R9cHgILQvl4xNnfKDMz4NAz
 oITV0icQGBLVU/V1QMt3OA0VEdDxTgl2roJLp4F4DZe+JGg4uZjiXu3oa/hEs0DSQKMt
 G1Ufe4fQZ0bwA1f5RGtcz0Qdo68mPJj3BZWwUjD917ldhTNRu9w7SzhiSbxJVYzW6eYW RQ== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dvv623nxg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 10:48:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20VAjb6i125241;
        Mon, 31 Jan 2022 10:48:43 GMT
Received: from nam12-dm6-obe.outbound.protection.outlook.com (mail-dm6nam12lp2171.outbound.protection.outlook.com [104.47.59.171])
        by aserp3030.oracle.com with ESMTP id 3dvumd97gj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 31 Jan 2022 10:48:43 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O02dB+o0jae0jjXiyJl4voR8XQ5sr+xhgX/7pHR1KmQshTbb8IC9laLFQf+i4cqOt4g2jmhKPnKj1ApkKb4vOARJ11JBDTynNZa2pqfd047pTa88IbEl2XHvG4YAqZxbSmXlvQFnMaRDzd0VmFFPoZQyAn3QPQkM/XhA+hPZJIxDbZuqPVkLeZ6egmsKyA77ZBmLD2wCQQah9saJvMtp3XtlbgYe8zhCh7LSX0dUoSg8KCn9DdgLHJxkSupilAsIabP/mJQe4/E61W7MtQ4ER+Ln4llR5NDpKAqD4vbn0rSZZN3BWRhmz/eeKRbSEmLoIJbi7kKdNM7tYpCaCfRXiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=/ID6KkYeVU2X6iyi5DcVFRhfkbsQZ5sKFF3u8vIefIg=;
 b=Jp5wrIGU90P0z30aaG1DhP6goMd/mPqg14WuKz+ESceeppU3rf9T3ap9uAsGUeyp6DnIRdbFS7o4PJG1Btt5WIkclaKDJRh3V8kXw9CXmShFvZjDVA8u4zO+uJ+9BVUEDGSMS44APgCjXc1RKAz27wKMe03VJPb4tOM0qqXbUkRW9+1rDUh1HU3TCG6l2C4bEwMIs7o5Gz152d31eEHBYaTRG1csndQhrydlEn3lx3YSAdHhdEwhb0hPeAU1WmeJaz4PbeZIxrKL4WO/7RmFJn2sSKx4SY1f7WWVad1C1nwFpcATocE2GverzVmJHN8iZQhcofYxF0CeISOesMMFMw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=/ID6KkYeVU2X6iyi5DcVFRhfkbsQZ5sKFF3u8vIefIg=;
 b=NccStSmAYVekInVyEgy6oiheh2aTz7F90cJjneVpwvFPdhY27VVdzijKZKA2Tt2eawevCcXWESiT68T3D8TQrll83zKOeM7F/J2nZwEDVYLKHay1EOJOQ3xUqsaXZUGDsnE1AhoK446a8+9Wo9ooGIxmgbU01mhk2GYEyKl/kyE=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by DM5PR10MB1484.namprd10.prod.outlook.com
 (2603:10b6:3:12::13) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.19; Mon, 31 Jan
 2022 10:48:42 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4930.021; Mon, 31 Jan 2022
 10:48:41 +0000
Date:   Mon, 31 Jan 2022 13:48:18 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hridya Valsaraju <hridya@google.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        GNU/Weeb Mailing List <gwml@gnuweeb.org>,
        linux-kernel@vger.kernel.org, Todd Kjos <tkjos@google.com>
Subject: [ammarfaizi2-block:google/android/kernel/common/android12-5.4
 7700/9999] drivers/dma-buf/dma-buf.c:728 dma_buf_attach() warn: ignoring
 unreachable code.
Message-ID: <202201310537.vKqvJhx3-lkp@intel.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0010.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4c::15)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: be9b1245-fc9f-4635-524d-08d9e4a73ea6
X-MS-TrafficTypeDiagnostic: DM5PR10MB1484:EE_
X-Microsoft-Antispam-PRVS: <DM5PR10MB1484D7664B0B6D9EB23F0BF58E259@DM5PR10MB1484.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:163;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OM+648p7braw0vAuRfwbe6SNlCgarwd0O/KnRZsownYoydQpjpH1xF5c54NIYVlN+6CHQ6C5M9E0KgVSQn9noQlrvSVhdNFsnY81LX8r0g62LGsPuTNBGnz8XF2uhBWTjl6FuOeMCzdBCT+RCavLniDJ3Qkbu7uMNyZWw1BkPo/bJEk65vKNZXO4iiOBHmVE1trNx30+oIsWGplLrPpueUC9yHNoTEwFhScBw4aX3VrpVJEfvkfuvJKN9ntKKSLCoaejSdgxxC7XOHTOeRxOIOr6RTZyr8QfwBAOEyiDFAwcgkbujmi7epSoMf9oAa0mQkeimWEOiCcKY/KJQS/FYzUGy9d+NbrngF9KTk8rIw3vePFeOHGjYzEtyRugoTA1E/48IW9c81eGCmiXZL4H6IsU0YY211EAIlAKTE1YdMVUmV6+6wTp0BYTrrhiUSBfMNEd40X8FRN1A/p52aduxabZasuuhuxxbhwX16Xp+jukawl0KNLPazUUf8ti9IYRPKZvR+rQOWJTihRyKC9eKcPBAcxJvQLIDRQ8uMErL8oj/gb/upAmsGsIxTve6x+7kp71zyL/QEsrCBCStivW337T3iCvpOp7EXyLCcIqhdaJrKtxUB2CFHtfIBAWsXzzUhbCyMtn2ShWiX8koBMPLWzLufRQI5MHTHcwFV1FqJdKgN0WhqKmvs/uZpm/sFVCOyvijFa5pbxpDRREpmsotfGYR0ILqheP4dmhHgAqwmOzQSDRy8jeTr8SOQ7rm70zk+na9MDaXG2XDS+JAF+MJO0uHWUJ1/1A2nn93kBL+52fzR4gbOhDgm+t628uQi4/MbSl2lxRERAUTQaTF6XZ6A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(5660300002)(66556008)(4326008)(83380400001)(38100700002)(44832011)(52116002)(38350700002)(86362001)(36756003)(9686003)(4001150100001)(26005)(6512007)(186003)(6506007)(6666004)(1076003)(8936002)(66476007)(8676002)(6486002)(966005)(54906003)(66946007)(316002)(508600001)(2906002)(6916009)(66574015)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?60mrwX+sRNXYD2sYVtyThSLUZe5SY82CTwgkkpFcIH56H+d5on3CSDxcac?=
 =?iso-8859-1?Q?y/ylB6PDiVRsAwIG1MkTJjqvtAt7/vjqhoJwI2jGV7b1vpSuaAX+03vQic?=
 =?iso-8859-1?Q?LhzSbncspQLaW0pnZejpbHxT5MysVkq8i3Oq6IujVXxQLMgT4itUyg9/QF?=
 =?iso-8859-1?Q?lhqyRQI+l44LnA1M7weVAo05PtK6AUq4NDrqfO7Q+5ziwbbq5EIkl4wLLj?=
 =?iso-8859-1?Q?y3g/zEDLnL2K3MDBUB2AkQBznlVKhyvhJX23OM90oDvberleQAuWcIDS7Y?=
 =?iso-8859-1?Q?RFEw2b3IIIUeKSbB9cfWgq19Rj7uFZf9dQ2luKoeNhdclbNPiBZV1cB4mT?=
 =?iso-8859-1?Q?A6yJkpQ5E9UGx54uM1fKzGXa6zWMyNWG9TPVVhA+PWj6tr5c25XnEbqjFr?=
 =?iso-8859-1?Q?+QH1zf7PqXPvTavbinu+KWeCsiskYVsv1rEOR51KSiQaC6lhWpJfNTnCo/?=
 =?iso-8859-1?Q?bslPxX1Z9DBRhylPNYVMGnjltZaLOz9SpgGfBb0ZBmNl6IRTPpDOB9iZm2?=
 =?iso-8859-1?Q?bdVEo6Bk0c2smFU0AqwLJ13UOK5hT0uwDb1r5FPhAXWSc+TvpQtgCPkbDN?=
 =?iso-8859-1?Q?mgVE/ycb9FFic+eJhgjQn5OcPwWKShl81+C6+jjCIEvB/vzr0v16gikHZR?=
 =?iso-8859-1?Q?GEui69aWoUMWOOxtLiTpWoBD83MpeL3p75WybWglA7zKZkRr3FKMtZMv2z?=
 =?iso-8859-1?Q?dCpk224e6Oj5uArPTtCQRiPxNscsfT7N1sdXYiM1KxbYlrsZU+rsH4uUaj?=
 =?iso-8859-1?Q?2Zczrhic64lDABlDyFTPsBnts+FzA1xSFaiweoTXVroBcCi4At6L1WMoa5?=
 =?iso-8859-1?Q?8Sghp04/1/daSQouPO7vzjAmSWiDOy5tESZ9A/2MqEfDex8HQlyxKsj8CD?=
 =?iso-8859-1?Q?aqSJcyPL3z8sHKlBC3Fe/YZvFEyY12oifLzJC+Bevf2MLQqmYnE9AAk8gH?=
 =?iso-8859-1?Q?NFlWgsH7PmdV8gpdFnOkayddENEMkBejTdiIM3mUvALQTMHHBP80+/6lpD?=
 =?iso-8859-1?Q?EJdyEgzgyawmCyCiMDj2BOhOGMz5oO2g9XHSi9PLC9ITb7f2lNLP8Om46m?=
 =?iso-8859-1?Q?jcLCpvMYA/St9ZqQOAszdBg1D/8GyQyHZLuNKaBPzUa1Sq8GhQGF8jk6bo?=
 =?iso-8859-1?Q?qsByoO2H5OOhFcfwgIB7saKYLUz57p+WcA75pDJY9Dususq2U080fGJCWa?=
 =?iso-8859-1?Q?mvmrv5SWYB6HzlcC4vmQ8NxIOxSjVhzK6rrOSmNPFxOQzDkNmD+50zrMzx?=
 =?iso-8859-1?Q?Tkx6rMkeOecF9MsdeMWDDOiu2VCeXRtbc901dvI7Bqy0Ek0TwAlqiXeC9k?=
 =?iso-8859-1?Q?dBd0wXKM30/hjyeG+KN+C/42h5/rJMxTXfqy/g6pGYCTSeIivXmbXDkAig?=
 =?iso-8859-1?Q?Uf8TG/mBpd7ktkmdSPmBbdcbsqIRkB1tWk3fAUq+xOeKZ85fsWWHspBhn1?=
 =?iso-8859-1?Q?NxLsx1C7iAnnx/OxrHVrVJp5YzHMr2bdfv9vRLJq8+kXMib5IBABXseR7K?=
 =?iso-8859-1?Q?EATzqH/1PPeT5nmRNViWuFM5nIqRMPjdBpq9OzE+kG9FQQsFPVJBy4rMBv?=
 =?iso-8859-1?Q?y7kcv9YDWGcIeI6DHAUsBsraoBgB70uIKJybg3GpeCj6ySYDACs1DYNbsH?=
 =?iso-8859-1?Q?5E9Bgjqinemo++p8rilrsVGERVIO0hYPk4eEnCTA0Wo7UYCYn5kusrINnS?=
 =?iso-8859-1?Q?X3ZgE0g9kHUtEzR9fuK1+VP0bdGtDVGfdRAHf9Ri4W2WwZcRau750zadDB?=
 =?iso-8859-1?Q?Sde9qrQ/OTM8ofePhrRT0zJlY=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: be9b1245-fc9f-4635-524d-08d9e4a73ea6
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 31 Jan 2022 10:48:41.6081
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0WymnIW2jPCAWHeO/aSp2nZ9DO5S1lRmAPwkByPdvixUeqt59h3MGVrblhTznZdMsx5dL7hykp1N2RWbIhnC3KZl89ewIGdHluGPPtWaLCM=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR10MB1484
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10243 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxscore=0 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201310072
X-Proofpoint-GUID: Gi9Wm5y4PswOm1oC-flpxWZDzz2XV5Tl
X-Proofpoint-ORIG-GUID: Gi9Wm5y4PswOm1oC-flpxWZDzz2XV5Tl
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://github.com/ammarfaizi2/linux-block google/android/kernel/common/android12-5.4
head:   57f9b292a6a391387c75515c18f47005fbdaaaf7
commit: e618a51f562f1f038f31b6a4b4a250c062d70eab [7700/9999] ANDROID: Delete the DMA-BUF attachment sysfs statistics
config: x86_64-rhel-8.3-kselftests (https://download.01.org/0day-ci/archive/20220131/202201310537.vKqvJhx3-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/dma-buf/dma-buf.c:728 dma_buf_attach() warn: ignoring unreachable code.

vim +728 drivers/dma-buf/dma-buf.c

d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  696  struct dma_buf_attachment *dma_buf_attach(struct dma_buf *dmabuf,
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  697  					  struct device *dev)
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  698  {
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  699  	struct dma_buf_attachment *attach;
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  700  	int ret;
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  701  
d1aa06a1eaf5f7 drivers/base/dma-buf.c    Laurent Pinchart 2012-01-26  702  	if (WARN_ON(!dmabuf || !dev))
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  703  		return ERR_PTR(-EINVAL);
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  704  
db7942b6292306 drivers/dma-buf/dma-buf.c Markus Elfring   2017-05-08  705  	attach = kzalloc(sizeof(*attach), GFP_KERNEL);
34d84ec4881d13 drivers/dma-buf/dma-buf.c Markus Elfring   2017-05-08  706  	if (!attach)
a9fbc3b73127ef drivers/base/dma-buf.c    Laurent Pinchart 2012-01-26  707  		return ERR_PTR(-ENOMEM);
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  708  
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  709  	attach->dev = dev;
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  710  	attach->dmabuf = dmabuf;
2ed9201bdd9a8e drivers/base/dma-buf.c    Laurent Pinchart 2012-01-26  711  
2ed9201bdd9a8e drivers/base/dma-buf.c    Laurent Pinchart 2012-01-26  712  	mutex_lock(&dmabuf->lock);
2ed9201bdd9a8e drivers/base/dma-buf.c    Laurent Pinchart 2012-01-26  713  
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  714  	if (dmabuf->ops->attach) {
a19741e5e5a9f1 drivers/dma-buf/dma-buf.c Christian König  2018-05-28  715  		ret = dmabuf->ops->attach(dmabuf, attach);
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  716  		if (ret)
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  717  			goto err_attach;
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  718  	}
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  719  	list_add(&attach->node, &dmabuf->attachments);
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  720  
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  721  	return attach;
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  722  
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  723  err_attach:
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  724  	kfree(attach);
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  725  	mutex_unlock(&dmabuf->lock);
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  726  	return ERR_PTR(ret);
                                                                                ^^^^^^^^^^^^^^^^^^^^
The next line is unreachable.

90935b28546d2c drivers/dma-buf/dma-buf.c Hridya Valsaraju 2021-02-01  727  
90935b28546d2c drivers/dma-buf/dma-buf.c Hridya Valsaraju 2021-02-01 @728  	dma_buf_detach(dmabuf, attach);
90935b28546d2c drivers/dma-buf/dma-buf.c Hridya Valsaraju 2021-02-01  729  	return ERR_PTR(ret);
d15bd7ee445d07 drivers/base/dma-buf.c    Sumit Semwal     2011-12-26  730  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

