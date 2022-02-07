Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 482024AB708
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Feb 2022 10:08:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349160AbiBGI77 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Feb 2022 03:59:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347763AbiBGIzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Feb 2022 03:55:10 -0500
Received: from mx0b-00069f02.pphosted.com (mx0b-00069f02.pphosted.com [205.220.177.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF7C043186
        for <linux-kernel@vger.kernel.org>; Mon,  7 Feb 2022 00:55:09 -0800 (PST)
Received: from pps.filterd (m0246630.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 2176BxlO021115;
        Mon, 7 Feb 2022 08:54:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : content-type : mime-version; s=corp-2021-07-09;
 bh=sXtm5WuzWj0aRC9uUgOMlkdqfKjh4Q2FsDpPFpve1WQ=;
 b=OsTjMdsXkvjy6hOtQOnhcaf1bNOKB/EBBv5Urs0GijU3xYOKUygoSKZY8zCtVbJWH1qS
 OP5dsb69rE7P7SXW7tqHh2irHfY0eOdjcrLz5UTJUy13miX8Src3QnzNVE5Q9WHj76ZW
 0NU9UE3R0x0OFFU8M3W5eCnpEqMdCcp+l2KEodV/6tsY9oQcHC0XbkmfyuB48FdRf8NS
 yoYmZbt7rxL6ZqvqQfMo4hgTSzLCXgpoemJT6HBXL2kK5CEZeT+H6vYtIJnks7lqsItq
 1qGY8vQ/24kIgW7zsokEzCTYKlW1LX4sC9MyH6dAbumu+Z8oDbk/4ygglXWHveqm71wc yw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e1fnddarp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 08:54:54 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 2178pSJh001680;
        Mon, 7 Feb 2022 08:54:53 GMT
Received: from nam10-bn7-obe.outbound.protection.outlook.com (mail-bn7nam10lp2108.outbound.protection.outlook.com [104.47.70.108])
        by aserp3020.oracle.com with ESMTP id 3e1h240v85-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 07 Feb 2022 08:54:53 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BEtFJU4E9CCoRq7HIAVlqf5RKSXTYLj+kVEkVN9DWc3AJJHH06mCLechEpwg6XraAT5J/AtZyQfAzveGAqWcRpQFAEVObWNRUTFXC19EaMqZLaO/ZDX2qvr+j5h7xehEMEw7WYDj/x569EAzao0S6VmR5vyJlgZDwoklQzrCdStHzWySdnNm3Qu2sS60GZl7JeDovL/h/GSVCSTGZih22VKmmYh6gaDMXEalSJp7bfGDUATYrsVE2HkH4awbxI+VqhacCZ7C1TeimGFRQRYNhyWHYxAHBY2/Gc7Em3NFnz7gjMM/Dzvdk3Ep0OLA4Z5P15cLjU3qNCfhTft/xddQIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sXtm5WuzWj0aRC9uUgOMlkdqfKjh4Q2FsDpPFpve1WQ=;
 b=UdNh25pNPJmVO8JNHlxLg6eXeBLKq4hOOqi0rTBbndAhuzu+5kfzavtJd5Nje6bM6vitA4kPU35PhZCa7lifDMMwCLYT/+I8B5jcfHfsu2QWBKuty/6TU0/CizBAPuz0q6vpSMJFuhzoVTMz/EmYgI0MbrsxPdbEhYAwtD5EXX525qY6k6h2THcqZG+GH5aBRY2jTIXQS3YHrY7XxIAQJC5vEWZgHV8CaQX4tkswOEuZcr7+l3mXRd0jqoEsKScUkO7M9Q3wSYvpUxw5fgdjx3soyQAZdcipvDDgo+N4kk1mb6cqyUODettFaCTH4W8gq7fXXcu+/CKq6MracGYrZA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sXtm5WuzWj0aRC9uUgOMlkdqfKjh4Q2FsDpPFpve1WQ=;
 b=BzYMPFGaSkjO7EyKf9p+6jN6Ns6R+sbV/HH5nQgiTexWwGBXB2ZIR1zZAESGoBwUYEpp0/aaDuF23srRPxxrxY/5r0FG7qGJ6I4zAVuQShek7FtEzMsWNBxry5D+MKLXv/yIpyt4OC02oQ5rqNel39KuQrV1J6VoE8ufFCEdolc=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by SN6PR10MB2528.namprd10.prod.outlook.com
 (2603:10b6:805:45::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Mon, 7 Feb
 2022 08:54:50 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Mon, 7 Feb 2022
 08:54:49 +0000
Date:   Mon, 7 Feb 2022 11:54:28 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     kbuild@lists.01.org, Hans de Goede <hdegoede@redhat.com>
Cc:     lkp@intel.com, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>
Subject: [jic23-iio:fixes-togreg 11/12] drivers/iio/accel/mma8452.c:1595
 mma8452_probe() error: we previously assumed 'id' could be null (see line
 1536)
Message-ID: <202202070226.OXoWo6JP-lkp@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNAP275CA0072.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:4f::23)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ccd98c67-b9c5-4c43-177d-08d9ea177f7f
X-MS-TrafficTypeDiagnostic: SN6PR10MB2528:EE_
X-Microsoft-Antispam-PRVS: <SN6PR10MB2528BD1A5A4DB3D05114A4A08E2C9@SN6PR10MB2528.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:389;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: I6mN9ImqBzaxBw8TtsOqGCiPKaNE58kkIGkhy5SpEAt1Ev9FR03Tw+aEW90SaLC6/krUPyEpAZzChtRMyHl0rWsoLnWQ/h4jnOln8dkvOq1r/i0ZEi/QFxv3ScNDiwRgk/HcVcIedi/4lUWa+btu0tL82U94DXv1sdzMO7nxIXm0wFVQegr5D8IrYqiH+GbynnaN/xVWGFyGYX0ruk0sc2tTfrrPqlghXnrd1H+0v43pwouAEgxUwRwZJBjq2OU6uTtK2A4EUgWld+YKgWndbrVHoH3XezRroLfyv+EjsUS3A3+NGzJKmDW7mQCC5KOiEp8iJqfJ/koKgjLllgwtHmjiXFypltmn3WuPeFPxXZwebEp/5YXzI/O8idWUEqQIiFa/Pet1Vq1epu6xqKji2elQvhZLUUudIs7IrjUZFfJBSeFoPowMo3a6Qcm+si+bpp7c1JshplxFloQTMPO8mgfTz1T5C0YiYl4lGLO8jyOXfNZrMDX9mnvKazJB7ACs8J94LVNRtXJDlg9vqUDeDTITzwU2DF7aCisPccyVqKVc7rIkxnyvpliZNx4CSI0HuvlnC5eqMVkMv5f7ECPfsGrkHMrUPxeccmbGIFywr+KZyMb7ZZWez7R6XumOLfRkpNJMtmCM+rMKyq55cf++VLps+DX0O4r460S+32QwRsgvQibod5yN33d/+Iw3yRv8hWRUm+ikEQQlplwmRh//hNInvK7OZjBW49X3dFNbJ9w+NaQppy+pJzhhR4+YfmMb7mddmKPubMKrDRAuRsNDeipUzFbVyN3eaeGPSWE+L2j92t3ZByhmNSIP6FtQvdAeVPayt3iQvQi1i1H3cuiCjg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(366004)(6486002)(966005)(83380400001)(38100700002)(38350700002)(508600001)(44832011)(26005)(4001150100001)(186003)(1076003)(66556008)(66476007)(52116002)(8936002)(6916009)(6666004)(2906002)(36756003)(5660300002)(30864003)(86362001)(66946007)(9686003)(6512007)(8676002)(316002)(4326008)(6506007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?GeB2Ed/2ZpOhygsTwt9ZD0HfR1joSl3TS6P/2qMf/X+awMiAatCM0dOGT+Q8?=
 =?us-ascii?Q?zTHE/tG5/gKfb3We3zBLixMYr1Q6kEcajd4pR7RwfEBHiaRJ/q+a1r+ygoh/?=
 =?us-ascii?Q?nNxeSjdg9+P3N7YijaB2Tlj5qaO4DgThXtMe27iHhQ9473pJy/dx08B/ynIS?=
 =?us-ascii?Q?5Ss08Fmomh5WydXycG8MvyjQ1apbF4FJU9ZNO0oThIWogpKx+Mls5sV3dAJj?=
 =?us-ascii?Q?HW62g8RL4U4t5T8JbqI1GDtScmNNlC82pdEcQ2ilCkr6SRUJ8p/BHrpxJEWl?=
 =?us-ascii?Q?/5cZvdGIexSSd2uQQYUp75Y8UJyTcfWCkBF8gPPMkXUzd24C+dMKePR08Bbl?=
 =?us-ascii?Q?FyV3aF9NXRnfaH5f3Bmz/GTTX3/D/9PY9CX57sXu1kLH89wjqJHjFOo3S0pN?=
 =?us-ascii?Q?tzp+HJV/vYrEJEEzWwyOR+hrCuV+dfHzlUPSceAQg0qtMkP58D6FmK0HtEGR?=
 =?us-ascii?Q?wUBbqt+4hIO2vqrAF7JzyV6dkNvOtIt21Ar5SmAlPDdML4/GntzShp9i/U2f?=
 =?us-ascii?Q?7GTztsUWbF/zDlI1oZ6qXaKQCHpA8biGDWK7i6OlShbKvTWLSfJLxnZRzs/e?=
 =?us-ascii?Q?HvBKHXJSg0N87aIgM+0P9/SaWmpUAd1PfqM8EvUkfBuJogQF4tBxAMUmsMDm?=
 =?us-ascii?Q?GrAmaeKDDV5DR0xNF1mopXH55W56t1gsKo80SnbOHP+FVOIWOYxTvZ+T/3WA?=
 =?us-ascii?Q?4a38vvMk1TfEnaBHDtQLGDTscuI3pTMviQYHntmcwMAoOzDvDSlxSXhrmUrb?=
 =?us-ascii?Q?vgPS2fRTIrsB4K5yCb+CmIgAee5006FjQSH2JXR0HnW7Ue7ofUxEXoJkjavW?=
 =?us-ascii?Q?9pWm+9fBWJS3ORjoaQJuqLY9gPt8TgSyjoJ3/1v5q7TzSjpV90CgJMMakDpD?=
 =?us-ascii?Q?HtKTaipCdkgXljVmZ2YlPiwzW3xbTE9Rc9h+RxMW3wuKZsfIZjeuPjP5DOUv?=
 =?us-ascii?Q?A5a58GjmHvkx3bJ7+1Dp4OBeutlN9LhtuQ8Xy9xDZjKlLCrvtoOouujQ6y9H?=
 =?us-ascii?Q?GJesPs1BSfT7+6vWm/gQiTMdFpa0ossEaNwRPBkMCJ5K4eSX1mycggca3HhV?=
 =?us-ascii?Q?UDVN8MCvjXDS9f0ZzUCR1Z58sRXmQE9+KU4BkulntMvez3kQDDteWeYx3O4P?=
 =?us-ascii?Q?S1bQsZsIqg2ZA/87ocSu5U7g48eLwllRTSckW/QIulTQIZm+aXsJr0lwn6O9?=
 =?us-ascii?Q?31hpgPpCqpw8hp5h2bdkoR8pmnWsRzXTztpHv2HvWGgmlTeTTNj95U5/tse2?=
 =?us-ascii?Q?BMENSzu5SVPALDqBzz6hqgaKAs+FiHDG1nedOnpKrKMl7N/GjS2voS6ALB/y?=
 =?us-ascii?Q?kTEXWseZr3Zq/7wA4tf8RZ6nFRND5pIqLDGGyyNn+dW/JOo84u9ngmpNXHxR?=
 =?us-ascii?Q?RS7m5KeUjioyRsGHEckTOMB3lorDdJPBGTs3t4Dzz5i0hr6hciqVGVXmpDrw?=
 =?us-ascii?Q?KoHQ1OZjNVzfl25JkRfxyDoQPDaKuJlqB445i9+KkqeMYajy5b1XQ7Lp294Z?=
 =?us-ascii?Q?mQKfFq1IKhTp6xER+JJl23F2YoktuzKh3Zai3ldeW8u5MVWbZghvRx71FMVo?=
 =?us-ascii?Q?/NuNAd58OwfvpXzPxrlWW4Okwlam5zMa6WhFlwHDdrUih3Dt0rgSQa0z/kLj?=
 =?us-ascii?Q?mlnZi8OKQsfUgV/s53IC18CIts8YS5oiit6aUPC70rs6wM8l0IpCPdAiANBO?=
 =?us-ascii?Q?RMjZ4Q=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ccd98c67-b9c5-4c43-177d-08d9ea177f7f
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Feb 2022 08:54:49.5381
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Z0sipvTIIYzmbeLSmkb5Xmz5hdH2Pwg0b0/nzf/ku1C+Ixn0IMqsHKUkxvW8cgOR/xZKmgRSxvOakqq2cgQRgGYyqJ/S1yc/Td/gifqtbxk=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN6PR10MB2528
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10250 signatures=673430
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxscore=0 bulkscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 adultscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202070057
X-Proofpoint-GUID: R0kV3PYaCb648nHkBITF2mQUtrVhrwed
X-Proofpoint-ORIG-GUID: R0kV3PYaCb648nHkBITF2mQUtrVhrwed
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/jic23/iio.git fixes-togreg
head:   21472ddd425831f6cf39b3034e825df2825ec850
commit: 4787cdbfbcb9590e6d9fb4809e0b667a3f491747 [11/12] iio: mma8452: Fix probe failing when an i2c_device_id is used
config: x86_64-randconfig-m001 (https://download.01.org/0day-ci/archive/20220207/202202070226.OXoWo6JP-lkp@intel.com/config)
compiler: gcc-9 (Debian 9.3.0-22) 9.3.0

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <dan.carpenter@oracle.com>

smatch warnings:
drivers/iio/accel/mma8452.c:1595 mma8452_probe() error: we previously assumed 'id' could be null (see line 1536)

vim +/id +1595 drivers/iio/accel/mma8452.c

c7eeea93ac60ab Peter Meerwald        2014-02-05  1519  static int mma8452_probe(struct i2c_client *client,
c7eeea93ac60ab Peter Meerwald        2014-02-05  1520  			 const struct i2c_device_id *id)
c7eeea93ac60ab Peter Meerwald        2014-02-05  1521  {
c7eeea93ac60ab Peter Meerwald        2014-02-05  1522  	struct mma8452_data *data;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1523  	struct iio_dev *indio_dev;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1524  	int ret;
c3cdd6e48e35b7 Martin Kepplinger     2015-09-01  1525  	const struct of_device_id *match;
4787cdbfbcb959 Hans de Goede         2022-01-06  1526  	const char *compatible;
c3cdd6e48e35b7 Martin Kepplinger     2015-09-01  1527  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1528  	indio_dev = devm_iio_device_alloc(&client->dev, sizeof(*data));
c7eeea93ac60ab Peter Meerwald        2014-02-05  1529  	if (!indio_dev)
c7eeea93ac60ab Peter Meerwald        2014-02-05  1530  		return -ENOMEM;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1531  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1532  	data = iio_priv(indio_dev);
c7eeea93ac60ab Peter Meerwald        2014-02-05  1533  	data->client = client;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1534  	mutex_init(&data->lock);
4787cdbfbcb959 Hans de Goede         2022-01-06  1535  
4787cdbfbcb959 Hans de Goede         2022-01-06 @1536  	if (id) {
                                                            ^^
Check for NULL

4787cdbfbcb959 Hans de Goede         2022-01-06  1537  		compatible = id->name;
4787cdbfbcb959 Hans de Goede         2022-01-06  1538  		data->chip_info = &mma_chip_info_table[id->driver_data];
4787cdbfbcb959 Hans de Goede         2022-01-06  1539  	} else {
4787cdbfbcb959 Hans de Goede         2022-01-06  1540  		match = of_match_device(mma8452_dt_ids, &client->dev);
4787cdbfbcb959 Hans de Goede         2022-01-06  1541  		if (!match) {
4787cdbfbcb959 Hans de Goede         2022-01-06  1542  			dev_err(&client->dev, "unknown device model\n");
4787cdbfbcb959 Hans de Goede         2022-01-06  1543  			return -ENODEV;
4787cdbfbcb959 Hans de Goede         2022-01-06  1544  		}
4787cdbfbcb959 Hans de Goede         2022-01-06  1545  		compatible = match->compatible;
c3cdd6e48e35b7 Martin Kepplinger     2015-09-01  1546  		data->chip_info = match->data;
4787cdbfbcb959 Hans de Goede         2022-01-06  1547  	}
c3cdd6e48e35b7 Martin Kepplinger     2015-09-01  1548  
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1549  	data->vdd_reg = devm_regulator_get(&client->dev, "vdd");
c8b9a02361d993 Krzysztof Kozlowski   2020-08-29  1550  	if (IS_ERR(data->vdd_reg))
c8b9a02361d993 Krzysztof Kozlowski   2020-08-29  1551  		return dev_err_probe(&client->dev, PTR_ERR(data->vdd_reg),
c8b9a02361d993 Krzysztof Kozlowski   2020-08-29  1552  				     "failed to get VDD regulator!\n");
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1553  
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1554  	data->vddio_reg = devm_regulator_get(&client->dev, "vddio");
c8b9a02361d993 Krzysztof Kozlowski   2020-08-29  1555  	if (IS_ERR(data->vddio_reg))
c8b9a02361d993 Krzysztof Kozlowski   2020-08-29  1556  		return dev_err_probe(&client->dev, PTR_ERR(data->vddio_reg),
c8b9a02361d993 Krzysztof Kozlowski   2020-08-29  1557  				     "failed to get VDDIO regulator!\n");
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1558  
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1559  	ret = regulator_enable(data->vdd_reg);
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1560  	if (ret) {
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1561  		dev_err(&client->dev, "failed to enable VDD regulator!\n");
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1562  		return ret;
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1563  	}
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1564  
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1565  	ret = regulator_enable(data->vddio_reg);
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1566  	if (ret) {
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1567  		dev_err(&client->dev, "failed to enable VDDIO regulator!\n");
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1568  		goto disable_regulator_vdd;
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1569  	}
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1570  
417e008ba9db7c Martin Kepplinger     2015-09-01  1571  	ret = i2c_smbus_read_byte_data(client, MMA8452_WHO_AM_I);
417e008ba9db7c Martin Kepplinger     2015-09-01  1572  	if (ret < 0)
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1573  		goto disable_regulators;
417e008ba9db7c Martin Kepplinger     2015-09-01  1574  
417e008ba9db7c Martin Kepplinger     2015-09-01  1575  	switch (ret) {
244a93f651937a Martin Kepplinger     2016-01-16  1576  	case MMA8451_DEVICE_ID:
417e008ba9db7c Martin Kepplinger     2015-09-01  1577  	case MMA8452_DEVICE_ID:
417e008ba9db7c Martin Kepplinger     2015-09-01  1578  	case MMA8453_DEVICE_ID:
417e008ba9db7c Martin Kepplinger     2015-09-01  1579  	case MMA8652_DEVICE_ID:
417e008ba9db7c Martin Kepplinger     2015-09-01  1580  	case MMA8653_DEVICE_ID:
e8731180fbf6fd Martin Kepplinger     2016-03-09  1581  	case FXLS8471_DEVICE_ID:
417e008ba9db7c Martin Kepplinger     2015-09-01  1582  		if (ret == data->chip_info->chip_id)
417e008ba9db7c Martin Kepplinger     2015-09-01  1583  			break;
df561f6688fef7 Gustavo A. R. Silva   2020-08-23  1584  		fallthrough;
417e008ba9db7c Martin Kepplinger     2015-09-01  1585  	default:
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1586  		ret = -ENODEV;
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1587  		goto disable_regulators;
417e008ba9db7c Martin Kepplinger     2015-09-01  1588  	}
417e008ba9db7c Martin Kepplinger     2015-09-01  1589  
c3cdd6e48e35b7 Martin Kepplinger     2015-09-01  1590  	dev_info(&client->dev, "registering %s accelerometer; ID 0x%x\n",
4787cdbfbcb959 Hans de Goede         2022-01-06  1591  		 compatible, data->chip_info->chip_id);
c7eeea93ac60ab Peter Meerwald        2014-02-05  1592  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1593  	i2c_set_clientdata(client, indio_dev);
c7eeea93ac60ab Peter Meerwald        2014-02-05  1594  	indio_dev->info = &mma8452_info;
c7eeea93ac60ab Peter Meerwald        2014-02-05 @1595  	indio_dev->name = id->name;
                                                                          ^^^^^^^^^
Unchecked dereference

c7eeea93ac60ab Peter Meerwald        2014-02-05  1596  	indio_dev->modes = INDIO_DIRECT_MODE;
c3cdd6e48e35b7 Martin Kepplinger     2015-09-01  1597  	indio_dev->channels = data->chip_info->channels;
c3cdd6e48e35b7 Martin Kepplinger     2015-09-01  1598  	indio_dev->num_channels = data->chip_info->num_channels;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1599  	indio_dev->available_scan_masks = mma8452_scan_masks;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1600  
ecabae71319695 Martin Fuzzey         2015-05-13  1601  	ret = mma8452_reset(client);
c7eeea93ac60ab Peter Meerwald        2014-02-05  1602  	if (ret < 0)
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1603  		goto disable_regulators;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1604  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1605  	data->data_cfg = MMA8452_DATA_CFG_FS_2G;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1606  	ret = i2c_smbus_write_byte_data(client, MMA8452_DATA_CFG,
c7eeea93ac60ab Peter Meerwald        2014-02-05  1607  					data->data_cfg);
c7eeea93ac60ab Peter Meerwald        2014-02-05  1608  	if (ret < 0)
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1609  		goto disable_regulators;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1610  
28e3427824ccc8 Martin Fuzzey         2015-06-01  1611  	/*
28e3427824ccc8 Martin Fuzzey         2015-06-01  1612  	 * By default set transient threshold to max to avoid events if
28e3427824ccc8 Martin Fuzzey         2015-06-01  1613  	 * enabling without configuring threshold.
28e3427824ccc8 Martin Fuzzey         2015-06-01  1614  	 */
28e3427824ccc8 Martin Fuzzey         2015-06-01  1615  	ret = i2c_smbus_write_byte_data(client, MMA8452_TRANSIENT_THS,
28e3427824ccc8 Martin Fuzzey         2015-06-01  1616  					MMA8452_TRANSIENT_THS_MASK);
28e3427824ccc8 Martin Fuzzey         2015-06-01  1617  	if (ret < 0)
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1618  		goto disable_regulators;
28e3427824ccc8 Martin Fuzzey         2015-06-01  1619  
28e3427824ccc8 Martin Fuzzey         2015-06-01  1620  	if (client->irq) {
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1621  		int irq2;
28e3427824ccc8 Martin Fuzzey         2015-06-01  1622  
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1623  		irq2 = of_irq_get_byname(client->dev.of_node, "INT2");
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1624  
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1625  		if (irq2 == client->irq) {
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1626  			dev_dbg(&client->dev, "using interrupt line INT2\n");
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1627  		} else {
28e3427824ccc8 Martin Fuzzey         2015-06-01  1628  			ret = i2c_smbus_write_byte_data(client,
28e3427824ccc8 Martin Fuzzey         2015-06-01  1629  						MMA8452_CTRL_REG5,
605f72de137ad9 Harinath Nampally     2017-09-09  1630  						data->chip_info->all_events);
28e3427824ccc8 Martin Fuzzey         2015-06-01  1631  			if (ret < 0)
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1632  				goto disable_regulators;
28e3427824ccc8 Martin Fuzzey         2015-06-01  1633  
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1634  			dev_dbg(&client->dev, "using interrupt line INT1\n");
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1635  		}
d2a3e0931a8f3b Martin Kepplinger     2015-10-15  1636  
28e3427824ccc8 Martin Fuzzey         2015-06-01  1637  		ret = i2c_smbus_write_byte_data(client,
28e3427824ccc8 Martin Fuzzey         2015-06-01  1638  					MMA8452_CTRL_REG4,
605f72de137ad9 Harinath Nampally     2017-09-09  1639  					data->chip_info->enabled_events);
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1640  		if (ret < 0)
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1641  			goto disable_regulators;
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1642  
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1643  		ret = mma8452_trigger_setup(indio_dev);
28e3427824ccc8 Martin Fuzzey         2015-06-01  1644  		if (ret < 0)
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1645  			goto disable_regulators;
28e3427824ccc8 Martin Fuzzey         2015-06-01  1646  	}
28e3427824ccc8 Martin Fuzzey         2015-06-01  1647  
ecabae71319695 Martin Fuzzey         2015-05-13  1648  	data->ctrl_reg1 = MMA8452_CTRL_ACTIVE |
ecabae71319695 Martin Fuzzey         2015-05-13  1649  			  (MMA8452_CTRL_DR_DEFAULT << MMA8452_CTRL_DR_SHIFT);
a45d1238870446 Richard Tresidder     2018-05-11  1650  
a45d1238870446 Richard Tresidder     2018-05-11  1651  	data->sleep_val = mma8452_calculate_sleep(data);
a45d1238870446 Richard Tresidder     2018-05-11  1652  
ecabae71319695 Martin Fuzzey         2015-05-13  1653  	ret = i2c_smbus_write_byte_data(client, MMA8452_CTRL_REG1,
ecabae71319695 Martin Fuzzey         2015-05-13  1654  					data->ctrl_reg1);
ecabae71319695 Martin Fuzzey         2015-05-13  1655  	if (ret < 0)
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1656  		goto trigger_cleanup;
ecabae71319695 Martin Fuzzey         2015-05-13  1657  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1658  	ret = iio_triggered_buffer_setup(indio_dev, NULL,
c7eeea93ac60ab Peter Meerwald        2014-02-05  1659  					 mma8452_trigger_handler, NULL);
c7eeea93ac60ab Peter Meerwald        2014-02-05  1660  	if (ret < 0)
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1661  		goto trigger_cleanup;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1662  
28e3427824ccc8 Martin Fuzzey         2015-06-01  1663  	if (client->irq) {
28e3427824ccc8 Martin Fuzzey         2015-06-01  1664  		ret = devm_request_threaded_irq(&client->dev,
28e3427824ccc8 Martin Fuzzey         2015-06-01  1665  						client->irq,
28e3427824ccc8 Martin Fuzzey         2015-06-01  1666  						NULL, mma8452_interrupt,
28e3427824ccc8 Martin Fuzzey         2015-06-01  1667  						IRQF_TRIGGER_LOW | IRQF_ONESHOT,
28e3427824ccc8 Martin Fuzzey         2015-06-01  1668  						client->name, indio_dev);
28e3427824ccc8 Martin Fuzzey         2015-06-01  1669  		if (ret)
28e3427824ccc8 Martin Fuzzey         2015-06-01  1670  			goto buffer_cleanup;
28e3427824ccc8 Martin Fuzzey         2015-06-01  1671  	}
28e3427824ccc8 Martin Fuzzey         2015-06-01  1672  
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1673  	ret = pm_runtime_set_active(&client->dev);
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1674  	if (ret < 0)
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1675  		goto buffer_cleanup;
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1676  
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1677  	pm_runtime_enable(&client->dev);
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1678  	pm_runtime_set_autosuspend_delay(&client->dev,
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1679  					 MMA8452_AUTO_SUSPEND_DELAY_MS);
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1680  	pm_runtime_use_autosuspend(&client->dev);
96c0cb2bbfe0a5 Martin Kepplinger     2016-03-03  1681  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1682  	ret = iio_device_register(indio_dev);
c7eeea93ac60ab Peter Meerwald        2014-02-05  1683  	if (ret < 0)
c7eeea93ac60ab Peter Meerwald        2014-02-05  1684  		goto buffer_cleanup;
28e3427824ccc8 Martin Fuzzey         2015-06-01  1685  
4b04266abe3ea0 Martin Kepplinger     2016-01-16  1686  	ret = mma8452_set_freefall_mode(data, false);
1a965d405fc6f6 Bijosh Thykkoottathil 2016-07-04  1687  	if (ret < 0)
d7369ae1f4d7cf Chuhong Yuan          2020-05-28  1688  		goto unregister_device;
4b04266abe3ea0 Martin Kepplinger     2016-01-16  1689  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1690  	return 0;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1691  
d7369ae1f4d7cf Chuhong Yuan          2020-05-28  1692  unregister_device:
d7369ae1f4d7cf Chuhong Yuan          2020-05-28  1693  	iio_device_unregister(indio_dev);
d7369ae1f4d7cf Chuhong Yuan          2020-05-28  1694  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1695  buffer_cleanup:
c7eeea93ac60ab Peter Meerwald        2014-02-05  1696  	iio_triggered_buffer_cleanup(indio_dev);
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1697  
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1698  trigger_cleanup:
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1699  	mma8452_trigger_cleanup(indio_dev);
ae6d9ce05691bf Martin Fuzzey         2015-06-01  1700  
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1701  disable_regulators:
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1702  	regulator_disable(data->vddio_reg);
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1703  
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1704  disable_regulator_vdd:
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1705  	regulator_disable(data->vdd_reg);
f6ff49b8a3b6f7 Anson Huang           2019-01-08  1706  
c7eeea93ac60ab Peter Meerwald        2014-02-05  1707  	return ret;
c7eeea93ac60ab Peter Meerwald        2014-02-05  1708  }

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

