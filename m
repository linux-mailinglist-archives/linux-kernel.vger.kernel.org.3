Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D7EEB4B2790
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 15:11:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241329AbiBKOKV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 09:10:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbiBKOKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 09:10:19 -0500
Received: from mx0a-00069f02.pphosted.com (mx0a-00069f02.pphosted.com [205.220.165.32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10E42C43;
        Fri, 11 Feb 2022 06:10:18 -0800 (PST)
Received: from pps.filterd (m0246617.ppops.net [127.0.0.1])
        by mx0b-00069f02.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 21BE6ENC011211;
        Fri, 11 Feb 2022 14:10:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=date : from : to : cc
 : subject : message-id : references : content-type : in-reply-to :
 mime-version; s=corp-2021-07-09;
 bh=aTom/Scyl9F25M+CXaGavTbd/G6bo7L2phZv1vP3VP0=;
 b=Kxy673Ozf6jk9RVh48vqalUULoogtL2ROkMJ6XH3ROCkazP/iua3qUEGcF1xR4/cjide
 LevbRqQmSvtZD0oZbJ+IjLdHfUhEvy0n2OhgdPIgMB58WIAtR9IZhNh9dKF3K3OcHJRJ
 GQ9NtWtvtbKozCh/a4UZ1yX3mzPwAVjNVRVlUzgGAKQhoSWNqO9A+My54KosvIwPqQ/n
 cLw5nPhk39sbZLr3b5avO3Y61g0aleT14oSHHwc0WicbjMkevQXGwKu0qpO7ohH0Riqz
 fCLUDfGmFXzTdvmTIXFhrCXd6FSAqDWclB1WinjVfUXjZslVBTVPrD82N9HIBDm3afJ7 nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by mx0b-00069f02.pphosted.com with ESMTP id 3e5njr0fr5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 14:10:15 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.1.2/8.16.1.2) with SMTP id 21BE5wxU164675;
        Fri, 11 Feb 2022 14:10:14 GMT
Received: from nam12-mw2-obe.outbound.protection.outlook.com (mail-mw2nam12lp2042.outbound.protection.outlook.com [104.47.66.42])
        by userp3030.oracle.com with ESMTP id 3e1ec7bnwb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 11 Feb 2022 14:10:13 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=cKWlraVItDR3H1yASkV//Ld8JzLQkwd6PSTdPJqapvfUqYpDJO8YTsfotTReB50iMzITfhQZZ9DrXRaBfEpR/qYdYa7TllLNSaSiMoTjc+Yh6ou2GbqwU+wp3yg7+CgwXLzVTCQgaEbYAxgwbyXQjW+nEETwv26K3as7ZylEl2dMTftYgzDxZSTN9/U+XN1eZjiYAunhwzvUKlSGIDd6uizKv8PbjxTYjHHOYC5jZn0AbUBESKrThsOZq/d7KUCBjPtiKcInL7uRf70FLrVqCMvGXS5H9cPU8fmmrFNcmLr9i4QsKf/7CwGyNSt+VMfC2iReQUuWFltn1hlyG7eqTw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=aTom/Scyl9F25M+CXaGavTbd/G6bo7L2phZv1vP3VP0=;
 b=irKEA0AQaLlzvgNEtF6K5V7aNxHyPmYk4PRzCsjveNmg4rOT8EIB8ifmv0AFVql0yMVCims9sExmUUZdJD3QKb2l9JcnVhqfzXeOlQ2J9SXiQFSm5JWJ5Dc1ctl3TEeJOo4yQPZ6jER3v+2/9Lzw1g1ytUqjfuYrfYKfu83V3Euu8+OrdkhTkmqYiT5J8O7SqC4lzaPB+J5RBPmaGrpvJbxXVaEE/ohXLXKOcFyYQ/KlkaBN1HdYIBJd/XgYnQrU1A5tWGwY1SwsYWttu5+nP1M1UZHE5Qegu00Mpu1V2JhGh8qa1BCugIbBX4kAF9pgPtXrTHxEuVZdbuOjlUyutQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oracle.onmicrosoft.com; s=selector2-oracle-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=aTom/Scyl9F25M+CXaGavTbd/G6bo7L2phZv1vP3VP0=;
 b=p/ei+ckDnpfjRXElUm5Vvt3nPbJ9pckrTlXAFm/bgvZn9lQxV1IcYdQwsj3bhvQTVolYm7A/Q8W9nUPa6nSn78ITmmuOlAahKhsHrsZi2gHVfqa+TP2Jb41VVSI1vIWkNee7nJukhaP5fNUQTakeWEr3dsPByspq5zRq1BFjM/k=
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 (2603:10b6:301:2d::28) by BN6PR1001MB2225.namprd10.prod.outlook.com
 (2603:10b6:405:2d::30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4975.15; Fri, 11 Feb
 2022 14:10:10 +0000
Received: from MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8]) by MWHPR1001MB2365.namprd10.prod.outlook.com
 ([fe80::e5a5:8f49:7ec4:b7b8%5]) with mapi id 15.20.4951.018; Fri, 11 Feb 2022
 14:10:09 +0000
Date:   Fri, 11 Feb 2022 17:09:50 +0300
From:   Dan Carpenter <dan.carpenter@oracle.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jhansen@vmware.com, vdasa@vmware.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, acking@vmware.com, dtor@vmware.com,
        pv-drivers@vmware.com, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 3/3] VMCI: Fix some error handling paths in
 vmci_guest_probe_device()
Message-ID: <20220211140950.GN1951@kadam>
References: <cover.1644531317.git.christophe.jaillet@wanadoo.fr>
 <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c5c1a5f3547bea3c4a1cfb8474db683d83c0ca1d.1644531317.git.christophe.jaillet@wanadoo.fr>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-ClientProxiedBy: JNXP275CA0026.ZAFP275.PROD.OUTLOOK.COM (2603:1086:0:18::14)
 To MWHPR1001MB2365.namprd10.prod.outlook.com (2603:10b6:301:2d::28)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f5c5f652-e7ad-4797-7b68-08d9ed683628
X-MS-TrafficTypeDiagnostic: BN6PR1001MB2225:EE_
X-Microsoft-Antispam-PRVS: <BN6PR1001MB222549BBA87F0A7E81C38FDC8E309@BN6PR1001MB2225.namprd10.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: vE6WntRDyfebZd5NdlO7YNKOCBmkyqvn7l7U4qp5FnBOfIsZNZA6utLWI8eie681H8Yx3NVVR119SX2pUPcL+YSVOz4VDJztXpv9qGt4encsCapDwdXBpDDQI+o8mSFqNqXVEjB4KaGOptagugI8je/3QeOXSWzuvcbMdxLJQuSFaywr0MmpmYlq0Fqr4Xf+ppXkxfjx+fH8mipK9Gi2Rm5KArIdOLSHVfH54IfyUBK7VgoHmSXgsKGY3aZQImqcrO6ZeElzz7kqnVHaMZWOnCzefFO2u/WdRMeKyOGgECBU8hffl9JWD3Ny/HYCc+lvUjggWwn9FiUDbH79jqNenaxCXVCJUQdQ7MTtCV2TupBMCuBR7uiJfG0xQpTabYA9VwhsRD8jsy83rnp64I6DpNKe3gGKAWKzxTTS0264dhdNhuqzObBq52zcqH/JsFx4UfRH9/bBFZ3li0K0tOsjRi1LzyROBoWRy0P72LIvO2nuSKSdObjw2yRQB9uSciv2/ahJQ0De6FerBPAJ/EIHd/uWk6vwCqvS5fkTC7jLGgWbHw+ivHRe6iGSeIY2YXyIHnG2TvQhqFEBM45DSvyC7kLNcz5NQvlrsTglYeL7nO0ZRztLra1jmhownR/c0dKG6aA1DsnUDIcFmmSAu78wjkWnHZzi4AXkTfFEoFvsongOiuUD1Kp91ihsNmTZcNMGV/bu3LalqPY3KHJ9Eai9PQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MWHPR1001MB2365.namprd10.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(7416002)(5660300002)(6666004)(508600001)(6512007)(9686003)(8936002)(6486002)(1076003)(33656002)(52116002)(186003)(26005)(6506007)(83380400001)(2906002)(86362001)(44832011)(38350700002)(38100700002)(6916009)(316002)(33716001)(4326008)(66476007)(66556008)(66946007)(8676002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Khv2uZ7VGhtJekEZ2NMuDjwI9pwpnZZ3HF9vo4PjpVYUhMkp3/DA/wcmbfHt?=
 =?us-ascii?Q?uf0aY7Che3v+SASoM+EJ1jwCJ26LNlsF6tVBxEsURa4cKH0BTYg8Sf5xRO2t?=
 =?us-ascii?Q?JHgJWcxzf4vV4SLeHQaIoWePTiJnDJJb+JljIr+JU/ssqeOvqlWy0EWLL2PI?=
 =?us-ascii?Q?aF7Fa2WfxLgKCZ44OHH1OnfLIEHzhGxQcTyAf/VhvN7JjXLe5dDC2p0ymkGh?=
 =?us-ascii?Q?Hrj4Ru4tNXYjf9MhK4YRxwaXHowxyiJ3ka1RwdTwEvDCai+b0vTUaeS7B5Wd?=
 =?us-ascii?Q?UcMo8AQwSCDKSi+7LbvdVyGXqkhpNmi+8JDcaOuVrISomD6YHw+0EY3cEQX2?=
 =?us-ascii?Q?8T/1v9TsIO7nMhWqZttzLgdAJKBaOu2OsgIzeweh6eodrx2jqvqqs0TzbxS5?=
 =?us-ascii?Q?nqRiti1l0UDcqV9A2t1bM+L6Kv9vlFW0gdoWTHyCqP1PscofAZUmC2lg0fit?=
 =?us-ascii?Q?gYxqya2esuWXwK1LSDAW6tCSmgYiDgz0gumcu+jMj04Za+VkN7B1GWNTpYCQ?=
 =?us-ascii?Q?q6N0skWiw29GcpxEQrptew1C9Ypc0XwUciLZ8ZBz/hSIuR/+YoLzgQOO9h0p?=
 =?us-ascii?Q?Oc5ohnItYWFpc7F2YGzRQzFrw1sbWVSrVmCPqm6Fu6j8jV2Tkva2QeDoNuO4?=
 =?us-ascii?Q?nf10h8aGNKo3nXWfxODffuWkvIau8awFNIC05SKx/Xma/wKDAm8oN6Mg3qx5?=
 =?us-ascii?Q?zXcIpcmQz2un6VQv51EENzxUKQHRJ40IHk+scEN2B0yUTbqdaYbbbTsw2PHs?=
 =?us-ascii?Q?jjf5pZzzETu3iTVCpEo11pc+Nj8nyvb0SkOctrOpVF6/TnA7iTBI6h2QRng6?=
 =?us-ascii?Q?0SvictISFCnzaUoALGCASxbrfbihSuJKbslONttp3V3jXk2aGAc3uZ5bIhK6?=
 =?us-ascii?Q?sEcYlzdV+Vezwe9LmH5AHfilDU0u56M0tBr2ibQrXA2CGC0CF6VSG37bd7yA?=
 =?us-ascii?Q?TN7iuHl3ao5yfj2/f3ZZ/b1HhjbFHZHa/YRnLnapuE9KRrKvu43s/q375ZfB?=
 =?us-ascii?Q?sbWOTgMe3bsql5IZ18HZZ/o9CtW13+vIULC4eEhP1HvQxmkIyrkfl9SeF4xI?=
 =?us-ascii?Q?97tbNfSKKJFjltNuT3kYHs0/R8pAxHCX1t5iCBY31Opr+zMH2lc4sM+FLTzT?=
 =?us-ascii?Q?AvJ97JoHv4qiu5WBVgl4WBdTaLlHn85hprAnOod9/iGroVxjVVh0mkZ83zkl?=
 =?us-ascii?Q?ANb11ddJD6JusRwHc2rjBoLVPamZ6XC9EvpheUDQZ03pjFql/SCrhBY/+H3G?=
 =?us-ascii?Q?cTnmOhZsEEl4n1t+fcSC/64CMQhPgY+Ry0hY4XNaYQxPAW5KxId5a0DghBCf?=
 =?us-ascii?Q?2OXxLJYAiGuISjeGaXxAW83LlZf4krFQ9AzlvsgNhgLl7ocVrNzsfYBpTeuH?=
 =?us-ascii?Q?IirLBsrlfxjqcI31feQgYyfRKs4Ia4R7g8MHUemStA427bnkzk8qZxFSR3eu?=
 =?us-ascii?Q?Veo/Dr5Dm9kHJ83K398y0Yn9DYVncFbiKazskPyvYPZWXZJ/1qoLUtd+ynFZ?=
 =?us-ascii?Q?opcyKf1LI8YhCqRkNHji9zunKwp6S7MZ9bbGxbEXYoh5EF27lPaqpMUimWwX?=
 =?us-ascii?Q?ZexhYJtbX2LqtNCirKVrwRd5GewIyp3hUuEks1vVUf5CYfikecMPHxUsF+lT?=
 =?us-ascii?Q?5WqvA+kGvsteo6ee7XjJvx2JVHDfMTyj60Xk6UWd/XXi1c28ra3rqB6HmyHq?=
 =?us-ascii?Q?pjemmw=3D=3D?=
X-OriginatorOrg: oracle.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f5c5f652-e7ad-4797-7b68-08d9ed683628
X-MS-Exchange-CrossTenant-AuthSource: MWHPR1001MB2365.namprd10.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 11 Feb 2022 14:10:09.3296
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 4e2c6054-71cb-48f1-bd6c-3a9705aca71b
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Q/R7GkiYKPXW2sBXRvGjeMdq82pzZYoXFjHcyXOMgXVcioJ/fUzjboiKRlPk11mmOYV8UwbY6A8tA0fjjTMQH/wMWWPFodfQKO8UFNGOyEE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1001MB2225
X-Proofpoint-Virus-Version: vendor=nai engine=6300 definitions=10254 signatures=673431
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 suspectscore=0
 mlxlogscore=999 mlxscore=0 adultscore=0 malwarescore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2201110000
 definitions=main-2202110078
X-Proofpoint-GUID: yyXWAZkY-DCtpusk7rXF4MLF66S1UFdf
X-Proofpoint-ORIG-GUID: yyXWAZkY-DCtpusk7rXF4MLF66S1UFdf
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 10, 2022 at 11:27:34PM +0100, Christophe JAILLET wrote:
> The 'err_remove_vmci_dev_g' error label is not at the right place.
> This could lead to un-released resource.
> 
> There is also a missing label. If pci_alloc_irq_vectors() fails, the
> previous vmci_event_subscribe() call must be undone.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Review with GREAT care.
> 
> This patch is a recent rebase of an old patch that has never been
> submitted.
> This function is huge and modifying its error handling path is error
> prone (at least for me).
> 
> The patch is compile-tested only.

There is still one bug.  Sorry if the line numbers are off.

drivers/misc/vmw_vmci/vmci_guest.c
   705                if (capabilities & VMCI_CAPS_NOTIFICATIONS) {
   706                        vmci_dev->notification_bitmap = dma_alloc_coherent(
                                                                  ^^^^^
Alloc

   707                                &pdev->dev, PAGE_SIZE, &vmci_dev->notification_base,
   708                                GFP_KERNEL);
   709                        if (!vmci_dev->notification_bitmap) {
   710                                dev_warn(&pdev->dev,
   711                                         "Unable to allocate notification bitmap\n");
   712                        } else {
   713                                memset(vmci_dev->notification_bitmap, 0, PAGE_SIZE);
   714                                caps_in_use |= VMCI_CAPS_NOTIFICATIONS;
   715                        }
   716                }
   717
   718                if (mmio_base != NULL) {
   719                        if (capabilities & VMCI_CAPS_DMA_DATAGRAM) {
   720                                caps_in_use |= VMCI_CAPS_DMA_DATAGRAM;
   721                        } else {
   722                                dev_err(&pdev->dev,
   723                                        "Missing capability: VMCI_CAPS_DMA_DATAGRAM\n");
   724                                error = -ENXIO;
   725                                goto err_free_data_buffers;

This should be goto err_free_notification_bitmap;

   726                        }
   727                }

On of the rules for error handling is that the unwind code should mirror
the allocation code but instead of that this code will have:

Alloc:
	if (capabilities & VMCI_CAPS_NOTIFICATIONS)
Free:
	if (vmci_dev->notification_bitmap)

It's the same if statement but you wouldn't really know it from just
looking at it so it's confusing.  Whatever...  But where this really
hurts is with:

Alloc:
	if (vmci_dev->exclusive_vectors) {
		error = request_irq(pci_irq_vector(pdev, 1), ...
Free:
	free_irq(pci_irq_vector(pdev, 1), vmci_dev);

No if statement.  It works because it's the last allocation but it's
confusing and fragile.

The other question I had was:

   882        err_remove_bitmap:
   883                if (vmci_dev->notification_bitmap) {
   884                        vmci_write_reg(vmci_dev, VMCI_CONTROL_RESET, VMCI_CONTROL_ADDR);
                              ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
This doesn't mirror anything in the allocation code so who knows if its
done in the correct place/order.

   885                        dma_free_coherent(&pdev->dev, PAGE_SIZE,
   886                                          vmci_dev->notification_bitmap,
   887                                          vmci_dev->notification_base);
   888                }

regards,
dan carpenter

