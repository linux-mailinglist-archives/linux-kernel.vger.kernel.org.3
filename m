Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0CFCC49CAA9
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Jan 2022 14:21:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238897AbiAZNVu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Jan 2022 08:21:50 -0500
Received: from mx0a-00069f02.pphosted.com ([205.220.165.32]:61024 "EHLO
        mx0a-00069f02.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238021AbiAZNVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Jan 2022 08:21:49 -0500
Received: from pps.filterd (m0246629.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 20QA5lfC010061;
        Wed, 26 Jan 2022 13:21:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=zJyOlWkCNaAIaxfktFpdQCPDrMyKr6EEPpEbZYAWeQI=;
 b=xQx3IkEBwwschUqlMoL1Z9refNlrIPw2GDoriewEmT92c1DyYcRyxpbzXhNw/qtPusFc
 71Os6/7dLOGsAkqOObJoxKH2ouWGLEZJ/ICJdTF/J2lWdcd1KO7YorZJMqHRVVAIkXbb
 omOVFUQcbd/tqsWfmQIPf7ssFLaa10Qx47oG0ttBsfnoHsPvXjFJHjOmsbUTchFqm8CE
 qm5uIBqZaKI8BOQgFlc1IAWJsY2FMcFxCT6yDU6o3mIvk1w6u4+/FvcIukNIuDXdcoFa
 RFPhrOgFUnYsYh1f6cIZ3/BRfcOVj9rXB3Wp8vhWdTRuA4wtAS/0aWvgxEKkJxUp35+8 xw== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by mx0b-00069f02.pphosted.com with ESMTP id 3dsxvfnvtb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 13:21:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 20QDGUIi137504;
        Wed, 26 Jan 2022 13:21:39 GMT
Received: from nam12-bn8-obe.outbound.protection.outlook.com (mail-bn8nam12lp2169.outbound.protection.outlook.com [104.47.55.169])
        by userp3020.oracle.com with ESMTP id 3drbcr2xny-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 26 Jan 2022 13:21:39 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=H1cwmnnOB5oX/FE2tDFXp7IlJ/A3b6KeB5VEhXnw43qqQHmuqTPuYfIdd1oTsm0Wt9WP2WLYiy2dg6o6hy19h/UAGOkyMocd3DzmELbJ9mLEwUXTEpkz2+DpLcaqmPD4SEC+7WALcWbTRnX6kCxcRH9wdRZKJdoZhYjpXH9g1M4zYvX4VmFAb5Xa+o9JmL3Ka238Wo0n/e8sYse0B8FHXlSwJQeGyCWcYR4bWB8MBZwmYVi9eEG2KkX2ctH4Ywpa2SLVGz1q6LCDCagfCNsd4af57ROCn9swe3D5sOmIVIbPny/FV3T099kBKm5xF3vdPePqoTyw4eoZTCnwE0shPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zJyOlWkCNaAIaxfktFpdQCPDrMyKr6EEPpEbZYAWeQI=;
 b=Lr9t8EpMczdzP64yKDwhD3vg2XpOFEymG0eFYT1uc0ag1t6bK8ev8HorSKACXmN9DXAcdqWaB64HIF7a+7CJX4HmFj5hpLGax41Vk2dZjm5kk7CxPiWqyYctyLRw2kcEMuVMUDMkvUHBIvU4msIU/L4iVfKGLUjCtQFbd3ORENWGklo7+kPkhSxVpmJdWFZCgMVsbwu2FrAQMUoSCHoITEgZFHFsJETvyQFXQdyiBWGU3hMny8FilFvXk0iJzRmhbxpI928JpalNLjpVSBasvpywd3HLNbfa6WJZFyXIbt4TnMQ91gA8OgGLnfV157V4xslJnRbrs2ZbT+SCwP62xA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zJyOlWkCNaAIaxfktFpdQCPDrMyKr6EEPpEbZYAWeQI=;
 b=SxcidQnrLbekz47c8su5YUhnqStkZeg83x85/db6kx1d65wPtFyWIpqYHYwePNiRAoNC071nPEx4eJzPrGUwXOULeFNF1iAfB1HxBmDDSV9/WmSl+LVpRHdg05cvt7t9i6iVdM12V3A0IZDepdngdrgHG9oIX5XLaA1F9WV/fo0=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2654.namprd10.prod.outlook.com
 (2603:10b6:805:40::17) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4909.12; Wed, 26 Jan
 2022 13:21:37 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::c13b:5812:a403:6d96%6]) with mapi id 15.20.4909.019; Wed, 26 Jan 2022
 13:21:37 +0000
Date:   Wed, 26 Jan 2022 16:21:16 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Paulo Miguel Almeida <paulo.miguel.almeida.rodenas@gmail.com>
Cc:     gregkh@linuxfoundation.org, realwakka@gmail.com,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] staging: pi433: add debugfs interface
Message-ID: <20220126132116.GA1951@kadam>
References: <20220124042506.GA7662@mail.google.com>
 <20220124042721.GA8078@mail.google.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220124042721.GA8078@mail.google.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0062.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::17)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: abd4f1e2-22dc-4780-ab81-08d9e0cec79e
X-MS-TrafficTypeDiagnostic: SN6PR10MB2654:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2654B62C8FE390628F0D88B78E209@SN6PR10MB2654.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: iMSWbXJl98yQXoIvXkCJhTO4auV9YDe7foE412JYd6ApR4RMH6To856Yfn485zSuhVz03vkHjHZeAxkzVeu4MYl9XT5VIL2uawybGelubW1tPJ34zJacAZRwbCVZYzsRQdHN6AZZ67cJPXxlP5Zn+E6CK8TUwmVznQs7qHTK47C/bV6vSBTecQmaCtMbos68bPoKaXsNLlppFR0H3Qn9Ez/0JVTqCC8CsZTMvap2H9nIJ1Hb1YHf0lK+bFaBTelBEW998ErCcKzVUR20ilFEEjBnrL9we3YaQk+hNs3s3p+GWpjmnUHxDtAlUS3QrMfyJeoWPlvf8L+2NKmARBuzYDNYPdWhtrYavGIPz3MUjUajCsNeOeqY/011G1Jh4peXc8vH5UPkev0GasRWhTI+D6R8i05BQdj99O27KqCrh92q1vfD7nCRd12NyARrVUyhSQ6fmNP2lm18WTy4gTUor1weVf228zv9+Rv79QHevxcGeBIMOpIW5stRcEWb5YaaNba6H298NNMU+yvNV8l+MtxMWnmDpF125wWYLVgzjHLPvMY8xnxEK190ZYsDPkoj4iPQ6V0cHa03DlN+fB7BHlUTgcRTLFcc9/eGrPKdvxUjreAE4wKjys8Vor5vVBlkshrimD+lhjsBzqPcDUyDHg6xPzatVWKtQkWp8r9n3ihoff3TqGAwAWegW/GKEH0LDI8XMXZ+QyCqK+0QfsyZsA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(7916004)(366004)(6486002)(38350700002)(508600001)(44832011)(6916009)(66946007)(6506007)(5660300002)(26005)(83380400001)(86362001)(6666004)(33716001)(8676002)(8936002)(316002)(4326008)(33656002)(66476007)(6512007)(66556008)(1076003)(2906002)(52116002)(38100700002)(186003)(9686003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?j6TokkssDZSbQBHzIohXoNEtAflOXKDtaD2lRdD1O1tde7NPtS+mxb0H3ExM?=
 =?us-ascii?Q?UYUQ+qQLawoBOJCjdvNHuSMjjPWW+PVj6RIi1VNm/wWlYud1UoosHS1fKZiY?=
 =?us-ascii?Q?Ye9Vz6dDfldn6lBHr7Yq5XPffK+ZXHX7PBp+jL1cR4jaMFk9U95oavlhJ2wo?=
 =?us-ascii?Q?MsO2C91DccCFq0Uosu+b5pTwPMK0r7LfsWfMM+VEiA02Eanlrqf9oOlVkyrr?=
 =?us-ascii?Q?VymBdUDKs7ibtJZsaEy2PV823JLDImZTqViCQ8zIjN89299muWYdR3r55qqQ?=
 =?us-ascii?Q?Am2i95UD0Y4MS/VG+XVU4CWqS/7XAzsvxqPFNYGxJel8CIf1+GR7EzEIwLop?=
 =?us-ascii?Q?ozZr4hgZgAyEok0NBadJe1V9QgYL25+YIRHZKJnHOjSl7LCi0Ho+onMyJGer?=
 =?us-ascii?Q?LwJ5v6otkyS1NQSzaE/W8A66QwJ5iugtO1hjkAEAnkT0cm7AJlxWj6kbhA6b?=
 =?us-ascii?Q?tvfx1G/ZEouZKADp1MPRsffoe+wFT/SeuXfAJGfJQpQCTEnvoe2JF4H7Mdcl?=
 =?us-ascii?Q?787sp8buxYyek1gGWwPn/QDdo9k8Gh8KfAQi9Mo2Cujz1vWhCfI7fV9GA/Q/?=
 =?us-ascii?Q?YLyxb3F8nejnHtkt0UCUAxP9EW5Yg+v9LP3XU0sAv/U+/Npte8MSQheq3mZu?=
 =?us-ascii?Q?9Xgg/I8dRDS5AqxQ19trUm02OV12GlF6nu236QHCrCq8mTqm8IaPc1kQZdRN?=
 =?us-ascii?Q?mSz7NpdpTvAVI5izpC9AVV5wx8i5bL5MM1MqtIdplc5L98FdPkn3Lp1ENQ8P?=
 =?us-ascii?Q?vm9OLFwh6Hntru68ihGAbVysS/MTlt4JWZ8TXbCHPElfuJDijqQIYlW41SBp?=
 =?us-ascii?Q?7vh4pTielHZZfHVpTTjG+nRh2vcUKWSQ6voeQ58mQ9RHXE9Y2iIAPKfLLjZ9?=
 =?us-ascii?Q?UrhULH67qgYVWJuZF0NkWXGZnwca1lHnbvaRmOCa+t8yIBzqE6gQ0zr/Qctc?=
 =?us-ascii?Q?xcI8yPE+OsXtIGqZHaLExcc1exYtrRrAuJiqHVIvvcJXd7XLGII42mfU86vK?=
 =?us-ascii?Q?00jDHq8Vm0B6SFv2v2DGZwEbv91koBlMC1HHtmEL2hdEgJtcfGVzT9lP9in8?=
 =?us-ascii?Q?EDRNO3AI4E4CXk/kA/ZTAhV/A5PvI8WpTE1hDvmdWPjs0phs8+TviMHgLvLo?=
 =?us-ascii?Q?Drzbi+Les/mzXciTbNj9INX+lMdbQQ88xra+CHefLMz+pTCnkYcBY27fR6ZA?=
 =?us-ascii?Q?6cocoML9vK5eOkYfzInVKG3TpyLV6LMnrCS5yHmrI1J/QhFMoXJCqh6EF2+l?=
 =?us-ascii?Q?++/rydG5JMQID5AXFvlefBj1HfUJkzBfVpKNpw8fInN6cKdK8+TABM5kPhXD?=
 =?us-ascii?Q?WW79FaSxUUqyf+H37XBSjd9cS1vh5WxmzyoYV4oe9zSpLbWYwOf+OpyUNvfl?=
 =?us-ascii?Q?jVldW8ncPHIRQ7qse+HKsyfQQigRjgSK/YMco7x6DRtKEmSC4nleHq4vQA92?=
 =?us-ascii?Q?u5ScquP7UQs9zeV/RB7juE0gcPYpYfiSIogqKgFzmZqAEsG1QC9z1P2Ib+8n?=
 =?us-ascii?Q?ypDAEyFW1d96qZVupzGF0gSd7IBorZcRYQHXo0EIU2iJJPKBuxg+1f+mccgZ?=
 =?us-ascii?Q?xMu/lk7cXBYMcQtlT7rFnpiQ9RFV8VNdOQCgyKMOdpO5iYVrX9SU+68RNUPv?=
 =?us-ascii?Q?aino2bfndIQZ8okg5JmEG2OO3K9oJbWWYhqRFzs2ADyZjFamt7/SscHloNQ7?=
 =?us-ascii?Q?OyIMlQ/6P4nfK6rdYMqcG9zfaho=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: abd4f1e2-22dc-4780-ab81-08d9e0cec79e
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Jan 2022 13:21:36.9709
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: /I7R5jBsWzwHFzgd/4v3s6T5wTma1weMOYuDGYAQs9a0FpLBHkjLo3oDQodLIdqmRFBeA/C7ZjjHlE+d0WRNzIb3ldOIs0y0tzXKhfVCPPY=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2654
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10238 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxscore=0 malwarescore=0
 spamscore=0 phishscore=0 suspectscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2201260080
X-Proofpoint-GUID: qElWL4VufxmMaPdLhWsjYShsGmytVzay
X-Proofpoint-ORIG-GUID: qElWL4VufxmMaPdLhWsjYShsGmytVzay
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since you're going to have to redo these anyway can you make some
additional changes?

On Mon, Jan 24, 2022 at 05:27:21PM +1300, Paulo Miguel Almeida wrote:
> +static int pi433_debugfs_regs_show(struct seq_file *m, void *p)
> +{
> +	struct pi433_device *dev;
> +	u8 reg_data[114];
> +	size_t i;

int i; unless the sizes are really going to exceed 2 billion.

> +	char *fmt = "0x%02x, 0x%02x\n";
> +
> +	dev = m->private;
> +
> +	// acquire locks to avoid race conditions

This comment does not add any information.  Delete it.

> +	mutex_lock(&dev->tx_fifo_lock);
> +	mutex_lock(&dev->rx_lock);
> +
> +	// wait for on-going operations to finish
> +	if (dev->tx_active)

This condition is unnecessary, it's already checked in wait_event_interruptible().

> +		wait_event_interruptible(dev->rx_wait_queue, !dev->tx_active);

It makes me nervous that you're not checking the returns from these...

> +
> +	if (dev->rx_active)
> +		wait_event_interruptible(dev->tx_wait_queue, !dev->rx_active);
> +
> +	// read contiguous regs
> +	// skip FIFO register (0x0) otherwise this can affect some of uC ops
> +	for (i = 1; i < 0x50; i++)
> +		reg_data[i] = rf69_read_reg(dev->spi, i);
> +
> +	// read non-contiguous regs
> +	reg_data[REG_TESTLNA] = rf69_read_reg(dev->spi, REG_TESTLNA);
> +	reg_data[REG_TESTPA1] = rf69_read_reg(dev->spi, REG_TESTPA1);
> +	reg_data[REG_TESTPA2] = rf69_read_reg(dev->spi, REG_TESTPA2);
> +	reg_data[REG_TESTDAGC] = rf69_read_reg(dev->spi, REG_TESTDAGC);
> +	reg_data[REG_TESTAFC] = rf69_read_reg(dev->spi, REG_TESTAFC);
> +
> +	seq_puts(m, "# reg, val\n");
> +
> +	// print contiguous regs

These comments duplicate the comments a few lines earlier so they don't
add anything new.

> +	for (i = 1; i < 0x50; i++)
> +		seq_printf(m, fmt, i, reg_data[i]);
> +
> +	// print non-contiguous regs

Delete.

> +	seq_printf(m, fmt, REG_TESTLNA, reg_data[REG_TESTLNA]);
> +	seq_printf(m, fmt, REG_TESTPA1, reg_data[REG_TESTPA1]);
> +	seq_printf(m, fmt, REG_TESTPA2, reg_data[REG_TESTPA2]);
> +	seq_printf(m, fmt, REG_TESTDAGC, reg_data[REG_TESTDAGC]);
> +	seq_printf(m, fmt, REG_TESTAFC, reg_data[REG_TESTAFC]);
> +
> +	// release locks

Delete this comment

> +	mutex_unlock(&dev->tx_fifo_lock);
> +	mutex_unlock(&dev->rx_lock);

Could you flip these locks around so they mirror the start of the
function?  It doesn't affect runtime, but really it's nicer if the
ordering are always consistent.  ABBA.

> +
> +	return 0;
> +}
> +
> +static ssize_t pi433_debugfs_regs_open(struct inode *inode, struct file *filp)
> +{
> +	return single_open(filp, pi433_debugfs_regs_show, inode->i_private);
> +}
> +
> +static const struct file_operations debugfs_fops = {
> +	.llseek =	seq_lseek,
> +	.open =		pi433_debugfs_regs_open,
> +	.owner =	THIS_MODULE,
> +	.read =		seq_read,
> +	.release =	single_release
> +};
> +
>  /*-------------------------------------------------------------------------*/
>  
>  static int pi433_probe(struct spi_device *spi)
>  {
>  	struct pi433_device	*device;
> +	struct dentry		*entry; /* debugfs */

Delete the comment.  The variable name is not good.  "dir" would be
better.

>  	int			retval;
>  
>  	/* setup spi parameters */
> @@ -1256,6 +1324,11 @@ static int pi433_probe(struct spi_device *spi)
>  	/* spi setup */
>  	spi_set_drvdata(spi, device);
>  
> +	/* debugfs setup */

Delete comment (it does not add information).

> +	entry = debugfs_create_dir(dev_name(device->dev),
> +				   debugfs_lookup(KBUILD_MODNAME, NULL));
> +	debugfs_create_file("regs", 0400, entry, device, &debugfs_fops);
> +
>  	return 0;
>  
>  del_cdev:
> @@ -1279,6 +1352,10 @@ static int pi433_probe(struct spi_device *spi)
>  static int pi433_remove(struct spi_device *spi)
>  {
>  	struct pi433_device	*device = spi_get_drvdata(spi);
> +	struct dentry *mod_entry = debugfs_lookup(KBUILD_MODNAME, NULL);
> +
> +	/* debugfs */

Delete comment.

> +	debugfs_remove(debugfs_lookup(dev_name(device->dev), mod_entry));
>  
>  	/* free GPIOs */
>  	free_gpio(device);

regards,
dan carpenter

